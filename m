Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D149EC4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B52E161042
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbhHQWNc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:13:32 -0400
Received: from mail-mw2nam08on2057.outbound.protection.outlook.com ([40.107.101.57]:62829
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234860AbhHQWNb (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Aug 2021 18:13:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGcFiHk7Pl/3QLozjzsCCXE7D8qX5pfbp/iR13XgVDoTXCz69YgiVCjGmWT/+x7SMsHgHuAiudkJqRsI6IVEMttZcQZOfzszcOSMYHuxSyOA1tGIyedsc5/52qRZHH9264kfXn4Hoz8RdyaYS1X+RaY67un5GXGLTSdns0UMFu3NOcmvbsggvt2FwmaIrlnLOZGoUBIXkH2cZ5B8F2qi96BWYHQUd4JjQyseKyjk+fh9jCjXoYOkKEZdyNlGoEcnvBCkQkyXaG3YQMqx21itKg3EEHYuOcjRnSGCRdOqVgUE4NmJccADIh/M/3a0qpD5q6w9/xMUo9CfZSPHQmePmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DRtUG3lMpDrdg6AVbogaZedLRDOqCW4PN2bOELirDc=;
 b=fWb7P5SLSkuq7faufmwjDk97RpYDFEul+g8HK4A6UFwU63IvKTxhddyamSK96EAqlsbYzMPdzwXEXKQrePW4WlijX/qWkG/AY5XHuC6/6ScjoRWb3bFplI0dMDbnbVOlXZWljDF5Whd85Szsb6U/k+FzgIqs5dNOoMThydF82JIAtD5GwNRyqTxabeqf9flBThe24S5NPs64H3mL4I7WAf9ek84lmVHphnDJYLjn0EJBJgF6aya2pEMar4khOvSY3LlnVnmCGjMcCdo9zdczN2K+BDiQTMRR0nlK1fJullslnkNkbAsYuuy78ih2o5lNNyzGep6WcT621qCC1YFB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DRtUG3lMpDrdg6AVbogaZedLRDOqCW4PN2bOELirDc=;
 b=HIYFEWNX0HxmWei7YJl2qIa8N8afk2C0yeTxvdIs/ffzwyFf2CmprSfqAgsDN5HHUXycGKwHC/uS7pIKCeHvhWe+Xs1oHPXIWzERr2GqGbu2WQZ/8mYzMSrOjcQtPqwuPwNjr5cOA725D/1Tsdqhent/7nMA0CZQgV9OpWrSqHY=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 22:12:55 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 22:12:55 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kim Phillips <kim.phillips@amd.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ian Rogers <irogers@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH 8/8] perf/x86/amd/ibs: Add bitfield definitions in new header
Date:   Tue, 17 Aug 2021 17:10:48 -0500
Message-Id: <20210817221048.88063-9-kim.phillips@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210817221048.88063-1-kim.phillips@amd.com>
References: <20210817221048.88063-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:805:f2::36) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by SN6PR04CA0095.namprd04.prod.outlook.com (2603:10b6:805:f2::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 22:12:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4a56073-81b5-41e2-a672-08d961cc29e1
X-MS-TrafficTypeDiagnostic: BN8PR12MB3505:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3505C83AAD09A5AB01AA420D87FE9@BN8PR12MB3505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qIMt1VyCL7CUzLhV/Pj8yIqTzJ8XD4o6YNFNAsiOzyrVuq/RrKXsVl2SpbBNAKe0+/TIjOqyUPch4xUHjtiJMFb3zQ+1qH3dNXCrbqsI62Truz9ME36iVt9Aq1GzokoJSutk95Gq+NI7bykCFMhgt10u/E6QIOoaaDuYh3cwInRHPAiSqHIY2ti4LKb/IzD7Sr7mu+U6GJH+c50V/gofxbVAQyCQRdIIZJqRQfrQkJswaaCGZafoi7oRqm7FOkvUxt3XMeh/9u6N9tGuxJ4CEOUQS9GpfaT79BD50VmFAJGWN29fEJ/oYDov+XALQ2Md0T+vLpf90XJNu5yfjeF0xaKvqoJhq+kOsrmYFYLOMyTzg8s1yrEpp2DDhu2HUGUkCG/VbJ8UEuRgcr7BgEYTlume1doUGvigFQzg7HQ+D38lYdEqyYBXB1Z1gQrvhSlvM32Q3o0rhZCMww2iatn+p1VqprD9Ml8nQFsH3U/H9Ps43gPaBUkK145JRZ8g00ubd4nsOIGBwgkBM0j8M+JsP+7+li85hPINEe+DxveWJvzOtzo8fKtMUEU/7N7Ln/jvZOtUquh59OuCQagmIfMzlcE/6nk1l8h+2MWu3TLtfESJwg8ZTRw6ypLHR97t80e8yXN76Reg9JTwrg/Wd5gTbiFDMFuA0tyo3ePLsxpU6n/utmmE0hV4tJ9CuA95LZolT/x8fEBBf2bK7X9zSg29+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(38350700002)(66946007)(52116002)(110136005)(86362001)(54906003)(6486002)(2906002)(66556008)(83380400001)(66476007)(186003)(26005)(7696005)(7049001)(5660300002)(956004)(36756003)(478600001)(8936002)(7416002)(1076003)(6666004)(8676002)(44832011)(4326008)(2616005)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pzRXP4/PUsGV7F85iXRJO4F6qNIISkfxDqCyLqGPFbKdK0jUi+ENL7nxlv2w?=
 =?us-ascii?Q?PbtuRe6xryhamrRQcq/tQR6IsMEelcm4HXMtkOl57JR3CErTqYLXtbTUzbnC?=
 =?us-ascii?Q?JoHCF1ntG9h6R/1rPZVh+t70eccAeI11AZcdiD/bLdMj4ZHPGQiAcXIABYDb?=
 =?us-ascii?Q?UX3detX/HA+f+e33nmxEAxmmX5LVkVlSitmJOrq27qur8M9Q35GtfksRe5jd?=
 =?us-ascii?Q?+S7GcWHn5zOsHnldKPVq1xkOO+r3Jb31r2TGDCnKRz+7Oy9Aw70ZY+SGBggt?=
 =?us-ascii?Q?tOznzySLd4l+WR5C0mA5m9fkh23fbV98IM1/iIjgJXk6xpCI7gpiuiHiwlmt?=
 =?us-ascii?Q?SIJJ+UA+QQMf9kDKiH7XQknlcYkQUJZ45xMcmHkzefno2UfUGd/kH+F0/hBd?=
 =?us-ascii?Q?aD8lVHT+RHsP/XjM4ZQAcrgvRwblImHDu4Hob+eQV/ITGGkqPbGG26dTw+gB?=
 =?us-ascii?Q?vDDgGRIgzmLi8oypWc1VGtM86vHtaolrEVOGzR35xW9K8e84MIRXn/S5Up8W?=
 =?us-ascii?Q?w/DCaI1x5JqoSiqmWJ2Yd8g53cLCP4Iv+PMW8hqkYoNErGxLHVger99PqQoR?=
 =?us-ascii?Q?ip4M/utvgSylwzY3R45Z6BpnMNiMHCY0Nbp9V6dRVcmPggXMePoFgo3lwXIs?=
 =?us-ascii?Q?j28gZvszDQQcvun7Us7u34ZajVDRjZqEDyV4A4hgGeXQDVctFTuPM9wg/IKk?=
 =?us-ascii?Q?IE7UZXJyg7IfiWt4mOCndhlikUFSIg2VU/qi0Mw1NZ7kBuJm4TJQx+lBX9iK?=
 =?us-ascii?Q?W24AkaVIUWxSdcBsjPGH9HIXgl+8hhbjOLMwGbXwMpqR8PeEjeqoL/AxkwmL?=
 =?us-ascii?Q?4noBd4MNcLQ0sQ6js+ZBBIKOUITbTL/jJuGr74RMAqqGKrVihHUR7kePECXE?=
 =?us-ascii?Q?kgrv1JSoZVec3ERHEHKbRA+0Bwj/vZc79da3HSLi5MELoF4eHmUJ8WmgJZ80?=
 =?us-ascii?Q?oP+9CR+N9eBdZ160ONIeecBjdSQCizM6EjNIEz/B6gy2JtLsq/1oOoaXesd+?=
 =?us-ascii?Q?lIPXHhgwEMjAkFQoRqtPfOdVjSdRBeIZCR5ADD5Kj4ss93PprMBCsGrZaaAI?=
 =?us-ascii?Q?oEB9eUrHKlMA+GS8RZWdcX6FNnAEnw5uTk50e9J+MEuKhdKxmIEz3TOIAYyt?=
 =?us-ascii?Q?EmTAlQuJ7s1Kd2dG7+4ECvjH/T3KFomJ0FSx29AyFuK37cUBaOIN32alRLUX?=
 =?us-ascii?Q?iZhZ8/xneHVUriHAyCSIdGlvTQ6+aT/czt5wsw+irKBCjS8SNfa+eItJtEiz?=
 =?us-ascii?Q?qeGiO4R55ktY62T2wCyX8T9Fx5cGehkK3LoMgKciIQkRv4cdSaJ53mxQ6Kon?=
 =?us-ascii?Q?a4h1cYAFYpHKlCSz3J39rZBi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a56073-81b5-41e2-a672-08d961cc29e1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 22:12:55.5231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HeZvCsqkDuPdiAr9DvwTFggEZd1PRaPKcYc0vELHbnlGQEPvXJwULZfT0Ujm53lhkV7UYVIPr9dqKMmZlzzPWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3505
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add arch/x86/include/asm/amd-ibs.h with bitfield definitions for
IBS MSRs, and demonstrate usage within the driver.

Also move struct perf_ibs_data where it can be shared with
the perf tool that will soon be using it.

No functional changes.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <robert.richter@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: x86@kernel.org
---
 arch/x86/events/amd/ibs.c      |  23 +++---
 arch/x86/include/asm/amd-ibs.h | 132 +++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+), 14 deletions(-)
 create mode 100644 arch/x86/include/asm/amd-ibs.h

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 222c890527a2..4fc85cdaa27a 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -26,6 +26,7 @@ static u32 ibs_caps;
 #include <linux/hardirq.h>
 
 #include <asm/nmi.h>
