Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADF236F901
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740433; cv=none; b=QFDhaA/UxoCpqoROXVbOxWkm/Blf9YgGGLbOUOaW+K6HaM4d+Q9nvgFUellDZrHsbi2JWPnEvYBfZ233XypJ/flBFMMaFx594qAIMzX+H8VxZfMlj328nFgnhbtcgyL5EPGm4J67zPhOT6Elok0NW5F1z6HDeR4o/m7DVC50KyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740433; c=relaxed/simple;
	bh=w5cWUGPVMJuQvQ/cGprtxg+JPLGX/F6iebYNWhoCWFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U7ZyLAdTRItqQ4zYkdBfcF+j0T8x9Sxv+ygcuk8WEx2KJ73qytqIIuxfZtYC4R/IBEe6c6UqXcO6AIPmYorh1NIkUHAOTPOhTDWWb+yWOkplmQQea/lD1LojV2SrO7wzTjTiKfdbROCPdsRVPMNhJlE3IKNTU/mqIjVYFmAHa1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INYF6CB1; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INYF6CB1"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d9336581a2so15064125ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789740431; x=1790345231; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ir1/YgDnxXsqAYc9f8EvJKyGqMi5T/DFjD9aFKSS1hk=;
        b=INYF6CB1hNlQt85zqOFtAULU+cbbbpAXweFQfCn0HgCe68/1J4vPWPvHEwUmLvi8yQ
         avdtDe/WpOYaVELQxVdISVCwaaeQ7nlyPX3/yK6qcub9M9Q25DtexE3B7JqXQT840GpH
         jjyOIA672nr9No1AzoXmPeF9U/uaj0W8WSE+9pMDQdceQNJcXuEUy4Q/zhSLyBdCR7ck
         c7hibGxwQQbkWhN/h9x2iBss5KYme5Y1flFPAGvCDwcUhItpbKVlqxdFc5Ba4tWqb+AJ
         s7rtR4ukSy0dnoCXoAgP8IsOKeotCLsWza4SWS1ueL0sbUViwkCz3LnzuJN27A5r7m18
         X4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740431; x=1790345231;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ir1/YgDnxXsqAYc9f8EvJKyGqMi5T/DFjD9aFKSS1hk=;
        b=aCTkh7NAlX51O1f7PhOTlhUJSJ3oOmXbZgZFtpjj/Txf1FdodAOTQY48kvBo+503kN
         dPsFNUZUr3TGUePB2BU3/0Yvgzg+e9lAnJcMuI4pKvuOuut5jGBERch8K9xDuPhKoJVM
         3HS+zQRiJbt3E3/FYbFUv+J5FkJwArQdtTXMCVDGzZ5Nd3IZHI2eh8iMelYbxVTl4Ytm
         N2z6slGnNBU0i0vpWfVHozs7PXOAiin7h1Z7uXl9b/PueY9eabckJslCdw3ADLByU2TL
         bE+zlgrI91R/vtLMxyqM1R8NAmUFVcqA/HRj62LQ8Pg87UHXOxwlULm/2RHBCOpqMeAw
         VyXg==
X-Forwarded-Encrypted: i=1; AKwUvBwOTBRlAZUZkb6XA2WFUfhSZ+SY+1dHQlqPNG8DTu08N1K5hDHjWqiar1AuPPj6JmrgnECO8LbdA+GaSiDnWz8f@vger.kernel.org
X-Gm-Message-State: AFuF++k12syzfDAIRaEvDfMmhzSrmjGqHSIohlbQgN1ulrmmKV3EGGU/
	9dLhqQC5ywiDceR3x5GjK1uwLNhJ9oydD4b709KUkBy6o7NSZ0TDfzMqORlFi+EWCuyW1KEU6AU
	nI8i3FvoNcA==
X-Received: from dlbut1.prod.google.com ([2002:a05:7022:7e01:b0:144:ce33:3556])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ac1:b0:39e:6a80:b79c
 with SMTP id 98e67ed59e1d1-39e6a80b8bcmr35842a91.44.1789740430514; Fri, 18
 Sep 2026 07:07:10 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:06:43 -0700
In-Reply-To: <cover.1789662556.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918140659.2501976-1-irogers@google.com>
Subject: [PATCH v3 00/16] perf trace: Fix BPF filtering and make tracing tests non-exclusive
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

perf trace's BPF augmentation attaches to raw_syscalls:sys_enter and
raw_syscalls:sys_exit system wide, and used the program return value to
decide whether a syscall was interesting. Returning 0 from a
BPF_PROG_TYPE_TRACEPOINT program makes perf_trace_run_bpf_submit() drop
the event for every listener on that tracepoint, not just for the perf
trace that installed the program. Any concurrent perf trace, perf record
or ftrace session watching raw_syscalls therefore lost events, which is
one of the reasons so many of the perf trace and perf probe shell tests
had to be marked (exclusive) and run on their own.

