Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021091.outbound.protection.outlook.com [52.101.95.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDBC439F97;
	Wed, 22 Jul 2026 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735466; cv=fail; b=cOrjiKT+IAiadMQw9wh+FM6rlyLysjCY/2YvxuJ2ePPlyaCxoAEFR7G4pME0siYqzl6DVbOzSDKX1dEwKm3VbdSaJf202dw4l1TzLeuPdvvYGejU+I4h0Zs2aFmasr8+MlRpDwwYfJrVXsuzRMCikO+IKedtISidRMWSxDYWcPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735466; c=relaxed/simple;
	bh=x06OEboMOSkk/zJURmvgeow5ncAKVuht7qg4qhdVaG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OgF5RehG5soBumOp3vS/fgiTBBC/VnkFK2oG6Pl+sb41VimxQjspghdxqDmqu9cmYJG78xFngLbTaQrZgt4BmbnQGvhZTCIoZf1IH94DjgzGqQhpxp1xnHkSA37YFA9ktdEuMijjKO79+DHM+ElTMwyyMhNTgqFLwQt12VU++yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWTFhS5H7haoLlSkvdmW/fOWII1et0YpIamze7IM4omIz+QToZNTLRpU5ed/6v3SD+62rU3oYNJeyg1ZdhwJ08xfEgRK7ONmyOy9v3vWQ8QngXe3n3lMLgUtavrFZZb3iZ/0T4KNwpjrrXrB4MrdOdZezHpXctqWqvM8Jm4XNuC1q4UQwpb8bt7JRj/wdSKXGASI+pWrmwEcfnLY8kgrLc1u6U/mNctcytFGJLfRl9yUDQ3oza++MTLj6TlhY7TrOuHvCAiFvl3dnHHDkWB2gEMHlF77WP1ISiGoGB3mZ2USm3VANxxmvNAY45iQv00v826KJTDY1x5QZn/UhekK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=A1h2eTqjl44ASLk8mjXcTGyrgbCn/F+xy84doniGtMM=;
 b=L7SJb7NUdW+0ZPIuVuAvvlsu/Pqll2s1S7bkTtv22LPZDFY1Ht0Y2ni7Qnnn2w2ZUVXDlU8P3pE+qttCC9nEtpw0ux47gpXfSFOjAxAz85uy5B6Hs3u3/+RogL32Mmntw7VKq3R+KHsZM1fpf9WPW7KIiIpaE59gcOEWk/mX0jsOU94Dqxu09M9jMSFKmgDd81dCsqXuXmurRQjVsqbY53RkB69JuANdMQH42EIP5dLrj6U+Xt6H6a1c4/gYv0KRob/ecFP1WTbZGMtCBRI0f41d5ja53EXCyBoEnnxhol6k4MG28lS/LXPnKgpL5ibIM5egrtQJehUUy08eFEQu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO8P123MB7473.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 15:51:01 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 15:51:01 +0000
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
Subject: [PATCH v4 2/2] perf trace: Add --bitmask-list command-line option
Date: Wed, 22 Jul 2026 11:50:49 -0400
Message-ID: <20260722155050.503516-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260722155050.503516-1-atomlin@atomlin.com>
References: <20260722155050.503516-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::16) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO8P123MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e2cf47-724c-46ac-a907-08dee80907ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|6133799003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	S1wCp2HqXXYlCLRLxpjjS1rRA42DA/DAH41iYIS0o0Vdu6K9qgyjng/5aWP6b/JsoD8maF6gIcbNgl9op+YD9HGPE9QdGMTh1qRJsc9DkxXYrAG3KN/6O2HWzlwuO4nIpYHSO3jJl3Vam6pE3QQJ8Mq2dg6oAJHqwe5T+TO2ZIJRdRgtpXkeOew2iS6+bR+K2HmpqzcYeLwXQYAYL8jrGTaZvqnUCkoHNlyj5Y/gyhZRb+9GMeJR65Pajy7vj7H8fkDek58zb9EVKGy65KGYrYdKH4JItHR50v7fak3cmwyHO3YIFIYT0BX1n6eOpiM1WxKuEYMl4J409DC9s+lc/MdImybgq+Qoq/bNyBY2Dqe7lFUgyTDC07nXlNhiKKkMBs3kNiRdmDjKv3AOi5fAy1lPUQuLh8E2GHxlm31LepYP138mkUbciMXFaVwrdCDdb8cpiqFwJrHY8rAIgn/A6oYMx2I0ZyYyui/Bmid8ycs+wm1NtSI1SNndhh/r6pwnZW47gCd2V7MkdVkyq0zAu2GZ320Cd1dkw36qXXdjGMmpAgnlK4tGO1BLBr1aezhWWTSwndnknm7uJw0HTCJjMCtgNrsvBLpamJ9D7pd69wY6nuOxG3i0yLiPZJ8RCxGIssKdP2lroXFm1WF5j35GQtLLvsKhuvJ80OdWGWbhaPQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVBSSDJ3NW5pTmV1U3Foc2RPU3IzemtYRXpCcDhwMXdHWWEvVVF0cVpsSUFq?=
 =?utf-8?B?dHA5MC9JenVpYmJ0OHpEQ3IwM3pEaDF1TTUwRmNuNUI5WVh5QXZoUGR6SFBH?=
 =?utf-8?B?a2U2YXBWb1VIZ3kvaGVRMEJxdnhycW1PQXZiYTBXVWU3aHRacEpGbG5BOHZP?=
 =?utf-8?B?NmlnQjVlbjk2SENoTVhob2tMdmZzWjRnRlJYYTdXdThBc3NKd09scnJSQkw0?=
 =?utf-8?B?Q3J3bVdDTkpqcWlMbndBTGV0NEhNYjZhRTcrUUdheFRoWTd1alo3SC95Rldl?=
 =?utf-8?B?VVYvdWYyMENDZ1lWOTRQTmcxVTV0czB4YkdDWDU1YUEyand2dFZCNjg5eGV5?=
 =?utf-8?B?NUVHenBTUU1tUCtHYUNRb2J3cmUyOVpsaHhjbmhIZk1FaGVvTmNQWkgzTW84?=
 =?utf-8?B?bEJITTd6bjFMNWlZK0J5bFFiVHJ2M1MvcndCNWloUnZkVlRMSFR4OGUzRnBS?=
 =?utf-8?B?eWZiYWlIV09WQk82OHJ1ZlFoZGxkbDBWOC8zWDlmQUd4SVJZNVAzUlFaRXo0?=
 =?utf-8?B?VDc0MmJKMDNDRENGMVoxeFVkNkNCUTV3NEhCK1pySlFMVDdOaVN3YStrd1hj?=
 =?utf-8?B?Z1B6OXA0N3hzb1AxYkV2RnVZUTJBMnN1Vjl5enpkM3ZlMTBSTXErb2NRREVa?=
 =?utf-8?B?cWdSYldlWlluQjNIRUNHbmlrbDdBOVJNQXViYUIyZElqZHQxZXJDZHF2V0FU?=
 =?utf-8?B?WEpkYkNPWVJJZ1VZdG43ckJhTmNhR0xONWtza1VJc3FsZ2RTaFBIbUgvSnVB?=
 =?utf-8?B?T2VQUC9FZkxzNlJMbmExMU10ejlpQ0MxSElJeVpNeE9yWmR4ZUludHNSTWNC?=
 =?utf-8?B?VEttT3kxdEplSzNlODJ0Y1hUdVVLQ2hMc3ZYN3VIRkJKaVczUXBoZ3l0UWl1?=
 =?utf-8?B?V1dlV2RIT21LUzIwdFpEb3FveUxWN1k0dEhXczMvbWdKU1VETUZ5ZjNub0hI?=
 =?utf-8?B?ZWEvZjEremJ6WElob1JRQ25qZVEyVHRDZ1VhNmpoSkE0OFJmdW9BVG1zRjB2?=
 =?utf-8?B?QklHbkxxbVAzYWZCaGFyUEs1bURvYjg1dlJwbXF4YkkwMHFnVGt6NTczdmxi?=
 =?utf-8?B?MkZzVHVHMVBsNlJ0RHFRc2RRaGNkTU5ZbUNFT0dlZEppd1BHOXdnTmtQLzBa?=
 =?utf-8?B?WkJpMUQ1NHk4WnBqcGIrRHRveVhrL0JMK09oN0p0Qk9Rd2p3UFZEc3dPNDIz?=
 =?utf-8?B?bmNta2ZiNDd4UlFvczJmd2puZ3Y5WGozdUpmY3NvaFowQm1EQ0wzMVk2YXlo?=
 =?utf-8?B?c3ozaWl2YWtFWVZFZVdLNGlKQUVIZnZGWFBjTUw3MkN1bm1LUGxOOCtKZTli?=
 =?utf-8?B?cmwxYjF2a2pFbE9ncStYdi9CQmxRYUg1UWFzWmZzb1BKK0RLQUxHSGxWOEc4?=
 =?utf-8?B?TmRuc1BPOTlpcGxrQU01T1ZYampEdWxYWXgxMnZPVG14WXNYWEdIVDlMUUY1?=
 =?utf-8?B?L3BkcDNOdVZ2YjFOd3RIa1dDc2lPUlBUVExhVVF3R0pxekhjYXo1bmhzdXhu?=
 =?utf-8?B?T2NJWnhHUkpWWE1oNFpYWXJsS0FaanVucVozLzhhRmxmVXBMTHhjeUxUbVRs?=
 =?utf-8?B?eHN1M2U3N1ZjVUJNYWsydjVEMjRhV0Q0Z2I4MWE0WlBZMHJSTjFyTERxL3da?=
 =?utf-8?B?YlJ0aHl1cFFvZmpaNGVEV1V3UXFRaUxHTmVrVGVvSElHZ3VPcmFVVzhuSEw2?=
 =?utf-8?B?djBHbWhNRkt2UGdXWkI0Z1orOHlsWDdESVhpbmhGY0dXNVMxU2ZvMkNPd0J2?=
 =?utf-8?B?dG52dlZOdXVJMm1tQ1o1TVhaVmE1VDV1MG5McGk2akxKQlFMZ2NEaWoxRGcz?=
 =?utf-8?B?eFpubjJYZ05EbXdHcXNNcmZ1WXczN2Zwczc0UlptckZKeWV1SEdPWHZWUmkv?=
 =?utf-8?B?bVZncmN4RXlUQ0pOVW1ZcmRYNTVJb29ycTRsK283a1RCMVpRczB4dWl6eU1L?=
 =?utf-8?B?cEp4eTRwUWR3ZjJPK01kd1ZYMVlYKzcvUUMyRStkNTNhMnRvYkZjSVFsVzQv?=
 =?utf-8?B?YjFpYWdhbHFrNWxyOS9SVGpqdDA0K3pFcGU2bWpNU3d5SW0zbjFnSWx0djl4?=
 =?utf-8?B?T0I4dkF4YURQSnZoZWJJVjBkdHlGQU96T2NUV0h4NFllZzdzOUt0SVJxK2RS?=
 =?utf-8?B?RVgzbVJaRW1sMXdEdDZUeVlReC9KNy9VZlFxcFF1VkZpTkozYkpXeUZ3TlJj?=
 =?utf-8?B?clhVSE5UMlVWVG5UMzNFK3lWRmNOMDJOQlMzMmtBcHovNVNhc3RkUlJmZERv?=
 =?utf-8?B?aXJpcGUyejNBdW5UYW5jYVdiY0ZQU01KV1Znam1LSXFUY0UwMlhsYWVDL0tZ?=
 =?utf-8?B?cGxIeUxUUE5iZkNUZTBVYk9wNXJvNGo3YlZiM01PcnlrK1RiN25mZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e2cf47-724c-46ac-a907-08dee80907ca
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 15:51:01.7957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYSjld2kg6MVb/SIK5o2HZNYI6grVPoGDaytl6NBB8HNUKZRUK67i+3y3+mywCDyY4EJHckY6BFjbhYj8DtEhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB7473

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
index 5808adad52ae..9307c2aae4ba 100644
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
@@ -3280,6 +3281,9 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
 
 			if (syscall_arg.len == 0) {
 				printed += scnprintf(bf + printed, size - printed, "0");
+			} else if (trace->bitmask_list) {
+				printed += bitmap_scnprintf(mask, syscall_arg.len * 8,
+							    bf + printed, size - printed);
 			} else {
 				int i;
 				bool skip_zero = true;
@@ -5590,6 +5594,7 @@ int cmd_trace(int argc, const char **argv)
 		     "start"),
 	OPT_BOOLEAN(0, "force-btf", &trace.force_btf, "Prefer btf_dump general pretty printer"
 		       "to customized ones"),
+	OPT_BOOLEAN(0, "bitmask-list", &trace.bitmask_list, "Show bitmask as a human-readable list"),
 	OPT_BOOLEAN(0, "bpf-summary", &trace.summary_bpf, "Summary syscall stats in BPF"),
 	OPT_INTEGER(0, "max-summary", &trace.max_summary,
 		     "Max number of entries in the summary."),
-- 
2.54.0

