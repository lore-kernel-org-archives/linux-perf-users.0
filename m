Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3FC32D0DC;
	Mon, 19 Jan 2026 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845609; cv=fail; b=tMRUa2lOpE2REw/eLSFICL+QOIpsfr6sqXUF8eg4/nY3bqyoKOe9NAAp3omWKc0Ct0K1ikVcHMCgHs6NOToC6SxJLFzwJfVLgHTdOHtbny9z7GSO97Cxe9CQn5IFLL7h+6mN4KwqShWse/g4RfZA0CTh91WckXJkYQ+EObIWw28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845609; c=relaxed/simple;
	bh=JdjpCSovzT4LWPgbSjRYvmBTip9iLUsLIspuJBmTyOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJGPwxb8nN/acEQORpL3L+irgsdPe8QzwlydkEE+F4GJzMXghZxQhno2k3/iV6BZ1nTWRUySAF09STZJvdobK0QqtykFhSV0GsKTMIUVvQIc6SCDTZh73Viy26VmJFpn21Etk5BC1So5wQpSMo1ZWFFUv7nAJDUlZX0RvBU/mpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gnj4HdPe; arc=fail smtp.client-ip=52.101.56.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gnj4HdPe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keil96/EpgwEYmoQtKSpRDmg6OK5l2LCV7BtsP1l+R0BKVsBOkaX5QK7MQ1dBwAHFxB8pdqxt6gD61ip72dgYAfKgtHxGVzM+lO4Y/6ZZJxKVeZhDkh4AfPwmy+EK91X1BMbxQGOWwsmJqShx0CH9mhY3SvuHZgVObgj+lewlQBjbUoA1qGzDVKWU/Q/UoSC2ZLhNAOh2A+UJFQ3UvPc8fkGGZoXK73302eQriQbnqsuQIXMGIqq8P/omBySk6JiAis8e+oXzEL4joLmiO14dTOnG51NixeSx+Bigc6wFRRNBOVf4/XroUmli6OqS7V7ZS/LTv5hhHU+MrHMynhENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J94kY+PT8SKVHFSHeQD2A+eJCaXShVW/BKJdkxy96Zs=;
 b=XP0G0paSiIa6OIds1WJLycPq5sNJkXPj9l+Gl8ci2BSMkKRK4l1aEk9FscgryDAnAARCxN4xQlD17DaclrUVTPxRcoUA6n6IAr/Ylob4STz/IkaQIiEY3ewpEKAjpn0Ykkm2ewOO8WU8EJlOep3ZZ4vMn6yDSP2Bp6ak0ZusX4sE1IHRjA7oorZJF0q9SbHyW96uOQdHkEwqtbWuYFW0qZAL+P35ixHF0tTsbdof0EMIxIsTvT2VCbUblwTc22f2WuUtttsGBgEjqPkUyPDYycizd4zoRneJdN/5V4jSSmmeU7249RzoPmB+xMLcEOulErr0rA+vRFeADAaiFm8ukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J94kY+PT8SKVHFSHeQD2A+eJCaXShVW/BKJdkxy96Zs=;
 b=gnj4HdPeBIc8pVG6hFlHkN08yNvF8GfxIh5Ut8VkYZ3pNibcObE+igutKZTDERsowMia7n1xkDWADWunc1pVsxiHx+T3yoHO0BwtyNDa8aXTjTwJ+n8D2xyomrmpPzynX7loc/S9IBEdmb2bScOM9hcsxOIeuzGeWSblKyE3+og=
