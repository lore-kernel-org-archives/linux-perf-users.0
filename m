From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: Perf support for interpreted and Just-In-Time translated languages
Date: Tue, 2 Dec 2014 18:36:55 -0800
Message-ID: <CAE40pddDWJuYvNL_HgOrovc=OXTDg2gEDGrQVgL54suTdPj_DQ@mail.gmail.com>
References: <547E2A3F.60504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:52370 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbaLCChQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 2 Dec 2014 21:37:16 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so16134884igb.7
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2014 18:37:15 -0800 (PST)
In-Reply-To: <547E2A3F.60504@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

G'Day Will,

On Tue, Dec 2, 2014 at 1:08 PM, William Cohen <wcohen@redhat.com> wrote:
> perf makes use of the debug information provided by the compilers to
> map the addresses observed in the instruction pointer and on the stack
> back to source code.  This works very well for traditional compiled
> programs written in c and c++.  However, the assumption that the
> instruction address maps back to something the user wrote is not true
> for code written in interpretered languages such as python, perl, and
> Ruby or for Just-In-Time (JIT) runtime environment commonly used for
> Java.  The addresses would either map back to the interpreter runtime
> or dynamically generated code.  It would be really nice if perf was
> enhanced to provide data about where in the interpreted and JIT'ed
> code the processor was spending time.

perf supports the /tmp/perf-PID.map files for JIT translations. It's
up to the runtimes to create these files.

I was enhancing the Java perf-map-agent today
(https://github.com/jrudolph/perf-map-agent), and using it with perf.
perf doesn't seem to handle map files that grow (and overwrite
symbols) very well, so I had to create an extra step that cleaned up
the map file. I should write up the Java instructions somewhere.

I did do a writeup for Node.js, whose v8 engine supports the perf map
files. See: http://www.brendangregg.com/blog/2014-09-17/node-flame-graphs-on-linux.html

Also see tools/perf/Documentation/jit-interface.txt

> OProfile provides the ability to map samples from Java Runtime
> Environment (JRE) JIT code using a shared library agent loaded when
> the program starts executing.  The shared library uses the JVMTI or
> JVMPI interface to note the method that each region of JIT'ed code
> maps to.  This is later used to map the instruction pointer back to
> the appropriate Java method.  There is some information on how this is
> implement at http://oprofile.sourceforge.net/doc/devel/index.html.

Yes, that's exactly what perf-map-agent does (JVMTI). I only just
created the pull request, but if you try perf-map-agent, you'll want
to use the fflush fix to avoid buffering lag
(https://github.com/jrudolph/perf-map-agent/pull/8).

Brendan

--
http://www.brendangregg.com
