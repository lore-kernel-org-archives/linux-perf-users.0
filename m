Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0C6322A24;
	Tue,  9 Sep 2025 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418295; cv=fail; b=n/YRxf/mf/V9oxARNJ88ccWirQm2aktFjB21HkJHARBcap6RnKuPKVYG7rdzbbU99PB8DbZjE/iAowPsC6ggm4zE9mohhgymAY6Na07cDLfvEOog+As0jtaNq3vEr6C0ba/IQKrqoUk9hzDb2DCtRt7BmkTgLEZs7ACUSye8lJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418295; c=relaxed/simple;
	bh=1+ANFpvIuB4o8yvFmqbOysPnpO72yAuXpCJ1n1mCI3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0X4pH0IB+rqDJP77deF3sK0nEGcpsk5pBhxACu7iVC4FJsYxVABa9S6c/ThvGtYKNojgHAMXsy0WAfj4oYnhdoxyldJ7t+3DSfSxozXA+JDTW0c7D42YgRx8OcES9HDmW9WrHnismdfYFUwYMpL7cUUevxh/DoAir1uQhVHOuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f/fj7OSk; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f/fj7OSk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNlEQUxAA4lbwiFOHYhMSOeNPgBdQ7ftrKwqQKgHEnxAHivvmXHJyVUgnd+asvHQ45VOcDT9R6yj/BP8ZKoyHIcA8A6HngRB8wuk+LWZNcC7u8mbmv+TbC07AVmtIMSEkwV8DMalYqVaFyBQUgYre3+GRX6kYTPZhK7a3BU1R9z/kJIERdQRYEwGvESzb+I9nRstKwwZCyarlWvzINgtybc5sx1jzAa8uCtTNMdZBGvwx/J37YlIGevLPBgnYQSWsrupGiKdXrTPR0CGSRuqAzCYeYdxpP8JJ7TfFxsv67wvs2smIxf7APaL67Iubo0211yl+aGVFFKMfG08I+Ajdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdSL6U44+iS0ue4w0nTq3wWn8hG8Yx9AbTL5vxaLpbQ=;
 b=VE/pbb5BGtWwNwild7I4eTU+eGXVSroifE2gcsU0OuZDAqQwzLElpU8/uqyP4pi6y67hufM3ng3/syue4iCX1Q+tvqflWbpcXL9f1xYzJYfdqHQ+6KmGkgdiyEEvRsSWPcK/JbprSQECPHyxQE8WwZpyINarON86xAr6oQL85/SWnEV0MThHYKJ4Ppqew1N5DUPFdFmd1d/kn0/x67Pf3lY+Iu5p1tbmEjlQADsQykWCqep70x5/UBlGuj+GBi2TH23rSG8/u5vRZ0bCoXb6+hvNykrg5WusZ48qlkUwJdHGUd9bdF73iUIBm4LCNR8SIZxvwjoc8lFkpibniSco5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdSL6U44+iS0ue4w0nTq3wWn8hG8Yx9AbTL5vxaLpbQ=;
 b=f/fj7OSkXZspTO1VVW+92IQulyW3zvQ3fSmYmo+f8sJyXAqq17Fvqi886Kgbq07Y033gYmJqi4y3ga6g8gFHpKS6d06zCqzND5oIpQRSQ6akKkWIp7NjGZoz8Z8mtRMFXLgLeGHRWxek5jklLOvQdZ0ctulwL3NLUw1ZeP4qBkQ=
