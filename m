Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC42BE650
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681370; cv=none; b=MlsMGTtVYCbap0YqQAMvbGSar300fGyqlWhVeNfdBE8Kg8jvnLIUSHdEPmskGbQ87Prt6c7u8Sc0mu7wpcafea0u//+GKWzy2xs1SKpodNBpJoZ2tcJxq9SnkiUZ4HnBVf+3poFm2Tuc6vbJr98wfTVtwsYsvyks5HDu9KXnCM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681370; c=relaxed/simple;
	bh=k1Nd2ZkHeTjO1+O9Y2qm5A3P/BikNVTJMUU/UEq3ZDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkv15eVj0X2P5cVjfwoBVApRivCLnxUoxKusYRsYf6zGa+jMP/OtvVTSRq13jK6nlcdA9C8uN2/QwaRL0q7gKB97cjbK1wxjDfl+SyojGF54S6m2pLboXGW9fEQ0pcVWJUy3r+MCG1B61LPX4/eWUX4xnnTQg8tthI90oLdGcVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o9flvZw6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9flvZw6"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290da96b37fso10255ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 12:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761681369; x=1762286169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qz7E3e014YVVbAntBggXwnVn/WihTsrRHoY0FNnCNtI=;
        b=o9flvZw6lhtY3SvoXTUr4tvua6z5v1jv9c5w9SdD9mBP+gFTbNxGjq0N+cUvt8eia0
         EhFqU0345Kes5GIeq56GqE9RPHWpfF1V5Lvu7UzUssuuXBzwYCQ1gjMftj8V6s9/WHK7
         +6rxNBKo0ZXGuYQBGvaV+HRGp1Xw9McZFdANEJXrMaavzabIMdgHTtgKgpGE8Esa4amM
         IUX2ZOe0Hu31ZXyZAqyssW7RQC958ROIZXete+PAS9nh17XFVSywlUx4wgsHDYe7k0k0
         +uIPYV6Ejf5LFoX9w0qgBOnndWPVO54Ln2XUo1W1JFxO7FJremqZTf8PurT7+faV9+Jy
         heYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681369; x=1762286169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qz7E3e014YVVbAntBggXwnVn/WihTsrRHoY0FNnCNtI=;
        b=IUsdR4xl5wJJ2YCHUi0HIoGCXC9SunYcgfii77Tnn3SATvYHoNw9mnFPw3oYBpdb1C
         +ots/vnPu3HBvLvbX0AxCYBq1NP7RCwjWWguR9T7y1/9DRKHofzX39lf2sHf6gKg3nte
         Imx5w6liBLsSf6kuXtv1Kb/99IOmBT/v7hLbFFlSwhgLXwiwmoihBZTqenQ/vHX9V7Rf
         R5GVUMNbS+yTnzgc1Xa9xTMyFwvO0ttLcpQVNmzqBfS4qTXcUUc2K9ATskLMo6OYfoYR
         eySZrOTUuQWHqJsd188brIOLHycxLbozpsdqCLjcqspqjUuvvpn6WsEx45zZMCMlnq94
         OJsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLBHwuWy+l1SwsdR2s0nmDu/Lw1iQjvPaJy4IjihciPqG4DSjHKCoRHw+u4HCEDvpaiMG4T0o2yZW7vvHgYHCq@vger.kernel.org
X-Gm-Message-State: AOJu0Yym3X3VedKgyXnNqNOZe2DfmGznfc/dj1MGZOrZa1CtYDxOcSu5
	1uV/B8Plhk1oWz+HUGVw2Wj+nF2R96J8+7JvCO/dtmWuOBjdTQ58IJ7GYWeKiVBd83ln5BfJdZL
	HeKMf5QOQu82rlqX5L5mq4FW51rq3JodPjPglxwY/
X-Gm-Gg: ASbGnctGPhalugO8aLczhl3GnMN/fWomXTOGAiyi8ZmRR/k9tDba2kaUV9clr3h5D7y
	eyKP2mFwfeN3U7vbgstchXoUmptg5D28bzfDHeGuzcFog0GBZKSq/3VK0t+x8US3m/OMQMpzeyd
	2Xgz0wIa+Du73LADUz6nLS2U94t04ByqJ9SBXWuaCsNR2+90skEAEFYL8UqXAPbhXebc+l8dOu6
	InHr6DyZvGoTo8BdcCC4Jap4nbn4LLpGvY6KupwkEQcBDxAr9OKO+AECkWRU0ee8ALMk8NlwKHs
	Kx66hchPkMq8Pny2Fcel23z0
