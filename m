Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B6613213A
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046648; cv=none; b=aiNEuRNY8vvTdO8v2bww4M0U/Nfwi+1suKFHPcqGprSc48blj4bBtZRN3OBWT8y7O2C3bJWisNtssmMRHjgahLPkP/Dw8RB/TXnlVS8vcGOn+cKU8C4BlzUfcERHvoPNr96miWPtB/bh4MqcWwuzPe8LVBhSTFu0OrgFMElKfFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046648; c=relaxed/simple;
	bh=8Q/HAcOWW10Wfu6QyHmyd5Q0soNFUEE7javOSm5ye2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ul6xCoCWyQZtfRqSLsgM0SM/FhuCZz/AgJa18QfngOGQucexjTlHd0FqNZjWh29+1Et80U2c1GNla+4bfUSjSq2SljqthuAmvNUu1Uj1VA7OaVB2sn8suSxVkm/3V/Oem2GsBO3k2W1J/ZrlApPOmSUdgWoeUqNavCsUgu/cfh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cWXivQeg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cWXivQeg"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fed726aefcso439045ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Aug 2024 09:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723046646; x=1723651446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XynK2BpMdyOBcdJAwEW97KiTbwRbYddVxKkhDAkMWK4=;
        b=cWXivQeg2SxUZETn/FVITNqqJlSEPl7MzUXHm5+LcFWTAn+lptk0a+7Dgog17G0u5H
         BLd6mISwqSpJTdUe8XPeVmje1RMe83yI3PoFnhm38xLIiwfB+T2N4JmpoAV3+yKW71QJ
         J02qqazfGDSPncGI+/UwtYo8E0ois8232ZDnhSFhs2JYasKLu/qKNrJRNreD1aJWxe9g
         M1MHv3GSIe/dia9KHdDgclpfMQZtV/tf76qMN35tAhUWuFFsfRX174qRvdjhKK726fyk
         +OHvXoQw4CXDJPHiraxUn/jMYc6uJ5CRmCupBdj+KKUF2/eh0Lw86H85qgmhSuwEiY01
         1dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723046646; x=1723651446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XynK2BpMdyOBcdJAwEW97KiTbwRbYddVxKkhDAkMWK4=;
        b=ib8BSIjjNDUG/OLC1dEQxJ3uhgH+UfPmx31EgTE/2wvTj7EdmjZQGWBJJE56LQW8Yq
         S09J1BlkJyTHOdOLoCqiTRSbs1vIs1mig8aLCGF0+BJNZHbm87f6sRZeJfrVuXEs3HxH
         dJEjM9NHtNrUreeEgllc4hz1qql3fj2olCJYo9hQKC5250PaFlUotg/XUOHdasQEpxgm
         thx0LHRtc/jbMlfXzYJ36JevBo5Hz4HXsElcJKy8K6lQeJSeOSlG0ya5dv/YtPvvfchk
         P5W88V6jkUY7FgRZa75uDhXqA0bffH9//zfoTyyvo1zJl/fLWnzwNSlel9DK0a4J3jd/
         QoRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCuqOakGc1hPOuCI+kUj34vqSzzCBY3713BQgMessy7vWaSF5mr4yzpnSXxYdXusqF61tEEEYJGaqI38MvepmqZB3opfAIKnbmnOQ54ofLng==
X-Gm-Message-State: AOJu0Yzv2Sf4brxteABYy+xMA5Vfyi9UsHWSmOEK1qq8UxbhfoglHSJN
	NJyqsujXY5ZGtKn9Y6/U8wVPZ//6rRyIvaHJhQ/NA16AHMpNmMs+pLVJ+ZCbQmwRBBOZa33JoXN
	bW/PG+nzOB+sZ41+52kqX6ykWEdG/GvzmQ8nx
X-Google-Smtp-Source: AGHT+IHzqx8qvcekhiBeXZcj6lhQEOhGANGLW0VXBI3+flBuJkI6sUNh+r9BXd0d9yrYIonzu8m5yWxTKMjsiAhaayc=
X-Received: by 2002:a17:903:1107:b0:1fb:52b1:27ca with SMTP id
 d9443c01a7336-20084fb9e76mr3055445ad.9.1723046645759; Wed, 07 Aug 2024
 09:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807065136.1039977-1-irogers@google.com> <277a02a5-9355-4f06-9158-026cf4b330f7@linux.intel.com>
 <ZrONok4ZhoA6FhNi@x1> <CAP-5=fWge5+AunVPoy-jxk=5xJeCD8gwFAd0vWk8K8Jif3DB-Q@mail.gmail.com>
