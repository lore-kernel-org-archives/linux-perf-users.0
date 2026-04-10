Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA9939E184
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806633; cv=none; b=oLjlQTEbsRnJO0ucaeVvDpYzDU1NWz2i/67aMTk0HCJazjToPq8g3wY3sedQU9tX0JPyMa1B8AucnhjRRCTa9hsxtvXyun5sM6Rt5sZBQgsX1iPqKbCkthEzqExLAU6/50CiOHPQyRj5O/PUmFYhGSc+NT9aquyOKhwxgGOqPOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806633; c=relaxed/simple;
	bh=4kj+BoA/CoQE4ybc/K9yGOUF7Q+sPiofbAfDIR4jpnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RbFE9tUilAVR4H+zJ/xcReADA6PcNfd9ra6y9c4CYBD5VQuw02DVUGsXjzIiuoLUpLSfGfRgoygdHyicHBEtnMBt5wVatHwQSEygWYUQxkEyQi2CFiFNWhFdkbKIIyUyGN7Xv1wNpWMtrgp619pXoszZBPDKehpR7LDZcKxjR9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Y7vHihxg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Y7vHihxg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAEBE1CE2;
	Fri, 10 Apr 2026 00:37:04 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DA873FAF5;
	Fri, 10 Apr 2026 00:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775806630; bh=4kj+BoA/CoQE4ybc/K9yGOUF7Q+sPiofbAfDIR4jpnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y7vHihxgcmTds8IWGBHBzMyS3sHFYr838n2sVjxJoZ2bUazdlBnlkRqmT+brUH7JV
	 4LHR3YY47y/yKv4DfoBaezp6qeDj/r0cLxmv1cQErN0dBpm4cRkL2W1/AAMq9NQwrX
	 C7rswvqicwhhP3rEiy0GwP+y4tkTN7th8IYQmoSU=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 10 Apr 2026 08:36:59 +0100
Subject: [PATCH v6 2/4] perf sort: Sort disabled and full predicated flags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-perf_support_arm_spev1-3-v6-2-3c6f2dfe2cd3@arm.com>
References: <20260410-perf_support_arm_spev1-3-v6-0-3c6f2dfe2cd3@arm.com>
In-Reply-To: <20260410-perf_support_arm_spev1-3-v6-0-3c6f2dfe2cd3@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775806625; l=2903;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=4kj+BoA/CoQE4ybc/K9yGOUF7Q+sPiofbAfDIR4jpnw=;
 b=VapZ7vg4oTxrTKiE6EKF/+GOpMSmVYB4xP4xk8OSppaB4lIGo7vFCe8ChGl0rNLknWL0IrskX
 WJ9GpN4K0mvAvbTmPiZlbMpS69TK/2azXwdIdgyiKPtPKl33nGiutOh
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

According to the Arm ARM (ARM DDI 0487, L.a), section D18.2.6
"Events packet", apart from the empty predicate and partial
predicates, an SVE or SME operation can be predicate-disabled
or full predicated.

To provide complete results, introduce two predicate types for
these cases.

Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/sample.h | 13 +++++++++----
 tools/perf/util/sort.c   | 15 ++++++++++-----
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 0e5ee7e0fb94f2d36c35df15de7c4ea00547a6c2..ca0c407c4423a4bc0b8098c657238b50ff5a3a17 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -72,8 +72,8 @@ struct aux_sample {
 
 struct simd_flags {
 	u8	arch:  2,	/* architecture (isa) */
-		pred:  2,	/* predication */
-		resv:  4;	/* reserved */
+		pred:  3,	/* predication */
+		resv:  3;	/* reserved */
 };
 
 /* simd architecture flags */
@@ -85,8 +85,13 @@ enum simd_op_flags {
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
 
 /**
  * struct perf_sample
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 7198eb3ae560cdac762a7d233d19bd6c70903d39..0020089cb13c7858ba04579568b1bdbc32909c63 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -209,18 +209,23 @@ static int hist_entry__simd_snprintf(struct hist_entry *he, char *bf,
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
 
 static struct sort_entry sort_simd = {

-- 
2.34.1