Received: from CH0PR13CA0031.namprd13.prod.outlook.com (2603:10b6:610:b2::6)
 by SJ5PPF6785369A4.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::997) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:44:49 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::9f) by CH0PR13CA0031.outlook.office365.com
 (2603:10b6:610:b2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.9 via Frontend Transport; Tue, 9
 Sep 2025 11:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 11:44:48 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 04:44:36 -0700
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
Subject: [PATCH RESEND v4 03/11] perf header: Support CPU DOMAIN relation info
Date: Tue, 9 Sep 2025 11:42:19 +0000
Message-ID: <20250909114227.58802-4-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|SJ5PPF6785369A4:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d30d0a-0d6e-47ce-f1ab-08ddef96480d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KcNJlC4hwWjQU9ZwD/ecemo3y12EdJJ8AUt7n8bMUwOd8cfVcYj/RqtRCEwV?=
 =?us-ascii?Q?hLblneaO1D/131zneer5iz9pc/fpTej/k+sDlFwKZ0SYR84PyRD116b2Aqp7?=
 =?us-ascii?Q?qk2m6FmbDbQDeVRalo4gPOTtGpah8GXzX8uOrp0E8M12t8uGFFtoky4DwEq9?=
 =?us-ascii?Q?HAzS2BBAVTMEaayTAEvMZ/X4uLGrl0XHDoZD1yNMlZcK7mFI8rK3naKkp9WA?=
 =?us-ascii?Q?5bLRpJpPXV9dTIBRKRAqyYt3N7TwIr01DWEJTm3ApiI9NuT00KYFKr/pYCaF?=
 =?us-ascii?Q?+FTPLIX2+8B+cktNdR8Sanh75eF5TLk4jrcJWrRBX580cffakWoDUQpv3IZU?=
 =?us-ascii?Q?LMv+ysjR3109dyjJuTpH6rG/8yqx4NNhcTO9sH/TwXPc15iEizgZMIJB2Dzf?=
 =?us-ascii?Q?o3ALjjyYi0VT+kK1ItJ/OPeH7HphFx8xK92ScsNWTSnXcJJEqAX3zPJ2r7o0?=
 =?us-ascii?Q?MpQmqTqDkg6lk1hYz460xDaJ6eUexp56QBZM0C5z73k1at6k5DwtU33bFYzx?=
 =?us-ascii?Q?ehBouBbsrugvY+aLuNs+iga8NrLao3OM2qoOG2fiZ7VmfyKKDL7pjlQsIBC5?=
 =?us-ascii?Q?VME8bN3RYKq7Nq2+RfIrxupPXmXYpIDLDS76l2GAICUog09raMbOv95uXy4r?=
 =?us-ascii?Q?swd+eG7swPY3xpTA7XdGQ+UwhODIPRoaDTQO1xKzxyeJTigXDu2fLJh+Hiey?=
 =?us-ascii?Q?jnY6wi8OuTpOvUbkjmZ76+KSw3Uh87cAKwHn39ufHcUnuBKF5pgXB/uLnGkG?=
 =?us-ascii?Q?eLolSoaG5YZ7w9KcsPaHLbOb8P+5bi7CIWiojxUo4kxOVELu5pXwaup06Avz?=
 =?us-ascii?Q?6Gxtn73jjPigG9RWvJ0k4ryZCPKJ5YIpFOJXNWGquIJOKAA4dv31Yu0RIswM?=
 =?us-ascii?Q?va2fOhdu1RVIkBXvyjsoR8rRVFOC08rmtyUH7oFFIKdkBRKUJ14e7bIoVpCr?=
 =?us-ascii?Q?hIZmlKKrhoCkpn92C9Pq/zJ2qHCa3+FBGlHkctIJko4aCXNKjyvsrAaxeNRc?=
 =?us-ascii?Q?IRfGeY3QIVKvqO5JvmT/7tHIyZsL4jP/nGsvVM7iZzf/mgEvdf6XKFiKlo5K?=
 =?us-ascii?Q?/wOjeorz94/qOKUfzZXsjAgpkg2KpN9oU5rk/WELK4JqEYxwziLyoQjh/ztX?=
 =?us-ascii?Q?X45/6233XGmzHkRDV6Rn7gSlLsth16prNFP8H27x2bb9GpdM9ze3Fh4quzw1?=
 =?us-ascii?Q?JseW1E5GWWinvNg/VPK0kTtF5vTp+KIi5dCu9LMa5SmdX1f8MwlvhVjaXkk1?=
 =?us-ascii?Q?wb1/ZCD5OahyXuj+a+AKJ7p4LSnEO4atsFGLF5RUypyPjS4c8Rwq4ChBJkvn?=
 =?us-ascii?Q?r5BMa3oaV4c2cgxog5CueHHwdnJxsT61ZKzDn4uZFJ3g3f7oSf5O4yM1czbt?=
 =?us-ascii?Q?iRKKwnPxamW6bYxPfoMTfcSwJiXx+rd55PwmR2zCiJo6ocpGxG5vmA9e858m?=
 =?us-ascii?Q?yWeMmFFqR3xjia/pr5VrdUJNTASCFdRB5k6RtuKR1GXcfCQiXO0B7gX/A7Ki?=
 =?us-ascii?Q?1H1tbKqJLShwdCuwgH8yXG9SYUPCYebyG6rz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:44:48.8940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d30d0a-0d6e-47ce-f1ab-08ddef96480d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6785369A4

'/proc/schedstat' gives the info about load balancing statistics within
a given domain. It also contains the cpu_mask giving information about
the sibling cpus and domain names after schedstat version 17. Storing
this information in perf header will help tools like `perf sched stats`
for better analysis.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 .../Documentation/perf.data-file-format.txt   |  17 +
 tools/perf/builtin-inject.c                   |   1 +
 tools/perf/util/env.h                         |  16 +
 tools/perf/util/header.c                      | 304 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/util.c                        |  42 +++
 tools/perf/util/util.h                        |   3 +
 7 files changed, 384 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index cd95ba09f727..92dbba1003cf 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -437,6 +437,23 @@ struct {
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
index a114b3fa1bea..f43a7ec44b5f 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2058,6 +2058,7 @@ static bool keep_feat(int feat)
 	case HEADER_CLOCK_DATA:
 	case HEADER_HYBRID_TOPOLOGY:
 	case HEADER_PMU_CAPS:
+	case HEADER_CPU_DOMAIN_INFO:
 		return true;
 	/* Information that can be updated */
 	case HEADER_BUILD_ID:
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index e00179787a34..71034c4b4488 100644
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
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4f2a6e10ed5c..7ff7434bac2c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1621,6 +1621,184 @@ static int write_pmu_caps(struct feat_fd *ff,
 	return 0;
 }
 
+static void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version, u32 nr)
+{
+	for (u32 i = 0; i < nr; i++) {
+		if (cd_map[i]->domains) {
+			for (u32 j = 0; j < cd_map[i]->nr_domains; j++) {
+				struct domain_info *d_info = cd_map[i]->domains[j];
+
+				if (schedstat_version >= 17)
+					free(d_info->dname);
+
+				free(d_info->cpumask);
+				free(d_info->cpulist);
+			}
+			free(cd_map[i]->domains);
+		}
+	}
+
+	free(cd_map);
+}
+
+static struct cpu_domain_map  **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains,
+						     u32 nr)
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
+	cd_map = calloc(nr, sizeof(*cd_map));
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
+				cd_map[cpu] = calloc(1, sizeof(*cd_map[cpu]));
+				if (!cd_map[cpu])
+					goto out_free_line;
+				cd_map[cpu]->cpu = cpu;
+			} else
+				continue;
+
+			dcount = 0;
+		} else if (strncmp(line, "domain", 6) == 0) {
+			dcount++;
+
+			cd_map[cpu]->domains = realloc(cd_map[cpu]->domains,
+						       dcount * sizeof(domain_info));
+			if (!cd_map[cpu]->domains)
+				goto out_free_line;
+
+			domain_info = calloc(1, sizeof(*domain_info));
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
+				domain_info->dname = calloc(strlen(dname) + 1, sizeof(char));
+				if (!domain_info->dname)
+					goto out_free_line;
+
+				strcpy(domain_info->dname, dname);
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
+			domain_info->cpumask = calloc(strlen(cpumask) + 1, sizeof(char));
+			if (!domain_info->cpumask)
+				goto out_free_line;
+
+			strcpy(domain_info->cpumask, cpumask);
+
+			cpumask_to_cpulist(cpumask, cpulist);
+			domain_info->cpulist = calloc(strlen(cpulist) + 1, sizeof(char));
+			if (!domain_info->cpulist)
+				goto out_free_line;
+
+			strcpy(domain_info->cpulist, cpulist);
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
+		if (cd_map[i]->domains) {
+			ret = do_write(ff, &cd_map[i]->cpu, sizeof(u32));
+			if (ret < 0)
+				goto out;
+
+			ret = do_write(ff, &cd_map[i]->nr_domains, sizeof(u32));
+			if (ret < 0)
+				goto out;
+
+			for (j = 0; j < cd_map[i]->nr_domains; j++) {
+				ret = do_write(ff, &cd_map[i]->domains[j]->domain, sizeof(u32));
+				if (ret < 0)
+					goto out;
+				if (schedstat_version >= 17) {
+					ret = do_write_string(ff, cd_map[i]->domains[j]->dname);
+					if (ret < 0)
+						goto out;
+				}
+
+				ret = do_write_string(ff, cd_map[i]->domains[j]->cpumask);
+				if (ret < 0)
+					goto out;
+
+				ret = do_write_string(ff, cd_map[i]->domains[j]->cpulist);
+				if (ret < 0)
+					goto out;
+			}
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
@@ -2254,6 +2432,35 @@ static void print_mem_topology(struct feat_fd *ff, FILE *fp)
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
+		if (cd_map[i]->domains) {
+			fprintf(fp, "# cpu		: %u\n", cd_map[i]->cpu);
+			fprintf(fp, "# nr_domains	: %u\n", cd_map[i]->nr_domains);
+
+			for (j = 0; j < cd_map[i]->nr_domains; j++) {
+				d_info = cd_map[i]->domains[j];
+				fprintf(fp, "# Domain		: %u\n", d_info->domain);
+
+				if (ff->ph->env.schedstat_version >= 17)
+					fprintf(fp, "# Domain name      : %s\n", d_info->dname);
+
+				fprintf(fp, "# Domain cpu map   : %s\n", d_info->cpumask);
+				fprintf(fp, "# Domain cpu list  : %s\n", d_info->cpulist);
+			}
+		}
+	}
+}
+
 static int __event_process_build_id(struct perf_record_header_build_id *bev,
 				    char *filename,
 				    struct perf_session *session)
