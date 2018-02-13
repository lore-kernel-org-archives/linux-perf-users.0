From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 4/4] perf test: Fix test case 23 for s390 z/VM or KVM guests
Date: Tue, 13 Feb 2018 16:14:19 +0100
Message-ID: <20180213151419.80737-4-tmricht@linux.vnet.ibm.com>
References: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On s390 perf can be executed on a LPAR with support
for hardware events (i. e. cycles) or on a z/VM or KVM guest
where no hardware events are supported. In this
environment use software event named cpu-clock
for this test case.

Use the cpuid infrastructure functions to determine
the cpuid on s390 which contains an indication of the
cpu counter facility availability.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/tests/code-reading.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 3bf7b145b826..c7115d369511 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -482,6 +482,34 @@ static void fs_something(void)
 	}
 }
 
+static const char *do_determine_event(bool excl_kernel)
+{
+	const char *event = excl_kernel ? "cycles:u" : "cycles";
+
+#ifdef __s390x__
+	char cpuid[128], model[16], model_c[16], cpum_cf_v[16];
+	unsigned int family;
+	int ret, cpum_cf_a;
+
+	if (get_cpuid(cpuid, sizeof(cpuid)))
+		goto out_clocks;
+	ret = sscanf(cpuid, "%*[^,],%u,%[^,],%[^,],%[^,],%x", &family, model_c,
+		     model, cpum_cf_v, &cpum_cf_a);
+	if (ret != 5)		 /* Not available */
+		goto out_clocks;
+	if (excl_kernel && (cpum_cf_a & 4))
+		return event;
+	if (!excl_kernel && (cpum_cf_a & 2))
+		return event;
+
+	/* Fall through: missing authorization */
+out_clocks:
+	event = excl_kernel ? "cpu-clock:u" : "cpu-clock";
+
+#endif
+	return event;
+}
+
 static void do_something(void)
 {
 	fs_something();
@@ -592,10 +620,7 @@ static int do_test_code_reading(bool try_kcore)
 
 		perf_evlist__set_maps(evlist, cpus, threads);
 
-		if (excl_kernel)
-			str = "cycles:u";
-		else
-			str = "cycles";
+		str = do_determine_event(excl_kernel);
 		pr_debug("Parsing event '%s'\n", str);
 		ret = parse_events(evlist, str, NULL);
 		if (ret < 0) {
-- 
2.14.3
