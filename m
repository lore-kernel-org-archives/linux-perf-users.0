Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B456E17FABA
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Jun 2024 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204223; cv=none; b=mTO4YJfblpbm+lQO9mWtqhYlJP/C86OZUkK2btTEEZS8MW0XvEF5VeohFr7WVS40RRRNijatTaTxqnLjBBAS1zM2Zr7W4vHv6XqrCwkIc1sr1PncNO8ERKNmElPWzjFm1czRbarpLeVR9muPaQousw4Z8B3G/w+tWCqFKYqXeIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204223; c=relaxed/simple;
	bh=kXvqJOj2qmIJtlSAfCsHO42GGGkuDIC0ENSaA26lh7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwGElxuj7k9Z9HDAtdRh+yfutCw27hKdKROwhKAghU94I8Fh49Q5jG7y/WcNabgcvZ1bZwDVGBm69ZkoTdOwJ5mpYQcl+jeY7yWiUNVEmMi3ZvVG+QlxnCw1UaC0LZleFrrFO91YJ4vQ9D5ZkOp2pBBrD06vPzHg4qcJhzC2qOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DtdtnfeD; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DtdtnfeD"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-375bb80e5b8so133655ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jun 2024 07:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718204220; x=1718809020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Plug/FubSS9ewmpduy54mROO8mLilKQ8oOX0XAiB/Gs=;
        b=DtdtnfeDIzv2aHUdLeehBrRIXrgnG39ZxfDCbqrBnnr1KFr6oXG3tume+V6wBO/fmx
         QjgUR0EVBLh3bLpIjy9a3RpkikjSGqhC23XlKYvOOHXrpmzTbJLe6c3b0/X7cG6K6rKN
         vlrQtwgnGU62ZjIfOnuRDGwv+SQVC8YLl1Qap6AZzTLPtH8nb/xbf3Tt8B9x3FWqqWPY
         +O7XpyU87FjNYN8sRGAMLtG4Nl8QsNTvdGhNoz3PWqwWwtB8o3q/nRvHuUzFPo6BLea3
         27sApHvd1J3hKD76gJuJ/1c4xRuAhv9igfP9QatNsrSwHOaObpvP2lXDShmwnT+UQZFU
         HInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718204220; x=1718809020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Plug/FubSS9ewmpduy54mROO8mLilKQ8oOX0XAiB/Gs=;
        b=KDpTSTCn4QHX1j1wE5Fnt/7zngCO0GQIU2oypPuexS/o2M/SkM+kGtR5FQxL99XvSg
         zaaa/lU/T0P8m+7c1Ipd4CymNetdpLWw4PU7BwwrqCrKp1Sza1lKyUsYT8uaisV4G4SU
         N39pYcSJnOh+5KKfJP/ID9BGAGi7jf6UmfxIEvRm+75wkU3YZQ8Iguw3d46Su0TrWcaX
         RDlme576bx7XxbZ8rYPa6y1NyPJ7CeWRPcQQmaQbZM0vxpGXb5WSD0FLbyRlXuIJYfE1
         anjnNWDSuOWx7VqGvR/lvmqjUkIA5iwtT/IQcyCU9fTRCMpAw8+giLkbDp5QAKw8331W
         jJkw==
X-Forwarded-Encrypted: i=1; AJvYcCUns4Jlju/FggLKlAzYsfTTbkargX/Hq6ffWX1SbwY0Uyu3GJl4fSZOhtUf20isCM9PLZfPHE7xE5qRKUR0p6MwFR4qLd9YbpcEDIghJ+8djw==
X-Gm-Message-State: AOJu0YwPh8oSo3Ot+tVQQmERnvyC2/n/eV/TxJTr95ZDi2f/JepN0d1m
	ZpoB5/WNfcvIXbgYEGOR6j0rJWiH39piuxTr20FSBQQs1X6SJbmo/KYe6VOBj79OVTJWDnj1rOE
	n4XPC9JZB2Uh/JDhLtLPBmm9OQ1ZI8B8ymmc7
X-Google-Smtp-Source: AGHT+IE+R7i2gqv7zOLcWU1DwOUBcsVM5huisdx3jFVf0F4q7LWHKhAUARQO0XayM9rFqaGH95bCcfkchyDdX1riub8=
X-Received: by 2002:a05:6e02:3188:b0:375:9ed9:1322 with SMTP id
 e9e14a558f8ab-375cb514668mr3822735ab.16.1718204219578; Wed, 12 Jun 2024
 07:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515060114.3268149-1-irogers@google.com> <20240515060114.3268149-2-irogers@google.com>
 <ce31a50b-53db-4c6f-9cb1-242280b0951c@arm.com> <CAP-5=fWxdZ1ibv7Pi0L38+NF-vNWZCtcDS9JVf6k3z9nDsrQQw@mail.gmail.com>
 <e9fc6ce3-d5c5-431d-a628-62742432be47@arm.com>
