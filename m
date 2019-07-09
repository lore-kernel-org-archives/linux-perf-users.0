From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/25] perf tools: Add missing headers, mostly stdlib.h
Date: Tue,  9 Jul 2019 15:31:11 -0300
Message-ID: <20190709183126.30257-11-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Part of the erosion of util/util.h, that will lose its include stdlib.h,
we need to add it to places where it is needed but was getting it
indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1imnqezw99ahc07fjeb51qby@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/common.c                 | 1 +
 tools/perf/arch/powerpc/util/perf_regs.c | 2 ++
 tools/perf/arch/s390/util/header.c       | 1 +
 tools/perf/builtin-config.c              | 1 +
 tools/perf/builtin-help.c                | 1 +
 tools/perf/tests/llvm.c                  | 1 +
 tools/perf/tests/sample-parsing.c        | 1 +
 tools/perf/tests/vmlinux-kallsyms.c      | 1 +
 tools/perf/ui/browser.h                  | 1 +
 tools/perf/ui/browsers/map.c             | 1 +
 tools/perf/ui/tui/setup.c                | 1 +
 tools/perf/ui/tui/util.c                 | 2 +-
 tools/perf/util/cputopo.c                | 1 +
 tools/perf/util/db-export.c              | 1 +
 tools/perf/util/debug.c                  | 1 +
 tools/perf/util/demangle-java.c          | 3 ++-
 tools/perf/util/dwarf-aux.c              | 2 +-
 tools/perf/util/env.c                    | 1 +
 tools/perf/util/parse-branch-options.c   | 2 +-
 tools/perf/util/parse-regs-options.c     | 8 ++++++--
 tools/perf/util/strbuf.c                 | 1 +
 tools/perf/util/symbol-elf.c             | 1 +
 tools/perf/util/symbol-minimal.c         | 1 +
 tools/perf/util/target.c                 | 2 +-
 tools/perf/util/thread-stack.c           | 1 +
 tools/perf/util/usage.c                  | 3 +++
 26 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index f3824ca7c20b..1bc329412bcf 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
+#include <stdlib.h>
 #include "common.h"
 #include "../util/env.h"
 #include "../util/util.h"
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index 34d5134681d9..64f65c296d3e 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -8,6 +8,8 @@
 #include "../../util/perf_regs.h"
 #include "../../util/debug.h"
 
+#include <linux/kernel.h>
+
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(r0, PERF_REG_POWERPC_R0),
 	SMPL_REG(r1, PERF_REG_POWERPC_R1),
diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
index a25896135abe..165c51435e72 100644
--- a/tools/perf/arch/s390/util/header.c
+++ b/tools/perf/arch/s390/util/header.c
@@ -12,6 +12,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <linux/ctype.h>
+#include <linux/kernel.h>
 
 #include "../../util/header.h"
 #include "../../util/util.h"
diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index d76f831f94c7..6c1284c87aaa 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -15,6 +15,7 @@
 #include "util/debug.h"
 #include "util/config.h"
 #include <linux/string.h>
+#include <stdlib.h>
 
 static bool use_system_config, use_user_config;
 
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 3d29d0524a89..6a1cab547043 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <errno.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
index a039f93199e5..ca5a5f94ce79 100644
--- a/tools/perf/tests/llvm.c
+++ b/tools/perf/tests/llvm.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
+#include <stdlib.h>
 #include <bpf/libbpf.h>
 #include <util/llvm-utils.h>
 #include <util/cache.h>
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 236ce0d6c826..361714e2583c 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdbool.h>
 #include <inttypes.h>
+#include <stdlib.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index f101576d1c72..5e8834fc7dec 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -3,6 +3,7 @@
 #include <linux/rbtree.h>
 #include <inttypes.h>
 #include <string.h>
+#include <stdlib.h>
 #include "map.h"
 #include "symbol.h"
 #include "util.h"
diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
index aa5932e1d62e..dc1444136658 100644
--- a/tools/perf/ui/browser.h
+++ b/tools/perf/ui/browser.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <stdarg.h>
+#include <sys/types.h>
 
 #define HE_COLORSET_TOP		50
 #define HE_COLORSET_MEDIUM	51
diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index 5f6529c9eb8e..4c545b92e20d 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -2,6 +2,7 @@
 #include <elf.h>
 #include <inttypes.h>
 #include <sys/ttydefaults.h>
+#include <stdlib.h>
 #include <string.h>
 #include <linux/bitops.h>
 #include "../../util/util.h"
diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
index d4ac41679721..3ad0d3363ac6 100644
--- a/tools/perf/ui/tui/setup.c
+++ b/tools/perf/ui/tui/setup.c
@@ -2,6 +2,7 @@
 #include <errno.h>
 #include <signal.h>
 #include <stdbool.h>
