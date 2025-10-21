Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011035.outbound.protection.outlook.com [52.101.125.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161922C21E6
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Oct 2025 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761088914; cv=fail; b=WJYta882MjGNnDAHHoqfthkdzX8QdRpwgD6Y1hXvzna0l7NAAIPMbrb8Xy2RM/9EDd5R2pclOTG6S9B2VNag908etdhE6Qi7htOi4i07AztDJhi/s6K7VtZKvZLUxtDiWB3yyG5OQYcscyxe4YUrXFY+eBQlKAfLiFG17GJ/9+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761088914; c=relaxed/simple;
	bh=Qwv4TrPPf0aZuPU0l4TzncxdyKNV0pPOTTCo2QrGF/Y=;
	h=Message-ID:To:From:Subject:Content-Type:Date:MIME-Version; b=vCHd/C/GXOfftQX+LjaacmEQIvNcJj9GLR0L+Dy0qExiapHer4gp/vcYy+vv0bVgWeXBR9XobPbuLUoDrVME8aJDN999lAizYo5IWDIkk9fhTs2puY3RBRD4yZjlbYE76R/qMjRawFzl6OFApx2Iq4e/vWmf57UAuk7Uiv9K/3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=DsrT6qzD; arc=fail smtp.client-ip=52.101.125.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="DsrT6qzD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHwQqkUgxPaBGt0ljtdO3kPp3XyxUdrbBBqw4AZjgV3XEjld+bar36noAKcKp0cypjYhVPOoHkILQUsYmU8rEkZGTBOSCfwDzT4UPO+gSqTK1KNoEHFKyvoCPn5D5YIP0YMdZ7gqHhePZ0VRbhSuMhZ7taXT2oFDGx4DbbzypS/LODO13FG8oc5ZxYz/sJMTI72QktwZz/hXYqIsiUDpNcnprgZwV2vgRVIEylKVEiufkaL5llikUjn9jTOVXi+nUMkRJkgPC6vJZ0LY++9TQzXdFtzrjQQ8WhxJkM+JkYu5O2Sn1hUAEPq5eobNsCbu51j8souoUv/4ag7wHAkD6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7EKeS+9ZI1odFiRLbsaH+UeltFt0Bs2UPudnEajAos=;
 b=dhhkREi195oW6J9OYdkefpxbc+ACtLhU0Icv19Idxvt5+VSIOq2xB764GgxGx2a590l4o08OyZ91MoSmBhXUwb/2xdesaf0gBjSLVU1eYzf9PqlBgujS5RysO6UALgC8YmLuPNSjF52DOhpOcPxV6uTGzkVui/0QQW7yB5QvBKs+PIrg5PU4S80TKMK5Gq2+YgnjgIjpHdvYXdBHR7bUcjThHO0//ZkgKw6oJyjVr4jSsS3cmwFY1niMbDhuR+/prqRDptN/Aiqv/LkFiW08iJUOY0ileNSYGL3U7gyEeAEDYk5QIJ6w/Xh4k5kDv6tolSIvtd3fViO9iSJbhg5e1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7EKeS+9ZI1odFiRLbsaH+UeltFt0Bs2UPudnEajAos=;
 b=DsrT6qzDBqeDe4G6BxUXUd0Y+LU6wcGx/+SgWc0jd1dXqJgvY3zmdgzTA5fLTDprnxwwstm28Qj0J0JTnTAi1scYP3OJCXBTqG0/VavR/mjOmAHumNTijmgTTb1mIhEzo7231gL6kOF0BZVyw3vMyrQjOhhBa+FlJt1cY33uLvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB7043.jpnprd01.prod.outlook.com
 (2603:1096:400:be::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 23:21:48 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%3]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 23:21:48 +0000
Message-ID: <877bwnyh6f.wl-kuninori.morimoto.gx@renesas.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@linux.dev>, Mark Rutland <mark.rutland@arm.com>, Mike Leach <mike.leach@linaro.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [resend][PATCH] tools: arm64: Add Cortex-A720AE definitions
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 21 Oct 2025 23:21:48 +0000
X-ClientProxiedBy: TY4P301CA0050.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::9) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: 026be57f-c703-4c76-758f-08de10f89bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nbqiNy66nP26xZcOJrbMX1BW8S+Ug9l9qTMtgWV3ubCxPIAafhd2sIN9qKsf?=
 =?us-ascii?Q?v9K+f6FUx8G6IpH5sIg+WBCWm8GCRXJZ2T4bAbMG3zVxjyXZmXegKTBwlw3k?=
 =?us-ascii?Q?CUonQPvwLRxb50Ee79jsqSEvCDLdBqhgwT3E1Lepr3dno1GqKsv/l0ZOPBLc?=
 =?us-ascii?Q?tvugYpI/Lkc+vRXdULNQg0w/awukr9gdaHW9hxlojcP3SIze4xdO9Zq35p33?=
 =?us-ascii?Q?EUpjiZs6O2F3uYkbDKqjJuHh0DsW7X4b54sSlhazh52kYp0sJNVmZZvEM+Ua?=
 =?us-ascii?Q?YXt5jesyARByMZDXoAPTCcQg+0PCTXpn1+6Ge85C6Ukhbz46aVIs0vgoC1+E?=
 =?us-ascii?Q?gIbTP0Z5fd2yzfuxU4aaIVr3hgURqtmS/oURn7wGIrvvGhzo0cLjYKZekizA?=
 =?us-ascii?Q?7oiK7VbOkg/oMyZeTJgvwH/w6vYozs/fE3dC/XIArsFN1QwxA2XfS+s0jY8J?=
 =?us-ascii?Q?LmjpNkdCk2bVODTkiqZMe+Ta8815490X3TJkrZ+8llXRwOhCUCZR6G3A+Nq0?=
 =?us-ascii?Q?+ipIWw5+VX+iAdziSB7naeATNHDQOTB12F96S45jOZx9XX7ybDaAJbsa1Gh/?=
 =?us-ascii?Q?TycBEZV+GgJ9bJqdSLOneK/uMpgH+bEXStETpdznqvCRh3X2jGESMDKZ2Uog?=
 =?us-ascii?Q?fMo6MK+cDancqgeVv9xb1QlQ0toeWDeGJLC8FnkcKVq9Tbm8P2sRcnkz7vvr?=
 =?us-ascii?Q?f9c9fnoIVzRAh8sAOaGHv4LvAzqbOPJUU+HDEXdca7ST6hmWywzUo/Vc1KLo?=
 =?us-ascii?Q?coqexF5qW19i6JtURZNaEiBZ0q4YABm1jREr2vfIoeqU/SV+eQ9Rj23dZO3i?=
 =?us-ascii?Q?hFL3mmVqyOLywXRwmXyBd7SAXcwwheeMjLT5xVcME/vjnWs1QkxnYIq54Qto?=
 =?us-ascii?Q?HWmbodPO/HQrOpVSi9MAipUxCGTj2ZdBgbFsdsr3vP/zmNZDB2V8s1uOX40v?=
 =?us-ascii?Q?tSzYgstpBkDXmNKIu7ryHqISxfZNcQ8V5V+1lp3+pDRPnt2vMp3y/Tb9DaMq?=
 =?us-ascii?Q?yE0FPYR6mTe0sx9jm9gFLg5VUlIyKh2q9oYzNnSC4iCgqpC7Y49s9hy5QYnP?=
 =?us-ascii?Q?vRYY6WTtD/WCRWkOU3lme5b3co1umAAf6MoK0Govo+JogNESw8lJ4goZgJv4?=
 =?us-ascii?Q?GJCJwGmjmYrnbWh3wBfRBlC34h/UTFNRmqDkn0GmnB4EV67tL70sA9GnrTvt?=
 =?us-ascii?Q?bA91qBLLcdJJD+ZX6hqRlILQa7jVS7SGoQlb4Zk3UYzICnhw9y/HzWruolLr?=
 =?us-ascii?Q?eIcsKfm4kCHHukE7kdDI7/98j7zxNbiYIuzOMY0IldeXAgP1To9S8Kd1Ieme?=
 =?us-ascii?Q?audnMPLKOdXfuVEW1MqZHzEr1IwSpNcZDZHE2Ti+Ee7OQuaXgXmZPaET/m1+?=
 =?us-ascii?Q?cnpSXmOKNkndoifhlxdPplCCS5GRFzr7cKl5wS97ZJG3MNYg5Sv5qeCVCkGW?=
 =?us-ascii?Q?iOPbcD9U2lYdiuXT2kUlnpxgz5n6c5EMwOwEwrTCoyA8HV9/GlaffVTA6fK6?=
 =?us-ascii?Q?pfh/W/06x4x5jCQLLiYn9TLNax7oUUwsmtwKwPXKsrzpH9pSafyWfXA+qA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?odrl0+mWBQ7kpUERczvybm96Nz2Yyv+m/b6vkDJuuJYkOrwdszfud9/RegIe?=
 =?us-ascii?Q?6S/QT2EM9WssM8CfGUCMqHOZnZZvhlGXYTc8sZqu+DhDrJsiDjpQWVrRSNm5?=
 =?us-ascii?Q?gxeVfipZ6PRcdIzjByg1cR/cUWc4JVzT7TZ4+yZlnFeEgUH63vZXDnIozhwZ?=
 =?us-ascii?Q?/zHpjOo4At1DMDN9oZ3mTpf+WpG4ehSNRNalm9krc1pnqqtOl6brHQEtnr6c?=
 =?us-ascii?Q?Dt0ZeQgbM8adxSAffN7+43ui/yXR1mj3Prr1Rz7+Xp3hFV+O11Jgf9PmVJbU?=
 =?us-ascii?Q?Ud8lEWzMb3Dx6toFN2u0+EayvawFKkunGkSlsOeToHrYctnxvagjZZNW7F3o?=
 =?us-ascii?Q?En603mp3gMeMV4U4VefI8UTgzB/GkVXt7EOOdCEj3HqFdPuw4P5OlSOhy6ek?=
 =?us-ascii?Q?P/kgw0lfzvnshICn/cuEq1Jz3edrlHZT9Jq4DCfP07GgEwZiKBF2ChHcuw8c?=
 =?us-ascii?Q?FJ5ny8Ow8u6WjHzITg5IXvLYRJYNytnuq94NktQ8Thycf6AcA8Nll7paR24/?=
 =?us-ascii?Q?zRcPOoC3fGmvYV4CQIESQINnW+1swtxRUKvwyzOnKHFHuC5E/ZjlMZOkVrPd?=
 =?us-ascii?Q?/Vj/1iVkVp7Len6DdTOjXQrt9++OPj37uBLdfrn6RFNtDU03iLnHRSzILcRJ?=
 =?us-ascii?Q?e9+GF+rGiTh1iw9JcGrM+D1VoFscaSXcDzZIboA3a3KkEmOmgSHqx1sHObS6?=
 =?us-ascii?Q?znxSmmvurlhfSQ7l99Tzyv2YHmUqGdUKiYp67AQxKo5qLOQnolF1fg+276ui?=
 =?us-ascii?Q?a17D0X76gWvrNMZJmCgwvyWRDv0g5/Wc79nQrj2CjCk6K1yQWcajmCX/cTkI?=
 =?us-ascii?Q?4FIYo2EpsCpEJsHc5AXzB+dckLfUdqs+F6y+pHtLaSg56Kx5iNXO6T/x6JNl?=
 =?us-ascii?Q?8oyN1wlo4lq0216SNsZmA3J3cruiV9WIg5P+B2BPMSGOxFaHnTr7+IGrlUks?=
 =?us-ascii?Q?qEs8NjZgYprK48aGN6rL7NMFSdiXUhyt3Dtd5jGRYgRWhUtkI6nbX8z3LhjQ?=
 =?us-ascii?Q?m1fdUBUafflblAb07TjqBzR2RUR54IWswVi95wElywrntkNH0I34FGBKre3n?=
 =?us-ascii?Q?QcgHMVDC2TfoVE26Nl+PUVNNfwjBR6NLc3qPKx5fwH6uNQjV1b8qtKggne0g?=
 =?us-ascii?Q?qiv7QXe6lDRRQExcXJRWLBGZ6IGUc/q6ZTrEmWWnxKtYoRJdXkIS6qcVu+li?=
 =?us-ascii?Q?oa1iUqXR5wYZdPK3iqPdhTZDINuSgMfSq/zul213KLRf4mT29OpaPnTXH9WP?=
 =?us-ascii?Q?R2PMzl1PN96lZQeTuOEGLgMYtLT/JYsEpcOalZ1VA2ZiKahbmUOjRoqpCcqO?=
 =?us-ascii?Q?LxgoB7QOn+0Wbm2n1kZHCmC/QzXXC2bM1nJC/u2h6/XOcVRHQWYIEAU7FsPa?=
 =?us-ascii?Q?UqOJsL9FO3SuegdROuLw+9Um5YtArdMooCmc7CdLZ8sYaiAeOZi65s+Js8o9?=
 =?us-ascii?Q?zXl3DzRGBmOBiSDLTJP4IqKEl2Ec3brV4ndrsqwvDAxEb2mMXpKn8ikwEe4D?=
 =?us-ascii?Q?ye6XG8ryYJdxczYj3mTDKcG2ZGy41MXCLq3uiXUQvU8Nm0jwhKRjqaIe9uyK?=
 =?us-ascii?Q?4pgMZXoy1YarpYCHl76uk5VlC3NtIjmMnbx3supAkv+/6L/pPd4e1BqMOy4l?=
 =?us-ascii?Q?VAbBUuSQ4UsD+YTCuQaZiyM=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026be57f-c703-4c76-758f-08de10f89bc8
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 23:21:48.6021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQRCiJhN9kGSex6vRcFw9ZULu+E9b5HU2fAHjVGMde2nVoFrpmt1cAJiODpSui0nE5E6C8UeQ/VG20ebTmF9rrF8oKymMp24LhDPAQkXl0oz01us2sTX371zrHTpEWOc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7043

