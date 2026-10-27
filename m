Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793139055;
	b=ww4zQVYGwZK+HjH7cZQNNNhCeRfnz1X44o03vN1D2/iGGWSK298iPErIZVgNS53lz/mJ
	 DC7X0nzgR8GQAnR/2C7t0no7/e+lY0kFDutCpKphiSsGq3k1k9LRxPlxdUnQ2Dhbj/XAo
	 w2eX3/jWHhaA6puYhx5tf5uKaKzNPE+2v7RJwe8nHnVcgKo8PnIvBktnL/K0jYS6jZJJz
	 I2XQkSNef9IYX+jME4fD+o8yUoUkGu6+s5dHGe8fFljMxXMZjOyfxaS7zJvLFT5Pcpm4y
	 533zNRnBZ/38f3YtTUQr1HYyF34qCAmn1E646noI2VJ5WQ8s/VXY+LbQOMfoP2uTxrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Kzu17wwU+EWIvmHfTgSENg2N8EVI1/OmRvpKpjPBKGc=;
	b=yn8MaA7MebWH8k6Mau5lp5uvPglAM8p/HzIMsztykCnJxv2GOTVW5HfFZPx/0LhPV0ha
	 3ccNZTYZM0bH3y3gEr+Kyt44K4rv6iuM6V0ZECdEcxbWD1oqXegLSC3jRbcyg9Vy/R+Rt
	 NOJSeUB/7aLNXXPG0lz8sspBU/2Nsi9sBsEhZeomgWLzVPZa1daP7VkDAvaeWIfr11IJf
	 QxFBy29Hu5h5E8Oue27zbvwysKQ2g4REGAw3i8wcmdycBuB66+0zYPffLIzNrEqoUf1K9
	 /UZpjAtSKp1ZnQBedRztvSEHJVtNyW9tt4jc8ZXE9pO4xUyWvjjK6wGrl6lhyBb22XA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jAjiZRED;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB4E606A32C
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 22:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCB4E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jAjiZRED
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-535f598d126so41671cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 15:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793139054; cv=none;
        d=google.com; s=arc-20260327;
        b=FJC4l7UBqIEsexPT7w/m9JVEBm7vEmokUW0bMdboR0CjvwlmaUVmdZo/nmOMJc1ofs
         iHPWZBnbOLqwTDLZwJPONFLkdamQs7iWrEUatqoI2pf63fFWIzTZzQ30a4TKwgxeJNfQ
         lsD9LQX8MpAJTRuLkaObrqoCjYoBwQtbv7ek0eNDKVA+AC1SrNeIeMwMKIDb7n0A9I2C
         497NJ0YlGwu4sNLDqUFLXtz3wHxwnuNvYT/fdY3Dw2VUZWtSNyf92+hGXBUOcKgGtf0u
         jNc9cEHPjgyr8JwVCmCN4NB++rmmlVv+JCgd70vsSr2/u5Ak/JsFTV6PnwVD444khOAK
         aACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kzu17wwU+EWIvmHfTgSENg2N8EVI1/OmRvpKpjPBKGc=;
        fh=M1q5C+5RLU7BGoBORKXBvlnvYHErIsmvM9TvwOB7i4g=;
        b=n+lHX2HQx1hJYH4X4Zp5Tt18ySzrGtlWmFPBxZOSVzGjMk7ws8VuejlOubreRD8bWg
         fTgmLxEFZLAlOXHFOSeC8718eJmJYv30k/XvTmYUhqPe0cvT5rjtX20XohdXNXugmFvL
         O8DqYzuuXOOHtPQi2NiJ67MAzdZd9UEMJlIWZUrDZmdLPNIGEJxCscfjbs90bEqr0xtz
         ohIk1WRi2CjcKy0GnzXRM9BZNYRsLl/kyUDaPSWcMA/Gp+ZNMhJ6EjLYiO8T1kg/6IEs
         b197B9eH409A3FlLX17qdAarGv5+ODPUHTqjqcZXT9JToJi/CPAH9adfb1ypmEuVOk13
         zHqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139054; x=1793743854; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kzu17wwU+EWIvmHfTgSENg2N8EVI1/OmRvpKpjPBKGc=;
        b=jAjiZRED4efHabS65rAPJo/JB9He1qV3QYfnymMDEINWid1rQWxsT1/bUsDQHQfBpw
         I/pnK4NXhoQvGY91ujGjj7c5Fz+Cxnx8GaTX+XCY+4KKNSncRH4NBlUHoebXzv/qgvh+
         mA93VUuqFUacnyKn4JRJISNONV9vElwrvIVZF+jKT8VrUfGwbPPK+74mvdghqIrn7pZH
         mBJj3DEX7eEIdDhYH0HNhN7InqXX6rICLIu0gimCWKwPeFYamMM/bwZjv+HDU5Hw90YR
         F/cEjs5VHg9u2VJhedCGDhqstPBJmCl3jBOoph/S6h9qDvcwlKY5aMqVka/44qGT8SP/
         hRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139054; x=1793743854;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kzu17wwU+EWIvmHfTgSENg2N8EVI1/OmRvpKpjPBKGc=;
        b=AwoyAW+ubzSb8jIAAx2aQHDE5VbJS8NUZDqQwL2gNWp6dAjd3+znaoadg7VZ2j1DUo
         tUhImH4kuFEUf5gyP4QQIb2BKlJTG1gSERoaaVLjNkqO6hIW8mx+fEQqQvwGAEa5+Qla
         xiH0tgazg7Ru+bRD+CR5cCrmew8VYMO/91KH9FgVpiEKK86JS6O3zzHn8w1bzFr8AA2j
         o84HCQoWVbnuSey7ik0D6ZBdfLwOS+D70wbXcluERPeFQpLxfHEaN/u4mpEpbfDBt2GZ
         P+jDe7Ef+Uk1wj/gk9y6u9htDO6JOR8RegC6qrp035xg1DnC3LNJDqUXLA+eH87eZcbM
         Foqg==
