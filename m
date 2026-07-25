Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022135.outbound.protection.outlook.com [52.101.96.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EBD3F4DD9;
	Sat, 25 Jul 2026 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785000840; cv=fail; b=lY2C9xnCLaSFRyxsp8HPOCJPsiEGY1UUbH0orKik+bP0pwGoEM89+RFzeR7mfjZY1bQOd6OI26bXpcfW0I6B4HHcGS/s5teDr3ZxhCQFU7o+k22U5NHHg44LZr4gTpCNTdEIF8RIeuVx+kw5ajOd8jMT1UAdKfvq3OUWEWIZeqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785000840; c=relaxed/simple;
	bh=Kncr43d7CzpYpJeDw2NunOAhuU6aoUaG8yvK6R33HFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NgM5Ppkgl/vW2nRTIq8pYz+rebty5PxjfLF3/blCcpnr7HRn080dPZeoIrdQUMpze/zc9iCdg16+tw7Gg5CXKJE4U8jXoVyNX1qmF4Wt4uKpXgDUZGTokPicyekscKxQ9bwUpB6XGUOH8bqQC3vGD279WJ5Y27Gtw1z09IkRV/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gr65GP8p8gguaMPyCTc6AhJYWuEVb5JUWDTz0fB3AdvuLtds1XTVlie1uDRG82rQMpnAVIKFmM7Bmf8ncyXx7NT6BiJngmiVvbxnHAnqy1+XJaKFB6WlFjwEwhS7fn1Pj79JTxN5kww2uYjxhch+B33pXhfQ2McDtiYCTppJJLAenqQGBUa7fqZPOVyyXuCUXSP1f0oYGKxa88ANILuXqbBb5vaU07HmPM52PDrpBhkmnoCLcQHxOh637XLJcHzccqsFw22ZJobk46tdYMf1za/Ge1OfzO8JbPXmXMTIB3qd2L6m0pnG9wtBs02BKt51v7h0m3xXPwckR7F4Tfqlqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=SEqWnb1MrGPB+PntItNEzUzdm6gqWPAYOuU0vBuCct4=;
 b=W3adsIi7dv0xFznIhMl5pQf1VRX+qc9WNR/CqMUtzsYpyBelSwUSrqfTQpqRzj5LAGUiZO+5rjLFeUXpjydeGIafGRJWh8KLDIQZLvuPsGA6jSdXRwFc262Q3fHfAebbA3nJthfLdJr53fwql8+BEGOmPyq1Ya/gd9Alv08g3TYvNP1R0+s4sL0K7Ymp1BLDjBkDOlRcuB1QyYvdnqwjS1k5pEWyZd/R9doJ8IRq035lmBCGFhjFgNvMMCXEflc0hZ20Zp9xpbXSIsZVX7EgXvWmzX8wbQSORhlQZxKlobGnKTUZXLuNfpmyVeJLFYC+XQ8/K2IPlOxk+uObc8Y9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6915.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 17:33:57 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 17:33:57 +0000
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
Subject: [PATCH v2 3/3] perf sched latency: Add histogram and time interval options
Date: Sat, 25 Jul 2026 13:33:41 -0400
Message-ID: <20260725173341.679782-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260725173341.679782-1-atomlin@atomlin.com>
References: <20260725173341.679782-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0858.namprd03.prod.outlook.com
 (2603:10b6:408:13d::23) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 6102663a-b5ec-437d-3c43-08deea72e7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|6133799003|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	IVENKEDqjSw/UscLqpKTZfVlf/PN7SKEJdolqcB/8x0XT1/X15SvGPWSn+zQy4RydJ3iUroFt5HoxQKpWF2JQSQuvWVyTLMbUf5j6vjr456WUOjDFYrcKu/wawm9BZVpbr9ksayjvW4iNCvNKTaZ4YKF3sMoagIA+1qWWQrjI3ZgKXlWwR8w/CPOIeoVp5k46t/p0RshaYgWW88sG+ooR8pV+195fgbgDhkVjhif0GgyaG3ASKP/se8+v8fsDlxivwaAkdktKgh0J+ZPzSu+2Q7d9iZ63q59Gfjam+Gkjy7f4w3/R79A9hqb3kc0AC5Ca07zZ3lvZC5Y++kFwiRjtjT/7FNwzuzwmpPu/kjor/u2FR4M1hZkXqs4eLONj80ipfZCdRW/HNx2n/URJoTlx62uq9qvmX2bwnhWz/3UCaN5VS/HD2KgVIoFsQ2VZ1BIxv/VmPPHbkmhooEnfqsQsDGmsCFgfSYGtMlMAdCD53od9RqtM1DT9eefdl7kGgxpN4ju0w6npFGinmrJCAfgmowUhM8t1dPms4KPE2r2TKNA9qrAanJbDJB8N2skFdtOyKhC6kv41pM4dfMNKgWJgQc51mCHsFm2sr3SQurd0KvsU3uLuYBkUXS/9tAvkvrMbYPhsHHespnVuslDQegbcneoe90GJedwSQADxAQHdF0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWhNNGRtRlJ0NDBNYlRSWWJPL051QnI5VCtrZ255OUgzQ3BLVHNPZXF6WkQw?=
 =?utf-8?B?aGFhUW90MFVMaUdvb0xlblltWmgza1AxTkdGa0RBTk5hSTdOV1JacmgrZUZp?=
 =?utf-8?B?eXpvSVRvV21YK1JQeng2c0xOS09VNzdVeWFwOHU4bWY5VFZ0c21VcW5OMW02?=
 =?utf-8?B?NzRwd2g4K2tDMFp2MEI0RG1FZm44aWJkNVpmdmZFWlV4TzFvOXlKUkt4M1NP?=
 =?utf-8?B?aVlJcksvdHZBdHl0LzJGdm1YVDVsUG0rYVFLeUNZem1nY3phSzU3MTVrUllY?=
 =?utf-8?B?cVJXVTBPMENRNDVZUTJnc2l6Ky80M0xOeFk2cEwrSWRxSHlSUG9XeXRXNktk?=
 =?utf-8?B?eVl5LzdMeEVIVm92eXY4eU8yb0RyQU1mRHJwb3VzTFU2UEhnUnJJRy9nZHRZ?=
 =?utf-8?B?SzZlWnhvZElwVUNFU3daTkVwNWRHZ2haSEhmbG5ValFTSGUreFV2WEhzS1ZJ?=
 =?utf-8?B?eFJqcW1mOW1hSFVLdmU0N2ZTK2dra3RneXhTdHlldnRaM3pha3RVL3FSRlRX?=
 =?utf-8?B?d2c3dzM2Y0pHR3lBSmpGWmFEK3gwenp0Z0tZV1dNY0g2YU9EQzV0N2xaTEJ2?=
 =?utf-8?B?UjkxcnFadTN0cW83eEs3ZFM2MFdNRDc4Z0xBd3UrMDQweWUzelVzZnFyT05D?=
 =?utf-8?B?YjhwdGFUMVJaQWRmN3VoeXBLaUdKMlJvUUM3aVpLWGtiUUE1VkJ1QzF6SEVL?=
 =?utf-8?B?UklGMFNHUTE4dktLcUQveFI1MUl3Q0RKUzUyVGNMUWg2cktSRUpGM2lSdzN4?=
 =?utf-8?B?UTl0eFRUd0J1aTNLRHhNMmlBZHhYWXluNkdMa0JGbmZrbWVkZDMvVlJMeExw?=
 =?utf-8?B?ZWN4TTFnT3A2SHVhY3V6ajFQMzBZcEpjN0FLajd1UGt3NU5jMVRMTitEeHNQ?=
 =?utf-8?B?NjNJdUlqTFZodTVvKzZRaEk0YXd0blM1eVNCa0NuRnFUVSs5K09ha2xON0dT?=
 =?utf-8?B?Q2lHWVJhbW51UnRIWnBHK3JyKzAvZm5rVVZtVXovVVdwVnhrSTVOc2w2RU9Y?=
 =?utf-8?B?TFRUeXJ3b2lRZVZSQzFBcFRDK0dMenVIVGFJeldBOHdBaUI2cTBxc2RBU3Z4?=
 =?utf-8?B?REl4ME10N1IvenhWaERRN3IydDdmMGRvenptR1dxZ0N0K0htbEZtQzY2U1p4?=
 =?utf-8?B?N2xHbUs0UzE4eVQwalhCcmdqN1EySENXbVBxUU44eE8vZlQrV2s4bXRiTjdW?=
 =?utf-8?B?RFdjNmlFRmxwZnA3K3hFLzBiUzdyZVFsQnJHRlYzSStBaTZqcjUvdVZLeFBl?=
 =?utf-8?B?bS9UQXJ6UHZrSHJaZEcwNU1waEZEZ2t2NkFCeGVRNHRqa2cxdnIzcklqYkll?=
 =?utf-8?B?WUpmNjVzOXhxYXFtUXcyS1QwQ3AwckYra3pHdTZNUUNWZi94VUdKNVQ4YVZl?=
 =?utf-8?B?ZnJSbTlTZTR0RkJ3U0lueUFaL3hGYmVkYlduaXQ5Z3l1OHJNc1dsazB2RzIy?=
 =?utf-8?B?bXUrZXdzc3RrNmNEN0hPS29TTVZXdnhUdlJKR1J5WDJRYzh4VytSTk1qc0NX?=
 =?utf-8?B?S0ZBbDF0THRvVkpxV2NjWnR0Z3lWNEUvRVdOb1M5V0o3R21aRlB3Nmo3d3BT?=
 =?utf-8?B?aVhwaUhOWWJxT1U0Z0FMV3lwczRmY2pVdFlIZ2NNV3ltd0FiSVdic3lJNmxO?=
 =?utf-8?B?VEJnNHZhTzByaVM2aHlvbW5MR1JuNUZKOTFtc3VIeG1KNktlaytRZ0VQeURH?=
 =?utf-8?B?Y2RzQytOMnVSSStXaGJuaGJtRWpxVk1LK2YwaTVXdHhDNVUybFJ1bUVqR1pO?=
 =?utf-8?B?Q1dhaklFM0QxWS9PWi9XTVJoc2NzVlUwY0VJL01Ud0tSdW1td3FlL29mbkJK?=
 =?utf-8?B?alN3S1g4aW03M0tOQnh5aUZBOFFYaDMwYVBtWEQrN0ZnK2hSV1NEOGxjNWk4?=
 =?utf-8?B?a3FleXROVVNySm9FcldveUIvSTJJUmxEcytZdGE3c1V0NUcxazJMWWcxaHBH?=
 =?utf-8?B?S0d1QTdIZUtYYS9uQWR3Vk05MEZDbk5SZGp2bHVZZmFtYm5ZWmFENUc3R3l2?=
 =?utf-8?B?aGVUVndQbWRSbFZucXFROWdwVndWTjdHeElTclFvOFk3THppdVVpZGlvRkdQ?=
 =?utf-8?B?MXJEa3N6QkRaVVdQdURZU2dENVpHb0tVK0lZOVM4d0I1Ym5ZellpQXl2YnpM?=
 =?utf-8?B?NWJydDkzVkZqbzlqYW1MUmZ6M0RMMVpwTEsxc3BOOWg2WFRQaHJqQ2JXZzYx?=
 =?utf-8?B?anZLcFpQczk4QVVzTzBPS0dnY2JiQWd4djNzcmRxNk9OUzZiTUlTc2ZPV21p?=
 =?utf-8?B?bks1WW5TVVZEK0h4NFB0TWxNUUxHL2RUZE9XNzVIcktNT3kvSUxkVERVNkg1?=
 =?utf-8?B?RVRZQjQvYWdieGd5SUY2Mmhzem9oeTRSa3FldE4xaU1vK09pc2pJZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6102663a-b5ec-437d-3c43-08deea72e7bf
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 17:33:57.0033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yup2rv7zAntatIhr73YNtgy0Rcuf4n2/ETcNrt+QQqHiRPB75atugyJgmbdXjifw3AHN091lZxIwXhQ6MWF0TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6915

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
 tools/perf/builtin-sched.c              | 179 +++++++++++++++++++++++-
 2 files changed, 182 insertions(+), 3 deletions(-)

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
index 00ff5abb08b5..e3051e6f7b1a 100644
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
@@ -1169,6 +1291,10 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
 		atoms->max_lat_end = timestamp;
 	}
 	atoms->nb_atoms++;
