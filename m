Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D5B255F4A;
	Mon, 12 May 2025 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037368; cv=none; b=tbsY+ozt2r4zQd2kjGv1f6PEcfJA9YiDm9vzg41h0P4pLVzIXy4+WorniWAIZR2KN7J4qnCPKm8gscd9atJtN4rbAGDZYRrolPQWoM+jso/VS+lnYiEwGorQCUy3eQOIzOHPFnCV8rUPhSmXfn3DRfLUOxBWEdOQivRkUhNt6p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037368; c=relaxed/simple;
	bh=UrH3ED4Pu+Ili7BvuZS5cyi1gmb7vjgRoTa1ak0bRSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OL6P/LYNavcs5Bkx53ijCt6yYYqmMOJ2IGGuynCZKVYN7+H+hZFGFFssSUICpta+D1dem4Ufu9PJj5y/Kl3wI7lp4vWWnI3mlRjxRqW3SGTK9zgthQ6LwQ/+nNVv8nEfXmsi7pw5Ah2fS6+YrlAO7OeXJesR6AXiU3uT+A/DEqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZwsdH1LFwz6L540;
	Mon, 12 May 2025 16:06:43 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 91F021400DC;
	Mon, 12 May 2025 16:09:25 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.30.10) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 May 2025 10:09:24 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <devicetree@vger.kernel.org>
CC: <robh@kernel.org>, <alireza.sanaee@huawei.com>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<mark.rutland@arm.com>, <shameerali.kolothum.thodi@huawei.com>,
	<krzk@kernel.org>, <dianders@chromium.org>, <catalin.marinas@arm.com>,
	<suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@linaro.org>,
	<linux-perf-users@vger.kernel.org>, <coresight@lists.linaro.org>,
	<gshan@redhat.com>, <ruanjinjie@huawei.com>, <saravanak@google.com>
Subject: [PATCH v3 4/7] coresight: Use of_cpu_phandle_to_id for grabbing CPU id
Date: Mon, 12 May 2025 09:07:12 +0100
Message-ID: <20250512080715.82-5-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512080715.82-1-alireza.sanaee@huawei.com>
References: <20250512080715.82-1-alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500003.china.huawei.com (7.182.85.28)

Use the newly created API to grab CPU id.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 drivers/hwtracing/coresight/coresight-platform.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 8192ba3279f0..f032fdbe959b 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -167,19 +167,9 @@ of_coresight_get_output_ports_node(const struct device_node *node)
 
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
+	struct device_node *dn = NULL;
+	int cpu = of_cpu_phandle_to_id(dev->of_node, &dn, 0);
 	of_node_put(dn);
-
 	return cpu;
 }
 
-- 
2.34.1

