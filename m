Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5A1AB50F
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434915; cv=none; b=PiBuESTLbAXHGyB0SGuynsxxCQdpRk2ZhpultFa2emuERHYo1ykmB2vvr4srFVRR9Q+qpmPau40VnKYysPpXRcePtmPuD1BggzTs+WIr4YDnEQSdBI7XmgqS1C2fzyAxXhdZIjxPuG6UbGc74QKHJB/Z5h2/wKT9B16FL3HL5sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434915; c=relaxed/simple;
	bh=xkqkDf3i33mhoH/6P2vmcvR8WMZ1uNWei51yxApiDeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/MNV0UwwcWV6ZJofZhH7Yo5+meTKfOyXSwRVFTYbHbN+L3ggfgmwSbQqAm1J6mKV7PSVZmalyREopmNHnYmGLct5L58OnRJdXr/WdAdJhC2yJQgTlhZUgpsc/kTo5BFIkZ++mXQfMtu7Juviuy/EBJnChWn84VUT6PgGaw14cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LRNM4SNv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LRNM4SNv"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd7509397bso176415ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 07:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722434912; x=1723039712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keNxJoV67E2HARqoufcyODbzk9VBaHqS9V5YRVqAlLU=;
        b=LRNM4SNv2wgLHgpLT7YMfIVUFUeNOexvN0pSzPEzykMTzIS1HjIQcGtN+T4WBT0qKD
         XT7Y2W0qPDIpfGbMP7EjaHQ2gLD9KxEI0L69IREm/eSdj/+ddxV6PfsrJf9xKj3PRKo+
         YKSCjkd3puaGOIH08pV6Yc9fdWF7GLbZknjUihvKq9r5SuUWMbLHEOcqmq6SDZF4HJsI
         6xp+xjuUT543XCfqd833GAVKqaCNovdnhe7PJVUZItPWVceR5fQFVGTAa5845dX/Ld+s
         Gbu3/0OeFo78l/l2QIF+v3OIT1vVGRNa17s+DCUw8Hb8nWsPgysdPg62uZ/PUIfaolmq
         EyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722434912; x=1723039712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keNxJoV67E2HARqoufcyODbzk9VBaHqS9V5YRVqAlLU=;
        b=CEbFKrXt/TJV+B8KAmAtnmmhuX/QdOUU3VknOLX8jBgb1oUY7FMUA0PxKVUl8Z+2lm
         qYCfeTTjPMK22SKjuRYuCJ8ami5ueOwiWN8I9BlPIK/Ih3hnCZl4YWTbyDyXdU6r1Y7D
         o8SADUsb9zOonapeC/DizpR8RLCvXtiAoOV8x3UCXgNoYPimJNYX3PJYyAOoiURQ+EwM
         hyhPjU4IxNhqHIiYNI0yPdsZm3VOdqPUfOL2cMvteqOonYmmxHiEgAN0dawBRNTj6WD+
         z24LwHkr8YKRFQcsUCPlC8aVPR637V43pEiaVnwH7RINoLgolmrnza5xc4qkRjwZyj7A
         tPhg==
X-Forwarded-Encrypted: i=1; AJvYcCWKlllgI8qYpirGXsvbmen0Idd7xUOGrl712MYZgugW2UVTbbC1ujJBeISu52WryaHZK5sW+AglvrggdW3pZWLMDhm8n6BWfhmjzAmQa34nlg==
X-Gm-Message-State: AOJu0Yz0FIlBIAsEqOk5fN1F8L59GiJnOsog8oI/DEZ8IAbJMtgXE1+f
	+qkKEeHxpE61qJ7U5yExAoglG2aH4I+4xCDIOabZ0Vj62fTN8L5irichOcpQPGskAZsabq440mB
	4N1OhZetjDlzg58p8VFK8RU0TWHkFbtHSHiSS
X-Google-Smtp-Source: AGHT+IHQ+tEHT/q4f3TgbugTF+UsZMruZpaep3e3hGyybeQ+i9b3u1gudJpYjiPs7WjDJCdRxEmZh+WpM+gimocMQU4=
X-Received: by 2002:a17:902:da89:b0:1f4:50b4:a50b with SMTP id
 d9443c01a7336-1ff41881988mr3065805ad.18.1722434911156; Wed, 31 Jul 2024
 07:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730191744.3097329-1-irogers@google.com> <20240730191744.3097329-3-irogers@google.com>
 <Zqo5vVdrkhL5NHJK@x1>
In-Reply-To: <Zqo5vVdrkhL5NHJK@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jul 2024 07:08:18 -0700
Message-ID: <CAP-5=fXyOfPya+TrKVaFhCK3rNY=AuLZLG67ith5YHf_XXVdNg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf jevents: Autogenerate empty-pmu-events.c
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, philip.li@intel.com, oliver.sang@intel.com, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 6:18=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Jul 30, 2024 at 12:17:44PM -0700, Ian Rogers wrote:
> > empty-pmu-events.c exists so that builds may occur without python
> > being installed on a system. Manually updating empty-pmu-events.c to
> > be in sync with jevents.py is a pain, let's use jevents.py to generate
> > empty-pmu-events.c.
>
> What am I missing here?
>
> If it exists so that we can build on a system without python how can we
> use python to generate it?
>
> Now having python in the system is a requirement and thus we don't need
> empty-pmu-events.c anymore?
>
> Can you guys please clarify that?

The requirement for python hasn't changed.

Case 1: no python or NO_JEVENTS=3D1
Build happens using empty-pmu-events.c that is checked in, no python
is required.

Case 2: python
pmu-events.c is created by jevents.py (requiring python) and then built.
This change adds a step where the empty-pmu-events.c is created using
jevents.py and that file is diffed against the checked in version.
This stops the checked in empty-pmu-events.c diverging if changes are
made to jevents.py. If the diff causes the build to fail then you just
copy the diff empty-pmu-events.c over the checked in one.

Thanks,
Ian

