import React, {useEffect, useState} from 'react'
import { View, Flex } from '@aws-amplify/ui-react'
import { Container, Form, Button, Card, Table, Alert, Row, Col } from 'react-bootstrap';
import './App.css'



function App({ onSubmit }) {

  const [item, setItem] = useState('');
  const [activity, setActivity] = useState('');
  const [tasks, setTasks] = useState([]);
  const [completedTasks, setCompletedTasks] = useState([]);
  const [isUniqueError, setIsUniqueError] = useState(false); // State to track unique item error

  const handleSubmit = (e) => {
    e.preventDefault();

    // Check if the item is unique
    if (tasks.some(task => task.item === item)) {
      setIsUniqueError(true);  // Set error state if item is not unique
      return;
    } else {
      setIsUniqueError(false);  // Reset error state if item is unique
    }

    setTasks([...tasks, { item, activity, completed: false }]);
    setItem('');
    setActivity('');
  };

  const markAsCompleted = (index) => {
    const updatedTasks = [...tasks];
    const taskToUpdate = updatedTasks[index];

    if (taskToUpdate.completed) {
        // If the task is currently marked as completed, unmark it and remove from completedTasks
        taskToUpdate.completed = false;
        setCompletedTasks(prevCompleted => prevCompleted.filter(task => task.item !== taskToUpdate.item));
    } else {
        // If the task is not currently marked as completed, mark it and add to completedTasks
        taskToUpdate.completed = true;
        setCompletedTasks(prevCompleted => [...prevCompleted, taskToUpdate]);
    }

    setTasks(updatedTasks);
  };

  const removeTask = (itemNumber) => {
    // Remove the task from the tasks list and update the state
    setTasks(prevTasks => prevTasks.filter(task => task.item !== itemNumber));

    // Remove the task from the completedTasks list and update the state
    setCompletedTasks(prevCompleted => prevCompleted.filter(task => task.item !== itemNumber));
  };


  return (
        <Container className="container1">
          <View
            as="div"
            ariaLabel="View example"
            border="0px solid var(--amplify-colors-black)"
            color="var(--amplify-colors-blue-60)"
            height="auto"
            padding="1rem"
            width="auto"
          >
             <Card className="card1 form">
              <Row>
                <Col>
                  <Flex direction="column" alignItems="center">
                    <Form onSubmit={handleSubmit}>
                      <Form.Group controlId="item">
                        <Form.Control
                          type="number"
                          placeholder="Enter item number"
                          value={item}
                          onChange={(e) => setItem(e.target.value)}
                          required
                        />
                      </Form.Group>
                      {isUniqueError && (
                        <Alert variant="danger" style={{margin: '20px', padding: '10px 15px'}}>Item number must be unique!</Alert>
                      )}
                      <Form.Group controlId="activity">
                        <Form.Control
                          type="text"
                          placeholder="Enter an activity or task"
                          value={activity}
                          onChange={(e) => setActivity(e.target.value)}
                          required
                        />
                      </Form.Group>

                      <Button className="button" variant="primary" type="submit" style={{marginLeft: '20px'}}>
                        Add Task
                      </Button>
                    </Form>
                  </Flex>
                </Col>
                <Col style={{marginLeft: '20px'}}>
                    <h4>NoteList App</h4>
                    <p>The app is a to-do list manager where users after logging in, they can add new tasks, and manage their completion status. Tasks are organized in a table, with a checkbox indicating whether a task is completed. Upon marking a task as completed, it appears in a separate table displaying all completed tasks. You can also remove tasks that you marked as completed. The design is user-friendly with distinct cards for adding and viewing tasks, ensuring a streamlined task management experience.</p>
                    <br/>
                    <h6>Enter the task you want to add to the task management list!!!!</h6>
                </Col>
              </Row>
            </Card>

            <div className="cardsWrapper">
              <Card className="card2">
                <Card.Header>
                  The List of Tasks
                </Card.Header>
                <Card.Body>
                  <Table striped bordered hover>
                    <thead>
                      <tr>
                        <th>Item</th>
                        <th>Activity</th>
                        <th>Done</th>
                      </tr>
                    </thead>
                    <tbody>
                      {tasks.map((task, index) => (
                        <tr key={index}>
                          <td>{task.item}</td>
                          <td>{task.activity}</td>
                          <td>
                            <Form.Check
                              type="checkbox"
                              checked={task.completed}
                              onChange={() => markAsCompleted(index)}
                            />
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </Table>
                </Card.Body>
              </Card>

              <Card className="card3">
                <Card.Header>
                  The List of Completed Tasks
                </Card.Header>
                <Card.Body>
                  <Table striped bordered hover>
                    <thead>
                      <tr>
                        <th>Item</th>
                        <th>Activity</th>
                        <th>Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      {completedTasks.map((task, index) => (
                        <tr key={index}>
                          <td>{task.item}</td>
                          <td>{task.activity}</td>
                          <td>
                            <Button className="smallButton" variant="danger" onClick={() => removeTask(task.item)}>
                              Remove
                            </Button>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </Table>
                </Card.Body>

              </Card>
            </div>

          </View>
        </Container>
  )
}

export default App
