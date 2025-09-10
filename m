Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2123.outbound.protection.outlook.com [40.107.92.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1F12DFA2B;
	Wed, 10 Sep 2025 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757533965; cv=fail; b=euk291iFAhKhsuNYiJqLBlJ9wXct2gH8MEVhO1knrStNP6gI1GWR68D+ybVNlEmSluDodZw93+5y/TFDYVgIB2X+N0b4P5K8GB3mOfWamSw9t1jWeep/SLBmvzN/HzphExx10WINDFjK3wpTxTVeJNeg8JwDzhVFO7NsJ3mw2kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757533965; c=relaxed/simple;
	bh=mZfnaJ6t7y1R9aWWFMPS153WUQapwlMXupXfNi0QjJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ag8XzvrqCsLvFzbw9QiBdUlfgem+dRhl8sgv9IM0i6EopTkRuT7EY8ydrED06N/1a+UnwWYVuNgtOv9CuhU38wpnd2GjJhwMkj5UTUeRbgmnWAb8dgob5VK5FrxFYKdRekFSH2zpfEK1CRBZmOHGJFm5MMF3mQntxOMuzBD9ZhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=tyBjoefs; arc=fail smtp.client-ip=40.107.92.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="tyBjoefs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqH/9RFugrOnnBnFAwMFudxje+ZKwo9Jlxciiwx/iAo+Wmp7c/Lqb2ocoZzSk1EPL6BWmgM8mlZHvmxRVQ2pevGixUJfmW6KGhRVrlSE4h4vDL5SiqH29udcCepISpM8+abClSg6RsYp5jgrqDpM0wfr3eo7vBNc7EE0LhMMhCGK/fEWmmZErlMB7IaP4cS4tyCANubIwOXBSfXaLBCISurg1MVaxVOJUgGarfI16VzcBTmUWR3ua4wsCNJfFngqEL7anNRZ7MiQtH0tpOo+TO/QdFZHu1Kx5llsHpq6FyLYNjeptYOl8Yp47NkOM1jc4Y5E7t4xf6KW5Gkc1rnYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzSAeFh0gPA98AixNmoy8GohF9nxmLZMoE2xqAmGKkQ=;
 b=YRaLiL0Nk+dLO/GeVs2JZE+IO7v7A2cxIRkmbqlmj2GBAmjJdkyuXo+HIvi6b1MuT6MwmuVOkSebZqnhC2Cu77AO4HiuweY1TGMDFiLCZSPFHbPZaetk4sJb8A67q8HUGIiKzVb0AgNh/hTGhltC4n1cjLKeFSxy55noJKQpAwTWoxc2yYD2JK0+7Q0hXGvMdZ8h7pYEVwMlnQx1zfDmBpGBD/45dh32HQTQAEjqCgl6wTRi6W1Zp7szXdL+6hiZVLjCuyT0pHgGVzHyuxGVbVFUkkG4W1GLvSKw9OaqcZjl2ftkRMH1BVyU7XImpXpHQfzGIJdW36+EFF/PQfUttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzSAeFh0gPA98AixNmoy8GohF9nxmLZMoE2xqAmGKkQ=;
 b=tyBjoefsYjmRP5s/arXxEAyopEndREYhVvEDxplFuLEWjepUilBAIw0u9bKWlSuj8dHcrwdcl6WD7lh7z+CbJpRtVVwserUdvFL52gu2dKkpOB1+gd/gNE8yI7ixRC72YVxeaeHFC4nzUhlTw2CVGt1z6oV9mhOuCzHcQiHepCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 IA0PR01MB8379.prod.exchangelabs.com (2603:10b6:208:485::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 19:52:40 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 19:52:40 +0000
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
Subject: [PATCH v2 2/2] perf vendor events arm64 AmpereOne: Fix typos in metrics' descriptions
Date: Wed, 10 Sep 2025 12:52:13 -0700
Message-ID: <20250910195214.50814-3-ilkka@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6b4f6508-5cda-49a6-a86b-08ddf0a399bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OT9/v6y43dSKbD+ZEmLoFFnQnad9O/Dznc9ZG6f9kE1xpxB3vjFxOXzh4wl6?=
 =?us-ascii?Q?whIq+KBB3FLvO2OZTH9tanDYrWJfL2IjrcJYTODRi78oukvFl5uAjaL4wd0G?=
 =?us-ascii?Q?NYNuPfzAWfFIh/P15JxTFRqherR6N6QW6OilWg4k2S1YMhahOq8bpFwx+KM4?=
 =?us-ascii?Q?4JpkxjpPivPSc+Lh6pQFh3CeBCQi4ydX8fwQ+WtfMLdnYp88evzYpmmAHtwq?=
 =?us-ascii?Q?GAeA8UsvObh4Bi+9N4xlBgbOjAXFZP5OGrched8czmqHW5QzW30kjJp6EDvb?=
 =?us-ascii?Q?hflOEvbzIH2m9++GzA+GANQpi1aWjJfHYSsmeEWILhsJa5BlrHLVwTZHxdW1?=
 =?us-ascii?Q?nOVd0nU8Z9dZpbNsiIN9LRT0aoXtiDAEcDR+MZwaN7F+xR/3nvaEca8qc651?=
 =?us-ascii?Q?i0P282Vhxi0khdpn/2sUA4SMxAN5LY5mEYJ4R/WR6V7Da8qlDyJ6C1BWOcrD?=
 =?us-ascii?Q?B/NOzoPbelFRiXC586ZIpI+xnuu/mgMeiSiljGd+1+8C8DPkujmx5ig+VnRM?=
 =?us-ascii?Q?OlPSrDnN3vP1ufPuN+nSjXmbWOK49P34lwOCN9rbB+bR1uG3eIeHA2jjpuxK?=
 =?us-ascii?Q?EwQkQMDD6R0gP80p8OR9qIx6LWLgP4qKiXKsuKRQop1j3ilQaaWtT6qOp2Ru?=
 =?us-ascii?Q?L1FQsEEpYl9At7d0l+99xr7z41CmtHgm+h0qC9O8SnsgHRCD20M9oTtSZ/bo?=
 =?us-ascii?Q?NLWi5ltIldvBlVKXHUZ12BEB1KxoZmlJ3rtsI0KtbamuP4JQVkJQOWYSnzgl?=
 =?us-ascii?Q?sfjEIH2flvIb9a4ixPrnaRHOqXp7P/vk9etQHvKIwdfxbgtTX+eE9YKP4TIs?=
 =?us-ascii?Q?Yfhkio9CtyWsSERETsg+wy/6DaeuXVJv725Xq+gdifHiG5SxYXsu/LA1e1iR?=
 =?us-ascii?Q?cjD3OWmUa2WxAFcLtRNjHCQzDvmTkLLCq1qTO3+vO4DUNa3iOWrmdIxExlPO?=
 =?us-ascii?Q?F8WQ6fuRKoAt/jTKmgZ7DkVGM9x4sG9Z/Q23Iz9LrlqNO87dVJW+i8e/hMtD?=
 =?us-ascii?Q?LlaARSIz/2GJ2UJTwchL+x8NO2cEhPYtlC5U2SblmA/GQdKyrOnIwJ9BglH1?=
 =?us-ascii?Q?G2nvyYkBgK8TEn7cK95eQ6eC/WoMHyzdS+hp0belLOzr8jO4vchrbFGNn/Fl?=
 =?us-ascii?Q?m7cIP4Ez1m2RcknAGOcoK6BOPELxkzvoygLk0pn3ift97IonvSuqXjetiALs?=
 =?us-ascii?Q?I3OhTRX+2hKWgii9b33ibqV0bigH4uMEDXQ/bTs8Tw2Phe0AfQgDgw0uDSGe?=
 =?us-ascii?Q?H8/mH/RWpGuJUaPSOxy213kZiQXOInRM1VBoD5bQjRnOYPgmS95SveUnjNap?=
 =?us-ascii?Q?jigbzUhpmFQzFUtWH6R6PU/Z6HGkVF2rWPy3Hn8bZ2q2UIBYPEsoXGqF1vjY?=
 =?us-ascii?Q?7etwDZmo81eUVXlI6Wv1OTY4w4KFLAB6hX+2w2mz0N9CPieUo3XrDA/bvlo6?=
 =?us-ascii?Q?yi47fG0OX984Q3Zcnd+ri+DIQr8veasYei6dYLH8B5L25XmkFuPNDQjxJbbK?=
 =?us-ascii?Q?pOUkVRZq3vpZ+V8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lG6qAptDREobyGMAK+CRP8J+H9j0SHRYkPkCit/dhNpDTk8N2sCrqlWHJtci?=
 =?us-ascii?Q?9G1xWPuUEo6kjT+7k3pKByf22620zPpNeB2UT8BGuwrBKp1WwDLeQtexCqRH?=
 =?us-ascii?Q?m2OMz2POm5zvJSCAh4aG1rKE1/e5C2vofOG9c1IWfEaVoYcC3jnx4k/1OQuv?=
 =?us-ascii?Q?ZuJVnUUz5KRw7qJMEmtZyp0/gIX7Ro+p9lGgnVJYS7avT0gbw61KluJzb490?=
 =?us-ascii?Q?fsdHJmTTxVWSa+uU7H6SsMdtWRSvC6S5pDwmeC0Ekft5FNjkPrwUHaB+EfKC?=
 =?us-ascii?Q?R4qv2IvfBI2wyIEj8f0It++gGDjsDnbog6E9otqsMq8H6iYEj/+C3sFHYoDz?=
 =?us-ascii?Q?kdx3Go+iJocDgHDZ90KVYMCRcZPFIfQG3cmi5g9Ecy2ycAVi732p5tOiNCPd?=
 =?us-ascii?Q?C5xicqGGEsivPXUtM8VsGl9C7InVsHjVmaUQh8e34PZ39PwdDZLU4UMbLzkc?=
 =?us-ascii?Q?owHMrZ0Nbi+h103f7+w8FatWj1ttzcVAMFN0+0qBUL8ZGrWgHl8E9l1lAXml?=
 =?us-ascii?Q?pUFYydjNb6JL0Br9Duhyh9q1GP1fwc0IjgSz8A5ZsOKikbXKdkCCZxJTx/uW?=
 =?us-ascii?Q?I7c0IYYaoAJd5ZnPmIGNKQPtqTZbQ8Qgmv38kcl6emedykNjX574P+kbUifB?=
 =?us-ascii?Q?wXhOyMJSsBwy5xbZqkDRv5ILbUZuxTPkZ83K1XRd14O1hYPSwYuuFao5rN6X?=
 =?us-ascii?Q?1tuHUg1R7q/Kfsej0Puo4ZVXpmDhd71bVQc6JUrFSbylh+387sDyqnwBmsOU?=
 =?us-ascii?Q?kscTTaJiN7r8kCwGJzXgZMCdRKYTqAQdYNpug67UBoN1ssOP+G3lN2b1G7W7?=
 =?us-ascii?Q?T0ApTR4QNmhSG0AaimnbnOMAIs0v1oNtApcF7934GMW2KcHYnOwMkRx9fkj+?=
 =?us-ascii?Q?JV9xLxiD63HiQpPY/C/0lXPK9B9ezLWCNiILk9ekGykfn8J2RDCHEZkoc5Hf?=
 =?us-ascii?Q?t2TE5Ymcw+2DfGXlu8R72FTrYcTVdTWkkP4YH9XuLTw36NClhEzFKkNk82li?=
 =?us-ascii?Q?Zrn4Ir6FiOVoNEE+EsjsRZBCIqtyFh7JbMahk1F/NpIWjXDXInXDgcGr287V?=
 =?us-ascii?Q?xXvSOSAvKf8VZIzN4BOYvPREDuw9hnsuNK5X/TSCXOf4pQKhyxgdL2DVzsDJ?=
 =?us-ascii?Q?NzpN4BtoW8sPVTZp/N+25InEAIc5qGSYBDGVVE63TrAtgmtM0DlH6ygPdhuP?=
 =?us-ascii?Q?XuN9ji5sW/VtUaG1yqk/gjl+FBwcFRItGCfn6ibiIQzcR6iTSRwW9CcgiQmt?=
 =?us-ascii?Q?7iS5YsdDE+g8If6oXkz3LdLGn7BGrJf+gCJb/76iI6gD62dyeL6vG1NEdRCX?=
 =?us-ascii?Q?lRPIMCmwajYHtDEX4JnIlUsIRiR9i4NWu9cFwXOS36gX9fa93FL6UWj2BEFa?=
 =?us-ascii?Q?u7IWJb5hF37Z3e3pbXthGuKwya+ULvOeGpxWDtXWt692Db5qKqdXdN60sRvm?=
 =?us-ascii?Q?1DkB9/L2mXc6WqWCyhV20RhGT8p/jJieqkPXzmQZo5k5xsI5V6BJIkCoQkOM?=
 =?us-ascii?Q?Ft5lxceRGUNakX6nWThK0Pv7IyFdAYA/HYwxWRqRjyt+WUqCsoG3n15FS5tk?=
 =?us-ascii?Q?YdzsMZyMYr0r7hFldoh0ZctcwgvmzvvLnnFx0MFMFOpGpdXqPUnYk7Cri3NO?=
 =?us-ascii?Q?NIIXG479sBDDVtqAQq5f8nI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4f6508-5cda-49a6-a86b-08ddf0a399bc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 19:52:40.7335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o77XmyRqIzz75uu0tvxbJaKKxTWp7TkeWV8KfLf/ApD6i0BitgScLqYUx1VvXrTANTLaYU8S6aDReMAwJc/X8CBm9S9rVVakNSV/kSO4Xiyhmvko3q/6nwHIl6aXTGm3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8379

While fixing a typo in "l1d_cache_access_prefetches" in AmpereOneX,
a few other typos were found in metrics' descriptions too. While AmpereOne
doesn't have the metric, it did have the typos in the descriptions.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../pmu-events/arch/arm64/ampere/ampereone/metrics.json   | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
index afcdad58ef89..324104438e78 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
@@ -113,7 +113,7 @@
     {
 	"MetricName": "load_store_spec_rate",
 	"MetricExpr": "((LDST_SPEC / INST_SPEC) * 100)",
-	"BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speclatively executed",
+	"BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speculatively executed",
         "MetricGroup": "Operation_Mix",
         "ScaleUnit": "1percent of operations"
     },
@@ -132,7 +132,7 @@
     {
 	"MetricName": "pc_write_spec_rate",
 	"MetricExpr": "((PC_WRITE_SPEC / INST_SPEC) * 100)",
-	"BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speclatively executed",
+	"BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speculatively executed",
         "MetricGroup": "Operation_Mix",
         "ScaleUnit": "1percent of operations"
     },
@@ -195,14 +195,14 @@
     {
 	"MetricName": "stall_frontend_cache_rate",
 	"MetricExpr": "((STALL_FRONTEND_CACHE / CPU_CYCLES) * 100)",
-	"BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and cache miss",
+	"BriefDescription": "Proportion of cycles stalled and no operations delivered from frontend and cache miss",
 	"MetricGroup": "Stall",
         "ScaleUnit": "1percent of cycles"
     },
     {
 	"MetricName": "stall_frontend_tlb_rate",
 	"MetricExpr": "((STALL_FRONTEND_TLB / CPU_CYCLES) * 100)",
-	"BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and TLB miss",
+	"BriefDescription": "Proportion of cycles stalled and no operations delivered from frontend and TLB miss",
 	"MetricGroup": "Stall",
         "ScaleUnit": "1percent of cycles"
     },
-- 
2.51.0

