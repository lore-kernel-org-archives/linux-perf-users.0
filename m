Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049A118BBAE;
	Wed, 17 Sep 2025 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112670; cv=none; b=KfrbSBzLuGgYFVR4iZ66eJW6bbQ+UMVZdGHhdC+I3IBsDiePOoGDijYctZEhQKnx5pPxlNYjHIG5m4fU4Q/BBhlSqS4jFbITF7Ay48mHmP3vfWPL6zoffTUI6S00y4DKX4+5apgx2Sk3ZG+fRLpuF4+9qFtlcocgo/4Ib8UF7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112670; c=relaxed/simple;
	bh=KmE6GFJA9XfhK+PXLx0nlAJebkPR9q5xDm8AcowCOQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGRuW4Kt9pB2RvJo+vCXqXcyre4CKaXWEWp2iZ1EkY13lSNHHv9kClPSQe6XTOiNDfrWPuXsK21USYkbq4ahVPlY344jti8EKnxHejOMe13iizI5UdyAv5JhuMJiFylshw2bwTezB8XCXRy3Y0LA9JLlp+iwEGXKAu8p3gpPSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhyHl4V5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhyHl4V5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B673C4CEF0;
	Wed, 17 Sep 2025 12:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758112669;
	bh=KmE6GFJA9XfhK+PXLx0nlAJebkPR9q5xDm8AcowCOQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RhyHl4V5kJ2LdJKzcEBOz7Wkwc9LVirxwz4tp5A1yiYfBGlY46LjoCkFAJ4IAkzUi
	 p/jloLsW//HzEuIsFBgfidqKV9NnM4glvediAVJ6v3H8dHwn35EQccl4XSluHEw/+y
	 CXMP5opyDF63z2J+fgPShI3XrZFByyazRYZG8qVJi+hrdP3B3TKm/bTNiPRXI1AHJP
	 qtGL4ckNON+dG9sBZnzPPsMY+Ha/dqz5yYYjMmiwSpO5+FA667rP+BfeZqko11QiFA
	 pEe/JvFXqKkJxAy9nHbwOoibAsDL86DzA8Cqp/p0F57riluMCU8fpba7cRLruNkFUa
	 oQcKvEfAYNxog==
Date: Wed, 17 Sep 2025 09:37:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Gautam Menghani <gautam@linux.ibm.com>, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	maddy@linux.ibm.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf python: Add an example for sampling
Message-ID: <aMqrmmDG65BGeZp0@x1>
References: <20250728055937.58531-1-gautam@linux.ibm.com>
 <aMlmiHATn5WHUcSM@mac.in.ibm.com>
 <aMm5uvPsMfXEv8Oo@x1>
 <CAP-5=fW4JQYJ2NCRsRVePidCcZ9+JcQbfY=xQ00xZG-bSn96ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW4JQYJ2NCRsRVePidCcZ9+JcQbfY=xQ00xZG-bSn96ew@mail.gmail.com>

