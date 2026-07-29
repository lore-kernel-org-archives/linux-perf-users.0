Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020077.outbound.protection.outlook.com [52.101.195.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A584C042D;
	Wed, 29 Jul 2026 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336316; cv=fail; b=hO8mhYHZoOkUZ/EHUvj1JQufEV3DIt7G+zGuB1UKsXZs/c2RfPLVAnZfVVRMZTWy5Sz5UOEvGbMGojApMcrE0gxpQqAEkCW8DoklOyd6rrUr6DfgOrN68jGqzpg9AxihtVCT8fDT9Fi90T97aruKe9P029SRrJbtRdayxKvcXa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336316; c=relaxed/simple;
	bh=5jUqpEwtbhiJXmXa/C4xvCCTw4+Nd5GFOBFnrleZcGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EzXkb3MA/G2sa3h5epMDBYtiLRs4liZfMu3Ng4EKTtk/Ce+dQidhUbKJVBY2hdk+o9GYbeUsPjoLkW/8Ale0LJT75/25w51s8m7X/g5aupgNOjmcK/+aw3Y0FQQhMK3vfX4YgoHKpqg39WEbzXNnAzt1BUC/uImmz185txSR3+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4EmzoxXgW3Aqrso3fnGD2yLW4jiuT4aIBWqCDTjvOzVueggHctanlkoPPOCI0jmOWT1CNvj8/lthxdPoc1WkoIIl+ZGWBBFmp4R1h329fn/nogZq6svX6IgqCTOtBCxEcj+oQ4RAKKkWqtsLbSLjPuI40i73kcnQGvcExjGowTfz7+TESQ9B8onLrC7aZ9VlffE0B1OlLHLpUk7406ZtSeV27HF8RVXJaAC2fNFJhOO1r1Zx0MixNUv9PSXVYOXECcecBibdsbNPoSy5RGGODx/TjzyXgnE8xORPv7ELYF5EeKoWmmuuq1WaX4+ql541wdCaURax1ajWSFhTB86pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=sRdHC4bDILLyr4SguAhKLO3EHII6zWN+r/TIN9iGjN0=;
 b=cczctXsyI/z4+l9jFav20tMEbQatsQ4jnvWQFa6e4Kx2XBBl7veNhGkEWA+oCsOg/nwAisjcANkp99EXS837TQWbXS/3LhfAVHYrBFFPHM5FgDToyTslt1x269wJPfrmh4TkAqw+sAc5z610vNRuEHM4PuGDE/bLCHXsr2XYzCFOiIWoPgE1+jVV2AGPFEd3ld3n70ruCvaGkNS3pzAtQZjENxpKBZqzLfMecTQfC5vrXWzxfZkGp5kCe99/KG4JYhLLSJ8uYmHIKRAh+SiyvSyqK7eIplJ0ymk4OEET/BRpD2wYq8wlR9VyjxCD0ezhI8JsVhxnzSSz/GMcIZk4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOVP123MB8527.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:487::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 14:45:06 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 14:45:06 +0000
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
Subject: [PATCH v4 3/3] perf sched latency: Add histogram and time interval options
Date: Wed, 29 Jul 2026 10:44:51 -0400
Message-ID: <20260729144451.38286-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729144451.38286-1-atomlin@atomlin.com>
References: <20260729144451.38286-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0196.namprd13.prod.outlook.com
 (2603:10b6:208:2be::21) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOVP123MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d3609c-f8b0-415e-073e-08deed7ffae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	pvkaGqu+idMnJeVtzYDPTxefbxZV1bHqShElKcJTbY+a4hxZWP2i58iA9N6B0dCUEFdshHq3/ksPSFpaicc5frHn2Z+8veRbvm5RnQuD+KXTS6Pn64b+thY6IiGsy93JUdJQLRhN7FgVZzDp3iayLrNIeh0GaR0tuulnD+0LyLmrPlWNzYVqTF5GmApscot9D09q5gK0XiQefFXXcsnHfZ5609XbcLAZLivsNpS5cWhLFLSVtNt2XUcA3xI9s7nqyPWkJ+uK2tW/2q7wfwTJO82MbhhJfKe+1QLFMQNRk1EnNoR30UX2TT8fafOzaTIHJL060uEfIjfbI/HT+temOugyMcz9bJOzISb4Sqb0PletNFPECiatb2PYVAxkCHPHlm74ih7tQSu7ZcLi44Ewl+txCIlCbD1oXrw7H2bR88uDYr+TV78fGKQpQN7YjkoN3Iso4E8Ysl3NgD+FdrXC2VjtnEeRIyPMxXoFspWNILlVZ2idZE/vWn6rq5o6JDoj1ZSSyhVEx/ng1404dI01GS5AVGt5OMJ3m20ZAYdI1bnKPs6G8iGCybpr+Zq0RJPowfUwnpxHCpfeEYriO9WEMPWcXswrcEroL5Z/Q4b15RCMd6GpsQ5mMoV+vm9yyMxG8EQ1k/9uy3Yzx1o5VpxmN3biCbuSD+rAseM1tWfwrHQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1hCbGdidEN1M3lWRVh0MjdLRlNoaVRhanpBanYzbm1WOVV2UFVmWDlCaG9y?=
 =?utf-8?B?Wk85aHdldmlGMFFRSy9aUUQybjk4SGJqNERLQXpJQnpNeS90QzJFd0JURy82?=
 =?utf-8?B?NnMrVjNTMGVYVmRlUGVhanA2NDhsTjdlcUlYeGhNV2JkSmVOM0ZtMWpXSjQ5?=
 =?utf-8?B?b0R4eW1oTVEvYnh6L01jV3ZnQldEWHZPSkdFYS9LVTFFeTk2Y09kQkNRNzB2?=
 =?utf-8?B?MnZ1dnNVQ3JwbHpWTStOMFJsaWRiSW1sZDloU1RSdk5DUkJEaXBpRFZIeXN5?=
 =?utf-8?B?RllKc1o4WnQ2bHQyRU1USFNYeEtzZjIvWTQvaHMzcFA1YzUzUTR2WDQ0WG45?=
 =?utf-8?B?bEgrMVhYalR4dDBMY29OZWVvbW9nbDlrYXFQaDBuYmhaR1R0UUxSdUpvV1JG?=
 =?utf-8?B?Zy9lOUZ6OEhINjc4Vm5NL3hudFh1b0FoVXR3QTJaMldUVmwyeENtZGtkUE1i?=
 =?utf-8?B?K0pETk85OFFGN3NQTGJ4dWNXZU5sSGtTR2hMTmVhMzVaeGhBQi9uUmxsNSsv?=
 =?utf-8?B?N3o5SXcxUUNiTURBUmc3bDN5cW5WajRxUkZJSnBIcWFQMmhUVnBRSndHNURX?=
 =?utf-8?B?UW00Rm9Jc3hnVFBPSmxJNVBUUXZTTFlER2pGUzgvTVhXdVAvNjFYYWpKRk90?=
 =?utf-8?B?Qjk3dmlJSzNkR2o4QmJXWEdkenVDaStMdzhzeFdyaXA5WDNKZFowdFRTMHhJ?=
 =?utf-8?B?KzNZQlNHbmdCVmxQY3c5RTRGWE1TK0h0c2MvYTVvS3JjMVBybDVkQ2hIb1Bo?=
 =?utf-8?B?YUlwMHRHWXlPMkFwbnRYZmtQWEhMNVMxYndIRENXdXF0T3RxTmhaVzJEV1M3?=
 =?utf-8?B?VDlIZFlIZkNDM3J5bStsTmhvYjhQYytGMDUzenB6ekVZT0RGTUIwSDBQeG9B?=
 =?utf-8?B?b0xmRmpFZWlhYi9JMjFhNG5lck5ucUgwUXdKajEzVmxUNlF3cmtsQndGQlBC?=
 =?utf-8?B?ODZrY2o2RDBiQ0JnWXZxMk9IcHhNb1VEM2xrNzJjNTBXVG16dkhIWTREeFlM?=
 =?utf-8?B?SHptd2k4RFN0eE9kSGdDWkF6T2NRaTE4OVFrUksxek0vQ2ExL3A3TmZWWE5u?=
 =?utf-8?B?UEo3c3N5WUpxMlR4OU44MzRpY2MwUmx5OTB5aXFMQnBXMkZMQy9SMjlTWEVR?=
 =?utf-8?B?ZVVxMU5xWWtZN2MrbjBPSkxEMkt4cWxRaUEzclZiNis0U1FsNU15aWZ5S2pX?=
 =?utf-8?B?VW0zekxSeEtBcktRdlZ4emY0Q0dBdHhJRmt4Y1p5MThCNGNqaC9VV0VaTk9H?=
 =?utf-8?B?ZnlKNHJJNy9vbVRkS3hHWVFIWjRJTVEyK2I5L3V4dHZTZ28yZU9sN3dzL2x1?=
 =?utf-8?B?QWJvdVlueGVYWjFFRTYyNm1mam82b3Z3NXREY25mRFhJM0dOL01Va1RrWU02?=
 =?utf-8?B?UEZJdW84L29CQkczNXIvSVplTzZWVENBVHpKa1NadTEraisyckYvcWRFcUFM?=
 =?utf-8?B?dm9mcGlkUzV1Q3l5bWJ3ei85eDgyQkxEMzVMVFJzY3dydTgzKzJOTFh4eEFW?=
 =?utf-8?B?LzdpNkM2ZFhTV1VyUExyaGdaUlA4NS9aSzR6Q1VZaGYzT3AwTlVZYTNaSWsw?=
 =?utf-8?B?Q2RLc0x2WHZqL3poUjBhN21NREUvc1ptL0ZUeDRJSXA1dUtSbm9Idzh5VHdW?=
 =?utf-8?B?cFduVmtYbTJJbDJrU1lnOW5nbmRMN0NxV3BoajNpZXZoU3lOMHptMjloRmlR?=
 =?utf-8?B?bWJZR0FXVzlkRGRHdFdIZ1VDOWNLZ1czQXM3MEg4dGxQamhtaWwwTlVsSXd3?=
 =?utf-8?B?VTZiQS8yZGNKRENwRFFjSzlreEZEbDZQWE1sS1R6YVVpaFZiNm5YWjFROVow?=
 =?utf-8?B?VnkrTFI0bld4WVRtSW16SEg2b0poWFFKSlQvZGwxeEplOXlOakUyRnpNekxS?=
 =?utf-8?B?dU9mWk93dGZHam9NeXhOZU1mSXdyZ1ZlODV0aUlWd1JKUXdCeWpoeWM2UjhP?=
 =?utf-8?B?c0RXTmdZbytrUk5pM05GbTd5OWw2YTU5MnBRRW9MUEpMa3pQbFd4M1pZRi9q?=
 =?utf-8?B?RjEvSy9FdVU2TlU1Zkp3UFJoTUhacHlQcXN4Q2tiOHFyMmxqMzhGUnpyWXd0?=
 =?utf-8?B?bUtJanFyOUg0Y1d4cDZ4MVkvSURpdy9SZXFIaklhNjdqVTlPRzUyU0RjT1Rh?=
 =?utf-8?B?TklNQkE2ZUhpVm8vVHJOYngyTkY3NWxHeU9TNUd5emxjMlMwZXQxa3p4bjU1?=
 =?utf-8?B?dWZUYkNRcFR5Y2ppZTBGNHNWZWdwV3doaWY4VjJmN0dNUUg1RFV5WmM0Nk1z?=
 =?utf-8?B?dExXK1dYVFEvck9rTGlWQXlKN1cyZDUvQ0ptUC80V3Roa0dFRXQxMDJIS053?=
 =?utf-8?B?RGFwS2hDSWNsQXlINlZtRFVDTkplUENOY0c1QWdKTVIvNzJ4cWt0UT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d3609c-f8b0-415e-073e-08deed7ffae1
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 14:45:06.0601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OC1dA1buPtHIm9+cDAfAclskCBKPZk3I4V2mmBdSE0TKGxTBz08zeAhj43Ux2ETLqn7sEdQZZuXX6qUgfP8xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP123MB8527

While 'perf sched latency' reports task runtime and delay statistics
(average and maximum delay), it does not provide a visual representation
of how task wait times are distributed across latency ranges between
snapshots (start and finish of the analysis window).

The --histogram option collects CPU wait latencies (time between when
a task becomes runnable and when it gets scheduled onto a CPU) into 22
latency buckets, displaying an ASCII bar chart distribution.

The --hist-mode option configures the bucketing scheme:
  - log (default). Logarithmic latency buckets ranging from
    sub-microsecond (< 1 us) up to >= 1.05 seconds

  - linear. Equal-width linear latency buckets
    (i.e., 100 us steps up to >= 2.1 ms)

The --time option allows filtering trace event processing to a
specific time interval [start,stop].

Example histogram output excerpt:

    ❯ sudo perf sched latency --histogram --CPU 0

     CPU Wait Latency Distribution Histogram (between snapshots) (total samples: 36114)
     -------------------------------------------------------------------
      Latency Range    |      Count |    Pct | Histogram Graph
     -------------------------------------------------------------------
      < 1 us           |         17 |   0.0% | #
      2 - 4 us         |        673 |   1.9% | #
      4 - 8 us         |       6237 |  17.3% | ######
      8 - 16 us        |       3224 |   8.9% | ###
      16 - 32 us       |       1388 |   3.8% | #
      32 - 64 us       |        709 |   2.0% | #
      64 - 128 us      |        690 |   1.9% | #
      128 - 256 us     |        789 |   2.2% | #
      256 - 512 us     |        541 |   1.5% | #
      512 - 1024 us    |       2256 |   6.2% | ##
      1 - 2 ms         |       3577 |   9.9% | ###
      2 - 4 ms         |      13259 |  36.7% | ##############
      4 - 8 ms         |       2523 |   7.0% | ##
      8 - 16 ms        |        222 |   0.6% | #
      16 - 32 ms       |         10 |   0.0% | #
      >= 1.05 s        |          3 |   0.0% | #
     -------------------------------------------------------------------

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/Documentation/perf-sched.txt |   6 +
 tools/perf/builtin-sched.c              | 191 +++++++++++++++++++++++-
 2 files changed, 194 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index a4221398e5e0..4da06215163a 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -40,6 +40,12 @@ There are several variants of 'perf sched':
   Tasks with the same command name are merged and the merge count is
   given within (), However if -p option is used, pid is mentioned.
 
+  If -H or --histogram option is passed, a CPU wait latency distribution
+  histogram is displayed illustrating how long tasks waited for CPU
+  runtime across latency buckets between snapshots. The --time
+  option (start,stop) limits analysis to a specific snapshot time interval.
+  The --hist-mode option (log or linear) configures the latency bucketing scheme.
+
   'perf sched script' to see a detailed trace of the workload that
    was recorded (aliased to 'perf script' for now).
 
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index c34726b87eaa..6d98566fc547 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -59,6 +59,68 @@
 #define MAX_PRIO		140
 #define SEP_LEN			100
 
+#define NUM_LAT_BUCKETS 22
+
+enum hist_mode {
+	HIST_MODE_LOG = 0,
+	HIST_MODE_LINEAR,
+};
+
+static const char *lat_bucket_names[NUM_LAT_BUCKETS] = {
+	"< 1 us",
+	"1 - 2 us",
+	"2 - 4 us",
+	"4 - 8 us",
+	"8 - 16 us",
+	"16 - 32 us",
+	"32 - 64 us",
+	"64 - 128 us",
+	"128 - 256 us",
+	"256 - 512 us",
+	"512 - 1024 us",
+	"1 - 2 ms",
+	"2 - 4 ms",
+	"4 - 8 ms",
+	"8 - 16 ms",
+	"16 - 32 ms",
+	"32 - 64 ms",
+	"64 - 128 ms",
+	"128 - 256 ms",
+	"256 - 512 ms",
+	"512 - 1024 ms",
+	">= 1.05 s"
+};
+
+static const char *linear_bucket_names[NUM_LAT_BUCKETS] = {
+	"< 100 us",
+	"100 - 200 us",
+	"200 - 300 us",
+	"300 - 400 us",
+	"400 - 500 us",
+	"500 - 600 us",
+	"600 - 700 us",
+	"700 - 800 us",
+	"800 - 900 us",
+	"900 - 1000 us",
+	"1.0 - 1.1 ms",
+	"1.1 - 1.2 ms",
+	"1.2 - 1.3 ms",
+	"1.3 - 1.4 ms",
+	"1.4 - 1.5 ms",
+	"1.5 - 1.6 ms",
+	"1.6 - 1.7 ms",
+	"1.7 - 1.8 ms",
+	"1.8 - 1.9 ms",
+	"1.9 - 2.0 ms",
+	"2.0 - 2.1 ms",
+	">= 2.1 ms"
+};
+
+struct perf_sched;
+static int latency_bucket(struct perf_sched *sched, u64 delta_ns);
+static void print_latency_histogram(struct perf_sched *sched, u64 *hist,
+				    u64 total_count, const char *title);
+
 static const char *cpu_list;
 static struct perf_cpu_map *user_requested_cpus;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
@@ -124,6 +186,7 @@ struct work_atoms {
 	u64			nb_atoms;
 	u64			total_runtime;
 	int			num_merged;
+	u64			hist[NUM_LAT_BUCKETS];
 };
 
 typedef int (*sort_fn_t)(struct work_atoms *, struct work_atoms *);
@@ -219,6 +282,10 @@ struct perf_sched {
 	struct list_head sort_list, cmp_pid;
 	bool force;
 	bool skip_merge;
+	bool show_histogram;
+	enum hist_mode hist_mode;
+	const char *hist_mode_str;
+	u64 global_hist[NUM_LAT_BUCKETS];
 	struct perf_sched_map map;
 
 	/* options for timehist command */
@@ -257,6 +324,59 @@ static int scnprintf_latency_unit(char *buf, size_t size, u64 nsecs)
 	return scnprintf(buf, size, "%6.3f s ", (double)nsecs / NSEC_PER_SEC);
 }
 
+static int latency_bucket(struct perf_sched *sched, u64 delta_ns)
+{
+	u64 delta_us = delta_ns / NSEC_PER_USEC;
+	u64 b;
+
+	if (sched->hist_mode == HIST_MODE_LINEAR) {
+		b = delta_us / 100;
+	} else {
+		if (delta_us == 0)
+			return 0;
+		b = 64 - __builtin_clzll(delta_us);
+	}
+
+	if (b >= NUM_LAT_BUCKETS - 1)
+		return NUM_LAT_BUCKETS - 1;
+	return b;
+}
+
+static void print_latency_histogram(struct perf_sched *sched, u64 *hist,
+				    u64 total_count, const char *title)
+{
+	const char **bucket_names = (sched->hist_mode == HIST_MODE_LINEAR) ?
+		linear_bucket_names : lat_bucket_names;
+	int bar_total = 40;
+	char bar[] = "########################################";
+	int i;
+
+	if (total_count == 0)
+		return;
+
+	printf("\n %s (total samples: %" PRIu64 ")\n", title, total_count);
+	printf(" -------------------------------------------------------------------\n");
+	printf("  %-16s | %10s | %6s | %s\n",
+	       "Latency Range", "Count", "Pct", "Histogram Graph");
+	printf(" -------------------------------------------------------------------\n");
+
+	for (i = 0; i < NUM_LAT_BUCKETS; i++) {
+		double pct;
+		int bar_len;
+
+		if (hist[i] == 0)
+			continue;
+		pct = (double)hist[i] * 100.0 / total_count;
+		bar_len = (hist[i] * bar_total) / total_count;
+		if (bar_len == 0 && hist[i] > 0)
+			bar_len = 1;
+		printf("  %-16s | %10" PRIu64 " | %5.1f%% | %.*s\n",
+		       bucket_names[i], hist[i], pct,
+		       bar_len, bar);
+	}
+	printf(" -------------------------------------------------------------------\n");
+}
+
 /* per thread run time data */
 struct thread_runtime {
 	u64 last_time;      /* time of previous sched in/out event */
@@ -1140,10 +1260,12 @@ add_runtime_event(struct work_atoms *atoms, u64 delta,
 }
 
 static void
-add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
+add_sched_in_event(struct perf_sched *sched, struct work_atoms *atoms,
+		   u64 timestamp)
 {
 	struct work_atom *atom;
 	u64 delta;
+	int b;
 
 	if (list_empty(&atoms->work_list))
 		return;
@@ -1161,6 +1283,9 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
 	atom->state = THREAD_SCHED_IN;
 	atom->sched_in_time = timestamp;
 
+	if (perf_time__skip_sample(&sched->ptime, timestamp))
+		return;
+
 	delta = atom->sched_in_time - atom->wake_up_time;
 	atoms->total_lat += delta;
 	if (delta > atoms->max_lat) {
@@ -1168,7 +1293,13 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
 		atoms->max_lat_start = atom->wake_up_time;
 		atoms->max_lat_end = timestamp;
 	}
+
 	atoms->nb_atoms++;
+
+	b = latency_bucket(sched, delta);
+	atoms->hist[b]++;
+	if (strcmp(thread__comm_str(atoms->thread), "swapper"))
+		sched->global_hist[b]++;
 }
 
 static void free_work_atoms(struct work_atoms *atoms)
@@ -1252,7 +1383,7 @@ static int latency_switch_event(struct perf_sched *sched,
 		if (add_sched_out_event(in_events, 'R', timestamp))
 			goto out_put;
 	}
-	add_sched_in_event(in_events, timestamp);
+	add_sched_in_event(sched, in_events, timestamp);
 	err = 0;
 out_put:
 	thread__put(sched_out);
@@ -1266,11 +1397,15 @@ static int latency_runtime_event(struct perf_sched *sched,
 {
 	const u32 pid	   = perf_sample__intval(sample, "pid");
 	const u64 runtime  = perf_sample__intval(sample, "runtime");
-	struct thread *thread = machine__findnew_thread(machine, -1, pid);
+	struct thread *thread;
 	struct work_atoms *atoms;
 	u64 timestamp = sample->time;
 	int cpu = sample->cpu, err = -1;
 
+	if (perf_time__skip_sample(&sched->ptime, timestamp))
+		return 0;
+
+	thread = machine__findnew_thread(machine, -1, pid);
 	if (thread == NULL)
 		return -1;
 
@@ -1454,6 +1589,10 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
 	       work_list->nb_atoms, avg_lat, max_lat,
 	       max_lat_start, max_lat_end);
 
+	if (sched->show_histogram && verbose > 0)
+		print_latency_histogram(sched, work_list->hist,
+					work_list->nb_atoms,
+					"Task Latency Histogram");
 }
 
 static int pid_cmp(struct work_atoms *l, struct work_atoms *r)
@@ -3566,6 +3705,8 @@ static void __merge_work_atoms(struct rb_root_cached *root, struct work_atoms *d
 				this->max_lat_start = data->max_lat_start;
 				this->max_lat_end = data->max_lat_end;
 			}
+			for (int i = 0; i < NUM_LAT_BUCKETS; i++)
+				this->hist[i] += data->hist[i];
 			free_work_atoms(data);
 			return;
 		}
@@ -3625,6 +3766,24 @@ static int perf_sched__lat(struct perf_sched *sched)
 
 	setup_pager();
 
+	if (sched->hist_mode_str) {
+		sched->show_histogram = true;
+		if (!strcmp(sched->hist_mode_str, "linear"))
+			sched->hist_mode = HIST_MODE_LINEAR;
+		else if (!strcmp(sched->hist_mode_str, "log"))
+			sched->hist_mode = HIST_MODE_LOG;
+		else {
+			pr_err("Invalid --hist-mode '%s', expected 'log' or 'linear'\n",
+			       sched->hist_mode_str);
+			return -EINVAL;
+		}
+	}
+
+	if (sched->time_str && perf_time__parse_str(&sched->ptime, sched->time_str) != 0) {
+		pr_err("Invalid time string\n");
+		return -EINVAL;
+	}
+
 	if (setup_cpus_switch_event(sched))
 		return rc;
 
@@ -3634,6 +3793,21 @@ static int perf_sched__lat(struct perf_sched *sched)
 	perf_sched__merge_lat(sched);
 	perf_sched__sort_lat(sched);
 
+	next = rb_first_cached(&sched->sorted_atom_root);
+	while (next) {
+		struct work_atoms *work_list = rb_entry(next, struct work_atoms, node);
+
+		if (work_list->nb_atoms && strcmp(thread__comm_str(work_list->thread), "swapper"))
+			break;
+		next = rb_next(next);
+	}
+
+	if (!next) {
+		pr_info("No matching trace samples found.\n");
+		rc = 0;
+		goto out_free_atoms;
+	}
+
 	printf("\n ------------------------------------------------------------------------------------------------------------------------------------------------\n");
 	printf("  Task                  |    Runtime     |  Count   |    Avg delay    |    Max delay    |      Max delay start      |     Max delay end     |\n");
 	printf(" ------------------------------------------------------------------------------------------------------------------------------------------------\n");
@@ -3658,8 +3832,13 @@ static int perf_sched__lat(struct perf_sched *sched)
 	print_bad_events(sched);
 	printf("\n");
 
+	if (sched->show_histogram)
+		print_latency_histogram(sched, sched->global_hist, sched->all_count,
+					"CPU Wait Latency Distribution Histogram (between snapshots)");
+
 	rc = 0;
 
+out_free_atoms:
 	while ((next = rb_first_cached(&sched->sorted_atom_root))) {
 		struct work_atoms *data;
 
@@ -5076,6 +5255,12 @@ int cmd_sched(int argc, const char **argv)
 		    "CPU to profile on"),
 	OPT_BOOLEAN('p', "pids", &sched.skip_merge,
 		    "latency stats per pid instead of per comm"),
+	OPT_BOOLEAN('H', "histogram", &sched.show_histogram,
+		    "show CPU wait latency distribution histogram"),
+	OPT_STRING(0, "hist-mode", &sched.hist_mode_str, "log|linear",
+		   "latency bucket mode (log or linear, default: log)"),
+	OPT_STRING(0, "time", &sched.time_str, "str",
+		   "Time span for analysis (start,stop)"),
 	OPT_PARENT(sched_options)
 	};
 	const struct option replay_options[] = {
-- 
2.55.0

