Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906CA30EF63;
	Tue,  9 Sep 2025 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418431; cv=fail; b=r/jmWV1N3aYi/HgElrh8wEK7dR0xsRWW4H3bJxiGOVYAXLrIFPGWdheEoIXqqdaLkKC86Tb/qIyEKdz86x8ZsHlKXt7IQy5u98MKHCHm2ht/P5LidvKJv22TuikGIq6E35sJ2d0f6AJ+/1tF+81pq8+xSGTPegFdI+AWQiK5lrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418431; c=relaxed/simple;
	bh=oJxD9HD7rdyJGgnHN2gjkU3Lff8G/dTRLSuyQK3Z/Zs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REramAzvl0O0NQ6pMny/h9umRuMEhUHllqtpxJEfikL04GvSDsrSpURHpCLv/9PIktA66h6wsANFcalGumXB9Lo+Za4q4It5iS9SH09rtk+4QXEfNj+jYywA6KPUEVHY94n+qvs4KrfKM0rbSnNQMCVbviGxIXVhXEqKoLdQGdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hhLTPUZl; arc=fail smtp.client-ip=40.107.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hhLTPUZl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URPTko4KMioZ3rgjttVcw2Xv1Yw9yrYXF9Jh56LbxIv9cZQzWbLO44uCdsEXYZSZCabN5gsCKhpEMZSrDZPhqtW6rauq654pPcvRy+1/P/5g681x+KkCi7+TywmJpFQInnLEExRvp3sxW3uQwoJfumhi/otdSueGDaISCaiS49DerQyHz6eJyz8P/fzFww/bpwO08w7UB+10wCVwT1d/m8oe8rFSTZNoL9Rs/QW/i5XYUV3WTtqxTjFCLERZ302d1QOv+HKip/zgsRuYQgqMAQUAbX6BuRX423CnyCqFdFRUGIPi5YCIeeTqZO9bqZSSW6K4/e0gTKhnrTZEAR2iEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuH4Jc2ohVg1C3/9sqpJ9GnIhkjwQPX1zsqKJUfarPQ=;
 b=beuB0MoB9vsmQfPBuboNZcCVQdZtPctJwEVcS4iTo4K8dIfRj+RZ7fIGQUMyApGsPVYdhW/abvsOOBMnM8DgCL7lEpxi+bs4k6MlBSNpvuZ3wvtIzqbKQ8HL6l2r/NtS2VWZFl2V5KXy94wG+d5vxPLNFa0nVTUyDgAk+FXn2fJjRHdSvNX60/xDRGqWwU2/nfbvQyUBmfAMRV5icYs+mze7Cs0QyrrpO5LWvbfYX7JlTvN3JIMgJO8HQqgrWnOrzA56VoYTB9WXGV6Akqxx6Uk/q06UXWFFIRgvh3CXkmrlGHQmGflTGt1uF6zBzjeH2x+M8VTlVb3Smit7nizoUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuH4Jc2ohVg1C3/9sqpJ9GnIhkjwQPX1zsqKJUfarPQ=;
 b=hhLTPUZlipyAgeooWo8M+xijYZM4ID3/SNRmpW8LZGM5G67iulrNaz5hELfh62xMg9Iek360Px0jG2VIOwhao1ZHnsoFxff6pzK7miZ8+Ii5apxZSm+9izjIt+2FX003jFjTqaFvZH8V2YsaMiPHMF539c24cYtUOWdGXRftP6I=
