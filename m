Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3177AC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Dec 2021 19:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbhLITds (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:33:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhLITdr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Dec 2021 14:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639078213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KdNSBzuwMtRAMCNZ3pk+C/086It2DmiMT1JFIWd+i/8=;
        b=Gf/EvvQWnDjLUnIjtVRBbAFn+QE4l5g085Kve8fJt/ORQTlkbSfXl/a9jgZFTN4jVTE7PO
        ol5g+2jjVLilefm07zPVnxZifoq4C43edswnck4ZyfvwjwcAYG95Fh1EipM96TatZDnS3Z
        Mk2qkeQFooAXNfVwkgmqXEUIcDMi3fk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-u_r9rVHcPt6dJfBZDQr7Ww-1; Thu, 09 Dec 2021 14:30:10 -0500
X-MC-Unique: u_r9rVHcPt6dJfBZDQr7Ww-1
Received: by mail-wm1-f72.google.com with SMTP id z138-20020a1c7e90000000b003319c5f9164so5339420wmc.7
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Dec 2021 11:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KdNSBzuwMtRAMCNZ3pk+C/086It2DmiMT1JFIWd+i/8=;
        b=QHngKwuGwG0SvSjKOePTBD0yHk/ZOKUBk4hCB/DukLIMgnrFNGPPuBHHzpDziejLdH
         NljSSWVg5PEIp0BMNlwuhlNfvT7p0VgrzDyhycG0pKXc7cP7w9PfnUrb//0pX/69qc0y
         wHE5LaMXiALZWdO3SYGVN2Lw2zl2yQAMHRqjmDiby+DNURNDiIdPZO8yjsG5RucSTxDn
         L2Qnj+PLTnc+JYE8ip844acMH9L8P7GCzDAytPPXn+XKqkKwXcodAAzHmtP0CFD9Xwsm
         TIr6dXbv/0QsSdR0KYQUKiuPGx/T+CsOpE2VmmxHr5R3Js7oZFxWeaoxYCHSUw8Kf4kJ
         s6Cg==
X-Gm-Message-State: AOAM530NyQ628CxZ6J7BHWdquREuEjL2ZOyyMy2DevvQZ3P4zx/Vyhcy
        ulpAbqulfWca2uY9KxW/h3hUdDTjsPqcoMYQA3BOCDepLJnFDmnuF2iFMjKfJyod4+vWPuMbjUZ
        /HLoNdWaJH5jbK7NOyCEsDB6jooe5sw==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr9969178wml.119.1639078209284;
        Thu, 09 Dec 2021 11:30:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRx1YfuMaa1lnYlwI+iuXZf1A/jyLmGlWI3oGWUPHiulDW3WXi64kvBXfucbK68/VlCjU9eg==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr9969146wml.119.1639078209058;
        Thu, 09 Dec 2021 11:30:09 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id a9sm569037wrt.66.2021.12.09.11.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:30:08 -0800 (PST)
Date:   Thu, 9 Dec 2021 20:30:06 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Sohaib Mohamed <sohaib.amhmd@gmail.com>, irogers@google.com,
        Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fabian Hemmer <copy@copy.sh>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Unbuffered output when pipe/tee to a file
Message-ID: <YbJZPsCfXi8QUbfR@krava>
References: <20211119061409.78004-1-sohaib.amhmd@gmail.com>
 <YaOhbfWzMv/uvKKi@krava>
 <YbJQOfeeAoJ1GzJZ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbJQOfeeAoJ1GzJZ@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Dec 09, 2021 at 03:51:37PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Nov 28, 2021 at 04:34:05PM +0100, Jiri Olsa escreveu:
> > On Fri, Nov 19, 2021 at 08:14:08AM +0200, Sohaib Mohamed wrote:
> > > The output of Perf bench gets buffered when I pipe it to a file or to
> > > tee, in such a way that I can see it only at the end.
> > > 
> > > E.g.
> > > $ perf bench internals synthesize -t
> > > < output comes out fine after each test run >
> > > 
> > > $ perf bench internals synthesize -t | tee file.txt
> > > < output comes out only at the end of all tests >
> > > 
> > > This patch resolves this issue for 'bench' and 'test' subcommands.
> > 
> > I can reproduce this for bench, but not for test subcommand
> > other that that it makes sense to me
> 
> I reproduced it, see my comment to Sohaib's message, its not at the end,
> its when the buffer fills up.
> 
> From the "it makes sense to me" I'm deriving an Acked-by you, ok?

ok, yes

Acked-by: Jiri Olsa <jolsa@redhat.com>

jirka

> 
> - Arnaldo
>  
> > jirka
> > 
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
> > > v1 -> v2:
> > > - Use setvbuf(), instead of sprinkling fflush() calls and missing some places.
> > > 
> > > v1: https://lore.kernel.org/linux-perf-users/20211112215313.108823-1-sohaib.amhmd@gmail.com/
> > > ---
> > >  tools/perf/builtin-bench.c      | 5 +++--
> > >  tools/perf/tests/builtin-test.c | 3 +++
> > >  2 files changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> > > index d0895162c2ba..d291f3a8af5f 100644
> > > --- a/tools/perf/builtin-bench.c
> > > +++ b/tools/perf/builtin-bench.c
> > > @@ -226,7 +226,6 @@ static void run_collection(struct collection *coll)
> > >  		if (!bench->fn)
> > >  			break;
> > >  		printf("# Running %s/%s benchmark...\n", coll->name, bench->name);
> > > -		fflush(stdout);
> > > 
> > >  		argv[1] = bench->name;
> > >  		run_bench(coll->name, bench->name, bench->fn, 1, argv);
> > > @@ -247,6 +246,9 @@ int cmd_bench(int argc, const char **argv)
> > >  	struct collection *coll;
> > >  	int ret = 0;
> > > 
> > > +	/* Unbuffered output */
> > > +	setvbuf(stdout, NULL, _IONBF, 0);
> > > +
> > >  	if (argc < 2) {
> > >  		/* No collection specified. */
> > >  		print_usage();
> > > @@ -300,7 +302,6 @@ int cmd_bench(int argc, const char **argv)
> > > 
> > >  			if (bench_format == BENCH_FORMAT_DEFAULT)
> > >  				printf("# Running '%s/%s' benchmark:\n", coll->name, bench->name);
> > > -			fflush(stdout);
> > >  			ret = run_bench(coll->name, bench->name, bench->fn, argc-1, argv+1);
> > >  			goto end;
> > >  		}
> > > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > > index 8cb5a1c3489e..d92ae4efd2e6 100644
> > > --- a/tools/perf/tests/builtin-test.c
> > > +++ b/tools/perf/tests/builtin-test.c
> > > @@ -606,6 +606,9 @@ int cmd_test(int argc, const char **argv)
> > >          if (ret < 0)
> > >                  return ret;
> > > 
> > > +	/* Unbuffered output */
> > > +	setvbuf(stdout, NULL, _IONBF, 0);
> > > +
> > >  	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
> > >  	if (argc >= 1 && !strcmp(argv[0], "list"))
> > >  		return perf_test__list(argc - 1, argv + 1);
> > > --
> > > 2.25.1
> > > 
> 
> -- 
> 
> - Arnaldo
> 

