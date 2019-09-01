From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 42/47] perf: Update .gitignore file
Date: Sun,  1 Sep 2019 09:23:21 -0300
Message-ID: <20190901122326.5793-43-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, x86@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

After a "make tools/perf", git reports the following untracked files:

  tools/perf/feature/
  tools/perf/fixdep
  tools/perf/libtraceevent-dynamic-list

Add these generated files to perf's .gitignore file.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: x86@kernel.org
Link: http://lore.kernel.org/lkml/03acbc6c2fbc72054861f6c301875db75db33030.1567118001.git.jpoimboe@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/.gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 3e5135dded16..bf1252dc2cb0 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -34,3 +34,6 @@ arch/*/include/generated/
 trace/beauty/generated/
 pmu-events/pmu-events.c
 pmu-events/jevents
+feature/
+fixdep
+libtraceevent-dynamic-list
-- 
2.21.0
