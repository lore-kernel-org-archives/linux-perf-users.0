Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2064.outbound.protection.outlook.com [40.107.6.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5306D17554D;
	Wed, 29 May 2024 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969924; cv=fail; b=U95cLnGLa4ZnbGCSLiUQJtuu0xwUlwBef4q0pMBZcKTq/OOwEk2X2Di2t3owO6I1QkoIkLjSutAO2NKZ20a9MUXNAZoRTtucwI/mLALwhcwp4vcHXa9U6hfYORPFCIKqDVAF0u3K7wi/1aGx5XFf2x3yI2/4ge0a7hdA+HawbME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969924; c=relaxed/simple;
	bh=Ef8OMxrhUi0B79xki6A3x3hyM9x9bXAFgRkl6UjLEXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iEO0E9wYqvgA/ifmSeTyrZPqJpNoOooDXnk8tvh8cXr7Zq2aY/k6JzeAzicUaX9l6uEtMXUhMQuVDZvfXXnnjyjeuSu0aZC3rz5t1KUB2oYMd7PPBL0DbO39dYVzX81uPky020dCDjSgUrWuAfYd+XX8g9m8T8O3nBsdIzQfvw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m0O536cF; arc=fail smtp.client-ip=40.107.6.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m0O536cF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8lU/Pz/gg4gzBLW4Zj7JN5yOVSpPhTED2tB7ybQSyDlapaGceUNv8ZvdwTpoauXqdngclTRoKWg7JfOObZza7y6zuWqqR1+bQlImFtSpz6uwK94hxWhnZSxwS9Sv/Osvo/GHcHsmy80o2yYQWG8IB2iAJBBS1uiDL7MBnka4oRtnDcVhvAgBuSSAxmOmPZVuyrXzBlKI46kI8oNAzporEN+qZrpu1Sbdr1emluAg3lZIJab04xnGIYE7uN5ZH2lljkc+0MPfTS9SrgaulkloEZ29pZq47rdan2+n+b60b5bVdA/Xs8vUkpsi+QLTihMKGf0y5lIiPwr3qzapt2nDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9xfbevwG/DMGXMdeNaT4ScDZPFm1zZHE1RLIBjvxQQ=;
 b=WYKcfiw2GWkQwNFzkEv+/XU0GrTAionnhFPB5G61ATwGr168v4GBwDbW97BYh61zhm6IIbrY//WCI80Of/4ukynnadPxXeeykK/nb4U53tSHmVi1LaLbleje2QYmi1xAF9g6WZRkdG8eUvtb0ePYedv/rLjYfuNOaGfybIeE0AToL9/LdzfaGa1SD/MO1N83p7d1LInNjJnfrOh8hI+B9uUruHMQ1oVKPETbBwZRDlmpSasosQe6iF8Zz9jAPsJ1BNruDlRkUhL3El8j8me9EVfMNqPKIxWwqBsEXXSRtFXNlx3EsqqFMcwc4AQXt+4NHpClUOdMhLIK3x4ng/3b0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9xfbevwG/DMGXMdeNaT4ScDZPFm1zZHE1RLIBjvxQQ=;
 b=m0O536cFN4M+cxotVWya0C4XgA+2Ws8/B6DCF3fTXa9V7lkhdAKyf0hg57TBXfxCJI59y4Hh+0yc7a5ndIHru1q0TFS3OgR366YM77m8aD8e7J+6t829bJ2e9a4z/59T+iLqdSUV8PU2C+wA7ODFDfLFuRozxNMxFsV/51uO+tc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS1PR04MB9384.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 08:05:19 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 08:05:19 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: frank.li@nxp.com,
	will@kernel.org,
	mark.rutland@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: mike.leach@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v12 7/8] perf vendor events arm64:: Add i.MX93 DDR Performance Monitor metrics