In-Reply-To: <CAP-5=fWge5+AunVPoy-jxk=5xJeCD8gwFAd0vWk8K8Jif3DB-Q@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 7 Aug 2024 09:03:41 -0700
Message-ID: <CAP-5=fWfLqk0naUJGRKBEN93_xy4SXSdjF24Z01FGnGhJf0pJQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf hist: Fix reference counting of branch_info
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 8:42=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Wed, Aug 7, 2024 at 8:07=E2=80=AFAM Arnaldo Carvalho de Melo <acme@ker=
nel.org> wrote:
> >
> > On Wed, Aug 07, 2024 at 09:27:02AM -0400, Liang, Kan wrote:
> > >
> > >
> > > On 2024-08-07 2:51 a.m., Ian Rogers wrote:
> > > > iter_finish_branch_entry doesn't put the branch_info from/to map
> > > > elements creating memory leaks. This can be seen with:
> > > >
> > > > ```
> > > > $ perf record -e cycles -b perf test -w noploop
> > > > $ perf report -D
> > > > ...
> > > > Direct leak of 984344 byte(s) in 123043 object(s) allocated from:
> > > >     #0 0x7fb2654f3bd7 in malloc libsanitizer/asan/asan_malloc_linux=
.cpp:69
> > > >     #1 0x564d3400d10b in map__get util/map.h:186
> > > >     #2 0x564d3400d10b in ip__resolve_ams util/machine.c:1981
> > > >     #3 0x564d34014d81 in sample__resolve_bstack util/machine.c:2151
> > > >     #4 0x564d34094790 in iter_prepare_branch_entry util/hist.c:898
> > > >     #5 0x564d34098fa4 in hist_entry_iter__add util/hist.c:1238
> > > >     #6 0x564d33d1f0c7 in process_sample_event tools/perf/builtin-re=
port.c:334
> > > >     #7 0x564d34031eb7 in perf_session__deliver_event util/session.c=
:1655
> > > >     #8 0x564d3403ba52 in do_flush util/ordered-events.c:245
> > > >     #9 0x564d3403ba52 in __ordered_events__flush util/ordered-event=
s.c:324
> > > >     #10 0x564d3402d32e in perf_session__process_user_event util/ses=
sion.c:1708
> > > >     #11 0x564d34032480 in perf_session__process_event util/session.=
c:1877
> > > >     #12 0x564d340336ad in reader__read_event util/session.c:2399
> > > >     #13 0x564d34033fdc in reader__process_events util/session.c:244=
8
> > > >     #14 0x564d34033fdc in __perf_session__process_events util/sessi=
on.c:2495
> > > >     #15 0x564d34033fdc in perf_session__process_events util/session=
.c:2661
> > > >     #16 0x564d33d27113 in __cmd_report tools/perf/builtin-report.c:=
1065
> > > >     #17 0x564d33d27113 in cmd_report tools/perf/builtin-report.c:18=
05
> > > >     #18 0x564d33e0ccb7 in run_builtin tools/perf/perf.c:350
> > > >     #19 0x564d33e0d45e in handle_internal_command tools/perf/perf.c=
:403
> > > >     #20 0x564d33cdd827 in run_argv tools/perf/perf.c:447
> > > >     #21 0x564d33cdd827 in main tools/perf/perf.c:561
> > > > ...
> > > > ```
> > > >
> > > > Clearing up the map_symbols properly creates maps reference count
> > > > issues so resolve those. Resolving this issue doesn't improve peak
> > > > heap consumption for the test above.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > >
> > > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> >
> > Thanks, applying.
> >
> > While trying to test it:
> >
> > make -k CORESIGHT=3D1 EXTRA_CFLAGS=3D"-fsanitize=3Dmemory" CC=3Dclang H=
OSTCC=3Dclang NO_LIBTRACEEVENT=3D1 NO_LIBELF=3D1 BUILD_BPF_SKEL=3D0 NO_LIBP=
FM=3D1 O=3D/tmp/build/$(basename $PWD)/ -C tools/perf install-bin
> >
> > Used that from a previous patch description from Ian to get rid of some
> > other problems with those other libraries:
> >
> > =E2=AC=A2[acme@toolbox perf-tools-next]$  perf record -e cycles -b perf=
 test -w noploop
