Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE9B388377
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945319; cv=none; b=LLMAeW8kJYZOC3+7eMce7za96CEkeDRhpchNTE+3WC2S7q2B+bBVMASsiKIq24WspZUmC/MdCKQAV7K8G0gNl+RyWQWrDGmWLsitGHSFoArkc0dtxeIzrBWiEyS5+ZD/iAqYMUykO2UrVtt4rbi8v0RKubVe/bPBYkGyjtGuDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945319; c=relaxed/simple;
	bh=1OeV5SBXd30IjE9CIobfQJAaolE0DoV+XF7N5uJktrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYWycJS0pjIygahV0ZH5nnNzCtLKI3fTMSRMF0DUdh9QlmxqC8VraSMuakiBKf0D1UF0bnFRoaX3QgEnh10G8eT7A1Pys2GJ1xhtj0G8Ra9Qt4Q1EmMM2uFbMED5lbFqPtFJW9Ie5FZew8G0gmvLn+AMDHzDpDncb+WbVLLLBAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D6C1F000E9;
	Wed,  5 Aug 2026 15:55:18 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: inux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	icheng@nvidia.com,
	sashiko-bot@kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v4 10/11] perf/cxl: Don't log through pmu.dev in the overflow interrupt handler
Date: Wed,  5 Aug 2026 08:55:00 -0700
Message-ID: <20260805155501.1294472-11-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805155501.1294472-1-dave.jiang@intel.com>
References: <20260805155501.1294472-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_pmu_unregister() frees pmu->dev without clearing the pointer, and
cxl_pmu_probe() orders its devm actions so that teardown runs it before
free_irq(). Nothing in between masks the interrupt, and
cxl_pmu_event_stop() leaves the overflow status bit set, so an overflow
taken just before teardown is still delivered and still reaches the
dev_dbg() in the !event branch - by which point info->pmu.dev is freed.

Log through info->pmu.parent instead, which is devm-managed and outlives
every teardown action.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Split the probe-time overflow clear out, so this is back to the single
  hunk Jonathan acked in v2.
---
 drivers/perf/cxl_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 84ebc7da181d..45edef53a983 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -805,7 +805,7 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
 		struct perf_event *event = info->hw_events[i];
 
 		if (!event) {
-			dev_dbg(info->pmu.dev,
+			dev_dbg(info->pmu.parent,
 				"overflow but on non enabled counter %d\n", i);
 			continue;
 		}
-- 
2.54.0

