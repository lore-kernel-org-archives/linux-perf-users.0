Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C429F22A1E6
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Jul 2025 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751512196; cv=none; b=pyepcrFciauVDRTP3tkfv9qd+kMzDoe6180a8f2VWkSyhSD+o+cTiiTiV1OnO4m8BLV82cfuCVPRnYzOSZDJpSd/uYfoLx1X2IvJHCrx5wgoIVd8F0/7ApWTTLd2H1XnxsIx4+M4lQ51r5C/blkkdxhPY3PeDvLhrD6pFz3P2ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751512196; c=relaxed/simple;
	bh=JnCo2aoHFSJ11Aw5PF1ftslLuVHtM2rnPxMlpD4sHYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qa3jUi7gNWYB4+4spBcn8A0lB/cXe0/hca0hf5necGSSShP/rLfG7umbzdWw52fhR944djEKheQwxkgC5FOPFUoFYIm3lh8T1k4WRl7NQqjsgc7mLTG49gekwG1v7OimK7aQ6SlalHHNYN1bMC8tufUaEbCsWqcvcM2U1YhZwbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tv777b7Y; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tv777b7Y"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so119845ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Jul 2025 20:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751512194; x=1752116994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwA3weHf33UXUUiOiLIv8oEn40SuH4N/NO2dHdlTtm4=;
        b=Tv777b7YTdH2eQmEpz8OwWcMwIO6rbERaspV87/nXcQHHW2lNT2WB0VPGkOmHpWiU3
         bs9ivfTVNEshYOgrEwY+lWqq9TUZ4tuNoDsmpjzBadwJ/o+JcbPcUakWtG7/Yw/jPNgh
         LtzGQkUAf/fyAukY4ItfCpcK1xqmn8yX5/YpXHEh4sYJVI8ULA/TbVjR8YEZeumP5je8
         s6L1HtBbbmZ9ks5q6/eNWWTtBC0mLi6jwbL47YNPj22/37sPyKLQfhsS2KWhWqMP4ZL/
         Hhbksk/a3Amk6KpsOglL26y27gsovT2b5qASHZhp3GCm5Wh+pXbd+Ny2gHMFkmFNl8C3
         8edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751512194; x=1752116994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwA3weHf33UXUUiOiLIv8oEn40SuH4N/NO2dHdlTtm4=;
        b=DQGTfZoiQdTH9MHts5FzPzcN/LCwQAHocd8HldrDRb7lYaGyv0D7Zv1U4MJYktLGN1
         TWhENDBd7x8vtGOWTdVMfVjeMkDH+VzJI7p/htpLVymaja0tj90TJqw6GR4WvrC+YbzR
         o4w62niTtjY9rXhxThQvyVabIBzjEdsRK0cUejAREC5SZ8R2Ag8kWVKMkDzj4O+JfrYg
         kUjC7K/cuCgloHrvxHu0FaYHByIVFiCYK84cqkFDME0X211LJbYPk5PJk+iJWsXfqy1a
         VRZgEUxFWtpQATRXQW/NhfIeT6pV6GEaDQGpDJQsxo7h+ZiPMSvcN0MFnycQw/dDqaBI
         IR4w==
X-Forwarded-Encrypted: i=1; AJvYcCVqaD5loV8pe0/VJydvPotsTkNk8v7SuykGSB8koqtOGEAG9Vun9r6fk5OJ72qwemh3M8hDDqxLbCYg2w2//k9X@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/DjPbUWuI1GkbutpC88q+z4RJKNePI4jQz5yEf8JUT9pYYag
	6xcBeoGVYnUoE1fzug0TXH4E3AduYh5a/NVL3d1dYyrtfFX9vyawA8WDeItctG0Q8Gc8qYOtpdm
	M8WjvoPkAdVPNYFelLhXfr7izdW1PnX28t9H6em0D
X-Gm-Gg: ASbGncu6qEaVnXRDNZ9zWMaHKNONQYleBx+rbB1/p8dmuO57LFPOFOzCLh+qQnQJXiW
	oRFtVnXsqFbxROYJM2PwiUYOdcZmniKGGYSfRlAiDVaEUigNNt1bRTpmorFj5f598jV/pC2AB1G
	fOyyRxK2Vk2uD546uxr5NH+/l5/p8CAQoS4osFACQs1d50
