Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058A7330311;
	Tue,  6 Jan 2026 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701305; cv=none; b=uNL4Nak9D5QY9jIYwUeELKHBa3AAnJBN2vjWghVEGcL520XXNfhrdoHNTL9lZA2deDDOaepMbjpKcvoTa3eo+lHGPaMsC5BmgPlf74sQ7ZDvI0eV3i4QcFl4al87ylXZUibz0Jj0jAdPBlJp/M7liCvu7/f3cNE7gSS56cItt1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701305; c=relaxed/simple;
	bh=/WNrB8RgXJV0DZiQQjlw0PADfmZMQPHh7jYqoeHWul8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ECVD2JXbUrP0+uN166WafaFr+gFsXOCeX9hqZi8tEpMrng0Bx2xJ3svIRdHtaLZ2YvXTrSZ3gQOOWWOwgxQdYfrg6dILEGJP7JD6hqTYiMMqPqnf/gtEBQMh+MqhsfnMv1pmMQ3ZSbKom7bLukc3m+UxluPwDdq9i7Z00tp8zCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96BA71595;
	Tue,  6 Jan 2026 04:08:16 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 439013F5A1;
	Tue,  6 Jan 2026 04:08:21 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 06 Jan 2026 12:07:55 +0000
Subject: [PATCH RESEND v4 5/8] perf sort: Support sort ASE and SME
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-perf_support_arm_spev1-3-v4-5-b887bb999f6e@arm.com>
References: <20260106-perf_support_arm_spev1-3-v4-0-b887bb999f6e@arm.com>
In-Reply-To: <20260106-perf_support_arm_spev1-3-v4-0-b887bb999f6e@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767701288; l=1838;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=/WNrB8RgXJV0DZiQQjlw0PADfmZMQPHh7jYqoeHWul8=;
 b=5G3ZkuNQQPm/6X3+NzeWTV4VMwuarfJNA8CT1zeRqIK42SZ4wiPmOb+kEdMCRFF2lUzS4B6jV
 rBTeqjalcv9Csd0Uc5oYbx/9dPElQIjLg//HGKMnccsVBrJpMW0w7Gk
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Support sort Advance SIMD extension (ASE) and SME.

Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/sample.h | 12 +++++++++---
 tools/perf/util/sort.c   |  6 +++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index a8307b20a9ea80668deecf65e316ab6036afbfeb..504256474f22fa8ec647429d182a6d04f8d05c39 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -67,12 +67,18 @@ struct aux_sample {
 };
 
 struct simd_flags {
-	u8	arch:1,	/* architecture (isa) */
-		pred:2;	/* predication */
+	u8	arch:  2,	/* architecture (isa) */
+		pred:  2,	/* predication */
+		resv:  4;	/* reserved */
 };
 
 /* simd architecture flags */
-#define SIMD_OP_FLAGS_ARCH_SVE		0x01	/* ARM SVE */
+enum simd_op_flags {
+	SIMD_OP_FLAGS_ARCH_NONE = 0x0,	/* No SIMD operation */
+	SIMD_OP_FLAGS_ARCH_SVE,		/* Arm SVE */
+	SIMD_OP_FLAGS_ARCH_SME,		/* Arm SME */
+	SIMD_OP_FLAGS_ARCH_ASE,		/* Arm Advanced SIMD */
+};
 
 /* simd predicate flags */
 #define SIMD_OP_FLAGS_PRED_PARTIAL	0x01	/* partial predicate */
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f963d61ac166f9b3f16069b07aa4b0dacfb65c02..e8f793eed33f78b7688b3f949e8254cbb64c3709 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -193,8 +193,12 @@ static const char *hist_entry__get_simd_name(struct simd_flags *simd_flags)
 {
 	u64 arch = simd_flags->arch;
 
-	if (arch & SIMD_OP_FLAGS_ARCH_SVE)
+	if (arch == SIMD_OP_FLAGS_ARCH_SVE)
 		return "SVE";
+	else if (arch == SIMD_OP_FLAGS_ARCH_SME)
+		return "SME";
+	else if (arch == SIMD_OP_FLAGS_ARCH_ASE)
+		return "ASE";
 	else
 		return "n/a";
 }

-- 
2.34.1

