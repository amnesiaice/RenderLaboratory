# RenderLaboratory

## Introduction
This is a personal project to follow the official tutorial, try to fulfill the official metal tutorial project, and rewrite it with swift language, this may avoid me to learn with copy-paste.The Tutorial planning to take:

### Official tutorial
- [x] DeviceAndCommands.
- [ ] HelloTriangle
- [ ] BasicBuffers
- [ ] BasicTexturing
- [ ] HelloCompute


This git may try some render feature in the future. Learn some practical technique in Computer Graphic, that's why it is called a Laboratory.Here are some thought:

### Render feature in plan
- Software renderer
- Play with some shader
- Process of physical based rendering
- and so on...


---

## Note Zone
**[Note 1]**
### DeviceAndCommands learning note
The first trial in this git practice meets with one main problem:

[problem]How to convert a NSView Object to a MTLView object.
The obj-c version code use a pointer cast which is not supported in swift.

[solution]Change order of two action: 

1.the super.didviewload function, put it to the last of the view preparation

2.the super.view=_view! sentence to the front part, which change the address of the NSViewController.view 

