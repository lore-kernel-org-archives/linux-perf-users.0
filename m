Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022108.outbound.protection.outlook.com [52.101.101.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EB4463B87;
	Thu, 30 Jul 2026 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437677; cv=fail; b=ME7G1Pjtuk9j72IfE6db+S+lRPfpMKDDuj1epNPaovLnIXxQHwI5sWOdqpvL74GkMQjRfxZuJeS1XGlVGNJ27hFmkJe4IcMC/HiAq0P1/1nDIAHKjKAwFCZcbuhNr3PI/9zTdOdiHgo49UiZ2QdyfTxDsOM71mV9fS2Gsw79oVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437677; c=relaxed/simple;
	bh=ed5fBWsRpzD7il1ZGwCp9c7t/TI1FOJcS3hRTCw2Y0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HsPPF9ZFdtCB9fSfHB3pwCTc8PycYGVItP65q+ipiMXwhECvUFP4gaHczJkVPhfem4+P4ImSbVQDucN9/4dBnEp+DH79YWbNLj8wOa+fq2SafcbNscRxfiQP3+taEuHHqYD0C2fiJHjzuOP82T3vwGjxOWufKYqtYyw/vxMkzPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLJS+PeRdps5ydjX6Exnl1RJLhsh7T3FyRg3p0Hijx2aoXolhw8vjsO3Q2feIshVj2MkuHV3UI2Z9C1QyppQSUKsgbmy4VcJX+H5WtuuN3MrWLMFAfLho/K4ETXk+wtwssbIN4wnCzds2X742h6AsmhFS9IMm8LhhDeD9LLVZwdkyeCNdQAjpDdmpArhd+5JCqp9OfN3vT2v+P3PXnk3kw4z0DqxQSgIUzxT+e1JylvUK4k5TtFuiLgAbQ8QIPR0VmMp4crTMqOyOiLQ2PeCRr0H6yUQm3mR+Yp2pa7ZeJ7LIwdvn76Gk6lnmtWkHDLCwexGuuj8kQ+0g4FSppgLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=KxL5lwt6IBa/0QQTf40J/qglvFKytds4B3BlGz/HI5s=;
 b=Lu+fgShcxGm8y5zf6VthfBxNIl5TUgpkZ5iSIvkYewsI5ovLBJjoqDgLINW7lnIk3E+lKCBTU6BCRxbfq+JipD+g9hFacHkrsDc/wq4gX0hxm4Fbs62ZlQ7XPuvm6fxqfw4mCq8qoqdcc45J56b0dq7PzJla2Ny8eXcdCMaviMUsn7OCKldNrZY7dT3NS0fkhnmbhSR6YSg4xl9YVYpx4hZd042R0NAsL1wwAKfNIKHtm8E2iMYF8PciPc6vp+IlD/ScE6ClBxH91sfdui1ptwZneX7grdNZOpxcn9D7XoO/LCB7wzUv8A4+OdTvJKhSRu+ZV0HMywmLpVAq8FNv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3654.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 18:54:32 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 18:54:32 +0000
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
Subject: [PATCH v5 3/3] perf sched latency: Add histogram and time interval options
Date: Thu, 30 Jul 2026 14:54:16 -0400
Message-ID: <20260730185416.97166-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730185416.97166-1-atomlin@atomlin.com>
References: <20260730185416.97166-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:408:ea::19) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3654:EE_
X-MS-Office365-Filtering-Correlation-Id: 82bfd6b8-2889-4e76-26b2-08deee6bfdae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|3023799007|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	X4LEdZwT8GY9GO+7QrKh8XCUJNWZcX9l+mczMz3Psds9Zv/fWYXMJ9TJg5i/36MxUMnXiTnPxEclCOUp2rqYE/wpj8xlF3+k0oR56u/ixHg1urU195C1iTOzhdrH2vcvL7tSMOb3oIq5o82P/oBq0OnMtqvqW1txgyXqaCnqd/DMKuikSyF6mmaWwVbpWODKMXGfJZhJ52OioOsXGYrERNM9vaPGrP9r0sqh+rE7zN8pjTE7AX3xAZJWRiuoqsoV99mmvPnNeSO8GOFsK+3ogywu/V7Jbg/isRofbY+5Ku8hl0JWbKY2YyEwJR95jrEqgS82anV9Wmtbv/PIiP1mLBrbtIwWwQq1+T+umqMHgYPyGIynLfmqMbryswPcEFxTdcZ6go/CO8cuaKcvkPWLn39ny2B0mujHngQqxJo1zuz8rW/58KWjFJb9ZJRGUzPCFlu4o04iglqjxwVL/Bkhmylc5K3zijWf0cxkcKAV5QvTj2rX3QFNGoMrzFaPpJ/90S8wdZfqNJZds4nGVAiM8f6j0LHuTwRoK1gPsxPhIPOTElubiRviaar1iIeg9tIeIzLdDM7tPQHS+oGQt2NAXnIxsbXz7o4ErIpuhxcfz4Ci6sospVM/tBsuwYFshRin+r3HvaM7qNJlfa6cC5A9FxIPsGm/xfe1BG+Osawm+c8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(3023799007)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0RpcVBqUE5YQS9MV3lYLzlmTjlDR1g5UjRrVmh2RHUwbTl4ZjJiN1U5RjNv?=
 =?utf-8?B?SHp5RGpUdER1cTZvZG5FRVJXR3l6bWhNdFZmTDJ3RTRBUll6aFNrYWdpVlhO?=
 =?utf-8?B?UVRidzBXSW9kK281SmN6NjFGdHRKVnVjUmdYbjBCSEp0U3QyNUVac1Fwd0Ry?=
 =?utf-8?B?NHI4bGtVbmNpZk8xUmpUM2h3djNGL2xpWlBwUnRaNi93Vnd1Z050eHhRYW0r?=
 =?utf-8?B?ZzRMTEFnOGcza1NqU3d0c0FZV05kL29sMEVReHBGdFp3UTBabHZaVVlGYUVW?=
 =?utf-8?B?WW1KNVZ4N0RDL2xCdm1pZEx0S3pjOUpPa3c5dkRCbk9NOVJzVG90L0dEY1V1?=
 =?utf-8?B?cUJJa3dnMmVxZFpoZ2pwV0VoMHRaVlJDLzludE5zWW5zblVlVWNudndkTDFp?=
 =?utf-8?B?V2lORlpBZGNWTHp6ZFI3ZDNRSGsvV2g0WFdTR2NwVkdPUHcyRkN5c01QMWpT?=
 =?utf-8?B?eDBPUTd5TSt6U09kVHZWVGl0S3hjVUFlLy95K0NHU1BDZ2M1ZnVNZmRLRmtJ?=
 =?utf-8?B?dVJsTkZVaWZ0ZXU5c21jalZ3WVVJU3ByTzZOMUFLVEE5U1FQUUVSa0xueDcv?=
 =?utf-8?B?NGxkeFQ4Vll4TGxFanJKWW01Z1NsMkFKck5OaTdVYkNYSGJvUmJqMnFRbGRl?=
 =?utf-8?B?cmZlRVZLVGxmNmlGVS8rRk9ZVkFyR01JMmdmVEtwWlpxZVU2bGg5cTVxQW1H?=
 =?utf-8?B?K3hCM3U0YzRaMXRMaER1MVhKN0lqblduWWcwMW9IeWlVblFsMmpqWTREeWFx?=
 =?utf-8?B?cXVJQnU0eFdiSHlmQ2haY3FGYXgvQ2s1OXJ3ZVdGQm5XVklzWGNyK3RQaXhj?=
 =?utf-8?B?WjJ1OHZoaFh6dnJEQm1jUjdYOVFBdWlKV21JY3lKZ0tRTEZFWjdsMDQ4am0w?=
 =?utf-8?B?N3VtWE9BbTkzdGYvMTQ3ME9XcHZvVnJPcHVhZWkwdjEyQ3JBQlY1bEdDNWc1?=
 =?utf-8?B?SExlZjBVbC9ndDZ2cWVBeEhZUE9YZmFyV0h2UWNib3VsVDdqMnBMK25QdFdW?=
 =?utf-8?B?VXVxTGliL1ViOWNNVW5vcUVvY1l1OWtqSndtUHlLTm1CQ0dPbzdVeGFBQXBj?=
 =?utf-8?B?UzlNZEQ3S2pTT0lKcmZiS2RYS3RTdkZEeTYwT2xmN2UzN0NmeitYMG9xbFZ4?=
 =?utf-8?B?ZnhTRUdIQkJZUmNiWTc1aEU1V3ZJekpudm5NM3lxV1E2MG0xZHFKRzBpNCtF?=
 =?utf-8?B?ckw3b2JabEtwbWlQclU3Z2grdHJCVFMwVXZGRGFRcDIrNysvQ3ZNSXp4bkg3?=
 =?utf-8?B?aXRPc2EyQlZzUm5IOXFFVnRYdFg3Z0pjSEJ4bDIxTHdBc3l6RzdZZDhZb2M5?=
 =?utf-8?B?NXdEVHpnVWxSL05uYXdZME9raEgvSWNYaDEzbHJnajh4dUJlV2RTaTJwd0kr?=
 =?utf-8?B?cktyQWtRNzNEZ3dGd2RyWkpyQWdlSjlBKzFkekxPRFNpZzlZajUrdUlodjFE?=
 =?utf-8?B?YmFMenl5YzUydW83d05OdTFkL21LTjhWTlZLWWIveWRwVWVhcFo3SW9KREli?=
 =?utf-8?B?ZGVRTnRZZmpSMzJKbHJvd2Z4YmtjR1FtQ0l4STdVRGQxbFJpamlmVTcxYmM2?=
 =?utf-8?B?MEd5TVQyQzMrTFp1dk5aTHRkNGN1NU5RSlBEYll2SzgzSEJ2MHpjTEhzUTZn?=
 =?utf-8?B?UEczQ043R1RXYmR6WEVQbzEvbkdxTnJGcHBXakdDRGphazJleldvcENaUTVE?=
 =?utf-8?B?d2lySlM4K3cvczJseS9aR05DQjR6Q1M3OGVQQi9wYldRZWo5U0ZnemZ3azJQ?=
 =?utf-8?B?dkNaRm9oV1FJaXM5cUw1QzVZclRMUEhkTW9kbkQ4OTlvQ2dMbTNXaVJvRlBB?=
 =?utf-8?B?SEpMOTdaSmlDY2J1VjM0bVBGWUhMcDQwNW0xVEltL1Q2U2xUNmlhZVVFU2dX?=
 =?utf-8?B?VDRESEdPcHZJRkdGb0NCOXJOaXltS0Npa1RBOHF0R2llSWhKMXhNdjM1MS9I?=
 =?utf-8?B?SmR6TEV6elo4T3VzVm1Va2RPVURNVmluNUNlN2FGQ210SVA3NHFTT0hLZEtm?=
 =?utf-8?B?bmNPdTR4cmRnY3MzczliaFE5Y3V3VHY1TS9NOXo5WmtSb0FTcWtHUGRsZEtw?=
 =?utf-8?B?S0tPSkl2aUVEMUtGOWtpcTBCWFZYeGNsd0hEakVYQ1N0Z2FjUWVvNnB3RTBk?=
 =?utf-8?B?Mmw4VWtUWW5wREIxMEd6WHVGQmd6S0ljTDVCVFJrMjlZbTdmQVZGQlJUMW9x?=
 =?utf-8?B?ZFlNaWlGLzJjaHFLNHdla2YzNDRha0FwWHRYT3B2SzFRODd5Q3BFcXRUYWFV?=
 =?utf-8?B?VUtCSHJMckozOEJhdysyb25sWkZad3ZERG50ZVZYYy92Vm10VG53UEZ4M3Rh?=
 =?utf-8?B?eU1kNzRINDdTa1VLWHV4dkZvdDUzNWlFcVBPbHY4dEZmUk9ETFR5UT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bfd6b8-2889-4e76-26b2-08deee6bfdae
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 18:54:31.9752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzVyf1Lx6NFJGOxnaaKt5fXULhMQNyYb553myjpLpfUt99ehxWWQ1KvK5UtBN7zFUzg1WDQPWjWWyK6cGYsAOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3654

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
 tools/perf/builtin-sched.c              | 208 +++++++++++++++++++++++-
 2 files changed, 209 insertions(+), 5 deletions(-)

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
index bfbedd12b346..76bff27c63ca 100644
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
@@ -1108,20 +1228,33 @@ add_sched_out_event(struct work_atoms *atoms,
 		    char run_state,
 		    u64 timestamp)
 {
-	struct work_atom *atom = zalloc(sizeof(*atom));
+	struct work_atom *atom = NULL;
+
+	if (!list_empty(&atoms->work_list)) {
+		atom = list_entry(atoms->work_list.prev, struct work_atom, list);
+		if (atom->state != THREAD_SCHED_IN)
+			goto reuse;
+	}
+
+	atom = zalloc(sizeof(*atom));
 	if (!atom) {
 		pr_err("Non memory at %s", __func__);
 		return -1;
 	}
 
+	list_add_tail(&atom->list, &atoms->work_list);
+
+reuse:
 	atom->sched_out_time = timestamp;
 
 	if (run_state == 'R') {
 		atom->state = THREAD_WAIT_CPU;
 		atom->wake_up_time = atom->sched_out_time;
+	} else {
+		atom->state = THREAD_SLEEPING;
+		atom->wake_up_time = 0;
 	}
 
-	list_add_tail(&atom->list, &atoms->work_list);
 	return 0;
 }
 