Received: from IA4P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::13)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Mon, 19 Jan
 2026 17:59:56 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:559:cafe::6f) by IA4P221CA0010.outlook.office365.com
 (2603:10b6:208:559::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 17:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 17:59:56 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 11:59:46 -0600
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
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH v5 02/10] perf header: Support CPU DOMAIN relation info
Date: Mon, 19 Jan 2026 17:58:24 +0000
Message-ID: <20260119175833.340369-3-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119175833.340369-1-swapnil.sapkal@amd.com>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|BY5PR12MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: a506cd8a-99cd-4484-0125-08de57848e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ugUyMM0O/j298+/intTCitJQya/3RWl7sTyJYrjrusEVoKfe03f1cfIkOwFl?=
 =?us-ascii?Q?sLTg2IvHpr6H9RvQwohAbmrfKlks+/fOTx9MA9RLyKK8JnfUR2Vip9iMJYVV?=
 =?us-ascii?Q?5zSWTLnr8I9iWDvYSfKHvpSbKWyPU6VfpC2p4RM6hNcXrk6t9wBobeOf1rNL?=
 =?us-ascii?Q?RCmxbmPnffUXaWYiJRdK6EUXjRly0XPFjtfoI+H8EFT/xTrkbunEnhuWDTmU?=
 =?us-ascii?Q?PPDGwlMo/HWdZIbjAKEXLTyrVWbwMqDt1Q4/Jow3rTJ7EoVnHjWoFbPADNTc?=
 =?us-ascii?Q?lj3n+ETYOvN0kHDKhmLa1D+FOKzZ4SV0wClc8DnisNdRVu/kKeYmIuf/ghYb?=
 =?us-ascii?Q?pSoPBrNr8pjuyWiyD7a1UGj5no+bfXcVPvd3wA/OevGs2xKtQjYunprrew29?=
 =?us-ascii?Q?X6Wh2D3cqMGkQOuQ7JrbzoWG/uMuKvh0itRklGd8BUb/7HXadqjuMhBssu2u?=
 =?us-ascii?Q?LibVmOuZY309IcR4CpxtIYetKm9U8BNkTQviOTEd4UBSzA8nxcuyx5HoytLB?=
 =?us-ascii?Q?gjRnY9g4vro0B6WjOLNd17GE6h5SqPvb896GoANT6iUM7TzCMe22OImasgUJ?=
 =?us-ascii?Q?ROzs36M2woMtMBhGiKjQgQr1xABGfRyAUJiYyt8hJmmnkqz9mys29gL0H2Kr?=
 =?us-ascii?Q?0EdECf/QkfBgWPZh6g9AAEGypbsa/sUv6OLcOx/2JajxhNRG/gWrZyNoTjBz?=
 =?us-ascii?Q?JeSIIZZuuTsmYCpWA5HzuLfPJWdouT5+O+Y0A6Sk++90vO89VLKEqzpxOBfC?=
 =?us-ascii?Q?yguAnjiLqAhiTojVqsTANNckA/YfQWYWIUM6P/lVkn+goGy7+icCxzoKfE5O?=
 =?us-ascii?Q?rQoHnwL8F3s+RIsI9mdW7F3mgB6tjW38R7EEWVYC7yJAyJ82P6JZ907BXjR9?=
 =?us-ascii?Q?Y9QH7oHRLasUQcyhgxztGfBU/8eg06ox3P02T70uMwKM7DnmcLYkh2wHYEsG?=
 =?us-ascii?Q?2En4LilT3LotzWOQY5N+NxYLXIU9RMBSwK0sixRFODSRZPbTGuPcwqQhpxUI?=
 =?us-ascii?Q?O0B3qbYSQcAhki9cVpsd7RC3mAvpTboqZENoTtRyNuVP/ZlXr5Dy82+P6snh?=
 =?us-ascii?Q?/4vUswzFb1miCPy/jksUGMMeBP1jgzxBZ+OJV4U8KJLp5uLewJ6OF/NIrsZH?=
 =?us-ascii?Q?D/3Qk1hrum9TyGXtSYcf2y0Z9q+Inh+t7I3pC4bLTYBsNz+s4d8CA3xQ3R3M?=
 =?us-ascii?Q?EyGSrCkTwj3cWZckdNKCCt7bS9ovnTlo7gEc6peix8/m0xAs2nQRK84CLX0c?=
 =?us-ascii?Q?ef4DT9N4w2Z1sQUteZMNGGSWY0xi7ejYutHC1UugUDmntHMTozFvGFnTYW+b?=
 =?us-ascii?Q?/+wma66H/V4SrVxONXvy6cFju8HPoXlHviAi5ZOMxbtJfwwbQCQg0yPvDf4F?=
 =?us-ascii?Q?ORpHaFrg7GuB/XQr/4UgsSfcYJIWilKnt/BeFltuzzy2XEh4xkw87kACIoEZ?=
 =?us-ascii?Q?ofZHBMmGpRL94omyJ9XsF5AAs+3rjZQH7AFHZDAFDhoToJr1B3EqwxDu/5Ef?=
 =?us-ascii?Q?HVwvQErpA3h32X11LtczuFCnQ5pdctSibbTjohI44+9uw+rNvbGaajQN1Gd9?=
 =?us-ascii?Q?wKpCDJGkx9KFQAyfpXbELho0JnnEz8457bLXzHzTfeR987VdPTsdTunLtDZ6?=
 =?us-ascii?Q?48tJJMqac5n23TsnlFjwHCoANhh5jtepqEylZZT8S1TLJnseK24POSDnsSUb?=
 =?us-ascii?Q?jTAZuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 17:59:56.4447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a506cd8a-99cd-4484-0125-08de57848e1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289

