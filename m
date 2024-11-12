Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494DF206E65
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731438015; cv=none; b=WskE3Lu+8nM1moaj2SR0EHmWtRNAAH25+SAcR6ZvQFiqpRuSxYO1kLO8+Ln9mMQIBLgwdYTYr3vq8s49got2ql1M+JOHwxR12gzPb9u3qDBbDWalVFJLqpqTuXLG3oF5uqMr2qu3YH6XR8PkWtG85Dqpi0VMGa3nO3/mwUXNxZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731438015; c=relaxed/simple;
	bh=rPuemJIsrHGzXAOqgA5lIwbTfkS3ImpR2sRS9+YzYrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6/jlmTQXSlT4Q3eSBjjBzNeIanRWkWwHG+30XuUUqBJXYiXV2OcInpGPyIYaqriWYdzvG+IDbcS3eCOyrr/ulXztKi7+TjGE3FZgpTpfw+JIvPioI+uLivXQqNXMoc4M0kA+mPelUmzDmoU/nt8Q32oJ2RoKLlG9br+KDIZC08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tqnw4mJn; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tqnw4mJn"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso13795ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 11:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731438011; x=1732042811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84oE5IW1fV5Ge5uyPAAuXLeOBNnfnJy1dmW84RfMUZc=;
        b=tqnw4mJnAHRKB1Ye1GpAzz5g9m/Ns2ZgyOWL9avgde4xKb+RUp7elwXXn+B+0QeDSa
         cpcUmkvvp/b7D1W3/Mxo1rlIMoOP75S3YxcpFOBLRJHlkhJm00cKLEvDUAcEQxNdaZCl
         AOI86TmNBUk2MJooGFjhdwzc52iCXTZkUGB/DsW3UHlXy12wGDffNgp5Tg33/CZ4PC/3
         mxjae5ssf5e6VeLfEoOjVsRSbsyvVGZhMj9HiQ4GqYHQnguruDFmdtAnbRTsD3F5vlC9
         1dv0JE6SpmXs7USqxGdVMszDeRIUH2ViP1xGSyoKRA2jejSWP0GKFokOJeqyUARqROZy
         WDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731438011; x=1732042811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84oE5IW1fV5Ge5uyPAAuXLeOBNnfnJy1dmW84RfMUZc=;
        b=bbfsBbFLg6dZpk+FeCBThSWLJBdzQMrVV+wdqzSH0As8GVlLGfn/o0GOjhwcWodUqc
         L0mY79bDMFUCi+t+cJJgewX685mVnubO1vi4gzMM4lNRNM2YRlV1jvP8HIea2WtyRNIO
         sONy2HX3Ce67wcyw/sDnRb223wKSwUe/Fp4Hhu7VlsWG9h2wyciyigGX/Mt+TWqneCaL
         y5Gl+h/gkotRCZIUWixJJVEVjca9APfeI1bFv3SixBH8SsUQznPX4SC3sk409Y2GsjVV
         kkUznGSh0deOVIyDF7MNz3d0BJ38wM5MsbbBMoCWznnRqhEwDN6wcIwdgg7r/ojGNBky
         Bp3g==
X-Forwarded-Encrypted: i=1; AJvYcCUEiXurL22kpH3NXKgWClHFGIujrhZgq8l91+aVb3gknogannTv+KCOotu3Yl2bz3XSdnZiK0nrtrhNgk1L6v7j@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3gh9+yrmsBM+SayScQ1gC8Nu/9G7fZTGtAasXs+W6pm2IRmXF
	B4Dh06MK4fpET79xIXFPocn/KoSsi9mSMcADcnKA2+kQdhf20vZMcTw7gWLcjWE9AkDC942pukg
	T33O+XBmsY0vP17KGxMtP6zBxN2BQPeoJ2iqo
X-Gm-Gg: ASbGncsI4I6tcIKw2AJcxfYso4lDS7O/KYVkI5Kd8cOhjRNc6BxMU7KYtzSO4X+XYIO
	HPDrs2XprNUwAUbXK2IJAAyqWvE1tVGbq5tIps+cyNcs6uYohZ3Gvpic9ooUK2TY=
X-Google-Smtp-Source: AGHT+IGYmV9DrKSyK+sIcpIfNuAhBToIvFRLOhm2e1Cky2WKW0V5T/TEs7nbp6aj4WOQPFxzv7X62gKV2WM3EoOD6OU=
X-Received: by 2002:a05:6e02:1c81:b0:39b:b1f:5be1 with SMTP id
 e9e14a558f8ab-3a70ddcaa9amr3075215ab.1.1731438010984; Tue, 12 Nov 2024
 11:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com> <ZzOg3Xlq2jsG85XQ@x1>
