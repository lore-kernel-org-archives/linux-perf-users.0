Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A016FD3
	for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877902; cv=none; b=FFkAv6MExwkict3BbZ0qK6eRTiKpjUD+iUOzLNMgEqt/zxcFh6+1JgK9NNwDyDXEZDuobNMbZ5V96F8ew0J14YKSE5+YTkQ4AWRA9MrKFlGUvvZTrAcr4y+slhLRGZoqGwQu9E6b7LxQZuvQXfkY3D15fzu6fnYmVLbwi5LbA9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877902; c=relaxed/simple;
	bh=VPlsruD35JAQqV3gEarB9dVDjoQdF9uedLGs17A74Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2Se+tRNsxeGIHpd+zyxM01ROgED58jc/Z8UK0OcjYpVqRzoVykHFR5YF+M2EX+Kq6NWF1HThPN18pbK3+wtXUgIngEhC/apaQto0+Nxx5wYSVG3H0v6bkQIFrUbnaETmq4SzaecXXPbTRi8dleEkrcomh3JuLVh1GcgIh134iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kz+G+R1q; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kz+G+R1q"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ec76185c0fso1425ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715877900; x=1716482700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdYJOsDWTmNqWlkMdmJgsT3jwYhNIzkdpl7HU6s1mPM=;
        b=Kz+G+R1qLk3OLN6bHUcpI4zJv1tFB3tEbn8aPL+XDjyuRoPG1KIaVRuit5M1fMrenO
         Q8V1z8hdpOWSusdBAQzEuBvHZDgXezvbuIvroWFsuQy1I2Y7P/9i3JAFvQN8kDDzyilf
         PiFe5nj08ieK0xXps3j5z8OHoz5XPh3HmBYhUMKKAeEdbUmrrY9Rm4/328wX9uv3RH6X
         xXvBhK9Ljd9D/CxBAIkoUfoRGazbbExkjU7lJAqO8dqPcZrDOuYkxZUQIS2gW+tjpegD
         Y1Hs0hMcHM1GVH0E1Z52GgZm/ajOgC8bSZuNew7mfMPc8nYoLETltWZoZ5z9rGyLlNN8
         gxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715877900; x=1716482700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdYJOsDWTmNqWlkMdmJgsT3jwYhNIzkdpl7HU6s1mPM=;
        b=joLDbxrJgQKSGr0yZxBlMstbvQQwTEIgCP/nm/Qu6vsfiRwDBQYUYIduvJLuT2SliF
         BbN0KQZ+KNBe3mDnahbrwBMjdaOkjhaHzAfrHJ0fR63KdwO6krhsFVdcuLngocap2pkf
         Ygg7QUsO5U+Ikk9OLYQ9Vz/RnS42pVqOEjv7LWS23aUUXFOBBhAtwVhF2vKtBvdk1ZSn
         L9PKA2MqpISof7KF3/y5+UXoSAWPendRuZIr+aTLDU7eYk+PLxlqB4u3efDVuGunWBoW
         P6Ko2pFNNpwPyZKeMYZ02hT0A4ZNDvrY+2vSrQlQHXDooORCO9Pf8RXutsTzwnyb02D8
         u7JA==
X-Forwarded-Encrypted: i=1; AJvYcCU4aTsegQbKeix1rincdC5+kKW/Ju1Oy3QjIzOCkqwTiD/zWeOIHT84/S23NXtTXt5LecL6HOTc/CtgCt3gk6L7gBkoCpigpVaDBOyim18DrA==
X-Gm-Message-State: AOJu0YyaQUwcRXTSKB2alqt44ptMIFR2w55aTR+w/yq0wht4KYRiymaC
	/cwTOvnhKI/BBZRWZQf7wuvzLR7Bh3L6gTU/hqOVPZBlsoF9fW1zxX+9MHY1qbh8RTNpN4V3vHJ
	HLQAjEmuDLVrAHPCghAUh4ex+gMSfzoY3lAZc
X-Google-Smtp-Source: AGHT+IFoo1JC4O175ZwyZQ3bk20utaBoBQQlTCsOymwt/4ExhPv/s5Y88E8nNj97m7jZ58XxCGj3unXFb5zKqk6ouR8=
X-Received: by 2002:a17:902:ec86:b0:1e5:5cce:7eca with SMTP id
 d9443c01a7336-1f05f660814mr12642895ad.8.1715877899735; Thu, 16 May 2024
 09:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515054443.2824147-1-weilin.wang@intel.com> <20240515054443.2824147-5-weilin.wang@intel.com>
In-Reply-To: <20240515054443.2824147-5-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 May 2024 09:44:45 -0700
Message-ID: <CAP-5=fUmH74Bbbm40oqDynDQL+GUi7iFKjHKSKc5-dPafqifzA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 4/7] perf stat: Add retire latency values into the
 expr_parse_ctx to prepare for final metric calculation
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:44=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Retire latency values of events are used in metric formulas. This update =
adds
> code to process data from perf record for required retire latency values.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>

In the evsel approach:
https://lore.kernel.org/lkml/20240428053616.1125891-1-irogers@google.com/
we don't need to special case tpebs events like this. I'd prefer we
went that route. My reviewed-by no longer stands.

Thanks,
Ian

> ---
>  tools/perf/util/stat-shadow.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index 3466aa952442..b97d23bfeac1 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -15,6 +15,7 @@
>  #include <linux/zalloc.h>
>  #include "iostat.h"
>  #include "util/hashmap.h"
> +#include "util/intel-tpebs.h"
>
>  struct stats walltime_nsecs_stats;
>  struct rusage_stats ru_stats;
> @@ -355,6 +356,20 @@ static void print_nsecs(struct perf_stat_config *con=
fig,
>                 print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0=
);
>  }
>
> +static int prepare_retire_lat(struct expr_parse_ctx *pctx,
> +                            struct list_head *retire_lats)
> +{
> +       int ret =3D 0;
> +       struct tpebs_retire_lat *t;
> +
> +       list_for_each_entry(t, retire_lats, nd) {
> +               ret =3D expr__add_id_val(pctx, strdup(t->tpebs_name), t->=
val);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +       return ret;
> +}
> +
>  static int prepare_metric(const struct metric_expr *mexp,
>                           const struct evsel *evsel,
>                           struct expr_parse_ctx *pctx,
> @@ -369,6 +384,9 @@ static int prepare_metric(const struct metric_expr *m=
exp,
>                 double val;
>                 int source_count =3D 0;
>
> +               if (metric_events[i]->retire_lat)
> +                       continue;
> +
>                 if (evsel__is_tool(metric_events[i])) {
>                         struct stats *stats;
>                         double scale;
> @@ -486,6 +504,11 @@ static void generic_metric(struct perf_stat_config *=
config,
>                 pctx->sctx.user_requested_cpu_list =3D strdup(config->use=
r_requested_cpu_list);
>         pctx->sctx.runtime =3D runtime;
>         pctx->sctx.system_wide =3D config->system_wide;
> +       i =3D prepare_retire_lat(pctx, &config->tpebs_results);
> +       if (i < 0) {
> +               expr__ctx_free(pctx);
> +               return;
> +       }
>         i =3D prepare_metric(mexp, evsel, pctx, aggr_idx);
>         if (i < 0) {
>                 expr__ctx_free(pctx);
> --
> 2.43.0
>
