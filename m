Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CD7BA3D
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 02:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759113580; cv=none; b=pbfSwfED3pIbNdNk9iIlU5yEenYxRTLJE6b5q7p24m25vhoYFc8zj4ZuiYTXj0Gnk4duEmp/wbr0PMsXiLR79xSC4lV1YSEvoXPZ3J+bvJXhoNvLr6L0r16ola5GjLIxM0bimCLAgfxSWJZfedlikryDKrkttHBwFOG5hgn1s7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759113580; c=relaxed/simple;
	bh=i2eXrDCETyRcAN962lpPJu8MuLsHnqrcB1fuua4NVnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1q3QfcUhJwEBdYsjNvXDTj3hGcM6/pYHgehp4eWoB8DiyeXrvfu9DQAR3ftfsUvJuNlJiTMIUBBoJC5x8+KZcM5NQVvVrZe05MAAtN2AAJtR//R9LhDpIS595PoSeyYB9pNaTNuzdyMxDnuSSAOctbEvHFhYPr5VUOMveTWIEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jM9dHjto; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jM9dHjto"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759113576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+Mo7zuy5xta4oo3UX7idl0F1HdsOv2bgqbQMKiGktQ=;
	b=jM9dHjtofVbEUsJf2ILCMtpZ/PHQqkZsGP7nJMgGchfzmBmeuX38p9Wz//rKII9TtjZ7jb
	bc3X+WjGFzVo1enL+k8d9JgA/zeUW0Csb7tE6mZJUXiT6QXPIpUtwnq9mVu2VEDTGh9iOw
	3Kh53jBsxxDtVVkQ34w490RFkACzaco=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-DpsPckkOOyyUraOEb4S-gA-1; Sun, 28 Sep 2025 22:39:35 -0400
X-MC-Unique: DpsPckkOOyyUraOEb4S-gA-1
X-Mimecast-MFC-AGG-ID: DpsPckkOOyyUraOEb4S-gA_1759113575
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-90dfda98b4bso837208739f.0
        for <linux-perf-users@vger.kernel.org>; Sun, 28 Sep 2025 19:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759113575; x=1759718375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+Mo7zuy5xta4oo3UX7idl0F1HdsOv2bgqbQMKiGktQ=;
        b=wq6sFoE2tFOFIRJMU5Dzd0SpkpuucwB6eNRrelZs2UrpkLuoTDoDpOU0IDFt3jimne
         CWSw3G12ZPjOqktI6R7Y4N108s2yIboFyBDwaoco+hUzdQgLhhwoxFr/MFQyen3AizoD
         grBkS04GOQBKMks643SI5qDjG1IJasr5Z6yy3FkuBj7H0Ygq+T6Z29BJ7OskmImEipG3
         BfdJnJlG0oCyYfOto4cXz2Red9smE0NkSk0HkE6MyBD0pF8tRwkesGXZcFvNcyGnxdJY
         G01nQd6/FdUferHgVkTXe3ITN//fAWNyoWqENfCioREGTbkzUWGDuaAm1dnPLrVqYB8X
         MrIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4liuNFbRK7p5ywrtlUaSivUDkUZe6pQq19iEa1KtdPFWuhT0BWk8EBh1bpxE18HcKR/fJUoZH75HTrjD4dIuw@vger.kernel.org
X-Gm-Message-State: AOJu0YwMLZLORTn63M6P96Ji5oueagSUIH6AmWTvSWLHPXWU46o4QasO
	gPooMHvKqn/X8HkeO9TK4eR7Sxm9ai7qXVdK3/ImRyxv26D6gH/HTtjLm4b7qizRVv/qhT4oLIG
	CKuqTC7FkqEG9LSvtDaIZD3TLmWTs0Y3b+/k+800iGvBu5MkJEqLSq8ZWRVg15nlZybINUABO5S
	73bP48xw6EFsapsJs9PKawIvAsDeoxFFSSTwOhJmAndXsLXw==
