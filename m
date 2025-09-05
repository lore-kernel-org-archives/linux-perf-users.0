Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A664263F2D;
	Fri,  5 Sep 2025 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089152; cv=none; b=D2Wg2jXBm1ONtkeRVHBfnjQ/qxfIpXU7eYuWlylTlmGFghgk9tenSk9bO+VOJ6AWjpuY8mfL5ZpMy/kGnVXjWPcxJ7qzahk6xWYKhvHMBSuR2sVVpqKfV/J9r6NkE+VDn6Vg/6iYI28y5TmXLRoDYd1CmCAs0TlVnL7t6rLaUP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089152; c=relaxed/simple;
	bh=C2t4tSU3Clk9k0uygTv6O4hhL18A4eELuW2Ca/p3YHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdsbWaKvoV2KyqWOgCfBQvaCp7c7PTm1vaWvXnA7lQyrTnzjq8V3EEwi2iFDwzviYarrwv4w43YQtC9cWUUmNBVLWuCdapT0CbSapFLXpN8/IS4uBVLl3zDCMNL+T+jkhng3Se5lqF4iqtsLAb6XELITURkU4sf08x+T9IPgyz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cJM2m72SLz6L51Z;
	Sat,  6 Sep 2025 00:18:08 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C8B1140159;
	Sat,  6 Sep 2025 00:19:08 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.202.66.105) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Sep 2025 18:19:05 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <coresight@lists.linaro.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <jonathan.cameron@huawei.com>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<robh@kernel.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<suzuki.poulose@arm.com>
Subject: [PATCH v4 1/6] of: add infra for finding CPU id from phandle
Date: Fri, 5 Sep 2025 17:18:24 +0100
Message-ID: <20250905161830.37-2-alireza.sanaee@huawei.com>
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

Get CPU ID from phandle. Some drivers such as coresight, cti-coresight,
or arm-dsu use this API for finding CPU node in DT. In particular,
drivers do this by getting the CPU device_node through a phandle and
then find the CPU ID using of_cpu_node_to_id(). This commit encapsulates
CPU node finding and improves readability.

The interface takes three parameters, 1) node, 2) pointer to
pointer of CPU node, 3) CPU node index. API sets the pointer to the CPU
node and allows the driver to work with the CPU node, for logging
purposes for instance.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 drivers/of/cpu.c   | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h |  9 +++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/of/cpu.c b/drivers/of/cpu.c
index 5214dc3d05ae..9e0d3ec10bc2 100644
--- a/drivers/of/cpu.c
+++ b/drivers/of/cpu.c
@@ -173,6 +173,54 @@ int of_cpu_node_to_id(struct device_node *cpu_node)
 }
 EXPORT_SYMBOL(of_cpu_node_to_id);
 
+/**
+ * of_cpu_phandle_to_id: Get the logical CPU number for a given device_node
+ *
+ * @node: Pointer to the device_node containing CPU phandle.
+ * @cpu_np: Pointer to the device_node for CPU.
+ * @cpu_idx: The index of the CPU in the list of CPUs.
+ *
+ * *cpu_np is only set when cpu_np is not NULL.  Use of_node_put() to release
+ * the node reference if cpu_np != NULL and this function succeeds.
+ *
+ * Return: This function has three different possible return situations:
+ *	1) returns -EINVAL if the node is NULL.
+ *	2) returns -ENODEV if the CPU node is not found or of_cpu_node_to_id is
+ *	not successful.
+ *	3) returns the logical CPU number if the CPU node is found.
+ */
+int of_cpu_phandle_to_id(const struct device_node *node,
+			 struct device_node **cpu_np,
+			 uint8_t cpu_idx)
+{
+	struct device_node *local_cpu_node = NULL;
+	int cpu;
+
+	if (!node)
+		return -EINVAL;
+
+	if (cpu_idx == 0)
+		local_cpu_node = of_parse_phandle(node, "cpu", 0);
+	if (!local_cpu_node)
+		local_cpu_node = of_parse_phandle(node, "cpus", cpu_idx);
+	if (!local_cpu_node)
+		return -ENODEV;
+
+	cpu = of_cpu_node_to_id(local_cpu_node);
+	if (cpu < 0) {
+		of_node_put(local_cpu_node);
+		return cpu;
+	}
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

