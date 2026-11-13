Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599644;
	b=xvIZ/2T1HBKFu5QP67nAZBl02kY5tLpXD3xsaogyT3c9pHD2uyiUmo5JHNRXb2oB5UFF
	 VQeM5eszatEHjNLmPfinc16U5Qil1YLTAgmuhdeeYh81TOVDLt/GWqCy56yub+4znpejP
	 7fYKPLWS9/fNDjRSOhYp0WXX+HZbeyFaMC0ulNNYf9YXkwWlNXh21L2ZXe42XHUcwXM13
	 4ekt9tznWSUYEbt7Evmcq+QSrlmx+A8VSmfc91yV4zEzfsG11Er5WLVRnuXaQmm7kDiSK
	 1OnNqmcsjysQZwztDT7RiMmwhYqSPNDC5A/FDACOBxhwX6Di3krmj5+uVFhXVNu1b3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=yF/be9CKFi/jWL1I0EMkmqft/FJWnaygCIXaGsGkbWM=;
	b=5Z+U9HW1W3bwY2gbxzxcAJ6KIxZUWHbA9gJcK8EjG8n+nhxvkvqL1y8HQs2LphnnSYL2
	 EOwua7iNf7aiK+Xh1D6Ez5QxSfS1tllKCPbdTbFiEGx3RYHnLkMTEt4pWyj70Un2v4cfj
	 m0njM5GeR5XC5W6c12+tuqHDRfQUHT/wa4eG7kMODIv93KSAR0rzxwO3r3baXjt+dwLmK
	 jO4yhLzYkKEK3HYGLXE8NPVu6/cFGsiFacdK10DjeC2O+/i1csODDE9lAgGC/Jv1b5vvp
	 /AGl6ysFsiHRsnIoLG2joF2XIkYDWyaSxjOuwTv6qwa4ihXOBBlYOm7O7J8yFaCRQXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kMYTjKZy;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8444760A380D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8444760A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kMYTjKZy
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so666331c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599643; x=1795204443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yF/be9CKFi/jWL1I0EMkmqft/FJWnaygCIXaGsGkbWM=;
        b=kMYTjKZyMQ2/nokk55UM2wmeeBsybzhEfEoVtju+hm0oTxLmJWn80lN70g9HnHl7Pj
         jXEYop2iSHYElBprHYHxxqDVscwkQXOAXTXnIW8+e+PKjrvHqU87vfwCKLAqsBSdTlwT
         BRb5M3DGZUlFwW6JDcizzYkLHp1gs6dcazmHlUavFJPsNl87p3Ieadhi5C+cw2wBYWW3
         NOegkceJW/rvPaO2qVXXL3W+ebVHqyIWWTLSmOb119l/LHjeuGUf3qngThI7PEYtlG+n
         GFvioQ/+XmAJ0iDn7pSkwqCcRDE2SOUYW0CwQPhtzJYcfF9FQvy6w0jxEEll7tfa9N/6
         YrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599643; x=1795204443;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yF/be9CKFi/jWL1I0EMkmqft/FJWnaygCIXaGsGkbWM=;
        b=RlC2tXOyZOl3eP3p9njqQ3Al3l9JmkSjvPpmQIe3R9KputWSN8viSmzSFONiSW9lj/
         sWQjmyLkb0tJN15IqQTIE10hc7MeZUY89fnG5vn13R0s2TKGH36et5KdcXnLOOR3qC8s
         91yOT4rZkkUOlHjLz2USp1VsZuaP4nVJnT6e/kp7PIptPoTAHq+7zlSeiBTUFA12lfm1
         uRq4Am7EtC0tUrdrf1YlJXW/jkx63X3juuzxeO1VksFq5u2UR9HeIPtTo4LrOnuc9PsP
         n+arPheg+7bhan4DNKeAYlZZ+4MMByE7Gs2B1vOKxHsy2twqmSAeRn0M/3/cjb0i41mw
         9Lbw==
X-Gm-Message-State: APuU4Z8ZOegbEoBjACsL3sicRiZM+nw3+c9zg/pd21BA5S1w09YJgw++
	R6+hVx96dZD6BdT36ZEQMOSfCVBUP76ENckgHFhlDpyyGjz41n0Q5o4G1iI1uUsLsQlxaxNtiEA
	pfKCimvzsAQ==
X-Received: from dlae24.prod.google.com ([2002:a05:701b:2318:b0:18c:3061:3bca])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:408d:b0:1b2:42db:8a54
 with SMTP id a92af1059eb24-1b50310591dmr3206002c88.23.1794599642048; Fri, 13
 Nov 2026 11:54:02 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:14 -0800
In-Reply-To: <20261113195335.2865725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195335.2865725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195335.2865725-10-irogers@google.com>
Subject: [PATCH v2 09/30] perf pmus: Pass struct perf_pmus to find helpers
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update perf_pmus__find(), perf_pmus__find_by_type(), and
perf_pmus__find_core_pmu() to take a struct perf_pmus * argument and
update callers to pass the appropriate environment's PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/util/auxtrace.c           |  9 ++--
 tools/perf/arch/arm/util/cs-etm.c             |  3 +-
 tools/perf/arch/arm64/util/pmu.c              |  3 +-
 tools/perf/arch/x86/tests/amd-ibs-period.c    |  5 +-
 .../arch/x86/tests/amd-ibs-via-core-pmu.c     |  3 +-
 tools/perf/arch/x86/tests/hybrid.c            |  3 +-
 tools/perf/arch/x86/tests/topdown.c           |  3 +-
 tools/perf/arch/x86/util/auxtrace.c           |  9 ++--
 tools/perf/arch/x86/util/evsel.c              |  6 ++-
 tools/perf/arch/x86/util/intel-bts.c          |  4 +-
 tools/perf/arch/x86/util/intel-pt.c           |  4 +-
 tools/perf/arch/x86/util/topdown.c            |  3 +-
 tools/perf/bench/pmu-scan.c                   |  3 +-
 tools/perf/builtin-stat.c                     |  8 +--
 tools/perf/tests/parse-events.c               | 14 ++---
 tools/perf/trace/beauty/perf_event_open.c     |  4 +-
 tools/perf/util/aslr.c                        |  7 ++-
 tools/perf/util/env.c                         |  2 +-
 tools/perf/util/evsel.c                       |  6 ++-
 tools/perf/util/evsel_fprintf.c               |  6 ++-
 tools/perf/util/evsel_fprintf.h               |  4 +-
 tools/perf/util/header.c                      |  8 +--
 tools/perf/util/metricgroup.c                 | 51 ++++++++++++-------
 tools/perf/util/metricgroup.h                 |  4 +-
 tools/perf/util/parse-events.c                | 18 ++++---
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |  2 +-
 tools/perf/util/perf_event_attr_fprintf.c     |  7 +--
 tools/perf/util/pfm.c                         |  6 ++-
 tools/perf/util/pmus.c                        | 28 ++++------
 tools/perf/util/pmus.h                        | 27 ++++++++--
 tools/perf/util/s390-sample-raw.c             | 16 ++++--
 31 files changed, 176 insertions(+), 100 deletions(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util=
/auxtrace.c
index 27bb14c8b880..f3a4f292a2c7 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -13,6 +13,7 @@
=20
 #include "../../../util/auxtrace.h"
 #include "../../../util/debug.h"
+#include "../../../util/env.h"
 #include "../../../util/evlist.h"
 #include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
@@ -22,6 +23,7 @@
=20
 static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
 {
+	struct perf_pmus *pmus =3D perf_env__pmus(host_env());
 	struct perf_pmu **arm_spe_pmus =3D NULL;
 	int ret, i, nr_cpus =3D sysconf(_SC_NPROCESSORS_CONF);
 	/* arm_spe_xxxxxxxxx\0 */
@@ -42,7 +44,7 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_sp=
es, int *err)
 			return NULL;
 		}
