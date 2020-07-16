import { useSelector } from 'react-redux';

const EditPopupContainer = (props) => {
  const { children } = props;
  const editedTask = useSelector((state) => state.TasksSlice.editedTask);

  return children({ editedTask });
};

export default EditPopupContainer;
