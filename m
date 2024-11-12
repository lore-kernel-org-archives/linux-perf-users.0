Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311D1FF7C4;
	Tue, 12 Nov 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436771; cv=none; b=vGSxCB3jRIcWdcfqjN5vPKdUg396JThO7WqhRcwcxsbKtGxkaBlCgZ9n0uV3TPfWHITCN+yj0ZlbWvE17kxD9HuLCWGZc+buWiH7ferCOV39lMAEGXm6Uk5EeIaOhcvFySrJbm3UMAer6N3b4G36Jv8sKnknO9ZetY2zBmv9UMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436771; c=relaxed/simple;
	bh=LPsPGdrRFQP1YfArcIN3lRRQuZprHeTYpv+JfzrnQ8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Slbpavk74fe0+0lyfc08Gr6JSWu1SxzE9SlmtTiM/O5X1lsBlGi9rVQ+FgTjWfNEeVzR2DVCYISTnvRZl5n1gPbUa5rlaiMZ/mDQ5xJbvDXo64aEopiP827n+9yuzmyVrOfdK44XeaUGhglBCdPMKGOyh57O5HxTKIq1NEHoZhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYn1mdIO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYn1mdIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7F9C4CECD;
	Tue, 12 Nov 2024 18:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731436771;
	bh=LPsPGdrRFQP1YfArcIN3lRRQuZprHeTYpv+JfzrnQ8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYn1mdIOMwsF0re7CBiWtxChZ58xSabc6LsC3iNz8VepKw45PaGUWSI5JkI37lhiO
	 Z8+6y+phm44im0lRGa2IKqjN+lzL6R93RsEJYzb4RPvWmpgrt/Fnp5Muk5cSFivNGP
	 EhkQfwQUTYwylXJpio+YPss37T+8PPQt4L4Rpd93lYPN6hHgVpH4m+RWuKAa5DQ8Nd
	 WuALdHx/iChJppvzTOLxOuSMVLP7zc7aHwbzC+B9tVV23REtNEipxRavdpdZt4TG0W
	 Ik/5oEPpQ8Xo2/YmEaPhUkD/f2D6ym2eXdzcKN68GKhRMorIlC20gMInH2gps3iEyp
	 RPe0m1+bukeWA==
Date: Tue, 12 Nov 2024 15:39:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, namhyung@kernel.org, irogers@google.com,
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/10] perf record --off-cpu: Dump off-cpu samples
 directly
Message-ID: <ZzOg3Xlq2jsG85XQ@x1>
References: <20241108204137.2444151-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241108204137.2444151-1-howardchu95@gmail.com>

⬢ [acme@toolbox perf-tools-next]$        git am ./v7_20241108_howardchu95_perf_record_off_cpu_dump_off_cpu_samples_directly.mbx
Applying: perf record --off-cpu: Add --off-cpu-thresh option
Applying: perf evsel: Expose evsel__is_offcpu_event() for future use
Applying: perf record --off-cpu: Parse off-cpu event
Applying: perf record --off-cpu: Preparation of off-cpu BPF program
Applying: perf record --off-cpu: Dump off-cpu samples in BPF
error: corrupt patch at line 107
Patch failed at 0005 perf record --off-cpu: Dump off-cpu samples in BPF
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"
⬢ [acme@toolbox perf-tools-next]$

This is on top of:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next

The message:

error: corrupt patch at line 107

Doesn't look like a clash with something that changed after you prepared
this patch set.

If we apply the first 4:

⬢ [acme@toolbox perf-tools-next]$        git am ./v7_20241108_howardchu95_perf_record_off_cpu_dump_off_cpu_samples_directly.mbx
Applying: perf record --off-cpu: Add --off-cpu-thresh option
Applying: perf evsel: Expose evsel__is_offcpu_event() for future use
Applying: perf record --off-cpu: Parse off-cpu event
Applying: perf record --off-cpu: Preparation of off-cpu BPF program
⬢ [acme@toolbox perf-tools-next]$ 

Then try to apply just the 5th patch:

