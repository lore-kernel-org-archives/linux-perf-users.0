Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BB11F37CF
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266299; cv=none; b=R9p/qd2hWO6/6FMG/fME2ze7//QFEK6KrIyWInCenVBLMvEqLC5I9TfEG4uxzzcyMNNtVnss8ZVXVly+djyxJIB2apd+punShxS9ztm+WTgBvZB9ACKfpXIvQpWkdHNO+LQMmD8GwJknPyNBqB79I+2KIEnOlp/j5jAFCEw5eJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266299; c=relaxed/simple;
	bh=oe4rYLsJTSsMqz8kYPo07co6S2Ugvm2arY6rIL9BfrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hITWJL99R7UzO6F4APpyIILfuZoF9cPGlLNNYH4okDZXyoq2D0Cm5alBQ3uhCz+17JKgvamsDe1Vt7B7BPMn2lFc95xTDTwmGCD2dM0BcfDgoCYdv+Sa1kp/IhAFwCKU5LUfIxieIB4zvPBspgs1KYOFkPpAqMbrrCi1IEXKWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yPt3ebKd; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yPt3ebKd"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so154205ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 08:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736266296; x=1736871096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovdIMwIwiZ14E4dfVfO4ghoVyZV5ri9bDMxCK8IFTAI=;
        b=yPt3ebKdNxIBfWrLby1RomYYDU1AwUTaLMOmp80bLrYRrE7BXIMQ0CerAWr4ziB2c9
         UK8eZaK63qo/zFFJWH7dscth41z3gfw2AxCvging7NmplAveit52bFC9x78MNRmoHcoM
         /QLmo12DhbMdU06+cJS0IDyoTSx2LcQgJLZin9PT8jI843PfBG705oLeTe1bvsZWWrUY
         PRSh0VGRy+j9Oi90eB9XyhNX+/FP1P5deyc9cyS5d0OIFegqgeIojU+O3zZADSjS1pF2
         mSF3KHc2LijPEposq6EyYWp9UXO45LnjdQbmchQ2eiKgPprHw5urfNJJgLz3ugpMrw8n
         dHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736266296; x=1736871096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovdIMwIwiZ14E4dfVfO4ghoVyZV5ri9bDMxCK8IFTAI=;
        b=dES5YjuhKeZAcQ31qKd8+gylZAcM0zju2xnAy6keEBsq5c1dNs8UM6VPpCmh8TcNWN
         yHKLHdkkgDSJdSQRj2yT52ly6mZhSYUVbB1DLrqZzh28Qc9P0knskGzErJbc0OhP/TNM
         HgWEwbZJuMXhGbpGMfCpdK3sumIKH/TlYSC1vJlXiLB+2nlO6FZmVou5Lt+53pGJZFfj
         qj1+jsfBWUWkf/DZ++/IjtMbJ3tnmmWFsQMpYkS/aM7xu6roHZlwLncy2SMIAQyHNjuI
         f+t6R54uT/TCOq4DmmZlA5b0C3GsSTvDah0fVi0t5G8+s5J03Va2fn5yD5lu8vEFlBJR
         SUlw==
X-Forwarded-Encrypted: i=1; AJvYcCVMrNFAUk/Gdj0Fo5PR6lD/4Onrj12G3iZBl/eXuIO9gS6qsnkAgyCcTkYZ+9OixrK+vVa40N7VB6mqAfk3Gokf@vger.kernel.org
X-Gm-Message-State: AOJu0YxVtVgzAeY3sPKAEkjha2tzw1Im0BDIlQbSjDK1GFt+bLai0jWT
	nuVTMMC3VfYGrFmJxstAsLsF1Vgw5KcS3fGLOX2PlcTrm4JlkD/9pR4iMStJPXu6MPm+0HhJdua
	psDyccWNxTUMLt7L4ItcP/JI20hDAWGPPRgrb
X-Gm-Gg: ASbGncu9jM+HuEIvkgZbeM2TpgTRFaWwzfqVQ2Wy6n5d+oQKmeM2TTKDlfKC7lrjPUi
	44IWsEEZGar4dhXqTk30g6N4By9vkKjzXNkJRy8W6Cw6zj6oksPnwh74MUQnzkwz9IDR6og==
