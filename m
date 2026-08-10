Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A973FD121;
	Mon, 10 Aug 2026 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373121; cv=none; b=jyOiX8ZDY+v7hTJhPW21vxz/+xmnmrTYnXhcWLCZizqjwzgO6k2FR7Ubqju1fKqTac0KkVQbqIXzfr31UBIHUeiq8RM+3WLsxSRUFwKQONy+nRliU0cKg6DoADEr2yOVjT440azRpJzDwr6SByOsblt0iH0BTz68l86lQ0ujNyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373121; c=relaxed/simple;
	bh=lR9RsWa9YwMGSZLK9zGUNTtHx75HhVKXKnB25jcbvgE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d44NEGZiUNapd84PlZ9VU1JvuaVaWdmOAECNn7beu6wwqnh87lK+UtLo7y4QMmv1arVDURV+thWD7oUEqGv1E5Gp2mCp/XxshkIVaS6+vMOjFY4rGpy++NvKxXj9NGyiOmr6reCJBix76Nawq8BGMkUkn0WpbiL4ab/aTojuL5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AxoTYWzl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AxoTYWzl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8B8A14BF;
	Mon, 10 Aug 2026 07:45:14 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1DA73F86F;
	Mon, 10 Aug 2026 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786373118; bh=lR9RsWa9YwMGSZLK9zGUNTtHx75HhVKXKnB25jcbvgE=;
	h=From:Subject:Date:To:Cc:From;
	b=AxoTYWzlqZ9uJ75aYFaVtYy/LyFM2LLrAz7GLETJWL8pLcew1mk1Krc7Va32Nu3Vc
	 TUldT2lGrYc/GCzjeh2wvhR+MwR3loipooBFeh6sp/f2o6vSoVXpA6AVqiQhbClkek
	 kXcQpYi1T6JoUmggV36KjkLdtvqR81o4uFXdlM2w=
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH 0/2] perf/arm: Prefer large AUX mappings for CoreSight and
 SPE
Date: Mon, 10 Aug 2026 15:44:40 +0100
Message-Id: <20260810-perf_aux_trace_large_granule-v1-0-03306c9339e3@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANjjeWoC/33NywqDMBCF4Vcps25KYlslXfU9ioRJnGjAGxMVi
 /juTYVuu/zP4jsbROJAER6nDZiWEMPQp1DnE7gG+5pEqFJDJrNcFqoQI7E3OK9mYnRkWuSaTM3
 Yzy2JSturdE7d7B0hESOTD+vBv8rUTYjTwO/jbVHf9Qfr//CihBTe5V5n3ha51U/k7uKGDsp93
 z97TzZ3xgAAAA==
X-Change-ID: 20260717-perf_aux_trace_large_granule-d9b30cc14b5a
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786373116; l=5308;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=lR9RsWa9YwMGSZLK9zGUNTtHx75HhVKXKnB25jcbvgE=;
 b=KJpm1mhSgiId0zE1EwYPY8OlCcnVxqUYKBM4Qm7YQcSWrEUKPrbzGm8Ub/iZ5Ui/lO/3LmjFM
 PF+YeIGIt4nDQCgcQfeBdhkPXfcnpiKQ8hXLAeWIrgL3ash+XJduUjp
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Since the commit:

 18049c8cff9 ("perf/aux: Allocate non-contiguous AUX pages by default")

it changed the AUX buffer allocator to allocate AUX pages page-by-page
(order=0) unless a PMU explicitly asks for contiguous allocations via
the capability flag PERF_PMU_CAP_AUX_PREFER_LARGE. The goal was to make
AUX allocation more memory-friendly by default, because not all PMUs
require physically contiguous AUX pages and large contiguous allocations
can contribute to fragmentation on long-running systems.

However, Arm SPE and CoreSight/TRBE rely on page-table translation when
writing trace data to memory. With page-by-page AUX allocation, a large
AUX buffer is mapped with many small mappings. This increases TLB
pressure, in practice this can increase trace-buffer latency due to
table translation walks (TTW) and contribute to trace discontinuities.

This series restores large AUX allocation for Arm CoreSight and SPE by
setting PERF_PMU_CAP_AUX_PREFER_LARGE.

This is intended to work together with the mm large-mapping series [1].
That series allows vmap() to map physically contiguous pages with
larger granules. With this series, perf first tries larger-order AUX
allocations, and the vmap() code can then create larger mappings for the
contiguous chunks.

