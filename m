From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/19] perf annotate: Get rid of annotation->nr_jumps
Date: Tue, 10 Mar 2020 08:15:36 -0300
Message-ID: <20200310111551.25160-5-acme@kernel.org>
References: <20200310111551.25160-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200310111551.25160-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

The 'nr_jumps' field in 'struct annotation' is not used since it's
inception in commit 2402e4a936a0 ("perf annotate browser: Show 'jumpy'
functions").  Get rid of it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200204045233.474937-7-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 --
 tools/perf/util/annotate.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0ea95be84b3b..f1ea0d61eb5b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2611,8 +2611,6 @@ void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 
 		if (++al->jump_sources > notes->max_jump_sources)
 			notes->max_jump_sources = al->jump_sources;
-
-		++notes->nr_jumps;
 	}
 }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 001258601a37..07c775938d46 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -279,7 +279,6 @@ struct annotation {
 	struct annotation_options *options;
 	struct annotation_line	**offsets;
 	int			nr_events;
-	int			nr_jumps;
 	int			max_jump_sources;
 	int			nr_entries;
 	int			nr_asm_entries;
-- 
2.21.1