In-Reply-To: <e9fc6ce3-d5c5-431d-a628-62742432be47@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Jun 2024 07:56:48 -0700
Message-ID: <CAP-5=fXCuQEqumkv1F5wG_dibGaTHoXM1DiDJ8Yr-YUN2dyinQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
To: Robin Murphy <robin.murphy@arm.com>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>, Tuan Phan <tuanphan@os.amperecomputing.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Stephane Eranian <eranian@google.com>, Mark Brown <broonie@kernel.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 6:57=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 12/06/2024 1:32 pm, Ian Rogers wrote:
> > On Wed, Jun 12, 2024 at 4:19=E2=80=AFAM Aishwarya TCV <aishwarya.tcv@ar=
m.com> wrote:
> >>
> >>
> >>
> >> On 15/05/2024 07:01, Ian Rogers wrote:
> >>> The mrvl_ddr_pmu is uncore and has a hexadecimal address suffix while
> >>> the previous PMU sorting/merging code assumes uncore PMU names start
> >>> with uncore_ and have a decimal suffix. Because of the previous
> >>> assumption it isn't possible to wildcard the mrvl_ddr_pmu.
> >>>
> >>> Modify pmu_name_len_no_suffix but also remove the suffix number out
> >>> argument, this is because we don't know if a suffix number of say 100
> >>> is in hexadecimal or decimal. As the only use of the suffix number is
> >>> in comparisons, it is safe there to compare the values as hexadecimal=
.
> >>> Modify perf_pmu__match_ignoring_suffix so that hexadecimal suffixes
> >>> are ignored.
> >>>
> >>> Only allow hexadecimal suffixes to be greater than length 2 (ie 3 or
> >>> more) so that S390's cpum_cf PMU doesn't lose its suffix.
> >>>
> >>> Change the return type of pmu_name_len_no_suffix to size_t to
> >>> workaround GCC incorrectly determining the result could be negative.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>   tools/perf/util/pmu.c  | 33 +++++++++++++--------
> >>>   tools/perf/util/pmus.c | 67 ++++++++++++++++++++++++---------------=
---
> >>>   tools/perf/util/pmus.h |  7 ++++-
> >>>   3 files changed, 65 insertions(+), 42 deletions(-)
> >>>
> >>
> >> Hi Ian,
> >>
> >> Perf test "perf_all_PMU_test" is failing when run against
> >> next-master(next-20240612) kernel with Arm64 on JUNO in our CI. It loo=
ks
> >> like it is failing when run on JUNO alone. Verified by running on othe=
r
> >> boards like RB5 and Ampere_altra and confirming that it does not fail =
on
> >> these boards. Suspecting that the suffixed 'armv8_pmuv3_0' naming coul=
d
> >> be the reason of test failure.
> >>
> >> Reverting the change (3241d46f5f54) seems to fix it.
> >>
> >> This works fine on Linux version v6.10-rc3
> >>
> >> Failure log
> >> ------------
> >> 110: perf all PMU test:
> >> --- start ---
> >> test child forked, pid 8279
> >> Testing armv8_pmuv3/br_immed_retired/
> >> Event 'armv8_pmuv3/br_immed_retired/' not printed in:
> >> # Running 'internals/synthesize' benchmark:
> >> Computing performance of single threaded perf event synthesis by
> >> synthesizing events on the perf process itself:
> >>    Average synthesis took: 1169.431 usec (+- 0.144 usec)
> >>    Average num. events: 35.000 (+- 0.000)
> >>    Average time per event 33.412 usec
> >>    Average data synthesis took: 1225.698 usec (+- 0.102 usec)
> >>    Average num. events: 119.000 (+- 0.000)
> >>    Average time per event 10.300 usec
> >>
> >>   Performance counter stats for 'perf bench internals synthesize':
> >>
> >>          3263664785      armv8_pmuv3_0/br_immed_retired/
> >>
> >>
> >>        25.472854464 seconds time elapsed
> >>
> >>         8.004791000 seconds user
> >>        17.060209000 seconds sys
> >> ---- end(-1) ----
> >> 110: perf all PMU test                                               :
> >> FAILED!
> >
> > Hi Aishwarya,
> >
> > Thanks for reporting an issue. The test should be pretty self
> > explanatory: it is doing a `perf stat -e
> > armv8_pmuv3/br_immed_retired/` and then looking for that in the
> > output. The event armv8_pmuv3/br_immed_retired/ comes from running
> > perf list. As you can see in the output the event did work, so perf
> > stat is working so nothing is actually broken here. What isn't working
> > is the perf stat output matching the command line event and this is
> > because of the unnecessary suffix on ARM's PMU name.
> >
> > We have a problem that ARM have buggy PMU drivers, either from
> > introducing new naming conventions or by just being broken:
> > https://lore.kernel.org/lkml/CAP-5=3DfWNDkOpnYF=3D5v1aQkVDrDWsmw+zYX1pj=
S8hoiYVgZsRGA@mail.gmail.com/
> > I've also asked that ARM step up their testing, for example in the
> > event parsing testing the PMU is hardcoded to the x86 PMU name of
> > 'cpu':
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/parse-events.c?h=3Dperf-tools-next#n2317
> > On a cortex A53, then PMU is named 'armv8_cortex_a53':
> > ```
> > $ ls /sys/devices/armv8_cortex_a53/
> > caps  cpus  events  format  perf_event_mux_interval_ms  power
> > subsystem  type  uevent
> > ```
> > This name appears better, so what's up with ARM's core PMU name?
>
> With Devicetree, we are able to derive a descriptive PMU name from the
> compatible string provided by the DT. Under ACPI, however, all we get
> told is whether each CPU has a usable PMU or not, so the best we can do
> is work out how many different CPU microarchitectures we have overall
> and create a PMU instance for each type. We still don't know *what* each
> one is, just that they're different, hence ending up with a common name
> plus a suffix which we can increment for disambiguation if and when we
> do see something new - userspace can still piece together the "cpus"
> lists and MIDRs to figure out what's what, we just can't do much in the
> kernel itself.
>
> > Anyway, I'm tempted to fix this by just skipping the test on ARM given
> > ARM's overall broken state.
>
> This isn't a driver issue, it's a "the behaviour of 'perf list' changed
> inconsistently" issue. I also had a brief dig into this using a
> different arm64 ACPI system, and I think I can broadly characterise the
> cause. This is prior to 3241d46f5f54:
>
> root@crazy-taxi:~# ./perf-mainline list armv8_pmuv3
>
> List of pre-defined events (to be used in -e or -M):
>
>
> armv8_pmuv3_0:
>    L1-dcache-loads OR armv8_pmuv3_0/L1-dcache-loads/
>    L1-dcache-load-misses OR armv8_pmuv3_0/L1-dcache-load-misses/
>    L1-icache-loads OR armv8_pmuv3_0/L1-icache-loads/
>    L1-icache-load-misses OR armv8_pmuv3_0/L1-icache-load-misses/
>    dTLB-loads OR armv8_pmuv3_0/dTLB-loads/
>    dTLB-load-misses OR armv8_pmuv3_0/dTLB-load-misses/
>    iTLB-loads OR armv8_pmuv3_0/iTLB-loads/
>    iTLB-load-misses OR armv8_pmuv3_0/iTLB-load-misses/
>    branch-loads OR armv8_pmuv3_0/branch-loads/
>    branch-load-misses OR armv8_pmuv3_0/branch-load-misses/
>    l3d_cache_wb OR armv8_pmuv3_0/l3d_cache_wb/        [Kernel PMU event]
>
>
> And this is after:
>
> root@crazy-taxi:~# ./perf-next list armv8_pmuv3
>
> List of pre-defined events (to be used in -e or -M):
>
>
> armv8_pmuv3_0:
>    L1-dcache-loads OR armv8_pmuv3_0/L1-dcache-loads/
>    L1-dcache-load-misses OR armv8_pmuv3_0/L1-dcache-load-misses/
>    L1-icache-loads OR armv8_pmuv3_0/L1-icache-loads/
>    L1-icache-load-misses OR armv8_pmuv3_0/L1-icache-load-misses/
>    dTLB-loads OR armv8_pmuv3_0/dTLB-loads/
>    dTLB-load-misses OR armv8_pmuv3_0/dTLB-load-misses/
>    iTLB-loads OR armv8_pmuv3_0/iTLB-loads/
>    iTLB-load-misses OR armv8_pmuv3_0/iTLB-load-misses/
>    branch-loads OR armv8_pmuv3_0/branch-loads/
>    branch-load-misses OR armv8_pmuv3_0/branch-load-misses/
>    l3d_cache_wb OR armv8_pmuv3/l3d_cache_wb/          [Kernel PMU event]
>
> See the difference in the last line - it appears that CPU PMU events
> which map to common hardware/cache events *do* still report the full PMU
> name, but any PMU-type-specific events show a truncated name in list and
> thus fail the test's strict match against the full name reported by stat.

