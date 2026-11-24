Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795494230;
	b=NZFwtiK11OD+L9AUjG9/dSU+UozuzIAOCe0XmygrvmRzwHNOaznJx8QXY+q69MGgluMG
	 FPtBmD+9OrKwOLfd88YUBj26Ne9yr6ZxjKeLy4N9b0R0ejxZ+WxkJj2zyn+HuZmao+qbX
	 wZEUzmbVU1A2W0dfecSHD1MyFjYsOy1aDc8wFSTpbcabt3cFgOw5AoTsC+Ju8MYBus37g
	 tbz29CGnaM/0DVu28fQ4BsvogfJY7daLDhAHMFBAYo8NDrO7CMklNOrbDGCaZkjV7HZqO
	 4Mdw7T1ewmsOM0/YOglVeHNSy5mi48WFgHT4e+o5sH5bVIlNxZtdqk9R6xu+OU5ZbYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ysvMymq5KIU6XrltkLSVyOSXaHAIgzr2IUM1B91c+/M=;
	b=s/W0Aq/ueBgI0O5QRWrcknlszqEIl6UiQXTJvROYT4UajFTBKMhpzZ9/HQHh++8tbAz4
	 rfuzgKhclCsaR/wvkhtNGiNr25lYrglM7ArH3sMcYGzg74+MsJrRmkhpE0enLwOHBL4Rx
	 whSSAt9nAbVoZpDUQCmzmFEwziiW33XhRRPVK3NP7jn75R4u2AO5NhtmIgbh+SFEr1JLA
	 POaHpMhBAWnY6Blk8WXl4YmiinCH6o0ptxNAyW6+a3f5W5O9ANwnxdf/flcF94/jTRkk6
	 nZnvUa11oY9nEJ4PlBL4ttKBzJ2T2Ya6UJE4mjw6+bLvCFPIseaWcO4t1LZnXLl4zaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qr990un9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BBC606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 04:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5BBC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qr990un9
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-55c7445cf85so664471cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 20:23:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795494229; cv=none;
        d=google.com; s=arc-20260327;
        b=qR4Wjjr9aChcm1ozN2GXDkWX8ygNqAfaO2Pm/INXgi66hI/Fyy/ZrJaPDNt69J3csN
         9l83O6HMxCC1xpw182T1c1AYMVhqlUoFb4F8w6eaJ+mdE+LNQA4Uch3+BJFY+agC8Z0n
         8L3JzfWJ2XhNvpzG6uwmKhZAZopZD7khExsK+jeAxZsYwukvLbiJq2J1ZV2XhRpBfuCk
         tFltLzSHtW1tAeEn/RsYDvu9olS4mDR/XN0/3bc7FLwD0S8IK/0eabSoG5Kqf6eADidM
         KAGHeFZz7ORRztFr5OV4xyuDr3OdDvRhrtbFuSF8dmJc1s5Q4mNos0hzEsaHkdCEVmkg
         L5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ysvMymq5KIU6XrltkLSVyOSXaHAIgzr2IUM1B91c+/M=;
        fh=cNuzgRrAuw0UOWtCA7h6LJg3OE1uK8OZbtBMLVGI4q0=;
        b=ID0XdsADeikyRW1AEEhxUoM0j3qi9Ta+/QFhq6oR4Ms9H7DclUMHm2bLYxB3LEw59b
         gf4UZ4VvW2Az23RmETPOADggwD9WGlB6znTmysyJ6q864wNqyOJhLW1PlYFoA+VYk35y
         A+hWcvnO7wpLDZn0ZkyqQPWoggh9pAMd8hFpObBNzF+aYIqP5BOyB/a2YhsBmJEEsqr7
         zS/qsmTcQb7SxNS0U5wLInGVBR3dsVN3W5XPEHrTrPxyWVvKTpDubnDwoRZhxme8av6g
         dCepi45VXo/17+wWQXBvv8aTdDU66DMT0/1kx/mZ40ZE8H2rWQCWs4pNLmB6b8Wt7LA3
         BrKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795494229; x=1796099029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ysvMymq5KIU6XrltkLSVyOSXaHAIgzr2IUM1B91c+/M=;
        b=Qr990un9wJ3zWkD3r5kHD06RHTsNsW2ZsxkAAm5+mh+EFBpCuUSTZOcgqEV19AzQCM
         UcW0Bf8qVpnRghM+29rlIxl/71Jk5xKVQBDpVvGpufIimlhXVWR05RlW6PZLL1q6VJWj
         xFBkGBQ7uDk5bX7ZzCcnSwwVfcehQJmhJrd2YmV/Nk/XezKgOTjnoHqV3LW8K3kWHGU5
         X07FR4D1eI5qKVAO4OncPmt0wDJmz66SmafJdYHge24F+aXRRwRlS87RH2VS8CYWGksc
         On2k4ojPhvvssUwZe7OBDNaeJI1m9rEPP2yOb2sjvdB6d8Pb+a3Wo8x5haR18kSp4/+u
         ViWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795494229; x=1796099029;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ysvMymq5KIU6XrltkLSVyOSXaHAIgzr2IUM1B91c+/M=;
        b=EgrhqO+Dm2eZAkBGkj2NYeb/BYSsONIl17Byg2/IS1QpuFA+5iHOZqvQXrKIjXCPUT
         a9ZlR+Gjd4k9yBoMmBbRgB0wBVIE/rbhjgToHcavGDujBOYn1aQNJxn/h6rpj3qqdxEj
         dnfiCy5gMAnxOFIDbxUAKgkdbXwgqE25Cxt9yWRJFy2XeBt/LmMPkMeYd4OuIFOwe7Fl
         QhHI3VtbaI/PAhoi58dWmjdhx09s48F5WwaoqqFVVq8awOkhNeCO/QV5dOw2ngQpQERm
         EIEWB8OIfr6ntP25WMqKxS+9F5Jch4ISjZ/Fe1rx8/Snk+6rtTAu+OTM0P8gqfXa6nXM
         GX4Q==
