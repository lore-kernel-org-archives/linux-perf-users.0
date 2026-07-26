Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021139.outbound.protection.outlook.com [52.101.95.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FBF375F9E;
	Sun, 26 Jul 2026 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785036353; cv=fail; b=fO5igh1Hd9nt1I4h5UfRKXDY57+sIylnQ4ZTKj9loIAPVokEKJTJ2E6DUIQ/HMzj2+rBsmt58/wEzT8wLQEbomeHJi2hvjfJrR3IFayeYgiO7Tf/HoMbdLtVBZKSE9/LRmR57W2dTHqiX17VGjBQvheslLMcDdoiDXjrVF2W26Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785036353; c=relaxed/simple;
	bh=t2U7GNZwpU4BNvfJ+DX4Lrb4UwPNBaEyxp6ei6IBuvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n3Y8evOtdB3jz3f1VBlYG2Jl1LwpHHu4+U4OrKoLS71MDqXedfmFVJqO7WpYO8AZFE5axDnqk2Nogoz+mJ3GXRHkasx6x3biH4qji9PH24vkoGuYHo2K3tiA/UxzxM1fNpKNUdnw7JwJbhwGh3+3qMb778DH+xBZwa+lS5xQnwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJdVI/MuHX25n++Jeg+s8TYTJPwCnGk9+i99iQQuRQYLe+FWYRydMf5K/YwzDMCH+aVrrIbCMUrWcV9WOS0iC9eBjX+3JqLbOw7GLDgNjGWCvGMhpjxfQb288xk9CqxJaZM1+t/L+hL1GhFpmOkhhyFBZB6t1oHzXRdS4Sf6oZJ+S5wsvBfo5tjrQkDleGMZZySV++myPI/+ayaJ88Ub4rHRLRRudYOeVQ0/d3PcyvGjMKBcACNmwzVPGU0TqFZDwb1ZlLGSp+CQiz2j2knZ2GSCjo+LK4ciE+IlWO9AcHWiEc17hWhhBoeB4zhGje93ivO6fYU2Cb+Y9zffggF4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=QGwxqntu1W4B6UfXNHX/5q46BaHLf7vurOW1QnGZfuo=;
 b=NlRz+oJlfELGOuhwtRf76LV6icFKNZVp3sLBWqP7o3DW2ESqAcIexTR86AXBYoP6pdiUKjnQoVd/7FzpF/9pzeE9TJPlit0/JwAUOoviWvzqVWxHuEPD7QEQJ/aAgEXYRqWcb9g5WB4FceSxAIoaazS1DP4bNA53DHyMUmtMjLQE+qcHRghp+nPIVBadzWFAvHFU1ApbRod8+QpFxXrxUh0wZlEHfYOp5aXXbfZxTtg2FfzU4pGE9mCzXZa+0Tk5sI0lp1q/JKMRw77jyX2H1EFj/57WerY9ENknYI/2BRe9GUHLFMsBwYfpDWJDspjvcAkBLErMawsCsPMzV0bhDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB7849.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 26 Jul
 2026 03:25:49 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 03:25:48 +0000
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
Subject: [PATCH v3 3/3] perf sched latency: Add histogram and time interval options
Date: Sat, 25 Jul 2026 23:25:33 -0400
Message-ID: <20260726032533.712462-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260726032533.712462-1-atomlin@atomlin.com>
References: <20260726032533.712462-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0307.namprd03.prod.outlook.com
 (2603:10b6:408:112::12) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: f8fc177a-43e4-4563-f15c-08deeac59680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|56012099006|10067099003|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	4iVnmU2hZjmX2b5rgMdsdL9lPwuwo7nNtmQjGToQi+jlVXBMnYAJPPVJUdgWI4hh4es0yMziHX2tKXdwPtERmuSjFISiiyR8ewneX39Hfi7PS8KJ6qoE8Ns7FxqENrXzYR+Pkqf1kElA4bHHNxF67v4Y4MZSJsrkXnalLkrSYitefVwD5186JitMZpXcBFWxiF9uzhL+KSiPfi9OO8N0KWLiKeWWiZgEULMjUBbgm8LAzCds293/qD2M/GIBjT4jX1xmzxyXvA7zJZI+MHq3vuVlC1o+2Qaa/l7bN9EqSyHK0sM1ixP3JInGBqyO+B1dGsHEhhkNAhwbeCUvo5QpdMEMlWTGpPRLI5D/h70sPTOSfo7mFhot6lHC/pVTjmqc0d5rTyTmt8tRq92A2e2OR1o9ZRb5RlYdnkEzfc4uwBZVhHK3ZhAxQBdbdTnV1YQbGqEh2YUDBHWLHktFAN2RqrvG7nL3rRDGT/LM5BbYuk88DnEWK2TtOtWohR4wvY/w8ZvhYbDudtvJu+dEgVcbTttyjLhsHReGUGiwiwLtOd//H0lzjydd94fTfE7M+aYnw5AO0VQZVrI9FvLzIXEdxsl8/31XCGXs6ewzzoajcOecOZK4NC2e7eserhrghtKUaHy6yGOvel24y1LgwBemjxJ8xQfRfMYueXb+J0BfkmE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWpvemJtY1ltamlRL0x2YWZvTGI1TDRra0kraDhRQitPQitqSzVvS3psTEhE?=
 =?utf-8?B?WUE0SDN5RzFTSjB4N2tVUFpyd2pNOXNPWmJyZ0d2emFXVmd0T1E2elE2Y1Rl?=
 =?utf-8?B?SHRTMkZnMVh5UHh0Q2FxK1Z2RFVkcHdrcmZWSmUra09oMVZsZFhMWEFyYno5?=
 =?utf-8?B?bjhsdFlFZ2JUUml3clBTSXBWK2NrUi8xTVAvOEJRNEFlRkFXVHY4d3Y5N284?=
 =?utf-8?B?TklYN0srRzgrOHpXclF4eVhrL2t4MDlZYml5TUNaK3JiNERyK3lWQ3NDSkVn?=
 =?utf-8?B?QzZiR2JSK0g4ZkpHaHZBSU5PTHYxRjhBRFRsWEdraGtKZG9vdkJUY1prMG43?=
 =?utf-8?B?NEpjU1JKZkVwbUJJSUJJY2dlV2UvZ1VXaDMzbU9GZmZRSEgxSVBka0o0Y24y?=
 =?utf-8?B?bmhkUFdzUm0wYmNTdVl4NnFUWDkvcW5XRWxGWVRHM0VFOWlua1MvZzdQaHpK?=
 =?utf-8?B?eWErVU9laXdKMHI0SUx2R3ZCVmsxYi9DNlZMbUI1SDVjVC9tazVvcnRvdmds?=
 =?utf-8?B?ek9kY0xhYUxja2RHejFEengyWERDOURSRVU2dGFROGs5bG5Id0hTOWhvLy9T?=
 =?utf-8?B?aFBJRGQ0UkkvZGJyM2RYaDMyaE1EVDZORytZcDNHdzYwWDFMbU9MSEpkMy9p?=
 =?utf-8?B?MEprS0hHeFNuLzZQVkNRNjNIaUhVM2pidENmSnphSFRBcGZNa21GM0RyM3F5?=
 =?utf-8?B?VlRIS2FsbE9KOGorRG1ZbjZId3ZTZkRMbHcyWHpXdGRxR1BTK2Z0R0Qyd0dW?=
 =?utf-8?B?WThNbUR3TTBqMzhhUjNYOVNmcnhZY1RSOWVnVGFzdVpSSlN6YndXbmhQYW1P?=
 =?utf-8?B?S1B1THQ0MUxzSG94Y3dNNmNydXBBNVFEckVHRmJzSlJjY2JiZkVXTUdOVFdB?=
 =?utf-8?B?dHhtd0lrNmxpcTB4K3lhUm5KdHhhR1RJdlZVMDA1TWRwVERiaDJzUUxpNktW?=
 =?utf-8?B?TlhkM1BQemNaVk9NL1h6MEFlNGRkcmRnTDJWMUp0QVBXMkVMQytqRWErTHR3?=
 =?utf-8?B?MGVIMXNncGovRitGR0ZPTXBYUGdFUmVvN1UvdmlrTkRVMVErZkVkemh2NGFF?=
 =?utf-8?B?WUNhVnBwb2ZESG1sMWRHNEdtSUZ5Z28wdjNzWkJFUFBTaGJacjN2RVo4TUdh?=
 =?utf-8?B?VFRXMHRHK3hXQmVZZmM1SzM4UE1HajN5NEtHbkVxTk9iSWR1aUlUTExwS3dZ?=
 =?utf-8?B?eGdJWlFTbVdWRU5OS1ZPaUw5bzhUTDBEU24wN1BQTDR0NHZxZVVLOG1qKysr?=
 =?utf-8?B?aCt1VW00UjFZN0I1OXROcUp5bFV4T295OXhlVmQzSTk0RUE3TWljbjlPM210?=
 =?utf-8?B?bEpvUGZ5R3p0allzVy9GNGhuWDkvZHZzTXBrb3JSK21kRk5TYzNvTk9DUWZy?=
 =?utf-8?B?dThFTVdnU0FMeGxFb1RzTURuUTdBZ25EVnorU2pHcGhaT2NPV1NDY1JLS1Jt?=
 =?utf-8?B?SVBLU010YXR6NEpjZjNCaTdSWTEvazlEM1BSbTBKQUMrNHZnOUdMeE5aQlpx?=
 =?utf-8?B?OFVFZ1ZlRzRTYzRxYjNrRGh3allQbHZFUUpNazllMUwxcU9DTnJLcWZibFJE?=
 =?utf-8?B?dy9vQWFTbjdGVTlSUGhxSC9jUE0wLzhCZ00wQ1lIRHZPMllMc3NhM2lKVFlu?=
 =?utf-8?B?M3UrOVNEaC9vOGhqUFB0OS9DZ3dLNSsvTUJja212Z0hpUlhyNWFBNDY0eWtT?=
 =?utf-8?B?VkJUTk0zZEVZUFljVGxkeXR0Yk5JR0kvVGx4S1pYaXF0ZVNoT3JIZXF3ZWQr?=
 =?utf-8?B?TVJPYU5GdnltUGdsWGp6ODFqNWsrQUREc2Y2ZE8zTnRsOXNYR1VIS3pXY01r?=
 =?utf-8?B?SVBtbTNWQzdoNnhMVWxyT3JKRlVialBxTlplWUxLVHFtRFRkVXB4dHFjYlN3?=
 =?utf-8?B?WGFROVVCek1PYWJGcFc0aWpGWUJMYnRPLzZOSTNQMWNtUkhLRFE2UVZmUXg5?=
 =?utf-8?B?czlRaGtEOUFXTTFlcm9KMU91RnJ4QTFBTGJEaHNnMVZkbGNrMnk0bSs1ZU4z?=
 =?utf-8?B?Q0U5dEcxeGx2L3g1N054N21IS3RzT0lEeEVWWUZaLzZqTVZMdWUzMU41alhY?=
 =?utf-8?B?UzlsVnlvZ1lhdDh6R29rQmhyOVE1RUh2Zk42b29mczg1UGowbWVycW01d1ZS?=
 =?utf-8?B?UHZNY0QyNW5uOHNRV1VsWGwzbnp5bHRNNENNWTd6QmYxV0ZtdjlZcUJhaXNE?=
 =?utf-8?B?QlBqSjZxZXlCTGMvNk9VUHBiU1YvOE5IUktoVk5IMDdGdXBEdnJ1K3FSdytn?=
 =?utf-8?B?RUJ6SEh5VDFXTWE1UUhrRSsxKzlpcEZCd0lNL2RndkY2bkJUY0lKQkZZSWFx?=
 =?utf-8?B?R3A0Q2h3LzJmdkU3ajlmaTV2T0RycTZZVDFidnc1cEFzbVprSU1uZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fc177a-43e4-4563-f15c-08deeac59680
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 03:25:48.8911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZHMPvXIEewyUpoeY+YxAtd8U+WwGOTGUNvKaIRlJ0e1X7fJJcKX5JzDX0+eJlOL2zg+exQafGoc5KUGjekRYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB7849

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
index 8c83dc423b57..9d76fb00e9ff 100644
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
@@ -3560,6 +3699,8 @@ static void __merge_work_atoms(struct rb_root_cached *root, struct work_atoms *d
 				this->max_lat_start = data->max_lat_start;
 				this->max_lat_end = data->max_lat_end;
 			}
+			for (int i = 0; i < NUM_LAT_BUCKETS; i++)
+				this->hist[i] += data->hist[i];
 			free_work_atoms(data);
 			return;
 		}
@@ -3619,6 +3760,24 @@ static int perf_sched__lat(struct perf_sched *sched)
 
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
 
@@ -3628,6 +3787,21 @@ static int perf_sched__lat(struct perf_sched *sched)
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
 	printf("\n -------------------------------------------------------------------------------------------------------------------------------------------\n");
 	printf("  Task                  |   Runtime     |  Count   | Avg delay       | Max delay       | Max delay start           | Max delay end          |\n");
 	printf(" -------------------------------------------------------------------------------------------------------------------------------------------\n");
@@ -3652,8 +3826,13 @@ static int perf_sched__lat(struct perf_sched *sched)
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
 
@@ -5070,6 +5249,12 @@ int cmd_sched(int argc, const char **argv)
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
2.54.0

