Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A223C8AE;
	Mon, 19 Jan 2026 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845746; cv=fail; b=QQiW3Rwq/zLqKyDMA6r5Ez1GvLF9RwYCK0Yjx1A75+zfV5zqZdCNVQiySrDaN9/yssk548KSqIdFCvgZAjvdVkdPFrln2C7QR/BmPGyMjyZwCPed92cSE8vMcR/jpj1hSGVBia8J1N+1Dypgd0HnatAi3+IocZlRiQEspgiquHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845746; c=relaxed/simple;
	bh=QsgeHdR2DLZYD2o7vwzrTYJtf0nsNrZ+cMdZeQeNGqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=msPhNS5atjjQRQQ0YAAQ0kbCzlU0FPN0iEJ5E4YYszXb6jLyd3RfqpOTy8C/x14k5sjPGbk6KYJJHWdx7hmj9Ld/jIvH+7NASeBeiEqb3QTrRiRWSOauT3zIoym5uhkKEU4JMe4+BD8DkrM5S6lr0mdv8aNDmOCQ4Z27Cz8UN3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oyo7GQ15; arc=fail smtp.client-ip=52.101.52.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oyo7GQ15"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llQel933c2x0e6gcJvVVR3Z0VXEkdYhNFcMN9+kWyic6LlIqalBAYcIMaJ0+KapA2DTf//AZOPSKeJviJu6aXc9ZEAyAaKSbFbjIZ2OpareJCyPk5sob+7hSCKaz2H0OGIdoZ4Kwz/QRhlMPo+OZBKtLS+UK9sMDI6ovBUfAWx8C1327qfFuIbFikgT54TjSynNMD9eavW/nIhxWHLqUSMlsai0P6fWK7rgtVeUTxrnCBVf2O9/JAEozMfs++5CI9Z9MyOw+fpgdSFoK+fJQYaRBxNhY6HQm25DKrMbemT6o8BqR78WHEVB0Go80mtmxNGsNWAktKWxDQLj+DCFLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1o+y9xaFRu71jx99PlNEK0ptBnrRx6Y5DIow8U2xY0=;
 b=KnNudBqpsaAq4c3r2eU7rqrfnhY91u4PpLjyDJhLWAJWWlFghXh/RMJqD1AS7zcI5SexHxYcJRRZReEG/EEUx2+a9+WYJER3TWrubXesVB50YOSAJvTyphvJ6csH4DojU6SLiqPdURIudgg5+zpPoEFasbcFZcqnkETHkYCHfmE67TqfWhhMGipTnc2/HHgbsWJxungKpIu6KODN/wVfmzWK9N4oiV3RvEKAcDdem+xrzgvm1NA8VDbq8eRUu+5QBE2wz4mrqTmRTR9uwVl6sFvoYfjlEjSDSYvWuKHQo4rnovbPwFhd8MxM7OC109lo7oJxwTlw7fRG/HiuyH/HZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1o+y9xaFRu71jx99PlNEK0ptBnrRx6Y5DIow8U2xY0=;
 b=oyo7GQ155G2OA6iTzL19+Qly/GoqoIRXLOtheVJdvXa2KYk9nOIrQWRa0XtQto7n4DpD5KeedEhQAUBg1lTbMkyMuYyS+rPFOaz1cHPCTNrkJu52btJGhnn86jXgnQ6Hrm8f0cccBfK8rldxldvy2Q+Cr+tbsaL4VkFS6CY5RnU=
