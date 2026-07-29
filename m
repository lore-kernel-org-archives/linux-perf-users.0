Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4E14968FA;
	Wed, 29 Jul 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336970; cv=none; b=SkmR681crqf3IgMin0xr1JZPHfIeWvqz3CzzsuzXhuxTW0++UjI2cduFwlcBTOp4IemgGgNGHyg++JxVpVih/Zn3aAbZaoZ1GYLRj+sdDVP/MHDSBN6xwXmqH4e8uduFLBNiml4tEYxQjJV1HjnZWgqiktO40GgUDNMb1yEI83I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336970; c=relaxed/simple;
	bh=90W4mubrGLPUrU0fzf0gWDn/muhXdeozbxjssJTaQ2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbdY8Fodl7IjxpawExK8tMSdWDtp9P1ZEJ2fXp8o2pdU0+NjzQ1AQ7j/pwb6FWsfYF0yw2FFesQgeCe6jdp2/QMrS1gcNx4kiJ3UWS1//McQCrAN0DUQM2ITw/KBiZrW50PZo9CM8YOYu925ND6+/YPbwX4qFI80Qd41qoiAjSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBEC1F000E9;
	Wed, 29 Jul 2026 14:56:09 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	sashiko-bot@kernel.org
Subject: [PATCH v2 8/9] perf/cxl: Don't use pmu.dev in IRQ and hotplug callbacks after unregister
Date: Wed, 29 Jul 2026 07:55:54 -0700
Message-ID: <20260729145555.3919550-9-dave.jiang@intel.com>
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
index 2e817a52ff1e..f42238b2b6b0 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -803,7 +803,7 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
 		struct perf_event *event = info->hw_events[i];
 
 		if (!event) {
-			dev_dbg(info->pmu.dev,
+			dev_dbg(info->pmu.parent,
 				"overflow but on non enabled counter %d\n", i);
 			continue;
 		}
@@ -966,7 +966,7 @@ static int cxl_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	info->on_cpu = -1;
 	target = cpumask_any_but(cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids) {
-		dev_err(info->pmu.dev, "Unable to find a suitable CPU\n");
+		dev_err(info->pmu.parent, "Unable to find a suitable CPU\n");
 		return 0;
 	}
 
-- 
2.55.0

