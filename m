Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2097.outbound.protection.outlook.com [40.107.236.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7441BBBE0;
	Thu, 31 Oct 2024 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410528; cv=fail; b=dSJmiayOX2US6VxPoZfsNUAfBaPmR0thaKmaUxmtwpSudGYvvZUtCGDSLLwa/ACVsO70Qr60ipankX2gvXgMTdKkFq/pEr0QpXyT7bqb5hyrH3ZckJVPohQo7CRVAFBhLM/wOvQRoZUv4v0S5YVAoA1YH+1liMfIdUbsIcSHNTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410528; c=relaxed/simple;
	bh=mm3CNEIqFYkIZQQpGSzYFx+U/XH9iIyz1geF/izAKRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AS6d5JS1S8eDJ6H7apXWkViR8KqJ69DbmYRAZctCuIGMevg1ck2wnFMSkvJ6SdSB5nzOOpIJ7KUEsU08taxm1H7llbfEfnnmhDiL0A+eBz71dfw1yvQNqlulxV9Eb3FKsio7AGXH5bCDTBuK1ezz4PC51wOnIUBMajHPqKl9Wqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=GVQDXzlo; arc=fail smtp.client-ip=40.107.236.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="GVQDXzlo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ2KLbWQXG3mtSJ5qg/wk13OvicU6uVfZgNEosu4OnKXQx8G/h7CO5R1t+GYbxdR9gw5CFTCFLJR7/Oqj1GLHyeQNtexDgocZfQCsaKqznekBlQU1dcirSpgKhDInB7BzwlyNM68K496KkYS/hK+ExQ6OKpIpE5vZgu5a5GpCmnvyTRfmd2kMrbi2bKGzSR61c9uPrPF58nasabyCr7h5V26QjNbEdWF15cKXejVBtwltSRdBLQV2Js2iUIqzH4LSrUzJZHTP3RD9wE54n65iyeV4rg1L4zXgD/68g338rTUBtZW22vI3+ZR5Vk8YBP7Nd0qUdSLJVYWBuvUvUZX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKWhnbY97SP1R6VGqf2ndEnIPTuONU8Xny6/jErYNPg=;
 b=yW/S3wIiKItJKRQF+wMRvlXjVeU4+avvMn3yVOFzUAyKz9A3DP8jbdgiR2h5g0ZpZL5IP3zvtytw6W9cqgRWCPDqyyAr4vVct39z0zuBLYAPfCua7zM98XNssZCkdHv2nB3L5JUvnLV4i1B+i7eyqccxr3X4K1kubMrlFUZPOVqt9u7Kbyg4BxfbDrUiu73nd0+o4QTtAz0w74kKhQJAEZzsB+DCjOrVgMdYdhZrUbSofeN4/azXl7xosOA61kAWcKSvS189go9hRi4U9mlRc5nA9FKY5006SY92xf72ZiEhwiqUDpvQXZZ5JyDDDgPwEAWLHZARDKfRY1G2/P5MAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKWhnbY97SP1R6VGqf2ndEnIPTuONU8Xny6/jErYNPg=;
 b=GVQDXzlokkiCdTsWlmERJ6YZT+YfHk6yiMaZoQnBSTkhGW0wleH65KalHp5FgLWW3ZO1PedctMmY0+y6rdif0P3KLzGFfRUdxshX3J4fz/c+F0oBWqWsGgjtVUkZFxOCaTHjg/UN5wCfkFK8ON+C5ej8Ju/KRdpwDRLQq69tAVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 DM4PR01MB7761.prod.exchangelabs.com (2603:10b6:8:68::13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.9; Thu, 31 Oct 2024 21:35:17 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8137.008; Thu, 31 Oct 2024
 21:35:17 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Graham Woodward <graham.woodward@arm.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] perf arm-spe: Prepare for adding data source packet implementations for other cores
Date: Thu, 31 Oct 2024 21:35:32 +0000
Message-ID: <20241031213533.11148-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031213533.11148-1-ilkka@os.amperecomputing.com>
References: <20241031213533.11148-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::14) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|DM4PR01MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a682dd1-d95c-4c7c-4b91-08dcf9f3e9da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bh6cHB4vFAP9ruuZTnJ2bn57GBX8JVmUBYYlshRLjgvnQ1TKHvMK3qNFzhLu?=
 =?us-ascii?Q?MD2O7cV/XcrGupDTuiN4KMhVouqtnySl7aTwnQ/I+C7zLaUW34I1aOb3WBFF?=
 =?us-ascii?Q?c3KpW8575rA9te2v7jWoA/OUQGER58AD52EKHo/z8eokwEeTUn5x9Ul3Q7Nq?=
 =?us-ascii?Q?QpM23YQMP3jGMvR62GWucAzISOdxnYsrpKPhM+SJBNWa5vkumLjP0TVIxCXk?=
 =?us-ascii?Q?OuYKmj91Nrb/zISaMXb037rciPkHqyTVDVVAsX34rKGG1RAKSo1C0W1tq/yH?=
 =?us-ascii?Q?LZDTXzW+zA7xbob0AGUkKf9ErI2IEIft8TMialUSl5s4oUPyswsYQTN2iZkJ?=
 =?us-ascii?Q?5E3m/EeUqq8P6ryaZ4RFF65Dyr8ckMO+YSw+/K7DNnYVzcX4hf3ox7VL62Ri?=
 =?us-ascii?Q?CyXLImyJwFmkrakIqRyVYaaUDGY4QJzimKYG7ciCZwz/TdTj7qJN9bofmRty?=
 =?us-ascii?Q?fhcMz6feJdyu27iJwz9uBH+u4AmB6/yA/QZ6HBIa8+pXIj+ISr11WKCQHTZM?=
 =?us-ascii?Q?JcPjqSlHseXCIbb/Oth4LFndjyCr8xUDeedsVUEMP1YO2L2bSdjzd4uUrEmc?=
 =?us-ascii?Q?uQPk1rx0ZxTCECYYj4CiGu/2ZRJwGkXjy7R10vuGC/Pm0MHnko/kkJDlnySD?=
 =?us-ascii?Q?LTO8Fqe6hssmIcQdDht0WfLGjeGrIGm9+/t0fdoXRLus3xFZ4AlMtaIDNAVA?=
 =?us-ascii?Q?Gil33fh25mdq39oJ76GtU7Ag7JivGlPHYAmioYuul72hv1CRY/zjwivhirZx?=
 =?us-ascii?Q?nl22LzzdO48iowhMCWCMJx9xwdcGdcbIILCCukYsD8d/bqHnNUGfyCwtB2bu?=
 =?us-ascii?Q?PZLAOA7RvL3xzqV/t5Cwig93ZmzNWMrGyD6Ell14WV+GEpriuI6VdgufminV?=
 =?us-ascii?Q?eY9MPgxqqe3iAnPDVpJts4dlV4S6zmqzBrbGfdeK1SZYMGfjjVeumKwczRVa?=
 =?us-ascii?Q?AjQO5mr69kT0SX3Arr+7HxHZH394QA8GdpHe6ww6SXaMAwjNrGP7F4bf/cVT?=
 =?us-ascii?Q?wgmwiw7zuyr7yiHD42NG26mBYuzNNHezEbkhaBun4sBR7DQhJn6Paxgggdmn?=
 =?us-ascii?Q?Z2FRbNksykWIXLyzzx6kN3PHinmqJ04EgNSaxsQ7CFuXKUEq67M9W53pfAzp?=
 =?us-ascii?Q?MQgmtsI47q0HN+DfKqyvO/QCJ6IjBu9Kf8IHN311w5RmLuXMedfI0zPFf9Qb?=
 =?us-ascii?Q?lJOk17Ja44TH+8GVtq0CkhWKZh8rAhcfNnUKLCPZY+aUsgXnKmbXTll72HDM?=
 =?us-ascii?Q?2yDESzr9YR7JwG6txctplAOELs4dJ7bxJwrP13dAUXJL8XmX/Nxrqr4p2wtE?=
 =?us-ascii?Q?5Hn1jMsz7VCvOgh6CN8/5mq+xZmh5I/lLgCDICinBItMUeLm+K8X+lahZJal?=
 =?us-ascii?Q?GP2BhMChIe8GoyzxETFzezRml3TP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gp0xYGZAvFbjFhZ7OGXf8jswEeID0ZHBY9FTOkPk5FKT88Xg88c3zdo30tXb?=
 =?us-ascii?Q?+XY7Afe+afMMrZgH/wQ9+9w55TlYmxYM1/kjUrKK1NRglY6mhh/tUdBtq/8D?=
 =?us-ascii?Q?PaS/p+lKW2LB7/MorYhjlx2m8WzaE+H71Yx7wB+51vnaB96udTdMpvxfKkff?=
 =?us-ascii?Q?VDMYV3aq1KfBBe/0JHcTh88hxF3ZAD7umCDmA3tkoPgGa68YHN97BpZFiWq/?=
 =?us-ascii?Q?CM9p7LraPlwbiPb90HKRGC+CGyJtOuIqRjEr9PTOn/S1VaB5PMcoqgRhZ3D2?=
 =?us-ascii?Q?auaV+rM5LX77P/mI/CCU4ZtnBaNxkBY/5TenFqbYJpmcJB9fb0Fwy83ud+tE?=
 =?us-ascii?Q?07e4UZK8iq+mnDmYUXtShiPC2DqmRBWLIu9Re611qsDy5Ce3c9yqbe7NN3+g?=
 =?us-ascii?Q?IAmTPh+jD0ql+c5tYfDHlVVeIohLve/ft205ZUoLtCYoxU08cxtE/mw0Dslg?=
 =?us-ascii?Q?gWdVDRLWg9NLpuPFGqjzpdbUAKyAfI7K0AsmOh2YtVTVYAeW7kXnuy6qnJXW?=
 =?us-ascii?Q?5Jb7EenZhc/INs7d8mkRfs7sIto+TxLjFUR9Z2eACWTWp7oEr7iE8/++oISJ?=
 =?us-ascii?Q?JZLYgCtJ/IrOG+cLFlhNBi0oVBILCrgzw766zeOhlF/wHIzJ4CUemkN+ifdn?=
 =?us-ascii?Q?hVQksPX+DiibbuRDO+kNer5elIg/FePeyX6qY5AyX1EtbduQzuuEl07b/p9d?=
 =?us-ascii?Q?48m66ZY08oW/YoEldg/mofx//Nxuq6nfX4WhqgQi8O9LQU4tMAfkEHZq8/1p?=
 =?us-ascii?Q?9DbbnFadolMWbOSz5LTucoNQ+vbMhEOcPo+9TE7+qlq9xUL8XNWeXR2hgE77?=
 =?us-ascii?Q?xKGix5IBOlACP4WxSTAm5xfEKxiCy9Gq0cSxpGnyt1lbnL1oraXaY8kg7Yj2?=
 =?us-ascii?Q?szvcXK0+AJO5Zf00eFkAfPvBC8boQtpqEN3GyZ9sU6+7mB5ySvmQ1pug2JUp?=
 =?us-ascii?Q?LLrInKZI/sEOBur0cv+XD+9NHIT2CwXY10VlO+Rw8/JRKLDct6ttxlIJq4Hm?=
 =?us-ascii?Q?tdsuqXNTW+SMTUaelhn5xnh+EiODOTbu43x0kmn2nhJcxsIfYgqo0jzm6a6Z?=
 =?us-ascii?Q?+WNfOWuL0SMh6I15C4ugqZR04z5SrOvrByl6FvJnBURsmyd8Tja8JwGpC0a+?=
 =?us-ascii?Q?9FgzDmi/R5DCCwMt4IlyXhv7MfkRqz5H8P+3JCZrNeXDU2LQGyrDNYDboc2n?=
 =?us-ascii?Q?aBt5GwRWOEY6hfnutaOCCc8RnYtqfC/mnFVim9sAu0Qa44qRiQ7FARf+WcO4?=
 =?us-ascii?Q?D556ldbhMbaycPDg8cMDEROm0/KZrmmdYcRt5xvcUWKoyDiz91eJyEuUFMnb?=
 =?us-ascii?Q?7umtn32ZY/U/qQn7mW0RTdN3jcTGTnJIiYmPwXe3U410Ki5XNh9nVisAXVJZ?=
 =?us-ascii?Q?jQ8Rwxg9dhr4GUX6fBY4o6etmCMt67g7scMiRKggy328W6fz8srXI7ayv3BE?=
 =?us-ascii?Q?aoce90WmUvMG/ZGWrGYg/hNmMGxGSXogqRtgTlB12pqx1HF0sSER0PoTVkM5?=
 =?us-ascii?Q?UL6GqVI2eVrF0W5f2tt4zL0A2fzHIxghjgH7IqaNwK1wDyC5jCqYWcxeagpO?=
 =?us-ascii?Q?zBAZASpV6XIEcv90GofdNhuwoKzUe3+tQR939i5YiorHI5XqwaqVxUyaFm6P?=
 =?us-ascii?Q?IoGBsalyqElcjqvFGjtAzkg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a682dd1-d95c-4c7c-4b91-08dcf9f3e9da
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 21:35:17.6316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpeI4y0+PVqdGOtqbMyGwv3klUMi/c+ZMvqNozRWv3ZSrF0Bc3MCuovIcQ3AAhb+t6p9LLMA2dZSgp7D74o7DQEleV2ZECaLxM6qaPYw5pbYRnbqcuzMhMjlP2F9ESHf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7761

