Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE76B154C0C;
	Mon, 29 Jul 2024 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266700; cv=none; b=N1rN2LiCj6s3vJJjfiK9BOFGJ2B9eGBJlqUJlU2tPucGAEyZA0jUGMoUD4n39FjFjUTu810Mg7tWCgj4rFmnGqXN6YNuXZpETwsbvIj4sZgAb46jOeR0Gb5FH48lGd6UqCzWPOr5Iaj38KphFo6XMADCnOtbK3R11Seo5qjfErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266700; c=relaxed/simple;
	bh=QP++Bsl3vngh40fhy1FftozspKdpktl2FxdG68Z69tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIUhSJPaOG9agQ40YguUKCOlRlTjd9CNqGTp9zGYGcX8WGiE6Z8O9uGSP/KvQgB8tjwpYtKpqxhlwNe4z6ylMKiZmaUp746uYcK6zxO524uQw/fIbg8Y6dL5/AR4UtMYfpe1zOlUkIHtaiyLoISMFyG4AMzUPB3cyRHEMRujPrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrMCwAKa; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrMCwAKa"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-66a048806e6so21459057b3.3;
        Mon, 29 Jul 2024 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722266698; x=1722871498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrWzyoHDY0V4iGBJS/oMZhZ3e1fyseejnIzoqwILk7k=;
        b=NrMCwAKaSJvLzvYVIcpQ0CrZivE7TwSIUnCDeN1QgqcaVUQPRDTZS+5js5DQ0oM9/p
         Ni6ikgIeKL3NED0i5eZDcQlvnnPECw2jjmTsYCnvcZ/uIXpFte9HVIfBBQYdK+HGVRXk
         niOucjyMSr9xMiLHC9sc4BaEqsDbjimhS3N1LDBNpTCaDO9zlC8+a7v/fz3iBkZpIJe9
         ct1d8Sog+DTy1j2usrmQawRxYLOT3NuehbQo0wV+PWLzw4TNymK4+WylnMgC5zCSqogX
         k2DSGW6uhwyYHfpJCHYtjFMVi21xJZWBZr95rxJuda0zfgjCkJw9mKYn7i8VG/g9xCiu
         Umiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722266698; x=1722871498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrWzyoHDY0V4iGBJS/oMZhZ3e1fyseejnIzoqwILk7k=;
        b=MYIm9COrWODsvJXItFMtAsDQW0VrfsV7FkMN8qt1K+qm2ZwshPwTqYt1QT/7bzAX41
         dmaHYw1c7dX2xTqTigw0cHemPSkOr+Qw++uqH5huJmUJ+p859aas/gs+3E1xYjVef3oy
         e5mJOk0N0m1ww2K3eBkwDiCs8jWRsY6m47T0dNgT7NP/IR0kVW97hgdGoyTOtFjvQxYc
         NjnAITbLEQ6Q7tWRKRIfdFieZuzISv4CePZWkCCEJIFel2ATwWG6ojBkk773JfXyK21h
         Tinfe7RYb437PeziDVt6aIMz1Oy5yDZH63H396H37X01HdEL3uaFoAjzeYI2Cku2uqu0
         1icw==
X-Forwarded-Encrypted: i=1; AJvYcCVIgSCnEKwnDKTk7zXw63el2VUQdNJzvt2n4hWS2JUeecW/YkqcZRg2CbGDJ2UlYeA8qsSFxPqN5KtIJQnxn7vJGO4wUogv4eAfLFp99GL78l/R59JCVbrZi9Gex5TV7Bo+TnMTc+6DSGXkipW4xw==
X-Gm-Message-State: AOJu0YzVZxJlpnJM1s8lgtCai9PXC5DhJH3+Go9q3S3g4SQQd2+mQ7zG
	3N3UjiXTSbBlkCUev0FqMw1IUf8SKwzhHAiZT3gFvrYXX7RdHNzVGQcOA4YKgAess1qs15V2Ab2
	Le4qzWaaKV57Zp9Z5iDihmrsYc9iTEU04Kv8=
X-Google-Smtp-Source: AGHT+IFi1mUw7+OXZM88XpZHe1uOHrLiQ08btL6rXZKEZ1bU7UM8Cxy8sQUiNrvhbyqWtZ9G/byeLF9mxfNurz5sv+0=
X-Received: by 2002:a81:b410:0:b0:645:8fb:71c8 with SMTP id
 00721157ae682-67a0a13665amr94555087b3.37.1722266697647; Mon, 29 Jul 2024
 08:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726102826.787004-1-howardchu95@gmail.com> <ZqbutBvHOJ0SPd64@google.com>
