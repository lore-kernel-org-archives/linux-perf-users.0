Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8161BF37;
	Tue,  8 Jul 2025 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987741; cv=none; b=M9agNKZ7LHgdX3krTXeQnmBrDgUywwLD2P9GNiz+z5Zk8rB0vcSAnrll9sShrveM6bnl8Cu7DxSiUoW3QGsdrLRlvE0oh+JQ26iy4jV/MBDj7kzpiRurszdc/v+xZqdr6bhdOAdscjn4pfEuA7wqf0aermgvrckhUJGnTG6GvKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987741; c=relaxed/simple;
	bh=kWGQ8niWIt154hC3EbK6P5yuNnrD5aDaG+k8IKy+pnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tET21jMmW596I1g7v49VT3t4j9c6+VdishkPMcoMjGMV3PnAZ/i5lBNNEIGX5M6585arioPkGmw/y16f96tW6uPl1wC1QlI0Y360G04X7Dw0hyNMnvNk/q6rb2AM+IjvJog3yDEw0xMI1//gLH/XRQ1iV4IbAmI7KfykN3L3xz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bc4NB4r7hz6D8gg;
	Tue,  8 Jul 2025 23:12:26 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 849261402A5;
	Tue,  8 Jul 2025 23:15:36 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.203.177.99) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Jul 2025 17:15:35 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <krzk@kernel.org>, <robh@kernel.org>
CC: <coresight@lists.linaro.org>, <devicetree@vger.kernel.org>,
	<dianders@chromium.org>, <james.clark@linaro.org>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 1/5] of: add infra for finding CPU id from phandle
Date: Tue, 8 Jul 2025 16:14:58 +0100
Message-ID: <20250708151502.561-2-alireza.sanaee@huawei.com>
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

Get CPU id from phandle. Many drivers get do this by getting hold of CPU
node first through a phandle and then find the CPU ID using the relevant
function. This commit encapsulates cpu node finding and improves
readability.

The API interface requires two parameters, 1) node, 2) pointer to
pointer of CPU node, 3) cpu node index. API sets the pointer to the CPU
node and allows the driver to play with the CPU itself, for logging
purposes for instance.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 drivers/of/cpu.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h |  9 +++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/of/cpu.c b/drivers/of/cpu.c
index 5214dc3d05ae..494d47470f94 100644
--- a/drivers/of/cpu.c
+++ b/drivers/of/cpu.c
@@ -173,6 +173,46 @@ int of_cpu_node_to_id(struct device_node *cpu_node)
 }
 EXPORT_SYMBOL(of_cpu_node_to_id);
 
+/**
+ * of_cpu_phandle_to_id: Get the logical CPU number for a given device_node
+ *
+ * @node: Pointer to the device_node containing CPU phandle.
+ * @cpu_np: Pointer to the device_node for CPU.
+ * @cpu_idx: The index of the CPU in the list of CPUs.
+ *
+ * Return: The logical CPU number of the given CPU device_node or -ENODEV if
+ * the CPU is not found, or if the node is NULL, it returns -1. On success,
+ * cpu_np will always point to the retrieved CPU device_node with refcount
+ * incremented, use of_node_put() on it when done.
+ */
+int of_cpu_phandle_to_id(const struct device_node *node,
+			 struct device_node **cpu_np,
+			 uint8_t cpu_idx)
+{
+	struct device_node *local_cpu_node;
+	int cpu;
+
+	if (!node)
+		return -1;
+
+	local_cpu_node = of_parse_phandle(node, "cpu", 0);
+	if (!local_cpu_node)
+		local_cpu_node = of_parse_phandle(node, "cpus", cpu_idx);
+
+	if (!local_cpu_node)
+		return -ENODEV;
+
+	cpu = of_cpu_node_to_id(local_cpu_node);
+
+	if (cpu_np)
+		*cpu_np = local_cpu_node;
+	else
+		of_node_put(local_cpu_node);
+
+	return cpu;
+}
+EXPORT_SYMBOL(of_cpu_phandle_to_id);
+
 /**
  * of_get_cpu_state_node - Get CPU's idle state node at the given index
  *
diff --git a/include/linux/of.h b/include/linux/of.h
index a62154aeda1b..717e55065d99 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -365,6 +365,8 @@ extern const void *of_get_property(const struct device_node *node,
 extern struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
 extern struct device_node *of_cpu_device_node_get(int cpu);
 extern int of_cpu_node_to_id(struct device_node *np);
+extern int of_cpu_phandle_to_id(const struct device_node *np,
+				struct device_node **cpu_np, uint8_t cpu_idx);
 extern struct device_node *of_get_next_cpu_node(struct device_node *prev);
 extern struct device_node *of_get_cpu_state_node(const struct device_node *cpu_node,
 						 int index);
@@ -680,6 +682,13 @@ static inline int of_cpu_node_to_id(struct device_node *np)
 	return -ENODEV;
 }
 
+static inline int of_cpu_phandle_to_id(const struct device_node *np,
+				       struct device_node **cpu_np,
+				       uint8_t cpu_idx)
+{
+	return -ENODEV;
+}
+
 static inline struct device_node *of_get_next_cpu_node(struct device_node *prev)
 {
 	return NULL;
-- 
2.43.0