X-Google-Smtp-Source: AGHT+IEXHJ3CbfVBewiNP3m8cBhI4iq/+6/9THX/DJXwQBljwiviqC1+5WHP5TzSI6evYlTvpTNbgvBi0QNghl9XDGE=
X-Received: by 2002:a05:6e02:16c6:b0:3dd:bdcc:5b29 with SMTP id
 e9e14a558f8ab-3e05d28fc57mr975795ab.21.1751512193547; Wed, 02 Jul 2025
 20:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703014942.1369397-1-namhyung@kernel.org> <20250703014942.1369397-6-namhyung@kernel.org>
In-Reply-To: <20250703014942.1369397-6-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Jul 2025 20:09:41 -0700
X-Gm-Features: Ac12FXxAzfpEgisJE9Q7lMR6b7WxYi4yZIZKQDLrblBd0vccQT1yOURI4IoeEyI
Message-ID: <CAP-5=fX2gUk-R-cYjv7j4SF=Sya9hFS_7HMOpzpR6V0KSQq59w@mail.gmail.com>
Subject: Re: [PATCH 5/8] perf sched: Fix memory leaks for evsel->priv in timehist
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 6:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> It uses evsel->priv to save per-cpu timing information.  It should be
> freed when the evsel is released.
>
> Add the priv destructor for evsel same as thread to handle that.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-sched.c | 12 ++++++++++++
>  tools/perf/util/evsel.c    | 11 +++++++++++
>  tools/perf/util/evsel.h    |  2 ++
>  3 files changed, 25 insertions(+)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 83b5a85a91b7ffbd..a6eb0462dd5be20f 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2020,6 +2020,16 @@ static u64 evsel__get_time(struct evsel *evsel, u3=
2 cpu)
>         return r->last_time[cpu];
>  }
>
> +static void timehist__evsel_priv_destructor(void *priv)
> +{
> +       struct evsel_runtime *r =3D priv;
> +
> +       if (r) {
> +               free(r->last_time);
> +               free(r);
> +       }
> +}
> +
>  static int comm_width =3D 30;
>
>  static char *timehist_get_commstr(struct thread *thread)
> @@ -3314,6 +3324,8 @@ static int perf_sched__timehist(struct perf_sched *=
sched)
>
>         setup_pager();
>
> +       evsel__set_priv_destructor(timehist__evsel_priv_destructor);
> +
>         /* prefer sched_waking if it is captured */
>         if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched=
_waking"))
>                 handlers[1].handler =3D timehist_sched_wakeup_ignore;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 9c50c3960487feee..3896a04d90af71f3 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1657,6 +1657,15 @@ static void evsel__free_config_terms(struct evsel =
*evsel)
>         free_config_terms(&evsel->config_terms);
>  }
>
> +static void (*evsel__priv_destructor)(void *priv);
> +
> +void evsel__set_priv_destructor(void (*destructor)(void *priv))
> +{
> +       assert(evsel__priv_destructor =3D=3D NULL);
> +
> +       evsel__priv_destructor =3D destructor;
> +}
> +
>  void evsel__exit(struct evsel *evsel)
>  {
>         assert(list_empty(&evsel->core.node));
> @@ -1687,6 +1696,8 @@ void evsel__exit(struct evsel *evsel)
>         hashmap__free(evsel->per_pkg_mask);
>         evsel->per_pkg_mask =3D NULL;
>         zfree(&evsel->metric_events);
> +       if (evsel__priv_destructor)
> +               evsel__priv_destructor(evsel->priv);
>         perf_evsel__object.fini(evsel);
>         if (evsel__tool_event(evsel) =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME |=
|
>             evsel__tool_event(evsel) =3D=3D TOOL_PMU__EVENT_USER_TIME)
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 6dbc9690e0c9258c..b84ee274602d7d2b 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -280,6 +280,8 @@ void evsel__init(struct evsel *evsel, struct perf_eve=
nt_attr *attr, int idx);
>  void evsel__exit(struct evsel *evsel);
>  void evsel__delete(struct evsel *evsel);
>
> +void evsel__set_priv_destructor(void (*destructor)(void *priv));
> +
>  struct callchain_param;
>
>  void evsel__config(struct evsel *evsel, struct record_opts *opts,
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
