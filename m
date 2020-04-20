From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 46/60] perf parser: Add support to specify rXXX event with pmu
Date: Mon, 20 Apr 2020 08:53:02 -0300
Message-ID: <20200420115316.18781-47-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sumanth Korikkar <sumanthk@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

The current rXXXX event specification creates event under PERF_TYPE_RAW
pmu type. This change allows to use rXXXX within pmu syntax, so it's
type is used via the following syntax:

  -e 'cpu/r3c/'
  -e 'cpum_cf/r0/'

The XXXX number goes directly to perf_event_attr::config the same way as
in '-e rXXXX' event. The perf_event_attr::type is filled with pmu type.

Committer testing:

So, lets see what goes in perf_event_attr::config for, say, the
'instructions' PERF_TYPE_HARDWARE (0) event, first we should look at how
to encode this event as a PERF_TYPE_RAW event for this specific CPU, an
AMD Ryzen 5:

  # cat /sys/devices/cpu/events/instructions
  event=0xc0
  #

Then try with it _and_ the instruction, just to see that they are close
enough:

  # perf stat -e rc0,instructions sleep 1

   Performance counter stats for 'sleep 1':

             919,794      rc0
             919,898      instructions

         1.000754579 seconds time elapsed

         0.000715000 seconds user
         0.000000000 seconds sys
  #

Now we should try, before this patch, the PMU event encoding:

  # perf stat -e cpu/rc0/ sleep 1
  event syntax error: 'cpu/rc0/'
                           \___ unknown term

  valid terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,percore
  #

Now with this patch, the three ways of specifying the 'instructions' CPU
counter are accepted:

  # perf stat -e cpu/rc0/,rc0,instructions sleep 1

   Performance counter stats for 'sleep 1':

             892,948      cpu/rc0/
             893,052      rc0
             893,156      instructions

         1.000931819 seconds time elapsed

         0.000916000 seconds user
         0.000000000 seconds sys

  #

Requested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200416221405.437788-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt |  5 +++++
 tools/perf/tests/parse-events.c        | 17 ++++++++++++++++-
 tools/perf/util/parse-events.l         |  1 +
 tools/perf/util/parse-events.y         |  9 +++++++++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index cb23667531ab..376a50b3452d 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -115,6 +115,11 @@ raw encoding of 0x1A8 can be used:
  perf stat -e r1a8 -a sleep 1
  perf record -e r1a8 ...
 
+It's also possible to use pmu syntax:
+
+ perf record -e r1a8 -a sleep 1
+ perf record -e cpu/r1a8/ ...
+
 You should refer to the processor specific documentation for getting these
 details. Some of them are referenced in the SEE ALSO section below.
 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 091c3aeccc27..902bd9d591a0 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1356,6 +1356,16 @@ static int test__checkevent_complex_name(struct evlist *evlist)
 	return 0;
 }
 
+static int test__checkevent_raw_pmu(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
+	return 0;
+}
+
 static int test__sym_event_slash(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
@@ -1750,7 +1760,12 @@ static struct evlist_test test__events_pmu[] = {
 		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
 		.check = test__checkevent_complex_name,
 		.id    = 3,
-	}
+	},
+	{
+		.name  = "software/r1a/",
+		.check = test__checkevent_raw_pmu,
+		.id    = 4,
+	},
 };
 
 struct terms_test {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index baa48f28d57d..c589fc42f058 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -286,6 +286,7 @@ no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
 percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
+r{num_raw_hex}		{ return raw(yyscanner); }
 ,			{ return ','; }
 "/"			{ BEGIN(INITIAL); return '/'; }
 {name_minus}		{ return str(yyscanner, PE_NAME); }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 94f8bcd83582..e879eb257874 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -706,6 +706,15 @@ event_term
 }
 
 event_term:
+PE_RAW
+{
+	struct parse_events_term *term;
+
+	ABORT_ON(parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_CONFIG,
+					NULL, $1, false, &@1, NULL));
+	$$ = term;
+}
+|
 PE_NAME '=' PE_NAME
 {
 	struct parse_events_term *term;
-- 
2.21.1
