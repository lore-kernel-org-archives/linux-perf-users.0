Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA21322425A;
	Wed, 26 Feb 2025 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607248; cv=none; b=B1VwuEau6VeMGsvj84foymJZXkVkWQGotaQyarJsljqpOrKAYdPHCQ2AfigSf4JZmIfNUZiGxR6ZGqV1rAL850FTHwSz3x4mJfMff/uRGdx7KIwyeX7hAe/lQxlKxx5agaKKFdJ6NL7Hzghf89kuVKskrdlQTgEiJIvLheE/PLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607248; c=relaxed/simple;
	bh=Gq6sFlE8L4UERVFFLlOXznpD30Gbi4mynlOtXAoi47s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzaH5+XW/qrbHE6qWjBV1URDHw6W5sSWv2rTkEbKsFQDNeF8hNyABC/jIJNZxonlGsUMdxTtkuukcC4WImXnAHYHeASJNbyP7hPZoRzM7TvDCAKoUZYL5PYVXrQC0z48wxJEdN0C9eJkBR6mCSLdGKvVf4p4Wvy0rWWrgkvJwLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGD1WS+t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGD1WS+t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23720C4CEEA;
	Wed, 26 Feb 2025 22:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740607248;
	bh=Gq6sFlE8L4UERVFFLlOXznpD30Gbi4mynlOtXAoi47s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QGD1WS+tpB3nakrIkPSY3YFt5jotep8OEQhO9yJpR8MTMc/OEcFnlWFZB9oquPiuB
	 71yiKhNsZt40N5WJNIlijRZHg18Fx0aujLcvCzRrBcXZYvYDy+ePPel+Is55r5oG8H
	 br047vNAnEZVMpbDTs64sDHdCIo6y4CTvPdaFmC+yIv6P51SvqPI3AFjHpeFF8e4vt
	 Tm2XNEP8e8dmOUIZPCGB1eziYWUDGUhQA3xyo8EQj6cApKFblhjCx4ReRYyo89kyLH
	 NgLIxgV7lstmIfaIcZzqqfmSjGvYTMgdzBP6WbbL2mrr+75NAd39OmfTKeh0+8bRcP
	 O7o07G0lTGsSg==
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d2acdea3acso1139575ab.0;
        Wed, 26 Feb 2025 14:00:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3PWaFkzHayqwAmH7DGt3xa5ey2zFlV3URvULSDTtWzcO8RsthiNzWer9Q+8Uwwld+nGt+12kj4TnvaU8=@vger.kernel.org, AJvYcCW0+kM225Y6iV3nXbO4HdIjEWqOXIJ5z/1TMeZ75TxwstsfA0R5J7CZ+WVOHtKq+Dh22z9BU1gGzHYewZQvZb+yPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY5AxC7siiHWPtutKWgM2UB4FLdA2XajoG33cIHaS2wtXkFVfe
	wT7ADPn4UWoTAtn0XWbdPX8+PxGreD0BR5DuNc0kGkS/uGmgsL3br4ctw9cMyC0QFNG5Jjvr1J8
	Kyc6PB5HPoA+hItfDh9ON2HOV/cw=
X-Google-Smtp-Source: AGHT+IHInxtODuG/XloB0r/X6+0Xdm255sgjOgDLlwow1akl8xeX2GE5NyynZY7TsN6ag34pVywzDfA5qe9nHTgdtCk=
X-Received: by 2002:a05:6e02:2195:b0:3d1:79a1:5b85 with SMTP id
 e9e14a558f8ab-3d3d1fb9c5cmr48364095ab.21.1740607247490; Wed, 26 Feb 2025
 14:00:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226203039.1099131-1-namhyung@kernel.org> <CAP-5=fVh2tTD22sFrPt37OJAhOsggvt2AVwf45p_pxTa=pnVKA@mail.gmail.com>
In-Reply-To: <CAP-5=fVh2tTD22sFrPt37OJAhOsggvt2AVwf45p_pxTa=pnVKA@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 26 Feb 2025 14:00:36 -0800
X-Gmail-Original-Message-ID: <CAPhsuW46wuwoXSf-Vq5Y78b3GeGspA3PqtNMm8GTHXAMmnRNbA@mail.gmail.com>
X-Gm-Features: AQ5f1Jo7UFc1GINzCV1sDiZHx1qptOLJ-zQBMuoaaHrVqrmG6Xl369kBkubu43g
Message-ID: <CAPhsuW46wuwoXSf-Vq5Y78b3GeGspA3PqtNMm8GTHXAMmnRNbA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Skip BPF sideband event for userspace profiling
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 12:59=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, Feb 26, 2025 at 12:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > The BPF sideband information is tracked using a separate thread and
> > evlist.  But it's only useful for profiling kernel and we can skip it
> > when users profile their application only.
>
> nit: It may be worth noting that profiling an application implicitly
> excludes the kernel samples.
>
> > It seems it already fails to open the sideband event in that case.
> > Let's remove the noise in the verbose output anyway.
> >
> > Cc: Song Liu <song@kernel.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> I wonder if the second evlist could be avoided similar to Howard's
> off-CPU sample events?
> I also wonder if we should make the evlist responsible for BPF and
> dummy/sideband events. Having unnecessary events increases the list
> size iterated over when creating sideband data, and so has a runtime
> cost. Having the logic separated in places like builtin-top and
> builtin-record feels suboptimal.

It appears we can indeed put this logic in evlist.

Thanks,
Song

> Thanks,
> Ian
>
