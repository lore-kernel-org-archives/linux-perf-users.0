Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023122.outbound.protection.outlook.com [40.107.201.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF5167D80;
	Thu, 24 Oct 2024 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729812632; cv=fail; b=awmUF45zXbUxS5qURkqU3OJOdfEaRnetS9cYrvLoC8QXOoaiZcMJ6+Ccx7rwyfXQZSlSecWZltcN/dF3bR3iKB/4s0cxbq2YweRZGcjbFhNx8mRFHXKvVJickcvmWFeWy+7M5YTB1eVSZSfwDb9rCL3apZWTRi39fdlHuF2ElCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729812632; c=relaxed/simple;
	bh=MoSxv7KAT3Gldn5Hk84/jas1RiRkQ0MdmE8e4Thv6IU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eH0NByubEsiCsQPt2aMhqR66j8cp3p2Lg3hEgwchj47lMvREFgNt87SgqmV4yNQwF9mWVKW1rRyjcdAwt7RGpN7Br+s8Lj5iZGnxQJ/Lh7totzuI+2MQ+njNU0W9opPHShwb+KP5nJIDjUypsycAcf6TrF4Xc6w+fsoXW/gHK7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=k3gapNdy; arc=fail smtp.client-ip=40.107.201.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="k3gapNdy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjDIkGdm+gzYPR2CnTI9xIqvx+VbY6k8ZscapcmvxWGilwr8xfin8StxjTgGgJ37dtMahL+H0dfIyZa833xzRCg1FhaZ4/8izL83RWqv4TniATkTdWG0bttwVKwgmpBqQZZjhvCEsjR19OEcAXZveQhgAKtVyox0lT5hqwmz3dQSoRTPySpgkGCadMkKg8fHIafsXbyqOUavoPw58wiu8EcbRrm3218zjbHzqIjvx0ovK9UlMan4zuZK9wef2oCHx6uS29aFbwtIH7UoWsp0HYwC//kdVjgjiEy66ChJ4CVzY8jweyvXZ1Pt7f2TW1lXfXgDl8+nLvZ+JexTmnV9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hN8QfXyhuY0m0xRWFEfnuXb9HpzW22lnsxd10IUIcw=;
 b=WCPMM/eGtiWGJn9sjdRInnMhmceLMIZXSH+04wa5jilCz7DyOoZ/Y3+2/Rj0xFxZWHwr8fMMTTKnrBpIWL6PXr0M6yynDgW2AmUn/DWi/Kaw0/rO3kOG0GQMX/kvpd7xmmGyIBHsahKJW5oeCAQWmSmYzHnuveoXzJzFhKLReo3m/O2GJUafC5eDSz+8rZnqw3n828yoDhtcfFhNhfYueDtHyMyvhqtINesTPKYlvnOXMGc88UlWxYPWWzVRviuotv/niC28fDs6LT2qxA/JasdLBfeG0rFV7sljLjuNM8idMSZ0iCkeILPw3X9+1tqUg+oznTql3kndrVOrx8Iy2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hN8QfXyhuY0m0xRWFEfnuXb9HpzW22lnsxd10IUIcw=;
 b=k3gapNdyNNkQL585by3dIS6Q4Ir+Sp8qvm+yYFnEmsW5BFyH0FRXGkyScVBKdEgDV99sHbop3diM1hJXgXukqbWa4LSjVibt1axyOdm/8YIgxXHXFMDaGLcECs6YX0/xjSZ9zDSlZgZDALfsH4aeDtQy2EZOROwRzJHwzceC0HM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CH3PR01MB8315.prod.exchangelabs.com (2603:10b6:610:173::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.7; Thu, 24 Oct 2024 23:30:21 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%7]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 23:30:19 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf arm-spe: Add support for SPE Data Source packet on AmpereOne
Date: Thu, 24 Oct 2024 23:30:35 +0000
Message-ID: <20241024233035.7979-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:610:11a::18) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|CH3PR01MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: a94bb584-9c03-4051-6e60-08dcf483d29f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JKQ7vwsRbM+wh/Alf0jhzM+qQTOpn11vz4Fo+HAK5z9zuO+V4bTGvILv9VQ3?=
 =?us-ascii?Q?29100tFvKs37WIVUplyY4Uu5g3VVTbU8TyEWmn9QjZfGnQ3cGOuTdyUC58zW?=
 =?us-ascii?Q?FGSTJ2HbX2XHefBAQJjDDXWxzLM5FZUS4mp1P6ouMKvrL3N/XFVCnmr75gbj?=
 =?us-ascii?Q?lGyRgF9NnnalX5G6Z3WN/GkLPi4EDEnUUJaWyKFNXMpNHyeSKO3G1XT82Dh2?=
 =?us-ascii?Q?vnbGh0PA7KgnYPMNWMxl0gkcy2RMKZ/HkKQ4cQXhU9XL1eETmrBGSccywyT+?=
 =?us-ascii?Q?MwTeVq202yzZc/EAfas5z14E2+NrysIF7x+PixawtRIKrK/QBZOD2iSKKJJ+?=
 =?us-ascii?Q?0RkL3P3JtlZ37AevuQeVobgw9Piqo9PkuIGz2Nl/Mb1tBxbRrQjKlx8odZAr?=
 =?us-ascii?Q?BupAoGRnWu1xE6IzR21ewVbbNPaxjsRN/cXkK1XV1otykoqFWPBNmjfGE5Cf?=
 =?us-ascii?Q?urcb7HxUnb3pKUtKPuAunwQuBCS1bUOEUgGXZcfRg31wlajR7GPdIdzYn0uR?=
 =?us-ascii?Q?x1/IB9xTtWjXTPsXIfw14ix5b2Qj7gF1ignxZL4FjxPjCNlKFDjNst8VxUJF?=
 =?us-ascii?Q?+A1jteRVrsyVTmYfGL9rVWLx3MNzC8E2V1pip1vWtsVluREzmqIjEA6U9k7R?=
 =?us-ascii?Q?li2D+2dE0ZX8p0RtbslrU7cm5ovV24YildsXXSEESnl+md8n2tm+95FuqmCc?=
 =?us-ascii?Q?CKgdx8seYkASvl6GfZqKDumiyb2BCtTSLuvvOjB+LxnyCPBmVNZsVZp7IvdK?=
 =?us-ascii?Q?IpSwIDW+3i+/C2VmMXKPq/aYiAmpaACKT212os6+DI8U+aiumf8XE2aiSLiF?=
 =?us-ascii?Q?L6qVX71jaglBfcjZjMLnjPD0PD1KZzQSUOaLMx2e2VgRKsvrGFyh8zlttnlX?=
 =?us-ascii?Q?eu96yQ0zwFbD1di6JKu3TCopFDoCeRYLWd5wLYSjAE3dKj89RpaWVuFnbapY?=
 =?us-ascii?Q?UDsFmQlRpCS+PV7hjJ+a+PMAGLwFmaV3U+ryzD39k4uxOAxBi7AtDO6h7hmn?=
 =?us-ascii?Q?6F5gBC6vF4YgBUpDZjOTN2byYZQfYvJWKyKHZ31tOkEVOD95k/1uAf5Q4c58?=
 =?us-ascii?Q?Ts0D8jQIks+0v0rf2YseGPKbwLo5OrBGz4h3pkrhf7bMRsRQi/FVAJBXzCJK?=
 =?us-ascii?Q?kISTCk57U4E9QL9qpSk80xacTAhZvCLuwPGETO/Xw2RHNWIwkNoEpQ70KLr4?=
 =?us-ascii?Q?fZkI5racbjcHNAsqXRP3JQ+AAJtLctUAgtc9cUlpJH5Q7tyxWOMODszp6dqa?=
 =?us-ascii?Q?4homSIxnlhrv9XljV1mIp3X7LnrODLzx1YZjzPkc8TpPppZudV3UuW/rFeCf?=
 =?us-ascii?Q?VzW+owvfpV3ycFm9zfAnUTXJvb5zaVw/sUi7stV0lXhXN1NzNyiMh8a7G3gr?=
 =?us-ascii?Q?cFg165d+WCcnilGFXwtkzN0onN7q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QQVEKOEnhk5QdX+b1X6dq2h20Hvcwhp2h9+Z+C73+V0NpHdkM2ZY+n3byoIw?=
 =?us-ascii?Q?KltfPVM/uTlPmhy3QizsaEchX1tXhUxiI9ZCERlAfDhW/idEIrv7aPyWHn3W?=
 =?us-ascii?Q?5KsEd19bou1ZLYMwsL5LqZt2ec/LFk1olW+Yg9NBDWlz29gqyDpm1E7RGAV9?=
 =?us-ascii?Q?kCPuKlxJyZ26XGfREuHzg7LSk8gh8SR+eEyHUPXsYN5SvnknY6iQ7Iv4vP7z?=
 =?us-ascii?Q?qYsyVHh7HcK9pQYpaIqRo1sBwC9IX694b9DR1AgtHoDySPQPERzuXZVGlicj?=
 =?us-ascii?Q?k6wsyuPS/r1j8YGPn4EHrday2a+EFF1A48JjUQvAyxjJtwt2wcxAuIRIg8yU?=
 =?us-ascii?Q?fHhmBy0kf3J65CtkxPxfCpAAo1LTBg5nK0QAE6Yz3CsA6rMm5Z/t8wQov7eU?=
 =?us-ascii?Q?YI1hFE+Wd3K0O1np5ljkWv4tgJ6dmyv7sqM1NaJLeFuhF0i2e9/US97j5w0i?=
 =?us-ascii?Q?GJNKYIKugYUlCIfzjqZdXLUT5hV14LQFk/YhSafk8SyVpJHMIueSsg43nXcH?=
 =?us-ascii?Q?pexrXsYu4DmQfSwL8tJgAwVW9mD6839oeyALywkekFDSTI6jFGMmvCvDe0O3?=
 =?us-ascii?Q?U5akf+m3b54WapwLHtZSjLzI//8qkIyzFc3nshDG+QrVmBCKDpJZ/yfpnZs1?=
 =?us-ascii?Q?1iCUqlVHNNRSOQ/eNW1dz31vbhdch0MoeFAdWd+bskX+8Nrea4xXpf4+kKQK?=
 =?us-ascii?Q?FKHQzm/qAW7FsviCkPf2k+b7CjXomOs9p7Gi6WyhT0C5R/1+LeUArMuWxDBU?=
 =?us-ascii?Q?/1zFKrJ5KEpcK7xc5Yjw8xHP/rOP/5//fw6QX9HI7o69uPFP5AgP8UA9hVHJ?=
 =?us-ascii?Q?SBU1EpzOBUM4hstM5R+p07ZhYpXaTS9SCY1uoTEQ2T1CS6MRpkbQ9sLKEgrZ?=
 =?us-ascii?Q?0MF6L4VSJ7+yh2WDImJn+3ME+uBo6ck8qQuxGgfcKIjAsubz9YX281pDVcPp?=
 =?us-ascii?Q?fE9FEizvexXZdcZTT/Vx2Jxc/nLsCHohFqUzCwGWBmk0kDmcdOIpwo4qHTC7?=
 =?us-ascii?Q?E04cKHKmI28alHGvTk7eM5hNtVhuOxwsyJK0NcWM4m3bIvWJBFBZdzQ8vcdr?=
 =?us-ascii?Q?+w8t0XcM/2yG8ERKgwaTz1hoGhuIGQumaD5z8AA1LbTCEPlSNsMo5ASxyFb3?=
 =?us-ascii?Q?m9XylZuWzHKAa5McMOr+Lvlu2r552Ou+u+rLQtvZaESSzPAlH9Ernm7o6LNF?=
 =?us-ascii?Q?LK/sybaoBapNRxoLBYT31CHgA/wDFQdIuWFqyxOnhOCcA2FRBApRbf9tsEOe?=
 =?us-ascii?Q?55VUi3/sHpEoDEi4Qo+c8E+fRK736HmAOVWjAxl0PcPMcOwhbNSS4jzto1+s?=
 =?us-ascii?Q?hSAgoFfrG4UYIzGA0fxHAkxdjc1GeL5+XUPOjJM+jkWvA+nF2p6cKFYI46Ds?=
 =?us-ascii?Q?f48KINRpeyz8j5gnzikYVCTSFhx3S9j+i8DzbW1gnwSWw2GxHQBaGZkwgl3D?=
 =?us-ascii?Q?vnnSdVep3k4Ajhi1bZ1Ln5/UPniRKnclYQ1rn4yy3irngiF9MEp+sJd+IOZy?=
 =?us-ascii?Q?3VuNR8JPsCslhue8HSyIZww7TiT7oFUhW/qKhpiDKTiPSVgF+0rB3WrF6DLj?=
 =?us-ascii?Q?O8d6Mq/FCxcFnYQ5nsPN2No7n3GQpWReVQUs2iau1lEmRHFQX0Vvw+BiKp80?=
 =?us-ascii?Q?n7OE336On+7g/fXBe0/5JWM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94bb584-9c03-4051-6e60-08dcf483d29f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 23:30:19.3439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSN1dRD4JlIxSBthso5tALsNrcsfOtr4iGBmoRMiS7P0ATpB9r6NahSklOcj2w1FC5CvfC0t6igHAD3Y9Fccd19tYdJS63jI3Y68jfS0rdqxGH88kbgnU2O+emHLo0Fy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8315

