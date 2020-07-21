import { useSelector } from 'react-redux';
import { useTasksActions } from 'slices/TasksSlice';

const EditPopupContainer = (props) => {
  const { children } = props;
  const editedTask = useSelector((state) => state.TasksSlice.editedTask);

  const { setTask } = useTasksActions();

  return children({ editedTask, setTask });
};

export default EditPopupContainer;