Received: from SJ0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:a03:39f::31)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:47:05 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:39f:cafe::4e) by SJ0PR03CA0236.outlook.office365.com
 (2603:10b6:a03:39f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 11:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Tue, 9 Sep 2025 11:47:04 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 04:46:50 -0700
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
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>, James Clark
	<james.clark@linaro.org>
Subject: [PATCH RESEND v4 08/11] perf sched stats: Add support for live mode
Date: Tue, 9 Sep 2025 11:42:24 +0000
Message-ID: <20250909114227.58802-9-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c2056e-2875-4437-d856-08ddef9698cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5NU5Wjkeliyjqzz0ay06pS/CqUz+EELCCP2xfXbqOKTLbpIiYmPlh0EqlASC?=
 =?us-ascii?Q?QbNulD3tA1tChfDPaQ00ZGhOmEvkuCs/awu+8A0OqYE/AIUl1xFyNGzvmsik?=
 =?us-ascii?Q?BTHyQwe9p5aH1XnctRrqVu2H4rN0v13puvJCS/g2A8/AfDVbpYNslB7Y6xn/?=
 =?us-ascii?Q?qm2Wr6IiL54xEkl3+ZIi60KbnNeztL/wQCSBsO6juBQDI+V1+dd4QeC0Fwnp?=
 =?us-ascii?Q?9mqr9vY2SiuRtsnONtuSHyc6bEdktZLI8NXWUHEGApqMFBq8pT45Bf7h9s81?=
 =?us-ascii?Q?uMDbZYOPW7JITbHjOE7QoAXL5jQ6QbUqK3aJdAqwoEP1l5LUoEe/B0g4426s?=
 =?us-ascii?Q?ZS/RdsiXI5YJtmXng8bw2GAZEcu+AHcIcfSTGf/4zkgJYlY40lMkNPHFyynD?=
 =?us-ascii?Q?M8YFvGibieWkrtinmrZySxlZ6QwpowjX3lblBWDpF1RaGyFKCYBzV6RECo1U?=
 =?us-ascii?Q?+Dpa53RP7zPqW72MlIZO1UAzRli/BQsf8CVwzQ5ok3IaiGoyKyno75ONSpiU?=
 =?us-ascii?Q?33egH7kbCrcdheWS8VEi3pmd5dJnMIHDbtR0wx8eiurSYzTNsd/2MlMfIm4e?=
 =?us-ascii?Q?Y8g9iewYKjE507WY/RhN5z4wtCI3Nd4dbIwziGdOk1RPrXsZyOf7dtznxmer?=
 =?us-ascii?Q?rL7SwmtZHHnp47+SwWNsBvDAG/q3muurCTmvo1uuIOPjCLfRVFFmChm4S+21?=
 =?us-ascii?Q?O8KRGLiFLDQdANt/O2tAb0nof0mMlE54k8lP1u10fb0GUYpNjnqM3sPjvXr+?=
 =?us-ascii?Q?FkknzgC1y1eZFGnK3FRxYRWFo1ohp5VGSlULCwRa4rGidI3njV+GB5Fklh6L?=
 =?us-ascii?Q?SGIQupnD0TPXbjqf3D6kiA/0zaY96NYvLKQgvh7brFjdenf6rrYqC3slofa7?=
 =?us-ascii?Q?tK609nGN2/hab0TZAiztydhp8vKfIATdtYKeZjipA4G8bD12bq4rrAi2yCgV?=
 =?us-ascii?Q?krgHEdi2Jb5ro2I9LCNeiRD8R2LUm5COHMWASs/Ri/deukbFqZWKqspcRK2M?=
 =?us-ascii?Q?o3bWtvZR8bYDA93d4xE7Mr0DuhkXieumKGcJjEJr7KXa18kKcyZ7Qvy3LhHa?=
 =?us-ascii?Q?rPSBU+8w10yujQ9fGyGYv2OG2y9dqFck1GVb3wrqsvQVmSlyyvN2m6sVOkMx?=
 =?us-ascii?Q?EqPviMofBfwmNBSNdm08tnp+g4o2eCCfzlt8XbhVLP9bUVBRNE8cmfGV2/LM?=
 =?us-ascii?Q?Y29O6Rxa8Tc2Kyp4zFAhANUtgIwd0bIbIwcnEyFaTYqJe0I2imw44SzHSdpx?=
 =?us-ascii?Q?ny0fItEqq9L+qyrJPgvqQvWa2AD4IKDkxWvzRI76uYIHfXQP3u1TB82R7C4F?=
 =?us-ascii?Q?YRTan1uqO0zy9ukVqYLYPUdKP4nDw8C5Yu37HOnyt4xVpGPbiLjkNY5yerND?=
 =?us-ascii?Q?RE2PXMRz/6lLzCO8wdZkhXBw+07XKe1q/Oh1L7/ICHQEP9cT8GQqubT3XRTI?=
 =?us-ascii?Q?RlvX+KxfN7oFcnstjl5akZ2HSSbNcJIqKhCHUCgNMDjlbQ+OTjDkYVV7iVxM?=
 =?us-ascii?Q?SUjFdT14D3GHUGvQdauTPJosknwVmLY+zpIh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:47:04.2890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c2056e-2875-4437-d856-08ddef9698cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608

The live mode works similar to simple `perf stat` command, by profiling
the target and printing results on the terminal as soon as the target
finishes.

Example usage:

  # perf sched stats -- sleep 10

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 99 +++++++++++++++++++++++++++++++++++++-
 tools/perf/util/header.c   |  6 +--
 tools/perf/util/header.h   |  5 ++
 3 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index e23018798f5b..ce04349cc4ff 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4439,6 +4439,103 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
 	return err;
 }
 
