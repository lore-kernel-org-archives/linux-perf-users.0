Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951DD41DDF0;
	Thu, 24 Sep 2026 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233551; cv=none; b=uzd0PKoPoZ74bAEYcfVlBrHSIeDpzM38fY7/yRqp1LGeM7XNeS9x4gzuG3N4uNq/S9lQto4jcKrcNLlcdemnMI+IUtoJcCa16IVLzRvYs7VQKHFDSGiCnB6RVTeWFL4EU9brJK/RinHfZx0ZjPavkuZJ7a8GD7ZiI0LR6GUBEwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233551; c=relaxed/simple;
	bh=ny7yRoqTZu3txm6Y15JB2f35IJQJiFGrkwW1JcDEPW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQaazCvgL85zT+NoS4UaMFPEDUerPwHMq1lMrmvepqkYzxx59CNhvxhjmpk93Fq8NwrEAGO4iFJqZLVtngiGEMb25YgrIv25fkooW+kj22ap0a5/Ov1GwRtTrd9wC8MGC1LEdWNgU7WqtZvIu5nqc4u9IA4Wrmcozzq/+4b+G6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NumiNqXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NumiNqXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6321F000FF;
	Thu, 24 Sep 2026 07:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790233544;
	bh=unO7c5AKFQ6l/ODCAfxidUIx3Us4+HGQywYjc6yeobQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NumiNqXNLkED+EGsexP3G9yFmRjrfSxODCOS2IeJxDN2I2LnDWrIoXBi4lFA8nJZ+
	 GShxpuSTxD/6uQVzm0vxTY/1f/i3Y0dLByDRwxftO/c2rru40oIlh4wnjnssSnR3fU
	 vD0HcihjnRtg7NrNfolsIuz0pvPUYRV2RJbuevFT0v1W84l277nJ9onSqLpBhJVWBQ
	 qYn/s6wEorlhxU7eeO78sBICaLJ6qazkDWOqNNaTuTUJlmFw/fJ3kbkFwYR3rlfD0i
	 be36LxxhNKQnTpjG8t21CvMSqSyTaL7+S7VUbii/iOlUf/ZeExIZoUnKmZxrLW8W7n
	 EmE3N7PGnJVCw==
Date: Thu, 24 Sep 2026 00:05:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, howardchu95@gmail.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v5 00/23] perf trace: Fix BPF filtering and make tracing
 tests non-exclusive
Message-ID: <arTLxu9SXPVf1V7S@z2>
References: <20260918211932.2966061-1-irogers@google.com>
 <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1790145937.git.irogers@google.com>

On Wed, Sep 23, 2026 at 12:13:40AM -0700, Ian Rogers wrote:
> perf trace's BPF augmentation attaches to raw_syscalls:sys_enter and
> raw_syscalls:sys_exit system wide, and used the program return value to
> decide whether a syscall was interesting. Returning 0 from a
> BPF_PROG_TYPE_TRACEPOINT program makes perf_trace_run_bpf_submit() drop
> the event for every listener on that tracepoint, not just for the perf
> trace that installed the program. Any concurrent perf trace, perf record
> or ftrace session watching raw_syscalls therefore lost events, which is
> one of the reasons so many of the perf trace and perf probe shell tests
> had to be marked (exclusive) and run on their own.
> 
> Patches 1 to 6 are independent fixes to the code the rest of the series
> goes on to rework or to rely on.
> 
> Patches 7 to 10 fix how an augmented argument is read back. They skip
> the __data_loc internal tracepoint fields that syscalls:sys_enter_*
> gained in 6.19 for syscalls only, bounds check every read of an
> augmented payload, and stop the ring buffer padding at the end of a
> sample being offered to the beautifiers as one. Patch 8 fixes the
> SIGSEGV Arnaldo hit testing v4.
> 
> Patches 11 to 15 fix perf trace's filtering. They stop the return value
> being used as a filter and do the filtering in BPF maps instead, stop
> the sys_exit program array tail calling a sys_enter augmenter, and
> replace the userspace PERF_RECORD_FORK/PERF_RECORD_EXIT bookkeeping with
> BTF-typed raw tracepoint programs on sched_process_{fork,exit,exec}. A
> task is then registered before its first syscall and evicted in
> do_exit(), rather than whenever userspace next drains the ring buffer.
> 
> Patches 16 to 23 deal with the tests. Several collided with each other
> through global state rather than through perf trace: fixed probe names,
> clear_all_probes() disabling every tracepoint on the system, and perf
> trace's hardcoded "probe:vfs_getname*" wildcard pinning probes belonging
> to other tests. With those scoped to a pid they can drop (exclusive) and
> run in parallel again.
> 
> Patches 1 and 2 fix pre-existing bugs that stand on their own and can be
> applied ahead of the rest. Only patch 9 depends on them.
> 
> Tested on x86_64. The trace and probe tests pass under 'perf test -r3',
> which runs the repeats concurrently. Every patch builds individually,
> and the series also builds with BUILD_BPF_SKEL=0.

