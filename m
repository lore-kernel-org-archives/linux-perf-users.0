From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/13] perf tools: No need to include namespaces.h in util.h
Date: Mon,  9 Apr 2018 16:34:34 -0300
Message-ID: <20180409193437.14199-11-acme@kernel.org>
References: <20180409193437.14199-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180409193437.14199-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The only thing that is needed there is a forward declaration for 'struct
nsinfo', so disentanble this, which in turns allows built-in clang
builds, i.e. 'make LIBCLANGLLVM=1 -C tools/perf'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-vq26rsuwq1cqylpcyvq89c84@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 9496365da3d7..c9626c206208 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -11,8 +11,7 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <linux/compiler.h>
-#include <linux/types.h>
-#include "namespaces.h"
+#include <sys/types.h>
 
 /* General helper functions */
 void usage(const char *err) __noreturn;
@@ -26,6 +25,7 @@ static inline void *zalloc(size_t size)
 #define zfree(ptr) ({ free(*ptr); *ptr = NULL; })
 
 struct dirent;
+struct nsinfo;
 struct strlist;
 
 int mkdir_p(char *path, mode_t mode);
-- 
2.14.3
