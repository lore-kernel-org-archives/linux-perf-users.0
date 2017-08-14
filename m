From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/19] perf test: Make 'list' subcommand match main 'perf test' numbering/matching
Date: Mon, 14 Aug 2017 13:27:28 -0300
Message-ID: <20170814162741.6101-7-acme@kernel.org>
References: <20170814162741.6101-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814162741.6101-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Matt Fleming <matt.fleming@intel.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Before:

  # perf test Synth
  39: Synthesize thread map  : Ok
  41: Synthesize cpu map     : Ok
  42: Synthesize stat config : Ok
  43: Synthesize stat        : Ok
  44: Synthesize stat round  : Ok
  45: Synthesize attr update : Ok
  #
  # perf test list Synth
   1: Synthesize thread map
   2: Synthesize cpu map
   3: Synthesize stat config
   4: Synthesize stat
   5: Synthesize stat round
   6: Synthesize attr update
  #

After:

  # perf test Synth
  39: Synthesize thread map  : Ok
  41: Synthesize cpu map     : Ok
  42: Synthesize stat config : Ok
  43: Synthesize stat        : Ok
  44: Synthesize stat round  : Ok
  45: Synthesize attr update : Ok
  #
  # perf test list Synth
  39: Synthesize thread map
  41: Synthesize cpu map
  42: Synthesize stat config
  43: Synthesize stat
  44: Synthesize stat round
  45: Synthesize attr update
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Matt Fleming <matt.fleming@intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-pjhuhkphs7o3tkbqrukfv6bz@git.kernel.org
Fixes: e8210cefb7e1 ("perf tests: Introduce iterator function for tests")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 3ccfd58a8c3c..436e22993909 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -465,10 +465,12 @@ static int perf_test__list(int argc, const char **argv)
 	int i = 0;
 
 	for_each_test(j, t) {
+		++i;
+
 		if (argc > 1 && !strstr(t->desc, argv[1]))
 			continue;
 
-		pr_info("%2d: %s\n", ++i, t->desc);
+		pr_info("%2d: %s\n", i, t->desc);
 	}
 
 	return 0;
-- 
2.13.4
