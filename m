Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871712BE028;
	Mon,  7 Jul 2025 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900758; cv=none; b=fwNf2SWvtoeEKwo2z5MSCyROJZObOmnl8dBSWZCZAoT5NwKD44gYIj5nOWpIX1p4A/Sr7V1bIfylGk2OSY9dG+M5sJud4dKY+X5gUguWd+ZT+BEAC6zsDU1H21P0tcVfzzWjedYPY51lc1mvDZ6rWJwFlKgBneXeopdS99zaN1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900758; c=relaxed/simple;
	bh=iDwkRX2eP1hRCtLn7y1aGD0KGq4pnNUc5ZgEOOJmnAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h202iaBuk3gfvpet08KNJmD8J9AeF2txfbSULe5A/lkvObGtLftlfwS7IaHFqztluVkHNjKGf55abwQVfmriFUxBLgWaBaYZbZmoZ1872qJ1+XuDccrbQSKz/YRBKIJ5jlGI6j78rMyonoTRjlKsMIGyHnG9Hgc78HMtExAXsfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bbSCW3kptz6L5PT;
	Mon,  7 Jul 2025 23:02:47 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 815AB1402EB;
	Mon,  7 Jul 2025 23:05:54 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.45.147.207) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Jul 2025 17:05:53 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <mark.rutland@arm.com>, <robh@kernel.org>
CC: <coresight@lists.linaro.org>, <devicetree@vger.kernel.org>,
	<dianders@chromium.org>, <james.clark@linaro.org>,
	<jonathan.cameron@huawei.com>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linuxarm@huawei.com>,
	<mike.leach@linaro.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <suzuki.poulose@arm.com>
Subject: [PATCH 3/5] coresight: cti: Use of_cpu_phandle_to_id for grabbing CPU id
Date: Mon, 7 Jul 2025 16:04:12 +0100
Message-ID: <20250707150414.620-4-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707150414.620-1-alireza.sanaee@huawei.com>
References: <20250707150414.620-1-alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500003.china.huawei.com (7.182.85.28)

Use the newly created API to grab CPU id.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 .../hwtracing/coresight/coresight-cti-platform.c  | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
index d0ae10bf6128..cd821e926792 100644
--- a/drivers/hwtracing/coresight/coresight-cti-platform.c
+++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
@@ -41,21 +41,12 @@
  */
 static int of_cti_get_cpu_at_node(const struct device_node *node)
 {
+	struct device_node *dn = NULL;
 	int cpu;
-	struct device_node *dn;
 
-	if (node == NULL)
-		return -1;
-
-	dn = of_parse_phandle(node, "cpu", 0);
-	/* CTI affinity defaults to no cpu */
-	if (!dn)
-		return -1;
-	cpu = of_cpu_node_to_id(dn);
+	cpu = of_cpu_phandle_to_id(node, &dn, 0);
 	of_node_put(dn);
-
-	/* No Affinity  if no cpu nodes are found */
-	return (cpu < 0) ? -1 : cpu;
+	return cpu;
 }
 
 #else
-- 
2.43.0

