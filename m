Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAB016FF3B;
	Fri, 27 Sep 2024 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463954; cv=none; b=EYxqjczfkzDRqyofsEBxM9IZoq+OMwBhr0rK1TjZOq7yimtCAYnoyw1qEKUjXJ6q8aRYulEjFIUcihTVf8AO5MREne9pwVUx3RRK30g91vtodcjvjzyqYfiUbS95tm6rV2wb2fJ+ry8nm4pjogDi0NzGd5wHxyHvapJFgG9Bz8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463954; c=relaxed/simple;
	bh=AlVmqydRc0H9M6uSiES4idlufya26gQJmhUiInsVoMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCh17W80B7Nu4ehGbjwonEycmtpsHXv04Kts+a8A5vHCLB/VAFJBmxhZUgpkbsSxQsZ32IWlIKf8gwl1CPxdJBbD4Mr4k0bqFLOIbwgGppPlCcXaRUIDn80GjtcXPfTe0anrkiBH9bu/eJEzRGm6B5R2YPGv+QU0o9ibUco9ldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQPlB/T7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQPlB/T7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E1CC4CEC4;
	Fri, 27 Sep 2024 19:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727463954;
	bh=AlVmqydRc0H9M6uSiES4idlufya26gQJmhUiInsVoMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQPlB/T7qzO8uuxc1elhRj4hg/sUzm8ppcz/jKj7zzv1LjM68viaJZoYK9bFRU3JN
	 kusPDdDssMCcRYjgPKF+meCQETY6Uj2YopNl1j0V31TdQBF/sFt1oZIDzNbw7gUxRP
	 +t6kggF30jZfjgk/PyHt4+pm8aoP6dYTW/uM6ATypzoxcAGTaPnHjK1dM2KceNZdbI
	 XQL3weL3C54wTigW471cG9thwQ47Su2sKHZJq22J1M7zsg2bXwRDAkk3pQ2Xh7AuIU
	 mFIbqCkH1Nnr0o9kfgot8Qs2fv2cZlh9IdUtNfiL23LPKV2BSF1XAMH0DxYYyZREwB
	 PVVNeGCHTFeEg==
Date: Fri, 27 Sep 2024 16:05:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/8] perf record --off-cpu: Dump off-cpu samples
 directly
Message-ID: <ZvcCDkrzwilKYQR2@x1>
References: <20240927185340.658143-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927185340.658143-1-howardchu95@gmail.com>

On Fri, Sep 27, 2024 at 11:53:32AM -0700, Howard Chu wrote:
> Changes in v5:
>  - Delete unnecessary copy in BPF program
>  - Remove sample_embed from perf header, hard code off-cpu stuff instead
>  - Move evsel__is_offcpu_event() to evsel.h
>  - Minor changes to the test
>  - Edit some comments

Thanks, I'll try to review and test this early next week, and check on
bisectability issues as you mentioned privately.

Thanks!

- Arnaldo
 
