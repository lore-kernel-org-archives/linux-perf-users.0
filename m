From: Carl Love <cel@us.ibm.com>
Subject: Re: Perf support for interpreted and Just-In-Time translated
 languages
Date: Fri, 05 Dec 2014 12:18:56 -0800
Message-ID: <1417810736.5098.11.camel@oc0276584878.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:58092 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbaLEUTC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 5 Dec 2014 15:19:02 -0500
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <cel@us.ibm.com>;
	Fri, 5 Dec 2014 13:19:02 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id C801A19D8040
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Dec 2014 13:07:38 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sB5KJfl249479698
	for <linux-perf-users@vger.kernel.org>; Fri, 5 Dec 2014 13:19:41 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sB5KIwYf004000
	for <linux-perf-users@vger.kernel.org>; Fri, 5 Dec 2014 13:18:58 -0700
Received: from [9.70.82.175] ([9.70.82.175])
	by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id sB5KIvIS003884
	for <linux-perf-users@vger.kernel.org>; Fri, 5 Dec 2014 13:18:57 -0700
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

> On 12/02/2014 08:36 PM, Brendan Gregg wrote:
>> G'Day Will,
>>
>> On Tue, Dec 2, 2014 at 1:08 PM, William Cohen <wcohen@redhat.com> wrote:
>>> perf makes use of the debug information provided by the compilers to
>>> map the addresses observed in the instruction pointer and on the stack
>>> back to source code.  This works very well for traditional compiled
>>> programs written in c and c++.  However, the assumption that the
>>> instruction address maps back to something the user wrote is not true
>>> for code written in interpretered languages such as python, perl, and
>>> Ruby or for Just-In-Time (JIT) runtime environment commonly used for
>>> Java.  The addresses would either map back to the interpreter runtime
>>> or dynamically generated code.  It would be really nice if perf was
>>> enhanced to provide data about where in the interpreted and JIT'ed
>>> code the processor was spending time.

I wholeheartedly agree. The ability to profile Java JITed code is a very big
deal for some perf users. I think perf should provide its own solution for
profiling Java JITed code that is well designed and well documented, instead of
directing users to something out-of-tree and out of perf's sphere of control.

>>
>> perf supports the /tmp/perf-PID.map files for JIT translations. It's
>> up to the runtimes to create these files.
>>
>> I was enhancing the Java perf-map-agent today
>> (https://github.com/jrudolph/perf-map-agent), and using it with perf.

Thanks for the pointer. I didn't know about this tool before. It's cool that
it has the ability to attach to a running JVM and create a /tmp/perf-<pid>.map
file -- i.e., can capture profile data without having to start the JVM with the
-agentpath or -agentlib option. But the downside is (as the documentation says) ...
  "Over time the JVM will JIT compile more methods and the perf-<pid>.map file
  will become stale. You need to rerun perf-java to generate a new and current map."

>> perf doesn't seem to handle map files that grow (and overwrite
>> symbols) very well, so I had to create an extra step that cleaned up
>> the map file. I should write up the Java instructions somewhere.

Yes, oprofile has to handle that as well. It keeps track of how long
each symbol resides at the overwritten address, and then chooses the
one that was resident the longest to attribute samples to. It's of course not
perfect, but it's probably reasonable to do so.  The oprofile user manual
explains this (http://oprofile.sourceforge.net/doc/overlapping-symbols.html).

>>
>> I did do a writeup for Node.js, whose v8 engine supports the perf map
>> files. See: http://www.brendangregg.com/blog/2014-09-17/node-flame-graphs-on-linux.html
>>
>> Also see tools/perf/Documentation/jit-interface.txt
>>
>>> OProfile provides the ability to map samples from Java Runtime
>>> Environment (JRE) JIT code using a shared library agent loaded when
>>> the program starts executing.  The shared library uses the JVMTI or
>>> JVMPI interface to note the method that each region of JIT'ed code
>>> maps to.  This is later used to map the instruction pointer back to
>>> the appropriate Java method.  There is some information on how this is
>>> implement at http://oprofile.sourceforge.net/doc/devel/index.html.
>>
>> Yes, that's exactly what perf-map-agent does (JVMTI). I only just

Similar, but not exactly. OProfile's Java agent library is passed to the JVM
on startup and is continuously used throughout the JVM's run time. It would be
ideal to have both this functionality and the attach functionality of perf-map-agent.

> OProfile provides two implementations of VM-specific libs -- one for pre-1.5 Java
> (using JVMPI interface) and another for 1.5 and later Java (using JVMTI interface).
> I know there are some other VM-specific agent libs that have been written (for mono
> and LLVM), but don't know how much they are used -- they were not contributed to
> oprofile.
>> created the pull request, but if you try perf-map-agent, you'll want
>> to use the fflush fix to avoid buffering lag
>> (https://github.com/jrudolph/perf-map-agent/pull/8).

There are a couple other issues with the current techniques used by perf for profiling
JITed code (unless I'm missing something):
  - When are the /tmp/perf-<pid>.map files deleted?
  - How does this work for the offline analysis scenario (i.e., using 'perf archive')?
    Would the /tmp/perf-<pid>.map files have to be copied over to the host system where
    the analysis is being done?

                     Carl Love
