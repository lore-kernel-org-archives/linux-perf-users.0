Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1864D90DD;
	Tue, 14 Jul 2026 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047919; cv=none; b=q0uRuSZYJEBKik3Pu56TLYfPSqovNuq+2MFWDWQ2s06cNMj966ytD75ZjHFqs7lclz7H5Fl0O+HYURft1Pq79pPadKYV90vdCgluuvXd/MZ7DFue5X7liYycd3a9gjbNH/XgJaWvpGQAC5eDJFkzVP/ODwhtTfzRW78HOUKsX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047919; c=relaxed/simple;
	bh=0NYj325MCxYfzA0iMFtFlFNm7KVwpEWpQsm1qEOkdJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lXtGAIbwRn8Jk0J5bjq+0gLYAe6StxeC9L09i2VBew4ewEaBnILgrbUoOVsu53pm1u4Hgsd6NYuhZM1qOkA1THI1YLLsp5JNpLneIUn4NUiHevIjp7BhAArtgi6/kMVYDv2gsVw3q0TRDFYS4DNLjc+KNFaPNsJ1ETaUJf6FDK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZiOS6GD2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZiOS6GD2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1784047914;
	bh=0NYj325MCxYfzA0iMFtFlFNm7KVwpEWpQsm1qEOkdJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZiOS6GD2z8CvGbtL0moHrrPujbDO5n6tgv6RfCwYJrs1wGp6CPFXJIc5ew43nmhV2
	 0to+rX9ljKOqdVHsN/XqIZzsELt5CLzdYptOivPMSQ3cIQ+Nd7lHJF5El9WRcmWJUA
	 SMS1lP7vprHJQLaGAhwBfMpj4StwXZx/qNXkRmpQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 14 Jul 2026 18:51:49 +0200
Subject: [PATCH 2/3] drivers: perf: Use __DEVICE_ATTR() macro to initialize
 dev_ext_attribute
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260714-sysfs-const-attr-dev_ext_attr-v1-2-6b2c0435d621@weissschuh.net>
References: <20260714-sysfs-const-attr-dev_ext_attr-v1-0-6b2c0435d621@weissschuh.net>
In-Reply-To: <20260714-sysfs-const-attr-dev_ext_attr-v1-0-6b2c0435d621@weissschuh.net>
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, 
 Yushan Wang <wangyushan12@huawei.com>, Jijie Shao <shaojijie@huawei.com>, 
 Khuong Dinh <khuong@os.amperecomputing.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-cxl@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, driver-core@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784047913; l=9437;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0NYj325MCxYfzA0iMFtFlFNm7KVwpEWpQsm1qEOkdJ0=;
 b=taFfFE7aDqhB7yKmzGYYYePgDR3Gq0wU8bj7GfGE+vF5SobjgvamevsFQjF1lGuaA4rzQZtbQ
 g8UOoXRQfZaBitkIOv3PDEqpf2XYWku0enMWHxYIssSWEOwfK+bF7zt
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The upcoming constification of the device_show_*() callback
signatures requires the users to handle the transition automatically.

