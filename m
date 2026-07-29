Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A620453A45;
	Wed, 29 Jul 2026 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336967; cv=none; b=Apcakeb4qnvjLecUf6W6XRn5tdppiSqLrKsxpWUgFD8ZmDddBKtWfcB+Q/FVXmZf3cbB/c3vxmAES8vXgSGcWxNI1v/8YrHHjkmKY8lgnm4eKIF9AtCwuBuXlTYwjqdbBcDRZHss0BXC3Uyahyd5ymOix/LIHJ2jfMaBw3QH3WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336967; c=relaxed/simple;
	bh=LRrrx3XG45fUgsPb/+BYXHpgSC6dFRACtHrpvobCBY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tw7I8biqT1+sVpFSNd9fPtPAcQyQtmg9cJ7ZFOw6vlQpMpFihg7GhYKl5axrBDN2p0X25oUUYANt6g7r9kNH00GjSnldhcVP/cmoJgrPNg6jZILYSAdRtdEVhWyAnSG4CwwV0jgZcqQ0OVO669PigxNabJ78DhdfEomWr8JkMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3D81F000E9;
	Wed, 29 Jul 2026 14:56:06 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	sashiko-bot@kernel.org
Subject: [PATCH v2 6/9] perf/cxl: Unfreeze counters after handling an overflow interrupt
Date: Wed, 29 Jul 2026 07:55:52 -0700
Message-ID: <20260729145555.3919550-7-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729145555.3919550-1-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
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
index 8b89db8f4d68..52e78a6e0960 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -804,6 +804,15 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
 
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