X-Gm-Gg: ASbGnctQ9BTFIqw83yLSM7ZQ8vyBxgC6BBuB8XqGNeban3/ZGppEO42cG3yIdQnl1Rk
	uW/oC79gkj4pNU/IyADTyVMbOei2V5TNLTvjil4IOmQEuvPRVxtQOidmWHEHqbc0g1i/fNVM4o6
	psxfjt1KCwSLJ1axzB3Jw3KQ==
X-Received: by 2002:a05:6602:a014:b0:924:2696:a53 with SMTP id ca18e2360f4ac-929ae1631b5mr237888839f.3.1759113574702;
        Sun, 28 Sep 2025 19:39:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFRUAwIuTq/bO5lXqA3tb8EB1CqkX0muxvELaMUmUkWZ78sj3uQCl/xFwhwtOtaX2fjwiHU6qxckCVKvHKw/0=
X-Received: by 2002:a05:6602:a014:b0:924:2696:a53 with SMTP id
 ca18e2360f4ac-929ae1631b5mr237886539f.3.1759113574299; Sun, 28 Sep 2025
 19:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918222202.1353854-1-irogers@google.com> <20250918222202.1353854-4-irogers@google.com>
 <CAATMXfnqCjxSV2wOqDJ9copKMWyR5hNe9p78kwtrn+W7UCV2DQ@mail.gmail.com> <CAP-5=fWb5R3Gu+01Qr0+fu7n=RL8hs2b-timZKzqnATa+DRMyw@mail.gmail.com>
In-Reply-To: <CAP-5=fWb5R3Gu+01Qr0+fu7n=RL8hs2b-timZKzqnATa+DRMyw@mail.gmail.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Sun, 28 Sep 2025 19:39:23 -0700
X-Gm-Features: AS18NWAxqHToub-OqiceaCOIXFL3bCybGNuw6oO7wesyqNlnWgJp-g5NmI-Nk7I
Message-ID: <CAATMXfkcWT+SP0eu9By2VdnLoHY8PdCFWa9MwTNzHMZ7t2UB_Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf test: Avoid uncore_imc/clockticks in
 uniquification test
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

Cool! After applied your patch "[PATCH v2 2/3] perf evsel: Fix
uniquification when PMU given without suffix" and  "[PATCH v2 3/3]
perf test: Avoid uncore_imc/clockticks in uniquification test",
the uniquifying testing passed on both Intel hybrid and non-hybrid machine:

hybrid CPU machine:
>>>>>>>>>>>>>>>>>>
# ./perf test -vv 96
 96: perf stat events uniquifying:
--- start ---
test child forked, pid 40541
Uniquification of PMU sysfs events test
Testing event uncore_imc_free_running/data_read/ is uniquified to
uncore_imc_free_running_0/data_read/
Testing event uncore_imc_free_running/data_total/ is uniquified to
uncore_imc_free_running_0/data_total/
Testing event uncore_imc_free_running/data_write/ is uniquified to
uncore_imc_free_running_0/data_write/
Testing event uncore_imc_free_running/data_read/ is uniquified to
uncore_imc_free_running_1/data_read/
Testing event uncore_imc_free_running/data_total/ is uniquified to
uncore_imc_free_running_1/data_total/
Testing event uncore_imc_free_running/data_write/ is uniquified to
uncore_imc_free_running_1/data_write/
---- end(0) ----
 96: perf stat events uniquifying                                    : Ok
>>>>>>>>>>>>>>>>>>

non-hybrid CPU machine:
>>>>>>>>>>>>>>>>>>
# ./perf test -vv 96
 96: perf stat events uniquifying:
