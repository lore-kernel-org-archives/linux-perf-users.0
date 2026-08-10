Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C453FF8AD;
	Mon, 10 Aug 2026 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373123; cv=none; b=JylmXi6+uLqbw0TOYJZVPuRrXCtj62GWCQAWImxcvQxkOLpl3EgNl/mk5HQeyzsdAFQm6KPA5AkEwq4HgF1bscsqnM9T2u4UkdJU1LeRbP0C5anLDIP2lj9HPEsVeMCGOreI/JXKKIzG8jB0d0xJMVE6QkDzS91dhMPv5eUuVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373123; c=relaxed/simple;
	bh=rndGpDOOwKFFZbFJHDMOhNPElPkCEXmJILpKy8IZlOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AdJczC1PXnZPhAy0Z2OOXLe2hxq3KxPMIUqKvWAUjju5rmO2+zw4m9wz6Dn9H9TQtytBpzJZPIiqZF3xHGoN18YGhDJokGGiQKJcWdr46tWXQ28R/2OH2ixedUALUrW/UYL5xjUMg3kHqV9HWoWmzN0jQliWZM4qKZfCKxeXV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KLHD2G7r; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KLHD2G7r"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26B9D1516;
	Mon, 10 Aug 2026 07:45:17 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12FDA3F86F;
	Mon, 10 Aug 2026 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786373121; bh=rndGpDOOwKFFZbFJHDMOhNPElPkCEXmJILpKy8IZlOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KLHD2G7r8AQ+jrXy1OYuyGK+D3R4RutlHjYgDuuwU7/bpALEGZ/xvAw1WejxThnbM
	 ehzvE7VZWVgEWNLEPX1wzgt0UuOTaNL83r4pP+UxVgjsJauT+oAq+RGEmiiDN5b2sv
	 mb1pwQ1QVkZVrtv2HZZM/U2sl1+vZ6gDMQePHq94=
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 10 Aug 2026 15:44:41 +0100
Subject: [PATCH 1/2] coresight: perf: Prefer large AUX mappings
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-perf_aux_trace_large_granule-v1-1-03306c9339e3@arm.com>
References: <20260810-perf_aux_trace_large_granule-v1-0-03306c9339e3@arm.com>
In-Reply-To: <20260810-perf_aux_trace_large_granule-v1-0-03306c9339e3@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>, 
 Tamas Zsoldos <tamas.zsoldos@arm.com>, 
 Michiel van Tol <michiel.vantol@arm.com>, Dev Jain <dev.jain@arm.com>, 
 David Hildenbrand <david@kernel.org>, Yabin Cui <yabinc@google.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786373116; l=2435;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=evv7XjftHtscB+lJLe9pcHq8V246fb1R/QmDUNb49SM=;
 b=qqb1uyE0/5XqA+fICm1gisB2NhhJCGR4hYSbbjV7HsbSuEWUICSF/5X0sL8f8dQQPUyXKY3BR
 f40Zo7xnWYUAx9ozVl4uhX7EM91ccmCw3m74e9OV532EPLnqZ8V7aZj
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

From: Dev Jain <dev.jain@arm.com>

Commit 18049c8cff9c ("perf/aux: Allocate non-contiguous AUX pages by
default") changed AUX allocation to use order-0 pages by default unless
a PMU explicitly asks for contiguous allocations. That reduces
unnecessary memory fragmentation for PMUs which do not require larger
AUX chunks.

TRBE relies on page-table translation for writing the AUX buffer. If a
large AUX buffer is built from order-0 pages, vmap() has to map it with
many small mappings. This adds TLB pressure from the trace unit itself,
and can increase trace-buffer latency and contribute to trace
discontinuities.

Set PERF_PMU_CAP_AUX_PREFER_LARGE for the CoreSight PMU. This asks the
generic AUX allocator to try larger-order allocations so that, with
the vmap() large-mapping support, contiguous chunks can be mapped with
larger granules.

Apply the same preference to traditional sinks such as ETR. ETR uses
double buffering (a bounce buffer and an AUX buffer) and does not use
CPU page table when accessing the bounce buffer, so this does not
benefit TTW latency there. It can still help when the driver or perf
tool accesses the AUX buffer.

With the mm large-mapping series already applied, a sparse branch test
using a 1GB AUX buffer with TRBE showed the following results over 10
iterations:

  l1d_tlb_refill: 163.7 -> 148.2  (-9.47%)
  l2d_tlb_refill: 161,884.9 -> 513.1  (-99.68%)
  dtlb_walk: 72.8 -> 63.9  (-12.23%)

This shows the intended reduction in TLB refill pressure and TLB walks
once the AUX buffer can use larger mappings.

Signed-off-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 09b21a711a8764ea429d712890265c84648e889e..9646a1aab65b5b0b75c622bd18667ba0b916674f 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -1036,7 +1036,8 @@ int __init etm_perf_init(void)
 
 	etm_pmu.capabilities		= (PERF_PMU_CAP_EXCLUSIVE |
 					   PERF_PMU_CAP_ITRACE |
-					   PERF_PMU_CAP_AUX_PAUSE);
+					   PERF_PMU_CAP_AUX_PAUSE |
+					   PERF_PMU_CAP_AUX_PREFER_LARGE);
 
 	etm_pmu.attr_groups		= etm_pmu_attr_groups;
 	etm_pmu.task_ctx_nr		= perf_sw_context;

-- 
2.34.1

