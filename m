Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021106.outbound.protection.outlook.com [52.101.100.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02F2388891;
	Fri, 12 Jun 2026 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302131; cv=fail; b=MWjZct7SImWH5610NY96T4o8r0G+9eUtzAuWYw6rcwQRbJrv0pTvcP9jO8GM6sUKh40FZHTBsLeoKfC26Y6QesHrm+NqS+dUpttFxkccJonnj6MwAIF6mr2imF7FrA1jnq0bH7WRZQ8xPqixZSEtquLe+hMeMj+J7PkrpJbpdEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302131; c=relaxed/simple;
	bh=fmSyLTqodfFQHMq16m8DXsqwCn+8v4YqxFrHZ/8I4EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BSmYJryJop9XLd6gAbm8hcjgPYK68nZkDASfNF5KM8f+l2HBvxWnHl/jKy+ew/4t34Cdee0N190ec0M4sManU5ehBvxopmBE9HIqJHIacBWKX4yHYPTCi6dEDCbQzDyDYBcrUO5Uv4gcgueRgThe4j3lhswMJrJ+Ey+SNEcgbe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWHztw3815ChCQ39KETiy6r1eo5YBHy0bsutL1ZbEvvzGsCMjKZk4XV8boRIcNL802Xsh6y1mh+4PeddjzUYqBTk8jrOeCb55wD2bV8dxyqQD9a0TiVHz5C2IeUogVT2GziZ0FLnFiw+bUfSXUihm/nUlOC9kpQw9DfegVk5869stERonwyzylY2RiqYzGQRFmM3GpTPcDX0u7XXBPtG9dkGrcGF2j/1LblfJFBcL7dc/MDmU9swScFTQkdpP9WSFGEYa6uE4Voq6L6I073k83IPOuVBBAbrE+wF/q/ol0+U/UxxoL3tWWlqjc0ufGXEGRZ7GNvKE/D4vvXCmS7CkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=gJt+nQ5t44Mb5kHMHaNG57I/gLy1haUArrKDHrOCV/g=;
 b=HfKNhPSs/XbR9VeudBLJXXrlLmy6Z2YI3WM4I5rVFkdRnHYzPAClQYK6A5uiZeqXvMXBx4UyOoMC2Tsqg4Kck5iHlbPGPX0Z4pKUQn0Sd0iJqtbPKasWz5VIOlNtHIwnplHTBCsGWMXyYivYWsx/6vY2BmZk/nwcW9B+upbQEg1BWF0Z/6ZQBbvt2KBDh/BYGMGC2u3OOk2/d0j0WrktPHkvnITLKrYjbawNb1KCc27mFwVPu6/8tKCO/CjOfZM42A4tAYYdMxq2uz7kMYNbKURumkEpNSOfcENfAfxojZuZmFVIssA1xZO2bOTiWN7e6qf1sTARY/ensMks5U2oiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB7161.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:32c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 22:08:45 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0113.014; Fri, 12 Jun 2026
 22:08:45 +0000
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
Subject: [PATCH] perf trace: Fix noise and signed formatting of __probe_ip in bare dynamic probes
Date: Fri, 12 Jun 2026 18:08:43 -0400
Message-ID: <20260612220843.1320348-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0520.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::16) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5354cc-230b-4b70-8e7e-08dec8cf2b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|5023799004|56012099006|3023799007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aq0TwuqjJCe2be6qvZprnsLekpcA1T2+r0yzN5efGq6TFvIOUL6F9+ALlMhuXW59nG6prcTDUcCsVfigkYn143zoFYI2001ZPshyErHtW81qwgGZhgsyr+Xud5Eu41Ohn6uxmo6u2OG/KgdzQ2shpU/cttsS8DDdcGlEJJjHCcVQipv4+5bGiej+tAcqHlBzFWPrj65h9MYF1v77H7AzRyZLnMsqB3MjIF7WeQOOAKPmRi/5+ksf/VOFGTovmECyFWFWqM9goKMMweganzPlwxYriLtLnZfIPEDFPPX08gOZOFfmcgLLz5/bIga67Lmx4EFnJKFnKqWjSVSm3QJjLIMHUts2d8CvKaivQ5Ou9Qvf4c6FSZh+JfcD84NuTrSuXEGrfkX/RTD2bhIyOmm5SZRkLCS6BZnfaqelJ8D2Ae/fxBTzyf/wqF4zhTDvimLiQVMuDusewRia/M9i+2zyKd19w/BiwpLWaR79MR28nC7/xGSsMP29RPd8csAckCcEEJ21muLy5+EbRwwGKmJ+DRkoqkZbUzhnbPnTGD3o5OtZsRNHnkBPitDXwRyrPJsQSyacadGZ8l5J+9rN7/MdQgmyT5OGnPTIPB5m4LLsq33fVcrbZuhQqVteu/mOHsSxpDygK9FvPpcgxdDBwca3OJ8D/k94Yq5ojpduQhNeuS2u5VV7ETp2XA9oblwuEN0I
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(5023799004)(56012099006)(3023799007)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHh4c0NteCtFcHgveXloOVphYzNRSVl0ZDY2Z0pxdXNHaVBKVEdkV2JwY0JJ?=
 =?utf-8?B?UFhrTk5HYXJJcldhdUZYZEVaTHhKOWFUUGVaWEpKclZQa0U5OU5HTy80TS9N?=
 =?utf-8?B?SWNBcnRSUzhpclNGTDcwL1QzSFZWV3BiOC9KZ1JMQVdMWjJSSnN6MDNOZUVx?=
 =?utf-8?B?aURPaStJNEtwSXFwUjgxR1ArcUU2Z3RYMW9sVVZrKzRzdGYwcWpqZjVBcWg5?=
 =?utf-8?B?SVhZRkN1WDIrdmVmcmN4YTJzMFZqRWJOSzRzeHpoRVIrTjBMT1J1eDgxNy9G?=
 =?utf-8?B?ZDVRQnkrbHdRcTdmVEFpS1RJQ2tra2RETDQvblJaS3d3Ly9JUmIxaVRYc2Y0?=
 =?utf-8?B?UlBNQm5MbFZzMlpQMUxQb2szaURiU0hsTTdIbHRoSmxnVEN0Z1hYMVlSMHZ6?=
 =?utf-8?B?SkRlWXdRaFF1MkFhVUNBZ3N4a3pjTGwvOXhmbklDQU95K29WaTF4VUYramdO?=
 =?utf-8?B?ZllaZUpMZXZ6WDVxZjdOcDV1MTEzbjRreEpYd1c3a1c1Z0cvQ01VVy85UVV0?=
 =?utf-8?B?SkNKV3ZzZzZ6b0UyeFZncUEzNnRlNi9TRlFRV0dsVHczQU9LSW9kWTc3eHo0?=
 =?utf-8?B?czBtOUczZnJiQTkrc0NLSmhxaHZlb1VDNysxOUM0RHNWT2JYU29EZ2ZvNlRM?=
 =?utf-8?B?M1ZUemVXTGJGZEFickpkQi9ReXQ5cENSekFKZ0tRaHROVnhuZFlTOGFFM3Zo?=
 =?utf-8?B?eVpmeUh1NnhaQUxYcys0bTVMS2NkclgyTitpSHJMZHYwRjV2M04vZ0x3cVI1?=
 =?utf-8?B?bzhiMW1iSEhzbDlxTFdpVFRIbEpWRWg0YzNaOGFCMmxOcmljczVIUE1qb1dI?=
 =?utf-8?B?SnM0MUN0UnNNcjkwcjh2UjVqRVNISElSb3lkQnZpQ1EyR0hZdW1DZ0NUaWwy?=
 =?utf-8?B?bEJkOVBBUGJKL00vMEs1dFM2aFVnZkxkZC9teE1TZkZ2TG03UnAvbmQ0ck92?=
 =?utf-8?B?NURyN0prbWNmdlptbFQ1c2k4b0NoaDVyblViZkJkRmxKSGJyaXFDZkhQanB0?=
 =?utf-8?B?NW96Q3BKdysvMHUxRjhxN1hHL2d1SmFhMzlSUVI4U3ZLNkh1aEw1aUNBdU5Q?=
 =?utf-8?B?S3F5Snk3c2JOZ1ZSY2JVbE5CZkI3V01iNHlkNFVxY1Z3MVFwcDV0MTljT3RK?=
 =?utf-8?B?NzdpbDhkbUQ1Sm1KUnhxYjlZWEVwVWlmSXYrTDZVSUhGeWZBd3FibE1wbUNY?=
 =?utf-8?B?bkhPNDRLRnMwYmxBN21vcmE5aXBHWVdwbnRleXU0cjBMZWdpdUhXaTkrOGVQ?=
 =?utf-8?B?TFluQXdQSjAyNUdQQkVXb2RYVGEvMC9iTzkrNEhHMzBSWjhSVjFQOGJqa0sv?=
 =?utf-8?B?d1BNcmswQVBCL3B3cEJjWGJyeDdRdTU3eXphV2s0Wjk0dldTZHJwSk43ZU5X?=
 =?utf-8?B?TnF6YStJM05SOTAzaW1EMm5JT2luaTFkZlZVSFZOMkR2VWUwTk1waFlKYWR1?=
 =?utf-8?B?T1c5ZVRob2lkLzBiT2VTOWY2aGpweWN5dDFVQWdRdjRhOXhJK0s3REo4S2pW?=
 =?utf-8?B?K0wzVUlmSXBsamdBT1RkSVNtQzFlTkxwUTI4NFpPNzZxMUlYUUo5M1hkeWVY?=
 =?utf-8?B?UXhSS0p2QnQzWXVGajJwWVdBU3VHbzg3TnNFQlhXL014ZWVRR0FRY2hHcjZQ?=
 =?utf-8?B?YTRJcXFvSEpxNWM1M0QrL2s1YVlaemw2a004RDdmdTVjR08yZDExYkxoOUto?=
 =?utf-8?B?UENKSWdPR3FhQlRFNFRQdXFvQ1drRXpTR1lQMnN2bzVzUmZHUm5ETXN0VUti?=
 =?utf-8?B?TWJRNUxxa2h0eUdiVXExdGdOK202NTRHWW9mQm9ORmgyQ053MzRZKzduU2N2?=
 =?utf-8?B?emtySnozRzFhWm9IRm94R0IzQnZUNEJLVjNaM0lOalV6ci9iN0kvam1jTXFq?=
 =?utf-8?B?OC9wN2Z0TE85T2wyNTE2Mmp4L2dIaGszeVJnczhpQ2RGMDkyMWZ1bVd3MTVG?=
 =?utf-8?B?Q0huZ28zb0VWY2l1SlA1dWdUemlES1Z5enBUR3I5cGdHSmJjd01ESFFkdy9E?=
 =?utf-8?B?S2xTS0NpdlRNNUQxZE9LRTJWdTZUUUs1OUkxR0ZtMldLZ1R4VkY4Zk9jOHAz?=
 =?utf-8?B?V1dRZVNBaDZlbnA5ZzlpVFY3ai9GKzZodXpjd3lsdHNHUSszd1JIRTA0UzJ0?=
 =?utf-8?B?c1RJb1A0TUtJRjFZZW1PY3U4VlV5Qk43eU85cGoyQWZLdGhmaDN5OWJvc0lv?=
 =?utf-8?B?QUNwSWRLUTh1OFk5VGlNbzFteUNiMDgvcFduSUVRdGJPYkpuMkRqamphZnE0?=
 =?utf-8?B?c2NIbE14MTI2MHM5T1hQcnB5Q01XQzBTalRQb0RickNsUmZFaW1IdkhzeWha?=
 =?utf-8?Q?B4PbPSjcR6c9UPW6lO?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5354cc-230b-4b70-8e7e-08dec8cf2b83
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 22:08:44.9048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfZ94bNCH2JMsN1kf70Gm1QuT1Wma9QZNX5kWxzIivLotWVNvWG3w1cr9tkrgkbE/xPYYfEfP0dkcT/Qlls3Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB7161

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
 tools/perf/builtin-trace.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 48615ddccd93..ca0b2680d531 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3234,6 +3234,23 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
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
+					     "%s%s: %#016llx", printed ?
+					     ", " : "", field->name,
+					     (unsigned long long)val);
+			continue;
+		}
+
 		printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
 
 		if (trace->show_arg_names)
-- 
2.51.0

