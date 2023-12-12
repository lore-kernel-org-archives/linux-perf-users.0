Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QCXTyOQP"
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E9F99
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 12:37:25 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-551d5cd1c42so2940a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 12:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702413444; x=1703018244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjwnVjtTzFRWKXsN9FzDur1MXPjRS32HCf9tyhW8ATU=;
        b=QCXTyOQPRJaY1JrdLO1gyz9slC8tHQb3f5KiBbz141zyCDx23JetABTbDFe9KRKXg+
         pq4GQZlO/FRYqiUN+X2zMdebrb6tZMKDQWrkSjwgBxtQwt+A1SVewGfJVx/g8yDwtzo5
         v0a0B9OCYeFpnjSpkKhnRT06J67A0upoReEvw8UgVBGrEzcJtCMoohsApZkT5+vNOe2a
         miK20Zj9/uMPOY+HIxTWsWCyficRnN8aN79p3/0K9xMKXAyfQxCRSzER2elJ7TEDMLae
         cv6CHixv64SsGIWaMdznBrQlkgUQaUulDeYC6hz3hZ+b6qqLetFYLSfMrXoyJwbJzy2u
         XrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702413444; x=1703018244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjwnVjtTzFRWKXsN9FzDur1MXPjRS32HCf9tyhW8ATU=;
        b=ZhWepViJPQH/OJ70BtuA04RSEqrumBYky+DdtN9IIRAunnQ5Vbs031uyq8mdfxA2+h
         VJZIaGpt0hqpJbKw8ZVah/D9zg2x2gvzDW73HtguXjEiM/n+fSsiqJJH5fy/ndByyK/v
         wATlHtaWCz+zkdNdB64clDn9D8Z5Q52pj4NWkmnpRmZNVKLSm2MK7VELCS5kZ8A7zXY2
         pM2uFOPUhkYrHe4XGSDOlDaJYTCNKaucgJMtDLIG3rGtlOgHCR6zbKQceozyOOmMHaC9
         CAuwAbmnGrNeWh6p7BKnUW5m4WnxjQbKCeBFPVDcEx/4RU/bYnGq4GTqXvnM50iYMT5d
         K3LA==
X-Gm-Message-State: AOJu0YxVTLJprj+iHDVEXH6SnE20gwNqys91BW8Jl4Z6zq5GFe0MB2Wd
	F/uK2s2EtInWByTYoZnXf1vnIS6dPZrZ2RG2xOKhiw==
X-Google-Smtp-Source: AGHT+IFJe6nel00LC/HauBXLcY3hPU9gaAIBWQs48bsWJQm23voEFrKK8ZBXNEYB3PpPu+M7d8I+RcPcyhIt3tMAhwc=
X-Received: by 2002:a50:d7c3:0:b0:54a:ee8b:7a99 with SMTP id
 m3-20020a50d7c3000000b0054aee8b7a99mr395116edj.0.1702413444029; Tue, 12 Dec
 2023 12:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212193833.415110-1-kan.liang@linux.intel.com>
In-Reply-To: <20231212193833.415110-1-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 Dec 2023 12:37:12 -0800
Message-ID: <CAP-5=fWCgjCC-DHHx+HJCuYk6vNn9Lf9EKcnBBZQ+xmnyYnmPg@mail.gmail.com>
Subject: Re: [PATCH V2] perf top: Use evsel's cpus to replace user_requested_cpus
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, maz@kernel.org, 
	marcan@marcan.st, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 11:39=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> perf top errors out on a hybrid machine
>  $perf top
>
>  Error:
>  The cycles:P event is not supported.
>
> The perf top expects that the "cycles" is collected on all CPUs in the
> system. But for hybrid there is no single "cycles" event which can cover
> all CPUs. Perf has to split it into two cycles events, e.g.,
> cpu_core/cycles/ and cpu_atom/cycles/. Each event has its own CPU mask.
> If a event is opened on the unsupported CPU. The open fails. That's the
> reason of the above error out.
>
> Perf should only open the cycles event on the corresponding CPU. The
> commit ef91871c960e ("perf evlist: Propagate user CPU maps intersecting
> core PMU maps") intersect the requested CPU map with the CPU map of the
> PMU. Use the evsel's cpus to replace user_requested_cpus.
>
> The evlist's threads are also propagated to the evsel's threads in
> __perf_evlist__propagate_maps(). For a system-wide event, perf appends
> a dummy event and assign it to the evsel's threads. For a per-thread
> event, the evlist's thread_map is assigned to the evsel's threads. The
> same as the other tools, e.g., perf record, using the evsel's threads
> when opening an event.
>
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@kernel.=
org/
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>
> Changes since V1:
> - Update the description
> - Add Reviewed-by from Ian

Thanks Kan, quick question. Does "perf top" on hybrid ask the user to
select between the cycles event on cpu_atom and cpu_core? I'm
wondering if there is some kind of missing "hybrid-merge"
functionality like we have for perf stat.

Thanks,
Ian

>  tools/perf/builtin-top.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index ea8c7eca5eee..cce9350177e2 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1027,8 +1027,8 @@ static int perf_top__start_counters(struct perf_top=
 *top)
>
>         evlist__for_each_entry(evlist, counter) {
>  try_again:
> -               if (evsel__open(counter, top->evlist->core.user_requested=
_cpus,
> -                                    top->evlist->core.threads) < 0) {
> +               if (evsel__open(counter, counter->core.cpus,
> +                               counter->core.threads) < 0) {
>
>                         /*
>                          * Specially handle overwrite fall back.
> --
> 2.35.1
>
