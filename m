Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022136.outbound.protection.outlook.com [52.101.101.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D73793D5;
	Sat, 19 Sep 2026 00:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779360; cv=fail; b=D7nkHjRhHlZSogZIwYSnVNQMIpQ+QBpsHkj49DjSmrYvH8864uaVfeozWmzThsN/0+1mpxkZJc7wP/UhcLgGC2wB3XSrDKIheXeypaA0cP2I+7vU+NfitrzyavS/nFZ2SZiNKdsK1CoCeB7+M1Q6AscKILJ2FUPTFip1luviLRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779360; c=relaxed/simple;
	bh=x24ZmTHBXsAk5BPrPRjAa5DtUj9NBdAXHv/n3V+pwlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P9yUjtwgnThzxJZrdgU5WwUzcRHmPW2GGyh1Ug8/bLeNLCoG2ATL2KtPn7hLoozeE6MLe0P2CC0CcUTF06nQzVdZEH4IcbVlbIUPw1kuyFTZabiXda5s3zlaoCFGGSJzTPbTtAS6x4MesZvW3urzlaITrEeJp3lcvU21TzGXoFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeTCkuJlP5lLTWZHnEY+dSct9+nNgvlDnzCtXtjAtEk4x0FsEO3p0bPMpkoP3ZqMChEfU4Ycq2AId5qoQtDwi56Rrs6jiGTNhiYhMYxs5ozFK4w+VxUihDOJtjYtAyd8xFSAWmHfLnPCoAlt2t8AJzagjrC1iESlwH/Jmw4qgQgJhYzFAJ22XBo2S+JQ6JwJk99eUyT4qeiBtFTbmUy8ieXLqr7muF3ElXimuIWuwww7nl/r4JEYEhh6Dep39L4CBY7/yCay39sOPQ9mz+sS9N07gd3iJmmRMcYuR6HUTFJQcbaok9NChKfHNQNFuu/TBCTvdUG7/H5KSw4r143HpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=qtwNUEQ6P1aVdHeKLYPanHhIQHzxTZXzFfhkJLV/8E8=;
 b=uqDmXD/voxXnxJ4+AUgeDznoNOzp/YdsowEKwWZFd+l57W9noJVKehpMMBeaTXg6eb4L+Za4ooSzBJrpbrGs0CGqvsJaNQeHFDadDXiZBuNzHmC4rZt5+F3KeM1C+jxVC6hcyhdmo/tTZHAwnasTiR1H98W1YSEchCFKcQ006o/pPxL1gkjr2uybjdFzUV1x6+7W+bbol0Hic1Eta3xFY2A9YXA+pPDo9OhbYVe38LbfiZDA2oZYL5U0lidysn3Mujh91ML6Lpa3aJrEho9TDjyeeFQ1StkSwE3//RKAd2yA8WMsojUEPHqsyGW8VPrZ+ObF2uVS2RUdnrFyA/+3nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB2769.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sat, 19 Sep
 2026 00:55:41 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 00:55:41 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	howardchu95@gmail.com,
	atomlin@atomlin.com,
	neelx@suse.com,
	chjohnst@mail.com,
	sean@ashe.io,
	steve@abita.co,
	rishil1999@outlook.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 perf-tools-next 2/7] perf trace: Validate payload bounds in augmented string beautifier
