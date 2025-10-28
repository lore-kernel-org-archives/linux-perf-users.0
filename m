Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25132B99B;
	Tue, 28 Oct 2025 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683835; cv=none; b=KCTRdXDtGLzGPa6/pZ7Q1OXP4bhoWXsvHA932s40ZsjS4AXPl0WWuRvLSxs9+ut8ZYVashjMl14Goh49HlDSKkDFZ3pmd2At0boEGNNUvPZFtIPI+933yrv/iEaStAPXItWre5bYVf5HJ3B1rhoCb2gBf02O/5Y8rR74ZxJbVgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683835; c=relaxed/simple;
	bh=X+6GU/BChhinqh72N81kiyBwcfgHtagVGJha8LiJPIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4hAkPNfxcPNYG7xzngZfFb+BnMuiFygUHa7BII8db9C9ukj44gFuA/bXRuKxgGd3ySTMhtD0Pwt5fkJqoBGGXrXvkpyF55Oy6tizZrr9ss43KG64A+ZDUDAmjuahaeRaxPgI/Y7V325jZwVt2/gv7uw6HNieexJ+7InLoo2YQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYtRk03G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYtRk03G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A03C4CEFF;
	Tue, 28 Oct 2025 20:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761683834;
	bh=X+6GU/BChhinqh72N81kiyBwcfgHtagVGJha8LiJPIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYtRk03GQ0ObjH7uaQZSmGQ/bIcs2EKdx3Vco5ZFaqLRcUzZMrP4AjZBmuEYu/iOr
	 c4Al02kVstJpDUEmLLbewZkiLKq8faHbKNgBC/HOyCNkZ/GBcieS8tXEQm7l+7VRtL
	 FgQm0GcafRdVf0o2lS8UtA1D9DXhppisCTFQZLMTcVjz3JoBjtKnk3QiESB/fNtula
	 pibQ/f5FarCmAebLwPgDMOgizHvZAIQZrA8EVQA8ZQ5N0489/09z0IRIFJy4nzsknC
	 eKrWo10VsT9DN3TUDd5XDQ6dmD9yecLWUPwHvVnYUX2lNYidEw6VoPp0ltpey4IxqM
	 cSmSMSydWUzDA==
Date: Tue, 28 Oct 2025 17:37:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf test workload: Add thread count argument to
 thloop
Message-ID: <aQEpdjP5OwU73q64@x1>
References: <20251028153821.4003666-1-irogers@google.com>
 <aQEV2ABm7JaGH3UO@x1>
 <CAP-5=fVuB02yxjQu2qvEVy9WHbSvVaAgPCpgSY8bXrSHGkr3rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVuB02yxjQu2qvEVy9WHbSvVaAgPCpgSY8bXrSHGkr3rg@mail.gmail.com>

On Tue, Oct 28, 2025 at 12:55:56PM -0700, Ian Rogers wrote:
> On Tue, Oct 28, 2025 at 12:13 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Tue, Oct 28, 2025 at 08:38:20AM -0700, Ian Rogers wrote:
> > > Allow the number of threads for the thloop workload to be increased
> > > beyond the normal 2. Add error checking to the parsed time and thread
> > > count values.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > > v2: Perform the pthread_join unconditionally and ensure started
> > >     threads terminate.
> > > ---
> > >  tools/perf/tests/workloads/thloop.c | 45 ++++++++++++++++++++++++-----
> > >  1 file changed, 38 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
> > > index 457b29f91c3e..bd8168f883fb 100644
> > > --- a/tools/perf/tests/workloads/thloop.c
> > > +++ b/tools/perf/tests/workloads/thloop.c
> > > @@ -31,21 +31,52 @@ static void *thfunc(void *arg)
> > >
> > >  static int thloop(int argc, const char **argv)
> > >  {
> > > -     int sec = 1;
> > > -     pthread_t th;
> > > +     int nt = 2, sec = 1, err = 1;
> > > +     pthread_t *thread_list = NULL;
> > >
> > >       if (argc > 0)
> > >               sec = atoi(argv[0]);
> > >
> > > +     if (sec <= 0) {
> > > +             fprintf(stderr, "Error: seconds (%d) must be >= 1\n", sec);
> > > +             return 1;
> > > +     }
> > > +
> > > +     if (argc > 1)
> > > +             nt = atoi(argv[1]);
> > > +
> > > +     if (nt <= 0) {
> > > +             fprintf(stderr, "Error: thread count (%d) must be >= 1\n", nt);
> > > +             return 1;
> > > +     }
> > > +
> > >       signal(SIGINT, sighandler);
> > >       signal(SIGALRM, sighandler);
> > > -     alarm(sec);
> > >
> > > -     pthread_create(&th, NULL, thfunc, test_loop);
> > > -     test_loop();
> > > -     pthread_join(th, NULL);
> > > +     thread_list = calloc(nt, sizeof(pthread_t));
> > > +     if (thread_list == NULL) {
> > > +             fprintf(stderr, "Error: malloc failed for %d threads\n", nt);
> > > +             goto out;
> > > +     }
> > > +     for (int i = 1; i < nt; i++) {
> >
> > Why do you start at 1? What goes in thread[0]? calloc() leaves it at
> > NULL, then if you have two threads you'll allocate thread[1], i gets
> > incremented, 2 < 2 fails, you get just one thread created, when two were
> > asked?
> >
> > Oh, I see, you use the main thread to run, that test_loop() just before
> > the err = 0, its just that you allocate thread[0] for nothing, that
> > confused me.
> 
> Agreed. It was so I could avoid doing "nt-1" as I mentioned before.
> Fwiw, pthread_self will sometimes return 0 for the main thread and so
> it isn't entirely inconsistent to do things this way. Not that the
> main thread should try to do a pthread_join with itself.

:-)

Its just a test,

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Thanks,
> Ian
> 
> > - Arnaldo
> >
> > > +             int ret = pthread_create(&thread_list[i], NULL, thfunc, test_loop);
> > >
> > > -     return 0;
> > > +             if (ret) {
> > > +                     fprintf(stderr, "Error: failed to create thread %d\n", i);
> > > +                     done = 1; // Ensure started threads terminate.
> > > +                     goto out;
> > > +             }
> > > +     }
> > > +     alarm(sec);
> > > +     test_loop();
> > > +     err = 0;
> > > +out:
> > > +     for (int i = 1; i < nt; i++) {
> > > +             if (thread_list && thread_list[i])
> > > +                     pthread_join(thread_list[i], /*retval=*/NULL);
> > > +     }
> > > +     free(thread_list);
> > > +     return err;
> > >  }
> > >
> > >  DEFINE_WORKLOAD(thloop);
> > > --
> > > 2.51.1.851.g4ebd6896fd-goog
