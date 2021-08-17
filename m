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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E715EC4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A5A60EE0
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhHQWQb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:16:31 -0400
Received: from mail-dm6nam12on2067.outbound.protection.outlook.com ([40.107.243.67]:22692
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235959AbhHQWQa (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Aug 2021 18:16:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gt/vz0UamQQ/FeLzSuf9MKoYvdEJ+JD6sPkSYhLz9ekxkxppdH2paNcW7IZboMG0byr5R8gUI+OHtXO3u7641LbgNmBFxI1wo3VlweUgAFpElIoiA6IRVUFJ0eGZJMzommSzsipskhe0tJmx4ClxZr35J+TbujBTtEu3bYoKOtik50sGJO2+ZBbs7Zf8y3XJCBnk/Nedc5yw6KAiCeWBfTImteJ20JcWAEYkSrLPTMbpNlJgi8yVSPpq9tb3oJTzVDemoml1V/UmLTigKyfNj1G/8RsRO5TwpaXPQt/MbvUwwV+zXcpLGdUVSS8COoceCcOYqrALOJ0Y2Y6iLubeOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzOKb98q/TE2xTvMtgsVck/oxHueD6ksUOSUP6H/Csk=;
 b=B3ur6yF4Pp6P/xdyqzmTtw+RT4H65h1RCn+UDs8ppp5t0JAbFKSibfEXbKRaei7kuOX9zIQlPEev6XYRXvwcQFegjZaP/Gn0x6b50TXjWGOijkjiGjWSG8LX4w5XgffKNfrhs8oODYfFgKyfEzIOTuoJPK+k6uMXIhD4F+iyU6cRfJq5nzdxsJdQcWc1JRDi1djUIdKyBxlZkjCoK28gIpLPx1dmE0RJQP7e6g1ng5+NjXggl32w31SRqneNEcO8LnQM68BiPQh5ItNad8eVRK/tVVpiLaVVSxzD0YCSgLUJ5UpQdAVsMpLkQ12uneG6ra/6MFpOZVy9lwYjiEEw/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzOKb98q/TE2xTvMtgsVck/oxHueD6ksUOSUP6H/Csk=;
 b=Lhc1V0Wi5eJRErt+6u4lM1PSHUlGyBH/2FDk257tnIChAjsPjjjVRJm/FcPo5S0mD4A0JoAuCp31BYw89sPYLHPPCBuP+D4JB0/P5tRviZq+b19VoxdKAeGJJkBjefFSJZ5tEm4taO0XkjmWqWxf5OX3E6kg0a+DTaM+3CDfFEo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB3090.namprd12.prod.outlook.com (2603:10b6:408:67::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 22:15:55 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 22:15:55 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>, kim.phillips@amd.com
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] perf report: Add tools/arch/x86/include/asm/amd-ibs.h
Date:   Tue, 17 Aug 2021 17:15:08 -0500
Message-Id: <20210817221509.88391-3-kim.phillips@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210817221509.88391-1-kim.phillips@amd.com>
References: <20210817221509.88391-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0180.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::35) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by SA0PR11CA0180.namprd11.prod.outlook.com (2603:10b6:806:1bb::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Tue, 17 Aug 2021 22:15:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1c28314-9e4b-4672-dcb6-08d961cc949f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3090:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3090942FF3B461AE23A93C5087FE9@BN8PR12MB3090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Voe59yEEViWeSmvkbbbg/H5qJ4lV6rXmVu3PNCx1xAYyYcDB/MalnT+jquKVWZsiITIAG2aWg47/gHsNzfRH5kw4gmXMuZKY/swFNu6qbMvbB93hyoccgQxC15P/ixXKRZzugyofmt326xi+jNikq+ndmfgsfVXfuB1HFfb9SYt2uX5yh61HgMwpoWfzjlIdB3+HbPay3FSLwrWMDoSrwgLcJSQqJIfDSbiLwIQ6yRS/dyMgdqK2Oz86yDFtjHMKkmPH1vYSJVlsOfgPgyqsFbH8ySCGpb7rGY/WLa6Kdll3Q2vZZBWSz+TNyihOgz7mZe+gncTYXdpTkzcfW8+Y+VmVmfXRKTkBWUrPSVzi/vH/JONMZ+/kltESD7SGkSiAVC/VP1NZx9AybA1/AdIM5MhR/a35H5wjd3x0ZPEkppV7QuOTbVtLH++e1pYvRa/4M1SxCgGXOU9GQvSkZ5c9jY9m59kbbujrKmNQueBrdBOmR2J6CTxkqQ4TZT8LlkxLhr6EBtN+mlDiDFsPGVh3fC2/dv3GPxlYC8nuu5Rb10PxslntjqUYT0zUGDp9x5brQ7rsAl2VokgGXRaVq/xiS8YSZoqe/TDKUc+hqjP8uLyPCqTLRpg+VThvduxwD40yaW5JiiwckaPli+eRO+D9CaZ6oLxCIm13Ja7GxHTeKN0PtKAg95VTeoDVFQPoS8aQxySJti2aWoT3oNFO4ZPi9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(38100700002)(38350700002)(44832011)(4326008)(186003)(1076003)(26005)(2906002)(54906003)(7416002)(66946007)(66476007)(66556008)(86362001)(2616005)(956004)(6486002)(8676002)(316002)(83380400001)(5660300002)(8936002)(36756003)(7696005)(52116002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7bX2I18QTQfUbtXpGFPb7FXta/ZP1JAeHkDomde1JXWgqt0yfQ0mqglW216Q?=
 =?us-ascii?Q?erVA9L0DYWVikYnJrXp2VB2KVf1zzpA8YUB9sY1i8hhgz3/OJqat5mReCxny?=
 =?us-ascii?Q?u1gEmDkh+LFsr+6BNWwo9UjLD4gJdaBiB0i5JWMBU7eZeS7VWWzGodwLLpfm?=
 =?us-ascii?Q?IaeME//Udygu0Ng1hMGZ+K6DVxDp2S+v/OtJ6xnuZiFLdcHcr/igSVGXeiiN?=
 =?us-ascii?Q?K5Zh393/1sk2ZlNaoHzjkGNFOzY6iu/j00OR2mQOZp/cY5dAjpIyb4WRJOPk?=
 =?us-ascii?Q?LoUu1LdJteBqaxKP7Rx/8mywsYjlKzSiAKhpvaU+93ikJ9mW1et0iKJaqkQ0?=
 =?us-ascii?Q?8wTpUPAp7PjfK0TfQmoEMtVc3vKeaMuOOmn2Yy3RP6Uvcvm90+/fxPvUxXBk?=
 =?us-ascii?Q?ZQv6qUYNj+hX6zYY5oxOfy858wo7uQdQS2o5/vof4rDoOaT/jtTV3nRL1Omv?=
 =?us-ascii?Q?jJl14s2Ywk/LF2n/1D6Ywpdw/2ewJhM0YqOd4zaOOQ/kJcC6lAV4At16zHrg?=
 =?us-ascii?Q?p7TMlZJOiTPocTVKxsMP9wBFh2OcqRwIUyKBr2OD2q8gl01X0hHj+tD0/sqE?=
 =?us-ascii?Q?92MKCoC3c82ufMIcgN7aTL0e0Hk83bb6JesJBp0paSDeuJKlomQab2AfOisL?=
 =?us-ascii?Q?qMwIMR3MCZxpnZKHboQQKNs10MpskM5HFLW3hZHp9+YyLptsFMboflInAdNJ?=
 =?us-ascii?Q?PvQuq4QBCPN0zcMxqkaU1U6V0NoLSiBXuwT/PWDCgHX/PqwB94f0VncLD6Zz?=
 =?us-ascii?Q?DKLf+9NGy76yjzP1K9IasrEJR1TgBtkP5g6lXBfF4SgtGYfsTT7138FdYKdx?=
 =?us-ascii?Q?hCNh/Qo29JF/x11ZySU3gZQwy9YnC7y3P0DeMWhfPS6q1j7B8fBVrCVKD8L8?=
 =?us-ascii?Q?XIjW9r51SrIHA3mmBaKG1hFXVJpO4A9LzDfWqfEZNZwgR7f1tw3q84gVKNbN?=
 =?us-ascii?Q?jLPd6ZgR101RGOXOC76IeSpCVaxKRNHTP7m+eDPV3N32qLZj/i4OHapcXLZi?=
 =?us-ascii?Q?ZoQ4i4xheGzRZZO1+RRdxv/k3T30Pr+xs3zyiQOLJ2/rjNF4QVyLntZvUTm8?=
 =?us-ascii?Q?zwjGHWFH3lKp1kf+KrpVCrfpwrYey5HC4h8i8Y0B0KRtiKa5A5CJgMDLuaqh?=
 =?us-ascii?Q?6RyjG5lAGp6HtzJyLGFr7J/T4AybAKf3kdo2MniAkjzQ7RgWAyRit4eKdZ6k?=
 =?us-ascii?Q?DahOgMAKH3F1xC1HYexbLtj4r896y//PbmZiKdqmDw5a/ffU/dHrtV8js66m?=
 =?us-ascii?Q?AaeJ2dVLwRu122NJA3nq3tleuZGAgAv7rVmD+TezuAsfEsDZ6t2tiUiWiYd/?=
 =?us-ascii?Q?S3z7xp/OnMDYGYSmSv4irfgD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c28314-9e4b-4672-dcb6-08d961cc949f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 22:15:55.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwFjJpekSUejGWZpPUcpk8uRiME/Nna6JvjF/euRGB9I1gOVZDpAFTg5jzIyEZEqc5LYITmMtrWGAg4TUTerOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3090
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is a tools/-side patch for the patch that adds the original copy
of the IBS header file, in arch/x86/include/asm/.

We also add an entry to check-headers.sh, so future changes continue
to be copied.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
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
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
---
 tools/arch/x86/include/asm/amd-ibs.h | 132 +++++++++++++++++++++++++++
 tools/perf/check-headers.sh          |   1 +
 2 files changed, 133 insertions(+)
 create mode 100644 tools/arch/x86/include/asm/amd-ibs.h

diff --git a/tools/arch/x86/include/asm/amd-ibs.h b/tools/arch/x86/include/asm/amd-ibs.h
new file mode 100644
index 000000000000..46e1df45efc0
--- /dev/null
+++ b/tools/arch/x86/include/asm/amd-ibs.h
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
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index c783558332b8..4a6b2b4ec507 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -34,6 +34,7 @@ arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/emulate_prefix.h
 arch/x86/include/asm/irq_vectors.h
 arch/x86/include/asm/msr-index.h
+arch/x86/include/asm/amd-ibs.h
 arch/x86/include/uapi/asm/prctl.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
-- 
2.31.1