Patches 1 and 2 are independent fixes to the files the rest of the
series goes on to rework.

Patches 3 to 8 fix perf trace. They stop the return value being used as
a filter and do the filtering in BPF maps instead, fix argument handling
for the __data_loc internal tracepoint fields that syscalls:sys_enter_*
gained in 6.19, stop the sys_exit program array tail calling a sys_enter
augmenter, and replace the userspace PERF_RECORD_FORK/PERF_RECORD_EXIT
bookkeeping with BTF-typed raw tracepoint programs on
sched_process_{fork,exit,exec}. A task is then registered before its
first syscall and evicted in do_exit(), rather than whenever userspace
next drains the ring buffer.

Patches 9 to 16 deal with the tests. Several collided with each other
through global state rather than through perf trace: fixed probe names,
clear_all_probes() disabling every tracepoint on the system, and perf
trace's hardcoded "probe:vfs_getname*" wildcard pinning probes belonging
to other tests. With those scoped to a pid they can drop (exclusive) and
run in parallel again.

Tested on x86_64. The trace and probe tests pass under 'perf test -r3',
which runs the repeats concurrently. Every patch builds individually,
and the series also builds with BUILD_BPF_SKEL=0.

Changes since v2:
- Rebased onto the current perf-tools-next.
- Patch 1 also includes <assert.h>, for the assert() in
  augmented_syscalls__create_bpf_output().
- New patch 2 makes evsel__put_and_free_priv() free the whole
  evsel_trace. It only zfree()d the struct, leaking the syscall_arg_fmt
  array hanging off it. No caller can reach that today, but patch 6
  adds one that discards a fully set up evsel.
- Patch 6 identifies the evsel to drop from the evlist by comparing
  against trace.syscalls.events.sys_enter instead of a strstr() for
  "syscalls:sys_enter". That substring also matches the per syscall
  syscalls:sys_enter_SYSCALL tracepoints, so a user asking for one of
  those by name would have had it removed from the evlist, and
  __augmented_syscalls__ described with its tracefs format rather than
  the raw tracepoint's.
- Patch 6 reports a failure to program the pid filters with the error
  that caused it. trace__run() sent everything trace__set_filter_pids()
  returned to out_error_mem, which prints "Not enough memory to run!".
  That was already a guess, and a wrong one now the function writes BPF
  maps too: the update fails with -E2BIG when the target has more
  threads than pids_to_trace has room for.
- Patch 6 reports a failure to program the syscall filters the same way.
  The pr_err() in trace__set_ev_qualifier_filter() ran before trace__run()
  printed "%m" at out_errno, and anything called in between could have
  changed errno by then, so the two did not have to agree. The inner
  report is now a pr_debug() and the caller prints the error it was
  given, which leaves out_errno without a user.
- Patch 7 moves the pid across in sched_process_exec() by deleting the
  old key before inserting the new one. The move is only a rename, but
  holding both keys at once needs a spare slot, and on a full map the
  insert failed with -E2BIG while the delete still succeeded, losing
  the task instead of moving it.
- Patch 7 no longer claims that a task forked during the attach window
  is still traced unaugmented. That was wrong: cmd_trace() removes the
  sys_enter evsel once the bpf-output event exists, so
  __augmented_syscalls__ is the only source of enter events and such a
  task is not reported at all. Describe what is really lost, why the
  tgid fallback is not kept as a safety net for it, note that only
  'perf trace -p' is exposed, and that closing it needs the target's
  descendants re-enumerated from /proc after the attach.
- Patch 7 drops the parent tgid test from sched_process_fork(), so a
  child inherits from the pid of the thread that called clone() and
  from nothing else. The lookups only ever match a task's own pid, and
  every thread of a -p target is enumerated from /proc/<pid>/task and
  inserted in its own right, so the tgid added no reach. What it did
  add was a child inheriting from a thread that is not traced itself,
  such as a sibling of the thread 'perf trace -t' selected.
- Patch 7 ends the session with the error that caused it when the BPF
  programs cannot be attached, rather than printing a bare errno left
  over from unwinding the attach. There is nothing to fall back to at
  that point, cmd_trace() has already built the evlist around
  __augmented_syscalls__ and dropped the sys_enter evsel, and the code
  being replaced did not fall back either: it ignored the result of
  augmented_raw_syscalls_bpf__attach() altogether.
- New patch 8 reads the target out of /proc again once the BPF programs
  are attached, so a task the target created while perf trace was
  starting up is traced rather than missed for the whole session. This
  is the gap patch 7 describes and left for later. It covers the
  target's new threads and, through task->children, anything it or they
  forked, to any depth. What is left is a task that made syscalls
  between sys_enter going live and being added to the map, which is
  momentary rather than lasting for the session.
