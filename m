Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC36125A63D;
	Wed,  9 Apr 2025 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185505; cv=fail; b=NfGOA/zneX539FAa3unL/SatYnK3qoHVZdM0NjlwNLp2TGQIgLAAEIVzc5/C+EHo0DerKrrK7EHEdBbmjttBW1Tw5rScwGFI7iAEtgKwdSiT0sKFnJ5QVUQHR7Naoe5fTKq4HSHMUIc5AdhFdcxs12Yq1JyX/g6YUXnjuk0J1Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185505; c=relaxed/simple;
	bh=y5OyOvxWPI0Sgyc5Xzb5xJ52K26uTVHxZuEjA429l+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FO9FCnpo8uXaioq9G73QyeKXKhABpntHEnyWTQQcCvUGpjIsSohDlmWocCoPvT50xhUg/325PIWGf+8l1hfWy1E+1+p3p8hKTHWSP5mpPt6C6JKqK0YddpRLyh4XE7C10DCD/l9x0DXzTtGiG/fP+V+cCELmb+hRVjGZN2hbfTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qgkt11fk; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qgkt11fk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBH7tc6uTIzjmH9veWKXDFNLokzH7feoknEIYa6nVzh6+O1YTHuW6TJ3BI/QoFaumrZFFPYnf2l8tSU/2t/Hm2yxF/rJqLIWhNXgtVOMLoI7WiGTo/6ZetlecbU/WTHhPP9H7y0fouGxqhl5ClTVdgeHrxgwzYwCl7Soy3OMaIZ6HQdt6RWj9s/2bRchX9VpVhGhG3TZ9yXcp2WktW7ioA5Q2sq4nIUHSITLcymTUI+ETVyr5Rk0Sa32kI+q1Qy8v677n/wkGr2ajvZxDL9BkVGStmNlYy6ku+7cGv0/IsFzvSnYLrtplY6IE3/p221DxapHYTJQrCsgKrs/MVuSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGNuXVhQ6GrRE43gBjT/Y0+b7lPutRJhOI6Ve9LELHA=;
 b=YS5KMRF6Wmy8VhcJV8UakeL+3TPE4Waus2IAJb1ddaK3SlEDEFfdKR4ldu+qKm956xrXIh3V8EM5Xuxt/XvcBI2gt6eiEWM+dQ2SX0wY3NFpFMxYSF1jrKkaS+PhLjVhQrFB+3DVrqCqw/oLbV9rLDK6y+yb0s6vgsZC4YP6t+6QQ6ACjqJnIMGFstOq+aJa1fBDaQ/8joID2bRZChupPme23xY47KdW3SMTwTl5uHiU8b4jhZO1QpIDctxF6QjzL6I05pD2gj7Tw34O+e2vP3HkKdiIKardi9zWG6N4+EZt2MssZvn18f+Hy2wTUApUSvuPSgfSnJf2C/M6FuPT+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGNuXVhQ6GrRE43gBjT/Y0+b7lPutRJhOI6Ve9LELHA=;
 b=qgkt11fkQwVCSy3eix/MiAyte6ZELBd8wwXzDM5fMoy8t6MJjikwR6We++s9L/W706b56zfyjuoT4jMpuek228mlDRV9yG2Bq/UsBmvmQHQu0RZsdSV/LwbxmrawXZG9o5ijb/D+kiF0V3Tj7nggLof9JTdaEt1uCRAZZNGRJ/s=
