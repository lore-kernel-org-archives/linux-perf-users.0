Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4352F48424B;
	Wed, 29 Jul 2026 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336963; cv=none; b=rLjzKtQrADYHxBJNsGP+i16jppd2vHfK1y90dHJQP2RsYLQ3m+KW/nLk4+Yl5oXUCEb9iXUX0UyY7zoJYh/Yi23+K/pQOy55kqHI31akz69uRAlmgK8eEfaCntp/xwccEA2mFVGqpj7KHQtZrCY4OYS2d+240vcNUpTDZT/DIFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336963; c=relaxed/simple;
	bh=6jR+F06ptSnlY+jzN9s8DQUJ2tVMCImezKBJj0WJBq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAsLjVCCc7R2JirKXYFEWlp1EBOwIarAa4A4oWwBcaC5zrS24puOhxIeEj8gC8rS7NPuRhk2viYsAz+mLwoZE1s6tgp//QkFQAfyuQZ2HWWFFzUIiBEzmzYbRY6FB/Z58InElJolXG4ohyWMOpABk5vXLvuWymyZPXMErkRjO0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45BB1F000E9;
	Wed, 29 Jul 2026 14:56:01 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	sashiko-bot@kernel.org
Subject: [PATCH v2 3/9] perf/cxl: Fix the counter overflow delta fixup
Date: Wed, 29 Jul 2026 07:55:49 -0700
Message-ID: <20260729145555.3919550-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729145555.3919550-1-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Counters are configured with Freeze on Overflow and are never reloaded: on
overflow the counter wraps to 0, counts on until the CPMU freezes, and
retains that residual (CXL r4.0 8.2.7.2.3). So the masked subtraction in
__cxl_pmu_read() only spans the wrap when new_cnt < prev_cnt.

The fixup keys off the delta rather than the operands:

	delta = (new_cnt - prev_cnt) & GENMASK_ULL(counter_width - 1, 0);
	if (overflow && delta < GENMASK_ULL(counter_width - 1, 0))
		delta += (1UL << counter_width);

and is wrong both ways. After a mid-period read the subtraction already
spans the wrap, but the guard holds for all but one delta value, so a
second period is added and the event over-counts. After an earlier
overflow read - or after event_start(), which leaves prev_count at 0 -
prev_cnt is a small residual, and once the new residual is greater or
equal only the difference between the two is counted and the period is
lost, which for a residual of 0 means every period after the first.
'perf stat -I' hits the former, plain 'perf stat' the latter.

The shift is also undefined for counter_width == 64, and for >= 32 on
32-bit kernels where 1UL is 32 bits.

Condition the fixup on new_cnt >= prev_cnt, the one case the masked
subtraction cannot express, and use mask + 1 for the period: it is 0 for a
64-bit counter, the correct sum mod 2^64, and needs no shift. A
userspace read landing between the wrap and the handler clearing the
overflow status stays correct because the counter is frozen and cannot
advance between the two reads.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Fix the fixup instead of deleting it. v1 dropped it on the rationale
  that the masked subtraction already handles the wrap, which only holds
  for new_cnt < prev_cnt; with freeze on overflow and no reload the
  overflow path routinely sees new_cnt >= prev_cnt, where v1 silently
  dropped a full period (sashiko-bot,
  https://lore.kernel.org/linux-cxl/20260728211411.47B2D1F000E9@smtp.kernel.org/).
- Keep the overflow argument and the __cxl_pmu_read()/cxl_pmu_read()
  split; v1 folded them together once the argument went unused.
- Use mask + 1 rather than 1ULL << counter_width so the 64-bit counter
  case needs no special casing.
---
 drivers/perf/cxl_pmu.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 3138514157cd..956da8202551 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -690,7 +690,7 @@ static void __cxl_pmu_read(struct perf_event *event, bool overflow)
 {
 	struct cxl_pmu_info *info = pmu_to_cxl_pmu_info(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	u64 new_cnt, prev_cnt, delta;
+	u64 new_cnt, prev_cnt, delta, mask;
 
 	do {
 		prev_cnt = local64_read(&hwc->prev_count);
@@ -698,12 +698,18 @@ static void __cxl_pmu_read(struct perf_event *event, bool overflow)
 	} while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
 
 	/*
-	 * If we know an overflow occur then take that into account.
-	 * Note counter is not reset as that would lose events
+	 * The counter wraps to 0 and is never reloaded, so the masked unsigned
+	 * subtraction only recovers a wrap when new_cnt < prev_cnt. On the
+	 * overflow path new_cnt >= prev_cnt means the full period elapsed
+	 * (prev_cnt is 0 from event_start(), or the residual left by an earlier
+	 * overflow), so add the period back. mask + 1 is 2^counter_width, which
+	 * evaluates to 0 for a 64-bit counter - the correct sum mod 2^64, and
+	 * avoids the undefined 1 << 64.
 	 */
-	delta = (new_cnt - prev_cnt) & GENMASK_ULL(info->counter_width - 1, 0);
-	if (overflow && delta < GENMASK_ULL(info->counter_width - 1, 0))
-		delta += (1UL << info->counter_width);
+	mask = GENMASK_ULL(info->counter_width - 1, 0);
+	delta = (new_cnt - prev_cnt) & mask;
+	if (overflow && new_cnt >= prev_cnt)
+		delta += mask + 1;
 
 	local64_add(delta, &event->count);
 }
-- 
2.55.0

