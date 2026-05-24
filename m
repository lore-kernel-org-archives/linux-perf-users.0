Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5C02741A0;
	Sun, 24 May 2026 03:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593264; cv=none; b=XKejh0G284S69ggJIMfr46KroNKWz3lQ/KKMjFgWDyWNFncS8197WFoXMfB585JL/pQVn6hn+8BCQdQhO1L+1TOfHzGzr+u02GrVRP64nJevvsQLyr84aWKDALono6rqSlrW1bJUT1JpWcmglVAZp2z70tp51aTXKlv0/7nNsxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593264; c=relaxed/simple;
	bh=OnqVr/x0PCFIuS9QoBjoftnmuBSOE+xs0TbXevOcqd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCTVqvqtM1vijwacGw+p/rRnBUGES8pY15SkXSAjXE72jMf3eqgNndu5/3BehM/Epy3CNcr1qYlMyReszPTWE5KxotcXdcD4WaAfOAypPqLF6/LaVz8Op15USSujvoIBvtd3JHfFxAiInZLpeHSG//7flc37wRqXw9BA0xvJX1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjAS/oVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjAS/oVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA301F00A3A;
	Sun, 24 May 2026 03:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779593263;
	bh=XbGi1j8FII0Y0rwll19PJjGMweR7zPiMUsJf/hVVrWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kjAS/oVld8bo2TD9RNIj1Kronp72Hxz3uMQkiz+IyCWBUnj0nsc5aJRiSHuDrkPz9
	 VdzQlu3WDEHc0gCpSJgn5/jd+hCdCPAI92By+PpQ/Fswsp72uq8iSJvBFCyEYL+uZs
	 rGn9oIP6wo3x2+smtyqrqFozrJSiQCaEEnJt8gJfLQNVZVhzlEzOiONkhEtnC5IAoK
	 G68lxcDdCMHbcE6rcWNQtUDew4fahmbEy/YPFHgvp+6WKxDMq/FdMnvK3cbtJ8SjlN
	 1xkqKAGGtN7Vqgl6PMnVSyIa2M6bdtPlvdDgNiHx9RXlSy6J4w8+w/HYgswroP7W++
	 cA0Vhp1cFlLhQ==
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
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 03/29] perf tools: Fix event_contains() macro to verify full field extent
Date: Sun, 24 May 2026 00:26:37 -0300
Message-ID: <20260524032709.1080771-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524032709.1080771-1-acme@kernel.org>
References: <20260524032709.1080771-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

event_contains() checked whether a field's start offset was within
the event (header.size > offsetof), but not whether the full field
fit.  A crafted event with header.size = offsetof(field) + 1 would
pass the check, but an 8-byte access (bswap_64, direct read) would
overrun the event boundary by up to 7 bytes.

Fix the macro to verify the complete field:

  header.size >= offsetof(field) + sizeof(field)

Also update all callers that check event_contains(time_cycles) but
access later fields (time_mask, cap_user_time_zero,
cap_user_time_short) to check for cap_user_time_short — the last
field accessed — so the entire extended block is verified:
tsc.c, arm-spe.c, cs-etm.c, jitdump.c.

Note: session.c's perf_event__time_conv_swap() also guards on
time_cycles but accesses time_mask — a pre-existing issue not
introduced by this macro change.  It is fixed by a later patch
in this series ("perf session: Add validated swap
infrastructure with null-termination checks"), which decouples
time_cycles and time_mask into independent per-field
event_contains() checks.  The struct assignment overread
(session->time_conv = event->time_conv copies sizeof on a
potentially shorter event) is separately fixed by "perf
session: Use bounded copy for PERF_RECORD_TIME_CONV".

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/include/perf/event.h | 9 ++++++++-
 tools/perf/util/arm-spe.c           | 2 +-
 tools/perf/util/cs-etm.c            | 2 +-
 tools/perf/util/jitdump.c           | 2 +-
 tools/perf/util/tsc.c               | 2 +-
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 9043dc72b5d68d58..fdced574c889e503 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -8,7 +8,14 @@
 #include <linux/bpf.h>
 #include <sys/types.h> /* pid_t */
 
-#define event_contains(obj, mem) ((obj).header.size > offsetof(typeof(obj), mem))
+/*
+ * Verify the full field fits within the event, not just its start offset.
+ * Only valid for fixed-size scalar fields — for trailing arrays like
+ * filename[PATH_MAX], sizeof() evaluates to the declared maximum, not
+ * the actual string length, so this would spuriously return false.
+ */
+#define event_contains(obj, mem) \
+	((obj).header.size >= offsetof(typeof(obj), mem) + sizeof((obj).mem))
 
 struct perf_record_mmap {
 	struct perf_event_header header;
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 31f05f46781092c1..552f063f126e6769 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -2002,7 +2002,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->tc.time_mult = tc->time_mult;
 	spe->tc.time_zero = tc->time_zero;
 
-	if (event_contains(*tc, time_cycles)) {
+	if (event_contains(*tc, cap_user_time_short)) {
 		spe->tc.time_cycles = tc->time_cycles;
 		spe->tc.time_mask = tc->time_mask;
 		spe->tc.cap_user_time_zero = tc->cap_user_time_zero;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 6ec48de29441012f..40c6ddfa8c8d91b6 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3514,7 +3514,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->tc.time_shift = tc->time_shift;
 	etm->tc.time_mult = tc->time_mult;
 	etm->tc.time_zero = tc->time_zero;
-	if (event_contains(*tc, time_cycles)) {
+	if (event_contains(*tc, cap_user_time_short)) {
 		etm->tc.time_cycles = tc->time_cycles;
 		etm->tc.time_mask = tc->time_mask;
 		etm->tc.cap_user_time_zero = tc->cap_user_time_zero;
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 52e6ffac2b3e1039..18fd84a82153c2ab 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -409,7 +409,7 @@ static uint64_t convert_timestamp(struct jit_buf_desc *jd, uint64_t timestamp)
 	 * checks the event size and assigns these extended fields if these
 	 * fields are contained in the event.
 	 */
-	if (event_contains(*time_conv, time_cycles)) {
+	if (event_contains(*time_conv, cap_user_time_short)) {
 		tc.time_cycles	       = time_conv->time_cycles;
 		tc.time_mask	       = time_conv->time_mask;
 		tc.cap_user_time_zero  = time_conv->cap_user_time_zero;
diff --git a/tools/perf/util/tsc.c b/tools/perf/util/tsc.c
index 511a517ce613dff1..ebf289bf6b9d9add 100644
--- a/tools/perf/util/tsc.c
+++ b/tools/perf/util/tsc.c
@@ -127,7 +127,7 @@ size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp)
 	 * when supported cap_user_time_short, for backward compatibility,
 	 * prints the extended fields only if they are contained in the event.
 	 */
-	if (event_contains(*tc, time_cycles)) {
+	if (event_contains(*tc, cap_user_time_short)) {
 		ret += fprintf(fp, "... Time Cycles     %" PRI_lu64 "\n",
 			       tc->time_cycles);
 		ret += fprintf(fp, "... Time Mask       %#" PRI_lx64 "\n",
-- 
2.54.0

