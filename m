From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/3] perf jvmti: Link against tools/lib/string.h to have weak strlcpy()
Date: Mon,  9 Sep 2019 13:41:14 +0200
Message-ID: <20190909114116.50469-2-tmricht@linux.ibm.com>
References: <20190909114116.50469-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190909114116.50469-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.ibm.com, gor@linux.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

That is needed in systems such some S/390 distros.

 [root@m35lp76 perf]# readelf -s jvmti/jvmti-in.o | fgrep strlcpy
   408: 0000000000002bc8   216 FUNC    WEAK   DEFAULT  116 strlcpy
 [root@m35lp76 perf]#

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/jvmti/Build | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/jvmti/Build b/tools/perf/jvmti/Build
index eaeb8cb5379b..202cadaaf097 100644
--- a/tools/perf/jvmti/Build
+++ b/tools/perf/jvmti/Build
@@ -1,8 +1,21 @@
 jvmti-y += libjvmti.o
 jvmti-y += jvmti_agent.o
 
+# For strlcpy
+jvmti-y += libstring.o libctype.o
+
 CFLAGS_jvmti         = -fPIC -DPIC -I$(JDIR)/include -I$(JDIR)/include/linux
 CFLAGS_REMOVE_jvmti  = -Wmissing-declarations
 CFLAGS_REMOVE_jvmti += -Wstrict-prototypes
 CFLAGS_REMOVE_jvmti += -Wextra
 CFLAGS_REMOVE_jvmti += -Wwrite-strings
+
+CFLAGS_libstring.o += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
+
+$(OUTPUT)jvmti/libstring.o: ../lib/string.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
+
+$(OUTPUT)jvmti/libctype.o: ../lib/ctype.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
-- 
2.21.0
