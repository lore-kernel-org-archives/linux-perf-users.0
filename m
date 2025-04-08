Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF45269819
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Apr 2025 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115288; cv=none; b=mua7puzm827EGIMr8fhn6ZS7t9z2IvdwtNpooGaIxs5GT/A3dcUKRmxdHdblrAg+8F8j/l8HRzLWCJ9L8OxyIglyBcNayFPZlicP5SIowuOrdadej7LFIq9tUWKMGnIOPs2s19lJj6KnY7lYZh7ic/S4LyKPC5kaSMdjjylLOwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115288; c=relaxed/simple;
	bh=adCZ9gKB+ucXpON0o1JYjAE2Vhz5Zs1rncxwb2pf0EE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RQTxsWNL6B4Fed4n0t5tunBDlXf/j+QRV3jsNkUCK/ZiXBFcV9sLX6Gw2vrv+dqhD/T/jazpVakDNjtzujFpd9CI1J98Tg8vT03++yf4iwrZNmlac/k8v4by+w0KcrK7a0daABlB9oY2GhRbUp3KkzlyDB398aNhz5znA6a2VkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZX4yB0QwbzCsDR;
	Tue,  8 Apr 2025 20:24:18 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id BC8E11400DC;
	Tue,  8 Apr 2025 20:28:02 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 8 Apr 2025 20:28:01 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <acme@kernel.org>, <namhyung@kernel.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<mark.rutland@arm.com>, <jolsa@kernel.org>, <john.g.garry@oracle.com>,
	<james.clark@linaro.org>, <leo.yan@linux.dev>, <irogers@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <hejunhao3@huawei.com>,
	<linuxarm@huawei.com>, <wangyushan12@huawei.com>, <caijingtao@huawei.com>,
	<xueshan2@huawei.com>, <prime.zeng@hisilicon.com>, <yangyicong@hisilicon.com>
Subject: [PATCH] perf arm-spe: Add support for SPE Data Source packet on HiSilicon HIP12
Date: Tue, 8 Apr 2025 20:28:09 +0800
Message-ID: <20250408122809.37884-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

Add data source encoding for HiSilicon HIP12 and coresponding mapping
to the perf's memory data source. This will help to synthesize the data
and support upper layer tools like perf-mem and perf-c2c.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 arch/arm64/include/asm/cputype.h              |   2 +
 tools/arch/arm64/include/asm/cputype.h        |   2 +
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  17 +++
 tools/perf/util/arm-spe.c                     | 101 ++++++++++++++++++
 4 files changed, 122 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index d1cc0571798b..36c5bbfbb6e9 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -133,6 +133,7 @@
 
 #define HISI_CPU_PART_TSV110		0xD01
 #define HISI_CPU_PART_HIP09			0xD02
+#define HISI_CPU_PART_HIP12		0xD06
 
 #define APPLE_CPU_PART_M1_ICESTORM	0x022
 #define APPLE_CPU_PART_M1_FIRESTORM	0x023
@@ -220,6 +221,7 @@
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
 #define MIDR_HISI_HIP09 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP09)
+#define MIDR_HISI_HIP12 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP12)
 #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
 #define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
 #define MIDR_APPLE_M1_ICESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_PRO)
diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 488f8e751349..9a5d85cfd1fb 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -129,6 +129,7 @@
 #define FUJITSU_CPU_PART_A64FX		0x001
 
 #define HISI_CPU_PART_TSV110		0xD01
+#define HISI_CPU_PART_HIP12		0xD06
 
 #define APPLE_CPU_PART_M1_ICESTORM	0x022
 #define APPLE_CPU_PART_M1_FIRESTORM	0x023
@@ -202,6 +203,7 @@
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
+#define MIDR_HISI_HIP12 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP12)
 #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
 #define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
 #define MIDR_APPLE_M1_ICESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_PRO)
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 5d232188643b..0410abed5009 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -82,6 +82,23 @@ enum arm_spe_ampereone_data_source {
 	ARM_SPE_AMPEREONE_L2D                           = 0x9,
 };
 