The fragmentation concern from commit 18049c8cff9c should not block this
opt-in. PERF_PMU_CAP_AUX_PREFER_LARGE is a preference, not a hard
requirement. The AUX allocator already falls back to smaller orders when
a high-order allocation fails. So this series gives Arm trace PMUs the
performance benefit when large chunks are available.

The comparison below uses a baseline that already includes the mm
large-mapping series [1]. "Baseline" means that the mm series is applied
but this Arm PMU series is not. "Large AUX" means the same kernel plus
this series. Some configurations to mitigate noise during test:

  1) The tests were run with CPU10 isolated with the kernel parameter
     "isolcpus=10".
  2) CPU10 was used as the traced CPU, the PMU counter CPU, and the
     workload CPU. The perf control tasks were pinned to CPU2 so that
     they did not add extra work on CPU10.
  3) Each test was run for 10 iterations, and the tables report the
     average counter values across those runs.

The results show that using larger AUX mappings reduces the TLB pressure.
This is mainly visible in the refill events: CoreSight/TRBE shows a
large drop in l2d_tlb_refill and a smaller reduction in l1d_tlb_refill,
while SPE also reduces l2d_tlb_refill. The dtlb_walk event also drops in
both tests, which shows fewer data TLB walks after the AUX buffer can be
mapped with larger granules.

ETM sparse branch delay (cs_etm, AUX 1GB)

  taskset -c 2 perf stat -C 10 -e cycles:u,instructions:u,dtlb_walk:u,l1d_tlb:u,l1d_tlb_refill:u,l2d_tlb_refill:u \
    -- taskset -c 2 perf record -C 10 -m ,1G -e cs_etm// \
    -- taskset -c 10 ./sparse_branch_delay.elf

 |                | Baseline  | Large map |            |         |
 | Metric         | Avg.      | Avg.      | Delta      | Change  |
 |----------------+-----------+-----------+------------+---------|
 | dtlb_walk      |      72.8 |      63.9 |       -8.9 | -12.23% |
 | l1d_tlb        |   7,434.4 |   1,982.2 |   -5,452.2 | -73.34% |
 | l1d_tlb_refill |     163.7 |     148.2 |      -15.5 |  -9.47% |
 | l2d_tlb_refill | 161,884.9 |     513.1 | -161,371.8 | -99.68% |

SPE dd memory copy (arm_spe, AUX 512MB)

  taskset -c 2 perf stat -C 10 -e cycles:u,instructions:u,dtlb_walk:u,l1d_tlb:u,l1d_tlb_refill:u,l2d_tlb_refill:u \
    -- taskset -c 2 perf record -C 10 -m ,512M -e arm_spe_0/ts_enable=1,pa_enable=1,period=64,min_latency=0/ \
    -- taskset -c 10 dd if=/dev/zero of=/dev/shm/dd_mem_test bs=1M count=1024 status=progress

 |                | Baseline  | Large map |            |         |
 | Metric         | Avg.      | Avg.      | Delta      | Change  |
 |----------------+-----------+-----------+------------+---------|
 | dtlb_walk      |   1,760.2 |   1,387.9 |     -372.3 | -21.15% |
 | l1d_tlb        | 257,312.4 | 251,460.9 |   -5,851.5 |  -2.27% |
 | l1d_tlb_refill |  15,921.9 |  15,933.6 |       11.7 |  +0.07% |
 | l2d_tlb_refill |   4,285.0 |   2,796.5 |   -1,488.5 | -34.74% |

Note that after setting PREFER_LARGE for CoreSight and SPE, the existing
AUX trace drivers either prefer large pages or, in the case of Intel
BTS/PT, use the stronger AUX_NO_SG constraint. We can refactor this
later by either dropping PREFER_LARGE entirely or reversing the flag if
a driver needs discrete pages. For now, keep PREFER_LARGE to preserve
flexibility in the allocation policy.

[1] https://lore.kernel.org/linux-mm/20260715120813.3609949-1-jiangwen6@xiaomi.com/

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Dev Jain (1):
      coresight: perf: Prefer large AUX mappings

Leo Yan (1):
      perf: arm_spe: Prefer large AUX mappings

 drivers/hwtracing/coresight/coresight-etm-perf.c | 3 ++-
 drivers/perf/arm_spe_pmu.c                       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260717-perf_aux_trace_large_granule-d9b30cc14b5a

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