Received: from CH2PR18CA0016.namprd18.prod.outlook.com (2603:10b6:610:4f::26)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:02:17 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::6d) by CH2PR18CA0016.outlook.office365.com
 (2603:10b6:610:4f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 18:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 18:02:17 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 12:02:06 -0600
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>
CC: <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>, <yu.c.chen@intel.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <ctshao@google.com>, <quic_zhonhan@quicinc.com>,
	<thomas.falcon@intel.com>, <blakejones@google.com>, <ashelat@redhat.com>,
	<leo.yan@arm.com>, <dvyukov@google.com>, <ak@linux.intel.com>,
	<yujie.liu@intel.com>, <graham.woodward@arm.com>, <ben.gainey@arm.com>,
	<vineethr@linux.ibm.com>, <tim.c.chen@linux.intel.com>, <linux@treblig.org>,
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH v5 08/10] perf sched stats: Add support for diff subcommand
Date: Mon, 19 Jan 2026 17:58:30 +0000
Message-ID: <20260119175833.340369-9-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119175833.340369-1-swapnil.sapkal@amd.com>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: c3624696-6068-4c49-b1af-08de5784e209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sCuDjDUMBbJwoiv1EgM2Nw6NJ+1kuHuJtXPpZAksVICkm2VYfh6TbtvNhu/W?=
 =?us-ascii?Q?R3xKogvnppVdy0aUVVkNCBCIRaQUVhLcfKT6k4dCClhw2iHc72DQzQ1cOYY6?=
 =?us-ascii?Q?f62wb8K5UOtk7UEwIoOlLPK5xCvJhCMVZCcYB7NN6A6Pm/cKrfiWPZTHpIKy?=
 =?us-ascii?Q?iE4I6zRpYgOlYez9Ntw98+vbXwJYCKSegW8YGxuiHjz0BjzqABCRDJDE/kbd?=
 =?us-ascii?Q?gTQ/cW8qKoEBysfLCAlL4Ie0ytpx11/Woo0kPMVB1Xg2VmdMwPI8i/3U9sVi?=
 =?us-ascii?Q?mUXo9mVoD0zlG7+2yV9fdxP2p2tJRyzuebLJknPjI6yBMjuh1uiWL9Saj/Ao?=
 =?us-ascii?Q?1zBsGOjtB1e6Psdp3Vuo97Y8yH5MU9Gjde/rmNaRJB/m5+hSwXMbFo54gfjP?=
 =?us-ascii?Q?MEeae/KvtYS+49obPjDDB6nDtAbm6LnpLgeQb2Ra7wgNoTPw6eE4jh/oxkXV?=
 =?us-ascii?Q?Sodelddi3Bl0C721aZNov4mixAFI+iJGQjU88aTiaXMovuktu5UxEc1Isc+g?=
 =?us-ascii?Q?6mo4sDByHd+deoQcKaRH8Bw1Gifhtot3dCNQyumZ+k5yzjAYrOeFDBzsFlJ3?=
 =?us-ascii?Q?0itOR4TMliJxA7yZG46HvyljYHGC2J0mtGXaYrKJzXod+Vd3mbugVbcvjHG5?=
 =?us-ascii?Q?M+NhYKt5S+tgxWNsp3ch39uOVNJJluUVOs36saykPUDcSgsClwqwMtw8v9Ca?=
 =?us-ascii?Q?tE07T7NDlFvs/o386gqTxSIzat/IMdcPV02ldJP8LTeC8cEEiIxziR/aX7gb?=
 =?us-ascii?Q?yKax8aftj6ssygc1VCPuS1vxozo83o7dc3Ddzo3dpiBDt4/uaC7/nOufcClb?=
 =?us-ascii?Q?cQoUPvZRRo6PuNeTOpNPnlJGCZA6PcIcUTWvRx1zYLC3iXUXlorweADLtlyt?=
 =?us-ascii?Q?PtjAfUBARh66F4dSL0yOMqULVsTR2MmlHexSvmRnGgvfM11IlaUSZfw02lD6?=
 =?us-ascii?Q?WEP2Xx4RShZAI0Kts+oG3H/Y3MmfFcpFNGo4VWcfZg40/tssGbm5VbEpS6qq?=
 =?us-ascii?Q?E+U/NHKvI0RdGqONLklOyip5qTuHpW9jWiwY1+zwQQo9OHXuvE2wIbkQ1/CG?=
 =?us-ascii?Q?QF7yCnYUyrpJ/2KNHslrUnVCKhoHdmclROy/wu0jByTxCl1w6ndSfkS0ey1+?=
 =?us-ascii?Q?dNlFUOaEWjshVft1lE+PY2eheEX5WwZNR8EpkwPQQdLTNFz8X48fmMwJdVxi?=
 =?us-ascii?Q?wytgwDlCQS4JffqWP2PpPnMeFvpzh5tcaaWpJMypBgANEaMSSCjupLTBSmk5?=
 =?us-ascii?Q?2nDkGLCB/5Pcq+Qjg2024qqVH7SiU1rnYaCq2pyAa4aXBx+wyNGi/VkT8ZPh?=
 =?us-ascii?Q?hhS8yT8WcMvbUVnOfF7/BRH1olusGhieQZZc97am4WI9U3qZYFX2f5Y0+q3u?=
 =?us-ascii?Q?R8Z9bVhr0EPEw1i9mNdsw9Rmg8RDB3DHuVzAPObFuJKjwQjLZLz/vNuIix4V?=
 =?us-ascii?Q?eWVWb1tnL+1YUZ8/kzqL0PaKvHeuClR0eJHLpvcS+KrH4a9cyOPySzG2AdCP?=
 =?us-ascii?Q?DhQ1llpYt9zgXKQRZGFYzWNzL+YRm3hDpCIJeS0xHX/JmHvPHcNFr9l+D33c?=
 =?us-ascii?Q?tgwiuY59x85hv7cRBx4UIwJOmz5hC0EjzgKtLAuEGDd2sQT2luVMdWXUQiB5?=
 =?us-ascii?Q?sAaVkyIc6rEUSOKj/ra9OXGBOArhV8lhDFCgXVQbds9JyTXbDtxrEU8ggpHJ?=
 =?us-ascii?Q?1Ap49A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:02:17.2232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3624696-6068-4c49-b1af-08de5784e209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988

