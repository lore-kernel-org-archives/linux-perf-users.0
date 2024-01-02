Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A2D171DB
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jan 2024 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEqjXs76"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e70b9a840so327e87.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jan 2024 14:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704235278; x=1704840078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wwtp0RapXDF0AyHO608G8Unzpht3Heb8Iz8vVndZq5w=;
        b=NEqjXs76mqmtyU/cFyccztmvnGEoJeDuTGPBKijlgv1eJ6TqkVhQgbKsWx95HfnUuj
         nTe3aiH13R/UlJW1OBaNgVfC/QtxTk0WfxGbWmxFyLPmiNWWUmuUWsz0LrzC+N29gTTD
         6k4745XQRPxdaSK35cnAiOg75uSJ0iYXchG8lUomb9Jp2EX26pnjqG1GFt3//sFvejyC
         /Lmt4JT3YLBykvzkcmFV7cTzDh81bawBO78cUu3onJ0Bt3yaFTS/DnI+Jn/ZQGj21YP4
         7ySgtKiuToU9ZRBY5OvVipGGRoYLTrX7HWw4jOWFwJAsxhG9ZAHBYfiNSxzLD358D0od
         kuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704235278; x=1704840078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wwtp0RapXDF0AyHO608G8Unzpht3Heb8Iz8vVndZq5w=;
        b=a4WqzAF9YnhRcADv1S9Rl+pSIasIvsUR85OVuSfm807x95aN4c1JlwGlEpaE9mhmYX
         P5v+mko2c/XbNZtofWRT58PP7l7/Yl7NtApPjBiX2/rXL+uIr8/giTit9EcjxWd1XJMZ
         azU9IrKUq/ntGobDNWrEUbEWA5zvKSLW/Q3maIahSK4yi6YWp0BaHElSt1tjFj7FTbQU
         /d7rQ+eKmljGFeNDJWxYY6pS7f7G0nSPgpTPQW0M1CY3klUsoy+AfPaztx6p6XSoaXyl
         DWrWzZ1PQsLRzn+KZxcRfwoInpkYQBB8GA3zPi0/VbmT/89La1ygBCK3h4GsjZw5G9Xb
         +95w==
X-Gm-Message-State: AOJu0Yw4Na28YSF8ER8fdlXBfRF/xo0ExM84q02VKaWUop/ePb2zdZmM
	nKthruHYJ8jZVPWkSXcc9KuTMS3Dic/ih/bilgOtGJC8+ASz
X-Google-Smtp-Source: AGHT+IGVMLm/Qdswcgr6++8fjw86gx7rCSFOlLefssE2dScC7t0YnCZsP0VVmz+WyzEm/PqMxxnZEUAP1GxvR2MsZcw=
X-Received: by 2002:ac2:58fc:0:b0:50e:9f94:1c37 with SMTP id
 v28-20020ac258fc000000b0050e9f941c37mr1559lfo.7.1704235278375; Tue, 02 Jan
 2024 14:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZYbm5L7tw7bdpDpE@kernel.org> <4d86f3b6-eaee-4673-bdf5-3b97c1c1ad17@linux.intel.com>
