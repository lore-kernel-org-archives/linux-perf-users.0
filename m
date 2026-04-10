Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5264E3346A6
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806630; cv=none; b=SNpnlpRLaE/X4YsiO4LYhT3r2z1HBbuNRwRZMhKxzBHUBmyoWg3opB4wwvDKhFMqMKMEqAm8wXdZ1mYWd6tKfUAebqpS9f/5mTD2BTmboyjs9ak1rG9cYYsxKlNoa5r4GLboRPxV0cH9w5hH7AKzHYURZ5C/Asg8CkptCOgqg3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806630; c=relaxed/simple;
	bh=sT+Dto1iykaMgIS4XR6VGDBuVICmsWs7yPnEEI2WLVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iHEgHo7U30poaTv9CzqyVirIAMQGN7h4ZEVWd9GrbQ2KqPck//i8u2DKEite1N05x4MbbzinhKrFXRb2ZOU3Rg2GpUIprLjeBftDGZE9VYaPB46dmUmyt1M9edzJJe7TLfFaSkROJhOhpwpYv3OM1atZSm/Tcuw1krGMOvhBdMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dmYlSCJ7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dmYlSCJ7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15D351D15;
	Fri, 10 Apr 2026 00:37:03 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49B523FAF5;
	Fri, 10 Apr 2026 00:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775806628; bh=sT+Dto1iykaMgIS4XR6VGDBuVICmsWs7yPnEEI2WLVo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dmYlSCJ7IjIISOmwM2WCLXO7ff2FgYCnfog9flfg2joWincU0SvQVNxhaRF4DkedM
	 NxyGNVdj2nZC81oyMF4DlnVHAKYDJHyBgWhNASMYMMcyZnKb8TpD2wEVjgZujDReZf
	 JpXgSe6dStT8g769lH0SjH4pkm/jaG4U7bbQMQkk=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 10 Apr 2026 08:36:58 +0100
Subject: [PATCH v6 1/4] perf sort: Support sort ASE and SME
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-perf_support_arm_spev1-3-v6-1-3c6f2dfe2cd3@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775806625; l=1838;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=sT+Dto1iykaMgIS4XR6VGDBuVICmsWs7yPnEEI2WLVo=;
 b=/3VzkdTZ5Rkpd/+94VUgObMeZBVEs1W9IKe2eNSw+9wRKmPtuzrN7pS9pD5buzq9X1YyF0fd3
 HXjmMxi+W/6DzTeP4AqCRtcyelxbI+ZhIhOzI+pw73pl7PR6lhC24a/
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
index 3d27a0daef8fb2d72ffa8510923857e73130dd40..0e5ee7e0fb94f2d36c35df15de7c4ea00547a6c2 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -71,12 +71,18 @@ struct aux_sample {
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
index 6ce684d68bd61edba2df16806d8a8f18132617db..7198eb3ae560cdac762a7d233d19bd6c70903d39 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -195,8 +195,12 @@ static const char *hist_entry__get_simd_name(struct simd_flags *simd_flags)
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

