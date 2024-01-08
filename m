Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4435674A
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jan 2024 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so765101a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jan 2024 14:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704751798; x=1705356598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbC+D584W0D0KSugGapjXBZmgIZVeoM2WZDjYENxdGs=;
        b=I9lwUszx92I2LDLGTS7aC3VGmhfZQrII3oYUPCPFgJuHWdYr2SqnO8wS/QwhuDhW4V
         9AV9HoSNwctHIy4K5Ihr8hGCZ2G2Vbu24CC4cnkr18RUsKatF15QikrtxTep/NrFv7jb
         zk6X30i3UwbgPFsmFOfXcqIWSzBT051VneXLxh06DkDGGSk/zgH1x+eLRHy3D4Keq/TN
         vL4UC5ET7uJ+/TjmBQfIVePYO996TLQGLTmWVzwai7wMpTucNwA/wgdVX2ZbvijaFUsV
         TXmikkx3/I0PCeBGdKjQQHuXZlVFYlcOiLne2ofkHbD+HOLXci4/aQZgB7tk645aCR+j
         Wg+Q==
X-Gm-Message-State: AOJu0Yz8eNmMvKDW9B7h0e2aAdYGY37PJvEsBOGhoASYePUYl0gQWsUR
	H4Yt14XcuaZ5gYfUExFUsix+bv0J5yfkVwwvoXs=
X-Google-Smtp-Source: AGHT+IHJWWTI2kEhMaM5T+XfLJ+1liongkoQ4kXMbj9ECcYldMAaEJL5JfdOwAv//vWv+q0EWSDBybG9jbcTFz8ESsc=
X-Received: by 2002:a17:90a:b318:b0:28c:fb01:a2d5 with SMTP id
 d24-20020a17090ab31800b0028cfb01a2d5mr1625089pjr.67.1704751798329; Mon, 08
 Jan 2024 14:09:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106094129.3337057-1-siyanteng@loongson.cn>
In-Reply-To: <20240106094129.3337057-1-siyanteng@loongson.cn>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 8 Jan 2024 14:09:47 -0800
Message-ID: <CAM9d7ciJ-H6+K_W02OsgV-LyJ_eBzH=5idDB9-TQ31Dv2_pFXA@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Fix compiler error when using gcc-14.
To: Yanteng Si <siyanteng@loongson.cn>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, Sun Haiyong <sunhaiyong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Jan 6, 2024 at 1:41=E2=80=AFAM Yanteng Si <siyanteng@loongson.cn> w=
rote:
>
> From: Sun Haiyong <sunhaiyong@loongson.cn>
>
> the definition of calloc is as follows:
>     void *calloc(size_t nmemb, size_t size);
> number of members is in the first parameter and the size is in the second
> parameter.
>
> fixed error message on the gcc 14 20240102:
> error: 'calloc' sizes specified with 'sizeof' in the earlier argument and
> not in the later argument [-Werror=3Dcalloc-transposed-args]
>
> Signed-off-by: Sun Haiyong <sunhaiyong@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-record.c        | 4 ++--
>  tools/perf/util/hist.c             | 4 ++--
>  tools/perf/util/metricgroup.c      | 2 +-
>  tools/perf/util/synthetic-events.c | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 91e6828c38cc..86c910125172 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -4080,8 +4080,8 @@ int cmd_record(int argc, const char **argv)
>         }
>
>         if (rec->switch_output.num_files) {
> -               rec->switch_output.filenames =3D calloc(sizeof(char *),
> -                                                     rec->switch_output.=
num_files);
> +               rec->switch_output.filenames =3D calloc(rec->switch_outpu=
t.num_files,
> +                                                     sizeof(char *));
>                 if (!rec->switch_output.filenames) {
>                         err =3D -EINVAL;
>                         goto out_opts;
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 0888b7163b7c..fa359180ebf8 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -491,8 +491,8 @@ static int hist_entry__init(struct hist_entry *he,
>         }
>
>         if (symbol_conf.res_sample) {
> -               he->res_samples =3D calloc(sizeof(struct res_sample),
> -                                       symbol_conf.res_sample);
> +               he->res_samples =3D calloc(symbol_conf.res_sample,
> +                                       sizeof(struct res_sample));
>                 if (!he->res_samples)
>                         goto err_srcline;
>         }
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index ca3e0404f187..966cca5a3e88 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -286,7 +286,7 @@ static int setup_metric_events(const char *pmu, struc=
t hashmap *ids,
>         *out_metric_events =3D NULL;
>         ids_size =3D hashmap__size(ids);
>
> -       metric_events =3D calloc(sizeof(void *), ids_size + 1);
> +       metric_events =3D calloc(ids_size + 1, sizeof(void *));
>         if (!metric_events)
>                 return -ENOMEM;
>
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 3712186353fb..2a0289c14959 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1055,11 +1055,11 @@ int perf_event__synthesize_threads(struct perf_to=
ol *tool,
>         if (thread_nr > n)
>                 thread_nr =3D n;
>
> -       synthesize_threads =3D calloc(sizeof(pthread_t), thread_nr);
> +       synthesize_threads =3D calloc(thread_nr, sizeof(pthread_t));
>         if (synthesize_threads =3D=3D NULL)
>                 goto free_dirent;
>
> -       args =3D calloc(sizeof(*args), thread_nr);
> +       args =3D calloc(thread_nr, sizeof(*args));
>         if (args =3D=3D NULL)
>                 goto free_threads;
>
> --
> 2.31.4
>
