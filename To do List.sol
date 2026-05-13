 SPDX-License-Identifier MIT
pragma solidity ^0.8.0;

contract DecentralizedTodo {

    struct Task {
        uint id;
        string taskText;
        bool completed;
    }

     Store tasks for each user
    mapping(address = Task[]) private userTasks;

     Add a new task
    function addTask(string memory _taskText) public {
        uint taskId = userTasks[msg.sender].length;

        userTasks[msg.sender].push(
            Task(taskId, _taskText, false)
        );
    }

     Update an existing task
    function updateTask(uint _taskId, string memory _newText) public {
        require(
            _taskId  userTasks[msg.sender].length,
            Task does not exist
        );

        userTasks[msg.sender][_taskId].taskText = _newText;
    }

     Mark task as completed
    function markCompleted(uint _taskId) public {
        require(
            _taskId  userTasks[msg.sender].length,
            Task does not exist
        );

        userTasks[msg.sender][_taskId].completed = true;
    }

     Get all tasks of logged-in user
    function getMyTasks() public view returns (Task[] memory) {
        return userTasks[msg.sender];
    }
}


<!-- How to Perform in Remix IDE
Step 1: Open Remix

Step 2: Create File
    todo.sol
    Paste the smart contract code.

Step 3: Compile Contract

Step 4: Deploy Contract

Testing the Smart Contract
1. Add Task
    Input:
    "Buy groceries"
    Click addTask.

2. View Tasks
    Click:
    getMyTasks

    Output Example:
        [
        {
            id: 0,
            taskText: "Buy groceries",
            completed: false
        }
        ]

3. Update Task
    Input: 
    0
    "Buy milk and groceries"
    Click updateTask.

4. Mark Task Completed
    Input:
    0
    Click markCompleted.

5. Verify Updated Task
    Click getMyTasks.

    Output:
        [
        {
            id: 0,
            taskText: "Buy milk and groceries",
            completed: true
        }
        ]

VIVA QUESTIONS:

1. What is mapping in Solidity?
A mapping stores key-value pairs in blockchain storage.

2. Why is msg.sender used?
It identifies the Ethereum address calling the function.

3. What is a struct?
A struct is a custom data type used to group related variables.

4. Why are tasks private per user?
Tasks are stored using:
mapping(address => Task[])
which separates tasks for each wallet address.

5. What is the purpose of require()?
It validates conditions and reverts transaction if condition fails. -->