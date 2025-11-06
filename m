Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8EF2BE03E;
	Thu,  6 Nov 2025 06:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762409001; cv=none; b=TDFzuKCpxnVgSPxaqTgfhJ2Uo+L72q0/65TW3ckKBr2yjfTs1zl6HCpu7rCdtw3nqS9ExS+uiWBkK2085vYSjHYsohUHSRmkRJ8X0J+sscfnJwMB9ylzqPI1v+9Xsr6SX5k9oSWeJO2UetnoGJh/XNmjjoXt1ojScQpRDH5IU3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762409001; c=relaxed/simple;
	bh=wf6dbf59RvL8cRrubFJD2UL2fLyYX4BL9MrVrSZpUd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6DLPGMgjbSx96d4Pr09CEEknFWyZVcy7G3LrZrnYVyKBbCendnFbHclzmQfKs7oigWahsUHQECDIZrb19qxxrHh7IkhniWTjf3YdsU5Wcpw26Vyh07UtB7SZUrjx7b8YPu3+CKsl6DHvMByPHmXwD304o5RbvypYpan5gubGBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ept7tZwu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ept7tZwu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06DCC4CEF7;
	Thu,  6 Nov 2025 06:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762409000;
	bh=wf6dbf59RvL8cRrubFJD2UL2fLyYX4BL9MrVrSZpUd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ept7tZwuFYEniBbZ8GYtbfTKKO4SZgJnuNqfjetRzDcjIj6LfnhLeDZaDSwoizG1e
	 1yB3wJnY+31OBGMpXu8ChMXEnIcVipDggSlmL7TsTlfvv0rCcAabRrSMzZ0j6OCVGj
	 HuKQfNF3juB95LPYqMhQ40ktIDdG/Wpfs3Yk/PSpJbS2lgeWIkcihaIOnYeOxytPc8
	 cZpVy+1eavKsddDciWDJinrfBufvXrURZIS8R7ouWYr0pj3+PoafJLAsj61SuRHZ8X
	 lSPfpc/NoJBQjSqzd92GXtjzv46h+rHCrQyr7VY5YKkW9qg/1a9wgzZkhtrFbcO4bJ
	 QdPmuOjCFAObQ==
Date: Wed, 5 Nov 2025 22:03:18 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Levi Yun <yeoreum.yun@arm.com>,
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 05/22] perf metricgroup: Add care to picking the evsel
 for displaying a metric
Message-ID: <aQw6Jje7bSpywGqq@google.com>
References: <20251024175857.808401-1-irogers@google.com>
 <20251024175857.808401-6-irogers@google.com>
 <aQmGfLVKk0UFGAyd@google.com>
 <CAP-5=fXmT-1io1k1O5d2QMken9aJmGTiuDEz2f-7k8-n=GCWtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXmT-1io1k1O5d2QMken9aJmGTiuDEz2f-7k8-n=GCWtA@mail.gmail.com>

On Mon, Nov 03, 2025 at 09:28:44PM -0800, Ian Rogers wrote:
> On Mon, Nov 3, 2025 at 8:52 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Oct 24, 2025 at 10:58:40AM -0700, Ian Rogers wrote:
> > > Rather than using the first evsel in the matched events, try to find
> > > the least shared non-tool evsel. The aim is to pick the first evsel
> > > that typifies the metric within the list of metrics.
> > >
> > > This addresses an issue where Default metric group metrics may lose
> > > their counter value due to how the stat displaying hides counters for
> > > default event/metric output.
> >
> > Do you have a command line example to show impact of this change?
> 
> You can just run a Topdown metricgroup on Intel to see differences,

Ok, before this change.

  $ perf stat -M topdownL1 true
  
   Performance counter stats for 'true':
  
           7,754,275      TOPDOWN.SLOTS                    #     37.1 %  tma_backend_bound      
                                                    #     38.7 %  tma_frontend_bound     
                                                    #      8.8 %  tma_bad_speculation    
                                                    #     15.3 %  tma_retiring           
           1,185,947      topdown-retiring                                                      
           3,010,483      topdown-fe-bound                                                      
           2,828,029      topdown-be-bound                                                      
             729,814      topdown-bad-spec                                                      
               9,987      INT_MISC.CLEARS_COUNT                                                 
             221,405      IDQ.MS_UOPS                                                           
               6,352      INT_MISC.UOP_DROPPING                                                 
           1,212,644      UOPS_RETIRED.SLOTS                                                    
             119,895      UOPS_DECODED.DEC0                                                     
              60,975      cpu/UOPS_DECODED.DEC0,cmask=1/                                        
           1,639,442      UOPS_ISSUED.ANY                                                       
             820,982      IDQ.MITE_UOPS                                                         
  
         0.001172956 seconds time elapsed
  
         0.001269000 seconds user
         0.000000000 seconds sys


And with this change, it does look better.

  $ perf stat -M topdownL1 true
  
   Performance counter stats for 'true':
  
           7,977,430      TOPDOWN.SLOTS                                                         
           1,188,793      topdown-retiring                                                      
           3,159,687      topdown-fe-bound                                                      
           2,940,699      topdown-be-bound                                                      
             688,248      topdown-bad-spec                                                      
               9,749      INT_MISC.CLEARS_COUNT            #     37.5 %  tma_backend_bound      
                                                    #      8.1 %  tma_bad_speculation    
             219,145      IDQ.MS_UOPS                      #     14.9 %  tma_retiring           
               6,188      INT_MISC.UOP_DROPPING            #     39.5 %  tma_frontend_bound     
           1,205,712      UOPS_RETIRED.SLOTS                                                    
             117,505      UOPS_DECODED.DEC0                                                     
              59,891      cpu/UOPS_DECODED.DEC0,cmask=1/                                        
           1,625,232      UOPS_ISSUED.ANY                                                       
             805,560      IDQ.MITE_UOPS                                                         
  
         0.001629344 seconds time elapsed
  
         0.001672000 seconds user
         0.000000000 seconds sys

