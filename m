Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B821517F
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Feb 2025 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697453; cv=none; b=N/fuRm8sZfJCkhtPkZR9IDPQttcT3agH1axI3tstKYn8hygIQOr3nffHJC+JmEQhXQRfS/b1L3XPJAmhgictrA7imuvrw/A7NtLl3nwRllSu8LDmcwk4F4yie+qjwaswkRjFYY64vIhtvnFCk8XGHtdZCsQ4NJNq1imcEnQBTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697453; c=relaxed/simple;
	bh=reyF95bfUBAYffil9IVz3eSYyOLzt08HZXE9QNJTfns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQp87hX6D6bZROPg/YovUaxF7nc3yHprGevVVRfWk3mK8jTqpmk7zWXQ+ZGHA7QDXmlpkpdgMWfWQatJwuF4ZMY1QeFnYDahiSddd0p7H4fOJm8YTkxzKWkv+CrFYlNN0tQwugZJfsjUgfxuLfxEsCjQfzmcL5otuWujOkjfbd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aUUwvac7; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUUwvac7"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a814c54742so189255ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 11:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738697451; x=1739302251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dj4H26EqpqfJa3dxflkvA+dNKXBACmjipnFJPH1DsZY=;
        b=aUUwvac7owWb1HIFdOrk9wrCojnTNckgp3T3yLO8OMdfRQNwW6DaKzQdM2/njv+jSi
         cWtq2clV63tCWoCvqJDjBm2w2A9S5R66jGWZYLfiDkpNRcNr2FHDIdOk+b17oXP4VWRx
         lHqGoJOuN5AyXbOD6AbaGNigCSw6HmJztrfTuwCZd35+kKm6Wn/I1SjodOY/FMx0RjrR
         EA4XR79sKDy9bfvA0Rs2Sb5zE4sHh+mK7KAkEjqPmiWa7wJQPOQegf2N0lPuk6d5fcQP
         cTfEqv50cB2yoP+XUovtJzYXtDEv1A+MFVq9F/U2x1+xjAlY9fYqjHzsvUPmdiLoMBup
         O6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738697451; x=1739302251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dj4H26EqpqfJa3dxflkvA+dNKXBACmjipnFJPH1DsZY=;
        b=jJ5kqVA2aUh01TGr3NRQR7Bxrdw0sYYK5OKxZjjnJsKQg5fA38zhJ8aZBOm130kukb
         pCnjZIXPjSnpHMHwn3nAPBI6J4D3tQO1VfLWJht6GFAuV7+S/a0MwwUX5DgxL5hJGLGp
         U22WsBWLW1oOTH+lTMlWW+OcFoIVeAoVyBAvAO2jFx2vhdS4/a8Yd9kS86zg6/TF2DAl
         m0hQNX2+ikPOueW+9S04IqB1KNQ9Vpyd5eaEovWoSwXkVuQYx/R7UYuli+YG7CJdcGzF
         mULfIC5RzQGV4IoM341OXSWEw+zQ/x7gZaZCdUjF6Bq2LR9/qTbqZVlC1u6+SKOPPIIB
         voSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1lz1oQhJBL+yYg95mN9wDjpLUAnMRyHWQ+ecuqPgocmAL4EPk+FyVelPxboNytRIAv14GV3Lfk2p8mgkxjgE1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz44T1dca6bIUs95qY2vG7y+OyaIqf5zT1eGVJUKerduQ0CJAUF
	ga7EJzfhoBAxX6V+Nj/i/nR2Tuy44V1QAfgQIGXlMqyJkjF0x9NrXuc0CF1orOYhUQNPkzSeHOo
	yYcdtOMeAn/c1F2lKxN6TKSFy0otcH0YQz4jU
X-Gm-Gg: ASbGncs7J//fLC7TXeCZJgYzHGaAk96l6xdcVNDFQnp6XNKWc3DtHYU1Xlu5TCDT6Ky
	mL2xlL1nBcaz4vJp2CGOS47evEc7Uh7Gc79+Que/8DvH8g6y/EDCZRycC6LS69i/NvIPAX3Oxc2
	WtSBNYjg/kmtu4FiCeRdNrs1k=
