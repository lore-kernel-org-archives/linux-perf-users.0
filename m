Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9112F1EEA55;
	Fri, 18 Jul 2025 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832259; cv=none; b=h6nZ5BtJZkvYjpKjE1d7sVd2BMsRhgc6DHP9Obicdk+tALkOtIrwycWGcpGGMiriOaNFZy9lv3OlPLZnWTmP08FSB0+g63bYV6sjzWCAF6b0a9NWWFzUQeyftTYStlBKBjcvzmBaE6S8aE1jeVB9eG+/Xe0UGd9MKWR4l1U9iYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832259; c=relaxed/simple;
	bh=bRjULrrR2MulqelyzRAHCuH2OlQPbE9xi/O7ANbHA18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gds+HLlzvvHHApe9U7vaSqeMn6Fz9AL8/T11T9x3a2DPRvXxF6zw2tYzM+nHil9IRLTs61h7/t34vquWTUg8Lq3Fw5zxrKNM9yN4rPU8D0tI+13zRB6PXY3a/Ai8a3dEnXWYAwyfg/4QFcaUImx/T/uJHAnadx20JDiBjZgj8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bk4l66Bmxz6H6m1;
	Fri, 18 Jul 2025 17:49:38 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id BA691140142;
	Fri, 18 Jul 2025 17:50:55 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.203.177.99) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Jul 2025 11:50:54 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <coresight@lists.linaro.org>,
	<dianders@chromium.org>, <james.clark@linaro.org>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<robh@kernel.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <suzuki.poulose@arm.com>
Subject: [PATCH v3 4/6] coresight: cti: Use of_cpu_phandle_to_id for grabbing CPU id
Date: Fri, 18 Jul 2025 10:48:46 +0100
Message-ID: <20250718094848.587-5-alireza.sanaee@huawei.com>
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

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 .../hwtracing/coresight/coresight-cti-platform.c    | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
index d0ae10bf6128..2629962dbe3e 100644
--- a/drivers/hwtracing/coresight/coresight-cti-platform.c
+++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
@@ -41,18 +41,7 @@
  */
 static int of_cti_get_cpu_at_node(const struct device_node *node)
 {
-	int cpu;
-	struct device_node *dn;
-
-	if (node == NULL)
-		return -1;
-
-	dn = of_parse_phandle(node, "cpu", 0);
-	/* CTI affinity defaults to no cpu */
-	if (!dn)
-		return -1;
-	cpu = of_cpu_node_to_id(dn);
-	of_node_put(dn);
+	int cpu = of_cpu_phandle_to_id(node, NULL, 0);
 
 	/* No Affinity  if no cpu nodes are found */
 	return (cpu < 0) ? -1 : cpu;
-- 
2.43.0

