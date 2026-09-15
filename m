Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF37C4BA9FB;
	Tue, 15 Sep 2026 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487378; cv=none; b=TQ0bTa4jld79Q5UtEKbGKMQZTTy6YWUP0rGSQb0Lj+klxmZgjkCa60ZCsMUMCQasG7i7xAnbi6EEGD/VynKUl9L9b3tDxqiauN6XOXnwM/zJUAn30uKmCnYKzoWuMzV7ojbqLQ9bPBhDlzRHUpxfqDLt/sP+/sOrmPIR+bpUgWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487378; c=relaxed/simple;
	bh=qzq9lLjuTS6Prgx1lZHT+cj9d8Nv+QaG1PQFXY2Natw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gy92nMWC4I2cAYoY+zfU9KP0zWtJ26hoGgChWfOo6UQPAeNA9sIxQSJDJWZ6inX/XLtwg+CIY6muoK78kpocWMPQNMzVOl8zG2N9/fhosXujy/+AEdyYSo5i3a+zP4yPKKDz5EShLQgO919wU97JfLsOLC5khVW9fxlDpUzhFao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=svDIG3eL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="svDIG3eL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5BCE1570;
	Tue, 15 Sep 2026 08:49:31 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 188F23F882;
	Tue, 15 Sep 2026 08:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487375; bh=qzq9lLjuTS6Prgx1lZHT+cj9d8Nv+QaG1PQFXY2Natw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=svDIG3eLlH+MZGJ+ZjDsOxy/H8oVslMgdwyK82uskiJ5KuLb1GTfGSXOn8ZYcHhGe
	 ScDk1CIVt4a6T3OBuLuvkIAnzeU9Z55PFTl5QpQUr7GrGahv41vnGMYM1It3wQWtDF
	 6H5txtSipDRrpnzRRNIYkm4adKXtgTuKtVI+PQTY=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:48:58 +0100
Subject: [PATCH 12/25] coresight: trbe: Track per-CPU sink interrupt
 handling
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-12-35cf6f297d20@arm.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487340; l=2982;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=qzq9lLjuTS6Prgx1lZHT+cj9d8Nv+QaG1PQFXY2Natw=;
 b=fV8kseG8x7mChJYniDqWNzR+udx1uwnsiclVN65ydu6ywIwAZZNBBmUmJu3DUASq7TPBcvFRm
 bGQeigFplLKDgtd2BTCeBTA0msPVOIhTk5BorL9AYtHGp1YXyjL9XY8
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

A sampling NMI can interrupt TRBE while it is using the active AUX
handle or buffer. Circular buffer mode avoids wrap interrupts but can
still generate fault interrupts.

Add an in_interrupt flag to per-CPU sinks and set it around the TRBE IRQ
handler. Compiler barriers keep AUX buffer accesses between the flag
updates. This lets NMI callbacks detect when they have interrupted sink
handling before modifying its state.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 17 ++++++++++++++++-
 include/linux/coresight.h                    |  2 ++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index ab3c5c7d27f3d272b07eade1e6452559808b196c..8eb625d3fc99db57a18e35ef59ef814dacf20a09 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1185,7 +1185,7 @@ static u64 cpu_prohibit_trace(void)
 	return trfcr;
 }
 
-static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
+static irqreturn_t __arm_trbe_irq_handler(int irq, void *dev)
 {
 	struct perf_output_handle **handle_ptr = dev;
 	struct perf_output_handle *handle = *handle_ptr;
@@ -1249,6 +1249,21 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
+{
+	struct coresight_device *csdev = coresight_get_percpu_sink(smp_processor_id());
+	irqreturn_t ret;
+
+	/* Circular Buffer mode can still interrupt on a fault. */
+	WRITE_ONCE(csdev->in_interrupt, true);
+	barrier();
+	ret = __arm_trbe_irq_handler(irq, dev);
+	barrier();
+	WRITE_ONCE(csdev->in_interrupt, false);
+
+	return ret;
+}
+
 static int arm_trbe_save(struct coresight_device *csdev)
 {
 	struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index ddf18c970e343041787424c2019f2b5dd49154c2..8830c30be0df53a22525ef4fc3c7e41a0ec6fd90 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -275,6 +275,7 @@ struct coresight_trace_id_map {
  *		when a source has been selected and a path is enabled from
  *		source to that sink. A sink can also become enabled but not
  *		activated if it's used via Perf.
+ * @in_interrupt: Per-CPU sink interrupt handler is running.
  * @ea:		Device attribute for sink representation under PMU directory.
  * @def_sink:	cached reference to default sink found for this device.
  * @nr_links:   number of sysfs links created to other components from this
@@ -299,6 +300,7 @@ struct coresight_device {
 	bool orphan;
 	/* sink specific fields */
 	bool sysfs_sink_activated;
+	bool in_interrupt;
 	struct dev_ext_attribute *ea;
 	struct coresight_device *def_sink;
 	struct coresight_trace_id_map perf_sink_id_map;

-- 
2.34.1

