Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224392E1C7A;
	Mon,  7 Jul 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900790; cv=none; b=JSxFUsp7JyvhT7m68klNqka+fVqWs1HzeGIy6VUP9nYkt5rkQXphZAHGvBZDcg8+6mckuHyJiYUzUiAqBwUrsw7nQxlq9CqgQfczaonazMJKvA5kdFVApiHn6kfwRyAOBYWC16sIe8uONhsXwDm/3180+2cbvnIOEl+lpP7j2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900790; c=relaxed/simple;
	bh=rlDNHVyVjrqIUDiW73UeFuBXyf2zoFO3tJzsYIf1cBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0y5uytLKx1gLd4izKo7ySo/r67DFwfFKiVzgJA7qcceXsOKRZcUFhiGxZ9KR5lzL2CKzTAVlHyIGxbZGhbWJsrnCcMq1E4cXzBdpARB+LxHQjLTo45gj32N6iWIs4s2j7hCqz2BUXxowAMi+CBY5PhKbA18g+d+BENsoTvm2dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bbSGX3km3z6M4qT;
	Mon,  7 Jul 2025 23:05:24 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 24F9F1402EB;
	Mon,  7 Jul 2025 23:06:27 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.45.147.207) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Jul 2025 17:06:25 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <mark.rutland@arm.com>, <robh@kernel.org>
CC: <coresight@lists.linaro.org>, <devicetree@vger.kernel.org>,
	<dianders@chromium.org>, <james.clark@linaro.org>,
	<jonathan.cameron@huawei.com>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linuxarm@huawei.com>,
	<mike.leach@linaro.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <suzuki.poulose@arm.com>
Subject: [PATCH 4/5] coresight: Use of_cpu_phandle_to_id for grabbing CPU id
Date: Mon, 7 Jul 2025 16:04:13 +0100
Message-ID: <20250707150414.620-5-alireza.sanaee@huawei.com>
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
2.43.0

