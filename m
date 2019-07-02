From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/43] perf tools: Remove old baggage that is util/include/linux/ctype.h
Date: Mon,  1 Jul 2019 23:25:52 -0300
Message-ID: <20190702022616.1259-20-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It was just including a ../util.h that wasn't even there:

  $ cat tools/perf/util/include/linux/../util.h
  cat: tools/perf/util/include/linux/../util.h: No such file or directory
  $

This would make kallsyms.h get util.h somehow and then files including
it would get util.h defined stuff, a mess, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wlzwken4psiat4zvfbvaoqiw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/symbol/kallsyms.h           | 1 -
 tools/perf/util/include/linux/ctype.h | 1 -
 2 files changed, 2 deletions(-)
 delete mode 100644 tools/perf/util/include/linux/ctype.h

diff --git a/tools/lib/symbol/kallsyms.h b/tools/lib/symbol/kallsyms.h
index bd988f7b18d4..2b238f181d97 100644
--- a/tools/lib/symbol/kallsyms.h
+++ b/tools/lib/symbol/kallsyms.h
@@ -3,7 +3,6 @@
 #define __TOOLS_KALLSYMS_H_ 1
 
 #include <elf.h>
-#include <linux/ctype.h>
 #include <linux/types.h>
 
 #ifndef KSYM_NAME_LEN
diff --git a/tools/perf/util/include/linux/ctype.h b/tools/perf/util/include/linux/ctype.h
deleted file mode 100644
index a53d4ee1e0b7..000000000000
--- a/tools/perf/util/include/linux/ctype.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../util.h"
-- 
2.20.1
