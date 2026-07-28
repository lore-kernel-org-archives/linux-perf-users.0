Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2663B961A;
	Tue, 28 Jul 2026 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272769; cv=none; b=Yk44gPOAv6Bg8aEWsgw1iQIOVVa2qbmH9LcBogazCRxYCfNSUMVhZQwJ7bmoRCmyQW3Tc78Gt+pInBF03Ath5wAe7HA4d6hBmvDWECQwMBKGpMD30szHlSC501CRwc9qeVGnghMFIhdjzfnz5W74xZd9XXGFRtw3BsRchV2Y5lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272769; c=relaxed/simple;
	bh=DGF4RL34O3CKN5JUY7sqxYuiHzF6VYDzWPrjJKv82Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+sa9x65tZEOWiVxOfzhtqg19JtiIJf/2etxHVueCyr3x9Z7c35e4ZTm8TT9mhUGQpp0ycqGxIkiyj8LpWBvzvdMbf88p0JD6b8C+BwPcIoqqqYYD5xmJILERFCu3gWdzvs81PbJSH/KFUFRHV+rS/0qVWrDigX+riXMoUp48+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14071F00A3A;
	Tue, 28 Jul 2026 21:06:07 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	sashiko-bot@kernel.org
Subject: [PATCH 9/9] perf/cxl: Avoid cpumask_of(-1) when no CPU is assigned
Date: Tue, 28 Jul 2026 14:05:51 -0700
Message-ID: <20260728210551.2449093-10-dave.jiang@intel.com>
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

cpumask_show() feeds info->on_cpu straight into cpumask_of() for the
world-readable cpumask sysfs attribute. on_cpu is -1 before the first
hotplug online callback and transiently in cxl_pmu_offline_cpu() before a
new target is chosen. cpumask_of(-1) treats the CPU number as unsigned and
does out-of-bounds pointer arithmetic in get_cpu_mask(), so a concurrent
read of the attribute dereferences a wild pointer and can fault -- a local
denial of service.

Read on_cpu once and emit an empty mask when it is negative.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/perf/cxl_pmu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index f1110c5029d6..80145e85fe36 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -501,8 +501,17 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct cxl_pmu_info *info = dev_get_drvdata(dev);
+	int cpu = READ_ONCE(info->on_cpu);
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(info->on_cpu));
+	/*
+	 * on_cpu is -1 before the first online callback and transiently during
+	 * cxl_pmu_offline_cpu(). cpumask_of(-1) computes an out-of-bounds
+	 * pointer, so report an empty mask instead.
+	 */
+	if (cpu < 0)
+		return sysfs_emit(buf, "\n");
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(cpu));
 }
 static DEVICE_ATTR_RO(cpumask);
 
-- 
2.55.0

