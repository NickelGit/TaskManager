import React from 'react';

import store from 'store';
import { Provider } from 'react-redux';

import TaskBoardContainer from 'containers/TaskBoardContainer';
import TaskBoard from 'components/TaskBoard';

const App = () => {
  return (
    <Provider store={store}>
      <TaskBoardContainer>
        {({
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
        }) => (
          <TaskBoard
            loadBoard={loadBoard}
            board={board}
            loadColumnMore={loadColumnMore}
            cardDragEnd={cardDragEnd}
            taskCreate={taskCreate}
            loadTask={loadTask}
            taskUpdate={taskUpdate}
            taskDestroy={taskDestroy}
            uploadImage={uploadImage}
            removeImage={removeImage}
          />
        )}
      </TaskBoardContainer>
    </Provider>
  );
};

export default App;
