Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B4C365A0B;
	Thu, 22 Jan 2026 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075259; cv=none; b=EyKh6wtmYQDFw2yCusDk6O51dGMDLTDU8Z+5QmzN5vKRIRu5S+7KytlJR0lbxN71MAj0+t8mfk6kB5BWL2l0FPDa7uM+inf8Y+on1MoMRtOVLqIIGYCr8mEBPu5HS9SDdvsF+HKkSRYH2l/4uTuTcz1Pi/rL1ypJDf3jHRF78+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075259; c=relaxed/simple;
	bh=eAZzCI5nkOPouHu8166myOihyvraqZfihihrLhdM7tQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhZdDyGNRn94fLuD0GxCnUCXu/EhusweT8+LkpJ7S+oiHSDvJXZVbITJJTMVVMBjXzvKr2ucgBaGs7n+6beTPudoS/p20p173wviAKV9/YNedMTpnA6wYOpd4QwZgB4Y/9eG9XnWiulnWcxiDrJ2dz603/tVLNfpc76sgaMPUdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uwAqmfuX; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uwAqmfuX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769075253; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4DCUNTo5xh9M5poTUAlPWmJCzg4ftKAmvhtmbMlI8n4=;
	b=uwAqmfuXBPng108nFnx8injZnAtmyRKR9wo79aeVZoIHCw7dLrjWFmAX1sxuv7EKX6jKcFDf+UYvY057Bfk2ckwsaQen4YCoyFJ8WAqHq1qtaQVuL6nXJIDGnIrZGi2sDQyMV250QTRDUypGz5Xdxrr0khMWiunaskP0Nbb/0aI=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0Wxbwfsb_1769075244 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 17:47:33 +0800
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
Subject: [PATCH v6 03/16] ras: AEST: support different group format
Date: Thu, 22 Jan 2026 17:46:43 +0800
Message-Id: <20260122094656.73399-4-tianruidong@linux.alibaba.com>
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

Support for various AEST group formats allows for flexible configuration of
AEST node address space sizes and maximum record counts per group.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/ras/aest/aest-core.c |  6 ++++--
 drivers/ras/aest/aest.h      | 39 +++++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index c7ef6c13fd44..acebb293ac75 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -84,7 +84,7 @@ static int aest_node_set_errgsr(struct aest_device *adev,
 		return 0;
 
 	if (!(anode->interface_hdr->flags & AEST_XFACE_FLAG_ERROR_GROUP)) {
-		node->errgsr = node->base + ERXGROUP;
+		node->errgsr = node->base + node->group->errgsr_offset;
 		return 0;
 	}
 
@@ -112,10 +112,12 @@ static int aest_init_node(struct aest_device *adev, struct aest_node *node,
 		return -ENOMEM;
 	node->record_implemented = anode->record_implemented;
 	node->status_reporting = anode->status_reporting;
+	node->group = &aest_group_config[anode->interface_hdr->group_format];
 
 	address = anode->interface_hdr->address;
 	if (address) {
-		node->base = devm_ioremap(adev->dev, address, PAGE_SIZE);
+		node->base =
+			devm_ioremap(adev->dev, address, node->group->size);
 		if (!node->base)
 			return -ENOMEM;
 	}
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index d918240c3f57..3250675e99b7 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -37,7 +37,15 @@
 	dev_dbg((__record)->node->adev->dev, "%s: %s: " format, \
 		(__record)->node->name, (__record)->name, ##__VA_ARGS__)
 
-#define ERXGROUP 0xE00
+#define ERXGROUP_4K_OFFSET 0xE00
+#define ERXGROUP_16K_OFFSET 0x3800
+#define ERXGROUP_64K_OFFSET 0xE000
+#define ERXGROUP_4K_SIZE (4 * KB)
+#define ERXGROUP_16K_SIZE (16 * KB)
+#define ERXGROUP_64K_SIZE (64 * KB)
+#define ERXGROUP_4K_ERRGSR_NUM 1
+#define ERXGROUP_16K_ERRGSR_NUM 4
+#define ERXGROUP_64K_ERRGSR_NUM 14
 
 struct aest_record {
 	char *name;
@@ -57,6 +65,34 @@ struct aest_record {
 	struct aest_node *node;
 };
 
+struct aest_group {
+	int type;
+	int errgsr_num;
+	size_t size;
+	u64 errgsr_offset;
+};
+
+static const struct aest_group aest_group_config[] = {
+	[ACPI_AEST_NODE_GROUP_FORMAT_4K] = {
+		.type = ACPI_AEST_NODE_GROUP_FORMAT_4K,
+		.errgsr_num = ERXGROUP_4K_ERRGSR_NUM,
+		.size = ERXGROUP_4K_SIZE,
+		.errgsr_offset = ERXGROUP_4K_OFFSET,
+	},
+	[ACPI_AEST_NODE_GROUP_FORMAT_16K] = {
+		.type = ACPI_AEST_NODE_GROUP_FORMAT_16K,
+		.errgsr_num = ERXGROUP_16K_ERRGSR_NUM,
+		.size = ERXGROUP_16K_SIZE,
+		.errgsr_offset = ERXGROUP_16K_OFFSET,
+	},
+	[ACPI_AEST_NODE_GROUP_FORMAT_64K] = {
+		.type = ACPI_AEST_NODE_GROUP_FORMAT_64K,
+		.errgsr_num = ERXGROUP_64K_ERRGSR_NUM,
+		.size = ERXGROUP_64K_SIZE,
+		.errgsr_offset = ERXGROUP_64K_OFFSET,
+	},
+};
+
 struct aest_node {
 	char *name;
 	u8 type;
@@ -86,6 +122,7 @@ struct aest_node {
 	 */
 	unsigned long *status_reporting;
 
+	const struct aest_group *group;
 	struct aest_device *adev;
 	struct acpi_aest_node *info;
 
-- 
2.51.2.612.gdc70283dfc

