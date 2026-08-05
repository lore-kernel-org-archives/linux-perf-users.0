Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022096.outbound.protection.outlook.com [52.101.101.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182BF481238;
	Wed,  5 Aug 2026 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964108; cv=fail; b=PXvW4dBGWB59IYW133gCQ2OdZ7qGPNpw2LjNeitO4s1MghYpgClTE2BaofZ/RW3ewjulBSRwohH0L9XFpZ8JM9PWtva5hYaDgTtX+Q41uOdLhdJxTQKYG8aXI3CPez6WAuhm5PJHhPcRNMCu30inP/uxr+o16RE6cTBmZUlM39I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964108; c=relaxed/simple;
	bh=0lb5T3CXiuMHVNUBFeTcgXStGI16kd/NGOaLssisJE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V1OBAhIQeDHdHI3Y3WuXvS55RcxMB6yNVUgcaEyeDhG0mY4LsX+TN5DOhnQk2n8WMihMv18VKsQG06XEtY1tEixZIKyAff1ctmraUKaBut/vvr6s8UYEUZ9WLTOIKHX2AdcyxRCQgtZDyLFQ5tijXpeJl3SplZbhy4Xw34bL64o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oF3udPETSa7xnYcaMSX7pGv+WwLXUHVset+O1d4vwT+OEeEUED9Q7ItUhrtiWZakw1sWEHLAC9TNZWnc6NIjTPtT6B2STaZnmex7+A85kc3IIHzg4te2+6m5A+K/XADziEZf7hAE4Gg08k/GR/MHbrztjFcmxAj4zs755zuAypBlb2YqlKuACSCcTXzWHb0HU03lQTGJj1t4tQdcxPPIC2tiKnLI9vp+sEMzESSvnbmOQmJtvaJswHTN7DSjFEh5N8Q9t9VTunk7IfkMrCp21VyVZFAlC+hkdSlyPjYiLdYa/deUmAET8AQPAAs/T1oRpDmCLs2Ki0rmSQZk5fhrjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=zlY5A7wujeIDmok3MsitLENPnUK8m85osXw05uNl5OA=;
 b=yjxjJ58pXR6hMnNznstzybcs9+IwEOBEKsFKuDJGd9Vmgni32BDQYXJJVpr1GyQM/U8DjYd6lSNen1i54u2q/aZZ96XQYmgIJlUaCHWcBgiNAHEuavc9GD4W+7VB/9PkWGGx9HUUaPHItbAMwllVWVpBtPIVAVGlN0czFtQsf2xMsYg8rVC5O9Or4hV68RZT3UNMuMk2YtpsWBcwgb0xRtqWoP/Gd3SYCqd4jn9pXVx5UhTU0/k5qhql671z1GA/Y024hZwgtvcffoPyWFl0jw4gDiCSvNMemPSUZWNeLZAwDBb/QzyH0KAAEdfTF1cwsZrWLO2qUnv+d3F//705kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8157.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:437::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 21:08:11 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 21:08:11 +0000
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
Subject: [PATCH v8 4/4] perf sched latency: Add histogram and time interval options
Date: Wed,  5 Aug 2026 17:07:51 -0400
Message-ID: <20260805210751.287746-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805210751.287746-1-atomlin@atomlin.com>
References: <20260805210751.287746-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 1beb77d9-0395-4286-1aa4-08def335a7e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|56012099006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6ayCJiS3Gyxm1SF3KuoXcsq0W51kdMZ0XcLp7m8VgRzuIRr9Ji/+rnPf2bLPNfoH+svvoMUZJwU6Kj6AINEkv55C5AHUrsneDQ3CjMu5DUSQicBEavxLKTl6TtuJTXRGsFHgjDqfUAJn7hV65sXetspQ3JIoHU9/b888xwcjGbjoxu+/W8tnDRcl8+LUFNo3mPbk8YgRu0TxcICj4B8r3oa51DgtnXJjeOUKytfjLu4gpDhXVDua5hJ1fmTOx12EBy0w3NdVNEb0IzMjjbyNotUpnph1p5QnpiyWpnemGJ44k6oUaTOZQyG8+JS2E+Js4rzqoukikN5yvIwpjONLQ7VXh0x2tWxkCiJy+CLDfUZIQt74LK24aTzofIDr8pwDHNTRaby75S8y8Q2h7coATTlk2tmKGvdz7HkzvZ1oI/kOy2qIl2SKhb1qfHnleJKSyzHb6ukXv1Vh3UJzwO9A+woMr4YKVN7B+/MMoNdtYP9T2riZ9dQiYa6w3MdxohXJeXC7jO264D+bShEX7TAb+Jn5HiBGOLWO0wM0FwtYEr2LoKtO2IVhCwW3/huSiVywNsw4hWB80yZvTahk33Nr8ECwoa4p8SxkfIpIiXgxXaokTXm6BZAVyi/PGOU/d1eE5NN6sbZ3HhPhzGANegy0eKJqefXs/shssm+NvNHt3vg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXpzMk51WnRYQ1RiY0h3MDdCd0RTZWsrbnBoa08yL2tULzlaK3VKU3o4Rmt5?=
 =?utf-8?B?K3FJOW91b2dCaDJpS1hiZVhpNTUzbzUrQ0NMS3ZBOWNjZU4wN1V5MXhZRWhG?=
 =?utf-8?B?VC93OU50b2NYSkRyK3p2VW1Yd244cEVJOGcxNmFHWlNoQVVZRlBiaUpvT3p2?=
 =?utf-8?B?cnpjWUkvVHZONnJneWdvdFQ2b0NvY0dzdC8vNnRkUGoydlpIQmlEZlhib2hN?=
 =?utf-8?B?UWRabTU3WGNoazVYbmNqYmJPcTNmTTBUVTlKMEJ0cVE0UWIxbXJUT2E0c1l5?=
 =?utf-8?B?MG5LNVZyaHJFMVRVZ2JQUGxGZXhKTEgrcVVsemQvU1ZyZHBlcWtIcmNCL2NX?=
 =?utf-8?B?L0pqVXJoLzRYVVNZRWFwVTZnUFVsOG1QamNKWGo2NWpQVndzbitmVVJTOHlt?=
 =?utf-8?B?eU9TTXdvM25jbmt3MVR4QkM4d2xVU1VJS3ViVWduMGtnbXEwTC81ZGdWbkFa?=
 =?utf-8?B?eGw3azJlOXdCaG8yYUN0OFpnT3VmMWlEdkN5eG1DbENyakV1cWR4U1NteDFD?=
 =?utf-8?B?OWJsZFlodUErR3BmUUNSM3ZUcWRNQ1VDd3NSZjhxaXRUQ2Z6dG9JOUYxOEN6?=
 =?utf-8?B?MWdKb2tTb20wTjdPN0Z0OGg1SExsc0daRTVCa3hDc3ltNmwyaWRVUzVZQkhL?=
 =?utf-8?B?RjhOMVo2cjk5TWl6ZW1tZnl6YkJybXk5YXpIV25kVTlVc0ZnS2hFSU90L3A2?=
 =?utf-8?B?bFNaaTQ0enNacng0QS92Wk9BQWpSZ2gvWjFFU09NbFpHVTFzNFB1UkFFRWhw?=
 =?utf-8?B?RWM1NCs4OTNXdFdtZ205SVlJV1VtbG1uVUY5YkxZSmtwN1Rycm5rbE54WEF5?=
 =?utf-8?B?dlVvakY4YXVHWHgwWnQwTytyZkN3aEZZZnZLMXo1SE1wNGt2UkZsMEdlekpC?=
 =?utf-8?B?UEpGbE1TcmJlUG9JV1V4RWxuSlZKSUFHdGRRc3Fub1pWdC9JODdYbzM1OVdv?=
 =?utf-8?B?cXFpb2lKdlNTOUNzYTMwS0JheFFBV2QvSTkxMTlhSGpnVHlwL2VsNGZRTmM1?=
 =?utf-8?B?Uk01WnYyR2d3QjhhUkN4Nm1wVnJ2QzhQSWRLbS9VRUg2WWxZSVVUOGxnSEhC?=
 =?utf-8?B?STA0QU5pN1o0Qm5Xa21uclpVd21ralhQQ0JIckZpMS8xdDN3eHB1WXhqclQz?=
 =?utf-8?B?UEJEOFpaVHJCZURnOHV3S1JUVHVhbGUzZlpiR1RJU1pHMXg3akI0MTh1Tk9P?=
 =?utf-8?B?ZmpWbmViNjVlMDJhSlhyb01pZ29ENmVCbEovb3UyNEZxcVJ0YkJqSHI3M3dW?=
 =?utf-8?B?TXNodm54Y1JPVERONjRkakxHenVuOVJKOEEzRHF6Vkk1aTQweldWMW8ya2l6?=
 =?utf-8?B?ci9MQ214dWQvWHNLSjNkaDFxVjFQM2tCc0p0VTVHQW9GcDA5VWRMMlNpTXRq?=
 =?utf-8?B?SXFSL1p1bHMvRitBbmxpQnVob05pQUtXNkQzdUZJY2xKVFVCd2FJQjRWUG11?=
 =?utf-8?B?TitmbFJKcG1XaWg5MnF2ZlJKaDh4bkFPdk1ZVFduaDNVTEcvSXR1R25SSEUx?=
 =?utf-8?B?RWdGUGZidTZVUS9RV01IUDh4VHpXTlJqR3ZLbi8yc3BKeVgxamxLajRlMmRQ?=
 =?utf-8?B?NWJRN0hZNTVXbjdteFVYU1V4RmNvWGt4YnFWL3BZcGMxY09lMjNaaG45Sytp?=
 =?utf-8?B?aUNlR1hOQXVnMVkzVFR1ZGNQV2ZXOGpoWGltaWp2VjB3K3NVcmwxOHFTdWVP?=
 =?utf-8?B?dkY5TUdyQnAxYTc1U1REM2ZuRmQ3ME1pdGhqQkovVHhqK3lwQ2VmUzVPa21n?=
 =?utf-8?B?MGxRbjBZY1VsMUlLUG1OU1FQa3pwYWtYaXVxTHhjZ1VxTnllTXUxUEUzNkli?=
 =?utf-8?B?dFZNRXBicnNHQTJqakRBdS85clRMSmQ3SmlzSmV2ZGVsa0RISTc1c2xSLzFX?=
 =?utf-8?B?OERoRjFPK2Y0ZE14TytnOUYzbWRMOTc5YWM4c3p3R1pGaXZNdVJQa0FNanBJ?=
 =?utf-8?B?SVo2VmNNdEgrTmxZSGhQZzBra3hlZUNmTEVaQktWbTg3MnhHTWlCcXNPdjVK?=
 =?utf-8?B?ZHVSTzM0ZmxhSlVIZ05PMTBsSDhIVjY1U2RoWWlaaTk3UzQ1U0pxdm5QUi94?=
 =?utf-8?B?OGRuS2JyMlBQV0tNaklDUjJsL2lyU092WjFMd0tvd2J4Z3daMktsOEJtMjZM?=
 =?utf-8?B?V2kwck1vanUvRytnUDU0VjRvcEZ2SEJBSHVqN2xqaURsTVVqaWNzUWFISHlS?=
 =?utf-8?B?eUdMbE5xVE1HUUhwQmpJMy8zdDZZUVB1TGVoaVZGZmRydjluZXlQSUhoU0hn?=
 =?utf-8?B?cXFjdUMyRmI5Rm94WmdMVnBaMnp6SUVuY3BKM1crOTlDSU9SZm9uNEJiSFFh?=
 =?utf-8?B?UW5ScUo4aUZNRWNROE1IekhKdFJFS3JBKzlUVlVVd1ZoOEpFTGgvdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1beb77d9-0395-4286-1aa4-08def335a7e7
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 21:08:10.9969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POT4BD/R5VlGn/JhXUoB0CZk5anE3cWXoTP33+PiW3s8944v+s2N5AQY/5Nf1Er77YK+6J9qtnzihfKtSXdqAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8157

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
 tools/perf/builtin-sched.c              | 210 +++++++++++++++++++++++-
 tools/perf/tests/shell/sched.sh         |  29 ++++
 3 files changed, 239 insertions(+), 6 deletions(-)

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
index 18282ab669e3..0b970d52485e 100644
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
+	if (thread__tid(atoms->thread) != 0)
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
 
@@ -1425,7 +1573,7 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
 	/*
 	 * Ignore idle threads:
 	 */
-	if (!strcmp(thread__comm_str(work_list->thread), "swapper"))
+	if (thread__tid(work_list->thread) == 0)
 		return;
 
 	sched->all_runtime += work_list->total_runtime;
@@ -1454,6 +1602,10 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
 	       work_list->nb_atoms, avg_lat, max_lat,
 	       max_lat_start, max_lat_end);
 
