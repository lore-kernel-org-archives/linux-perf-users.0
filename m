Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792945475;
	b=Hx5hjxfhuf1D7liztNqMGHPgjfrBayxHaJjY3zrBcPBhAiIXY8/ayGEuhg6KEQjU8F6m
	 0nlQId/mHepjty2wYBxYfhZN5aEbv6Y8koojlJ5nwBp/ijAwF/lXrwnMMzo/mBzEx12cQ
	 fIqNibjOTzHwYdJwe8R2xkisEjHa5pd94CLLkxd1dtpLxrOis1m5QVnk43SVqB3Bn6xnm
	 5JtrFbUIVsoH5cM70hCN9zlbEg6l7x6cVoSx02ZMQgjKpOy8fPf6yTkBWt1grydyG/7uU
	 a3uPqgHCkd5x4nyt4eCiiAZp6kUWYAeRNmtQ3AcK3VfiY1lM1cYlPXLX6cgE4H2dSXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792945475;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=c2ZwSUvISahkObZiE8tNnKfQSgL0vnLyigfSBhzpSG8=;
	b=z9OtoOiCGzTZPVeIt07AZNi7KtKXCW7Gz4tuMyJTcurHv2at51ghPg47Ha3Wv6gwir4X
	 vUcdonlQeK4sJC6+ZZp3DuOMx7lx16iePqbx7P/+PxPIA70nvvJ5F6TXl+OWbLpdSGPds
	 7anOnaJmLTdasijpOVv77ECjvjxSmRIruo7L2sXcRAs0oAD+ASSHfj8kpsAhQ1uNKO8iw
	 Q4eKl8yJ2NQy4u1yKc/x3PpACfwYntVmQ/9q7AFOrmcX7+gogMehmOe+Aw9tP50gkkzaA
	 g1Hd6Ym8WeDIOE9wOJZstpFu+YwFEgztJHId1n97snTYL4NFiQuvSxd0bFnfKDkhSeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XBTMmGeZ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95796606A31B;
	Sun, 25 Oct 2026 16:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95796606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XBTMmGeZ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A1851688;
	Sun, 25 Oct 2026 09:24:23 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A74CD3F7B4;
	Sun, 25 Oct 2026 09:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792945466; bh=Wa5FEiznotdGRjUAu7xhk4BKqfMZW4oKuBsX6e09kyk=;
	h=From:Date:Subject:To:Cc:From;
	b=XBTMmGeZHkjM+Wh27vgs0gx+Vryw2mbsdA/yVCIYwxazl6YoAfBBi8Mb3LvA0qgzY
	 Pv/ZwP5lclzPec3iiK/GHFyLNI09lNZQc9yYtPIZDdg4qkMoM+9MwK6p6CvtPUW+3l
	 F1XZdHTZirQFoLPkX5tDBXVfXIiobLOcoJHVDhXY=
From: Leo Yan <leo.yan@arm.com>
Date: Sun, 25 Oct 2026 16:24:06 +0000
Subject: [PATCH] Revert "perf/aux: Allocate non-contiguous AUX pages by
 default"
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-perf_revert_prefer_large_alloc-v1-1-5fb431bbd624@arm.com>
X-B4-Tracking: v=1; b=H4sIACUt3moC/x2NUQqDMBAFryL7bSBJMaG9SpEQ9EUXgsqmlILk7
 o1+DgwzJxUIo9CrO0nw5cL71sD0HU1r3BYonhuT1dYZbQd1QFJoJuQTDkGChBxlQYg575OK2ng
 /u4d/Jkctcin8uwfvsdY/489yl3AAAAA=
X-Change-ID: 20261025-perf_revert_prefer_large_alloc-a0177d6379f6
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Yabin Cui <yabinc@google.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner <tglx@kernel.org>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Tamas Petz <tamas.petz@arm.com>, Tamas Zsoldos <tamas.zsoldos@arm.com>, 
 Michiel van Tol <michiel.vantol@arm.com>, Dev Jain <dev.jain@arm.com>
Cc: coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792945462; l=5825;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=Wa5FEiznotdGRjUAu7xhk4BKqfMZW4oKuBsX6e09kyk=;
 b=enQwGhfr5sTaKC2BbDvEtznAEqp0JWMmf2YawrTgqEV0dISIAS4VEIfOxtnv3JwcGaaKD5rw4
 ifrzWaa3r+hAyJXCQRp8T7Js7b/l4u/xuazoR7JLqZOcBeT5erRDYpN
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This reverts commit 18049c8cff9cc89daadc4df6975f7d9069638926.

The original commit claimed that contiguous AUX pages unnecessarily
exacerbate fragmentation for SPE, TRBE and ETR. This is not generally
valid: larger allocations can keep pages with the same lifetime
together, while order-0 allocations can scatter them across large
blocks and prevent free pages from coalescing [1]. The follow-up
discussion [2] has not established how forcing order-0 allocations
addresses the reported problem.

