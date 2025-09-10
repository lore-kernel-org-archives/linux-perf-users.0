Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2123.outbound.protection.outlook.com [40.107.92.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C32D839F;
	Wed, 10 Sep 2025 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757533963; cv=fail; b=ZLv5qE9eaCjsUqQyMtuJmR4AT3GqZJE2m2DX/CgOQr3ompn6hGFmnPjnymy+qA8Xzp51Vh/CpyaMry5uVrvTftiCkyU3Y0eqWc+30+93g1HR0vK+LHAQ4MqcMXY9S8ZfYbUjakhpjY02pphFUR3o+FsJwj8cUTHxrbli7+VG4qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757533963; c=relaxed/simple;
	bh=1oU98PxjbbCb51lZg979WVj4J5gdBG/9ndEl/5cxPdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cieX6Z9/BrtoyEmrKMNV4BrHfkYMQ0k217iLQsq6FKgWNyDBksFY5KN2Yt1z5Um/C5z/NGb5e4IYQuoxkpriNNWaAOcIzZox0Es9Drlxi+mLESjEagAw9S32hKTgf8/Caj8B8hZFlH+a9oiuOgSFQKPVXkwZgRIl03xzj531bY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=hE9at7U9; arc=fail smtp.client-ip=40.107.92.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="hE9at7U9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFPxLjADhk2QlGA/XCTU9JM9KSDHy2tpX83l7XmAtz6yMamBJ04mrZq4tcvxikhTYV4Qnum8fRtIYGUv3t3wu6yHD2qA3brVPjsJGp8p7f6ajXyHGL9GFPR7wp1208VNt4YJY1kUm7zeZXTQC6OMRTmqqW2zaC70OGft3HN6f/acMK08Nw+BkqMqhszfYsZtXXsKq++hkKGD3SxAR1z4XGnn6B3/mClOG4vOz4lk4BQj4FZp/tl36ZjZjn/HaCw2I1wOh2E+KrOPq7+w6m3QLpL/lDYGwvdPVAL9ZTGkVAWKEjwbG1IBaPDTp6UbZZHUfAZMGSKE50dTwsSg6TVThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiIW9s1bwITUZYuEtAvgv5FMhepYEN3kauSknKDJeN0=;
 b=nJmblFjAGaBki9Ep6nzFJ30cDLiLEzK+MlvVR0VqBz6SnCpIaNzAS/4KT8Ny1Xa/yVrJs1eD/4zU59oM6j9Vw/XlaYHLGdAJPa09LaBiA5DzqO1zOFeT4fM3I2dNsykebaWbRobuQ8qI5KtRFbOfxG3YNEBm3HpboDy7NqYQDRX4A346PdX/kiYvqfjcgZhT0opDTjUV8CVsCGyeGN8dW9ESm6PXY3olQx5zPxWu4sSQ90VxSjEcgDQlLYiDd4GW3JoGuy9Jpka8wj7wveXxYjfgTq7vQOk6v8kEamtwbx9v6/Xx1HqG5iaDKwSMP4IKP+cphIVrOxrorhm8+F+dIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiIW9s1bwITUZYuEtAvgv5FMhepYEN3kauSknKDJeN0=;
 b=hE9at7U9tY8F5M7Lx/OjjhUGl3OL8+t7DWACrYrwRI0s6QftKBXb8c66ZRLWgMsk+3IBp3iPzInyAQO9odGNbHAYFo1W3NHrDdBYJYU3SwiNC3eqYp6nqbFnWt+0lLQy4cuUU3zQUFzPzRSpwDzM2af6Uwxp+u+gzRHCgeuDzwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 IA0PR01MB8379.prod.exchangelabs.com (2603:10b6:208:485::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 19:52:38 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 19:52:38 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] perf vendor events arm64 AmpereOneX: Fix typo - should be l1d_cache_access_prefetches
Date: Wed, 10 Sep 2025 12:52:12 -0700
Message-ID: <20250910195214.50814-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910195214.50814-1-ilkka@os.amperecomputing.com>
References: <20250910195214.50814-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:930:3::8) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|IA0PR01MB8379:EE_
X-MS-Office365-Filtering-Correlation-Id: 80233650-db63-476c-f7df-08ddf0a39821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3CIec7oGY6cqmaLTvTmvqnYHH9IrbfCNhRa3nW9xt2nFcAHytog32wuLbMGl?=
 =?us-ascii?Q?uRcgLJ8+kDIz6MwNco+G9X2m0KikELdb49qVrBSltdop5KHXYfdDW4FKeKc6?=
 =?us-ascii?Q?37T1JI8KmaMJN/EiNbq6AjXkBNKLeSk9gUOI/p2nH7PMbNb1QR8ezhfOy5Q5?=
 =?us-ascii?Q?L1EYsX8rZB3NgcapWMquzyXHYfYScnXAsKRg13fYcPqCoRpdyHHNo6PeF/si?=
 =?us-ascii?Q?R3mHP0sSRuy3mkBbm1u34FtVvFEArNcCswFzF6c39Y6Au0A2uNc5JPGA6A3k?=
 =?us-ascii?Q?zUNu0nRnKqt5+7LIKzazhpInAIdjl10/XsAlKMxYDTi7b0oyqvqfCUIoYINN?=
 =?us-ascii?Q?YDyvFNIzvfxw4plveeW3uXY0gJjOHyUYVEJLibfhDWM+hF1fSSbMZ/Fhmiid?=
 =?us-ascii?Q?Fq8qrAJHnbG3LgZ5digHCUVRchu60oJ+9jYQV0D3BSN8VZieeWd6Yp2sYCLF?=
 =?us-ascii?Q?/hhQtDEgaYPLNTIykkOFmPxynaDbrfC+eqf9FFSoOV4ZwMHRRrEwhWPA7/RQ?=
 =?us-ascii?Q?hcq0lX67b69GnD/G0HZMPDGKh3T3i0ijUENbxl5y/8bviwJuqIOiTocK60NL?=
 =?us-ascii?Q?1ej7cfOu0aZvF75QUJe16GS6J0q45K9nargogQCaOveC0VymMm7WFzeiqOel?=
 =?us-ascii?Q?C4Bu4yo4T2lMgDW/6MTuJQw0RfqDwml7V7l2hPuCpK7RwUzB9GSqM6gYhTAg?=
 =?us-ascii?Q?ut702xLJqVdPvPL7x7kuUOv7Geshbbc3YudNbqjv0hyZfkI+bCsq2znjRAcM?=
 =?us-ascii?Q?nwUEunFAdU/hIOgKlM0mc5nN2a1UCq7TFnh4KYa/u3HBgSk+X3f7Wcer5JxD?=
 =?us-ascii?Q?1c5LUoSaVaJDhT//Yo4GxmZR4QNm0e1XNqMeirgW4o00kRbpI8geHfnWRs7U?=
 =?us-ascii?Q?JCaQ3bPDQVnxXme4Zvjb1D99lC+vC2TTJHBv05LO61xQIyc3OSQQ4LXF3lH1?=
 =?us-ascii?Q?YnjRbSt69wFhDB7UOj8ki64fjkH/bukV2VTKY1G2ToFRaojHFLclewhhBFYF?=
 =?us-ascii?Q?gKGaOlpslVK139QV9rziM0Q56kHG5dC/MoigdY6PnPRypGmgI0DNPqX3msE8?=
 =?us-ascii?Q?3YIHdNB0V9qJMvbk1RbHXaqzXS5iE6s+PqFiq+YkCOQyndlLiIFP5VBxQtO3?=
 =?us-ascii?Q?4TPTbzY3yyBOm7+aldaqRa5ogIMsFpjGnbdQFtkHgIDft358dPGtFDLzZdbf?=
 =?us-ascii?Q?zNm9+KQQuY6otJXcldD/KWVdkT53djRqD4RtXJAcUsRlH0zeJM4sCvzxOa+b?=
 =?us-ascii?Q?7Z7TJrqEbc64bzq6zm1OtLBPVWwwi2ga09sAdIAxhos8/8y2HjEvBn5aheqc?=
 =?us-ascii?Q?GwwSMMMBO1e2oswktjEa8JZcdQ707Dtdw06vumMf/e/a0LLuRCe7UyLP3P0a?=
 =?us-ascii?Q?OYHLj+VW0VwZdR3UD0fLFy4bPCqAPHSzjTKtbnkCKIN5SnLiKuUo+fhhnpN7?=
 =?us-ascii?Q?jiSEO/z9lPahlWG7BOS3yNvLonz4ytYO9/Pimy/CC5JNQ7p7GmdyqpNJQUxT?=
 =?us-ascii?Q?aVEK1Cuxl9a48/w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YinU0eaTz36rV5QBPcs8M6IvHdXJICxi1wJlmhqEemvrUTCoOWycbhABr7f2?=
 =?us-ascii?Q?clH+lS8RyYtBv3KbgI+ZxRP+phbmPPW0gMwtU/TEOeVUIhv3vChkzuNv62Fp?=
 =?us-ascii?Q?bkTqVKb3pCaWcNF+pgZ7Z7B+FaiBiCBfZXPqJkeTPyPnjeEMXDjD3O3sCuvI?=
 =?us-ascii?Q?8fGiHqlwO9prMLY7t2phjILuY1nN9N/JZsQ34ayTRPdhz4ljyzyRKlqRRhy7?=
 =?us-ascii?Q?RlbWNMUkAUclvivjLCLtMinSZZhJY6uIXed6yqH332PuK/bFgF8V03qes4Ty?=
 =?us-ascii?Q?LXMufNkv5OlMBZwukdqNHEa7jvfNyZdpIDIG4VQKjEGyd1oN2cdiBN/BVpRv?=
 =?us-ascii?Q?+wyM/YCo3hKsJwiYTJePcIeoqpeK2i25/5DTRfN/NVrIufpz1lBnF5EJzYtj?=
 =?us-ascii?Q?rxqh+ajPgQpOeJiZqkP249yk3Mua8X6LUcNabT5HAVSavFgkWMKv9UvjBzfN?=
 =?us-ascii?Q?IMluql8ueLf6F0/+jLOacT+0wH9/452/ivBkSJwtNXTr9e3PnPb7ukkjEjBE?=
 =?us-ascii?Q?oOqrMy7KhLPsp/8ftvT4cqlWDO0XIhXwrv7CzTEgUlVyG6XyYeuhOJF4mBu2?=
 =?us-ascii?Q?9AyCFY4ldVlAANTZQ9Mt2TaPeRTtzF3+GrdJkwxBYd7n3zvHyfY6HZ2jKySi?=
 =?us-ascii?Q?LbLVC+RK4IfeTGWFNLIMmI05/e8t6Sk8TF92NfEpg8WRzN8yfhCBaEFjAxm1?=
 =?us-ascii?Q?N21sHtMpkHhAM7j7ZdK9kPn67YEC9eaM+vloMWDZXQnE5YGAFaQI8Jq7mno+?=
 =?us-ascii?Q?GIkur7QebRplg/niCP+GSPc2bov8DaZ+Rq6XAlt8gYs7OwAzZfzSPLY+FVXQ?=
 =?us-ascii?Q?s+m/bfWiYZhrxRTgufZamKVBeSQs7TKuGoDMd/H8F8flbQXCyx2Mfk92QdRj?=
 =?us-ascii?Q?bc0ZF+vR1QnM0D1507CN7M5tXRyEVr7U0KY5hvPsYQds7c6IInz87H74k5G1?=
 =?us-ascii?Q?YnAPh9TCCzYx76RZ5rs8Y/P7gFZRRDZZXgAKJz3YJCqPn3BspTkidXff3qsD?=
 =?us-ascii?Q?DGLTJ9K1DtPGr1butffAwxX6p/oNE3f+M3ZRr90vvVdThooKVDDNvpPs2+69?=
 =?us-ascii?Q?nm9GJOd6i7J4OBF+zAGtxQzEscdaj/upOpFA4UJavTLwyO986xo+pjZzDyhT?=
 =?us-ascii?Q?oefM00gJvtoc6dcQv/2d4/UgzaJkbjpsVOxzcACEYYhh3SGYkOJElkUt3jV0?=
 =?us-ascii?Q?9Aw/dyDb2M2P4ZBSUy4Z/xYWHun1/aiNOVEjACf7hAzDF5goEoTyC3O1H1FN?=
 =?us-ascii?Q?mjoMds7wrK48f79L8E1IQGQ+juGeJPynnV0e8ic42uXgT7/Q2ReOYU1OGrUT?=
 =?us-ascii?Q?93nDzK2Wkps6GjB2D20kW/zylLK9/LtJIHwQ5FRc78Nln4ZHkySiA+h3+TC/?=
 =?us-ascii?Q?bc/dO+QbSKCVHPwUZs8ceYS5J+NJTh8XBtwMO8WyJtGCuDGvycUh1oeMj/uN?=
 =?us-ascii?Q?v9JA/ve98dWJqbPiX+pMS6M3EWof+tkm35rPz0x205ip7xiGX/Wz7DbEwmTH?=
 =?us-ascii?Q?8JhvbOMZRX1kMtyIr3PbCGbcDQNZSwY53HE1o/6jxNpOwRxJDwB7/6DyJswW?=
 =?us-ascii?Q?qvCAs/H4acfDONub8SwQeT0OT14p6yO4MYk9dHmIsZbrazRcPevzNQfX3OkQ?=
 =?us-ascii?Q?TPoT+NfHI+5Mwq1ZV6w7I3k=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80233650-db63-476c-f7df-08ddf0a39821
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 19:52:38.0291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SB51zIhDPy+Y9FAuVNYjK144DMIIOraBEYF6wR16oIg/3B56fwcjM6XywOUkjzvFtRiI4vlwxWrqax5AARIrgkZRWIB8/DqRetv3XHfLz0Enjl2r72dL9j/HLghQgTvF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8379

