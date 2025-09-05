Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DF7309EFE;
	Fri,  5 Sep 2025 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089287; cv=none; b=Q5NAC85Uo9W2DXu6fvOWU2wsual1XST9OADrv+mPRwa7JoA0i7ujjkVJ2ULPfbr/cxLmkK/OROqe5vz1jHETnfdnJuHA1tk/VebXG0t4BPgwlJzoMDWClDVvl90m+R8T4WlNZbFDlh0x/f62P0Dpvmb4NfsjpBRFBPW0JyraiNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089287; c=relaxed/simple;
	bh=JyGpkO5xvJ2CDutAEOuCOmU05rAt1Mc+tZrzmBhfD8k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyMciW8LzXLb43DoN/0JQ8qZumT8GKPEIVEqOD3DgBs6IYp5toIfCvDcshWcOgBuKQxH6fUILdUkfGgTPFVpyJkEI9c3ZOutfXwx57cPCH66zT9+RCGguEHH94YxlOa4twN/4rlym3QsM2HW3lpVZo3MGoVQ6GiUnnEN6Jiig2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cJM3c3GJKz6M51s;
	Sat,  6 Sep 2025 00:18:52 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id DFA4F140114;
	Sat,  6 Sep 2025 00:21:23 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.202.66.105) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Sep 2025 18:21:21 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <coresight@lists.linaro.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <jonathan.cameron@huawei.com>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<robh@kernel.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<suzuki.poulose@arm.com>
Subject: [PATCH v4 5/6] coresight: Use of_cpu_phandle_to_id for grabbing CPU ID
Date: Fri, 5 Sep 2025 17:18:28 +0100
Message-ID: <20250905161830.37-6-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905161830.37-1-alireza.sanaee@huawei.com>
References: <20250905161830.37-1-alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500003.china.huawei.com (7.182.85.28)

Use the newly created API (of_cpu_phandle_to_id) to grab CPU ID.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
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

