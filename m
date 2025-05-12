Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A692561B8;
	Mon, 12 May 2025 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037465; cv=none; b=evZZnJUz92LLVfgP8+6EnUcW6HJOUxXF+0ZF0QuHqeyVdbNxU/ZiKaz7VPILuNIapbDUCkSi6jdM2KmsS4YJ542U5ytnELhgT3hw6ap4/mMp8+6LsCqSeGkiIInCiKiVkgNNl2B3dc5MOmCto9IGZ0c814Og8DEPfxXmqkxz/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037465; c=relaxed/simple;
	bh=9Wo1EwJxutD9p3npSM18IZGR8PNKr7fkce/EAjiUTQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8PAleS703vSs2IGt26wm1k/U18OOPq6HUxGckRmkvuYcfgFzVK38362+1G0X91esXzSxNE0bfVpUM1+R+2qFZsMBCNu69Xd4DBRP4r/TWXyJaaesQTk7CLLwatzZYVnwGPfbLGnTuS7xOBhHwh8YfnWZCUPsKNu0F2Svaw/10E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zwscv1Lntz6M4gh;
	Mon, 12 May 2025 16:06:23 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id BE8E41402F4;
	Mon, 12 May 2025 16:11:01 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.30.10) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 May 2025 10:11:00 +0200
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
Subject: [PATCH v3 7/7] of: of_cpu_phandle_to_id to support SMT threads
Date: Mon, 12 May 2025 09:07:15 +0100
Message-ID: <20250512080715.82-8-alireza.sanaee@huawei.com>
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

Enhance the API to support SMT threads, this will allow sharing
resources among multiple SMT threads.

Enabled the sharing of resources, such as L1 Cache and clocks, between
SMT threads. It introduces a fix that uses thread IDs to match each CPU
thread in the register array within the cpu-node. This ensures that the
cpu-map or any driver relying on this API is fine even when SMT threads
share resources.

Additionally, I have tested this for CPU based on the discussions in
[1], I adopted the new cpu-map layout, where the first parameter is a
phandle and the second is the local thread index, as shown below:

    core0 {
      thread0 {
        cpu = <&cpu0 0>;
      };
      thread1 {
        cpu = <&cpu0 1>;
      };
    };

Also, there are devices such as below that are a bit different.

    arm_dsu@0 {
      compatible = "arm,dsu";
      cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
    }

In these cases, we can also point to a CPU thread as well like the
following:

    arm_dsu@0 {
      compatible = "arm,dsu";
        cpus = <&cpu0 5 &cpu1 9 &cpu2 1 &cpu3 0>;
    }

It should be possible to know how many arguments a phandle might
require, and this information is encoded in another variable in the dt
called #cpu-cells in cpu node.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>

[1] https://lore.kernel.org/devicetree-spec/CAL_JsqK1yqRLD9B+G7UUp=D8K++mXHq0Rmv=1i6DL_jXyZwXAw@mail.gmail.com/
---
 drivers/of/cpu.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/of/cpu.c b/drivers/of/cpu.c
index fba17994fc20..cf54ef47f029 100644
--- a/drivers/of/cpu.c
+++ b/drivers/of/cpu.c
@@ -189,16 +189,41 @@ int of_cpu_phandle_to_id(const struct device_node *node,
 			 struct device_node **cpu_np,
 			 uint8_t cpu_idx)
 {
+	bool found = false;
+	int cpu, ret = -1, i, j;
+	uint32_t local_thread, thread_index;
+	struct device_node *np;
+	struct of_phandle_args args;
+	static const char * const phandle_names[] = { "cpus", "cpu" };
+	static const char * const cpu_cells[] = { "#cpu-cells", NULL };
+
 	if (!node)
-		return -1;
+		return ret;
 
-	*cpu_np = of_parse_phandle(node, "cpu", 0);
-	if (!*cpu_np)
-		*cpu_np = of_parse_phandle(node, "cpus", cpu_idx);
-			if (!*cpu_np)
-				return -ENODEV;
+	for (i = 0; i < ARRAY_SIZE(phandle_names); i++) {
+		for (j = 0; j < ARRAY_SIZE(cpu_cells); j++) {
+			ret = of_parse_phandle_with_args(node, phandle_names[i],
+							 cpu_cells[j], cpu_idx,
+							 &args);
+				if (ret >= 0)
+					goto success;
+		}
+	}
 
-	return of_cpu_node_to_id(*cpu_np);
+	if (ret < 0)
+		return ret;
+success:
+	*cpu_np = args.np;
+	thread_index = args.args_count == 1 ? args.args[0] : 0;
+	for_each_possible_cpu(cpu) {
+		np = of_get_cpu_node(cpu, &local_thread);
+		found = (*cpu_np == np) && (local_thread == thread_index);
+		of_node_put(np);
+		if (found)
+			return cpu;
+	}
+
+	return -ENODEV;
 }
 EXPORT_SYMBOL(of_cpu_phandle_to_id);
 
@@ -206,7 +231,7 @@ EXPORT_SYMBOL(of_cpu_phandle_to_id);
  * of_get_cpu_state_node - Get CPU's idle state node at the given index
  *
  * @cpu_node: The device node for the CPU
- * @index: The index in the list of the idle states
+g* @index: The index in the list of the idle states
  *
  * Two generic methods can be used to describe a CPU's idle states, either via
  * a flattened description through the "cpu-idle-states" binding or via the
-- 
2.34.1

