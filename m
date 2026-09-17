Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C331568FA0;
	Thu, 17 Sep 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660602; cv=none; b=A2AjlV1OU9J7ersiRF+osXt6M1OGKoGrTUthkm34C4ZT6jzFqU/0OBeEaUUZj4L0N6LSAV/ttcR1oDfYeLKzDKvWhqbe2/+faIIkS+9wcddSJA0WEw/tkjSTEju0aSJv73ReH3biTyxxvD/tuHd+mVdD6+Y6gWW2fKQSmXMxdRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660602; c=relaxed/simple;
	bh=zHcxKbrunYVsvNyJ+cuY8XMv04mlJthI8lf4qJuxCvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etBROGwHzIDU6KOvz6Dp+scKHOzAyBVah8LHjhX5i7n+YFloQINdU9CrFp43At5t15D9ChI6qPIA6Fh3PXjrM0hEr7jlwuTBZBYPWj/5hV3Q4o8YTUvIw+MZPW52cLrcR3jS5sa8ulPK9Nu7we7vPpgycgaV9KES55WNFReM4sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ohd1aqAk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ohd1aqAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EE21F000FF;
	Thu, 17 Sep 2026 15:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789660601;
	bh=T9/PygOUc5Sp8CyqFmmxdPTgMyswLof5Pol5Pa1EloE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ohd1aqAkQutlsIlLBI33fHp+tBCwNkBgf9MFHK3lQ5hMGgax2rGUkU3DKpDOjfKef
	 aMbHigxeFWcBcmgPTwKcAYxlGJpD/9zfgquXi/0LnOYzYj8dlJvtsGdZW2oMrwzXJ1
	 T5AkSeQrKcj3+OkUkSiTVuYBpcKsifFOE34fYqea/G4J8hME9MCpmg58dDSA5GcOZ0
	 pFDX85ublTv0fiVhFnjDktp6pW1LZSI+FrLbcPPxf5R6n7mydOwB8z8mfqR2Nf76a3
	 83JmRdsfPMtXwlg8DHauMijqxzHhk0zm1Z17ae+QeLkVRVD39sJieFGqtJma0u3bEB
	 1xVyJ+w9XFgTQ==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/15] perf mem record: Use the IBS swfilt filter when available
Date: Thu, 17 Sep 2026 12:55:26 -0300
Message-ID: <20260917155528.62607-16-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917155528.62607-1-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

IBS events with exclude_{user,kernel} bits, as used for per-thread
recording when kernel samples are not allowed, are rejected by the
kernel on hardware without the privilege filter, so per-thread 'perf mem
record' fails on AMD:

  $ perf mem record -o /dev/null -- true
  Error:
  Failure to open event 'ibs_op/ldlat=0/u' on PMU 'ibs_op' which will be removed.
  Invalid event (ibs_op/ldlat=0/u) in per-thread mode, enable system wide with '-a'.

Kernel v6.14 added swfilt, a software privilege filter exposed as the
'swfilt' format term, making those events usable per-thread:

  $ perf record -e ibs_op/ldlat=0,swfilt=1/ -- true

Give the ibs_op memory events a name variant with the swfilt term, used
when the PMU exposes it, even when the record ends up without exclude
bits: 'perf record' adds those bits itself when the first open fails,
after the name was built, and that retry needs the term.  This makes the
per-thread 'perf mem record' the data type profiling shell test does
work on AMD kernels with swfilt, and the test's event regex is adjusted
for the added term.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/mem-events.c      | 14 +++++++++++---
 tools/perf/tests/shell/test_data_symbol.sh |  6 ++++--
 tools/perf/util/mem-events.c               | 18 ++++++++++++++----
 tools/perf/util/mem-events.h               |  2 ++
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index b38f519020ff8c6f..a12d410247dfd47e 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -7,7 +7,10 @@
 
 #define MEM_LOADS_AUX		0x8203
 
-#define E(t, n, s, l, a) { .tag = t, .name = n, .event_name = s, .ldlat = l, .aux_event = a }
+#define E_INIT(t, n, s, l, a, sf) {					\
+	.tag = t, .name = n, .event_name = s, .swfilt_name = sf,	\
+	.ldlat = l, .aux_event = a }
+#define E(t, n, s, l, a) E_INIT(t, n, s, l, a, NULL)
 
 struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX] = {
 	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"mem-loads",	true,	0),
@@ -21,14 +24,19 @@ struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX] = {
 	E(NULL,			NULL,				NULL,		false,	0),
 };
 
+/*
+ * IBS events with exclude bits, as used for per-thread recording, are
+ * rejected without the swfilt software filter, so carry a name variant
+ * with the term, used when the PMU exposes it.
+ */
 struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
 	E(NULL,		NULL,		NULL,	false,	0),
 	E(NULL,		NULL,		NULL,	false,	0),
-	E("mem-ldst",	"%s//",		NULL,	false,	0),
+	E_INIT("mem-ldst",	"%s//",		NULL,	false,	0, "%s/swfilt=1/"),
 };
 
 struct perf_mem_event perf_mem_events_amd_ldlat[PERF_MEM_EVENTS__MAX] = {
 	E(NULL,		NULL,		NULL,	false,	0),
 	E(NULL,		NULL,		NULL,	false,	0),
-	E("mem-ldst",	"%s/ldlat=%u/",	NULL,	true,	0),
+	E_INIT("mem-ldst",	"%s/ldlat=%u/",	NULL,	true,	0, "%s/ldlat=%u,swfilt=1/"),
 };
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
index 0b49fce251fcc184..f45598aa89825d79 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -82,6 +82,7 @@ static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
 					     char *buf, size_t buf_size)
 {
 	struct perf_mem_event *e;
+	const char *name;
 
 	if (i >= PERF_MEM_EVENTS__MAX || !pmu)
 		return NULL;
@@ -90,24 +91,33 @@ static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
 	if (!e || !e->name)
 		return NULL;
 
+	/*
+	 * Use the swfilt variant when the PMU exposes the term: 'perf record'
+	 * adds exclude bits itself when the first open fails, after this name
+	 * was built, and that retry needs the term in the name.
+	 */
+	name = e->name;
+	if (e->swfilt_name && perf_pmu__has_format(pmu, "swfilt"))
+		name = e->swfilt_name;
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
@@ -117,7 +127,7 @@ static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
 
 	if (i == PERF_MEM_EVENTS__STORE) {
 		scnprintf(buf, buf_size,
-			  e->name, pmu->name);
+			  name, pmu->name);
 		return buf;
 	}
 
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 5b98076904b0b689..41f628fad10709b9 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -11,6 +11,8 @@ struct perf_mem_event {
 	u32		aux_event;
 	const char	*tag;
 	const char	*name;
+	/* Name with the swfilt software privilege filter, when supported. */
+	const char	*swfilt_name;
 	const char	*event_name;
 };
 
-- 
2.55.0

