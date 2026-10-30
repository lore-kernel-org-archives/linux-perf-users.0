Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793388393;
	b=4jgr/+z2ztcSnvMIbZMk7oa1vVa+4nVzv7X1OP8NKfj7i8KYOcnKxsv2IB0pdivSrxrN
	 ItB8VtjvsdVYyi/bUn6Uubll3VPTKD1Hs2uuVXRJh4/zL5xaULIs8C2Pl9ycXpukyMrys
	 NGq7RwGjmXty7kjZt0qZeRz5MnLn7OduPef9wPupgTMpW/wdN2dGBj/SgF2gASwNbhv+2
	 kDtyS5vP/NQAXq+zZ7XA6oCWhJ9lbS3P3iapefYggeW2OJTPyIevt9edD6uIG77/NUH8n
	 Bm+qJg/S2T1rc8jKxgr+noSoMEdiSnQEl2uDvjcGj16nMS29FOTAiVUP5BwJB6VjyYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sgHlXj6h4QGyy7NIQ39vX6G3QQB6Nd9MQnOFsFvVlBo=;
	b=lPEFzyrIvGnB3F21IeBXRvhQXgbZ9RgAXuoLenSFstSFZnRL4tf40XMW2jLEv+3DKAAr
	 qDFSD7vcr+Ib6Obr7AdkyCWa8ucVqpTNqgIJShah+UYUO7zLHIT2cWK73a1vVy8rVd4I9
	 yR6JJ7GhCNNrdpR1GruP/FJs69qebzwoacSS4tXgxugpwsIf6Yfjh4WanVBG9SiOGvxlW
	 yFpzsVU6EjlW5ouDNDotNAA6JAlKkeO9Q8xppn002TJpV40zvtXVh2uV66VOGfB09gMU+
	 NBGiCuRGrDCv3kTVQmz9VJ7nPzXKcJ+KubLmds3PzHQOy+F8NUWZ8gI00YFPaf9RKWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fZk2xDJi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C55606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 19:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53C55606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fZk2xDJi
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36a1947498bso41550eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 12:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793388392; cv=none;
        d=google.com; s=arc-20260327;
        b=iLAKqMkGjWwBGuYGbYSWKowBdx8D0Qz/AyFCCSnwVYrb2mb1bBaH44syAPTcWXo6oP
         XctDfOpCm6s+bzEJ0xi8cGFImsFqKczv1SYMG89/nckChk5s4b4l+ojOfgL67v4KVo9/
         9tQGhcwVHMmMBIlw97QAIe9O3HxVcWjtfuzgX6tROae0FI4X/FmnDelPRaGZx8vWPNkH
         3Q8sNDqVU4xIu11+WavLkz3kwjnCehFLtIL/E1lIv0DUDJJ0cB9LUgMaUa+h6ZpYFM65
         7QnJB/gfiwdYHtWIx1TPQbKr4ykleCdBParxh7TT62p2AfkAa/xFR1Ma+EZg+2+6unqZ
         W5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sgHlXj6h4QGyy7NIQ39vX6G3QQB6Nd9MQnOFsFvVlBo=;
        fh=7osusx65/C8uQdHMAuk22ZQFawl2exHu0/w+/KVnO5U=;
        b=f6D1sU4Iqpae5SOaS51LsGrZedStnsf/Yxwf4NKvPoKKvdKO1T40Z67V59U7AbhQbQ
         p7fMpfkwnSWnRrrAa/SA86w//34EqzJlPEvuAJc3il5nz0gKrscPPm87JEOBIRcCTn6k
         khjucsWtq5sPKwOvZgM7HjiPyt6DseNtPE9k8eUf9UIZu8DckC82A22XuVigFt9atEbH
         xotvykVTJVgVcqHvvfeLwoHb2KV3urC1Eg9fJDoZMYU454y/KF/jeoYlGqmp23Fk9GNx
         lTt46414UNT2HeFlAm1Uc2CL8wi3OZYyfRuAlX+DMXWYdCAXVg8efa8PIkH3q8S7JoP0
         lnqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793388392; x=1793993192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sgHlXj6h4QGyy7NIQ39vX6G3QQB6Nd9MQnOFsFvVlBo=;
        b=fZk2xDJiLN1NijJ6tRumraMom6eOQ7Gf2iRx2bAIfcMVwDjzdaOcCS1o6+YUbI0Yli
         9mkQA5VrSknhy36athONZnoITj/kU8nepNNOAr7TdKmm80wIUWwZZgpwbhMTs1nK4POk
         EFTqDlo1Jh5824QY5N+ic4gX9maI/4pvewhnO3ZyfYP2OZ8gC3DnTlFnIEcFr3BanXYJ
         3lRSXAbOZBhqsIlej3X4tjvXSnBCuaXymJ5YnJLvUPQDTkQCWaEK7MT3mUIeltkhqSMJ
         uGl4nGPjcVyuClemQ1zQBlJHdPfPU/UhzlpQho11H3J1C7DJENHDVrmWgMBnVym+vHmu
         RD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388392; x=1793993192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sgHlXj6h4QGyy7NIQ39vX6G3QQB6Nd9MQnOFsFvVlBo=;
        b=twhkjZs4l7odqnS6OlAkJ4iUyRAtoe6tmgpOT+17e9nritaobp/NmTLGi2C8zIvSii
         wR29rkzWgvdKHSfDTZvHIXwD0zcmkQyw8ooV8UAtx8PD06IfWleFDpqh/WjntjY/wk98
         a61m40i1jreKiYrK0IvRixBC3bjwOi8u4u8XjK32LwUz3aTzrM9V27Mjce68CSffBjnp
         m73DYnd8rMVwLQCn78QlPMGVI84M6VQnD5XvboTEg82cA/pmFSdQEXRueVfySd2GYrX7
         DXRxoxGxJJcfgSZmj1feE5aUiSWzzJnGVOehnLUlpZ6/6Bof8me88727nR9EfPM3rNJh
         P6JA==