⬢ [acme@toolbox perf-tools-next]$ b4 am -P5 -ctsl --cc-trailers 20241108204137.2444151-2-howardchu95@gmail.com
⬢ [acme@toolbox perf-tools-next]$ patch -p1 < ./v7_20241108_howardchu95_perf_record_off_cpu_dump_off_cpu_samples_directly.mbx
patching file tools/perf/util/bpf_skel/off_cpu.bpf.c
patch: **** malformed patch at line 138:  

⬢ [acme@toolbox perf-tools-next]$

You have:

@@ -209,6 +268,12 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
        pelem->state = state;
        pelem->stack_id = stack_id;

+       /*
+        * If stacks are successfully collected by bpf_get_stackid(), collect them once more
+        * in task_storage for direct off-cpu sample dumping
+        */
+       if (stack_id > 0 && bpf_get_stack(ctx, &pelem->stack, MAX_STACKS * sizeof(u64), BPF_F_USER_STACK)) {
+       }
+
 next:
        pelem = bpf_task_storage_get(&tstamp, next, NULL, 0);

@@ -223,11 +288,19 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,

see the -209,6 +268,12? Did you edit it manually? It should be -209,6 +268,13

And also what is the point of that empty if block?

- Arnaldo

On Fri, Nov 08, 2024 at 12:41:27PM -0800, Howard Chu wrote:
> Changes in v7:
>  - Make off-cpu event system-wide
>  - Use strtoull instead of strtoul
>  - Delete unused variable such as sample_id, and sample_type
>  - Use i as index to update BPF perf_event map
>  - MAX_OFFCPU_LEN 128 is too big, make it smaller.
>  - Delete some bound check as it's always guaranteed
>  - Do not set ip_pos in BPF
>  - Add a new field for storing stack traces in the tstamp map
>  - Dump the off-cpu sample directly or save it in the off_cpu map, not both
>  - Delete the sample_type_off_cpu check
>  - Use __set_off_cpu_sample() to parse samples instead of a two-pass parsing
> 
> Changes in v6:
>  - Make patches bisectable
> 
> Changes in v5:
>  - Delete unnecessary copy in BPF program
>  - Remove sample_embed from perf header, hard code off-cpu stuff instead
>  - Move evsel__is_offcpu_event() to evsel.h
>  - Minor changes to the test
>  - Edit some comments
> 
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
> Howard Chu (10):
>   perf record --off-cpu: Add --off-cpu-thresh option
>   perf evsel: Expose evsel__is_offcpu_event() for future use
>   perf record --off-cpu: Parse off-cpu event
>   perf record --off-cpu: Preparation of off-cpu BPF program
>   perf record --off-cpu: Dump off-cpu samples in BPF
>   perf evsel: Assemble offcpu samples
>   perf record --off-cpu: Disable perf_event's callchain collection
>   perf script: Display off-cpu samples correctly
>   perf record --off-cpu: Dump the remaining samples in BPF's stack trace
>     map
>   perf test: Add direct off-cpu test
> 
>  tools/perf/builtin-record.c             |  26 ++++++
>  tools/perf/builtin-script.c             |   4 +-
>  tools/perf/tests/builtin-test.c         |   1 +
>  tools/perf/tests/shell/record_offcpu.sh |  31 ++++++-
>  tools/perf/tests/tests.h                |   1 +
>  tools/perf/tests/workloads/Build        |   1 +
>  tools/perf/tests/workloads/offcpu.c     |  16 ++++
>  tools/perf/util/bpf_off_cpu.c           | 115 ++++++++++++++----------
>  tools/perf/util/bpf_skel/off_cpu.bpf.c  |  85 ++++++++++++++++--
>  tools/perf/util/evsel.c                 |  34 ++++++-
>  tools/perf/util/evsel.h                 |   2 +
>  tools/perf/util/off_cpu.h               |   3 +-
>  tools/perf/util/record.h                |   1 +
>  13 files changed, 264 insertions(+), 56 deletions(-)
>  create mode 100644 tools/perf/tests/workloads/offcpu.c
> 
> -- 
> 2.43.0
