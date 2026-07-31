Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946303C3F50;
	Fri, 31 Jul 2026 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540514; cv=none; b=f45YFMdlFgbCiMI6S5JlMALhrTKJDlHo2N/BeK7FdYTh1inaDagPEFgx0WXBXjSF821P7zobZAAw7CYzh+S0hRZai/5W1L6XqKB2nm2DWt5Krt/G8C4oioa60UycFNGPiWlHJmrcmQMIkwhyt4d9MPavre6EQQnciWOOyNJqRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540514; c=relaxed/simple;
	bh=1yv3zRTUYulXBGErGgwtHXttw5KhX/DGGZ4PMlKjCZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MShpf/mR2SixTnBrWJega9kWajiNjhv6m+hkPgRkJb2RXOdgaOxv5e9LaN8vbFYIaG4mNGsQ0GbdMD1K8/S3j1drKbIi7HRoZcTSv1KjO1SrAoEzC74xXstyoQvqj/5dAEkYnPvB6hwfMO5o/i2cR7myu5OwEkCAgwKoc1PkLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FE31F00ACA;
	Fri, 31 Jul 2026 23:28:33 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	sashiko-bot@kernel.org
Subject: [PATCH v3 3/9] perf/cxl: Fix the counter overflow delta fixup
Date: Fri, 31 Jul 2026 16:28:21 -0700
Message-ID: <20260731232827.401447-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731232827.401447-1-dave.jiang@intel.com>
References: <20260731232827.401447-1-dave.jiang@intel.com>
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
overflow status tells the two apart. That is why __cxl_pmu_read() takes an
overflow argument.

The fixup keys off the delta rather than the operands:

	delta = (new_cnt - prev_cnt) & GENMASK_ULL(counter_width - 1, 0);
	if (overflow && delta < GENMASK_ULL(counter_width - 1, 0))
		delta += (1UL << counter_width);

so it cannot tell whether the subtraction needed the period. What decides
that is where prev_count sits when the counter wraps:

  event_start         polled read          wrap
  ctr = 0 ..........  ctr = P/2 .........  mask -> 0 (+r)
  prev = 0            prev = P/2                 IRQ reads new = r

  prev = 0    (no read yet):  new >= prev, fell short -> add period
  prev = P/2  (polled):       new <  prev, spans wrap -> add nothing

Both rows are the same overflow interrupt and the old guard adds a period
in both, so a mid-period read makes the event over-count. 'perf stat -I'
hits that.

Condition the fixup on new_cnt >= prev_cnt instead, the one case the
subtraction cannot express. Dropping it outright would break the first row.
The residual r need not be 0 either, since some events increment by more
than 1 per cycle (CXL r4.0 8.2.7.2.1, Threshold), and keying off the
operands stays exact whatever r is.

Use mask + 1 for the period rather than a shift. It is 0 for a 64-bit
counter, and avoids the old 1UL << counter_width, undefined for width 64
and for >= 32 on 32-bit kernels.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Rewrite the rationale. v2 blamed the counter counting on past the wrap,
  which the spec permits but which was not what made the old code wrong
  (Jonathan).
- Note that events incrementing by more than 1 per cycle make a non-zero
  residual reachable, so the fixup has to hold for any residual (Jonathan).
- Drop the claim that the old code loses a period on the first overflow
  after event_start(). It does not. The subtraction yields 0 there and the
  old guard then adds the period back correctly. The reachable bug is the
  over-count in the other direction.
- No code change.
---
 drivers/perf/cxl_pmu.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index b16e2e4090a3..3511d049aea4 100644
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
@@ -697,12 +697,17 @@ static void __cxl_pmu_read(struct perf_event *event, bool overflow)
 	} while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
 
 	/*
-	 * If we know an overflow occur then take that into account.
-	 * Note counter is not reset as that would lose events
+	 * The mask discards exactly the bit that says the counter wrapped, so a
+	 * delta of one whole period reads back as 0, the same as no events at
+	 * all. Only the overflow status distinguishes them, and new_cnt >=
+	 * prev_cnt is that case, so add the period back. mask + 1 is
+	 * 2^counter_width, which is 0 for a 64-bit counter - the right value to
+	 * add once the top bit is gone, and no undefined 1 << 64.
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