X-Forwarded-Encrypted: i=1; AKwUvBxn7CpwZTdS9qnWkSbqpuKjqeNFcnacHV5tPihV2j2fFx9I3yeRR8ddfnFEk9UXTSQFuQs+ut8mELkOoQJ/JrxV@vger.kernel.org
X-Gm-Message-State: AFq9FYJcMSdQg9AQt5AsEB5nYm6SWl6iECM2XeQsPQ5bTFIICxTOCvO1
	69dy22ShAQ/GsSqGmmaViw3nCs2wRY4Q6gFk1pDanoJ6OVmdaTGZzC6sl8outTGkjMudja+REJV
	E/iqQpmPGgy/EoIAx/Ev2JBtS0TzOGaCQibjuSR9WbwVpq9x7u6Zp6m6KoTM=
X-Gm-Gg: AYBFou2MRiI0PVxkgpbSHwlckGWHA6xOfDiu0vgG89yfVu3eljXNosEnTVIYzSGxly5
	s1DDt7qJcm96ZigJbzv2jyRoe4xOfnS1yYbqFQfbcj8F+5JnXq+M91Ul2m8ZhCivRO//qOeksbr
	95fXn3k8afIEqBnRftWRV8hGa/saB+h7Yi6KYt49oul+WrTDLdhObiO2y3eporfpFfr57frW/kd
	4ZV1kA67AFIT80EeN7w70PjaiF/zWILX1icgr20MGNb9qCJdmvV1jWeZKYACcmNvG7rx+jtc5Xo
	IJfP+fSDroRsBqVx8REyBi5qOJvMvg7DxV6hQ8oJjWnzhaWrI101rNROXhofTUj1tx+k0ZuW9tN
	ACJxpQh9B+Wnxsrqbtj+kLC2gWiuyhSv/Di6+XqxAej9AFMDc5YoOBs6CNlctUlBcQg==
X-Received: by 2002:a05:622a:514d:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-53fbb9967ddmr6974561cf.0.1793139052820; Tue, 27 Oct 2026
 15:10:52 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027203115.2647914-1-ctshao@google.com>
In-Reply-To: <20261027203115.2647914-1-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Oct 2026 15:10:41 -0700
X-Gm-Features: AclHuK_rK__J_E1C_pyQp14ySl_0Aj2dtJg2u9thGouZYItwxYB4DJ7le9mBwoU
Message-ID: <CAP-5=fUF4QFU=f=m29HX3JAn+Sn_K6V6hwcSymGJ3Lehe4ybZw@mail.gmail.com>
Subject: Re: [PATCH v6] perf stat: Include PMU name and split uncore events
 per PMU in metric-only JSON output