In-Reply-To: <ZzOg3Xlq2jsG85XQ@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 Nov 2024 10:59:59 -0800
Message-ID: <CAP-5=fXsGB97D2CTeXhpiQCzUtbk8gd-GUrvw+um8Jx8tRU2=A@mail.gmail.com>
Subject: Re: [PATCH v7 00/10] perf record --off-cpu: Dump off-cpu samples directly
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 10:39=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$        git am ./v7_20241108_how=
ardchu95_perf_record_off_cpu_dump_off_cpu_samples_directly.mbx
> Applying: perf record --off-cpu: Add --off-cpu-thresh option
> Applying: perf evsel: Expose evsel__is_offcpu_event() for future use
> Applying: perf record --off-cpu: Parse off-cpu event
> Applying: perf record --off-cpu: Preparation of off-cpu BPF program
> Applying: perf record --off-cpu: Dump off-cpu samples in BPF
> error: corrupt patch at line 107
> Patch failed at 0005 perf record --off-cpu: Dump off-cpu samples in BPF
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abo=
rt".
> hint: Disable this message with "git config advice.mergeConflict false"
> =E2=AC=A2 [acme@toolbox perf-tools-next]$
>
> This is on top of:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git =
tmp.perf-tools-next
>
> The message:
>
> error: corrupt patch at line 107
>
> Doesn't look like a clash with something that changed after you prepared
> this patch set.
>
> If we apply the first 4:
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$        git am ./v7_20241108_how=
ardchu95_perf_record_off_cpu_dump_off_cpu_samples_directly.mbx
> Applying: perf record --off-cpu: Add --off-cpu-thresh option
> Applying: perf evsel: Expose evsel__is_offcpu_event() for future use
> Applying: perf record --off-cpu: Parse off-cpu event
> Applying: perf record --off-cpu: Preparation of off-cpu BPF program
> =E2=AC=A2 [acme@toolbox perf-tools-next]$
>
> Then try to apply just the 5th patch:
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ b4 am -P5 -ctsl --cc-trailers 2=
0241108204137.2444151-2-howardchu95@gmail.com
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ patch -p1 < ./v7_20241108_howar=
dchu95_perf_record_off_cpu_dump_off_cpu_samples_directly.mbx
> patching file tools/perf/util/bpf_skel/off_cpu.bpf.c
> patch: **** malformed patch at line 138:
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$
>
> You have:
>
> @@ -209,6 +268,12 @@ static int off_cpu_stat(u64 *ctx, struct task_struct=
 *prev,
>         pelem->state =3D state;
>         pelem->stack_id =3D stack_id;
>
> +       /*
> +        * If stacks are successfully collected by bpf_get_stackid(), col=
lect them once more
> +        * in task_storage for direct off-cpu sample dumping
> +        */
> +       if (stack_id > 0 && bpf_get_stack(ctx, &pelem->stack, MAX_STACKS =
* sizeof(u64), BPF_F_USER_STACK)) {
> +       }
> +
>  next:
>         pelem =3D bpf_task_storage_get(&tstamp, next, NULL, 0);
>
> @@ -223,11 +288,19 @@ static int off_cpu_stat(u64 *ctx, struct task_struc=
t *prev,
>
> see the -209,6 +268,12? Did you edit it manually? It should be -209,6 +26=
8,13
>
> And also what is the point of that empty if block?

There was some discussion of this already:
https://lore.kernel.org/lkml/CAP-5=3DfVXgQjAh1OFDN7DMp=3Dxw5cAHRaO8j8UQfe4C=
ZHrZc8uFg@mail.gmail.com/
TL;DR, it avoids an unused return value warning.

Thanks,
Ian

> - Arnaldo
>
> On Fri, Nov 08, 2024 at 12:41:27PM -0800, Howard Chu wrote:
> > Changes in v7:
> >  - Make off-cpu event system-wide
> >  - Use strtoull instead of strtoul
> >  - Delete unused variable such as sample_id, and sample_type
> >  - Use i as index to update BPF perf_event map
> >  - MAX_OFFCPU_LEN 128 is too big, make it smaller.
> >  - Delete some bound check as it's always guaranteed
> >  - Do not set ip_pos in BPF
> >  - Add a new field for storing stack traces in the tstamp map
> >  - Dump the off-cpu sample directly or save it in the off_cpu map, not =
both
> >  - Delete the sample_type_off_cpu check
> >  - Use __set_off_cpu_sample() to parse samples instead of a two-pass pa=
rsing
> >
> > Changes in v6:
> >  - Make patches bisectable
> >
> > Changes in v5:
> >  - Delete unnecessary copy in BPF program
> >  - Remove sample_embed from perf header, hard code off-cpu stuff instea=
d
> >  - Move evsel__is_offcpu_event() to evsel.h
> >  - Minor changes to the test
> >  - Edit some comments
> >
> > Changes in v4:
> >  - Minimize the size of data output by perf_event_output()
> >  - Keep only one off-cpu event
> >  - Change off-cpu threshold's unit to microseconds
> >  - Set a default off-cpu threshold
> >  - Print the correct error message for the field 'embed' in perf data h=
eader
> >
> > Changes in v3:
> >  - Add off-cpu-thresh argument
> >  - Process direct off-cpu samples in post
> >
> > Changes in v2:
> >  - Remove unnecessary comments.
> >  - Rename function off_cpu_change_type to off_cpu_prepare_parse
> >
> > v1:
> >
> > As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=3D207323
> >
> > Currently, off-cpu samples are dumped when perf record is exiting. This
> > results in off-cpu samples being after the regular samples. This patch
> > series makes possible dumping off-cpu samples on-the-fly, directly into
> > perf ring buffer. And it dispatches those samples to the correct format
> > for perf.data consumers.
> >
> > Before:
> > ```
> >      migration/0      21 [000] 27981.041319: 2944637851    cycles:P:  f=
fffffff90d2e8aa record_times+0xa ([kernel.kallsyms])
> >             perf  770116 [001] 27981.041375:          1    cycles:P:  f=
fffffff90ee4960 event_function+0xf0 ([kernel.kallsyms])
> >             perf  770116 [001] 27981.041377:          1    cycles:P:  f=
fffffff90c184b1 intel_bts_enable_local+0x31 ([kernel.kallsyms])
> >             perf  770116 [001] 27981.041379:      51611    cycles:P:  f=
fffffff91a160b0 native_sched_clock+0x30 ([kernel.kallsyms])
> >      migration/1      26 [001] 27981.041400: 4227682775    cycles:P:  f=
fffffff90d06a74 wakeup_preempt+0x44 ([kernel.kallsyms])
> >      migration/2      32 [002] 27981.041477: 4159401534    cycles:P:  f=
fffffff90d11993 update_load_avg+0x63 ([kernel.kallsyms])
> >
> > sshd  708098 [000] 18446744069.414584:     286392 offcpu-time:
> >           79a864f1c8bb ppoll+0x4b (/usr/lib/libc.so.6)
> >           585690935cca [unknown] (/usr/bin/sshd)
> > ```
> >
> > After:
> > ```
> >             perf  774767 [003] 28178.033444:        497           cycle=
s:P:  ffffffff91a160c3 native_sched_clock+0x43 ([kernel.kallsyms])
> >             perf  774767 [003] 28178.033445:     399440           cycle=
s:P:  ffffffff91c01f8d nmi_restore+0x25 ([kernel.kallsyms])
> >          swapper       0 [001] 28178.036639:  376650973           cycle=
s:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
> >          swapper       0 [003] 28178.182921:  348779378           cycle=
s:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
> >     blueman-tray    1355 [000] 28178.627906:  100184571 offcpu-time:
> >           7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
> >           7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
> >           7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-=
2.0.so.0.8000.2)
> >           7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.=
0.8000.2)
> >           7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
> >           7fff24e862d8 [unknown] ([unknown])
> >
> >
> >     blueman-tray    1355 [000] 28178.728137:  100187539 offcpu-time:
> >           7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
> >           7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
> >           7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-=
2.0.so.0.8000.2)
> >           7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.=
0.8000.2)
> >           7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
> >           7fff24e862d8 [unknown] ([unknown])
> >
> >
> >          swapper       0 [000] 28178.463253:  195945410           cycle=
s:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
> >      dbus-broker     412 [002] 28178.464855:  376737008           cycle=
s:P:  ffffffff91c000a0 entry_SYSCALL_64+0x20 ([kernel.kallsyms])
> > ```
> >
> > Howard Chu (10):
> >   perf record --off-cpu: Add --off-cpu-thresh option
> >   perf evsel: Expose evsel__is_offcpu_event() for future use
> >   perf record --off-cpu: Parse off-cpu event
> >   perf record --off-cpu: Preparation of off-cpu BPF program
> >   perf record --off-cpu: Dump off-cpu samples in BPF
> >   perf evsel: Assemble offcpu samples
> >   perf record --off-cpu: Disable perf_event's callchain collection
> >   perf script: Display off-cpu samples correctly
> >   perf record --off-cpu: Dump the remaining samples in BPF's stack trac=
e
> >     map
> >   perf test: Add direct off-cpu test
> >
> >  tools/perf/builtin-record.c             |  26 ++++++
> >  tools/perf/builtin-script.c             |   4 +-
> >  tools/perf/tests/builtin-test.c         |   1 +
> >  tools/perf/tests/shell/record_offcpu.sh |  31 ++++++-
> >  tools/perf/tests/tests.h                |   1 +
> >  tools/perf/tests/workloads/Build        |   1 +
> >  tools/perf/tests/workloads/offcpu.c     |  16 ++++
> >  tools/perf/util/bpf_off_cpu.c           | 115 ++++++++++++++----------
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c  |  85 ++++++++++++++++--
> >  tools/perf/util/evsel.c                 |  34 ++++++-
> >  tools/perf/util/evsel.h                 |   2 +
> >  tools/perf/util/off_cpu.h               |   3 +-
> >  tools/perf/util/record.h                |   1 +
> >  13 files changed, 264 insertions(+), 56 deletions(-)
> >  create mode 100644 tools/perf/tests/workloads/offcpu.c
> >
> > --
> > 2.43.0
