Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54240480DFC;
	Wed,  5 Aug 2026 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945566; cv=none; b=Uxku7HkwaLtVVvOKd3ZL438l/1Sd0PfjyZHNQHJlAi6ivjlT+PnScTOiU0qLm9mAgRcJSZDpMZxR6fbVZDfC3JBkJo5/1gNblKuSqo5XmF2st8ms6Pn4q1i+JTU2+7GJhKjSMGf/TdlwAIg7jCbVW3mKpsQrJb0iIie6ntbthDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945566; c=relaxed/simple;
	bh=i/n7VmLc/62gufj9NHvm+On5nRRbkwqgI4427e9e3SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vy41CJK8vdMjnbeUbMmH9r6uYbpg4gVR5+nl6KZ+eXJ9DsuDzEQhdS3tZkeLsqgzlqMsy0VGgO1gLMyW3VBFrj0MFfIJPKDhGMTb0V3nlZyAHZ1c+L3gEox8bnY1HzWpp3yZr0eRSaVq0w311lss7anz8q0VMYGU3Gf1BrZH6OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4261F00A3D;
	Wed,  5 Aug 2026 15:59:17 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	icheng@nvidia.com,
	sashiko-bot@kernel.org
Subject: [RESEND PATCH v4 03/11] perf/cxl: Fix the counter overflow delta fixup
Date: Wed,  5 Aug 2026 08:59:03 -0700
Message-ID: <20260805155911.1304807-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805155911.1304807-1-dave.jiang@intel.com>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The counter is masked to counter_width, so the subtraction in
__cxl_pmu_read() throws away the bit that records the wrap. A delta of one
whole period reads back as 0, the same as no events at all, and only the
overflow status tells the two apart - which is why __cxl_pmu_read() takes
an overflow argument.

The fixup keys off the delta rather than the operands:

	delta = (new_cnt - prev_cnt) & GENMASK_ULL(counter_width - 1, 0);
	if (overflow && delta < GENMASK_ULL(counter_width - 1, 0))
		delta += (1UL << counter_width);

so it cannot tell which of these it is looking at:

  event_start         polled read          wrap
  ctr = 0 ..........  ctr = P/2 .........  mask -> 0 (+r)
  prev = 0            prev = P/2                 IRQ reads new = r

  prev = 0    (no read yet):  new >= prev, fell short -> add period
  prev = P/2  (polled):       new <  prev, spans wrap -> add nothing

Both rows are the same interrupt and the old guard adds a period in both,
so a mid-period read makes the event over-count. 'perf stat -I' hits that.

Condition the fixup on new_cnt >= prev_cnt, the one case the subtraction
cannot express. Dropping it outright would break the first row. It stays
exact whatever the residual r is, which matters because some events
increment by more than 1 per cycle (CXL r4.0 8.2.7.2.1, Threshold) and can
step past 0 as they wrap.

Use mask + 1 for the period rather than a shift. It is 0 for a 64-bit
counter, and avoids the old 1UL << counter_width - undefined for width 64,
and for >= 32 on 32-bit kernels.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/perf/cxl_pmu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index b16e2e4090a3..40741e529d9b 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -689,7 +689,7 @@ static void __cxl_pmu_read(struct perf_event *event, bool overflow)
 {
 	struct cxl_pmu_info *info = pmu_to_cxl_pmu_info(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	u64 new_cnt, prev_cnt, delta;
+	u64 new_cnt, prev_cnt, delta, mask;
 
 	do {
 		prev_cnt = local64_read(&hwc->prev_count);
@@ -697,12 +697,16 @@ static void __cxl_pmu_read(struct perf_event *event, bool overflow)
 	} while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
 
 	/*
-	 * If we know an overflow occur then take that into account.
-	 * Note counter is not reset as that would lose events
+	 * The mask discards the bit that says the counter wrapped, so a delta of
+	 * one whole period reads back as 0 - the same as no events at all. Only
+	 * the overflow status separates them, and new_cnt >= prev_cnt is that
+	 * case, so add the period back. mask + 1 is 2^counter_width, which comes
+	 * out as 0 for a 64-bit counter and avoids an undefined 1 << 64.
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
2.54.0

