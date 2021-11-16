Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CB0C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 13:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C6A61C4F
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 13:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbhKPNuw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 16 Nov 2021 08:50:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:59698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236798AbhKPNuu (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Nov 2021 08:50:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A947761B49;
        Tue, 16 Nov 2021 13:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637070473;
        bh=L0/b5A0ZQAlrQCQ9zkoxCpHSFp5715/1sSWroaWRkvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LRpkJ6ZTVi2gdfregIDk41LH1kHqUcVLhJPraAw//U+SitZUvNRUS2b8WmEMENKdP
         kIY+UE5d903gig8jkwavug7MWqDFyYwP1aYdvd1HrHKh7yoLaKXk87jYXRd+k51QjT
         4trC61ZTUTSjFgNPLe8J0eZx+EsA0PD7/bHpSF9eZGqD//2ArxbP5pXxx6kUIDA3X2
         T9QVtulXtbGZmrI0FgOuv0GM7yzx/oXPWcFpijcVtzVQJcEKIZbFdzRvQSo36NyRRi
         gDEpBj+u1ch4Fy6ZQoQ1PcD7atLyCR2HnEh/urmFzfB+DCzQcTOgK1IeBUsCR5ZW0M
         2mXWYvtPcBlxA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4F34E4088E; Tue, 16 Nov 2021 10:47:50 -0300 (-03)
Date:   Tue, 16 Nov 2021 10:47:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     rickyman7@gmail.com, irogers@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf bench: flush stats when pipe it to a file or to tee
Message-ID: <YZO2hn+gDDa/Mhyj@kernel.org>
References: <20211112215313.108823-1-sohaib.amhmd@gmail.com>
 <YY+sqrAm1sAFEUQ4@kernel.org>
 <YY+tDhLJ5R6dijUv@kernel.org>
 <20211115224151.odaewu62ltx7smty@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115224151.odaewu62ltx7smty@pc>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Nov 16, 2021 at 12:41:51AM +0200, Sohaib Mohamed escreveu:
> Hello, Arnaldo
> 
> On Sat, Nov 13, 2021 at 09:18:22AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Sat, Nov 13, 2021 at 09:16:42AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Nov 12, 2021 at 11:53:12PM +0200, Sohaib Mohamed escreveu:
> > > > The output of perf bench gets buffered when I pipe it to a file or to
> > > > tee, in such a way that I can see it only at the end.
> > >
> > > Good, now try with 'perf test' :-)
> > >
> > > Applying,
> >
> > Humm, take that back, when I almost did it for 'perf test' I used
> > setvbuf(), take a look at it so that you don't have to go sprinkling
> > fflush() calls and missing some places.
> >
> > - Arnaldo
> 
> I'm not sure about the meaning of 'perf test' here, Should I write new unit
> tests?

Try:

$ perf test 2>&1 | tee /tmp/bla

It uses buffered output, so we see the output in bumps, would be better
to use unbuffered.
 
> I found I could invoke this function at the beginning of perf-bench:
> setvbuf(stdout, NULL, _IONBF, 0);
> This looks to me will resolve the issue for all perf-bench subcommands.
> I'm not sure if a good practice...

Well, it will achieve what you want, right? Unbuffered output, which I
think is desirable.

> This probably is version 2 of this patch:

Yeah, looks ok.

- Arnaldo
 
> 
> diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> index d0895162c2ba..a0b812cde1ee 100644
> --- a/tools/perf/builtin-bench.c
> +++ b/tools/perf/builtin-bench.c
> @@ -226,7 +226,6 @@ static void run_collection(struct collection *coll)
>                 if (!bench->fn)
>                         break;
>                 printf("# Running %s/%s benchmark...\n", coll->name, bench->name);
> -               fflush(stdout);
> 
>                 argv[1] = bench->name;
>                 run_bench(coll->name, bench->name, bench->fn, 1, argv);
> @@ -247,6 +246,8 @@ int cmd_bench(int argc, const char **argv)
>         struct collection *coll;
>         int ret = 0;
> 
> +       setvbuf(stdout, NULL, _IONBF, 0);
> +
>         if (argc < 2) {
>                 /* No collection specified. */
>                 print_usage();
> @@ -300,7 +301,6 @@ int cmd_bench(int argc, const char **argv)
> 
>                         if (bench_format == BENCH_FORMAT_DEFAULT)
>                                 printf("# Running '%s/%s' benchmark:\n", coll->name, bench->name);
> -                       fflush(stdout);
>                         ret = run_bench(coll->name, bench->name, bench->fn, argc-1, argv+1);
>                         goto end;
>                 }
> 
> 
> 
> Thanks,
> - Sohaib
> 
> >
> > > - Arnaldo
> > >
> > > > E.g.
> > > > $ perf bench internals synthesize -t
> > > > < output comes out fine after each test run >
> > > >
> > > > $ perf bench internals synthesize -t | tee file.txt
> > > > < output comes out only at the end of all tests >
> > > >
> > > > See, also:
> > > > $ perf bench mem all | tee file.txt
> > > > $ perf bench sched all | tee file.txt
> > > > $ perf bench internals all -t | tee file.txt
> > > > $ perf bench internals all | tee file.txt
> > > >
> > > > Suggested-by: Riccardo Mancini <rickyman7@gmail.com>
> > > > Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
> > > > ---
> > > >  tools/perf/bench/find-bit-bench.c | 1 +
> > > >  tools/perf/bench/synthesize.c     | 2 ++
> > > >  2 files changed, 3 insertions(+)
> > > >
> > > > diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
> > > > index 22b5cfe97023..39fb4184fbcb 100644
> > > > --- a/tools/perf/bench/find-bit-bench.c
> > > > +++ b/tools/perf/bench/find-bit-bench.c
> > > > @@ -113,6 +113,7 @@ static int do_for_each_set_bit(unsigned int num_bits)
> > > >
> > > >  		if (use_of_val == accumulator)  /* Try to avoid compiler tricks. */
> > > >  			printf("\n");
> > > > +		fflush(stdout);
> > > >  	}
> > > >  	bitmap_free(to_test);
> > > >  	return 0;
> > > > diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
> > > > index 7401ebbac100..d21d311df61b 100644
> > > > --- a/tools/perf/bench/synthesize.c
> > > > +++ b/tools/perf/bench/synthesize.c
> > > > @@ -92,6 +92,7 @@ static int do_run_single_threaded(struct perf_session *session,
> > > >  		update_stats(&event_stats, atomic_read(&event_count));
> > > >  	}
> > > >
> > > > +	fflush(stdout);
> > > >  	time_average = avg_stats(&time_stats);
> > > >  	time_stddev = stddev_stats(&time_stats);
> > > >  	printf("  Average %ssynthesis took: %.3f usec (+- %.3f usec)\n",
> > > > @@ -186,6 +187,7 @@ static int do_run_multi_threaded(struct target *target,
> > > >  		perf_session__delete(session);
> > > >  	}
> > > >
> > > > +	fflush(stdout);
> > > >  	time_average = avg_stats(&time_stats);
> > > >  	time_stddev = stddev_stats(&time_stats);
> > > >  	printf("    Average synthesis took: %.3f usec (+- %.3f usec)\n",
> > > > --
> > > > 2.25.1
> > >
> > > --
> > >
> > > - Arnaldo
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
