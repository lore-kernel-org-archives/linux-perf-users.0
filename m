Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B09F30BF75;
	Mon,  1 Dec 2025 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588166; cv=none; b=a54fdTrwl9zF1iAGUQJepvEThLI4WGflu97YsBlz/LIAvCaKQWPd8D4SSOEuXyLsyn8Nwp317XJGOZy6ALeZaTne+NOguuJL8mAM69jVIPtnqsiH3pgCq20Cm7zr4pskKatzi9KI+QruBAKIYR305uWR2Yq/YATlO3obgiu/DNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588166; c=relaxed/simple;
	bh=tI23wHWbnF4yzdYIODYmTmujHYxBfWMJv1sYUQXmTec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b0DWhAC9FYiz3srNlVAicw2Z+O5asLB+Fqm6EQcmiDEzSgaGs6gNJEJRFQZqUx+nsyz8vF7Jns+gyMOapVFQ/MwFoCm88EcMEddyALWnA8DjjWIIMduVmUckKdRuBxTOs17WgwDFseVq7TMviTpJPLzzIe2eEV9jgfhqPXF3gfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63F85153B;
	Mon,  1 Dec 2025 03:22:37 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41E053F59E;
	Mon,  1 Dec 2025 03:22:42 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 01 Dec 2025 11:22:03 +0000
Subject: [PATCH 13/19] coresight: trbe: Remove misleading comment
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-13-7da32b076b28@arm.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>, 
 Tamas Zsoldos <tamas.zsoldos@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=1975;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=tI23wHWbnF4yzdYIODYmTmujHYxBfWMJv1sYUQXmTec=;
 b=RIRbbXcq3hGGI2EJ1tcNL6xKmXI8GPtNQJN0zCfuGLhEufkzi2hxCfk9zj/nB4NPQprWUPel+
 NNUomz9IsgYA1ODwFJFyowfrz5o9URya2JGODB2lFPLrysXOSBGdyR4
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Since the rounded-up wakeup address is always higher than the head, the
limit cannot be less than the head caused by wakeup capping.

The described scenario is never valid caused by wakeup capping, remove
the comment to avoid confusion.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 48bc03bd339908b5eac9466dc60325ff1b238976..206eaf103cd94f36220cb6bddd1a78012f5de35a 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -488,10 +488,10 @@ static unsigned long __trbe_normal_offset(struct perf_output_handle *handle)
 		limit = min(limit, round_up(wakeup, PAGE_SIZE));
 
 	/*
-	 * There are two situation when this can happen i.e limit is before
+	 * There is a situation when this can happen i.e limit is before
 	 * the head and hence TRBE cannot be configured.
 	 *
-	 * 1) head < tail (aligned down with PAGE_SIZE) and also they are both
+	 * head < tail (aligned down with PAGE_SIZE) and also they are both
 	 * within the same PAGE size range.
 	 *
 	 *			PAGE_SIZE
@@ -502,18 +502,6 @@ static unsigned long __trbe_normal_offset(struct perf_output_handle *handle)
 	 * |$$$$$$$$$$$$$$$$$$$|========|$$$$$$$|
 	 * +------------|------|--------|-------+
 	 * trbe_base				trbe_base + nr_pages
-	 *
-	 * 2) head < wakeup (aligned up with PAGE_SIZE) < tail and also both
-	 * head and wakeup are within same PAGE size range.
-	 *
-	 *		PAGE_SIZE
-	 *	|----------------------|
-	 *
-	 *	limit	head	wakeup  tail
-	 * +----|------|-------|--------|-------+
-	 * |$$$$$$$$$$$|=======|========|$$$$$$$|
-	 * +----|------|-------|--------|-------+
-	 * trbe_base				trbe_base + nr_pages
 	 */
 	if (limit > head)
 		return limit;

-- 
2.34.1

