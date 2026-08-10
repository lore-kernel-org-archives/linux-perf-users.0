Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171DB3FFFAB;
	Mon, 10 Aug 2026 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373126; cv=none; b=MOxjJSZ3uy30ogWAnIUTNw6xeCtyOucRD1Q7x2T+v1uWVqL+j3ZUFcLAY4TcxrXo50RJtG4lOy0/eJGyXD0LWL24ndObjxEvo6MD82gQqlqvj729zbvV5EVjAGbs9ck95PgcwF5tkkem8xou5qTL6wLj7ohHo4Oo05It7IXPyZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373126; c=relaxed/simple;
	bh=SQC/qO2QI27h6zSJWRDS8uVqaVhFIZ0RKuXuG7LZlaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GnAsDNzVC+qWG1sESfYY9EQu/JIMhTINWFuwN+ERpcQ/V0Wop3Q2p5rHz/cQeMPflgKp1IfHkt997HFVPZsIVvxojabZjp8VPsgjch4gGHR/B+DRCgSs5FW/w0Wx+KanLRrCveQbf2Ba/MNDLNYC0KjiH749ZH9hiI3tMNh63rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AMAqCP9O; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AMAqCP9O"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C3551570;
	Mon, 10 Aug 2026 07:45:19 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 672F93F86F;
	Mon, 10 Aug 2026 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786373123; bh=SQC/qO2QI27h6zSJWRDS8uVqaVhFIZ0RKuXuG7LZlaw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AMAqCP9Or7ZEE+7irgG1ViDeYpuZrYIpRVqjDSM4Otp3qe8XAxXRqF3ng/Q3ucbWM
	 ZX0VWBf/Kkxcl1datkZYxVl3BxhyrAf5gLF7cHOfk57tF3DkGxn/gdm0kirP6yfTnU
	 EcZsYa7IkKpfPH/y3plMLFdQq/16EwU89KQqo50k=
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 10 Aug 2026 15:44:42 +0100
Subject: [PATCH 2/2] perf: arm_spe: Prefer large AUX mappings
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-perf_aux_trace_large_granule-v1-2-03306c9339e3@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786373116; l=1980;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=SQC/qO2QI27h6zSJWRDS8uVqaVhFIZ0RKuXuG7LZlaw=;
 b=6B791dOu9ElM3tlaEWqLmd/g2vG2sWy54i4443bykJhilWR3o6ls74M/f4767LaiRxIw+4vaX
 PrctZahAIBNBG/UHd7fwHwK7mtDq43MaEn5VTK7W58lFBMxNJfiwcXv
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Commit 18049c8cff9c ("perf/aux: Allocate non-contiguous AUX pages by
default") made the AUX allocator use order-0 pages by default unless a
PMU explicitly asks for contiguous allocations.

SPE writes trace data to the AUX buffer via virtual addresses and relies
on page-table translation. When a large AUX buffer is allocated with
order-0, the buffer is mapped with many small mappings, increasing TLB
pressure from the trace unit itself. This can add translation latency
while collecting trace.

Set PERF_PMU_CAP_AUX_PREFER_LARGE for Arm SPE. This lets the generic AUX
allocator try larger-order chunks first, which can then be mapped by
vmap() with larger granules when the mm large-mapping support is present.

With the mm large-mapping series already applied, dd memory copy test
using a 512MB AUX buffer with SPE showed the following results over 10
iterations:

  l1d_tlb_refill: 15,921.9 -> 15,933.6  (+0.07%)
  l2d_tlb_refill: 4,285.0 -> 2,796.5  (-34.74%)
  dtlb_walk: 1,760.2 -> 1,387.9  (-21.15%)

The main improvement is the lower L2 data TLB refill count, with fewer data
TLB walks as well.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index dbd0da1116390f71edf47c93db2f6fa3b36739d1..02389d3842216d55cd06e9174d2d27ade9a2ce4b 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1064,7 +1064,8 @@ static int arm_spe_pmu_perf_init(struct arm_spe_pmu *spe_pmu)
 	spe_pmu->pmu = (struct pmu) {
 		.module = THIS_MODULE,
 		.parent		= &spe_pmu->pdev->dev,
-		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
+		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE |
+				  PERF_PMU_CAP_AUX_PREFER_LARGE,
 		.attr_groups	= arm_spe_pmu_attr_groups,
 		/*
 		 * We hitch a ride on the software context here, so that

-- 
2.34.1

