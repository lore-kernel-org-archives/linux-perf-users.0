Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33FCBE5E
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775641415; cv=none; b=jK6vlyo2b+iBvEsrMpLSIy0OrTbbkaLFdUDwmwNas9DWq7EMPaKGFFxf+ac0mzl/42OrkBKmIMjjLXOtzvgS1pGhExrIS+IIICLLG/FA55ksCtbKxGPqfhwQ22f3UFHk932n6VtAB+gB7P8lY9fNRIDrFpnH61vaiaOScWPanso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775641415; c=relaxed/simple;
	bh=EfovEt/+pDg6M+HIkNdZubv3GBaXYR/cbM7RTckIW4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YPRs3a+uhdYrPXZaqr4U3z3iLt7Wx648EKcrwSIfPK+rXQILEr6gOy8QsVrNqWRq4mPT4t7mcvYoyz3Y3f5KtWCuFpCBi/XD4fwD+wkEew+uSb6l21vCtNKIwr7r7JHm+GMX8Vh6rV/pHJ2bo+j4wcn8GJ/J4Df8Ka5OUIVP9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mmwTb/48; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mmwTb/48"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3069C32E3;
	Wed,  8 Apr 2026 02:43:26 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E0493F641;
	Wed,  8 Apr 2026 02:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775641411; bh=EfovEt/+pDg6M+HIkNdZubv3GBaXYR/cbM7RTckIW4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mmwTb/48ICnuGc7pZS/OynOOnQUOqp/8UJ9SIy2MX5hBIfz8s9dsLXLX0dIOYrZm2
	 PMjgeOUjOO5CSk84JafJat2w4h+ovMS++rErvJGJZmYl1GyGe1L+AQfQgcdf1L1iJr
	 pd1NFBSlFEanPPZpNeRevdztzodwPfhNoYzdtjUo=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 08 Apr 2026 10:42:31 +0100
Subject: [PATCH v5 1/4] perf sort: Support sort ASE and SME
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-perf_support_arm_spev1-3-v5-1-b5bcea6217bb@arm.com>
References: <20260408-perf_support_arm_spev1-3-v5-0-b5bcea6217bb@arm.com>
In-Reply-To: <20260408-perf_support_arm_spev1-3-v5-0-b5bcea6217bb@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775641408; l=1838;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=EfovEt/+pDg6M+HIkNdZubv3GBaXYR/cbM7RTckIW4M=;
 b=kuW4WZuKarGhOd9GVLJh03EeD8j5qQzfWEOqCe9Zxd4iOZXTHH+MTUcAEoIY1u9HsgjV46PNy
 u3x23EhzPW1AIVFcUI+yvaVZPaDodrGtLcK+DepENjSrSIeTEVdTfTg
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
index 5c9656cc4f9dacdb66351543c103ddd3cee6860a..69ecc5be0488c749a11fe9912375d8e5408175bf 100644
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

