Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692CE311966
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695546; cv=none; b=BE5oXDwjCmUnjx/PeU7oWWKmAo35ol98HYjtqyluM2B61MVSXSrSYRqCW9/CMHtvSHLMOHE+zoq7N0wLX9LjTc3GsSN/YSLrsGDdcjKXRHxKG8ROzRgmAWVrjN/eaQez+ESy029RQ1yiU5thCIY1dJJjGyld63ZjpqUrjiWcOg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695546; c=relaxed/simple;
	bh=LxrG4la+UU2a+kngmi6pw8OHWq6AgFvXmkETg/5yk98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D5+URtGU5hG8xNcG7asEQT3zhzPOZh75KHGtyZV0wzIIG/jntY0ZJ9KXUKExaZA5t6wLirZqrzl0TLVAarJ2MA7eiPTeojaNOzzUtITXr4O/iHAOCRKBY2aXnWVpZM3etvEQ3dKB6JaXgHQJ7UkHHobySDzRoFXDWR6J4micpCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5289F1C25;
	Fri, 17 Oct 2025 03:05:37 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D23BD3F59E;
	Fri, 17 Oct 2025 03:05:43 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 17 Oct 2025 11:05:11 +0100
Subject: [PATCH v2 22/25] perf sort: Support sort ASE and SME
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-perf_support_arm_spev1-3-v2-22-2d41e4746e1b@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760695507; l=1741;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=LxrG4la+UU2a+kngmi6pw8OHWq6AgFvXmkETg/5yk98=;
 b=tbAXEc0TDjJdPMhk/Q/Mq0Y3agA2yqN7TuC2Tg5fk+Bb1XplrNO6/2bet+S1u4sJerINTwJ8r
 gaBIYqM1q1lAOqrhlolNuHS3T0i3NT0QTtkfK5DAorsMP00DvDWO/NL
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Support sort Advance SIMD extension (ASE) and SME.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/sample.h | 12 +++++++++---
 tools/perf/util/sort.c   |  6 +++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index fae834144ef42105d08a59704ee75cd4852bbc5a..3b22cc2f7ad6ba1dc53b5d9ffff2a4e47c89612a 100644
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
index f3a565b0e2307a8adf159725f803df5fef0dff83..ad98d5b75f34b49cd39e30cba997a614654eebcb 100644
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