+#include <asm/amd-ibs.h>
 
 #define IBS_FETCH_CONFIG_MASK	(IBS_FETCH_RAND_EN | IBS_FETCH_MAX_CNT)
 #define IBS_OP_CONFIG_MASK	IBS_OP_MAX_CNT
@@ -100,15 +101,6 @@ struct perf_ibs {
 	u64				(*get_count)(u64 config);
 };
 
-struct perf_ibs_data {
-	u32		size;
-	union {
-		u32	data[0];	/* data buffer starts here */
-		u32	caps;
-	};
-	u64		regs[MSR_AMD64_IBS_REG_COUNT_MAX];
-};
-
 static int
 perf_event_set_period(struct hw_perf_event *hwc, u64 min, u64 max, u64 *hw_period)
 {
@@ -329,11 +321,14 @@ static int perf_ibs_set_period(struct perf_ibs *perf_ibs,
 
 static u64 get_ibs_fetch_count(u64 config)
 {
-	return (config & IBS_FETCH_CNT) >> 12;
+	union ibs_fetch_ctl fetch_ctl = (union ibs_fetch_ctl)config;
+
+	return fetch_ctl.fetch_cnt << 4;
 }
 
 static u64 get_ibs_op_count(u64 config)
 {
+	union ibs_op_ctl op_ctl = (union ibs_op_ctl)config;
 	u64 count = 0;
 
 	/*
@@ -341,12 +336,12 @@ static u64 get_ibs_op_count(u64 config)
 	 * and the lower 7 bits of CurCnt are randomized.
 	 * Otherwise CurCnt has the full 27-bit current counter value.
 	 */
-	if (config & IBS_OP_VAL) {
-		count = (config & IBS_OP_MAX_CNT) << 4;
+	if (op_ctl.op_val) {
+		count = op_ctl.opmaxcnt << 4;
 		if (ibs_caps & IBS_CAPS_OPCNTEXT)
-			count += config & IBS_OP_MAX_CNT_EXT_MASK;
+			count += op_ctl.opmaxcnt_ext << 20;
 	} else if (ibs_caps & IBS_CAPS_RDWROPCNT) {
-		count = (config & IBS_OP_CUR_CNT) >> 32;
+		count = op_ctl.opcurcnt;
 	}
 
 	return count;
diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
new file mode 100644
index 000000000000..46e1df45efc0
--- /dev/null
+++ b/arch/x86/include/asm/amd-ibs.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * From PPR Vol 1 for AMD Family 19h Model 01h B1
+ * 55898 Rev 0.35 - Feb 5, 2021
+ */
+
+#include <asm/msr-index.h>
+
+/*
+ * IBS Hardware MSRs
+ */
+
+/* MSR 0xc0011030: IBS Fetch Control */
+union ibs_fetch_ctl {
+	__u64 val;
+	struct {
+		__u64	fetch_maxcnt:16,/* 0-15: instruction fetch max. count */
+			fetch_cnt:16,	/* 16-31: instruction fetch count */
+			fetch_lat:16,	/* 32-47: instruction fetch latency */
+			fetch_en:1,	/* 48: instruction fetch enable */
+			fetch_val:1,	/* 49: instruction fetch valid */
+			fetch_comp:1,	/* 50: instruction fetch complete */
+			ic_miss:1,	/* 51: i-cache miss */
+			phy_addr_valid:1,/* 52: physical address valid */
+			l1tlb_pgsz:2,	/* 53-54: i-cache L1TLB page size
+					 *	  (needs IbsPhyAddrValid) */
+			l1tlb_miss:1,	/* 55: i-cache fetch missed in L1TLB */
+			l2tlb_miss:1,	/* 56: i-cache fetch missed in L2TLB */
+			rand_en:1,	/* 57: random tagging enable */
+			fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
+					 *      (needs IbsFetchComp) */
+			reserved:5;	/* 59-63: reserved */
+	};
+};
+
+/* MSR 0xc0011033: IBS Execution Control */
+union ibs_op_ctl {
+	__u64 val;
+	struct {
+		__u64	opmaxcnt:16,	/* 0-15: periodic op max. count */
+			reserved0:1,	/* 16: reserved */
+			op_en:1,	/* 17: op sampling enable */
+			op_val:1,	/* 18: op sample valid */
+			cnt_ctl:1,	/* 19: periodic op counter control */
+			opmaxcnt_ext:7,	/* 20-26: upper 7 bits of periodic op maximum count */
+			reserved1:5,	/* 27-31: reserved */
+			opcurcnt:27,	/* 32-58: periodic op counter current count */
+			reserved2:5;	/* 59-63: reserved */
+	};
+};
+
+/* MSR 0xc0011035: IBS Op Data 2 */
+union ibs_op_data {
+	__u64 val;
+	struct {
+		__u64	comp_to_ret_ctr:16,	/* 0-15: op completion to retire count */
+			tag_to_ret_ctr:16,	/* 15-31: op tag to retire count */
+			reserved1:2,		/* 32-33: reserved */
+			op_return:1,		/* 34: return op */
+			op_brn_taken:1,		/* 35: taken branch op */
+			op_brn_misp:1,		/* 36: mispredicted branch op */
+			op_brn_ret:1,		/* 37: branch op retired */
+			op_rip_invalid:1,	/* 38: RIP is invalid */
+			op_brn_fuse:1,		/* 39: fused branch op */
+			op_microcode:1,		/* 40: microcode op */
+			reserved2:23;		/* 41-63: reserved */
+	};
+};
+
+/* MSR 0xc0011036: IBS Op Data 2 */
+union ibs_op_data2 {
+	__u64 val;
+	struct {
+		__u64	data_src:3,	/* 0-2: data source */
+			reserved0:1,	/* 3: reserved */
+			rmt_node:1,	/* 4: destination node */
+			cache_hit_st:1,	/* 5: cache hit state */
+			reserved1:57;	/* 5-63: reserved */
+	};
+};
+
+/* MSR 0xc0011037: IBS Op Data 3 */
+union ibs_op_data3 {
+	__u64 val;
+	struct {
+		__u64	ld_op:1,			/* 0: load op */
+			st_op:1,			/* 1: store op */
+			dc_l1tlb_miss:1,		/* 2: data cache L1TLB miss */
+			dc_l2tlb_miss:1,		/* 3: data cache L2TLB hit in 2M page */
+			dc_l1tlb_hit_2m:1,		/* 4: data cache L1TLB hit in 2M page */
+			dc_l1tlb_hit_1g:1,		/* 5: data cache L1TLB hit in 1G page */
+			dc_l2tlb_hit_2m:1,		/* 6: data cache L2TLB hit in 2M page */
+			dc_miss:1,			/* 7: data cache miss */
+			dc_mis_acc:1,			/* 8: misaligned access */
+			reserved:4,			/* 9-12: reserved */
+			dc_wc_mem_acc:1,		/* 13: write combining memory access */
+			dc_uc_mem_acc:1,		/* 14: uncacheable memory access */
+			dc_locked_op:1,			/* 15: locked operation */
+			dc_miss_no_mab_alloc:1,		/* 16: DC miss with no MAB allocated */
+			dc_lin_addr_valid:1,		/* 17: data cache linear address valid */
+			dc_phy_addr_valid:1,		/* 18: data cache physical address valid */
+			dc_l2_tlb_hit_1g:1,		/* 19: data cache L2 hit in 1GB page */
+			l2_miss:1,			/* 20: L2 cache miss */
+			sw_pf:1,			/* 21: software prefetch */
+			op_mem_width:4,			/* 22-25: load/store size in bytes */
+			op_dc_miss_open_mem_reqs:6,	/* 26-31: outstanding mem reqs on DC fill */
+			dc_miss_lat:16,			/* 32-47: data cache miss latency */
+			tlb_refill_lat:16;		/* 48-63: L1 TLB refill latency */
+	};
+};
+
+/* MSR 0xc001103c: IBS Fetch Control Extended */
+union ic_ibs_extd_ctl {
+	__u64 val;
+	struct {
+		__u64	itlb_refill_lat:16,	/* 0-15: ITLB Refill latency for sampled fetch */
+			reserved:48;		/* 16-63: reserved */
+	};
+};
+
+/*
+ * IBS driver related
+ */
+
+struct perf_ibs_data {
+	u32		size;
+	union {
+		u32	data[0];	/* data buffer starts here */
+		u32	caps;
+	};
+	u64		regs[MSR_AMD64_IBS_REG_COUNT_MAX];
+};
-- 
2.31.1

