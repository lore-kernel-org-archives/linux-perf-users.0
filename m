Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CC32E0916;
	Tue,  8 Jul 2025 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987771; cv=none; b=vAa3ZHFd19jxOkqzyY/4pFzaYLw31Yg97aBpH/iTaexluI7Lpm5e1TPkSNCG/G4U3Hm9/HFfSPS3gDuBKe/RNPc0wL792jvwPW235lkKt0dcADmR4moxjh09X/jUnXfjl3OP5ddNy3vt8d6eWU+dIHay/A+zO685YDiQ9OzA5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987771; c=relaxed/simple;
	bh=fPkbhYkP8oPCC3wrim1HbW/Hjnd8KZr7Pyf40Q9rta4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZthEBq04gVItnQs+Ge86YxNjSrJvbdjICOZ+T17/SO+9dZsU00K0ZL2j848ZAlBNMUU+Z/xBigRYjX+mOu3RbcKrskCsmEmFlRtQUcPFssjYAIpAkEu22F91uyKLH4+FKMlN1cVNvlnhUUxoJbl97qg/VYgo3nAMVYI4/Z4eYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bc4Np0DFNz6D8gp;
	Tue,  8 Jul 2025 23:12:58 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id DA5381402A5;
	Tue,  8 Jul 2025 23:16:07 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.203.177.99) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Jul 2025 17:16:07 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <krzk@kernel.org>, <robh@kernel.org>
CC: <coresight@lists.linaro.org>, <devicetree@vger.kernel.org>,
	<dianders@chromium.org>, <james.clark@linaro.org>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 2/5] arch_topology: update CPU map to use the new API
Date: Tue, 8 Jul 2025 16:14:59 +0100
Message-ID: <20250708151502.561-3-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708151502.561-1-alireza.sanaee@huawei.com>
References: <20250708151502.561-1-alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500003.china.huawei.com (7.182.85.28)

Cleans up the cpu-map generation using the created API.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 drivers/base/arch_topology.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1037169abb45..ccc73bfae90d 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -473,19 +473,19 @@ static unsigned int max_smt_thread_num = 1;
  */
 static int __init get_cpu_for_node(struct device_node *node)
 {
+	struct device_node *cpu_node;
 	int cpu;
-	struct device_node *cpu_node __free(device_node) =
-		of_parse_phandle(node, "cpu", 0);
 
-	if (!cpu_node)
-		return -1;
-
-	cpu = of_cpu_node_to_id(cpu_node);
-	if (cpu >= 0)
+	cpu = of_cpu_phandle_to_id(node, &cpu_node, 0);
+	if (cpu >= 0) {
 		topology_parse_cpu_capacity(cpu_node, cpu);
-	else
+		of_node_put(cpu_node);
+	} else if (cpu == -ENODEV) {
 		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
 			cpu_node, cpumask_pr_args(cpu_possible_mask));
+		of_node_put(cpu_node);
+	} else
+		return -1;
 
 	return cpu;
 }
-- 
2.43.0

