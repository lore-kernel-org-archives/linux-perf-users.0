From: David Ahern <daahern@cisco.com>
Subject: [PATCH 4/4] perf stat: treat realtime-clock as nsec counter
Date: Mon, 21 Feb 2011 14:02:30 -0700
Message-ID: <1298322150-15505-5-git-send-email-daahern@cisco.com>
References: <1298322150-15505-1-git-send-email-daahern@cisco.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-2.cisco.com ([171.71.176.71]:55507 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126Ab1BUVCj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Feb 2011 16:02:39 -0500
In-Reply-To: <1298322150-15505-1-git-send-email-daahern@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de, David Ahern <daahern@cisco.com>

Based on patch from Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: David Ahern <daahern@cisco.com>
---
 tools/perf/builtin-stat.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 21c0252..35d45b4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -184,8 +184,9 @@ static int create_perf_stat_counter(struct perf_evsel *evsel)
  */
 static inline int nsec_counter(struct perf_evsel *evsel)
 {
-	if (perf_evsel__match(evsel, SOFTWARE, SW_CPU_CLOCK) ||
-	    perf_evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK))
+	if (perf_evsel__match(evsel, SOFTWARE, SW_CPU_CLOCK)  ||
+	    perf_evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK) ||
+	    perf_evsel__match(evsel, SOFTWARE, SW_REALTIME_CLOCK))
 		return 1;
 
 	return 0;
-- 
1.7.3.4
