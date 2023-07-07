# My experience of using AI assistants for programming the past month

Last month, I started using two services, ChatGPT and Github Copilot to help me with my coding work. They are very different, but both share the underlying model, using [Large Language Models (LLMs)][llms].

 - [ChatGPT][chatgpt]: Is a generic model, that's implemented mainly as a chat bot, but it can answer code questions of various nature.
 - [Github Copilot][copilot]: is a model based on [Codex][codex], a tuned version of an LLM with the focus on code.

Outside this comparison is [Amazon CodeWhisperer][codewhisp] but I would like to give it a try soon. According to the demo I watched, the main difference is that Code Whisperer gives you code *that is actually* in a real open source repo. 

## Configuration
For my trial I worked with Copilot installed on Visual Studio Code as a plugin, I think this is the most productive way to work with.
For ChatGPT I'm using the browser and the popular GitHub project called [AutoGPT][autogpt], that project extends the capabilities of the chat-based interface by using the API of chatGPT and ellaborating a plan based on the user description. Among the capabilities, it can write the files to disk, it can browse the Internet, and you can extend the functionality by using plugins (that's really a very idealistic description of how it really works).

# Experiment: Writing code for a Flutter Application
Yeah, [Flutter][flutter] is a framework written in [Dart][dart] language by Google with the idea of creating one single codebase for all your mobile / desktop applications. I'm writting a couple of apps using this technology and I have to say it's really cool and fast to develop.

I want to create an activity tracker, similar to the one from the main page of GitHub, you may have seen it:
![images/github_activity.png]

## Using GitHub Copilot:
I create an empty file and write the comments in the header of what I want to achieve.
Here the only output I get from Copilot is the list of imports and after a few of them, it loops again to the first import. 
**In this example, Copilot wasn't very useful**.

## Using ChatGPT
This was my prompt: "can you define a widget in flutter to create an activity tracker with squares representing each day, in the style of github front page?"
And this was the code:

```dart
import 'package:flutter/material.dart';

class ActivityTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, // 7 squares per row for each day of the week
      ),
      itemCount: 365, // Total number of days in a year
      itemBuilder: (BuildContext context, int index) {
        return ActivitySquare(); // Custom widget representing a day's activity square
      },
    );
  }
}

class ActivitySquare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.grey, // Set the color based on activity level or data
        shape: BoxShape.rectangle,
      ),
    );
  }
}

// Usage example
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: ActivityTracker(),
    ),
  ));
}

```
You can actually compile this code and with a little bit of wiring up, you can run it, if you see the picture, it's not perfect, but it fits the description.
The solution I implemented works with a different component, and does not use any of this code, the base widgets are different, but it helped me think about the solution.


# Conclusions
Using Copilot for not-so-popular languages like Dart, wasn't really useful. Maybe I have to change the way I ask to the tool. It could be that the language has fewer examples to be trained on. Or it could be just that there is a lot of interaction between different parts of the Flutter framework, which makes very complex for Copilot to write code.

ChatGPT, on the other hand, helped me to get something executable, and like a first iteration, but the final solution was done using a more sophisticated code.









[copilot]: https://github.com/features/copilot
[codex]: https://openai.com/blog/openai-codex
[chatgpt]: https://openai.com/blog/chatgpt
[llms]: https://machinelearningmastery.com/what-are-large-language-models/
[codewhisp]: https://aws.amazon.com/es/codewhisperer
[autogpt]: https://github.com/Significant-Gravitas/Auto-GPT
[flutter]: https://flutter.dev/
[dart]:https://dart.dev/