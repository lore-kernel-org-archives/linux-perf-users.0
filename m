Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021076.outbound.protection.outlook.com [52.101.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F63A43F099;
	Sun, 19 Jul 2026 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784425091; cv=fail; b=PBTd45w+bnxjdEOvVcG/dWJ0+94KUS5M1isR9xCs29DyWrYCmBhS8GqT/uu8axHZnUsiDWJS8xkA1chT2MWHLnulfy4Z59lszW9c0IbFnKSk5a0yFgkmk3jjZxFA/GB7VwR7LcOTrjtfJRXLl60743nCWlwh9p5+OEXHWUlYtgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784425091; c=relaxed/simple;
	bh=mT5jp6ei2XqBiLVwvUe3OkWGzwBdlWpVO1bxoh307aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JRC5YBjZzWCYC9zRaVEoWqePacptZncpPYhNdRPx+Ll0Elnm5qaB8IA+XDWQCPPBGwgmZFsAOJOLqRSoS4o/0+XBGK7FBfgE7YUgjYqtqtWvZhEJJmIKeoWMAHS8IYnj4Veq6QjfEFmyKrtkfaVhjEEmrl1a1VJe/T3LID5hVwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSt1EG2+Cw6L5gft6YbkdSgMEclj1vnjp29KdOPJWimoVXrPb7Q81cb7aph1K+wEMFc+QgnsfKJiJTIny4CvwLJdY6+t1EwocpB8EpY/BMUqyHCo5sY2j/ycBSMfSvdv2Aeo208yj/URds+r6u38Dj5InYssif6rhLLYpGeC06gIRD8E3fiBr12bXiNtchPEvM8jhXVS+JYjXUdoT1Ub41hqO8aBAPszefdKEiylLTdcpxPiqXGswovZEaVKVzed1IX3bkmfLOSy/3bdxSEe0V/CIrM0gB0wauJDUbigLKsTStSpOfHf2cmjN5ihTctGfj2QioMKexR2ZLrP/YArdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=yWgGFByrDZDUbKuGIgs3QjE7UFdVymahnbPuOGQmSEA=;
 b=dn6EQI2WeNxe9ySn0FaK2/kJtgf9bHeFeBCmi131ehKQ53yMS6k/a9ahc63HpG9rJrVTBBcpZY6bP34CMHmWp9TK9lsV503/0fl3x5mzDTqCv2VTvV7NKU1RPivdMRv2Addie5lODPYiP+njUcflr+Oe8PUsz2cFes+NQVXKr/0/WF6ppmdCBFm/zRO/BAUFrKyv4hqQqtEh3Jd5CIfrULhkSQtovFFvRF3nhgHbb42pL+gXE/KyE0qbkDBwPzbXLcSu67i3m2u4IKBrG3iWwxFkQ2PsT66q1irmtK5R/IWDyARVU2fyWQBC2Li32AfZARJv/8+QrAIZ4QcDmSfKjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB5858.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:195::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sun, 19 Jul
 2026 01:38:05 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.015; Sun, 19 Jul 2026
 01:38:03 +0000
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] perf stat: Add --hide-zero-events option to suppress zero-count events
Date: Sat, 18 Jul 2026 21:38:00 -0400
Message-ID: <20260719013800.404370-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0201.namprd04.prod.outlook.com
 (2603:10b6:408:e9::26) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c4bc22-1525-482d-dc68-08dee536600d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|6133799003|3023799007|56012099006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	dQJuBsArxQTPDeua/BvoE6+gS8MSXllGh3r7ooMF4T3j8EuNrtAQc9yBBAD0Szy+Z4sIDmApKn6XEC7DNRgcIUUcok+LWAJbmERd1TKC2sf+zInMf6TVIyzxOcJ3VD0g+a++USMq24IFv2ST6N2BVGPW6NS9HQ5CF18/vvhtvB2F9T5/9YsDOz9vzIzBrahljV1FC7LQbZm7DXViwXOHwnIPpnGQIIvid0gQVijZZS3pHCelxD7z6wARAmlgWKVrYZ1Ol8JQARZifNFt777lM4r08E2KiKFlwvbNQc7QxKg1lntJuUwdxW879eQNBNRVU0lPc1JKLvoazFN/spezxODEcIn2dzTaXVb8wgaOjOGunW9ct5jwel9L6iumSf5Rbyp4u0KgdKcqHmbwuWwa6ZLIBG8Mrti360wPGY2xch8/rfHy2pnd8cIFpFJuU33fGp/dKVr0PXgAVCjX2rimsE5QErsxqYc1w6OBJ9cVw5G+1voodRwB3SOjTw/6+DqRba1/Z6LsPyAdX3lHL7J0h3Nc+hTbMsp72oKfdLzSdKhDvo1RRQwFoLeeL/wJE8CJQH49r2lzfsPutaRzhix7unKY0aq2Oxp6LkaB4E/361zQ9g+jM/Gr2wpfMwhDsey+LoA81ugwOfeXHu90S5EXrOkZgz5hdJ8rcfYRwIvL6YM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(6133799003)(3023799007)(56012099006)(5023799004)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZF7SlZiZAr3oYyR59zG747zbqZYCVhwbRTij5qOlOKkPTAd0rIiKKkINdtau?=
 =?us-ascii?Q?8ZxSLXviCnbtPBOwehyo6ZQ99J7ohDg30jmu6KQGIeFVi3Oq+twv42uAtCWl?=
 =?us-ascii?Q?um5RlOETVPMWCA2BZBgqrxWK3+cK6GIAq3MV270xsqgxvZTgNhHfbySLWHux?=
 =?us-ascii?Q?FNn8T5upKZywPnsSFzCgDjBdF6lQPQ7kmIslinurYffpf+NVFwE8ok8BoNqP?=
 =?us-ascii?Q?7VpLIcqDYfJXgrgSdZ2JNMGaaXrZSNPLIgcxu0WtnLqsesdhafGR/ZoKpKB/?=
 =?us-ascii?Q?tcnAxy/JvI+ZIONMAwKrjIq/0LMAbCOfWGYYzMhXd2No03Tm8PPbOpmS9hxK?=
 =?us-ascii?Q?WoWRvY8Qr7OZ+9TmfrP16B39Ig5hzsOcuiuFPWP6xOAbn5fStxL+I0rdB3qt?=
 =?us-ascii?Q?aY45ad1za03ToN8jO9ldRJk9wedGQcB9Am0FC9NPARtBr+ir++1Wd02FXywX?=
 =?us-ascii?Q?t5dbo6ptnmcQ1kaceGUfyV+LToDnG6CoNOMwWUIKG/IdCicFrReKEoUhO5/8?=
 =?us-ascii?Q?UkiYVsKfJ1svHtPyVJ5IMfrelnJWiR9OluHo23PI1ncTLlVFS9oG3v90Mp3n?=
 =?us-ascii?Q?As4MSTD+AGyQG+jB9lJH3T/+7kz/o1pqyon2wH7O0Y3ArQydDm0re3ZG2Bbr?=
 =?us-ascii?Q?FzmAw7cTPRRJ36v9BJwKsSFeH6+qHkWvC2lEmWMCf0GEKgi9n3+IX8DIoKS9?=
 =?us-ascii?Q?sYX0gNVijhOQlZ8ibguMQE1hpPv8EJX9VmixcKCm/5CQUQXn+1cl7SDVHa6Q?=
 =?us-ascii?Q?2PCLQkMUB3fvHjH9+oM8CbykASIpOAoitqMm8fIKlQ267M5jtNgdjxpv9SLT?=
 =?us-ascii?Q?VWpYQj1KjhfrObsjdTBUBUJsVuO7kQeYqwK+0DiCv759dB+caWJaxKniJ/Km?=
 =?us-ascii?Q?3v7c+YfjtWGyAWaUzcUoFmcWPEiSy9DQp1xyAQsYAdqMeWmN+I51QZnA8ygH?=
 =?us-ascii?Q?03F0zsGzoJJEJv8duJXzoyqeuNH0wGj1zT0VLvz3/+EcobdT4Ia3SqueiwbG?=
 =?us-ascii?Q?6n32FvDVvQsuXuFaR+u2GG76jZJB11KWF6PrifiY+N95WUVuAcT3bF2pkVNT?=
 =?us-ascii?Q?CMAEWR46fJQ1cLc5D+6cW1bsZC8wEBGfMMnsUgOdzo1UgOnYQQgmVtrXVbkp?=
 =?us-ascii?Q?W4ioMaVXacyGLVUBMCUhkiBJ0R6/FIDGBCw4y0Vf4Z4wLc1WZWdqlp3hU+9W?=
 =?us-ascii?Q?lvrEuhXRUybzxCBAMHlIc4Ke1/+/lGBwtgQxbmrcWCU3lxwu30knZ2oQApYw?=
 =?us-ascii?Q?M42albXBPm9o2elvRoJ4UAO8PA93LGFSRIzMYxwBWMd3+0DTMuOHrTLko3XT?=
 =?us-ascii?Q?SxgdpQU/XT0ThGUG00Adczof6appDaFDqmnq3rx9kp8B7fXliD8EsTGptw/y?=
 =?us-ascii?Q?geHOni5X933bYw05tzKV8S20bdZtyyNgkFA0DUsP5woxlxQmTEHyXllbfNcF?=
 =?us-ascii?Q?di5XvtBBBp5/4GyAWsgjSo0hVMLkYg4Vin4T2wzyyg5zkq1N9mGRaS+7KDw5?=
 =?us-ascii?Q?GjIk/HjTZSv5BviV2Z82TFBxxJBsUCKVmLN+QjxkvG3phe1dthiNd9J6wnV8?=
 =?us-ascii?Q?du3xUzX2rjDHiMfAmiehkLI0wFZ75LbVWz500+SNiE4wpjbA72D17P2cf2ir?=
 =?us-ascii?Q?hQWL5wNpXeJBfNt9aVvo/nDSkfLaIQ55nh9vbVrsYJNKda0EIoz+v5ZZkb4S?=
 =?us-ascii?Q?++RDFQALbpYS9xq4bTJ9mfmyc6NUovDjIpK1+sHWPtRE50HJJRImTE4dCWGk?=
 =?us-ascii?Q?F2mbPBMDCA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c4bc22-1525-482d-dc68-08dee536600d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 01:38:03.8254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlxG69lxFu8P3iKQDCvjONhfBNlTNB6YllRT4Wkkgv1N3DwmT54/8mUxJz9/4grtSolLQ/xX+ZHgkF0wvFAifQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB5858

