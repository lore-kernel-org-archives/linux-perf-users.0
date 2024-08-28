Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D901A0B1B;
	Wed, 28 Aug 2024 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864812; cv=none; b=rfuigtVCs8mQc47xQvdpuOxfuA3Kavq+uMWol2IDHgRlV0IRCZwUkGtGPlxWtV4nCMu+qtxMr2mxwet17viw+6gVjxDBoh9pIgShGtA44LTtTdjjNgDKRKXcCRFS+zmMCjfxhi341NVP5/LAY2IShEG2i1eGUDQ4Sta6e3TB+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864812; c=relaxed/simple;
	bh=+7Yk+MHdIX0lm7TT6btJiPHHECyyAkCgMGhtiL20v3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfILXdhZfdLa0wq5XS5uRgkqHYHwVek0zP+KPDBN9fFtZjiSaCSPyTCLSx704ThXeZyN9dQCychHjCiT8fywdicHbwX7VuCxkNEeOyMLvq/M4J4cTRB5Tb0RbbCJybvV85vHlOJaU0iUxBXvu+rFGiF52cy9Qls5fGKppdj8rbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-714262f1bb4so5203187b3a.3;
        Wed, 28 Aug 2024 10:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724864810; x=1725469610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2oCPDeNtjRZP4XhvKPrrim8zzVhTyguFTNO3eziRBE=;
        b=qm8x+WF4FQX4k+MmA58xK48YwaHPXGsB1UY5U1UsrEub7BGVn0LoEpbzXeag9p2W7o
         xfp/UJIVR+U9GN2L5VNMyBpFHCGCQWg/7gSH9fcGizvSCx4AlLeb6QIsfguvBhoQ5I5h
         qGeMD1gPkkVpg1gKAFeynE0vALUKAf5NedYnPqvOlZ46ZfKdaYaNx3Hzmbd9toa/heH0
         hNTE7kXb5/RCl3DIwlg5+QAutQw7s4Jb+dPg02dbXGWqsbfHwAK3AJZAM5ztKo+ut8U8
         LY/HuGiSJ1Lr6WzuiqSsbk9ycIRM7+yeLTAr7QGOkkhYek+aNbkSZMwCdBxaimfaBO4p
         XukQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrdlxJGqwApYx6oSg4mta8K9lYlACemHUT2hjtzEOw9cqDt1f5AVhYQ6viio7jR3SjY8kl3Abvijx2PW9VQDLWuw==@vger.kernel.org, AJvYcCXFiBYFGIzujilR4A+gwo/kp2WlbXVtDvZMnqHkr49nXngMzfGSbDpFSjH5y8rIxQw2YhUptNC0qKMkTeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW6A33C+3lnSsej5wnyp4l8YRW7MPwLzZyK0LGlQfhsDJW00cr
	P853QX/p6vaa6siVo/5ocY+oOjmQ4vY2HKp3wQqv4aluff/E1aq7ucbHKe32lHhnCv2cfWMMvS7
	sAwyynf27J5F93nP36oFWABJ2t6s=
X-Google-Smtp-Source: AGHT+IFJ/6LjYH4iH6wgkJUgN5vOUdDW7qOoL2xxQLlDUU9j8K2/2dmXVUv8nCGWaPcAIiizsVXO0t9w/FqJuBV85Gg=
X-Received: by 2002:a17:90b:4b8f:b0:2d3:bd32:fc7d with SMTP id
 98e67ed59e1d1-2d646d5eb25mr17371960a91.39.1724864809719; Wed, 28 Aug 2024
 10:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827212757.1469340-1-irogers@google.com>
In-Reply-To: <20240827212757.1469340-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 28 Aug 2024 10:06:37 -0700
Message-ID: <CAM9d7cgoRUzRkwf37BisHV8vKWFD2AY+GJKH+eOqH4HmGBY2Wg@mail.gmail.com>
Subject: Re: [PATCH v1] perf report: Name events in stats for pipe mode
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Tue, Aug 27, 2024 at 2:37=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> In stats mode PERF_RECORD_EVENT_UPDATE isn't being handled meaning the
> evsels aren't named when handling pipe mode output.
>
> Before:
> ```
> $ perf record -e inst_retired.any -a -o - sleep 0.1|perf report --stats -=
i -
> ...
> Aggregated stats:
>            TOTAL events:      23358
>             COMM events:       2608  (11.2%)
>             EXIT events:          1  ( 0.0%)
>             FORK events:       2607  (11.2%)
>           SAMPLE events:        174  ( 0.7%)
>            MMAP2 events:      17936  (76.8%)
>             ATTR events:          2  ( 0.0%)
>   FINISHED_ROUND events:          2  ( 0.0%)
>         ID_INDEX events:          1  ( 0.0%)
>       THREAD_MAP events:          1  ( 0.0%)
>          CPU_MAP events:          1  ( 0.0%)
>     EVENT_UPDATE events:          3  ( 0.0%)
>        TIME_CONV events:          1  ( 0.0%)
>          FEATURE events:         20  ( 0.1%)
>    FINISHED_INIT events:          1  ( 0.0%)
> raw 0xc0 stats:
>           SAMPLE events:        174
> ```
>
> After:
> ```
> $ perf record -e inst_retired.any -a -o - sleep 0.1|perf report --stats -=
i -
> ...
> Aggregated stats:
>            TOTAL events:      23742
>             COMM events:       2620  (11.0%)
>             EXIT events:          2  ( 0.0%)
>             FORK events:       2619  (11.0%)
>           SAMPLE events:        165  ( 0.7%)
>            MMAP2 events:      18304  (77.1%)
>             ATTR events:          2  ( 0.0%)
>   FINISHED_ROUND events:          2  ( 0.0%)
>         ID_INDEX events:          1  ( 0.0%)
>       THREAD_MAP events:          1  ( 0.0%)
>          CPU_MAP events:          1  ( 0.0%)
>     EVENT_UPDATE events:          3  ( 0.0%)
>        TIME_CONV events:          1  ( 0.0%)
>          FEATURE events:         20  ( 0.1%)
>    FINISHED_INIT events:          1  ( 0.0%)
> inst_retired.any stats:
>           SAMPLE events:        165
> ```
>
> This makes the pipe output match the regular output.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> This bug pre-dates commit 113f614c6dd0 ("perf report: Use
> perf_tool__init()")
> ---
>  tools/perf/builtin-report.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 1643113616f4..5c21ca33ca08 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -811,6 +811,7 @@ static void stats_setup(struct report *rep)
>         rep->tool.attr =3D process_attr;
>         rep->tool.sample =3D count_sample_event;
>         rep->tool.lost_samples =3D count_lost_samples_event;
> +       rep->tool.event_update =3D perf_event__process_event_update;
>         rep->tool.no_warn =3D true;
>  }
>
> --
> 2.46.0.295.g3b9ea8a38a-goog
>
