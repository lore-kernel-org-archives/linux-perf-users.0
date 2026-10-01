Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77A4377AB6;
	Thu,  1 Oct 2026 06:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837276; cv=none; b=gL7p01+S25vggssDobI/LHoN5sq1hXDrGNBASQptAHN1OE/fq2c4GJ+5kolNTFFhAYfYngWHK0AZcliRmCyhOie0XYveE+x+Bww21gGvJreBM0vieRc0ft0pX1ndvSPjPLbQzLlaZ3615RtvjuhYgQPoNg2RZkThU9RHXBSumps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837276; c=relaxed/simple;
	bh=TXC5ruVXo+a9dEJ5rZbCZbW68skQG3TCrlDnMCSWDdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgRey8TT7UQBtN/Ak8u/D+I+Rm9N6UMgqSnKhQ08n+6dKYdk8q5sTMdCJVuN57ccd2OqjGXc6iHVc3MEJtBngPlItV0ZN5zOIeQJrXEfMvo+AE8foQdLkr0HP+eeFtm2WePK06jnh6XwTzO6Y3YYvRWxe0zPZTLykjbddebOJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAx4r1Qy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAx4r1Qy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7CA1F000FF;
	Thu,  1 Oct 2026 06:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790837272;
	bh=/eo4VXfLJA2BqXU04SITGfBAcQm5nCCQ0vEGJlZDNXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GAx4r1QySbXUQtVhs5ku+Px8WYJpasZv+1qGZplpRI54QCCxJjWc3ccOrq0QC6kMh
	 xXuiXwz1LLp5AseyT0GJfSt5L4ekNSx871d6NGOwDlRj7haRlEytVgsdzV9pQuwpjg
	 7dmDwboevsrg7cCbe5e3FAAPqCpg0+cxMTIk5XUKojRZd0HN+zQv4d2uwHvPBUwcaB
	 Z2ZjNi+i5+cbXSIiyNufW209Su4GyX6wb5vveag/MfkEnt9g+vgPUwfT+tAmkoEPmw
	 8OeaW3EZkLcz/Wjt/qNgrvbHS9NtLEJt9qaiFG+e0UiYV8vh9AcoCfrzJxaedCeuuH
	 RnuCcORKTfgNQ==
Date: Wed, 30 Sep 2026 23:47:50 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
	Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/26] perf trace: Fix BPF filtering and make tracing
 tests non-exclusive
Message-ID: <ar4CFsO_TMn1ZQnX@z2>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <ar1HuxPsRpiOZ_4K@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ar1HuxPsRpiOZ_4K@x2>

On Wed, Sep 30, 2026 at 07:32:43PM +0200, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 28, 2026 at 11:25:39AM -0700, Ian Rogers wrote:
> > perf trace's BPF programs return 0 from raw_syscalls:sys_{enter,exit} to
> > filter, which drops the event for every other session using the
> > tracepoint. Fix that, and bugs found on the way, so the perf trace and
> > probe tests can run in parallel.
> 
> Applied the first 4 patches so far,
  