@@ -1140,10 +1273,12 @@ add_runtime_event(struct work_atoms *atoms, u64 delta,
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
@@ -1158,6 +1293,9 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
 		return;
 	}
 
+	if (perf_time__skip_sample(&sched->ptime, timestamp))
+		return;
+
 	atom->state = THREAD_SCHED_IN;
 	atom->sched_in_time = timestamp;
 
@@ -1168,7 +1306,13 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
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
@@ -1252,7 +1396,7 @@ static int latency_switch_event(struct perf_sched *sched,
 		if (add_sched_out_event(in_events, 'R', timestamp))
 			goto out_put;
 	}
-	add_sched_in_event(in_events, timestamp);
+	add_sched_in_event(sched, in_events, timestamp);
 	err = 0;
 out_put:
 	thread__put(sched_out);
@@ -1266,11 +1410,15 @@ static int latency_runtime_event(struct perf_sched *sched,
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
 
@@ -1454,6 +1602,10 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
 	       work_list->nb_atoms, avg_lat, max_lat,
 	       max_lat_start, max_lat_end);
 
+	if (sched->show_histogram && verbose > 0)
+		print_latency_histogram(sched, work_list->hist,
+					work_list->nb_atoms,
+					"Task Latency Histogram");
 }
 
 static int pid_cmp(struct work_atoms *l, struct work_atoms *r)
@@ -3577,6 +3729,8 @@ static void __merge_work_atoms(struct rb_root_cached *root, struct work_atoms *d
 				this->max_lat_start = data->max_lat_start;
 				this->max_lat_end = data->max_lat_end;
 			}
+			for (int i = 0; i < NUM_LAT_BUCKETS; i++)
+				this->hist[i] += data->hist[i];
 			free_work_atoms(data);
 			return;
 		}
@@ -3636,6 +3790,24 @@ static int perf_sched__lat(struct perf_sched *sched)
 
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
 
@@ -3645,6 +3817,21 @@ static int perf_sched__lat(struct perf_sched *sched)
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
 	printf("\n -----------------------------------------------------------------------------------------------------------------------------------------\n");
 	printf("  Task                   |    Runtime     |  Count   |    Avg delay    |    Max delay    |      Max delay start  |     Max delay end     |\n");
 	printf(" -----------------------------------------------------------------------------------------------------------------------------------------\n");
@@ -3669,8 +3856,13 @@ static int perf_sched__lat(struct perf_sched *sched)
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
 
@@ -5087,6 +5279,12 @@ int cmd_sched(int argc, const char **argv)
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

