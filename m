Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA21AC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 18:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD09E60FF2
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 18:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhJHSzi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 14:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239603AbhJHSzb (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 14:55:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A62360F93;
        Fri,  8 Oct 2021 18:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633719215;
        bh=gCDIyOLC55BdB0VojmsOaz6jn9SjfK7KSJKg2L3pwYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EaYWxKQY872FgAXTtAjaQYw567AO1H0lQIY/SrQ5HKkjCc2ed/UEEBt6ow9vXLDMc
         W0xuuYdzzktw9e4Xs5nSQ/KdZjVoFHmfSqETXlRASNVuplLDQ6QktkCukieYicuJql
         bTzyZebirMDkq7aoWkb6RqEUOQvIuot1AV+vao2zQ3JAye1uJWTLFlC1ZV2eWz5Ygo
         oAirGlbyDdImGrldHM9qU46XU2kDWc2P3USJzHzG8ozPl/SbfzpbKTHYSsasnN7vAV
         vO2jyoIvbJxNN4u6zRuJilLUprAJ6Ro9aHLRi4/c4fAQfmcwvUEZVLw/Poh9T01Cmj
         EZ9LfWXY7ZBhA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6BBF5410A1; Fri,  8 Oct 2021 15:53:33 -0300 (-03)
Date:   Fri, 8 Oct 2021 15:53:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] libperf tests: Fix test_stat_cpu
Message-ID: <YWCTrY/5zQLJm6kd@kernel.org>
References: <20211006094817.477494-1-nakamura.shun@fujitsu.com>
 <YV8o9nukzBTkWmlw@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YV8o9nukzBTkWmlw@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Oct 07, 2021 at 07:05:58PM +0200, Jiri Olsa escreveu:
> On Wed, Oct 06, 2021 at 06:48:17PM +0900, Shunsuke Nakamura wrote:
> > `cpu` of perf_evsel__read() must be specified the cpu index.
> > perf_cpu_map__for_each_cpu is for iterating the cpu number (not index)
> > and is not appropriate.
> > So, if there is an offline CPU, the cpu number specified in the argument
> > may point out of range because the cpu number and the cpu index are
> > different.
> 
> nice catch

Indeed, Nakamura-san, please address Jiri's comment and resubmit,

Thanks,

- Arnaldo
 
> > 
> > Fix test_stat_cpu.
> > 
> > Committer testing:
> > 
> >   # make tests -C tools/lib/perf/
> >   make: Entering directory '/home/nakamura/kernel_src/linux-5.15-rc4_fix/tools/lib/perf'
> >   running static:
> >   - running tests/test-cpumap.c...OK
> >   - running tests/test-threadmap.c...OK
> >   - running tests/test-evlist.c...OK
> >   - running tests/test-evsel.c...OK
> >   running dynamic:
> >   - running tests/test-cpumap.c...OK
> >   - running tests/test-threadmap.c...OK
> >   - running tests/test-evlist.c...OK
> >   - running tests/test-evsel.c...OK
> >   make: Leaving directory '/home/nakamura/kernel_src/linux-5.15-rc4_fix/tools/lib/perf'
> > 
> > 
> > Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> > ---
> > Previous version at:
> > https://lore.kernel.org/lkml/20211006080456.474273-1-nakamura.shun@fujitsu.com/
> > 
> > Changes in v2:
> >  - Remove "2/2" from Patch Subject
> > 
> >  tools/lib/perf/tests/test-evlist.c | 6 +++---
> >  tools/lib/perf/tests/test-evsel.c  | 6 +++---
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
> > index c67c83399170..47badd7eabf2 100644
> > --- a/tools/lib/perf/tests/test-evlist.c
> > +++ b/tools/lib/perf/tests/test-evlist.c
> > @@ -40,7 +40,7 @@ static int test_stat_cpu(void)
> >  		.type	= PERF_TYPE_SOFTWARE,
> >  		.config	= PERF_COUNT_SW_TASK_CLOCK,
> >  	};
> > -	int err, cpu, tmp;
> > +	int err, idx;
> >  
> >  	cpus = perf_cpu_map__new(NULL);
> >  	__T("failed to create cpus", cpus);
> > @@ -70,10 +70,10 @@ static int test_stat_cpu(void)
> >  	perf_evlist__for_each_evsel(evlist, evsel) {
> >  		cpus = perf_evsel__cpus(evsel);
> >  
> > -		perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
> > +		for (idx = 0, idx < perf_cpu_map__nr(cpus); idx++) {
> 
> s/,/;/                      ^
> 
> tests/test-evlist.c: In function ‘test_stat_cpu’:
> tests/test-evlist.c:73:52: error: expected ‘;’ before ‘)’ token
>    73 |   for (idx = 0, idx < perf_cpu_map__nr(cpus); idx++) {
>       |                                                    ^
>       |                                                    ;
> 
> 
> perf_cpu_map__for_each_cpu also returns the cpu index (tmp),
> maybe we could use that instead?
> 
> thanks,
> jirka
> 
> >  			struct perf_counts_values counts = { .val = 0 };
> >  
> > -			perf_evsel__read(evsel, cpu, 0, &counts);
> > +			perf_evsel__read(evsel, idx, 0, &counts);
> >  			__T("failed to read value for evsel", counts.val != 0);
> >  		}
> >  	}
> > diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
> > index 9abd4c0bf6db..33ae9334861a 100644
> > --- a/tools/lib/perf/tests/test-evsel.c
> > +++ b/tools/lib/perf/tests/test-evsel.c
> > @@ -22,7 +22,7 @@ static int test_stat_cpu(void)
> >  		.type	= PERF_TYPE_SOFTWARE,
> >  		.config	= PERF_COUNT_SW_CPU_CLOCK,
> >  	};
> > -	int err, cpu, tmp;
> > +	int err, idx;
> >  
> >  	cpus = perf_cpu_map__new(NULL);
> >  	__T("failed to create cpus", cpus);
> > @@ -33,10 +33,10 @@ static int test_stat_cpu(void)
> >  	err = perf_evsel__open(evsel, cpus, NULL);
> >  	__T("failed to open evsel", err == 0);
> >  
> > -	perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
> > +	for (idx = 0; idx < perf_cpu_map__nr(cpus); idx++) {
> >  		struct perf_counts_values counts = { .val = 0 };
> >  
> > -		perf_evsel__read(evsel, cpu, 0, &counts);
> > +		perf_evsel__read(evsel, idx, 0, &counts);
> >  		__T("failed to read value for evsel", counts.val != 0);
> >  	}
> >  
> > -- 
> > 2.25.1
> > 

-- 

- Arnaldo
