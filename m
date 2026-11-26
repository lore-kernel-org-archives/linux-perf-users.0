Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688536;
	b=VvWyBTIrcbHhPP4Wb9LNmAkrv02TNWnnopPQadDySPtXFBzxuvaGuDhXpjOcaFHftZQv
	 DnUiDQ8nb+f4AfP3I7mgJNvTDw5QyZFQwq3PauHCQXZosNxEKaQcjJEJkhRvCqjd0oKVR
	 eWxIyjhJ8lHa133BjPhkFoO9QK4nFNY64/t82rPlaFiczxDGhKpW7wVSRx6qKT6K+ehU1
	 CXUwzcf70UtRVL5kMiXfQnsnZGipJx63iYyAXI0EMOxzLSk7tYiFpNYAxmWjARfE/qFqG
	 l3oqSphfzV/k3qd0TkTnwLx7iK6Z4G95PlLJ0OvlmSFLtqQIjV/ds2auiC+Kvq5MeFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688536;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=8w/f4SiDANi2k7NL/+UPEV4viHGDZQaj6YjN0nW4NYM=;
	b=VajRJBUX71YH+kzP4hKfU/K3L05SasE2fjpi1f4rdcmb5hWgdyBSUAvAMfruBrAvVmAm
	 M0PRqSktbXqGX5ejEq0M+MvpJcUj1/6OHLxGpjrMfulEonG6kJKrPVnPOjCuXCaT0XDLL
	 2ZhJyxTr58wDPJhlqRaSG6qC/Pi0Q07HNHXLLzHkqd2fVmCwgzeRjLAgMJuIb5oDe5x6h
	 1mngKw6tckil0GrmbYEA4JbIDOjnTQr8LD9UT6eUw4T+JbcsxN+oS5YvfjvgodLz/gEnO
	 /0I6eDfeS7c6+ZZS78FVTBOZDKd5uCl1NGE20P6ZB9EBXnp1loAHBJYlDyMEf18vAMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cYYhhzRK;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B736606A321;
	Thu, 26 Nov 2026 10:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B736606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cYYhhzRK
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 945C71BA8;
	Thu, 26 Nov 2026 02:22:12 -0800 (PST)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7D913F86C;
	Thu, 26 Nov 2026 02:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795688535; bh=cQAsHx4brEvocz4pw9S+49oUBP7yt12EafdnARiH7z0=;
	h=From:Date:Subject:To:Cc:From;
	b=cYYhhzRKB9dxOlvatnobSfh1tiq0jxj22LXIgAphQyyYzTM7rcm2ERTIzXkz1piXP
	 iR6dFPCCnrPYd2gdrIxDHx7hoeylgpkgdDBWDOZ7EzDBdRjLVwcAWUKVa+5aUXaUbV
	 rNl49msEHCrykWqQbjo6KmsYTPHe0fEbKkguSf4c=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 26 Nov 2026 10:21:55 +0000
Subject: [PATCH v3] perf/aux: Avoid reclaim for optional higher-order
 allocations
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
Message-Id: <20261126-perf_aux_alloc_optimize_psi-v3-1-e06b921b276a@arm.com>
X-B4-Tracking: v=1; b=H4sIAEIICGsC/43NSw6CMBSF4a2Qjq2hl4fgyH0YQ0q5lZsAbVokK
 GHvFiY6Mg7/M/jOwjw6Qs/O0cIcTuTJDCGSQ8RUK4c7cmpCM4ghFyIuuUWnK/mYK9l1RlXGjtT
 TCyvriSvQhULAUsaKBcE61DTv+vUWuiU/Gvfczyaxrf+5k+CCN1kuVVrrBHV2ka4/KtOzTZ3gS
 4LstwRBqkGqEzYCirT8SOu6vgEsOXZvDgEAAA==
X-Change-ID: 20261109-perf_aux_alloc_optimize_psi-c2f8ce2e9a0c
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Yabin Cui <yabinc@google.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Tamas Petz <tamas.petz@arm.com>, 
 Tamas Zsoldos <tamas.zsoldos@arm.com>, 
 Michiel van Tol <michiel.vantol@arm.com>, Dev Jain <dev.jain@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795688532; l=5702;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=cQAsHx4brEvocz4pw9S+49oUBP7yt12EafdnARiH7z0=;
 b=bD2D7Sa+zfCfAEOqcl7xReOMnxb8zF/6KNcXolgg9V5K0i+CJadiPMA0bM1NeiLP0VtaTTkF4
 T5O3T52g0q3ATr8dVUSIY42UpylylfuN1xuiga05nWS/drYA00Nh9x7
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

PERF_AUX_GFP includes GFP_KERNEL, which contains __GFP_RECLAIM. On
fragmented systems, costly AUX allocations can wake kswapd/kcompactd,
or worse, they can stall in direct reclaim/compaction. Yabin Cui
reported that the resulting memory pressure can trigger Android's lmkd
to kill applications.

For PMUs that support scatter-gather, higher-order AUX allocations are
optional. Clear __GFP_RECLAIM and set __GFP_NOMEMALLOC for these
attempts. Perf can then use contiguous pages when available and fall
back to smaller orders without reclaiming memory or drawing on emergency
reserves for the larger allocation.

