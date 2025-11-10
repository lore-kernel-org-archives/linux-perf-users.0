Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14EE280A5A;
	Mon, 10 Nov 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792128; cv=none; b=ieRHukfnCPHcZIf+53V1ccRu9sojNrr//uYQ7Ihec0CZszl7ThESgDszDd3PYPCiCmoaLWpEu2MEsb+cD2YsrLUmdreGBcaWV+QNzWEsX8EQBj9j0bVdVvBvo4h1TwKaZZCN8fQzT+Ciihz+5MYPZizbzRKG3C+UXBQ8qYQagt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792128; c=relaxed/simple;
	bh=l/aU0HZFwL9DexYyDyDNj/KW5vxEQESB+dU0Cog8fmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bFSqjm0Fbuyobg+IRX0WnVxxbZIN1vAf1laB5Z1iWu2rYsapn35m5jOcb11Xuj6JeAJFk4iEkVcp+gpIZ4D2XdiJFLS1ISM91bQ94gUIgms8ZYs1V5hXxbbhhYhp0BeHyi4Lw1biXXwvzhSk6NpxMyKh0/bdT3YauQbsLFrj1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 824C916A3;
	Mon, 10 Nov 2025 08:28:38 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F4523F66E;
	Mon, 10 Nov 2025 08:28:45 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 10 Nov 2025 16:28:32 +0000
Subject: [PATCH v2 2/2] perf: arm_spe: Ensure profiling buffer is properly
 disabled
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251110-arm_spe_fix_truncated_flag-v2-2-a629740985cc@arm.com>
References: <20251110-arm_spe_fix_truncated_flag-v2-0-a629740985cc@arm.com>
In-Reply-To: <20251110-arm_spe_fix_truncated_flag-v2-0-a629740985cc@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792122; l=1864;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=l/aU0HZFwL9DexYyDyDNj/KW5vxEQESB+dU0Cog8fmY=;
 b=MFjvNr8klWeo7hLRbQ8b/v89thS4UmvzMhR8j8p+QGdvZ1ckEAuOLFlQn9yaHuEVzICSJEDs6
 ZeCAgwsGsq+DNw3B/BilBY0qtHm5KdabmEEFH9VkRxdRYTsRXTbrQr4
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

During interrupt handling, if arm_spe_perf_aux_output_begin() fails to
calculate a valid limit, it queues the disable callback in the IRQ work
and sets the PERF_HES_STOPPED flag.

Afterwards, the disable callback arm_spe_pmu_stop() is invoked, but
since the PERF_HES_STOPPED flag has already been set, arm_spe_pmu_stop()
exits immediately. As a result, the profiling buffer is not properly
stopped — profiling on exception levels is not disabled, and buffered
data is not drained.

To fix this, explicitly disable the profiling buffer for stopped events
in the interrupt handler.

Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fc8f908c2c3a270f2d1ae574c2badb1fbcf51484..4f51510d5f8a660c12e3934eae8a66f1a1416617 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -761,6 +761,20 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
 		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)) {
 			arm_spe_perf_aux_output_begin(handle, event);
 			isb();
+
+			/*
+			 * A non-zero state indicates that an error occurred in
+			 * arm_spe_perf_aux_output_begin(), for example, if the
+			 * buffer overflowed and failed to get a valid limit.
+			 *
+			 * Since the PERF_HES_STOPPED flag has been set, the
+			 * afterwards disable callback exits immediately and
+			 * the buffer disable flow is skipped (see
+			 * arm_spe_pmu_stop()). Explicitly disable the profiling
+			 * buffer here.
+			 */
+			if (event->hw.state)
+				arm_spe_pmu_disable_and_drain_local();
 		}
 		break;
 	case SPE_PMU_BUF_FAULT_ACT_SPURIOUS:

-- 
2.34.1