Add cputype definitions for Cortex-A720AE. These will be used for errata
detection in subsequent patches.

These values can be found in the Cortex-A720AE TRM:

https://developer.arm.com/documentation/102828/0001/

... in Table A-187

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Will Deacon <will@kernel.org>
---
 tools/arch/arm64/include/asm/cputype.h | 2 ++
 tools/perf/util/arm-spe.c              | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 139d5e87dc959..0192dc7ec9ca9 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -96,6 +96,7 @@
 #define ARM_CPU_PART_NEOVERSE_V3	0xD84
 #define ARM_CPU_PART_CORTEX_X925	0xD85
 #define ARM_CPU_PART_CORTEX_A725	0xD87
+#define ARM_CPU_PART_CORTEX_A720AE	0xD89
 #define ARM_CPU_PART_NEOVERSE_N3	0xD8E
 
 #define APM_CPU_PART_XGENE		0x000
@@ -185,6 +186,7 @@
 #define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
 #define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
 #define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
+#define MIDR_CORTEX_A720AE MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A720AE)
 #define MIDR_NEOVERSE_N3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N3)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 71be979f50771..9561951a00554 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -571,6 +571,7 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 
 static const struct midr_range common_ds_encoding_cpus[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720AE),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A725),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
-- 
2.43.0

