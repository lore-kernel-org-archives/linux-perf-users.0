Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C8017C8
	for <linux-perf-users@vger.kernel.org>; Sun, 24 Mar 2024 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711251930; cv=none; b=ngKmOTOfvFBVaj3y88ODmml8YEyjB75zwBGMlVpBWkENR3VNARWEP7cVgTfMlA09vN6S+If7wrkOWf56SvA2uGFtOI7vS4XNe0mW/eE4QCyzswRgcQznS+fflNqRF9McrjpLd+xaT6yaY3xQexK35jvzunlq8/M9uCeRHBmYINE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711251930; c=relaxed/simple;
	bh=iUzFpA4Fu9YSmQkZKCSOgGKftUekVbN3SUQ87quTRH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l93OqGvtAWijo4KKBnohVOst53Std5h1bslgiNljyUxe52jq5Dl0b5F+pPJtdy3wXRRclsg/Dq7JGNn/oxftTTd2DG3QAV3XZ+Wo1oBDvzL+3uD8d4Lf2+Btn/hCW3lIN/7CbvugOrycbRi1W/fjiuLSHg0IObeWAmUNujl8W2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EyZlVcOf; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EyZlVcOf"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-366abfd7b09so169505ab.0
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Mar 2024 20:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711251928; x=1711856728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZCokTmZle4WRUisGL16ZDZ627DO4HnlPXhDi+B1ycU=;
        b=EyZlVcOfn2+UYty3BpUX1+7YyL3lxQjtz8AUUZel2B/mIOJAMY+lZ9OWrbHvGiMGzc
         zvNw+RsA29fgra0RFXlwmVsBB2ganmy4MzWMU13uJHGT8JXIK3tiv+bNv8JfNAtllEos
         cn5c0H/DH6nY+XLAJprv/Y9tWKuyIFMvpEEdGITOa+bj0Bt6tWCFVh0OQzGTXjRC0suE
         h4Usmmqu4hnATBbFVjCvrs+d1HDohMP4JCwfNSInUmwngVDyd8IBEW96ubyU5ZhWOyLC
         MB57+kMQCKP/eUyt0lMTFPu1p+lgK/Ezi43PApZUVDkcMxMaV1gdG+rYLmms9/V3cMEY
         n8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711251928; x=1711856728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZCokTmZle4WRUisGL16ZDZ627DO4HnlPXhDi+B1ycU=;
        b=qCaTNGNU6uZgs/E/weTD5Gco3mXbMHMGB4ychRyuWTiXiPIL30CJP005tj0IRxjWGD
         cW4KVsJmhi/5mqZqsxgb3O9xa4BiwXMdpsMwHR6TADV+MYLl2j732I9E847jGZGWn/bz
         KXO4u0RopdxBuML4fGj6h5WMWvfU5DYHUT6plhEX/0B8OsDAw4kTSWCAp7tsB/0A8sB9
         MntazuvoZQXq1HVDOIzTJ4rs7tdsqv18vuBIteUy2Rz0qVzemBH1aKRktJfgYQV18+NU
         5Qg5nq6Bnny/mR6VJEZy9DfKavyllZSNJvM2WKrqkw26PAAVnUN7QYri3UXIcqcU7xQ/
         RTGw==
X-Forwarded-Encrypted: i=1; AJvYcCUYFQR+FWahpjzbyfV41IuFb5XWUF5hWD0o6H0gRJCVMlJ+R8c8yXwQl8uZj2A9t8Lb+xlNLnkLMZH1kBcNvbrZ2Ky7klymfxVnLnes1SCtnw==
X-Gm-Message-State: AOJu0Yw1EcrgqnNHTS+q0c0wS6YrI1IIJIVRbl+xa4owkgi83qJw7mrX
	YLGAx8TSCgJUGvsDxGBoGhPBtCXfWdqxj6LycuoVbo9HyErhUkM2DT1hIIhKcF0B4Ah7Xi9IYnP
	lmp+JOK5CjJ0gDJUZd/su2zRXEgolc3b5/GEA
X-Google-Smtp-Source: AGHT+IEgum0vXLed6NbuUwGmJ7FXxoDws9TF50Q15ohjHnrKGyAZHh3ZXJb/gugHgM0BpVGrx3rlI3tuTpp/saspbHE=
X-Received: by 2002:a05:6e02:12e4:b0:366:526f:17b2 with SMTP id
 l4-20020a056e0212e400b00366526f17b2mr815554iln.9.1711251928224; Sat, 23 Mar
 2024 20:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312234921.812685-1-weilin.wang@intel.com> <20240312234921.812685-4-weilin.wang@intel.com>
In-Reply-To: <20240312234921.812685-4-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 20:45:14 -0700
Message-ID: <CAP-5=fVmnAaJAuC5oZcP7H3BVz3+8n5zVu_UxZTyXsS3LEj3TA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/6] perf stat: Add retire latency values into the
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

On Tue, Mar 12, 2024 at 4:49=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Retire latency values of events are used in metric formulas. This update =
adds
> code to process data from perf record for required retire latency values.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/builtin-stat.c     |  1 +
>  tools/perf/util/metricgroup.h |  1 +
>  tools/perf/util/stat-shadow.c | 19 +++++++++++++++++++
>  3 files changed, 21 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 4e92e73cbeaf..a479b21874b0 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -786,6 +786,7 @@ static int process_sample_event(struct perf_tool *too=
l __maybe_unused,
>                 if (!strcmp(evname, t->name)) {
>                         t->count +=3D 1;
>                         t->sum +=3D sample->retire_lat;
> +                       t->val =3D (double) t->sum / t->count;
>                         break;
>                 }
>         }
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index 3c37d80c4d34..38f9134d8b54 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -82,6 +82,7 @@ struct tpebs_retire_lat {
>         const char *tpebs_name;
>         size_t count;
>         int sum;
> +       double val;

Given the similarity of count, sum and val it would be good to document the=
m.

>  };
>
>  struct metric_event *metricgroup__lookup(struct rblist *metric_events,
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index 3466aa952442..8fc3415de106 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -355,6 +355,20 @@ static void print_nsecs(struct perf_stat_config *con=
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
> @@ -486,6 +500,11 @@ static void generic_metric(struct perf_stat_config *=
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
