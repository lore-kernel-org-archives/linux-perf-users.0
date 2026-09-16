Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129164C33DF;
	Wed, 16 Sep 2026 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583588; cv=none; b=pyaAspLSMVmVNZAQHdi/biqnnFcYQOepTybUnK5mQcp9CKKeStoc076JxCHt0b5pOlLiP0jQg8HJQt81/zJcnyeb5fflgwwy2Vx/mY9DOfA9+qJ3KSob3H91A5HLZaXLpCEpPAnLeRpF/Fmpb7Qh6/w1pAf2wNN1kiXqsGG8FMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583588; c=relaxed/simple;
	bh=0RrEKkQQ18XV851YtvsGnUyVTlvFAQUr15uGrg82rLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSva4cEEUKz4AzolwV1Kgp2aBah6zg7B/TO/yM/44emPY+hYyrQh1cUYUaNYiyFAAuSzEh8JCSky+OdLQ9MDm8yk8xKi8/MSNG/Jtb4xPAhIRnxksXULQPTFtIEleciFAwxyc33mHGx2W+bnM9sJeICmL7n7NWUHA3feD4g0J+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvreR9QT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvreR9QT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7451F000FF;
	Wed, 16 Sep 2026 18:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583581;
	bh=xZGMU8f+NYH2x2PwqSoReKlyDd/t+XJGm61nMsMGlLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dvreR9QT6Byk+96IHQPsaAPVPFAeG3kDyIzKfN4tf8O5IVdkwellZCvzpgdidlgGh
	 AJohEmQRvBegIHeMSXhBARFcqKGenQsgaP2aVpVQiWz7oTYcJaWHtZeaH/BqIIUeHI
	 O4ETeNr1aagBW0rG/q7/iseqp/nxVUwWT9VADJ8I91xWzB+nGMdVQ2RZWN0yvlkPMi
	 K2Q181bFihGxqHYr39lwEx22yg16j/yhW2qzF1NWlST8/hhWQQQdyYL+1suO4QV6go
	 hgo64kEqiftUeaqjhleQMQ+crUsaJp/KD/6KIQEXfKXS7bN4A9SJ+u2kcfJzkzeuhJ
	 e6S6+/mLR0joQ==
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
Subject: [PATCH 12/12] perf mem record: Use the IBS swfilt filter when available
Date: Wed, 16 Sep 2026 15:32:13 -0300
Message-ID: <20260916183215.54305-13-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916183215.54305-1-acme@kernel.org>
References: <20260916183215.54305-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

IBS events with exclude_{user,kernel} bits, as used in per-thread mode
when kernel samples are not allowed, are rejected by the kernel on
hardware without the privilege filter, so a per-thread 'perf mem
record' fails:

  $ perf mem record -o /dev/null -- true
  Error:
  Failure to open event 'ibs_op/ldlat=0/u' on PMU 'ibs_op' which will be removed.
  Invalid event (ibs_op/ldlat=0/u) in per-thread mode, enable system wide with '-a'.

Kernel v6.14 added swfilt, a software privilege filter that makes those
events usable per-thread, exposed as the 'swfilt' format term
(d29e744c71673a71 "perf/x86: Relax privilege filter restriction on AMD
IBS"):

  $ perf record -e ibs_op/ldlat=0,swfilt=1/ -- true

Give the ibs_op memory events a name variant with the swfilt term, used
when the PMU exposes it as a format term, keeping the names that need
system wide mode otherwise.

The variant is used even for records that end up without exclude bits,
e.g. a plain system wide one: perf record adds those bits itself when
the first open fails with EACCES on an unprivileged setup, after the
event name has been built, so the term has to be in it for that retry:

  $ perf record -v -e ibs_op/ldlat=0/ -- true
  kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
  Failure to open event 'ibs_op/ldlat=0/u' on PMU 'ibs_op' which will be removed.
  Invalid event (ibs_op/ldlat=0/u) in per-thread mode, enable system wide with '-a'.

With no exclude bits the kernel discards nothing.

This makes the per-thread 'perf mem record' that the data type profiling
shell test does work: the skip added by patch 1 is driven by that record
failing, so it now runs on AMD kernels with swfilt, and keeps skipping on
kernels without it.  The 'Test data symbol' shell test matches the exact
ibs_op event string, so its regex now accepts terms added after
ldlat=150, and it only checks ldlat when the captured term has it: on
uarch without ldlat the swfilt variant makes the capture non-empty
("swfilt=1"), that the old 'ldlat=0' check would reject.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/mem-events.c      | 17 ++++++++++++++---
 tools/perf/tests/shell/test_data_symbol.sh |  6 ++++--
 tools/perf/util/mem-events.c               | 21 +++++++++++++++++----
 tools/perf/util/mem-events.h               |  2 ++
 4 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index b38f519020ff8c6f..034053dc762101dc 100644
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
@@ -21,14 +24,22 @@ struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX] = {
 	E(NULL,			NULL,				NULL,		false,	0),
 };
 
+/*
+ * IBS events with exclude_{user,kernel} bits set, as used by perf to
+ * record per-thread when kernel samples are not allowed, are rejected
+ * by the kernel on hardware without the privilege filter unless the
+ * swfilt software filter is used, so these events carry a variant of
+ * their names with the swfilt term, used by perf_pmu__mem_events_name()
+ * when the kernel exposes the term.
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
index 0b49fce251fcc184..8f74cd085e500231 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -82,6 +82,7 @@ static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
 					     char *buf, size_t buf_size)
 {
 	struct perf_mem_event *e;
+	const char *name;
 
 	if (i >= PERF_MEM_EVENTS__MAX || !pmu)
 		return NULL;
@@ -90,24 +91,36 @@ static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
 	if (!e || !e->name)
 		return NULL;
 
+	/*
+	 * Use the swfilt variant of the name when the PMU exposes the term.
+	 * It is not conditional on the event already having exclude bits:
+	 * perf record adds those bits itself when the first open fails with
+	 * EACCES on an unprivileged setup, after this name has been built,
+	 * and that retry only succeeds with the term in the name.  With no
+	 * exclude bits the kernel doesn't discard anything.
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
@@ -117,7 +130,7 @@ static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
 
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