Date: Wed, 29 May 2024 16:03:57 +0800
Message-Id: <20240529080358.703784-7-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529080358.703784-1-xu.yang_2@nxp.com>
References: <20240529080358.703784-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS1PR04MB9384:EE_
X-MS-Office365-Filtering-Correlation-Id: 837b28e8-33ec-4241-69ac-08dc7fb614fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|7416005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BplZRWZm0BEPYfvxqPxgr97zAcqkAsm2ju54kJl3+Nr0be0qnsWVwtyq3Byo?=
 =?us-ascii?Q?cmlLjs0z1b5Rus9hGPaFJ/gUw61/Uhsrjd59O3G8R6o2EBCSdly3s+vCiiB1?=
 =?us-ascii?Q?7/syKorEaxXcYfYb4t229g4O8smXWTdA1WzSJJXrzzQxK/j1m0LxL/vIb+Sq?=
 =?us-ascii?Q?ee2oVsK7/8TuVjvH6cD8uTZWZFBcsAVMzV6b5X8VChY/OmAY7VT+60EVJmr4?=
 =?us-ascii?Q?WilBlwXgVnm0iYR8ECeBaCMV2p01Zh7zc5pzU6+b0OA0Rzuyc0uzPFvrSeOv?=
 =?us-ascii?Q?Si4L88Y+vDj8ZCUZDWmMMsgqpACT+5k7iL5T3GFadITMGX6Qlpqg7olcpWhx?=
 =?us-ascii?Q?Yf4Mb3fcxiqYijWG6uOA8juhMWl2oBGDdkNhTXMveYIZhXUsfXMgKdl4yqAD?=
 =?us-ascii?Q?y0+p3Ayg7NcZCnyRhPQy784XSUbw95H5Puy0NakJjPHOylV8NnghR/QYfrHf?=
 =?us-ascii?Q?XeuyvDWAMo37hs/kvsc3Wp3HcjiRO2ZQ1ebOryUGk0LLGjzO4VjQ+ekmPpMC?=
 =?us-ascii?Q?gU1oOz9vBk3bY3Koepmmw/fgowTppoBpRbPjyJkJgMMwEH38D5SCqko/rrSY?=
 =?us-ascii?Q?keDUs3MKWYpQm4VARRGq0KCQ2Qnrc9sLwuc1C0WlntW9AYGYTvSZlXV/caw/?=
 =?us-ascii?Q?00yufpMeKy0xFw4nGVPrl2L7D5Wias/5gXykMtwhVnljYKz5xhTZMbzUfOuF?=
 =?us-ascii?Q?gza/A25DZcugxBraxvIO4Rt0k1ffFG+61r9u+Hx50DspAFRhfHoYTGxE9qJ4?=
 =?us-ascii?Q?zVS/sUDglvRmBkzIVrZdSbnmf72bzoWtfK5bZ/etTo3biiyoyDPGaYLIKhXb?=
 =?us-ascii?Q?fzgPlsBFyeIy/6Mw1Dd7K3DKbUZPssiF2b8r0C6+4ZRoTN5vxnhPrXVzFLGT?=
 =?us-ascii?Q?uC7cNuVH4us7Z7FLVEhsIMHGrOGZqZUsFvnKNJKhU8yTTPSeqlm456nhjvJc?=
 =?us-ascii?Q?m6TUjaypLNdqRCD0GACjGK3T0AnowV7RD+HgxREn468lJB3kSIYXSCvWuUIq?=
 =?us-ascii?Q?mrIuz/vY2gfR8DCFRiXlRFR2B26LA0UNuDmdg2fjBWi9ZUE18sIHA7Cc1trE?=
 =?us-ascii?Q?NKR3K56ciOF5mu4komN1R125yKaTPVbcjFfU9DyMF1bmN80CJ4V+JFMZQomp?=
 =?us-ascii?Q?FLmcZVUnpdzelWB5jXR+zvBs58/X+5/45VReexvYQgvzYZyNI6aWW5htXdby?=
 =?us-ascii?Q?0tDEh00Nb1d4DQgeJ1UaikVOWDj6X0N/kaUy8hM6eSQaqlNVqBpKG/nB594C?=
 =?us-ascii?Q?gMr2276WDqi9HMBjPF1ZvbX/2X9xuinvg5u5K/KbVVLUTAF52JJa4GBiwRRw?=
 =?us-ascii?Q?G4rDQDXy55FRoE9Rd1OsXX9ltt2nd5albh1ntA4CPEaFPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fAuq6XrrqvfQtRyAtduGFsFMg5FslHG2tj6xfmhAliQRfIEE30gY8uu/fzIZ?=
 =?us-ascii?Q?C48A2HKf9J+OB198SLz5sKPN+3Ssn8QgLofdg4oT/vfR41rGkh1yESP5NtmS?=
 =?us-ascii?Q?QfuPZZkcPQQHiHSBmoRCZu4GHDudpJMJ7EkHgqOiwcXM6ejSJSeuqPpPXiTb?=
 =?us-ascii?Q?b2FFn7HFslcgSkxQNM1rXggLNSM49cjO4rq44CVPuzwRsi82zHh4Bc/DYJ1X?=
 =?us-ascii?Q?sgk9l1/r45EFduqVcQrGdinn+yXQEqqrUnYI2DPr3YoP/+zumIyx72OQUluH?=
 =?us-ascii?Q?9vw1nlUwVQgGqHZEGDElvtDwlfS+9uePitTT4ZlgN/cmVyFrNdPRgBN3mXcV?=
 =?us-ascii?Q?4nVVqDd8iUGRHXSVO5H79GVh64zFJLdSlhVIdlizXdsP7Hk6JsNbdzbHjGlf?=
 =?us-ascii?Q?dNMvLMUmqNEmoctZsrPvySFUiPgcgYqQiU80YGGfP7yxGQnyPwxLDgYkIqcf?=
 =?us-ascii?Q?Yw1uoVtX/473Q3+UgQ7z8z98r139a030giAjCdhHf2xOUtyLsiYMOLbH7p7t?=
 =?us-ascii?Q?jXeVTIDSh7DgpRG5dQJvtit0Q6eWbxyT1Osrx6qMLOZugLwc3n3sXtAKOWrW?=
 =?us-ascii?Q?nOe9aiMbvnh7+bkZCEgTNknkri4DWW7w+EpEItUBX5tlyLtswaLZOUVKmVs+?=
 =?us-ascii?Q?eOG7QkgsIlgU0DK3OQm+9CjP7Qcs9JOSjd0EFoC/vC9T16KdUHxkEDtWBqrx?=
 =?us-ascii?Q?oBk1VPYPbBpHHcD08d8FvjpqwUVJUDzVT7GeNgV5PzhtRBF88ZtbCfL4jPfp?=
 =?us-ascii?Q?6xtLiJGOpzxXMvraPTrMZEMQDlRiewgMVZFlkJPHj8k0ozqWp5e42ZQJoQj4?=
 =?us-ascii?Q?HhynOwGtCv6pdedLn5etPjFSAD9vIvNqJ1/SwDuH5u84S6j8cTCWoEXLycsp?=
 =?us-ascii?Q?q/wpP4TOff6vfO9rp/33BPBKeob+/nT0kzVB1+TR9Zb/drGxzpdK6KdYwPr6?=
 =?us-ascii?Q?s/s3tDu3dul2atEn2ungvzQQ3aftvacauEZ77kVAYsKGciwRLAr+DeAPtlwt?=
 =?us-ascii?Q?zJQ3TW++JBamEhTx/jGIz7J/R+D07bWd8Ym9d9nKczNL4Ng9ygdWzJAjNwm9?=
 =?us-ascii?Q?Q9cgzHj458Pf+uMKs3TF80TlhTaw3DxgDS3Uu5xOR+83pI8S761YSFwdEPZr?=
 =?us-ascii?Q?SbsJ/apvl3MrY24ySJrKGCDUB0X0Foyb2djqW8g8Q5ZrN1USKuhnY7jatPX/?=
 =?us-ascii?Q?vxZA+2d0yUHKkUaA2lwQJmGTIixEQFFfJ4UZMT6ku0uidmzNcOuQECqit4up?=
 =?us-ascii?Q?JnTnlM545tET51d3Oso+MtGfMV+C8LhbURljMl1ubUv2fN4fw2kI+F1d8Jzb?=
 =?us-ascii?Q?xFCWA4yKw34zI/vC7BHwsEM+eCvKHH981Lxp84epp0eG1orlVg4qLmP1WrJK?=
 =?us-ascii?Q?/QUpm2+6uxKi2cz+D4SrKWcLw7ji/gkmXIKoH9deqvb0SNhYxMoTxP5oa/JO?=
 =?us-ascii?Q?7qflNEC+rq58w6Y87Td77lYnj26vNEQLN0AWjQYizi10k99lmHvRaDHDabdk?=
 =?us-ascii?Q?j5VlDd7BHtTNKteRtg3JWIAjBSmOopw38Y5IcNfBxFQH+PU5Jk62bwGEI/Jt?=
 =?us-ascii?Q?PPv/jD3GvouSufS2V5PB4tsep4Zdk8T5Gj0nzJ6Z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837b28e8-33ec-4241-69ac-08dc7fb614fa
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 08:05:19.4569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqVgUP9bvs/3acqd3C1/nyPTrxtfdWEs6VRXgoCORKsJllGLi/jwMetC7SadgW1Qh7x8IjIKyBkK1XGNu3vDQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9384