'/proc/schedstat' gives the info about load balancing statistics within
a given domain. It also contains the cpu_mask giving information about
the sibling cpus and domain names after schedstat version 17. Storing
this information in perf header will help tools like `perf sched stats`
for better analysis.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 .../Documentation/perf.data-file-format.txt   |  17 ++
 tools/perf/builtin-inject.c                   |   1 +
 tools/perf/util/env.c                         |  29 ++
 tools/perf/util/env.h                         |  17 ++
 tools/perf/util/header.c                      | 286 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/util.c                        |  42 +++
 tools/perf/util/util.h                        |   3 +
 8 files changed, 396 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index c9d4dec65344..0e4d0ecc9e12 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -447,6 +447,23 @@ struct {
 	} [nr_pmu];
 };
 
+	HEADER_CPU_DOMAIN_INFO = 32,
+
+List of cpu-domain relation info. The format of the data is as below.
+
+struct domain_info {
+	int domain;
+	char dname[];
+	char cpumask[];
+	char cpulist[];
+};
+
+struct cpu_domain_info {
+	int cpu;
+	int nr_domains;
+	struct domain_info domains[];
+};
+
 	other bits are reserved and should ignored for now
 	HEADER_FEAT_BITS	= 256,
 
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 6080afec537d..587c180035b2 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2047,6 +2047,7 @@ static bool keep_feat(struct perf_inject *inject, int feat)
 	case HEADER_CLOCK_DATA:
 	case HEADER_HYBRID_TOPOLOGY:
 	case HEADER_PMU_CAPS:
+	case HEADER_CPU_DOMAIN_INFO:
 		return true;
 	/* Information that can be updated */
 	case HEADER_BUILD_ID:
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index f1626d2032cd..93d475a80f14 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -216,6 +216,34 @@ static void perf_env__purge_bpf(struct perf_env *env __maybe_unused)
 }
 #endif // HAVE_LIBBPF_SUPPORT
 
+void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version, u32 nr)
+{
+	if (!cd_map)
+		return;
+
+	for (u32 i = 0; i < nr; i++) {
+		if (!cd_map[i])
+			continue;
+
+		for (u32 j = 0; j < cd_map[i]->nr_domains; j++) {
+			struct domain_info *d_info = cd_map[i]->domains[j];
+
+			if (!d_info)
+				continue;
+
+			if (schedstat_version >= 17)
+				zfree(&d_info->dname);
+
+			zfree(&d_info->cpumask);
+			zfree(&d_info->cpulist);
+			zfree(&d_info);
+		}
+		zfree(&cd_map[i]->domains);
+		zfree(&cd_map[i]);
+	}
+	zfree(&cd_map);
+}
+
 void perf_env__exit(struct perf_env *env)
 {
 	int i, j;
@@ -265,6 +293,7 @@ void perf_env__exit(struct perf_env *env)
 		zfree(&env->pmu_caps[i].pmu_name);
 	}
 	zfree(&env->pmu_caps);
+	free_cpu_domain_info(env->cpu_domain, env->schedstat_version, env->nr_cpus_avail);
 }
 
 void perf_env__init(struct perf_env *env)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 9977b85523a8..76ba1a36e9ff 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -54,6 +54,19 @@ struct pmu_caps {
 	char            *pmu_name;
 };
 
