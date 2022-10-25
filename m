Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3537C38A2D
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 Oct 2022 11:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJYLHO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 Oct 2022 07:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJYLHN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 Oct 2022 07:07:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB4F188AAD
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Oct 2022 04:07:12 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MxTfV2DxQzHvDd;
        Tue, 25 Oct 2022 19:06:58 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 19:07:10 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        <linux-perf-users@vger.kernel.org>
CC:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <liuqi6124@gmail.com>, <jonathan.cameron@huawei.com>,
        <alexander.shishkin@linux.intel.com>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>
Subject: [PATCH 1/2] perf tool: move unit macros to kernel.h
Date:   Tue, 25 Oct 2022 19:06:33 +0800
Message-ID: <20221025110634.45405-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221025110634.45405-1-yangyicong@huawei.com>
References: <20221025110634.45405-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

Unit macros like MiB/KiB are defined separately in several places:

$ egrep -rn "#define MiB|#define KiB" ./
./arch/arm64/util/hisi-ptt.c:27:#define KiB(x) ((x) * 1024)
./arch/arm64/util/hisi-ptt.c:28:#define MiB(x) ((x) * 1024 * 1024)
./arch/arm64/util/arm-spe.c:28:#define KiB(x) ((x) * 1024)
./arch/arm64/util/arm-spe.c:29:#define MiB(x) ((x) * 1024 * 1024)
./arch/x86/util/intel-bts.c:28:#define KiB(x) ((x) * 1024)
./arch/x86/util/intel-bts.c:29:#define MiB(x) ((x) * 1024 * 1024)
./arch/x86/util/intel-bts.c:30:#define KiB_MASK(x) (KiB(x) - 1)
./arch/x86/util/intel-bts.c:31:#define MiB_MASK(x) (MiB(x) - 1)
./arch/x86/util/intel-pt.c:36:#define KiB(x) ((x) * 1024)
./arch/x86/util/intel-pt.c:37:#define MiB(x) ((x) * 1024 * 1024)
./arch/x86/util/intel-pt.c:38:#define KiB_MASK(x) (KiB(x) - 1)
./arch/x86/util/intel-pt.c:39:#define MiB_MASK(x) (MiB(x) - 1)
./util/cs-etm.h:188:#define KiB(x) ((x) * 1024)
./util/cs-etm.h:189:#define MiB(x) ((x) * 1024 * 1024)

Move them to a common place to avoid duplicated definition.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 tools/include/linux/kernel.h          | 5 +++++
 tools/perf/arch/arm64/util/arm-spe.c  | 3 ---
 tools/perf/arch/arm64/util/hisi-ptt.c | 3 ---
 tools/perf/arch/x86/util/intel-bts.c  | 5 -----
 tools/perf/arch/x86/util/intel-pt.c   | 5 -----
 tools/perf/util/cs-etm.h              | 3 ---
 6 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 4b0673bf52c2..e03aaa9c8ff1 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -105,4 +105,9 @@ int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
 #define current_gfp_context(k) 0
 #define synchronize_rcu()
 
+#define KiB(x) ((x) * 1024)
+#define MiB(x) ((x) * 1024 * 1024)
+#define KiB_MASK(x) (KiB(x) - 1)
+#define MiB_MASK(x) (MiB(x) - 1)
+
 #endif
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index d4c234076541..8f1ff8b99b7a 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -25,9 +25,6 @@
 #include "../../../util/arm-spe.h"
 #include <tools/libc_compat.h> // reallocarray
 
-#define KiB(x) ((x) * 1024)
-#define MiB(x) ((x) * 1024 * 1024)
-
 struct arm_spe_recording {
 	struct auxtrace_record		itr;
 	struct perf_pmu			*arm_spe_pmu;
diff --git a/tools/perf/arch/arm64/util/hisi-ptt.c b/tools/perf/arch/arm64/util/hisi-ptt.c
index ba97c8a562a0..64e9bb06487a 100644
--- a/tools/perf/arch/arm64/util/hisi-ptt.c
+++ b/tools/perf/arch/arm64/util/hisi-ptt.c
@@ -24,9 +24,6 @@
 #include "../../../util/session.h"
 #include "../../../util/tsc.h"
 
-#define KiB(x) ((x) * 1024)
-#define MiB(x) ((x) * 1024 * 1024)
-
 struct hisi_ptt_recording {
 	struct auxtrace_record	itr;
 	struct perf_pmu *hisi_ptt_pmu;
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 439c2956f3e7..1dded1645287 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -25,11 +25,6 @@
 #include "../../../util/intel-bts.h"
 #include <internal/lib.h> // page_size
 
-#define KiB(x) ((x) * 1024)
-#define MiB(x) ((x) * 1024 * 1024)
-#define KiB_MASK(x) (KiB(x) - 1)
-#define MiB_MASK(x) (MiB(x) - 1)
-
 struct intel_bts_snapshot_ref {
 	void	*ref_buf;
 	size_t	ref_offset;
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index af102f471e9f..963d70b3a008 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -33,11 +33,6 @@
 #include <internal/lib.h> // page_size
 #include "../../../util/intel-pt.h"
 
-#define KiB(x) ((x) * 1024)
-#define MiB(x) ((x) * 1024 * 1024)
-#define KiB_MASK(x) (KiB(x) - 1)
-#define MiB_MASK(x) (MiB(x) - 1)
-
 #define INTEL_PT_PSB_PERIOD_NEAR	256
 
 struct intel_pt_snapshot_ref {
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 90c83f932d9a..d36a0c18ca59 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -185,9 +185,6 @@ struct cs_etm_packet_queue {
 	struct cs_etm_packet packet_buffer[CS_ETM_PACKET_MAX_BUFFER];
 };
 
-#define KiB(x) ((x) * 1024)
-#define MiB(x) ((x) * 1024 * 1024)
-
 #define CS_ETM_INVAL_ADDR 0xdeadbeefdeadbeefUL
 
 #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
-- 
2.24.0

