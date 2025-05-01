Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B6B1F1527;
	Thu,  1 May 2025 01:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746063301; cv=none; b=g77NBzv+kzBado0rNtYuE8lX38nhGyfhfv2xc0DjHCLpffodDdhaHGzON5Zl5GYK0kfiWqzqt0xdaurIqr8VhqQNPEz8nmJUzKq4/RiPC4vrJ8CPPko69pX997ycZBhL77eaQnxxim43OuPZmFVE0c7hggr+k3OvRB5eDocV/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746063301; c=relaxed/simple;
	bh=Agkv3OGBG77qIC3WcKk7FTT3q4BDqxYanUlFlICbwOg=;
	h=Message-ID:Date:From:To:Cc:Subject; b=ZfuzK1ok7uW5PFfgp6k73BARPe4+qZkSNn7ETH+8Sq1l44o1pgcu6wNGdYukES9TtVd2N8oT74IRRPl+htpmPTlvKi2Y5NWgr3hn4HtYgqB1EH1nF4aBp2s9pXh1tzbXY3naVnw/qyXI57deiwvmwqjCAE4ApxaN2OVTMfyl5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5731DC4CEEB;
	Thu,  1 May 2025 01:35:01 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAIpO-00000001okg-0Cca;
	Wed, 30 Apr 2025 21:35:06 -0400
Message-ID: <20250501013202.997535180@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 30 Apr 2025 21:32:02 -0400
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
Subject: [PATCH v6 0/5] perf: Deferred unwinding of user space stack traces for per CPU events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

This is v6 of:

  https://lore.kernel.org/linux-trace-kernel/20250424192456.851953422@goodmis.org/

But this only adds the unwind deferred interface and not the ftrace code
so that perf can use it.

This series is based on top of:

 https://lore.kernel.org/linux-trace-kernel/20250430195746.827125963@goodmis.org/

The above patch series adds deferred unwinding for task events, but not
for per CPU events. This is because the event is only tracing a single task
and can use a task_work to trigger its own callbacks. But per CPU events do
not have that luxury. A single per CPU event can request a deferred user
space stacktrace for several tasks before receiving any of the deferred
stacktraces.

To solve this, per CPU events will use the extended interface of the
deferred unwinder that ftrace will use. This includes the new API of:

  unwind_deferred_init()
  unwind_deferred_request()
  unwind_deferred_cancel()


What perf now does is:

When a new per CPU event is created, it searches a global list of
descriptors that map to the group_leader of tasks that create these events.
The PID of group_leader of current is used to find this descriptor.
If one is found, the event is simply added to it. If one is not found, then
it will create the descriptor.

This descriptor has an array the size of possible CPUs and holds per CPU
descriptors. Each of these CPU descriptors has a linked list that would
holds the CPU events that were created and want deferred unwinding.

The group_leader descriptor has a unwind_work descriptor that it registers
with the unwind deferred infrastructure with unwind_deferred_init().
Each event within this descriptor has a pointer to this descriptor.
When a request is made from interrupt context to have a deferred unwind
happen, it calls unwind_deferred_request() passing it the group_leader
descriptor.

When the task returns back to user space, it will call the callback
associated with the group_leader descriptor, and that callback will pass the
user space stacktrace to the event attached to the CPU from its CPU array.

When these events are freed, they are removed from this descriptor, and
when the last event is removed, the descriptor is freed.

I've tested this, and this appears to work fine. All the associated events
that the perf tool creates are associated via this descriptor. At least it
doesn't overflow the max number of unwind works that can be attached to the
unwind deferred infrastructure.

This is based on v5 of the unwind code mentioned above. Changes since
then include:

- Have unwind_deferred_request() return positive if already queued

- Check (current->flags & PF_KTHREAD | PF_EXITING) in
  unwind_deferred_request(), as the task_work will fail to be added in the
  exit code.

- Have unwind_deferred_request() return positive if already queued.

- Use SRCU to protect the list of callbacks when a task returns instead of
  using a global mutex. (Mathieu Desnoyers)

- Does not include ftrace update

- Includes perf per CPU events using this infrastructure


Josh Poimboeuf (2):
      unwind_user/deferred: Add deferred unwinding interface
      unwind_user/deferred: Make unwind deferral requests NMI-safe

Steven Rostedt (3):
      unwind deferred: Use bitmask to determine which callbacks to call
      unwind deferred: Use SRCU unwind_deferred_task_work()
      perf: Support deferred user callchains for per CPU events

----
 include/linux/perf_event.h            |   5 +
 include/linux/sched.h                 |   1 +
 include/linux/unwind_deferred.h       |  19 +++
 include/linux/unwind_deferred_types.h |   4 +
 kernel/events/core.c                  | 226 +++++++++++++++++++++++---
 kernel/unwind/deferred.c              | 290 +++++++++++++++++++++++++++++++++-
 6 files changed, 519 insertions(+), 26 deletions(-)
