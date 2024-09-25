Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ACE147C86;
	Wed, 25 Sep 2024 06:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247527; cv=none; b=bGrxkuexLS9Ne06baS2y40+m4HEA4yBaCmWaWVDlgvVpycwgoIevoHStNUVjCGMVmVp35hZqjMHJAmt/qHpXYw1YW8mGZSogtfiQ2ldGw+0B3gEeQWJVQgZLUWNh0oa4ib9/UQlRdaoF3U/dPU2FdIKk6QYCItDzTE+7Wz2QjWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247527; c=relaxed/simple;
	bh=oQEQIOU3xRCKCtt6gKWxLZdFiwk4IoFuZIHYnzkdnT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l29W2GZpnsvWV0C6g42i8YOHEWqXEnbip11Ed6WAl2DecGSVr5zNHECxuyBKL5x0DCtIRvKD8OX8hyHONzE854qG4MbUkBQXd1P+qt182EBIrqUbapJhj1QU8Gg8x9n/zocxrnJRmfxNemjA+WVUu1sLc2+KGDNYh3XXxmPZgPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V66mjM2h; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V66mjM2h"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e2226b9f246so5171532276.0;
        Tue, 24 Sep 2024 23:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727247525; x=1727852325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzyqNQBATiOvlcrhunJO6Kx8iB7QsrBw6gXMXv7ZsYY=;
        b=V66mjM2hFRbTMECIob3NXpVjFvCVY6LE4bkELG+uQpRLG1BUO7HaNcqHVP7Z9QOD4c
         UdaZE5P0gH1Nwx8v9f8YZuwNlr6HdU3wK8ke2h4+3Rv3psgr6s3M5QPLOg52GMUV5T35
         b4V8pkgs74397WS26jRm1u3Lt0Uco0rCUQhld/2gr+cB+jfORP0vZCwcPk7xsI+TjwDq
         45dsptnCf2Enn7J/+jOS3gszSYN7OiDV/wPHdqZyWAUKy1vWHphbTyjnUaJoZjE11NDN
         ZVG3eAt84UpkmND8CjjPRG97q1risbizWoL4y8Q2Vi98CRwBH35+bpob7iMpB3MgYRQt
         v1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727247525; x=1727852325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzyqNQBATiOvlcrhunJO6Kx8iB7QsrBw6gXMXv7ZsYY=;
        b=c+vIFz+DFBi+cASsZa7j537YjCEgaf06C51q9/iPcKh81E6aYY7jU7102Xkht4QmHH
         doWWABgglHUvDj4eQ+oJaEPo5IKPJhZf9WWCqMRngoPt3W0qzVuo+9ONBwCnqWUlBUhm
         qpYe5DVrP1OAy6Eiwm+EZKpcs/sqtsBR3wu0WK9ctI2mfS6sWegvRTWbTPpE/koVLVkD
         fuVS7V/D4t5T64RhtZQ/GTEz2WYy8+k7ac3XBReGdxAHU3ayS1JJzMwcd5TwzxFUBsu2
         csrHZDPdV9nwZlSlH0FI/i/T7+seCpxQOHCIAR1H2Zz9Vgzcrk+sV3Y1Is3JY6gLh2NA
         X4Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUiBDxT1pIBlP5C4iC24W5twD2n872y8BHtVq1cEelusCjN+AccWakN9iyUNl19XArMlZVc8IcKqXlV/ocL6om+cw==@vger.kernel.org, AJvYcCW87Xga82nhJQc5KrooU8ZZCKsurI2rab0ohsbj1Si8lB6UON+Vdec3cH5qnj4noXYMvfeePvnr7WRB5SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiY6ozjiB4YQcl3RDVTyfLLAaz3p/lLxhYXxGRvxiLOxO5LS3e
	51xHPKC/2f3fp7GZW4CnmtiHqJBDK5CNDdhNk48KNhcyF7M0P+fpRBkObQPxDhSGg0FJiSjarYh
	C9vcmRmPGpiJxJ2kJjtE5I2MIrdI=
X-Google-Smtp-Source: AGHT+IGXbgN+X3HBSvR1Yez99A93uiFJgjAK2wsEpK+WYNMCbdTCkW3BG5gPChatSkS/HZm8L7i2Ih7/6wXg7mnC8R0=
X-Received: by 2002:a05:6902:c0d:b0:e1d:af44:46b5 with SMTP id
 3f1490d57ef6-e24d78242c8mr1223028276.2.1727247524686; Tue, 24 Sep 2024
 23:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807153843.3231451-1-howardchu95@gmail.com> <CAP-5=fVy4HijSq=M6QvFtHpyjw=R7XB8CsbMmFMqzJrmG9t6vg@mail.gmail.com>
