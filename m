Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E881C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 23:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4572861A0C
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 23:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242236AbhKOXpy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343898AbhKOXm1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Nov 2021 18:42:27 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4243C079789;
        Mon, 15 Nov 2021 14:41:55 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so925114wme.4;
        Mon, 15 Nov 2021 14:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1wcRoUsi7m4so1ILzmSN202bo8uzxCLDy3lmO8Chj0s=;
        b=A6p8nlOgTxhb0XhsUTWEURq5tT7Io7Z5Q7zNDcascjpnruwYSLkz3L6hLjxGwNFxyl
         PJb/CoLuSrtanJwZF2woFycJ1knpO+EmTSH520PPS9kjm8nsA0QKNfbzQMVnBlLfD2/T
         +a3jF/tf1jw11k7khy2fXKD3uIvbKmqNDsu2EBMwcWsTIRxjVcQwIR0Snuurh7qo9Hns
         d+Ynts/T+OYP2yhQGl6kMFSbi/ha+s8QNZLB2egLZuUB5RvI7wEg29cIMdhKMbMYcnTp
         fhRb10DKuwP6MdDG2E1XjIc8w+Bvwvg7YQXJ67+tPy2yoy4vaqqAyD9pJJgFx/25u1QC
         LZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1wcRoUsi7m4so1ILzmSN202bo8uzxCLDy3lmO8Chj0s=;
        b=H5DQ6I8EfcXQLEM/Sr1+v5YkP4SbnqwsSapM1t/0JKCUKL7fOQjZg8aITDpYBiwquC
         C0wpCm2RKPZeExkUqyhl2v6IlGqb26qdsCd5kqa/d5mkT7KIAKUKTzEF+fMXs+i+slLP
         g+gcd6eZPbglMgDue4/geQrllCHSwAo544D83bF/HZQ+sG237ChTpmoyoubwODrWh4E5
         Fgr67UKXby6aryY7v62l/WO3zLeHzvnnt95swWBAp1xtE3bAghl4dLEMATT5S8HlCJ/x
         t0d4g51GpuNjKCpLIgk+jGXGboNwUropzQA62X8DZmNn1qMCSkLG9o6+RImUVSmHQ6zI
         0HnQ==
X-Gm-Message-State: AOAM533aAT38NytPDTB1vePgV0GUEqXKhEcurEStwwD307PhW4gu+NlO
        nvKTdtsDSt+Ia/dLHrGjRiY=
X-Google-Smtp-Source: ABdhPJxa52tQBjaB2iU8+hZZNsx2OY72vhMth8Lqzlaj1rlosTCBAsZBjh6xbfcKET/RaPALdPBXYg==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr62053756wmi.107.1637016114281;
        Mon, 15 Nov 2021 14:41:54 -0800 (PST)
Received: from pc ([197.49.250.127])
        by smtp.gmail.com with ESMTPSA id r8sm19649518wrz.43.2021.11.15.14.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:41:53 -0800 (PST)
Date:   Tue, 16 Nov 2021 00:41:51 +0200
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <20211115224151.odaewu62ltx7smty@pc>
References: <20211112215313.108823-1-sohaib.amhmd@gmail.com>
 <YY+sqrAm1sAFEUQ4@kernel.org>
 <YY+tDhLJ5R6dijUv@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY+tDhLJ5R6dijUv@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello, Arnaldo

On Sat, Nov 13, 2021 at 09:18:22AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Nov 13, 2021 at 09:16:42AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Nov 12, 2021 at 11:53:12PM +0200, Sohaib Mohamed escreveu:
> > > The output of perf bench gets buffered when I pipe it to a file or to
> > > tee, in such a way that I can see it only at the end.
> >
> > Good, now try with 'perf test' :-)
> >
> > Applying,
>
> Humm, take that back, when I almost did it for 'perf test' I used
> setvbuf(), take a look at it so that you don't have to go sprinkling
> fflush() calls and missing some places.
>
> - Arnaldo