Add missing 'h' to l1d_cache_access_prefetces

Also fix a couple of typos and use consistent term in brief descriptions

Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core PMU events and metrics")
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../arch/arm64/ampere/ampereonex/metrics.json          | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
index 5228f94a793f..6817cac149e0 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
@@ -113,7 +113,7 @@
     {
         "MetricName": "load_store_spec_rate",
         "MetricExpr": "LDST_SPEC / INST_SPEC",
-        "BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speclatively executed",
+        "BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speculatively executed",
         "MetricGroup": "Operation_Mix",
         "ScaleUnit": "100percent of operations"
     },
@@ -132,7 +132,7 @@
     {
         "MetricName": "pc_write_spec_rate",
         "MetricExpr": "PC_WRITE_SPEC / INST_SPEC",
-        "BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speclatively executed",
+        "BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speculatively executed",
         "MetricGroup": "Operation_Mix",
         "ScaleUnit": "100percent of operations"
     },
@@ -195,14 +195,14 @@
     {
         "MetricName": "stall_frontend_cache_rate",
         "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
-        "BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and cache miss",
+        "BriefDescription": "Proportion of cycles stalled and no operations delivered from frontend and cache miss",
         "MetricGroup": "Stall",
         "ScaleUnit": "100percent of cycles"
     },
     {
         "MetricName": "stall_frontend_tlb_rate",
         "MetricExpr": "STALL_FRONTEND_TLB / CPU_CYCLES",
-        "BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and TLB miss",
+        "BriefDescription": "Proportion of cycles stalled and no operations delivered from frontend and TLB miss",
         "MetricGroup": "Stall",
         "ScaleUnit": "100percent of cycles"
     },
@@ -391,7 +391,7 @@
         "ScaleUnit": "100percent of cache acceses"
     },
     {
-        "MetricName": "l1d_cache_access_prefetces",
+        "MetricName": "l1d_cache_access_prefetches",
         "MetricExpr": "L1D_CACHE_PRFM / L1D_CACHE",
         "BriefDescription": "L1D cache access - prefetch",
         "MetricGroup": "Cache",
-- 
2.51.0

