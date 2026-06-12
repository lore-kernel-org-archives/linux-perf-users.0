Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020121.outbound.protection.outlook.com [52.101.195.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0F39734A;
	Fri, 12 Jun 2026 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304977; cv=fail; b=dADmLNuPY9RZMBf3cq1vwekmDwo48jfmp4oyI8lN3C02lsUuntxe/LW9rLwxx8nBLZF4SCt1IWu5JDsmNBfvMeD3mU6gK9LGenxbfPJASD+3YkZ+NF1L1Ny372nAM8PcUSy9Yw/HLL31W3f9/V531iS8/ei6tHZ+w1F42hTFz+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304977; c=relaxed/simple;
	bh=3yGWBtgROLmB0a1kEGu6C7mA7zYU0V8+J1gVAKLMHBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=n0UNSkRVN8fjI0ANkuTp4G7LFjkuZQ2/jC0dtxSalj+LnYlfKteetH9GBW+1TPAagSDnVuYNTLeWHTCtp9l+B6GgKKELZ8AhVNNVn8VB6Mr7i5moTQFxm1lhDIar83X4166ugWJCJPLM7OrZxMO+XVTAjMb+X1vdWTIVSDh0xJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z13q813sqHCmJbc5LK/SvcSFejrMQjh6OvqUaqVuksaDfzZCwdYaXO3/jGvx9tIIKUgBSKsHHw3tc+RzBZ2pwnDPNF51aXf1DH5j2BsMeWzo9rB+BLZ2MTUfWhIJuX3aXWVmhI7tPmjt793L18mzVMR4mG0eRqoIxkX6gDAXd3t4m87QIoEuTgf54TikrY6Z1bZsL8KdsWAQuHDIYbtXrFJdO7tZK1IA6gLzWLuh37k557CFKX5YdT0kpQ4eglaTOAg5FkM9avWHYVwtoNIRNNLX8udSlW6GK4kli5GZoSEbA8zVL6n/JFTvgeD327ydWAxoLWGFYgiczjVdkr/sCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=lec0aCeao/aj2UWvdwnjjKTtkrmXXXRDasE54ubE858=;
 b=n1U90NUT2WQgbjS35FoGY1uTKb3d1/eJesZHJH1SA7AE/kEE8YpOR0BcMU8H5xXvzz6tt3fbrSbDqovXvBI4/fVEUsFEe69sfvKHKIFWWxtIrvROKdva7o2F853Fq+q/ODcM/+pwkQKQgSYCo7UZaBROheG9c0+jMofIQk+U+/ZqsjKfgBN0Sss3r/mfBzdDTaO1VNNqkejJy51ySIqKBlO9SQvaoy9thhdHVDF2sYoj4pBoMnGCVj2QJ1yudgj6jApiqrtxhgpCRg6SW7+2xzzMN8PmxLP2eRCqWKsLMJJHDU2mQGH0YC3N47bh6Ea7kvHelrqfuDdV6PF7Y3Kxyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB2733.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 22:56:12 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0113.014; Fri, 12 Jun 2026
 22:56:11 +0000
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
	sean@ashe.io,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf trace: Fix noise and signed formatting of __probe_ip in bare dynamic probes
Date: Fri, 12 Jun 2026 18:56:10 -0400
Message-ID: <20260612225610.1326644-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0208.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::6) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB2733:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e9e6aa-e595-46c7-79a2-08dec8d5cc38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|3023799007|56012099006|6133799003|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	TsxCoFabJw2S0UNKWdYckOUf4UpOFeaMYrbDeTs4tOiadQwDm5HK4dTJvjcqg3BqFaQtNMVWgg959HSJVjRmeDC4gW6ZUII2V2LV+rQnFADiqH1OjilErr+WerLN3LaxOu61YUoAmry8ZiRg3u557P5HzjtQGbOUker6t96+3dZPNmg9wXC3b8vG1NGXPcNe9g/q3JnWCn4RG570pjT3/aVoVlE9ipFFnAB/I6Kj/IDvWLHSIlE5czJvs8pF4k7hYUzEn43GPhJv0wQq3ixNZXPa7KkQ2CXpo+Rw+Z4SYdwBTLM7BIdU7R8ACXl+anwPv6jVL6oM3UjcKWtu+NuCjZqNcmrsU2pA8HRC9kYcg0IuUTP/nAJsW6D6Hj9EObEi71NFoZr/e6zr6Y9OUIi1shNKmoGD+uWrQQDRG/j52nG+Xd1sYS27tCsodysTiMVWHR27POM1xkuBBKRrxMGQgBnBpON31ZLJckvmSxZAqysDfoXULut8o1uAivoJTSH58SIhahXP0FmN2IaGn0sM7OEW0Um/NiMA5W35TfbaNaPoB3fuNvk2/5sU/8VeithHwAhjI1wE53B4hs4B1pj+OtOyXJ0SC1tT8zu5lIDQ8b9MHwpQK/cS5sPP3RwhWUOBgBRtlT/T6HHj4LUKjG81uaxMHcte+qpOdEf1rDoPsxn29IFvPja344Iz8Tw85ogCno6ejRRLjXujXyXw1nXyYQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(3023799007)(56012099006)(6133799003)(5023799004)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTE0UVozS1duYjUxbmZJRWh6ZVQ5ZmtLRE8yemxRMkU4WFdEeFZnTHY0R3li?=
 =?utf-8?B?SnlvclMxWndMMUxTTEVMLzJmdEFtOXN3VmU1NHNJeExqdlZ0YUJPdTRsMGdB?=
 =?utf-8?B?dEQrejBOblZVUnNBZDlPajk1UCtFNEZZNlc1aC81NWs5TytQRHVsakExdWdW?=
 =?utf-8?B?TFFuVHZFNmUyRjFaNVp3TElrT2QyaXJUcmc5VVBCVEZFb1ZQN0xRV2F0d2Mz?=
 =?utf-8?B?OFNuNXljeGpSY2c0TWRBMGdUYWVJMjFWT250RFVFT3FOL054REppOVRSOFpr?=
 =?utf-8?B?b2FGL0Y4cGI1VUxtRW8yOU5PUFpZQndlejNUeEk1VzZRZHBESDBYZ25iTGNr?=
 =?utf-8?B?RllsdDhlbXN6L0FnK2VCZ1ZOUFNET2p3SUMyZmw4OGw3bys5SzlleCt4cFBH?=
 =?utf-8?B?MDhSK2UzN2pKTjI4TmRhYlNGOHZhdlVmbm1xVGN6RHVuSHV2bHhzNjFjV2dt?=
 =?utf-8?B?cUlTS0dWeEtSZDlySUJtMUlTVXFOU1R6MUVBVVRTSFBrYnMzMXl2ckRDVVRN?=
 =?utf-8?B?MHBZRWg5cFB2eFZ0elI5Z3ZMVzVDb28wMXN3aG9yRkhwY0k0T29XR1Y4bUpm?=
 =?utf-8?B?MjRWZ2YyZlR3UDJ6MnZtcktUdFBNaExnWWtvUGh5eE1JQURkTHd5anlsbDlv?=
 =?utf-8?B?MHRKbWhaL3Z4dm9DVUQ3dVpFbG1XMExlU056ZE9LQmhuUENXUEY5U3lwWnpu?=
 =?utf-8?B?c2RyeSszN2dsdDdEc0hDdzlSd0s1Rkx3R21tOUJneVVOUmpzYnhjM0NvOWVI?=
 =?utf-8?B?dWRsc0xFNjIzdkVUeEV5NXZlY3NJRmszNFg5bTBvVXdHUEhTODF3aVRqY3pt?=
 =?utf-8?B?Ym14UW9RNVdhS2lKWHpGUytvcThkOTlET0JiNjhNN3l4UzNCaWw5bUduSk1y?=
 =?utf-8?B?R2FKOFF2anorbXBadWJCcE44a2NmQWd1cXQyYWJBZE9sRWFlVjJKRFNBQ3dJ?=
 =?utf-8?B?VXVSNzdaUGJvblpkL1FmTEs5SVVtZWVpbkM0NVM0aDdQNm9lNTluZCt0U3dm?=
 =?utf-8?B?NHJWVk1mbmRRdG1wMWtqUlUxVkpqU0JhNFpVMWc0Z2xQbEVuQlRqYXQwRDNG?=
 =?utf-8?B?UlFOZ0RodjJITll5Y2pZWkVwdkw3ZWM2bHNWbTNCRDJwZlk2TGJCUlJyV003?=
 =?utf-8?B?Um9DY281TXRZcnJtWHRRQzVlSHhBR3hJR2VjekVVSUppUER0MExSd2FWZzI4?=
 =?utf-8?B?N0c4dVYrYnNXMk1tT0ovV01kZUZJdDBzN2l6WnNXRTFmQUYxekx2SHRPUkl5?=
 =?utf-8?B?MWFJckJoeXhtL3ppRVZEd0VScm1RNjJGOFd3S0lJVTJ5eEdhZ2NUbkJyM2J5?=
 =?utf-8?B?UTdDUm85ejJvTDBnTlZyYXoweUFXZ1dYS1MwQ0NGQkkyQ0ZrTXcrWnlNNEh1?=
 =?utf-8?B?RFdEUTNGcVhwY3NIRmZiejJud1hDNUpEblFqQng0cUNqcEZZazZiMWk0UlNQ?=
 =?utf-8?B?OEp3MWFFdTlvcmtxSXBVWnlqZ1oyWUMwN0tTQUhpME9pY0NMQkQrNTA4eTJM?=
 =?utf-8?B?cC82UzRNbjA2T1ROdmMzN3hLY3NFOTNkNVF6NU1iOEVKSzFoMDlnNldDYTd4?=
 =?utf-8?B?ZENCQk9vV21HbTFIQ3FjenNwUHo1NGxkaWVVMzJMK3lXYXVOMzJpaW5pdkVs?=
 =?utf-8?B?VVBGWHpCTTZ6d1Mzd0c4TThlN2xJTFFFQm1WWHVGdGpibVJjSjlxNnhKQWFY?=
 =?utf-8?B?K2QzNDVsR2ptUkwyMXFLZ1F4WVhYaEo4MzVPak5tWVROVFYvbVJHVyt2M3lD?=
 =?utf-8?B?VzYzaGFqNkxDUzhFc0J5eDBPY2VWbzQ3WlRVNVVhM1d3b2NIbzcyK29VdjJv?=
 =?utf-8?B?c0VqNzV3R25hM1VvbU9QbW9FU0RMcnQ0Yk5ObHdXWHV0aFkxd0t2bk5jVU1T?=
 =?utf-8?B?eGVwaXk5aXRhdS9ud3ZXNUpnaW9hNWpGZTBsU1Y2RnQvUXNObXNRMlFldjhV?=
 =?utf-8?B?d0xTREJ4NXVpcjhMNFNHaEpHVHRxQm1DNnJFZVlqZlg0aFZCRk9MT2I4MHc2?=
 =?utf-8?B?T2xvSFNodlVSSWFJZE96aTJDek8ycFhBdE9Vd2Nha0d1bU0wc0hmREJzTUw5?=
 =?utf-8?B?U2k0L29wMXB5QWdsWEVDZi9ZS1RwZ1pUZndWU0VJNmFiRXl0TmJmRzVQZFQx?=
 =?utf-8?B?U3JxTEZtcU1HVDV3OEdaaFZCK21JcHVZdXJmL2dpRm15V0wxazZ4ZU5rdS9L?=
 =?utf-8?B?c0xNZ0E4Uno2REdDK0h1eEtlVllhNFExV3k1bW81bXhPQ0lFa1hQYnkxbWlU?=
 =?utf-8?B?akk3S0FsUVdaQXJkbDFCc0VxWXdPVm9XcFFIL0wxbzVOK1VJaDdFVXlrc2lI?=
 =?utf-8?Q?Td0+Sd5bju31I6PmjC?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e9e6aa-e595-46c7-79a2-08dec8d5cc38
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 22:56:11.4437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebURfvA4Zzw0d9T20uyttBLlaoKjYAa1bU7lUqwWj/O27lZtqW5jJ/WF58xcTAwxesaTdxHZF1QkNhfSMZ2VDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2733