On Tue, Sep 16, 2025 at 01:07:43PM -0700, Ian Rogers wrote:
> On Tue, Sep 16, 2025 at 12:25 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Tue, Sep 16, 2025 at 07:00:48PM +0530, Gautam Menghani wrote:
> > > Hi Ian/Arnaldo,
> > >
> > > Can you please review this series and let me know if any changes are
> > > needed?
> >
> > Looking at it now, sry for the delay,
> 
> I think the patches look good. I'm a little concerned that the python
> APIs are a chance to do something better than the C APIs that have
> evolved. For example, we removed UID out of target recently [1] as the
> BPF alternative was better. Had this patch come earlier then it seems
> likely we'd have had target with UIDs. I wonder rather than having a
> kwlist of:
> 
> + static char *kwlist[] = { "target", "inherit_stat", "no_buffering",
> "no_inherit",
> + "no_inherit_set", "no_samples", "raw_samples",
> + "sample_address", "sample_phys_addr", "sample_data_page_size",
> + "sample_code_page_size", "sample_weight", "sample_time",
> + "sample_time_set", "sample_cpu", "sample_identifier",
> + "sample_data_src", "period", "period_set", "running_time",
> + "full_auxtrace", "auxtrace_snapshot_mode",
> + "auxtrace_snapshot_on_exit", "auxtrace_sample_mode",
> + "record_namespaces", "record_cgroup", "record_switch_events",
> + "record_switch_events_set", "all_kernel", "all_user",
> + "kernel_callchains", "user_callchains", "tail_synthesize",
> + "overwrite", "ignore_missing_thread", "strict_freq", "sample_id",
> + "no_bpf_event", "kcore", "text_poke", "build_id", "freq",
> + "mmap_pages", "auxtrace_mmap_pages", "user_freq", "branch_stack",
> + "sample_intr_regs", "sample_user_regs", "default_interval",
> + "user_interval", "auxtrace_snapshot_size", "auxtrace_snapshot_opts",
> + "auxtrace_sample_opts", "sample_transaction", "use_clockid",
> + "clockid", "clockid_res_ns", "nr_cblocks", "affinity", "mmap_flush",
> + "comp_level", "nr_threads_synthesize", "ctl_fd", "ctl_fd_ack",
> + "ctl_fd_close", "synth", "threads_spec", "threads_user_spec",
> + "off_cpu_thresh_ns",  NULL };
> 
> but then just using this subset:
> 
> +    opts = perf.record_opts(freq=1000, target=tgt, sample_time=True,
> +                            sample_cpu=True, no_buffering=True,
> no_inherit=True)
> 
> The kwlist should be kept to just those necessary values for the
> example to work? I kind of see this as Arnaldo's baby, so he may just
> want everything, so this needn't be a blocker.
> 
> Bigger picture I wonder about migrating the `perf script` code to just
> being regular python programs like the example here.

You mean:

acme@number:~/git/perf-tools-next$ ls -la tools/perf/scripts/python/
total 452
drwxr-xr-x. 1 acme acme    902 Aug 20 14:18 .
drwxr-xr-x. 1 acme acme     30 Sep 17 09:27 ..
-rwxr-xr-x. 1 acme acme  11865 Aug 20 14:06 arm-cs-trace-disasm.py
drwxr-xr-x. 1 acme acme   1640 Aug 20 14:18 bin
-rw-r--r--. 1 acme acme   2461 Apr 16 10:06 check-perf-trace.py
-rw-r--r--. 1 acme acme   7923 Apr 16 10:06 compaction-times.py
-rw-r--r--. 1 acme acme   7497 Apr 16 10:06 event_analyzing_sample.py
-rwxr-xr-x. 1 acme acme 157369 Aug 20 14:18 exported-sql-viewer.py
-rw-r--r--. 1 acme acme  39845 Apr 16 10:06 export-to-postgresql.py
-rw-r--r--. 1 acme acme  24671 Apr 16 10:06 export-to-sqlite.py
-rw-r--r--. 1 acme acme   2173 Apr 16 10:06 failed-syscalls-by-pid.py
-rwxr-xr-x. 1 acme acme  10377 Aug 20 14:18 flamegraph.py
-rw-r--r--. 1 acme acme   1717 Apr 16 10:06 futex-contention.py
-rw-r--r--. 1 acme acme  13302 Apr 16 10:06 gecko.py
-rw-r--r--. 1 acme acme  14636 Apr 16 10:06 intel-pt-events.py
-rw-r--r--. 1 acme acme   3395 Apr 16 10:06 libxed.py
-rw-r--r--. 1 acme acme   4230 Aug 20 14:13 mem-phys-addr.py
-rw-r--r--. 1 acme acme  15420 Aug 20 14:05 netdev-times.py
-rwxr-xr-x. 1 acme acme   1833 Apr 16 10:06 net_dropmonitor.py
-rwxr-xr-x. 1 acme acme  30683 Aug 20 14:05 parallel-perf.py
drwxr-xr-x. 1 acme acme     34 Sep 17 09:27 Perf-Trace-Util
-rw-r--r--. 1 acme acme   4509 Apr 16 10:06 powerpc-hcalls.py
-rw-r--r--. 1 acme acme  12095 Apr 16 10:06 sched-migration.py
-rw-r--r--. 1 acme acme   2183 Apr 16 10:06 sctop.py
-rwxr-xr-x. 1 acme acme   4408 Apr 16 10:06 stackcollapse.py
-rw-r--r--. 1 acme acme   2444 Apr 16 10:06 stat-cpi.py
-rw-r--r--. 1 acme acme   2055 Apr 16 10:06 syscall-counts-by-pid.py
-rw-r--r--. 1 acme acme   1673 Apr 16 10:06 syscall-counts.py
-rwxr-xr-x. 1 acme acme  34014 Apr 16 10:06 task-analyzer.py
acme@number:~/git/perf-tools-next$

