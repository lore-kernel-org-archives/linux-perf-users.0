Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520019D08F
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559301; cv=none; b=hQJpIqEu0isqAk5iWUriprxgNtM4p46DxIOztuErA1Yxf27ijPRF2TBe1Vi84I21FpRH4QYR6xRPiCdhfk2tcNZaSVLADVwgt4bqk4lCEjIi26tZEDyfucNM3ZGwsHWZVDeClUooLHJjJsFb+qBv3l/xJOP5B5HEcwngXuJOmRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559301; c=relaxed/simple;
	bh=MGfamdGAk8HrKfaDqakpaY7IT3Ti3k5iPmyzw0pKF6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzRm5uYydg+RysNPX7xb102ZN7xUxIA8tg4tdjP088zXuRk4Ube5hTNcAM2HVy/e984nAbkIz7PF2LVT07gmFtC+qnFjd3Ku/9XkjWtYHow7YTrny/9GiEyNi90jrx+ZoH09z1APybh6APa9ysFoEEkaxrAfoHyQ9oF1oZFnX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8NVb/cO; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8NVb/cO"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44fdc70e695so206501cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723559298; x=1724164098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwMwCe9XraET4qEmC7d2hSRU8Grm1zoGQun5Yl3pIFQ=;
        b=r8NVb/cOhvjkNZQrbDxyVUlbNZ8bbxIJfuFeWeFN9hJUq/EIPqvRvLbDTBqX3/o12V
         drsOn1vmyVrfuXEKZLg6NeeTMbBhb26UojjehAVUQngQJvgByFIuvFlUPWwT6Ako7xnV
         eOZoI0qATA6hQWQ04PDvmoFLfM+PROg8Kw9mo4njh5yFhfN10UPk+9D2v60hwSDvd6+U
         bBNlnmh2UvB2CLaq5tNpqplPJaBuIwcQ7ZdZDA92ytv4vIlz6W0F17d4hLwjqy7xdSxE
         7j4euz3tc/bFp22DvCqdofhVX7UnICj6d2FE9bQAaM2sgVApawTxQw0RtEJiG4xQ2cgS
         UAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559298; x=1724164098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwMwCe9XraET4qEmC7d2hSRU8Grm1zoGQun5Yl3pIFQ=;
        b=Qx6stpz8lgK0892iQi2rWSmzqQPhpm+juRrC86lzfn82L9c/hba6B+xQcIzVY/f/aE
         q7PR3laZqyp1a6KnZ5k04x7+q19O2CQPQysFuUAtN0Nicp/7qo34x+oyqNwvckcpaqFn
         DbpxhvFkJIzL/qIaqRunVBYKV+5Ob5GkhWJFfMbcy+Z3NNZiBGKFNiL8JctJL01kE+xy
         oczyjtGwEj0jd1r1+7lYDTG5XXE66N/QFyyer0r387hYWhYBpUOXqXz7zDm+mf8qJCvd
         67PYWnnl1lrxdYlkPNpAwYUo3Nj8uTPu3ZEhqsQp+T+vNPomfAXbJgY4uMj5lYSwohbu
         8xDQ==
X-Gm-Message-State: AOJu0Yz61G/0pS8QULf/vFGMQasiAUGJcMqitbw49i6WgdNcnYLzd66c
	4QxF4YBGJnOmahdJrPkEjxdHQrZJzGcqALaP6VTeOzQQ9q6NErso1CaV4bHoZpwDPklEQiEQYlc
	Yo+jLQPshcpsmbGWPf2WbddRTV/NJ73yeCFKT
X-Google-Smtp-Source: AGHT+IEHcwqV4cFmhHUR8wPvObTxmaxWalQoPmmrv/9ZEE67XYps098QKeZ/3rcuQ+XnEfwzoGkAkOkUdzIssDWVrWg=
X-Received: by 2002:a05:622a:102:b0:447:e497:95d0 with SMTP id
 d75a77b69052e-4534f9d9f38mr1372091cf.17.1723559298338; Tue, 13 Aug 2024
 07:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813132323.98728-1-james.clark@linaro.org> <20240813132323.98728-2-james.clark@linaro.org>
In-Reply-To: <20240813132323.98728-2-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Aug 2024 07:28:05 -0700
Message-ID: <CAP-5=fX-m3mhi0sGsGo9biWmFV_U=35Tp7h9X0reg3zHMEsy_Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf stat: Initialize instead of overwriting clock event
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 6:24=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> This overwrite relies on the clock event remaining at index 0 and is
> quite a way down from where the array is initialized, making it easy to
> miss. Just initialize it with the correct clock event to begin with.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/builtin-stat.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 1f92445f7480..a65f58f8783f 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1817,7 +1817,9 @@ static int add_default_attributes(void)
>  {
>         struct perf_event_attr default_attrs0[] =3D {
>
> -  { .type =3D PERF_TYPE_SOFTWARE, .config =3D PERF_COUNT_SW_TASK_CLOCK  =
           },
> +  { .type =3D PERF_TYPE_SOFTWARE, .config =3D target__has_cpu(&target) ?
> +                                               PERF_COUNT_SW_CPU_CLOCK :
> +                                               PERF_COUNT_SW_TASK_CLOCK =
       },

Hand crafting perf_event_attr when we have an event name to
perf_event_atttr parser doesn't make sense. Doing things this way
means we need to duplicate logic between event parsing and these
default configurations. The default configurations are also using
legacy events which of course are broken on Apple ARM M? (albeit for
hardware events, here it is software). Event and metric parsing has to
worry about things like grouping topdown events. All-in-all let's have
one way to do things, event parsing, otherwise this code is going to
end up reinventing all the workarounds the event parsing has to have.
Lots of struct perf_event_attr also contribute to binary size.

If you are worried about a cycles event being opened on arm_dsu PMUs,
there is this patch:
https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com/

Thanks,
Ian
