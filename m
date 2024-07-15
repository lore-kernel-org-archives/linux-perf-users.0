Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EF1208BA
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062155; cv=none; b=JwF8e9bVXutivnRdZaDBEu4Yr8i81Y3h5W/zlMzkummWRBWjnbJJSrIopgPpdjbyjUNOVCl7dzKlezIwmZUNJDL23WJuyWDgdRB0FCpLPfVxBEP5ZgTp26XKN1idVNDaGR2wI3wKMvtMqQ5/z9wo7qrdSO4nvY6Us1nO8cuMMI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062155; c=relaxed/simple;
	bh=BVNgqz+4odXWv/QdUrTS3ZJYLwOEmal7WpHwLv2mPPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPBWXcK6IC0N4WTM2PPnHdkr+O7+PtoqZOfSXHnxcIUH7WWvIKVmalUCPBIDBDW/GFu7w8s+0aJ9yAux9J6JKXmeUvubs0TLOY8zRRgkMZZGwPYXT/5AoHfjZ0ihYn05w65lXzE+7ZfPYht2++evl+SbYKlQRJeNWnetUSnQUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=O0IATCKe; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="O0IATCKe"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eede876fcbso24916341fa.2
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1721062152; x=1721666952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVNgqz+4odXWv/QdUrTS3ZJYLwOEmal7WpHwLv2mPPA=;
        b=O0IATCKey6MKjFNC30HNhcqiXRYtr6jzdhzKD67767VsixBnf+t9b6z+OZwb0+uWAF
         Sy4M1LqsS46kUGORmxMKEf/FpJ4MwKN4T/GPArbRZosgHqr2ZtbxrdbYUhEVH0RmYl4i
         ttZkwjsCGfpRLBRgxNpTDen5ISr54ydL7arrtK21e61xNzK5YYiQoB2m06FXzcSeeXu4
         am/FF5oWO898QmeLiIhD1Th8XESx3WUZ6LvkbvmFg5I9Ol6StYUyekO2xnbfnFTGi9Oj
         1J20staOnGBMYu6Zvgn9fwbhRZJiq10YZDFS+pTy8YF3UCDjExj+HqksoLedH+MWR1DP
         Y7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721062152; x=1721666952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVNgqz+4odXWv/QdUrTS3ZJYLwOEmal7WpHwLv2mPPA=;
        b=X9afD3/RTJpWch8IzUZAY3ClTTpa87lQ2TA8hXIT2P7xeVdvFKPrpDgrLJEq75AWtg
         lXiA6ndf544J31mspQPH7Q3P8J32pZdHJA1yQ3ui/5B/7TlfB1dauVNVjutt4g/4OXf2
         K+ZA7ScvFS8ymx3mtkN9OFjmSKzhXvgNp3dEvDd8xTKrh9TjAvMFQj7Ou5ySNSUS2Myz
         QWpzeT1P16RaE/QTZIBBQx4hi3zzI0Rv0A97dZBS8Fq196px97ePmXwDJRR2eZh5Tvhf
         U7Y0O1mhT7GpGfvUlu50+eRAC2rWdfSD2aPNZGshuh9Yu0sQt8x+rVTIbt3occWtUfcf
         GHvw==
X-Forwarded-Encrypted: i=1; AJvYcCVzzntL3BV/wrNTJAtVyWYVgRPp/Amw2eRXqaXSANYoDw5t7r38BuhVHrSdbEz+e5vZ0pP4CbGi66AmtVeyqeV/oGNnEqQ6YJK6m4hAWpfmzA==
X-Gm-Message-State: AOJu0Yw98zpefk6kUxrx0EWN+LrrxPxZNtJFHkCfb/6R065IDNNDWERc
	rlwTweCAvRt+Hvv2Z8ZDRhR/prIZKXf0OImzaChrCsHRdepyAC67IM1hbm/TLIKsfrI7SVM4RDC
	BzuUcnEVQ2yTrMM/ViSkV+AS7yyml0EFniVtC
X-Google-Smtp-Source: AGHT+IFRSOgkzkjLnzFYhjtojv9zXtEfhnmrpuhjhF1QSAGhPIuoCZ6kU3nMDyjzf5kVyjnwwKCKcmfbXnyCQ/kBnoQ=
X-Received: by 2002:a2e:beaa:0:b0:2ee:5b64:b471 with SMTP id
 38308e7fff4ca-2eef2da5dacmr4220141fa.30.1721062151922; Mon, 15 Jul 2024
 09:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713044645.10840-1-khuey@kylehuey.com> <ZpLkR2qOo0wTyfqB@krava>
 <20240715111208.GB14400@noisy.programming.kicks-ass.net> <CAP045ArBNZ559RFrvDTsHj42S4W+BuReHe+XV2tBPSeoHOMMpA@mail.gmail.com>
 <20240715150410.GJ14400@noisy.programming.kicks-ass.net> <CAP045Aq3Mv2oDMCU8-Afe7Ne+RLH62120F3RWqc+p9STpcxyxg@mail.gmail.com>
 <20240715163003.GK14400@noisy.programming.kicks-ass.net>
In-Reply-To: <20240715163003.GK14400@noisy.programming.kicks-ass.net>
From: Kyle Huey <me@kylehuey.com>
Date: Mon, 15 Jul 2024 09:48:58 -0700
Message-ID: <CAP045Apu6Sb=eKLXkZ5TWitWbmGHMDArD1++81vdN2_NqeFTyw@mail.gmail.com>
Subject: Re: [PATCH] perf/bpf: Don't call bpf_overflow_handler() for tracing events
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, khuey@kylehuey.com, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	robert@ocallahan.org, Joe Damato <jdamato@fastly.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 9:30=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Jul 15, 2024 at 08:19:44AM -0700, Kyle Huey wrote:
>
> > I think this would probably work but stealing the bit seems far more
> > complicated than just gating on perf_event_is_tracing().
>
> perf_event_is_tracing() is something like 3 branches. It is not a simple
> conditional. Combined with that re-load and the wrong return value, this
> all wants a cleanup.
>
> Using that LSB works, it's just that the code aint pretty.

Maybe we could gate on !event->tp_event instead. Somebody who is more
familiar with this code than me should probably confirm that tp_event
being non-null and perf_event_is_tracing() being true are equivalent
though.

- Kyle
