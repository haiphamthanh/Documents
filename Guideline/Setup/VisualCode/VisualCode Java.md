## Hướng dẫn setup môi trường Java trong VS Code.

### Reference link: https://code.visualstudio.com/Download

# Getting Started with Java in VS Code



This tutorial shows you how to write and run Hello World program in Java with Visual Studio Code. It also covers a few advanced features, which you can explore by reading other documents in this section.

For an overview of the features available for Java in VS Code, see [Java Language Overview](https://code.visualstudio.com/docs/languages/java)

If you run into any issues when following this tutorial, you can contact us by clicking the **Report an issue** button below.

[Report an issue](javascript:void(0))

## Setting up VS Code for Java development[#](https://code.visualstudio.com/docs/java/java-tutorial#_setting-up-vs-code-for-java-development)

### Coding Pack for Java[#](https://code.visualstudio.com/docs/java/java-tutorial#_coding-pack-for-java)

To help you set up quickly, you can install the **Coding Pack for Java**, which includes VS Code, the Java Development Kit (JDK), and essential Java extensions. The Coding Pack can be used as a clean installation, or to update or repair an existing development environment.

[Install the Coding Pack for Java - Windows](https://aka.ms/vscode-java-installer-win)

[Install the Coding Pack for Java - macOS](https://aka.ms/vscode-java-installer-mac)

> **Note**: The Coding Pack for Java is only available for Windows and macOS. For other operating systems, you will need to manually install a JDK, VS Code, and Java extensions.

### Installing extensions[#](https://code.visualstudio.com/docs/java/java-tutorial#_installing-extensions)

If you are an existing VS Code user, you can also add Java support by installing [Java Extension Pack](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack), which includes these extensions:

- [Language Support for Java(TM) by Red Hat](https://marketplace.visualstudio.com/items?itemName=redhat.java)
- [Debugger for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-debug)
- [Java Test Runner](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-test)
- [Maven for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-maven)
- [Project Manager for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-dependency)

[Install the Java Extension Pack](vscode:extension/vscjava.vscode-java-pack)

The [Java Extension Pack](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack) provides a Quick Start guide and tips for code editing and debugging. It also has a FAQ that answers some frequently asked questions. Use the command **Java: Getting Started** from the Command Palette (⇧⌘P) to launch the guide.

![Java Getting Started](https://code.visualstudio.com/assets/docs/java/java-tutorial/getting-started.png)

You can also install extensions separately. The **Extension Guide** is provided to help you. You can launch the guide with the **Java: Extension Guide** command.

For this tutorial, the only required extensions are:

- [Language Support for Java(TM) by Red Hat](https://marketplace.visualstudio.com/items?itemName=redhat.java)
- [Debugger for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-debug)

## Settings for the JDK[#](https://code.visualstudio.com/docs/java/java-tutorial#_settings-for-the-jdk)

### Supported Java versions[#](https://code.visualstudio.com/docs/java/java-tutorial#_supported-java-versions)

The supported version for running the VS Code for Java extension and the supported version for your projects are two separate runtimes. To run VS Code for Java, Java SE 11 or above version is required; for projects, VS Code for Java supports projects with version 1.5 or above. For more details, refer to [Configure JDK](https://code.visualstudio.com/docs/java/java-project#_configure-jdk).

### Using Java runtime configuration wizard[#](https://code.visualstudio.com/docs/java/java-tutorial#_using-java-runtime-configuration-wizard)

To help you configure correctly, we provide a runtime configuration wizard. You can launch the wizard by opening the **Command Palette** (⇧⌘P) and typing the command **Java: Configure Java Runtime**, which will display the configuration user interface below.

![JDK Configuration](https://code.visualstudio.com/assets/docs/java/java-tutorial/jdk-config-wizard-overview.png)

> **Note**: To configure multiple JDKs, see [Configure JDK](https://code.visualstudio.com/docs/java/java-project#_configure-jdk). To enable Java preview features, see [How can I use VS Code with new Java versions](https://code.visualstudio.com/docs/java/java-faq#_how-can-i-use-visual-studio-code-with-new-java-versions)

### Using VS Code settings[#](https://code.visualstudio.com/docs/java/java-tutorial#_using-vs-code-settings)

Alternatively, you can configure JDK settings using the VS Code Settings editor. A common way to do this is [setting the value of the JAVA_HOME system environment variable](https://docs.oracle.com/cd/E19182-01/821-0917/inst_jdk_javahome_t/index.html) to the install location of the JDK, for example, `C:\Program Files\Java\jdk-13.0.2`. Or if you want to configure only VS Code to use the JDK, use the `java.home` setting in VS Code's [User or Workspace settings](https://code.visualstudio.com/docs/getstarted/settings).

### Installing a Java Development Kit (JDK)[#](https://code.visualstudio.com/docs/java/java-tutorial#_installing-a-java-development-kit-jdk)

When you need to install a JDK, we recommend you to consider installing from one of these sources:

- [Oracle Java SE](https://www.oracle.com/java/technologies/javase-downloads.html)
- [AdoptOpenJDK](https://adoptopenjdk.net/)
- [Azul Zulu for Azure - Enterprise Edition](https://www.azul.com/downloads/azure-only/zulu/)

## Creating a source code file[#](https://code.visualstudio.com/docs/java/java-tutorial#_creating-a-source-code-file)

Create a folder for your Java program and open the folder with VS Code. Then in VS Code, create a new file and save it with the name `Hello.java`. When you open that file, the Java Language Server automatically starts loading, and you should see a loading icon on the right side of the Status Bar. After it finishes loading, you will see a thumbs-up icon.

<video autoplay="" loop="" muted="" playsinline="" controls="" style="box-sizing: border-box; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; display: inline-block; vertical-align: baseline; margin-top: 1.5rem; margin-bottom: 2.5rem; width: 750px; max-width: 100%; color: rgb(68, 68, 68); font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></video>



> **Note**: If you open a Java file in VS Code without opening its folder, the Java Language Server might not work properly.

VS Code will also try to figure out the correct package for the new type and fill the new file from a template. See [Create new file](https://code.visualstudio.com/docs/java/java-editing#_create-new-file).

You can also create a Java project using the **Java: Create Java Project** command. Bring up the **Command Palette** (⇧⌘P) and then type `java` to search for this command. After selecting the command, you will be prompted for the location and name of the project. You can also choose your build tool from this command.

<video autoplay="" loop="" muted="" playsinline="" controls="" style="box-sizing: border-box; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; display: inline-block; vertical-align: baseline; margin-top: 1.5rem; margin-bottom: 2.5rem; width: 750px; max-width: 100%; color: rgb(68, 68, 68); font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></video>



Visual Studio Code also supports more complex Java projects, see [Project Management](https://code.visualstudio.com/docs/java/java-project).

## Editing source code[#](https://code.visualstudio.com/docs/java/java-tutorial#_editing-source-code)

You can use code snippets to scaffold your classes and methods. VS Code also provides IntelliSense for code completion, and various refactor methods.

<video autoplay="" loop="" muted="" playsinline="" controls="" style="box-sizing: border-box; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; display: inline-block; vertical-align: baseline; margin-top: 1.5rem; margin-bottom: 2.5rem; width: 750px; max-width: 100%; color: rgb(68, 68, 68); font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></video>



To learn more about editing Java, see [Java Editing](https://code.visualstudio.com/docs/java/java-editing).

## Running and debugging your program[#](https://code.visualstudio.com/docs/java/java-tutorial#_running-and-debugging-your-program)

To run and debug Java code, set a breakpoint, then either press F5 on your keyboard or use the **Run** > **Start Debugging** menu item. You can also use the **Run|Debug** CodeLens options in the editor. After the code compiles, you can see all your variables and threads in the Run view.

<video autoplay="" loop="" muted="" playsinline="" controls="" style="box-sizing: border-box; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; display: inline-block; vertical-align: baseline; margin-top: 1.5rem; margin-bottom: 2.5rem; width: 750px; max-width: 100%; color: rgb(68, 68, 68); font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></video>



The debugger also supports advanced features such as Hot Code replacement and conditional breakpoints.

For more information, see [Java Debugging](https://code.visualstudio.com/docs/java/java-debugging).

## More features[#](https://code.visualstudio.com/docs/java/java-tutorial#_more-features)

The editor also has much more capability for your Java workload.

- [Editing Java](https://code.visualstudio.com/docs/java/java-editing) explains how to navigate and edit Java in more details
- [Debugging](https://code.visualstudio.com/docs/java/java-debugging) illustrates all the key features of the Java Debugger
- [Testing](https://code.visualstudio.com/docs/java/java-testing) provides comprehensive support for JUnit and TestNG framework
- [Java Project Management](https://code.visualstudio.com/docs/java/java-project) shows you how to use a project view and work with Maven
- [Spring Boot](https://code.visualstudio.com/docs/java/java-spring-boot) and [Tomcat and Jetty](https://code.visualstudio.com/docs/java/java-tomcat-jetty) demonstrate great framework support
- [Java Web Apps](https://code.visualstudio.com/docs/java/java-webapp) shows how to work with Java Web App in VS Code
