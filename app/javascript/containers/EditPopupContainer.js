import { useSelector } from 'react-redux';

const EditPopupContainer = (props) => {
  const { children } = props;
  const editedTask = useSelector((state) => state.TasksSlice.editedTask);

  console.log(`in EditPopupContainer`);
  console.log(editedTask);

  return children({ editedTask });
};

export default EditPopupContainer;
