Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3301E00AB
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466779; cv=none; b=tpZgl22CFNa6U+5dh5z68GDsYLMAfyFUUsQ3q3y4ZQ+IAvSy8YTuQW9DR5gJfOrPIiVZoX/wQnIc9onZGmsqJQWOWfb373G0pLGmfRpDWVjIdJfikE+Zp/9KotMM+nGjywntYPSCrBIODPnOJ4B25XqNfxY8fPm6JJ5v5nlqqbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466779; c=relaxed/simple;
	bh=WR9gODpJwzztNv80pp/9TofBTjDhBhMxxRESpXAfG54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKuWMQoPwcw9ws94UahVQWBppebSjPbE/YjVraZkjsZi2m+vGKESZ6iF2ovWBuwObeIUXLMjMX9t4TrR2b/GT2FmpkRVhSjqILlwajWlowt3vzdMyL5adzMREvG94Tg4l79bodyEjKdMX61HcIOvEI31/grY5pvJR24wbUvKbeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ltx1om/k; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ltx1om/k"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20260346ca1so240195ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Sep 2024 09:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725466777; x=1726071577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25Zf/4cKd4+468N9AqNX5z8KPRD3uRfodn3ph1xnn0w=;
        b=Ltx1om/k2w3DD8wsdwK3Rbalr0kIUbZEstOv8avYlbHlQ4JO7Msx6w9fNwgn3lbYWx
         8+uyk57OwP/o375MM8J7h45WMpS2SCRm4GBOfAKu50t6/Wc4QuQLamMoiskvCeA4sQyc
         OOWBtRoGaUewwG0SkwBfVPc+Fhr6BtN+U7RgqaAMKus0DrJP/s3tqdEpYUiOOiGDuMOa
         D5LD524cKf2FypPohC0Iez+k5uQ2igOD1NMIPk4IPdjCoElVTxv8WGH85IOWnX8NxBNH
         gtwtoKd0jkfqhn2pma3U3NEKgTjhxSIbjnwBDpWjR7mpFE98injog9hvPkgofbrszFVe
         OPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466777; x=1726071577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25Zf/4cKd4+468N9AqNX5z8KPRD3uRfodn3ph1xnn0w=;
        b=eGLBX3RcmgCvzx46e88i1MgQAviPga114Ti88EsSA3o7GX3lm49YiJZz0JdM707PpM
         6mqfLarm9cxEG1vr+3guA3+icKTvdaW1Ky+jWKd+Aj4VnloMzBXfecrbqrtvO5msn58V
         ETPV+nq3w+65dpSfxGF64jSLsO/6S7JuKXLpoyAn6MtXwQFeTSIs4G3ZDYV+PP7soqGB
         EXUZju3BBVQv+q+a3iRWcrukBeMK+jGUPRcrlWmPY2eIOAq6dDyZ5NmeVXaHlB+qXn8E
         TV7rhGPxQyJc/zTgahnTAgt6pPfr1A3xPKWrv+Q6a/ierXkQSn0DledEZKpS37c26kEZ
         Hvug==
X-Forwarded-Encrypted: i=1; AJvYcCXik96YDv8u7s7DLVvUc+UmjTk8icNOkHHMfb476KfE7k3K+vpSITIzf4CI/J7OJseSL/3Pr1CGOkjLLCfapcIG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa0OSdw/RKiD6J5OGQyceSG0CMVDzu2EHnSJN5rP42nBaLc3Yo
	T0WVaN0sbyg2Xs/S8ckTB1IDprJxQO8ltPT6ya0rLi8vG1y8dnPFkjWN+GK+PSzo+YQUe5tgSSi
	q8wxQwtDdpBb7raCc5+bgKymA3T+k8ndJPr8t
X-Google-Smtp-Source: AGHT+IEiFBoQQwHuUEXS3IHquLDvHm6vqwNYM/SC1nUtLaeosM7rzHTua+C3+xTNmlk+KAAtYb8yNjJWCRaslrFFyy0=
X-Received: by 2002:a17:902:ce81:b0:1fd:74a8:df75 with SMTP id
 d9443c01a7336-206b0725477mr3875685ad.16.1725466776976; Wed, 04 Sep 2024
 09:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904064131.2377873-1-namhyung@kernel.org> <20240904064131.2377873-9-namhyung@kernel.org>
In-Reply-To: <20240904064131.2377873-9-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Sep 2024 09:19:25 -0700
Message-ID: <CAP-5=fWnAwVumJgypta=RJV4JBN7A82bn4aUuNJX4G3Xi0zfhg@mail.gmail.com>
Subject: Re: [PATCH 8/8] perf tools: Check fallback error and order
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 11:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The perf_event_open might fail due to various reasons, so blindly
> reducing precise_ip level might not be the best way to deal with it.
>
> It seems the kernel return -EOPNOTSUPP when PMU doesn't support the
> given precise level.  Let's try again with the correct error code.

We also have pmu's max_precise:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.h?h=3Dperf-tools-next#n91
The reducing the precision approach was iirc taken for AMD who will
forward some precise events to IBS, but the max_precise on the cpu PMU
is 0. I think because of this, reducing the precision below
evsel->pmu->max_precise shouldn't be necessary and another fallback
may help better.

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/evsel.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 8c4d70f7b2f5b880..0133c9ad3ce07a24 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2565,9 +2565,6 @@ static int evsel__open_cpu(struct evsel *evsel, str=
uct perf_cpu_map *cpus,
>         return 0;
>
>  try_fallback:
> -       if (evsel__precise_ip_fallback(evsel))
> -               goto retry_open;
> -
>         if (evsel__ignore_missing_thread(evsel, perf_cpu_map__nr(cpus),
>                                          idx, threads, thread, err)) {
>                 /* We just removed 1 thread, so lower the upper nthreads =
limit. */
> @@ -2584,11 +2581,12 @@ static int evsel__open_cpu(struct evsel *evsel, s=
truct perf_cpu_map *cpus,
>         if (err =3D=3D -EMFILE && rlimit__increase_nofile(&set_rlimit))
>                 goto retry_open;
>
> -       if (err !=3D -EINVAL || idx > 0 || thread > 0)
> -               goto out_close;
> +       if (err =3D=3D -EOPNOTSUPP && evsel__precise_ip_fallback(evsel))
> +               goto retry_open;
>
> -       if (evsel__detect_missing_features(evsel))
> +       if (err =3D=3D -EINVAL && evsel__detect_missing_features(evsel))
>                 goto fallback_missing_features;
> +
>  out_close:
>         if (err)
>                 threads->err_thread =3D thread;
> --
> 2.46.0.469.g59c65b2a67-goog
>
