Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021118.outbound.protection.outlook.com [52.101.95.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59827DA66;
	Sun, 26 Jul 2026 03:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785036344; cv=fail; b=CtunZ7PwKJHGKHuwP9KzISQj1+2Vt1d7L7S+Qg2sQPxzG4E70pRpAdmvD9y2GxnnxDxUSEt/Klck20JuHetU9dqddYzcvNA685gnx0X4jVPPyKh1eh21s0pGvvepxMsohl4uMgVg/1j7qRq539FfVX8BmSwK0XG5RGpHCHJr4ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785036344; c=relaxed/simple;
	bh=ntxqSfKC2KgDToB6SsfW1gvaLpV/AGBy8TRTyD+fhOg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lrpYKRf2qAiS1lZmhlvFITyaxNgjYWITcqTxM/9mTj9WUd17O7DeRAPPrriQbmXKqJ1N0ohLVwQlJqny6kYnHOhpW2HYxMUBsWAVn1e3X99vAN16c/eOs1imoq3gCb+2/Afq9FvouOLv4R6q16iedRQ/JVGSHAFUIUYrKzj5Agg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNozyz9OM1TIgCp3ERoTZbdJoLQm4WNqIsQZlMJQ2oj3TdKeyLotOAGrfSigc03f4WvuCvL8erxjEs3CX6KKgDm2N8uPBCp2iqodT+0l4mvp+BEL3EzADEyeiv/86FWLNl6D06+1dcgXKvtiqkwxZsG8hU8rqZh9WMMZE0/caxGTArdEt+EK06IF3iFtPnMLst+RScSQcgA8buLqlw4AXRiGEx8RhqhSE3YwD/H+pTjhuhXpNhT6jTkqDXY3ob6BQ0ANWyFkfS4S6iaTSspg2uHKry1l78aJDOAEynwLlSfufRWot602WYSc+SSvjJea0Ebd3fwJF+9u1nDPQ8QHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=bR0/1wTGsBCJjfY64erxFAspkIh1bdAU1m115nQ0mSg=;
 b=Yqd2R8RjBGuzqWQUKlu+pIj7J252kb5WmuR43hBggAT7k8BTesIzT4fYqOV7Yd7umuQ1eX9J3J4UvhP2y0n4bq/WMUKKJKiwhqKa6Jr8gKw5I2FqmoQ+0W2AJbs73+0tAzHWvkp2H2tQJtYL4Kind9ceXWJz+yniwg+svrGkqbZZm6dFGc2zwWhqjsIzJPJW17s5Y73fOjb/dRbU5lL/MEiQVTCvC0MuYJw6IGPc/uAptPV1i2OM6cRQbjMIVeaGOZladLS4MWPfYoPl8bRz7iazeZW3kz2hBtjcTKFxkSqu4wiSVie/EETZeZVhOCCKLjZMuDfwmrhgp0YtxynwaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB7849.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 26 Jul
 2026 03:25:39 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 03:25:38 +0000
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] perf sched latency: Refine outputs, unit scaling, and histogram support
Date: Sat, 25 Jul 2026 23:25:30 -0400
Message-ID: <20260726032533.712462-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0146.namprd04.prod.outlook.com
 (2603:10b6:408:ed::31) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e10396-f48b-41c6-9929-08deeac58fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|56012099006|10067099003|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	AiBCDhumvTnm620EHG20C4NrtxhQSJMJLpaJc8Fqgvr8Y8v0ngbVRRKMZ2FxAzEcuUJBrTXAVDBDaF+6rrl34lHuSMiU4AyRgqN5PnLIeNOcVqWc0uSrCPG9jEa6xd8sqiw9aRSd+tmKHQeKvs5G0Yp41mxQcpEpC3B6/cToWH5VKHjM8+SLyPBAwqI2a4QkZ0CC2NnjDrxWlnMpOzHYvZyLo1iOPJG7G8Ma0iTrAh6tCkQoFtGyDgkIJAyB7fV1QOQueRfCMCa3DI4TqIMvmtJpwSdJuKoZPq0ExUc/ueqJg5dr+OW2BlgYEnA+6D1hFdS+lDANVUfTA4uqC53vIo10X5LvvqrHEY4qh6+wR4viuonI93wexouK1J+qxRe9n7t867JhG64cfSVe1/rGSYJXqQlH2PvINVJBtTUS5/DPZtR3EVJtg/iHkY9SJZkF9eokWSJlMYeaTmYItYyGldMNrTtzCymYXDoVn/CQSby2Q792SI5WoBIiEZ+qUOVlFMN6fDlRPEspmfE5LDpI/mho0w4r9kPeSMpMc/DfWIhdsen0jiXJWvNToFknexDfep/Sj4JYlYsNq6vEgPBnkDhT6sSRibPow1By5fKujGk4CISsJ2q7JYAac6uq+ja/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?II+PfPBEz4zlXsQatxQUu/U5LQX3w5Ihant8W1IqeFiSDE6svv6or2+obbYV?=
 =?us-ascii?Q?/1S5jDgPzg2eriFo+YuQGMFDhrFbCUSpPV1IYRmBMy5v0YzlM1s3x6uqq0Vw?=
 =?us-ascii?Q?d5woB44CIAbEblJSwUnoXM15BM/BptD6cuDe7lRAZfWwKeemKV1S8oVBMWGx?=
 =?us-ascii?Q?vnDpzg+g1iRdYpHkEmzx85PlNmx+08GYFcV6yQH8QHOTxvCujD3ROLKx9j9j?=
 =?us-ascii?Q?IOU+sb+M5vAGfJbRMnYqvFSm2d3zsPQuBMYXVq74LL4Zbul7c+82qhKTuSGu?=
 =?us-ascii?Q?XvrA/OPMsc/T585PwBEnZcmrgj+09zbum6gBz52rJMwXKOLNwoh1UXHKvrkH?=
 =?us-ascii?Q?8AXCBffLBAJ606HMRjy0kheQK/SX/ggYKcJmJLGDiPqJ1IYx8fejlfxVnpAq?=
 =?us-ascii?Q?lUJuQuvYTpwbvbaCbeBZ6b989T9uKl002YYX22e9wMyP3Jp1hCE9jufF9a/P?=
 =?us-ascii?Q?ZvN/Dc1vd8rDVjX07BZlgjfqcgPVcPv5xK3nNfCU1XUZFn5uQjt3ie1dviCV?=
 =?us-ascii?Q?/rRXAD+f8bjwWxZWU7pS/dXNgRyEnjvqJlQL3476lDhe/i9Tziogo7v2Gze0?=
 =?us-ascii?Q?zq6VLrFIbYLziMFJWozGLno9pIRjYfU3DOUdiElikC/xbxPqtz1I2ATUizuB?=
 =?us-ascii?Q?QdypqCVF8N5k05fA2QqzRUMh8qUkzuFS+fnzIx/yAEdijMwXokq7/TbJ8rG9?=
 =?us-ascii?Q?WTd57JV3nacgezg3XgSPb+FaMsjQbBS0tVkpUXnsT359vxnMFvGf0rxGX2Sb?=
 =?us-ascii?Q?KUB0RRzPShEKd1250zhEAudm1pZhG94qNxSy2xrBddOUUxpo2ROUymhxm1Bk?=
 =?us-ascii?Q?br4zEmGqdYeiv6MBpsiRqixnZEiWGZMO+XVFAbYY/VkH+Cv1snYCuPqYh99x?=
 =?us-ascii?Q?Nl++dprkz2yWSfWKiuGLnt7vd/enpUiNwLLN0zZZ57liVOCtjqhQMMN2cbwy?=
 =?us-ascii?Q?Pv1nuMh+etmhVdNpyUk8dTECT8AE16T8nZKeK5eKzJCZTF6Nhix638Cwhttm?=
 =?us-ascii?Q?Jm6O1LdcBGR6uy+NuXyvwdJCFDUYgpQuWju1RC4N+HJdgMTViya55TolouEw?=
 =?us-ascii?Q?pyljlISfCFximBFMBdO+crAjY8wX6dcXgl1f3K0IvmoPrx52OMrFq4TB4q3L?=
 =?us-ascii?Q?npoZubfH9EiFdWcUnT722qAAjkvV2OAxtd/f9JpZhMv1c+VZG4IHKzRNtgvj?=
 =?us-ascii?Q?sVjXohxoTcfOiraHllfQzoVplt72lodLixY4NldUNasGudlMJpcJN/t4t0YI?=
 =?us-ascii?Q?m8APQoW0HiBqvwbx2Pr6plmJ70EEXgCDM2EPZCJH6anvTUfe8mSI1HJrfJEt?=
 =?us-ascii?Q?fDscOmBkN+oRtCX1K2ip/DXG93sSN6InB7N7P4Hz8ZUpmZ1Sf38CtHi5bMEo?=
 =?us-ascii?Q?W+Oud0A6tKcMDrixm1YmmFWe8fbJ+TozEkvkgGT5WGBPOWZkyqkbMno/gvZZ?=
 =?us-ascii?Q?5C2EYUZJ/07tmoLsbmSq4HkV9mWqrSSpLO+lXv6sypk3ee92TPO+l1GT4n47?=
 =?us-ascii?Q?gk3oiO8ybBixig4VnjaLxvxCUwxKcDeknSolKpy1lCP4SDolhF+DKf1HhyI6?=
 =?us-ascii?Q?xA5sWMj6Px747Dm2UX/34G6ZQjVZgaGvmM8Q18pcpWbRVLftONcfWVFHoeR7?=
 =?us-ascii?Q?BgPVsY4V3CALEQ5y53Hw7419pyyAS1C4B9QxztITYImaMVJ2dAJftMXAJ1f5?=
 =?us-ascii?Q?mTHSh02s6z9+1UzofPb8MX9NB9qPK3/wmNQl+j+wxTXLPDRNZE5J2tnPFaO0?=
 =?us-ascii?Q?HYRtEgcykg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e10396-f48b-41c6-9929-08deeac58fee
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 03:25:37.9934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7qgy/AR+dHaAI9x58qQ1Q9+4oObfH52X2/kJfyLwyBLy9G7tly1EEz1qa12qrqB63FP5/xdTvS4cmvSDtVMjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB7849

