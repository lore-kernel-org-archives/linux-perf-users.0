From: Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH] perf tools: Fix cache event name generation
Date: Wed, 5 Sep 2012 19:51:33 +0200
Message-ID: <20120905175133.GA18352@krava.brq.redhat.com>
References: <CAB04Epfe1n0R3HHi217YJzazh4ejWJk2-Ww1r55X0=q__WftwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18353 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754164Ab2IERwI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Sep 2012 13:52:08 -0400
Content-Disposition: inline
In-Reply-To: <CAB04Epfe1n0R3HHi217YJzazh4ejWJk2-Ww1r55X0=q__WftwA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Joel Uckelman <joel@lightboxtechnologies.com>
Cc: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>, Corey Ashford <cjashfor@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>

On Wed, Sep 05, 2012 at 05:21:10PM +0200, Joel Uckelman wrote:
> When I do this with perf 3.5.2,
> 
>   perf stat -x, -e
> L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores,L1-dcache-store-misses
> ls
> 
> I'm seeing this output from perf:
> 
>   697171,L1-dcache-loads
> 
>   28012,L1-dcache-misses
> 
>   455691,L1-dcache-stores
> 
>   11791,L1-dcache-misses
> 
> So, I'm getting two results labeled "L1-dcache-misses" (with different
> values!) and none labeled "L1-dcache-store-misses". It looks to me
> like one of the "L1-dcache-misses" is mislabeled.
> 
> There appears to be a general problem with all of the *-misses
> counters, as a similar thing happens with, e.g., LLC-load-misses and
> LLC-store-missses, and all of the others I've checked.
> 
> Is this a bug, or am I misunderstanding how perf-stat is supposed to work?

bug ;) please try attached patch

thanks,
jirka


---
If the event name is specified with all 3 components, the last one
overwrites the previous one during the name composing within the
parse_events_add_cache function.

Fixing this by properly adjusting the string index.

Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Corey Ashford <cjashfor@linux.vnet.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@redhat.com>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b246303..a031ee1 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -308,7 +308,7 @@ int parse_events_add_cache(struct list_head **list, int *idx,
 	for (i = 0; (i < 2) && (op_result[i]); i++) {
 		char *str = op_result[i];
 
-		snprintf(name + n, MAX_NAME_LEN - n, "-%s\n", str);
+		n += snprintf(name + n, MAX_NAME_LEN - n, "-%s", str);
 
 		if (cache_op == -1) {
 			cache_op = parse_aliases(str, perf_evsel__hw_cache_op,
-- 
1.7.11.4
