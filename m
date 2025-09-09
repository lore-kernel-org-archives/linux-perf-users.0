Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48267322A34;
	Tue,  9 Sep 2025 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418239; cv=fail; b=Sr/FLyvWuTCG1OBv82S/bF2bbsTuZqRvHlkrNl3oy6lN1y73V/llAj/AIoVBk1g3YTvugNbP1BQGlhx6KlMDtS/PaCFXIloDe+fOYv3TcJD8MEuMHAKD2+O2+XB2Jb3dX8zy1J5fENdS/X0AcTGd1yh1xN6osw7pd2MpZ6UWB2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418239; c=relaxed/simple;
	bh=NtkI70RtTfF5+4aXa4bFk0/lUXAX+lAbo3kZqBgK6uc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJjrKDu/g0my7LFePQ+fDWxNe1FIyeMISAVhMvhUwFaYSnBLsavH00hahMH9p8MhS2+3JE22SjCHtuFnXj3CQJkCUC7VB9FWK4OwXYNrfBMvVkuI/dT9E/ceghbdN81iaTF8xN94ze0TQupmNm7APKeTljF4bjzRhCS05EVGjjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u5dVAJXz; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u5dVAJXz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwOTu9QenEgxZAd1LumryxxqmOy2bqMbra5/lyLJPniH8WSEg6oliYVZH1K7vTxAwVATEGKtodnDe0utQzgsgtHcRwdUbPDyyDWILV8OnrvWHc5GifyzusZ1k4zGuAehOi3NMuVnp9vidcrbvrS4FIMyibOKHMpWBhFusJdvQ+sbKrHX+ObtQS8NSKHqCUxzZp7aO4ydyNBubvYO+YPzgaQf65e4L0BUCeyM+i4jQMPM85uEW61+d3+U6oxvOR7DGwvToxc7ZKsIbe6Fc356Esl2T69RIljbDkgSnnxWBllS+wsTxhsmdtSGy065fuVUorp1hiVkZg6NYd+DLESn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNxD/4yr6Vsad4zlpYjJNNqpz9+8mTY9oOt5lDVHg5U=;
 b=ZwFWZ4Rz8hz7aTAPZM+GrpMagm+jY06D7jE9XojOcZ6X7NIg1jqRMLovaYFl3w8D8s9DnChklV9jZJdiqOKSa91lfqtIzzYXEnwg4/nlLPUlzCMqYs3k/9dmgTFn4cfHpXapADvIEnvYkqh6yZiCN1aPAOY0h+G5a2AOfN1O/qNAbc+t2FPwm2aalMZLsuAa7T+jkQQfU0TGxhy5HLZuUc4XR+KYnVH765qSX/pUTfFQf6Jsuxw2t+A4GvLOD2ETKmdF5vVgiZm2P5VHoMqdCarHgtwolMRssiFsL1Pd9L6jaccAGPRpFP3hb3xeThOOwqbPr9fCRZ/EZG84/aQYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNxD/4yr6Vsad4zlpYjJNNqpz9+8mTY9oOt5lDVHg5U=;
 b=u5dVAJXzHvcDkzuIBb6gBAUaHiOg30OwMl8xRuN42sqQDfFBPloQeumow3IfAy31ntsKdAbfcHnmlSlVcz7uMwGuWzJvAuiDRZIZWahB9ctkmIcC6TELPNsKxB8Awp97fMRzggtMI+kIK/qbg2WQZC9peF0I08TZfPYpi3YQs2w=
Received: from CH2PR05CA0051.namprd05.prod.outlook.com (2603:10b6:610:38::28)
 by CH3PR12MB8282.namprd12.prod.outlook.com (2603:10b6:610:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:43:54 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::f9) by CH2PR05CA0051.outlook.office365.com
 (2603:10b6:610:38::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 11:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 11:43:54 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 04:43:42 -0700
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>
CC: <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>, <yu.c.chen@intel.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <ctshao@google.com>, <quic_zhonhan@quicinc.com>,
	<thomas.falcon@intel.com>, <blakejones@google.com>, <ashelat@redhat.com>,
	<leo.yan@arm.com>, <dvyukov@google.com>, <ak@linux.intel.com>,
	<yujie.liu@intel.com>, <graham.woodward@arm.com>, <ben.gainey@arm.com>,
	<vineethr@linux.ibm.com>, <tim.c.chen@linux.intel.com>, <linux@treblig.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH RESEND v4 01/11] perf: Add print_separator to util