This patch series improves 'perf sched latency' by fixing misleading empty
table output, introducing dynamic unit auto-scaling for latency and runtime
statistics, and adding latency histogram visualisation alongside time-span
filtering.

Patch 1 fixes a bug where 'perf sched latency' would fall through and
return success (0) when perf_session__has_traces() failed due to missing
tracepoint events in perf.data. This resulted in empty header tables and
zeroed summary statistics being printed. The fix ensures an early return of
a suitable error code.

Patch 2 introduces dynamic auto-scaling for display columns (Runtime, Avg
delay, Max delay). Previously, all values were unconditionally formatted in
milliseconds (ms), making microsecond or second-scale latencies difficult
to read. Columns are now scaled dynamically to the most appropriate unit
(ns, us, ms, s) and headers are updated accordingly.

Patch 3 adds three new command-line options to 'perf sched latency':
    --histogram (-H):
            Displays an ASCII bar chart of CPU wait latencies between
            snapshots

    --hist-mode:
            Configures the bucketing scheme to either logarithmic (log) or
            100 us equal-width linear (linear) mode

    --time:
            Filters event processing to a specified [start,stop] time span

Changes since v2:

 - Ensured vertical pipe separators align across all latency table columns
  
 - Excluded "swapper" (idle thread) latency samples from global_hist
  
 - Preserved task state machine transitions across --time boundaries
  
 - Suppressed empty table headers, total lines, and histogram graphs when
   no matching trace samples exist (e.g., when --time, --CPU, or --pids
   exclude all samples), outputting "No matching trace samples found."
   instead

 - Linked to v2: https://lore.kernel.org/lkml/20260725173341.679782-1-atomlin@atomlin.com/

Changes since v1:

 - Fixed integer overflow in latency_bucket() (Ian Rogers)

 - Linked to v1: https://lore.kernel.org/lkml/20260724142901.634761-1-atomlin@atomlin.com/

Aaron Tomlin (3):
  perf sched: Suppress latency table output when trace samples are
    missing
  perf sched latency: Auto-scale latency and runtime display units
  perf sched latency: Add histogram and time interval options

 tools/perf/Documentation/perf-sched.txt |   6 +
 tools/perf/builtin-sched.c              | 246 ++++++++++++++++++++++--
 2 files changed, 231 insertions(+), 21 deletions(-)

-- 
2.54.0