TRBE and SPE write to virtually addressed buffers. The TRBE L1 TLB
has one entry on Neoverse V2 [3] and two on Neoverse V3 [4]. Small
mappings increase translation pressure, and TTW stalls can contribute
to FIFO overflow and trace loss on TRBE.

Larger allocations provide contiguous, aligned chunks for PMD or
contiguous-PTE mappings with the proposed vmap() support [5].
With the proposed vmap() support already applied, the tests in [2]
showed that preferring larger AUX allocations reduced L2 data TLB
refills by 99.68% in the TRBE test and 34.74% in the SPE test.

Restore the previous policy of trying higher-order allocations first.
The allocator already uses __GFP_NORETRY and falls back to smaller
orders, including order 0, when larger allocations fail.

Remove PERF_PMU_CAP_AUX_PREFER_LARGE, since the restored default
provides that preference. Intel PT retains its existing allocation
behaviour, with no functional change.

[1] https://lore.kernel.org/all/aPjrRkjiIt6HmXmT@casper.infradead.org/
[2] https://lore.kernel.org/linux-arm-kernel/20260810-perf_aux_trace_large_granule-v1-0-03306c9339e3@arm.com/
[3] https://documentation-service.arm.com/static/633fe1ec4c59b30b517730b8#page=52
[4] https://documentation-service.arm.com/static/67361bd2c7fc0d1f211da382#page=54
[5] https://lore.kernel.org/linux-mm/20260715120813.3609949-1-jiangwen6@xiaomi.com/

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 arch/x86/events/intel/pt.c  |  2 --
 include/linux/perf_event.h  |  5 ++---
 kernel/events/ring_buffer.c | 29 +++++++++--------------------
 3 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 49349afee6119fb6fad815c847cb3cd9daa97604..3782af40f0832a874a7f0b60961d6652513de241 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1896,8 +1896,6 @@ static __init int pt_init(void)
 
 	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
 		pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_NO_SG;
-	else
-		pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_PREFER_LARGE;
 
 	pt_pmu.pmu.capabilities		|= PERF_PMU_CAP_EXCLUSIVE |
 					   PERF_PMU_CAP_ITRACE |
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index eb3f7bab498ca9bee9ce7193744943b24ab2e0c5..b8d8b005f5c8a7c1def7cad02230bf9ffb876bd6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -304,9 +304,8 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_AUX_OUTPUT		0x0080
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100
 #define PERF_PMU_CAP_AUX_PAUSE		0x0200
-#define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
-#define PERF_PMU_CAP_MEDIATED_VPMU	0x0800
-#define PERF_PMU_CAP_SIMD_REGS		0x1000
+#define PERF_PMU_CAP_MEDIATED_VPMU	0x0400
+#define PERF_PMU_CAP_SIMD_REGS		0x0800
 
 /**
  * pmu::scope
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 64d4dbdc6c071b72b670dd044616f52981206ae8..95f4fbdfd2764de5b72d901d778c46302f525fad 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -684,15 +684,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 {
 	bool overwrite = !(flags & RING_BUFFER_WRITABLE);
 	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
-	bool use_contiguous_pages = event->pmu->capabilities & (
-		PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_PREFER_LARGE);
-	/*
-	 * Initialize max_order to 0 for page allocation. This allocates single
-	 * pages to minimize memory fragmentation. This is overridden if the
-	 * PMU needs or prefers contiguous pages (use_contiguous_pages = true).
-	 */
-	int max_order = 0;
-	int ret = -ENOMEM;
+	int ret = -ENOMEM, max_order;
 
 	if (!has_aux(event))
 		return -EOPNOTSUPP;
@@ -702,8 +694,8 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 
 	if (!overwrite) {
 		/*
-		 * Watermark defaults to half the buffer, to aid PMU drivers
-		 * in double buffering.
+		 * Watermark defaults to half the buffer, and so does the
+		 * max_order, to aid PMU drivers in double buffering.
 		 */
 		if (!watermark)
 			watermark = min_t(unsigned long,
@@ -711,19 +703,16 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 					  (unsigned long)nr_pages << (PAGE_SHIFT - 1));
 
 		/*
-		 * If using contiguous pages, use aux_watermark as the basis
-		 * for chunking to help PMU drivers honor the watermark.
+		 * Use aux_watermark as the basis for chunking to
+		 * help PMU drivers honor the watermark.
 		 */
-		if (use_contiguous_pages)
-			max_order = get_order(watermark);
+		max_order = get_order(watermark);
 	} else {
 		/*
-		 * If using contiguous pages, we need to start with the
-		 * max_order that fits in nr_pages, not the other way around,
-		 * hence ilog2() and not get_order.
+		 * We need to start with the max_order that fits in nr_pages,
+		 * not the other way around, hence ilog2() and not get_order.
 		 */
-		if (use_contiguous_pages)
-			max_order = ilog2(nr_pages);
+		max_order = ilog2(nr_pages);
 		watermark = 0;
 	}
 

---
base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
change-id: 20261025-perf_revert_prefer_large_alloc-a0177d6379f6

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

