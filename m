From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: Perf support for interpreted and Just-In-Time translated languages
Date: Fri, 5 Dec 2014 13:27:36 -0800
Message-ID: <CAE40pdcXt_gaCXD7n3UED4Y2_gdpH+A3S627TS-72xkbGDoNsA@mail.gmail.com>
References: <1417810736.5098.11.camel@oc0276584878.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:63449 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbaLEV15 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 5 Dec 2014 16:27:57 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so1454475igb.17
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2014 13:27:57 -0800 (PST)
In-Reply-To: <1417810736.5098.11.camel@oc0276584878.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Carl Love <cel@us.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

G'Day Carl,

On Fri, Dec 5, 2014 at 12:18 PM, Carl Love <cel@us.ibm.com> wrote:
>
> > On 12/02/2014 08:36 PM, Brendan Gregg wrote:
> >> G'Day Will,
> >>
> >> On Tue, Dec 2, 2014 at 1:08 PM, William Cohen <wcohen@redhat.com> wrote:
> >>> perf makes use of the debug information provided by the compilers to
> >>> map the addresses observed in the instruction pointer and on the stack
> >>> back to source code.  This works very well for traditional compiled
> >>> programs written in c and c++.  However, the assumption that the
> >>> instruction address maps back to something the user wrote is not true
> >>> for code written in interpretered languages such as python, perl, and
> >>> Ruby or for Just-In-Time (JIT) runtime environment commonly used for
> >>> Java.  The addresses would either map back to the interpreter runtime
> >>> or dynamically generated code.  It would be really nice if perf was
> >>> enhanced to provide data about where in the interpreted and JIT'ed
> >>> code the processor was spending time.
>
> I wholeheartedly agree. The ability to profile Java JITed code is a very big
> deal for some perf users. I think perf should provide its own solution for
> profiling Java JITed code that is well designed and well documented, instead of
> directing users to something out-of-tree and out of perf's sphere of control.

I posted a hotspot patch yesterday:
http://mail.openjdk.java.net/pipermail/hotspot-compiler-dev/2014-December/016477.html

Along with perf-map-agent for symbol translation, this lets perf
profile Java (noting the caveats in that email).

... There are a lot of exotic things we can do with perf, but I don't
think CPU stack profiling is one of them. I think if you have perf &
java, it should just work.

> >>
> >> perf supports the /tmp/perf-PID.map files for JIT translations. It's
> >> up to the runtimes to create these files.
> >>
> >> I was enhancing the Java perf-map-agent today
> >> (https://github.com/jrudolph/perf-map-agent), and using it with perf.
>
> Thanks for the pointer. I didn't know about this tool before. It's cool that
> it has the ability to attach to a running JVM and create a /tmp/perf-<pid>.map
> file -- i.e., can capture profile data without having to start the JVM with the
> -agentpath or -agentlib option. But the downside is (as the documentation says) ...
>   "Over time the JVM will JIT compile more methods and the perf-<pid>.map file
>   will become stale. You need to rerun perf-java to generate a new and current map."

FWIW, there's a lot of churn in the first few minutes of java running
hot, as methods get compiled, but I've seen it settle down after 5
minutes for my workload. Still, it's something I'm keeping an eye on.
I can, at least, generate a map before and after profiling, and look
for changes.

>
>
> >> perf doesn't seem to handle map files that grow (and overwrite
> >> symbols) very well, so I had to create an extra step that cleaned up
> >> the map file. I should write up the Java instructions somewhere.
>
> Yes, oprofile has to handle that as well. It keeps track of how long
> each symbol resides at the overwritten address, and then chooses the
> one that was resident the longest to attribute samples to. It's of course not
> perfect, but it's probably reasonable to do so.  The oprofile user manual
> explains this (http://oprofile.sourceforge.net/doc/overlapping-symbols.html).

Hm, that is a bit odd. My dumb solution would have been to detect
symbols that have changed during profiling, and flag them in the
profile so the end-user would know to be dubious. The percentage is
pretty small, but YMMV.

If we were to look at timing, why not have JVMTI emit timestamped
method symbols, and then correlate to perf's timestamped samples.

>
> >>
> >> I did do a writeup for Node.js, whose v8 engine supports the perf map
> >> files. See: http://www.brendangregg.com/blog/2014-09-17/node-flame-graphs-on-linux.html
> >>
> >> Also see tools/perf/Documentation/jit-interface.txt
> >>
> >>> OProfile provides the ability to map samples from Java Runtime
> >>> Environment (JRE) JIT code using a shared library agent loaded when
> >>> the program starts executing.  The shared library uses the JVMTI or
> >>> JVMPI interface to note the method that each region of JIT'ed code
> >>> maps to.  This is later used to map the instruction pointer back to
> >>> the appropriate Java method.  There is some information on how this is
> >>> implement at http://oprofile.sourceforge.net/doc/devel/index.html.
> >>
> >> Yes, that's exactly what perf-map-agent does (JVMTI). I only just
>
> Similar, but not exactly. OProfile's Java agent library is passed to the JVM
> on startup and is continuously used throughout the JVM's run time. It would be
> ideal to have both this functionality and the attach functionality of perf-map-agent.

Actually, that is what perf-map-agent did do when I wrote this. :) It
was just changed, so that it now emits the map file on demand.

A motivating factor to change this was that the map file grew in such
a way that it confused perf_events, which didn't translate properly. I
haven't debugged it, but I suspect perf_events expects a sorted map
file, which this wasn't. I wrote a perl tool to tidy up the map file,
which made perf_events then work correctly.. The other solution, which
is what perf-map-agent now does, is just to dump the whole map file on
demand, rather than growing it over time.

>
> > OProfile provides two implementations of VM-specific libs -- one for pre-1.5 Java
> > (using JVMPI interface) and another for 1.5 and later Java (using JVMTI interface).
> > I know there are some other VM-specific agent libs that have been written (for mono
> > and LLVM), but don't know how much they are used -- they were not contributed to
> > oprofile.
> >> created the pull request, but if you try perf-map-agent, you'll want
> >> to use the fflush fix to avoid buffering lag
> >> (https://github.com/jrudolph/perf-map-agent/pull/8).
>
> There are a couple other issues with the current techniques used by perf for profiling
> JITed code (unless I'm missing something):
>   - When are the /tmp/perf-<pid>.map files deleted?

That's up to the runtime agent. Currently never, so your /tmp slowly fills!

>   - How does this work for the offline analysis scenario (i.e., using 'perf archive')?
>     Would the /tmp/perf-<pid>.map files have to be copied over to the host system where
>     the analysis is being done?

Yes. I keep copies of the perf.map along with the perf.data. It might
be worth having an option to perf to change the base path for these
maps, so that I didn't have to keep putting them in /tmp.

Brendan