And then make:

acme@number:~/git/perf-tools-next$ perf script -l
List of available trace scripts:
  compaction-times [-h] [-u] [-p|-pv] [-t | [-m] [-fs] [-ms]] [pid|pid-range|comm-regex] display time taken by mm compaction
  event_analyzing_sample               analyze all perf samples
  export-to-postgresql [database name] [columns] [calls] export perf data to a postgresql database
  export-to-sqlite [database name] [columns] [calls] export perf data to a sqlite3 database
  failed-syscalls-by-pid [comm]        system-wide failed syscalls, by pid
  flamegraph                           create flame graphs
  futex-contention                     futext contention measurement
  gecko                                create firefox gecko profile json format from perf.data
  intel-pt-events                      print Intel PT Events including Power Events and PTWRITE
  mem-phys-addr                        resolve physical address samples
  net_dropmonitor                      display a table of dropped frames
  netdev-times [tx] [rx] [dev=] [debug] display a process of packet and processing time
  powerpc-hcalls                       
  sched-migration                      sched migration overview
  sctop [comm] [interval]              syscall top
  stackcollapse                        produce callgraphs in short form for scripting use
  syscall-counts-by-pid [comm]         system-wide syscall counts, by pid
  syscall-counts [comm]                system-wide syscall counts
  task-analyzer                        analyze timings of tasks
  failed-syscalls [comm]               system-wide failed syscalls
  rw-by-file <comm>                    r/w activity for a program, by file
  rw-by-pid                            system-wide r/w activity
  rwtop [interval]                     system-wide r/w top
  wakeup-latency                       system-wide min/max/avg wakeup latency
acme@number:~/git/perf-tools-next$

And make:

perf script rwtop

Just call 'python PATH_TO_PYTHON_SCRIPTS/rwtop.py' transparently?

That looks interesting indeed, that way we would stop linking with
libpython, etc.

I wonder if there are out of tree scripts using the current tools/perf/util/scripting-engines/trace-event-python.c
mechanism...

But even that can fallback to a python based mechanism, right?

Import the script, if it has a given structure, use the new way, if not,
call a glue that reads the events and feed to the old style code.

Seems doable and would save code on the main perf binary and headaches
with the libpython and libperl build processes.

- Arnaldo

> I sent out
> deprecating the libperl code to this ends (looking for reviews):
> https://lore.kernel.org/linux-perf-users/20250908181918.3533480-1-irogers@google.com/
> The issue is that `perf script` being the main thread inhibits things
> like textual running until trace_end. This means we can't do things
> like incremental loading support. We may want to make the perf events
> support something like an asyncio interface for that.
> 
> Refactoring that support will likely raise backward compatibility
> concerns. It'd be a really nice thing to do as the API has some fairly
> major overheads like turning everything in a sample into a Dict
> whether needed or not:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/scripting-engines/trace-event-python.c#n838
> I mention this just to say why I'd like to minimize the API when possible.
> 
> Thanks,
> Ian
> 
> [1] https://lore.kernel.org/r/20250604174545.2853620-10-irogers@google.com