`perf sched stats diff` subcommand will take two perf.data files as an
input and it will print the diff between the two perf.data files. The
default input to this subcommnd is perf.data.old and perf.data.

Example usage:

 # perf sched stats diff sample1.data sample2.data
 Description
 ----------------------------------------------------------------------------------------------------
 DESC                          -> Description of the field
 COUNT                         -> Value of the field
 PCT_CHANGE                    -> Percent change with corresponding base value
 AVG_JIFFIES                   -> Avg time in jiffies between two consecutive occurrence of event
 ----------------------------------------------------------------------------------------------------

 Time elapsed (in jiffies)                                        :           1,          1
 ----------------------------------------------------------------------------------------------------
 CPU: <ALL CPUS SUMMARY>
 ----------------------------------------------------------------------------------------------------
 DESC                                                                    COUNT1      COUNT2   PCT_CHANGE    PCT_CHANGE1 PCT_CHANGE2
 ----------------------------------------------------------------------------------------------------
 yld_count                                                        :           0,          0  |     0.00% |
 array_exp                                                        :           0,          0  |     0.00% |
 sched_count                                                      :           0,          0  |     0.00% |
 sched_goidle                                                     :           0,          0  |     0.00% |  (     0.00%,      0.00% )
 ttwu_count                                                       :           0,          0  |     0.00% |
 ttwu_local                                                       :           0,          0  |     0.00% |  (     0.00%,      0.00% )
 rq_cpu_time                                                      :       32565,      33525  |     2.95% |
 run_delay                                                        :           0,        436  |     0.00% |  (     0.00%,      1.30% )
 pcount                                                           :           0,          0  |     0.00% |
 ----------------------------------------------------------------------------------------------------
 CPU: <ALL CPUS SUMMARY> | DOMAIN: SMT
 ----------------------------------------------------------------------------------------------------
 DESC                                                                    COUNT1      COUNT2   PCT_CHANGE     AVG_JIFFIES1 AVG_JIFFIES2
 ----------------------------------------- <Category busy> ------------------------------------------
 busy_lb_count                                                    :           0,          0  |     0.00% |  $        0.00,        0.00 $
 busy_lb_balanced                                                 :           0,          0  |     0.00% |  $        0.00,        0.00 $
 busy_lb_failed                                                   :           0,          0  |     0.00% |  $        0.00,        0.00 $
 busy_lb_imbalance_load                                           :           0,          0  |     0.00% |
 busy_lb_imbalance_util                                           :           0,          0  |     0.00% |
 busy_lb_imbalance_task                                           :           0,          0  |     0.00% |
 busy_lb_imbalance_misfit                                         :           0,          0  |     0.00% |
 busy_lb_gained                                                   :           0,          0  |     0.00% |
 busy_lb_hot_gained                                               :           0,          0  |     0.00% |
 busy_lb_nobusyq                                                  :           0,          0  |     0.00% |  $        0.00,        0.00 $
 busy_lb_nobusyg                                                  :           0,          0  |     0.00% |  $        0.00,        0.00 $
 *busy_lb_success_count                                           :           0,          0  |     0.00% |
 *busy_lb_avg_pulled                                              :        0.00,       0.00  |     0.00% |

 ... and so on. Output contains the diff of aggregated data of all the
