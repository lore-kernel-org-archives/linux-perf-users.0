Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAF43A9638;
	Tue, 28 Jul 2026 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272767; cv=none; b=SCQAM09QX4SwLNT8sAkmCSZFz5RJzfu3u6nTXt2ha1Dj/GTQcolh/oyAcWnqC+zxuIqTXycWg6g4e8RMnR1yJwcoZifwpw+VHnYyYzWMFIJmUKpVw+RStKkxDUo0deBgjYGLMXJ9vN1lmRpZUGx84IGEQfrdUjK+3NNHCx5EqFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272767; c=relaxed/simple;
	bh=f2ML5gSW1CWCJxLdPH4bN7PSoOYahiJLC9hasJq3vC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiFYrcuHbDJR/Y/OmTIGrYyftH5PMPlsqeqTr2uPwCWHiIqE/ZA7Gz9tIdHZK04SrPwe+wzE5J97SxkPq0yQOb9/xlMl7637maGPc4BfLNpJcSCu8NvDwgyzW776irgspk9859DrEoNhjjGtNePgOQDoVZixoQHyeMJ3iUqgj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A15B1F00A3D;
	Tue, 28 Jul 2026 21:06:06 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	sashiko-bot@kernel.org
Subject: [PATCH 8/9] perf/cxl: Don't use pmu.dev in IRQ and hotplug callbacks after unregister
Date: Tue, 28 Jul 2026 14:05:50 -0700
Message-ID: <20260728210551.2449093-9-dave.jiang@intel.com>
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

On device removal the devm actions unwind LIFO, so cxl_pmu_perf_unregister()
runs first and perf_pmu_unregister() frees info->pmu.dev (device_del() +
put_device() -> kfree()). The overflow IRQ (freed last) and the CPU-hotplug
instance (removed next) are still live at that point, and both
cxl_pmu_irq() and cxl_pmu_offline_cpu() log via dev_dbg()/dev_err() on
info->pmu.dev, dereferencing freed memory. The shared IRQ can be entered
for a co-function on the same MSI vector, and a CPU can go offline in the
window before the hotplug instance is removed.

Log through info->pmu.parent instead, the cxl_pmu device passed to probe,
which is devm-managed and outlives every teardown action.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/perf/cxl_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index d1fa97f77e25..f1110c5029d6 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -791,7 +791,7 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
 		struct perf_event *event = info->hw_events[i];
 
 		if (!event) {
-			dev_dbg(info->pmu.dev,
+			dev_dbg(info->pmu.parent,
 				"overflow but on non enabled counter %d\n", i);
 			continue;
 		}
@@ -954,7 +954,7 @@ static int cxl_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	info->on_cpu = -1;
 	target = cpumask_any_but(cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids) {
-		dev_err(info->pmu.dev, "Unable to find a suitable CPU\n");
+		dev_err(info->pmu.parent, "Unable to find a suitable CPU\n");
 		return 0;
 	}
 
-- 
2.55.0

