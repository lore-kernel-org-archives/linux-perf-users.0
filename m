Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13411C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 19:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7E1611CE
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 19:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhIJT3m (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 15:29:42 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29550 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhIJT3f (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 15:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631302102; x=1662838102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DuPSUb7mLjAKpGhZiKY+keHuZZBigTliJx8ob9s9tVI=;
  b=Lv90YRnbFNqBTy/d+v8M97z+LGDt/xv8IpFJFyyV/ktmg9T7bHdVUWvi
   i12luILx/B4TMTcWWpPO3jVhG9xOxpfpPci7hxySJnGjIYmUUlnhK37dA
   xWRSQyXEbVKOus8FO83KnW9ggpfkH45C553hKLnDCjw2QPtlQ8w6G9tO6
   hrK7AmwkJh6+zvHvO1IJk9lRI1F9fnqzPPQ4DihSWhRvwqHLqWCp6r0q7
   BEQ9Idd0jVzk+xrV2jBwP6JkVR8ou1cQSY3h6PpOEsKsAuqEt+A8A7bbQ
   RGXRyAK7g7FfNNEzxZsS6s3SXH6r8HcZ1NReCvtXr6yy9WAjtqjTt/8E0
   A==;
X-IronPort-AV: E=Sophos;i="5.85,283,1624291200"; 
   d="scan'208";a="179706174"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2021 03:28:21 +0800
IronPort-SDR: 1/ArfjTlZsj/8ND1JGbjuvqRPCWRsyeiaCfsoYzv9A0h+f7hQ7sTGolyz2gPMIS3PU/cA1bpTn
 qrPeaamGGJw6Ioiz4Sukml6Xtx8QcUHyqdd07eo2WuCfKEFEU29T1HHEOcotOhj3OUEVK1RV/w
 Sx+YkY1ZplMNbvVCsqOo8RQ30QZNGDi39FDesrdcFjXpGHAjK3r6rwO9ll3KFQgkBgvY69lRSh
 IK5P7IBOrIxP+psZyuFBdaGjH4YDl8XR5PVdOjj+o2bQmPYKVpMWUcVDr9BDYShfxyiJL/Rcq9
 dNap8At2C1Yvr+3V+I0ZpH5w
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 12:03:16 -0700
IronPort-SDR: OYqyMHxLuMKu+NMchYR7Gpj/GvrhIsk6A2Ls4rkZESYhFgSlmyEn5MfGjSwW89d3qMiRzeE61N
 gZuPL9BB7yPRoC/IBTDoS/oShs/Rqb/icNuDvJntUahmlo+NtSpA0pUOU56cJ3GHUOlH39FHW0
 gcn5tq+t3NaUTn3Z91yfsXsIa5U8NJUd8ZnwJHrGdkfP7bU3rJ6Nkhhp5rCwyLBM54mzXJAmFX
 ymm2Om8x7ootf9FiRP9SkUAN/+d16KKXY+3cO2QXdMguk8T0tWI7t+xb5zNN45Cw07Rm3L7JDq
 pTY=
WDCIronportException: Internal
Received: from unknown (HELO hulk.wdc.com) ([10.225.167.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2021 12:28:22 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, devicetree@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [v3 05/10] RISC-V: Add RISC-V SBI PMU extension definitions
Date:   Fri, 10 Sep 2021 12:27:52 -0700
Message-Id: <20210910192757.2309100-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210910192757.2309100-1-atish.patra@wdc.com>
References: <20210910192757.2309100-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds all the definitions defined by the SBI PMU extension.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/sbi.h | 97 ++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 0d42693cb65e..7a14ca06ba8f 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -27,6 +27,7 @@ enum sbi_ext_id {
 	SBI_EXT_IPI = 0x735049,
 	SBI_EXT_RFENCE = 0x52464E43,
 	SBI_EXT_HSM = 0x48534D,
+	SBI_EXT_PMU = 0x504D55,
 };
 
 enum sbi_ext_base_fid {
@@ -70,6 +71,99 @@ enum sbi_hsm_hart_status {
 	SBI_HSM_HART_STATUS_STOP_PENDING,
 };
 
+
+enum sbi_ext_pmu_fid {
+	SBI_EXT_PMU_NUM_COUNTERS = 0,
+	SBI_EXT_PMU_COUNTER_GET_INFO,
+	SBI_EXT_PMU_COUNTER_CFG_MATCH,
+	SBI_EXT_PMU_COUNTER_START,
+	SBI_EXT_PMU_COUNTER_STOP,
+	SBI_EXT_PMU_COUNTER_FW_READ,
+};
+
+#define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(55, 0)
+#define RISCV_PMU_RAW_EVENT_IDX 0x20000
+
+/** General pmu event codes specified in SBI PMU extension */
+enum sbi_pmu_hw_generic_events_t {
+	SBI_PMU_HW_NO_EVENT			= 0,
+	SBI_PMU_HW_CPU_CYCLES			= 1,
+	SBI_PMU_HW_INSTRUCTIONS			= 2,
+	SBI_PMU_HW_CACHE_REFERENCES		= 3,
+	SBI_PMU_HW_CACHE_MISSES			= 4,
+	SBI_PMU_HW_BRANCH_INSTRUCTIONS		= 5,
+	SBI_PMU_HW_BRANCH_MISSES		= 6,
+	SBI_PMU_HW_BUS_CYCLES			= 7,
+	SBI_PMU_HW_STALLED_CYCLES_FRONTEND	= 8,
+	SBI_PMU_HW_STALLED_CYCLES_BACKEND	= 9,
+	SBI_PMU_HW_REF_CPU_CYCLES		= 10,
+
+	SBI_PMU_HW_GENERAL_MAX,
+};
+
+/**
+ * Special "firmware" events provided by the firmware, even if the hardware
+ * does not support performance events. These events are encoded as a raw
+ * event type in Linux kernel perf framework.
+ */
+enum sbi_pmu_fw_generic_events_t {
+	SBI_PMU_FW_MISALIGNED_LOAD	= 0,
+	SBI_PMU_FW_MISALIGNED_STORE	= 1,
+	SBI_PMU_FW_ACCESS_LOAD		= 2,
+	SBI_PMU_FW_ACCESS_STORE		= 3,
+	SBI_PMU_FW_ILLEGAL_INSN		= 4,
+	SBI_PMU_FW_SET_TIMER		= 5,
+	SBI_PMU_FW_IPI_SENT		= 6,
+	SBI_PMU_FW_IPI_RECVD		= 7,
+	SBI_PMU_FW_FENCE_I_SENT		= 8,
+	SBI_PMU_FW_FENCE_I_RECVD	= 9,
+	SBI_PMU_FW_SFENCE_VMA_SENT	= 10,
+	SBI_PMU_FW_SFENCE_VMA_RCVD	= 11,
+	SBI_PMU_FW_SFENCE_VMA_ASID_SENT	= 12,
+	SBI_PMU_FW_SFENCE_VMA_ASID_RCVD	= 13,
+
+	SBI_PMU_FW_HFENCE_GVMA_SENT	= 14,
+	SBI_PMU_FW_HFENCE_GVMA_RCVD	= 15,
+	SBI_PMU_FW_HFENCE_GVMA_VMID_SENT = 16,
+	SBI_PMU_FW_HFENCE_GVMA_VMID_RCVD = 17,
+
+	SBI_PMU_FW_HFENCE_VVMA_SENT	= 18,
+	SBI_PMU_FW_HFENCE_VVMA_RCVD	= 19,
+	SBI_PMU_FW_HFENCE_VVMA_ASID_SENT = 20,
+	SBI_PMU_FW_HFENCE_VVMA_ASID_RCVD = 21,
+	SBI_PMU_FW_MAX,
+};
+
+/* SBI PMU event types */
+enum sbi_pmu_event_type {
+	SBI_PMU_EVENT_TYPE_HW = 0x0,
+	SBI_PMU_EVENT_TYPE_CACHE = 0x1,
+	SBI_PMU_EVENT_TYPE_RAW = 0x2,
+	SBI_PMU_EVENT_TYPE_FW = 0xf,
+};
+
+/* SBI PMU event types */
+enum sbi_pmu_ctr_type {
+	SBI_PMU_CTR_TYPE_HW = 0x0,
+	SBI_PMU_CTR_TYPE_FW,
+};
+
+/* Flags defined for config matching function */
+#define SBI_PMU_CFG_FLAG_SKIP_MATCH	(1 << 0)
+#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	(1 << 1)
+#define SBI_PMU_CFG_FLAG_AUTO_START	(1 << 2)
+#define SBI_PMU_CFG_FLAG_SET_MINH	(1 << 3)
+#define SBI_PMU_CFG_FLAG_SET_SINH	(1 << 4)
+#define SBI_PMU_CFG_FLAG_SET_UINH	(1 << 5)
+#define SBI_PMU_CFG_FLAG_SET_VSINH	(1 << 6)
+#define SBI_PMU_CFG_FLAG_SET_VUINH	(1 << 7)
+
+/* Flags defined for counter start function */
+#define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
+
+/* Flags defined for counter stop function */
+#define SBI_PMU_STOP_FLAG_RESET (1 << 0)
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
@@ -82,6 +176,9 @@ enum sbi_hsm_hart_status {
 #define SBI_ERR_INVALID_PARAM	-3
 #define SBI_ERR_DENIED		-4
 #define SBI_ERR_INVALID_ADDRESS	-5
+#define SBI_ERR_ALREADY_AVAILABLE -6
+#define SBI_ERR_ALREADY_STARTED -7
+#define SBI_ERR_ALREADY_STOPPED -8
 
 extern unsigned long sbi_spec_version;
 struct sbiret {
-- 
2.31.1