X-Forwarded-Encrypted: i=1; AL+hErFb46T3iB9CC7WRNv2Cd/xfUjguhAgtdWNfxM3C6k0XyR1JuH/gJXWFZvnrDyvz7YMCnJsTzWGyfTVtFMfsfaFS@vger.kernel.org
X-Gm-Message-State: APuU4Z8Xg2sWljpbVxcOusjPBk3B+ndB34WfntBfPriq2s+OOU2lRjM0
	oKS8V7oseUjATQDEkrZmbfta5STEvAucET/ffiNoGT0oOqLRbtQmoVZuX0r1wKwQdOzO569cyp1
	TtIsxksDTsVeQ5T5YU8LyWgPFsk3+i+cXPR17rjdR
X-Gm-Gg: AZFdTZeby6SkYL3KkA8XQyt/6E+qoevrreS3/1LrcZb5bap5QTAmJhaF6oFt90X7DZ7
	t0qZ+x0EFNAdnxxgAKEb+Ojb8NvbtC+5iNFhtEYs9zv+RhgFUPoO3kjkmDlgNgRfAtXqDgueIJ4
	s9g5E1NnhTZQF8lhT2IyREdh06DhIEVQegwyK1ZDc1l8gHMABoIUco5dObYgapqdVaHk422bpfD
	+IFNKi6hEds53mFPpCDpm5iC8Ovfqrlq77KB4ZHq1a2Kdiiynq5Wf3idaDOPrZ0SIDKEBPQmaGy
	Hb6H+FIS3839UTYp7AZ92nBC8bVsfmUYk5e0Q2qBmwN27Tscxj2qM+fSGB+gJVnV9Me93Py0b5J
	HsKKhCI8pYcQ6+3DPFezjX9jlK3T9pmFHTDEx
