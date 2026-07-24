Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021142.outbound.protection.outlook.com [52.101.95.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797BD367B73;
	Fri, 24 Jul 2026 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784923938; cv=fail; b=SP3clQKBZM8wEsko6FwbcGEQPIwGhHfteuAoDFyEK7A3yUWuflUAcx5P4AifFBOq01vEk/EsgF2w9tNczR9sYCWrlPU1oZIeNd2RIGWYXCgEU7uSLyJj2UPKLrxkX+DPDepDyL3uSqdt8xg2UUBJiiAglaLqS+aQj5lPkKo8wSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784923938; c=relaxed/simple;
	bh=sqfSYeTfb3606so9Uohiis5FScp8TkLaHFJJ5bKarPA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FNE0DXVe0mK6L/Bam/j2buCqoSzSGyFgqGC/j94pMAIN5A0eqMJFSYJBmb46fpR6Sa4Qiiso7v8azvIDL+vHe0Lm8TDpr5AYBzYIb+LgYRkexAKwF++jP2t+bvuuOyemZaEbkBVR6K9tP45AX7LhCKJTQCBgoxxhgh1+TZXrXDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C76ZVXtak1mJHTKu/J4g1G7NBZLqV5SLFHxC7jz2i5JFgzCvmzH2s6/QbVRTy9O4+zZTzRixc0/SNG5ZtNqKOKOtW9DAR44B/WktrSrZvI3VSYMp/lKyIDCo/6H1Djc2j/VHHthuVlMsrJ3dMGg8mf81AGv9lh71tA3/d4DlVxg8Mv6R9lLaekDc5FFPYDOJqvPUHiO6645ASv9rJcFVHbHROyu6uJCLY60yoPdvUWOY8lQCru9b3N03xKBH4QRPoHqJdca6kSJfngUvK2JwyGyWfYGrd5vfKy/961hOn5kWcCAAIl1nbiNKiKQHmPwmuME6UvJpE80+L0L8lyKo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=swFHP9dzVj9Zj1+rGoBzFpjq35EwdDcV+XikV9g1K5E=;
 b=gl73I5YL74zmEfky0JkCnMNVeV3KTlb6eubGh+TyouoDMtEak3rlRPGH8owx7Gv4aNnOsv8uxoSsMyuIKNRspl7SuumdR/JniZH9S7ZzseiE8+5DSNCN9Nl3X2DyrAXctDy8CEFie98Lq6QEu6s1Dp4eYXEE8aocfyyoXh2LFlm3EgV+TcdOqmYPI1wlB8oAk/MUjPgBecfwMpsjiRkRb9hDWsf/T6jAbn9fqC7L77hDRYUFoWfXmY2UpxkEMFydNNMOuN6Bp72qF5OCP3bN69EeLxKcyr9YnQXvYyts3fFqdpIsRN3sjegn55m0Xg7wTWvJPC+xoE6PCj9L/vAD0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB7433.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:379::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 20:12:12 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 20:12:12 +0000
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
Subject: [RFC PATCH] perf sched latency: Add histogram and time interval options
Date: Fri, 24 Jul 2026 16:12:07 -0400
Message-ID: <20260724201207.661300-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::22) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d9d883-8d12-41f1-eff4-08dee9bfd898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|18002099003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	g926XgjwDPKDnEzQM7itnaCQ9pkrvIIXTzX2ndxw5AIGIdr1VqfftSbh6STgasQIEpk3nyEDPFxVU9EsF4TuhTYoJJIAyRd2ZAKnRzuiAkPbwnb93Zmug6tv9xY2Vq/1OBcVPRSs/5vN5XKA6KabXv7DMiJmbcOQBAgAeheOmtQZDAwgNpeDDVF56C8tl6YN+n63AfdOHPRUwfcwTvGbrVIvzziBzkhNk83M9/UYGPZlVHRpdOT1c+Aq9XngLoyJqGgi30Msgop1tZMZX9Z7t0b977JDQkstvwSclq6Btyv/nH9uMYzDu1Ub2pXg+oLf6QMrCclgAOpnHq2Ocs0JMKx2THSDvsZxYW6ItQlSdnvptep/MeThVTHXi7guW1T8K2ua8yDeiwHeiEYXW8R5madZQN3IuSpuy4EAf/tBdR5xgmG28U70BoqFHpBP/h5/zuWeJnqobOkGHsCiwtMEEGn9iurCNbw5BIxJ0V3Qye4VwANFV6GQrA4cAeAiMHMfKVSdtpkjNike/dmde8en+KC9BPSC8AHV93uOhnB8hwjhJGsdJpsQ5bNNgcpus4zWG/PnXsPK2VY7Z8o+L8eWauD8Gc4TSRh0FT0MgbqvH/a4Xnt/mKce39KeElpWwOiJgebwGe8jmqeCd+yPso4CyIykwePYnxM7aDJ0Thxu2OQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFdsYUx4OUFRN3dXblBhbnpNNitOeHJNd3JIQXdtY1ZXMm5CaUlldDNPeVdS?=
 =?utf-8?B?YTZoekxUaEg4d0hUcWFjSjlncWRlNFYweE5OcjAvejNsRUpxN25GQXcrbTNW?=
 =?utf-8?B?R1dsd1I2ZkNjVXVoV05VV2VKdHllazNkVDZzbkU4ekd1TkpPZElRQkpOZ25L?=
 =?utf-8?B?OHZRbjAvckoxWWxiOCsxSTdPN2FGUmQ0L1gwNzZFSVJPQW5YbFE0eVhyOUhY?=
 =?utf-8?B?RlVDbllQbG9sS2tFREcwSmxPUStob3ljQnhYWUROQ0UvZUVtenpYR3JGemxo?=
 =?utf-8?B?Q3BXeEVTWnlwWlduQ0Z5YTYzUTFwM3E1OW44VjIxUlFOeTl0WDYrWU5vU0F0?=
 =?utf-8?B?cVN6ajRKV2pLcmZxd3c0M1NZZWl3VzVleEc4Zmd5Uzg0THgwNVJhN1NiblVa?=
 =?utf-8?B?S1EzN3QzRXRycXV0MU83clNCTzg5MzdIYzIreG56ME5QUklMRS9OUGpXWG00?=
 =?utf-8?B?L3hFa1lrQnUxMndqOFZwU2xZdC8yTHFsNmpyOC9NRzJHNE11N2hXM1MrWVlu?=
 =?utf-8?B?NmhYS09tTVBzNFJLa280a1dvQ1FCMTYyeXk1bHdERHhlM2RacEZYNVYwVkR5?=
 =?utf-8?B?R2lScVVlTFRTNE0wZVdHUXhnWlhYMHJlbjJmNHJSK3l1UUtIczNqTENBa1ZK?=
 =?utf-8?B?SktmUDMzNldQZ3d0MGNvTlpwWXc0MWVoanljR1ZGTlkrR0ltRG1DeHJCSnhR?=
 =?utf-8?B?SGRKK2xQTERoSzhlUzg5ZlI5eU1qOWtFRkU3SVN1Zk5qNEtFZGZPbXY4WHhn?=
 =?utf-8?B?eVA2K1pYazZjUm5mdFhEYjZMdEJQRmdnK1YwVWZHY1dKZGt1K3R2UFN2QkRl?=
 =?utf-8?B?VzJKWWM0U0pFYmhwWGVxRmltVURZejh4R2VlQTU5dDl3WnFoNGNxOEtWY0lZ?=
 =?utf-8?B?MTk2aEJBcW5GRUxyUGFMZHFYUnFPMkZ4QlNYYTNzMGl3T3VmWmcwK1R0T0Zo?=
 =?utf-8?B?K0syZ1hNV3VoQU1QMHlmbmZpZ0xSZEpvaWtRRVo4bG1ac0ZXRHEwSEIrTGhu?=
 =?utf-8?B?djBMQ1MxNVlOUW1DTm53VHpFdkFFRlFmazJWUGxkM043WU4xSHNjK1IxbHhK?=
 =?utf-8?B?M1JRTzZ6b1hUNE1manhiODJMa1UrZk1UUmVPbUFmZHF0dDI5VnJIdzFpbDJ2?=
 =?utf-8?B?dVE4RGhVWXF6R1NOeXZmVmZscGdqUk0xckdSblV6Zk9FcHFYR1JhS29KdklB?=
 =?utf-8?B?OWhKdjllL0d5ejZXSkpkRE1TK3NWTklxY0pmZ2YyUXl4VjZtQ0pROUFyUVhQ?=
 =?utf-8?B?aGh6T05URkFrVTd4ZzZCQzVIV1J2RHA4Yit3ZGpqZzhiVXkxd1dCKzFVcTNJ?=
 =?utf-8?B?aXVXTEJlVHFjS3ZoQjVuYUgzL0IraTFBUlM0SXpHSnNmZmNYQjRiamNVdVZx?=
 =?utf-8?B?NGVVditBVnB6TDRGNGJNVy9HMFZ0MTF2TlpiRE5KM2RibmhXcVlTUlRpOWQ2?=
 =?utf-8?B?alJsZzMza0g4ek1QMUVwSFRuOUNNK0tHczBFNW1zOEZpc1BycktWZXJ6d2Yr?=
 =?utf-8?B?dG1zU3UvSUdFdWRUbDk3Tnh3RjloMkgyM0JvTXFhWUFUQ0c3b21BdFRUUmY0?=
 =?utf-8?B?R3ZmQ0N3ZmlER0dWL3ZtNkhnN0VlZjNUaTI4RTFwWEIwK1c5WUdGaVUzbFFy?=
 =?utf-8?B?SlBGWVZNc0tOS3hBUkZKemp1dG5sUUU2YXRHbzBEcHQ4YUkrNW50VGNCMEdP?=
 =?utf-8?B?YnBPTUNoY0VYNFdoQjBJVVVkc2JNS0RLNEFvcklnZVlnSXlOdG5aM3g4SmVZ?=
 =?utf-8?B?VDJPOXIwZXYycjhJanpJSTROekNDcXhrNVZMUW9udys0Y2p0YS9oa0lZY200?=
 =?utf-8?B?aU4vbU1PZ2pnQlpab3c3eUkyWlcxbjQybFBsQWpMc1NlY1JyS2dCaS9sdTg4?=
 =?utf-8?B?eTV6a2R0am1yVTZ6a0tqT0lFRU1hVzJwQlVpdFhrVTNWUzNXVGNjblZ4WTVR?=
 =?utf-8?B?aGRNd1VDQmM0T2tBZC9aRFhOVTN6OSs4WEl5YVJvZ3ZKdElSWVU4UUVFQW1x?=
 =?utf-8?B?VWVHNTNSdGtjTWJlYlE4YlpjZFJEaVlvVHJXTWtCU3VHYldTVllBcWR6SklJ?=
 =?utf-8?B?Qkx1aldpM3FxdG5XYVJ4UzBSREU3MU91SlRVcVNxK0RNcWFMSjRRdnVUR2FD?=
 =?utf-8?B?dG0rc0N3MkptWnBXNm12dDJlSUlSRyttMG9ORk16WXd0TTJCakt3S3QvY3E5?=
 =?utf-8?B?VWhoRUZhU0hPYkZYZnRhQ3JHSTBXampiaVRaS2E4WDBKQk1rYVgrOGpkZVpa?=
 =?utf-8?B?dlJST29pSFZFQnhsMitndVd5Z0tYZzNEVUw3SzQzMWcwVXYzS1lVdkM3VkJC?=
 =?utf-8?B?dTlQQVJjVTN4SE5JM0xjTzFuUzR3KzRzUU9IWTBDaGhaTmFuU2swZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d9d883-8d12-41f1-eff4-08dee9bfd898
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 20:12:11.9819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6x34jHYsguYP/ekwhXTlnoosuTH6VUR7mdVm7phvbUOjARK1d6kbcask95zB0FWPXR+YRsoqlYHLLyIA5JV6DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB7433

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
 tools/perf/builtin-sched.c              | 180 +++++++++++++++++++++++-
 2 files changed, 183 insertions(+), 3 deletions(-)

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
index b3cf678573e0..b73149b84fb8 100644
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
@@ -246,6 +313,59 @@ struct perf_sched {
 	struct perf_data *data;
 };
 
