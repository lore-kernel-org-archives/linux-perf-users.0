Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ABC30AD00;
	Mon,  1 Dec 2025 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588158; cv=none; b=YK3G0q34bXkBgXe9uAcE16g280QwMi0bg73p4kFC/O7CrnvgFmoakXQNRa2UI7YGS129G9eeaDaR8BKreHsDYLyEMRHlihDbPSOrob1jBld8aQj4r3AvJp7lCSyYGndi22quKb9anR1/CmjkWb/J+unZnED8II1fBcMMCDvHumo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588158; c=relaxed/simple;
	bh=19hsKtZvm/XjHbnhnNNNKO3wE2KHI7/1sDLKvI2Gz50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tF7/AzSQ09iBE5weYcUS3o1zexPp25UA5FkcfVRb7BTwxwWH6cS8Up610tTu8MOcEqScOhCcpSWSG3onwDl02yu+5sBE36CciTCpM8t0tpK1oTosT4aq2chN5ZPm81LX0kF2EfnP8aDAxeox5M65OvVLzjb7kFxeNBRe94Yat/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00A921595;
	Mon,  1 Dec 2025 03:22:29 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D600E3F59E;
	Mon,  1 Dec 2025 03:22:33 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 01 Dec 2025 11:22:00 +0000
Subject: [PATCH 10/19] coresight: trbe: Always check fault action when
 updating buffer
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-10-7da32b076b28@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=1745;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=19hsKtZvm/XjHbnhnNNNKO3wE2KHI7/1sDLKvI2Gz50=;
 b=8n4+DTzS10CUKp2NbJ+DyZWEvFEL1+PXV1SpJ3BDr6n+4wRuWUa2C6q2/hZ1eCDj8o28E+q7i
 EPgYQV4HJPCA/CzTRI0GK1JPf7SF2cokf8x2mWVYtalawIGlx/dXa2q
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The current code checks the fault action only via the IRQ status bit,
which is unreliable due to possible hardware latency.

Move the fault action check out of the IRQ status condition.  This also
causes the buffer size to be calculated for non-WRAP and fault cases,
which is fine since the write pointer is trusted for the calculation.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index f56ecdeaa6596afb440e4d53732e08a85f9bf89d..e579ea98523c24d23a0cd265dcdd0a46b52b52da 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -806,7 +806,6 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
 	enum trbe_fault_action act;
 	unsigned long size, status;
 	unsigned long flags;
-	bool wrap = false;
 
 	WARN_ON(buf->cpudata != cpudata);
 	WARN_ON(cpudata->cpu != smp_processor_id());
@@ -858,21 +857,11 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
 		 */
 		clr_trbe_irq();
 		isb();
-
-		act = trbe_get_fault_act(handle, status);
-		/*
-		 * If this was not due to a WRAP event, we have some
-		 * errors and as such buffer is empty.
-		 */
-		if (act != TRBE_FAULT_ACT_WRAP) {
-			size = 0;
-			goto done;
-		}
-
-		wrap = true;
 	}
 
-	size = trbe_get_trace_size(handle, buf, wrap);
+	act = trbe_get_fault_act(handle, status);
+
+	size = trbe_get_trace_size(handle, buf, act == TRBE_FAULT_ACT_WRAP);
 
 done:
 	local_irq_restore(flags);

-- 
2.34.1