busy, idle and newidle categories for all the sched domains in the system.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 316 ++++++++++++++++++++++++++++++-------
 1 file changed, 260 insertions(+), 56 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 8993308439bc..01e6cb6a2fbc 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3985,29 +3985,46 @@ static void store_schedstat_domain_diff(struct schedstat_domain *after_workload)
 #undef DOMAIN_FIELD
 }
 
-static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs)
+#define PCT_CHNG(_x, _y)        ((_x) ? ((double)((double)(_y) - (_x)) / (_x)) * 100 : 0.0)
+static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs1,
+				   struct perf_record_schedstat_cpu *cs2)
 {
-	printf("%-65s %12s %12s\n", "DESC", "COUNT", "PCT_CHANGE");
-	printf("%.*s\n", 100, graph_dotted_line);
+	printf("%-65s ", "DESC");
+	if (!cs2)
+		printf("%12s %12s", "COUNT", "PCT_CHANGE");
+	else
+		printf("%12s %11s %12s %14s %10s", "COUNT1", "COUNT2", "PCT_CHANGE",
+		       "PCT_CHANGE1", "PCT_CHANGE2");
+
+	printf("\n");
+	print_separator2(100, "", 0);
 
 #define CALC_PCT(_x, _y)	((_y) ? ((double)(_x) / (_y)) * 100 : 0.0)
 
-#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
-	do {									\
-		printf("%-65s: " _format, verbose_field ? _desc : #_name,	\
-		       cs->_ver._name);						\
-		if (_is_pct) {							\
-			printf("  ( %8.2lf%% )",				\
-			       CALC_PCT(cs->_ver._name, cs->_ver._pct_of));	\
-		}								\
-		printf("\n");							\
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)			\
+	do {										\
+		printf("%-65s: " _format, verbose_field ? _desc : #_name,		\
+		       cs1->_ver._name);						\
+		if (!cs2) {								\
+			if (_is_pct)							\
+				printf("  ( %8.2lf%% )",				\
+				       CALC_PCT(cs1->_ver._name, cs1->_ver._pct_of));	\
+		} else {								\
+			printf("," _format "  | %8.2lf%% |", cs2->_ver._name,		\
+			       PCT_CHNG(cs1->_ver._name, cs2->_ver._name));		\
+			if (_is_pct)							\
+				printf("  ( %8.2lf%%,  %8.2lf%% )",			\
+				       CALC_PCT(cs1->_ver._name, cs1->_ver._pct_of),	\
+				       CALC_PCT(cs2->_ver._name, cs2->_ver._pct_of));	\
+		}									\
+		printf("\n");								\
 	} while (0)
 
-	if (cs->version == 15) {
+	if (cs1->version == 15) {
 #include <perf/schedstat-v15.h>
-	} else if (cs->version == 16) {
+	} else if (cs1->version == 16) {
 #include <perf/schedstat-v16.h>
-	} else if (cs->version == 17) {
+	} else if (cs1->version == 17) {
 #include <perf/schedstat-v17.h>
 	}
 
@@ -4015,10 +4032,17 @@ static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs)
 #undef CALC_PCT
 }
 
