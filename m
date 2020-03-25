From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/24] perf cpumap: Fix snprintf overflow check
Date: Wed, 25 Mar 2020 09:41:23 -0300
Message-ID: <20200325124124.32648-24-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, David Laight <David.Laight@ACULAB.COM>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Don Zickus <dzickus@redhat.com>, He Zhe <zhe.he@windriver.com>, Jan Stancek <jstancek@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, kernel-janitors@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

'snprintf' returns the number of characters which would be generated for
the given input.

If the returned value is *greater than* or equal to the buffer size, it
means that the output has been truncated.

Fix the overflow test accordingly.

Fixes: 7780c25bae59f ("perf tools: Allow ability to map cpus to nodes easily")
Fixes: 92a7e1278005b ("perf cpumap: Add cpu__max_present_cpu()")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: He Zhe <zhe.he@windriver.com>
Cc: Jan Stancek <jstancek@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-janitors@vger.kernel.org
Link: http://lore.kernel.org/lkml/20200324070319.10901-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 983b7388f22b..dc5c5e6fc502 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -317,7 +317,7 @@ static void set_max_cpu_num(void)
 
 	/* get the highest possible cpu number for a sparse allocation */
 	ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/possible", mnt);
-	if (ret == PATH_MAX) {
+	if (ret >= PATH_MAX) {
 		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
 		goto out;
 	}
@@ -328,7 +328,7 @@ static void set_max_cpu_num(void)
 
 	/* get the highest present cpu number for a sparse allocation */
 	ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/present", mnt);
-	if (ret == PATH_MAX) {
+	if (ret >= PATH_MAX) {
 		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
 		goto out;
 	}
@@ -356,7 +356,7 @@ static void set_max_node_num(void)
 
 	/* get the highest possible cpu number for a sparse allocation */
 	ret = snprintf(path, PATH_MAX, "%s/devices/system/node/possible", mnt);
-	if (ret == PATH_MAX) {
+	if (ret >= PATH_MAX) {
 		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
 		goto out;
 	}
@@ -441,7 +441,7 @@ int cpu__setup_cpunode_map(void)
 		return 0;
 
 	n = snprintf(path, PATH_MAX, "%s/devices/system/node", mnt);
-	if (n == PATH_MAX) {
+	if (n >= PATH_MAX) {
 		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
 		return -1;
 	}
@@ -456,7 +456,7 @@ int cpu__setup_cpunode_map(void)
 			continue;
 
 		n = snprintf(buf, PATH_MAX, "%s/%s", path, dent1->d_name);
-		if (n == PATH_MAX) {
+		if (n >= PATH_MAX) {
 			pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
 			continue;
 		}
-- 
2.21.1
