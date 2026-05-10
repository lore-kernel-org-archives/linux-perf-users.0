Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608501F0995;
	Sun, 10 May 2026 03:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384086; cv=none; b=XHw4NFJ6thZzRDsmGLgO1YKcllGnCRSsjkE6aND7SODjtyoCu2qDeVT/znqRTHls7NCllA8zSAqQEHUdvzDc9WVKGWr8I2h8RLGdzsWyauDWSpQtOZewTOOGF519Xu+Jmxbk1uNRrqFtXynhZ8FXMa+XJI4gXQz3c7l+dleLXOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384086; c=relaxed/simple;
	bh=8Z3U7z7l7mbeyZbEtwZji0Na/j7Xf3Vx+97iUGbglmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRgIDmc4Fk59XU+t1wZn1cQl3DBw+bwyN9P9OA/gyZ38L+9q31yj5U9fT00mXAOWsgbR8VBMPPiBSndoaPU/i4hssp3yxbGJ5IYyJno0NraFfzyuFixtiMxB21x9aqzfV260hXoS2ypCTIUaR+AfU4bV1Grog59KKHsT0+mGP40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTamJK4X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTamJK4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F569C2BCF7;
	Sun, 10 May 2026 03:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384085;
	bh=8Z3U7z7l7mbeyZbEtwZji0Na/j7Xf3Vx+97iUGbglmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PTamJK4XB4wxqk0PJjgefrx2mUHTI4hEC2eeyxyWuDKCJ0neo/EX+rosM37FJ4/jo
	 eRPwXmVdEK+RrOsEMcSso3ugBgTc4WM2KfzxpGtfFvvczmJvqSu7pqaNOW75LLjTPM
	 5QrqUn/de9gC1w5iwBce1XQY+CcQCOg49A2Eoa76uln4/bRkzRu8OnVCkgpdkV57vi
	 zkC9TAG2F3wBJClhXqwdvnp5KW+GXm/tiHFdHCEHoljTq2xe1Ed51/bSDhOWNIb3+N
	 fVuDpWssDAS7lwsgIzlnzOS1fpFlT1FhGz/wBZ3yTEOa8b+mz/C4AWHfxREkJRViOP
	 F0d+IW9IV65wQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 02/28] perf tools: Fix event_contains() macro to verify full field extent
Date: Sun, 10 May 2026 00:33:53 -0300
Message-ID: <20260510033424.255812-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510033424.255812-1-acme@kernel.org>
References: <20260510033424.255812-1-acme@kernel.org>
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
infrastructure with null-termination checks"), which changes
the guard to time_mask.  The struct assignment overread
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
 tools/lib/perf/include/perf/event.h | 4 +++-
 tools/perf/util/arm-spe.c           | 2 +-
 tools/perf/util/cs-etm.c            | 2 +-
 tools/perf/util/jitdump.c           | 2 +-
 tools/perf/util/tsc.c               | 2 +-
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 9043dc72b5d68d58..c821143e6e4938c2 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -8,7 +8,9 @@
 #include <linux/bpf.h>
 #include <sys/types.h> /* pid_t */
 
-#define event_contains(obj, mem) ((obj).header.size > offsetof(typeof(obj), mem))
+/* Verify the full field fits within the event, not just its start offset */
+#define event_contains(obj, mem) \
+	((obj).header.size >= offsetof(typeof(obj), mem) + sizeof((obj).mem))
 
 struct perf_record_mmap {
 	struct perf_event_header header;
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 2b31da231ef3ec84..6f87e8ef20880425 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1982,7 +1982,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->tc.time_mult = tc->time_mult;
 	spe->tc.time_zero = tc->time_zero;
 
-	if (event_contains(*tc, time_cycles)) {
+	if (event_contains(*tc, cap_user_time_short)) {
 		spe->tc.time_cycles = tc->time_cycles;
 		spe->tc.time_mask = tc->time_mask;
 		spe->tc.cap_user_time_zero = tc->cap_user_time_zero;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8a639d2e51a4c5bf..02b80389810e767d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3496,7 +3496,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->tc.time_shift = tc->time_shift;
 	etm->tc.time_mult = tc->time_mult;
 	etm->tc.time_zero = tc->time_zero;
-	if (event_contains(*tc, time_cycles)) {
+	if (event_contains(*tc, cap_user_time_short)) {
 		etm->tc.time_cycles = tc->time_cycles;
 		etm->tc.time_mask = tc->time_mask;
 		etm->tc.cap_user_time_zero = tc->cap_user_time_zero;
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index e0ce8b9047298362..e1e160cdec4cf2c2 100644
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

