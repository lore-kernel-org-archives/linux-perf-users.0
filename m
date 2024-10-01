Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24951CB308
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804699; cv=none; b=UUxg3ARtWK7djOSvtQhYvMKT1xZFwzJdEde6qR40eDTWQVj+SqfEIq1qC5kibkGb7YvqF579XPNloyqZbydhYFQKEv8okcH8FN8Fa//srTGIDqmhnlbOzwVM4DWAPYIoXIcMmDf7ttmw9Yia6R+WyJNVy556ay4C1RvMv+tT2qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804699; c=relaxed/simple;
	bh=SQ+aVhFQpxj15QWJrRUSzObbOU7GnMskBGf8Cdbmi7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIvpBN7VL3/NtYvYHMSOsSwnI4Oqox7gfO/M8F+lZZF9EVfcrgwEmbfdbvddg6K7lX+h2b0W3chFyt+Tztg/t+bfj1lcGBG5nuPB7NQqSYyLIYRppLQi5tnBDsNcRVS+bWkt7B0/DSIifXpYLwrTt6riaNP8ckeeYkZhOFgLzc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ovzdc85U; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ovzdc85U"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4582a5b495cso22131cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 10:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727804697; x=1728409497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Em5LGkch8nDUBUVgonI9cq9bFbnQYt7iISXA27TCkLA=;
        b=ovzdc85URf2Zj/WFrs+lIF2R6xbye8RM85WIgi9sDcef5RZzCa3tmqM2Jv8COzxsFK
         ufYLPOCp79gT00dvL+9knuHRo7Vyq0lluM07Bz6H2rmbwL+htwqgDP87b71E2Npnn8/m
         /0R4yXMr7ZvQisvzdN0lQfuPTR2cGAuEOqJ3yXbJ6Lm633CYGQ1fGSVgwaAizwXOGhJE
         7p+rogPQx011nBlZTFfIF/m/2ROk+zhko0uEGVci39a5I/3Vxr4EWtzUcARiGRuA39Xs
         /Im+06/sjZl/uct1L0CD5Qdnd3zrGq1aFqV+Ri03lvIiHRnK7sjUBfBwYFymu0SUWShY
         YoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727804697; x=1728409497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Em5LGkch8nDUBUVgonI9cq9bFbnQYt7iISXA27TCkLA=;
        b=E/wJnbM7A/uKsIXVKOOAu1cdH/k42jG0EtmOz70fp2EZrInrEN0dQ59fE58pi62Ifp
         3grDAjBefiE9jgGr0Je2C13DpP/wbDYNYTp+t7zRgN5VYI7hLkK6EsJZDZpkny+abrYE
         Ml0D8LLfRpGT0weM9KAPYP/3T8uorCv3OYDE8gqW21Q2ybn2RiNClMZko9+hNp1vZ9yR
         VGD4i67dze+NXtHQ+s2ehKH6Xky51EN0JzYnUO9pSfMmW3KszniMAY++FpsTC3WjosRo
         4COoM54304vHLzVUxKrfuW5s3kxV8PYDMzmZ5EAzyXeGo6ATwFiDeV/EoFf+Gf54ZbsH
         Tlgw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3Is2gQF3ATlG51UVM1ilK1Rwa7jnLCbQ43ZzbPm/ZAAfyVb4xbpoN0zp/oC5xcpNlE5hyy3hnPXOpWMm3gdo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0QlK+5ZRbhLDQE7FybYy/vfP2TKTCZcX0k2WialD1xmqqrub8
	4ugzKVM2p8M6nltm+BEx7qhsYWACbHJCJ6L9TVMb0aT9BNyTuB8CQKp02JwyVlJhOe2/s+rqpXt
	nUwTSOvFZT8KtN2PsKq/EMpJTrUQVzd7WN6c1