> - Arnaldo
>
> > 1) change jevents.py so that an arch and model of none cause
> >    generation of a pmu-events.c without any json. Add a SPDX and
> >    autogenerated warning to the start of the file.
> > > 2) change Build so that if a generated pmu-events.c for arch none and
> >    model none doesn't match empty-pmu-events.c the build fails with a
> >    cat of the differences. Update Makefile.perf to clean up the files
> >    used for this.
> >
> > 3) update empty-pmu-events.c to match the output of jevents.py with
> >    arch and mode of none.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > ---
> >  tools/perf/Makefile.perf                 |   2 +
> >  tools/perf/pmu-events/Build              |  12 +-
> >  tools/perf/pmu-events/empty-pmu-events.c | 894 ++++++++++++++---------
> >  tools/perf/pmu-events/jevents.py         |   6 +-
> >  4 files changed, 562 insertions(+), 352 deletions(-)
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 175e4c7898f0..76bb0925849a 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -1252,6 +1252,8 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBC=
MD)-clean $(LIBSYMBOL)-clean $(
> >               $(OUTPUT)util/intel-pt-decoder/inat-tables.c \
> >               $(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}=
.c \
> >               $(OUTPUT)pmu-events/pmu-events.c \
> > +             $(OUTPUT)pmu-events/test-empty-pmu-events.c \
> > +             $(OUTPUT)pmu-events/empty-pmu-events.log \
> >               $(OUTPUT)pmu-events/metric_test.log \
> >               $(OUTPUT)$(fadvise_advice_array) \
> >               $(OUTPUT)$(fsconfig_arrays) \
> > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> > index 1d18bb89402e..c3fa43c49706 100644
> > --- a/tools/perf/pmu-events/Build
> > +++ b/tools/perf/pmu-events/Build
> > @@ -11,6 +11,8 @@ METRIC_TEST_PY      =3D  pmu-events/metric_test.py
> >  EMPTY_PMU_EVENTS_C =3D pmu-events/empty-pmu-events.c
> >  PMU_EVENTS_C =3D  $(OUTPUT)pmu-events/pmu-events.c
> >  METRIC_TEST_LOG      =3D  $(OUTPUT)pmu-events/metric_test.log
> > +TEST_EMPTY_PMU_EVENTS_C =3D $(OUTPUT)pmu-events/test-empty-pmu-events.=
c
> > +EMPTY_PMU_EVENTS_TEST_LOG =3D $(OUTPUT)pmu-events/empty-pmu-events.log
> >
> >  ifeq ($(JEVENTS_ARCH),)
> >  JEVENTS_ARCH=3D$(SRCARCH)
> > @@ -31,7 +33,15 @@ $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
> >       $(call rule_mkdir)
> >       $(Q)$(call echo-cmd,test)$(PYTHON) $< 2> $@ || (cat $@ && false)
> >
> > -$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(MET=
RIC_TEST_LOG)
> > +$(TEST_EMPTY_PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRI=
C_PY) $(METRIC_TEST_LOG)
> > +     $(call rule_mkdir)
> > +     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none pmu-eve=
nts/arch $@
> > +
> > +$(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_E=
VENTS_C)
> > +     $(call rule_mkdir)
> > +     $(Q)$(call echo-cmd,test)diff -u $? 2> $@ || (cat $@ && false)
> > +
> > +$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(MET=
RIC_TEST_LOG) $(EMPTY_PMU_EVENTS_TEST_LOG)
> >       $(call rule_mkdir)
> >       $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $=
(JEVENTS_MODEL) pmu-events/arch $@
> >  endif
> > diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-=
events/empty-pmu-events.c
> > index 13727421d424..c592079982fb 100644
> > --- a/tools/perf/pmu-events/empty-pmu-events.c
> > +++ b/tools/perf/pmu-events/empty-pmu-events.c
> > @@ -1,196 +1,193 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/*
> > - * An empty pmu-events.c file used when there is no architecture json =
files in
> > - * arch or when the jevents.py script cannot be run.
> > - *
> > - * The test cpu/soc is provided for testing.
> > - */
> > -#include "pmu-events/pmu-events.h"
> > +
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* THIS FILE WAS AUTOGENERATED BY jevents.py arch=3Dnone model=3Dnone =
! */
> > +
> > +#include <pmu-events/pmu-events.h>
> >  #include "util/header.h"
> >  #include "util/pmu.h"
> >  #include <string.h>
> >  #include <stddef.h>
> >
> > -static const struct pmu_event pmu_events__test_soc_cpu[] =3D {
> > -     {
> > -             .name =3D "l3_cache_rd",
> > -             .event =3D "event=3D0x40",
> > -             .desc =3D "L3 cache access, read",
> > -             .topic =3D "cache",
> > -             .long_desc =3D "Attributable Level 3 cache access, read",
> > -     },
> > -     {
> > -             .name =3D "segment_reg_loads.any",
> > -             .event =3D "event=3D0x6,period=3D200000,umask=3D0x80",
> > -             .desc =3D "Number of segment register loads",
> > -             .topic =3D "other",
> > -     },
> > -     {
> > -             .name =3D "dispatch_blocked.any",
> > -             .event =3D "event=3D0x9,period=3D200000,umask=3D0x20",
> > -             .desc =3D "Memory cluster signals to block micro-op dispa=
tch for any reason",
> > -             .topic =3D "other",
> > -     },
> > -     {
> > -             .name =3D "eist_trans",
> > -             .event =3D "event=3D0x3a,period=3D200000,umask=3D0x0",
> > -             .desc =3D "Number of Enhanced Intel SpeedStep(R) Technolo=
gy (EIST) transitions",
> > -             .topic =3D "other",
> > -     },
> > -     {
> > -             .name =3D "uncore_hisi_ddrc.flux_wcmd",
> > -             .event =3D "event=3D0x2",
> > -             .desc =3D "DDRC write commands. Unit: hisi_sccl,ddrc ",
> > -             .topic =3D "uncore",
> > -             .long_desc =3D "DDRC write commands",
> > -             .pmu =3D "hisi_sccl,ddrc",
> > -     },
> > -     {
> > -             .name =3D "unc_cbo_xsnp_response.miss_eviction",
> > -             .event =3D "event=3D0x22,umask=3D0x81",
> > -             .desc =3D "A cross-core snoop resulted from L3 Eviction w=
hich misses in some processor core. Unit: uncore_cbox ",
> > -             .topic =3D "uncore",
> > -             .long_desc =3D "A cross-core snoop resulted from L3 Evict=
ion which misses in some processor core",
> > -             .pmu =3D "uncore_cbox",
> > -     },
> > -     {
> > -             .name =3D "event-hyphen",
> > -             .event =3D "event=3D0xe0,umask=3D0x00",
> > -             .desc =3D "UNC_CBO_HYPHEN. Unit: uncore_cbox ",
> > -             .topic =3D "uncore",
> > -             .long_desc =3D "UNC_CBO_HYPHEN",
> > -             .pmu =3D "uncore_cbox",
> > -     },
> > -     {
> > -             .name =3D "event-two-hyph",
> > -             .event =3D "event=3D0xc0,umask=3D0x00",
> > -             .desc =3D "UNC_CBO_TWO_HYPH. Unit: uncore_cbox ",
> > -             .topic =3D "uncore",
> > -             .long_desc =3D "UNC_CBO_TWO_HYPH",
> > -             .pmu =3D "uncore_cbox",
> > -     },
> > -     {
> > -             .name =3D "uncore_hisi_l3c.rd_hit_cpipe",
> > -             .event =3D "event=3D0x7",
> > -             .desc =3D "Total read hits. Unit: hisi_sccl,l3c ",
> > -             .topic =3D "uncore",
> > -             .long_desc =3D "Total read hits",
> > -             .pmu =3D "hisi_sccl,l3c",
> > -     },
> > -     {
> > -             .name =3D "uncore_imc_free_running.cache_miss",
> > -             .event =3D "event=3D0x12",
> > -             .desc =3D "Total cache misses. Unit: uncore_imc_free_runn=
ing ",
> > -             .topic =3D "uncore",
> > -             .long_desc =3D "Total cache misses",
> > -             .pmu =3D "uncore_imc_free_running",
> > -     },
> > -     {
> > -             .name =3D "uncore_imc.cache_hits",
> > -             .event =3D "event=3D0x34",
> > -             .desc =3D "Total cache hits. Unit: uncore_imc ",
> > -             .topic =3D "uncore",
> > -             .long_desc =3D "Total cache hits",
> > -             .pmu =3D "uncore_imc",
> > -     },
> > -     {
> > -             .name =3D "bp_l1_btb_correct",
> > -             .event =3D "event=3D0x8a",
> > -             .desc =3D "L1 BTB Correction",
> > -             .topic =3D "branch",
> > -     },
> > -     {
> > -             .name =3D "bp_l2_btb_correct",
> > -             .event =3D "event=3D0x8b",
> > -             .desc =3D "L2 BTB Correction",
> > -             .topic =3D "branch",
> > -     },
> > -     {
> > -             .name =3D 0,
> > -             .event =3D 0,
> > -             .desc =3D 0,
> > -     },
> > +struct compact_pmu_event {
> > +        int offset;
> >  };
> >
> > -static const struct pmu_metric pmu_metrics__test_soc_cpu[] =3D {
> > -     {
> > -             .metric_expr    =3D "1 / IPC",
> > -             .metric_name    =3D "CPI",
> > -     },
> > -     {
> > -             .metric_expr    =3D "inst_retired.any / cpu_clk_unhalted.=
thread",
> > -             .metric_name    =3D "IPC",
> > -             .metric_group   =3D "group1",
> > -     },
> > -     {
> > -             .metric_expr    =3D "idq_uops_not_delivered.core / (4 * (=
( ( cpu_clk_unhalted.thread / 2 ) * "
> > -             "( 1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhal=
ted.ref_xclk ) )))",
> > -             .metric_name    =3D "Frontend_Bound_SMT",
> > -     },
> > -     {
> > -             .metric_expr    =3D "l1d\\-loads\\-misses / inst_retired.=
any",
> > -             .metric_name    =3D "dcache_miss_cpi",
> > -     },
> > -     {
> > -             .metric_expr    =3D "l1i\\-loads\\-misses / inst_retired.=
any",
> > -             .metric_name    =3D "icache_miss_cycles",
> > -     },
> > -     {
> > -             .metric_expr    =3D "(dcache_miss_cpi + icache_miss_cycle=
s)",
> > -             .metric_name    =3D "cache_miss_cycles",
> > -             .metric_group   =3D "group1",
> > -     },
> > -     {
> > -             .metric_expr    =3D "l2_rqsts.demand_data_rd_hit + l2_rqs=
ts.pf_hit + l2_rqsts.rfo_hit",
> > -             .metric_name    =3D "DCache_L2_All_Hits",
> > -     },
> > -     {
> > -             .metric_expr    =3D "max(l2_rqsts.all_demand_data_rd - l2=
_rqsts.demand_data_rd_hit, 0) + "
> > -             "l2_rqsts.pf_miss + l2_rqsts.rfo_miss",
> > -             .metric_name    =3D "DCache_L2_All_Miss",
> > -     },
> > -     {
> > -             .metric_expr    =3D "DCache_L2_All_Hits + DCache_L2_All_M=
iss",
> > -             .metric_name    =3D "DCache_L2_All",
> > -     },
> > -     {
> > -             .metric_expr    =3D "d_ratio(DCache_L2_All_Hits, DCache_L=
2_All)",
> > -             .metric_name    =3D "DCache_L2_Hits",
> > -     },
> > -     {
> > -             .metric_expr    =3D "d_ratio(DCache_L2_All_Miss, DCache_L=
2_All)",
> > -             .metric_name    =3D "DCache_L2_Misses",
> > -     },
> > -     {
> > -             .metric_expr    =3D "ipc + M2",
> > -             .metric_name    =3D "M1",
> > -     },
> > -     {
> > -             .metric_expr    =3D "ipc + M1",
> > -             .metric_name    =3D "M2",
> > -     },
> > -     {
> > -             .metric_expr    =3D "1/M3",
> > -             .metric_name    =3D "M3",
> > -     },
> > -     {
> > -             .metric_expr    =3D "64 * l1d.replacement / 1000000000 / =
duration_time",
> > -             .metric_name    =3D "L1D_Cache_Fill_BW",
> > -     },
> > -     {
> > -             .metric_expr =3D 0,
> > -             .metric_name =3D 0,
> > -     },
> > +struct pmu_table_entry {
> > +        const struct compact_pmu_event *entries;
> > +        uint32_t num_entries;
> > +        struct compact_pmu_event pmu_name;
> > +};
> > +
> > +static const char *const big_c_string =3D
> > +/* offset=3D0 */ "default_core\000"
> > +/* offset=3D13 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\00=
0event=3D0x8a\000\00000\000\000"
> > +/* offset=3D72 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\00=
0event=3D0x8b\000\00000\000\000"
> > +/* offset=3D131 */ "l3_cache_rd\000cache\000L3 cache access, read\000e=
vent=3D0x40\000\00000\000Attributable Level 3 cache access, read\000"
> > +/* offset=3D226 */ "segment_reg_loads.any\000other\000Number of segmen=
t register loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\00=
0"
> > +/* offset=3D325 */ "dispatch_blocked.any\000other\000Memory cluster si=
gnals to block micro-op dispatch for any reason\000event=3D9,period=3D20000=
0,umask=3D0x20\000\00000\000\000"
> > +/* offset=3D455 */ "eist_trans\000other\000Number of Enhanced Intel Sp=
eedStep(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\00=
0\00000\000\000"
> > +/* offset=3D570 */ "hisi_sccl,ddrc\000"
> > +/* offset=3D585 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write=
 commands\000event=3D2\000\00000\000DDRC write commands\000"
> > +/* offset=3D671 */ "uncore_cbox\000"
> > +/* offset=3D683 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A=
 cross-core snoop resulted from L3 Eviction which misses in some processor =
core\000event=3D0x22,umask=3D0x81\000\00000\000A cross-core snoop resulted =
from L3 Eviction which misses in some processor core\000"
> > +/* offset=3D914 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=
=3D0xe0\000\00000\000UNC_CBO_HYPHEN\000"
> > +/* offset=3D979 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000ev=
ent=3D0xc0\000\00000\000UNC_CBO_TWO_HYPH\000"
> > +/* offset=3D1050 */ "hisi_sccl,l3c\000"
> > +/* offset=3D1064 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total r=
ead hits\000event=3D7\000\00000\000Total read hits\000"
> > +/* offset=3D1144 */ "uncore_imc_free_running\000"
> > +/* offset=3D1168 */ "uncore_imc_free_running.cache_miss\000uncore\000T=
otal cache misses\000event=3D0x12\000\00000\000Total cache misses\000"
> > +/* offset=3D1263 */ "uncore_imc\000"
> > +/* offset=3D1274 */ "uncore_imc.cache_hits\000uncore\000Total cache hi=
ts\000event=3D0x34\000\00000\000Total cache hits\000"
> > +/* offset=3D1352 */ "uncore_sys_ddr_pmu\000"
> > +/* offset=3D1371 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-c=
ycles event\000event=3D0x2b\000v8\00000\000\000"
> > +/* offset=3D1444 */ "uncore_sys_ccn_pmu\000"
> > +/* offset=3D1463 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cyc=
les event\000config=3D0x2c\0000x01\00000\000\000"
> > +/* offset=3D1537 */ "uncore_sys_cmn_pmu\000"
> > +/* offset=3D1556 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts to=
tal cache misses in first lookup result (high priority)\000eventid=3D1,type=
=3D5\000(434|436|43c|43a).*\00000\000\000"
> > +/* offset=3D1696 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00=
000"
> > +/* offset=3D1718 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhal=
ted.thread\000\000\000\000\000\000\000\00000"
> > +/* offset=3D1781 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.=
core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread=
_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
> > +/* offset=3D1947 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / ins=
t_retired.any\000\000\000\000\000\000\000\00000"
> > +/* offset=3D2011 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / =
inst_retired.any\000\000\000\000\000\000\000\00000"
> > +/* offset=3D2078 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + =
icache_miss_cycles\000\000\000\000\000\000\000\00000"
> > +/* offset=3D2149 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd=
_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000=
"
> > +/* offset=3D2243 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand=
_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rf=
o_miss\000\000\000\000\000\000\000\00000"
> > +/* offset=3D2377 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_=
L2_All_Miss\000\000\000\000\000\000\000\00000"
> > +/* offset=3D2441 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits,=
 DCache_L2_All)\000\000\000\000\000\000\000\00000"
> > +/* offset=3D2509 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Mis=
s, DCache_L2_All)\000\000\000\000\000\000\000\00000"
> > +/* offset=3D2579 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00=
000"
> > +/* offset=3D2601 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00=
000"
> > +/* offset=3D2623 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\0000=
0"
> > +/* offset=3D2643 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1=
e9 / duration_time\000\000\000\000\000\000\000\00000"
> > +;
> > +
> > +static const struct compact_pmu_event pmu_events__test_soc_cpu_default=
_core[] =3D {
> > +{ 13 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=
=3D0x8a\000\00000\000\000 */
> > +{ 72 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=
=3D0x8b\000\00000\000\000 */
> > +{ 325 }, /* dispatch_blocked.any\000other\000Memory cluster signals to=
 block micro-op dispatch for any reason\000event=3D9,period=3D200000,umask=
=3D0x20\000\00000\000\000 */
> > +{ 455 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep(=
R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\=
000\000 */
> > +{ 131 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0=
x40\000\00000\000Attributable Level 3 cache access, read\000 */
> > +{ 226 }, /* segment_reg_loads.any\000other\000Number of segment regist=
er loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000 */
> > +};
> > +static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sc=
cl_ddrc[] =3D {
> > +{ 585 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write command=
s\000event=3D2\000\00000\000DDRC write commands\000 */
> > +};
> > +static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sc=
cl_l3c[] =3D {
> > +{ 1064 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits=
\000event=3D7\000\00000\000Total read hits\000 */
> > +};
> > +static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_=
cbox[] =3D {
> > +{ 914 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\0=
00\00000\000UNC_CBO_HYPHEN\000 */
> > +{ 979 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0x=
c0\000\00000\000UNC_CBO_TWO_HYPH\000 */
> > +{ 683 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-c=
ore snoop resulted from L3 Eviction which misses in some processor core\000=
event=3D0x22,umask=3D0x81\000\00000\000A cross-core snoop resulted from L3 =
Eviction which misses in some processor core\000 */
> > +};
> > +static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_=
imc[] =3D {
> > +{ 1274 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000ev=
ent=3D0x34\000\00000\000Total cache hits\000 */
> > +};
> > +static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_=
imc_free_running[] =3D {
> > +{ 1168 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cac=
he misses\000event=3D0x12\000\00000\000Total cache misses\000 */
> > +
> > +};
> > +
> > +const struct pmu_table_entry pmu_events__test_soc_cpu[] =3D {
> > +{
> > +     .entries =3D pmu_events__test_soc_cpu_default_core,
> > +     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_default_core=
),
> > +     .pmu_name =3D { 0 /* default_core\000 */ },
> > +},
> > +{
> > +     .entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,
> > +     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_dd=
rc),
> > +     .pmu_name =3D { 570 /* hisi_sccl,ddrc\000 */ },
> > +},
> > +{
> > +     .entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
> > +     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3=
c),
> > +     .pmu_name =3D { 1050 /* hisi_sccl,l3c\000 */ },
> > +},
> > +{
> > +     .entries =3D pmu_events__test_soc_cpu_uncore_cbox,
> > +     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox)=
,
> > +     .pmu_name =3D { 671 /* uncore_cbox\000 */ },
> > +},
> > +{
> > +     .entries =3D pmu_events__test_soc_cpu_uncore_imc,
> > +     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
> > +     .pmu_name =3D { 1263 /* uncore_imc\000 */ },
> > +},
> > +{
> > +     .entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,
> > +     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_f=
ree_running),
> > +     .pmu_name =3D { 1144 /* uncore_imc_free_running\000 */ },
> > +},
> >  };
> >
> > +static const struct compact_pmu_event pmu_metrics__test_soc_cpu_defaul=
t_core[] =3D {
> > +{ 1696 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
> > +{ 2377 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_M=
iss\000\000\000\000\000\000\000\00000 */
> > +{ 2149 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l=
2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
> > +{ 2243 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd=
 - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\0=
00\000\000\000\000\000\000\00000 */
> > +{ 2441 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_=
L2_All)\000\000\000\000\000\000\000\00000 */
> > +{ 2509 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCach=
e_L2_All)\000\000\000\000\000\000\000\00000 */
> > +{ 1781 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (=
4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active =
/ cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
> > +{ 1718 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thre=
ad\000\000\000\000\000\000\000\00000 */
> > +{ 2643 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / dur=
ation_time\000\000\000\000\000\000\000\00000 */
> > +{ 2579 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
> > +{ 2601 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
> > +{ 2623 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
> > +{ 2078 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_m=
iss_cycles\000\000\000\000\000\000\000\00000 */
> > +{ 1947 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retire=
d.any\000\000\000\000\000\000\000\00000 */
> > +{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_ret=
ired.any\000\000\000\000\000\000\000\00000 */
> > +
> > +};
> > +
> > +const struct pmu_table_entry pmu_metrics__test_soc_cpu[] =3D {
> > +{
> > +     .entries =3D pmu_metrics__test_soc_cpu_default_core,
> > +     .num_entries =3D ARRAY_SIZE(pmu_metrics__test_soc_cpu_default_cor=
e),
> > +     .pmu_name =3D { 0 /* default_core\000 */ },
> > +},
> > +};
> > +
> > +static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_=
sys_ccn_pmu[] =3D {
> > +{ 1463 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles even=
t\000config=3D0x2c\0000x01\00000\000\000 */
> > +};
> > +static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_=
sys_cmn_pmu[] =3D {
> > +{ 1556 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cach=
e misses in first lookup result (high priority)\000eventid=3D1,type=3D5\000=
(434|436|43c|43a).*\00000\000\000 */
> > +};
> > +static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_=
sys_ddr_pmu[] =3D {
> > +{ 1371 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles ev=
ent\000event=3D0x2b\000v8\00000\000\000 */
> > +
> > +};
> > +
> > +const struct pmu_table_entry pmu_events__test_soc_sys[] =3D {
> > +{
> > +     .entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
> > +     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_c=
cn_pmu),
> > +     .pmu_name =3D { 1444 /* uncore_sys_ccn_pmu\000 */ },
> > +},
> > +{
> > +     .entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
> > +     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_c=
mn_pmu),
> > +     .pmu_name =3D { 1537 /* uncore_sys_cmn_pmu\000 */ },
> > +},
> > +{
> > +     .entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
> > +     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_d=
dr_pmu),
> > +     .pmu_name =3D { 1352 /* uncore_sys_ddr_pmu\000 */ },
> > +},
> > +};
> > +
> > +
> >  /* Struct used to make the PMU event table implementation opaque to ca=
llers. */
> >  struct pmu_events_table {
> > -     const struct pmu_event *entries;
> > +        const struct pmu_table_entry *pmus;
> > +        uint32_t num_pmus;
> >  };
> >
> >  /* Struct used to make the PMU metric table implementation opaque to c=
allers. */
> >  struct pmu_metrics_table {
> > -     const struct pmu_metric *entries;
> > +        const struct pmu_table_entry *pmus;
> > +        uint32_t num_pmus;
> >  };
> >
> >  /*
> > @@ -202,92 +199,191 @@ struct pmu_metrics_table {
> >   * The  cpuid can contain any character other than the comma.
> >   */
> >  struct pmu_events_map {
> > -     const char *arch;
> > -     const char *cpuid;
> > -     const struct pmu_events_table event_table;
> > -     const struct pmu_metrics_table metric_table;
> > +        const char *arch;
> > +        const char *cpuid;
> > +        struct pmu_events_table event_table;
> > +        struct pmu_metrics_table metric_table;
> >  };
> >
> >  /*
> >   * Global table mapping each known CPU for the architecture to its
> >   * table of PMU events.
> >   */
> > -static const struct pmu_events_map pmu_events_map[] =3D {
> > -     {
> > -             .arch =3D "testarch",
> > -             .cpuid =3D "testcpu",
> > -             .event_table =3D { pmu_events__test_soc_cpu },
> > -             .metric_table =3D { pmu_metrics__test_soc_cpu },
> > -     },
> > -     {
> > -             .arch =3D 0,
> > -             .cpuid =3D 0,
> > -             .event_table =3D { 0 },
> > -             .metric_table =3D { 0 },
> > -     },
> > -};
> > -
> > -static const struct pmu_event pmu_events__test_soc_sys[] =3D {
> > -     {
> > -             .name =3D "sys_ddr_pmu.write_cycles",
> > -             .event =3D "event=3D0x2b",
> > -             .desc =3D "ddr write-cycles event. Unit: uncore_sys_ddr_p=
mu ",
> > -             .compat =3D "v8",
> > -             .topic =3D "uncore",
> > -             .pmu =3D "uncore_sys_ddr_pmu",
> > -     },
> > -     {
> > -             .name =3D "sys_ccn_pmu.read_cycles",
> > -             .event =3D "config=3D0x2c",
> > -             .desc =3D "ccn read-cycles event. Unit: uncore_sys_ccn_pm=
u ",
> > -             .compat =3D "0x01",
> > -             .topic =3D "uncore",
> > -             .pmu =3D "uncore_sys_ccn_pmu",
> > -     },
> > -     {
> > -             .name =3D "sys_cmn_pmu.hnf_cache_miss",
> > -             .event =3D "eventid=3D0x1,type=3D0x5",
> > -             .desc =3D "Counts total cache misses in first lookup resu=
lt (high priority). Unit: uncore_sys_cmn_pmu ",
> > -             .compat =3D "(434|436|43c|43a).*",
> > -             .topic =3D "uncore",
> > -             .pmu =3D "uncore_sys_cmn_pmu",
> > -     },
> > -     {
> > -             .name =3D 0,
> > -             .event =3D 0,
> > -             .desc =3D 0,
> > -     },
> > +const struct pmu_events_map pmu_events_map[] =3D {
> > +{
> > +     .arch =3D "testarch",
> > +     .cpuid =3D "testcpu",
> > +     .event_table =3D {
> > +             .pmus =3D pmu_events__test_soc_cpu,
> > +             .num_pmus =3D ARRAY_SIZE(pmu_events__test_soc_cpu),
> > +     },
> > +     .metric_table =3D {
> > +             .pmus =3D pmu_metrics__test_soc_cpu,
> > +             .num_pmus =3D ARRAY_SIZE(pmu_metrics__test_soc_cpu),
> > +     }
> > +},
> > +{
> > +     .arch =3D 0,
> > +     .cpuid =3D 0,
> > +     .event_table =3D { 0, 0 },
> > +     .metric_table =3D { 0, 0 },
> > +}
> >  };
> >
> >  struct pmu_sys_events {
> >       const char *name;
> > -     const struct pmu_events_table table;
> > +     struct pmu_events_table event_table;
> > +     struct pmu_metrics_table metric_table;
> >  };
> >
> >  static const struct pmu_sys_events pmu_sys_event_tables[] =3D {
> >       {
> > -             .table =3D { pmu_events__test_soc_sys },
> > +             .event_table =3D {
> > +                     .pmus =3D pmu_events__test_soc_sys,
> > +                     .num_pmus =3D ARRAY_SIZE(pmu_events__test_soc_sys=
)
> > +             },
> >               .name =3D "pmu_events__test_soc_sys",
> >       },
> >       {
> > -             .table =3D { 0 }
> > +             .event_table =3D { 0, 0 },
> > +             .metric_table =3D { 0, 0 },
> >       },
> >  };
> >
> > -int pmu_events_table__for_each_event(const struct pmu_events_table *ta=
ble, struct perf_pmu *pmu,
> > -                                  pmu_event_iter_fn fn, void *data)
> > +static void decompress_event(int offset, struct pmu_event *pe)
> > +{
> > +     const char *p =3D &big_c_string[offset];
> > +
> > +     pe->name =3D (*p =3D=3D '\0' ? NULL : p);
> > +     while (*p++);
> > +     pe->topic =3D (*p =3D=3D '\0' ? NULL : p);
> > +     while (*p++);
> > +     pe->desc =3D (*p =3D=3D '\0' ? NULL : p);
> > +     while (*p++);
> > +     pe->event =3D (*p =3D=3D '\0' ? NULL : p);
> > +     while (*p++);
> > +     pe->compat =3D (*p =3D=3D '\0' ? NULL : p);
> > +     while (*p++);
> > +     pe->deprecated =3D *p - '0';
> > +     p++;
> > +     pe->perpkg =3D *p - '0';
> > +     p++;
> > +     pe->unit =3D (*p =3D=3D '\0' ? NULL : p);
> > +     while (*p++);
> > +     pe->long_desc =3D (*p =3D=3D '\0' ? NULL : p);
> > +}
> > +
> > +static void decompress_metric(int offset, struct pmu_metric *pm)
> >  {
> > -     for (const struct pmu_event *pe =3D &table->entries[0]; pe->name;=
 pe++) {
> > -             int ret;
> > +     const char *p =3D &big_c_string[offset];
> > +
> > +     pm->metric_name =3D (*p =3D=3D '\0' ? NULL : p);
> > +     while (*p++);
> > +     pm->metric_group =3D (*p =3D=3D '\0' ? NULL : p);
> > +     while (*p++);
> > +     pm->metric_expr =3D (*p =3D=3D '\0' ? NULL : p);
> > +     while (*p++);
> > +     pm->metric_threshold =3D (*p =3D=3D '\0' ? NULL : p);
> > +     while (*p++);
> > +     pm->desc =3D (*p =3D=3D '\0' ? NULL : p);
> > +     while (*p++);
> > +     pm->long_desc =3D (*p =3D=3D '\0' ? NULL : p);
> > +     while (*p++);
> > +     pm->unit =3D (*p =3D=3D '\0' ? NULL : p);
> > +     while (*p++);
> > +     pm->compat =3D (*p =3D=3D '\0' ? NULL : p);
> > +     while (*p++);
> > +     pm->metricgroup_no_group =3D (*p =3D=3D '\0' ? NULL : p);
> > +     while (*p++);
> > +     pm->default_metricgroup_name =3D (*p =3D=3D '\0' ? NULL : p);
> > +     while (*p++);
> > +     pm->aggr_mode =3D *p - '0';
> > +     p++;
> > +     pm->event_grouping =3D *p - '0';
> > +}
> >
> > -                if (pmu && !pmu__name_match(pmu, pe->pmu))
> > +static int pmu_events_table__for_each_event_pmu(const struct pmu_event=
s_table *table,
> > +                                                const struct pmu_table=
_entry *pmu,
> > +                                                pmu_event_iter_fn fn,
> > +                                                void *data)
> > +{
> > +        int ret;
> > +        struct pmu_event pe =3D {
> > +                .pmu =3D &big_c_string[pmu->pmu_name.offset],
> > +        };
> > +
> > +        for (uint32_t i =3D 0; i < pmu->num_entries; i++) {
> > +                decompress_event(pmu->entries[i].offset, &pe);
> > +                if (!pe.name)
> >                          continue;
> > +                ret =3D fn(&pe, table, data);
> > +                if (ret)
> > +                        return ret;
> > +        }
> > +        return 0;
> > + }
> > +
> > +static int pmu_events_table__find_event_pmu(const struct pmu_events_ta=
ble *table,
> > +                                            const struct pmu_table_ent=
ry *pmu,
> > +                                            const char *name,
> > +                                            pmu_event_iter_fn fn,
> > +                                            void *data)
> > +{
> > +        struct pmu_event pe =3D {
> > +                .pmu =3D &big_c_string[pmu->pmu_name.offset],
> > +        };
> > +        int low =3D 0, high =3D pmu->num_entries - 1;
> >
> > -             ret =3D fn(pe, table, data);
> > -             if (ret)
> > -                     return ret;
> > -     }
> > -     return 0;
> > +        while (low <=3D high) {
> > +                int cmp, mid =3D (low + high) / 2;
> > +
> > +                decompress_event(pmu->entries[mid].offset, &pe);
> > +
> > +                if (!pe.name && !name)
> > +                        goto do_call;
> > +
> > +                if (!pe.name && name) {
> > +                        low =3D mid + 1;
> > +                        continue;
> > +                }
> > +                if (pe.name && !name) {
> > +                        high =3D mid - 1;
> > +                        continue;
> > +                }
> > +
> > +                cmp =3D strcasecmp(pe.name, name);
> > +                if (cmp < 0) {
> > +                        low =3D mid + 1;
> > +                        continue;
> > +                }
> > +                if (cmp > 0) {
> > +                        high =3D mid - 1;
> > +                        continue;
> > +                }
> > +  do_call:
> > +                return fn ? fn(&pe, table, data) : 0;
> > +        }
> > +        return PMU_EVENTS__NOT_FOUND;
> > +}
> > +
> > +int pmu_events_table__for_each_event(const struct pmu_events_table *ta=
ble,
> > +                                    struct perf_pmu *pmu,
> > +                                    pmu_event_iter_fn fn,
> > +                                    void *data)
> > +{
> > +        for (size_t i =3D 0; i < table->num_pmus; i++) {
> > +                const struct pmu_table_entry *table_pmu =3D &table->pm=
us[i];
> > +                const char *pmu_name =3D &big_c_string[table_pmu->pmu_=
name.offset];
> > +                int ret;
> > +
> > +                if (pmu && !pmu__name_match(pmu, pmu_name))
> > +                        continue;
> > +
> > +                ret =3D pmu_events_table__for_each_event_pmu(table, ta=
ble_pmu, fn, data);
> > +                if (pmu || ret)
> > +                        return ret;
> > +        }
> > +        return 0;
> >  }
> >
> >  int pmu_events_table__find_event(const struct pmu_events_table *table,
> > @@ -296,14 +392,19 @@ int pmu_events_table__find_event(const struct pmu=
_events_table *table,
> >                                   pmu_event_iter_fn fn,
> >                                   void *data)
> >  {
> > -     for (const struct pmu_event *pe =3D &table->entries[0]; pe->name;=
 pe++) {
> > -                if (pmu && !pmu__name_match(pmu, pe->pmu))
> > +        for (size_t i =3D 0; i < table->num_pmus; i++) {
> > +                const struct pmu_table_entry *table_pmu =3D &table->pm=
us[i];
> > +                const char *pmu_name =3D &big_c_string[table_pmu->pmu_=
name.offset];
> > +                int ret;
> > +
> > +                if (!pmu__name_match(pmu, pmu_name))
> >                          continue;
> >
> > -             if (!strcasecmp(pe->name, name))
> > -                     return fn(pe, table, data);
> > -     }
> > -        return -1000;
> > +                ret =3D pmu_events_table__find_event_pmu(table, table_=
pmu, name, fn, data);
> > +                if (ret !=3D PMU_EVENTS__NOT_FOUND)
> > +                        return ret;
> > +        }
> > +        return PMU_EVENTS__NOT_FOUND;
> >  }
> >
> >  size_t pmu_events_table__num_events(const struct pmu_events_table *tab=
le,
> > @@ -311,160 +412,253 @@ size_t pmu_events_table__num_events(const struc=
t pmu_events_table *table,
> >  {
> >          size_t count =3D 0;
> >
> > -     for (const struct pmu_event *pe =3D &table->entries[0]; pe->name;=
 pe++) {
> > -                if (pmu && !pmu__name_match(pmu, pe->pmu))
> > -                        continue;
> > +        for (size_t i =3D 0; i < table->num_pmus; i++) {
> > +                const struct pmu_table_entry *table_pmu =3D &table->pm=
us[i];
> > +                const char *pmu_name =3D &big_c_string[table_pmu->pmu_=
name.offset];
> >
> > -             count++;
> > -     }
> > +                if (pmu__name_match(pmu, pmu_name))
> > +                        count +=3D table_pmu->num_entries;
> > +        }
> >          return count;
> >  }
> >
> > -int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table =
*table, pmu_metric_iter_fn fn,
> > -                                   void *data)
> > +static int pmu_metrics_table__for_each_metric_pmu(const struct pmu_met=
rics_table *table,
> > +                                                const struct pmu_table=
_entry *pmu,
> > +                                                pmu_metric_iter_fn fn,
> > +                                                void *data)
> > +{
> > +        int ret;
> > +        struct pmu_metric pm =3D {
> > +                .pmu =3D &big_c_string[pmu->pmu_name.offset],
> > +        };
> > +
> > +        for (uint32_t i =3D 0; i < pmu->num_entries; i++) {
> > +                decompress_metric(pmu->entries[i].offset, &pm);
> > +                if (!pm.metric_expr)
> > +                        continue;
> > +                ret =3D fn(&pm, table, data);
> > +                if (ret)
> > +                        return ret;
> > +        }
> > +        return 0;
> > +}
> > +
> > +int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table =
*table,
> > +                                     pmu_metric_iter_fn fn,
> > +                                     void *data)
> >  {
> > -     for (const struct pmu_metric *pm =3D &table->entries[0]; pm->metr=
ic_expr; pm++) {
> > -             int ret =3D fn(pm, table, data);
> > +        for (size_t i =3D 0; i < table->num_pmus; i++) {
> > +                int ret =3D pmu_metrics_table__for_each_metric_pmu(tab=
le, &table->pmus[i],
> > +                                                                 fn, d=
ata);
> > +
> > +                if (ret)
> > +                        return ret;
> > +        }
> > +        return 0;
> > +}
> >
> > -             if (ret)
> > -                     return ret;
> > -     }
> > -     return 0;
> > +static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
> > +{
> > +        static struct {
> > +                const struct pmu_events_map *map;
> > +                struct perf_pmu *pmu;
> > +        } last_result;
> > +        static struct {
> > +                const struct pmu_events_map *map;
> > +                char *cpuid;
> > +        } last_map_search;
> > +        static bool has_last_result, has_last_map_search;
> > +        const struct pmu_events_map *map =3D NULL;
> > +        char *cpuid =3D NULL;
> > +        size_t i;
> > +
> > +        if (has_last_result && last_result.pmu =3D=3D pmu)
> > +                return last_result.map;
> > +
> > +        cpuid =3D perf_pmu__getcpuid(pmu);
> > +
> > +        /*
> > +         * On some platforms which uses cpus map, cpuid can be NULL fo=
r
> > +         * PMUs other than CORE PMUs.
> > +         */
> > +        if (!cpuid)
> > +                goto out_update_last_result;
> > +
> > +        if (has_last_map_search && !strcmp(last_map_search.cpuid, cpui=
d)) {
> > +                map =3D last_map_search.map;
> > +                free(cpuid);
> > +        } else {
> > +                i =3D 0;
> > +                for (;;) {
> > +                        map =3D &pmu_events_map[i++];
> > +
> > +                        if (!map->arch) {
> > +                                map =3D NULL;
> > +                                break;
> > +                        }
> > +
> > +                        if (!strcmp_cpuid_str(map->cpuid, cpuid))
> > +                                break;
> > +               }
> > +               free(last_map_search.cpuid);
> > +               last_map_search.cpuid =3D cpuid;
> > +               last_map_search.map =3D map;
> > +               has_last_map_search =3D true;
> > +        }
> > +out_update_last_result:
> > +        last_result.pmu =3D pmu;
> > +        last_result.map =3D map;
> > +        has_last_result =3D true;
> > +        return map;
> >  }
> >
> >  const struct pmu_events_table *perf_pmu__find_events_table(struct perf=
_pmu *pmu)
> >  {
> > -     const struct pmu_events_table *table =3D NULL;
> > -     char *cpuid =3D perf_pmu__getcpuid(pmu);
> > -     int i;
> > +        const struct pmu_events_map *map =3D map_for_pmu(pmu);
> >
> > -     /* on some platforms which uses cpus map, cpuid can be NULL for
> > -      * PMUs other than CORE PMUs.
> > -      */
> > -     if (!cpuid)
> > -             return NULL;
> > +        if (!map)
> > +                return NULL;
> >
> > -     i =3D 0;
> > -     for (;;) {
> > -             const struct pmu_events_map *map =3D &pmu_events_map[i++]=
;
> > +        if (!pmu)
> > +                return &map->event_table;
> >
> > -             if (!map->cpuid)
> > -                     break;
> > +        for (size_t i =3D 0; i < map->event_table.num_pmus; i++) {
> > +                const struct pmu_table_entry *table_pmu =3D &map->even=
t_table.pmus[i];
> > +                const char *pmu_name =3D &big_c_string[table_pmu->pmu_=
name.offset];
> >
> > -             if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> > -                     table =3D &map->event_table;
> > -                     break;
> > -             }
> > -     }
> > -     free(cpuid);
> > -     return table;
> > +                if (pmu__name_match(pmu, pmu_name))
> > +                         return &map->event_table;
> > +        }
> > +        return NULL;
> >  }
> >
> >  const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct pe=
rf_pmu *pmu)
> >  {
> > -     const struct pmu_metrics_table *table =3D NULL;
> > -     char *cpuid =3D perf_pmu__getcpuid(pmu);
> > -     int i;
> > +        const struct pmu_events_map *map =3D map_for_pmu(pmu);
> >
> > -     /* on some platforms which uses cpus map, cpuid can be NULL for
> > -      * PMUs other than CORE PMUs.
> > -      */
> > -     if (!cpuid)
> > -             return NULL;
> > +        if (!map)
> > +                return NULL;
> >
> > -     i =3D 0;
> > -     for (;;) {
> > -             const struct pmu_events_map *map =3D &pmu_events_map[i++]=
;
> > +        if (!pmu)
> > +                return &map->metric_table;
> >
> > -             if (!map->cpuid)
> > -                     break;
> > +        for (size_t i =3D 0; i < map->metric_table.num_pmus; i++) {
> > +                const struct pmu_table_entry *table_pmu =3D &map->metr=
ic_table.pmus[i];
> > +                const char *pmu_name =3D &big_c_string[table_pmu->pmu_=
name.offset];
> >
> > -             if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> > -                     table =3D &map->metric_table;
> > -                     break;
> > -             }
> > -     }
> > -     free(cpuid);
> > -     return table;
> > +                if (pmu__name_match(pmu, pmu_name))
> > +                           return &map->metric_table;
> > +        }
> > +        return NULL;
> >  }
> >
> >  const struct pmu_events_table *find_core_events_table(const char *arch=
, const char *cpuid)
> >  {
> > -     for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
> > -          tables->arch;
> > -          tables++) {
> > -             if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tabl=
es->cpuid, cpuid))
> > -                     return &tables->event_table;
> > -     }
> > -     return NULL;
> > +        for (const struct pmu_events_map *tables =3D &pmu_events_map[0=
];
> > +             tables->arch;
> > +             tables++) {
> > +                if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(t=
ables->cpuid, cpuid))
> > +                        return &tables->event_table;
> > +        }
> > +        return NULL;
> >  }
> >
> >  const struct pmu_metrics_table *find_core_metrics_table(const char *ar=
ch, const char *cpuid)
> >  {
> > -     for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
> > -          tables->arch;
> > -          tables++) {
> > -             if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tabl=
es->cpuid, cpuid))
> > -                     return &tables->metric_table;
> > -     }
> > -     return NULL;
> > +        for (const struct pmu_events_map *tables =3D &pmu_events_map[0=
];
> > +             tables->arch;
> > +             tables++) {
> > +                if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(t=
ables->cpuid, cpuid))
> > +                        return &tables->metric_table;
> > +        }
> > +        return NULL;
> >  }
> >
> >  int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
> >  {
> > -     for (const struct pmu_events_map *tables =3D &pmu_events_map[0]; =
tables->arch; tables++) {
> > -             int ret =3D pmu_events_table__for_each_event(&tables->eve=
nt_table,
> > -                                                        /*pmu=3D*/ NUL=
L, fn, data);
> > -
> > -             if (ret)
> > -                     return ret;
> > -     }
> > -     return 0;
> > +        for (const struct pmu_events_map *tables =3D &pmu_events_map[0=
];
> > +             tables->arch;
> > +             tables++) {
> > +                int ret =3D pmu_events_table__for_each_event(&tables->=
event_table,
> > +                                                           /*pmu=3D*/ =
NULL, fn, data);
> > +
> > +                if (ret)
> > +                        return ret;
> > +        }
> > +        return 0;
> >  }
> >
> >  int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data)
> >  {
> > -     for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
> > -          tables->arch;
> > -          tables++) {
> > -             int ret =3D pmu_metrics_table__for_each_metric(&tables->m=
etric_table, fn, data);
> > -
> > -             if (ret)
> > -                     return ret;
> > -     }
> > -     return 0;
> > +        for (const struct pmu_events_map *tables =3D &pmu_events_map[0=
];
> > +             tables->arch;
> > +             tables++) {
> > +                int ret =3D pmu_metrics_table__for_each_metric(&tables=
->metric_table, fn, data);
> > +
> > +                if (ret)
> > +                        return ret;
> > +        }
> > +        return 0;
> >  }
> >
> >  const struct pmu_events_table *find_sys_events_table(const char *name)
> >  {
> > -     for (const struct pmu_sys_events *tables =3D &pmu_sys_event_table=
s[0];
> > -          tables->name;
> > -          tables++) {
> > -             if (!strcmp(tables->name, name))
> > -                     return &tables->table;
> > -     }
> > -     return NULL;
> > +        for (const struct pmu_sys_events *tables =3D &pmu_sys_event_ta=
bles[0];
> > +             tables->name;
> > +             tables++) {
> > +                if (!strcmp(tables->name, name))
> > +                        return &tables->event_table;
> > +        }
> > +        return NULL;
> >  }
> >
> >  int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
> >  {
> > -     for (const struct pmu_sys_events *tables =3D &pmu_sys_event_table=
s[0];
> > -          tables->name;
> > -          tables++) {
> > -             int ret =3D pmu_events_table__for_each_event(&tables->tab=
le, /*pmu=3D*/ NULL, fn, data);
> > -
> > -             if (ret)
> > -                     return ret;
> > -     }
> > -     return 0;
> > +        for (const struct pmu_sys_events *tables =3D &pmu_sys_event_ta=
bles[0];
> > +             tables->name;
> > +             tables++) {
> > +                int ret =3D pmu_events_table__for_each_event(&tables->=
event_table,
> > +                                                           /*pmu=3D*/ =
NULL, fn, data);
> > +
> > +                if (ret)
> > +                        return ret;
> > +        }
> > +        return 0;
> >  }
> >
> > -int pmu_for_each_sys_metric(pmu_metric_iter_fn fn __maybe_unused, void=
 *data __maybe_unused)
> > +int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, void *data)
> >  {
> > -     return 0;
> > +        for (const struct pmu_sys_events *tables =3D &pmu_sys_event_ta=
bles[0];
> > +             tables->name;
> > +             tables++) {
> > +                int ret =3D pmu_metrics_table__for_each_metric(&tables=
->metric_table, fn, data);
> > +
> > +                if (ret)
> > +                        return ret;
> > +        }
> > +        return 0;
> >  }
> >
> > -const char *describe_metricgroup(const char *group __maybe_unused)
> > +static const int metricgroups[][2] =3D {
> > +
> > +};
> > +
> > +const char *describe_metricgroup(const char *group)
> >  {
> > -     return NULL;
> > +        int low =3D 0, high =3D (int)ARRAY_SIZE(metricgroups) - 1;
> > +
> > +        while (low <=3D high) {
> > +                int mid =3D (low + high) / 2;
> > +                const char *mgroup =3D &big_c_string[metricgroups[mid]=
[0]];
> > +                int cmp =3D strcmp(mgroup, group);
> > +
> > +                if (cmp =3D=3D 0) {
> > +                        return &big_c_string[metricgroups[mid][1]];
> > +                } else if (cmp < 0) {
> > +                        low =3D mid + 1;
> > +                } else {
> > +                        high =3D mid - 1;
> > +                }
> > +        }
> > +        return NULL;
> >  }
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/j=
events.py
> > index 731776e29f47..fcf0158438b5 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -1256,6 +1256,10 @@ such as "arm/cortex-a34".''',
> >        'output_file', type=3Dargparse.FileType('w', encoding=3D'utf-8')=
, nargs=3D'?', default=3Dsys.stdout)
> >    _args =3D ap.parse_args()
> >
> > +  _args.output_file.write(f"""
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* THIS FILE WAS AUTOGENERATED BY jevents.py arch=3D{_args.arch} model=
=3D{_args.model} ! */
> > +""")
> >    _args.output_file.write("""
> >  #include <pmu-events/pmu-events.h>
> >  #include "util/header.h"
> > @@ -1281,7 +1285,7 @@ struct pmu_table_entry {
> >      if item.name =3D=3D _args.arch or _args.arch =3D=3D 'all' or item.=
name =3D=3D 'test':
> >        archs.append(item.name)
> >
> > -  if len(archs) < 2:
> > +  if len(archs) < 2 and _args.arch !=3D 'none':
> >      raise IOError(f'Missing architecture directory \'{_args.arch}\'')
> >
> >    archs.sort()
> > --
> > 2.46.0.rc2.264.g509ed76dc8-goog
> >
