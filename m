Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020080.outbound.protection.outlook.com [52.101.195.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0920C029;
	Sat, 18 Jul 2026 01:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784337049; cv=fail; b=KQR5oCUon/gT7cY3DMbEeZAvRmoVPoHQ1sjPLSb9AqTpq3OxaNGNm4pjt3dTE3IfKKnzt20m2Ck6T2ZZdZsGK20sgE49krdHnwWuR9SrfKc1wIVIdehLAVVKzzLjkbftBHy9JHQ57ZlN8L9WtMhqyesjFGZKihybUmZ/1IRMqPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784337049; c=relaxed/simple;
	bh=XUT/wSW4IDjLhWc1MpOWXpRrWHWuYob4/6So6DCs+x4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LZBkit9BG4coRCv09lqhfYLysULNKTGPgVTiVxSCK3zh5T99N4jAxH+gBNbEXVOgdQ7KtlFeJbyIdHeMmvB6JltEqCbdNZrK9emPEPM3Fgo2sLPADvGa4KpY832hRylW26E960kd57fAzjxxvwD6h8mPwfjoYyz9m2bO/Q+xBC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXoadichn1O+ogj7Qetp7SuLPV0CUv+MJRIPEkdBy5DUs8mphPUSPiUxPEYZYOVuNFUBp1wscyiNSZVZktGdQMd0EIrKbitMlCe9ApRr0yNbbSjL3zmSlKXxU/UGGWFYz7CrwgI0lTMlfYZkY3NDG/zhnvTf3DKfEt+csSGlR3aK5MDN+EvrI44k8Prni0Kh+gacYdyoCl8ezC1UsHobqUct49BXhgGYqWaTLN3e4eFPK0Fbkg3n6dGBB1yWgo4JPrcqOYfzQZJd4ijt1mZ62WleR3DBBeXZ8H83Dp+wCwf31DrmFuCFnoI7bpbMZIXr8wMCRxmH+svnauC8S4jOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=x9YyeFbmoEGkiDD3BC01O/8BSPOkyogxmS5WUFLyI48=;
 b=RmmJ12E2hEKQELdOyqPYxkX3TO8dMm5HRE4XxxoHYJVy62QoJeuDkLdCoJGwsKtL8ZzaN3Ov2fE2S/a7EcyEbW0kcGIBvtMSylHlEKNwM/igqeR/daLKMPTdQTjr0Fi32nhh+33Uszw7phRAZdgvFeVBD2HeyIgXUN81/SL9HmaygyrTeb8O3C8XRFAZwAjqj2Df+tgdI+IZPurLMj6wIs4yHXgZQO72EficMVarrZKjtTNQOE+qVW/KHnNDXXcSMTPbs20ytpCG2nsWuP771lKw60MCkpPD4OQAzO31IlxOHNfiTf3B0uryIAm4R/eUUJRotrsODRUal9/fNt1ERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB3840.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:144::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Sat, 18 Jul
 2026 01:10:43 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 01:10:43 +0000
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
Subject: [PATCH v2] perf stat: Add --hide-zero-events option to suppress zero-count events
Date: Fri, 17 Jul 2026 21:10:39 -0400
Message-ID: <20260718011039.278310-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB3840:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ead06e3-d0fb-43d2-ea5b-08dee46963a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|6133799003|56012099006|5023799004|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	mFDky27BtMfhiOG1mzlv8vgBY9T/hHm1I7XPSENH7FqJNqz/OG2Vw0WOJqMeF9TtPipReafR4kzq6jiE61FQWsUSDOe9rlX/pO/MoGatYzSfiURJi90Oqm7EWbfErafTkwgA+hTcQ+1K18LX6OPqPMAyIfCPNzyPHGWJ+677TbyW9z9hvG9EJxg2PECe2GqlMTwZtSFdAqq9fjGXqxMiP11UGi/SZ6bzGH9yOZjSMsa5Q447jDcVU3sjk7RKsBqZZUPqZy0vI+ypM7WWBLsOY0fwg8ZFrMTEc/NbwPHFhcsY0hWVU/n/CG06m5C8EMErX/eQXilPBWJ5IukBFmpUEiIGDKMT1DYZ74PYc2uvsyvqHJeBnmKoEjF4by7JdydK5ZeVdpLtUXYFj0KsO7OPcaGoBM+wDl/+hZ94EnB/exdJO9f+0zTBtKyR0l+w0fbbdWjebwxEZQ4MMl566XZeU2SJDorlJGpjrRItH9pDqcgncPpIBCbmYp14JaWrGkK/6Y78JjMZhpxKnrFcEb0gzpFe8OrauqwJqPa8G8vvCbNZadIUCGTY37WVHSXHy6qbilIJ9zPK4kcZEi/IeGVOmWeFxw7+L0NcraWv9YRLEAbiUokihHNiGp05xcQ+7IC+hYO4FyrteK2mcKq1aXmg0MmE8kdA2UUOMM9tg+XLpk4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(6133799003)(56012099006)(5023799004)(10067099003)(3023799007)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eOKEicXIZGqzMaIYVJUSEuIYMQHF1CSRY9A/U4MML7vC+LzipqeW2Am6XzvP?=
 =?us-ascii?Q?2fExMovRGZlCqOhh3cueSRhqvH7VDgtLzcAO84ZjFwyIz0GlzB5KFo6ANsRM?=
 =?us-ascii?Q?jnGFKyzk3fdOzhT3M3cllhu15Bmkwgu7cCcFj2Oi3S2gz6+24Zj1Uv2sPybX?=
 =?us-ascii?Q?miQMUH3Uix1ita5UBOkqpS3yUKd87++iDkYKcDuVh0llh3YggfpJGXtoqWo3?=
 =?us-ascii?Q?DP7Gu1Hljx/UXJHryQwE2dil5u1GhwGwCTTuiQqxLnPHwx5bXKAyVChCwVRT?=
 =?us-ascii?Q?6xzP6e7DgCYDbk+teN8t4iXb0K8gwwFJm+6HBG9v8GlDinbUtgtqh5FWoFXE?=
 =?us-ascii?Q?8RFzZgPwqsu/WVGyLwyZFsZJNSj83z9CjQ3DELknxhuO8Qtdxqq5Kc4HGiiW?=
 =?us-ascii?Q?FsxVLeCVVNqNOwb8GA8GdSpBBGl+OuM9eFxIwS6bBdwZeXj7iDTkgJZ8ocHM?=
 =?us-ascii?Q?3YShhM4mIIgD4Gs5Q2YFa0S/sGsC3uR5jAno7E0dLC4OBgMPfCAv5jd+WkF2?=
 =?us-ascii?Q?h6QgoBqnpJQohK+z8+fKTl0+CnbvkBLvf1FIoWjxzEtwylb/jidxDTMOt6ft?=
 =?us-ascii?Q?guH+/xcKyS/1Orc3NzrtwIWzLtEdOhw3bvPIYIh9nJjBMcBHFmdSCx76mQPE?=
 =?us-ascii?Q?5WW2RyODP4QdA8ESE25m4FmfoN26ef9npskljeN8Rt2dHsI8GDl8RGHnZ4bp?=
 =?us-ascii?Q?8Zva/4EJWbL4EkB7XttDmIgsYWU8w6PgxlOotmd1A8b5GqovtThHf5cdSLhZ?=
 =?us-ascii?Q?B0aBiefVk4Yq8sdWv9MM/GgSqY0hqLMHN/4svsFDos4LQCT2nEQcMOwxOF+y?=
 =?us-ascii?Q?ccerTjHm/GDF45NwcqCzHi4n8NUF7GaK4tLVpRij8DesacrV9GE/pOolObCL?=
 =?us-ascii?Q?aujI8+4HHNsAbVz/iNnCbKQ54TCkdI9zx8S4uCZ2l0Wp9ecLx9pYmnUdi8Pr?=
 =?us-ascii?Q?TlFXilubj4YVsb6RneTM+fsSIhmnOHzh2As9e6nh6a9sItO+GpV2rJttb7nY?=
 =?us-ascii?Q?pTZevjWv3WUHEzumP0JnN+E0A/KjWV9nqrYvZDoUsVw2GQpDorYFQEcCYg7J?=
 =?us-ascii?Q?ZgdG0RdC8s7SO4HmhjJCk7qHp409kQ9RHbJBT5IuG3YzsYCQDyiyX8tY3Lop?=
 =?us-ascii?Q?+UXIzJXWaepSWIYY7wOLCZYpOIVj3n8hHyLJPeAhdv3XVsAt0Ipjnneo3mOA?=
 =?us-ascii?Q?+clInRun71jjBe6L1VFwfO9XurV2xxcgesaVF3Lqy2wOV15d3HK20/5yScaM?=
 =?us-ascii?Q?cR3JXa40zkk+ukyhbrs77V+eaNqc2ZyUJ/6KizztJlAUsnse8wLxatIv2CXa?=
 =?us-ascii?Q?eHmYs87TjetHt5Yu4LSlxQ5CD2w6/pD0BahdkUBXFvfIfAf/qkbk4cdOrhxE?=
 =?us-ascii?Q?EvBaDKPdm4tGPXeNWL5CKe98gdA02Y05ja1CMW7iNyYf+erNRuA/F4gdJc0l?=
 =?us-ascii?Q?Y9BANAhAFx33tt5CYjoZKcvhZFUG5a/q6tjuCxVsxpReHdvwk/wlF55bCAGg?=
 =?us-ascii?Q?d9QPLgsVI1hGgO2t0e1ihkPJnPgPub4zNZ1EyCfYQv72071nYBYRok5zVyGt?=
 =?us-ascii?Q?oXqbsaAJuJCnRhG60E3sHJBLaCoouOBw7rreSRYy8z+aKtngBJmCilXJ8Mni?=
 =?us-ascii?Q?9bwBCmxKI4ayy5uEVkDltpA4jj0Etv8q1JIwOMzEzkGt96IEj76ZhP5AIThK?=
 =?us-ascii?Q?/DUBLKnLLqUd6oAsIkRGx51dFFJADz0QKd55jFMVD4PaqxTHSzeXKbNW33EK?=
 =?us-ascii?Q?I5rBxGz7Fw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ead06e3-d0fb-43d2-ea5b-08dee46963a2
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 01:10:42.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhRUyP46SUQVaxsUS2qg1VwjWXVnME/yQ5dsfoXM3oOTDbAXkMJ0TiJoWgCD86EbdqTNdyc55MeHNJ4H3ZUYyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB3840

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
Changes since v1:

 - Add shell test coverage for --hide-zero-events and --metric-only
   in stat.sh

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
index a04466ea3b0a..8d340c2ae76c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2493,6 +2493,8 @@ int cmd_stat(int argc, const char **argv)
 			"display details about each run (only with -r option)"),
 		OPT_BOOLEAN('n', "null", &stat_config.null_run,
 			"null run - dont start any counters"),
+		OPT_BOOLEAN(0, "hide-zero-events", &stat_config.hide_zero,
+			"Do not show events with a zero count"),
 		OPT_INCR('d', "detailed", &detailed_run,
 			"detailed run - start a lot of events"),
 		OPT_BOOLEAN('S', "sync", &sync_run,
diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 1e17bee026bd..cf7a35fac871 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -535,6 +535,51 @@ test_stat_delay() {
   echo "stat -D test [Success]"
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
@@ -551,6 +596,7 @@ test_stat_detailed
 test_stat_repeat
 test_stat_pid
 test_stat_delay
+test_hide_zero_events_stat
 
 cleanup
 exit $err
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 0a5750bb59fa..1579e3e2c445 100644
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
-- 
2.54.0