X-Google-Smtp-Source: AGHT+IE3AKsxbJcp0ZEgamOHl9Olkr0Px4wUgXCcKDjSuWcG6plOf2OoIC6eTIH0Apxl3q8Le6xxW6Kah7F+lg09gag=
X-Received: by 2002:a05:622a:8610:b0:458:17ac:2913 with SMTP id
 d75a77b69052e-45d8204bf85mr2641cf.11.1727804696507; Tue, 01 Oct 2024 10:44:56
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001002027.1272889-1-namhyung@kernel.org> <20241001002027.1272889-4-namhyung@kernel.org>
In-Reply-To: <20241001002027.1272889-4-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 10:44:45 -0700
Message-ID: <CAP-5=fW7tCmF44nPMdoMpE-7zhOGZ_NLuEwWEHgJnvYTyztXdA@mail.gmail.com>
Subject: Re: [PATCH 3/8] perf tools: Simplify evsel__add_modifier()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>, 
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 5:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Since it doesn't set the exclude_guest, no need to special handle the
> bit and simply show only if one of host or guest bit is set.  Now the
> default event name might not have :H prefix anymore so change the
> dlfilter test not to compare the ":" at the end.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/dlfilters/dlfilter-test-api-v0.c | 2 +-
>  tools/perf/dlfilters/dlfilter-test-api-v2.c | 2 +-
>  tools/perf/util/evsel.c                     | 5 +----
>  3 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/dlfilters/dlfilter-test-api-v0.c b/tools/perf/dlf=
ilters/dlfilter-test-api-v0.c
> index 4083b1abeaabe605..4ca2d7b2ea6c8200 100644
> --- a/tools/perf/dlfilters/dlfilter-test-api-v0.c
> +++ b/tools/perf/dlfilters/dlfilter-test-api-v0.c
> @@ -220,7 +220,7 @@ static int check_sample(struct filter_data *d, const =
struct perf_dlfilter_sample
>         CHECK_SAMPLE(raw_callchain_nr);
>         CHECK(!sample->raw_callchain);
>
> -#define EVENT_NAME "branches:"
> +#define EVENT_NAME "branches"
>         CHECK(!strncmp(sample->event, EVENT_NAME, strlen(EVENT_NAME)));
>
>         return 0;
> diff --git a/tools/perf/dlfilters/dlfilter-test-api-v2.c b/tools/perf/dlf=
ilters/dlfilter-test-api-v2.c
> index 32ff619e881caa50..00d73a16c4fdaece 100644
> --- a/tools/perf/dlfilters/dlfilter-test-api-v2.c
> +++ b/tools/perf/dlfilters/dlfilter-test-api-v2.c
> @@ -235,7 +235,7 @@ static int check_sample(struct filter_data *d, const =
struct perf_dlfilter_sample
>         CHECK_SAMPLE(raw_callchain_nr);
>         CHECK(!sample->raw_callchain);
>
> -#define EVENT_NAME "branches:"
> +#define EVENT_NAME "branches"
>         CHECK(!strncmp(sample->event, EVENT_NAME, strlen(EVENT_NAME)));
>
>         return 0;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 0ddd77c139e89a2e..f202d28147d62a44 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -545,7 +545,6 @@ static int evsel__add_modifiers(struct evsel *evsel, =
char *bf, size_t size)
>  {
>         int colon =3D 0, r =3D 0;
>         struct perf_event_attr *attr =3D &evsel->core.attr;
> -       bool exclude_guest_default =3D false;
>
>  #define MOD_PRINT(context, mod)        do {                             =
       \
>                 if (!attr->exclude_##context) {                         \
> @@ -557,17 +556,15 @@ static int evsel__add_modifiers(struct evsel *evsel=
, char *bf, size_t size)
>                 MOD_PRINT(kernel, 'k');
>                 MOD_PRINT(user, 'u');
>                 MOD_PRINT(hv, 'h');
> -               exclude_guest_default =3D true;
>         }
>
>         if (attr->precise_ip) {
>                 if (!colon)
>                         colon =3D ++r;
>                 r +=3D scnprintf(bf + r, size - r, "%.*s", attr->precise_=
ip, "ppp");
> -               exclude_guest_default =3D true;
>         }
>
> -       if (attr->exclude_host || attr->exclude_guest =3D=3D exclude_gues=
t_default) {
> +       if (attr->exclude_host || attr->exclude_guest) {
>                 MOD_PRINT(host, 'H');
>                 MOD_PRINT(guest, 'G');
>         }
> --
> 2.46.1.824.gd892dcdcdd-goog
>