-static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
-				      __u64 jiffies)
+static inline void print_domain_stats(struct perf_record_schedstat_domain *ds1,
+				      struct perf_record_schedstat_domain *ds2,
+				      __u64 jiffies1, __u64 jiffies2)
 {
-	printf("%-65s %12s %14s\n", "DESC", "COUNT", "AVG_JIFFIES");
+	printf("%-65s ", "DESC");
+	if (!ds2)
+		printf("%12s %14s", "COUNT", "AVG_JIFFIES");
+	else
+		printf("%12s %11s %12s %16s %12s", "COUNT1", "COUNT2", "PCT_CHANGE",
+		       "AVG_JIFFIES1", "AVG_JIFFIES2");
+	printf("\n");
 
 #define DOMAIN_CATEGORY(_desc)							\
 	do {									\
@@ -4033,28 +4057,54 @@ static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
 #define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
 	do {									\
 		printf("%-65s: " _format, verbose_field ? _desc : #_name,	\
-		       ds->_ver._name);						\
-		if (_is_jiffies) {						\
-			printf("  $ %11.2Lf $",					\
-			       CALC_AVG(jiffies, ds->_ver._name));		\
+		       ds1->_ver._name);					\
+		if (!ds2) {							\
+			if (_is_jiffies)					\
+				printf("  $ %11.2Lf $",				\
+				       CALC_AVG(jiffies1, ds1->_ver._name));	\
+		} else {							\
+			printf("," _format "  | %8.2lf%% |", ds2->_ver._name,	\
+			       PCT_CHNG(ds1->_ver._name, ds2->_ver._name));	\
+			if (_is_jiffies)					\
+				printf("  $ %11.2Lf, %11.2Lf $",		\
+				       CALC_AVG(jiffies1, ds1->_ver._name),	\
+				       CALC_AVG(jiffies2, ds2->_ver._name));	\
 		}								\
 		printf("\n");							\
 	} while (0)
 
 #define DERIVED_CNT_FIELD(_name, _desc, _format, _x, _y, _z, _ver)		\
-	printf("*%-64s: " _format "\n", verbose_field ? _desc : #_name,		\
-	       (ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))
+	do {									\
+		__u32 t1 = ds1->_ver._x - ds1->_ver._y - ds1->_ver._z;		\
+		printf("*%-64s: " _format, verbose_field ? _desc : #_name, t1);	\
+		if (ds2) {							\
+			__u32 t2 = ds2->_ver._x - ds2->_ver._y - ds2->_ver._z;	\
+			printf("," _format "  | %8.2lf%% |", t2,		\
+			       PCT_CHNG(t1, t2));				\
+		}								\
+		printf("\n");							\
+	} while (0)
 
 #define DERIVED_AVG_FIELD(_name, _desc, _format, _x, _y, _z, _w, _ver)		\
-	printf("*%-64s: " _format "\n", verbose_field ? _desc : #_name,		\
-	       CALC_AVG(ds->_ver._w,						\
-			((ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))))
+	do {									\
+		__u32 t1 = ds1->_ver._x - ds1->_ver._y - ds1->_ver._z;		\
+		printf("*%-64s: " _format, verbose_field ? _desc : #_name,	\
+		       CALC_AVG(ds1->_ver._w, t1));				\
+		if (ds2) {							\
+			__u32 t2 = ds2->_ver._x - ds2->_ver._y - ds2->_ver._z;	\
+			printf("," _format "  | %8.2Lf%% |",			\
+			       CALC_AVG(ds2->_ver._w, t2),			\
+			       PCT_CHNG(CALC_AVG(ds1->_ver._w, t1),		\
+					CALC_AVG(ds2->_ver._w, t2)));		\
+		}								\
+		printf("\n");							\
+	} while (0)
 
-	if (ds->version == 15) {
+	if (ds1->version == 15) {
 #include <perf/schedstat-v15.h>
-	} else if (ds->version == 16) {
+	} else if (ds1->version == 16) {
 #include <perf/schedstat-v16.h>
-	} else if (ds->version == 17) {
+	} else if (ds1->version == 17) {
 #include <perf/schedstat-v17.h>
 	}
 
@@ -4064,6 +4114,7 @@ static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
 #undef CALC_AVG
 #undef DOMAIN_CATEGORY
 }
+#undef PCT_CHNG
 
 static void summarize_schedstat_cpu(struct schedstat_cpu *summary_cpu,
 				    struct schedstat_cpu *cptr,
@@ -4173,13 +4224,16 @@ static int get_all_cpu_stats(struct list_head *head)
 	return ret;
 }
 
-static int show_schedstat_data(struct list_head *head, struct cpu_domain_map **cd_map)
+static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **cd_map1,
+			       struct list_head *head2, struct cpu_domain_map **cd_map2,
+			       bool summary_only)
 {
-	struct schedstat_cpu *cptr = list_first_entry(head, struct schedstat_cpu, cpu_list);
-	__u64 jiffies = cptr->cpu_data->timestamp;
-	struct perf_record_schedstat_domain *ds;
-	struct perf_record_schedstat_cpu *cs;
-	struct schedstat_domain *dptr;
+	struct schedstat_cpu *cptr1 = list_first_entry(head1, struct schedstat_cpu, cpu_list);
+	struct perf_record_schedstat_domain *ds1 = NULL, *ds2 = NULL;
+	struct perf_record_schedstat_cpu *cs1 = NULL, *cs2 = NULL;
+	struct schedstat_domain *dptr1 = NULL, *dptr2 = NULL;
+	struct schedstat_cpu *cptr2 = NULL;
+	__u64 jiffies1 = 0, jiffies2 = 0;
 	bool is_summary = true;
 	int ret = 0;
 
@@ -4194,49 +4248,100 @@ static int show_schedstat_data(struct list_head *head, struct cpu_domain_map **c
 	print_separator2(100, "", 0);
 	printf("\n");
 
-	printf("%-65s: %11llu\n", "Time elapsed (in jiffies)", jiffies);
+	printf("%-65s: ", "Time elapsed (in jiffies)");
+	jiffies1 = cptr1->cpu_data->timestamp;
+	printf("%11llu", jiffies1);
+	if (head2) {
+		cptr2 = list_first_entry(head2, struct schedstat_cpu, cpu_list);
+		jiffies2 = cptr2->cpu_data->timestamp;
+		printf(",%11llu", jiffies2);
+	}
+	printf("\n");
+
+	ret = get_all_cpu_stats(head1);
+	if (cptr2) {
+		ret = get_all_cpu_stats(head2);
+		cptr2 = list_first_entry(head2, struct schedstat_cpu, cpu_list);
+	}
 
-	ret = get_all_cpu_stats(head);
+	list_for_each_entry(cptr1, head1, cpu_list) {
+		struct cpu_domain_map *cd_info1 = NULL, *cd_info2 = NULL;
+
+		cs1 = cptr1->cpu_data;
+		cd_info1 = cd_map1[cs1->cpu];
+		if (cptr2) {
+			cs2 = cptr2->cpu_data;
+			cd_info2 = cd_map2[cs2->cpu];
+			dptr2 = list_first_entry(&cptr2->domain_head, struct schedstat_domain,
+						 domain_list);
+		}
+
+		if (cs2 && cs1->cpu != cs2->cpu) {
+			pr_err("Failed because matching cpus not found for diff\n");
+			return -1;
+		}
+
+		if (cd_info2 && cd_info1->nr_domains != cd_info2->nr_domains) {
+			pr_err("Failed because nr_domains is not same for cpus\n");
+			return -1;
+		}
 
-	list_for_each_entry(cptr, head, cpu_list) {
-		cs = cptr->cpu_data;
 		print_separator2(100, "", 0);
 
 		if (is_summary)
 			printf("CPU: <ALL CPUS SUMMARY>\n");
 		else
-			printf("CPU: %d\n", cs->cpu);
+			printf("CPU: %d\n", cs1->cpu);
 
 		print_separator2(100, "", 0);
-		print_cpu_stats(cs);
+		print_cpu_stats(cs1, cs2);
 		print_separator2(100, "", 0);
 
-		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
-			struct domain_info *dinfo;
+		list_for_each_entry(dptr1, &cptr1->domain_head, domain_list) {
+			struct domain_info *dinfo1 = NULL, *dinfo2 = NULL;
+
+			ds1 = dptr1->domain_data;
+			dinfo1 = cd_info1->domains[ds1->domain];
+			if (dptr2) {
+				ds2 = dptr2->domain_data;
+				dinfo2 = cd_info2->domains[ds2->domain];
+			}
+
+			if (dinfo2 && dinfo1->domain != dinfo2->domain) {
+				pr_err("Failed because matching domain not found for diff\n");
+				return -1;
+			}
 
-			ds = dptr->domain_data;
-			dinfo = cd_map[ds->cpu]->domains[ds->domain];
 			if (is_summary) {
-				if (dinfo->dname)
+				if (dinfo1->dname)
 					printf("CPU: <ALL CPUS SUMMARY> | DOMAIN: %s\n",
-					       dinfo->dname);
+					       dinfo1->dname);
 				else
 					printf("CPU: <ALL CPUS SUMMARY> | DOMAIN: %d\n",
-					       dinfo->domain);
+					       dinfo1->domain);
 			} else {
-				if (dinfo->dname)
+				if (dinfo1->dname)
 					printf("CPU: %d | DOMAIN: %s | DOMAIN_CPUS: ",
-					       cs->cpu, dinfo->dname);
+					       cs1->cpu, dinfo1->dname);
 				else
 					printf("CPU: %d | DOMAIN: %d | DOMAIN_CPUS: ",
-					       cs->cpu, dinfo->domain);
+					       cs1->cpu, dinfo1->domain);
 
-				printf("%s\n", dinfo->cpulist);
+				printf("%s\n", dinfo1->cpulist);
 			}
 			print_separator2(100, "", 0);
-			print_domain_stats(ds, jiffies);
+			print_domain_stats(ds1, ds2, jiffies1, jiffies2);
 			print_separator2(100, "", 0);
+
+			if (dptr2)
+				dptr2 = list_next_entry(dptr2, domain_list);
 		}
+		if (summary_only)
+			break;
+
+		if (cptr2)
+			cptr2 = list_next_entry(cptr2, cpu_list);
+
 		is_summary = false;
 	}
 	return ret;
@@ -4417,7 +4522,7 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
 		}
 
 		cd_map = session->header.env.cpu_domain;
