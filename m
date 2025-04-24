Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A58D281357;
	Thu, 24 Apr 2025 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511876; cv=none; b=cFxtCgnu7IFBd9RAWzIKD9wiN/YKBnVxTZMI7Fr4P26T/ZTJXV2vyhB8jIKcpepYOqMk4yZlU757My6CLE44Ep26FD2rUok4tMKlbssEOGklZ/hO4lcnwzfmx9LTVjr4bX1uK+Y3soi5OaZZafcVN61Ku+isMnPgQj828Tc+st0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511876; c=relaxed/simple;
	bh=Jao3+sdr1Py0lNBzRRjKO3lUvn6bSaXkSWTdhLVTc9E=;
	h=Message-ID:Date:From:To:Cc:Subject; b=gejOlbmozEBgr1WXjyauEMSPAxoRPsy547+pmDrD6TVz4M/LVXvQ5cMV2aS0gyHUbwGrGAc0ZDKtkh23d6qNeQoT/LgbJqZYLVs/K2agkDGW/YFVfs32Gyw8vT6g5MkOEovfx3aOksPsFrbvMPuvsLWxjdCaviA5/GYdTuVhsAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904D1C4CEE8;
	Thu, 24 Apr 2025 16:24:35 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u7zPD-0000000GyVD-1FKZ;
	Thu, 24 Apr 2025 12:26:31 -0400
Message-ID: <20250424162529.686762589@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 12:25:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org,
 Jordan Rome <jordalgo@meta.com>,
 Sam James <sam@gentoo.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>,
 Weinan Liu <wnliu@google.com>,
 Blake Jones <blakejones@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>
Subject: [PATCH v5 00/17] perf: Deferred unwinding of user space stack traces
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>


I'm currently working on getting sframe support from the kernel.
Josh Poimboeuf did a lot of the hard work already, but he told me he doesn't
have time to continue it so I'm picking it up where he left off.

His last series of v4 is here:

  https://lore.kernel.org/all/cover.1737511963.git.jpoimboe@kernel.org/

It covers a lot of topics as he found issues with other aspects of
the kernel that needed to be fixed for sframes to work properly.

This series focuses only on implementing the deferred user space
stack tracing that can be used by perf. It does not implement sframe
support nor does it add an interface that can be used by ftrace
or LTTng (that will come later).

I based this off of the latest tip/master:

 commit 7ab869c799fc0fb22f9b4c2f36aaa603d9c7cc9d

A new generic interface is created for user space stack tracing.
It does not replace the current stack_trace_save_user() interface,
but creates a new interface that can handle more complex tasks.
For instance, deferred stack tracing.

Josh's code had an interface with:

  unwind_deferred_init()
  unwind_deferred_request()
  unwind_deferred_cancel()

That is not in this series.

That code made it possible for a tracer to register that it will be wanting
to have user space stacktraces and give it a callback to call when the task
goes back to user space. An interface to request a stacktrace and is given a
"cookie" that will be used to map it to the stacktrace that will be
retrieved when the task exits. And an interface to unregister (cancel).

But that is not in this series. This adds a new interface that is called by
the tracer from a faultable context and gets the user space stack trace
immediately. It also has the cache logic where if the same stacktrace
is requested more than once (possibly by different requesters) it doesn't
have to regenerate the trace.

The new function is:

  unwind_deferred_trace()

Since perf is unique from other tracers where it has a separate event for
basically every task and/or every event and can have hundreds of requesters
for a task stack trace, I found it was just better to have perf use its own
setup with a task_work per event. This is very similar to what Josh did with
his last version within the above three functions. But since that was not
very useful for ftrace or LTTng, and perf didn't need the cookie concept, I
decided to just implement that directly within perf. That made the unwinder
code simpler for this version.