Decode SPE Data Source packets on AmpereOne. The field is IMPDEF.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  9 +++
 tools/perf/util/arm-spe.c                     | 61 +++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 1443c28545a9..e4115b1e92b2 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -67,6 +67,15 @@ enum arm_spe_neoverse_data_source {
 	ARM_SPE_NV_DRAM		 = 0xe,
 };
 
+enum arm_spe_ampereone_data_source {
+	ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE	= 0x0,
+	ARM_SPE_AMPEREONE_SLC				= 0x3,
+	ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE		= 0x5,
+	ARM_SPE_AMPEREONE_DDR				= 0x7,
+	ARM_SPE_AMPEREONE_L1D				= 0x8,
+	ARM_SPE_AMPEREONE_L2D				= 0x9,
+};
+
 struct arm_spe_record {
 	enum arm_spe_sample_type type;
 	int err;
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 138ffc71b32d..04bd21ad7ea8 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -515,10 +515,69 @@ static void arm_spe__synth_data_source_generic(const struct arm_spe_record *reco
 		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
 }
 
+static const struct midr_range ampereone_source_spe[] = {
+	MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
+	{},
+};
+
+static void arm_spe__synth_data_source_ampereone(const struct arm_spe_record *record,
+						 union perf_mem_data_src *data_src,
+						 u64 midr)
+{
+	if (!is_midr_in_range_list(midr, ampereone_source_spe)) {
+		arm_spe__synth_data_source_generic(record, data_src);
+		return;
+	}
+
+	if (record->op & ARM_SPE_OP_ST) {
+		data_src->mem_lvl = PERF_MEM_LVL_NA;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NA;
+		return;
+	}
+
+	switch (record->source) {
+	case ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE:
+		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
+		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
+		break;
+	case ARM_SPE_AMPEREONE_SLC:
+		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
+		data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
+		break;
+	case ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE:
+		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
+		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
+		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
+		break;
+	case ARM_SPE_AMPEREONE_DDR:
+		data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		break;
+	case ARM_SPE_AMPEREONE_L1D:
+		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		break;
+	case ARM_SPE_AMPEREONE_L2D:
+		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		break;
+	default:
+		break;
+	}
+}
+
 static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
 {
 	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
 	bool is_neoverse = is_midr_in_range_list(midr, neoverse_spe);
+	bool is_ampereone = (read_cpuid_implementor() == ARM_CPU_IMP_AMPERE);
 
 	if (record->op & ARM_SPE_OP_LD)
 		data_src.mem_op = PERF_MEM_OP_LOAD;
@@ -529,6 +588,8 @@ static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 m
 
 	if (is_neoverse)
 		arm_spe__synth_data_source_neoverse(record, &data_src);
+	else if (is_ampereone)
+		arm_spe__synth_data_source_ampereone(record, &data_src, midr);
 	else
 		arm_spe__synth_data_source_generic(record, &data_src);
 
-- 
2.47.0