Date: Fri, 18 Sep 2026 20:55:25 -0400
Message-ID: <20260919005530.728615-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919005530.728615-1-atomlin@atomlin.com>
References: <20260919005530.728615-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:408:e1::28) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB2769:EE_
X-MS-Office365-Filtering-Correlation-Id: f3aa404a-6b4e-4e30-916c-08df15e8ba45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	L08boMZzsgzONsz6h9U82dmayq1XfgG+u4C1BgFeRQ0iyh1lVFPb56xuXu3vZ2ToT6l8gmZEEZEpHNYAXTkd1xNqbe7tePLDx9wfEcAZE4R7K+25lqNoL1bMVJgs1txVwFYp/jhroTP1z1Lb90zfVW8ExdIOLB2MGOl9bxTMtG3zjFRdQaLJdVm/726EcSJZdLfpdYO/jvUGu/xCwjkI7+wvoeI6yZ5ySsE2FXJKJgTxo2x5HMXfjn2U4iIOkDSHOpZHl7T69vKcDFrJ++39CBDunKstPa+Zx9q61hkMy6/BxQ6ga+d0EcqqXxHvad3hQ2kyntNgOXEU+I2ypLgx9ivpExkjSCz3EI2RH52hWsuW45vQbTapg1dyi6IoK8vUt8QAFFr6BEU5XhlJdARTv+8gu8YpmGPjSixO87aUyKKeKIigD3xKaS4fzPJv4a6soNtxOxnhYKUz8jFDtkdP0BdSiDSLFewGEbz1sSu+bhcqNGaIFgMkmc80c05Q3I5awEUSTXWglbNbRFiRYmgGz2AwRGc2QrU5KhMgqxoel6Lr1pyFpnV+suUmgFLF2Zxo13k/yTz9c2rLpWJ5IfoDsGkNwMKeYYsBznTONk5OXh/DIy04sCesSZTu4qOr0PQsPHh3y3qy7nL1ijFXiML1eJBZcGN/ZXPuEqVGcxQjITA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+9sjpX+sqqrVEHoIYI47qC0FbyfGql4egaBVPDW2Ma3WuOxcrJZku9CbXCu9?=
 =?us-ascii?Q?HtyFJKSjwF+WUwnWeMXOGENXYAr3pjyjB1g3X7uBOIsrP1nf/vm5ZHR8tAQD?=
 =?us-ascii?Q?MW5+eah6g2Wmhs+g+Vb9wfZuY9bcJ3Yy5znfEnt6i9Gz91Am3+BeaAdrzBvf?=
 =?us-ascii?Q?vMrHqbs6n3t0IxJwhJpnujlRYLCWC6ZCEPbPXjHbbmefuG4lnxua+Ha78cE+?=
 =?us-ascii?Q?j7rFH4//VsgYzr4dmpwhiU8OhG05pNSplwJplBnwCO/dVyRJmt7NJpAIls6H?=
 =?us-ascii?Q?iWNWUmsMENaV5Q1VgQKmsMf4yswaoZQN2Udqd84r7xcNAkFe+BgH/pzryBRZ?=
 =?us-ascii?Q?tPSUNzuc5TORxp1agEitTa+jCJPifjKKbYaQiSXIN8VutknTiPy7C8sHTjyY?=
 =?us-ascii?Q?yn+vLrgb/LY5yoFJJi4YkpbbNUyrBAHbnjPt5Hmf06UHO2bAyE7VAS1TSbzC?=
 =?us-ascii?Q?u1L4iZj7/LqwyZ86sTObF+lYeHIDmZmRyxRH1GlcCly2Iul3ziOE2NvVaeRx?=
 =?us-ascii?Q?efGWzi/Avv3d8ETIVXrPneB2Q5kcgyTVGxhetnzvu+0QJkSjRRSkwvOkLxeP?=
 =?us-ascii?Q?vAC/5jTHg3ytrlkQLAjACDfo4dEOqimIVmrJgX1jWeA2xQLQ9ZML7J8XXB5g?=
 =?us-ascii?Q?3bvT34XYE2N1XZndhWsRL7m2Qk8CS51zj8qCQwVF+f6YFDOj+BnK4Zbo5T8m?=
 =?us-ascii?Q?8uF0qsovlSUbGNKPqh9ROYqxgdRChIcVhic8dVdH48AUCi86xc1cQ1a+VIFe?=
 =?us-ascii?Q?I+lzSPCz/AfkJZ2yIf7tV+2cPgh/cYVOVPMtpNkj+kqvcFMu7fIFipGv3Py9?=
 =?us-ascii?Q?/rJa4jzoWJ9Rq+KXDJQjtjqxHGaCTaE6O6FRTinvIGpqjApC8WiT0jBOckCZ?=
 =?us-ascii?Q?MPR81NQ8hTQWq5VyL//I0cDC4g4myMozByg88/6DIkBL8UVK2q/pgqo4HOYS?=
 =?us-ascii?Q?CvckOCEB6eJqK5I87EXMLiAE7HPo2Xnwn/m4Tp0NoFPI5M/LivWzG5UffbBS?=
 =?us-ascii?Q?rz/7MpLfaOm8roH/u21CAXsPh9hWwCwLlrBpZFKZNm9uWhWSkE6ewSWXJZsH?=
 =?us-ascii?Q?7DOHDfhBn+QsCvqoxXiUFklBwOB/qep+U+4N1J+Y3xU9C1aTIkBQFKJhBfUS?=
 =?us-ascii?Q?SyXQ6GXZNuo91NoOMAbZIxJP6B5ceZApestqhvo0OHmupwNdCEcYEnr+jxS4?=
 =?us-ascii?Q?7JFsRdjzHuDcJsvHenzdD2RW0LGfOFQoCVlmpyO59zJUTKap7s2iQkPWB8qK?=
 =?us-ascii?Q?ryHLp2bqEzLXkVJbs8J9BBwaxwNIvCkky1r+Dj6+NE6beon6rbASsnxIE3RK?=
 =?us-ascii?Q?GjLw2utk6iheQQo8SgdeKC8Z5Qn833s7VY3WWWlaVJNqOzYNAN3FGbp/e1vH?=
 =?us-ascii?Q?b2BfTJcQVdxe34GGGeNxmP/NBOZIEfKtKulRWRPtE8D3BVr2M5RjvlmgtO6/?=
 =?us-ascii?Q?FNXq/CyANbi6mEaq2nJX7MxVJWLZRHGoUCL0rHatALBQH/ZNYnu0oBRbv0h3?=
 =?us-ascii?Q?lWmINV5po9iuk4XTaxrTe9KPAvz/oTG3u+XOgoX2+ZQf3hgA4NzoiBJiz9cI?=
 =?us-ascii?Q?EXVL4K+LYNFR50oCetk3OxHibZxNOGJJr8PyNiVLKsf703oFsIfzet2AV05I?=
 =?us-ascii?Q?Esnq2/RzZJkIVIbL7YywL0/4F/KZmHEFnPtwf1SysbiborcAYnDJ4sRF5Mpe?=
 =?us-ascii?Q?Syo77QYNirAhaezw5+ujrUYQlkFV0zbHyoLCXWTVd0M+UuZpwJE2je3GJ37W?=
 =?us-ascii?Q?HqmWX83iXg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3aa404a-6b4e-4e30-916c-08df15e8ba45
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 00:55:41.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXKILzDSQWPtokIS7F+mU60y8o8dXDtVPcuq5PMpXhh6C8xLv5jWoLVrTn4NNP64ChlNE2efbajRNRw0bTx/9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB2769