X-Google-Smtp-Source: AGHT+IE8mPPweGD/XpLRwVh6HXIUhzMbEoHxkKV6IW0N3/GvKW/3kqA/gHoDCh3vemR2crcapQey99/lhfZZf4RzBOc=
X-Received: by 2002:a05:6e02:3790:b0:3cf:a4e4:8f89 with SMTP id
 e9e14a558f8ab-3d03fbc5fd6mr3884605ab.4.1738697450707; Tue, 04 Feb 2025
 11:30:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130030525.1482498-1-namhyung@kernel.org> <20250130030525.1482498-2-namhyung@kernel.org>
 <CAP-5=fVJDi2UuhTYk5g-QaLqZC29tAprKWs_0PKNmd+y=iugjA@mail.gmail.com>
 <Z6GCde4XqCuEZlgz@google.com> <CAP-5=fVrFzxcLZG8DyYh2rbd3u4133V6hhrQFCHsq_QMVVW=9g@mail.gmail.com>
 <Z6JosmbJBmiRHBKK@google.com>
In-Reply-To: <Z6JosmbJBmiRHBKK@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Feb 2025 11:30:39 -0800
X-Gm-Features: AWEUYZk4s0UOeMvph36Z_mNa6fGMDDI7NG0jb-zIPxCg8YiaKMAHQHX4CtxQlDg
Message-ID: <CAP-5=fXdF41qVwUnZ1XjPM9PuiDa8owYwK=3eRznPEnMKrVkdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf trace: Allocate syscall stats only if summary
 is on
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 11:21=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Feb 04, 2025 at 07:59:01AM -0800, Ian Rogers wrote:
> > On Mon, Feb 3, 2025 at 6:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Sat, Feb 01, 2025 at 10:57:00PM -0800, Ian Rogers wrote:
> > > > On Wed, Jan 29, 2025 at 7:05=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > The syscall stats are used only when summary is requested.  Let's=
 avoid
> > > > > unnecessary operations.  Pass 'trace' pointer to check summary an=
d give
> > > > > output file together.
> > > >
> > > > I don't think this last sentence makes sense.
> > >
> > > Thanks for your review.  I'd say:  Pass 'trace' pointer instead of do=
ing
> > > 'summary' option and 'output' file pointer separately.
> >
> > This still doesn't make sense. There is lazier initialization:
> > ```
> > -               ttrace->syscall_stats =3D intlist__new(NULL);
> > +               if (trace->summary)
> > +                       ttrace->syscall_stats =3D intlist__new(NULL);
> > ```
> > and there are functions that take a FILE* but now we're going to use
> > the one in trace instead:
>
> Yep, those FILE* (fp) was from trace->output.
>
>
> > ```
> > @@ -1568,7 +1569,7 @@ static struct thread_trace *thread__trace(struct
> > thread *thread, FILE *fp)
> >
> >         return ttrace;
> >  fail:
> > -       color_fprintf(fp, PERF_COLOR_RED,
> > +       color_fprintf(trace->output, PERF_COLOR_RED,
> >                       "WARNING: not enough memory, dropping samples!\n"=
);
> >         return NULL;
> > ```
> > So why does the one passed to trace still exist? Unfortunately names
> > like "fp" and "output" are not intention revealing.
>
> I think "fp" is a conventional name for file pointers (probably from
> K&R?).
>
> >
> > Anyway, from the commit message and the code I don't understand what
> > this change is trying to do.
>
> I don't know where you didn't get it.  Apparently my English is not good
> enough.  So this commit does two things.
>
> 1. check trace->summary before allocating syscall_stats
> 2. change signature of thread__trace from (thread, fp) to (thread,
>    trace) so that it can use trace->output (fp) and trace->summary.
>
> I thought the change #2 is trivial enough to be in the same commit.  But
> I can split that if you want.

Ah, the diff was showing the function signature still taking fp which
was confusing me. Looking above I see:
```
-static struct thread_trace *thread__trace(struct thread *thread, FILE *fp)
+static struct thread_trace *thread__trace(struct thread *thread,
struct trace *trace)
```
Keeping the context in trace and not splitting the patch both make
sense to me. It'd be nice to capture your more verbose description in
the commit message.

Thanks,
Ian