+struct domain_info {
+	u32	domain;
+	char	*dname;
+	char	*cpumask;
+	char	*cpulist;
+};
+
+struct cpu_domain_map {
+	u32			cpu;
+	u32			nr_domains;
+	struct domain_info	**domains;
+};
+
 typedef const char *(arch_syscalls__strerrno_t)(int err);
 
 struct perf_env {
@@ -70,6 +83,8 @@ struct perf_env {
 	unsigned int		max_branches;
 	unsigned int		br_cntr_nr;
 	unsigned int		br_cntr_width;
+	unsigned int		schedstat_version;
+	unsigned int		max_sched_domains;
 	int			kernel_is_64_bit;
 
 	int			nr_cmdline;
@@ -92,6 +107,7 @@ struct perf_env {
 	char			**cpu_pmu_caps;
 	struct cpu_topology_map	*cpu;
 	struct cpu_cache_level	*caches;
+	struct cpu_domain_map	**cpu_domain;
 	int			 caches_cnt;
 	u32			comp_ratio;
 	u32			comp_ver;
@@ -151,6 +167,7 @@ struct bpf_prog_info_node;
 struct btf_node;
 
 int perf_env__read_core_pmu_caps(struct perf_env *env);
+void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version, u32 nr);
 void perf_env__exit(struct perf_env *env);
 
 int perf_env__kernel_is_64_bit(struct perf_env *env);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index f5cad377c99e..673d53bb2a2c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1614,6 +1614,162 @@ static int write_pmu_caps(struct feat_fd *ff,
 	return 0;
 }
 
+static struct cpu_domain_map **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains,
+						    u32 nr)
+{
+	struct domain_info *domain_info;
+	struct cpu_domain_map **cd_map;
+	char dname[16], cpumask[256];
+	char cpulist[1024];
+	char *line = NULL;
+	u32 cpu, domain;
+	u32 dcount = 0;
+	size_t len;
+	FILE *fp;
+
+	fp = fopen("/proc/schedstat", "r");
+	if (!fp) {
+		pr_err("Failed to open /proc/schedstat\n");
+		return NULL;
+	}
+
+	cd_map = zalloc(sizeof(*cd_map) * nr);
+	if (!cd_map)
+		goto out;
+
+	while (getline(&line, &len, fp) > 0) {
+		int retval;
+
+		if (strncmp(line, "version", 7) == 0) {
+			retval = sscanf(line, "version %d\n", schedstat_version);
+			if (retval != 1)
+				continue;
+
+		} else if (strncmp(line, "cpu", 3) == 0) {
+			retval = sscanf(line, "cpu%u %*s", &cpu);
+			if (retval == 1) {
+				cd_map[cpu] = zalloc(sizeof(*cd_map[cpu]));
+				if (!cd_map[cpu])
+					goto out_free_line;
+				cd_map[cpu]->cpu = cpu;
+			} else
+				continue;
+
+			dcount = 0;
+		} else if (strncmp(line, "domain", 6) == 0) {
+			struct domain_info **temp_domains;
+
+			dcount++;
+			temp_domains = realloc(cd_map[cpu]->domains, dcount * sizeof(domain_info));
+			if (!temp_domains)
+				goto out_free_line;
+			else
+				cd_map[cpu]->domains = temp_domains;
+
+			domain_info = zalloc(sizeof(*domain_info));
+			if (!domain_info)
+				goto out_free_line;
+
+			cd_map[cpu]->domains[dcount - 1] = domain_info;
+
+			if (*schedstat_version >= 17) {
+				retval = sscanf(line, "domain%u %s %s %*s", &domain, dname,
+						cpumask);
+				if (retval != 3)
+					continue;
+
+				domain_info->dname = strdup(dname);
+				if (!domain_info->dname)
+					goto out_free_line;
+			} else {
+				retval = sscanf(line, "domain%u %s %*s", &domain, cpumask);
+				if (retval != 2)
+					continue;
+			}
+
+			domain_info->domain = domain;
+			if (domain > *max_sched_domains)
+				*max_sched_domains = domain;
+
+			domain_info->cpumask = strdup(cpumask);
+			if (!domain_info->cpumask)
+				goto out_free_line;
+
+			cpumask_to_cpulist(cpumask, cpulist);
+			domain_info->cpulist = strdup(cpulist);
+			if (!domain_info->cpulist)
+				goto out_free_line;
+
+			cd_map[cpu]->nr_domains = dcount;
+		}
+	}
+
+out_free_line:
+	free(line);
+out:
+	fclose(fp);
+	return cd_map;
+}
+
+static int write_cpu_domain_info(struct feat_fd *ff,
+				 struct evlist *evlist __maybe_unused)
+{
+	u32 max_sched_domains = 0, schedstat_version = 0;
+	struct cpu_domain_map **cd_map;
+	u32 i, j, nr, ret;
+
+	nr = cpu__max_present_cpu().cpu;
+
+	cd_map = build_cpu_domain_map(&schedstat_version, &max_sched_domains, nr);
+	if (!cd_map)
+		return -1;
+
+	ret = do_write(ff, &schedstat_version, sizeof(u32));
+	if (ret < 0)
+		goto out;
+
+	max_sched_domains += 1;
+	ret = do_write(ff, &max_sched_domains, sizeof(u32));
+	if (ret < 0)
+		goto out;
+
+	for (i = 0; i < nr; i++) {
+		if (!cd_map[i])
+			continue;
+
+		ret = do_write(ff, &cd_map[i]->cpu, sizeof(u32));
+		if (ret < 0)
+			goto out;
+
+		ret = do_write(ff, &cd_map[i]->nr_domains, sizeof(u32));
+		if (ret < 0)
+			goto out;
+
+		for (j = 0; j < cd_map[i]->nr_domains; j++) {
+			ret = do_write(ff, &cd_map[i]->domains[j]->domain, sizeof(u32));
+			if (ret < 0)
+				goto out;
+			if (schedstat_version >= 17) {
+				ret = do_write_string(ff, cd_map[i]->domains[j]->dname);
+				if (ret < 0)
+					goto out;
+			}
+
+			ret = do_write_string(ff, cd_map[i]->domains[j]->cpumask);
+			if (ret < 0)
+				goto out;
+
+			ret = do_write_string(ff, cd_map[i]->domains[j]->cpulist);
+			if (ret < 0)
+				goto out;
+		}
+	}
+
+out:
+	free_cpu_domain_info(cd_map, schedstat_version, nr);
+	return ret;
+}
+
 static void print_hostname(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
@@ -2247,6 +2403,39 @@ static void print_mem_topology(struct feat_fd *ff, FILE *fp)
 	}
 }
 
