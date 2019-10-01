From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/24] perf annotate: Propagate the symbol__annotate() error return
Date: Tue,  1 Oct 2019 08:12:13 -0300
Message-ID: <20191001111216.7208-22-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were just returning -1 in symbol__annotate() when symbol__annotate()
failed, propagate its error as it is used later to pass to
symbol__strerror_disassemble() to present a error message to the user,
that in some cases were getting:

  "Invalid -1 error code"

Fix it to propagate the error.

Reported-by: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/n/tip-0tj89rs9g7nbcyd5skadlvuu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 95109acf4808..1de1a7091c48 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2997,7 +2997,7 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct evsel *evsel,
 
 out_free_offsets:
 	zfree(&notes->offsets);
-	return -1;
+	return err;
 }
 
 #define ANNOTATION__CFG(n) \
-- 
2.21.0
