Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D91A5BB6;
	Thu, 24 Apr 2025 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522656; cv=none; b=Y9emyMouWdv3g2zKhPFt0FS/Q7J7iCaSgUvRUmfb7oTFL9Lgj/NtncO6GyG0/HllcukpaVW/+12hMWq40gOreTnFPDdOJWCbLqSG53BrNGLNyLevj3XZ2xO7w0N7XFWWgytLAU/RFnZwQ5MeF3E566asY7/vZHnQ75LqG8WnOy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522656; c=relaxed/simple;
	bh=bR9QjNDkqqz5zsC3ePNRX3ghEJgOc1RRAoHjTmY7UHg=;
	h=Message-ID:Date:From:To:Cc:Subject; b=T4+lcpd8+F3+wyMrgC+Rs8FkqKRYLU834mmLEkIlpSmGajKwRbCzuFanx/6d5tNHrcluvrrQbPRJRDCeZwc7asDvp0VyLdYpO3gFecIKgWbU08mspW70k9sU7bKoOJCwmhlk1q7JtjuZKVQWPRjiQA92zCEDnmlwrQrlSY92HEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E08AC4CEE4;
	Thu, 24 Apr 2025 19:24:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u82D6-0000000H2OC-1zk4;
	Thu, 24 Apr 2025 15:26:12 -0400
Message-ID: <20250424192456.851953422@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 15:24:56 -0400
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
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Alexander Aring <aahringo@redhat.com>
Subject: [PATCH v5 0/9] tracing: Deferred unwinding of user space stack traces
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

This series focuses on implementing the deferred unwinding for ftrace
(and LTTng could use it).

This implements the three API functions that Josh had in his series:

  unwind_deferred_init()
  unwind_deferred_request()
  unwind_deferred_cancel()

The difference is that it does not add the task_work to the tracer's
unwind_work structure. Instead, it uses a global bitmask where each
registered tracer gets a bit. That means it can have at most 32 tracers
registered at a time on a 32 bit system, and 64 tracers on a 64 bit
system. Ideally, there should not be more than 10, and that is a lot.

This is also why perf does not use this method, as it would register
a callback for pretty much every event or task or CPU, and that goes
into the hundreds.

But for generic tracers that have a single entity tracing multiple
tasks, this works out well.

When a tracer registers with unwind_deferred_init(), a avaliable bit
in the global mask is assigned to that tracer. If there are no more
bits available, -EBUSY is returned.

When a tracer requests a stacktrace on task exit back to user space,
it is given a cookie that is associated to that stacktrace. The tracer
can save that cookie into its buffer and use it to attach the stacktrace
when it gets back. It's bit is set in the task structures unwind_mask
and when the task returns back to user space, it will iterate all
the tracers that are registered, and if their corresponding bit is
set it will call its callback and clear the bit.

The last patches implement the tracing subsystem to use this for
its global user space stack tracing per event (individual events is
not supported yet). It creates a two new events, where one is to
record the cookie when the stack trace is requested, and the other is
for the user space stacktrace itself.

Since the callback is called in faultable context, it uses this opportunity
to look at the addresses in the stacktrace and convert them to where
they would be in the executable file (if found). It also records
the inode and device major/minor numbers into the trace, so that post
processing can find the exact location where the stacks are.

Josh Poimboeuf (3):
      unwind_user/deferred: Add deferred unwinding interface
      unwind_user/deferred: Make unwind deferral requests NMI-safe
      mm: Add guard for mmap_read_lock

Steven Rostedt (6):
      unwind deferred: Use bitmask to determine which callbacks to call
      tracing: Do not bother getting user space stacktraces for kernel threads
      tracing: Rename __dynamic_array() to __dynamic_field() for ftrace events
      tracing: Implement deferred user space stacktracing
      tracing: Have deferred user space stacktrace show file offsets
      tracing: Show inode and device major:minor in deferred user space stacktrace

----
 include/linux/entry-common.h          |   2 +-
 include/linux/mmap_lock.h             |   2 +
 include/linux/sched.h                 |   1 +
 include/linux/unwind_deferred.h       |  23 ++-
 include/linux/unwind_deferred_types.h |   4 +
 kernel/trace/trace.c                  | 138 +++++++++++++++++
 kernel/trace/trace.h                  |  14 +-
 kernel/trace/trace_entries.h          |  38 ++++-
 kernel/trace/trace_export.c           |  25 +++-
 kernel/trace/trace_output.c           |  99 ++++++++++++
 kernel/unwind/deferred.c              | 275 +++++++++++++++++++++++++++++++++-
 11 files changed, 610 insertions(+), 11 deletions(-)
