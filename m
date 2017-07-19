From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/86] tools include uapi x86: Add __NR_setns, if missing
Date: Wed, 19 Jul 2017 11:28:56 -0300
Message-ID: <20170719142950.3747-33-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Krister Johansen <kjlx@templeofstupid.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To help us provide a simple setns() in older distros.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-o10a85kf6j7ig87ep6crab2k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/unistd_32.h | 3 +++
 tools/arch/x86/include/asm/unistd_64.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tools/arch/x86/include/asm/unistd_32.h b/tools/arch/x86/include/asm/unistd_32.h
index 88b3f8c8920c..0e4312ffc945 100644
--- a/tools/arch/x86/include/asm/unistd_32.h
+++ b/tools/arch/x86/include/asm/unistd_32.h
@@ -10,3 +10,6 @@
 #ifndef __NR_getcpu
 # define __NR_getcpu 318
 #endif
+#ifndef __NR_setns
+# define __NR_setns 346
+#endif
diff --git a/tools/arch/x86/include/asm/unistd_64.h b/tools/arch/x86/include/asm/unistd_64.h
index fbdb70ee8837..dd56bb36132a 100644
--- a/tools/arch/x86/include/asm/unistd_64.h
+++ b/tools/arch/x86/include/asm/unistd_64.h
@@ -10,3 +10,6 @@
 #ifndef __NR_getcpu
 # define __NR_getcpu 309
 #endif
+#ifndef __NR_setns
+#define __NR_setns 308
+#endif
-- 
2.9.4