Thanks Robin. The hardware and cache events are legacy events that are
printed here, the assumption being that core PMUs don't use a suffix:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/print-events.c?h=3Dperf-tools-next#n304
Fwiw these events are knowingly broken on the Apple M? ARM PMUs as
legacy events like L1-dcache-loads will use a legacy encoding which is
broken on this PMU, hence trying to migrate to preferring sysfs/json
events first - the support for which is reverted in v6.10.
The l3d_cache_wb event is not a legacy event and so goes down the
regular PMU event printing route that tries to avoid listing duplicate
PMUs as there may be 10s or 100s of these:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmus.c?h=3Dperf-tools-next#n490
Yes, this was an intentional behavior change as system scale has gotten lar=
ger.
I'm currently thinking that the suffix should just be ignored on core
PMUs, we assume they never have duplicates. Unfortunately the code
just has a name and doesn't know from this whether a PMU is core or
not:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmus.c?h=3Dperf-tools-next#n43
Note, following Kan Liang's advice we've been trying to actually
document the PMU naming convention:
https://lore.kernel.org/lkml/20240606044959.335715-1-irogers@google.com/
The inconsistency here comes from ARM core PMUs using suffixes, which
isn't really intended behavior and will likely screw up, my guess is
around legacy events (the tests of which currently have limited ARM
coverage).

Thanks,
Ian

> Thanks,
> Robin.