Thanks for working on this.

But as I said to Arnaldo too, can you please guide your coding agent to
produce more concise texts?  Sometimes it takes me too long to read the
whole messages and comments and I feel like they are too verbose and
often duplicate.

Thanks,
Namhyung

> 
> Changes since v4:
> - New patch 1 fills in the size in the augmented argument header in the
>   four augmenters that left it unset: sendto, perf_event_open,
>   nanosleep and clock_nanosleep. They all build a payload for a fixed
>   size type, and the beautifiers cast it directly rather than reading
>   the length, so nothing has needed it so far. Patch 9 starts checking
>   it. While there, report a failed bpf_probe_read_user() rather than
>   claiming success for it: the payload length is set to zero and the
>   error recorded in the header, so userspace falls back to printing the
>   raw pointer instead of whatever the per-CPU scratch buffer last held.
> - New patch 2 includes the augmented argument header in nanosleep's
>   payload length. It used sizeof(augmented_args->args) where its three
>   siblings use sizeof(u64) + sizeof(augmented_args->args), so the
>   record was eight bytes short of the struct timespec it carries and
>   tv_nsec was printed half from the ring buffer.
> - Patch 7 only skips the internal tracepoint fields when it is setting
>   up a syscall. syscall_arg_fmt__init_array() is also called for an
>   ordinary tracepoint by evsel__init_tp_arg_scnprintf(), and
>   trace__fprintf_tp_fields() walks that array in lockstep with the
>   field list, so packing the entries shifted every formatter along by
>   one from the field it belongs to. 'perf trace -e
>   sched:sched_process_exec' printed its filename with the pid
>   beautifier. The syscall path indexes the array packed and is
>   unaffected, so the two callers now ask for what each of them needs.
> - New patch 8 bounds checks an augmented argument before reading it.
>   This is the SIGSEGV Arnaldo reported on v4. The check
>   btf_struct_scnprintf() already had is lifted into a shared
>   syscall_arg__augmented_args_valid() in beauty.h and used at every
>   site that reads an augmented payload, in particular
>   syscall_arg__scnprintf_buf(), which looped to a length taken from the
>   payload with nothing bounding it and walked off the end of the 8K
>   argbuf in bss.
> - New patch 9 bounds the beautifiers that read a fixed size type out of
>   a payload that may be shorter than it. perf_event_attr__fprintf()
>   always reads a whole struct perf_event_attr, so the payload is copied
>   into a zero padded local rather than read in place, and the AF_LOCAL
>   socket address is printed with a length from the payload rather than
>   as a string it need not be. Split out from patch 8 so the crash fix
>   stays minimal.
> - New patch 10 recognises the padding at the end of a sample for what
>   it is. perf_sample_save_raw_data() rounds the raw size up to eight
>   bytes and __output_skip() advances over the padding rather than
>   zeroing it, so a 64 byte struct syscall_enter_args comes back as 68
>   bytes and userspace took the four stale bytes for an augmented
>   argument. A trailing run shorter than a struct augmented_arg cannot
>   be one.
> - Patch 13 notes that a descendant added to pids_filtered by
>   sched_process_fork() can still have a sys_exit printed without a
>   matching enter. The raw_syscalls:sys_exit evsel is still in the
>   evlist and its tracepoint filter is set once, so it never learns of
>   the descendants, and a tracepoint program can only suppress an event
>   by vetoing it, which is what this series removes. It needs
>   --filter-pids naming a process that then forks. Routing sys_exit
>   through __augmented_syscalls__ the way sys_enter now is would close
>   it.
> - Patch 14 notes that a thread the target creates during the attach
>   window is still missed by 'perf trace -t'. The re-enumeration reads
>   /proc/<tid>/task/<tid>/children, which lists forked processes, and
>   copy_process() makes a CLONE_THREAD child a sibling of its creator
>   rather than a child of it. /proc does not record which task in a
>   group created which, so such a sibling cannot be told apart from one
>   -t was deliberately pointed away from.
> 
> Changes since v3:
> - New patch 3 returns -ENOMEM rather than -1 from evsel__set_filter(),
>   evsel__append_filter(), evlist__set_tp_filter() and
>   evlist__append_tp_filter(). An allocation is the only thing that can
>   fail in any of them, and patch 7 goes on to print what they return,
>   where -1 negated is EPERM and a failure to allocate would have been
>   reported as "Operation not permitted".
> - Patch 5 sets sc->args only once the arg_fmt array that is indexed
>   alongside it has been allocated. Publishing the field first left a
>   syscall with args set and arg_fmt NULL, and since sc->name is already
>   set by then a later syscall__read_info() returns success without
>   retrying the allocation, leaving syscall_arg_fmt__mask_val() to
>   dereference NULL.
> - Patch 7 adds the raw_syscalls tracepoints in trace__run() only if
>   they are not in the evlist already, and stops ignoring the result of
>   trace__add_syscall_newtp(). cmd_trace() adds them before it creates
>   the bpf-output event, and on the paths where that creation fails they
>   were added a second time, giving the session two enter and two exit
>   evsels for the same pair of tracepoints.
> - Patch 7 no longer abandons the session when a target does not fit in
>   the pid map. bpf_map__update_elem() answers -E2BIG once max_entries
>   keys are present, so a target with more threads than the map has room
>   for took perf trace down with it, on exactly the large workloads
>   where there is least else to reach for. The tasks that fit are added
>   and a warning says how many did not.
> - Patch 9 includes <sys/types.h> for the pid_t it uses rather than
>   relying on the include chain to drag it in.
> - Patch 9 no longer ends the session when the target has already
>   exited. thread_map__new_by_pid() fails with ENOENT once
>   /proc/<pid>/task is gone, which is the ordinary outcome of
>   'perf trace -p' on a short lived process, so only ENOMEM is now
>   propagated and everything else is logged and stepped over.
> - Patch 9 reads /proc once per thread group instead of once per thread.
>   'perf trace -p' names every thread of the target in the thread map
>   and /proc/<tid>/task lists the whole group whichever thread it is
>   asked through, so the enumeration was quadratic in the number of
>   threads. On a 64 thread target it went from 65 directory reads and
>   4097 entries to 2 and 65, for the same set of pids.
> - New patch 10 removes from the BPF maps the tasks that died before
>   userspace got round to writing them there. sched_process_exit() can
>   only delete a pid that is already in the map, so a target that exits
>   during startup leaves an entry behind for the rest of the session,
>   and since pids are reused an unrelated task then gets traced, or
>   silently filtered out, in its place. The map is walked with the
>   cursor left on a task found alive, which is one the walk has decided
>   to keep, so its own deletions can never leave the cursor on a key
>   that htab_map_get_next_key() will answer by starting the walk over.
> 
> Changes since v2:
> - Rebased onto the current perf-tools-next.
> - Patch 1 also includes <assert.h>, for the assert() in
>   augmented_syscalls__create_bpf_output().
> - New patch 2 makes evsel__put_and_free_priv() free the whole
>   evsel_trace. It only zfree()d the struct, leaking the syscall_arg_fmt
>   array hanging off it. No caller can reach that today, but patch 6
>   adds one that discards a fully set up evsel.
> - Patch 6 identifies the evsel to drop from the evlist by comparing
>   against trace.syscalls.events.sys_enter instead of a strstr() for
>   "syscalls:sys_enter". That substring also matches the per syscall
>   syscalls:sys_enter_SYSCALL tracepoints, so a user asking for one of
>   those by name would have had it removed from the evlist, and
>   __augmented_syscalls__ described with its tracefs format rather than
>   the raw tracepoint's.
> - Patch 6 reports a failure to program the pid filters with the error
>   that caused it. trace__run() sent everything trace__set_filter_pids()
>   returned to out_error_mem, which prints "Not enough memory to run!".
>   That was already a guess, and a wrong one now the function writes BPF
>   maps too.
> - Patch 7 moves the pid across in sched_process_exec() by deleting the
>   old key before inserting the new one. The move is only a rename, but
>   holding both keys at once needs a spare slot, and on a full map the
>   insert failed with -E2BIG while the delete still succeeded, losing
>   the task instead of moving it.
> - Patch 7 no longer claims that a task forked during the attach window
>   is still traced unaugmented. That was wrong: cmd_trace() removes the
>   sys_enter evsel once the bpf-output event exists, so
>   __augmented_syscalls__ is the only source of enter events and such a
>   task is not reported at all. Describe what is really lost, why the
>   tgid fallback is not kept as a safety net for it, note that only
>   'perf trace -p' is exposed, and that closing it needs the target's
>   descendants re-enumerated from /proc after the attach.
> - Patch 7 drops the parent tgid test from sched_process_fork(), so a
>   child inherits from the pid of the thread that called clone() and
>   from nothing else. The lookups only ever match a task's own pid, and
>   every thread of a -p target is enumerated from /proc/<pid>/task and
>   inserted in its own right, so the tgid added no reach. What it did
>   add was a child inheriting from a thread that is not traced itself,
>   such as a sibling of the thread 'perf trace -t' selected.
> - Patch 7 ends the session with the error that caused it when the BPF
>   programs cannot be attached, rather than printing a bare errno left
>   over from unwinding the attach. There is nothing to fall back to at
>   that point, cmd_trace() has already built the evlist around
>   __augmented_syscalls__ and dropped the sys_enter evsel, and the code
>   being replaced did not fall back either: it ignored the result of
>   augmented_raw_syscalls_bpf__attach() altogether.
> - New patch 8 reads the target out of /proc again once the BPF programs
>   are attached, so a task the target created while perf trace was
>   starting up is traced rather than missed for the whole session. This
>   is the gap patch 7 describes and left for later. It covers the
>   target's new threads and, through task->children, anything it or they
>   forked, to any depth. What is left is a task that made syscalls
>   between sys_enter going live and being added to the map, which is
>   momentary rather than lasting for the session.
> - Patch 9 bails out if mktemp fails rather than carrying on with an
>   empty $tmpdir. cd rejects the null directory, and the rmdir that was
>   meant to undo the mktemp then failed to remove '' instead. Its
>   cleanup() also no longer exits when it cannot cd out of the temporary
>   directory, which would have skipped removing it. The removal takes an
>   absolute path and does not need the cd to have succeeded.
> - Patch 10 now narrows the disable in clear_all_probes() to the probes
>   themselves rather than dropping it. Clearing kprobe_events or
>   uprobe_events is all or nothing: dyn_events_release_all() returns
>   -EBUSY without removing anything if it finds a probe that is still
>   enabled, so simply removing the write could leave stale probes behind
>   to collide with the next run. The set to disable is read from the
>   kprobe_events and uprobe_events listings rather than assumed to be
>   the groups perf uses, since a probe left enabled in another group,
>   such as the default kprobes group used when kprobe_events is written
>   directly, would abort the clear just the same.
> - Patch 11 deletes the probes from an exit trap as well as on the way
>   out. A pid scoped name is never seen again, so a run interrupted
>   before cleanup_probe_vfs_getname() left its probes behind for good,
>   a set per run, where the fixed name was at least found and reused by
>   the next run.
> - Patch 12 retries deleting the uprobe. Deletion writes uprobe_events
>   just as addition does and can lose the same race with a concurrent
>   test, and because the event name is now pid scoped a probe left
>   behind is never overwritten by a later run. It also bails out if
>   mktemp fails and quotes the path in the emptiness check, which
>   unquoted would have tested the string "-s" and reported success.
> - Patch 13 prints the tail of the output rather than the head. The
>   pattern it matches only appears in the summary, which is printed
>   after any trace output, so the head of the file is not the part that
>   failed to match.
> 
> Changes since v1:
> - New patch 1 includes <sys/types.h> and <string.h> for the pid_t and
>   strcmp() uses that were relying on the include chain happening to
>   drag them in, which does not hold on libcs such as musl.
> - Patch 6 no longer returns success when the event qualifier filter
>   string fails to allocate. err now defaults to 0 because either
>   tracepoint may legitimately be absent, so the ENOMEM path has to set
>   the error itself rather than rely on that default. It also includes
>   <stdbool.h> for the bool parameters it adds to trace_augment.h.
> - Patch 9 removes the temporary directory if the cd into it fails.
>   That happens before the cleanup trap is installed, so the directory
>   would otherwise be left behind in /tmp.
> 
> Ian Rogers (23):
>   perf trace: Set the augmented arg header in the augmenters that omit
>     it
>   perf trace: Include the augmented arg header in nanosleep's payload
>     length
>   perf trace: Include the headers declaring pid_t, strcmp and assert
>   perf trace: Free the whole evsel_trace in evsel__put_and_free_priv
>   perf evsel: Report an allocation failure as ENOMEM when setting
>     filters
>   perf trace: Start BPF summary before starting workload
>   perf trace: Skip internal tracepoint fields in formatting and beauty
>     map
>   perf trace: Bounds check augmented arguments before reading them
>   perf trace: Bound the fixed size augmented argument beautifiers
>   perf trace: Do not read sample padding as an augmented argument
>   perf trace: Do not set unaugmented BPF program on sys_exit map
>   perf trace: Filter events in BPF and avoid tracepoint vetoes
>   perf trace: Handle fork and exit directly in BPF filter maps
>   perf trace: Enumerate the target again once BPF is attached
>   perf trace: Drop targets that died before they were filtered
>   perf test test_task_analyzer: Isolate in temporary directory and make
>     non-exclusive
>   perf test common: Only disable probes in clear_all_probes
>   perf test probe_vfs_getname: Scope probe name to PID and make
>     non-exclusive
>   perf test record+probe_libc_inet_pton: Scope event to PID, add
>     retries, and make non-exclusive
>   perf test trace_summary: Improve error diagnostics
>   perf test trace_btf_general: Drop --max-events=1 and make
>     non-exclusive
>   perf test trace_summary: Make non-exclusive
>   perf test uprobe_from_different_cu: Scope probe name to PID
> 
>  tools/perf/Documentation/perf-trace.txt       |   5 +
>  tools/perf/builtin-trace.c                    | 863 +++++++++++++++---
>  tools/perf/tests/shell/common/init.sh         |  33 +-
>  .../perf/tests/shell/lib/probe_vfs_getname.sh |  51 +-
>  tools/perf/tests/shell/probe_vfs_getname.sh   |   3 +-
>  .../shell/record+probe_libc_inet_pton.sh      | 107 ++-
>  .../shell/record+script_probe_vfs_getname.sh  |  18 +-
>  tools/perf/tests/shell/test_task_analyzer.sh  |  20 +-
>  .../shell/test_uprobe_from_different_cu.sh    |  11 +-
>  .../tests/shell/trace+probe_vfs_getname.sh    |   9 +
>  tools/perf/tests/shell/trace_btf_general.sh   |   8 +-
>  tools/perf/tests/shell/trace_summary.sh       |  16 +-
>  tools/perf/trace/beauty/beauty.h              |  43 +
>  tools/perf/trace/beauty/perf_event_open.c     |  38 +-
>  tools/perf/trace/beauty/sockaddr.c            |  55 +-
>  tools/perf/trace/beauty/timespec.c            |   2 +-
>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 407 ++++++++-
>  tools/perf/util/bpf_trace_augment.c           | 288 +++++-
>  tools/perf/util/evlist.c                      |  12 +-
>  tools/perf/util/evsel.c                       |   4 +-
>  tools/perf/util/trace_augment.h               |  33 +-
>  21 files changed, 1801 insertions(+), 225 deletions(-)
> 
> 
> base-commit: 9db4e9d6cc7c7d318fb6d6bb73abe3fed27385a8
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
