Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022130.outbound.protection.outlook.com [52.101.96.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9FA1A9F97;
	Sun, 19 Jul 2026 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784420124; cv=fail; b=jRNhmxpWt9Bub6+RUuoNAoLoQO6RzM/V6u2dEMqU03sHZ+2sybzIilnBhsKXX2TiV7pVRRDvbIapSCv/CrBhjCG2bwIgUDBMNTDkDxVDAX4JzRfL/CAOtlSh/ad52+TpEUE1JHiuFvg+xg6vhu1xcg0gJ3kfhuP4QDxquLmGO0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784420124; c=relaxed/simple;
	bh=xuu+U7s4Q9gQ42RVBHAIejE9OR7VgbIuUetaDnHpMwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PqcC7vRgqM4CRW7gwuEmukBP7qJWEWNtcLZRo62vEMXqqQ7gJP1GMNETEvsb/x3jd1eQABgc+fBBRdqlWPY2M5bCtXWLa8o+e+gmwYdMDDj1qE8KkLxOrEisb/EqA7zRGZd0T6Ak7xuoFuRYR1an8Y7js4R453xv17j/8ne78fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDKSC1JNECZlQYgEwlftGz1hFLkley8XZwmYYSTCZ3YNEsrK/4vdFZAlVEKcbUdH8nvgVI5zHB1otfhfBCsj1GKvrcwIoDIZ3QeSwwm+bUncSasHQ0Nnl64XpuLdIh/ztgeR0QVliiXp8OGMzbd6fq/xzwu+2W7EkyEcUG1Te1qG+CggMg/wnBlKfMZRfpS+lblaFMvVVmXXhER/uc1cYIBpGCHgs8W9m9z6yc+HH69BtdnlqL+LC1VF4n4iXBX/h+JLws5+CmUsfiKV6carfaYEb3VmD/l7/8ZvxXc7Is4sGBKUFWigAsmV6mhqJRtZNKckzOXdx7L/nY9ijNukRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=W0nuIozz830FNSpPvB6smgcVaoegCC8FGOTkRJk+nYo=;
 b=rEOgp/H07lipGFCDen+LYsT4qOcInhzGrMgqUbfVLgKg1q1fHSZh0C8vDzN3qBx6srQchhXv11S/XfXU6++f/mQlG2HGuVVatR8MCL34N2onNIrhycdxp0zPkbZpiEqavJ3I2IEjGB70Pm0TQKWTUTxfbvPy0LZ6OvRohu1Bh0OBKPEF5ecWjLmicxiO6vVY+UZgnYcdAFgFVUL3vpvzYx+7MXGsRAp9IKIenHItT7ILxmyaKQuuGrqjpmx79zHju4FArmM1A+jZQTUT1Vj/AzsX7LCTT7eLH9Qq7g6oQH7R8XFdPUs+Th5lUDheZk/mK7uG96ntKbr7ao65d/aGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2b2::11)
 by LO4P123MB6514.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sun, 19 Jul
 2026 00:15:21 +0000