> but they are minor. The main impact is on the Default legacy metrics
> as those have a counter then a metric, but without this change you get
> everything grouped on the cpu-clock event and the formatting gets broken.

Do you mean with other changes in this series?  I don't see any
differences in the output just after this patch..

Before:

  $ perf stat -a true
  
   Performance counter stats for 'system wide':
  
          19,078,719      cpu-clock                        #    7.256 CPUs utilized             
                  94      context-switches                 #    4.927 K/sec                     
                  14      cpu-migrations                   #  733.802 /sec                      
                  61      page-faults                      #    3.197 K/sec                     
          43,304,957      instructions                     #    1.10  insn per cycle            
          39,281,107      cycles                           #    2.059 GHz                       
           5,012,071      branches                         #  262.705 M/sec                     
             128,358      branch-misses                    #    2.56% of all branches           
   #     24.4 %  tma_retiring           
   #     33.7 %  tma_backend_bound      
                                                    #      5.9 %  tma_bad_speculation    
   #     36.0 %  tma_frontend_bound     
  
         0.002629534 seconds time elapsed
  
After:
  
  $ perf stat -a true
  
   Performance counter stats for 'system wide':
  
           6,201,661      cpu-clock                        #    3.692 CPUs utilized             
                  24      context-switches                 #    3.870 K/sec                     
                   7      cpu-migrations                   #    1.129 K/sec                     
                  60      page-faults                      #    9.675 K/sec                     
          11,458,681      instructions                     #    1.07  insn per cycle            
          10,704,978      cycles                           #    1.726 GHz                       
           2,457,704      branches                         #  396.298 M/sec                     
              54,553      branch-misses                    #    2.22% of all branches           
   #     21.4 %  tma_retiring           
   #     36.1 %  tma_backend_bound      
                                                    #     10.2 %  tma_bad_speculation    
   #     32.3 %  tma_frontend_bound     
  
         0.001679679 seconds time elapsed
  
Thanks,
Namhyung


> As --metric-only is popular when looking at a group of events
> and the Default legacy metrics are added in subsequent changes it
> didn't seem right to include the output (it either shows broken things
> keeping to be somewhat broken or output from later patches).
> 
> Thanks,
> Ian
> 
> > Thanks,
> > Namhyung
> >
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/metricgroup.c | 48 ++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 47 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > > index 48936e517803..76092ee26761 100644
> > > --- a/tools/perf/util/metricgroup.c
> > > +++ b/tools/perf/util/metricgroup.c
> > > @@ -1323,6 +1323,51 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
> > >       return ret;
> > >  }
> > >
> > > +/* How many times will a given evsel be used in a set of metrics? */
> > > +static int count_uses(struct list_head *metric_list, struct evsel *evsel)
> > > +{
> > > +     const char *metric_id = evsel__metric_id(evsel);
> > > +     struct metric *m;
> > > +     int uses = 0;
> > > +
> > > +     list_for_each_entry(m, metric_list, nd) {
> > > +             if (hashmap__find(m->pctx->ids, metric_id, NULL))
> > > +                     uses++;
> > > +     }
> > > +     return uses;
> > > +}
> > > +
> > > +/*
> > > + * Select the evsel that stat-display will use to trigger shadow/metric
> > > + * printing. Pick the least shared non-tool evsel, encouraging metrics to be
> > > + * with a hardware counter that is specific to them.
> > > + */
> > > +static struct evsel *pick_display_evsel(struct list_head *metric_list,
> > > +                                     struct evsel **metric_events)
> > > +{
> > > +     struct evsel *selected = metric_events[0];
> > > +     size_t selected_uses;
> > > +     bool selected_is_tool;
> > > +
> > > +     if (!selected)
> > > +             return NULL;
> > > +
> > > +     selected_uses = count_uses(metric_list, selected);
> > > +     selected_is_tool = evsel__is_tool(selected);
> > > +     for (int i = 1; metric_events[i]; i++) {
> > > +             struct evsel *candidate = metric_events[i];
> > > +             size_t candidate_uses = count_uses(metric_list, candidate);
> > > +
> > > +             if ((selected_is_tool && !evsel__is_tool(candidate)) ||
> > > +                 (candidate_uses < selected_uses)) {
> > > +                     selected = candidate;
> > > +                     selected_uses = candidate_uses;
> > > +                     selected_is_tool = evsel__is_tool(selected);
> > > +             }
> > > +     }
> > > +     return selected;
> > > +}
> > > +
> > >  static int parse_groups(struct evlist *perf_evlist,
> > >                       const char *pmu, const char *str,
> > >                       bool metric_no_group,
> > > @@ -1430,7 +1475,8 @@ static int parse_groups(struct evlist *perf_evlist,
> > >                       goto out;
> > >               }
> > >
> > > -             me = metricgroup__lookup(&perf_evlist->metric_events, metric_events[0],
> > > +             me = metricgroup__lookup(&perf_evlist->metric_events,
> > > +                                      pick_display_evsel(&metric_list, metric_events),
> > >                                        /*create=*/true);
> > >
> > >               expr = malloc(sizeof(struct metric_expr));
> > > --
> > > 2.51.1.821.gb6fe4d2222-goog
> > >
