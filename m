Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D77C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 14:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2F361B4C
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 14:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhKQPAb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:00:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230376AbhKQPAb (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Nov 2021 10:00:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 211EC61B1E;
        Wed, 17 Nov 2021 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637161052;
        bh=HktchAsyHIdoZdrHkEAvVXEdpnzu5xzjV5j19JFCzes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LMt7AwVAUCGADPBPzusyAqFmHpLz12BeUn/wDOdvRLncxx14zibCWlrgCXIThddYA
         0VJUzhtokj6YRES/xZUSLv7UgQvdiAJ2M8CoTqE1aLxKzF/Q9+xrcK7Qnltn6WzxDy
         yygznJviBHffoUvzjrKqn484KXTjiX09HndxfxO3Ir78oSzHLe+xGSnIH3s1cxpVBs
         sqXLj765x/7FOT9J5zH2YlZuYDY3Ei+kqZK+a5QECq6ialqGGoh2upt230CBc9v9Ge
         haY493ajBhgqdgLAYAYSwObF5Dx0r+ow8eZG4Ij2Ln3rCPw5vxdhkJGWiy05roO+N4
         rfijEDhmFk/Lg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D3B524088E; Wed, 17 Nov 2021 11:57:28 -0300 (-03)
Date:   Wed, 17 Nov 2021 11:57:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/3] libperf: Move perf_counts_values__scale to
 tools/lib/perf
Message-ID: <YZUYWAiI6HIWPhYj@kernel.org>
References: <20211109085831.3770594-1-nakamura.shun@fujitsu.com>
 <20211109085831.3770594-2-nakamura.shun@fujitsu.com>
 <YZE3Ia3UpHPx2/gh@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZE3Ia3UpHPx2/gh@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Nov 14, 2021 at 05:19:45PM +0100, Jiri Olsa escreveu:
> On Tue, Nov 09, 2021 at 05:58:29PM +0900, Shunsuke Nakamura wrote:
> > Move perf_counts_values__scale from tools/perf/util to tools/lib/perf
> > so that it can be used with libperf.
> > 
> > Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> > ---
> >  tools/lib/perf/evsel.c              | 19 +++++++++++++++++++
> >  tools/lib/perf/include/perf/evsel.h |  4 ++++
> >  tools/lib/perf/libperf.map          |  1 +
> >  tools/perf/util/evsel.c             | 19 -------------------
> >  tools/perf/util/evsel.h             |  3 ---
> >  5 files changed, 24 insertions(+), 22 deletions(-)
> > 
> > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > index 8441e3e1aaac..5097aadea37a 100644
> > --- a/tools/lib/perf/evsel.c
> > +++ b/tools/lib/perf/evsel.c
> > @@ -431,3 +431,22 @@ void perf_evsel__free_id(struct perf_evsel *evsel)
> >  	zfree(&evsel->id);
> >  	evsel->ids = 0;
> >  }
> > +
> > +void perf_counts_values__scale(struct perf_counts_values *count,
> > +			       bool scale, s8 *pscaled)
> > +{
> > +	s8 scaled = 0;
> > +
> > +	if (scale) {
> > +		if (count->run == 0) {
> > +			scaled = -1;
> > +			count->val = 0;
> > +		} else if (count->run < count->ena) {
> > +			scaled = 1;
> > +			count->val = (u64)((double)count->val * count->ena / count->run);
> > +		}
> > +	}
> > +
> > +	if (pscaled)
> > +		*pscaled = scaled;
> > +}
> > diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> > index 60eae25076d3..9013d73af22d 100644
> > --- a/tools/lib/perf/include/perf/evsel.h
> > +++ b/tools/lib/perf/include/perf/evsel.h
> > @@ -4,6 +4,8 @@
> >  
> >  #include <stdint.h>
> >  #include <perf/core.h>
> > +#include <stdbool.h>
> > +#include <linux/types.h>
> >  
> >  struct perf_evsel;
> >  struct perf_event_attr;
> > @@ -39,5 +41,7 @@ LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu);
> >  LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
> >  LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
> >  LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
> > +LIBPERF_API void perf_counts_values__scale(struct perf_counts_values *count,
> > +					   bool scale, s8 *pscaled);
> 
> not sure if we should use __s8 for pscaled now when it's exported?
> it's just we use it everywhere else with '__' prefix, I forgot what's
> the difference actually ;-)

I'm moving this to be __s8, following what is being used in
tools/lib/bpf/bpf.h.
 
> but other that all looks good, for the patchset:
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
> 
> 
> >  
> >  #endif /* __LIBPERF_EVSEL_H */
> > diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> > index 71468606e8a7..5979bf92d98f 100644
> > --- a/tools/lib/perf/libperf.map
> > +++ b/tools/lib/perf/libperf.map
> > @@ -50,6 +50,7 @@ LIBPERF_0.0.1 {
> >  		perf_mmap__read_init;
> >  		perf_mmap__read_done;
> >  		perf_mmap__read_event;
> > +		perf_counts_values__scale;
> >  	local:
> >  		*;
> >  };
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index dbfeceb2546c..49e4d0bdd7cc 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1457,25 +1457,6 @@ void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
> >  	count->run = count->run - tmp.run;
> >  }
> >  
> > -void perf_counts_values__scale(struct perf_counts_values *count,
> > -			       bool scale, s8 *pscaled)
> > -{
> > -	s8 scaled = 0;
> > -
> > -	if (scale) {
> > -		if (count->run == 0) {
> > -			scaled = -1;
> > -			count->val = 0;
> > -		} else if (count->run < count->ena) {
> > -			scaled = 1;
> > -			count->val = (u64)((double) count->val * count->ena / count->run);
> > -		}
> > -	}
> > -
> > -	if (pscaled)
> > -		*pscaled = scaled;
> > -}
> > -
> >  static int evsel__read_one(struct evsel *evsel, int cpu, int thread)
> >  {
> >  	struct perf_counts_values *count = perf_counts(evsel->counts, cpu, thread);
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 1f7edfa8568a..8a6a4182c5fd 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -190,9 +190,6 @@ static inline int evsel__nr_cpus(struct evsel *evsel)
> >  	return evsel__cpus(evsel)->nr;
> >  }
> >  
> > -void perf_counts_values__scale(struct perf_counts_values *count,
> > -			       bool scale, s8 *pscaled);
> > -
> >  void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
> >  			   struct perf_counts_values *count);
> >  
> > -- 
> > 2.27.0
> > 

-- 

- Arnaldo
