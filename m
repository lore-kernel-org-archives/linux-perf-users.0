Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264E72606
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835306; cv=none; b=m2idIw0iMUUEfCJeLDJB9oPXflUVn4PsoyxPGmnFnZEdBw1NT4XN+7bNTPicHhf1e/T1Q8Z3hfIc5Y3k6+RjlKiS/0Xx8/lReX+aV+udZ4Ks9VrNH6FQ/9L78YXhhTbjPJumCwF7E70cb4gag+83cYiA2veC+0pSoSAIirEbYnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835306; c=relaxed/simple;
	bh=tZmrPtKq9NBVoM5sBtvwoKj+O3b1ayp2YkLwz3fWz20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2A/ufgwcUbnS/m70FH0XmtMVUXLY1ZYQJI0xYNV/AvWLcQ/nV+JjP8FdM+oO14SmZ2zoQ4csU4CAFFqXRLu2jK7afQXWiL5KWPh+FJhNBVf3WbnmVdMD1ZvbeoaL0+mKHuvKYm9bMbC2axDYyQUMz2RKZ5XvIlJVL5jn5L6EV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEhabt9I; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEhabt9I"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso63925ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 06:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747835304; x=1748440104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxlheM5lEmnt1MM3GdEBAW8Kn3rstbnprh4CdxgItUw=;
        b=kEhabt9ImR2tn5SvWAg4t6OXdLJUgE8Ey8sHRdvth91oNO2UIyPn8ZiUAZODa7JASm
         H4U1t5huxudAmMP8vIkcOr/1nBitsP38rPt2qa9TC2GeTT+xTxxI9qeh1FUtCFiJEBuL
         UiNcXTKWAB1wotghO1eyYa38fhfn8b4p4mPu/axSH9PkbeLnqVWLwDnG2RgPg0eQ+jPg
         JepPxB72yYx/nUyAwcLgMIkRD/y/SPHP9hxPWyoNQoUFjUV2fLQphaWBEtCjZoYMz7gX
         0Wmilvn6zbtUTmQxmg8kUN/yIgvCywMkli4b7GUHEW6iL+fzpvZx3g9joG76vxjy/Aqo
         nNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747835304; x=1748440104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxlheM5lEmnt1MM3GdEBAW8Kn3rstbnprh4CdxgItUw=;
        b=fDv3+pRJ+Vi3OMiSULqov/TtUEXT7tLhMRpUB9BuMchC6nCJ7b8nNs33HAqdlUh/Gq
         KY8n+4OSlwB4cDQ2eLX2CWyeY14vQBfDJP0pmsRQspgNQ8+9xSom/ZtAfoWlkyPXYtKt
         7MxC5LYWT2wpzFVOaLkgbgDCLKfeXWNtaC8j2062cKQI4ZOwU1VJjpD1LXeOXRAWdoTd
         EHOwV6E930U9sxaxmS/iHull0dK0EBUxIcLc57UKR45/ZwpwBQh5yz0uP/ZKTEASF2vI
         s3V4iQSvpIKYSKciQd3iVGBkefcGw5fhl8Wj1RTygq15u9fNO7z29NpvxK4kvx04BIrx
         b/gA==
X-Forwarded-Encrypted: i=1; AJvYcCUoQK3VVfLsyGFBizTW51H6/2aeZra/BMXLABRa3328WFjZGDHSr9zHgfkXRL5smkT/8ytOBxRZFvUsf3Uj4JKC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8rsbCDkhd6+82h5GKzPrPJGaAqxRNg816zAiF70zLWLMYq/hB
	BjBjb+RXJOjrjfqoZhKsJlhMdUHW1a3zOSqQLohRhAYLrLI9PLdUEwHWq91N6flfU6HdPCap2+4
	V02wo2zO45BF3h7e71QWzv8XlZM/+7ewx+7kDj/lw
X-Gm-Gg: ASbGncsQs1ZPOJaOLyNb4DcGKt/P9w4N04ZR+yZ/d/JGiy95kW9ZtwTt001MFX7/HYl
	1aecUnrZatob/hyVywQy4cb1EWw5qSogiDEzCgf/bgCfFCBEdG2Q4eUHXaxHSskGHCpfs7vB+//
	geEO+Ni7SEShbJ65/LyHxKluS9D6Oz7aa6Sicgd03lWc5e
X-Google-Smtp-Source: AGHT+IHeC3oqFSgaSqVqnlVsrRLoNPF0gPsQUeBcI7ysFF8RkEVB62BJa8yOpnMhrjZ5pr9UqIZimBxfrtcYIG88gNc=
X-Received: by 2002:a05:6e02:c85:b0:3dc:7faa:e939 with SMTP id
 e9e14a558f8ab-3dc7faaecb8mr5109685ab.23.1747835303953; Wed, 21 May 2025
 06:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521052029.658800-1-irogers@google.com> <20250521052029.658800-2-irogers@google.com>
 <8f162665-be8d-4299-9442-a677e935999b@intel.com>
In-Reply-To: <8f162665-be8d-4299-9442-a677e935999b@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 May 2025 06:48:11 -0700
X-Gm-Features: AX0GCFugq0Va_fvHZm5B5rFZ2v7ADlvXVfexnQfQqaSFfsH3ZJYnUqpKCOmjaGc
Message-ID: <CAP-5=fXF89BsMy7OTh5z4tc1Sxk-mua2LgaZRCsaFQTpR_SHyA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf sample: Remove arch notion of sample parsing
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>, Song Liu <song@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 1:14=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> > diff --git a/tools/perf/include/perf/perf_dlfilter.h b/tools/perf/inclu=
de/perf/perf_dlfilter.h
> > index 16fc4568ac53..ec154fd937e7 100644
> > --- a/tools/perf/include/perf/perf_dlfilter.h
> > +++ b/tools/perf/include/perf/perf_dlfilter.h
> > @@ -38,7 +38,7 @@ enum {
> >  struct perf_dlfilter_sample {
> >       __u32 size; /* Size of this structure (for compatibility checking=
) */
> >       __u16 ins_lat;          /* Refer PERF_SAMPLE_WEIGHT_TYPE in <linu=
x/perf_event.h> */
> > -     __u16 p_stage_cyc;      /* Refer PERF_SAMPLE_WEIGHT_TYPE in <linu=
x/perf_event.h> */
> > +     __u16 p_stage_cyc_or_retire_lat; /* Refer PERF_SAMPLE_WEIGHT_TYPE=
 in <linux/perf_event.h> */
>
> Don't rename dlfilter API identifiers.  It will break dlfilter
> compilation for anyone using the old identifier in their dlfilters.

Thanks, I will fix it in v2.

Ian
