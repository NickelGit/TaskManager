import React, { useEffect, useState } from 'react';
import PropTypes from 'prop-types';
import KanbanBoard from '@lourenci/react-kanban';
import Fab from '@material-ui/core/Fab';
import AddIcon from '@material-ui/icons/Add';

import Task from 'components/Task';
import AddPopup from 'components/AddPopup';
import EditPopup from 'components/EditPopup';
import ColumnHeader from 'components/ColumnHeader';
import EditPopupContainer from 'containers/EditPopupContainer';

import useStyles from './useStyles';

const MODES = {
  ADD: 'add',
  EDIT: 'edit',
  NONE: 'none',
};

const TaskBoard = (props) => {
  const {
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
  } = props;
  const [mode, setMode] = useState(MODES.NONE);
  const [openedTaskId, setOpenedTaskId] = useState(null);
  const styles = useStyles();

  useEffect(() => {
    loadBoard();
  }, []);

  const handleOpenAddPopup = () => {
    setMode(MODES.ADD);
  };

  const handleOpenEditPopup = (task) => {
    setOpenedTaskId(task.id);
    setMode(MODES.EDIT);
  };

  const handleClose = () => {
    setMode(MODES.NONE);
    setOpenedTaskId(null);
  };

  const handleCardDragEnd = (task, source, destination) => {
    cardDragEnd(task, source, destination);
  };

  const handleTaskCreate = (params) => {
    taskCreate(params);
    handleClose();
  };

  const handleTaskUpdate = (task) => {
    taskUpdate(task);
    handleClose();
  };

  const handleTaskDestroy = (task) => {
    taskDestroy(task);
    handleClose();
  };

  const handleAttachImage = (task, attachment) => {
    uploadImage(task, attachment);
    handleClose();
  };

  const handleRemoveImage = (task) => {
    removeImage(task);
    handleClose();
  };

  return (
    <>
      <Fab onClick={handleOpenAddPopup} className={styles.addButton} color="primary" aria-label="add">
        <AddIcon />
      </Fab>

      <KanbanBoard
        disableColumnDrag
        onCardDragEnd={handleCardDragEnd}
        renderCard={(card) => <Task onClick={handleOpenEditPopup} task={card} />}
        renderColumnHeader={(column) => <ColumnHeader column={column} onLoadMore={loadColumnMore} />}
      >
        {board}
      </KanbanBoard>

      {mode === MODES.ADD && <AddPopup onCreateCard={handleTaskCreate} onClose={handleClose} />}
      {mode === MODES.EDIT &&
        (loadTask(openedTaskId),
        (
          <EditPopupContainer>
            {({ editedTask }) => (
              <EditPopup
                onDestroyCard={handleTaskDestroy}
                onUpdateCard={handleTaskUpdate}
                onClose={handleClose}
                editedTask={editedTask}
                onAttachImage={handleAttachImage}
                onRemoveImage={handleRemoveImage}
              />
            )}
          </EditPopupContainer>
        ))}
    </>
  );
};

TaskBoard.propTypes = {
  loadBoard: PropTypes.func.isRequired,
  loadColumnMore: PropTypes.func.isRequired,
  cardDragEnd: PropTypes.func.isRequired,
  taskCreate: PropTypes.func.isRequired,
  loadTask: PropTypes.func.isRequired,
  taskUpdate: PropTypes.func.isRequired,
  taskDestroy: PropTypes.func.isRequired,
  uploadImage: PropTypes.func.isRequired,
  removeImage: PropTypes.func.isRequired,
  board: PropTypes.shape({
    columns: PropTypes.arrayOf(
      PropTypes.shape({
        id: PropTypes.string.isRequired,
        title: PropTypes.string.isRequired,
        cards: PropTypes.array.isRequired,
        meta: PropTypes.shape({}).isRequired,
      }),
    ),
  }).isRequired,
};

export default TaskBoard;
