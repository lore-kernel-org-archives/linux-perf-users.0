Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D392580F7;
	Fri, 25 Apr 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592974; cv=none; b=pLjJFvV9aHunty05gW1vxbTrUpCB7iDvVWUT/sa2ehbu7Ok+a49IKQO9jXxUGeLxImNx+MpaXc++3Oc1UnLybIQqxhO53M5DnJ4RQd4PAp9RZ9DyqJoNkfS79rd8YeWe/FJHZW3DHI0eyRSyyay6IhrTkbOexny6WTmP5qWhoMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592974; c=relaxed/simple;
	bh=VWUIziZsBbgbfPxgQz2jInW5sIUOCc7T4OH8LmSyIgc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=ZZFVk7F0bbI5hpDndmolvCTVT9z9+WpzGJqFrAHY2d9Lv/j/CF9AqN/RorkMzF0Z4VthTDcw6yyvHATRylK1PO5IZ2BYTbknhJsrS4MjtPD8fkE42P19muTsjmO4AfHqV6nxzRtiucsBFbmfg2UhS7SsUZrOIcXevI9qocjeBIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC65C4CEE8;
	Fri, 25 Apr 2025 14:56:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u8KVH-0000000HSfo-3KTs;
	Fri, 25 Apr 2025 10:58:11 -0400
Message-ID: <20250425145422.132820147@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 25 Apr 2025 10:54:22 -0400
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
Subject: [PATCH v6 00/18] perf: Deferred unwinding of user space stack traces 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

[ With the big Cc list, this will probably get blocked by gmail again :-p ]

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

  0c6ae66ef164c408daeab6a61aace4b86010369a

Changes since v5: https://lore.kernel.org/linux-trace-kernel/20250424162529.686762589@goodmis.org/

- Instead of clearing cache->nr_entries when entering from user, clear it
  when exiting to user mode.

- Change checking if a task is a kernel thread or not from testing
  current->mm == NULL to current->flags & PF_KTHREAD. Also updated
  some other places in perf that did this before this series.

- Fixed whitespace issues

Josh Poimboeuf (12):
      unwind_user: Add user space unwinding API
      unwind_user: Add frame pointer support
      unwind_user/x86: Enable frame pointer unwinding on x86
      perf/x86: Rename and move get_segment_base() and make it global
      unwind_user: Add compat mode frame pointer support
      unwind_user/x86: Enable compat mode frame pointer unwinding on x86
      unwind_user/deferred: Add unwind cache
      perf: Remove get_perf_callchain() init_nr argument
      perf: Have get_perf_callchain() return NULL if crosstask and user are set
      perf: Simplify get_perf_callchain() user logic
      perf: Skip user unwind if the task is a kernel thread.
      perf: Support deferred user callchains

Namhyung Kim (4):
      perf tools: Minimal CALLCHAIN_DEFERRED support
      perf record: Enable defer_callchain for user callchains
      perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
      perf tools: Merge deferred user callchains

Steven Rostedt (2):
      unwind_user/deferred: Add unwind_deferred_trace()
      perf: Use current->flags & PF_KTHREAD instead of current->mm == NULL

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
 kernel/events/core.c                      | 168 +++++++++++++++++++++++++++++-
 kernel/fork.c                             |   4 +
 kernel/unwind/Makefile                    |   1 +
 kernel/unwind/deferred.c                  |  62 +++++++++++
 kernel/unwind/user.c                      | 130 +++++++++++++++++++++++
 tools/include/uapi/linux/perf_event.h     |  19 +++-
 tools/lib/perf/include/perf/event.h       |   7 ++
 tools/perf/Documentation/perf-script.txt  |   5 +
 tools/perf/builtin-script.c               |  92 ++++++++++++++++
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
 44 files changed, 987 insertions(+), 73 deletions(-)
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
