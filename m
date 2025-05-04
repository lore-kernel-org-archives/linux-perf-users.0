Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020093.outbound.protection.outlook.com [52.101.195.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8B41A3155;
	Sun,  4 May 2025 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746355440; cv=fail; b=IxE+6PfvJrz0qtj89XWTHDB4eFI0zL4dk728t7qWUMOS1zs3QZg6G+6qqF9PLm7soRmD8rIicNzUrtOi/QlVtsASKnw0ZjIXw8B8s+arcnoanTfwKgoy+3OIEGERQZwF60fIZJMMDsYqvVTc6yLZF1kxNGpLXmtui6FbMtxV2GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746355440; c=relaxed/simple;
	bh=uiXGfSqThmmEWZkF/r9FAO18uE+r1ma8Y9MvxJHSoiI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NDRrYasQmuNFAr2t3/zCvkSD9Lkzy99uFRcBVF4Q7zHSAHQmjxEqaJy4/eXUUD+AyhMoGx2AU8ohz9S/cmpstexLWq+9UuugFboihabVXyyGlhtiBdiODDUNoP12rAqDi+Lt2nfwh+OVcyFcsrGKdvKmooDqalxbpdCHAx15jMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOIz7rCaWVstNT5DMEgLXYHrmVpSH2ZCIBU5D24WpTn1sKzJqHfVF4LxEEIvJWylidgKGgqbWd3VqpWhs1ZFojxsdQuk3rZmBUrsuLPMeHOBDTah7kqI1uDmbZiiExmY+/lwzbkwZzGTeoUqhzLngjg7IDndrnAw8xQmlmdSZLGOuSg5e/c23XQCUHoxlISIftUUmtDU9jQUMwJ8ILNkr2DB9+5jb9vQiS6ipFDF6f42IWfX6ebrY7ZzIxFyqWsJvPMCmkiTFU5il/ObbRLBI0J+JCUsm4U9o+ymZ1yMA1YSofTJCcA5Cz0HHORjOCMiATd+NOBWEiyPcSc1yKOjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaqMHctHYffqH5RcpM1BZq0DAMAIJXXPAYHJCIQCRnY=;
 b=buvkKOqANIkGlktFOMEEMJbfCrIjQ14UjXachE6MjjrQ/qvSM47AlEbHP2CAD6h+UyoVQsSBltXAM8UGdNJx/b8DW1KeubRw4O8mpRc+eoakB+kA2DuuESoN8FNDlHdbTRdc2Dd9kaFqM7QnIi3hr22+pboDN2ffXEX2VaymEsUsm/dvm7ggmaZii6DGifbT2AT9uCDlnT0N+8GkiBLS3E+aPq73xBGZplJqmGfD4edu/uFndRHXN8E39Fj9JzmAXGa6V61Jv6hLUMxro0iycNF7xDdPxTP1BqKc/m54+L8IK1JNhVfBgtRZ0FgZlAE8qSiLGsUG7T4i12460tWuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB5668.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:197::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Sun, 4 May
 2025 10:43:53 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%6]) with mapi id 15.20.8722.011; Sun, 4 May 2025
 10:43:53 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: namhyung@kernel.org
