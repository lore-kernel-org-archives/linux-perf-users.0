Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3073812E4;
	Thu, 21 May 2026 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779331759; cv=fail; b=usjVmEVCFiyBiy6QNLt26KmPy/bwHSirt7GxfTZqS2EsJ3/DWzbHu3gqu/Ky7PJTxCZ2EdRiY/0OXFnRh2i9QV9VJ7VZC2l3neo2VakzXQmrmcetxanuJb45Z0/KDTKAk0DdY5jFahSpl0b0bPolvAA5AGEEZDHUoKa9INXBZbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779331759; c=relaxed/simple;
	bh=o4RjtsDgBmfKFVNN9WL4qBcdtzPR3e+6bQ0lCaVEsec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pALoek/lCdYcrBH/jbfQc8rpmTwiSJLJJL/EZKBrNXSjXpDZe9mWL0PN2GWky9/M2hbt6WRCzNc+knut8yf8t+nrA2fw0i9kqb30aNWcRf1QEhszEP7XuYk/KpBWsSllutH2S01Uc0RsRbyaMcPBrOccn36vHOiXih/Ue1PKY/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IK9kbqcu; arc=fail smtp.client-ip=40.93.194.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IK9kbqcu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNzQfqPa0aBBvbhPPJyBtVtUScDYxYftlRV9TD9SQPfN38xJ/J+vBjYRDPYYeX7r9L5lZI6Ey7OSWvRq/pkVUpYw3xjQnqTXg77liFKOLAYWI+zMNsr8Yfntqd5YjkJBDb8l2WybmGT0uuvrJ3pZwjDAP8j5NLPI7vnN9nuiFbcaiRycwUGVlFuGL/QtqasrjIBTjOXS8dQs4PZuXjwYD9FNjI68xpkCDbBlUqWqlCZZwO4UtQ99Qkg5keVeQBJdPrXMhD3ukCJA7yOheA6X2mlkHQJmsHe9gz1wwSl6tf+DpBPS+MZ4cS4TGc8B+OlRm3lqLLAGNN2CCFuIFV8bfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loUNz5fm1mY1eZa8mTlWfxgqu04fYL3GArxwFQltiPU=;
 b=UkVsAD2XYgFlEltmz8u/q2xO/3wLQJLP8hB5jxx2vzrVVzuP0goXvcm9skaxsqvMsr80G3rKoKr69Xs4VgqDtA6YnnpELp8IIxjMWISy4CeYFD3dapkQztr1eqPmmjzy/OqJgjRCChA5pIWw1i4/5G9H84YzESON/mwchm3xSSFEHrzw+p+XXMgSUXI6cW3VEUXc8tJe/XhsGarfcn1RxgTHCJpK9rlxuYU2Q3Ozkkz40EKdOVWJ5kec2mxW7qaLJGXbc56yuPP6uOhYpGd2BacSnJF7rDBCCNRbfEIipt2FjKmpQ3NI+Sjv1SWaTOjBgeUrwWSgLsRu7/NMe39qXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loUNz5fm1mY1eZa8mTlWfxgqu04fYL3GArxwFQltiPU=;
 b=IK9kbqcu3pjvg23hxqy3XxFOfL1EvGK+PSgg8O4IYUcueSHwl81Uh8xtJt+PFib+3E9sUHmYAwmDVEK8vYkn5OxedsxQFVUKB//aw1LS5DByWN/2LGlA+hNdu3YIgjUxStDrHIJ0aYATDPTD7S2LBzD0aRbS6pUO4V7Rykd+wiaZ5RjLxuRDN0VFv91yr9rcGll2ENbG2HpVhubtJQihvdQswJsNusz7ccO/bNX/tY9KH3f5abUi5Q1Mj6sXf4+U4e8pLfzTgCuMPDScuAvKdZOMtINnCDgcf2KKIRf+pSiRmRvjw+M8x1kK2yvhQQYsfomAB7tRWbzOqGuh3FNjqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 02:49:07 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9913.012; Thu, 21 May 2026
 02:49:07 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-perf-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/2] perf/core: out-of-line and export perf_allow_cpu/tracepoint()
