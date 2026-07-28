Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B7411F83;
	Tue, 28 Jul 2026 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272767; cv=none; b=YZKbSRzMeTLB1xa7m5YhLRPQ3EMI0I9psaa2a7g3EOA7TsHJAZ+Nju/1+ARuHKSZnzM5fRjqEMICqjYWQbAnRJ9jlb9OQaxe09U7OGMRINNLI41kJMq5ob/aH5x4j8AaW+wfAWDi6ZUFyve7rsMtLI/a45y3TLAhBSLZW5bk6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272767; c=relaxed/simple;
	bh=t+UwxkWy20Z4zO60GwJ+fplg193lgU8CrtFIbVudrsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8+ubAkVjF50WCSO0SujXGPamkMYiYYoGQCVHL+CRWxcskFFeK7SDHJRKvSaAnTy42b/sZx1oWZVAcI5fVlkluGwBfi2ciOlUSFQq9P3cDpwVm2te0MAUrlXQ6yUNkjvnjobcuLXAVo+9ww3XvjeUB6+GQ1NjgjI4UDV3a0JyLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1F41F00A3A;
	Tue, 28 Jul 2026 21:06:03 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	sashiko-bot@kernel.org
Subject: [PATCH 6/9] perf/cxl: Unfreeze counters after handling an overflow interrupt
Date: Tue, 28 Jul 2026 14:05:48 -0700
Message-ID: <20260728210551.2449093-7-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728210551.2449093-1-dave.jiang@intel.com>
References: <20260728210551.2449093-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The counters are configured with Freeze on Overflow, so when any counter
overflows the CPMU freezes every counter in the block (CXL r4.0
§8.2.7.2.1). cxl_pmu_irq() reads the overflowed counters and clears the
overflow status, but never writes the CPMU Freeze register to unfreeze,
so all counters stay frozen until the next pmu_enable() and events in
that window are silently lost.

Unfreeze after clearing the overflow status so counting resumes.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/perf/cxl_pmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 0c53f9e5ccb1..e13811cf0c81 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -792,6 +792,15 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
 
 	writeq(overflowed, base + CXL_PMU_OVERFLOW_REG);
 
+	/*
+	 * Counters are configured to freeze on overflow (Freeze on Overflow),
+	 * which freezes every counter in the CPMU. Once the overflowed counters
+	 * have been read and their status cleared, unfreeze so counting resumes;
+	 * otherwise all counters stay frozen until the next pmu_enable() and
+	 * events are silently lost.
+	 */
+	writeq(0, base + CXL_PMU_FREEZE_REG);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.55.0