Received: from BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::9)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 07:58:20 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::dc) by BY1P220CA0024.outlook.office365.com
 (2603:10b6:a03:5c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.20 via Frontend Transport; Wed,
 9 Apr 2025 07:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 07:58:19 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 02:58:13 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <eranian@google.com>,
	<songliubraving@meta.com>, <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
	<sandipan.das@amd.com>
Subject: [PATCH 3/4] perf/x86/amd/uncore: Add parameter to configure hrtimer
Date: Wed, 9 Apr 2025 13:27:08 +0530
Message-ID: <42f99bafa99d25b24e5446167490d4d1720d11cb.1744184837.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744184837.git.sandipan.das@amd.com>
References: <cover.1744184837.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f563426-031a-47de-aa49-08dd773c4b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pYZlCezo9kNFefSgRJGnPalVPLeTZkbkJoTTCCI1x1unNPw1xREfT38Gq8c0?=
 =?us-ascii?Q?fMVilV+Y2pqYtxjdD81qwyQ8nGGIVWgs+NymIhzoNXkxLRarkAGTpy299aPT?=
 =?us-ascii?Q?/u1r5nqNcw2TbeQ0kMHfSfPKL2AH5DAUlVRfp6rfnovPFXQFobs1aXw/xSCt?=
 =?us-ascii?Q?JTbaQh4VIMo/alxK77UTOOLrTm00jDrqFdpNWFk9ctuzn1ai3e2ntrIU2+Dt?=
 =?us-ascii?Q?SzOURQEQwYntNztZYmbB8Brjm8AOaLaGiXMf1yH4l/e0o4Rw3m9DJ4e0xyMn?=
 =?us-ascii?Q?2AG+FCKKAe3NKDbiBemAWumEAjBZeTZ0w7WMDzD9LMFdybRZPmS/wHsbkOxb?=
 =?us-ascii?Q?97U4weWaij7rlDwbTwsZf8aV36Ep2ldV1NbdUmpfVzdKRQgyhe7WWR8L0M9W?=
 =?us-ascii?Q?EkBlsRsY5H4Nd60xLA/UjmJZy8RDo8XaHbDjZ4p8sHH/erTOy9bunJEJVHRX?=
 =?us-ascii?Q?XlANamEEVzGLKxWenJCGpYFsZZ87l8ZwthhFgpxxdzRyUXCJmpHKXRAJtV1E?=
 =?us-ascii?Q?nO/FuHm8xsClTJ4i3IsRlHiNdRR/uv0KKbHYMWfny0KmB1RcLfNyKHqrzbEC?=
 =?us-ascii?Q?pGgl+kjrK7CsPnTryiUGQ/k746yvAZMGkU3JPqkiJJKvYiLMjQptRXXvXwEN?=
 =?us-ascii?Q?qUlVc3pm+vDPIHsAtZ/AHKaWaX0NuG0sxyFs3NPhrf8QSYTv++3iTzmwJUy7?=
 =?us-ascii?Q?eA/NdXPJBgXd8hV/Iszu7MCZ5ueU4eRZDhAMXPkzmSyQI+iEpv2bs/m1yo7v?=
 =?us-ascii?Q?kle6rIIJnq5G5CLaewMUlvUn5gC47D6cSjbnYHvKjUyjy9kILSUQxWregEqs?=
 =?us-ascii?Q?RwRcdF8Fv9AaGuQKLC3GItm5uv+yiG8BYTE6CGSVzlO3ysb6jWPuxepQJ0HH?=
 =?us-ascii?Q?W3UzlUzaiUFj5TJ2KaroHQLQ8syVFBYPAVxo+YPc5cSCDmAuaICHd66E29bF?=
 =?us-ascii?Q?NzKxYfW/70vpA1MT7Gv6WkHFMgXAko58XZGeUfZJFnMVpWlQ19i3LssldYlE?=
 =?us-ascii?Q?LCEN716oHwxh3jE72lMcJ7knlX6p+fl/6Hq5VoiwA7Tyf+M5ySRv/Fo5AtnC?=
 =?us-ascii?Q?LgzrwNAO40wuxByVhBWCWYolFO4Au5NvrN8aAyt/34DH7Z8ZpQKWFJUBajWp?=
 =?us-ascii?Q?5ChywBZloLFpGlKQev70xBO5S39P2me4//mw3537qD42bBCAswowJlHgGj89?=
 =?us-ascii?Q?1RNQNRlnNjrH1OUXx53ercr7fg73NWvnbv0lkrrec2isZEUKJJHRPiDqkkA3?=
 =?us-ascii?Q?x347wvU/BRGV3ITJgjJ/IZMK3jeqFw2ILwu8E4PljSXjrxKGYz3sKkRUYPyT?=
 =?us-ascii?Q?+N/XsfmjdB4u5CYgr2idRjbCXzlirrzl2d7XCqaO9nfOn/xtk6qlvYPuLVJI?=
 =?us-ascii?Q?hqcgSXBCebtwxpWSyMioPc0MmUgO1XbO43mIMzlUB7nV9slwAP9t5t1WPZsH?=
 =?us-ascii?Q?cIJjeTCf9hhIg1bcqAsUlmaRxnNSZ/nr85QjlkAoQixnnZyf0ZJ6UlXK2xyU?=
 =?us-ascii?Q?+ieq4lXOayQaZMYPvZh0hBhQTGjpUaFL3VWq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:58:19.9057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f563426-031a-47de-aa49-08dd773c4b3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791

Introduce a module parameter for configuring the hrtimer duration in
milliseconds. The default duration is 60000 milliseconds and the intent
is to allow users to customize it to suit jitter tolerances. It should
be noted that a longer duration will reduce jitter but affect accuracy
if the programmed events cause the counters to overflow multiple times
in a single interval.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index ee6528f2189f..8135dd60668c 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -87,6 +87,10 @@ struct amd_uncore {
 
 static struct amd_uncore uncores[UNCORE_TYPE_MAX];
 
+/* Interval for hrtimer, defaults to 60000 milliseconds */
+static unsigned int update_interval = 60 * MSEC_PER_SEC;
+module_param(update_interval, uint, 0444);
+
 static struct amd_uncore_pmu *event_to_amd_uncore_pmu(struct perf_event *event)
 {
 	return container_of(event->pmu, struct amd_uncore_pmu, pmu);
@@ -554,7 +558,7 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 			}
 
 			amd_uncore_init_hrtimer(curr);
-			curr->hrtimer_duration = 60LL * NSEC_PER_SEC;
+			curr->hrtimer_duration = (u64)update_interval * NSEC_PER_MSEC;
 
 			cpumask_set_cpu(cpu, &pmu->active_mask);
 		}
-- 
2.43.0

