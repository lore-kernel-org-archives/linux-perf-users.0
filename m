Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9534A4F20E;
	Mon, 29 Jul 2024 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722216118; cv=none; b=e7FeUz1E3H4WWz+y4iuUvkOcyuIXLBZIqhHmn5B77iMGm0QbKa4zdo1EW6mgyatXLTuWJ2PFRO24F+plhQLZdX+q6jcUtHIey84DtKO7kEFHI7tSU+NqkofZZBNiMd36LSMLmz48pnHIv4p9Jvan8X5tIkShEewP33h9NoT13kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722216118; c=relaxed/simple;
	bh=fcJW5gJLnuodeIWxC2Kn1Lk9LfB+ENVDoYCigF2EHbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHgMhkZe9ZKMbf9OIeF5u4vcF4kkqeO+/OMo9ss/ZRJ9AAe904UDe/MHvPq4ZXjczC8ICtWK/TI0AriX1IxqOGwGMnJ/PFqOxJtDihlK2pE1k7TVuRSawvHJtbS4BgKvOyxh2rO4+bb/8ljYBSlAom1b5AOt1Ws177WyjSwNsEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVq9ZAzc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVq9ZAzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918A7C116B1;
	Mon, 29 Jul 2024 01:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722216118;
	bh=fcJW5gJLnuodeIWxC2Kn1Lk9LfB+ENVDoYCigF2EHbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iVq9ZAzclkJiCHb7miMCuGS8neNsccB40NVmVYAEgQCaDAuFKdFG4d6HVvPF2EX1O
	 tqfyhE4QV2rMAfODaEaGA71oiY6IfJak8bFyYT/4PH63IrYxV0TE9rLplcodkEGSbe
	 jxzv/ka+EW7D/0qrESyGE0ajyWI1boRsxocoPmnR+w2XjK3eCUjO7vYF56lmrx4n2U
	 4V+K66dwqITY7fNtfH2gfB6b/FiV6h8L5XFrLDeezDy19Una14jnJ7CgwA991iYRNX
	 BdnGGZnQ05vVqmUiGveXtXZWnkmY98rzFBslYR1Pirwqnbxl9tG6eJUeJbmwfME/TQ
	 QaIPs2yk7X5iA==
Date: Sun, 28 Jul 2024 18:21:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com,
	jolsa@kernel.org, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Dump off-cpu samples directly
Message-ID: <ZqbutBvHOJ0SPd64@google.com>
References: <20240726102826.787004-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240726102826.787004-1-howardchu95@gmail.com>

Hello Howard,

On Fri, Jul 26, 2024 at 06:28:21PM +0800, Howard Chu wrote:
> As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=207323
> 
> Currently, off-cpu samples are dumped when perf record is exiting. This
> results in off-cpu samples being after the regular samples. This patch
> series makes possible dumping off-cpu samples on-the-fly, directly into
> perf ring buffer. And it dispatches those samples to the correct format
> for perf.data consumers.

Thanks for your work!

But I'm not sure we need a separate event for offcpu-time-direct.  If we
fix the format for the direct event, we can adjust the format of offcpu-
time when it dumps at the end.

Anyway, as far as I can see you don't need to fill the sample info in
the offcpu-time-direct manually in your BPF program.  Because the
bpf_perf_event_output() will call perf_event_output() which fills all
the sample information according to the sample_type flags.

Well.. it'll set IP to the schedule function, but it should be ok.
(updating IP using CALLCHAIN like in off_cpu_write() is a kinda hack and
not absoluately necessary, probably I can get rid of it..  Let's go with
simple for now.)

So I think what you need is to ensure it has the uncessary flags.  And
the only info it needs to fill is the time between the previous schedule
and this can be added to the raw data.

Thanks,
Namhyung

> 
> Changes in v3:
>  - Add off-cpu-thresh argument
>  - Process direct off-cpu samples in post
> 
> Changes in v2:
>  - Remove unnecessary comments.
>  - Rename function off_cpu_change_type to off_cpu_prepare_parse
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
>     blueman-tray    1355 [000] 28178.627906:  100184571 offcpu-time-direct: 
> 	    7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
> 	    7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
> 	    7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-2.0.so.0.8000.2)
> 	    7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.0.8000.2)
> 	    7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
> 	    7fff24e862d8 [unknown] ([unknown])
> 
> 
>     blueman-tray    1355 [000] 28178.728137:  100187539 offcpu-time-direct: 
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
> Howard Chu (5):
>   perf record off-cpu: Add direct off-cpu event
>   perf record off-cpu: Dumping samples in BPF
>   perf record off-cpu: processing of embedded sample
>   perf record off-cpu: save embedded sample type
>   perf record off-cpu: Add direct off-cpu test
> 
>  tools/perf/builtin-record.c             |   2 +
>  tools/perf/builtin-script.c             |   2 +-
>  tools/perf/tests/builtin-test.c         |   1 +
>  tools/perf/tests/shell/record_offcpu.sh |  29 +++++
>  tools/perf/tests/tests.h                |   1 +
>  tools/perf/tests/workloads/Build        |   1 +
>  tools/perf/tests/workloads/offcpu.c     |  16 +++
>  tools/perf/util/bpf_off_cpu.c           |  53 ++++++++-
>  tools/perf/util/bpf_skel/off_cpu.bpf.c  | 143 ++++++++++++++++++++++++
>  tools/perf/util/evsel.c                 |  16 ++-
>  tools/perf/util/evsel.h                 |  13 +++
>  tools/perf/util/header.c                |  12 ++
>  tools/perf/util/off_cpu.h               |   1 +
>  tools/perf/util/record.h                |   1 +
>  tools/perf/util/session.c               |  23 +++-
>  15 files changed, 309 insertions(+), 5 deletions(-)
>  create mode 100644 tools/perf/tests/workloads/offcpu.c
> 
> -- 
> 2.45.2
> 