The comparison is based on Yabin's result from an Android Pixel, a
production phone with 4 KiB pages, 12 GiB of RAM and 6 GiB of zram.

  v7.4-rc3-sim
    Android baseline kernel with the v7.4-rc3 perf AUX and page
    allocator paths, including commit 526d945ad9c0 ("Revert "perf/aux:
    Allocate non-contiguous AUX pages by default"") and
    commit 0e05a469c294 ("mm/page_alloc: avoid direct reclaim and
    compaction for costly __GFP_NORETRY allocations").

  rc3 + no-reclaim
    The same baseline with this patch's GFP flag changes applied only
    to optional higher-order AUX allocations.

The test allocated 4 MiB AUX buffer per CPU while running Dev Jain's
compact-bench [1] at 90%, 95% and 99% memory pressure. Both kernels
completed ten runs at each level without an AUX buffer allocation
failure. Across the 30 runs per kernel, system-wide memory stall time
(PSI some) fell by 97.7%.

  Totals over 30 runs        v7.4-rc3-sim   rc3 + no-reclaim
  Memory PSI some (ms)           1,840.29              41.78
  compact_stall                       522                  0
  allocstall                          161                  0
  compact_daemon_wake                  14                  0
  sp_kswapd_wk                         21                  1

In a separate test with realistic Android memory fragmentation, lmkd
killed an application during TRBE testing on the baseline kernel, and
SPE allocations stalled in direct compaction and reclaim. Neither issue
was observed with this patch applied. When memory was unfragmented,
the patched kernel allocated AUX buffer chunks at order 9 (2 MiB).

[1] https://lore.kernel.org/all/d2b8edf0-39ab-4a44-bd0d-58230dee2fad@arm.com/

Reported-by: Yabin Cui <yabinc@google.com>
Link: https://lore.kernel.org/lkml/CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak6LyV_We7yBQ@mail.gmail.com/
Suggested-by: Yabin Cui <yabinc@google.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Tested-by: Yabin Cui <yabinc@google.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v3:
- Updated commit log to clarify the cause on fragmented systems (Dev).
- Added review and test tags (Yabin and Dev).
- Link to v2: https://lore.kernel.org/r/20261125-perf_aux_alloc_optimize_psi-v2-1-b2ac7ed12849@arm.com

Changes in v2:
- Dropped __GFP_RETRY_MAYFAIL and kept __GFP_NORETRY, as no allocation
  failures were observed in Android testing. (Dev/Yabin)
- Updated the commit log based on Yabin's test results to reflect the
  benefits on Android. (Yabin)
- Link to v1: https://lore.kernel.org/r/20261109-perf_aux_alloc_optimize_psi-v1-1-d56ac4bf3ef5@arm.com
---
 kernel/events/ring_buffer.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 95f4fbdfd2764de5b72d901d778c46302f525fad..317a0454be8b26d60a14a5790a15625868836257 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -619,7 +619,7 @@ long perf_output_copy_aux(struct perf_output_handle *aux_handle,
 
 #define PERF_AUX_GFP	(GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY)
 
-static struct page *rb_alloc_aux_page(int node, int order)
+static struct page *rb_alloc_aux_page(int node, int order, bool no_sg)
 {
 	struct page *page;
 
@@ -627,7 +627,16 @@ static struct page *rb_alloc_aux_page(int node, int order)
 		order = MAX_PAGE_ORDER;
 
 	do {
-		page = alloc_pages_node(node, PERF_AUX_GFP, order);
+		gfp_t gfp = PERF_AUX_GFP;
+
+		/*
+		 * Don't reclaim or use emergency reserves for optional
+		 * higher-order allocations.
+		 */
+		if (order && !no_sg)
+			gfp = (gfp | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;
+
+		page = alloc_pages_node(node, gfp, order);
 	} while (!page && order--);
 
 	if (page && order) {
@@ -683,6 +692,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 		 pgoff_t pgoff, int nr_pages, long watermark, int flags)
 {
 	bool overwrite = !(flags & RING_BUFFER_WRITABLE);
+	bool no_sg = event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG;
 	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
 	int ret = -ENOMEM, max_order;
 
@@ -733,7 +743,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 		int last, order;
 
 		order = min(max_order, ilog2(nr_pages - rb->aux_nr_pages));
-		page = rb_alloc_aux_page(node, order);
+		page = rb_alloc_aux_page(node, order, no_sg);
 		if (!page)
 			goto out;
 
@@ -748,8 +758,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 	 * buffering. In this case, the entire buffer has to be one contiguous
 	 * chunk.
 	 */
-	if ((event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG) &&
-	    overwrite) {
+	if (no_sg && overwrite) {
 		struct page *page = virt_to_page(rb->aux_pages[0]);
 
 		if (page_private(page) != max_order)

---
base-commit: 25faec9ce61c01fb45abf812a222c5b43c3cd5c5
change-id: 20261109-perf_aux_alloc_optimize_psi-c2f8ce2e9a0c

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