X-Received: by 2002:a05:622a:8c8:b0:55b:ce7e:e65 with SMTP id
 d75a77b69052e-55d8903b91emr47619581cf.12.1795494228124; Mon, 23 Nov 2026
 20:23:48 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123071913.653315-1-irogers@google.com> <20261123071913.653315-6-irogers@google.com>
 <3F569607-DA0C-47B3-823D-926D12D7FBC1@linux.ibm.com>
In-Reply-To: <3F569607-DA0C-47B3-823D-926D12D7FBC1@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Nov 2026 20:23:36 -0800
X-Gm-Features: Aa3M54qyOPA931bpT1wuJ3cgqsSQ6c4Hj8Jgh9I1Mf8vyoDtW6sgS_nBGZTcf9I
Message-ID: <CAP-5=fXPCbPFhVeB6229hnHNpE4pFshQQQ7CfNyu-S9XUVi6Vg@mail.gmail.com>
Subject: Re: [PATCH v1 05/13] perf stat: Preserve per-evsel CPU maps across
 stat record and report
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Song Liu <songliubraving@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 9:13=E2=80=AFAM Athira Rajeev <atrajeev@linux.ibm.c=
om> wrote:
>
>
>
> > On 23 Nov 2026, at 12:49=E2=80=AFPM, Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Commit 6d765f5f7ec6 ("libperf evsel: Rename own_cpus to pmu_cpus") and
> > commit 811082e4b668 ("perf parse-events: Support user CPUs mixed with
> > threads/processes") separated an evsel's PMU cpumask (pmu_cpus) from th=
e
> > actual CPUs on which the event is opened (cpus) and taught
> > __perf_evlist__propagate_maps() to collapse evsel->cpus to the "any CPU=
"
> > (-1) map when user_requested_cpus is -1 and !evsel->requires_cpu.
> >
> > However, perf_event__synthesize_event_update_cpus() continued to
> > serialize evsel->core.pmu_cpus instead of evsel->core.cpus, and
> > perf_event__process_event_update() only populated evsel->core.pmu_cpus
> > without setting evsel->core.cpus or evsel->core.requires_cpu. This brok=
e
> > perf stat record/report (and perf script) in two ways:
> >
> > 1. When recording an event opened per-CPU alongside a workload target
> >   (where user_requested_cpus is -1), such as an event with a cpu=3D ter=
m,
> >   an uncore counter, --bpf-counters, or a BPF-filtered counter,
> >   PERF_RECORD_STAT events are written with concrete CPU numbers, but
> >   perf stat report's perf_evlist__set_maps() collapses evsel->cpus to
> >   -1 and fails with:
> >
> >     $ perf stat record -e 'task-clock/cpu=3D0/,task-clock' -- true
> >     $ perf stat report
> >     Invalid CPU 0 for event task-clock/cpu=3D0/.
>
> Hi Ian
>
> Thanks for the fix, verified the fix for "perf stat report". But I have o=
ne observation when using aggregation mode.
>
> Working case with the fix:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> With the fix:
>
> ./perf stat record -e cycles/cpu=3D8/,cycles/cpu=3D9/ <workload>
> ./perf stat report
>
> Perf stat report works fine
> Also checked system wide.
>
> Using -A:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> Before broken commits 6d765f5f7ec6 and 811082e4b668,
> ./perf stat record -e cycles/cpu=3D8/,cycles/cpu=3D9/ <workload>
> ./perf stat report -A : this was working
>
>     ./perf stat report -A
>
>     Performance counter stats for '/root/perf-tools-next/tools/perf/perf =
stat record -e cycles/cpu=3D8/,cycles/cpu=3D9/ ./stream=E2=80=99:
>
>
>     3,447,492,527,125      cycles/cpu=3D8/
>     3,447,492,527,125      cycles/cpu=3D9/
>      108.543826387 seconds time elapsed
>
> On top of this patch, result looks like:
> ./perf stat report -A
>
>  Performance counter stats for '/root/perf-tools-next/tools/perf/perf':
>
>
>        2.119970008 seconds time elapsed
>
> There are no counter line, only time elapsed. I am suspecting the change =
for perf_event__process_event_update needs update.
> Ian,  have another query as well in the patch , adding them below.

Thanks for testing and catching this!

Before commit 811082e4b668, __perf_evlist__propagate_maps() clobbered
cycles/cpu=3D8/ and cycles/cpu=3D9/ to the "any CPU" (-1) map when recordin=
g
a workload without -a, so both counters recorded CPU -1 (which is why
both reported identical task-wide totals with no CPU8/CPU9 column).

With per-evsel CPUs preserved on workload targets, evlist->user_requested_c=
pus
(written to PERF_RECORD_CPU_MAP) is still the "any CPU" (-1) map while
evlist->all_cpus holds {8, 9}. perf_stat_init_aggr_mode_file() and
perf_stat_init_aggr_mode() built stat_config.aggr_map from
user_requested_cpus (-1) rather than falling back to all_cpus, so CPU 8
and CPU 9 had no entries in aggr_map and were skipped during -A output.
Also process_stat_config_event() checked perf_cpu_map__is_empty(st->cpus)
instead of checking whether all_cpus only contains -1 for pure task data.

I've updated patch 5 in v2 to fall back to evlist->all_cpus when
user_requested_cpus is the "any CPU" (-1) map (and check all_cpus in
process_stat_config_event()), so 'perf stat report -A' now displays the
CPU8 and CPU9 counter lines, and added a '-A' test case in stat.sh.

> >
> > 2. In system-wide mode (-a), per-evsel CPU restrictions such as cpu=3D0
> >   were overwritten by the full PMU cpumask during report, causing
> >   perf stat report -A to report bogus <not counted> entries on every
> >   other CPU.
> >
> > Fix perf_event__synthesize_event_update_cpus() to serialize
> > evsel->core.cpus, and update perf_event__process_event_update() to
> > populate evsel->core.cpus and set requires_cpu when the recorded CPU ma=
p
> > does not use the "any CPU" (-1) placeholder. For backward compatibility
> > with data files recorded by older perf binaries that wrote pmu_cpus for
> > per-task (-1) counters, fall back to the "any CPU" map in
> > perf_event__process_stat_event() if a -1 CPU stat event arrives for an
> > evsel without -1 in its CPU map.
> >
> > Update the event_update unit test and stat.sh record/report/script test=
s
> > to cover per-evsel CPU maps on workload targets.
> >
> > Fixes: 6d765f5f7ec6 ("libperf evsel: Rename own_cpus to pmu_cpus")
> > Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with t=
hreads/processes")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > tools/perf/tests/event_update.c    | 43 ++++++++++++++++++++++++++----
> > tools/perf/tests/shell/stat.sh     | 16 +++++++++++
> > tools/perf/util/evsel.c            |  2 +-
> > tools/perf/util/header.c           |  5 ++++
> > tools/perf/util/stat.c             | 18 +++++++++++++
> > tools/perf/util/synthetic-events.c |  7 +++--
> > 6 files changed, 83 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_u=
pdate.c
> > index 220cc0347747..bacf3c44c8e2 100644
> > --- a/tools/perf/tests/event_update.c
> > +++ b/tools/perf/tests/event_update.c
> > @@ -1,6 +1,7 @@
> > // SPDX-License-Identifier: GPL-2.0
> > #include <linux/compiler.h>
> > #include <perf/cpumap.h>
> > +#include <perf/evlist.h>
> > #include <string.h>
> > #include "cpumap.h"
> > #include "evlist.h"
> > @@ -58,13 +59,20 @@ static int process_event_name(const struct perf_too=
l *tool,
> > return 0;
> > }
> >
> > -static int process_event_cpus(const struct perf_tool *tool __maybe_unu=
sed,
> > +struct event_cpus {
> > + struct perf_tool tool;
> > + struct evlist *evlist;
> > +};
> > +
> > +static int process_event_cpus(const struct perf_tool *tool,
> >      union perf_event *event,
> >      struct perf_sample *sample __maybe_unused,
> >      struct machine *machine __maybe_unused)
> > {
> > + struct event_cpus *tmp =3D container_of(tool, struct event_cpus, tool=
);
> > struct perf_record_event_update *ev =3D (struct perf_record_event_updat=
e *)event;
> > - struct perf_cpu_map *map;
> > + struct perf_cpu_map *map, *any_cpu;
> > + struct evsel *evsel;
> >
> > map =3D cpu_map__new_data(&ev->cpus.cpus);
> >
> > @@ -75,6 +83,26 @@ static int process_event_cpus(const struct perf_tool=
 *tool __maybe_unused,
> > TEST_ASSERT_VAL("wrong cpus", perf_cpu_map__cpu(map, 1).cpu =3D=3D 2);
> > TEST_ASSERT_VAL("wrong cpus", perf_cpu_map__cpu(map, 2).cpu =3D=3D 3);
> > perf_cpu_map__put(map);
> > +
> > + evsel =3D evlist__first(tmp->evlist);
> > + perf_cpu_map__put(evsel->core.cpus);
> > + evsel->core.cpus =3D NULL;
> > + perf_cpu_map__put(evsel->core.pmu_cpus);
> > + evsel->core.pmu_cpus =3D NULL;
> > + evsel->core.requires_cpu =3D false;
> > +
> > + TEST_ASSERT_VAL("failed to process attr update cpus",
> > + !perf_event__process_event_update(tool, event, &tmp->evlist));
> > +
> > + any_cpu =3D perf_cpu_map__new_any_cpu();
> > + TEST_ASSERT_VAL("failed to allocate any_cpu map", any_cpu);
> > + perf_evlist__set_maps(evlist__core(tmp->evlist), any_cpu, NULL);
> > + perf_cpu_map__put(any_cpu);
> > +
> > + TEST_ASSERT_VAL("wrong processed cpus", perf_cpu_map__nr(evsel->core.=
cpus) =3D=3D 3);
> > + TEST_ASSERT_VAL("wrong processed cpus", perf_cpu_map__cpu(evsel->core=
.cpus, 0).cpu =3D=3D 1);
> > + TEST_ASSERT_VAL("wrong processed cpus", perf_cpu_map__cpu(evsel->core=
.cpus, 1).cpu =3D=3D 2);
> > + TEST_ASSERT_VAL("wrong processed cpus", perf_cpu_map__cpu(evsel->core=
.cpus, 2).cpu =3D=3D 3);
> > return 0;
> > }
> >
> > @@ -82,6 +110,7 @@ static int test__event_update(struct test_suite *tes=
t __maybe_unused, int subtes
> > {
> > struct evsel *evsel;
> > struct event_name tmp;
> > + struct event_cpus tmp_cpus;
> > struct target target =3D {};
> > struct evlist *evlist =3D evlist__new_default(&target, /*sample_callcha=
ins=3D*/false);
> >
> > @@ -111,11 +140,15 @@ static int test__event_update(struct test_suite *=
test __maybe_unused, int subtes
> > TEST_ASSERT_VAL("failed to synthesize attr update name",
> > !perf_event__synthesize_event_update_name(&tmp.tool, evsel, process_eve=
nt_name));
> >
> > - perf_cpu_map__put(evsel->core.pmu_cpus);
> > - evsel->core.pmu_cpus =3D perf_cpu_map__new("1,2,3");
> > + perf_cpu_map__put(evsel->core.cpus);
> > + evsel->core.cpus =3D perf_cpu_map__new("1,2,3");
> > +
> > + perf_tool__init(&tmp_cpus.tool, /*ordered_events=3D*/false);
> > + tmp_cpus.evlist =3D evlist;
> >
> > TEST_ASSERT_VAL("failed to synthesize attr update cpus",
> > - !perf_event__synthesize_event_update_cpus(&tmp.tool, evsel, process_e=
vent_cpus));
> > + !perf_event__synthesize_event_update_cpus(&tmp_cpus.tool, evsel,
> > +  process_event_cpus));
> >
> > evlist__put(evlist);
> > return 0;
> > diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/st=
at.sh
> > index ac9e031831da..43a158ee3609 100755
> > --- a/tools/perf/tests/shell/stat.sh
> > +++ b/tools/perf/tests/shell/stat.sh
> > @@ -77,6 +77,14 @@ test_stat_record_report() {
> >     err=3D1
> >     return
> >   fi
> > +  cpu=3D$(sed 's/[-,].*//' /sys/devices/system/cpu/online)
> > +  if ! perf stat record -e "task-clock/cpu=3D${cpu}/,task-clock" -o - =
true | \
> > +    perf stat report -i - 2>&1 | grep -E -q "task-clock/cpu=3D${cpu}/"
> > +  then
> > +    echo "stat record and report test [Failed per-evsel CPU]"
> > +    err=3D1
> > +    return
> > +  fi
> >   echo "stat record and report test [Success]"
> > }
> >
> > @@ -89,6 +97,14 @@ test_stat_record_script() {
> >     err=3D1
> >     return
> >   fi
> > +  cpu=3D$(sed 's/[-,].*//' /sys/devices/system/cpu/online)
> > +  if ! perf stat record -e "task-clock/cpu=3D${cpu}/,task-clock" -o - =
true | \
> > +    perf script -i - 2>&1 | grep -E -q "task-clock/cpu=3D${cpu}/"
> > +  then
> > +    echo "stat record and script test [Failed per-evsel CPU]"
> > +    err=3D1
> > +    return
> > +  fi
> >   echo "stat record and script test [Success]"
> > }
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 1f96c170d277..64daef4cc345 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1822,7 +1822,7 @@ void evsel__config(struct evsel *evsel, const str=
uct record_opts *opts,
> > attr->exclude_user   =3D 1;
> > }
> >
> > - if (evsel->core.pmu_cpus || evsel->unit)
> > + if (evsel->core.cpus || evsel->core.pmu_cpus || evsel->unit)
> > evsel->core.attr.read_format |=3D PERF_FORMAT_ID;
> >
> > /*
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 9eec6deee190..e9af99b8c0f8 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -5962,6 +5962,11 @@ int perf_event__process_event_update(const struc=
t perf_tool *tool __maybe_unused
> > if (map) {
> > perf_cpu_map__put(evsel->core.pmu_cpus);
> > evsel->core.pmu_cpus =3D map;
> > + if (!evsel->counts) {
> > + perf_cpu_map__put(evsel->core.cpus);
> > + evsel->core.cpus =3D perf_cpu_map__get(map);
>
> Here pmu_cpus and core.cpus will point to same data ? When evsel->counts =
is zero, both will carry same =E2=80=9Cperf_cpu_map=E2=80=9D object.
> So during report, the pmu_cpus will hold same contents as =E2=80=9Ccpus=
=E2=80=9D , which is record opened cpu map.
> But ideally pmu_cpus should be having the PMU=E2=80=99s cpumask ?

perf.data only carries a single PERF_EVENT_UPDATE__CPUS record (not a
separate PMU cpumask), and during 'perf stat report' the evsels are
reconstructed from PERF_RECORD_HEADER_ATTR rather than parsed against
the reporting machine's local sysfs PMUs (which may be a different host
with different online CPUs). When set_maps() calls
__perf_evlist__propagate_maps(), non-"any CPU" evsel->cpus is
intersected with evsel->pmu_cpus, so pmu_cpus needs to cover the
recorded CPUs to avoid intersecting them away.

However, when map is the "any CPU" (-1) placeholder, pmu_cpus shouldn't
be set to {-1}. In v2 I've guarded the pmu_cpus assignment with
!perf_cpu_map__has_any_cpu(map) and added a comment explaining why
pmu_cpus is populated from concrete recorded CPU maps.

Thanks,
Ian

> Thanks
> Athira
>
> > + evsel->core.requires_cpu =3D !perf_cpu_map__has_any_cpu(map);
> > + }
> > } else
> > pr_err("failed to get event_update cpus\n");
> > break;
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index 6da3dbbde0e2..429bfc339308 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -8,6 +8,7 @@
> >
> > #include <linux/err.h>
> > #include <linux/zalloc.h>
> > +#include <perf/cpumap.h>
> >
> > #include "counts.h"
> > #include "cpumap.h"
> > @@ -674,6 +675,23 @@ int perf_event__process_stat_event(const struct pe=
rf_tool *tool __maybe_unused,
> > return -EINVAL;
> > }
> > cpu_map_idx =3D perf_cpu_map__idx(evsel__cpus(counter), (struct perf_cp=
u){.cpu =3D st->cpu});
> > + if (cpu_map_idx =3D=3D -1 && (s32)st->cpu =3D=3D -1 && counter->count=
s &&
> > +    evsel__nr_cpus(counter) > 0) {
> > + /*
> > + * Older perf tools wrote pmu_cpus instead of cpus in
> > + * PERF_EVENT_UPDATE__CPUS, leaving per-task counters with a
> > + * CPU list instead of the "any CPU" (-1) map used by their
> > + * PERF_RECORD_STAT events.
> > + */
> > + struct perf_cpu_map *any_cpu =3D perf_cpu_map__new_any_cpu();
> > +
> > + if (any_cpu) {
> > + perf_cpu_map__put(counter->core.cpus);
> > + counter->core.cpus =3D any_cpu;
> > + counter->core.requires_cpu =3D false;
> > + cpu_map_idx =3D 0;
> > + }
> > + }
> > if (cpu_map_idx =3D=3D -1) {
> > pr_err("Invalid CPU %d for event %s.\n", st->cpu, evsel__name(counter))=
;
> > return -EINVAL;
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synth=
etic-events.c
> > index 3c8d29f27fd9..b87d15a5be6a 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -2234,10 +2234,13 @@ int perf_event__synthesize_event_update_name(co=
nst struct perf_tool *tool, struc
> > int perf_event__synthesize_event_update_cpus(const struct perf_tool *to=
ol, struct evsel *evsel,
> >     perf_event__handler_t process)
> > {
> > - struct synthesize_cpu_map_data syn_data =3D { .map =3D evsel->core.pm=
u_cpus };
> > + struct synthesize_cpu_map_data syn_data =3D { .map =3D evsel->core.cp=
us };
> > struct perf_record_event_update *ev;
> > int err;
> >
> > + if (!evsel->core.cpus)
> > + return 0;
> > +
> > ev =3D cpu_map_data__alloc(&syn_data, sizeof(struct perf_event_header) =
+ 2 * sizeof(u64));
> > if (!ev)
> > return -ENOMEM;
> > @@ -2315,7 +2318,7 @@ int perf_event__synthesize_extra_attr(const struc=
t perf_tool *tool, struct evlis
> > }
> > }
> >
> > - if (evsel->core.pmu_cpus) {
> > + if (evsel->core.cpus) {
> > err =3D perf_event__synthesize_event_update_cpus(tool, evsel, process);
> > if (err < 0) {
> > pr_err("Couldn't synthesize evsel cpus.\n");
> > --
> > 2.56.1.750.gf70dc682cf-goog
> >
> >
>
