Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B987482;
	Thu, 22 May 2025 03:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747884113; cv=none; b=dMaBEpMiXLgUjXfQje284s/8IMUSCiK+ACsIUlwNMIomXn83XnB8bpOy851Djn5ZizWKKncmMSgqBVnniBaRz3l4XCnUElb1G3ksAb4kI6oAPncrcPpr2P4igwhngXSAkR3X7b4fkWfFkP3aAN8CwKyx031Io2+AgS95TN/etag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747884113; c=relaxed/simple;
	bh=G0K09VQ/s+NhLRZWJLBMCGFDaIDKTifiXWCbHH03GHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TgMI3jtL8anssttebj8ietclXhosrx6PAN7v9ElJX3WoZ7ba8/IFyDC2HfrqCudEk6lW7NWkCOPAZsDzTnt9BdtpQbpg4nqTgSvbBv9rr4oAKvs+XtpbsgYIJI5i8iT711q574NDSzVlYgY8QTbVmdlnZaqXO9nBwFuXXC3pYfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXn3s8mC5oaCJuCg--.8523S2;
	Thu, 22 May 2025 11:21:32 +0800 (CST)
Received: from localhost.localdomain (unknown [219.142.137.151])
	by mail (Coremail) with SMTP id AQAAfwA3zCU4mC5oAmE4AA--.310S2;
	Thu, 22 May 2025 11:21:31 +0800 (CST)
From: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To: robin.murphy@arm.com,
	will@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] perf/arm-cmn: Broaden module description for wider interconnect support
Date: Thu, 22 May 2025 11:21:22 +0800
Message-ID: <20250522032122.949373-1-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwA3zCU4mC5oAmE4AA--.310S2
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=daizhiyuan
	@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7Gw1DGryxuF1rZFWDtFyrWFg_yoWkGrg_ur
	yxWr1xJ3WkJr9Yyw1akw4rZ34S9F48ZryxXF1a9wnxZ3ZrJw1fWr4kZa4Sqw18Jw1xJFs0
	yFsxuFySyrWUKjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=

The current MODULE_DESCRIPTION only mentions CMN-600, but this driver
now supports several Arm mesh interconnects including CMN-650, CMN-700,
CI-700, and CMN-S3.

Update the MODULE_DESCRIPTION to reflect the expanded scope.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 drivers/perf/arm-cmn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index d4fe30ff225b..479bc35dccab 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2016-2020 Arm Limited
-// CMN-600 Coherent Mesh Network PMU driver
+// ARM CMN/CI interconnect PMU driver
 
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
@@ -2699,5 +2699,5 @@ module_init(arm_cmn_init);
 module_exit(arm_cmn_exit);
 
 MODULE_AUTHOR("Robin Murphy <robin.murphy@arm.com>");
-MODULE_DESCRIPTION("Arm CMN-600 PMU driver");
+MODULE_DESCRIPTION("Arm CMN/CI interconnect PMU driver");
 MODULE_LICENSE("GPL v2");
-- 
2.43.0

