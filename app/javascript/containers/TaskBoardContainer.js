import { useSelector } from 'react-redux';
import { useTasksActions } from 'slices/TasksSlice';

const TaskBoardContainer = (props) => {
  const { children } = props;
  const board = useSelector((state) => state.TasksSlice.board);

  const {
    loadBoard,
    loadColumnMore,
    cardDragEnd,
    taskCreate,
    loadTask,
    taskUpdate,
    taskDestroy,
    uploadImage,
    removeImage,
  } = useTasksActions();

  return children({
    board,
    loadBoard,
    loadColumnMore,
    cardDragEnd,
    taskCreate,
    loadTask,
    taskUpdate,
    taskDestroy,
    uploadImage,
    removeImage,
  });
};

export default TaskBoardContainer;