+static int process_synthesized_event_live(const struct perf_tool *tool __maybe_unused,
+					  union perf_event *event,
+					  struct perf_sample *sample __maybe_unused,
+					  struct machine *machine __maybe_unused)
+{
+	return perf_sched__process_schedstat(NULL, event);
+}
+
+static int perf_sched__schedstat_live(struct perf_sched *sched,
+				      int argc, const char **argv)
+{
+	struct cpu_domain_map **cd_map = NULL;
+	struct target target = {};
+	u32 __maybe_unused md;
+	struct evlist *evlist;
+	u32 nr = 0, sv;
+	int reset = 0;
+	int err = 0;
+
+	signal(SIGINT, sighandler);
+	signal(SIGCHLD, sighandler);
+	signal(SIGTERM, sighandler);
+
+	evlist = evlist__new();
+	if (!evlist)
+		return -ENOMEM;
+
+	/*
+	 * `perf sched schedstat` does not support workload profiling (-p pid)
+	 * since /proc/schedstat file contains cpu specific data only. Hence, a
+	 * profile target is either set of cpus or systemwide, never a process.
+	 * Note that, although `-- <workload>` is supported, profile data are
+	 * still cpu/systemwide.
+	 */
+	if (cpu_list)
+		target.cpu_list = cpu_list;
+	else
+		target.system_wide = true;
+
+	if (argc) {
+		err = evlist__prepare_workload(evlist, &target, argv, false, NULL);
+		if (err)
+			goto out;
+	}
+
+	err = evlist__create_maps(evlist, &target);
+	if (err < 0)
+		goto out;
+
+	user_requested_cpus = evlist->core.user_requested_cpus;
+
+	err = perf_event__synthesize_schedstat(&(sched->tool),
+					       process_synthesized_event_live,
+					       user_requested_cpus);
+	if (err < 0)
+		goto out;
+
+	err = enable_sched_schedstats(&reset);
+	if (err < 0)
+		goto out;
+
+	if (argc)
+		evlist__start_workload(evlist);
+
+	/* wait for signal */
+	pause();
+
+	if (reset) {
+		err = disable_sched_schedstat();
+		if (err < 0)
+			goto out;
+	}
+
+	err = perf_event__synthesize_schedstat(&(sched->tool),
+					       process_synthesized_event_live,
+					       user_requested_cpus);
+	if (err)
+		goto out;
+
+	setup_pager();
+
+	if (list_empty(&cpu_head)) {
+		pr_err("Data is not available\n");
+		err = -1;
+		goto out;
+	}
+
+	nr = cpu__max_present_cpu().cpu;
+	cd_map = build_cpu_domain_map(&sv, &md, nr);
+	show_schedstat_data(&cpu_head, cd_map);
+out:
+	free_cpu_domain_info(cd_map, sv, nr);
+	free_schedstat(&cpu_head);
+	evlist__delete(evlist);
+	return err;
+}
+
 static bool schedstat_events_exposed(void)
 {
 	/*
@@ -4764,7 +4861,7 @@ int cmd_sched(int argc, const char **argv)
 						     stats_usage, 0);
 			return perf_sched__schedstat_report(&sched);
 		}
-		usage_with_options(stats_usage, stats_options);
+		return perf_sched__schedstat_live(&sched, argc, argv);
 	} else {
 		usage_with_options(sched_usage, sched_options);
 	}
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 7ff7434bac2c..e8f4d00b5261 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1621,7 +1621,7 @@ static int write_pmu_caps(struct feat_fd *ff,
 	return 0;
 }
 
-static void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version, u32 nr)
+void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version, u32 nr)
 {
 	for (u32 i = 0; i < nr; i++) {
 		if (cd_map[i]->domains) {
@@ -1641,8 +1641,8 @@ static void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_v
 	free(cd_map);
 }
 
-static struct cpu_domain_map  **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains,
-						     u32 nr)
+struct cpu_domain_map  **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains,
+					      u32 nr)
 {
 	struct domain_info *domain_info;
 	struct cpu_domain_map **cd_map;
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index edcb95e0dc49..d67d26dad88e 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -209,4 +209,9 @@ char *get_cpuid_str(struct perf_cpu cpu);
 char *get_cpuid_allow_env_override(struct perf_cpu cpu);
 
 int strcmp_cpuid_str(const char *s1, const char *s2);
+
+struct cpu_domain_map  **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains,
+					      u32 nr);
+
+void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version, u32 nr);
 #endif /* __PERF_HEADER_H */
-- 
2.43.0

