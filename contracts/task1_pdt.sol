// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract StudentsContract {
    struct Student {
        address id;
        string name;
        uint8[] marks;
        bool exists;
    }

    // Contract owner, the only who can register a new student
    address owner;

    // Students mapping
    mapping(address => Student) public students;
    uint16 nStudents;

    string[] subjects;
    uint8 nSubjects;

    constructor(string[] memory _subjects) {
        //require(owner != address(0), "The owner is already set");
        require(_subjects.length < type(uint8).max, "Maximum subjects exceeded");

        owner = msg.sender;
        nStudents = 0;
        subjects = _subjects;
        nSubjects = uint8(_subjects.length);
    }

    modifier onlyOwner() {
        require(owner != address(0) && owner == msg.sender, "Only the owner can use this function");
        _;
    }

    //onlyOwner
    function registerStudent(address _studentId, string calldata _name, uint8[] calldata _marks) external onlyOwner
    {
        require(address(0) != _studentId, 'Address must be initialized');
        require(students[_studentId].exists == false, 'Student already exists');
        require(_marks.length == nSubjects, "Marks length doesn\'t match with the number of registered subjects");
        //TODO check name is not empty
        //TODO check address is set

        students[_studentId] = Student({id : _studentId, name : _name, marks : _marks, exists : true});
        nStudents++;
    }

    function getStudentDetails(address _studentId) external view returns (Student memory)
    {
        require(students[_studentId].exists == true, "Student doesn't exist");

        return students[_studentId];
    }
}

//["math"]
//0x8989B260D90A512685397026Bebf78A8dFC87c12,"xavi",[1]
//0x0000000000000000000000000000000000000000,"xavi",[1]