When pretty-printing augmented string arguments via
syscall_arg__scnprintf_augmented_string(), augmented_arg->size is not
validated against the remaining buffer size (arg->augmented.size).

If a malformed or truncated perf.data record provides an invalid or
excessively large augmented_arg->size:
    1.  If arg->augmented.size is smaller than sizeof(*augmented_arg),
        dereferencing augmented_arg->size reads past the available
        buffer.

    2.  Calculating consumed = sizeof(*augmented_arg) +
        augmented_arg->size can overflow signed integer bounds or cause
        arg->augmented.size to underflow, advancing arg->augmented.args
        out of bounds and corrupting the parsing state for subsequent
        arguments in multi-argument syscalls.

Validate that arg->augmented.size is large enough to hold
sizeof(*augmented_arg) and that augmented_arg->size is within the bounds
of the remaining buffer before printing or calculating consumed bytes.
If validation fails, fall back to printing the raw pointer value.

Fixes: 8195168e8779 ("perf trace: Consume the augmented_raw_syscalls payload")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 20fffc24507b..91461ab927b6 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1898,12 +1898,21 @@ static void thread__set_filename_pos(struct thread *thread, const char *bf,
 static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg *arg, char *bf, size_t size)
 {
 	struct augmented_arg *augmented_arg = arg->augmented.args;
-	size_t printed = scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
+	size_t printed;
+	int consumed;
+
+	if (arg->augmented.size < (int)sizeof(*augmented_arg))
+		return 0;
+
+	if (augmented_arg->size <= 0 || augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg))
+		return 0;
+
+	printed = scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
 	/*
 	 * So that the next arg with a payload can consume its augmented arg, i.e. for rename* syscalls
 	 * we would have two strings, each prefixed by its size.
 	 */
-	int consumed = sizeof(*augmented_arg) + augmented_arg->size;
+	consumed = sizeof(*augmented_arg) + augmented_arg->size;
 
 	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
 	arg->augmented.size -= consumed;
@@ -1916,8 +1925,12 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
 {
 	unsigned long ptr = arg->val;
 
-	if (arg->augmented.args)
-		return syscall_arg__scnprintf_augmented_string(arg, bf, size);
+	if (arg->augmented.args) {
+		size_t printed = syscall_arg__scnprintf_augmented_string(arg, bf, size);
+
+		if (printed)
+			return printed;
+	}
 
 	if (!arg->trace->vfs_getname)
 		return scnprintf(bf, size, "%#x", ptr);
-- 
2.55.0

