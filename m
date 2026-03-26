Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E5D3FFAA8;
	Thu, 26 Mar 2026 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543171; cv=none; b=VfHIUScDZSWO4LEDoGJjU3SvAfm5F9+WbBYU1NTWrY4aJHVY+rLY8h++ttlOl0kLEs5EU9T2VScXFAGdgS8gTT0SwX5JyagL6AP+ebKU4jutEQj/yFYCL7Nc5tW8ZaFUy1fXeD38cHXyF3DL2EfYxeOURgTGRB8K01pGyvCd8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543171; c=relaxed/simple;
	bh=4N4MkMJOO4e1DvpIc4taU17tnv9S+seEJ9mmcITOIj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaomJphURRJVHA8/9En5s1HAeKGEMXk+7H//TJ93GoxHwovDjkXyy338BKphpgo5BxJ3rzHO/tUFj0ZMuIB19iC73M+xCSpgO0/Ga4TEIOBwq6KVR+w3VEclCWnaevbkyzQ8VYY2/kQ17lhq0BpQeg+4Cqn8/jODSIQu7QA9K6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=j3NWEASd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="j3NWEASd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDE942BC0;
	Thu, 26 Mar 2026 09:39:22 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4816C3F905;
	Thu, 26 Mar 2026 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774543168; bh=4N4MkMJOO4e1DvpIc4taU17tnv9S+seEJ9mmcITOIj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3NWEASdLKUKKwpfFvCNRQ6zhHNY6FJbMbJpZGaf2Zq2j8zyoXQap5zRO4zNRJzTk
	 jG+ya/sctdMrLPh7al0jJ1gCv8bmkoz/f5EOp1ayXvvNQVreJ3pAdC+mtWNtW4YKtU
	 K8HBYEhdmdQ2nkkhLYqz7QkBlHdfQmYX8114MQ9c=
Date: Thu, 26 Mar 2026 16:39:26 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: Re: [PATCH v2] perf stat: Fix crash on arm64
Message-ID: <20260326163926.GB356832@e132581.arm.com>
References: <20260325-perf_stat-v2-1-d986ef5b9327@debian.org>
 <20260325205914.GA356832@e132581.arm.com>
 <CAP-5=fWkbhffgL6BJjpiwRV6rD3yd=KkOz7-ODH2FnORBf70bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWkbhffgL6BJjpiwRV6rD3yd=KkOz7-ODH2FnORBf70bQ@mail.gmail.com>

On Wed, Mar 25, 2026 at 03:27:05PM -0700, Ian Rogers wrote:

[...]

> > As Arnaldo mentioned in v1, I also found Segmentation fault when
> > testing this patch:
> >
> >  Program received signal SIGSEGV, Segmentation fault.
> >  metricgroup__copy_metric_events (evlist=0xaaaaab037750, cgrp=0x0, new_metric_events=0xaaaaab038210, old_metric_events=0xaaaaab038d20) at util/metricgroup.c:1662
> >  1662                    evsel = evlist__find_evsel(evlist, old_me->evsel->core.idx);
> >  (gdb) bt
> >  #0  metricgroup__copy_metric_events (evlist=0xaaaaab037750, cgrp=0x0, new_metric_events=0xaaaaab038210, old_metric_events=0xaaaaab038d20) at util/metricgroup.c:1662
> >  #1  0x0000aaaaaab05870 in add_default_events () at builtin-stat.c:2110
> >  #2  0x0000aaaaaab08300 in cmd_stat (argc=0, argv=0xfffffffffaa0) at builtin-stat.c:2838
> >  #3  0x0000aaaaaab40998 in run_builtin (p=0xaaaaaaf9d428 <commands+360>, argc=4, argv=0xfffffffffaa0) at perf.c:348
> >  #4  0x0000aaaaaab40c14 in handle_internal_command (argc=4, argv=0xfffffffffaa0) at perf.c:398
> >  #5  0x0000aaaaaab40ddc in run_argv (argcp=0xfffffffff8bc, argv=0xfffffffff8b0) at perf.c:442
> >  #6  0x0000aaaaaab41110 in main (argc=4, argv=0xfffffffffaa0) at perf.c:549
> >
> > Last week I tested v1 and confirmed the issue was gone with the change,
> > I will dig a bit in tomorrow and share back if any finding.
> >
> > Apologies for my lazy, as I should double check once Arnaldo
> > pointed out in v1.
> 
> 
> From the stack trace I don't see anything that should allow this.
> Either the list of metrics is broken, or the struct metric_event's
> evsel is NULL. But that should never happen as we wouldn't have a
> metric at that point. The sorting shouldn't affect that. If you can
> reproduce the issue, verbose logs may help.