When monitoring a large number of events (e.g., with wildcards such as
--event 'syscalls:sys_enter_*'), many matched events will return a count
of zero. This clutters the output, making it difficult to spot the
active events.

Add a new option --hide-zero-events to suppress printing events that
have a count of zero.

To prevent formatting and diagnostic issues, the zero-skipping logic
implements the following rules:

    1. In metric-only mode (i.e., --metric-only), columns must remain
       aligned in the output grid. We evaluate config->metric_only first
       to avoid skipping zero-valued columns, preventing values from
       shifting left and aligning under incorrect headers

    2. For explicitly requested events, we ensure they are not silently
       hidden if they are unsupported. We only hide a zero-count event
       if counter->supported is true, ensuring that unsupported explicit
       events still report "<not supported>"

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
Changes since v2:

 - Rebased against perf-tools-next/perf-tools-next (Namhyung Kim)

 - Linked to v1: https://lore.kernel.org/lkml/20260718011039.278310-1-atomlin@atomlin.com/

Changes since v1:

 - Add shell test coverage for --hide-zero-events and --metric-only
   in stat.sh (Ian Rogers)

 - Linked to v1: https://lore.kernel.org/lkml/20260717023134.272578-1-atomlin@atomlin.com/
---
 tools/perf/Documentation/perf-stat.txt |  3 ++
 tools/perf/builtin-stat.c              |  2 ++
 tools/perf/tests/shell/stat.sh         | 46 ++++++++++++++++++++++++++
 tools/perf/util/stat-display.c         |  3 ++
 tools/perf/util/stat.h                 |  1 +
 5 files changed, 55 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index b72a29c9223c..f334aabdc809 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -162,6 +162,9 @@ null run - Don't start any counters.
 This can be useful to measure just elapsed wall-clock time - or to assess the
 raw overhead of perf stat itself, without running any counters.
 