> > Uninitialized bytes in fopen64 at offset 46 inside [0x7fff1077e890, 52)
> > =3D=3D1948231=3D=3DWARNING: MemorySanitizer: use-of-uninitialized-value
> >     #0 0x7921df in perf_pmu_format__load pmu.c
> >     #1 0x791f3e in perf_pmu__warn_invalid_formats (/home/acme/bin/perf+=
0x791f3e) (BuildId: d7742e31f05abb200493b431a6191afda9ed77c8)
> >     #2 0x6f62d0 in __add_event parse-events.c
> >     #3 0x6fa681 in __parse_events_add_numeric parse-events.c
> >     #4 0x6fa3e4 in parse_events_add_numeric (/home/acme/bin/perf+0x6fa3=
e4) (BuildId: d7742e31f05abb200493b431a6191afda9ed77c8)
> >     #5 0x78c6ca in parse_events_parse (/home/acme/bin/perf+0x78c6ca) (B=
uildId: d7742e31f05abb200493b431a6191afda9ed77c8)
> >     #6 0x6fd8eb in __parse_events (/home/acme/bin/perf+0x6fd8eb) (Build=
Id: d7742e31f05abb200493b431a6191afda9ed77c8)
> >     #7 0x6ff232 in parse_events_option (/home/acme/bin/perf+0x6ff232) (=
BuildId: d7742e31f05abb200493b431a6191afda9ed77c8)
> >     #8 0x5be82f in get_value /home/acme/git/perf-tools-next/tools/lib/s=
ubcmd/parse-options.c
> >     #9 0x5ba474 in parse_short_opt /home/acme/git/perf-tools-next/tools=
/lib/subcmd/parse-options.c:351:11
> >     #10 0x5ba474 in parse_options_step /home/acme/git/perf-tools-next/t=
ools/lib/subcmd/parse-options.c:539:12
> >     #11 0x5ba474 in parse_options_subcommand /home/acme/git/perf-tools-=
next/tools/lib/subcmd/parse-options.c:653:10
> >     #12 0x4f089f in cmd_record (/home/acme/bin/perf+0x4f089f) (BuildId:=
 d7742e31f05abb200493b431a6191afda9ed77c8)
> >     #13 0x56fda9 in run_builtin perf.c
> >     #14 0x56e9ea in main (/home/acme/bin/perf+0x56e9ea) (BuildId: d7742=
e31f05abb200493b431a6191afda9ed77c8)
> >     #15 0x7fbf387ea087 in __libc_start_call_main (/lib64/libc.so.6+0x2a=
087) (BuildId: 8f53abaad945a669f2bdcd25f471d80e077568ef)
> >     #16 0x7fbf387ea14a in __libc_start_main@GLIBC_2.2.5 (/lib64/libc.so=
.6+0x2a14a) (BuildId: 8f53abaad945a669f2bdcd25f471d80e077568ef)
> >     #17 0x4364e4 in _start (/home/acme/bin/perf+0x4364e4) (BuildId: d77=
42e31f05abb200493b431a6191afda9ed77c8)
> >
> > SUMMARY: MemorySanitizer: use-of-uninitialized-value pmu.c in perf_pmu_=
format__load
> > Exiting
> > =E2=AC=A2[acme@toolbox perf-tools-next]$
> >
> > So I think there is something else nor merged or is this something new?
>
> Taking a look. You are setting HOSTCC here presumably to work past a
> libbpf build error I see. Why are we building libbpf with HOSTCC and
> not CC?

The memory sanitizer error is a false positive. The msan interceptor
hasn't worked for vfscanf so it doesn't understand that type was
written to as an out argument. We know it must have been as the result
of the vscanf is compared with 1 to make sure it was read:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.c?h=3Dperf-tools-next#n1105
To work around the false positive you can change "__u32 type;" to be
"__u32 type =3D 0;".

