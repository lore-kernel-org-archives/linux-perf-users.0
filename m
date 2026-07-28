Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF303F4831;
	Tue, 28 Jul 2026 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272761; cv=none; b=t3YoK0zQBnLAV9Ug3VOs9p9pph4geohyd4o9ZrUvs3hdGglcmaAXw1WL6cBJnU8F7cSPddzTdZjlv6xUCiBsxUwmDmR6Jnt2W409pwqelc1PLtrecwNl3DHVxxRAy9xveyl7v+VxV0ZWs3RlFsalNfVE+lNscDo11Ed7pmrZIhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272761; c=relaxed/simple;
	bh=I9WTYfWN3ttcqDNU7b/0d3CGtaZ2nl9jKGIIYgdTYzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b75wCPwWFx2ZlWtNPyKoxFGPNcOC2hHHrI7bbQTTMkC4kBjL4byi5my6SzihEHUDigx05/bQUo+rQRGUJA5qd1EMdD4HRDO0UYsStP1aRcdVUQqyO6laz04Sl9WGWbsNBeAP0k5pRjjQAdVmGOvb5wYlVIj3rbSqVJLn7TDPNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775461F000E9;
	Tue, 28 Jul 2026 21:05:59 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	sashiko-bot@kernel.org
Subject: [PATCH 3/9] perf/cxl: Drop bogus counter overflow fixup
Date: Tue, 28 Jul 2026 14:05:45 -0700
Message-ID: <20260728210551.2449093-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728210551.2449093-1-dave.jiang@intel.com>
References: <20260728210551.2449093-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the overflow path __cxl_pmu_read() adds a full counter period to the
delta: `delta += (1UL << counter_width)` when `delta < mask`. The masked
unsigned subtraction already gives the correct delta across a wrap, so
this over-counts by ~one period on nearly every overflow (the guard holds
for all but one delta value), and the shift is undefined for counter
widths >= 32 (32-bit kernels) or == 64.

Drop the fixup to match every other perf driver. The overflow argument is
now unused, so fold __cxl_pmu_read() into cxl_pmu_read().

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/perf/cxl_pmu.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 3138514157cd..410c9162c824 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -686,7 +686,7 @@ static u64 cxl_pmu_read_counter(struct perf_event *event)
 	return readq(base + CXL_PMU_COUNTER_REG(event->hw.idx));
 }
 
-static void __cxl_pmu_read(struct perf_event *event, bool overflow)
+static void cxl_pmu_read(struct perf_event *event)
 {
 	struct cxl_pmu_info *info = pmu_to_cxl_pmu_info(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
@@ -698,21 +698,15 @@ static void __cxl_pmu_read(struct perf_event *event, bool overflow)
 	} while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
 
 	/*
-	 * If we know an overflow occur then take that into account.
-	 * Note counter is not reset as that would lose events
+	 * The counter is not reset on overflow, and the unsigned subtraction
+	 * masked to the counter width already yields the correct delta across a
+	 * single wrap, so no overflow fixup is needed.
 	 */
 	delta = (new_cnt - prev_cnt) & GENMASK_ULL(info->counter_width - 1, 0);
-	if (overflow && delta < GENMASK_ULL(info->counter_width - 1, 0))
-		delta += (1UL << info->counter_width);
 
 	local64_add(delta, &event->count);
 }
 
-static void cxl_pmu_read(struct perf_event *event)
-{
-	__cxl_pmu_read(event, false);
-}
-
 static void cxl_pmu_event_stop(struct perf_event *event, int flags)
 {
 	struct cxl_pmu_info *info = pmu_to_cxl_pmu_info(event->pmu);
@@ -793,7 +787,7 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
 			continue;
 		}
 
-		__cxl_pmu_read(event, true);
+		cxl_pmu_read(event);
 	}
 
 	writeq(overflowed, base + CXL_PMU_OVERFLOW_REG);
-- 
2.55.0

