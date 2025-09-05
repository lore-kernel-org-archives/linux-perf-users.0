Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97A7309F03;
	Fri,  5 Sep 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089220; cv=none; b=UqZjZzPf36QCTqnHulPSJXC/aA/nH9zcwixzP6rkTg6TLkz3lJxgkj+XD5DqGapdewT/ZCYd0xDXo7U47MMDEXtj6CKTXuNiZzw04jCjNjh6vuTqwxUttTS+bm7oFJ5uPEXn/NkZMu9Pp5TLl3L5tFoQuPDh9kyYAIhJAg9kTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089220; c=relaxed/simple;
	bh=g0c2Th4MPywjqWoMfjQxZfkoQutYHoteM3HnE467LTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8FZp8GkimWAEkwsZr+QSi0tuBOZXIZ9pUhonAg3x5ZKsAKdUKJwoMDLnRdqym/FfItvHU4XSPl2x9BqpUqQp5JqrBuuWJ7SZw07lQiXyGlLcEXc+My4UgrEGP3nwNgiHLijy1VO0E7K9IVGBSvs4u4NjBjYamwFQQe0Wk3jtEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cJM0j1rRgz6L5FV;
	Sat,  6 Sep 2025 00:16:21 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id EEE7F14037D;
	Sat,  6 Sep 2025 00:20:15 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.202.66.105) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Sep 2025 18:20:13 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <coresight@lists.linaro.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <jonathan.cameron@huawei.com>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<robh@kernel.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<suzuki.poulose@arm.com>
Subject: [PATCH v4 3/6] arch_topology: update CPU map to use of_cpu_phandle_to_id
Date: Fri, 5 Sep 2025 17:18:26 +0100
Message-ID: <20250905161830.37-4-alireza.sanaee@huawei.com>
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

Refactor get_cpu_for_node to use of_cpu_phandle_to_id instead of
of_cpu_node_to_id.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 drivers/base/arch_topology.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 6fafd86f608a..72bf23cdf469 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -474,20 +474,19 @@ static unsigned int max_smt_thread_num = 1;
 static int __init get_cpu_for_node(struct device_node *node)
 {
 	int cpu;
-	struct device_node *cpu_node __free(device_node) =
-		of_parse_phandle(node, "cpu", 0);
+	struct device_node *cpu_node = NULL;
 
-	if (!cpu_node)
-		return -1;
-
-	cpu = of_cpu_node_to_id(cpu_node);
-	if (cpu < 0) {
+	cpu = of_cpu_phandle_to_id(node, &cpu_node, 0);
+	if (cpu == -ENODEV) {
 		pr_info("CPU node exist but the possible cpu range is :%*pbl\n",
 			cpumask_pr_args(cpu_possible_mask));
 		return cpu;
+	} else if (cpu < 0) {
+		return -1;
 	}
 
 	topology_parse_cpu_capacity(cpu_node, cpu);
+	of_node_put(cpu_node);
 	return cpu;
 }
 
-- 
2.43.0