+static int latency_bucket(struct perf_sched *sched, u64 delta_ns)
+{
+	u64 delta_us = delta_ns / NSEC_PER_USEC;
+	int b;
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
@@ -1129,10 +1249,12 @@ add_runtime_event(struct work_atoms *atoms, u64 delta,
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
@@ -1158,6 +1280,10 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
 		atoms->max_lat_end = timestamp;
 	}
 	atoms->nb_atoms++;
+
+	b = latency_bucket(sched, delta);
+	atoms->hist[b]++;
+	sched->global_hist[b]++;
 }
 
 static void free_work_atoms(struct work_atoms *atoms)
@@ -1188,6 +1314,9 @@ static int latency_switch_event(struct perf_sched *sched,
 	int cpu = sample->cpu, err = -1;
 	s64 delta;
 
+	if (perf_time__skip_sample(&sched->ptime, sample->time))
+		return 0;
+
 	/* perf.data is untrusted input — CPU may be absent or corrupted */
 	if (cpu >= MAX_CPUS || cpu < 0) {
 		pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound sample CPU %d, skipping sample\n",
@@ -1241,7 +1370,7 @@ static int latency_switch_event(struct perf_sched *sched,
 		if (add_sched_out_event(in_events, 'R', timestamp))
 			goto out_put;
 	}
-	add_sched_in_event(in_events, timestamp);
+	add_sched_in_event(sched, in_events, timestamp);
 	err = 0;
 out_put:
 	thread__put(sched_out);
@@ -1255,11 +1384,15 @@ static int latency_runtime_event(struct perf_sched *sched,
 {
 	const u32 pid	   = perf_sample__intval(sample, "pid");
 	const u64 runtime  = perf_sample__intval(sample, "runtime");
-	struct thread *thread = machine__findnew_thread(machine, -1, pid);
+	struct thread *thread;
 	struct work_atoms *atoms;
 	u64 timestamp = sample->time;
 	int cpu = sample->cpu, err = -1;
 
+	if (perf_time__skip_sample(&sched->ptime, sample->time))
+		return 0;
+
+	thread = machine__findnew_thread(machine, -1, pid);
 	if (thread == NULL)
 		return -1;
 
@@ -1302,6 +1435,9 @@ static int latency_wakeup_event(struct perf_sched *sched,
 	u64 timestamp = sample->time;
 	int err = -1;
 
+	if (perf_time__skip_sample(&sched->ptime, sample->time))
+		return 0;
+
 	wakee = machine__findnew_thread(machine, -1, pid);
 	if (wakee == NULL)
 		return -1;
@@ -1362,6 +1498,9 @@ static int latency_migrate_task_event(struct perf_sched *sched,
 	struct thread *migrant;
 	int err = -1;
 
+	if (perf_time__skip_sample(&sched->ptime, sample->time))
+		return 0;
+
 	/*
 	 * Only need to worry about migration when profiling one CPU.
 	 */
@@ -1438,6 +1577,11 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
 		 work_list->nb_atoms, (double)avg / NSEC_PER_MSEC,
 		 (double)work_list->max_lat / NSEC_PER_MSEC,
 		 max_lat_start, max_lat_end);
+
+	if (sched->show_histogram && verbose > 0)
+		print_latency_histogram(sched, work_list->hist,
+					work_list->nb_atoms,
+					"Task Latency Histogram");
 }
 
 static int pid_cmp(struct work_atoms *l, struct work_atoms *r)
@@ -3544,6 +3688,8 @@ static void __merge_work_atoms(struct rb_root_cached *root, struct work_atoms *d
 				this->max_lat_start = data->max_lat_start;
 				this->max_lat_end = data->max_lat_end;
 			}
+			for (int i = 0; i < NUM_LAT_BUCKETS; i++)
+				this->hist[i] += data->hist[i];
 			free_work_atoms(data);
 			return;
 		}
@@ -3602,6 +3748,24 @@ static int perf_sched__lat(struct perf_sched *sched)
 
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
 
@@ -3634,6 +3798,10 @@ static int perf_sched__lat(struct perf_sched *sched)
 	print_bad_events(sched);
 	printf("\n");
 
+	if (sched->show_histogram)
+		print_latency_histogram(sched, sched->global_hist, sched->all_count,
+					"CPU Wait Latency Distribution Histogram (between snapshots)");
+
 	rc = 0;
 
 	while ((next = rb_first_cached(&sched->sorted_atom_root))) {
@@ -5052,6 +5220,12 @@ int cmd_sched(int argc, const char **argv)
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