+enum arm_spe_hisi_hip_data_source {
+	ARM_SPE_HISI_HIP_PEER_CPU		= 0,
+	ARM_SPE_HISI_HIP_PEER_CPU_HITM		= 1,
+	ARM_SPE_HISI_HIP_L3			= 2,
+	ARM_SPE_HISI_HIP_L3_HITM		= 3,
+	ARM_SPE_HISI_HIP_PEER_CLUSTER		= 4,
+	ARM_SPE_HISI_HIP_PEER_CLUSTER_HITM	= 5,
+	ARM_SPE_HISI_HIP_REMOTE_SOCKET		= 6,
+	ARM_SPE_HISI_HIP_REMOTE_SOCKET_HITM	= 7,
+	ARM_SPE_HISI_HIP_LOCAL			= 8,
+	ARM_SPE_HISI_HIP_REMOTE			= 9,
+	ARM_SPE_HISI_HIP_NC_DEV			= 13,
+	ARM_SPE_HISI_HIP_L2			= 16,
+	ARM_SPE_HISI_HIP_L2_HITM		= 17,
+	ARM_SPE_HISI_HIP_L1			= 18,
+};
+
 struct arm_spe_record {
 	enum arm_spe_sample_type type;
 	int err;
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 2a9775649cc2..eceae4219601 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -571,6 +571,11 @@ static const struct midr_range ampereone_ds_encoding_cpus[] = {
 	{},
 };
 
+static const struct midr_range hisi_hip_ds_encoding_cpus[] = {
+	MIDR_ALL_VERSIONS(MIDR_HISI_HIP12),
+	{},
+};
+
 static void arm_spe__sample_flags(struct arm_spe_queue *speq)
 {
 	const struct arm_spe_record *record = &speq->decoder->record;
@@ -718,9 +723,105 @@ static void arm_spe__synth_data_source_ampereone(const struct arm_spe_record *re
 	arm_spe__synth_data_source_common(&common_record, data_src);
 }
 
+static void arm_spe__synth_data_source_hisi_hip(const struct arm_spe_record *record,
+						union perf_mem_data_src *data_src)
+{
+	/* Use common synthesis method to handle store operations */
+	if (record->op & ARM_SPE_OP_ST) {
+		arm_spe__synth_data_source_common(record, data_src);
+		return;
+	}
+
+	switch (record->source) {
+	case ARM_SPE_HISI_HIP_PEER_CPU:
+		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
+		break;
+	case ARM_SPE_HISI_HIP_PEER_CPU_HITM:
+		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
+		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
+		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
+		break;
+	case ARM_SPE_HISI_HIP_L3:
+		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		break;
+	case ARM_SPE_HISI_HIP_L3_HITM:
+		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
+		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
+		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
+		break;
+	case ARM_SPE_HISI_HIP_PEER_CLUSTER:
+		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
+		break;
+	case ARM_SPE_HISI_HIP_PEER_CLUSTER_HITM:
+		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
+		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
+		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
+		break;
+	case ARM_SPE_HISI_HIP_REMOTE_SOCKET:
+		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
+		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
+		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
+		break;
+	case ARM_SPE_HISI_HIP_REMOTE_SOCKET_HITM:
+		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
+		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
+		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
+		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
+		break;
+	case ARM_SPE_HISI_HIP_LOCAL:
+		data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		break;
+	case ARM_SPE_HISI_HIP_REMOTE:
+		data_src->mem_lvl = PERF_MEM_LVL_REM_RAM1 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
+		break;
+	case ARM_SPE_HISI_HIP_NC_DEV:
+		data_src->mem_lvl = PERF_MEM_LVL_IO | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_IO;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		break;
+	case ARM_SPE_HISI_HIP_L2:
+		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		break;
+	case ARM_SPE_HISI_HIP_L2_HITM:
+		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
+		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
+		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
+		break;
+	case ARM_SPE_HISI_HIP_L1:
+		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		break;
+	default:
+		break;
+	}
+}
+
 static const struct data_source_handle data_source_handles[] = {
 	DS(common_ds_encoding_cpus, data_source_common),
 	DS(ampereone_ds_encoding_cpus, data_source_ampereone),
+	DS(hisi_hip_ds_encoding_cpus, data_source_hisi_hip),
 };
 
 static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
-- 
2.24.0

