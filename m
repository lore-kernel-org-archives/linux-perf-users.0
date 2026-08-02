Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020123.outbound.protection.outlook.com [52.101.195.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FD8345EAE;
	Sun,  2 Aug 2026 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785704981; cv=fail; b=LsGusSgPfCClvOFe74Qs8H+X6tfGruvPKoa+SPa206IJQDzdbb2vKGeIKhIHejBPgX1dFbOHpm782S+QpZi5s1em5IGvkrMQUB3ibvsNlx0iffovu7MSnIfhM9M+lUUGhEfERw3YvzzHheonmy3ZNmsQ4i6Q5IEUGwgsL973cBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785704981; c=relaxed/simple;
	bh=R0Y8DL3bjFNSQ0IrU7Oszrh3ye6d8rOrLxCgQzgZ0HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YxEOU+vDKf+EgVCCP2Xwf4WCpe0oDISggfbzCNZiB304bhhd6clsLj05Buz0yMxAI5HnHLQOhH73Nr6/ldknXEL7Xp2tIXVs4LKAGnL3P8pfxTSYJtxCdKqc4BHG/oe+p7LYeRIiZUailaxs2XQthqF8VsacJgVakUkkrm/XZsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3FYZgExkye5J+Xs79P53KnD5GmSGsOrfMFox1eVrjm8asjUObNMHo3zxBcO6xg1KF+lL8V5V3Ghj4Un2sLBUqI+fy4gjZ8ztz4itrMmoAg/3QOajKGL/9j/NiwmKUUMj2zdL4eO1X2Ya/gzlPE1FoNiD9qglDdhrLxm+WSLzOd9tNDH2MUIoIL6F9f/CYyii2/BoidrvFPyyA4c321aU0lV2zEiu8qtMRvfq4d28hZVxMYx99LVKJYkQd3sFwS76+YdgRdsUFSAHRLSjOCWaPviG49GAyteGcNSOLSkW2Dv9KplH+eFbCvj+Ux67O37k8G24mpkz/DtbOwyiMOuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=biUarJs1zf99BNH9PXUbl8ybTPUfglz+VIUDFNyXZSo=;
 b=YzoZCOK7VDyODCqk6PXjZEHl8pjdMl/RzeLrEXr2rhfEQB/s0vxxYJyncW0dmzQvRBJDrvooGQaMm/GZCLSKC9NNAva36Y/JC6Lh8YDG7rlgn2b4nhjDtzlIqO5rlge90zUHeVZv4FpYt2OVC7cj96E4W3QGbkBe73x7FFqIVH3PWwZfGsFL9C6MD216de7aErxAH5As9Pl8ukeGyDv0rnm/hyhNx/NNc2K7YxrgjOwKW5vrKBuu6B3pVMSzYNyBz6LTd7dOHFzE3uDGnSTiFvEDGV6kpupGn9FMwWvdX/dy0GOLhdye0jX+edaEsfWlrCslG8F1x2HCwH34ltCOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB5940.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 21:09:32 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 21:09:32 +0000
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
Subject: [PATCH v7 4/4] perf sched latency: Add histogram and time interval options
Date: Sun,  2 Aug 2026 17:09:14 -0400
Message-ID: <20260802210914.199941-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802210914.199941-1-atomlin@atomlin.com>
References: <20260802210914.199941-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: e02bbed8-e831-4bdf-997f-08def0da5949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|56012099006|10067099003|6133799003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	1hTTnEAE9nsiPERRonmPlbgV6yiKUOJzcgMLBRTVR6IUtfRnnSzdx7syzMUSsTUSkvZ6qu3eeEXavr0i4irgPsp9pot+F0It9hmjUbP5INY1d1wD35rYVHvvy5Y5efhQRXwroYtk05GtSAzXEGknQBshAppFuuufvEUAGlVTP4FOqcw8BTpvI8+Dg2Ka2osj9XRNJzonD10aw4aIXmN5UJXyzvE8/bA8wSrdJX01HxK7LnVEtvBcVceW03ufzoFcSh9kvdMecb9Brt+amaCzMX3urtFcVsgAy2+yPJmlrnzmfy7B6WRc8H85KQkoOu683HfWCj+oCFg8GI+va5qIET6EIsW3k/F7kby0WKWNBTqvQ+znoZlwLC0PBhMmpXcsc3NynR9lU+qns9EcE/wTYZ+hLGLMNApJaDz4KaglGoEBVMR0dBEK6rvJ5LTboX+SGbmn7cAYywOYN8mmq+RNfEhph9/pJl2CO3RlxLRe0WpacOCUVi7nPcLTOnMzyMfWiFd1kjFz6+txeAMr2lNucLoeR0syp0ylvdEYtuaiUG7wf7qMooKgIRQosOT0dCxCHXMQDGS3YsjVxU1mHpkV8f2M+BD2Y0lONeVOJPviQvcTJa+9FFMgoOW04oumGzpmXYic2vr1ZE2FDgLDX+n2o5tPdgU8ME0GxnfxZhWnioM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(56012099006)(10067099003)(6133799003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDdZN3YyTU9nditWbDJMa1lnZUxIMnNaL3k0WEMvcjJ5T1NiOTJmOGtGVWtw?=
 =?utf-8?B?Tm9ZQXFCNUcvU0VhRFJMUysxc0kzek1kSldCSEZSNG9WZzU0RGZoRldBeUJl?=
 =?utf-8?B?RnRlejcrOFJpZ3FQMnJycHhxbTFXSmRweE92azJaNTNwNWtlWjEvK2F2Lzdo?=
 =?utf-8?B?K3llL1JnemY2ZkxYL2RIa3RmV2U3UDZOWDhONC9tczdXMmk5RWNnSUFNdGlZ?=
 =?utf-8?B?Z3BwdGdva3hrN08rRVh6TEt0V3QrT1pBRGZ5UjhFS0c5a0haQ0R3N2J2NXZ5?=
 =?utf-8?B?NFFYVlQ3R2dVOVorbGh5c2poRXNlS2NnYXdGaXc5azNXRXBBeG92VjFubmUy?=
 =?utf-8?B?RjlnQ0pVeUFyazllNXpFQy9JMUFPOVRrWFpTc1hPanBsbGtyRUtTdXN5RERm?=
 =?utf-8?B?VllUbmlxUmZIRXZTcjVDK1VjcVRCQU04ZnNTOTRuYW45aG01MGwwb1RrekxP?=
 =?utf-8?B?N1lBVUNodjZGbkVLMVZFNU9pcUowUjJ4dEs5UnlKZE5KWFZHZE1YMlJQQnN4?=
 =?utf-8?B?MUw0UEZsT2pLcGY2bG05SjVrOG5QdHlid0VVdkc1Yzd3ejVKNXBSK0ZhRG1F?=
 =?utf-8?B?Z3V5Tkt2NDZIY3Z4aGVLMG1lc1ZUZHkvMm05aUVsLzB5Z1JFeUFDWlVjL2l1?=
 =?utf-8?B?REFXOVhvekVSK3VCcVZhclJDZGpXN3JYdzloaEpoV0ZaM216cllKOUFLa3RJ?=
 =?utf-8?B?c0pCTVlsOGhvbVBxaUdaUVZhMXZvNW8xVFJDeFVyNW1yYnNPckxubGJjYmpK?=
 =?utf-8?B?cjdVeG9hTVRGMWhPaTgrVGpvbnpRcmtwa243UUJwMFlsaTdjelRhckQyS0g3?=
 =?utf-8?B?VisxcEg4bzJkSGNrdUFPTXI0d2JtZHgzbVU5RCtvS2lna0lpb2EyMmg1RkRE?=
 =?utf-8?B?aUdSWW1Oc1d4aklFNEVxaWJXazM2ZGs4emxhZ1NiaWJPNHRiNkVTbEhwUk4w?=
 =?utf-8?B?WXdIdmhRTXpZRGJnZWorRHh0MHB1R1gzelEvVU1QYnFDY0d1S2t5RVlpRmdC?=
 =?utf-8?B?NXdxZHdhS1ZYUS8vSW1GNW52ODM2RktaT0FkTWNZVldvdHpVTEtaZWRsaUNp?=
 =?utf-8?B?SUQ5WkNyTmFtRkhTcnFFb0ZjcTJ4ZDBJaHRVRVdnaG1wWklOUDJGV25OQXMz?=
 =?utf-8?B?aTFNWGtPZ2tJYmVLMXpFSi9PMlAzS3RiZHNDeVRacVpyUkRXUGpqVGtqd1Vn?=
 =?utf-8?B?V2dFZUJwc2tZMVJTVEgyZDd1QXB4elljMnZFM0svQ0xQSFBYaDlTTy85YkxX?=
 =?utf-8?B?dVQ5dHowT0s3VDRoV1JSUldhdEFNY2w1ZkpvcnFaRUdmWnZLc3pVMVZFc2pY?=
 =?utf-8?B?T0IwUmE0M3d2WDVEbFFFcHdCVUVjSHdiYTZkRUl3MnNsY0laNlduY2dvbjRZ?=
 =?utf-8?B?REpVWmxEQUZtb0Z0RGVXWjBwUlhyMTdJTmNuYkNsd2FmVE9qUmMyT25MVGM5?=
 =?utf-8?B?b0xXTmUwa2VsUHBYOHpiZ2RQUXVNZHRxdk92bDhFQ1lxNmV1RzE5NXQ2Sm9x?=
 =?utf-8?B?SE1qeDY1WjRLenZncWJEQVQ5TXhoTkRia0V5OHNZS3RzVTFuM2hsbWJqditN?=
 =?utf-8?B?bCtMcGlBZUQrYU5TaU5ESFE3dSs2c3pzUENlTm1SQzJtZWE2M1dPTFUvZnps?=
 =?utf-8?B?VGFTR1JET0lYMnlRa3NZRitRa0NydlhKaG1kOW5NRklvbjA4WDNEZXVpOWpy?=
 =?utf-8?B?dEUxQ09iR1FlbHpRaGthVzZ1STVodDZPSUhyZWVrajdkM2NyWGxPc1FYd3VW?=
 =?utf-8?B?OGtlTndXdEZZVUZTOEYzR1ZKdDRKOTdBOU0ya1l4cUsvaG5XWTNDOEo2ZlF1?=
 =?utf-8?B?clJGRDZUck9vUndTSDdBZUJ0ZVZOUUZuOWZ1cG1xRUxqZmJYTmMxMWdUeXMx?=
 =?utf-8?B?NithSUN0T2Y2Z0FqMjVhOW9NUXhkSHBwbDZDd0RsQWxpNXhOSUhsaVJkcFJU?=
 =?utf-8?B?NEZnVHpqVE9NVUFUdzJNQzdZdzZlUk1haTVQYy8yNytvSWVodzVVZU5WMHQw?=
 =?utf-8?B?VWRML3QwU0VUVjJtanBUTEUyTG9jZnM0dW45ZkttT0RUZWp5NEV1RFBUYkxT?=
 =?utf-8?B?UGZxWFUzWkZIUTFBT2hsa2d3VnVHUWJqck1OTU91L1lPNlBtdy9pQ0RmaUUx?=
 =?utf-8?B?VDI2M2VTVVl1d09PR1orS0k4cVk5TGRONjdFQWFURzd0Z2dYUEhiZ1lycFIy?=
 =?utf-8?B?QTkzc2ZFaWl4bTRwaGU3dnc0Y1RFcUVweEY5OTdmVGdQQUVoUmJreUpVSVRP?=
 =?utf-8?B?bFNDeWttRm9acHVpUXJySTUxaVNEWmU3bnppZHB1YS9wMkMwd0dKMTdTcWU4?=
 =?utf-8?B?Z0h2UEtpY1lZT1JOQzlCNFo2WldEbXptRVRLeE4weE5GQkp1WTlsUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02bbed8-e831-4bdf-997f-08def0da5949
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 21:09:32.5883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vakqq0/DIXTw3cZ2KhXlmlI56e/H8ALoQTqWyusQNMwJiUMgumxjeK5cknnwcEOwsETwKDdDWJbSwI6iYmQ7Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB5940

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
index f86255ff107b..d246402b8f8a 100644
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
@@ -3591,6 +3743,8 @@ static void __merge_work_atoms(struct rb_root_cached *root, struct work_atoms *d
 				this->max_lat_start = data->max_lat_start;
 				this->max_lat_end = data->max_lat_end;
 			}
+			for (int i = 0; i < NUM_LAT_BUCKETS; i++)
+				this->hist[i] += data->hist[i];
 			free_work_atoms(data);
 			return;
 		}
@@ -3650,6 +3804,24 @@ static int perf_sched__lat(struct perf_sched *sched)
 
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
 
@@ -3659,6 +3831,21 @@ static int perf_sched__lat(struct perf_sched *sched)
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
 	printf("\n ------------------------------------------------------------------------------------------------------------------------------------------\n");
 	printf("  Task                    |    Runtime     |  Count   |    Avg delay    |    Max delay    |      Max delay start  |     Max delay end     |\n");
 	printf(" ------------------------------------------------------------------------------------------------------------------------------------------\n");
@@ -3683,8 +3870,13 @@ static int perf_sched__lat(struct perf_sched *sched)
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
 
@@ -5101,6 +5293,12 @@ int cmd_sched(int argc, const char **argv)
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

