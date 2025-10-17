Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AA73115AE
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695548; cv=none; b=IhAioEpBUuwhvmawqbYMny5ljgSfHID2qYLJoUjLjvodsmZVeWJfBVwYkgPSC+UUtY6fY74Bqb78z8Wbi0FaW7jfZxNeHUbES58V9UO0Z9XFdgnT2TtE/328b2EEZaaTxK4xACulGRsMHzeF0WS2BpAeoZ8mKTGtIDpDC3+xhcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695548; c=relaxed/simple;
	bh=1Vk+T+Hx3u2vOsFODCfgVnGRN0oLOre+czspaI2a/pc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L4ZAq7eZGcuv1A4gzvXgKaanUwyTOzyNYyZxkBRSODlw/OaCX+Ey7OopLooUKC6zpZ+HkiDUv0vq5acmSREHWOTvcFRCH2ZSgbMmAy5jSevtytmEAr0tQRfThZh5QO4AOCbQ0MqK08KQNlPC2jEeU8Y5QxhaLbXbWeG/gJ6bLP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1F4A1596;
	Fri, 17 Oct 2025 03:05:38 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D8FF3F59E;
	Fri, 17 Oct 2025 03:05:45 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 17 Oct 2025 11:05:12 +0100
Subject: [PATCH v2 23/25] perf sort: Sort disabled and full predicated
 flags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-perf_support_arm_spev1-3-v2-23-2d41e4746e1b@arm.com>
References: <20251017-perf_support_arm_spev1-3-v2-0-2d41e4746e1b@arm.com>
In-Reply-To: <20251017-perf_support_arm_spev1-3-v2-0-2d41e4746e1b@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760695507; l=2803;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=1Vk+T+Hx3u2vOsFODCfgVnGRN0oLOre+czspaI2a/pc=;
 b=IYbtljwxVsRkfL093uQOR0+2AbQI66l89zEaX9zZJs5MyVBJwhNMrlsDLmAY7ONsIiQvSaNPC
 g5Qk68NpsfvAKKBuKuzG3yBPhZnuVq35JtfAG5/G18dcx8IRrRZRse5
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

According to the Arm ARM (ARM DDI 0487, L.a), section D18.2.6
"Events packet", apart from the empty predicate and partial
predicates, an SVE or SME operation can be predicate-disabled
or full predicated.

To provide complete results, introduce two predicate types for
these cases.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/sample.h | 13 +++++++++----
 tools/perf/util/sort.c   | 15 ++++++++++-----
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 3b22cc2f7ad6ba1dc53b5d9ffff2a4e47c89612a..9477fe9c87402dd9135f25a6eee2e7539e6fdbca 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -68,8 +68,8 @@ struct aux_sample {
 
 struct simd_flags {
 	u8	arch:  2,	/* architecture (isa) */
-		pred:  2,	/* predication */
-		resv:  4;	/* reserved */
+		pred:  3,	/* predication */
+		resv:  3;	/* reserved */
 };
 
 /* simd architecture flags */
@@ -81,8 +81,13 @@ enum simd_op_flags {
 };
 
 /* simd predicate flags */
-#define SIMD_OP_FLAGS_PRED_PARTIAL	0x01	/* partial predicate */
-#define SIMD_OP_FLAGS_PRED_EMPTY	0x02	/* empty predicate */
+enum simd_pred_flags {
+	SIMD_OP_FLAGS_PRED_NONE = 0x0,	/* Not available */
+	SIMD_OP_FLAGS_PRED_PARTIAL,	/* partial predicate */
+	SIMD_OP_FLAGS_PRED_EMPTY,	/* empty predicate */
+	SIMD_OP_FLAGS_PRED_FULL,	/* full predicate */
+	SIMD_OP_FLAGS_PRED_DISABLED,	/* disabled predicate */
+};
 
 struct perf_sample {
 	u64 ip;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index ad98d5b75f34b49cd39e30cba997a614654eebcb..fe203458c6ffbc340450f6fffc13d0e256dfe7cf 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -207,18 +207,23 @@ static int hist_entry__simd_snprintf(struct hist_entry *he, char *bf,
 				     size_t size, unsigned int width __maybe_unused)
 {
 	const char *name;
+	const char *pred_str = ".";
 
 	if (!he->simd_flags.arch)
 		return repsep_snprintf(bf, size, "");
 
 	name = hist_entry__get_simd_name(&he->simd_flags);
 
-	if (he->simd_flags.pred & SIMD_OP_FLAGS_PRED_EMPTY)
-		return repsep_snprintf(bf, size, "[e] %s", name);
-	else if (he->simd_flags.pred & SIMD_OP_FLAGS_PRED_PARTIAL)
-		return repsep_snprintf(bf, size, "[p] %s", name);
+	if (he->simd_flags.pred == SIMD_OP_FLAGS_PRED_EMPTY)
+		pred_str = "e";
+	else if (he->simd_flags.pred == SIMD_OP_FLAGS_PRED_PARTIAL)
+		pred_str = "p";
+	else if (he->simd_flags.pred == SIMD_OP_FLAGS_PRED_DISABLED)
+		pred_str = "d";
+	else if (he->simd_flags.pred == SIMD_OP_FLAGS_PRED_FULL)
+		pred_str = "f";
 
-	return repsep_snprintf(bf, size, "[.] %s", name);
+	return repsep_snprintf(bf, size, "[%s] %s", pred_str, name);
 }
 
 struct sort_entry sort_simd = {

-- 
2.34.1