Date: Tue, 9 Sep 2025 11:42:17 +0000
Message-ID: <20250909114227.58802-2-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909114227.58802-1-swapnil.sapkal@amd.com>
References: <20250909114227.58802-1-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|CH3PR12MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 670478bd-0371-4986-135a-08ddef962766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2kObTMpPBkgHmTb1OaEGSWrJKHkSbKsuZ3HElhx2fSI8jEKgOb2bXsKSmT86?=
 =?us-ascii?Q?6803RyMjkQek4HMFOdJA9KgtOjwFrk1nED08EnQcNvga7jSwoDjL/Hj41PLB?=
 =?us-ascii?Q?4sExfUg2f7MmPiwYmZ5Uvwnj9pa5j9bcnvsBogH3G6YTVI5oMlVJNVWxekML?=
 =?us-ascii?Q?pFHnVP5HuhNnepWCLaqK068Mm6TW8kxSuuo7SnPIvKqFZBumNhRs/0afopXz?=
 =?us-ascii?Q?4gEFvVbn6urYwXSMGvZbPFfsvqdIoUE+OxsYoQYgyvXucrA5pr9qJTl853+i?=
 =?us-ascii?Q?r/EPHO+Qa4ayy4YgDG8Osu5dI53M93eXabE4oe9EJSNJ8vfWivJCT6gpqU6Q?=
 =?us-ascii?Q?lWm3U5YafJTsUxl/svMgydSsk2hc1q/n0ElccH1XXlE9lqaEsKPcb3gROlfs?=
 =?us-ascii?Q?E0NoCMzZc09fevVTMHVLaxbNusoUf7cj+LVAiymKACvlJAapo3Gw1YuCxpoZ?=
 =?us-ascii?Q?vTlp2cWohS1iKN3ADMigUxOs2pRX1KQn0/VKANFMI0BWq9e4oBSvK1TnLOIx?=
 =?us-ascii?Q?iKdbS6EGDmzlHY4cZ7rhP3ZBzdOvraEBqap770Fw9FzCkrgvRBJREep+/Ela?=
 =?us-ascii?Q?0SRBQMKTCMsZboRVn7BtsyJTLA+Gb4E/0L97JERz7TNxKw190JRuZd3i4tbU?=
 =?us-ascii?Q?zqNv0FigKyjna1so+vLWvntdLh6FTz7CdHc4sV0cYp4bp53JJMGfon5MPpot?=
 =?us-ascii?Q?ZSyynNtBNQUqIXVPVFg/82uv2t412SsGkacjx4nMLS5Ms3VjG5jpNQbut+O/?=
 =?us-ascii?Q?xe0v1Z1LbAj5KmsI45bm5I8ASIqeQhC+iE8edT5vNF/ynIL3QS11oWXWq6B0?=
 =?us-ascii?Q?QiK2QwI0qyyfEak0nsU3DJUYetebdiETjZ94hpX4H5TtjB1iFYw7SPcNwjuf?=
 =?us-ascii?Q?Yo2uxa4VZr8mSY5rf1MzqQeLN+/tLbYI9aDTi8pkY1nYHGIKJ736FFbxCgaN?=
 =?us-ascii?Q?VTgiwKM3D0OAw48eJjMnLsvFmwgr9zipnk2qPpAGOJRrOyJ3rDvzc5AhxVpk?=
 =?us-ascii?Q?Cf1jmSK7ZNdJTKAQlD9Dy460FthRC4JouVeteONGNc5gu+ifTICcdNcQziIl?=
 =?us-ascii?Q?L4OlVaxk3tAU/cD5A3He08C2r/mcDgfuijYeD6yuxN840mrmGkz3ly4kaF+3?=
 =?us-ascii?Q?FNPWoe0jnxtcuhWk5PfJGChLokHmWqtFaP4mxgLSMgZxlEwsvNnC9qVu2Wv9?=
 =?us-ascii?Q?qoOvQMrU+ZFUcY2W4Tq1Yl/lpxuHfPg2goR+7A8YOkN7dRw2pZOzpTqB8P+g?=
 =?us-ascii?Q?Kgv42hTjkA8zE1aNjbU+QVA5CJ+sLA2u6kADley2dsMuZ+3xXi6nl0HvHeB+?=
 =?us-ascii?Q?4WNwf3Nx4DonhqlUwbN+wHTaL2NWg2g05BKpS/Em76ZoEJH4ft0AtB/YKY+/?=
 =?us-ascii?Q?Dkvy2WkzJtgpbTvzgkvs+5Q6wMwneYu+JFdZJIrQebPa7I8YZpZile2SXX1Z?=
 =?us-ascii?Q?IXKy+RslxL6EYBSE2SP7x+FiekPOewxcLIH4GQONlDsKHWRmH3YasRwnxXCH?=
 =?us-ascii?Q?pa2dlvUbCLiMhoDrx1fL5gIaiv+oRW3ACErZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:43:54.0991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 670478bd-0371-4986-135a-08ddef962766
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8282

