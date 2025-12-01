Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3664E308F28;
	Mon,  1 Dec 2025 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588144; cv=none; b=vFQ2F4KLHOeAngYihY7ezlabvOHTqPWQNjDoxTSegBB64KJtg0Ki8+f4CQesiOhHGeQ3yDg3jmhM43Q0WvXjHNQftKVLrj6hJdDmYL98wt3J26fyGvChNzEDcJCkL9i2nXwjAJhmPwMyUzOto1rH90igwR/1ijhjyhHR1tDDM5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588144; c=relaxed/simple;
	bh=lB/NC74zZrDVCqfwFSRLgRpttiHzTgZXwBAD9mmFzVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n7/afdw0SUzJNBV02Hoayo51d/undo/svNPPaqxaPb52Fna6o5LChIWr5ZUo6jwciHeLL/NC6fV4cIqIbBs6KCq/7ZaZ+8uWC20JHOzFf8/JSjLs9+tSVX+U5r1IyYrny26LI9CjtcIv/ffVnmHjhR/Eif3IHfWoUU1FODk3V2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04AC9153B;
	Mon,  1 Dec 2025 03:22:15 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB5B23F59E;
	Mon,  1 Dec 2025 03:22:19 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 01 Dec 2025 11:21:55 +0000
Subject: [PATCH 05/19] coresight: trbe: Refactor status clearing
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-5-7da32b076b28@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=1736;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=lB/NC74zZrDVCqfwFSRLgRpttiHzTgZXwBAD9mmFzVM=;
 b=IeoS+fXPb5TGOyYZgypSVdCG859ipU9WOW5rq3/di9udWyJqYqCiH3YljHwdz/NfPitGMPKfa
 nqSNvOFWDvrCzkIpXQ5osHvR5/dWyClsHnW/Tnr+sdyCr4DvqEBKZBH
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

If the driver does not clear the status when disabling the trace buffer
unit, stale state will carry over to the next enable, though the driver
clears it again on enable.

Explicitly clear status after the trace is disabled in the interrupt
handling and when a perf session ends.  Keep the status for spurious
interrupts for continuous tracing.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index e426991e2c2c398a9d3982e9d0f7f542e404cbab..9e565122816949b37b8ff5e4ba04cfbc317c6f25 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -629,7 +629,6 @@ static void trbe_enable_hw(struct trbe_buf *buf)
 	WARN_ON(buf->trbe_hw_base < buf->trbe_base);
 	WARN_ON(buf->trbe_write < buf->trbe_hw_base);
 	WARN_ON(buf->trbe_write >= buf->trbe_limit);
-	clr_trbe_status();
 	set_trbe_base_pointer(buf->trbe_hw_base);
 	set_trbe_write_pointer(buf->trbe_write);
 
@@ -1036,6 +1035,8 @@ static int arm_trbe_disable(struct coresight_device *csdev)
 		return -EINVAL;
 
 	trbe_drain_and_disable_local(cpudata);
+	clr_trbe_status();
+
 	buf->cpudata = NULL;
 	cpudata->buf = NULL;
 	cpudata->mode = CS_MODE_DISABLED;
@@ -1151,6 +1152,10 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 		return IRQ_NONE;
 
 	act = trbe_get_fault_act(handle, status);
+
+	if (act != TRBE_FAULT_ACT_SPURIOUS)
+		clr_trbe_status();
+
 	switch (act) {
 	case TRBE_FAULT_ACT_WRAP:
 		truncated = !!trbe_handle_overflow(handle);

-- 
2.34.1

