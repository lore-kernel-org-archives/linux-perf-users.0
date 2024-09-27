Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A6381B1;
	Fri, 27 Sep 2024 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469082; cv=none; b=nm/KqLoIE/lXImSi8d0P7lZwd45Oz5urmEAjDFvR5WYvSCdBCi0axjei83mQXXAnIdgAWPqEfYjNuH92zPljafXB0q1XNYNn7QSr3z3/7aQtt7ZJEvnBXdakVnfxn3NX2th3RU+LKZ8IPfYClcqMOaR3hpcx1ialEgGELXhlwiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469082; c=relaxed/simple;
	bh=9dSRJZcXh2ervxAKCG8NtovwITt89yV3KlYPqt2C0cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVKC5R9raJI3US5hctHi41U9gra/oEKA7/TcS+2pB2loqTgCzB31xsb9BQpKb+gsTwramOU9s2unLot+ua+9+I7JBP2uHxaV9GhHt+Wenzu/vRGJqe1qaWN5o01x4gut1Zghqo1XGbzYw1t/WPLMHqUhWLJC+BRnmQmmN11L1Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xi/YrAx6; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi/YrAx6"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6db836c6bd7so24991877b3.3;
        Fri, 27 Sep 2024 13:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727469079; x=1728073879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kDPoVhzp+eDmm6+Au/7tcJpUbsRCxjUnI5744obY9c=;
        b=Xi/YrAx6sSDR0Y1t8x0B6D3gU1/tm3TPgpFqU75I447C2jSxsy1w4Luaq3s+QFVAss
         nUpf34g9k/FMW2XPDUex0P7S5ounUEn138WEY3tUDGVoV0LKK2l4bQe/6+Nvx302wZIc
         hASiN+pFPDLu/qz769CrvpdTqOlr1I+jFJho2KDNPkQeWsVrBAu9aU1yko4J+FFMg7wA
         lGQ/EU5UUPLM5U4dXwvP0zdSb4hsg8mHxeJxw5nbPatZ40fIBpCA9qD9aZSpqFjah82/
         58TGIU2B9RDGSVI6MCbLde8sHU3ABQ8PZnipG37y5FHDrobrPTn5k7/pibqqOR6saR0x
         P45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727469079; x=1728073879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kDPoVhzp+eDmm6+Au/7tcJpUbsRCxjUnI5744obY9c=;
        b=FUNWzSyjy6ThWIvDaYPejC3nuxuNRAAlYmxLz8is9lg8EZFtujk/49mmSGU0/4guO2
         NAkfDEk5ygnvU2UGFCIwCHNcFbISJY2YZfTL5xsF34dVMUoeHSpsjPpwaT+e+UJVwdgx
         +BQ1+iC1V8Md46wpgHb4A0sW5/JpfDzgwG8ylV7UND2mbphih10osFia+Kc21904j8or
         j2VSKXYbSUqVRQ7gH6mK4ezFrFsLFf0xumxfE61GjkMDo+G155adgscVmJQbDPzWcKHn
         c6nGSuTPjQGDZoI0H/ic2D56CSr9sXpuVF0BvQ4d143N2RRP/eExEIy4w/by8IeWpwpg
         IwNg==
X-Forwarded-Encrypted: i=1; AJvYcCU4BxNcnu9uCwPD4AV5YrynPzyOrakY4tvNjm/Wc/9NK9SHy7LwWy3lJ8VvlbKN16AEGmhkW3zGCC/A4+uQ3ZOozQ==@vger.kernel.org, AJvYcCU9t9gbdBlkfymShwpYBcEvsb3LWmzpvyVSNmqQJ9IUo8cSWbLJgjtccicr76d/2FNwrcJa95SW7Pdsdoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2AteVjgd+rmUa4Z6k/58yhxUyaJCKRSWFZuagpnvYtx6GCxhH
	ggvZzalfx1z9JxKeP0qgyyAvPAupnxZ3axdwrOZHDtVAXUizDOFp60KayRk3EFq7udG40yUFhZ2
	7ZmaSCYRUgODdv7gSik4OvXLDQS8=
X-Google-Smtp-Source: AGHT+IEoVdybVPEv3yNhiimTogIKAfSPj3LcSHshkHTosGjBBu899863vpWFpWXvi+6uhiBhJvnxyFZ+dxzXi6VjBOQ=
X-Received: by 2002:a05:690c:660b:b0:6e2:ef1:2583 with SMTP id
 00721157ae682-6e24750a5d4mr43800097b3.9.1727469079323; Fri, 27 Sep 2024
 13:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927185340.658143-1-howardchu95@gmail.com> <ZvcCDkrzwilKYQR2@x1>
In-Reply-To: <ZvcCDkrzwilKYQR2@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 27 Sep 2024 13:31:08 -0700
Message-ID: <CAH0uvohTkodXTbLN3OWXOXpBg1En7YGse8M1dYhjEczjhfJFMA@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] perf record --off-cpu: Dump off-cpu samples directly
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

Thank you, made them bisectable on v6 (link:
https://lore.kernel.org/linux-perf-users/20240927202736.767941-1-howardchu9=
5@gmail.com/).

Thanks,
Howard

On Fri, Sep 27, 2024 at 12:05=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Sep 27, 2024 at 11:53:32AM -0700, Howard Chu wrote:
> > Changes in v5:
> >  - Delete unnecessary copy in BPF program
> >  - Remove sample_embed from perf header, hard code off-cpu stuff instea=
d
> >  - Move evsel__is_offcpu_event() to evsel.h
> >  - Minor changes to the test
> >  - Edit some comments
>
> Thanks, I'll try to review and test this early next week, and check on
> bisectability issues as you mentioned privately.
>
> Thanks!
>
> - Arnaldo
>
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
> > Howard Chu (8):
> >   perf evsel: Set off-cpu BPF output to system-wide
> >   perf record --off-cpu: Add --off-cpu-thresh
> >   perf record --off-cpu: Parse offcpu-time event
> >   perf record off-cpu: Dump direct off-cpu samples in BPF
> >   perf record --off-cpu: Dump total off-cpu time at the end.
> >   perf evsel: Delete unnecessary =3D 0
> >   perf record --off-cpu: Parse BPF output embedded data
> >   perf test: Add direct off-cpu dumping test
> >
> >  tools/perf/builtin-record.c             |  26 ++++
> >  tools/perf/builtin-script.c             |   4 +-
> >  tools/perf/tests/builtin-test.c         |   1 +
> >  tools/perf/tests/shell/record_offcpu.sh |  29 ++++
> >  tools/perf/tests/tests.h                |   1 +
> >  tools/perf/tests/workloads/Build        |   1 +
> >  tools/perf/tests/workloads/offcpu.c     |  16 +++
> >  tools/perf/util/bpf_off_cpu.c           | 174 +++++++++++++++---------
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c  | 123 +++++++++++++++++
> >  tools/perf/util/evsel.c                 |  47 ++++---
> >  tools/perf/util/evsel.h                 |   6 +
> >  tools/perf/util/off_cpu.h               |  10 +-
> >  tools/perf/util/record.h                |   1 +
> >  tools/perf/util/session.c               |  12 +-
> >  14 files changed, 359 insertions(+), 92 deletions(-)
> >  create mode 100644 tools/perf/tests/workloads/offcpu.c
> >
> > --
> > 2.43.0
