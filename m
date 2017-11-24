From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/11] perf intel-pt: Bring instruction decoder files into line with the kernel
Date: Fri, 24 Nov 2017 12:02:32 -0300
Message-ID: <20171124150232.18676-12-acme@kernel.org>
References: <20171124150232.18676-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171124150232.18676-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

There are just a few new defines which do not affect perf tools.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/r/1511253326-22308-3-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/inat.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/inat.h b/tools/perf/util/intel-pt-decoder/inat.h
index 125ecd2a300d..52dc8d911173 100644
--- a/tools/perf/util/intel-pt-decoder/inat.h
+++ b/tools/perf/util/intel-pt-decoder/inat.h
@@ -97,6 +97,16 @@
 #define INAT_MAKE_GROUP(grp)	((grp << INAT_GRP_OFFS) | INAT_MODRM)
 #define INAT_MAKE_IMM(imm)	(imm << INAT_IMM_OFFS)
 
+/* Identifiers for segment registers */
+#define INAT_SEG_REG_IGNORE	0
+#define INAT_SEG_REG_DEFAULT	1
+#define INAT_SEG_REG_CS		2
+#define INAT_SEG_REG_SS		3
+#define INAT_SEG_REG_DS		4
+#define INAT_SEG_REG_ES		5
+#define INAT_SEG_REG_FS		6
+#define INAT_SEG_REG_GS		7
+
 /* Attribute search APIs */
 extern insn_attr_t inat_get_opcode_attribute(insn_byte_t opcode);
 extern int inat_get_last_prefix_id(insn_byte_t last_pfx);
-- 
2.13.6