I've reviewed other patches and they all look fine.  Thanks Ian for
incorperating my earlier patches.  I'd like to merge this series first
and work on more cleanups later.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> > Patches 1-6 fix reading augmented arguments.
> > 
> > Patches 7-10 fix starting the BPF summary, and the syscall tracepoints'
> > internal fields being taken for arguments.
> > 
> > Patches 11-18 fix the filtering. Namhyung's series [2], patches 11, 17
> > and 18, sends sys_exit as well as sys_enter through the bpf-output event
> > so nothing is vetoed. That event only works for the first thread of a
> > task target and not for its children, so patches 14-16 open it on every
> > CPU and select the target's tasks in BPF, keyed by process when
> > inheriting. Patch 19 adds --no-syscall-augment.
> > 
> > Patches 20-26 scope the tests' probes and events to their pid so they
> > can drop the exclusive tag.
> > 
> > Aaron's series [1] overlaps patches 4 and 5, whose approach was
> > preferred. In [1], 3/7 steps over a string by its size rounded up to 8,
> > but the BTF augmenter packs arguments unaligned, so the second path of
> > rename-like syscalls is misread. 2/7 doesn't step over the zero sized
> > argument a failed read leaves, so the next argument rereads it. [1] also
> > has checkpatch warnings, Reported-by without Closes: and 112 column
> > lines.
> > 
> > >From [2], Jakub's 1/5, using the kernel's syscall tracepoint structs, is
> > left out as these fixes don't need it and patches 1, 2, 15 and 17 change
> > the same code. It can follow on top. 3/5 adds common_type to the existing
> > structs instead and, among the changes noted in it, always returns 1
> > from augmented__output(), as returning 0 from the tail called augmenters
> > still vetoed the tracepoint. 5/5 keeps trace+probe_vfs_getname.sh
> > exclusive, as without BPF every perf trace opens its probe.
> > 
> > The series applies on top of [3], which fixes the vfs_getname tests on
> > v7.0+ kernels and changes the same lines as patch 21.
> > 
> > Tested on x86_64, the trace and probe tests pass under 'perf test -r3'.
> > Every patch builds with and without BUILD_BPF_SKEL.
> > 
> > [1] https://lore.kernel.org/r/20260919005530.728615-1-atomlin@atomlin.com
> > [2] https://lore.kernel.org/r/20250814071754.193265-1-namhyung@kernel.org
> > [3] https://lore.kernel.org/r/20260926223905.6865105-1-irogers@google.com
> > 
> > v6:
> >  - Shorter commit messages and comments (Namhyung).
> >  - Keep v5 8-9/23 as patches 4 and 5 rather than Aaron's [1], see above.
> >  - New patch 6 copies sockaddr arguments by their length, so IPv6
> >    addresses are shown.
> >  - Namhyung's 2-4/5 with patches 15 and 16 replace v5 11-15/23, and his
> >    5/5 replaces v5 22/23, see above.
> >  - Seed the target's tasks before the events are opened, rather than
> >    re-reading /proc after attaching, keyed by process when inheriting.
> >    Tasks that don't fit are reported as lost, suggesting
> >    --no-syscall-augment.
> >  - Patch 14 moves bpf-filter's convert_to_tgid() to thread_map.c, fixing
> >    a read after free and a comm containing "Tgid:" being taken for it.
> >  - Split v5 7/23 into patches 8-10, stopping at the first internal
> >    field (Namhyung).
> >  - --no-syscall-augment is its own patch (Namhyung).
> >  - Drop v5 3-5/23, now applied.
> >  - Drop v5 16/23, as perf-tools-next's port of task-analyzer to the perf
> >    module made the same change.
> > 
> > Ian Rogers (22):
> >   perf trace: Set the augmented arg header in the augmenters that omit
> >     it
> >   perf trace: Include the augmented arg header in nanosleep's payload
> >     length
> >   perf trace: Don't read sample padding as an augmented argument
> >   perf trace: Bounds check augmented arguments before reading them
> >   perf trace: Bound the fixed size augmented argument beautifiers
> >   perf trace: Copy sockaddr arguments by their length
> >   perf trace: Start BPF summary before starting workload
> >   perf trace: Stop at internal fields when walking syscall arguments
> >   perf trace: Don't allocate syscall arg formats for internal fields
> >   perf trace: Only take augmented arguments from the BPF output event
> >   perf trace: Use the CPU map index for the BPF output event's fds
> >   perf trace: Destroy the BPF skeleton if it fails to load
> >   perf thread_map: Add thread_map__tgid()
> >   perf trace: Filter the target's tasks in BPF
> >   perf trace: Open the BPF output event on every CPU for task targets
> >   perf trace: Add an option to disable syscall augmentation
> >   perf test common: Only disable probes in clear_all_probes
> >   perf test probe_vfs_getname: Scope probe name to PID and make
> >     non-exclusive
> >   perf test record+probe_libc_inet_pton: Scope event to PID and make
> >     non-exclusive
> >   perf test trace_summary: Improve error diagnostics
> >   perf test trace_btf_general: Drop --max-events=1 and make
> >     non-exclusive
> >   perf test uprobe_from_different_cu: Scope probe name to PID
> > 
> > Namhyung Kim (4):
> >   perf trace: Split unaugmented sys_exit program
> >   perf trace: Do not return 0 from syscall tracepoint BPF
> >   perf trace: Remove unused code
> >   perf test: Remove exclusive tag from perf trace tests
> > 
> >  tools/perf/Documentation/perf-trace.txt       |   6 +
> >  tools/perf/builtin-trace.c                    | 441 ++++++++++--------
> >  tools/perf/tests/shell/common/init.sh         |  21 +-
> >  .../perf/tests/shell/lib/probe_vfs_getname.sh |  25 +-
> >  tools/perf/tests/shell/probe_vfs_getname.sh   |   3 +-
> >  .../shell/record+probe_libc_inet_pton.sh      |  85 +++-
> >  .../shell/record+script_probe_vfs_getname.sh  |  16 +-
> >  .../shell/test_uprobe_from_different_cu.sh    |   7 +-
> >  .../tests/shell/trace+probe_vfs_getname.sh    |   5 +
> >  tools/perf/tests/shell/trace_btf_general.sh   |   8 +-
> >  tools/perf/tests/shell/trace_summary.sh       |  15 +-
> >  tools/perf/trace/beauty/beauty.h              |  17 +
> >  tools/perf/trace/beauty/perf_event_open.c     |  31 +-
> >  tools/perf/trace/beauty/sockaddr.c            |  49 +-
> >  tools/perf/trace/beauty/timespec.c            |   2 +-
> >  tools/perf/util/bpf-filter.c                  |  29 +-
> >  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 210 +++++++--
> >  tools/perf/util/bpf_skel/perf_trace_u.h       |  14 +
> >  tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |   9 +
> >  tools/perf/util/bpf_trace_augment.c           |  89 +++-
> >  tools/perf/util/thread_map.c                  |  26 ++
> >  tools/perf/util/thread_map.h                  |   1 +
> >  tools/perf/util/trace_augment.h               |  34 +-
> >  23 files changed, 800 insertions(+), 343 deletions(-)
> >  create mode 100644 tools/perf/util/bpf_skel/perf_trace_u.h
> > 
> > 
> > base-commit: 0ae6fc78c5ce0dfd18d8712a50f0fd4602eff103
> > prerequisite-patch-id: 8c69aafd92a5783df1ce11b7ab792ab39508380e
> > -- 
> > 2.56.0.rc1.315.gc6ed9934b7-goog
> > 