In-Reply-To: <CAP-5=fVy4HijSq=M6QvFtHpyjw=R7XB8CsbMmFMqzJrmG9t6vg@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 24 Sep 2024 23:59:36 -0700
Message-ID: <CAH0uvoiq189sQ3JoeD8FWPNMgkyt95LhtSHxg=7zQBpFs00W8A@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] perf record --off-cpu: Dump off-cpu samples directly
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Tue, Sep 24, 2024 at 8:04=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Aug 7, 2024 at 8:38=E2=80=AFAM Howard Chu <howardchu95@gmail.com>=
 wrote:
> >
> > Changes in v4:
> >  - Minimize the size of data output by perf_event_output()
> >  - Keep only one off-cpu event
> >  - Change off-cpu threshold's unit to microseconds
> >  - Set a default off-cpu threshold
> >  - Print the correct error message for the field 'embed' in perf data h=
eader
>
> Hi Howard,
>
> I think this all looks good. There is an outstanding comment for patch
> 2/9 where a definition in a later patch needs moving to patch 2/9.
> There is also a comment in 3/9 where you say you will turn a "=3D" back
> to an "&=3D". These seem like small things to fix, could you rebase and
> post the series? Are there other outstanding issues I'm missing? I'd

Thank you, I fixed them. Namhyung said the sample_embed thing should
be handled with care, so I'll make this sample_embed a special case
for off-cpu, and hard code something, so patches will look more
concise. Will do this,  rebase, and send the series. Sorry for taking
so long. (=E3=80=92=EF=B8=BF=E3=80=92)

Thanks,
Howard
> quite like to see this land.
>
> Thanks,
> Ian
>
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
> >             79a864f1c8bb ppoll+0x4b (/usr/lib/libc.so.6)
> >             585690935cca [unknown] (/usr/bin/sshd)
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
> >             7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
> >             7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
> >             7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libgli=
b-2.0.so.0.8000.2)
> >             7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.s=
o.0.8000.2)
> >             7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
> >             7fff24e862d8 [unknown] ([unknown])
> >
> >
> >     blueman-tray    1355 [000] 28178.728137:  100187539 offcpu-time:
> >             7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
> >             7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
> >             7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libgli=
b-2.0.so.0.8000.2)
> >             7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.s=
o.0.8000.2)
> >             7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
> >             7fff24e862d8 [unknown] ([unknown])
> >
> >
> >          swapper       0 [000] 28178.463253:  195945410           cycle=
s:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
> >      dbus-broker     412 [002] 28178.464855:  376737008           cycle=
s:P:  ffffffff91c000a0 entry_SYSCALL_64+0x20 ([kernel.kallsyms])
> > ```
> >
> >
> > Howard Chu (9):
> >   perf evsel: Set BPF output to system-wide
> >   perf record --off-cpu: Add --off-cpu-thresh
> >   perf record --off-cpu: Parse offcpu-time event
> >   perf record off-cpu: Dump direct off-cpu samples in BPF
> >   perf record --off-cpu: Dump total off-cpu time at the end.
> >   perf evsel: Delete unnecessary =3D 0
> >   perf record --off-cpu: Parse BPF output embedded data
> >   perf header: Add field 'embed'
> >   perf test: Add direct off-cpu dumping test
> >
> >  tools/perf/builtin-record.c             |  26 ++++
> >  tools/perf/builtin-script.c             |   5 +-
> >  tools/perf/tests/builtin-test.c         |   1 +
> >  tools/perf/tests/shell/record_offcpu.sh |  27 ++++
> >  tools/perf/tests/tests.h                |   1 +
> >  tools/perf/tests/workloads/Build        |   1 +
> >  tools/perf/tests/workloads/offcpu.c     |  16 +++
> >  tools/perf/util/bpf_off_cpu.c           | 176 +++++++++++++++---------
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c  | 135 ++++++++++++++++++
> >  tools/perf/util/evsel.c                 |  49 ++++---
> >  tools/perf/util/evsel.h                 |  13 ++
> >  tools/perf/util/header.c                |  12 ++
> >  tools/perf/util/off_cpu.h               |  10 +-
> >  tools/perf/util/record.h                |   1 +
> >  tools/perf/util/session.c               |  16 ++-
> >  15 files changed, 401 insertions(+), 88 deletions(-)
> >  create mode 100644 tools/perf/tests/workloads/offcpu.c
> >
> > --
> > 2.45.2
> >
