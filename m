Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A7175BF;
	Tue, 18 Feb 2025 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739841686; cv=none; b=lDyzX0pHvBeyRCT9nFrC3zGGAeCISxi3wMUGMsWmgy9rdBC1JkzSRuFL1Ul1y9gVK7zwan1rUB2mhwx8uxK1CTcBJIt9zJ4EV3Ffjmt48ZJj/5ZGKVT6tBmGA1ZGL2q0HcdFeqU6D7tY7u36CszJu01q+y+vbFcYoIh1mGIXmpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739841686; c=relaxed/simple;
	bh=42wuwLzT7FUmwwcFugm5CFe50Sm4EzCJF++OL//MtqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WFfseqqw5a39+aNhkVLRfuA3HfJ8EAz8R8mmfZ14NRlu9FERqdP/aNVbNI5OtGMV4HOqgzsgTJy+uogg5vy6iLBqDfiv1NUGcYsKHQNxHQU7SiHO0heYvFC11C2SOAuwuqSz5ELya4483f/abMxiyGPr9jujsXBWaeyfZEEgD2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cvWQP1rD; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cvWQP1rD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739841675; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=FuF6m3leXUa/vGlA8F/tyoZFS3UM+jds6W3yZp2fFyA=;
	b=cvWQP1rD57v6zw9WVFpGbqTJXUFFUOc2yqbv+TmP9CdV0c7LcTY7VcRqQvb1Uzj4JJgIiLrptBGkV6nbWSwvA2PvSKjfydz5QBQo10KrZvSn0VGtdfKIoaovY3PFEzfqQQfH0G6MAkCsuPcvqXIOMGp7TQQ5ZiWXV2CedyvOexY=
Received: from localhost.localdomain(mailfrom:fengwei_yin@linux.alibaba.com fp:SMTPD_---0WPjc6Hf_1739841673 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Feb 2025 09:21:14 +0800
From: Yin Fengwei <fengwei_yin@linux.alibaba.com>
To: robin.murphy@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jie.li.linux@linux.alibaba.com,
	Yin Fengwei <fengwei_yin@linux.alibaba.com>
Subject: [PATCH] perf/arm-cmn: don't claim resource during ioremap() for CMN700 with ACPI
Date: Tue, 18 Feb 2025 09:21:11 +0800
Message-Id: <20250218012111.30068-1-fengwei_yin@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, arm-cmn PMU driver assumes ACPI claim resource
for CMN600 + ACPI. But with CMN700 + ACPI, the device probe
failed because of resource claim failes when ioremap() is
called:
[   10.837300] arm-cmn ARMHC700:00: error -EBUSY: can't request region for resource [mem 0x40000000-0x4fffffff]
[   10.847310] arm-cmn ARMHC700:00: probe with driver arm-cmn failed with error -16
[   10.854726] arm-cmn ARMHC700:02: error -EBUSY: can't request region for resource [mem 0x40040000000-0x4004fffffff]
[   10.865085] arm-cmn ARMHC700:02: probe with driver arm-cmn failed with error -16

Let CMN700 + ACPI do same as CMN600 + ACPI to allow CMN700
work in ACPI env.

Signed-off-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>
---
I am also wondering whether we could just drop the CMN600 part id
check here if ACPI companion device claimed the resource?

 drivers/perf/arm-cmn.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index ef959e66db7c..8b5322a2aa6e 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2559,7 +2559,8 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	cmn->part = (unsigned long)device_get_match_data(cmn->dev);
 	platform_set_drvdata(pdev, cmn);
 
-	if (cmn->part == PART_CMN600 && has_acpi_companion(cmn->dev)) {
+	if (((cmn->part == PART_CMN600) || (cmn->part == PART_CMN700)) &&
+			has_acpi_companion(cmn->dev)) {
 		rootnode = arm_cmn600_acpi_probe(pdev, cmn);
 	} else {
 		rootnode = 0;
@@ -2649,7 +2650,7 @@ MODULE_DEVICE_TABLE(of, arm_cmn_of_match);
 static const struct acpi_device_id arm_cmn_acpi_match[] = {
 	{ "ARMHC600", PART_CMN600 },
 	{ "ARMHC650" },
-	{ "ARMHC700" },
+	{ "ARMHC700", PART_CMN700 },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, arm_cmn_acpi_match);
-- 
2.43.5