> Changes in v4:
>  - Minimize the size of data output by perf_event_output()
>  - Keep only one off-cpu event
>  - Change off-cpu threshold's unit to microseconds
>  - Set a default off-cpu threshold
>  - Print the correct error message for the field 'embed' in perf data header
> 
> Changes in v3:
>  - Add off-cpu-thresh argument
>  - Process direct off-cpu samples in post
> 
> Changes in v2:
>  - Remove unnecessary comments.
>  - Rename function off_cpu_change_type to off_cpu_prepare_parse
> 
> v1:
> 
> As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=207323
> 
> Currently, off-cpu samples are dumped when perf record is exiting. This
> results in off-cpu samples being after the regular samples. This patch
> series makes possible dumping off-cpu samples on-the-fly, directly into
> perf ring buffer. And it dispatches those samples to the correct format
> for perf.data consumers.
> 
> Before:
> ```
>      migration/0      21 [000] 27981.041319: 2944637851    cycles:P:  ffffffff90d2e8aa record_times+0xa ([kernel.kallsyms])
>             perf  770116 [001] 27981.041375:          1    cycles:P:  ffffffff90ee4960 event_function+0xf0 ([kernel.kallsyms])
>             perf  770116 [001] 27981.041377:          1    cycles:P:  ffffffff90c184b1 intel_bts_enable_local+0x31 ([kernel.kallsyms])
>             perf  770116 [001] 27981.041379:      51611    cycles:P:  ffffffff91a160b0 native_sched_clock+0x30 ([kernel.kallsyms])
>      migration/1      26 [001] 27981.041400: 4227682775    cycles:P:  ffffffff90d06a74 wakeup_preempt+0x44 ([kernel.kallsyms])
>      migration/2      32 [002] 27981.041477: 4159401534    cycles:P:  ffffffff90d11993 update_load_avg+0x63 ([kernel.kallsyms])
> 
> sshd  708098 [000] 18446744069.414584:     286392 offcpu-time: 
> 	    79a864f1c8bb ppoll+0x4b (/usr/lib/libc.so.6)
> 	    585690935cca [unknown] (/usr/bin/sshd)
> ```
> 
> After:
> ```
>             perf  774767 [003] 28178.033444:        497           cycles:P:  ffffffff91a160c3 native_sched_clock+0x43 ([kernel.kallsyms])
>             perf  774767 [003] 28178.033445:     399440           cycles:P:  ffffffff91c01f8d nmi_restore+0x25 ([kernel.kallsyms])
>          swapper       0 [001] 28178.036639:  376650973           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
>          swapper       0 [003] 28178.182921:  348779378           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
>     blueman-tray    1355 [000] 28178.627906:  100184571 offcpu-time: 
> 	    7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
> 	    7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
> 	    7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-2.0.so.0.8000.2)
> 	    7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.0.8000.2)
> 	    7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
> 	    7fff24e862d8 [unknown] ([unknown])
> 
> 
>     blueman-tray    1355 [000] 28178.728137:  100187539 offcpu-time: 
> 	    7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
> 	    7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
> 	    7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-2.0.so.0.8000.2)
> 	    7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.0.8000.2)
> 	    7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
> 	    7fff24e862d8 [unknown] ([unknown])
> 
> 
>          swapper       0 [000] 28178.463253:  195945410           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
>      dbus-broker     412 [002] 28178.464855:  376737008           cycles:P:  ffffffff91c000a0 entry_SYSCALL_64+0x20 ([kernel.kallsyms])
> ```
> 
> Howard Chu (8):
>   perf evsel: Set off-cpu BPF output to system-wide
>   perf record --off-cpu: Add --off-cpu-thresh
>   perf record --off-cpu: Parse offcpu-time event
>   perf record off-cpu: Dump direct off-cpu samples in BPF
>   perf record --off-cpu: Dump total off-cpu time at the end.
>   perf evsel: Delete unnecessary = 0
>   perf record --off-cpu: Parse BPF output embedded data
>   perf test: Add direct off-cpu dumping test
> 
>  tools/perf/builtin-record.c             |  26 ++++
>  tools/perf/builtin-script.c             |   4 +-
>  tools/perf/tests/builtin-test.c         |   1 +
>  tools/perf/tests/shell/record_offcpu.sh |  29 ++++
>  tools/perf/tests/tests.h                |   1 +
>  tools/perf/tests/workloads/Build        |   1 +
>  tools/perf/tests/workloads/offcpu.c     |  16 +++
>  tools/perf/util/bpf_off_cpu.c           | 174 +++++++++++++++---------
>  tools/perf/util/bpf_skel/off_cpu.bpf.c  | 123 +++++++++++++++++
>  tools/perf/util/evsel.c                 |  47 ++++---
>  tools/perf/util/evsel.h                 |   6 +
>  tools/perf/util/off_cpu.h               |  10 +-
>  tools/perf/util/record.h                |   1 +
>  tools/perf/util/session.c               |  12 +-
>  14 files changed, 359 insertions(+), 92 deletions(-)
>  create mode 100644 tools/perf/tests/workloads/offcpu.c
> 
> -- 
> 2.43.0