X-Google-Smtp-Source: AGHT+IH3TRhcVUxRwROAnGiMz0BCFIqdPZZG0MhujaC2lMpKBeZ22ZAZZERQaCQH0w/cSR6Snh/KcjDC/TdE6BhUx1o=
X-Received: by 2002:a17:902:db05:b0:26e:ac44:3b44 with SMTP id
 d9443c01a7336-294de569f58mr1209945ad.10.1761681368203; Tue, 28 Oct 2025
 12:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028153821.4003666-1-irogers@google.com> <aQEV2ABm7JaGH3UO@x1>
In-Reply-To: <aQEV2ABm7JaGH3UO@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 Oct 2025 12:55:56 -0700
X-Gm-Features: AWmQ_bl0HnAjrQ_JMiG8nyJ6MWL_ZdLvpZp9FKGajQ3u8ZuiqIO16qXhOPI6o_4
Message-ID: <CAP-5=fVuB02yxjQu2qvEVy9WHbSvVaAgPCpgSY8bXrSHGkr3rg@mail.gmail.com>
Subject: Re: [PATCH v2] perf test workload: Add thread count argument to thloop
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 12:13=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Oct 28, 2025 at 08:38:20AM -0700, Ian Rogers wrote:
> > Allow the number of threads for the thloop workload to be increased
> > beyond the normal 2. Add error checking to the parsed time and thread
> > count values.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > v2: Perform the pthread_join unconditionally and ensure started
> >     threads terminate.
> > ---
> >  tools/perf/tests/workloads/thloop.c | 45 ++++++++++++++++++++++++-----
> >  1 file changed, 38 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/wor=
kloads/thloop.c
> > index 457b29f91c3e..bd8168f883fb 100644
> > --- a/tools/perf/tests/workloads/thloop.c
> > +++ b/tools/perf/tests/workloads/thloop.c
> > @@ -31,21 +31,52 @@ static void *thfunc(void *arg)
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
> > -     test_loop();
> > -     pthread_join(th, NULL);
> > +     thread_list =3D calloc(nt, sizeof(pthread_t));
> > +     if (thread_list =3D=3D NULL) {
> > +             fprintf(stderr, "Error: malloc failed for %d threads\n", =
nt);
> > +             goto out;
> > +     }
> > +     for (int i =3D 1; i < nt; i++) {
>
> Why do you start at 1? What goes in thread[0]? calloc() leaves it at
> NULL, then if you have two threads you'll allocate thread[1], i gets
> incremented, 2 < 2 fails, you get just one thread created, when two were
> asked?
>
> Oh, I see, you use the main thread to run, that test_loop() just before
> the err =3D 0, its just that you allocate thread[0] for nothing, that
> confused me.

Agreed. It was so I could avoid doing "nt-1" as I mentioned before.
Fwiw, pthread_self will sometimes return 0 for the main thread and so
it isn't entirely inconsistent to do things this way. Not that the
main thread should try to do a pthread_join with itself.

Thanks,
Ian

> - Arnaldo
>
> > +             int ret =3D pthread_create(&thread_list[i], NULL, thfunc,=
 test_loop);
> >
> > -     return 0;
> > +             if (ret) {
> > +                     fprintf(stderr, "Error: failed to create thread %=
d\n", i);
> > +                     done =3D 1; // Ensure started threads terminate.
> > +                     goto out;
> > +             }
> > +     }
> > +     alarm(sec);
> > +     test_loop();
> > +     err =3D 0;
> > +out:
> > +     for (int i =3D 1; i < nt; i++) {
> > +             if (thread_list && thread_list[i])
> > +                     pthread_join(thread_list[i], /*retval=3D*/NULL);
> > +     }
> > +     free(thread_list);
> > +     return err;
> >  }
> >
> >  DEFINE_WORKLOAD(thloop);
> > --
> > 2.51.1.851.g4ebd6896fd-goog