@@ -3395,6 +3602,102 @@ static int process_pmu_caps(struct feat_fd *ff, void *data __maybe_unused)
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
+	cd_map = calloc(nra, sizeof(*cd_map));
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
+		cd_map[cpu] = calloc(1, sizeof(*cd_map[cpu]));
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
+		cd_map[cpu]->domains = calloc(max_sched_domains, sizeof(*d_info));
+		if (!cd_map[cpu]->domains)
+			return -1;
+
+		for (j = 0; j < nr_domains; j++) {
+			if (do_read_u32(ff, &domain))
+				return -1;
+
+			d_info = calloc(1, sizeof(*d_info));
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
+				d_info->dname = calloc(strlen(dname) + 1, sizeof(char));
+				if (!d_info->dname)
+					return -1;
+
+				strcpy(d_info->dname, dname);
+			}
+
+			cpumask = do_read_string(ff);
+			if (!cpumask)
+				return -1;
+
+			d_info->cpumask = calloc(strlen(cpumask) + 1, sizeof(char));
+			if (!d_info->cpumask)
+				return -1;
+			strcpy(d_info->cpumask, cpumask);
+
+			cpulist = do_read_string(ff);
+			if (!cpulist)
+				return -1;
+
+			d_info->cpulist = calloc(strlen(cpulist) + 1, sizeof(char));
+			if (!d_info->cpulist)
+				return -1;
+			strcpy(d_info->cpulist, cpulist);
+		}
+	}
+
+	return ret;
+}
+
 #define FEAT_OPR(n, func, __full_only) \
 	[HEADER_##n] = {					\
 		.name	    = __stringify(n),			\
@@ -3460,6 +3763,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
 	FEAT_OPN(HYBRID_TOPOLOGY,	hybrid_topology,	true),
 	FEAT_OPR(PMU_CAPS,	pmu_caps,	false),
+	FEAT_OPR(CPU_DOMAIN_INFO,	cpu_domain_info,	true),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index d16dfceccd74..edcb95e0dc49 100644
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
index 1b91834e11de..47bfc0259b0e 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -263,6 +263,48 @@ void print_separator(int pre_dash_cnt, const char *s, int post_dash_cnt)
 	       graph_dotted_line);
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
+		blk[len] = '\0';
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
index de69384380c2..90a8b4d2e59c 100644
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
@@ -50,6 +51,8 @@ int perf_tip(char **strp, const char *dirpath);
 
 void print_separator(int pre_dash_cnt, const char *s, int post_dash_cnt);
 
+void cpumask_to_cpulist(char *cpumask, char *cpulist);
+
 #ifndef HAVE_SCHED_GETCPU_SUPPORT
 int sched_getcpu(void);
 #endif
-- 
2.43.0

