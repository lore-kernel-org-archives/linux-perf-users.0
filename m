From: Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 1/2] perf tests: Add event parsing error handling to parse events test
Date: Mon, 11 Jun 2018 11:34:21 +0200
Message-ID: <20180611093422.1005-1-jolsa@kernel.org>
References: <0d25bc25-ed0b-81bb-c516-12fd25442427@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0d25bc25-ed0b-81bb-c516-12fd25442427@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Thomas-Mich Richter <tmricht@linux.ibm.com>, Kim Phillips <kim.phillips@arm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Add missing error handling for parse_events calls in test_event
function that led to following segfault on s390:

  running test 52 'intel_pt//u'
  perf: Segmentation fault
  ...
  /lib64/libc.so.6(vasprintf+0xe6) [0x3fffca3f106]
  /lib64/libc.so.6(asprintf+0x46) [0x3fffca1aa96]
  ./perf(parse_events_add_pmu+0xb8) [0x80132088]
  ./perf(parse_events_parse+0xc62) [0x8019529a]
  ./perf(parse_events+0x98) [0x801341c0]
  ./perf(test__parse_events+0x48) [0x800cd140]
  ./perf(cmd_test+0x26a) [0x800bd44a]
  test child interrupted

Adding the struct parse_events_error argument to parse_events
call. Also adding parse_events_print_error to get more details
on the parsing failures, like:

  # perf test 6 -v
  running test 52 'intel_pt//u'failed to parse event 'intel_pt//u', err 1, str 'Cannot find PMU `intel_pt'. Missing kernel support?'
  event syntax error: 'intel_pt//u'
                       \___ Cannot find PMU `intel_pt'. Missing kernel support?

Link: http://lkml.kernel.org/n/tip-lmrdeivfr0m34t67c6i98p1f@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/parse-events.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 7d4077068454..3b0bfdf5a594 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1686,6 +1686,7 @@ static struct terms_test test__terms[] = {
 
 static int test_event(struct evlist_test *e)
 {
+	struct parse_events_error err = { 0 };
 	struct perf_evlist *evlist;
 	int ret;
 
@@ -1693,10 +1694,11 @@ static int test_event(struct evlist_test *e)
 	if (evlist == NULL)
 		return -ENOMEM;
 
-	ret = parse_events(evlist, e->name, NULL);
+	ret = parse_events(evlist, e->name, &err);
 	if (ret) {
-		pr_debug("failed to parse event '%s', err %d\n",
-			 e->name, ret);
+		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
+			 e->name, ret, err.str);
+		parse_events_print_error(&err, e->name);
 	} else {
 		ret = e->check(evlist);
 	}
-- 
2.13.6