--- start ---
test child forked, pid 114458
Uniquification of PMU sysfs events test
Testing event uncore_iio_free_running/bw_in_port0/ is uniquified to
uncore_iio_free_running_0/bw_in_port0/
Testing event uncore_iio_free_running/bw_in_port1/ is uniquified to
uncore_iio_free_running_0/bw_in_port1/
Testing event uncore_iio_free_running/bw_in_port2/ is uniquified to
uncore_iio_free_running_0/bw_in_port2/
Testing event uncore_iio_free_running/bw_in_port3/ is uniquified to
uncore_iio_free_running_0/bw_in_port3/
Testing event uncore_iio_free_running/bw_in_port4/ is uniquified to
uncore_iio_free_running_0/bw_in_port4/
Testing event uncore_iio_free_running/bw_in_port5/ is uniquified to
uncore_iio_free_running_0/bw_in_port5/
Testing event uncore_iio_free_running/bw_in_port6/ is uniquified to
uncore_iio_free_running_0/bw_in_port6/
Testing event uncore_iio_free_running/bw_in_port7/ is uniquified to
uncore_iio_free_running_0/bw_in_port7/
Testing event uncore_iio_free_running/ioclk/ is uniquified to
uncore_iio_free_running_0/ioclk/
... ...
Testing event uncore_imc_free_running/dclk/ is uniquified to
uncore_imc_free_running_0/dclk/
Testing event uncore_imc_free_running/rpq_cycles/ is uniquified to
uncore_imc_free_running_0/rpq_cycles/
Testing event uncore_imc_free_running/wpq_cycles/ is uniquified to
uncore_imc_free_running_0/wpq_cycles/
Testing event uncore_imc_free_running/dclk/ is uniquified to
uncore_imc_free_running_1/dclk/
Testing event uncore_imc_free_running/rpq_cycles/ is uniquified to
uncore_imc_free_running_1/rpq_cycles/
Testing event uncore_imc_free_running/wpq_cycles/ is uniquified to
uncore_imc_free_running_1/wpq_cycles/
Testing event uncore_imc_free_running/dclk/ is uniquified to
uncore_imc_free_running_2/dclk/
Testing event uncore_imc_free_running/rpq_cycles/ is uniquified to
uncore_imc_free_running_2/rpq_cycles/
Testing event uncore_imc_free_running/wpq_cycles/ is uniquified to
uncore_imc_free_running_2/wpq_cycles/
Testing event uncore_imc_free_running/dclk/ is uniquified to
uncore_imc_free_running_3/dclk/
Testing event uncore_imc_free_running/rpq_cycles/ is uniquified to
uncore_imc_free_running_3/rpq_cycles/
Testing event uncore_imc_free_running/wpq_cycles/ is uniquified to
uncore_imc_free_running_3/wpq_cycles/
---- end(0) ----
 96: perf stat events uniquifying                                    : Ok
>>>>>>>>>>>>>>>>>>

Tested-by: Qiao Zhao <qzhao@redhat.com>