+--hide-zero-events::
+Do not show events with a zero count.
+
 -v::
 --verbose::
         be more verbose (show counter open errors, etc)
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a85a4f30221a..d68a2617a920 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2505,6 +2505,8 @@ int cmd_stat(int argc, const char **argv)
 			"display details about each run (only with -r option)"),
 		OPT_BOOLEAN('n', "null", &stat_config.null_run,
 			"null run - dont start any counters"),
+		OPT_BOOLEAN(0, "hide-zero-events", &stat_config.hide_zero,
+			"Do not show events with a zero count"),
 		OPT_INCR('d', "detailed", &detailed_run,
 			"detailed run - start a lot of events"),
 		OPT_BOOLEAN('S', "sync", &sync_run,
diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 649de1166fed..298ce454b45a 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -546,6 +546,51 @@ test_csv_json_fail() {
   fi
 }
 
+test_hide_zero_events_stat() {
+  echo "Hide zero events stat test"
+  if ! perf stat -e context-switches,cpu-migrations true > "${stat_output}" 2>&1
+  then
+    echo "Hide zero events stat test [Skipped event parsing failed]"
+    return
+  fi
+
+  zero_event=""
+  if grep -q -E "[[:space:]]+0[[:space:]]+context-switches" "${stat_output}"; then
+    zero_event="context-switches"
+  elif grep -q -E "[[:space:]]+0[[:space:]]+cpu-migrations" "${stat_output}"; then
+    zero_event="cpu-migrations"
+  fi
+
+  if [ -z "$zero_event" ]; then
+    echo "Hide zero events stat test [Skipped - no zero count event found]"
+    return
+  fi
+
+  if ! perf stat --hide-zero-events -e context-switches,cpu-migrations true > "${stat_output}" 2>&1
+  then
+    echo "Hide zero events stat test [Failed - command failed]"
+    err=1
+    return
+  fi
+
+  if grep -q -E "$zero_event" "${stat_output}"
+  then
+    echo "Hide zero events stat test [Failed - zero event $zero_event was not hidden]"
+    err=1
+    return
+  fi
+
+  # Check that --metric-only works with --hide-zero-events
+  if ! perf stat --hide-zero-events --metric-only -e instructions,cycles true > "${stat_output}" 2>&1
+  then
+    echo "Hide zero events stat test [Failed - metric-only command failed]"
+    err=1
+    return
+  fi
+
+  echo "Hide zero events stat test [Success]"
+}
+
 test_default_stat
 test_null_stat
 test_offline_cpu_stat
@@ -563,6 +608,7 @@ test_stat_repeat
 test_stat_pid
 test_stat_delay
 test_csv_json_fail
+test_hide_zero_events_stat
 
 cleanup
 exit $err
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index f94f1324d24a..b337cc23f413 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -907,6 +907,9 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 	/* Metric only counts won't be displayed but the metric wants to be computed. */
 	if (config->metric_only)
 		return false;
+
+	if (config->hide_zero && counter->supported)
+		return true;
 	/*
 	 * Skip value 0 when enabling --per-thread globally,
 	 * otherwise it will have too many 0 output.
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 4bced233d2fc..e3598037a6aa 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -69,6 +69,7 @@ struct perf_stat_config {
 	bool			 interval_clear;
 	bool			 metric_only;
 	bool			 null_run;
+	bool			 hide_zero;
 	bool			 ru_display;
 	bool			 big_num;
 	bool			 hybrid_merge;

base-commit: 59355235f29e02eb4d88aa2d0c0d68aca901c929
-- 
2.54.0