In-Reply-To: <4d86f3b6-eaee-4673-bdf5-3b97c1c1ad17@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Jan 2024 14:41:07 -0800
Message-ID: <CAP-5=fUfJ-VBGS1D2+WM_eBu4uPGvxJ2KyD4WXzgKRCfGKHTQQ@mail.gmail.com>
Subject: Re: perf test hybrid failing on 14700K
To: "Liang, Kan" <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 7:43=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2023-12-23 8:55 a.m., Arnaldo Carvalho de Melo wrote:
> > Hi Kan,
> >
> > I noticed the following problem, are you able to reproduce it?
> >
> > Happy solstice!
>
> Happy new year!
>
> >
> > - Arnaldo
> >
> > root@number:/home/acme/Downloads# grep "model name" -m1 /proc/cpuinfo
> > model name    : Intel(R) Core(TM) i7-14700K
> > root@number:/home/acme/Downloads# uname -a
> > Linux number 6.6.4-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Sun Dec  3 18=
:13:11 UTC 2023 x86_64 GNU/Linux
> > root@number:/home/acme/Downloads# perf -vv
> > perf version 6.7.rc6.g63daba4e2861
> >                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
> >     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
> >          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
> >                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
> >             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
> >                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> >                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> >                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
> >              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> >               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> >              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
> >              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
> >     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
> >                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
> >                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> >              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> >                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> >                    aio: [ on  ]  # HAVE_AIO_SUPPORT
> >                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> >                libpfm4: [ on  ]  # HAVE_LIBPFM
> >          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
> >          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
> > root@number:/home/acme/Downloads# perf test 75
> >  75: x86 hybrid                                                      : =
FAILED!
>
> The failure should be a regression caused by the a24d9d9dc096 ("perf
> parse-events: Make legacy events lower priority than sysfs/JSON")
>
> @@ -1004,10 +1012,19 @@ static int config_term_pmu(struct
> perf_event_attr *attr,
>                                                            err_str, /*hel=
p=3D*/NULL);
>                         return -EINVAL;
>                 }
> -               attr->type =3D PERF_TYPE_HARDWARE;
> -               attr->config =3D term->val.num;
> -               if (perf_pmus__supports_extended_type())
> -                       attr->config |=3D (__u64)pmu->type << PERF_PMU_TY=
PE_SHIFT;
> +               /*
> +                * If the PMU has a sysfs or json event prefer it over
> +                * legacy. ARM requires this.
> +                */
> +               if (perf_pmu__have_event(pmu, term->config))
> For Intel hybrid, the perf_pmu__have_event() should be always true for
> all hw events and hw cache events. So the patch will mistakenly update
> the type to TYPE_USER. However, On Intel platforms, the type of the hw
> events should be TYPE_HARDWARE.
>
> Seems ARM needs to find another way to distinguish the case.
>
> Ian, any suggestions?

Hi Kan/Mark,

Firstly, the perf_pmu__have_event is a test of whether
/sys/devices/<pmu>/events or the equivalent json events have the
specified event string like "inst_retired.any" - ie it isn't a test of
whether the event is supported by the kernel. Mark was quite insistent
that the behavior be changed so that if a legacy event is specified
with a PMU, the PMU's sysfs/json event is the priority which is a big
behavior change on x86.

To get the test passing again I've sent out a test update:
https://lore.kernel.org/lkml/20240102215732.1125997-1-irogers@google.com/
This switches the legacy events in the test to ones which don't have
sysfs or json equivalents. The test is somewhat brittle as an x86 PMU
change could decide to add /sys/devices/cpu/events/cycles alongside
/sys/devices/cpu/events/cpu-cycles. Ideally we'd be testing all events
on core PMUs, for legacy events they may have a sysfs/json override
and the test expectation should expect this and assert that the type
isn't PERF_TYPE_HARDWARE, etc. For now what I sent out is sufficient
to get the "x86 hybrid" test passing. I should probably have done the
whole Reported-by.. thing, sorry for missing that.

Thanks,
Ian