+	if (sched->show_histogram && verbose > 0)
+		print_latency_histogram(sched, work_list->hist,
+					work_list->nb_atoms,
+					"Task Latency Histogram");
 }
 
 static int pid_cmp(struct work_atoms *l, struct work_atoms *r)
@@ -3586,6 +3738,8 @@ static void __merge_work_atoms(struct rb_root_cached *root, struct work_atoms *d
 				this->max_lat_start = data->max_lat_start;
 				this->max_lat_end = data->max_lat_end;
 			}
+			for (int i = 0; i < NUM_LAT_BUCKETS; i++)
+				this->hist[i] += data->hist[i];
 			free_work_atoms(data);
 			return;
 		}
@@ -3645,6 +3799,24 @@ static int perf_sched__lat(struct perf_sched *sched)
 
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
 
@@ -3654,6 +3826,21 @@ static int perf_sched__lat(struct perf_sched *sched)
 	perf_sched__merge_lat(sched);
 	perf_sched__sort_lat(sched);
 
+	next = rb_first_cached(&sched->sorted_atom_root);
+	while (next) {
+		struct work_atoms *work_list = rb_entry(next, struct work_atoms, node);
+
+		if (work_list->nb_atoms && thread__tid(work_list->thread) != 0)
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
@@ -3678,8 +3865,13 @@ static int perf_sched__lat(struct perf_sched *sched)
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
 
@@ -5096,6 +5288,12 @@ int cmd_sched(int argc, const char **argv)
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
diff --git a/tools/perf/tests/shell/sched.sh b/tools/perf/tests/shell/sched.sh
index b9637069adb1..113df962a51c 100755
--- a/tools/perf/tests/shell/sched.sh
+++ b/tools/perf/tests/shell/sched.sh
@@ -76,6 +76,32 @@ test_sched_latency() {
   fi
 }
 
+test_sched_latency_histogram() {
+  echo "Sched latency histogram"
+
+  if ! perf sched latency -H -i "${perfdata}" | grep -q "Latency Distribution Histogram"
+  then
+    echo "Sched latency histogram [Failed missing log histogram]"
+    err=1
+  fi
+
+  if ! perf sched latency --histogram --hist-mode linear -i "${perfdata}" | grep -q "Latency Distribution Histogram"
+  then
+    echo "Sched latency histogram [Failed missing linear histogram]"
+    err=1
+  fi
+}
+
+test_sched_latency_time() {
+  echo "Sched latency time filter"
+
+  if ! perf sched latency --time 0, -i "${perfdata}" | grep -q perf-noploop
+  then
+    echo "Sched latency time filter [Failed missing output]"
+    err=1
+  fi
+}
+
 test_sched_script() {
   echo "Sched script"
 
@@ -108,9 +134,12 @@ test_sched_timehist() {
 
 test_sched_record
 test_sched_latency
+test_sched_latency_histogram
+test_sched_latency_time
 test_sched_script
 test_sched_map
 test_sched_timehist
 
 cleanup
 exit $err
+
-- 
2.55.0