+static void print_cpu_domain_info(struct feat_fd *ff, FILE *fp)
+{
+	struct cpu_domain_map **cd_map = ff->ph->env.cpu_domain;
+	u32 nr = ff->ph->env.nr_cpus_avail;
+	struct domain_info *d_info;
+	u32 i, j;
+
+	fprintf(fp, "# schedstat version	: %u\n", ff->ph->env.schedstat_version);
+	fprintf(fp, "# Maximum sched domains	: %u\n", ff->ph->env.max_sched_domains);
+
+	for (i = 0; i < nr; i++) {
+		if (!cd_map[i])
+			continue;
+
+		fprintf(fp, "# cpu		: %u\n", cd_map[i]->cpu);
+		fprintf(fp, "# nr_domains	: %u\n", cd_map[i]->nr_domains);
+
+		for (j = 0; j < cd_map[i]->nr_domains; j++) {
+			d_info = cd_map[i]->domains[j];
+			if (!d_info)
+				continue;
+
+			fprintf(fp, "# Domain		: %u\n", d_info->domain);
+
+			if (ff->ph->env.schedstat_version >= 17)
+				fprintf(fp, "# Domain name      : %s\n", d_info->dname);
+
+			fprintf(fp, "# Domain cpu map   : %s\n", d_info->cpumask);
+			fprintf(fp, "# Domain cpu list  : %s\n", d_info->cpulist);
+		}
+	}
+}
+
 static int __event_process_build_id(struct perf_record_header_build_id *bev,
 				    char *filename,
 				    struct perf_session *session)
@@ -3388,6 +3577,102 @@ static int process_pmu_caps(struct feat_fd *ff, void *data __maybe_unused)
 	return ret;
 }
 