>
> +                       term->type_term =3D PARSE_EVENTS__TERM_TYPE_USER;
> +                       term->no_value =3D true;
> +               } else {
> +                       attr->type =3D PERF_TYPE_HARDWARE;
> +                       attr->config =3D term->val.num;
> +                       if (perf_pmus__supports_extended_type())
> +                               attr->config |=3D (__u64)pmu->type << PER=
F_PMU_TYPE_SHIFT;
> +               }
>                 return 0;
>         }
>         if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_USER ||
>
>
> Thanks,
> Kan
> > root@number:/home/acme/Downloads# perf test -v 75
> >  75: x86 hybrid                                                      :
> > --- start ---
> > test child forked, pid 4111587
> > Using CPUID GenuineIntel-6-B7-1
> > running test 0 'cpu_core/cpu-cycles/'
> > FAILED arch/x86/tests/hybrid.c:30 wrong type
> > Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu_c=
ore/cpu-cycles/,cpu_core/instructions/}'
> > FAILED arch/x86/tests/hybrid.c:42 wrong type
> > Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions=
/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
> > FAILED arch/x86/tests/hybrid.c:65 wrong type
> > Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running te=
st 3 '{cpu_core/cpu-cycles/,cpu-clock}'
> > FAILED arch/x86/tests/hybrid.c:78 wrong type
> > Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running te=
st 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
> > FAILED arch/x86/tests/hybrid.c:95 wrong type
> > Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instruction=
s/u}'running test 5 'r1a'
> > running test 6 'cpu_core/r1a/'
> > running test 7 'cpu_core/config=3D10,config1,config2=3D3,period=3D1000/=
u'
> > WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported b=
y kernel)!
> > running test 8 'cpu_core/LLC-loads/'
> > test child finished with -1
> > ---- end ----
> > x86 hybrid: FAILED!
> > root@number:/home/acme/Downloads#
> >
> > root@number:/home/acme/Downloads# perf trace -e perf_event_open perf te=
st -F -v 75
> >  75: x86 hybrid                                                      :
> > --- start ---
> > Using CPUID GenuineIntel-6-B7-1
> > running test 0 'cpu_core/cpu-cycles/'
> > FAILED arch/x86/tests/hybrid.c:30 wrong type
> > Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu_c=
ore/cpu-cycles/,cpu_core/instructions/}'
> > FAILED arch/x86/tests/hybrid.c:42 wrong type
> > Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions=
/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
> > FAILED arch/x86/tests/hybrid.c:65 wrong type
> > Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running te=
st 3 '{cpu_core/cpu-cycles/,cpu-clock}'
> > FAILED arch/x86/tests/hybrid.c:78 wrong type
> > Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running te=
st 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
> > FAILED arch/x86/tests/hybrid.c:95 wrong type
> > Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instruction=
s/u}'running test 5 'r1a'
> > running test 6 'cpu_core/r1a/'
> > running test 7 'cpu_core/config=3D10,config1,config2=3D3,period=3D1000/=
u'
> > WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported b=
y kernel)!
> > running test 8 'cpu_core/LLC-loads/'
> > ---- end ----
> > x86 hybrid: FAILED!
> >      0.000 ( 0.008 ms): :4115165/4115165 perf_event_open(attr_uptr: { t=
ype: 0 (PERF_TYPE_HARDWARE), config: 0xa00000000, disabled: 1, { bp_len, co=
nfig2 }: 0x900000000, branch_sample_type: USER|COUNTERS, sample_regs_user: =
0x3ecaddffffffff, sample_stack_user: 4115165, clockid: 925535355, sample_re=
gs_intr: 0x8140c90000a8f7, sample_max_stack: 8, sig_data: 120259084288 }, c=
pu: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 3
> >      0.010 ( 0.002 ms): :4115165/4115165 perf_event_open(attr_uptr: { t=
ype: 0 (PERF_TYPE_HARDWARE), config: 0x400000000, disabled: 1, { bp_len, co=
nfig2 }: 0x900000000, branch_sample_type: USER|COUNTERS, sample_regs_user: =
0x3ecaddffffffff, sample_stack_user: 4115165, clockid: 925538919, sample_re=
gs_intr: 0x8140c90000a8f7, sample_max_stack: 8, sig_data: 120259084288 }, c=
pu: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 4
> > root@number:/home/acme/Downloads# strace -e perf_event_open perf test -=
F -v 75
> >  75: x86 hybrid                                                      :
> > --- start ---
> > Using CPUID GenuineIntel-6-B7-1
> > running test 0 'cpu_core/cpu-cycles/'
> > FAILED arch/x86/tests/hybrid.c:30 wrong type
> > Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu_c=
ore/cpu-cycles/,cpu_core/instructions/}'
> > FAILED arch/x86/tests/hybrid.c:42 wrong type
> > Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions=
/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
> > FAILED arch/x86/tests/hybrid.c:65 wrong type
> > Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running te=
st 3 '{cpu_core/cpu-cycles/,cpu-clock}'
> > FAILED arch/x86/tests/hybrid.c:78 wrong type
> > Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running te=
st 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
> > FAILED arch/x86/tests/hybrid.c:95 wrong type
> > Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instruction=
s/u}'running test 5 'r1a'
> > running test 6 'cpu_core/r1a/'
> > running test 7 'cpu_core/config=3D10,config1,config2=3D3,period=3D1000/=
u'
> > WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported b=
y kernel)!
> > running test 8 'cpu_core/LLC-loads/'
> > perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3D0 /* PERF_ATTR_SIZE_=
??? */, config=3D0xa<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=3D0, sampl=
e_type=3D0, read_format=3D0, disabled=3D1, precise_ip=3D0 /* arbitrary skid=
 */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) =3D 3
> > perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3D0 /* PERF_ATTR_SIZE_=
??? */, config=3D0x4<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=3D0, sampl=
e_type=3D0, read_format=3D0, disabled=3D1, precise_ip=3D0 /* arbitrary skid=
 */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) =3D 4
> > ---- end ----
> > x86 hybrid: FAILED!
> > +++ exited with 0 +++
> > root@number:/home/acme/Downloads#
> >