Add print_separator to util.c and use it wherever necessary.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-kwork.c | 13 ++++---------
 tools/perf/util/util.c     |  6 ++++++
 tools/perf/util/util.h     |  2 ++
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index d2e08de5976d..842f59ff85ac 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1340,11 +1340,6 @@ static struct kwork_class *kwork_class_supported_list[KWORK_CLASS_MAX] = {
 	[KWORK_CLASS_SCHED]     = &kwork_sched,
 };
 
-static void print_separator(int len)
-{
-	printf(" %.*s\n", len, graph_dotted_line);
-}
-
 static int report_print_work(struct perf_kwork *kwork, struct kwork_work *work)
 {
 	int ret = 0;
@@ -1458,7 +1453,7 @@ static int report_print_header(struct perf_kwork *kwork)
 	}
 
 	printf("\n");
-	print_separator(ret);
+	print_separator(ret, "", 0);
 	return ret;
 }
 
@@ -1633,7 +1628,7 @@ static void top_print_header(struct perf_kwork *kwork __maybe_unused)
 		     PRINT_RUNTIME_HEADER_WIDTH + RPINT_DECIMAL_WIDTH, "RUNTIME",
 		     PRINT_TASK_NAME_WIDTH, "COMMAND");
 	printf("\n ");
-	print_separator(ret);
+	print_separator(ret, "", 0);
 }
 
 static int top_print_work(struct perf_kwork *kwork __maybe_unused, struct kwork_work *work)
@@ -1933,11 +1928,11 @@ static int perf_kwork__report(struct perf_kwork *kwork)
 		}
 		next = rb_next(next);
 	}
-	print_separator(ret);
+	print_separator(ret, "", 0);
 
 	if (kwork->summary) {
 		print_summary(kwork);
-		print_separator(ret);
+		print_separator(ret, "", 0);
 	}
 
 	print_bad_events(kwork);
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 0f031eb80b4c..1b91834e11de 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -257,6 +257,12 @@ static int rm_rf_kcore_dir(const char *path)
 	return 0;
 }
 
+void print_separator(int pre_dash_cnt, const char *s, int post_dash_cnt)
+{
+	printf("%.*s%s%.*s\n", pre_dash_cnt, graph_dotted_line, s, post_dash_cnt,
+	       graph_dotted_line);
+}
+
 int rm_rf_perf_data(const char *path)
 {
 	const char *pat[] = {
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 3423778e39a5..de69384380c2 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -48,6 +48,8 @@ bool sysctl__nmi_watchdog_enabled(void);
 
 int perf_tip(char **strp, const char *dirpath);
 
+void print_separator(int pre_dash_cnt, const char *s, int post_dash_cnt);
+
 #ifndef HAVE_SCHED_GETCPU_SUPPORT
 int sched_getcpu(void);
 #endif
-- 
2.43.0

