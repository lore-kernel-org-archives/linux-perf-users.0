Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D5D33A01B
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664236; cv=none; b=K62zvr2dMQoBKE7ZjmZrUAoEnvYsBex7rAv0NI5WkvrxIu63CcROwiaJ1YRmeGheeWWFni5TMiUJDR3ZGEnrbSv1OiYzf/6Fepc6c5wwzNrCZDp8aIuMVnNgillXgkmZnVU+qOim0MQ+2wcSMd3AOjxgxlOB5ZfvFQ1RpXkVX3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664236; c=relaxed/simple;
	bh=5eURALmjEXpcAT+tMtvn9nNrKnMmPzsrKL2QAv6/xDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwijJLx9g1cvEcrKyI/qJZ3RcAfyCtaE6/ulpDCFbtZas6ChmQW2YBP68SdJO3TV8qBxV2FguSEEvlFLUCRDTxUvtOXzhf8ArLGDzDnOVaI9dpn9rShJbUuvNixA8IsHBnwEVuiIEothKxDQhbPyT+x+7wdVj8CMd2YofCajCIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Co0CYXMw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Co0CYXMw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290da96b37fso202905ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761664235; x=1762269035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmwGfBA71gaKywqy7NioTKwzmenUnKIz3SBwxgyrT6A=;
        b=Co0CYXMwYdtQtcyZqfB5pR7IAbFU6k8rV3/hr/nwndkzCEdyaxEjWDU2v1TC+FPsss
         iXqYLQ5uWNIfqXHExs7O0xgmvTPU67AvDdQb0Jf8lbQzGClJnyjoui+yRdUfg59RU5rU
         UrRJQNld+UgQzu9IpVG1uIgZgag02/MI92KhXUjE12edZhZltd5gkgSsYKxAqN/AckFZ
         uaCqPspnEZoobI4xsctoExgItn2+2ZTmXNEYUFq+iWSCEJ0mMKNRRNrkYAunMhEb4Ju1
         s8EtJWeuRtN9waABmoUXxj/Ith1cLjvf8APGNKJPwq3lqp2Q/wnoKsL8dq2R/0LLkHL3
         BWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761664235; x=1762269035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmwGfBA71gaKywqy7NioTKwzmenUnKIz3SBwxgyrT6A=;
        b=IbTgDs2YQyQNMGMotiwEd0h3W33i/Q8CHRnIVvwTtS32279lnxFcbwbSOMPpOSaS+P
         O+ROn5tRuP67eCPxW1DnrjlRChIczSGqXR640crxxT/oiKe5/1U3w+qL+PKzQD2wuPBd
         KBVe9mOqvXtN+xw833NMLQaB83g3OoDWgYU9E8bXUjpndezgXN8YnHHhmMjX1xkafF1h
         VClEUHxiUcewB38pbGRAmwAVkmEh49iHuWetu3pNU7DouyFP7YCi/Y6/I/HDsHJCLd9j
         GxlCzqO8Ra2XGW2XzrfRpX0D0TQ5LFTy08J1jQimJdcgtM0mhV50DAL0ASkbP3bmG+xw
         dW9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXG8Z1IBN5hFAn/p8+zHK/+dOCKfRPNQjEtp3o/K066/9oHFNLQ6/y6XQ6Js300hjWJPtkPwT7rvMM2Bec4sr7J@vger.kernel.org
X-Gm-Message-State: AOJu0YyKBg5MMc3gCYyl6A/D+ZNxH3XAY8jgGO8/AotVbmw9l6WY72wY
	fL0EGA59xvjTLhIrCf3UiJ2dRtS2v7Kg4ScNVUOhiW19lMyGYZ02BsdexcHhoDEwNddc2zKB3G1
	LDyxTSzirxkiOooqQVWhyFt3jlvnRvFISu4PC6g4Q
X-Gm-Gg: ASbGnctDarvzUPHhJEnTzP5YMwWamBYmxn2nDJgAvX4wUkvZKMkDe/rW9lLPtC3mJIA
	E4CYMKSMMwMFnhsjXv/qSmiBDIwOmDmwAeXH7GryWfK65Rj+TRIio5AfwpcZ0dThUxHOA23Sfo1
	Wnq/Gg6cp6ePH1ogIihMuXKwwSMUAvnCI7sRjLhzC+VxP6OcViSlXe0e46WE8lo5RTwr1SxGxNc
	DpQKgIQXynOj3Yk52auLhAIPo8oNER4dP6pvAJLG7AGLgAWtAqYPSiS6yFL6XDRSuh/JKS9Spr+
	67C0PzWvmw3MN2OiUxW7DHFZgw==
