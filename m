Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7030329B79B;
	Fri, 18 Jul 2025 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832290; cv=none; b=hB6SDSbDX888Th3R5e73wN5kKbhtZpqWqFGerX+i1GQ0SpSbVLo1zkbT+IHfRJL0b9PWWy/FiJ4DUNW5lEeB9spBaBuC1BAhJDaBNp3xwt0DJovZsqOqe+dYAaMyKFqKCgqXBr7Jl0oTd7QuexzgAsQN5HnLMJbk1A8fsSgZdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832290; c=relaxed/simple;
	bh=M8WxPaYVpKdNsLyNhAWiyuc6YVSz5XqimHXWTgdW/R8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTHOR7ehrzMrkAPOJ1tnoJeunoraDbgSk7EHg9HrSjxHC4YD94OBJpS97qMst88czf+zSTOPUvOFRsoIiiJUFWQZ12ZJL8NZizXnukiVMKKkIB4cuZmnQdu8qi+oCgac/KZmgAl6h4gQdtLix74dUgk0QuuNYAf0wrC+74H4wJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bk4j11BLCz6L53B;
	Fri, 18 Jul 2025 17:47:49 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 2615A1402F6;
	Fri, 18 Jul 2025 17:51:27 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.203.177.99) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Jul 2025 11:51:26 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <coresight@lists.linaro.org>,
	<dianders@chromium.org>, <james.clark@linaro.org>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<robh@kernel.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <suzuki.poulose@arm.com>
Subject: [PATCH v3 5/6] coresight: Use of_cpu_phandle_to_id for grabbing CPU ID
Date: Fri, 18 Jul 2025 10:48:47 +0100
Message-ID: <20250718094848.587-6-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718094848.587-1-alireza.sanaee@huawei.com>
References: <20250718094848.587-1-alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500003.china.huawei.com (7.182.85.28)

Use the newly created API (of_cpu_phandle_to_id) to grab CPU ID.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 drivers/hwtracing/coresight/coresight-platform.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 0db64c5f4995..95d46ea08936 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -167,20 +167,7 @@ of_coresight_get_output_ports_node(const struct device_node *node)
 
 static int of_coresight_get_cpu(struct device *dev)
 {
-	int cpu;
-	struct device_node *dn;
-
-	if (!dev->of_node)
-		return -ENODEV;
-
-	dn = of_parse_phandle(dev->of_node, "cpu", 0);
-	if (!dn)
-		return -ENODEV;
-
-	cpu = of_cpu_node_to_id(dn);
-	of_node_put(dn);
-
-	return cpu;
+	return of_cpu_phandle_to_id(dev->of_node, NULL, 0);
 }
 
 /*
-- 
2.43.0