+#include <stdlib.h>
 #include <linux/kernel.h>
 #ifdef HAVE_BACKTRACE_SUPPORT
 #include <execinfo.h>
diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
index b9794d6185af..fe5e571816fc 100644
--- a/tools/perf/ui/tui/util.c
+++ b/tools/perf/ui/tui/util.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../../util/util.h"
 #include <signal.h>
 #include <stdbool.h>
 #include <string.h>
+#include <stdlib.h>
 #include <sys/ttydefaults.h>
 
 #include "../../util/cache.h"
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 26e73a4bd4fe..d3b2bd258b9e 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -2,6 +2,7 @@
 #include <sys/param.h>
 #include <sys/utsname.h>
 #include <inttypes.h>
+#include <stdlib.h>
 #include <api/fs/fs.h>
 
 #include "cputopo.h"
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 2182f552aac6..4cdd1f579156 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -5,6 +5,7 @@
  */
 
 #include <errno.h>
+#include <stdlib.h>
 
 #include "evsel.h"
 #include "machine.h"
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 3cc578343f48..3780fe42453b 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -7,6 +7,7 @@
 #include <string.h>
 #include <stdarg.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <sys/wait.h>
 #include <api/debug.h>
 #include <linux/time64.h>
diff --git a/tools/perf/util/demangle-java.c b/tools/perf/util/demangle-java.c
index 5b4900d67c80..763328c151e9 100644
--- a/tools/perf/util/demangle-java.c
+++ b/tools/perf/util/demangle-java.c
@@ -1,14 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <sys/types.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
-#include "util.h"
 #include "debug.h"
 #include "symbol.h"
 
 #include "demangle-java.h"
 
 #include <linux/ctype.h>
+#include <linux/kernel.h>
 
 enum {
 	MODE_PREFIX = 0,
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 218bfea8f8a8..03b2de1f5a35 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -6,7 +6,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <stdbool.h>
-#include "util.h"
+#include <stdlib.h>
 #include "debug.h"
 #include "dwarf-aux.h"
 #include "string2.h"
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 22eee8942527..7d317d49d207 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <sys/utsname.h>
 #include <bpf/libbpf.h>
+#include <stdlib.h>
 
 struct perf_env perf_env;
 
diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index bd779d9f4d1e..726e8d9e8c54 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "perf.h"
-#include "util/util.h"
 #include "util/debug.h"
 #include <subcmd/parse-options.h>
 #include "util/parse-branch-options.h"
+#include <stdlib.h>
 
 #define BRANCH_OPT(n, m) \
 	{ .name = n, .mode = (m) }
diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index 08581e276225..ef46c2848808 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -1,8 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "perf.h"
-#include "util/util.h"
+#include <stdbool.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <stdio.h>
 #include "util/debug.h"
 #include <subcmd/parse-options.h>
+#include "util/perf_regs.h"
 #include "util/parse-regs-options.h"
 
 static int
diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
index 23092fd6451d..54336df089df 100644
--- a/tools/perf/util/strbuf.c
+++ b/tools/perf/util/strbuf.c
@@ -3,6 +3,7 @@
 #include "util.h"
 #include <linux/kernel.h>
 #include <errno.h>
+#include <stdlib.h>
 
 /*
  * Used as the default ->buf value, so that people can always assume
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 62008756d8cc..429920978cb0 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -2,6 +2,7 @@
 #include <fcntl.h>
 #include <stdio.h>
 #include <errno.h>
+#include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include <inttypes.h>
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 17edbd4f6f85..c8b7cadbc9c4 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <fcntl.h>
 #include <string.h>
+#include <stdlib.h>
 #include <byteswap.h>
 #include <sys/stat.h>
 
diff --git a/tools/perf/util/target.c b/tools/perf/util/target.c
index 3852d07c49bd..3adc65480349 100644
--- a/tools/perf/util/target.c
+++ b/tools/perf/util/target.c
@@ -10,9 +10,9 @@
 #include "debug.h"
 
 #include <pwd.h>
+#include <stdlib.h>
 #include <string.h>
 
-
 enum target_errno target__validate(struct target *target)
 {
 	enum target_errno ret = TARGET_ERRNO__SUCCESS;
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 6ff1ff4d4ce7..48d585a0175c 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -8,6 +8,7 @@
 #include <linux/list.h>
 #include <linux/log2.h>
 #include <errno.h>
+#include <stdlib.h>
 #include "thread.h"
 #include "event.h"
 #include "machine.h"
diff --git a/tools/perf/util/usage.c b/tools/perf/util/usage.c
index 070d25ceea6a..3949a60b00ae 100644
--- a/tools/perf/util/usage.c
+++ b/tools/perf/util/usage.c
@@ -9,6 +9,9 @@
  */
 #include "util.h"
 #include "debug.h"
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/compiler.h>
 
 static __noreturn void usage_builtin(const char *err)
 {
-- 
2.21.0