X-Google-Smtp-Source: AGHT+IE3DMWW3zVk/a+sqA74LhwuSAxFitEwU8gUISEAsBDvLi/0+/aSCNWdCr0CI+9ikc+Vc3l//6wwZLtU99l+TEQ=
X-Received: by 2002:a17:902:f551:b0:25b:ce96:7109 with SMTP id
 d9443c01a7336-294cf219784mr4352065ad.3.1761664234147; Tue, 28 Oct 2025
 08:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027201405.3715599-1-irogers@google.com> <aQDcWtHI9LSBAWw9@x1>
In-Reply-To: <aQDcWtHI9LSBAWw9@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 Oct 2025 08:10:22 -0700
X-Gm-Features: AWmQ_blmLG8elvtK72Nq1qoZ_Qwt-KFZ9zTBzwwTPbDxl7b8KIejhv02kmuJaH8
Message-ID: <CAP-5=fXph-sL5cjdSXmeD-V3ydZ1YSTfS+4o5nM5KDE_aw8a0w@mail.gmail.com>
Subject: Re: [PATCH v1] perf test workload: Add thread count argument to thloop
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 8:08=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Oct 27, 2025 at 01:14:05PM -0700, Ian Rogers wrote:
> > Allow the number of threads for the thloop workload to be increased
> > beyond the normal 2. Add error checking to the parsed time and thread
> > count values.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/workloads/thloop.c | 41 ++++++++++++++++++++++++-----
> >  1 file changed, 35 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/wor=
kloads/thloop.c
> > index 457b29f91c3e..dbb88bcf49e0 100644
> > --- a/tools/perf/tests/workloads/thloop.c
> > +++ b/tools/perf/tests/workloads/thloop.c
> > @@ -31,21 +31,50 @@ static void *thfunc(void *arg)
> >
> >  static int thloop(int argc, const char **argv)
> >  {
> > -     int sec =3D 1;
> > -     pthread_t th;
> > +     int nt =3D 2, sec =3D 1, err =3D 1;
> > +     pthread_t *thread_list =3D NULL;
> >
> >       if (argc > 0)
> >               sec =3D atoi(argv[0]);
> >
> > +     if (sec <=3D 0) {
> > +             fprintf(stderr, "Error: seconds (%d) must be >=3D 1\n", s=
ec);
> > +             return 1;
> > +     }
> > +
> > +     if (argc > 1)
> > +             nt =3D atoi(argv[1]);
> > +
> > +     if (nt <=3D 0) {
> > +             fprintf(stderr, "Error: thread count (%d) must be >=3D 1\=
n", nt);
> > +             return 1;
> > +     }
> > +
> >       signal(SIGINT, sighandler);
> >       signal(SIGALRM, sighandler);
> > -     alarm(sec);
> >
> > -     pthread_create(&th, NULL, thfunc, test_loop);
> > +     thread_list =3D calloc(nt, sizeof(pthread_t));
> > +     if (thread_list =3D=3D NULL) {
> > +             fprintf(stderr, "Error: malloc failed for %d threads\n", =
nt);
> > +             goto out;
> > +     }
> > +     for (int i =3D 1; i < nt; i++) {
> > +             int ret =3D pthread_create(&thread_list[i], NULL, thfunc,=
 test_loop);
> > +
> > +             if (ret) {
> > +                     fprintf(stderr, "Error: failed to create thread %=
d\n", i);
>
> With nt=3D2 what happens if you manage to create the first thread but not
> the second? The first would not have its pthread_join()?

Yeah. Let's join them. I was trying to be clean and not just call
exit. Fwiw, the 1st thread is the main thread and I was trying to
avoid "nt - 1" appearing everything, or nt being 1 in the case of 2
threads. Anyway...

Thanks,
Ian

> > +                     goto out;
> > +             }
> > +     }
> > +     alarm(sec);
> >       test_loop();
> > -     pthread_join(th, NULL);
> > +     for (int i =3D 1; i < nt; i++)
> > +             pthread_join(thread_list[i], /*retval=3D*/NULL);
> >
> > -     return 0;
> > +     err =3D 0;
> > +out:
> > +     free(thread_list);
> > +     return err;
> >  }
> >
> >  DEFINE_WORKLOAD(thloop);
> > --
> > 2.51.1.851.g4ebd6896fd-goog
