Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219730;
	b=u0o8oiYfSz/UJLs47wAJb+Xs50zMv+iiNBvup0mkcFZihaQMJM6x3qA8sEAPywVoGJBO
	 B3511QhkaWYJCyTJncIj1tKP4Mb2+a2KlLMk9QcOiAS+lwLDCJo8S/Le9jiYii0LoAhvF
	 0SeNWH7ffwP4tostl5GzUUbB5J3Pc5LnIKnYCIp98usiAmOD6ElP+jioTYgdWc4EDKgXr
	 vvn1/0K44XyooWRm/S6WYx9LYX1h8oVmFTmI6MdNiMTvxnkRIwlwiU8JK1XIiKpMipO0f
	 ruHRk/wqGyWEKtUkBAjgSSsPOzKm3Zi02GjFR+PaB+7168EHnSmkBHuxj0Z2EIWB/0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219730;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=iPcV1/YFudmIF9K6nkbj2ycq/qpJcOLHweLRDaGFQyM=;
	b=1fhePFaUPMniNVm49mQBs3C2PxbAH8LMizbk/MiL6tjdl1H41HA57CDiebXhsFMUy/3r
	 lvvQlesxV2Qbti19cTnTptbV6LELJqhdvmgyluUf6foG7/L1ZrIYZZ2BEY7GHUalQIcWE
	 4WakuoKeXj8DfSUnnxvf1K70E1uoP5rxvB6R6KbqnUAE3c3glJHbkf0NKupp+hpdZpJv4
	 whnPcTTLlQWH4nRGkkFbl8VxBOzAPZBvq6I57mHpm/osmMgstmkZFt8nz+sG7sH5rYInY
	 1EivZRdLifQn7iOevs6LJLCsJXecySzaYcnkeCXl7DBki58rxRIsR7SfUPMpjxMDohA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rchZXeYP;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA50606A322;
	Mon,  9 Nov 2026 10:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAA50606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rchZXeYP
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C52521576;
	Mon,  9 Nov 2026 02:22:05 -0800 (PST)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23C9E3F632;
	Mon,  9 Nov 2026 02:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794219728; bh=OqKqpxSrpUS49kONNs9z4tUJA+53UdQ+dJdC8b5DWo8=;
	h=From:Date:Subject:To:Cc:From;
	b=rchZXeYPtrUeGb4SPtrAAuq5UrhX+P/kThWjDFVmDPhRblbvotqMOJoGW7ol7/Ocf
	 7OX6vF020lOSc7/7Is2JFVzam0fU2PfLnmie5l+SBssKKTbJKmPZlgzX6nfxmktNmI
	 y60CESSgcyv1zjzsnt0m03R8nIjYtAGvgwzf+MTA=
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 09 Nov 2026 10:21:39 +0000
Subject: [PATCH] perf/aux: Avoid reclaim for optional higher-order
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
Message-Id: <20261109-perf_aux_alloc_optimize_psi-v1-1-d56ac4bf3ef5@arm.com>
X-B4-Tracking: v=1; b=H4sIALKe8WoC/x3MQQqDMBAF0KvIrA0kWRT1KkVCmP7ogDUh0SIV7
 25w+TbvpIIsKDQ0J2X8pEhcK0zbEM9+naDkU01W25cxulcJOTi/H84vS2QX0yZf+cOlIopt6Bg
 WvddMdUgZQY5nf4/XdQPZccYzbQAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794219725; l=6169;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=OqKqpxSrpUS49kONNs9z4tUJA+53UdQ+dJdC8b5DWo8=;
 b=zQvGw5O+6p1Ag7n0sBNF5VSoiVuML3ZYzl6JyHypzO152xYE2N7186f88DX1cpJ7LSMDm0ew9
 ckSeeSZI747BXo1zLXq2A0s1xfBp66RcLOhfxoAlKoKSu4vtHrzdM/C
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

PERF_AUX_GFP includes __GFP_NORETRY, but still permits reclaim and
compaction. Repeated higher-order allocation attempts on fragmented
systems can therefore cause substantial stalls. Yabin reported that
these stalls raise memory PSI and trigger Android's lmkd to kill
applications.