X-Forwarded-Encrypted: i=1; AKwUvBysAT/+XMAX6/U3Ji2ubjD1wLuvBVaty6ircxoW/4Vitmjcm2Z+loyEC1SCHBarvvmbZb9mdIQqb/0fhzDomVx3@vger.kernel.org
X-Gm-Message-State: AFq9FYIu3t9es+wKrG3JCRSmzPA+4OcKzHckDR2YUgxbR0DR5snx70H8
	AB3qrYXTJgXxCYn28d6mntsiJNt2MjODsCz919CQC9WsBgDlmJaDI03qL3fQWVHbfW24fiqRpHX
	aZ9mi9OJEp6hx1lbBzAwE8mFOhAevphnhNQcGk4k0
X-Gm-Gg: AYBFou3OhBCL2FjY3+igYy6IsgpfczvVR/2X2m6n5pShdVD43gzXyHV9VKtHloBT3tG
	18Ta2CYNHO0jkKu9VWV6U1oV88mGNN8TPHqM36CrwOBnOXotE7xOTPByXtOLc4jBAIOk2x+V78e
	GP+QfTRnMfRZTGBRndYz5/AUwACdvpZrg08JyRks6fd3k+F5qayhYmgbFCGFcEBBtdR51gcInQm
	OvRrvE4JavAxMIVA6sx9/Y1HDj2tt1XT8JzapyEBPttxaAeTTspIU1NI4lVaG3PEvXELR2n2FSo
	R41i6lR9/3oip9i+MKLAR25GDLAg4fXVP2LAInNhAqNGNnF7GhxtumZqFGBhtDmFEQMkjOk75nc
	eetBhxVhqS4mlcFpt4povkbCbiaWtZ3+CWUxa
X-Received: by 2002:a05:701b:280c:b0:19a:bbe8:41a8 with SMTP id
 a92af1059eb24-1ac5c64cf83mr3723613c88.20.1793388391009; Fri, 30 Oct 2026
 12:26:31 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027203115.2647914-1-ctshao@google.com> <CAP-5=fUF4QFU=f=m29HX3JAn+Sn_K6V6hwcSymGJ3Lehe4ybZw@mail.gmail.com>