+
+	b = latency_bucket(sched, delta);
+	atoms->hist[b]++;
+	sched->global_hist[b]++;
 }
 
 static void free_work_atoms(struct work_atoms *atoms)
@@ -1199,6 +1325,9 @@ static int latency_switch_event(struct perf_sched *sched,
 	int cpu = sample->cpu, err = -1;
 	s64 delta;
 
+	if (perf_time__skip_sample(&sched->ptime, sample->time))
+		return 0;
+
 	/* perf.data is untrusted input — CPU may be absent or corrupted */
 	if (cpu >= MAX_CPUS || cpu < 0) {
 		pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound sample CPU %d, skipping sample\n",
@@ -1252,7 +1381,7 @@ static int latency_switch_event(struct perf_sched *sched,
 		if (add_sched_out_event(in_events, 'R', timestamp))
 			goto out_put;
 	}
-	add_sched_in_event(in_events, timestamp);
+	add_sched_in_event(sched, in_events, timestamp);
 	err = 0;
 out_put:
 	thread__put(sched_out);
@@ -1266,11 +1395,15 @@ static int latency_runtime_event(struct perf_sched *sched,
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
 
@@ -1313,6 +1446,9 @@ static int latency_wakeup_event(struct perf_sched *sched,
 	u64 timestamp = sample->time;
 	int err = -1;
 
+	if (perf_time__skip_sample(&sched->ptime, sample->time))
+		return 0;
+
 	wakee = machine__findnew_thread(machine, -1, pid);
 	if (wakee == NULL)
 		return -1;
@@ -1373,6 +1509,9 @@ static int latency_migrate_task_event(struct perf_sched *sched,
 	struct thread *migrant;
 	int err = -1;
 
+	if (perf_time__skip_sample(&sched->ptime, sample->time))
+		return 0;
+
 	/*
 	 * Only need to worry about migration when profiling one CPU.
 	 */
@@ -1454,6 +1593,10 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
 	       work_list->nb_atoms, avg_lat, max_lat,
 	       max_lat_start, max_lat_end);
 
+	if (sched->show_histogram && verbose > 0)
+		print_latency_histogram(sched, work_list->hist,
+					work_list->nb_atoms,
+					"Task Latency Histogram");
 }
 
 static int pid_cmp(struct work_atoms *l, struct work_atoms *r)
@@ -3560,6 +3703,8 @@ static void __merge_work_atoms(struct rb_root_cached *root, struct work_atoms *d
 				this->max_lat_start = data->max_lat_start;
 				this->max_lat_end = data->max_lat_end;
 			}
+			for (int i = 0; i < NUM_LAT_BUCKETS; i++)
+				this->hist[i] += data->hist[i];
 			free_work_atoms(data);
 			return;
 		}
@@ -3619,6 +3764,24 @@ static int perf_sched__lat(struct perf_sched *sched)
 
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
 
@@ -3652,6 +3815,10 @@ static int perf_sched__lat(struct perf_sched *sched)
 	print_bad_events(sched);
 	printf("\n");
 
+	if (sched->show_histogram)
+		print_latency_histogram(sched, sched->global_hist, sched->all_count,
+					"CPU Wait Latency Distribution Histogram (between snapshots)");
+
 	rc = 0;
 
 	while ((next = rb_first_cached(&sched->sorted_atom_root))) {
@@ -5070,6 +5237,12 @@ int cmd_sched(int argc, const char **argv)
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