Cc: arnaldo.melo@gmail.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	atomlin@atomlin.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] perf probe: Extend the quiet option
Date: Sun,  4 May 2025 11:43:51 +0100
Message-ID: <20250504104351.1549583-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.47.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::28) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: ba579e33-c4e8-46a8-35e4-08dd8af89036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2R6NlZwUjBOcTlJZTFtQzROL0FPeFBjOS9EZzBGajdXV2l2LytUM3RnT3kz?=
 =?utf-8?B?R0xRZkdHWFNaUTQ1TzBQMFVVd3VDUDR5TC9UUDVJTVhVZkpzdzJUcmIxUlZ2?=
 =?utf-8?B?UUtwSnNYb1J1WkxaRGNIa0NzMjU3emF5QmJYM1RrUWhxcHJnSkN6S3ZqOEY0?=
 =?utf-8?B?WGVDMmNNS1ZGcTdERCt2eCtXMWUyMDZwSklEdllTNmE2SXFQZjhrT2ErRzZD?=
 =?utf-8?B?MlQzempaWFp0dHlVVitHYndPRDhoUGYxYWhzSEhtY253bExsSnRxSW9McHdP?=
 =?utf-8?B?WitMd3REcmxZdUF3bFlDQ0dmRGlwYXdvcThWK3BJZjNWTW9lMHg3bFhTTEtI?=
 =?utf-8?B?SDF4QnVSLytCbzJBYmU1K2J2aGRuVUgrKzUrMDdJSEd0ZTQzTXZYM1Z6bTd6?=
 =?utf-8?B?N2VmeFRMRzRQWGRocElrOHYyQkpqTE1FOFMzNDhvcXkyTnBnRElhLzFBYU42?=
 =?utf-8?B?bGFIK1czbXQwMWJqMFJ5UVJ0cS9qWnhwTi9EL2VySDMwTEZuNXd3T3RpeURt?=
 =?utf-8?B?M2JFODVreFlNUTRiWlhHUjM4a0RIOThZdmtFTkM2bm9aUFVFcnlMdXJtcXov?=
 =?utf-8?B?TTNMSFFKcS9LbVZ6RjllUHFtZTB2SFlrY3A0TzlEb01UL0NmaGM1TXdGb1Bn?=
 =?utf-8?B?dWptdHFBQ0lQOUVkamJoWDNmSHBjQ1h2R3k1NG1LWXhBRjJhV0p4MXJnVmI5?=
 =?utf-8?B?K0c0bHpVOU5Rd2YyUWFZcXpLQUtJTGVzWkQyK1pWdzl3NzBVTEg5ck1tT0Ir?=
 =?utf-8?B?OVpXREozNlA1REdCUVBvL1RCRXZBZjVING9xU2hjNE1PS0NqRUlZVEVRYTkv?=
 =?utf-8?B?Rjc0VDUxczA5SFBBT0Z0L2JxeFU4aGY2OXo3UzZtQTJqak5ZQnQ0VGd3dVNh?=
 =?utf-8?B?ZjgrMElXTHpjQ2d2ZTBmT2dpTE5MaGt4OExRYmZSNDV1UERpN0JTeW9VSXRV?=
 =?utf-8?B?cnh6QVQ3UThZNC85M1ZwMjlGQnIxd1hvNm1YbzBET3BRMHdNNUIxcFJSMWpR?=
 =?utf-8?B?ODIrLytPSGVXeUxCQ2g0cHdiZHlOZVlWS1ZPSHpIalZFMHAxVEFuNE91VjFs?=
 =?utf-8?B?Vm1zbFZvUm84ZSt2K1lOZ3BjTnQ5ZHZxR3BTRXhpUm9acm95WEJVVVNGdUxw?=
 =?utf-8?B?Y1p1WkRNWWs0VEZXZXZoYysvZk56R2tjdE1uN2hjaCtrdHJDd28zUkRLb2Zl?=
 =?utf-8?B?ZU9JSy9PalBJZDFVM09QRG90MFZlRUliSS9Kb2c5R3hlSS9JL3BWOWZxZlIv?=
 =?utf-8?B?eTJkWnNuaHlVOVBrY2FSTW1ZSW5ucUVpbHI3MlBXdys2MTRQNU5SRnkveWJT?=
 =?utf-8?B?c29VWElORHBEKzRaN2RnV2ZwbkdxYjhPSG5pNWlFWGt2bVNVWnZJSUM5ZXB5?=
 =?utf-8?B?L3gzN3R0ZmV2ZnphZ0FpRHNrUFNoQzIzQWJGNkFSeld4RFJBSWVpMnp4OFJI?=
 =?utf-8?B?LzJGb3htMnY4ZXdZVDJaZzh5TlY3TVA2MjdmanJWc3ByZTZGYUZyaUt6SWF0?=
 =?utf-8?B?NzNvZWg4T2trZmFOSHZjQkFiSUdWRGVyU1phRVNScWZRSmNNL20ybVYwaW13?=
 =?utf-8?B?NlU2QTVkR0w2S2JIa21SRzN2TG1lNEVGRmNLcHhSY0ZkWFVsNFRQNjFERlNQ?=
 =?utf-8?B?K0NRZFRlTGtSbkNLa3dvNDVCWkZBb3cxaWR4cngveXJTeldDOEhpVC9qMnht?=
 =?utf-8?B?OWRHYnBKMWJVWXBWeUJOU0lMV3pQV2wrRWFXVHdkMzlnckl1S1h4RmFwTFdu?=
 =?utf-8?B?K1cvOG1jNWhSNXBMbXE0dlY0UGtlcjRZM0RXaDl0c2pDMHdSbThaaVdObmI0?=
 =?utf-8?B?SWh0ZDNGTTk0REFqMnEzOUFDQWYyUFVlRDVJWGRyRGhWUXB6cEJOZTZhdTVt?=
 =?utf-8?B?OURVMVYrWmYzckRYSTl4VzAzMWcxR1k3WTFxdDVNS3YySldlZ1l4ZWZDR0RC?=
 =?utf-8?Q?DIWhgEOTs2Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjlOUStIbk5tTWdHMTVnM3RjK0VRMUYxTjZXNDU3V1kwTzdOazBPdk5HbG9U?=
 =?utf-8?B?NGxTVmpWSkFRT1ZoTittNmdzUzVVRnJNUGh5MmpXMzVVVmxuNjFEeTVIWFdQ?=
 =?utf-8?B?NFBwUzUvRDduTWZCY0VrNXQ1a0trYVFCdjFpOWFNajUrdzFtS2p1MGhHWnho?=
 =?utf-8?B?UVg5MG5aWmMrYjJMUndTd1NESldUR1hJbEZzdGtqREdMK1U4RzB4OU1GRWc0?=
 =?utf-8?B?OE9ycDJST2ZMbzV1TkZyZHlqMytDZmtQUWQwM01GSjZ2MGl5Y0dEMml4MDZT?=
 =?utf-8?B?cWN1aDQwUi9tTklHZ0M0cTdTUkplTEw5Tm5QNmdyUkt2bG9LRWFIRUlzL21F?=
 =?utf-8?B?blNpQkYzaXlpRXQ4YlJQQzVVN3E0RGk1eW9QdElhZjA3MWhZM1RGN1NjTVdy?=
 =?utf-8?B?NURheGs4SUpXTVY3STJEdjFZYUpRbWlHQ0ZKRTduM0Y0REhrNFJpc1lqR3RJ?=
 =?utf-8?B?dDdJM0JCUDFUU0Y2M1FEMmExRzBHL2FpV3grNnd5VGtnWEhLUE5SSU5Xei9N?=
 =?utf-8?B?bnM4d2h6YS9iTDJ2MGkrTWZqUXdOUFBMdmVRbkxDNE9vQ0JZZ1orU05pYkE1?=
 =?utf-8?B?c2wveDc3ZUNUeWE3MEpqVDl3cGMxa2F2SkUvVkYyRXIySWo0cUJLVHRDWWg2?=
 =?utf-8?B?NElHNnYwMjNvZUVzcXRwQjFKbFpxVVhaeFlYNHZROWNjcEphYTVwQmI4N2V4?=
 =?utf-8?B?T0VKRmJQZUZGZlFpa3l3K2E5TnhvMXUrSzVvR2doK2dYMWE2N0JJVkc0TkNO?=
 =?utf-8?B?Umt4YndVZzVMeWV0ekhFVmZ6WXRKSVgyMU9neUhGZEY2cVdQM0JhcCtaTkFL?=
 =?utf-8?B?N0RpVmtHWk1iSVNCcXBHdHdjdHBzeForQnYzZ3NJQTd4Vlhpb2VaNk9CZUd6?=
 =?utf-8?B?NktvTHNLbXhNNzZsaXJSMGpqd0NIOUIyOFd6RkZQUUpkMFF0d016M0szSkR4?=
 =?utf-8?B?TTZCdUlGUnRFeG9PQUF5K1ZJLzlKLy96NjlPUVVreTIwU2V3QlBWSCs5U3ZK?=
 =?utf-8?B?aE1sSXcxeU16a3pVeVgwNlFVbi9BM1ZNY2gvSE1vUW1pRDRad1g3eGk4b2R6?=
 =?utf-8?B?UWlkTVI4aUIrQ3ZEK0xvc0FZcm9EcFNPV0hoUng3a05wV0ZLRnJnb2JTb0hN?=
 =?utf-8?B?RGwzOHlkYngyWjV6a1ZoSDltS2cyTVp5QUd0dzJTMWxsTHpHRExkRFhMZzlG?=
 =?utf-8?B?ZGVZYi9BSytYblFra3BhRzVhdWMyZDNXeitFY1ZuSHpuaUhxOFV5TXpnb3Vn?=
 =?utf-8?B?cFZvejNpVkYvMWg1VldTTGRIVllPNnZ3WFRRZEcyMXIvTDA1cmM4ei96KzI3?=
 =?utf-8?B?bmZQVUw2OTVUMHBuREphaURvUnJzTStnS25nbW5Jd05EQlNMSUFPSXQ3RHgw?=
 =?utf-8?B?b0pBK2lTTHVQL1oxQ2JrVWgvbVUrUmhyL2h3bHJldlY2RkxtTm9GaEJrQ2hp?=
 =?utf-8?B?YzRqRk1NZmlNb09jSzBhRGhOMGxFL3pDZGlpSzBUNS9KT0xQcTg0V0hSRG1P?=
 =?utf-8?B?T2NrZEQ3b0RrUklQZU50YjZPaE9BeDFHTVJIZHNUZlNMWEdwb2NtTWxCUFJl?=
 =?utf-8?B?a2wyUkphSmRwREJKNnNEOSt2dWc2MUxQV0N3azZ4dlJ3dSsxU2JncmsxcG1V?=
 =?utf-8?B?QThadHY3alpLSnMxZEtOVjRrMmxnR1IzMzNMaGVEVXpqYlZRdm16Rk1hRXA5?=
 =?utf-8?B?aU9MVElab2lUQ05IelduSXpkWUFpTmYydjhsbEZpTThTbEVqU29VWjU0aS9X?=
 =?utf-8?B?MU14aXZPeW9lL015bXY3MDdRK3NXMExKQUlqdURQSmd2NldiQzlod2piaFlp?=
 =?utf-8?B?b052ZU9KWC9mSXB0SWNTYnJldTRJMlZjSksrKytvMFoxUUdUVjVDVnREVTFW?=
 =?utf-8?B?Mkl0eGdzelV3SHF1WmFEdFN3REV0VXplckF4VDZmRVJLSTNaeFJLblJIT3JY?=
 =?utf-8?B?dUhWR0VSQmRKcFBDM2FJYW4vdm9HdkVRcWE3YWZJTmRwc1g2VUZuZEx3K0Ji?=
 =?utf-8?B?WnZBTzhna056UFhDNC9IQnBzek5DRnJQV1dJcFZWMlJrRzB6UUpGSEptMjVa?=
 =?utf-8?B?SmZ0U0R0Tm92Z0czdURab2NLUDd5N0FMTEtDRm4rQ2ppMUprcnJpUElldHdx?=
 =?utf-8?Q?0TH2PsUetFWzj0UcAPNku58tN?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba579e33-c4e8-46a8-35e4-08dd8af89036
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 10:43:53.5170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuqEvdzfFFspyWIv/fCj6PQM7R3sNlua8z+YYgIQ7sfD6ZhGD4BwuKMbPcCqQl+b56QVlPwMVc4xXu5ushrYaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB5668

