Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDD52F7ABF;
	Fri,  5 Sep 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089185; cv=none; b=eKQiw9MB7T2oI5AtccE2LFvb6XXl6Yn8xMHzyZOvOTSzOnhVey15Cuf54hi0WTQOLvMj/lMmb/m0ufnhEc/Zn35o6ncnDU8/qUsj7sMqMoucTX/lHIBqWd8aqsm2tt++slBxIo9vgKZxpoIeCFkS8GYLLg7GzyioRiDVQfRbKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089185; c=relaxed/simple;
	bh=eZSDeiM7HCdeqqRsi4zXh+9r6X3OLsFdI7dGcGk4yoc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baXXoKM1cBrZSr4VnSZ9Lz1w1mnbJLOawpWvfui4Zlgc1yImzf7bpSO9MVdL5LAO6EkTX2P9tVY/06gXyJrhvDjWAi9H8Kfd+3TqsB8P0sZMPTM0iddapGvoRHJwYyhLVs8MWpaYXMqJUon47/Z1SrNlCKs0dtsTl8wZFX2Oeg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cJM3Q6vwsz6L51J;
	Sat,  6 Sep 2025 00:18:42 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 2803F1401DC;
	Sat,  6 Sep 2025 00:19:42 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.202.66.105) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Sep 2025 18:19:39 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <coresight@lists.linaro.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <jonathan.cameron@huawei.com>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<robh@kernel.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<suzuki.poulose@arm.com>
Subject: [PATCH v4 2/6] arch_topology: drop the use of cpu_node in the pr_info
Date: Fri, 5 Sep 2025 17:18:25 +0100
Message-ID: <20250905161830.37-3-alireza.sanaee@huawei.com>
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

Remove the use of cpu_node in the pr_info(). When of_cpu_node_to_id() fails,
it may set a pointer, cpu_node, and the get_cpu_for_node() function uses that
pointer to log further in the fail scenario.

Also, change the structure to exit early in fail scenarios which will
help enabling code unification that follows in this series.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 drivers/base/arch_topology.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1037169abb45..6fafd86f608a 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -481,12 +481,13 @@ static int __init get_cpu_for_node(struct device_node *node)
 		return -1;
 
 	cpu = of_cpu_node_to_id(cpu_node);
-	if (cpu >= 0)
-		topology_parse_cpu_capacity(cpu_node, cpu);
-	else
-		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
-			cpu_node, cpumask_pr_args(cpu_possible_mask));
+	if (cpu < 0) {
+		pr_info("CPU node exist but the possible cpu range is :%*pbl\n",
+			cpumask_pr_args(cpu_possible_mask));
+		return cpu;
+	}
 
+	topology_parse_cpu_capacity(cpu_node, cpu);
 	return cpu;
 }
 
-- 
2.43.0

