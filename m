Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B114E30CD81
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163887; cv=none; b=bip9zGNcv8y+bLig7RxVtZNIPFK9kSY3pKe4u6vMXblphD7oj+gLSYU9NppN15uQM0hUlFicDxmQ+ZJz/yPHmB2lREGfinLKgwZeHLEsJNmu9udRl503mSp/hhMKf6HpZ+JKLPtHF8coAwl+oLMnPExNn+U4FmEII5elEmdXUfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163887; c=relaxed/simple;
	bh=b0PllY8RWLZry/bueun+VAsGue4qV9iwUC/TXi6VS1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TYSdrpNLdlqYzywvzCgDhhIZQFX5geK4c5suWcSSVltOhek9HuBRXXt+59lPeJB8xRQTYBuneTSY0WfkunYHq9AknEmvKu/78tY0EyW3jzuUZS03zOUW1jvjfbpxQjpM/YN/6hvUy4GmdOcoB/YWm+at3yh/VXXwjrx+QLKU/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 621DE150C;
	Mon, 29 Sep 2025 09:37:57 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0767B3F66E;
	Mon, 29 Sep 2025 09:38:03 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 29 Sep 2025 17:37:43 +0100
Subject: [PATCH 07/25] perf arm_spe: Remove unused operation types
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-perf_support_arm_spev1-3-v1-7-1150b3c83857@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=1210;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=b0PllY8RWLZry/bueun+VAsGue4qV9iwUC/TXi6VS1k=;
 b=0em+aTqTnwCBc1YlmmYQ8zbm5lw/5m/wQJ7BFN+HQe/ZVerfp4CqaH5c6KFONambjtvrTwWQf
 SxhcZnO2qOqATimE4TRj9qB/nCpSfJ1cFM0Fxaygsq7CzyPqnpb2qZ9
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Remove unused SVE operation types. These operations will be reintroduced
in subsequent refactoring, but with a different format.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index fbb57f8052371e51d562d9dd6098e97fc099461c..1259cbadfdc8098019afcd4cf65e733475310392 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -39,8 +39,6 @@ enum arm_spe_op_type {
 
 	/* Second level operation type for OTHER */
 	ARM_SPE_OP_SVE_OTHER		= 1 << 16,
-	ARM_SPE_OP_SVE_FP		= 1 << 17,
-	ARM_SPE_OP_SVE_PRED_OTHER	= 1 << 18,
 
 	/* Second level operation type for LDST */
 	ARM_SPE_OP_LD			= 1 << 16,
@@ -53,8 +51,6 @@ enum arm_spe_op_type {
 	ARM_SPE_OP_UNSPEC_REG		= 1 << 23,
 	ARM_SPE_OP_NV_SYSREG		= 1 << 24,
 	ARM_SPE_OP_SVE_LDST		= 1 << 25,
-	ARM_SPE_OP_SVE_PRED_LDST	= 1 << 26,
-	ARM_SPE_OP_SVE_SG		= 1 << 27,
 
 	/* Second level operation type for BRANCH_ERET */
 	ARM_SPE_OP_BR_COND		= 1 << 16,

-- 
2.34.1

