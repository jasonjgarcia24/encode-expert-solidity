# Homework 4

***
## Optimising Storage
Using the <a href="https://github.com/naddison36/sol2uml">sol2uml</a> tool, find how many storage slots <a href="https://gist.github.com/extropyCoder/6e9b5d5497b8ead54590e72382cdca24">this contract</a> is using.<br>

By reordering the variables, reduce the number of storage slots needed.<br>

<b>Original Storage Layout</b>:<br>
[Original Contract](./original__Store.sol)<br>
`sol2uml storage 01-week/hw/Homework04/Store.sol -c Store -o 01-week/hw/Homework04/img/original-store-storage-report.svg`<br>

![Original Store Storage Report](./img/original-store-storage-report.svg)<br>

<b>Updated Storage Layout</b>:<br>
[Updated Contract](./Store.sol)<br>
`sol2uml storage 01-week/hw/Homework04/Store.sol -c Store -o 01-week/hw/Homework04/img/store-storage-report.svg`<br>

![Updated Store Storage Report](./img/updated-store-storage-report.svg)