From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/19] perf test: Make 'list' use same filtering code as main 'perf test'
Date: Mon, 14 Aug 2017 13:27:31 -0300
Message-ID: <20170814162741.6101-10-acme@kernel.org>
References: <20170814162741.6101-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814162741.6101-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
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
  # perf test list Synth
  #

After:

  # perf test Synth
  39: Synthesize thread map  : Ok
  41: Synthesize cpu map     : Ok
  42: Synthesize stat config : Ok
  43: Synthesize stat        : Ok
  44: Synthesize stat round  : Ok
  45: Synthesize attr update : Ok
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
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-v95tqqzuwawsmds3zn2mosje@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 2bd158e3c02f..9ecc44e68990 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -609,15 +609,16 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
 		return -1;
 
 	for_each_shell_test(dir, ent) {
+		int curr = i++;
 		char bf[256];
-		const char *desc = shell_test__description(bf, sizeof(bf), path, ent->d_name);
-
-		++i;
+		struct test t = {
+			.desc = shell_test__description(bf, sizeof(bf), path, ent->d_name),
+		};
 
-		if (argc > 1 && !strstr(desc, argv[1]))
+		if (!perf_test__matches(&t, curr, argc, argv))
 			continue;
 
-		pr_info("%2d: %s\n", i, desc);
+		pr_info("%2d: %s\n", i, t.desc);
 	}
 
 	closedir(dir);
@@ -631,9 +632,10 @@ static int perf_test__list(int argc, const char **argv)
 	int i = 0;
 
 	for_each_test(j, t) {
-		++i;
+		int curr = i++;
 
-		if (argc > 1 && !strstr(t->desc, argv[1]))
+		if (!perf_test__matches(t, curr, argc, argv) ||
+		    (t->is_supported && !t->is_supported()))
 			continue;
 
 		pr_info("%2d: %s\n", i, t->desc);
@@ -668,7 +670,7 @@ int cmd_test(int argc, const char **argv)
 
 	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
 	if (argc >= 1 && !strcmp(argv[0], "list"))
-		return perf_test__list(argc, argv);
+		return perf_test__list(argc - 1, argv + 1);
 
 	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.sort_by_name = true;
-- 
2.13.4
