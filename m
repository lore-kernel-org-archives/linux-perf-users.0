Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A744CA792;
	Thu, 24 Sep 2026 21:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285323; cv=none; b=OEPI9pqtXcGxTY9zN6fmyRNm9NbP4B41rtjNAEX7DB9ymFH+WppJqNu4lt4o2CWW33VBLKiF5AbElYOALfKMbfmkaKlKJAv7pe2nDqf1I66gTOpIwfDKeV+cB5Rs6CgRrb7edIxZbqr+hA2GOMxewccfZ9dFgWNQb5OfaGF8zfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285323; c=relaxed/simple;
	bh=/GJ7wQeujE2k15+Nr0kcXEqBEva8hSxHBFKwsjn3ZTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqldK/MYaWpZoaI/FcSz3JakNgwJhOP5oXW0c2+2CedDS8BNAZYtd/XDaFE1u4lru8eROqr+Zu9uDtn3pPYRkrMxE5/RPOjcO78qGiuQ/SE3KCyZh0SlL8nIpiz0VnSyTx7mOcKxC0kekVksvQ/2hSTUL/y1V2Kxf4uNCjWJdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jlt+a+gy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jlt+a+gy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BD51F00893;
	Thu, 24 Sep 2026 21:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790285318;
	bh=fZrXkLdukQjv+IF7qhRN58lTYVZPpg5i2UitoGtzgfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jlt+a+gyMDIRul40aOZi7dCT77O6+A1rjtIOrGInKRkOVD5FduizWYo5e4uC9/u7p
	 msQLf8bsvB/YNSJ+16bJMb6acb85S192hPMh0OIMtKNt8DlBANd0A2mY3viDOMgUVL
	 m19seylwai5aX6eDlEgIYxGi6PvAiU8Bi0zKDLmxWdh5WnOWHpBybdCQihk2y5iCcv
	 DmSuL0bvOFYU8mhEkymuooSPe6V5rSTb+s3pfGygL1X+QsWJ8tsjT+oDU/iTZsCl4I
	 pDA8VTRPgxcB3OM9Nq/WFNLBaGm4Sd+gcLzhFrRdJPqWjlFvZoBYk57wMGdc7nWRYD
	 U5XAe1eUju1vQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH v4 6/6] perf mem record: Use the IBS swfilt filter when available
Date: Thu, 24 Sep 2026 23:28:09 +0200
Message-ID: <20260924212809.1733663-7-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924212809.1733663-1-acme@kernel.org>
References: <20260924212809.1733663-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

IBS events with exclude_{user,kernel} bits, as used for per-thread
recording when kernel samples are not allowed, are rejected on hardware
without the privilege filter, so per-thread 'perf mem record' fails on
AMD:

  $ perf mem record -o /dev/null -- true
  Failure to open event 'ibs_op/ldlat=0/u' on PMU 'ibs_op' which will be removed.

Kernel v6.14 added swfilt, a software privilege filter exposed as the
'swfilt' format term, making those events usable per-thread.  Give the
ibs_op memory events extra tables with the term, selected in
perf_pmu__arch_init() when the PMU exposes it, keeping the names that
need system wide mode otherwise; the knowledge that IBS needs this
stays in the arch code.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Suggested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/mem-events.c      | 19 +++++++++++++++++++
 tools/perf/arch/x86/util/mem-events.h      |  2 ++
 tools/perf/arch/x86/util/pmu.c             | 10 ++++++++--
 tools/perf/tests/shell/test_data_symbol.sh |  6 ++++--
 tools/perf/util/mem-events.c               | 11 +++++++----
 5 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index b38f519020ff8c6f..156974ead7d42a82 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -21,14 +21,33 @@ struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX] = {
 	E(NULL,			NULL,				NULL,		false,	0),
 };
 
+/*
+ * IBS events with exclude_{user,kernel} bits are rejected on hardware
+ * without the privilege filter unless swfilt is used: the extra tables
+ * carry the term, selected when the PMU exposes it.  Keep it even when
+ * the event has no exclude bits yet, 'perf record' adds them on the
+ * first open failure and retries with the same name.
+ */
 struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
 	E(NULL,		NULL,		NULL,	false,	0),
 	E(NULL,		NULL,		NULL,	false,	0),
 	E("mem-ldst",	"%s//",		NULL,	false,	0),
 };
 
+struct perf_mem_event perf_mem_events_amd_swfilt[PERF_MEM_EVENTS__MAX] = {
+	E(NULL,		NULL,		NULL,	false,	0),
+	E(NULL,		NULL,		NULL,	false,	0),
+	E("mem-ldst",	"%s/swfilt=1/",	NULL,	false,	0),
+};
+
 struct perf_mem_event perf_mem_events_amd_ldlat[PERF_MEM_EVENTS__MAX] = {
 	E(NULL,		NULL,		NULL,	false,	0),
 	E(NULL,		NULL,		NULL,	false,	0),
 	E("mem-ldst",	"%s/ldlat=%u/",	NULL,	true,	0),
 };
