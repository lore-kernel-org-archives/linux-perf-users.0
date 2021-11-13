Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0B2C433F5
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 Nov 2021 12:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4827F61075
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 Nov 2021 12:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhKMMVR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 13 Nov 2021 07:21:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhKMMVQ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 13 Nov 2021 07:21:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A796161051;
        Sat, 13 Nov 2021 12:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636805904;
        bh=lnmeFK9mh836G3nxFYF5yuM019RQ0fepEDS/+f+uGJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PH7bS3XMXs+6QeT3sGJ+3UIBeLbPHbtQg2uq7cXz5WjXBOKH4vsm35NZ8meO2jOrA
         /u33JELgTjxHgGSmYgn0ySTPy+6Jg/0n4Ol7AVS+Wt2oC4yjen2e+gqypevt+dnS0V
         kkJyJ8R2KguKgU9I5cVJl+tMCC/dCwjcxSXtZuzWO5I8gOq32V1YSQnkuq7HP2nR0l
         VMAc5u6fUwKA72eq1GIPBGNT8H1+K4BgqyKeUmO+ABfZK6AGl/q5s4Q41+/O6v8mRV
         dW8nxkZnpgYnj2GaMOdvoOujkmV3HOVryQaJHf1qDoHfUjQEByfbtf8DWpx/w+HPHB
         vMR+0Ss9YHJfQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 69F16410A1; Sat, 13 Nov 2021 09:18:22 -0300 (-03)
Date:   Sat, 13 Nov 2021 09:18:22 -0300
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
Message-ID: <YY+tDhLJ5R6dijUv@kernel.org>
References: <20211112215313.108823-1-sohaib.amhmd@gmail.com>
 <YY+sqrAm1sAFEUQ4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY+sqrAm1sAFEUQ4@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Nov 13, 2021 at 09:16:42AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Nov 12, 2021 at 11:53:12PM +0200, Sohaib Mohamed escreveu:
> > The output of perf bench gets buffered when I pipe it to a file or to
> > tee, in such a way that I can see it only at the end.
> 
> Good, now try with 'perf test' :-)
> 
> Applying,

Humm, take that back, when I almost did it for 'perf test' I used
setvbuf(), take a look at it so that you don't have to go sprinkling
fflush() calls and missing some places.

- Arnaldo
 
> - Arnaldo
>  
> > E.g.
> > $ perf bench internals synthesize -t
> > < output comes out fine after each test run >
> > 
> > $ perf bench internals synthesize -t | tee file.txt
> > < output comes out only at the end of all tests >
> > 
> > See, also:
> > $ perf bench mem all | tee file.txt
> > $ perf bench sched all | tee file.txt
> > $ perf bench internals all -t | tee file.txt
> > $ perf bench internals all | tee file.txt
> > 
> > Suggested-by: Riccardo Mancini <rickyman7@gmail.com>
> > Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
> > ---
> >  tools/perf/bench/find-bit-bench.c | 1 +
> >  tools/perf/bench/synthesize.c     | 2 ++
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
> > index 22b5cfe97023..39fb4184fbcb 100644
> > --- a/tools/perf/bench/find-bit-bench.c
> > +++ b/tools/perf/bench/find-bit-bench.c
> > @@ -113,6 +113,7 @@ static int do_for_each_set_bit(unsigned int num_bits)
> > 
> >  		if (use_of_val == accumulator)  /* Try to avoid compiler tricks. */
> >  			printf("\n");
> > +		fflush(stdout);
> >  	}
> >  	bitmap_free(to_test);
> >  	return 0;
> > diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
> > index 7401ebbac100..d21d311df61b 100644
> > --- a/tools/perf/bench/synthesize.c
> > +++ b/tools/perf/bench/synthesize.c
> > @@ -92,6 +92,7 @@ static int do_run_single_threaded(struct perf_session *session,
> >  		update_stats(&event_stats, atomic_read(&event_count));
> >  	}
> > 
> > +	fflush(stdout);
> >  	time_average = avg_stats(&time_stats);
> >  	time_stddev = stddev_stats(&time_stats);
> >  	printf("  Average %ssynthesis took: %.3f usec (+- %.3f usec)\n",
> > @@ -186,6 +187,7 @@ static int do_run_multi_threaded(struct target *target,
> >  		perf_session__delete(session);
> >  	}
> > 
> > +	fflush(stdout);
> >  	time_average = avg_stats(&time_stats);
> >  	time_stddev = stddev_stats(&time_stats);
> >  	printf("    Average synthesis took: %.3f usec (+- %.3f usec)\n",
> > --
> > 2.25.1
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
