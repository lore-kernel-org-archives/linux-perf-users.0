From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Test 6 dumps core on s390
Date: Fri,  8 Jun 2018 15:17:28 +0200
Message-ID: <20180608131728.75084-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Perf test case 6 "Parse event definition strings"
dumps core when executed on s390.
Root case is a NULL pointer supplied in function

 test_event()
 +---> parse_events()

The third parameter is set to NULL:
(gdb) where
 #0  parse_events (evlist=0x149dc90, str=0x133242a "intel_pt//u", err=0x0)
	at util/parse-events.c:1835
 #1  0x00000000010d3d1c in test_event (e=0x14330e0 <test.events+1272>)
	at tests/parse-events.c:1696
 #2  0x00000000010d3e88 in test_events (events=0x1432be8 <test.events>, cnt=54)
	at tests/parse-events.c:1718
 #3  0x00000000010d44c0 in test__parse_events (test=0x142b500
		 <generic_tests+280>, subtest=-1) at tests/parse-events.c:1838

Function parse_events(xx, xx, struct parse_events_error *err) dives
into a bison generated scanner and creates
parser state information for it first:

   struct parse_events_state parse_state = {
      .list   = LIST_HEAD_INIT(parse_state.list),
      .idx    = evlist->nr_entries,
      .error  = err,   <--- NULL POINTER !!!
      .evlist = evlist,
   };

Now various functions inside the bison scanner are called to end up in
__parse_events_add_pmu(struct parse_events_state *parse_state, ..) with
first parameter being a pointer to above structure definition.

Now the event name is not found (because being executed on s390) and
this function tries to create an error message with

   asprintf(&parse_state->error.str, ....)

which references above NULL pointer and dumps core.

Fix this by providing a pointer to the necessary error information
instead of NULL.
Please note that the test still fails on non x86 platforms but for
different and valid reason.

Output with this fix:
[root@s35lp76 perf]# ./perf test -vvvvv -F 6
6: Parse event definition strings                        :
 --- start ---
running test 0 'syscalls:sys_enter_openat'
Using CPUID IBM,3906,703,M03,3.5,002f
running test 1 'syscalls:*'
running test 2 'r1a'
running test 3 '1:1'
running test 4 'instructions'
...
running test 51 'L1-dcache-misses/name=cachepmu/'
running test 52 'intel_pt//u'
failed to parse event 'intel_pt//u', err 1
omitting PMU cpu tests
omitting PMU cpu tests
running test 0 'config=10,config1,config2=3,umask=1'
 ---- end ----
Parse event definition strings: FAILED!

Fixes: b3f58c8da64b ("perf tests parse-events: Add intel_pt parse test")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/tests/parse-events.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index b9ebe15afb13..f1012d7aea7a 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1686,6 +1686,7 @@ static struct terms_test test__terms[] = {
 
 static int test_event(struct evlist_test *e)
 {
+	struct parse_events_error errinfo;
 	struct perf_evlist *evlist;
 	int ret;
 
@@ -1693,7 +1694,7 @@ static int test_event(struct evlist_test *e)
 	if (evlist == NULL)
 		return -ENOMEM;
 
-	ret = parse_events(evlist, e->name, NULL);
+	ret = parse_events(evlist, e->name, &errinfo);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d\n",
 			 e->name, ret);
-- 
2.14.3