Split Data Source Packet handling to prepare adding support for
other implementations.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 tools/perf/util/arm-spe.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index dbf13f47879c..9586416be30a 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -555,7 +555,8 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
 		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
 }
 
-static bool arm_spe__is_common_ds_encoding(struct arm_spe_queue *speq)
+static bool arm_spe__is_ds_encoding_supported(struct arm_spe_queue *speq,
+					      const struct midr_range *cpus)
 {
 	struct arm_spe *spe = speq->spe;
 	bool is_in_cpu_list;
@@ -592,7 +593,7 @@ static bool arm_spe__is_common_ds_encoding(struct arm_spe_queue *speq)
 		midr = metadata[ARM_SPE_CPU_MIDR];
 	}
 
-	is_in_cpu_list = is_midr_in_range_list(midr, common_ds_encoding_cpus);
+	is_in_cpu_list = is_midr_in_range_list(midr, cpus);
 	if (is_in_cpu_list)
 		return true;
 	else
@@ -603,7 +604,8 @@ static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
 				      const struct arm_spe_record *record)
 {
 	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
-	bool is_common = arm_spe__is_common_ds_encoding(speq);
+	bool is_common = arm_spe__is_ds_encoding_supported(speq,
+						common_ds_encoding_cpus);
 
 	if (record->op & ARM_SPE_OP_LD)
 		data_src.mem_op = PERF_MEM_OP_LOAD;
-- 
2.47.0