I'm not sure about the meaning of 'perf test' here, Should I write new unit
tests?

I found I could invoke this function at the beginning of perf-bench:
setvbuf(stdout, NULL, _IONBF, 0);
This looks to me will resolve the issue for all perf-bench subcommands.
I'm not sure if a good practice...

This probably is version 2 of this patch:


diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index d0895162c2ba..a0b812cde1ee 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -226,7 +226,6 @@ static void run_collection(struct collection *coll)
                if (!bench->fn)
                        break;
                printf("# Running %s/%s benchmark...\n", coll->name, bench->name);
-               fflush(stdout);

                argv[1] = bench->name;
                run_bench(coll->name, bench->name, bench->fn, 1, argv);
@@ -247,6 +246,8 @@ int cmd_bench(int argc, const char **argv)
        struct collection *coll;
        int ret = 0;

+       setvbuf(stdout, NULL, _IONBF, 0);
+
        if (argc < 2) {
                /* No collection specified. */
                print_usage();
@@ -300,7 +301,6 @@ int cmd_bench(int argc, const char **argv)

                        if (bench_format == BENCH_FORMAT_DEFAULT)
                                printf("# Running '%s/%s' benchmark:\n", coll->name, bench->name);
-                       fflush(stdout);
                        ret = run_bench(coll->name, bench->name, bench->fn, argc-1, argv+1);
                        goto end;
                }



Thanks,
- Sohaib

>
> > - Arnaldo
> >
> > > E.g.
> > > $ perf bench internals synthesize -t
> > > < output comes out fine after each test run >
> > >
> > > $ perf bench internals synthesize -t | tee file.txt
> > > < output comes out only at the end of all tests >
> > >
> > > See, also:
> > > $ perf bench mem all | tee file.txt
> > > $ perf bench sched all | tee file.txt
> > > $ perf bench internals all -t | tee file.txt
> > > $ perf bench internals all | tee file.txt
> > >
> > > Suggested-by: Riccardo Mancini <rickyman7@gmail.com>
> > > Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
> > > ---
> > >  tools/perf/bench/find-bit-bench.c | 1 +
> > >  tools/perf/bench/synthesize.c     | 2 ++
> > >  2 files changed, 3 insertions(+)
> > >
> > > diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
> > > index 22b5cfe97023..39fb4184fbcb 100644
> > > --- a/tools/perf/bench/find-bit-bench.c
> > > +++ b/tools/perf/bench/find-bit-bench.c
> > > @@ -113,6 +113,7 @@ static int do_for_each_set_bit(unsigned int num_bits)
> > >
> > >  		if (use_of_val == accumulator)  /* Try to avoid compiler tricks. */
> > >  			printf("\n");
> > > +		fflush(stdout);
> > >  	}
> > >  	bitmap_free(to_test);
> > >  	return 0;
> > > diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
> > > index 7401ebbac100..d21d311df61b 100644
> > > --- a/tools/perf/bench/synthesize.c
> > > +++ b/tools/perf/bench/synthesize.c
> > > @@ -92,6 +92,7 @@ static int do_run_single_threaded(struct perf_session *session,
> > >  		update_stats(&event_stats, atomic_read(&event_count));
> > >  	}
> > >
> > > +	fflush(stdout);
> > >  	time_average = avg_stats(&time_stats);
> > >  	time_stddev = stddev_stats(&time_stats);
> > >  	printf("  Average %ssynthesis took: %.3f usec (+- %.3f usec)\n",
> > > @@ -186,6 +187,7 @@ static int do_run_multi_threaded(struct target *target,
> > >  		perf_session__delete(session);
> > >  	}
> > >
> > > +	fflush(stdout);
> > >  	time_average = avg_stats(&time_stats);
> > >  	time_stddev = stddev_stats(&time_stats);
> > >  	printf("    Average synthesis took: %.3f usec (+- %.3f usec)\n",
> > > --
> > > 2.25.1
> >
> > --
> >
> > - Arnaldo
>
> --
>
> - Arnaldo
