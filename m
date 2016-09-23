From: Bruno Alexandre Rosa <bruno.rosa@eldorado.org.br>
Subject: RE: Using perf inject on ppc64le
Date: Fri, 23 Sep 2016 22:28:52 +0000
Message-ID: <8a73d9e467e745e9b46d4d9555155f76@serv030.corp.eldorado.org.br>
References: <9f091d82a3a44d2d8c80622a64f59d01@serv030.corp.eldorado.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp1.eldorado.org.br ([200.148.226.10]:54979 "EHLO
        smtp1.eldorado.org.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbcIWW3H (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Sep 2016 18:29:07 -0400
In-Reply-To: <9f091d82a3a44d2d8c80622a64f59d01@serv030.corp.eldorado.org.br>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Looking closer, when I switch to flat profile and profile an example more interesting than a HelloWorld, I could actually see annotated jitted code on ppc64. But perf still complains about missing perf-<pid>.map(s)  (is that an unrelated problem?)

Output from profiling hog.java example on the patch notes

<clipped>
+    7.32%     0.01%  java             perf-8536.map        [.] 0x00003fff60009958             <===== missing symbols                                                                                             
+    6.85%     0.00%  java             perf-8536.map        [.] 0x00003fff88474400             <===== missing symbols           
+    6.81%     0.01%  C2 CompilerThre  libjvm.so            [.] PhaseChaitin::Register_Allocate
+    6.81%     0.02%  java             jitted-8536-1009.so  [.] class hog.do_something(int)             <===== it works! 
+    6.61%     0.00%  C2 CompilerThre  libjvm.so            [.] Compile::Optimize                                                                                                               
<clipped>

Regards,
Bruno Rosa

-----Original Message-----
From: linux-perf-users-owner@vger.kernel.org [mailto:linux-perf-users-owner@vger.kernel.org] On Behalf Of Bruno Alexandre Rosa
Sent: sexta-feira, 23 de setembro de 2016 16:23
To: linux-perf-users@vger.kernel.org
Subject: Using perf inject on ppc64le

Hello everyone,

I'm trying to inspect "jitted" code (i.e. code from a just-in-time compiler) from OpenJDK following the steps mentioned in https://patchwork.kernel.org/patch/8236901/ on a  ppc64le 4.4.0-38-generic Ubuntu 16.04 virtual machine.
Unfortunately, though, when I look at the perf report, the higher level of detail I can get is on perf-<pid>.map.

Going through the same steps on a x64 virtual machine I was able to get to jit-<pid>.so level of information.

Is there any known compatibility/port issue? Am I missing something?

More info:
- Perf compiled from from git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
- Perf record command line and output:
brunorosa@brosa-ubuntu:~/test$ ~/tip/tools/perf/perf record -k mono -g /home/brunorosa/hs-comp/build/linux-ppc64le-normal-server-release/jdk/bin/java -agentpath:libjvmti.so HelloWorld
WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted, check /proc/sys/kernel/kptr_restrict.

Samples in kernel functions may not be resolved if a suitable vmlinux file is not found in the buildid cache or in the vmlinux path.

Samples in kernel modules won't be resolved at all.

If some relocation was applied (e.g. kexec) symbols may be misresolved even with a suitable vmlinux or kallsyms file.

Couldn't record kernel reference relocation symbol Symbol resolution may be skewed if relocation was used (e.g. kexec).
Check /proc/kallsyms permission or run as root.
java: jvmti: jitdump in /home/brunorosa/.debug/jit/java-jit-20160923.XXD2HmC2/jit-13964.dump
Compiler intrinsic is defined for method [java.lang.Math.fma(FFF)F], but the method is not annotated with @HotSpotIntrinsicCandidate. Method will not be inlined.
Compiler intrinsic is defined for method [java.lang.Math.fma(DDD)D], but the method is not annotated with @HotSpotIntrinsicCandidate. Method will not be inlined.
Hello, World
[ perf record: Woken up 4 times to write data ] [kernel.kallsyms] with build id 2132f2e43450ff769c824a9552ab551ab8402d7b not found, continuing without symbols [ perf record: Captured and wrote 1.749 MB perf.data (7551 samples) ]

-  Perf inject command line: ~/tip/tools/perf/perf inject --jit -i perf.data -o perf.jitted.data

- Perf report command line:
brunorosa@brosa-ubuntu: ~/tip/tools/perf/perf report -g 'graph,0.5,caller' -i perf.jitted.data <clipped>
+   36.91%     0.00%  C2 CompilerThre  libjvm.so              [.] 
+CompileBroker::compiler_thread_loop
+   36.91%     0.00%  C2 CompilerThre  libjvm.so              [.] 
+compiler_thread_entry
+   36.91%     0.00%  C2 CompilerThre  libjvm.so              [.] 
+JavaThread::thread_main_inner
+   36.91%     0.00%  C2 CompilerThre  libjvm.so              [.] 
+thread_native_entry
+   36.91%     0.00%  C2 CompilerThre  libpthread-2.23.so     [.] 
+start_thread
+   36.91%     0.00%  C2 CompilerThre  libc-2.23.so           [.] 
+__clone
+   36.19%     0.00%  C2 CompilerThre  libjvm.so              [.] 
+CompileBroker::invoke_compiler_on_method
+   36.03%     0.00%  C2 CompilerThre  libjvm.so              [.] 
+C2Compiler::compile_method
+   36.00%     0.00%  C2 CompilerThre  libjvm.so              [.] 
+Compile::Compile
+   34.03%     0.01%  java             libc-2.23.so           [.] 
+__clone
+   34.00%     0.00%  java             libpthread-2.23.so     [.] 
+start_thread
+   33.35%     0.00%  java             libjli.so              [.] 
+JavaMain
+   33.05%     0.00%  java             libjvm.so              [.] 
+Threads::create_vm
+   33.05%     0.00%  java             libjvm.so              [.] 
+JNI_CreateJavaVM
+   31.84%     0.00%  java             libjvm.so              [.] 
+JavaCalls::call_helper
+   31.84%     0.00%  java             libjvm.so              [.] 
+os::os_exception_wrapper
+   31.08%     0.00%  java             libjvm.so              [.] 
+JavaCalls::call_static
+   30.29%     0.00%  java             perf-13964.map         [.] 
+0x00003fff20000924
+   30.25%     0.07%  java             perf-13964.map         [.] 
+0x00003fff2000a2a0
+   29.87%     0.07%  java             perf-13964.map         [.] 
+0x00003fff2000a53c
+   29.56%     0.00%  java             perf-13964.map         [.] 
+0x00003fff2000a37c
+   24.15%     0.04%  java             perf-13964.map         [.] 
+0x00003fff2000a5ac
<clipped>

Regards,
Bruno Rosa
--
To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