- Patch 9 bails out if mktemp fails rather than carrying on with an
  empty $tmpdir. cd rejects the null directory, and the rmdir that was
  meant to undo the mktemp then failed to remove '' instead. Its
  cleanup() also no longer exits when it cannot cd out of the temporary
  directory, which would have skipped removing it. The removal takes an
  absolute path and does not need the cd to have succeeded.
- Patch 10 now narrows the disable in clear_all_probes() to the probes
  themselves rather than dropping it. Clearing kprobe_events or
  uprobe_events is all or nothing: dyn_events_release_all() returns
  -EBUSY without removing anything if it finds a probe that is still
  enabled, so simply removing the write could leave stale probes behind
  to collide with the next run. The set to disable is read from the
  kprobe_events and uprobe_events listings rather than assumed to be
  the groups perf uses, since a probe left enabled in another group,
  such as the default kprobes group used when kprobe_events is written
  directly, would abort the clear just the same.
- Patch 11 deletes the probes from an exit trap as well as on the way
  out. A pid scoped name is never seen again, so a run interrupted
  before cleanup_probe_vfs_getname() left its probes behind for good,
  a set per run, where the fixed name was at least found and reused by
  the next run.
- Patch 12 retries deleting the uprobe. Deletion writes uprobe_events
  just as addition does and can lose the same race with a concurrent
  test, and because the event name is now pid scoped a probe left
  behind is never overwritten by a later run. It also bails out if
  mktemp fails and quotes the path in the emptiness check, which
  unquoted would have tested the string "-s" and reported success.
- Patch 13 prints the tail of the output rather than the head. The
  pattern it matches only appears in the summary, which is printed
  after any trace output, so the head of the file is not the part that
  failed to match.

Changes since v1:
- New patch 1 includes <sys/types.h> and <string.h> for the pid_t and
  strcmp() uses that were relying on the include chain happening to
  drag them in, which does not hold on libcs such as musl.
- Patch 6 no longer returns success when the event qualifier filter
  string fails to allocate. err now defaults to 0 because either
  tracepoint may legitimately be absent, so the ENOMEM path has to set
  the error itself rather than rely on that default. It also includes
  <stdbool.h> for the bool parameters it adds to trace_augment.h.
- Patch 9 removes the temporary directory if the cd into it fails.
  That happens before the cleanup trap is installed, so the directory
  would otherwise be left behind in /tmp.

Ian Rogers (16):
  perf trace: Include the headers declaring pid_t, strcmp and assert
  perf trace: Free the whole evsel_trace in evsel__put_and_free_priv
  perf trace: Start BPF summary before starting workload
  perf trace: Skip internal tracepoint fields in formatting and beauty
    map
  perf trace: Do not set unaugmented BPF program on sys_exit map
  perf trace: Filter events in BPF and avoid tracepoint vetoes
  perf trace: Handle fork and exit directly in BPF filter maps
  perf trace: Enumerate the target again once BPF is attached
  perf test test_task_analyzer: Isolate in temporary directory and make
    non-exclusive
  perf test common: Only disable probes in clear_all_probes
  perf test probe_vfs_getname: Scope probe name to PID and make
    non-exclusive
  perf test record+probe_libc_inet_pton: Scope event to PID, add
    retries, and make non-exclusive
  perf test trace_summary: Improve error diagnostics
  perf test trace_btf_general: Drop --max-events=1 and make
    non-exclusive
  perf test trace_summary: Make non-exclusive
  perf test uprobe_from_different_cu: Scope probe name to PID

 tools/perf/Documentation/perf-trace.txt       |   5 +
 tools/perf/builtin-trace.c                    | 637 +++++++++++++++---
 tools/perf/tests/shell/common/init.sh         |  33 +-
 .../perf/tests/shell/lib/probe_vfs_getname.sh |  51 +-
 tools/perf/tests/shell/probe_vfs_getname.sh   |   3 +-
 .../shell/record+probe_libc_inet_pton.sh      | 107 ++-
 .../shell/record+script_probe_vfs_getname.sh  |  18 +-
 tools/perf/tests/shell/test_task_analyzer.sh  |  20 +-
 .../shell/test_uprobe_from_different_cu.sh    |  11 +-
 .../tests/shell/trace+probe_vfs_getname.sh    |   9 +
 tools/perf/tests/shell/trace_btf_general.sh   |   8 +-
 tools/perf/tests/shell/trace_summary.sh       |  16 +-
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 312 ++++++++-
 tools/perf/util/bpf_trace_augment.c           | 175 ++++-
 tools/perf/util/trace_augment.h               |  27 +-
 15 files changed, 1281 insertions(+), 151 deletions(-)


base-commit: 86a27811675a415bd351efca1a194a1a94c082dd
-- 
2.55.0.1082.g2b9226bbc0-goog

