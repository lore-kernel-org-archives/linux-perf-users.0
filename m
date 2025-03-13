Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2101.outbound.protection.outlook.com [40.107.237.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD11F4E5F;
	Thu, 13 Mar 2025 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741896771; cv=fail; b=nv31nlj2H8PObW6XaIMgv6NrHHdYJuOSqZ+a7GGI5dooh6mjkKmeF1VyM0ozy3ImAQcZeQmzQVJboPi2lTwXO9EuT21mMXbQ/c/lcL0whsAMMU8CAS8VQHuAOZkZ184Dkee+XLm9PRPyjvLflEzy4LQNWuLT0yvtVQGD7e0CQ+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741896771; c=relaxed/simple;
	bh=WKHwBCiWZV3fnmJtgMwrbYtVwzUyreMZLxZzvg1eySc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gWrfkwbeRlalhKxC4Y659zlS4cBCcETIXx32qI8gB/7L1DFw4+G4NCjwjzC/Ji9VL5/KnB2t023giPFG623VshehINFJ58Ox64kMaF93IHy2lok2x3CJiP9B32/W8/PWqlGRBt/XiG7GqCKNUvMYdHdpPhhTJgTnf00Q3wDPF9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=YeyMO4zM; arc=fail smtp.client-ip=40.107.237.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="YeyMO4zM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUY2c/+c4ZKJpNMHW1TyT+otH1u3bsTb8rXFTJizXr+a4iK6HTqwn2OeOmZnyJ/gxQV7NGcupcGwujeSVwYwH5yekInN2R35L+p7GadDGEKfg3GbTqgxAwJMnnyql/0uKbtwSwM7DU5e+T1BFl8WHYFiVgsaW/tVDfPpa64AVUN4Sh3QXexc1tB7boMtIJrGgn9+IcXCrNNZjncxYXvr+tcCYkKr0D6VO8xq/9O4Jc+bWssshotkjp0s1Fhl6XrKBNhccBKIY2qVibGBXreCqdWjZi/DXOeuiXEkm1hBw+l156HnTq1fQaF+zS2HplYDOxuRKcdFMMVntd/r/3niCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fgn3g0p4W8XPPR71S1Pvw25BbfbPiD7iIu2EesaX1HA=;
 b=yFNeCUbPAuCBqDou73MoeZkc4V4Odmws1Zrc0VlgW3OhvzTB647PInmMHcxizf6UA78nY0DW5GOot61nRE9focH7QcECTWYRX6VNZ//wkWj0l7o3aWqApMPYdwC79wvh8D+uJH/NHivgo2Uo43ZQ4qnJOXpQLC29AekmcXZS2JCGgvwnGGJX/b8Tu5nexs4iPylOAalOU/ElSmrapQbR1HMb6pe08W1S+mcsSXWk9CHL2xcEa+PKDDAyjKYyJQ/8ZiPr14FLzd1xpeCBg9wyzqPZ7/BBPu21+5jSYL5UBVHpRUGmdgVsOMbgpvd7kBV+4BWLWMKGGIE0+bC4t+gUXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fgn3g0p4W8XPPR71S1Pvw25BbfbPiD7iIu2EesaX1HA=;
 b=YeyMO4zMxaf8+x3SCvNkmOXkUn6u8hRJlB+eTAQgvCbTonmaYkH2b5DhQB1xuJY22ZXXwuCgm3V/hPW7uJJYGDFfMUCpMiGKI+wpCt8DHWBt9PvDWqwwoHXRzN/Cx6t5C3xzuZOLjr7Pf6ihsXwICiQorJcF4TCojom2Ffq3zaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 SJ0PR01MB7415.prod.exchangelabs.com (2603:10b6:a03:3d2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Thu, 13 Mar 2025 20:12:47 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 20:12:47 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf vendor events arm64 AmpereOneX: Fix frontend_bound calculation
Date: Thu, 13 Mar 2025 20:15:59 +0000
Message-ID: <20250313201559.11332-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250313201559.11332-1-ilkka@os.amperecomputing.com>
References: <20250313201559.11332-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::21) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|SJ0PR01MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c3f3d3-f79b-43bf-3853-08dd626b6c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rkbovQ/11jt7SsvrVwN0aAm+XVl6Key/GHNGlBifuq9hJT5Da/ejjL6ax/e8?=
 =?us-ascii?Q?hVNPRJkNeizhPqCJuk0skZeL9rCuQpUw5R94gY0h8TW8ewHpRNMPuddH/I+6?=
 =?us-ascii?Q?Lee7euL/h7EYfWhTeCQ+k1zBKwnUK02rWpHL7i7gLLjCpG4VyqdHEpBhAW80?=
 =?us-ascii?Q?qRQls79ybGZVuI8CAXSf0TMu7Hs/tpvNyKR7jI93rUl5XTEpirK1PsDFEpLE?=
 =?us-ascii?Q?Lw2eSWSr7UvD3WA2PrE1A3eEyRM6dcEr18zcvWa6E40zipiOt84IbijB9qVx?=
 =?us-ascii?Q?gTypKEbqnTXZ9gElmRuGj+BafcLGX1bOPWZj3d0s0leYeQhiFkWfxjL3mpYc?=
 =?us-ascii?Q?/za+AnXg1m0wv2ki33B9JkH5DJ4cT6r4GB0FvZ1cohr0sF5oZk3DXYpIWWuc?=
 =?us-ascii?Q?Bq5FqcmRaf9tfs7SCi9xD7cRJ8GB8+mxxNCiLG93XBmgC6owwKLv6MBNe95h?=
 =?us-ascii?Q?nKPDqp152bmX6okqWsnc/CR7/ZYcE6+31lQoNDYE0W7VD9/F+v4klvxHFB5/?=
 =?us-ascii?Q?aJfniBEBlsARfzvS/7SN/OT0j33XAeYpBdvwtofsYQ6Rf3UeWTmdziv8VFgs?=
 =?us-ascii?Q?mpixQcwknv9taT6PlRIt/igOcHCilknx5Z8dcxsWN2ucY1ke14mJ8a6c6meI?=
 =?us-ascii?Q?rzCywU+ywEKS4tILh1QaADwMT++7gvfoixaL8HkrXxkC6HwUjXuN+WQC8VNp?=
 =?us-ascii?Q?nb6oy0nVUpqmr/HRKmmzLa2VJk2T67+72a3+NHnA7XcbQM9bHFYJJMjw/Kw5?=
 =?us-ascii?Q?wgY6CV67GPelE+tOSV8RvtFVZ53wMi3dFmcSLBq+BBXe5GLzXJhZDUyhHs3o?=
 =?us-ascii?Q?beSybySnqkIq11Rkfpr95rp0zf0xkQMiuc+UJkwkX9BgicPfyZ0lEYEEpvMI?=
 =?us-ascii?Q?YdLOjtEsifkrOxQL/oYRBlCN+FdC3++fW1QJyslaQ9BQxSZ9qrBJZLx4nakK?=
 =?us-ascii?Q?LGX3RWKYKqJ7jY+g7pTysWxzY1JT+pRWEdOpNR0ZcPYO9/hb+2VAAunCXKQw?=
 =?us-ascii?Q?9xZkR224i47/CZC4kDmut7W7z55qOHtiqiJem3hR4JBs6N3wZv9MO96hDUDC?=
 =?us-ascii?Q?zj6oWwmald9WUT7YmG+hbmm8yrFwbMc/UBSlaItcdv43Grh+NAwEkaOI7kzQ?=
 =?us-ascii?Q?HiINYmDIt+hSfs9DS/d7KnLT53MiaY2R+04F+V2678D360JzscvSOTFqCza1?=
 =?us-ascii?Q?rt56MyOX4krE1KNHR7MM3o0pG7cKdTVFbwnNCSMbPq3KQLTtk+K3vxwZUtAj?=
 =?us-ascii?Q?rrGlp51CqZkhPLm/yBpG6oFwi3EGL2nEvKc8MmEGnHj4BNm2xh/6WF9boohT?=
 =?us-ascii?Q?ZhIbBfRyTfOxGB+8Wd2NXSA3OGCNCRROwEr3LRAv88QK65/ZZb3CdE3x5/DB?=
 =?us-ascii?Q?dFxxHXjRBTfFJR3txAgoidryxpmWv9Cj+qdcOOM144Y4IkCR2XcYlnXJJ987?=
 =?us-ascii?Q?hYgrMGLMsDs5Q53yX2cHKFTzQLJZRGqQWOpc9YcGMRoZDtVXpbfBKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bpzfhw4WDrLXfUSAXLMbcm8G3xdThehW/ZDvf8B+XCS/Mk33pgGoC2TTZyYt?=
 =?us-ascii?Q?AxcRnQdw34SSbcPiiAeEv2zmLHNtUI7ecAax1hXMfARxkyDNQBpxbwIiHS83?=
 =?us-ascii?Q?6hRN1CT3tK0qIvA1iaVxe3O0ZD++fZpbfRXpv+FeJEshBnWQTbglv6KX63gd?=
 =?us-ascii?Q?9M317IvEUS22ExI6Nwk0xxDQ5CPxMGddBajDkuUeUXu+Oy0BR74a7CmwHbDO?=
 =?us-ascii?Q?hjtjbryeVwJeS4DcrivD2WCVbPXfyCeh+RHJ9DrwnDkA4R9IPvEs02nRm7Wp?=
 =?us-ascii?Q?ovYgpVs80/4cQaUOINy4n+7hW7r83UXvlfRXV0bdUxXm+ays3RyQUZY1CAkF?=
 =?us-ascii?Q?1zNxmBtBwX0rfoi33lZRyHOZhppbu9vB57euS55UPlwd7jKRULjzJKKz6YC/?=
 =?us-ascii?Q?uzKxQmqDRk8Z5HpX5vsYInrdqe+/ALqGA1UKnpMjD5GQzF2TG0SfCGD1ezfi?=
 =?us-ascii?Q?MBLnCTsVqhCnrwaqizbGCgglmDnz/Qno6UkGknME3ctm4w7Z8jnw318f1WBk?=
 =?us-ascii?Q?Dtf5JHNA4FYLylFZbsmesuGWjxxIIx+L+AO+yVaazZISMo9tfDHtm01zvHkF?=
 =?us-ascii?Q?ByS5zDZMsOOy8CqOzVvoILA6NBudgZkW6t1CXpLiHCu2Rxg+sVigFcfnUjBU?=
 =?us-ascii?Q?pw911nln4yI4LXVEZXJ2zyOFYu1XXfX2e1K8le0vW/oeyFeNH8g/kVXRY62F?=
 =?us-ascii?Q?KBAA27njQ18L+7pr8uwTuSvLlVUrRHm/N2ITkiGSZPvaopSi5Zq7UvojL2OM?=
 =?us-ascii?Q?IUJBrJlYhYhIYas/KJ1P/Q4lpC3ClKHyD2UqcYq0oP5sGVlCTeug/CAuCKdn?=
 =?us-ascii?Q?fwv53ye+e0yycVJI2poT3BttH9L4EeG7fehaG0z+NRnOniutx1Ut2O4W5Fqx?=
 =?us-ascii?Q?eSOAfXoaa2mER5tEvdY+T3Fkh/ETL9gC/5V3FNnOsuuY1bI6+rXXmXuAU0ZL?=
 =?us-ascii?Q?dNjagojEo8SeLN0sz+p8+PX7z8X2KVWlKnyDtWN8QoyMpklIXkd+XjNOl4U8?=
 =?us-ascii?Q?Kw9Y4sR6013Bg98hygJ3rQYm7D2bd6pMTr5SW6K6TuMvTXVwHwZ9bYsVWYjP?=
 =?us-ascii?Q?ktkk7jea6SliYt23IKwYNeVnBXh5buw472YQN11aYkY7WQ5l9LdzMD6a8+6G?=
 =?us-ascii?Q?qM8YHiwK8q04YXQGyiR7mpQem0Yoyyd1Ub0GrExP5QYZuGcCRr0k5hNE3Lq6?=
 =?us-ascii?Q?8VJud4JZ/tNT6vzkWHakQgDBcLqZ9GfWWXSd20qsrz8ETXQZJKuNaePsvMTq?=
 =?us-ascii?Q?1cRI4JgLLHB1fuAXEhy40bo3vOYUNnF6wch7pgjyBYmviidK2xsd5cInYk88?=
 =?us-ascii?Q?byDkm4xs2zS2AiGYFTgKxICy4Om0tiOabvnoGTxElKvQXMM57wHH04GoUC2S?=
 =?us-ascii?Q?TdiN2VtzkSsA3THbnnPwMEWOMWc1Aa3shUlkMx1kaU0QpeN+Iyb/1yjgXsOt?=
 =?us-ascii?Q?nk6Mctae+tQCCchpmaUr8LApCYV27fXqnF39sJSM+AUIq+tTxxYoiRAOnAwi?=
 =?us-ascii?Q?oz67XheYaGm50Y2tB7FK1qTcNqL69UEesVIftI81Xh2xvREIQ7P77UC/LfXi?=
 =?us-ascii?Q?YC4NKmRbkzUSB0Hm358No50PqSElQBj6RYBCSqdKlDlnsRnGcFj8C2evWkK6?=
 =?us-ascii?Q?HBxmKMbqS9WN3etv9iHQZcI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c3f3d3-f79b-43bf-3853-08dd626b6c3d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 20:12:47.4719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giNXvJ3/OINGJhSyyxlya1PB9VanLrAhVIiV4MpCDgdK21rqQvf8F429NXl5TdskCtS9ojHMfHfkZx4rzw3aPnKcC0X/Ta1o2bmM14Uve6GpHyqVgn444nCnz14Sz8hf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7415

frontend_bound metrics was miscalculated due to different scaling in
a couple of metrics it depends on. Change the scaling to match with
AmpereOne.

Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core PMU events and metrics")
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../arch/arm64/ampere/ampereonex/metrics.json          | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
index c5d1d22bd034..5228f94a793f 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
@@ -229,19 +229,19 @@
     },
     {
         "MetricName": "slots_lost_misspeculation_fraction",
-        "MetricExpr": "(OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #slots)",
+        "MetricExpr": "100 * (OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #slots)",
         "BriefDescription": "Fraction of slots lost due to misspeculation",
         "DefaultMetricgroupName": "TopdownL1",
         "MetricGroup": "Default;TopdownL1",
-        "ScaleUnit": "100percent of slots"
+        "ScaleUnit": "1percent of slots"
     },
     {
         "MetricName": "retired_fraction",
-        "MetricExpr": "OP_RETIRED / (CPU_CYCLES * #slots)",
+        "MetricExpr": "100 * OP_RETIRED / (CPU_CYCLES * #slots)",
         "BriefDescription": "Fraction of slots retiring, useful work",
         "DefaultMetricgroupName": "TopdownL1",
         "MetricGroup": "Default;TopdownL1",
-        "ScaleUnit": "100percent of slots"
+        "ScaleUnit": "1percent of slots"
     },
     {
         "MetricName": "backend_core",
@@ -266,7 +266,7 @@
     },
     {
         "MetricName": "frontend_bandwidth",
-        "MetricExpr": "frontend_bound - frontend_latency",
+        "MetricExpr": "frontend_bound - 100 * frontend_latency",
         "BriefDescription": "Fraction of slots the CPU did not dispatch at full bandwidth - able to dispatch partial slots only (1, 2, or 3 uops)",
         "MetricGroup": "TopdownL2",
         "ScaleUnit": "1percent of slots"
-- 
2.47.0