To diagnose this I added to EXTRA_CFLAGS
-fsanitize-memory-track-origins=3D2. This yielded:
```
=3D=3D1069181=3D=3DWARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x556c8f187881 in __perf_pmus__find_by_type tools/perf/util/pmus.c:2=
45:7
    #1 0x556c8f186f6e in perf_pmus__find_by_type tools/perf/util/pmus.c:258=
:25
    #2 0x556c8ed2c3ea in parse_events_add_numeric
tools/perf/util/parse-events.c:1398:55
    #3 0x556c8f129795 in parse_events_parse tools/perf/util/parse-events.y:=
348:8
    #4 0x556c8ed3e5fe in parse_events__scanner
tools/perf/util/parse-events.c:1871:8
    #5 0x556c8ed3f85b in __parse_events tools/perf/util/parse-events.c:2140=
:8
    #6 0x556c8ed48553 in parse_events_option
tools/perf/util/parse-events.c:2343:8
    #7 0x556c8e6720cc in get_value tools/lib/subcmd/parse-options.c:251:10
    #8 0x556c8e668a63 in parse_short_opt tools/lib/subcmd/parse-options.c:3=
51:11
    #9 0x556c8e65c55f in parse_options_step
tools/lib/subcmd/parse-options.c:539:12
    #10 0x556c8e659066 in parse_options_subcommand
tools/lib/subcmd/parse-options.c:653:10
    #11 0x556c8e65fd07 in parse_options tools/lib/subcmd/parse-options.c:69=
1:9
    #12 0x556c8e07fe11 in cmd_record tools/perf/builtin-record.c:3995:9
    #13 0x556c8e5cf19b in run_builtin tools/perf/perf.c:350:11
    #14 0x556c8e5caa3a in handle_internal_command tools/perf/perf.c:403:8
    #15 0x556c8e5ce677 in run_argv tools/perf/perf.c:447:2
    #16 0x556c8e5c8e77 in main tools/perf/perf.c:561:3
    #17 0x7f4218443b89 in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #18 0x7f4218443c44 in __libc_start_main csu/../csu/libc-start.c:360:3

  Uninitialized value was stored to memory at
    #0 0x556c8f1447f9 in perf_pmu__lookup tools/perf/util/pmu.c:1123:12
    #1 0x556c8f198a68 in perf_pmu__find2 tools/perf/util/pmus.c:184:9
    #2 0x556c8f186b26 in pmu_read_sysfs tools/perf/util/pmus.c:223:3
    #3 0x556c8f18995b in perf_pmus__scan_core tools/perf/util/pmus.c:295:3
    #4 0x556c8f196347 in perf_pmus__num_core_pmus tools/perf/util/pmus.c:62=
8:17
    #5 0x556c8f1999ad in __perf_pmus__supports_extended_type
tools/perf/util/pmus.c:638:6
    #6 0x556c8f196599 in perf_pmus__init_supports_extended_type
tools/perf/util/pmus.c:653:40
    #7 0x7f42184aa276 in __pthread_once_slow nptl/pthread_once.c:116:7

  Uninitialized value was created by an allocation of 'type' in the stack f=
rame
    #0 0x556c8f143d50 in perf_pmu__lookup tools/perf/util/pmu.c:1091:2

SUMMARY: MemorySanitizer: use-of-uninitialized-value
tools/perf/util/pmus.c:245:7 in __perf_pmus__find_by_type
    #0 0x556c8f143d50 in perf_pmu__lookup
/home/irogers/kernel.org2/tools/perf/util/pmu.c:1091:2

SUMMARY: MemorySanitizer: use-of-uninitialized-value
/home/irogers/kernel.org2/tools/perf/util/pmus.c:245:7 in
__perf_pmus__find_by_type
```

As I say, there's no way for type to be uninitialized, the vscanf
ensures it, so this is an msan interceptor issue. Fwiw, it can be
difficult to use msan without fully recompiling things like libc, this
is how I test perf inside of Google's monorepo with msan. Address
sanitizer, that includes leak sanitizer, is less fussy but it lacks
interceptors for things like the BPF system call. Ideally distros
would ship sanitizer builds of things like libc in the same way they
ship developer/debug packages.

Thanks,
Ian
