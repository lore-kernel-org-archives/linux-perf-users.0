Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CB012E1CD
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045358; cv=none; b=i17ACfuWKLeuI1vw8sfOFvQdX8SornMTynKREkkDG6PFrgSJqHOysFa9oTNwNUZuLEvtyN3l5UZMsQOzwPGcPEjB/bLAKMubNYTRvEEgxw+o3KAqSBdAkvqkyzpxtwnj8z0BBS7LU3HGwWOqbaqJ1ONKYNy+3RJE9PV01DWfbEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045358; c=relaxed/simple;
	bh=FIuCwcGB6yWytPpKZDSV7rxGdFAn2LjbZ6Pn5fgdESQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rR58yMsWldU/fx/qzhFCo/5QR9d2mR72CEQsYc4Nbc+AqacedQYlb0rywEtPBjIMJ8SXwFYB9TEH7fLQ60NoGZR+Dqv29f/60pt2DPgsd6XLXSChL5SBVa82sRTBjtBW9BPx/LFWcoZdv8lJGqWzZDjP/Sc7Xqi0FByZ3NXyZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lAaiifIx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lAaiifIx"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd657c9199so402435ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Aug 2024 08:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723045356; x=1723650156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvU0ExuYojcXA0XRZ5/zdrNnONP8813olpspTlDaQd8=;
        b=lAaiifIxL5SgkYiK8b3J2oRPQppByjlG5Nosqarx77AH4PzXnI04ccS3J0XVSdlJMt
         PcIdO8vlhfEmB+wn+Ih+AKIBgpXp+CtqFkHM9snFVJALY/AH2sxenPo3PiZupnqw3KNE
         wkACHuQ+L5j4XsaajxGCHC3zPmjC0zHj0yl02dDSqsqTZdVTQrKecM37fumEGqooSJBn
         2Aov7BwE5AvzK7mzktWNsyq9IUhwEPOPSJ2QWJfIn7+Fej9zCIARoBXf4k8lj4QUemXR
         GEDiE+T1gcJ2BNTkzVd8B7Ck+IKY2Ojvm1jQVxyLERX8w7tJFQLM/6brW32iKg0VQVXM
         +F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045356; x=1723650156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvU0ExuYojcXA0XRZ5/zdrNnONP8813olpspTlDaQd8=;
        b=p+8LemoGSqyviJ7OmgR5d6Xbp/IGYgUbMqR+tS/W9jxh0r4dYLHodFX4oxaDWX0rgL
         tcUxcCdt0D8PuqRqbOpWWBfTv99UDWwB5+NsVR0UHIkSxGbCOI1WoKNmCWS8tnksfmHS
         WOuYCOlQsMSZ6hM+vw+w+l3uevAq9NaDI7bL/rlNC6zDSAlr2zAhoVsHDYU08yflmkND
         81GraVAehrAMtYiSVrIcOazmDKMpHt4dxju3+bo3sJCisy0ospmEm6y+sAXhBTwtdCbP
         vMNUfznZ7gGXOEj9ibuaRdnggYs81TAI+2WTdBud2NzPtuuTZY1sbdHmvocsA0PzXDRv
         DclQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHU1pJl+zUj2IQnLvwYpNeF5EIjtW4eUpQP1isjFgwDb7wB6dkSoHBYlU18sG55SRGS8KbF5nr8COONWOy2687r5LrD4jdFEtbatBzp5yLSw==
X-Gm-Message-State: AOJu0YzxSsBIwZn5pGQKLs03Q1195l1UfAQA8RbDsgIo/vzqNvjSimua
	FK6/XFrEFY6q59GqIOIHgvuC8yesV/9CniDkTJW4PXcULrF6HNRepDFH+oI4LysrAgavdxKvoVw
	T1s7EFpzsyab2tdZX950T9tahGKhB7EJCI6Mi
