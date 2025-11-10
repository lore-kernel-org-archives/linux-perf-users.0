Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E04C27B34F;
	Mon, 10 Nov 2025 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792127; cv=none; b=GaWWD5jfGwoR1lEOEZYAWW7INP2aWwsIB3y7dEY7ZgTSDQdxUovk8ELeODMPcX/GcKu/w6A+fb563YXOuUF44AH7AeyQEvm5lp+IaZ5KbNerLUHwsDKJwP/2JDlxaIN+GEdOCOAHkoGsTdYirBwMMsPs1F4span2D/tt6MM04+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792127; c=relaxed/simple;
	bh=8UdIi+vekhUmBUYHnTWZHzY9nrwSvSb76pHrnU/+RmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sI2F0k8NyfqRCwVuvvGQUkycR5zt39SaMtqivYHQ46R6JqASCWaANClTq38KgT9yjM3T5r5IWsR3wdRA7LZLVUD5RXNbbDI9hJGtCSv1YP9Q9ObAk7GylKAy2XXP7+01vDiK39PnsmXBDOqmBrEHoYObl4Sh8DeCjnt1Cfr1J5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 214A32F;
	Mon, 10 Nov 2025 08:28:37 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B271A3F66E;
	Mon, 10 Nov 2025 08:28:43 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 10 Nov 2025 16:28:31 +0000
Subject: [PATCH v2 1/2] perf: arm_spe: Correct setting the PERF_HES_STOPPED
 flag
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-arm_spe_fix_truncated_flag-v2-1-a629740985cc@arm.com>
References: <20251110-arm_spe_fix_truncated_flag-v2-0-a629740985cc@arm.com>
In-Reply-To: <20251110-arm_spe_fix_truncated_flag-v2-0-a629740985cc@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792122; l=1937;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=8UdIi+vekhUmBUYHnTWZHzY9nrwSvSb76pHrnU/+RmE=;
 b=lB5mNzWEC2PrAQOxpWQ1p1l+2TaiTL4ViYONCUsNXp36RWaHBusoUJ5G2rM483wtrZUiI/Rn1
 /7utNQOolWPBqGkGc7FrkZCQILQHDk950A36mpGxfRWLvyRaJtyNv3g
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

In arm_spe_perf_aux_output_begin(), if the calculation of limit fails
and arm_spe_pmu_next_off() returns zero, the driver misses to set the
PERF_HES_STOPPED flag for the event.  As a result, hwc->state does not
reflect the latest state, which can mislead subsequent operations.

Validate the limit when exiting the function: if the limit is 0,
that tracing is disabled, set the PERF_HES_STOPPED flag accordingly.

Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fa50645feddadbea5dc1e404f80f62cf5aa96fd4..fc8f908c2c3a270f2d1ae574c2badb1fbcf51484 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -597,7 +597,6 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 	/* Start a new aux session */
 	buf = perf_aux_output_begin(handle, event);
 	if (!buf) {
-		event->hw.state |= PERF_HES_STOPPED;
 		/*
 		 * We still need to clear the limit pointer, since the
 		 * profiler might only be disabled by virtue of a fault.
@@ -608,15 +607,19 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 
 	limit = buf->snapshot ? arm_spe_pmu_next_snapshot_off(handle)
 			      : arm_spe_pmu_next_off(handle);
-	if (limit)
-		limit |= PMBLIMITR_EL1_E;
+	if (!limit)
+		goto out_write_limit;
 
 	limit += (u64)buf->base;
+	limit |= PMBLIMITR_EL1_E;
 	base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
 	write_sysreg_s(base, SYS_PMBPTR_EL1);
 
 out_write_limit:
 	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
+
+	if (!limit)
+		event->hw.state |= PERF_HES_STOPPED;
 }
 
 static void arm_spe_perf_aux_output_end(struct perf_output_handle *handle)

-- 
2.34.1

