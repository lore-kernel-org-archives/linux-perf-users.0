Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77396149E16;
	Sat,  8 Feb 2025 05:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738992338; cv=none; b=dC/wtW4zJipg8q4MpXGM5efdMOeAY4l5l5Y+CWZGHB5SsNvfLajYYikdWrsdyaU+xH+g7h097sIYTYGlm3UYPsLXYEq6RU0xkmEA4fJb8s4SVvtzkqhH3nb8lJC6o+7h3dmuzMZI6ZFV1bdjZ+RCxFe7rGTB7MofrG0T7AlIdeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738992338; c=relaxed/simple;
	bh=0smO9XkikRJHjHLhsl4Z55KXOlo/iN4VDmT24NDqpzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEQ0+PlAfjZiL+/7DRgPd0bcoh6073MenIbH2mMHSuIuqeZXUVXJ4AWn1w6l2O8uJr1jHJHCC4RXdmpQzUES6cVfilg+t7ieuXIhErDO4Rgf/l6QGYySk3zkK0/NZGWW4+s6tJ0T6hAPnmX6Be9/jrwQPOhW/g8JoQC9YYNJN+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvkqFV3k; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvkqFV3k"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6f6c90b51c3so22513517b3.2;
        Fri, 07 Feb 2025 21:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738992335; x=1739597135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OF4xeNuYmWKv0YV6IejqFGNZBvcjnf68cZWsTxDa3ec=;
        b=hvkqFV3kYGfpNfLLpGLfEvCcgRjG9DItGmy4SH151prvhhG6ZVkCSeZrbkVn43YavP
         wfds0hH6HzUXWBZXiGlBA1jlF7tJF25ZQkkgJi2smVf7S7Kyfex9uttjHi5T3aTezESJ
         VfqURSWUkuPqvXAX85KxiXMmLBao9K3163PHf8BbojTXIYWKFdiA0KJimUwXR2+zMMKK
         X6avIE9czZpgjHj32wlunc3zZlVueTpfsEVCsLa4p/qbAeycZrYAnN18mcCrrzFv0Gdp
         9F3QVfEX8w0T9Mt2yZz9pF9IAjRlyk0En/BqvAal/Noe0g2VaphBUYdFiiqg04f6H5pO
         F/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738992335; x=1739597135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OF4xeNuYmWKv0YV6IejqFGNZBvcjnf68cZWsTxDa3ec=;
        b=P23A81IkACJqR2CMOXuMR5Y9tC7PMEZ8UTnMTxELK6B9F3gwu1zSyRvKY+11pQIkBy
         jz0nqEpFTx39JhK07rn5t3V8DyP8RR2lJ9re3okxyNXMOIpWSgO1keFReMQEKSc+RVu4
         zT3/INRLaS3YSFHrsG1VKSiDZDj3iwJd+OdCrUcPiOWgyPEWyhHY4lRqDzo09AnblZDz
         XIagBnry1gO9Q67X6+6sh/Hk9uR2vk9eFoKld6Q58lEJiZqyy+d7r1UAVUr4fVez+Z2W
         xkjZVeqtUj3BfY9fC4x3Da/m1l/FB5ETO2bmv8lUNb0hvzHzN2FJMiKuL8lMoX6QDF5X
         xUrA==
X-Forwarded-Encrypted: i=1; AJvYcCU8QzvJsHIpAos97EZq+DN3aHHRJuRIR/DSUcYbtzRhu5MP8StSXyt5stM5FFM/ZMCeGO/YOlBS2YN8MFd6kqQG0Q==@vger.kernel.org, AJvYcCXAIHl3eMu5RotfIS+RbiBhDwbJvzHJCF2gmxRo/OZg6mgbm6cxIruxxwsXejQLXZE+aDh4O0Lmzr0QlhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQkl4y7L/3jhN5u4nPzx8I/8QranUifjIKQjgH3S2xdYPlY8Ou
	7ZhI9qtGGD3pXPTFmVzdAK5H8qRytU6EOs+4Xzqyj+voigPTai0pqtH0/TE0qIuCd31ttIK7Ir6
	hGJVCNliQMUaJdC7N6YP2Awp5dEM=
X-Gm-Gg: ASbGnctYBa2MLZefTJmngrTNSLhFUmNvjWOBkeWDuLY8glsUsyWeSuSOb4YN0OYTUX4
	qPZ7gpBYUjATKwxN54blWM9TGv4bO4wCL87oSFjf+wuM+DZD0EXS+iuJ3g1OwIr9PQoigA38=
X-Google-Smtp-Source: AGHT+IHRJprD1huFADTVuVRMYonFd5A03KQn7mQ86Ll8vexC8rJh2lc9dxjfOMOmLSPzMAsUWdzw2FfxoXKXDCG3eiM=
X-Received: by 2002:a05:690c:690f:b0:6ef:4a57:fc98 with SMTP id
 00721157ae682-6f9b286125bmr62303867b3.16.1738992335302; Fri, 07 Feb 2025
 21:25:35 -0800 (PST)
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
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 7 Feb 2025 21:25:24 -0800
X-Gm-Features: AWEUYZlfkjXbRRmX0GGEkubcOp71j8vYwaX8UyWMtiebFMXMvXUMdsgMV46atqg
Message-ID: <CAH0uvohMSS263T1ELDyy=OsOnjc8xDURpBqCfQPER5Urgwu2JA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf trace: Allocate syscall stats only if summary
 is on
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

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

I don't think so. Please don't say that to yourself. :)

Thanks,
Howard