+static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused)
+{
+	u32 schedstat_version, max_sched_domains, cpu, domain, nr_domains;
+	struct perf_env *env = &ff->ph->env;
+	char *dname, *cpumask, *cpulist;
+	struct cpu_domain_map **cd_map;
+	struct domain_info *d_info;
+	u32 nra, nr, i, j;
+	int ret;
+
+	nra = env->nr_cpus_avail;
+	nr = env->nr_cpus_online;
+
+	cd_map = zalloc(sizeof(*cd_map) * nra);
+	if (!cd_map)
+		return -1;
+
+	env->cpu_domain = cd_map;
+
+	ret = do_read_u32(ff, &schedstat_version);
+	if (ret)
+		return ret;
+
+	env->schedstat_version = schedstat_version;
+
+	ret = do_read_u32(ff, &max_sched_domains);
+	if (ret)
+		return ret;
+
+	env->max_sched_domains = max_sched_domains;
+
+	for (i = 0; i < nr; i++) {
+		if (do_read_u32(ff, &cpu))
+			return -1;
+
+		cd_map[cpu] = zalloc(sizeof(*cd_map[cpu]));
+		if (!cd_map[cpu])
+			return -1;
+
+		cd_map[cpu]->cpu = cpu;
+
+		if (do_read_u32(ff, &nr_domains))
+			return -1;
+
+		cd_map[cpu]->nr_domains = nr_domains;
+
+		cd_map[cpu]->domains = zalloc(sizeof(*d_info) * max_sched_domains);
+		if (!cd_map[cpu]->domains)
+			return -1;
+
+		for (j = 0; j < nr_domains; j++) {
+			if (do_read_u32(ff, &domain))
+				return -1;
+
+			d_info = zalloc(sizeof(*d_info));
+			if (!d_info)
+				return -1;
+
+			cd_map[cpu]->domains[domain] = d_info;
+			d_info->domain = domain;
+
+			if (schedstat_version >= 17) {
+				dname = do_read_string(ff);
+				if (!dname)
+					return -1;
+
+				d_info->dname = zalloc(strlen(dname) + 1);
+				if (!d_info->dname)
+					return -1;
+
+				d_info->dname = strdup(dname);
+			}
+
+			cpumask = do_read_string(ff);
+			if (!cpumask)
+				return -1;
+
+			d_info->cpumask = zalloc(strlen(cpumask) + 1);
+			if (!d_info->cpumask)
+				return -1;
+			d_info->cpumask = strdup(cpumask);
+
+			cpulist = do_read_string(ff);
+			if (!cpulist)
+				return -1;
+
+			d_info->cpulist = zalloc(strlen(cpulist) + 1);
+			if (!d_info->cpulist)
+				return -1;
+			d_info->cpulist = strdup(cpulist);
+		}
+	}
+
+	return ret;
+}
+
 #define FEAT_OPR(n, func, __full_only) \
 	[HEADER_##n] = {					\
 		.name	    = __stringify(n),			\
@@ -3453,6 +3738,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
 	FEAT_OPN(HYBRID_TOPOLOGY,	hybrid_topology,	true),
 	FEAT_OPR(PMU_CAPS,	pmu_caps,	false),
+	FEAT_OPR(CPU_DOMAIN_INFO,	cpu_domain_info,	true),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index c058021c3150..c62f3275a80f 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -53,6 +53,7 @@ enum {
 	HEADER_CLOCK_DATA,
 	HEADER_HYBRID_TOPOLOGY,
 	HEADER_PMU_CAPS,
+	HEADER_CPU_DOMAIN_INFO,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 0f031eb80b4c..b87ff96a9f45 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -257,6 +257,48 @@ static int rm_rf_kcore_dir(const char *path)
 	return 0;
 }
 
+void cpumask_to_cpulist(char *cpumask, char *cpulist)
+{
+	int i, j, bm_size, nbits;
+	int len = strlen(cpumask);
+	unsigned long *bm;
+	char cpus[1024];
+
+	for (i = 0; i < len; i++) {
+		if (cpumask[i] == ',') {
+			for (j = i; j < len; j++)
+				cpumask[j] = cpumask[j + 1];
+		}
+	}
+
+	len = strlen(cpumask);
+	bm_size = (len + 15) / 16;
+	nbits = bm_size * 64;
+	if (nbits <= 0)
+		return;
+
+	bm = calloc(bm_size, sizeof(unsigned long));
+	if (!cpumask)
+		goto free_bm;
+
+	for (i = 0; i < bm_size; i++) {
+		char blk[17];
+		int blklen = len > 16 ? 16 : len;
+
+		strncpy(blk, cpumask + len - blklen, blklen);
+		blk[blklen] = '\0';
+		bm[i] = strtoul(blk, NULL, 16);
+		cpumask[len - blklen] = '\0';
+		len = strlen(cpumask);
+	}
+
+	bitmap_scnprintf(bm, nbits, cpus, sizeof(cpus));
+	strcpy(cpulist, cpus);
+
+free_bm:
+	free(bm);
+}
+
 int rm_rf_perf_data(const char *path)
 {
 	const char *pat[] = {
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 3423778e39a5..1572c8cf04e5 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -11,6 +11,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <linux/compiler.h>
+#include <linux/bitmap.h>
 #include <sys/types.h>
 #ifndef __cplusplus
 #include <internal/cpumap.h>
@@ -48,6 +49,8 @@ bool sysctl__nmi_watchdog_enabled(void);
 
 int perf_tip(char **strp, const char *dirpath);
 
+void cpumask_to_cpulist(char *cpumask, char *cpulist);
+
 #ifndef HAVE_SCHED_GETCPU_SUPPORT
 int sched_getcpu(void);
 #endif
-- 
2.43.0