For PMUs supporting scatter-gather buffers, higher-order allocations
are optional: allocation can fall back to smaller orders. Clear
__GFP_RECLAIM for these attempts, and add __GFP_NOMEMALLOC to prevent
them from using emergency reserves through inherited allocation
privileges. Available higher-order pages can still be used.

Use __GFP_RETRY_MAYFAIL instead of __GFP_NORETRY so order-0 and NO_SG
allocations can retry reclaim and compaction without directly invoking
the OOM killer. This improves allocation success at the cost of
potentially longer stalls.

Testing used an arm64 Orion6 board (12 CPUs) and Dev Jain's
compact-bench pressure workload [1], with 64 KiB mTHP in madvise mode,
four worker threads and a 120-second hold time:

  Requested demand   compact-bench arguments
   90%               89 64 4  1 120
   95%               94 64 4  1 120
  100%               99 64 4  1 120

Once the workload is holding its mappings, run the AUX allocation test
in a separate cgroup so its PSI excludes the pressure workload's stalls.
The measure_memory_psi.py script reads cgroup memory.pressure totals
and /proc/vmstat before and after each perf record command, and reports
their deltas. --delay=-1 allocates AUX buffers while keeping tracing
disabled; /dev/null avoids trace files and their page-cache footprint.

  #!/bin/bash
  set -euo pipefail

  mkdir /sys/fs/cgroup/aux-psi

  results_dir=$(mktemp -d /tmp/psi-perf-cgroup.XXXXXX)

  for i in {1..10}; do
      echo "Iteration $i/10"

      python3 ./measure_memory_psi.py \
          --psi-file /sys/fs/cgroup/aux-psi/memory.pressure \
          --out "$results_dir/run-$i" -- \
          sh -c '
              echo "$$" > /sys/fs/cgroup/aux-psi/cgroup.procs || exit 1
              # Allocate AUX buffers while keeping tracing disabled.
              exec perf record -vv -a -e cs_etm// -m 256,4M \
                  --delay=-1 --no-buildid --no-buildid-cache \
                  -o /dev/null -- sleep 1
          '
  done

  echo "Results: $results_dir"

The following values are totals over ten runs per pressure case, shown
as before -> after. PSI some measures time when at least one task in
perf's cgroup is stalled on memory; the VM counters are system-wide
counts.

  Demand      PSI some (ms)  allocstall_*  compact_stall     pgscan_direct
     90%     0.000 -> 0.000        0 -> 0         0 -> 0            0 -> 0
     95%    64.099 -> 0.430       70 -> 2        72 -> 0     51,179 -> 600
    100%   98.343 -> 10.298      99 -> 10       147 -> 0   51,954 -> 1,308
   Total  162.442 -> 10.728     169 -> 12       219 -> 0  103,133 -> 1,908

Total PSI some falls by 93.4%. Allocation stalls fall from 169 to 12,
and recorded direct compaction stalls fall from 219 to zero. All 30
after runs exit successfully, including all ten at 100% requested
demand. The median PSI some delta is zero in every after case, with
25 of 30 runs reporting zero PSI some, compared with 11 of 30 before.

[1] https://lore.kernel.org/all/d2b8edf0-39ab-4a44-bd0d-58230dee2fad@arm.com/

Reported-by: Yabin Cui <yabinc@google.com>
Link: https://lore.kernel.org/lkml/CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak6LyV_We7yBQ@mail.gmail.com/
Suggested-by: Yabin Cui <yabinc@google.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 kernel/events/ring_buffer.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 95f4fbdfd2764de5b72d901d778c46302f525fad..37bda4398724a2516f121c53daf61cd3f706922a 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -617,9 +617,9 @@ long perf_output_copy_aux(struct perf_output_handle *aux_handle,
 	return len;
 }
 
-#define PERF_AUX_GFP	(GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY)
+#define PERF_AUX_GFP	(GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_RETRY_MAYFAIL)
 
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
base-commit: 2651f6deb3326129a052897df193052dc28ea94f
change-id: 20261109-perf_aux_alloc_optimize_psi-c2f8ce2e9a0c

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

