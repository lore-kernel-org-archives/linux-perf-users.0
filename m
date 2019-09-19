From: Kim Phillips <kim.phillips@amd.com>
Subject: [PATCH 5/5] perf list: specify metrics are to be used with -M
Date: Thu, 19 Sep 2019 15:43:06 -0500
Message-ID: <20190919204306.12598-5-kim.phillips@amd.com>
References: <20190919204306.12598-1-kim.phillips@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190919204306.12598-1-kim.phillips@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: kim.phillips@amd.com, Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Borislav Petkov <bp@suse.de>, Martin Liska <mliska@suse.cz>, Luke Mujica <lukemujica@google.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Output of 'perf list metrics' before:

  $ perf list metrics

  List of pre-defined events (to be used in -e):

  Metrics:

    C2_Pkg_Residency
         [C2 residency percent per package]
  ...

This misleads the uninitiated user to try:

  $ perf stat -e C2_Pkg_Residency

which gets:

  event syntax error: 'C2_Pkg_Residency'
                       \___ parser error
  Run 'perf list' for a list of valid events

Explicitly clarify that metrics and metricgroups are meant to
be used with -M, and correct the grammar for the -e equivalent
statement.

Output of 'perf list metrics' after:

  $ perf list metrics

  List of pre-defined events (to be used with -e):

  Metrics (to be used with -M):

    C2_Pkg_Residency
         [C2 residency percent per package]
  ...

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Martin Liska <mliska@suse.cz>
Cc: Luke Mujica <lukemujica@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
---
 tools/perf/builtin-list.c     | 2 +-
 tools/perf/util/metricgroup.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 08e62ae9d37e..be8e878aa556 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -51,7 +51,7 @@ int cmd_list(int argc, const char **argv)
 	setup_pager();
 
 	if (!raw_dump && pager_in_use())
-		printf("\nList of pre-defined events (to be used in -e):\n\n");
+		printf("\nList of pre-defined events (to be used with -e):\n\n");
 
 	if (argc == 0) {
 		print_events(NULL, raw_dump, !desc_flag, long_desc_flag,
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a7c0424dbda3..f116848be9f7 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -377,9 +377,10 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	}
 
 	if (metricgroups && !raw)
-		printf("\nMetric Groups:\n\n");
+		printf("\nMetric Groups");
 	else if (metrics && !raw)
-		printf("\nMetrics:\n\n");
+		printf("\nMetrics");
+	printf(" (to be used with -M):\n\n");
 
 	for (node = rb_first_cached(&groups.entries); node; node = next) {
 		struct mep *me = container_of(node, struct mep, nd);
-- 
2.23.0
