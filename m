Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021091.outbound.protection.outlook.com [52.101.95.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1823CDBD3;
	Sat,  1 Aug 2026 23:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785627630; cv=fail; b=DInJCg0673NuJHCDof54VfWOKlotthKBx3z7qnZ4DaFewp44RQUWkpAsIQNAxW2dmTVL4lXwWJMZpFRmlRZcQ0oYHU40nYQ8ar4CjgyUQFgtcW8iWNurkjzDzjpfSFC5NCrNQvkAXrPeJQDoWbJvBIFKgjgS9Nt9xdOApCdfTOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785627630; c=relaxed/simple;
	bh=mTOWRGJndG8O+shr0HRfqDuL452m8h2d/5+xMLNOoao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xwq+Gtyr+84kfp+R8PJIlyfU41rTLR8+NDk/aHF3IUuURRLdcs+loBTxKlzpxikqV1e3Oy6YeWrcwa8HVkuFGW5ymfH/ZML/lrHCHUW3KXOqVidR4+HZL1xNOHSdbsjyFblma0fA3EZ5nw8hrbfphuSWuvmCKSjpmjNHu59suyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLiXWS8neuZ9YvL4iWLuQJiIlAhJdfB4vzJEdxDNyFW37IpGoojV9nuATB0cPR1ki5dIOcf3CjvmDQn1C1Wk0tGdD0NEF6/zyB5/VlI4oKOxUJxipwYdpcy9814a7AvQLm1TxVu0a0wSh74atDCevErF9bNoCc+nCvynP3ke5YaLBFpLsPKYa+I7FGhZjx1epfXL2URsxWGeKriC/FbhjkYiCvlIV7SkQ+F9xrZeljXLkPCDJ+74cTrm36o6LeWgG451JM/7IOqVYw3vNN8wgrQ8HdPvNdaA/grXuK6jlThjO3GZz6SOlx/uSiyhhAepd+euhD30ql5vH88SJTf41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=6vyD+AO4fVcla+YmKfB+LBydIsJufnaze2v7EJcgx4Y=;
 b=IWiRKiJpYxA/C6IPpwgjViUUubIzOJTsimhCtwK7abm+8lI2TNep87zMKnNHZTaxNlWbwmO+r7Ylk2vI/STr1ybfGZcRgp1Sb4jetsyssoH0Xvsg/1JraM52VrnxQ60+mk6A6tRCzBkZ9DWukHdLBqfJXcBby3fCGbe0Magxgo9w5I4ZIg5iaT7CNHLDqYsB0A0y1uoelvwbslru0Qbk7wRjtnk9XXgj2GwiAZQzZGD9/8AMEV5K6ucIcbBuXrzjIWrwWMNQG2tyKa20zL4UHnksyaT2eT/mWacx/d/umFDBoofIDDAqAW1NkmLOCT0y9jbFhlj6zcKUvc3Bvt9C6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOBP123MB8812.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:480::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sat, 1 Aug
 2026 23:40:25 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.016; Sat, 1 Aug 2026
 23:40:25 +0000
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
Subject: [PATCH v6 4/4] perf sched latency: Add histogram and time interval options
Date: Sat,  1 Aug 2026 19:40:08 -0400
Message-ID: <20260801234008.176724-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801234008.176724-1-atomlin@atomlin.com>
References: <20260801234008.176724-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::8) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOBP123MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d58c328-5533-45f1-fd93-08def02642df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|3023799007|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	zhBAAWSW0Mvh04v8nrRxrvYNvAlSfE3iVnqMARMcw2JDoFEIx4jDGCOiXzvd0n+dP4OE00wow+1DA86qnvkhNtw1FEwww2pLn7rMaJ3d14bkd6rEgGPqiDBhYDBV2UI9P3txM9JkvO6inVOPUxHBFdU3Gpi1Kmgcke9vYiZvSPY2Wav1vy+4loSkqTquoX/qPnYir3k6gJPeqgzM9ZijrY1+KP75zmOqhFLCVtrJS5yhnW3M8ltd3fLbVtFsBnT+V6yzRiJY8D+d/aA8LL7oNme1sfxNK4K/sRVr6yAUSCLzZRtvx403x1Zky5WPCjX1VNtI2DBPDgC3pk8X6wfjK3wKs+WCoXYBtoyKHltvkVzGrqXRFl8QA5rZ3/BxeXgiB9tJ3y8qfeD5VXC3WTFnb1CWQTl7+c4BexXSt4keeArYSSYql5hcmBM0XQqz6xw4KaNHFkYu9EX2yGXa3UCXhNJ5WGoI5UA4r3onD/8CXUo8qLuCo6xYafn5OIh1wneLwMofHFr+AqV8+kOBGLkHJfQ/ASRCsjSU6uNSXUy7gXHvrhJGPm1HigbDoaIsrMGcgF/S1i6s8+y1tiK7B9+V5TNWVHpW2eLfQLpXNakcTn0qs5ZHiXFJWIu33Gfp7fAfn8YB5YBjPhmhxSqGA0mI+7FyGkYRwfPSP/iArUm8qc0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(3023799007)(6133799003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2czQjAwdzBhcjFwbUIxL2tHZFJ1TWpReitzbHplYWdlcUl2alFTTnR0Ykt1?=
 =?utf-8?B?R3JrZnB6ZXZNU3BvaTJkR2hHL1RkOEcwVW95dHF0Q1ZOVlZlN2hjZHk4Y21N?=
 =?utf-8?B?WGhYMGdUenhZSTdLOEQ2YjhDZjNMQml4NllMc05oQWlYYnRlSDFJcDFUOXA3?=
 =?utf-8?B?R1plZjc4d0JzL204ZzlGc1l0Wk1IQ0VPTUZ5aFVJNmMwZGRESzdOUFlLWDJp?=
 =?utf-8?B?U2hZQUNKUVZtNm9iblhkcVVJcWc3MnFXdm44ZnE4NFI1ZWFQMVgrS2l6dXpp?=
 =?utf-8?B?SGxXQjYxSFlLT0J2NVVucHNmWVJRMWZ3VFFEeXZ1aDl3UWcyU0pZQXdMOGFR?=
 =?utf-8?B?bUtPaWxlK3A1dXZyZmdPZHdCQWF0WnkweThtUnBNaktyZ3J2VHY5RHE0UW42?=
 =?utf-8?B?L0FUSjdtVmhDZ05oUVJvQWFFOUhIcUp0MlYxMzJaQTBWc2JDQ1lzZ3lCR3Qz?=
 =?utf-8?B?YmdzTk5FTHpHdG5HbkhSZCtjeEd1VlVQNGN3S2JRSThsTjRwa0JNMHJhK3hp?=
 =?utf-8?B?OWRQUkRKUytlUlltbGpUVEloWDNvaER1NjhtQTZBSitFaFlUNWcyZTBEOWhl?=
 =?utf-8?B?RTFRREVvNDdKNExnYmt4Yk1IMGpXamRJeHgzbEtCSmlZaTI2ZmN5T3dSZGQ4?=
 =?utf-8?B?OVJwa081a05XdjZPWG9pTmtwc3p0OWFBYUN2NFQyR3dKRTBlbVl5akY2UVJ2?=
 =?utf-8?B?ZS9wUWo1ZisyMTBDUnVLckt0QmlBZ05QR3krODJNUjlxZ2RWdzE5L203RXpr?=
 =?utf-8?B?blhRd2RoUmNGc3JUOEZxSUJCRUZZM3VuR1g0VHduQkhldGZqSnNZKzJnNkFQ?=
 =?utf-8?B?MzRyNzFhMUlYdGZySGpCdnhCTEtqQ1hPSHRyajFDdW1ibjFrNnhBMy9RcEhh?=
 =?utf-8?B?bnhyVWdpQThZNnNIaENGTmF5Qk03WTB5eFhaS3NrK2V1NWhBelpHeFBlUmRh?=
 =?utf-8?B?NExhOVFpV3BRL1RxbjdrL0VvMzRUa3hxS3BFUzRYRGVUakhtWlh5TFNiR0ln?=
 =?utf-8?B?cXJuVHNoUGlxNUFVUWFUNzJXb0FXWDJIdnJseXlza2tFbHhBYXp6RUxmME56?=
 =?utf-8?B?blNvdG01VGRuZ2FJaVNEOFY5ZGtMMDhwaHF0eFhxZTEvZmVYdWlXakFvTjFp?=
 =?utf-8?B?WHVOMW1oQXVGUDlsSHg4RmVQMC9ncWtjbE1Ib295Z1Vaam9vaThML2VIQTYz?=
 =?utf-8?B?REJZcEZXZFdvSFRKcWtRTXdONnpXcE53d2lsenhiUW1Ocis4d1F4V0VReVd3?=
 =?utf-8?B?UlJSM3cvazVJVTJ6eVB0QSt5ejFQdzVDK3Brbjh6bGZlWFg4M2JrSFlXWXNk?=
 =?utf-8?B?WEY2V0cycllGZUpnTVNxZU5INGdDcFlTRU5Fc25xalpjYU9ua25mS25UNTlt?=
 =?utf-8?B?UlI5NGdtQjMxRGo1VUU4SndsSGNtL0x3WUpERGJiUC93dUJSUzY3ZUxYZW03?=
 =?utf-8?B?UW84M2RCSjhkVmZ0T1BiZGsvOCthMU13eFhZQ1VjV3I0ZnNNbENwYlo3bWZn?=
 =?utf-8?B?UlpJUmVpdUlVT0tZQTZjamdFTVg5OXdOOE9SeWRtbFRkcWRZUVdaU2ZFZGZ6?=
 =?utf-8?B?Uk40enYxZ3hNVk9ENFQwMG5hQ21hSDJqMFNnWm5lNWpRck82YjNiNWpFNVlL?=
 =?utf-8?B?ZFdjcDJyVUNuNUlYMXdCTGIyQmdzampXaUorUlZTeVZOaFVXcFpBTmxCRUVO?=
 =?utf-8?B?N1hGRzJWdFlqbGwwUzFBK1dJejY2ZlZzMW9ZdzB6aDFnL3REMW1zcDMxcWxL?=
 =?utf-8?B?S1ZreTBLOVYyR3BLTU4ybDVwbzNUUWVHcC8wQ0tWeHYxdVBLNEdVUitQcjJY?=
 =?utf-8?B?Znp6TE5rcmdMTlpiYmx5c1ZnZS9OTjI2N09vV0VtWjdxeUJtTzFuTFVEaHdS?=
 =?utf-8?B?TkZ2MXRsdmtuMS92bXFTUExwYjE5aHliVGtFWEsvZ1RFLzMrUDdBT3JPVmw1?=
 =?utf-8?B?dGE3aW92R2VnWmRUUHlDUkI2M1dVZVA1U3pEUnI4Y1poZnZNUEdNVGY4WVJR?=
 =?utf-8?B?dDNKOVkxTW9TQ2duclI2SmxPaFEzc3pwVnN1V1l1L2JMaElFYStPSFl2dCs3?=
 =?utf-8?B?TjRpeW5lMGJWMlFGSFZYemYvcFhsV1RITW9rSmdNUytEdUIwRjYwWEV2TlIy?=
 =?utf-8?B?YTF0cU1KZXBWS1R2YUJRNEZuUWFzT0h6MnQyYWVDZFJVckIvTjlBMEJZZDhm?=
 =?utf-8?B?NTZiYTRYdm81WjRHZDhQSUJRY2FWWFQvK2g1R21CWmVPdjMxTHYwTDR1V2lM?=
 =?utf-8?B?MHgybVZLcmVxVVYrNHlBNXhZOVFsNlhsTHpVYTRHR0FLMS80ZytXWVBiRjlB?=
 =?utf-8?B?VWplMzNLanlvRERDSUZKejJYdzBWTGk0TDdsalppTEpTS0l3TDNjdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d58c328-5533-45f1-fd93-08def02642df
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 23:40:25.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vEzRBa32HphA/LNqHRaw792jiEBBxpRLm62wQ8UcRgqUZTp0S0Qcu2qWvvsJ4nRk0GzTAvKxGLzDxeMqXE90g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8812

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
index 38f701b65110..47d6b4c8bf03 100644
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
 	printf("\n ------------------------------------------------------------------------------------------------------------------------------------------\n");
 	printf("  Task                    |    Runtime     |  Count   |    Avg delay    |    Max delay    |      Max delay start  |     Max delay end     |\n");
 	printf(" ------------------------------------------------------------------------------------------------------------------------------------------\n");
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