X-Google-Smtp-Source: AGHT+IFRGMAI8grxoLwU2BMFOYBqhR5G/5+yRiXlsTISXSuvfb3Eb0aGg6zU69aqjzEvaVHXuJ/Tu/v7loLxxl0BAcI=
X-Received: by 2002:a05:6e02:1068:b0:3ce:3873:48d4 with SMTP id
 e9e14a558f8ab-3ce38734b0amr762905ab.4.1736266295512; Tue, 07 Jan 2025
 08:11:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106215443.198633-1-irogers@google.com> <576a50c8-9ca2-4e2f-9bd8-7d9be4862920@linaro.org>
In-Reply-To: <576a50c8-9ca2-4e2f-9bd8-7d9be4862920@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Jan 2025 08:11:23 -0800
Message-ID: <CAP-5=fUZ2QCocFKdLfBoNYC-CQfSAcdbA05OhegKmTt_PLR1WA@mail.gmail.com>
Subject: Re: [PATCH v1] tools build: Fix a number of Wconversion warnings
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 2:33=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> On 06/01/2025 9:54 pm, Ian Rogers wrote:
> > There's some expressed interest in having the compiler flag
> > -Wconversion detect at build time certain kinds of potential problems:
> > https://lore.kernel.org/lkml/20250103182532.GB781381@e132581.arm.com/
> >
> > As feature detection passes -Wconversion from CFLAGS when set, the
> > feature detection compile tests need to not fail because of
> > -Wconversion as the failure will be interpretted as a missing
> > feature. Switch various types to avoid the -Wconversion issue, the
> > exact meaning of the code is unimportant as it is typically looking
> > for header file definitions.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> What's the plan for errors in #includes that we can't modify? I noticed
> the Perl feature test fails with -Wconversion but can be fixed by
> disabling the warning:
>
>    #pragma GCC diagnostic push
>    #pragma GCC diagnostic ignored "-Wsign-conversion"
>    #pragma GCC diagnostic ignored "-Wconversion"
>    #include <EXTERN.h>
>    #include <perl.h>
>    #pragma GCC diagnostic pop
>
> Not sure why it needs both those things to be disabled when I only
> enabled -Wconversion, but it does.

This change lgtm, I'm not sure how others feel. I don't have a plan, I
was just following up on Leo's Wconversion comment to see what state
things were in. The feature tests without these changes pretty much
break the build (I can live without perl support :-) ) so I thought I
could move things forward there and then see the state of Wconversion
with the patch I was working on.

I'm not sure how others feel about fixing Wconversion in perf, the
errors are quite noisy imo. The biggest issue imo will be with headers
shared by tools and the kernel, where kernel people may be vocal on
the merits of Wconversion.

> > ---
> >   tools/build/feature/test-backtrace.c           | 2 +-
> >   tools/build/feature/test-bpf.c                 | 2 +-
> >   tools/build/feature/test-glibc.c               | 2 +-
> >   tools/build/feature/test-libdebuginfod.c       | 2 +-
> >   tools/build/feature/test-libdw.c               | 2 +-
> >   tools/build/feature/test-libelf-gelf_getnote.c | 2 +-
> >   tools/build/feature/test-libelf.c              | 2 +-
> >   tools/build/feature/test-lzma.c                | 2 +-
> >   8 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/build/feature/test-backtrace.c b/tools/build/feature=
/test-backtrace.c
> > index e9ddd27c69c3..7962fbad6401 100644
> > --- a/tools/build/feature/test-backtrace.c
> > +++ b/tools/build/feature/test-backtrace.c
> > @@ -5,7 +5,7 @@
> >   int main(void)
> >   {
> >       void *backtrace_fns[10];
> > -     size_t entries;
> > +     int entries;
> >
> >       entries =3D backtrace(backtrace_fns, 10);
> >       backtrace_symbols_fd(backtrace_fns, entries, 1);
> > diff --git a/tools/build/feature/test-bpf.c b/tools/build/feature/test-=
bpf.c
> > index 727d22e34a6e..e7a405f83af6 100644
> > --- a/tools/build/feature/test-bpf.c
> > +++ b/tools/build/feature/test-bpf.c
> > @@ -44,5 +44,5 @@ int main(void)
> >        * Test existence of __NR_bpf and BPF_PROG_LOAD.
> >        * This call should fail if we run the testcase.
> >        */
> > -     return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
> > +     return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr)) =3D=
=3D 0;
>
> Seems a bit weird to invert some of the return values rather than doing
> !=3D 0, but as you say, the actual values seem to be unimportant.
>
> Reviewed-by: James Clark <james.clark@linaro.org>

Yeah it was arbitrary and I didn't want to add a stdlib.h dependency
in a bunch of places for the sake of a definition of NULL. I'm happy
for things to be done differently if people like.

Thanks,
Ian