Date: Wed, 20 May 2026 19:49:03 -0700
Message-ID: <20260521024904.331912-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521024904.331912-1-jhubbard@nvidia.com>
References: <20260521024904.331912-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::28) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: fa859675-eaf3-4914-32ea-08deb6e3873d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|11063799006|18002099003|22082099003|56012099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	7YCLKPa2AEUwz3att/sONDAIaWb8B/wr+USOaqgwP0zRV7RjZxQ35FLThr3lCfRoIFOYVSMkiMiQcPk8VPReh8kftrxsrvuSg67nYcCPREyuQtC4TXb6vmvUL9AHATCND8Fu9iuaM+J+EDepIioEydF5LIGkWHjLtHMmxiZUfh4zr7zEtEllqS04cRxSMWIctVDxRNm3+Wy3A170lWCFyejZbDDnZee+r9Dk7vYUvgHReBEF7ciDXDhgQvQfeYZw/7KSYbMADJEu2p56tDy6sWXNCWAICbS39/MPtnvk0XPvLQFi+B+OQ9nqv65AxTyUvBLU0iXPQCjGlqeNJH/Ma0bMWcYnjXReeE5Lpc+oQcs9BPIHjRpbkVMsew5kYOIKcbyDNlxMk2lquOCkp5vwDmLICV0vgxaCOp9zy7vMQMTEPulucOPabFmvDeADhCBZEEXDbEGfIsvhX6ZhraSr52ISbjbRw0crw7QVAsnM/NpZt9UA4jOXG/KnvX3zRZ5rkA9yBsOUj9cjUMpxLzQ8OHe6Y+KRn3eMlgaawpjnUDhvzoXw6LPGsouSen38yAakdmdR5fK+WU7yaGSoxo6SF0QOkNUjvjJ7KjQdP0Hn1CSrpfadxS/BC3YLqSOkahB7iS9xaImmTbHBypB27lX8oGHeprjx30l1IAbl0Ato6aH/ERCkPwmcb/UZdGU5hmHo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(11063799006)(18002099003)(22082099003)(56012099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?At473bMyY4zEGvPiGykbaFDQNmRAZorWR7BrFw68wTWJd4g7Zh+FgChMoJJK?=
 =?us-ascii?Q?LR58CUAAnavVb6YrlQXYNDrEu4FMToQAjF6XggOKuTXRioBK4nW8Am4dP77r?=
 =?us-ascii?Q?+0IhdOMkX7uZchUo44+gy/kafJwrkkYrnkRnMP1bfo2Af5GJT8U/agOv1oM4?=
 =?us-ascii?Q?TMZOHNJuSLQB3t4ZUBMoNirbpiK6gZ4TCghdZRRSLhYeRcbuPF6HfTIA9Hqy?=
 =?us-ascii?Q?3/w72FRkZPlJTSlnHQLQ7X1ZuFAgSJkeD2dyVKlGIUXurEIVjER1IRLZG3Lu?=
 =?us-ascii?Q?XdWjEogGeV8tz21u/2H5YFdyECOvaYlF2ze0Dqaq/Xj6AkUsHrdTPJoWW5L4?=
 =?us-ascii?Q?laa6+Hubed+a9fSmH5+43DbdePdnN6bx4+Oz1CFFztw0fRnveED3ywkKZYS4?=
 =?us-ascii?Q?b94Rb5cQBvHxpzgl/IbjmOEAfYu+NkrrdD3gshqTFhX7Km0SI+mJMj3W5GI8?=
 =?us-ascii?Q?BnmSfIMxeMlakH5mpGwtVzP6O5vSTtBl1x8URewN5TtnMIvMa9jpYjhqj+aw?=
 =?us-ascii?Q?wjdYSP3uupSlQwGyozE3d7F+XvyuCzNqzMtH+mRNjEiMKSEMHYLJ6S7Abs1T?=
 =?us-ascii?Q?o+khm7X1J0vo2SffhaJpcMTlwkZm38Mcbtu9bvFZ6c5S55WjQf3C4xHbOHQt?=
 =?us-ascii?Q?tXI/Kd+2xK9uQigjv7bYCz8H0oTjZoKk31AiWaXOZ3PXMEhYBzatMAmxqww6?=
 =?us-ascii?Q?e2vl/L3cWfHvNwvhj98TrcUNfrn3QabD4nsfwrAx+XswJ9zYzUhF0yv+ncBC?=
 =?us-ascii?Q?EXH0kzN8UtPmWMgYyUj+6f4hyn4r7XhsANtVM6E5UD2lcb7FMmvKWXJKfqW+?=
 =?us-ascii?Q?eo1uFRSL9Cr3TfCN+gVuzo11JJ4OYpned7MCUxhX5j/i8hO3yPxYRykQlY++?=
 =?us-ascii?Q?hP1bF02Y0fLX+AXurGQZwSThQg45mGf5gSm6AVfzeVLJ3WuWiJl4tkrxTMqU?=
 =?us-ascii?Q?y222+Go2XBXCCPhS9qfS+j/35kOUn3M5SawIdJfnk/z81QOwrIhkYBRX9/Xc?=
 =?us-ascii?Q?K+zCDly6BmLedvRK2fVKNTVQHiaIh+sA6VsPsqSyWHOj1huh1hqwUzy+rpA7?=
 =?us-ascii?Q?479VxVka+LSgCLmrQvOEDrX9MTU7n1JjO/0Kv2XoR+19G2P8OlygRgwvK+NV?=
 =?us-ascii?Q?3IDtR3OdxhbUf6mt3BsMKY4CqvNxPf4Qa5gVfTgJ2XuGXp2CbPri+++W9fq2?=
 =?us-ascii?Q?HPwBURy9DZH9HJ9XqIz6AGnNri9drD296+mCewwgCooIK9oXmwf4vhUj7u8R?=
 =?us-ascii?Q?LrIytIT+uLLRgQd7zSzo9G1Q7UnqdQyP7CaHjU12S++fClgGXBL+rdkumW5x?=
 =?us-ascii?Q?/SrouH/uXI9zaR/mS0US+u0J5TAE0I/pjZ68dsmVyWgzBTgIpxKgCG7CbLdt?=
 =?us-ascii?Q?0fbu5bJth4kPrrlZpFy2uwF1VYLIeWQP/lcd26lx5x2+5iAk6PsmpwJ80bdz?=
 =?us-ascii?Q?iHaANSoSkXoXy9yhJFZl3dtaUuoxk9GhTTRt43pjBrKbmfncCy/AeESqrHWi?=
 =?us-ascii?Q?WgphYDxm2ppaaykzj9Nks33vjA4l8YGz9/e5kJ57EMN7M0S66dpE5qrUn/NP?=
 =?us-ascii?Q?0G4vKwXelGqxdelkB4fOIAgHdCAZ3VkIoKrO7qxynx6NeY5zMw1OEUGpXQbE?=
 =?us-ascii?Q?7NZ6s5razAK9S+Lk39bJEuqD9CQwyCsABzN1hyQB3SC2R6PbhzJ0VSgtBSHF?=
 =?us-ascii?Q?XHCwsVLnANd2Gb2OIa8/o/ftoYH2XF17Fh8DBhAsAyUh3TVQRdrly18L0Zsi?=
 =?us-ascii?Q?/yo69ic/fQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa859675-eaf3-4914-32ea-08deb6e3873d
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 02:49:07.7261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +t/A1mw6qLeuKVlQbxclEqwjE5RtdtBrN60LxlL0yXJBV1WguK2UsDklPgnINIf69amwNmiAZqYspoP3xhckkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296

These helpers are static inline in <linux/perf_event.h> and reach
into sysctl_perf_event_paranoid and security_perf_event_open(),
neither of which is itself exported. The perf_allow_* trio is
therefore asymmetric: built-in callers can use any of the three, but
modular code can only call perf_allow_kernel().

Move both bodies into kernel/events/core.c next to perf_allow_kernel()
and export them with EXPORT_SYMBOL_GPL, following the shape of
commit 5e9629d0ae97 ("drivers/perf: arm_spe: Use perf_allow_kernel()
for permissions"). Existing in-tree callers live in built-in arch and
tracing code, so the change is invisible to them.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/perf_event.h | 18 ++----------------
 kernel/events/core.c       | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea..00c4ffe1434d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1791,22 +1791,8 @@ static inline int perf_is_paranoid(void)
 }
 
 extern int perf_allow_kernel(void);
-
-static inline int perf_allow_cpu(void)
-{
-	if (sysctl_perf_event_paranoid > 0 && !perfmon_capable())
-		return -EACCES;
-
-	return security_perf_event_open(PERF_SECURITY_CPU);
-}
-
-static inline int perf_allow_tracepoint(void)
-{
-	if (sysctl_perf_event_paranoid > -1 && !perfmon_capable())
-		return -EPERM;
-
-	return security_perf_event_open(PERF_SECURITY_TRACEPOINT);
-}
+extern int perf_allow_cpu(void);
+extern int perf_allow_tracepoint(void);
 
 extern int perf_exclude_event(struct perf_event *event, struct pt_regs *regs);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7935d5663944..cb13f3ad11a3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14731,6 +14731,24 @@ int perf_allow_kernel(void)
 }
 EXPORT_SYMBOL_GPL(perf_allow_kernel);
 
+int perf_allow_cpu(void)
+{
+	if (sysctl_perf_event_paranoid > 0 && !perfmon_capable())
+		return -EACCES;
+
+	return security_perf_event_open(PERF_SECURITY_CPU);
+}
+EXPORT_SYMBOL_GPL(perf_allow_cpu);
+
+int perf_allow_tracepoint(void)
+{
+	if (sysctl_perf_event_paranoid > -1 && !perfmon_capable())
+		return -EPERM;
+
+	return security_perf_event_open(PERF_SECURITY_TRACEPOINT);
+}
+EXPORT_SYMBOL_GPL(perf_allow_tracepoint);
+
 /*
  * Inherit an event from parent task to child task.
  *
-- 
2.54.0

