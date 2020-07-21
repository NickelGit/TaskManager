import React, { useState } from 'react';
import PropTypes from 'prop-types';
import { isNil } from 'ramda';
import Modal from '@material-ui/core/Modal';
import Card from '@material-ui/core/Card';
import CardHeader from '@material-ui/core/CardHeader';
import IconButton from '@material-ui/core/IconButton';
import CloseIcon from '@material-ui/icons/Close';
import CardContent from '@material-ui/core/CardContent';
import CircularProgress from '@material-ui/core/CircularProgress';
import Button from '@material-ui/core/Button';
import CardActions from '@material-ui/core/CardActions';

import Form from 'components/Form';
import TaskPresenter from 'presenters/TaskPresenter';

import useStyles from './useStyles';

const EditPopup = ({
  setTask,
  loadColumn,
  editedTask,
  onClose,
  onDestroyCard,
  onUpdateCard,
  onAttachImage,
  onRemoveImage,
}) => {
  const [isSaving, setSaving] = useState(false);
  const [errors, setErrors] = useState({});
  const styles = useStyles();

  const handleCardUpdate = () => {
    setSaving(true);

    onUpdateCard(editedTask)
      .then(() => {
        loadColumn(TaskPresenter.state(editedTask));
      })
      .catch((error) => {
        setSaving(false);
        setErrors(error || {});

        if (error instanceof Error) {
          alert(`Update Failed! Error: ${error.message}`);
        }
      });
  };

  const handleCardDestroy = () => {
    setSaving(true);

    onDestroyCard(editedTask)
      .then(() => {
        loadColumn(TaskPresenter.state(editedTask));
      })
      .catch((error) => {
        setSaving(false);

        alert(`Destrucion Failed! Error: ${error.message}`);
      });
  };

  const handleUploadImage = (attachment) => {
    setSaving(true);

    onAttachImage(editedTask, attachment)
      .then(() => {
        loadColumn(TaskPresenter.state(editedTask));
      })
      .catch((error) => {
        setSaving(false);

        alert(`Upload image Failed! Error: ${error.message}`);
      });
  };

  const handleRemoveImage = () => {
    setSaving(true);

    onRemoveImage(editedTask)
      .then(() => {
        loadColumn(TaskPresenter.state(editedTask));
      })
      .catch((error) => {
        setSaving(false);

        alert(`Remove image Failed! Error: ${error.message}`);
      });
  };

  const isLoading = isNil(editedTask);

  return (
    <Modal className={styles.modal} open onClose={onClose}>
      <Card className={styles.root}>
        <CardHeader
          action={
            <IconButton onClick={onClose}>
              <CloseIcon />
            </IconButton>
          }
          title={
            isLoading
              ? 'Your task is loading. Please be patient.'
              : `Task # ${TaskPresenter.id(editedTask)} [${TaskPresenter.name(editedTask)}]`
          }
        />
        <CardContent>
          {isLoading ? (
            <div className={styles.loader}>
              <CircularProgress />
            </div>
          ) : (
            <Form
              errors={errors}
              onChange={setTask}
              onAttachImage={handleUploadImage}
              onRemoveImage={handleRemoveImage}
              task={editedTask}
            />
          )}
        </CardContent>
        <CardActions className={styles.actions}>
          <Button
            disabled={isLoading || isSaving}
            onClick={handleCardUpdate}
            size="small"
            variant="contained"
            color="primary"
          >
            Update
          </Button>
          <Button
            disabled={isLoading || isSaving}
            onClick={handleCardDestroy}
            size="small"
            variant="contained"
            color="secondary"
          >
            Destroy
          </Button>
        </CardActions>
      </Card>
    </Modal>
  );
};

EditPopup.propTypes = {
  setTask: PropTypes.func.isRequired,
  loadColumn: PropTypes.func.isRequired,
  editedTask: TaskPresenter.shape().isRequired,
  onClose: PropTypes.func.isRequired,
  onDestroyCard: PropTypes.func.isRequired,
  onUpdateCard: PropTypes.func.isRequired,
  onAttachImage: PropTypes.func.isRequired,
  onRemoveImage: PropTypes.func.isRequired,
};

export default EditPopup;