Add JSON metrics for i.MX93 DDR Performance Monitor.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v7:
 - new patch
Changes in v8:
 - no changes
Changes in v9:
 - add Rb tag
Changes in v10:
 - no changes
Changes in v11:
 - no changes
Changes in v12:
 - no changes
---
 .../arch/arm64/freescale/imx93/sys/ddrc.json  |  9 +++++++
 .../arm64/freescale/imx93/sys/metrics.json    | 26 +++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
new file mode 100644
index 000000000000..eeeae4d49fce
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
@@ -0,0 +1,9 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx93_ddr.cycles",
+           "Unit": "imx9_ddr",
+           "Compat": "imx93"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json
new file mode 100644
index 000000000000..4d2454ca1259
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json
@@ -0,0 +1,26 @@
+[
+   {
+	    "BriefDescription": "bandwidth usage for lpddr4x evk board",
+	    "MetricName": "imx93_bandwidth_usage.lpddr4x",
+	    "MetricExpr": "(((( imx9_ddr0@ddrc_pm_0@ ) * 2 * 8 ) + (( imx9_ddr0@ddrc_pm_3@ + imx9_ddr0@ddrc_pm_5@ + imx9_ddr0@ddrc_pm_7@ + imx9_ddr0@ddrc_pm_9@ - imx9_ddr0@ddrc_pm_2@ - imx9_ddr0@ddrc_pm_4@ - imx9_ddr0@ddrc_pm_6@ - imx9_ddr0@ddrc_pm_8@ ) * 32 )) / duration_time) / (3733 * 1000000 * 2)",
+	    "ScaleUnit": "1e2%",
+	    "Unit": "imx9_ddr",
+	    "Compat": "imx93"
+   },
+   {
+	    "BriefDescription": "bytes all masters read from ddr",
+	    "MetricName": "imx93_ddr_read.all",
+	    "MetricExpr": "( imx9_ddr0@ddrc_pm_0@ ) * 2 * 8",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx9_ddr",
+	    "Compat": "imx93"
+   },
+   {
+	    "BriefDescription": "bytes all masters write to ddr",
+	    "MetricName": "imx93_ddr_write.all",
+	    "MetricExpr": "( imx9_ddr0@ddrc_pm_3@ + imx9_ddr0@ddrc_pm_5@ + imx9_ddr0@ddrc_pm_7@ + imx9_ddr0@ddrc_pm_9@ - imx9_ddr0@ddrc_pm_2@ - imx9_ddr0@ddrc_pm_4@ - imx9_ddr0@ddrc_pm_6@ - imx9_ddr0@ddrc_pm_8@ ) * 32",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx9_ddr",
+	    "Compat": "imx93"
+   }
+]
-- 
2.34.1