On Fri, Sep 26, 2025 at 9:22=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Sep 26, 2025 at 2:00=E2=80=AFAM Qiao Zhao <qzhao@redhat.com> wrot=
e:
> >
> > Hi Ian,
> >
> > I tested your patch (latest linux-next code + your patch) on hybrid
> > CPU machine {CPU Model name: 12th Gen Intel(R) Core(TM) i7-12800HE}
> > and failed,
>
> Hi Qiao,
>
> in your output is:
> uncore_imc_free_running_0/uncore_imc_free_running,data_total/
> ie the uncore PMU is reported twice. This is fixed in the immediately
> prior patch in this series:
> https://lore.kernel.org/lkml/20250918222202.1353854-3-irogers@google.com/
>
> Thanks,
> Ian
>
> > >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> > # perf test -vv "perf stat events uniquifying"
> >  95: perf stat events uniquifying:
> > --- start ---
> > test child forked, pid 21799
> > Uniquification of PMU sysfs events test
> > Testing event uncore_imc_free_running/data_read/ is uniquified to
> > uncore_imc_free_running_0/data_read/
> > Uniquification of PMU sysfs events test [Failed]
> > # started on Fri Sep 26 04:49:54 2025
> >
> >
> >  Performance counter stats for 'system wide':
> >
> > CPU0                 1.47 MiB
> > uncore_imc_free_running_0/uncore_imc_free_running,data_read/
> > CPU0                 1.47 MiB
> > uncore_imc_free_running_1/uncore_imc_free_running,data_read/
> >
> >        0.000925108 seconds time elapsed
> >
> > Testing event uncore_imc_free_running/data_total/ is uniquified to
> > uncore_imc_free_running_0/data_total/
> > Uniquification of PMU sysfs events test [Failed]
> > # started on Fri Sep 26 04:49:54 2025
> >
> >
> >  Performance counter stats for 'system wide':
> >
> > CPU0                 0.59 MiB
> > uncore_imc_free_running_0/uncore_imc_free_running,data_total/
> > CPU0                 0.58 MiB
> > uncore_imc_free_running_1/uncore_imc_free_running,data_total/
> >
> >        0.000969877 seconds time elapsed
> >
> > Testing event uncore_imc_free_running/data_write/ is uniquified to
> > uncore_imc_free_running_0/data_write/
> > Uniquification of PMU sysfs events test [Failed]
> > # started on Fri Sep 26 04:49:54 2025
> >
> >
> >  Performance counter stats for 'system wide':
> >
> > CPU0                 0.00 MiB
> > uncore_imc_free_running_0/uncore_imc_free_running,data_write/
> > CPU0                 0.00 MiB
> > uncore_imc_free_running_1/uncore_imc_free_running,data_write/
> >
> >        0.001183888 seconds time elapsed
> >
> > Testing event uncore_imc_free_running/data_read/ is uniquified to
> > uncore_imc_free_running_1/data_read/
> > Uniquification of PMU sysfs events test [Failed]
> > # started on Fri Sep 26 04:49:54 2025
> >
> >
> >  Performance counter stats for 'system wide':
> >
> > CPU0                 0.29 MiB
> > uncore_imc_free_running_0/uncore_imc_free_running,data_read/
> > CPU0                 0.29 MiB
> > uncore_imc_free_running_1/uncore_imc_free_running,data_read/
> >
> >        0.000710088 seconds time elapsed
> >
> > Testing event uncore_imc_free_running/data_total/ is uniquified to
> > uncore_imc_free_running_1/data_total/
> > Uniquification of PMU sysfs events test [Failed]
> > # started on Fri Sep 26 04:49:54 2025
> >
> >
> >  Performance counter stats for 'system wide':
> >
> > CPU0                 0.62 MiB
> > uncore_imc_free_running_0/uncore_imc_free_running,data_total/
> > CPU0                 0.67 MiB
> > uncore_imc_free_running_1/uncore_imc_free_running,data_total/
> >
> >        0.000959074 seconds time elapsed
> >
> > Testing event uncore_imc_free_running/data_write/ is uniquified to
> > uncore_imc_free_running_1/data_write/
> > Uniquification of PMU sysfs events test [Failed]
> > # started on Fri Sep 26 04:49:54 2025
> >
> >
> >  Performance counter stats for 'system wide':
> >
> > CPU0                 0.23 MiB
> > uncore_imc_free_running_0/uncore_imc_free_running,data_write/
> > CPU0                 0.23 MiB
> > uncore_imc_free_running_1/uncore_imc_free_running,data_write/
> >
> >        0.000775028 seconds time elapsed
> >
> > ---- end(-1) ----
> >  95: perf stat events uniquifying                                    : =
FAILED!
> > >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> > # ls -la /sys/bus/event_source/devices/uncore_imc_free_running_*/events=
/
> > /sys/bus/event_source/devices/uncore_imc_free_running_0/events/:
> > total 0
> > drwxr-xr-x. 2 root root    0 Sep 26 04:57 .
> > drwxr-xr-x. 5 root root    0 Sep 26 01:49 ..
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_read
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_read.scale
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_read.unit
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_total
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_total.scale
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_total.unit
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_write
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_write.scale
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_write.unit
> >
> > /sys/bus/event_source/devices/uncore_imc_free_running_1/events/:
> > total 0
> > drwxr-xr-x. 2 root root    0 Sep 26 04:57 .
> > drwxr-xr-x. 5 root root    0 Sep 26 01:49 ..
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_read
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_read.scale
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_read.unit
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_total
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_total.scale
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_total.unit
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_write
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_write.scale
> > -r--r--r--. 1 root root 4096 Sep 26 01:49 data_write.unit
> >
> > - Qiao
> >
> > >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >
> >
> > On Fri, Sep 19, 2025 at 6:22=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > The detection of uncore_imc may happen for free running PMUs and the
> > > clockticks event may be present on uncore_clock. Rewrite the test to
> > > detect duplicated/deduplicated events from perf list, not hardcoded t=
o
> > > uncore_imc.
> > >
> > > If perf stat fails then assume it is permissions and skip the test.
> > >
> > > Fixes: 070b315333ee ("perf test: Restrict uniquifying test to machine=
s with 'uncore_imc'")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  .../tests/shell/stat+event_uniquifying.sh     | 109 ++++++++--------=
--
> > >  1 file changed, 49 insertions(+), 60 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools=
/perf/tests/shell/stat+event_uniquifying.sh
> > > index bf54bd6c3e2e..b5dec6b6da36 100755
> > > --- a/tools/perf/tests/shell/stat+event_uniquifying.sh
> > > +++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
> > > @@ -4,74 +4,63 @@
> > >
> > >  set -e
> > >
> > > -stat_output=3D$(mktemp /tmp/__perf_test.stat_output.XXXXX)
> > > -perf_tool=3Dperf
> > >  err=3D0
> > > +stat_output=3D$(mktemp /tmp/__perf_test.stat_output.XXXXX)
> > >
> > > -test_event_uniquifying() {
> > > -  # We use `clockticks` in `uncore_imc` to verify the uniquify behav=
ior.
> > > -  pmu=3D"uncore_imc"
> > > -  event=3D"clockticks"
> > > -
> > > -  # If the `-A` option is added, the event should be uniquified.
> > > -  #
> > > -  # $perf list -v clockticks
> > > -  #
> > > -  # List of pre-defined events (to be used in -e or -M):
> > > -  #
> > > -  #   uncore_imc_0/clockticks/                           [Kernel PMU=
 event]
> > > -  #   uncore_imc_1/clockticks/                           [Kernel PMU=
 event]