=20
-		arm_spe_pmus[*nr_spes] =3D perf_pmus__find(arm_spe_pmu_name);
+		arm_spe_pmus[*nr_spes] =3D perf_pmus__find(pmus, arm_spe_pmu_name);
 		if (arm_spe_pmus[*nr_spes]) {
 			pr_debug2("%s %d: arm_spe_pmu %d type %d name %s\n",
 				 __func__, __LINE__, *nr_spes,
@@ -57,6 +59,7 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_sp=
es, int *err)
=20
 static struct perf_pmu **find_all_hisi_ptt_pmus(int *nr_ptts, int *err)
 {
+	struct perf_pmus *pmus =3D perf_env__pmus(host_env());
 	struct perf_pmu **hisi_ptt_pmus =3D NULL;
 	struct dirent *dent;
 	char path[PATH_MAX];
@@ -89,7 +92,7 @@ static struct perf_pmu **find_all_hisi_ptt_pmus(int *nr_p=
tts, int *err)
 	rewinddir(dir);
 	while ((dent =3D readdir(dir))) {
 		if (strstr(dent->d_name, HISI_PTT_PMU_NAME) && idx < *nr_ptts) {
-			hisi_ptt_pmus[idx] =3D perf_pmus__find(dent->d_name);
+			hisi_ptt_pmus[idx] =3D perf_pmus__find(pmus, dent->d_name);
 			if (hisi_ptt_pmus[idx])
 				idx++;
 		}
@@ -133,7 +136,7 @@ struct auxtrace_record
 	if (!evlist)
 		return NULL;
=20
-	cs_etm_pmu =3D perf_pmus__find(CORESIGHT_ETM_PMU_NAME);
+	cs_etm_pmu =3D perf_pmus__find(perf_env__pmus(host_env()), CORESIGHT_ETM_=
PMU_NAME);
 	arm_spe_pmus =3D find_all_arm_spe_pmus(&nr_spes, err);
 	hisi_ptt_pmus =3D find_all_hisi_ptt_pmus(&nr_ptts, err);
=20
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/c=
s-etm.c
index d2861d66a661..e15bd87f65fb 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -25,6 +25,7 @@
 #include "../../../util/auxtrace.h"
 #include "../../../util/cpumap.h"
 #include "../../../util/debug.h"
+#include "../../../util/env.h"
 #include "../../../util/event.h"
 #include "../../../util/evlist.h"
 #include "../../../util/evsel.h"
@@ -883,7 +884,7 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 	struct perf_pmu *cs_etm_pmu;
 	struct cs_etm_recording *ptr;
=20
-	cs_etm_pmu =3D perf_pmus__find(CORESIGHT_ETM_PMU_NAME);
+	cs_etm_pmu =3D perf_pmus__find(perf_env__pmus(host_env()), CORESIGHT_ETM_=
PMU_NAME);
=20
 	if (!cs_etm_pmu) {
 		*err =3D -EINVAL;
diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/=
pmu.c
index 895fb0d0610c..798b423fe149 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
=20
+#include "../../../util/env.h"
 #include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
 #include "../../../util/tool_pmu.h"
@@ -9,7 +10,7 @@ u64 tool_pmu__cpu_slots_per_cycle(void)
 {
 	char path[PATH_MAX];
 	unsigned long long slots =3D 0;
-	struct perf_pmu *pmu =3D perf_pmus__find_core_pmu();
+	struct perf_pmu *pmu =3D perf_pmus__find_core_pmu(perf_env__pmus(host_env=
()));
=20
 	if (pmu) {
 		perf_pmu__pathname_scnprintf(path, sizeof(path),
diff --git a/tools/perf/arch/x86/tests/amd-ibs-period.c b/tools/perf/arch/x=
86/tests/amd-ibs-period.c
index 32713f8fcd5c..4a32eaea61c7 100644
--- a/tools/perf/arch/x86/tests/amd-ibs-period.c
+++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
@@ -930,6 +930,7 @@ static bool kernel_v6_15_or_newer(void)
 int test__amd_ibs_period(struct test_suite *test __maybe_unused,
 			 int subtest __maybe_unused)
 {
+	struct perf_pmus *pmus =3D perf_env__pmus(host_env());
 	char perf[PATH_MAX] =3D {'\0'};
 	int ret =3D TEST_OK;
=20
@@ -940,8 +941,8 @@ int test__amd_ibs_period(struct test_suite *test __mayb=
e_unused,
 	 * of the test to fail if kernel changes it after reading it here.
 	 */
 	perf_event_max_sample_rate =3D get_perf_event_max_sample_rate();
-	fetch_pmu =3D perf_pmus__find("ibs_fetch");
-	op_pmu =3D perf_pmus__find("ibs_op");
+	fetch_pmu =3D perf_pmus__find(pmus, "ibs_fetch");
+	op_pmu =3D perf_pmus__find(pmus, "ibs_op");
=20
 	if (!x86__is_amd_cpu() || !fetch_pmu || !op_pmu)
 		return TEST_SKIP;
diff --git a/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c b/tools/perf/=
arch/x86/tests/amd-ibs-via-core-pmu.c
index 78b1902f6f59..a509a861b4f5 100644
--- a/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
+++ b/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
@@ -2,6 +2,7 @@
 #include "arch-tests.h"
 #include "linux/perf_event.h"
 #include "tests/tests.h"
+#include "env.h"
 #include "pmu.h"
 #include "pmus.h"
 #include "../perf-sys.h"
@@ -44,7 +45,7 @@ int test__amd_ibs_via_core_pmu(struct test_suite *test __=
maybe_unused,
 	int ret =3D TEST_OK;
 	int fd, i;
=20
-	ibs_pmu =3D perf_pmus__find("ibs_op");
+	ibs_pmu =3D perf_pmus__find(perf_env__pmus(host_env()), "ibs_op");
 	if (!ibs_pmu)
 		return TEST_SKIP;
=20
diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests=
/hybrid.c
index 011217998a3e..0146cc2e0c5b 100644
--- a/tools/perf/arch/x86/tests/hybrid.c
+++ b/tools/perf/arch/x86/tests/hybrid.c
@@ -112,10 +112,11 @@ static int test__hybrid_group_modifier1(struct evlist=
 *evlist)
=20
 static int test__hybrid_raw1(struct evlist *evlist)
 {
+	struct perf_pmus *pmus =3D perf_env__pmus(host_env());
 	struct perf_evsel *evsel;
=20
 	perf_evlist__for_each_evsel(evlist__core(evlist), evsel) {
-		struct perf_pmu *pmu =3D perf_pmus__find_by_type(evsel->attr.type);
+		struct perf_pmu *pmu =3D perf_pmus__find_by_type(pmus, evsel->attr.type)=
;
=20
 		TEST_ASSERT_VAL("missing pmu", pmu);
 		TEST_ASSERT_VAL("unexpected pmu", !strncmp(pmu->name, "cpu_", 4));
diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/test=
s/topdown.c
index 520075329c37..827169b60813 100644
--- a/tools/perf/arch/x86/tests/topdown.c
+++ b/tools/perf/arch/x86/tests/topdown.c
@@ -5,6 +5,7 @@
 #include "arch-tests.h"
 #include "../util/topdown.h"
 #include "debug.h"
+#include "env.h"
 #include "evlist.h"
 #include "parse-events.h"
 #include "pmu.h"
@@ -245,7 +246,7 @@ static int test__x86_topdown_metrics_clear(struct test_=
suite *test __maybe_unuse
 	if (!topdown_sys_has_perf_metrics())
 		return TEST_OK;
=20
-	pmu =3D perf_pmus__find_by_type(PERF_TYPE_RAW);
+	pmu =3D perf_pmus__find_by_type(perf_env__pmus(host_env()), PERF_TYPE_RAW=
);
 	if (!pmu || !perf_pmu__has_format(pmu, "metrics_clear"))
 		return TEST_OK;
=20
diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util=
/auxtrace.c
index 84fce0b51ccf..540caf06d15c 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -9,6 +9,7 @@
=20
 #include "../../../util/header.h"
 #include "../../../util/debug.h"
+#include "../../../util/env.h"
 #include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
 #include "../../../util/auxtrace.h"
@@ -20,15 +21,13 @@ static
 struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
 						    int *err)
 {
-	struct perf_pmu *intel_pt_pmu;
-	struct perf_pmu *intel_bts_pmu;
+	struct perf_pmus *pmus =3D perf_env__pmus(host_env());
+	struct perf_pmu *intel_pt_pmu =3D perf_pmus__find(pmus, INTEL_PT_PMU_NAME=
);
+	struct perf_pmu *intel_bts_pmu =3D perf_pmus__find(pmus, INTEL_BTS_PMU_NA=
ME);
 	struct evsel *evsel;
 	bool found_pt =3D false;
 	bool found_bts =3D false;
=20
-	intel_pt_pmu =3D perf_pmus__find(INTEL_PT_PMU_NAME);
-	intel_bts_pmu =3D perf_pmus__find(INTEL_BTS_PMU_NAME);
-
 	evlist__for_each_entry(evlist, evsel) {
 		if (intel_pt_pmu && evsel->core.attr.type =3D=3D intel_pt_pmu->type)
 			found_pt =3D true;
diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/ev=
sel.c
index 23a8e662a912..a8e239d29b72 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -132,6 +132,7 @@ static void ibs_l3miss_warn(void)
=20
 void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *=
attr)
 {
+	struct perf_pmus *pmus;
 	struct perf_pmu *evsel_pmu, *ibs_fetch_pmu, *ibs_op_pmu;
 	static int warned_once;
=20
@@ -142,8 +143,9 @@ void arch__post_evsel_config(struct evsel *evsel, struc=
t perf_event_attr *attr)
 	if (!evsel_pmu)
 		return;
=20
-	ibs_fetch_pmu =3D perf_pmus__find("ibs_fetch");
-	ibs_op_pmu =3D perf_pmus__find("ibs_op");
+	pmus =3D perf_env__pmus(host_env());
+	ibs_fetch_pmu =3D perf_pmus__find(pmus, "ibs_fetch");
+	ibs_op_pmu =3D perf_pmus__find(pmus, "ibs_op");
=20
 	if (ibs_fetch_pmu && ibs_fetch_pmu->type =3D=3D evsel_pmu->type) {
 		if (attr->config & IBS_FETCH_L3MISSONLY) {
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/uti=
l/intel-bts.c
index d44d568a6d21..2a7b20f5a1ca 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -19,6 +19,7 @@
 #include "../../../util/auxtrace.h"
 #include "../../../util/cpumap.h"
 #include "../../../util/debug.h"
+#include "../../../util/env.h"
 #include "../../../util/event.h"
 #include "../../../util/evlist.h"
 #include "../../../util/evsel.h"
@@ -420,7 +421,8 @@ static int intel_bts_find_snapshot(struct auxtrace_reco=
rd *itr, int idx,
=20
 struct auxtrace_record *intel_bts_recording_init(int *err)
 {
-	struct perf_pmu *intel_bts_pmu =3D perf_pmus__find(INTEL_BTS_PMU_NAME);
+	struct perf_pmu *intel_bts_pmu =3D perf_pmus__find(perf_env__pmus(host_en=
v()),
+							 INTEL_BTS_PMU_NAME);
 	struct intel_bts_recording *btsr;
=20
 	if (!intel_bts_pmu)
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util=
/intel-pt.c
index a533114c0048..7756971ade50 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -23,6 +23,7 @@
 #include "../../../util/config.h"
 #include "../../../util/cpumap.h"
 #include "../../../util/debug.h"
+#include "../../../util/env.h"
 #include "../../../util/event.h"
 #include "../../../util/evlist.h"
 #include "../../../util/evsel.h"
@@ -1195,7 +1196,8 @@ static int intel_pt_perf_config(const char *var, cons=
t char *value, void *data)
=20
 struct auxtrace_record *intel_pt_recording_init(int *err)
 {
-	struct perf_pmu *intel_pt_pmu =3D perf_pmus__find(INTEL_PT_PMU_NAME);
+	struct perf_pmu *intel_pt_pmu =3D perf_pmus__find(perf_env__pmus(host_env=
()),
+							INTEL_PT_PMU_NAME);
 	struct intel_pt_recording *ptr;
=20
 	if (!intel_pt_pmu)
diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/=
topdown.c
index 64bc64e335a2..797ace8999e4 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include "util/env.h"
 #include "util/evlist.h"
 #include "util/pmu.h"
 #include "util/pmus.h"
@@ -26,7 +27,7 @@ bool topdown_sys_has_perf_metrics(void)
 	 * The slots event is only available when the core PMU
 	 * supports the perf metrics feature.
 	 */
-	pmu =3D perf_pmus__find_by_type(PERF_TYPE_RAW);
+	pmu =3D perf_pmus__find_by_type(perf_env__pmus(host_env()), PERF_TYPE_RAW=
);
 	if (pmu && perf_pmu__have_event(pmu, "slots"))
 		has_perf_metrics =3D true;
=20
diff --git a/tools/perf/bench/pmu-scan.c b/tools/perf/bench/pmu-scan.c
index 1d7dd4b203e0..754486d1d87b 100644
--- a/tools/perf/bench/pmu-scan.c
+++ b/tools/perf/bench/pmu-scan.c
@@ -77,6 +77,7 @@ static int save_result(void)
=20
 static int check_result(bool core_only)
 {
+	struct perf_pmus *pmus =3D perf_env__pmus(host_env());
 	struct pmu_scan_result *r;
 	struct perf_pmu *pmu;
 	struct list_head *list;
@@ -87,7 +88,7 @@ static int check_result(bool core_only)
 		if (core_only && !r->is_core)
 			continue;
=20
-		pmu =3D perf_pmus__find(r->name);
+		pmu =3D perf_pmus__find(pmus, r->name);
 		if (pmu =3D=3D NULL) {
 			pr_err("Cannot find PMU %s\n", r->name);
 			return -1;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8706798290eb..f81192cec481 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1982,6 +1982,7 @@ static int default_evlist_evsel_cmp(void *priv __mayb=
e_unused,
 static int add_default_events(void)
 {
 	const char *pmu =3D parse_events_option_args.pmu_filter ?: "all";
+	struct perf_pmus *pmus =3D perf_env__pmus(host_env());
 	struct parse_events_error err;
 	struct evlist *evlist =3D evlist__new();
 	struct evsel *evsel;
@@ -2002,7 +2003,7 @@ static int add_default_events(void)
 		 * will use this approach. To determine transaction support
 		 * on an architecture test for such a metric name.
 		 */
-		if (!metricgroup__has_metric_or_groups(pmu, "transaction")) {
+		if (!metricgroup__has_metric_or_groups(pmus, pmu, "transaction")) {
 			pr_err("Missing transaction metrics\n");
 			ret =3D -1;
 			goto out;
@@ -2037,7 +2038,7 @@ static int add_default_events(void)
 			smi_reset =3D true;
 		}
=20
-		if (!metricgroup__has_metric_or_groups(pmu, "smi")) {
+		if (!metricgroup__has_metric_or_groups(pmus, pmu, "smi")) {
 			pr_err("Missing smi metrics\n");
 			ret =3D -1;
 			goto out;
@@ -2113,7 +2114,8 @@ static int add_default_events(void)
 		for (size_t i =3D 0; i < ARRAY_SIZE(default_metricgroup_names); i++) {
 			struct evlist *metric_evlist;
=20
-			if (!metricgroup__has_metric_or_groups(pmu, default_metricgroup_names[i=
]))
+			if (!metricgroup__has_metric_or_groups(pmus, pmu,
+							       default_metricgroup_names[i]))
 				continue;
=20
 			if ((int)i > detailed_run)
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-event=
s.c
index 8969bcf004ea..c95f6d6f5854 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -641,7 +641,7 @@ static int test__checkevent_pmu(struct evlist *evlist)
 {
=20
 	struct evsel *evsel =3D evlist__first(evlist);
-	struct perf_pmu *core_pmu =3D perf_pmus__find_core_pmu();
+	struct perf_pmu *core_pmu =3D perf_pmus__find_core_pmu(perf_env__pmus(hos=
t_env()));
=20
 	TEST_ASSERT_EVSEL("wrong number of entries", 1 =3D=3D evlist__nr_entries(=
evlist), evsel);
 	TEST_ASSERT_EVSEL("wrong type", core_pmu->type =3D=3D evsel->core.attr.ty=
pe, evsel);
@@ -705,7 +705,7 @@ static int test__checkevent_list(struct evlist *evlist)
 static int test__checkevent_pmu_name(struct evlist *evlist)
 {
 	struct evsel *evsel =3D evlist__first(evlist);
-	struct perf_pmu *core_pmu =3D perf_pmus__find_core_pmu();
+	struct perf_pmu *core_pmu =3D perf_pmus__find_core_pmu(perf_env__pmus(hos=
t_env()));
 	char buf[256];
=20
 	/* default_core/config=3D1,name=3Dkrava/u */
@@ -729,7 +729,7 @@ static int test__checkevent_pmu_name(struct evlist *evl=
ist)
 static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evli=
st)
 {
 	struct evsel *evsel =3D evlist__first(evlist);
-	struct perf_pmu *core_pmu =3D perf_pmus__find_core_pmu();
+	struct perf_pmu *core_pmu =3D perf_pmus__find_core_pmu(perf_env__pmus(hos=
t_env()));
=20
 	/* default_core/config=3D1,call-graph=3Dfp,time,period=3D100000/ */
 	TEST_ASSERT_EVLIST("wrong number of entries",
@@ -762,7 +762,7 @@ static int test__checkevent_pmu_partial_time_callgraph(=
struct evlist *evlist)
 static int test__checkevent_pmu_events(struct evlist *evlist)
 {
 	struct evsel *evsel;
-	struct perf_pmu *core_pmu =3D perf_pmus__find_core_pmu();
+	struct perf_pmu *core_pmu =3D perf_pmus__find_core_pmu(perf_env__pmus(hos=
t_env()));
=20
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 <=3D evlist__nr_entries(e=
vlist), evlist);
=20
@@ -1768,7 +1768,7 @@ static int test__checkevent_config_cache(struct evlis=
t *evlist)
=20
 static bool test__pmu_default_core_event_valid(void)
 {
-	struct perf_pmu *pmu =3D perf_pmus__find_core_pmu();
+	struct perf_pmu *pmu =3D perf_pmus__find_core_pmu(perf_env__pmus(host_env=
()));
=20
 	if (!pmu)
 		return false;
@@ -1778,7 +1778,7 @@ static bool test__pmu_default_core_event_valid(void)
=20
 static bool test__intel_pt_valid(void)
 {
-	return !!perf_pmus__find("intel_pt");
+	return !!perf_pmus__find(perf_env__pmus(host_env()), "intel_pt");
 }
=20
 static int test__intel_pt(struct evlist *evlist)
@@ -2624,7 +2624,7 @@ static int combine_test_results(int existing, int lat=
est)
 static int test_events(const struct evlist_test *events, int cnt)
 {
 	int ret =3D TEST_OK;
-	struct perf_pmu *core_pmu =3D perf_pmus__find_core_pmu();
+	struct perf_pmu *core_pmu =3D perf_pmus__find_core_pmu(perf_env__pmus(hos=
t_env()));
=20
 	for (int i =3D 0; i < cnt; i++) {
 		struct evlist_test e =3D events[i];
diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace/b=
eauty/perf_event_open.c
index bfdf322c6ede..edf156995be6 100644
--- a/tools/perf/trace/beauty/perf_event_open.c
+++ b/tools/perf/trace/beauty/perf_event_open.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: LGPL-2.1
 #include <string.h>
 #include "trace/beauty/beauty.h"
+#include "util/env.h"
 #include "util/evsel_fprintf.h"
 #include <linux/perf_event.h>
=20
@@ -75,7 +76,8 @@ static size_t perf_event_attr___scnprintf(struct perf_eve=
nt_attr *attr, char *bf
 		.bf	 =3D bf,
 	};
=20
-	perf_event_attr__fprintf(stdout, attr, attr__fprintf, &args);
+	perf_event_attr__fprintf(stdout, attr, attr__fprintf, &args,
+				 perf_env__pmus(host_env()));
 	return args.printed + scnprintf(bf + args.printed, size - args.printed, "=
 }");
 }
=20
diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index e365f807b021..60928c490eb1 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -3,6 +3,7 @@
=20
 #include "addr_location.h"
 #include "debug.h"
+#include "env.h"
 #include "event.h"
 #include "evsel.h"
 #include "evlist.h"
@@ -1255,9 +1256,10 @@ void aslr_tool__strip_attr_event(union perf_event *e=
vent, struct evlist *evlist)
 		    attr_size >=3D (offsetof(struct perf_event_attr, bp_addr) + sizeof(u=
64))) {
 			event->attr.attr.bp_addr =3D 0;
 		} else if (type >=3D PERF_TYPE_MAX) {
+			struct perf_env *env =3D evlist__env(evlist) ?: host_env();
 			struct perf_pmu *pmu;
=20
-			pmu =3D perf_pmus__find_by_type(type);
+			pmu =3D perf_pmus__find_by_type(perf_env__pmus(env), type);
 			if (pmu && (!strcmp(pmu->name, "kprobe") ||
 				    !strcmp(pmu->name, "uprobe"))) {
 				if (attr_size >=3D (offsetof(struct perf_event_attr, config1) + sizeof=
(u64)))
@@ -1407,6 +1409,7 @@ int aslr_tool__cache_orig_attrs(struct perf_tool *too=
l, struct evsel *evsel)
=20
 void aslr_tool__strip_evlist(const struct perf_tool *tool __maybe_unused, =
struct evlist *evlist)
 {
+	struct perf_pmus *pmus =3D perf_env__pmus(evlist__env(evlist) ?: host_env=
());
 	struct evsel *evsel;
=20
 	evlist__for_each_entry(evlist, evsel) {
@@ -1419,7 +1422,7 @@ void aslr_tool__strip_evlist(const struct perf_tool *=
tool __maybe_unused, struct
 		if (evsel->core.attr.type =3D=3D PERF_TYPE_BREAKPOINT) {
 			evsel->core.attr.bp_addr =3D 0;
 		} else if (evsel->core.attr.type >=3D PERF_TYPE_MAX) {
-			struct perf_pmu *pmu =3D perf_pmus__find_by_type(evsel->core.attr.type)=
;
+			struct perf_pmu *pmu =3D perf_pmus__find_by_type(pmus, evsel->core.attr=
.type);
=20
 			if (pmu && (!strcmp(pmu->name, "kprobe") ||
 				    !strcmp(pmu->name, "uprobe"))) {
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 5f16920f0a89..4f4ec49b6a6b 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -616,7 +616,7 @@ int perf_env__read_core_pmu_caps(struct perf_env *env)
 		return -ENODEV;
=20
 	if (nr_pmu =3D=3D 1) {
-		pmu =3D perf_pmus__find_core_pmu();
+		pmu =3D perf_pmus__find_core_pmu(pmus);
 		if (!pmu)
 			return -ENODEV;
 		ret =3D perf_pmu__caps_parse(pmu);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2fa8a0036375..9d58b9bfa8b6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2472,7 +2472,8 @@ static void display_attr(struct perf_event_attr *attr=
)
 	if (verbose >=3D 2 || debug_peo_args) {
 		fprintf(stderr, "%.60s\n", graph_dotted_line);
 		fprintf(stderr, "perf_event_attr:\n");
-		perf_event_attr__fprintf(stderr, attr, __open_attr__fprintf, NULL);
+		perf_event_attr__fprintf(stderr, attr, __open_attr__fprintf, NULL,
+					 perf_env__pmus(host_env()));
 		fprintf(stderr, "%.60s\n", graph_dotted_line);
 	}
 }
@@ -4317,7 +4318,8 @@ bool evsel__fallback(struct evsel *evsel, struct targ=
et *target, int err,
 		 * available even if no PMU support. PPC returned ENXIO rather
 		 * than ENODEV or ENOENT until 2.6.37.
 		 */
-		evsel->pmu =3D perf_pmus__find_by_type(PERF_TYPE_SOFTWARE);
+		evsel->pmu =3D perf_pmus__find_by_type(perf_env__pmus(host_env()),
+						     PERF_TYPE_SOFTWARE);
 		assert(evsel->pmu); /* software is a "well-known" and can't fail PMU typ=
e. */
=20
 		/* Configure the event. */
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprint=
f.c
index 0f7a25500a44..ed7d13461575 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -2,6 +2,7 @@
 #include <inttypes.h>
 #include <stdio.h>
 #include <stdbool.h>
+#include "util/env.h"
 #include "util/evlist.h"
 #include "evsel.h"
 #include "util/evsel_fprintf.h"
@@ -66,8 +67,11 @@ int evsel__fprintf(struct evsel *evsel, struct perf_attr=
_details *details, FILE
 	printed +=3D fprintf(fp, "%s", evsel__name(evsel));
=20
 	if (details->verbose) {
+		struct perf_env *env =3D evsel__env(evsel) ?: host_env();
+
 		printed +=3D perf_event_attr__fprintf(fp, &evsel->core.attr,
-						    __print_attr__fprintf, &first);
+						    __print_attr__fprintf, &first,
+						    perf_env__pmus(env));
 	} else if (details->freq) {
 		const char *term =3D "sample_freq";
=20
diff --git a/tools/perf/util/evsel_fprintf.h b/tools/perf/util/evsel_fprint=
f.h
index c8a9fac2f2dd..792437ceb578 100644
--- a/tools/perf/util/evsel_fprintf.h
+++ b/tools/perf/util/evsel_fprintf.h
@@ -6,6 +6,7 @@
 #include <stdbool.h>
=20
 struct evsel;
+struct perf_pmus;
=20
 struct perf_attr_details {
 	bool freq;
@@ -46,5 +47,6 @@ int sample__fprintf_sym(struct perf_sample *sample, struc=
t addr_location *al,
 typedef int (*attr__fprintf_f)(FILE *, const char *, const char *, void *)=
;
=20
 int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
-			     attr__fprintf_f attr__fprintf, void *priv);
+			     attr__fprintf_f attr__fprintf, void *priv,
+			     struct perf_pmus *pmus);
 #endif // __PERF_EVSEL_H
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index b6f86f557caf..48ff46c165fd 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1704,7 +1704,7 @@ static int __write_pmu_caps(struct feat_fd *ff, struc=
t perf_pmu *pmu,
 static int write_cpu_pmu_caps(struct feat_fd *ff,
 			      struct evlist *evlist __maybe_unused)
 {
-	struct perf_pmu *cpu_pmu =3D perf_pmus__find_core_pmu();
+	struct perf_pmu *cpu_pmu =3D perf_pmus__find_core_pmu(perf_env__pmus(host=
_env()));
 	int ret;
=20
 	if (!cpu_pmu)
@@ -2492,6 +2492,7 @@ static int __desc_attr__fprintf(FILE *fp, const char =
*name, const char *val,
=20
 static void print_event_desc(struct feat_fd *ff, FILE *fp)
 {
+	struct perf_pmus *pmus =3D perf_env__pmus(&ff->ph->env);
 	struct evsel *evsel, *events;
 	u32 j;
 	u64 *id;
@@ -2519,7 +2520,7 @@ static void print_event_desc(struct feat_fd *ff, FILE=
 *fp)
 			fprintf(fp, " }");
 		}
=20
-		perf_event_attr__fprintf(fp, &evsel->core.attr, __desc_attr__fprintf, NU=
LL);
+		perf_event_attr__fprintf(fp, &evsel->core.attr, __desc_attr__fprintf, NU=
LL, pmus);
=20
 		fputc('\n', fp);
 	}
@@ -5735,7 +5736,8 @@ size_t perf_event__fprintf_event_update(union perf_ev=
ent *event, FILE *fp)
=20
 size_t perf_event__fprintf_attr(union perf_event *event, FILE *fp)
 {
-	return perf_event_attr__fprintf(fp, &event->attr.attr, __desc_attr__fprin=
tf, NULL);
+	return perf_event_attr__fprintf(fp, &event->attr.attr, __desc_attr__fprin=
tf, NULL,
+					perf_env__pmus(host_env()));
 }
=20
 int perf_event__process_attr(const struct perf_tool *tool __maybe_unused,
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 63aa326944d7..593032197edd 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -388,14 +388,14 @@ static bool match_metric_or_groups(const char *metric=
_or_groups, const char *sou
 	return m && match_metric_or_groups(m + 1, sought);
 }
=20
-static bool match_pm_metric_or_groups(const struct pmu_metric *pm, const c=
har *pmu,
-				      const char *metric_or_groups)
+static bool match_pm_metric_or_groups(struct perf_pmus *pmus, const struct=
 pmu_metric *pm,
+				      const char *pmu, const char *metric_or_groups)
 {
 	const char *pm_pmu =3D pm->pmu ?: "cpu";
 	struct perf_pmu *perf_pmu =3D NULL;
=20
 	if (pm->pmu)
-		perf_pmu =3D perf_pmus__find(pm->pmu);
+		perf_pmu =3D perf_pmus__find(pmus, pm->pmu);
=20
 	if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu) &&
 	   (perf_pmu && !perf_pmu__name_wildcard_match(perf_pmu, pmu)))
@@ -697,6 +697,7 @@ struct metricgroup_add_iter_data {
 };
=20
 static int add_metric(struct list_head *metric_list,
+		      struct perf_pmus *pmus,
 		      const struct pmu_metric *pm,
 		      const char *modifier,
 		      bool metric_no_group,
@@ -722,6 +723,7 @@ static int metricgroup__find_metric_callback(const stru=
ct pmu_metric *pm,
  * resolve_metric - Locate metrics within the root metric and recursively =
add
  *                    references to them.
  * @metric_list: The list the metric is added to.
+ * @pmus: The PMUs collection for resolving referenced metrics.
  * @pmu: The PMU name to resolve metrics on, or "all" for all PMUs.
  * @modifier: if non-null event modifiers like "u".
  * @metric_no_group: Should events written to events be grouped "{}" or
@@ -739,6 +741,7 @@ static int metricgroup__find_metric_callback(const stru=
ct pmu_metric *pm,
  *       architecture perf is running upon.
  */
 static int resolve_metric(struct list_head *metric_list,
+			  struct perf_pmus *pmus,
 			  struct perf_pmu *pmu,
 			  const char *modifier,
 			  bool metric_no_group,
@@ -793,7 +796,7 @@ static int resolve_metric(struct list_head *metric_list=
,
 	 * context.
 	 */
 	for (i =3D 0; i < pending_cnt; i++) {
-		ret =3D add_metric(metric_list, &pending[i].pm, modifier, metric_no_grou=
p,
+		ret =3D add_metric(metric_list, pmus, &pending[i].pm, modifier, metric_n=
o_group,
 				 metric_no_threshold, user_requested_cpu_list, system_wide,
 				 fake_pmu, root_metric, visited, table);
 		if (ret)
@@ -807,6 +810,7 @@ static int resolve_metric(struct list_head *metric_list=
,
 /**
  * __add_metric - Add a metric to metric_list.
  * @metric_list: The list the metric is added to.
+ * @pmus: The PMUs collection for resolving referenced metrics.
  * @pm: The pmu_metric containing the metric to be added.
  * @modifier: if non-null event modifiers like "u".
  * @metric_no_group: Should events written to events be grouped "{}" or
@@ -826,6 +830,7 @@ static int resolve_metric(struct list_head *metric_list=
,
  *       architecture perf is running upon.
  */
 static int __add_metric(struct list_head *metric_list,
+			struct perf_pmus *pmus,
 			const struct pmu_metric *pm,
 			const char *modifier,
 			bool metric_no_group,
@@ -927,11 +932,11 @@ static int __add_metric(struct list_head *metric_list=
,
 		struct perf_pmu *pmu;
=20
 		if (pm->pmu && pm->pmu[0] !=3D '\0')
-			pmu =3D perf_pmus__find(pm->pmu);
+			pmu =3D perf_pmus__find(pmus, pm->pmu);
 		else
 			pmu =3D perf_pmus__scan_core(/*pmu=3D*/ NULL);
=20
-		ret =3D resolve_metric(metric_list, pmu, modifier, metric_no_group,
+		ret =3D resolve_metric(metric_list, pmus, pmu, modifier, metric_no_group=
,
 				     metric_no_threshold, user_requested_cpu_list,
 				     system_wide, fake_pmu, root_metric, &visited_node,
 				     table);
@@ -947,6 +952,7 @@ static int __add_metric(struct list_head *metric_list,
 }
=20
 static int add_metric(struct list_head *metric_list,
+		      struct perf_pmus *pmus,
 		      const struct pmu_metric *pm,
 		      const char *modifier,
 		      bool metric_no_group,
@@ -963,7 +969,7 @@ static int add_metric(struct list_head *metric_list,
 	pr_debug("metric expr %s for %s\n", pm->metric_expr, pm->metric_name);
=20
 	if (!strstr(pm->metric_expr, "?")) {
-		ret =3D __add_metric(metric_list, pm, modifier, metric_no_group,
+		ret =3D __add_metric(metric_list, pmus, pm, modifier, metric_no_group,
 				   metric_no_threshold, 0, user_requested_cpu_list,
 				   system_wide, fake_pmu, root_metric, visited, table);
 	} else {
@@ -977,7 +983,7 @@ static int add_metric(struct list_head *metric_list,
 		 */
=20
 		for (j =3D 0; j < count && !ret; j++)
-			ret =3D __add_metric(metric_list, pm, modifier, metric_no_group,
+			ret =3D __add_metric(metric_list, pmus, pm, modifier, metric_no_group,
 					   metric_no_threshold, j, user_requested_cpu_list,
 					   system_wide, fake_pmu, root_metric, visited, table);
 	}
@@ -1033,6 +1039,7 @@ static int default_metricgroup_cmp(void *priv __maybe=
_unused,
=20
 struct metricgroup__add_metric_data {
 	struct list_head *list;
+	struct perf_pmus *pmus;
 	const char *pmu;
 	const char *metric_name;
 	const char *modifier;
@@ -1051,14 +1058,15 @@ static int metricgroup__add_metric_callback(const s=
truct pmu_metric *pm,
 	struct metricgroup__add_metric_data *data =3D vdata;
 	int ret =3D 0;
=20
-	if (pm->metric_expr && match_pm_metric_or_groups(pm, data->pmu, data->met=
ric_name)) {
+	if (pm->metric_expr && match_pm_metric_or_groups(data->pmus, pm, data->pm=
u,
+							 data->metric_name)) {
 		bool metric_no_group =3D data->metric_no_group ||
 			match_metric_or_groups(pm->metricgroup_no_group, data->metric_name);
=20
 		data->has_match =3D true;
-		ret =3D add_metric(data->list, pm, data->modifier, metric_no_group,
+		ret =3D add_metric(data->list, data->pmus, pm, data->modifier, metric_no=
_group,
 				 data->metric_no_threshold, data->user_requested_cpu_list,
-				data->system_wide, data->fake_pmu, /*root_metric=3D*/NULL,
+				 data->system_wide, data->fake_pmu, /*root_metric=3D*/NULL,
 				 /*visited_metrics=3D*/NULL, table);
 	}
 	return ret;
@@ -1066,6 +1074,7 @@ static int metricgroup__add_metric_callback(const str=
uct pmu_metric *pm,
=20
 /**
  * metricgroup__add_metric - Find and add a metric, or a metric group.
+ * @pmus: The PMUs collection for resolving PMU names and referenced metri=
cs.
  * @pmu: The PMU name to search for metrics on, or "all" for all PMUs.
  * @metric_name: The name of the metric or metric group. For example, "IPC=
"
  *               could be the name of a metric and "TopDownL1" the name of=
 a
@@ -1081,7 +1090,8 @@ static int metricgroup__add_metric_callback(const str=
uct pmu_metric *pm,
  * @table: The table that is searched for metrics, most commonly the table=
 for the
  *       architecture perf is running upon.
  */
-static int metricgroup__add_metric(const char *pmu, const char *metric_nam=
e, const char *modifier,
+static int metricgroup__add_metric(struct perf_pmus *pmus, const char *pmu=
,
+				   const char *metric_name, const char *modifier,
 				   bool metric_no_group, bool metric_no_threshold,
 				   const char *user_requested_cpu_list,
 				   bool system_wide, bool fake_pmu,
@@ -1092,6 +1102,7 @@ static int metricgroup__add_metric(const char *pmu, c=
onst char *metric_name, con
 	int ret;
 	struct metricgroup__add_metric_data data =3D {
 		.list =3D &list,
+		.pmus =3D pmus,
 		.pmu =3D pmu,
 		.metric_name =3D metric_name,
 		.modifier =3D modifier,
@@ -1122,6 +1133,7 @@ static int metricgroup__add_metric(const char *pmu, c=
onst char *metric_name, con
 /**
  * metricgroup__add_metric_list - Find and add metrics, or metric groups,
  *                                specified in a list.
+ * @pmus: The PMUs collection for resolving PMU names and referenced metri=
cs.
  * @pmu: A pmu to restrict the metrics to, or "all" for all PMUS.
  * @list: the list of metrics or metric groups. For example, "IPC,CPI,TopD=
ownL1"
  *        would match the IPC and CPI metrics, and TopDownL1 would match a=
ll
@@ -1136,7 +1148,8 @@ static int metricgroup__add_metric(const char *pmu, c=
onst char *metric_name, con
  * @table: The table that is searched for metrics, most commonly the table=
 for the
  *       architecture perf is running upon.
  */
-static int metricgroup__add_metric_list(const char *pmu, const char *list,
+static int metricgroup__add_metric_list(struct perf_pmus *pmus, const char=
 *pmu,
+					const char *list,
 					bool metric_no_group,
 					bool metric_no_threshold,
 					const char *user_requested_cpu_list,
@@ -1157,7 +1170,7 @@ static int metricgroup__add_metric_list(const char *p=
mu, const char *list,
 		if (modifier)
 			*modifier++ =3D '\0';
=20
-		ret =3D metricgroup__add_metric(pmu, metric_name, modifier,
+		ret =3D metricgroup__add_metric(pmus, pmu, metric_name, modifier,
 					      metric_no_group, metric_no_threshold,
 					      user_requested_cpu_list,
 					      system_wide, fake_pmu,
@@ -1412,6 +1425,7 @@ static int parse_groups(struct evlist *perf_evlist,
 			bool fake_pmu,
 			const struct pmu_metrics_table *table)
 {
+	struct perf_pmus *pmus =3D perf_env__pmus(evlist__env(perf_evlist) ?: hos=
t_env());
 	struct evlist *combined_evlist =3D NULL;
 	LIST_HEAD(metric_list);
 	struct metric *m;
@@ -1419,7 +1433,7 @@ static int parse_groups(struct evlist *perf_evlist,
 	bool is_default =3D !strcmp(str, "Default");
 	int ret;
=20
-	ret =3D metricgroup__add_metric_list(pmu, str, metric_no_group, metric_no=
_threshold,
+	ret =3D metricgroup__add_metric_list(pmus, pmu, str, metric_no_group, met=
ric_no_threshold,
 					   user_requested_cpu_list,
 					   system_wide, fake_pmu,
 					   &metric_list, table);
@@ -1618,6 +1632,7 @@ int metricgroup__parse_groups_test(struct evlist *evl=
ist,
 }
=20
 struct metricgroup__has_metric_data {
+	struct perf_pmus *pmus;
 	const char *pmu;
 	const char *metric_or_groups;
 };
@@ -1628,13 +1643,15 @@ static int metricgroup__has_metric_or_groups_callba=
ck(const struct pmu_metric *p
 {
 	struct metricgroup__has_metric_data *data =3D vdata;
=20
-	return match_pm_metric_or_groups(pm, data->pmu, data->metric_or_groups) ?=
 1 : 0;
+	return match_pm_metric_or_groups(data->pmus, pm, data->pmu, data->metric_=
or_groups) ? 1 : 0;
 }
=20
-bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric=
_or_groups)
+bool metricgroup__has_metric_or_groups(struct perf_pmus *pmus, const char =
*pmu,
+				       const char *metric_or_groups)
 {
 	const struct pmu_metrics_table *table =3D pmu_metrics_table__find();
 	struct metricgroup__has_metric_data data =3D {
+		.pmus =3D pmus,
 		.pmu =3D pmu,
 		.metric_or_groups =3D metric_or_groups,
 	};
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 6a66f14dd01b..bc5d3d21f405 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -10,6 +10,7 @@
 struct evlist;
 struct evsel;
 struct option;
+struct perf_pmus;
 struct print_callbacks;
 struct rblist;
 struct cgroup;
@@ -86,7 +87,8 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
=20
 int metricgroup__for_each_metric(const struct pmu_metrics_table *table, pm=
u_metric_iter_fn fn,
 				 void *data);
-bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric=
_or_groups);
+bool metricgroup__has_metric_or_groups(struct perf_pmus *pmus, const char =
*pmu,
+				       const char *metric_or_groups);
 unsigned int metricgroups__topdown_max_level(void);
 int arch_get_runtimeparam(const struct pmu_metric *pm);
 void metricgroup__rblist_init(struct rblist *metric_events);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.=
c
index b56f0e2d1542..bb99588589f4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -85,7 +85,7 @@ static char *get_config_name(const struct parse_events_te=
rms *head_terms)
 }
=20
 static struct perf_cpu_map *get_config_cpu(const struct parse_events_terms=
 *head_terms,
-					   bool fake_pmu)
+					   struct parse_events_state *parse_state)
 {
 	struct parse_events_term *term;
 	struct perf_cpu_map *cpus =3D NULL;
@@ -102,7 +102,8 @@ static struct perf_cpu_map *get_config_cpu(const struct=
 parse_events_terms *head
 		if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_NUM) {
 			term_cpus =3D perf_cpu_map__new_int(term->val.num);
 		} else {
-			struct perf_pmu *pmu =3D perf_pmus__find(term->val.str);
+			struct perf_pmu *pmu =3D perf_pmus__find(parse_state->pmus,
+							       term->val.str);
=20
 			if (pmu) {
 				term_cpus =3D pmu->is_core && perf_cpu_map__is_empty(pmu->cpus)
@@ -110,7 +111,7 @@ static struct perf_cpu_map *get_config_cpu(const struct=
 parse_events_terms *head
 					    : perf_cpu_map__get(pmu->cpus);
 			} else {
 				term_cpus =3D perf_cpu_map__new(term->val.str);
-				if (!term_cpus && fake_pmu) {
+				if (!term_cpus && parse_state->fake_pmu) {
 					/*
 					 * Assume the PMU string makes sense on a different
 					 * machine and fake a value with all online CPUs.
@@ -929,7 +930,7 @@ do {											\
 			break;
 		}
 		assert(term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR);
-		if (perf_pmus__find(term->val.str) !=3D NULL)
+		if (perf_pmus__find(parse_state->pmus, term->val.str) !=3D NULL)
 			break;
=20
 		map =3D perf_cpu_map__new(term->val.str);
@@ -1429,7 +1430,7 @@ static int __parse_events_add_numeric(struct parse_ev=
ents_state *parse_state,
=20
 	name =3D get_config_name(head_config);
 	metric_id =3D get_config_metric_id(head_config);
-	cpus =3D get_config_cpu(head_config, parse_state->fake_pmu);
+	cpus =3D get_config_cpu(head_config, parse_state);
 	ret =3D __add_event(list, &parse_state->idx, &attr, /*init_attr*/true, na=
me,
 			metric_id, parse_state->pmus, pmu, &config_terms,
 			first_wildcard_match, cpus,
@@ -1471,7 +1472,8 @@ int parse_events_add_numeric(struct parse_events_stat=
e *parse_state,
 		if (found_supported)
 			return 0;
 	}
-	return __parse_events_add_numeric(parse_state, list, perf_pmus__find_by_t=
ype(type),
+	return __parse_events_add_numeric(parse_state, list,
+					perf_pmus__find_by_type(parse_state->pmus, type),
 					type, /*extended_type=3D*/0, config, head_config,
 					/*first_wildcard_match=3D*/NULL);
 }
@@ -1592,7 +1594,7 @@ static int parse_events_add_pmu(struct parse_events_s=
tate *parse_state,
 		return -EINVAL;
 	}
=20
-	term_cpu =3D get_config_cpu(&parsed_terms, parse_state->fake_pmu);
+	term_cpu =3D get_config_cpu(&parsed_terms, parse_state);
 	evsel =3D __add_event(list, &parse_state->idx, &attr, /*init_attr=3D*/tru=
e,
 			    get_config_name(&parsed_terms),
 			    get_config_metric_id(&parsed_terms), parse_state->pmus, pmu,
@@ -1730,7 +1732,7 @@ int parse_events_multi_pmu_add_or_add_pmu(struct pars=
e_events_state *parse_state
 	INIT_LIST_HEAD(*listp);
=20
 	/* Attempt to add to list assuming event_or_pmu is a PMU name. */
-	pmu =3D perf_pmus__find(event_or_pmu);
+	pmu =3D perf_pmus__find(parse_state->pmus, event_or_pmu);
 	if (pmu && !parse_events_add_pmu(parse_state, *listp, pmu, const_parsed_t=
erms,
 					 first_wildcard_match))
 		return 0;
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/ut=
il/perf-regs-arch/perf_regs_x86.c
index 2d80f119629a..920f17b89659 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
@@ -534,7 +534,7 @@ __support_simd_reg_class(uint64_t sample_type, uint16_t=
 qwords,
 	}
=20
 	if (perf_pmus__num_core_pmus(pmus) > 1) {
-		__u64 type =3D perf_pmus__find_core_pmu()->type;
+		__u64 type =3D perf_pmus__find_core_pmu(pmus)->type;
=20
 		attr.config |=3D type << PERF_PMU_TYPE_SHIFT;
 	}
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/pe=
rf_event_attr_fprintf.c
index 2e8be9a357dc..7fd87c0e19f6 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -298,9 +298,10 @@ do {									\
 #define PRINT_ATTRf_bf(_f, _p)	PRINT_ATTRn_bf(#_f, _f, _p, false)
=20
 int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
-			     attr__fprintf_f attr__fprintf, void *priv)
+			     attr__fprintf_f attr__fprintf, void *priv,
+			     struct perf_pmus *pmus)
 {
-	struct perf_pmu *pmu =3D perf_pmus__find_by_type(attr->type);
+	struct perf_pmu *pmu =3D perf_pmus__find_by_type(pmus, attr->type);
 	/*
 	 * size =3D=3D 0 means ABI0 =E2=80=94 the producer didn't set attr.size.
 	 * perf_event__fprintf_attr() may pass the raw mmap'd event
@@ -328,7 +329,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_even=
t_attr *attr,
 		u32 extended_type =3D attr->config >> PERF_PMU_TYPE_SHIFT;
=20
 		if (extended_type)
-			pmu =3D perf_pmus__find_by_type(extended_type);
+			pmu =3D perf_pmus__find_by_type(pmus, extended_type);
 	}
=20
 	PRINT_ATTRn("type", type, p_type_id, true);
diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index ad9bc481da70..c761e701a41d 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -6,6 +6,7 @@
  */
 #include "util/cpumap.h"
 #include "util/debug.h"
+#include "util/env.h"
 #include "util/event.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
@@ -35,6 +36,7 @@ int parse_libpfm_events_option(const struct option *opt, =
const char *str,
 			int unset __maybe_unused)
 {
 	struct evlist *evlist =3D *(struct evlist **)opt->value;
+	struct perf_pmus *pmus =3D perf_env__pmus(host_env());
 	struct perf_event_attr attr;
 	struct perf_pmu *pmu;
 	struct evsel *evsel, *grp_leader =3D NULL;
@@ -84,7 +86,7 @@ int parse_libpfm_events_option(const struct option *opt, =
const char *str,
 			goto error;
 		}
=20
-		pmu =3D perf_pmus__find_by_type((unsigned int)attr.type);
+		pmu =3D perf_pmus__find_by_type(pmus, (unsigned int)attr.type);
 		evsel =3D parse_events__add_event(evlist__nr_entries(evlist),
 						&attr, q, /*metric_id=3D*/NULL,
 						pmu);
@@ -135,7 +137,7 @@ static bool is_libpfm_event_supported(const char *name,=
 struct perf_cpu_map *cpu
 	if (ret !=3D PFM_SUCCESS)
 		return false;
=20
-	pmu =3D perf_pmus__find_by_type((unsigned int)attr.type);
+	pmu =3D perf_pmus__find_by_type(perf_env__pmus(host_env()), (unsigned int=
)attr.type);
 	evsel =3D parse_events__add_event(0, &attr, name, /*metric_id=3D*/NULL, p=
mu);
 	if (evsel =3D=3D NULL)
 		return false;
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 3adb297636b6..903ea3d559e7 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -159,7 +159,7 @@ static struct perf_pmu *pmu_find(struct perf_pmus *pmus=
, const char *name)
 	return NULL;
 }
=20
-static struct perf_pmu *__perf_pmus__find(struct perf_pmus *pmus, const ch=
ar *name)
+struct perf_pmu *perf_pmus__find(struct perf_pmus *pmus, const char *name)
 {
 	struct perf_pmu *pmu;
 	int dirfd;
@@ -167,7 +167,7 @@ static struct perf_pmu *__perf_pmus__find(struct perf_p=
mus *pmus, const char *na
 	unsigned int to_read_pmus =3D 0;
=20
 	if (!strcmp(name, "default_core"))
-		return perf_pmus__find_core_pmu();
+		return perf_pmus__find_core_pmu(pmus);
 	/*
 	 * Once PMU is loaded it stays in the list,
 	 * so we keep us from multiple reading/parsing
@@ -216,11 +216,6 @@ static struct perf_pmu *__perf_pmus__find(struct perf_=
pmus *pmus, const char *na
 	return pmu_find(pmus, name);
 }
=20
-struct perf_pmu *perf_pmus__find(const char *name)
-{
-	return __perf_pmus__find(perf_env__pmus(host_env()), name);
-}
-
 static struct perf_pmu *perf_pmu__find2(struct perf_pmus *pmus, int dirfd,=
 const char *name)
 {
 	struct perf_pmu *pmu;
@@ -340,7 +335,7 @@ static struct perf_pmu *__perf_pmus__find_by_type(struc=
t perf_pmus *pmus, unsign
 	return NULL;
 }
=20
-static struct perf_pmu *pmu_find_by_type(struct perf_pmus *pmus, unsigned =
int type)
+struct perf_pmu *perf_pmus__find_by_type(struct perf_pmus *pmus, unsigned =
int type)
 {
 	unsigned int to_read_pmus;
 	struct perf_pmu *pmu =3D __perf_pmus__find_by_type(pmus, type);
@@ -363,11 +358,6 @@ static struct perf_pmu *pmu_find_by_type(struct perf_p=
mus *pmus, unsigned int ty
 	return pmu;
 }
=20
-struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
-{
-	return pmu_find_by_type(perf_env__pmus(host_env()), type);
-}
-
 /*
  * pmu iterator: If pmu is NULL, we start at the begin, otherwise return t=
he
  * next pmu. Returns NULL on end.
@@ -852,7 +842,7 @@ void perf_pmus__print_raw_pmu_events(struct perf_pmus *=
pmus,
=20
 bool perf_pmus__have_event(struct perf_pmus *pmus, const char *pname, cons=
t char *name)
 {
-	struct perf_pmu *pmu =3D __perf_pmus__find(pmus, pname);
+	struct perf_pmu *pmu =3D perf_pmus__find(pmus, pname);
=20
 	return pmu && perf_pmu__have_event(pmu, name);
 }
@@ -915,14 +905,14 @@ bool perf_pmus__host_supports_extended_type(void)
 struct perf_pmu *perf_pmus__find_by_attr(struct perf_pmus *pmus,
 					 const struct perf_event_attr *attr)
 {
-	struct perf_pmu *pmu =3D pmu_find_by_type(pmus, attr->type);
+	struct perf_pmu *pmu =3D perf_pmus__find_by_type(pmus, attr->type);
 	u32 type =3D attr->type;
 	bool legacy_core_type =3D type =3D=3D PERF_TYPE_HARDWARE || type =3D=3D P=
ERF_TYPE_HW_CACHE;
=20
 	if (!pmu && legacy_core_type && perf_pmus__supports_extended_type(pmus)) =
{
 		type =3D attr->config >> PERF_PMU_TYPE_SHIFT;
=20
-		pmu =3D pmu_find_by_type(pmus, type);
+		pmu =3D perf_pmus__find_by_type(pmus, type);
 	}
 	if (!pmu && (legacy_core_type || type =3D=3D PERF_TYPE_RAW)) {
 		/*
@@ -933,7 +923,7 @@ struct perf_pmu *perf_pmus__find_by_attr(struct perf_pm=
us *pmus,
 		 * PERF_TYPE_RAW, assume the RAW events are going to be handled
 		 * by the first core PMU.
 		 */
-		pmu =3D pmu_scan_core(pmus, NULL);
+		pmu =3D perf_pmus__find_core_pmu(pmus);
 	}
 	return pmu;
 }
@@ -952,9 +942,9 @@ struct perf_pmu *evsel__find_pmu(const struct evsel *ev=
sel)
 	return pmu;
 }
=20
-struct perf_pmu *perf_pmus__find_core_pmu(void)
+struct perf_pmu *perf_pmus__find_core_pmu(struct perf_pmus *pmus)
 {
-	return perf_pmus__scan_core(NULL);
+	return pmu_scan_core(pmus, NULL);
 }
=20
 struct perf_pmu *perf_pmus__add_test_pmu(struct perf_pmus *pmus,
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 45f4bd8b6aa6..cd0c14f8e04b 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -75,8 +75,23 @@ void perf_pmus__init(struct perf_pmus *pmus);
  */
 void perf_pmus__exit(struct perf_pmus *pmus);
=20
-struct perf_pmu *perf_pmus__find(const char *name);
-struct perf_pmu *perf_pmus__find_by_type(unsigned int type);
+/**
+ * perf_pmus__find() - Find a PMU by name in @pmus.
+ * @pmus: The PMU collection to search.
+ * @name: Name of the PMU to look up.
+ *
+ * Return: Pointer to the matching struct perf_pmu, or NULL if not found.
+ */
+struct perf_pmu *perf_pmus__find(struct perf_pmus *pmus, const char *name)=
;
+
+/**
+ * perf_pmus__find_by_type() - Find a PMU by its perf_event_attr type ID.
+ * @pmus: The PMU collection to search.
+ * @type: The PMU type identifier (e.g. PERF_TYPE_RAW or dynamic sysfs typ=
e).
+ *
+ * Return: Pointer to the matching struct perf_pmu, or NULL if not found.
+ */
+struct perf_pmu *perf_pmus__find_by_type(struct perf_pmus *pmus, unsigned =
int type);
=20
 /**
  * perf_pmus__find_by_attr() - Find the PMU corresponding to @attr.
@@ -217,6 +232,12 @@ struct perf_pmu *perf_pmus__add_test_hwmon_pmu(struct =
perf_pmus *pmus,
  * Return: Pointer to the fake struct perf_pmu.
  */
 struct perf_pmu *perf_pmus__fake_pmu(void);
-struct perf_pmu *perf_pmus__find_core_pmu(void);
+/**
+ * perf_pmus__find_core_pmu() - Return the first core PMU in @pmus.
+ * @pmus: The PMU collection to search.
+ *
+ * Return: Pointer to the first core struct perf_pmu, or NULL if none exis=
ts.
+ */
+struct perf_pmu *perf_pmus__find_core_pmu(struct perf_pmus *pmus);
=20
 #endif /* __PMUS_H */
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sampl=
e-raw.c
index aaf8838b2cb2..650dfcba794a 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -24,6 +24,7 @@
=20
 #include "color.h"
 #include "debug.h"
+#include "env.h"
 #include "evlist.h"
 #include "hashmap.h"
 #include "pmu.h"
@@ -352,8 +353,11 @@ void evlist__s390_sample_raw(struct evlist *evlist, un=
ion perf_event *event,
=20
 	/* Display raw data on screen */
 	if (sample->evsel->core.attr.config =3D=3D PERF_EVENT_CPUM_CF_DIAG) {
-		if (!sample->evsel->pmu)
-			sample->evsel->pmu =3D perf_pmus__find("cpum_cf");
+		if (!sample->evsel->pmu) {
+			struct perf_env *env =3D evsel__env(sample->evsel) ?: host_env();
+
+			sample->evsel->pmu =3D perf_pmus__find(perf_env__pmus(env), "cpum_cf");
+		}
 		if (!s390_cpumcfdg_testctr(sample))
 			pr_err("Invalid counter set data encountered\n");
 		else
@@ -375,8 +379,12 @@ void evlist__s390_sample_raw(struct evlist *evlist, un=
ion perf_event *event,
 	if (!s390_pai_all_test(sample)) {
 		pr_err("Invalid %s raw data encountered\n", pai_name);
 	} else {
-		if (!sample->evsel->pmu)
-			sample->evsel->pmu =3D perf_pmus__find_by_type(sample->evsel->core.attr=
.type);
+		if (!sample->evsel->pmu) {
+			struct perf_env *env =3D evsel__env(sample->evsel) ?: host_env();
+
+			sample->evsel->pmu =3D perf_pmus__find_by_type(perf_env__pmus(env),
+								     sample->evsel->core.attr.type);
+		}
 		s390_pai_all_dump(sample);
 	}
 }
--=20
2.56.1.703.gf848ed807c-goog