To provide a consistent and complete quiet mode, this patch expands the
scope of the [-q|--quiet] option to suppress all informational messages,
including those indicating successful event creation, in addition to the
currently suppressed warnings and messages. For example:

    ❯ sudo ./perf probe --quiet --add proc_sys_open
    ❯ echo $?
    0

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-probe.c    | 16 +++++++++++-----
 tools/perf/util/probe-event.h |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 69800e4d9530..aee756aad19d 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -391,7 +391,7 @@ static int perf_add_probe_events(struct perf_probe_event *pevs, int npevs)
 	}
 
 	/* Note that it is possible to skip all events because of blacklist */
-	if (event) {
+	if (event && !probe_conf.quiet) {
 #ifndef HAVE_LIBTRACEEVENT
 		pr_info("\nperf is not linked with libtraceevent, to use the new probe you can use tracefs:\n\n");
 		pr_info("\tcd /sys/kernel/tracing/\n");
@@ -467,8 +467,11 @@ static int perf_del_probe_events(struct strfilter *filter)
 
 	ret = probe_file__get_events(kfd, filter, klist);
 	if (ret == 0) {
-		strlist__for_each_entry(ent, klist)
+		strlist__for_each_entry(ent, klist) {
+			if (probe_conf.quiet)
+				continue;
 			pr_info("Removed event: %s\n", ent->s);
+		}
 
 		ret = probe_file__del_strlist(kfd, klist);
 		if (ret < 0)
@@ -478,8 +481,11 @@ static int perf_del_probe_events(struct strfilter *filter)
 
 	ret2 = probe_file__get_events(ufd, filter, ulist);
 	if (ret2 == 0) {
-		strlist__for_each_entry(ent, ulist)
+		strlist__for_each_entry(ent, ulist) {
+			if (probe_conf.quiet)
+				continue;
 			pr_info("Removed event: %s\n", ent->s);
+		}
 
 		ret2 = probe_file__del_strlist(ufd, ulist);
 		if (ret2 < 0)
@@ -531,7 +537,7 @@ __cmd_probe(int argc, const char **argv)
 	struct option options[] = {
 	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show parsed arguments, etc)"),
-	OPT_BOOLEAN('q', "quiet", &quiet,
+	OPT_BOOLEAN('q', "quiet", &probe_conf.quiet,
 		    "be quiet (do not show any warnings or messages)"),
 	OPT_CALLBACK_DEFAULT('l', "list", NULL, "[GROUP:]EVENT",
 			     "list up probe events",
@@ -631,7 +637,7 @@ __cmd_probe(int argc, const char **argv)
 	argc = parse_options(argc, argv, options, probe_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (quiet) {
+	if (probe_conf.quiet) {
 		if (verbose != 0) {
 			pr_err("  Error: -v and -q are exclusive.\n");
 			return -EINVAL;
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 71905ede0207..55771113791f 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -10,6 +10,7 @@ struct nsinfo;
 
 /* Probe related configurations */
 struct probe_conf {
+	bool	quiet;
 	bool	show_ext_vars;
 	bool	show_location_range;
 	bool	force_add;
-- 
2.47.1