Josh Poimboeuf (12):
      unwind_user: Add user space unwinding API
      unwind_user: Add frame pointer support
      unwind_user/x86: Enable frame pointer unwinding on x86
      perf/x86: Rename and move get_segment_base() and make it global
      unwind_user: Add compat mode frame pointer support
      unwind_user/x86: Enable compat mode frame pointer unwinding on x86
      unwind_user/deferred: Add unwind cache
      perf: Remove get_perf_callchain() 'init_nr' argument
      perf: Have get_perf_callchain() return NULL if 'crosstask' and 'user' are set
      perf: Simplify get_perf_callchain() user logic
      perf: Skip user unwind if !current->mm
      perf: Support deferred user callchains

Namhyung Kim (4):
      perf tools: Minimal CALLCHAIN_DEFERRED support
      perf record: Enable defer_callchain for user callchains
      perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
      perf tools: Merge deferred user callchains

Steven Rostedt (1):
      unwind_user/deferred: Add unwind_deferred_trace()

----
 MAINTAINERS                               |   8 ++
 arch/Kconfig                              |  14 +++
 arch/x86/Kconfig                          |   2 +
 arch/x86/events/core.c                    |  44 +-------
 arch/x86/include/asm/ptrace.h             |   2 +
 arch/x86/include/asm/unwind_user.h        |  61 +++++++++++
 arch/x86/include/asm/unwind_user_types.h  |  17 +++
 arch/x86/kernel/ptrace.c                  |  38 +++++++
 include/asm-generic/Kbuild                |   2 +
 include/asm-generic/unwind_user.h         |  24 +++++
 include/asm-generic/unwind_user_types.h   |   9 ++
 include/linux/entry-common.h              |   2 +
 include/linux/perf_event.h                |  15 ++-
 include/linux/sched.h                     |   5 +
 include/linux/unwind_deferred.h           |  31 ++++++
 include/linux/unwind_deferred_types.h     |  14 +++
 include/linux/unwind_user.h               |  15 +++
 include/linux/unwind_user_types.h         |  35 +++++++
 include/uapi/linux/perf_event.h           |  19 +++-
 kernel/Makefile                           |   1 +
 kernel/bpf/stackmap.c                     |   8 +-
 kernel/events/callchain.c                 |  47 +++++----
 kernel/events/core.c                      | 165 +++++++++++++++++++++++++++++-
 kernel/fork.c                             |   4 +
 kernel/unwind/Makefile                    |   1 +
 kernel/unwind/deferred.c                  |  62 +++++++++++
 kernel/unwind/user.c                      | 130 +++++++++++++++++++++++
 tools/include/uapi/linux/perf_event.h     |  19 +++-
 tools/lib/perf/include/perf/event.h       |   7 ++
 tools/perf/Documentation/perf-script.txt  |   5 +
 tools/perf/builtin-script.c               |  92 +++++++++++++++++
 tools/perf/util/callchain.c               |  24 +++++
 tools/perf/util/callchain.h               |   3 +
 tools/perf/util/event.c                   |   1 +
 tools/perf/util/evlist.c                  |   1 +
 tools/perf/util/evlist.h                  |   1 +
 tools/perf/util/evsel.c                   |  39 +++++++
 tools/perf/util/evsel.h                   |   1 +
 tools/perf/util/machine.c                 |   1 +
 tools/perf/util/perf_event_attr_fprintf.c |   1 +
 tools/perf/util/sample.h                  |   3 +-
 tools/perf/util/session.c                 |  78 ++++++++++++++
 tools/perf/util/tool.c                    |   2 +
 tools/perf/util/tool.h                    |   4 +-
 44 files changed, 985 insertions(+), 72 deletions(-)
 create mode 100644 arch/x86/include/asm/unwind_user.h
 create mode 100644 arch/x86/include/asm/unwind_user_types.h
 create mode 100644 include/asm-generic/unwind_user.h
 create mode 100644 include/asm-generic/unwind_user_types.h
 create mode 100644 include/linux/unwind_deferred.h
 create mode 100644 include/linux/unwind_deferred_types.h
 create mode 100644 include/linux/unwind_user.h
 create mode 100644 include/linux/unwind_user_types.h
 create mode 100644 kernel/unwind/Makefile
 create mode 100644 kernel/unwind/deferred.c
 create mode 100644 kernel/unwind/user.c