X-Google-Smtp-Source: AGHT+IGWOCCAyEkog4aU/nUnFwQjg5mNCx4lubB/HSeOtQlZ3If8Rr/e2RojHur+C35xWxqqnMr1EDQ0y/rt+u6mQsM=
X-Received: by 2002:a17:902:ecc4:b0:1fb:3e93:79cf with SMTP id
 d9443c01a7336-200851d3e92mr2917165ad.13.1723045355452; Wed, 07 Aug 2024
 08:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807065136.1039977-1-irogers@google.com> <277a02a5-9355-4f06-9158-026cf4b330f7@linux.intel.com>
 <ZrONok4ZhoA6FhNi@x1>
In-Reply-To: <ZrONok4ZhoA6FhNi@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 7 Aug 2024 08:42:23 -0700
Message-ID: <CAP-5=fWge5+AunVPoy-jxk=5xJeCD8gwFAd0vWk8K8Jif3DB-Q@mail.gmail.com>
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

On Wed, Aug 7, 2024 at 8:07=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Wed, Aug 07, 2024 at 09:27:02AM -0400, Liang, Kan wrote:
> >
> >
> > On 2024-08-07 2:51 a.m., Ian Rogers wrote:
> > > iter_finish_branch_entry doesn't put the branch_info from/to map
> > > elements creating memory leaks. This can be seen with:
> > >
> > > ```
> > > $ perf record -e cycles -b perf test -w noploop
> > > $ perf report -D
> > > ...
> > > Direct leak of 984344 byte(s) in 123043 object(s) allocated from:
> > >     #0 0x7fb2654f3bd7 in malloc libsanitizer/asan/asan_malloc_linux.c=
pp:69
> > >     #1 0x564d3400d10b in map__get util/map.h:186
> > >     #2 0x564d3400d10b in ip__resolve_ams util/machine.c:1981
> > >     #3 0x564d34014d81 in sample__resolve_bstack util/machine.c:2151
> > >     #4 0x564d34094790 in iter_prepare_branch_entry util/hist.c:898
> > >     #5 0x564d34098fa4 in hist_entry_iter__add util/hist.c:1238
> > >     #6 0x564d33d1f0c7 in process_sample_event tools/perf/builtin-repo=
rt.c:334
> > >     #7 0x564d34031eb7 in perf_session__deliver_event util/session.c:1=
655
> > >     #8 0x564d3403ba52 in do_flush util/ordered-events.c:245
> > >     #9 0x564d3403ba52 in __ordered_events__flush util/ordered-events.=
c:324
> > >     #10 0x564d3402d32e in perf_session__process_user_event util/sessi=
on.c:1708
> > >     #11 0x564d34032480 in perf_session__process_event util/session.c:=
1877
> > >     #12 0x564d340336ad in reader__read_event util/session.c:2399
> > >     #13 0x564d34033fdc in reader__process_events util/session.c:2448
> > >     #14 0x564d34033fdc in __perf_session__process_events util/session=
.c:2495
> > >     #15 0x564d34033fdc in perf_session__process_events util/session.c=
:2661
> > >     #16 0x564d33d27113 in __cmd_report tools/perf/builtin-report.c:10=
65
> > >     #17 0x564d33d27113 in cmd_report tools/perf/builtin-report.c:1805
> > >     #18 0x564d33e0ccb7 in run_builtin tools/perf/perf.c:350
> > >     #19 0x564d33e0d45e in handle_internal_command tools/perf/perf.c:4=
03
> > >     #20 0x564d33cdd827 in run_argv tools/perf/perf.c:447
> > >     #21 0x564d33cdd827 in main tools/perf/perf.c:561
> > > ...
> > > ```
> > >
> > > Clearing up the map_symbols properly creates maps reference count
> > > issues so resolve those. Resolving this issue doesn't improve peak
> > > heap consumption for the test above.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> >
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>
> Thanks, applying.
>
> While trying to test it:
>
> make -k CORESIGHT=3D1 EXTRA_CFLAGS=3D"-fsanitize=3Dmemory" CC=3Dclang HOS=
TCC=3Dclang NO_LIBTRACEEVENT=3D1 NO_LIBELF=3D1 BUILD_BPF_SKEL=3D0 NO_LIBPFM=
=3D1 O=3D/tmp/build/$(basename $PWD)/ -C tools/perf install-bin
>
> Used that from a previous patch description from Ian to get rid of some
> other problems with those other libraries:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$  perf record -e cycles -b perf t=
est -w noploop
> Uninitialized bytes in fopen64 at offset 46 inside [0x7fff1077e890, 52)
> =3D=3D1948231=3D=3DWARNING: MemorySanitizer: use-of-uninitialized-value
>     #0 0x7921df in perf_pmu_format__load pmu.c
>     #1 0x791f3e in perf_pmu__warn_invalid_formats (/home/acme/bin/perf+0x=
791f3e) (BuildId: d7742e31f05abb200493b431a6191afda9ed77c8)
>     #2 0x6f62d0 in __add_event parse-events.c
>     #3 0x6fa681 in __parse_events_add_numeric parse-events.c
>     #4 0x6fa3e4 in parse_events_add_numeric (/home/acme/bin/perf+0x6fa3e4=
) (BuildId: d7742e31f05abb200493b431a6191afda9ed77c8)
>     #5 0x78c6ca in parse_events_parse (/home/acme/bin/perf+0x78c6ca) (Bui=
ldId: d7742e31f05abb200493b431a6191afda9ed77c8)
>     #6 0x6fd8eb in __parse_events (/home/acme/bin/perf+0x6fd8eb) (BuildId=
: d7742e31f05abb200493b431a6191afda9ed77c8)
>     #7 0x6ff232 in parse_events_option (/home/acme/bin/perf+0x6ff232) (Bu=
ildId: d7742e31f05abb200493b431a6191afda9ed77c8)
>     #8 0x5be82f in get_value /home/acme/git/perf-tools-next/tools/lib/sub=
cmd/parse-options.c
>     #9 0x5ba474 in parse_short_opt /home/acme/git/perf-tools-next/tools/l=
ib/subcmd/parse-options.c:351:11
>     #10 0x5ba474 in parse_options_step /home/acme/git/perf-tools-next/too=
ls/lib/subcmd/parse-options.c:539:12
>     #11 0x5ba474 in parse_options_subcommand /home/acme/git/perf-tools-ne=
xt/tools/lib/subcmd/parse-options.c:653:10
>     #12 0x4f089f in cmd_record (/home/acme/bin/perf+0x4f089f) (BuildId: d=
7742e31f05abb200493b431a6191afda9ed77c8)
>     #13 0x56fda9 in run_builtin perf.c
>     #14 0x56e9ea in main (/home/acme/bin/perf+0x56e9ea) (BuildId: d7742e3=
1f05abb200493b431a6191afda9ed77c8)
>     #15 0x7fbf387ea087 in __libc_start_call_main (/lib64/libc.so.6+0x2a08=
7) (BuildId: 8f53abaad945a669f2bdcd25f471d80e077568ef)
>     #16 0x7fbf387ea14a in __libc_start_main@GLIBC_2.2.5 (/lib64/libc.so.6=
+0x2a14a) (BuildId: 8f53abaad945a669f2bdcd25f471d80e077568ef)
>     #17 0x4364e4 in _start (/home/acme/bin/perf+0x4364e4) (BuildId: d7742=
e31f05abb200493b431a6191afda9ed77c8)
>
> SUMMARY: MemorySanitizer: use-of-uninitialized-value pmu.c in perf_pmu_fo=
rmat__load
> Exiting
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> So I think there is something else nor merged or is this something new?

Taking a look. You are setting HOSTCC here presumably to work past a
libbpf build error I see. Why are we building libbpf with HOSTCC and
not CC?

Thanks,
Ian