> > > -  #   uncore_imc_2/clockticks/                           [Kernel PMU=
 event]
> > > -  #   uncore_imc_3/clockticks/                           [Kernel PMU=
 event]
> > > -  #   uncore_imc_4/clockticks/                           [Kernel PMU=
 event]
> > > -  #   uncore_imc_5/clockticks/                           [Kernel PMU=
 event]
> > > -  #
> > > -  #   ...
> > > -  #
> > > -  # $perf stat -e clockticks -A -- true
> > > -  #
> > > -  #  Performance counter stats for 'system wide':
> > > -  #
> > > -  # CPU0            3,773,018      uncore_imc_0/clockticks/
> > > -  # CPU0            3,609,025      uncore_imc_1/clockticks/
> > > -  # CPU0                    0      uncore_imc_2/clockticks/
> > > -  # CPU0            3,230,009      uncore_imc_3/clockticks/
> > > -  # CPU0            3,049,897      uncore_imc_4/clockticks/
> > > -  # CPU0                    0      uncore_imc_5/clockticks/
> > > -  #
> > > -  #        0.002029828 seconds time elapsed
> > > -
> > > -  echo "stat event uniquifying test"
> > > -  uniquified_event_array=3D()
> > > +cleanup() {
> > > +  rm -f "${stat_output}"
> > >
> > > -  # Skip if the machine does not have `uncore_imc` device.
> > > -  if ! ${perf_tool} list pmu | grep -q ${pmu}; then
> > > -    echo "Target does not support PMU ${pmu} [Skipped]"
> > > -    err=3D2
> > > -    return
> > > -  fi
> > > +  trap - EXIT TERM INT
> > > +}
> > >
> > > -  # Check how many uniquified events.
> > > -  while IFS=3D read -r line; do
> > > -    uniquified_event=3D$(echo "$line" | awk '{print $1}')
> > > -    uniquified_event_array+=3D("${uniquified_event}")
> > > -  done < <(${perf_tool} list -v ${event} | grep ${pmu})
> > > +trap_cleanup() {
> > > +  echo "Unexpected signal in ${FUNCNAME[1]}"
> > > +  cleanup
> > > +  exit 1
> > > +}
> > > +trap trap_cleanup EXIT TERM INT
> > >
> > > -  perf_command=3D"${perf_tool} stat -e $event -A -o ${stat_output} -=
- true"
> > > -  $perf_command
> > > +test_event_uniquifying() {
> > > +  echo "Uniquification of PMU sysfs events test"
> > >
> > > -  # Check the output contains all uniquified events.
> > > -  for uniquified_event in "${uniquified_event_array[@]}"; do
> > > -    if ! cat "${stat_output}" | grep -q "${uniquified_event}"; then
> > > -      echo "Event is not uniquified [Failed]"
> > > -      echo "${perf_command}"
> > > -      cat "${stat_output}"
> > > -      err=3D1
> > > -      break
> > > -    fi
> > > +  # Read events from perf list with and without -v. With -v the dupl=
icate PMUs
> > > +  # aren't deduplicated. Note, json events are listed by perf list w=
ithout a
> > > +  # PMU.
> > > +  read -ra pmu_events <<< "$(perf list --raw pmu)"
> > > +  read -ra pmu_v_events <<< "$(perf list -v --raw pmu)"
> > > +  # For all non-deduplicated events.
> > > +  for pmu_v_event in "${pmu_v_events[@]}"; do
> > > +    # If the event matches an event in the deduplicated events then =
it musn't
> > > +    # be an event with duplicate PMUs, continue the outer loop.
> > > +    for pmu_event in "${pmu_events[@]}"; do
> > > +      if [[ "$pmu_v_event" =3D=3D "$pmu_event" ]]; then
> > > +        continue 2
> > > +      fi
> > > +    done
> > > +    # Strip the suffix from the non-deduplicated event's PMU.
> > > +    event=3D$(echo "$pmu_v_event" | sed -E 's/_[0-9]+//')
> > > +    for pmu_event in "${pmu_events[@]}"; do
> > > +      if [[ "$event" =3D=3D "$pmu_event" ]]; then
> > > +        echo "Testing event ${event} is uniquified to ${pmu_v_event}=
"
> > > +        if ! perf stat -e "$event" -A -o ${stat_output} -- true; the=
n
> > > +          echo "Error running perf stat for event '$event'  [Skip]"
> > > +          if [ $err =3D 0 ]; then
> > > +            err=3D2
> > > +          fi
> > > +          continue
> > > +        fi
> > > +        # Ensure the non-deduplicated event appears in the output.
> > > +        if ! grep -q "${pmu_v_event}" "${stat_output}"; then
> > > +          echo "Uniquification of PMU sysfs events test [Failed]"
> > > +          cat "${stat_output}"
> > > +          err=3D1
> > > +        fi
> > > +        break
> > > +      fi
> > > +    done
> > >    done
> > >  }
> > >
> > >  test_event_uniquifying
> > > -rm -f "${stat_output}"
> > > +cleanup
> > >  exit $err
> > > --
> > > 2.51.0.470.ga7dc726c21-goog
> > >
> > >
> >
>

