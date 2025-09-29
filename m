Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047D130C634
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163913; cv=none; b=c2g/dldU7Mj80/R72Gq006b4ohO0rDkEnXKK4kQ2H2VkSnTFLqE5V162o6/lYHylvE2B9JfZHcQ7arJK/680SpECiJkCybk5Jzobi5U70p4at3+YiHFK5igoDXJPZNhRFu3p0PqmuYIJ/EZUK944XcEKMeqr9Pdx4nrXYgyrpPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163913; c=relaxed/simple;
	bh=9DgUIDtSBub4xxUhrwS3IOUa2/casbTUCxqkU1V8J7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O9RRz/Uv8YzkMl7Ukpcve0jJgRDyTtp5YcZrpzGjRbxzR3zhpOIRA5uJ5/oyJK7OjYI0m9A4YeSi69cUkDLjgdZsezZm4oEQrrnGiUFxIIKla39/IVKngdUrIc3/vq5T+0hInQzhEEcmeyXotUiTbMixTPifcmZFgFwfJ5ZmeD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B36FC1CC4;
	Mon, 29 Sep 2025 09:38:23 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AF833F66E;
	Mon, 29 Sep 2025 09:38:30 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 29 Sep 2025 17:37:59 +0100
Subject: [PATCH 23/25] perf sort: Sort disabled and full predicated flags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-perf_support_arm_spev1-3-v1-23-1150b3c83857@arm.com>
References: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
In-Reply-To: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=2583;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=9DgUIDtSBub4xxUhrwS3IOUa2/casbTUCxqkU1V8J7s=;
 b=cDloOdTprN298IBmh/nz0Jy2ojqCsZ4xZpebZycYnvyWZ5ek0T3ElvRVexgI5Wecs97iUXA7X
 n5YYUkCGfQcALQBWLJd8nkMsLnUtk7g5KR5heBrcm9+kXBk0GtwhByY
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

According to the Arm ARM (ARM DDI 0487, L.a), section D18.2.6
"Events packet", apart from the empty predicate and partial
predicates, an SVE or SME operation can be predicate-disabled
or fully predicated.

To provide reliable results, introduce two predicate types for
these cases.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/sample.h |  6 ++++--
 tools/perf/util/sort.c   | 11 ++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 405876885e1f273c039cb67187c6e5c39c91a612..d38810021fb9d6cb29f02267ae2a223cbe55839d 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -68,8 +68,8 @@ struct aux_sample {
 
 struct simd_flags {
 	u8	arch:  3,	/* architecture (isa) */
-		pred:  2,	/* predication */
-		resv:  3;	/* reserved */
+		pred:  4,	/* predication */
+		resv:  1;	/* reserved */
 };
 
 /* simd architecture flags */
@@ -80,6 +80,8 @@ struct simd_flags {
 /* simd predicate flags */
 #define SIMD_OP_FLAGS_PRED_PARTIAL	0x01	/* partial predicate */
 #define SIMD_OP_FLAGS_PRED_EMPTY	0x02	/* empty predicate */
+#define SIMD_OP_FLAGS_PRED_FULL		0x04	/* full predicate */
+#define SIMD_OP_FLAGS_PRED_DISABLED	0x08	/* disabled predicate */
 
 struct perf_sample {
 	u64 ip;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index c7596e9ca089c170988dbc43a00f6973039261cd..44c2d2623d529cde78ea16f281a6501c2bde9c66 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -207,6 +207,7 @@ static int hist_entry__simd_snprintf(struct hist_entry *he, char *bf,
 				     size_t size, unsigned int width __maybe_unused)
 {
 	const char *name;
+	const char *pred_str = ".";
 
 	if (!he->simd_flags.arch)
 		return repsep_snprintf(bf, size, "");
@@ -214,11 +215,15 @@ static int hist_entry__simd_snprintf(struct hist_entry *he, char *bf,
 	name = hist_entry__get_simd_name(&he->simd_flags);
 
 	if (he->simd_flags.pred & SIMD_OP_FLAGS_PRED_EMPTY)
-		return repsep_snprintf(bf, size, "[e] %s", name);
+		pred_str = "e";
 	else if (he->simd_flags.pred & SIMD_OP_FLAGS_PRED_PARTIAL)
-		return repsep_snprintf(bf, size, "[p] %s", name);
+		pred_str = "p";
+	else if (he->simd_flags.pred & SIMD_OP_FLAGS_PRED_DISABLED)
+		pred_str = "d";
+	else if (he->simd_flags.pred & SIMD_OP_FLAGS_PRED_FULL)
+		pred_str = "f";
 
-	return repsep_snprintf(bf, size, "[.] %s", name);
+	return repsep_snprintf(bf, size, "[%s] %s", pred_str, name);
 }
 
 struct sort_entry sort_simd = {

-- 
2.34.1