To: Chun-Tse Shao <ctshao@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 1:31=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> When running `perf stat` with `-A` (--no-aggr) and `--metric-only` in
> JSON output mode (`-j`), `perf stat` evaluates metric expressions
> across all matching PMUs (including uncore PMUs like `uncore_iio_0`,
> `uncore_iio_1`, etc.).
>
> However, `perf stat` previously formatted JSON output by printing only
> "cpu" : "<id>" and grouping all metric values on a single line per CPU
> without identifying which PMU instance evaluated each metric. As a
> result, when an uncore event spans multiple PMU boxes, `perf stat`
> printed repeated, ambiguous metric keys without PMU names.
>
> Fix this by:
> 1. Including "pmu" : "<pmu_name>" in print_aggr_id_json when evsel->pmu
>    is a non-core or hybrid PMU in AGGR_NONE mode (-A). Tool events are
>    not labeled as they don't belong to a hardware PMU instance.
> 2. Starting a new JSON metric line in AGGR_NONE mode (-A) whenever the
>    PMU name changes, so that a line only has metrics from the PMU it is
>    labeled with.
> 3. Opening a metric line only for events that have a metric, as other
>    events print nothing in metric-only mode. This avoids spurious lines
>    like {"cpu" : "0", "pmu" : "tool"} for events like user_time, while
>    metrics on tool events, like tma_info_system_time (duration_time),
>    are still printed with the line prefix.
> 4. Updating perf_json_output_lint.py to recognize the new "pmu" key in
>    the JSON test suite.
>
> Before the fix:
>   $ perf stat -M iio_bandwidth_read -a -A --metric-only -j -I 1000
>   {"interval" : 1.001017947, "cpu" : "0", "MB/s  iio_bandwidth_read" : "0=
.0", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "22.5=
", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.2", =
"MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.0", "MB=
/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.0", "MB/s =
 iio_bandwidth_read" : "0.0"}
>
> There is no way to determine which uncore device generated the metrics.
>
> After:
>   $ perf stat -M iio_bandwidth_read -a -A --metric-only -j -I 1000
>   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_0", "MB/s  =
iio_bandwidth_read" : "0.0"}
>   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_1", "MB/s  =
iio_bandwidth_read" : "0.1"}
>   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_11", "MB/s =
 iio_bandwidth_read" : "0.0"}
>   ...
>   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_0", "MB/s =
 iio_bandwidth_read" : "0.0"}
>   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_1", "MB/s =
 iio_bandwidth_read" : "0.0"}
>   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_11", "MB/s=
  iio_bandwidth_read" : "0.0"}
>
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
> v6:
>   - Open metric lines for events that have a metric instead of skipping
>     tool events, so metrics on tool events (e.g. tma_info_system_time)
>     keep the line prefix and are terminated properly. (Sashiko)
>   - Split JSON lines only when the shown PMU name changes. Tool event
>     metrics are no longer mislabeled with an uncore PMU name, and the
>     STD and CSV output are no longer split.
>   - Rebase onto the latest perf-tools-next.
> v5: lore.kernel.org/20260811230518.3360-2-ctshao@google.com
>   - Fix perf test "perf stat JSON output linter" failure.
> v4: lore.kernel.org/20260804210659.112192-1-ctshao@google.com
>   - Fix the line splitting issue, causing spurious empty {"pmu": "tool"}
>     objects and order-dependent PMU mislabeling.
> v3: lore.kernel.org/20260729170416.41904-1-ctshao@google.com
>   - Add before the fix output.
> v2: lore.kernel.org/20260715203055.2981363-1-ctshao@google.com
>   - Fix print_metric_begin() initialization in print_no_aggr_metric()
>     to ensure tool events always open lines cleanly.
>
>  .../tests/shell/lib/perf_json_output_lint.py  |  5 +-
>  tools/perf/util/stat-display.c                | 74 ++++++++++++++++---
>  2 files changed, 66 insertions(+), 13 deletions(-)
>
> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/=
perf/tests/shell/lib/perf_json_output_lint.py
> index 8cde22ac9d97..982be893bd69 100644
> --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> @@ -65,6 +65,7 @@ def check_json_output(expected_count):
>        'metricgroup': lambda x: True,
>        'node': lambda x: True,
>        'pcnt-running': isfloat,
> +      'pmu': lambda x: True,
>        'socket': lambda x: True,
>        'thread': lambda x: True,
>        'unit': lambda x: True,
> @@ -99,8 +100,10 @@ def check_json_output(expected_count):
>  try:
>    if args.no_args or args.system_wide or args.event:
>      expected_items =3D [5, 7]
> -  elif args.interval or args.per_thread or args.system_wide_no_aggr:
> +  elif args.interval or args.per_thread:
>      expected_items =3D [6, 8]
> +  elif args.system_wide_no_aggr:
> +    expected_items =3D [6, 7, 8, 9]
>    elif args.per_core or args.per_socket or args.per_node or args.per_die=
 or args.per_cluster or args.per_cache:
>      expected_items =3D [7, 9]
>    elif args.metric_only:
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index b337cc23f413..9f1d74019d1e 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1,6 +1,7 @@
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <inttypes.h>
> +#include <string.h>
>  #include <linux/string.h>
>  #include <linux/time64.h>
>  #include <math.h>
> @@ -23,6 +24,7 @@
>  #include "pmu.h"
>  #include "pmus.h"
>  #include "tool_pmu.h"
> +#include "metricgroup.h"
>
>  #define CNTR_NOT_SUPPORTED     "<not supported>"
>  #define CNTR_NOT_COUNTED       "<not counted>"
> @@ -361,9 +363,33 @@ static void print_aggr_id_csv(struct perf_stat_confi=
g *config,
>         }
>  }
>
> +/*
> + * In no-aggregation mode, JSON output includes the PMU name of non-core=
 and
> + * hybrid events so that events and metrics from different PMU instances=
, like
> + * uncore_iio_0 and uncore_iio_1, can be told apart. Tool events don't b=
elong
> + * to a hardware PMU instance and so are not labeled.
> + */
> +static const char *json_pmu_name(const struct evsel *evsel)
> +{
> +       if (!evsel || !evsel->pmu || evsel__is_tool(evsel))
> +               return NULL;
> +       if (evsel->pmu->is_core && !evsel__is_hybrid(evsel))
> +               return NULL;
> +       return evsel->pmu->name;
> +}
> +
> +static bool json_pmu_name_changed(const char *name, const char *prev)
> +{
> +       if (!name || !prev)
> +               return name !=3D prev;
> +       return strcmp(name, prev) !=3D 0;
> +}
> +
>  static void print_aggr_id_json(struct perf_stat_config *config, struct o=
utstate *os,
>                                struct evsel *evsel, struct aggr_cpu_id id=
, int aggr_nr)
>  {
> +       const char *pmu_name;
> +
>         switch (config->aggr_mode) {
>         case AGGR_CORE:
>                 json_out(os, "\"core\" : \"S%d-D%d-C%d\", \"counters\" : =
%d",
> @@ -397,6 +423,9 @@ static void print_aggr_id_json(struct perf_stat_confi=
g *config, struct outstate
>                         json_out(os, "\"cpu\" : \"%d\"",
>                                 id.cpu.cpu);
>                 }
> +               pmu_name =3D json_pmu_name(evsel);
> +               if (pmu_name)
> +                       json_out(os, "\"pmu\" : \"%s\"", pmu_name);
>                 break;
>         case AGGR_THREAD:
>                 json_out(os, "\"thread\" : \"%s-%d\"",
> @@ -1012,11 +1041,12 @@ static void print_counter_aggrdata(struct perf_st=
at_config *config,
>
>  static void print_metric_begin(struct perf_stat_config *config,
>                                struct evlist *evlist,
> -                              struct outstate *os, int aggr_idx)
> +                              struct outstate *os, int aggr_idx,
> +                              struct evsel *counter)
>  {
>         struct perf_stat_aggr *aggr;
>         struct aggr_cpu_id id;
> -       struct evsel *evsel;
> +       struct evsel *evsel =3D counter ?: evlist__first(evlist);

This seems a bit random, what if there are two metrics? Will they have
the same evsel?

>
>         os->first =3D true;
>         if (!config->metric_only)
> @@ -1031,7 +1061,6 @@ static void print_metric_begin(struct perf_stat_con=
fig *config,
>                 else
>                         fprintf(config->output, "%s", os->timestamp);
>         }
> -       evsel =3D evlist__first(evlist);
>         id =3D config->aggr_map->map[aggr_idx];
>         aggr =3D &evsel->stats->aggr[aggr_idx];
>         aggr_printout(config, os, evsel, id, aggr->nr);
> @@ -1069,7 +1098,7 @@ static void print_aggr(struct perf_stat_config *con=
fig,
>          * Without each counter has its own line.
>          */
>         cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
> -               print_metric_begin(config, evlist, os, aggr_idx);
> +               print_metric_begin(config, evlist, os, aggr_idx, NULL);

Please name arguments that are constants.  Pass evlist__first here?

>
>                 evlist__for_each_entry(evlist, counter) {
>                         print_counter_aggrdata(config, counter, aggr_idx,=
 os);
> @@ -1095,7 +1124,7 @@ static void print_aggr_cgroup(struct perf_stat_conf=
ig *config,
>                 os->cgrp =3D evsel->cgrp;
>
>                 cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
> -                       print_metric_begin(config, evlist, os, aggr_idx);
> +                       print_metric_begin(config, evlist, os, aggr_idx, =
NULL);

Use evsel here?

>
>                         evlist__for_each_entry(evlist, counter) {
>                                 if (counter->cgrp !=3D os->cgrp)
> @@ -1131,7 +1160,8 @@ static void print_no_aggr_metric(struct perf_stat_c=
onfig *config,
>
>         perf_cpu_map__for_each_cpu(cpu, all_idx, evlist__core(evlist)->us=
er_requested_cpus) {
>                 struct evsel *counter;
> -               bool first =3D true;
> +               const char *line_pmu =3D NULL;
> +               bool line_open =3D false;
>
>                 evlist__for_each_entry(evlist, counter) {
>                         u64 ena, run, val;
> @@ -1146,12 +1176,32 @@ static void print_no_aggr_metric(struct perf_stat=
_config *config,
>                                 if (config->aggr_map->map[aggr_idx].cpu.c=
pu =3D=3D cpu.cpu)
>                                         break;
>                         }
> +                       if (aggr_idx >=3D config->aggr_map->nr)
> +                               continue;
>
>                         os->evsel =3D counter;
>                         os->id =3D aggr_cpu_id__cpu(cpu, /*data=3D*/NULL)=
;
> -                       if (first) {
> -                               print_metric_begin(config, evlist, os, ag=
gr_idx);
> -                               first =3D false;
> +
> +                       /*
> +                        * Only events with a metric print something in m=
etric-only
> +                        * mode, so let them open the line. For JSON, sta=
rt a new
> +                        * line when the PMU name changes so that a line =
only has
> +                        * metrics from the PMU it is labeled with.
> +                        */
> +                       if (config->iostat_run ||
> +                           metricgroup__lookup(evlist__metric_events(evl=
ist), counter, false)) {
> +                               const char *pmu_name =3D json_pmu_name(co=
unter);
> +
> +                               if (line_open && config->json_output &&
> +                                   json_pmu_name_changed(pmu_name, line_=
pmu)) {
> +                                       print_metric_end(config, os);
> +                                       line_open =3D false;
> +                               }
> +                               if (!line_open) {
> +                                       print_metric_begin(config, evlist=
, os, aggr_idx, counter);
> +                                       line_pmu =3D pmu_name;
> +                                       line_open =3D true;
> +                               }
>                         }
>                         val =3D ps->aggr[aggr_idx].counts.val;
>                         ena =3D ps->aggr[aggr_idx].counts.ena;
> @@ -1160,7 +1210,7 @@ static void print_no_aggr_metric(struct perf_stat_c=
onfig *config,
>                         uval =3D val * counter->scale;
>                         printout(config, os, uval, run, ena, 1.0, aggr_id=
x);
>                 }
> -               if (!first)
> +               if (line_open)
>                         print_metric_end(config, os);
>         }
>  }
> @@ -1523,7 +1573,7 @@ static void print_cgroup_counter(struct perf_stat_c=
onfig *config, struct evlist
>                                 print_metric_end(config, os);
>
>                         os->cgrp =3D counter->cgrp;
> -                       print_metric_begin(config, evlist, os, /*aggr_idx=
=3D*/0);
> +                       print_metric_begin(config, evlist, os, /*aggr_idx=
=3D*/0, NULL);

In this case, would passing counter be more obvious? The function will
turn this into evlist__first(evlist) but there's no guarantee the
event comes first.

>                 }
>
>                 print_counter(config, counter, os);
> @@ -1573,7 +1623,7 @@ void evlist__print_counters(struct evlist *evlist, =
struct perf_stat_config *conf
>                 } else if (config->cgroup_list) {
>                         print_cgroup_counter(config, evlist, &os);
>                 } else {
> -                       print_metric_begin(config, evlist, &os, /*aggr_id=
x=3D*/0);
> +                       print_metric_begin(config, evlist, &os, /*aggr_id=
x=3D*/0, NULL);

Maybe pass evlist__first here?

Thanks,
Ian

>                         evlist__for_each_entry(evlist, counter) {
>                                 print_counter(config, counter, &os);
>                         }
> --
> 2.56.0.317.g454f8302e1-goog
>