-		err = show_schedstat_data(&cpu_head, cd_map);
+		err = show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
 	}
 
 out:
@@ -4426,6 +4531,100 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
 	return err;
 }
 
+static int perf_sched__schedstat_diff(struct perf_sched *sched,
+				      int argc, const char **argv)
+{
+	struct cpu_domain_map **cd_map0 = NULL, **cd_map1 = NULL;
+	struct list_head cpu_head_ses0, cpu_head_ses1;
+	struct perf_session *session[2];
+	struct perf_data data[2];
+	int ret = 0, err = 0;
+	static const char *defaults[] = {
+		"perf.data.old",
+		"perf.data",
+	};
+
+	if (argc) {
+		if (argc == 1)
+			defaults[1] = argv[0];
+		else if (argc == 2) {
+			defaults[0] = argv[0];
+			defaults[1] = argv[1];
+		} else {
+			pr_err("perf sched stats diff is not supported with more than 2 files.\n");
+			goto out_ret;
+		}
+	}
+
+	INIT_LIST_HEAD(&cpu_head_ses0);
+	INIT_LIST_HEAD(&cpu_head_ses1);
+
+	sched->tool.schedstat_cpu = perf_sched__process_schedstat;
+	sched->tool.schedstat_domain = perf_sched__process_schedstat;
+
+	data[0].path = defaults[0];
+	data[0].mode  = PERF_DATA_MODE_READ;
+	session[0] = perf_session__new(&data[0], &sched->tool);
+	if (IS_ERR(session[0])) {
+		ret = PTR_ERR(session[0]);
+		pr_err("Failed to open %s\n", data[0].path);
+		goto out_delete_ses0;
+	}
+
+	err = perf_session__process_events(session[0]);
+	if (err)
+		goto out_delete_ses0;
+
+	cd_map0 = session[0]->header.env.cpu_domain;
+	list_replace_init(&cpu_head, &cpu_head_ses0);
+	after_workload_flag = false;
+
+	data[1].path = defaults[1];
+	data[1].mode  = PERF_DATA_MODE_READ;
+	session[1] = perf_session__new(&data[1], &sched->tool);
+	if (IS_ERR(session[1])) {
+		ret = PTR_ERR(session[1]);
+		pr_err("Failed to open %s\n", data[1].path);
+		goto out_delete_ses1;
+	}
+
+	err = perf_session__process_events(session[1]);
+	if (err)
+		goto out_delete_ses1;
+
+	cd_map1 = session[1]->header.env.cpu_domain;
+	list_replace_init(&cpu_head, &cpu_head_ses1);
+	after_workload_flag = false;
+	setup_pager();
+
+	if (list_empty(&cpu_head_ses1)) {
+		pr_err("Data is not available\n");
+		ret = -1;
+		goto out_delete_ses1;
+	}
+
+	if (list_empty(&cpu_head_ses0)) {
+		pr_err("Data is not available\n");
+		ret = -1;
+		goto out_delete_ses0;
+	}
+
+	show_schedstat_data(&cpu_head_ses0, cd_map0, &cpu_head_ses1, cd_map1, true);
+
+out_delete_ses1:
+	free_schedstat(&cpu_head_ses1);
+	if (!IS_ERR(session[1]))
+		perf_session__delete(session[1]);
+
+out_delete_ses0:
+	free_schedstat(&cpu_head_ses0);
+	if (!IS_ERR(session[0]))
+		perf_session__delete(session[0]);
+
+out_ret:
+	return ret;
+}
+
 static int process_synthesized_event_live(const struct perf_tool *tool __maybe_unused,
 					  union perf_event *event,
 					  struct perf_sample *sample __maybe_unused,
@@ -4515,7 +4714,7 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 
 	nr = cpu__max_present_cpu().cpu;
 	cd_map = build_cpu_domain_map(&sv, &md, nr);
-	show_schedstat_data(&cpu_head, cd_map);
+	show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
 out:
 	free_cpu_domain_info(cd_map, sv, nr);
 	free_schedstat(&cpu_head);
@@ -4847,6 +5046,11 @@ int cmd_sched(int argc, const char **argv)
 				argc = parse_options(argc, argv, stats_options,
 						     stats_usage, 0);
 			return perf_sched__schedstat_report(&sched);
+		} else if (argv[0] && !strcmp(argv[0], "diff")) {
+			if (argc)
+				argc = parse_options(argc, argv, stats_options,
+						     stats_usage, 0);
+			return perf_sched__schedstat_diff(&sched, argc, argv);
 		}
 		return perf_sched__schedstat_live(&sched, argc, argv);
 	} else {
-- 
2.43.0

