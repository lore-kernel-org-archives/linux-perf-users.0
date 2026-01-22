Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3D03E8C53;
	Thu, 22 Jan 2026 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075297; cv=none; b=ak0qYwcwzqbV7JTyF6PupIls0N8G1MKZzvJcoCyV8AiGP4zMYHFgvL1n1ZDyBRzTs7ZkTCYFFIhDa5wn/EWS652j9RMCXVuZRWczXryZeA9KK3DOtdyDZWB3TdVD0d18zkePW0dP/DM5ZA4rjK4VndgNxupb7XCmIy2vhtIQk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075297; c=relaxed/simple;
	bh=SG5fMJBwAml2JWXlXKLHrHeULHkWewfRTCubRbuaowM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r3JtN3FvI4Z2+VjrrkhesnlmWavAwC5nCl8LpBg3O3pttSg8tqOmL6n2cbpLSUDn2lEernkuQjPyW+FRGNLvwn1PnmDjogACFxUE/xUkf5Vntvr8u2DqCuQ6AaG8HiRHDFtG/ReyOoQUY2z0jCJmMH0+mfYC0wp9n62Zq1KEwWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uzSwk61L; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uzSwk61L"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769075292; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=X5CrQ5BRNqlsZgtv/fi6RZSuKr5nRtuxSxetuKVXTfg=;
	b=uzSwk61LycJCC9iuU6qohdVhkYC8RPW1204+ZVVaAhGCZyA/1vncoYf9iDLuCemvTk3yl8c5hieKxkt0hWa6kT15L2sikeHdDvP7GAOucnepZhl+oi2KmVddE8tDQnTikBg398zrQoqAHy9tjrchO68u+FO2CrTUzF6YcAa8dwY=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0Wxbuak8_1769075288 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 17:48:11 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	robin.murphy@arm.com,
	mark.rutland@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org
Cc: lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-edac@vger.kernel.org,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH v6 10/16] ras: AEST: Introduce AEST driver sysfs interface
Date: Thu, 22 Jan 2026 17:46:50 +0800
Message-Id: <20260122094656.73399-11-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20260122094656.73399-1-tianruidong@linux.alibaba.com>
References: <20260122094656.73399-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exposes certain AEST driver information to userspace.

Only ROOT can access these interface because it includes
hardware-sensitive information:

  ls /sys/kernel/debug/aest/
  memory<id> smmu<id> ...

  ls /sys/kernel/debug/aest/memory<id>/
  record0 record1 ...

All details at:
        Documentation/ABI/testing/debugfs-aest

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 Documentation/ABI/testing/debugfs-aest |  32 +++++++
 MAINTAINERS                            |   1 +
 drivers/ras/aest/Makefile              |   1 +
 drivers/ras/aest/aest-core.c           |  13 +++
 drivers/ras/aest/aest-sysfs.c          | 118 +++++++++++++++++++++++++
 drivers/ras/aest/aest.h                |   8 ++
 6 files changed, 173 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-aest
 create mode 100644 drivers/ras/aest/aest-sysfs.c

