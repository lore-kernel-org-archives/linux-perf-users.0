Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7852571D5;
	Mon, 12 May 2025 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037305; cv=none; b=Z2Lz+tF3cue09WIG4sW/VOQB+XOfGIEkThscHh91SK0z7+SApYt/fFAKQd8jjPTnU+RQzRewQ6dX1LFwLns8Er1UY3rFfqb6nj1v+WfMJXfJpbMtc6lkps+huRT5sLMrFgtHPjgyKFOPqnOCfAEfv0dZeQgXlNVZuXCqYUJG8S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037305; c=relaxed/simple;
	bh=eF1yfF+FebAl2O4ISeOH9vYT5R/HY3HCYjCHSmtiBAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1H5U6znc/dEj7R1NpauXRMHVOUKlcXf/gffvOcVtJv5VH82Q1R3OU2KaREJ1DTCytagbYPKy6q16nc0K2ZCrINiPWWl5LRykvxLznCL/mnu3IZPICY8OsGp0XJTDNC5QpbpP5aZI2qu3odnBJRDVr3Qz211DoCOzW6+/lN8c3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zwsc31vLpz6L4wH;
	Mon, 12 May 2025 16:05:39 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id A473F1402FC;
	Mon, 12 May 2025 16:08:21 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.30.10) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 May 2025 10:08:20 +0200
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
Subject: [PATCH v3 2/7] arch_topology: update CPU map to use the new API
Date: Mon, 12 May 2025 09:07:10 +0100
Message-ID: <20250512080715.82-3-alireza.sanaee@huawei.com>
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

Cleans up the cpu-map generation using the created API.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 drivers/base/arch_topology.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 3ebe77566788..88970f13f684 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -518,23 +518,23 @@ core_initcall(free_raw_capacity);
  */
 static int __init get_cpu_for_node(struct device_node *node)
 {
+	struct device_node *cpu_node __free(device_node) = NULL;
 	int cpu;
-	struct device_node *cpu_node __free(device_node) =
-		of_parse_phandle(node, "cpu", 0);
 
-	if (!cpu_node)
-		return -1;
+	cpu = of_cpu_phandle_to_id(node, &cpu_node, 0);
 
-	cpu = of_cpu_node_to_id(cpu_node);
 	if (cpu >= 0)
 		topology_parse_cpu_capacity(cpu_node, cpu);
-	else
+	else if (cpu == -ENODEV)
 		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
 			cpu_node, cpumask_pr_args(cpu_possible_mask));
+	else
+		return -1;
 
 	return cpu;
 }
 
+
 static int __init parse_core(struct device_node *core, int package_id,
 			     int cluster_id, int core_id)
 {
-- 
2.34.1

