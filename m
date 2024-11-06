Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DCE204028
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Nov 2024 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909105; cv=none; b=AjpAROpsdd1lnJv7IQbF5f6VA2zdZRzB26wyqEBSxSfDC7gFemT+Mub1dmilSkvgTEDDnXVIYjhpRVgBiOJeyDd1wzjKU72dw4FDgdIuXLfdhWDLFFF0bgrIY419s9Nan72ZJORTYOZsnlayCxYIMnCC0tgdtI4lzmherdHwsK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909105; c=relaxed/simple;
	bh=cH5OE7NX7Mz/bdUBs66w08qwMK7Qsujzly9jtp/uTs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jw6xZDkeOJpTMeLwrwxFmuk6um9WdYEivlp1HMhsInG4JQ7gU+XxFY6oFgaEcXs1OLzAGz6+6hgq5clYJ2FjJzI+MjMHnSR4f5oWtx71g5jjJJSi6anT6Jkqtd2RdZyqNm29n6TC0miiMkCFsfEOQPiys9utpQ7gxweg6AEw6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dGyJjcHv; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dGyJjcHv"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460a8d1a9b7so250731cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Nov 2024 08:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730909102; x=1731513902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IL4bTsX4yoJsol4u3vZrSSAIg09xmcdzQI4G8r3j4oA=;
        b=dGyJjcHvAHDgfRG3X/RgQ+bx5l3YhTieFfM7h+u6PvzEBy+fdt4/0RDso71iBRIvUN
         4uKyUZ8euqX6fEDRAU1FArMbIjqAwM9UOELJH70sJFzu6nB7rZyP2KVTgARPpvS2APvB
         z5/0DTOkEhZpuVCW8cmTWumMpLrHEIJCQZThCp6Wouo8A0IVELVLFl5IEUwImMOhoBvU
         E/z07b+C9k/4yagcuO7NziwpUnThJA13kHW7yuzOlq4i8R7WPaXaI6h4iXxz4NvYxPmj
         FEIiKIe2mBL6lYGSdc3VNWbFhg8w2wBqMCPm0dJNfiLeC4ONPnyENm0n5oGygwhfaUPk
         4W7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730909102; x=1731513902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IL4bTsX4yoJsol4u3vZrSSAIg09xmcdzQI4G8r3j4oA=;
        b=SiDtkH1GZYswaAgbYwDzYMV7VW8WCnYK2ypBSi8jZxf05yBCRoVaBaoh1HBHXN/5gi
         BQEhb5ScoenrahqnZGX8dgcISLgVyIL32q0OqZ8Hr7kxdXcXAgsYIkYjlVlt7jkwaW2B
         opyo1IChMijND6XViA1a39wHxGlJwijsP3arjmV7V6CPVvh1FUqp97SotQ5aL1Ue5rYJ
         RqN0TjLg8KCcepmTKESW8Fl3c7moT2RT7xiIDSaVhJNspxa6tQnziCNH+iUO4n4C8lqv
         nnhrhbTXpiSvEYQXhQO79sVEmD3uHdWzFzjIWrrZSzPfoyEVz2nuFcxhsHxP8n+UL+i2
         SD4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIK5DJlFiS3i4Nyao+kNH2MILzUjNXMcdiBPjqD34lkciSXgcUO/MVd6EnvXk+V5u7a7sEEI8BtlLEmf4yXF8L@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5b1ZGbGrCGT8qTMfQM0SWoAD2n9yUc+tFpzxuglLyFYY16g/0
	WSEZQ28adPNFqkNnBvYR4L3MFr85c0Oe86y/hfSg4SxaJbPPRuHrCq7SEecnWF4fMZSK/9J6bLD
	5JwKGa3uv5OsOPy+ITqFDBhitfXIdRms+Dsr2
X-Gm-Gg: ASbGnctY1T7UkDF6OYgf3Zf8DbdJZ7702/WQVG/hUkBZ4h93LJ9ra+9hcPV0rrpUma9
	NOQVVHxJnGvVuulweKiShKcI20TIZgB7ejEYqGLAywJ0gpD/iZTsE8DHtzhTjzbU=
X-Google-Smtp-Source: AGHT+IGVuAyYxfbKNtvaZjW52zgPaDYQVeAmhHgdEdnwxmPFzOVkFKrhtvzICzMYI5c5fjUF6KVTO9JuvH8HQgPdF7Y=
X-Received: by 2002:a05:622a:612:b0:461:6e0a:6a27 with SMTP id
 d75a77b69052e-462fa6113c7mr288421cf.20.1730909102271; Wed, 06 Nov 2024
 08:05:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106004818.2174593-1-irogers@google.com> <126ebac6-fb52-4c3c-b364-0b423e164d40@linux.intel.com>
In-Reply-To: <126ebac6-fb52-4c3c-b364-0b423e164d40@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 6 Nov 2024 08:04:51 -0800
Message-ID: <CAP-5=fV3RuvU0N_bt7R-ZMs2nX1_wfKh30PA59u3MW0TF4nzBg@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Expand metric+unit buffer size
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 7:27=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-11-05 7:48 p.m., Ian Rogers wrote:
> > Long metric names combined with units may exceed the metric_bf and
> > lead to truncation. Double metric_bf in size to avoid this.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/stat-shadow.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shado=
w.c
> > index 8c9292aa61d3..6b531d4f58a3 100644
> > --- a/tools/perf/util/stat-shadow.c
> > +++ b/tools/perf/util/stat-shadow.c
> > @@ -507,7 +507,7 @@ static void generic_metric(struct perf_stat_config =
*config,
> >       if (!metric_events[i]) {
> >               if (expr__parse(&ratio, pctx, metric_expr) =3D=3D 0) {
> >                       char *unit;
> > -                     char metric_bf[64];
> > +                     char metric_bf[128];
>
> I thin there is already a MAX_EVENT_NAME.
> Can we similarly define a MAX_METRIC_NAME for it?

So in this case the buffer needs to be big enough to hold the metric
name, the unit from the scaleunit (e.g. the "%" from "100%"). I'd
prefer we used dynamic memory allocation to having hard coded limits,
just to avoid a "640K ought to be enough for anybody," moment.
Although this change is implicitly a hard coded limit, sigh. There is
also the metric only name length:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/builtin-stat.c?h=3Dperf-tools-next#n160
That looked like it was planned to be dynamically computed but then
the patch adding that never materialized - meaning "standard"
metric-only output has its own cut-off rules at 20 characters. I'd
rather wait on doing a larger cleanup and do this quick fix for now,
mainly as I have enough to do.

While we're talking metrics, I'm still looking for feedback on the
python generation of metrics. v1 was sent back in January, if v4 looks
okay some acknowledgement would be nice:
https://lore.kernel.org/lkml/CAP-5=3DfVX5wypmAAhR8LsE4nSWp5BmN_qhGf9+WCh2be=
bNcGYTg@mail.gmail.com/
Leo sent some feedback to improve some of the ARM metrics, so I can
resend the whole series. Would be nice to gather some acked-by or
other tags.

Thanks,
Ian