+
+struct perf_mem_event perf_mem_events_amd_ldlat_swfilt[PERF_MEM_EVENTS__MAX] = {
+	E(NULL,		NULL,			NULL,	false,	0),
+	E(NULL,		NULL,			NULL,	false,	0),
+	E("mem-ldst",	"%s/ldlat=%u,swfilt=1/",	NULL,	true,	0),
+};
diff --git a/tools/perf/arch/x86/util/mem-events.h b/tools/perf/arch/x86/util/mem-events.h
index 11e09a256f5bb084..f707de38037017c1 100644
--- a/tools/perf/arch/x86/util/mem-events.h
+++ b/tools/perf/arch/x86/util/mem-events.h
@@ -6,6 +6,8 @@ extern struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX];
 extern struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX];
 
 extern struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX];
+extern struct perf_mem_event perf_mem_events_amd_swfilt[PERF_MEM_EVENTS__MAX];
 extern struct perf_mem_event perf_mem_events_amd_ldlat[PERF_MEM_EVENTS__MAX];
+extern struct perf_mem_event perf_mem_events_amd_ldlat_swfilt[PERF_MEM_EVENTS__MAX];
 
 #endif /* _X86_MEM_EVENTS_H */
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 2c24ef3140da5e9b..fd4491fda117e51a 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -333,6 +333,7 @@ static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha
 void perf_pmu__arch_init(struct perf_pmu *pmu)
 {
 	struct perf_pmu_caps *ldlat_cap;
+	bool swfilt_format;
 
 	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
 		pmu->auxtrace = true;
@@ -348,7 +349,10 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
 		if (strcmp(pmu->name, "ibs_op"))
 			return;
 
-		pmu->mem_events = perf_mem_events_amd;
+		swfilt_format = perf_pmu__has_format(pmu, "swfilt");
+		pmu->mem_events = swfilt_format ?
+				  perf_mem_events_amd_swfilt :
+				  perf_mem_events_amd;
 
 		if (!perf_pmu__caps_parse(pmu))
 			return;
@@ -358,7 +362,9 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
 			return;
 
 		perf_mem_events__loads_ldlat = 0;
-		pmu->mem_events = perf_mem_events_amd_ldlat;
+		pmu->mem_events = swfilt_format ?
+				  perf_mem_events_amd_ldlat_swfilt :
+				  perf_mem_events_amd_ldlat;
 	} else {
 		if (pmu->is_core) {
 			if (perf_pmu__have_event(pmu, "mem-loads-aux"))
diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
index d61b5659a46d9a77..52c837fddb639595 100755
--- a/tools/perf/tests/shell/test_data_symbol.sh
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -65,15 +65,17 @@ if (($is_amd >= 1)); then
 	# --ldlat on AMD:
 	# o Zen4 and earlier uarch does not support ldlat
 	# o Even on supported platforms, it's disabled (--ldlat=0) by default.
+	# o Kernels with the swfilt term add it even when ldlat is not
+	#   supported, so only check ldlat when the term is present.
 	ldlat=${BASH_REMATCH[1]}
-	if [[ -n $ldlat ]]; then
+	if [[ $ldlat == *ldlat=* ]]; then
 		if ! [[ "$ldlat" =~ ldlat=0 ]]; then
 			echo "ERROR: ldlat not initialized to 0?"
 			exit 1
 		fi
 
 		mem_events="$(perf mem record -v --ldlat=150 -e list 2>&1)"
-		if ! [[ "$mem_events" =~ ^mem-ldst.*ibs_op/ldlat=150/.*available ]]; then
+		if ! [[ "$mem_events" =~ ^mem-ldst.*ibs_op/ldlat=150[,/].*available ]]; then
 			echo "ERROR: --ldlat not honored?"
 			exit 1
 		fi
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 0b49fce251fcc184..0b07011939d7d7c3 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -82,6 +82,7 @@ static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
 					     char *buf, size_t buf_size)
 {
 	struct perf_mem_event *e;
+	const char *name;
 
 	if (i >= PERF_MEM_EVENTS__MAX || !pmu)
 		return NULL;
@@ -90,24 +91,26 @@ static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
 	if (!e || !e->name)
 		return NULL;
 
+	name = e->name;
+
 	if (i == PERF_MEM_EVENTS__LOAD || i == PERF_MEM_EVENTS__LOAD_STORE) {
 		if (e->ldlat) {
 			if (!e->aux_event) {
 				/* ARM and Most of Intel */
 				scnprintf(buf, buf_size,
-					  e->name, pmu->name,
+					  name, pmu->name,
 					  perf_mem_events__loads_ldlat);
 			} else {
 				/* Intel with mem-loads-aux event */
 				scnprintf(buf, buf_size,
-					  e->name, pmu->name, pmu->name,
+					  name, pmu->name, pmu->name,
 					  perf_mem_events__loads_ldlat);
 			}
 		} else {
 			if (!e->aux_event) {
 				/* AMD and POWER */
 				scnprintf(buf, buf_size,
-					  e->name, pmu->name);
+					  name, pmu->name);
 			} else {
 				return NULL;
 			}
@@ -117,7 +120,7 @@ static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
 
 	if (i == PERF_MEM_EVENTS__STORE) {
 		scnprintf(buf, buf_size,
-			  e->name, pmu->name);
+			  name, pmu->name);
 		return buf;
 	}
 
-- 
2.53.0

