From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/25] perf annotate: Fix dereferencing freed memory found by the smatch tool
Date: Tue,  9 Jul 2019 15:31:05 -0300
Message-ID: <20190709183126.30257-5-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Alexios Zavras <alexios.zavras@intel.com>, Andi Kleen <ak@linux.intel.com>, Changbin Du <changbin.du@intel.com>, "David S . Miller" <davem@davemloft.net>, Davidlohr Bueso <dave@stgolabs.net>, Eric Saint-Etienne <eric.saint.etienne@oracle.com>, Jin Yao <yao.jin@linux.intel.com>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Mathieu Poirier <mathieu.poirier@linaro.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

Based on the following report from Smatch, fix the potential
dereferencing freed memory check.

  tools/perf/util/annotate.c:1125
  disasm_line__parse() error: dereferencing freed memory 'namep'

  tools/perf/util/annotate.c
  1100 static int disasm_line__parse(char *line, const char **namep, char **rawp)
  1101 {
  1102         char tmp, *name = ltrim(line);

  [...]

  1114         *namep = strdup(name);
  1115
  1116         if (*namep == NULL)
  1117                 goto out_free_name;

  [...]

  1124 out_free_name:
  1125         free((void *)namep);
                            ^^^^^
  1126         *namep = NULL;
               ^^^^^^
  1127         return -1;
  1128 }

If strdup() fails to allocate memory space for *namep, we don't need to
free memory with pointer 'namep', which is resident in data structure
disasm_line::ins::name; and *namep is NULL pointer for this failure, so
it's pointless to assign NULL to *namep again.

Committer note:

Freeing namep, which is the address of the first entry of the 'struct
ins' that is the first member of struct disasm_line would in fact free
that disasm_line instance, if it was allocated via malloc/calloc, which,
later, would a dereference of freed memory.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Alexios Zavras <alexios.zavras@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Song Liu <songliubraving@fb.com>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190702103420.27540-5-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ec7aaf31c2b2..944a6507a5e3 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1119,16 +1119,14 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
 	*namep = strdup(name);
 
 	if (*namep == NULL)
-		goto out_free_name;
+		goto out;
 
 	(*rawp)[0] = tmp;
 	*rawp = skip_spaces(*rawp);
 
 	return 0;
 
-out_free_name:
-	free((void *)namep);
-	*namep = NULL;
+out:
 	return -1;
 }
 
-- 
2.21.0