In-Reply-To: <CAP-5=fUF4QFU=f=m29HX3JAn+Sn_K6V6hwcSymGJ3Lehe4ybZw@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 30 Oct 2026 12:25:54 -0700
X-Gm-Features: AclHuK9oVrY6WgpWds8FlIzjWxyEK-ngWDhQwXMOZh-iYl1GfjCs5g3lrz40oTA
Message-ID: <CAJpZYjW77aCDi7t=kg6ZbYRS_-LUAhZ71EiRtGgeCRGs0X=vsw@mail.gmail.com>
Subject: Re: [PATCH v6] perf stat: Include PMU name and split uncore events
 per PMU in metric-only JSON output
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian, thanks for your review, please check my v7 patch at:
lore.kernel.org/20261030192537.3079368-1-ctshao@google.com

On Tue, Oct 27, 2026 at 3:10=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Oct 27, 2026 at 1:31=E2=80=AFPM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> >
> > When running `perf stat` with `-A` (--no-aggr) and `--metric-only` in
> > JSON output mode (`-j`), `perf stat` evaluates metric expressions
> > across all matching PMUs (including uncore PMUs like `uncore_iio_0`,
> > `uncore_iio_1`, etc.).
> >
> > However, `perf stat` previously formatted JSON output by printing only
> > "cpu" : "<id>" and grouping all metric values on a single line per CPU
> > without identifying which PMU instance evaluated each metric. As a
> > result, when an uncore event spans multiple PMU boxes, `perf stat`
> > printed repeated, ambiguous metric keys without PMU names.
> >
> > Fix this by:
> > 1. Including "pmu" : "<pmu_name>" in print_aggr_id_json when evsel->pmu
> >    is a non-core or hybrid PMU in AGGR_NONE mode (-A). Tool events are
> >    not labeled as they don't belong to a hardware PMU instance.
> > 2. Starting a new JSON metric line in AGGR_NONE mode (-A) whenever the
> >    PMU name changes, so that a line only has metrics from the PMU it is
> >    labeled with.
> > 3. Opening a metric line only for events that have a metric, as other
> >    events print nothing in metric-only mode. This avoids spurious lines
> >    like {"cpu" : "0", "pmu" : "tool"} for events like user_time, while
> >    metrics on tool events, like tma_info_system_time (duration_time),
> >    are still printed with the line prefix.
> > 4. Updating perf_json_output_lint.py to recognize the new "pmu" key in
> >    the JSON test suite.
> >
> > Before the fix:
> >   $ perf stat -M iio_bandwidth_read -a -A --metric-only -j -I 1000
> >   {"interval" : 1.001017947, "cpu" : "0", "MB/s  iio_bandwidth_read" : =
"0.0", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "22=
.5", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.2"=
, "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.0", "=
MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.0", "MB/=
s  iio_bandwidth_read" : "0.0"}
> >
> > There is no way to determine which uncore device generated the metrics.
> >
> > After:
> >   $ perf stat -M iio_bandwidth_read -a -A --metric-only -j -I 1000
> >   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_0", "MB/s=
  iio_bandwidth_read" : "0.0"}
> >   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_1", "MB/s=
  iio_bandwidth_read" : "0.1"}
> >   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_11", "MB/=
s  iio_bandwidth_read" : "0.0"}
> >   ...
> >   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_0", "MB/=
s  iio_bandwidth_read" : "0.0"}
> >   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_1", "MB/=
s  iio_bandwidth_read" : "0.0"}
> >   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_11", "MB=
/s  iio_bandwidth_read" : "0.0"}
> >
> > Assisted-by: Gemini:gemini-3.1-pro-preview
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> > v6:
> >   - Open metric lines for events that have a metric instead of skipping
> >     tool events, so metrics on tool events (e.g. tma_info_system_time)
> >     keep the line prefix and are terminated properly. (Sashiko)
> >   - Split JSON lines only when the shown PMU name changes. Tool event
> >     metrics are no longer mislabeled with an uncore PMU name, and the
> >     STD and CSV output are no longer split.
> >   - Rebase onto the latest perf-tools-next.
> > v5: lore.kernel.org/20260811230518.3360-2-ctshao@google.com
> >   - Fix perf test "perf stat JSON output linter" failure.
> > v4: lore.kernel.org/20260804210659.112192-1-ctshao@google.com
> >   - Fix the line splitting issue, causing spurious empty {"pmu": "tool"=
}
> >     objects and order-dependent PMU mislabeling.
> > v3: lore.kernel.org/20260729170416.41904-1-ctshao@google.com
> >   - Add before the fix output.
> > v2: lore.kernel.org/20260715203055.2981363-1-ctshao@google.com
> >   - Fix print_metric_begin() initialization in print_no_aggr_metric()
> >     to ensure tool events always open lines cleanly.
> >
> >  .../tests/shell/lib/perf_json_output_lint.py  |  5 +-
> >  tools/perf/util/stat-display.c                | 74 ++++++++++++++++---
> >  2 files changed, 66 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tool=
s/perf/tests/shell/lib/perf_json_output_lint.py
> > index 8cde22ac9d97..982be893bd69 100644
> > --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> > +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> > @@ -65,6 +65,7 @@ def check_json_output(expected_count):
> >        'metricgroup': lambda x: True,
> >        'node': lambda x: True,
> >        'pcnt-running': isfloat,
> > +      'pmu': lambda x: True,
> >        'socket': lambda x: True,
> >        'thread': lambda x: True,
> >        'unit': lambda x: True,
> > @@ -99,8 +100,10 @@ def check_json_output(expected_count):
> >  try:
> >    if args.no_args or args.system_wide or args.event:
> >      expected_items =3D [5, 7]
> > -  elif args.interval or args.per_thread or args.system_wide_no_aggr:
> > +  elif args.interval or args.per_thread:
> >      expected_items =3D [6, 8]
> > +  elif args.system_wide_no_aggr:
> > +    expected_items =3D [6, 7, 8, 9]
> >    elif args.per_core or args.per_socket or args.per_node or args.per_d=
ie or args.per_cluster or args.per_cache:
> >      expected_items =3D [7, 9]
> >    elif args.metric_only:
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-disp=
lay.c
> > index b337cc23f413..9f1d74019d1e 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -1,6 +1,7 @@
> >  #include <stdlib.h>
> >  #include <stdio.h>
> >  #include <inttypes.h>
> > +#include <string.h>
> >  #include <linux/string.h>
> >  #include <linux/time64.h>
> >  #include <math.h>
> > @@ -23,6 +24,7 @@
> >  #include "pmu.h"
> >  #include "pmus.h"
> >  #include "tool_pmu.h"
> > +#include "metricgroup.h"
> >
> >  #define CNTR_NOT_SUPPORTED     "<not supported>"
> >  #define CNTR_NOT_COUNTED       "<not counted>"
> > @@ -361,9 +363,33 @@ static void print_aggr_id_csv(struct perf_stat_con=
fig *config,
> >         }
> >  }
> >
> > +/*
> > + * In no-aggregation mode, JSON output includes the PMU name of non-co=
re and
> > + * hybrid events so that events and metrics from different PMU instanc=
es, like
> > + * uncore_iio_0 and uncore_iio_1, can be told apart. Tool events don't=
 belong
> > + * to a hardware PMU instance and so are not labeled.
> > + */
> > +static const char *json_pmu_name(const struct evsel *evsel)
> > +{
> > +       if (!evsel || !evsel->pmu || evsel__is_tool(evsel))
> > +               return NULL;
> > +       if (evsel->pmu->is_core && !evsel__is_hybrid(evsel))
> > +               return NULL;
> > +       return evsel->pmu->name;
> > +}
> > +
> > +static bool json_pmu_name_changed(const char *name, const char *prev)
> > +{
> > +       if (!name || !prev)
> > +               return name !=3D prev;
> > +       return strcmp(name, prev) !=3D 0;
> > +}
> > +
> >  static void print_aggr_id_json(struct perf_stat_config *config, struct=
 outstate *os,
> >                                struct evsel *evsel, struct aggr_cpu_id =
id, int aggr_nr)
> >  {
> > +       const char *pmu_name;
> > +
> >         switch (config->aggr_mode) {
> >         case AGGR_CORE:
> >                 json_out(os, "\"core\" : \"S%d-D%d-C%d\", \"counters\" =
: %d",
> > @@ -397,6 +423,9 @@ static void print_aggr_id_json(struct perf_stat_con=
fig *config, struct outstate
> >                         json_out(os, "\"cpu\" : \"%d\"",
> >                                 id.cpu.cpu);
> >                 }
> > +               pmu_name =3D json_pmu_name(evsel);
> > +               if (pmu_name)
> > +                       json_out(os, "\"pmu\" : \"%s\"", pmu_name);
> >                 break;
> >         case AGGR_THREAD:
> >                 json_out(os, "\"thread\" : \"%s-%d\"",
> > @@ -1012,11 +1041,12 @@ static void print_counter_aggrdata(struct perf_=
stat_config *config,
> >
> >  static void print_metric_begin(struct perf_stat_config *config,
> >                                struct evlist *evlist,
> > -                              struct outstate *os, int aggr_idx)
> > +                              struct outstate *os, int aggr_idx,
> > +                              struct evsel *counter)
> >  {
> >         struct perf_stat_aggr *aggr;
> >         struct aggr_cpu_id id;
> > -       struct evsel *evsel;
> > +       struct evsel *evsel =3D counter ?: evlist__first(evlist);
>
> This seems a bit random, what if there are two metrics? Will they have
> the same evsel?

I think the evsel is picked in printout, and print_metric_begin is
only for the shared prefix. Test on two metrics sharing the same PMU:

```
$ perf stat -a -A --metric-only -j -M
iio_bandwidth_write,iio_bandwidth_read -- sleep 1
{"cpu" : "0", "pmu" : "uncore_iio_1", "MB/s  iio_bandwidth_read" : "0.0"}
{"cpu" : "0", "pmu" : "uncore_iio_11", "MB/s  iio_bandwidth_read" : "0.0"}
{"cpu" : "0", "pmu" : "uncore_iio_12", "MB/s  iio_bandwidth_read" : "22.5"}
...
{"cpu" : "0", "pmu" : "uncore_iio_11", "MB/s  iio_bandwidth_write" : "0.6"}
{"cpu" : "0", "pmu" : "uncore_iio_12", "MB/s  iio_bandwidth_write" : "0.0"}
{"cpu" : "0", "pmu" : "uncore_iio_14", "MB/s  iio_bandwidth_write" : "0.0"}
...
```

It looks good to me.

Thanks,
CT

>
> >
> >         os->first =3D true;
> >         if (!config->metric_only)
> > @@ -1031,7 +1061,6 @@ static void print_metric_begin(struct perf_stat_c=
onfig *config,
> >                 else
> >                         fprintf(config->output, "%s", os->timestamp);
> >         }
> > -       evsel =3D evlist__first(evlist);
> >         id =3D config->aggr_map->map[aggr_idx];
> >         aggr =3D &evsel->stats->aggr[aggr_idx];
> >         aggr_printout(config, os, evsel, id, aggr->nr);
> > @@ -1069,7 +1098,7 @@ static void print_aggr(struct perf_stat_config *c=
onfig,
> >          * Without each counter has its own line.
> >          */
> >         cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
> > -               print_metric_begin(config, evlist, os, aggr_idx);
> > +               print_metric_begin(config, evlist, os, aggr_idx, NULL);
>
> Please name arguments that are constants.  Pass evlist__first here?
>
> >
> >                 evlist__for_each_entry(evlist, counter) {
> >                         print_counter_aggrdata(config, counter, aggr_id=
x, os);
> > @@ -1095,7 +1124,7 @@ static void print_aggr_cgroup(struct perf_stat_co=
nfig *config,
> >                 os->cgrp =3D evsel->cgrp;
> >
> >                 cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) =
{
> > -                       print_metric_begin(config, evlist, os, aggr_idx=
);
> > +                       print_metric_begin(config, evlist, os, aggr_idx=
, NULL);
>
> Use evsel here?
>
> >
> >                         evlist__for_each_entry(evlist, counter) {
> >                                 if (counter->cgrp !=3D os->cgrp)
> > @@ -1131,7 +1160,8 @@ static void print_no_aggr_metric(struct perf_stat=
_config *config,
> >
> >         perf_cpu_map__for_each_cpu(cpu, all_idx, evlist__core(evlist)->=
user_requested_cpus) {
> >                 struct evsel *counter;
> > -               bool first =3D true;
> > +               const char *line_pmu =3D NULL;
> > +               bool line_open =3D false;
> >
> >                 evlist__for_each_entry(evlist, counter) {
> >                         u64 ena, run, val;
> > @@ -1146,12 +1176,32 @@ static void print_no_aggr_metric(struct perf_st=
at_config *config,
> >                                 if (config->aggr_map->map[aggr_idx].cpu=
.cpu =3D=3D cpu.cpu)
> >                                         break;
> >                         }
> > +                       if (aggr_idx >=3D config->aggr_map->nr)
> > +                               continue;
> >
> >                         os->evsel =3D counter;
> >                         os->id =3D aggr_cpu_id__cpu(cpu, /*data=3D*/NUL=
L);
> > -                       if (first) {
> > -                               print_metric_begin(config, evlist, os, =
aggr_idx);
> > -                               first =3D false;
> > +
> > +                       /*
> > +                        * Only events with a metric print something in=
 metric-only
> > +                        * mode, so let them open the line. For JSON, s=
tart a new
> > +                        * line when the PMU name changes so that a lin=
e only has
> > +                        * metrics from the PMU it is labeled with.
> > +                        */
> > +                       if (config->iostat_run ||
> > +                           metricgroup__lookup(evlist__metric_events(e=
vlist), counter, false)) {
> > +                               const char *pmu_name =3D json_pmu_name(=
counter);
> > +
> > +                               if (line_open && config->json_output &&
> > +                                   json_pmu_name_changed(pmu_name, lin=
e_pmu)) {
> > +                                       print_metric_end(config, os);
> > +                                       line_open =3D false;
> > +                               }
> > +                               if (!line_open) {
> > +                                       print_metric_begin(config, evli=
st, os, aggr_idx, counter);
> > +                                       line_pmu =3D pmu_name;
> > +                                       line_open =3D true;
> > +                               }
> >                         }
> >                         val =3D ps->aggr[aggr_idx].counts.val;
> >                         ena =3D ps->aggr[aggr_idx].counts.ena;
> > @@ -1160,7 +1210,7 @@ static void print_no_aggr_metric(struct perf_stat=
_config *config,
> >                         uval =3D val * counter->scale;
> >                         printout(config, os, uval, run, ena, 1.0, aggr_=
idx);
> >                 }
> > -               if (!first)
> > +               if (line_open)
> >                         print_metric_end(config, os);
> >         }
> >  }
> > @@ -1523,7 +1573,7 @@ static void print_cgroup_counter(struct perf_stat=
_config *config, struct evlist
> >                                 print_metric_end(config, os);
> >
> >                         os->cgrp =3D counter->cgrp;
> > -                       print_metric_begin(config, evlist, os, /*aggr_i=
dx=3D*/0);
> > +                       print_metric_begin(config, evlist, os, /*aggr_i=
dx=3D*/0, NULL);
>
> In this case, would passing counter be more obvious? The function will
> turn this into evlist__first(evlist) but there's no guarantee the
> event comes first.
>
> >                 }
> >
> >                 print_counter(config, counter, os);
> > @@ -1573,7 +1623,7 @@ void evlist__print_counters(struct evlist *evlist=
, struct perf_stat_config *conf
> >                 } else if (config->cgroup_list) {
> >                         print_cgroup_counter(config, evlist, &os);
> >                 } else {
> > -                       print_metric_begin(config, evlist, &os, /*aggr_=
idx=3D*/0);
> > +                       print_metric_begin(config, evlist, &os, /*aggr_=
idx=3D*/0, NULL);
>
> Maybe pass evlist__first here?
>
> Thanks,
> Ian
>
> >                         evlist__for_each_entry(evlist, counter) {
> >                                 print_counter(config, counter, &os);
> >                         }
> > --
> > 2.56.0.317.g454f8302e1-goog
> >
