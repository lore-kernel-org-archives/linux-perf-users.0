Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397B937BE6A
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333076; cv=none; b=eIUyRZ9Kbq+2rZj2sbi0A6Ir+Lhm63/oiuTgDMkmj71eY4+No6TvNuF6E8mo8c+V34Mlb3MjGkeF0Ql7fVososfOgAb++pDsxyYLPy3mos2IvWnIDdDdzgAJ3btWDdtLUpcf80NMM3lVfguMZxqsBgEt6C77J9ICnIgMIMt6oFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333076; c=relaxed/simple;
	bh=2QMz3330WJdBlyRHi1YMybseAbGfFS4tQIgdwj6xIHY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z3UQ/AWELfvMzmpNFY+FYpPYKpJXoW5V7y2qVbDQLZDSj8YmyIZ9GPECZnNji5cVXO2OAWRbzhmOs+JMBMEoRNl/Nbhc6ukIdFdFTHf+OJMOwxKf3ZDG33WMGDeigr72AGrU6cKw7iv0z1cfRWnDUcRr5jGcxrx5CjfkIh646w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fxCv22jMRzHnH6K;
	Thu, 16 Apr 2026 17:50:54 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A09D4058D;
	Thu, 16 Apr 2026 17:51:12 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.123.51.176) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 10:51:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yushan Wang <wangyushan12@huawei.com>, Jie Zhan <zhanjie9@hisilicon.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>
CC: <linuxarm@huawei.com>, <jic23@kernel.org>
Subject: [PATCH] MAINTAINERS: Update HiSilicon PMU driver maintainer to Yushan Wang
Date: Thu, 16 Apr 2026 10:51:10 +0100
Message-ID: <20260416095110.25612-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

Replace myself with Yushan Wang who is very familiar with the HiSilicon PMU
drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e12fe1f..8b95a43527fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11563,7 +11563,7 @@ F:	Documentation/devicetree/bindings/net/hisilicon*.txt
 F:	drivers/net/ethernet/hisilicon/
 
 HISILICON PMU DRIVER
-M:	Jonathan Cameron <jonathan.cameron@huawei.com>
+M:	Yushan Wang <wangyushan12@huawei.com>
 S:	Supported
 W:	http://www.hisilicon.com
 F:	Documentation/admin-guide/perf/hisi-pcie-pmu.rst
-- 
2.51.0

