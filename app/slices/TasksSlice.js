import { propEq } from 'ramda';
import { createSlice } from '@reduxjs/toolkit';
import TasksRepository from 'repositories/TasksRepository';
import TaskPresenter from 'presenters/TaskPresenter';
import TaskForm from 'forms/TaskForm';
import { useDispatch } from 'react-redux';
import { changeColumn } from '@lourenci/react-kanban';

const STATES = [
  { key: 'new_task', value: 'New' },
  { key: 'in_development', value: 'In Dev' },
  { key: 'in_qa', value: 'In QA' },
  { key: 'in_code_review', value: 'in CR' },
  { key: 'ready_for_release', value: 'Ready for release' },
  { key: 'released', value: 'Released' },
  { key: 'archived', value: 'Archived' },
];

const initialState = {
  board: {
    columns: STATES.map((column) => ({
      id: column.key,
      title: column.value,
      cards: [],
      meta: {},
    })),
  },
  editedTask: { value: null },
};

const tasksSlice = createSlice({
  name: 'tasks',
  initialState,
  reducers: {
    loadColumnSuccess(state, { payload }) {
      const { items, meta, columnId } = payload;
      const column = state.board.columns.find(propEq('id', columnId));

      state.board = changeColumn(state.board, column, {
        cards: items,
        meta,
      });

      return state;
    },
    loadColumnMoreSuccess(state, { payload }) {
      const { items, meta, columnId } = payload;
      const column = state.board.columns.find(propEq('id', columnId));

      state.board = changeColumn(state.board, column, {
        cards: column.cards.concat(items),
        meta,
      });

      return state;
    },
    loadTaskSuccess(state, { payload }) {
      state.editedTask = payload.task;

      return state;
    },
    setTaskSuccess(state, { payload }) {
      state.editedTask = payload;

      return state;
    },
  },
});

const { loadColumnSuccess, loadColumnMoreSuccess, loadTaskSuccess, setTaskSuccess } = tasksSlice.actions;

export default tasksSlice.reducer;

export const useTasksActions = () => {
  const dispatch = useDispatch();

  const loadColumn = (state, page = 1, perPage = 10) => {
    TasksRepository.index({
      q: { stateEq: state },
      page,
      perPage,
    }).then(({ data }) => {
      dispatch(loadColumnSuccess({ ...data, columnId: state }));
    });
  };

  const loadBoard = () => STATES.map(({ key }) => loadColumn(key));

  const loadColumnMore = (state, page = 1, perPage = 10) => {
    TasksRepository.index({
      q: { stateEq: state },
      page,
      perPage,
    }).then(({ data }) => {
      dispatch(loadColumnMoreSuccess({ ...data, columnId: state }));
    });
  };
  const cardDragEnd = (task, source, destination) => {
    const transition = TaskPresenter.transitions(task).find(({ to }) => destination.toColumnId === to);
    if (transition) {
      TasksRepository.update(TaskPresenter.id(task), { task: { stateEvent: transition.event } })
        .then(() => {
          loadColumn(destination.toColumnId);
          loadColumn(source.fromColumnId);
        })
        .catch((error) => {
          alert(`Move failed! ${error.message}`);
        });
    }
  };

  const taskCreate = (params) => {
    const attributes = TaskForm.attributesToSubmit(params);
    return TasksRepository.create(attributes);
  };

  const loadTask = (id) => {
    return TasksRepository.show(id).then(({ data }) => {
      dispatch(loadTaskSuccess(data));
    });
  };

  const setTask = (task) => {
    dispatch(setTaskSuccess(task));
  };

  const taskUpdate = (task) => {
    const attributes = TaskForm.attributesToSubmit(task);

    return TasksRepository.update(TaskPresenter.id(task), attributes);
  };

  const taskDestroy = (task) => {
    return TasksRepository.destroy(TaskPresenter.id(task));
  };

  const uploadImage = (task, attachment) => {
    return TasksRepository.attachImage(task.id, attachment);
  };

  const removeImage = (task) => {
    return TasksRepository.removeImage(task.id);
  };

  return {
    loadColumn,
    loadBoard,
    loadColumnMore,
    cardDragEnd,
    taskCreate,
    loadTask,
    setTask,
    taskUpdate,
    taskDestroy,
    uploadImage,
    removeImage,
  };
};