Switch to the __DEVICE_ATTR() macro which can do this.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/perf/arm-cci.c                      |  2 +-
 drivers/perf/arm-ccn.c                      |  2 +-
 drivers/perf/arm_cspmu/arm_cspmu.h          |  2 +-
 drivers/perf/arm_dsu_pmu.c                  |  2 +-
 drivers/perf/cxl_pmu.c                      | 10 +++++-----
 drivers/perf/fujitsu_uncore_pmu.c           |  2 +-
 drivers/perf/hisilicon/hisi_pcie_pmu.c      |  2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h    |  6 +++---
 drivers/perf/hisilicon/hns3_pmu.c           |  6 +++---
 drivers/perf/nvidia_t410_c2c_pmu.c          |  2 +-
 drivers/perf/nvidia_t410_cmem_latency_pmu.c | 12 ++++++------
 drivers/perf/qcom_l3_pmu.c                  |  8 ++++----
 drivers/perf/xgene_pmu.c                    |  2 +-
 13 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 1cc3214d6b6d..374a00ae4e48 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -132,7 +132,7 @@ static ssize_t __maybe_unused cci_pmu_event_show(struct device *dev,
 
 #define CCI_EXT_ATTR_ENTRY(_name, _func, _config) 				\
 	&((struct dev_ext_attribute[]) {					\
-		{ __ATTR(_name, S_IRUGO, _func, NULL), (void *)_config }	\
+		{ __DEVICE_ATTR(_name, S_IRUGO, _func, NULL), (void *)_config }	\
 	})[0].attr.attr
 
 #define CCI_FORMAT_EXT_ATTR_ENTRY(_name, _config) \
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 8af3563fdf60..955cb5c2b77b 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -217,7 +217,7 @@ static void arm_ccn_pmu_config_set(u64 *config, u32 node_xp, u32 type, u32 port)
 
 #define CCN_FORMAT_ATTR(_name, _config) \
 	struct dev_ext_attribute arm_ccn_pmu_format_attr_##_name = \
-			{ __ATTR(_name, S_IRUGO, device_show_string, \
+			{ __DEVICE_ATTR(_name, S_IRUGO, device_show_string, \
 			NULL), _config }
 
 static CCN_FORMAT_ATTR(node, "config:0-7");
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index 3fc5c8d77266..841b04ea02a4 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -23,7 +23,7 @@
 #define ARM_CSPMU_EXT_ATTR(_name, _func, _config)			\
 	(&((struct dev_ext_attribute[]){				\
 		{							\
-			.attr = __ATTR(_name, 0444, _func, NULL),	\
+			.attr = __DEVICE_ATTR(_name, 0444, _func, NULL),\
 			.var = (void *)_config				\
 		}							\
 	})[0].attr.attr)
diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 32b0dd7c693b..1d7def95645f 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -69,7 +69,7 @@
 #define DSU_EXT_ATTR(_name, _func, _config)		\
 	(&((struct dev_ext_attribute[]) {				\
 		{							\
-			.attr = __ATTR(_name, 0444, _func, NULL),	\
+			.attr = __DEVICE_ATTR(_name, 0444, _func, NULL),\
 			.var = (void *)_config				\
 		}							\
 	})[0].attr.attr)
diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 68a54d97d2a8..4ab3360a9004 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -209,11 +209,11 @@ static int cxl_pmu_parse_caps(struct device *dev, struct cxl_pmu_info *info)
 }
 
 #define CXL_PMU_FORMAT_ATTR(_name, _format)\
-	(&((struct dev_ext_attribute[]) {					\
-		{								\
-			.attr = __ATTR(_name, 0444, device_show_string, NULL),	\
-			.var = (void *)_format					\
-		}								\
+	(&((struct dev_ext_attribute[]) {						\
+		{									\
+			.attr = __DEVICE_ATTR(_name, 0444, device_show_string, NULL),	\
+			.var = (void *)_format						\
+		}									\
 		})[0].attr.attr)
 
 enum {
diff --git a/drivers/perf/fujitsu_uncore_pmu.c b/drivers/perf/fujitsu_uncore_pmu.c
index c3c6f56474ad..b83fdaf59324 100644
--- a/drivers/perf/fujitsu_uncore_pmu.c
+++ b/drivers/perf/fujitsu_uncore_pmu.c
@@ -292,7 +292,7 @@ static void fujitsu_uncore_event_read(struct perf_event *event)
 
 #define UNCORE_PMU_FORMAT_ATTR(_name, _config)				      \
 	(&((struct dev_ext_attribute[]) {				      \
-		{ .attr = __ATTR(_name, 0444, device_show_string, NULL),      \
+		{ .attr = __DEVICE_ATTR(_name, 0444, device_show_string, NULL), \
 		  .var = (void *)_config, }				      \
 	})[0].attr.attr)
 
diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index c5394d007b61..2dc19b7c8cbf 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -110,7 +110,7 @@ static ssize_t hisi_pcie_event_sysfs_show(struct device *dev, struct device_attr
 
 #define HISI_PCIE_PMU_FORMAT_ATTR(_name, _format)                              \
 	(&((struct dev_ext_attribute[]){                                       \
-		{ .attr = __ATTR(_name, 0444, device_show_string, NULL),       \
+		{ .attr = __DEVICE_ATTR(_name, 0444, device_show_string, NULL),\
 		  .var = (void *)_format }                                     \
 	})[0].attr.attr)
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index 3ffe6acda653..a4cb9ed7ea20 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -27,9 +27,9 @@
 #define HISI_MAX_COUNTERS	0x18
 #define to_hisi_pmu(p)	(container_of(p, struct hisi_pmu, pmu))
 
-#define HISI_PMU_ATTR(_name, _func, _config)				\
-	(&((struct dev_ext_attribute[]) {				\
-		{ __ATTR(_name, 0444, _func, NULL), (void *)_config }   \
+#define HISI_PMU_ATTR(_name, _func, _config)				     \
+	(&((struct dev_ext_attribute[]) {				     \
+		{ __DEVICE_ATTR(_name, 0444, _func, NULL), (void *)_config } \
 	})[0].attr.attr)
 
 #define HISI_PMU_FORMAT_ATTR(_name, _config)		\
diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
index c157f3572cae..88a1129e9b90 100644
--- a/drivers/perf/hisilicon/hns3_pmu.c
+++ b/drivers/perf/hisilicon/hns3_pmu.c
@@ -405,9 +405,9 @@ static ssize_t hns3_pmu_filter_mode_show(struct device *dev,
 	return len;
 }
 
-#define HNS3_PMU_ATTR(_name, _func, _config)				\
-	(&((struct dev_ext_attribute[]) {				\
-		{ __ATTR(_name, 0444, _func, NULL), (void *)_config }	\
+#define HNS3_PMU_ATTR(_name, _func, _config)				     \
+	(&((struct dev_ext_attribute[]) {				     \
+		{ __DEVICE_ATTR(_name, 0444, _func, NULL), (void *)_config } \
 	})[0].attr.attr)
 
 #define HNS3_PMU_FORMAT_ATTR(_name, _format) \
diff --git a/drivers/perf/nvidia_t410_c2c_pmu.c b/drivers/perf/nvidia_t410_c2c_pmu.c
index 411987153ff3..930cb3e8aad2 100644
--- a/drivers/perf/nvidia_t410_c2c_pmu.c
+++ b/drivers/perf/nvidia_t410_c2c_pmu.c
@@ -545,7 +545,7 @@ static struct attribute_group nv_c2c_pmu_peer_attr_group = {
 #define NV_C2C_PMU_EXT_ATTR(_name, _func, _config)			\
 	(&((struct dev_ext_attribute[]){				\
 		{							\
-			.attr = __ATTR(_name, 0444, _func, NULL),	\
+			.attr = __DEVICE_ATTR(_name, 0444, _func, NULL),\
 			.var = (void *)_config				\
 		}							\
 	})[0].attr.attr)
diff --git a/drivers/perf/nvidia_t410_cmem_latency_pmu.c b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
index acb8f5571522..d6e02b70a7cf 100644
--- a/drivers/perf/nvidia_t410_cmem_latency_pmu.c
+++ b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
@@ -435,12 +435,12 @@ static struct attribute_group cmem_lat_pmu_identifier_attr_group = {
 
 /* Format attributes. */
 
-#define NV_PMU_EXT_ATTR(_name, _func, _config)			\
-	(&((struct dev_ext_attribute[]){				\
-		{							\
-			.attr = __ATTR(_name, 0444, _func, NULL),	\
-			.var = (void *)_config				\
-		}							\
+#define NV_PMU_EXT_ATTR(_name, _func, _config)					\
+	(&((struct dev_ext_attribute[]){					\
+		{								\
+			.attr = __DEVICE_ATTR(_name, 0444, _func, NULL),	\
+			.var = (void *)_config					\
+		}								\
 	})[0].attr.attr)
 
 static struct attribute *cmem_lat_pmu_formats[] = {
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 66e6cabd6fff..d5aa6ace847a 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -609,10 +609,10 @@ static void qcom_l3_cache__event_read(struct perf_event *event)
 
 /* formats */
 
-#define L3CACHE_PMU_FORMAT_ATTR(_name, _config)				      \
-	(&((struct dev_ext_attribute[]) {				      \
-		{ .attr = __ATTR(_name, 0444, device_show_string, NULL),      \
-		  .var = (void *) _config, }				      \
+#define L3CACHE_PMU_FORMAT_ATTR(_name, _config)				        \
+	(&((struct dev_ext_attribute[]) {				        \
+		{ .attr = __DEVICE_ATTR(_name, 0444, device_show_string, NULL), \
+		  .var = (void *) _config, }				        \
 	})[0].attr.attr)
 
 static struct attribute *qcom_l3_cache_pmu_formats[] = {
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 33b5497bdc06..3f23611fd4c7 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -164,7 +164,7 @@ enum xgene_pmu_dev_type {
  */
 #define XGENE_PMU_FORMAT_ATTR(_name, _config)		\
 	(&((struct dev_ext_attribute[]) {		\
-		{ .attr = __ATTR(_name, S_IRUGO, device_show_string, NULL), \
+		{ .attr = __DEVICE_ATTR(_name, S_IRUGO, device_show_string, NULL), \
 		  .var = (void *) _config, }		\
 	})[0].attr.attr)
 

-- 
2.55.0

