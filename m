From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 2/4] perf annotate: Scan cpuid for s390 and save machine type
Date: Tue, 13 Feb 2018 16:14:17 +0100
Message-ID: <20180213151419.80737-2-tmricht@linux.vnet.ibm.com>
References: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Scan the cpuid string and extract the type number for later
use.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/arch/s390/annotate/instructions.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 8c72b44444cb..01df9d8303e1 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -23,12 +23,37 @@ static struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *na
 	return ops;
 }
 
+static int s390__cpuid_parse(struct arch *arch, char *cpuid)
+{
+	unsigned int family;
+	char model[16], model_c[16], cpumf_v[16], cpumf_a[16];
+	int ret;
+
+	/*
+	 * cpuid string format:
+	 * "IBM,family,model-capacity,model[,cpum_cf-version,cpum_cf-authorization]"
+	 */
+	ret = sscanf(cpuid, "%*[^,],%u,%[^,],%[^,],%[^,],%s", &family, model_c,
+		     model, cpumf_v, cpumf_a);
+	if (ret >= 2) {
+		arch->family = family;
+		arch->model = 0;
+		return 0;
+	}
+
+	return -1;
+}
+
 static int s390__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
+	int err = 0;
+
 	if (!arch->initialized) {
 		arch->initialized = true;
 		arch->associate_instruction_ops = s390__associate_ins_ops;
+		if (cpuid)
+			err = s390__cpuid_parse(arch, cpuid);
 	}
 
-	return 0;
+	return err;
 }
-- 
2.14.3