I believe I encountered a different issue, which is irrelevant to this
patch.  So Breno's patch is fine for me.

On one of my board, I can see the log:

  Events in 'frontend_bound' fully contained within 'retiring'
  Events in 'bad_speculation' fully contained within 'retiring'
  Events in 'backend_bound' fully contained within 'retiring'

Then, in parse_groups(), it selects fully contained list:

  list_for_each_entry(n, &metric_list, nd) {
      ...
      if (expr__subset_of_ids(n->pctx, m->pctx)) {
          metric_evlist = n->evlist;
          break;
      }
  }

  // As metric_evlist has been set, so below does not run
  if (!metric_evlist) {
        ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
                        m->group_events, tool_events, &m->evlist);
        if (ret)
                goto out;

        metric_evlist = m->evlist;
  }

The problem is it skips to call parse_ids() and m->pctx is not
initialized.  This leads to pick_display_evsel() returns NULL and
pass NULL pointer to metricgroup__lookup().   In the end, the NULL
pointer is consumed in metricgroup__copy_metric_events().

How about below change ?  I tested it which can dismiss the issue.

Subject: [PATCH] perf metricgroup: Fix segment fault in
 metricgroup__copy_metric_events()

In parse_groups(), when find a event is fully contained by a previous
event, it skips to call parse_ids(), as a result, m->pctx->ids is not
initialized.  Then, setup_metric_events() returns an empty metric
events, pick_display_evsel() consumes the returned metric_events and
feeds to metricgroup__lookup() with passing "evsel = NULL".

metricgroup__copy_metric_events() access old_me->evsel->core.idx, due
to the evsel is set to NULL in metricgroup__lookup(), it causes
segment fault.

This commit corrects the fully contained case to allow it to parse IDs,
thus this can effectively avoid setup NULL pointer in
metricgroup__lookup().

Fixes: 5ecd5a0c7d1c ("perf metrics: Modify setup and deduplication")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/metricgroup.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 7e39d469111b..528a6462876b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1431,7 +1431,7 @@ static int parse_groups(struct evlist *perf_evlist,
 	list_for_each_entry(m, &metric_list, nd) {
 		struct metric_event *me;
 		struct evsel **metric_events;
-		struct evlist *metric_evlist = NULL;
+		struct evlist *metric_evlist = NULL, *contained = NULL;
 		struct metric *n;
 		struct metric_expr *expr;
 
@@ -1463,19 +1463,18 @@ static int parse_groups(struct evlist *perf_evlist,
 				if (expr__subset_of_ids(n->pctx, m->pctx)) {
 					pr_debug("Events in '%s' fully contained within '%s'\n",
 						 m->metric_name, n->metric_name);
-					metric_evlist = n->evlist;
+					contained = n->evlist;
 					break;
 				}
-
 			}
 		}
 		if (!metric_evlist) {
+			metric_evlist = contained ? contained : m->evlist;
+
 			ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
-					m->group_events, tool_events, &m->evlist);
+					m->group_events, tool_events, &metric_evlist);
 			if (ret)
 				goto out;
-
-			metric_evlist = m->evlist;
 		}
 		ret = setup_metric_events(fake_pmu ? "all" : m->pmu, m->pctx->ids,
 					  metric_evlist, &metric_events);
-- 
2.34.1