Received: from LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3975:c5e7:bc1a:f383]) by LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3975:c5e7:bc1a:f383%4]) with mapi id 15.21.0223.013; Sun, 19 Jul 2026
 00:15:21 +0000
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] perf trace: Add --bitmask-list command-line option
Date: Sat, 18 Jul 2026 20:15:10 -0400
Message-ID: <20260719001510.398616-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260719001510.398616-1-atomlin@atomlin.com>
References: <20260719001510.398616-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0664.namprd03.prod.outlook.com
 (2603:10b6:408:10e::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO6P123MB6616:EE_|LO4P123MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 39235aeb-ed1e-4202-ba56-08dee52ad251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|22082099003|18002099003|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	zr4deG/37pglxQiWENGvnspFjhOLCBEVwIy44Yjm/hYixq2qiXPmN0sEen+T/lqTzJe5fUEQoRZetqVURWc5ByNqbFINILB9asD66EsBZ6JuxI7C4AswI2qdhwPTHyRsjxX6tHqxl49gbGwymopxqAUR7BH89D0cz+zREfAFwcQwXr+BO8B3VD4qQoYqPZRYoxeo3kFc+tl/HQL4Igj4uq1HM9UKHZAOVH/LmGkmpn31JdgoYyxqGmuYNMxca7tovJCGp1lp4Gbmtg2K4H/Xx6lpEcxU20SYXhmPA7/6HFZwO7hIGjhDBmecuXk4Yz2gRd0lHzR6iGPw2vpnl6Hq9PBqcUjA2aZzbO8k4ZpYLNsfAi1nYJBc/ePrItHQuag5H88EdZ+gOtDuykZTPr1BO3V1Ina4B8iAHiWblHfEFUmoW5LdkPz0IoXKvvOggmcqeXjmtl1/mSCzpyNYp03ESYSAnBhlC6hRPrvNEC5IemtwLUQCMALqU1cfFc9YjxK69T4YULJhXhD1ECkjelrLPL7aLrZauHNQKhIS/snR193/NEOzsqRV1gN+3uoaT2Gi8Uw092E6LY+b3Yx67idCrEG9lqOAKQ3bXz0EcYxip9d9L/D70LSxw/+bUQ4RskcXLEpQAzqil6wSmQI4hqrZSlwK1N3/QWygOHkHRDpH2YI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0tYand6SHZzMVhSNmt5cUNmU0NRWk00eDR3Q2ZpalhJeFh2aWg0d25SaXVw?=
 =?utf-8?B?b3diSHg2TzRhWmp2M21HemdpekNDbjJtcHBXcWtDaG5ZYjJvRVM0eTF1N0dh?=
 =?utf-8?B?emxBU2ZnUUxRV2x6VXlNaXJUZlJFeW9jVmtZc0RVN0pqV2hJRFgxMkljVlBi?=
 =?utf-8?B?c2RId0p0Qkp1WkIvUkFDdmlGOHo5K2haQ2dmaXZYOTM1QzZDY1NEVitPOThw?=
 =?utf-8?B?aXhqQ0lBdWt4NHlSSW5MRmFKVTR2MmIvTE1hajVUdVhCSEVFRUsxekRhb3dq?=
 =?utf-8?B?ZlhWVDYyM2pBRVFFcUZ1UkQ4MGlqYzJRSFdhM08velFCUnV0RGhsTmMxR1B1?=
 =?utf-8?B?ZFlwWnA1ZXdYcXF4MW9pRWtYY1Rlc3dUemZ6VGxGNTQ4OWNHdk1ycjI2YjJh?=
 =?utf-8?B?ZGFKY1JtSjhwV3IvRG1hcmN0WnMwN1JXS0VObnZLVDh6NWZEcWRHNW9WLzQz?=
 =?utf-8?B?WWhCbllzSU1uS3ZRZlFETGhtWndPdFVLN2lzSHR6TzVBelIrT3kvVnRWQTNu?=
 =?utf-8?B?ODVoMkNKcXFkaEdoUGpCUklpRk90MVFoL1crVGtoOE5PNFBIeDJERUczWitY?=
 =?utf-8?B?dWZSUFl1V3JYeTU5Z1hYZ1hDU3k0Z2FqRXJDWFpSaGQzZWswbU4ybm9TUlRU?=
 =?utf-8?B?WTF1N21VQXJKS2diTnpuNVNNUjRLajFJVXlXQU5GaFpvdHZyWnRvczRNZFBH?=
 =?utf-8?B?ZGNFdVN0M092WHMyNmZUN21ma0dNTzJpc1lRa2s2Z1Y4NjRNMnhvRHNqcGY3?=
 =?utf-8?B?cUtrN004Q2ZGOFpSZ1BXRWQxK0RLZEFsWGRyVUU5a2dCQWp6a0RScVk0eU50?=
 =?utf-8?B?UTg5bWhRUWZhWWJ1SWVta05JNUkrRU84eWlHUC8xME50NmF4Y2tPa3lzZG5v?=
 =?utf-8?B?N2hqTXdNQ0ZKbHc0ZThuY3FyNHBVTnpMTGRrT3JDTWViK1hCcSt0S0lmdEF6?=
 =?utf-8?B?NU1xVzgxblZiNXNTelVxbXgxUDZhcFc5ZTZsWWRHQmhLcSt2TDA5MTZPUko5?=
 =?utf-8?B?ZEFHaE5TK1BtU3p2QkkyaFNzK3lkZVVkakVSZHBDOXNVeGV2MnJaWVVHU0hw?=
 =?utf-8?B?LzNJbXdrYzdjR3B1V01NV3lFUEFLenJqQnJhTVpMR2pkQUc4VUVEVG9YbjBF?=
 =?utf-8?B?c2w2cXlKVkhocVBGTUxmQ3VCWWlBQnRjTDVOS2FuZk9XQzExMGhHK1AyUHdk?=
 =?utf-8?B?SmozTnRRNndQZDB3NHVxQVRpdWg2UWdhVTlwWm9LTFNzcE9vQ1R5RUZ4bTNF?=
 =?utf-8?B?MkpqU1FNT2FFclJZQzZ5d0ZYK0xRUERVemU1WTVwNHJWdVRVTVRZNHNiNHRN?=
 =?utf-8?B?cGdaK01WeEZOaTliK3hDRk4wMFl4Z2ZjNk9EYTZ2NUhWbzFLdW9kNlBFUUh5?=
 =?utf-8?B?Q1lOMW1pbzMyS3k5Uk1lS2g0VFB3bXhVdWltMlhUQnpxVTFvNUFLc0lNMWw4?=
 =?utf-8?B?cTBPQ2dxSENwNXREVXRrdGpUNFhXZDJ0RkFhaEVjd1lrRTBHdG9RZDdSMU0x?=
 =?utf-8?B?VVhrN2Y5am9TdWR2M1FJU1NyM25IZkl4OFBobE9GU3I5djB5aTdhdEUyYTJr?=
 =?utf-8?B?TlBrVHlqMi9aLzBJVmJaWURZTi9IS1hMamxnZzNZRUZ4MDNZU0RPcFBtSTl4?=
 =?utf-8?B?TndQcHNnU1hqVlZnOEVORXNrYjlHVjdsTHRISURUeXFoMDEzd2tVWFA3NlNi?=
 =?utf-8?B?c2FxQ0ZJQVZYWkQwOWt6Tk5yL0M1TUxOMnJNd0xWdUdOblFpOGJLeGNVNjdu?=
 =?utf-8?B?UEhWSll1VUZFZGVJRlJhckMvQWlwZTVia2x3b3dXVHB2WGZJTXZqNUh5UlVK?=
 =?utf-8?B?S3hiY0RpR2dXQXEzbDIxV25kVWVUK1BUQ0dJVnVJYkFVZ2ZveVRPWXlNbVhH?=
 =?utf-8?B?bHZGQ0lOdllKTkFQa2t3ZnN3WHYvOGxUdUp1ekcySlBJd3dXZU1TSXdTYW56?=
 =?utf-8?B?VWhzR0Z4eEVzNHVvNGx1RXY3V0lMcnpxRmNjL0QwL2FScXc5ZkpnOUJaZVhY?=
 =?utf-8?B?ajVUVGxYaGg4WHVGMnI3WlBWZm1sWTRlbkhKNjFVZnJpQWYzQW5Ta2YvOHdL?=
 =?utf-8?B?RVNPQWhmVVFYWldOV3dpbFdRa1g0ZjRHTnBHZ2NFU2ZvTjg1ZW1ZNjJ6TVFW?=
 =?utf-8?B?My9ZSTFyMWtSSG9STEVRc2NVWDE3dSs5NEVWNUV5bjdYelNKQjh0RWJIa3JI?=
 =?utf-8?B?bjIrYVFvbXZVN2xNTFRlQkU5UGZuVklMVEVIL2lGRWtvKzhzbWhmY2tMOS9R?=
 =?utf-8?B?QmZBNWljTFo5Q01UY1ZRWFpERldqUWthaklIWEFEU1R2bVluVHBMMWJWbnhu?=
 =?utf-8?B?ODlGRWFrd1YremtBeHVIMTJFY1hNbWxtNDdJMnJNa1VxMVJqSWNRdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39235aeb-ed1e-4202-ba56-08dee52ad251
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 00:15:21.5445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFuue1SulgatfjMHPyKGwTLny+o1eqJllgty0loWN9eMo0Rd030Qhyvkdn+cxj2eO8IGh8uvbUKT3MAbVLp6bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6514

Introduce a new '--bitmask-list' command-line option for 'perf trace'.
When this option is specified, the formatting of cpumasks is delegated
to bitmap_scnprintf(), enabling cpumasks to be displayed as a condensed,
human-readable list (e.g., "0,2-5,7") instead of the default hexadecimal
representation. An example is provided below:

❯ sudo ./perf trace --show-cpu --bitmask-list --event ipi:ipi_send_cpumask --max-event 5
     0.000 [000] Xorg/1434 ipi:ipi_send_cpumask(cpumask: 2-3,6, callsite: 0xffffffff9994f8e4, callback: 0xffffffff9994fdd0)
   694.527 [002] chrome/2894 ipi:ipi_send_cpumask(cpumask: 1,3-5, callsite: 0xffffffff9994f8e4, callback: 0xffffffff9994fdd0)
  2666.608 [003] Chrome_ChildIO/2948 ipi:ipi_send_cpumask(cpumask: 4,7, callsite: 0xffffffff9994f8e4, callback: 0xffffffff9994fdd0)
  2673.638 [000] Chrome_IOThrea/2920 ipi:ipi_send_cpumask(cpumask: 2-5, callsite: 0xffffffff9994f8e4, callback: 0xffffffff9994fdd0)
  2714.228 [005] chrome/3375 ipi:ipi_send_cpumask(cpumask: 0-4,6-7, callsite: 0xffffffff9994f8e4, callback: 0xffffffff9994fdd0)

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/Documentation/perf-trace.txt | 4 ++++
 tools/perf/builtin-trace.c              | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index d0b6c771a1b9..d20b43ea3d37 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -247,6 +247,10 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	pretty-printing serves as a fallback to hand-crafted pretty printers, as the latter can
 	better pretty-print integer flags and struct pointers.
 
+--bitmask-list::
+	Show bitmasks as a human-readable, condensed list (e.g. "0,2-5,7")
+	instead of the default hexadecimal representation.
+
 --bpf-summary::
 	Collect system call statistics in BPF.  This is only for live mode and
 	works well with -s/--summary option where no argument information is
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f8b8431f9543..0142a16830de 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -226,6 +226,7 @@ struct trace {
 	bool			force;
 	bool			vfs_getname;
 	bool			force_btf;
+	bool			bitmask_list;
 	bool			summary_bpf;
 	int			trace_pgfaults;
 	char			*perfconfig_events;
@@ -3279,6 +3280,9 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
 
 			if (syscall_arg.len == 0) {
 				printed += scnprintf(bf + printed, size - printed, "0");
+			} else if (trace->bitmask_list) {
+				printed += bitmap_scnprintf(mask, syscall_arg.len * 8,
+							    bf + printed, size - printed);
 			} else {
 				int i;
 				bool skip_zero = true;
@@ -5589,6 +5593,7 @@ int cmd_trace(int argc, const char **argv)
 		     "start"),
 	OPT_BOOLEAN(0, "force-btf", &trace.force_btf, "Prefer btf_dump general pretty printer"
 		       "to customized ones"),
+	OPT_BOOLEAN(0, "bitmask-list", &trace.bitmask_list, "Show bitmask as a human-readable list"),
 	OPT_BOOLEAN(0, "bpf-summary", &trace.summary_bpf, "Summary syscall stats in BPF"),
 	OPT_INTEGER(0, "max-summary", &trace.max_summary,
 		     "Max number of entries in the summary."),
-- 
2.54.0