In-Reply-To: <ZqbutBvHOJ0SPd64@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 29 Jul 2024 23:24:47 +0800
Message-ID: <CAH0uvogRFE_gXhSQTbXJiu-Yj2b+H1U4K40bDOgwTFyTOtHFDA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Dump off-cpu samples directly
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

Thanks for reviewing this patch.

On Mon, Jul 29, 2024 at 9:21=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello Howard,
>
> On Fri, Jul 26, 2024 at 06:28:21PM +0800, Howard Chu wrote:
> > As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=3D207323
> >
> > Currently, off-cpu samples are dumped when perf record is exiting. This
> > results in off-cpu samples being after the regular samples. This patch
> > series makes possible dumping off-cpu samples on-the-fly, directly into
> > perf ring buffer. And it dispatches those samples to the correct format
> > for perf.data consumers.
>
> Thanks for your work!
>
> But I'm not sure we need a separate event for offcpu-time-direct.  If we
> fix the format for the direct event, we can adjust the format of offcpu-
> time when it dumps at the end.

Thank you and Ian for this advice, I'll do that.

>
> Anyway, as far as I can see you don't need to fill the sample info in
> the offcpu-time-direct manually in your BPF program.  Because the
> bpf_perf_event_output() will call perf_event_output() which fills all
> the sample information according to the sample_type flags.
>
> Well.. it'll set IP to the schedule function, but it should be ok.
> (updating IP using CALLCHAIN like in off_cpu_write() is a kinda hack and
> not absoluately necessary, probably I can get rid of it..  Let's go with
> simple for now.)
>
> So I think what you need is to ensure it has the uncessary flags.  And
> the only info it needs to fill is the time between the previous schedule
> and this can be added to the raw data.

Sure thing, thank you. Other than the off-cpu duration, do you think
we should collect the callchain as well?

This idea is great because it minimizes the data we need to transfer
from kernel space to user space. But with this, the whole
"full-fledged sample in BPF output" is not the case anymore, because
we only take a couple of things(such as the time between the
schedules) from the raw data. This idea is more like an extension of
the sample data, I think it's interesting, will try to implement it.

Thanks,
Howard
>
> Thanks,
> Namhyung
>
> >
> > Changes in v3:
> >  - Add off-cpu-thresh argument
> >  - Process direct off-cpu samples in post
> >
> > Changes in v2:
> >  - Remove unnecessary comments.
> >  - Rename function off_cpu_change_type to off_cpu_prepare_parse
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
> >     blueman-tray    1355 [000] 28178.627906:  100184571 offcpu-time-dir=
ect:
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
> >     blueman-tray    1355 [000] 28178.728137:  100187539 offcpu-time-dir=
ect:
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
> > Howard Chu (5):
> >   perf record off-cpu: Add direct off-cpu event
> >   perf record off-cpu: Dumping samples in BPF
> >   perf record off-cpu: processing of embedded sample
> >   perf record off-cpu: save embedded sample type
> >   perf record off-cpu: Add direct off-cpu test
> >
> >  tools/perf/builtin-record.c             |   2 +
> >  tools/perf/builtin-script.c             |   2 +-
> >  tools/perf/tests/builtin-test.c         |   1 +
> >  tools/perf/tests/shell/record_offcpu.sh |  29 +++++
> >  tools/perf/tests/tests.h                |   1 +
> >  tools/perf/tests/workloads/Build        |   1 +
> >  tools/perf/tests/workloads/offcpu.c     |  16 +++
> >  tools/perf/util/bpf_off_cpu.c           |  53 ++++++++-
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c  | 143 ++++++++++++++++++++++++
> >  tools/perf/util/evsel.c                 |  16 ++-
> >  tools/perf/util/evsel.h                 |  13 +++
> >  tools/perf/util/header.c                |  12 ++
> >  tools/perf/util/off_cpu.h               |   1 +
> >  tools/perf/util/record.h                |   1 +
> >  tools/perf/util/session.c               |  23 +++-
> >  15 files changed, 309 insertions(+), 5 deletions(-)
> >  create mode 100644 tools/perf/tests/workloads/offcpu.c
> >
> > --
> > 2.45.2
> >
