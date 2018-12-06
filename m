From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 71/75] perf annotate: Introduce basic support for ARC
Date: Thu,  6 Dec 2018 18:25:58 -0300
Message-ID: <20181206212602.20474-72-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Clark Williams <williams@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Vineet Gupta <vineet.gupta1@synopsys.com>, Alexey Brodkin <alexey.brodkin@synopsys.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>, linux-snps-arc@lists.infradead.org, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-perf-users.vger.kernel.org

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

Introduce basic 'perf annotate' support for ARC to be able to use
anotation via stdio interface.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vineet Gupta <vineet.gupta1@synopsys.com>
Link: http://lkml.kernel.org/r/20181204175118.25232-1-Eugeniy.Paltsev@synopsys.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arc/annotate/instructions.c |  9 +++++++++
 tools/perf/arch/common.c                    | 11 ++++++++++-
 tools/perf/util/annotate.c                  |  5 +++++
 3 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/arch/arc/annotate/instructions.c

diff --git a/tools/perf/arch/arc/annotate/instructions.c b/tools/perf/arch/arc/annotate/instructions.c
new file mode 100644
index 000000000000..2f00e995c7e3
--- /dev/null
+++ b/tools/perf/arch/arc/annotate/instructions.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+
+static int arc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+{
+	arch->initialized = true;
+	arch->objdump.comment_char = ';';
+	return 0;
+}
diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index 5f69fd0b745a..f3824ca7c20b 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -5,6 +5,13 @@
 #include "../util/util.h"
 #include "../util/debug.h"
 
+const char *const arc_triplets[] = {
+	"arc-linux-",
+	"arc-snps-linux-uclibc-",
+	"arc-snps-linux-gnu-",
+	NULL
+};
+
 const char *const arm_triplets[] = {
 	"arm-eabi-",
 	"arm-linux-androideabi-",
@@ -147,7 +154,9 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 		zfree(&buf);
 	}
 
-	if (!strcmp(arch, "arm"))
+	if (!strcmp(arch, "arc"))
+		path_list = arc_triplets;
+	else if (!strcmp(arch, "arm"))
 		path_list = arm_triplets;
 	else if (!strcmp(arch, "arm64"))
 		path_list = arm64_triplets;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 51d291b0b81f..ac9805e0bc76 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -134,6 +134,7 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
 	return 0;
 }
 
+#include "arch/arc/annotate/instructions.c"
 #include "arch/arm/annotate/instructions.c"
 #include "arch/arm64/annotate/instructions.c"
 #include "arch/x86/annotate/instructions.c"
@@ -142,6 +143,10 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
 #include "arch/sparc/annotate/instructions.c"
 
 static struct arch architectures[] = {
+	{
+		.name = "arc",
+		.init = arc__annotate_init,
+	},
 	{
 		.name = "arm",
 		.init = arm__annotate_init,
-- 
2.19.2