diff --git a/Documentation/ABI/testing/debugfs-aest b/Documentation/ABI/testing/debugfs-aest
new file mode 100644
index 000000000000..8bacc6bb20b6
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-aest
@@ -0,0 +1,32 @@
+What:		/sys/kernel/debug/aest/<name>.<id>/
+Date:		Dec 2025
+KernelVersion:	6.19
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		Directory represented a AEST device, <name> means device type,
+		like:
+
+		- processor
+		- memory
+		- smmu
+		- ...
+
+		<id> is the unique ID for this device.
+
+What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/*
+Date:		Dec 2025
+KernelVersion:	6.19
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		Attibute for aest node which belong this device, the format
+		of node name is: <Node Type>-<Node Address>
+
+		See more at:
+			https://developer.arm.com/documentation/den0085/latest/
+
+What:		/sys/kernel/debug/aest/<name>.<id>/<node_name>/record<index>/err_*
+Date:		Dec 2025
+KernelVersion:	6.19
+Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
+Description:
+		(RO) Read err_* register and return val.
diff --git a/MAINTAINERS b/MAINTAINERS
index 3d56d3b791e4..e4b249823051 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -346,6 +346,7 @@ M:	Ruidong Tian <tianruidond@linux.alibaba.com>
 L:	linux-acpi@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Supported
+F:	Documentation/ABI/testing/debugfs-aest
 F:	arch/arm64/include/asm/ras.h
 F:	drivers/acpi/arm64/aest.c
 F:	drivers/ras/aest/
diff --git a/drivers/ras/aest/Makefile b/drivers/ras/aest/Makefile
index a6ba7e36fb43..75495413d2b6 100644
--- a/drivers/ras/aest/Makefile
+++ b/drivers/ras/aest/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_AEST) 	+= aest.o
 
 aest-y		:= aest-core.o
+aest-y		+= aest-sysfs.o
diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index 686dde6f2e68..3bcc635cf8e4 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -20,6 +20,9 @@ DEFINE_PER_CPU(struct aest_device, percpu_adev);
 #undef pr_fmt
 #define pr_fmt(fmt) "AEST: " fmt
 
+#ifdef CONFIG_DEBUG_FS
+struct dentry *aest_debugfs;
+#endif
 /*
  * This memory pool is only to be used to save AEST node in AEST irq context.
  * There can be 500 AEST node at most.
@@ -940,6 +943,8 @@ static int aest_device_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, adev);
 
+	aest_dev_init_debugfs(adev);
+
 	aest_dev_dbg(adev, "Node cnt: %x, id: %x\n", adev->node_cnt, adev->id);
 
 	return 0;
@@ -955,12 +960,20 @@ static struct platform_driver aest_driver = {
 
 static int __init aest_init(void)
 {
+#ifdef CONFIG_DEBUG_FS
+	aest_debugfs = debugfs_create_dir("aest", NULL);
+#endif
+
 	return platform_driver_register(&aest_driver);
 }
 module_init(aest_init);
 
 static void __exit aest_exit(void)
 {
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove(aest_debugfs);
+#endif
+
 	platform_driver_unregister(&aest_driver);
 }
 module_exit(aest_exit);
diff --git a/drivers/ras/aest/aest-sysfs.c b/drivers/ras/aest/aest-sysfs.c
new file mode 100644
index 000000000000..f3b5427ff4f0
--- /dev/null
+++ b/drivers/ras/aest/aest-sysfs.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM Error Source Table Support
+ *
+ * Copyright (c) 2025, Alibaba Group.
+ */
+
+#include "aest.h"
+
+/*******************************************************************************
+ *
+ * Attribute for AEST record
+ *
+ ******************************************************************************/
+
+#define DEFINE_AEST_DEBUGFS_ATTR(name, offset) \
+static int name##_get(void *data, u64 *val) \
+{ \
+	struct aest_record *record = data; \
+	*val = record_read(record, offset); \
+	return 0; \
+} \
+static int name##_set(void *data, u64 val) \
+{ \
+	struct aest_record *record = data; \
+	record_write(record, offset, val); \
+	return 0; \
+} \
+DEFINE_DEBUGFS_ATTRIBUTE(name##_ops, name##_get, name##_set, "%#llx\n")
+
+DEFINE_AEST_DEBUGFS_ATTR(err_fr, ERXFR);
+DEFINE_AEST_DEBUGFS_ATTR(err_ctrl, ERXCTLR);
+DEFINE_AEST_DEBUGFS_ATTR(err_status, ERXSTATUS);
+DEFINE_AEST_DEBUGFS_ATTR(err_addr, ERXADDR);
+DEFINE_AEST_DEBUGFS_ATTR(err_misc0, ERXMISC0);
+DEFINE_AEST_DEBUGFS_ATTR(err_misc1, ERXMISC1);
+DEFINE_AEST_DEBUGFS_ATTR(err_misc2, ERXMISC2);
+DEFINE_AEST_DEBUGFS_ATTR(err_misc3, ERXMISC3);
+
+static void aest_record_init_debugfs(struct aest_record *record)
+{
+	debugfs_create_file("err_fr", 0600, record->debugfs, record,
+								&err_fr_ops);
+	debugfs_create_file("err_ctrl", 0600, record->debugfs, record,
+								&err_ctrl_ops);
+	debugfs_create_file("err_status", 0600, record->debugfs, record,
+								&err_status_ops);
+	debugfs_create_file("err_addr", 0600, record->debugfs, record,
+								&err_addr_ops);
+	debugfs_create_file("err_misc0", 0600, record->debugfs, record,
+								&err_misc0_ops);
+	debugfs_create_file("err_misc1", 0600, record->debugfs, record,
+								&err_misc1_ops);
+	debugfs_create_file("err_misc2", 0600, record->debugfs, record,
+								&err_misc2_ops);
+	debugfs_create_file("err_misc3", 0600, record->debugfs, record,
+								&err_misc3_ops);
+}
+
+static void
+aest_node_init_debugfs(struct aest_node *node)
+{
+	int i;
+	struct aest_record *record;
+
+	for (i = 0; i < node->record_count; i++) {
+		record = &node->records[i];
+		if (!record->name)
+			continue;
+		record->debugfs = debugfs_create_dir(record->name,
+								node->debugfs);
+		aest_record_init_debugfs(record);
+	}
+}
+
+static void
+aest_oncore_dev_init_debugfs(struct aest_device *adev)
+{
+	int cpu, i;
+	struct aest_node *node;
+	struct aest_device *percpu_dev;
+	char name[16];
+
+	for_each_possible_cpu(cpu) {
+		percpu_dev = this_cpu_ptr(adev->adev_oncore);
+
+		snprintf(name, sizeof(name), "processor%u", cpu);
+		percpu_dev->debugfs = debugfs_create_dir(name, aest_debugfs);
+
+		for (i = 0; i < adev->node_cnt; i++) {
+			node = &adev->nodes[i];
+
+			node->debugfs = debugfs_create_dir(node->name,
+							percpu_dev->debugfs);
+			aest_node_init_debugfs(node);
+		}
+	}
+}
+
+void aest_dev_init_debugfs(struct aest_device *adev)
+{
+	int i;
+	struct aest_node *node;
+
+	adev->debugfs = debugfs_create_dir(dev_name(adev->dev), aest_debugfs);
+	if (aest_dev_is_oncore(adev)) {
+		aest_oncore_dev_init_debugfs(adev);
+		return;
+	}
+
+	for (i = 0; i < adev->node_cnt; i++) {
+		node = &adev->nodes[i];
+		if (!node->name)
+			continue;
+		node->debugfs = debugfs_create_dir(node->name, adev->debugfs);
+		aest_node_init_debugfs(node);
+	}
+}
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index f85e81ff35a6..ceb9e32bcee3 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -7,6 +7,7 @@
 
 #include <linux/acpi_aest.h>
 #include <asm/ras.h>
+#include <linux/debugfs.h>
 
 #define MAX_GSI_PER_NODE 2
 #define DEFAULT_CE_THRESHOLD 1
@@ -67,6 +68,8 @@
 
 #define GIC_ERRDEVARCH 0xFFBC
 
+extern struct dentry *aest_debugfs;
+
 struct aest_event {
 	struct llist_node llnode;
 	char *node_name;
@@ -133,6 +136,7 @@ struct aest_record {
 
 	struct ce_threshold ce;
 	enum ras_ce_threshold threshold_type;
+	struct dentry *debugfs;
 };
 
 struct aest_group {
@@ -201,6 +205,7 @@ struct aest_node {
 
 	int record_count;
 	struct aest_record *records;
+	struct dentry *debugfs;
 	struct aest_node __percpu *oncore_node;
 };
 
@@ -215,6 +220,7 @@ struct aest_device {
 	struct work_struct aest_work;
 	struct gen_pool *pool;
 	struct llist_head event_list;
+	struct dentry *debugfs;
 	struct aest_device __percpu *adev_oncore;
 };
 
@@ -344,3 +350,5 @@ static inline bool aest_dev_is_oncore(struct aest_device *adev)
 {
 	return adev->type == ACPI_AEST_PROCESSOR_ERROR_NODE;
 }
+
+void aest_dev_init_debugfs(struct aest_device *adev);
-- 
2.51.2.612.gdc70283dfc