When a dynamic probe is created without explicitly requested arguments
via perf probe --add, the Ftrace subsystem automatically appends
"__probe_ip" to the tracepoint format to record the instruction pointer.

Currently, perf trace prints this implicit field by default.
Furthermore, because the formatting logic defaults to a standard signed
integer representation, the kernel space memory address is erroneously
displayed as a meaningless negative integer.

    ❯ sudo ./perf trace --event probe:proc_sys_open --max-events 1
         0.000 ps/1316543 probe:proc_sys_open(__probe_ip: -1406056956)

This patch addresses the user experience by combining two refinements:
    1. "__probe_ip" is now hidden from the standard output, as its
       presence adds no contextual value for a bare probe.

    2. If the user explicitly requests verbose output (--verbose),
       "__probe_ip" is intercepted and properly formatted as a hexadecimal
       kernel address, restoring its utility for debugging inline
       function hits.

    ❯ sudo ./perf trace --event probe:proc_sys_open --max-events 1
         0.000 ps/1314074 probe:proc_sys_open()

    ❯ sudo ./perf trace --verbose --event probe:proc_sys_open --max-events 1
    Using CPUID GenuineIntel-6-8E-C
    mmap size 528384B
         0.000 ps/1314366 probe:proc_sys_open(__probe_ip: 0xffffffffac314604)

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Changes since v1:

 - Fixed a bug where the hardcoded format string for "__probe_ip"
   bypassed the trace->show_arg_names configuration. The formatting
   logic is now properly decoupled to respect trace.show_arg_names when
   verbose mode is enabled.

 - Linked to v1: https://lore.kernel.org/lkml/20260612220843.1320348-1-atomlin@atomlin.com/
---
 tools/perf/builtin-trace.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 48615ddccd93..ac15b5588a27 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3234,6 +3234,27 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		if (val == 0 && !trace->show_zeros && !arg->show_zero && arg->strtoul != STUL_BTF_TYPE)
 			continue;
 
+		/*
+		 * __probe_ip is implicitly added to bare dynamic probes.
+		 * Suppress it by default to avoid cluttering the output.
+		 * If verbose mode is enabled, ensure it is formatted as a
+		 * hexadecimal memory address rather than a signed integer.
+		 */
+		if (!strcmp(field->name, "__probe_ip")) {
+			if (!verbose)
+				continue;
+
+			printed += scnprintf(bf + printed, size - printed,
+					     "%s", printed ? ", " : "");
+			if (trace->show_arg_names)
+				printed += scnprintf(bf + printed, size - printed,
+						     "%s: ", field->name);
+
+			printed += scnprintf(bf + printed, size - printed, "%#016llx",
+					     (unsigned long long)val);
+			continue;
+		}
+
 		printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
 
 		if (trace->show_arg_names)
-- 
2.51.0

