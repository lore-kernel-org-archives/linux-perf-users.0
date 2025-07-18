Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E4129992A;
	Fri, 18 Jul 2025 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832228; cv=none; b=tC7xrs3D+4H2+z41g3fAgjIeAYZzcq7HVi/VelaOFmo0qTCXOU5uaWCKaDVxjdgpjHBGn3LFecoS+zL3X0VKUw9+PNgkflY+MPNpnVwAHmdkY1Iknew4F9u7BLdl5aFwM1SrGnU31k6snMXMbdMd0LjzP16pmWwcNITwDtR/k7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832228; c=relaxed/simple;
	bh=muKMfRVWZI2Rc8hAQlQD7V76CBdzCka9gl3ZQT3OCNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkBfMaN5HXTB2JwlsB3WOF0ba31gl5NZUS5ZinJpDdhnQvdiECrviGowq5TQBzlayFHkNFwYfdpMMOqpJzlvmh9098+737xAqN7faeWggnv/RnGCglF36PtQIud70OXLea+ZA9G6SfeKi50SmvnV4ox/pHOq/DMdhU/exvOtMv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bk4kV1VZcz6M4j6;
	Fri, 18 Jul 2025 17:49:06 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 69BF314027A;
	Fri, 18 Jul 2025 17:50:24 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.203.177.99) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Jul 2025 11:50:23 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <coresight@lists.linaro.org>,
	<dianders@chromium.org>, <james.clark@linaro.org>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<robh@kernel.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <suzuki.poulose@arm.com>
Subject: [PATCH v3 3/6] arch_topology: update CPU map to use of_cpu_phandle_to_id
Date: Fri, 18 Jul 2025 10:48:45 +0100
Message-ID: <20250718094848.587-4-alireza.sanaee@huawei.com>
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

Refactor get_cpu_for_node to use of_cpu_phandle_to_id instead of
of_cpu_node_to_id.

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

