Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013010.outbound.protection.outlook.com [40.93.196.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3A232ED4D;
	Mon, 19 Jan 2026 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845706; cv=fail; b=SirWmudr5Myeserm1JTzoeb0NYc/nPZpiazpeo5ZPe5OL2huVx1wRVgkEUjrxVmI/gdd9JLT3LioeTadiTfwFMy6d0IOT3zEXyWdLAp4pzmVPerFEEPrGwEOP1Y/IpVoYYcQmO1oxEd062uc5+90QZBTqe87k9uyOvjCf9bfCZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845706; c=relaxed/simple;
	bh=PeRdMaljwzlhlagfKruHIpNwbDbkktifM970h0Gnbhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBf6AsYIPyrQsKbNgjLEJWUhdPBCG9Yqtp8aW3feNkRF7nLL8a9qFLvYeKJ/tX1TBCuZqZB+iZTGi9iWe/HZRtb8tiRSMqrCjeDWc5bQ3NzulBZnDlr3evqOsPBOi+zFRlTBFwh2Gn7NOQbfaBC9+Dct24tS0eGf53a9st16H70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PWkCYk0H; arc=fail smtp.client-ip=40.93.196.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PWkCYk0H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0J8mg5N0LKGt1iifi5CkI59DGF7d/M+EycZrHB3RRUppJNf18lTMLZ7qc35tWnozwJFtziBNLK1ZcWL27IULLhTRVygwoxkoWgUaFwAFtUCNOvEXDjpYYuENzltYC2sXEDe9wwKuqs86uT8n/vbC9wx3YiAQCP0SdXOCr97uc70nA2BqhJ9mMxpGYTRZwfhLjBjreACBvIgi0lIpzFORfc23uakwm0ku5ANV7Ym9Mbf5UFDAK+kGaaJDmelIjdTtPHqWzYYFadszLMaAndYCDBTrz6sMtHEw04mk1N5SNJjxV6O83u3RL5Idgzb6NQWIKaVMxIAEr5aWXG2WiouWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NhA3Rd2UmeUqV1FRQzMtu2mvrxdNkmFhhDTDghj+D8=;
 b=uTrMzAYwNnwK1Auy92ODy89+pJjTEoyhJMWCFH06golNdnzDX722/5tvX8Uw6Yekgy+o46y01I6C1PtSWTCPQSMY+Sj/ajgzM5vb2C2qIqFpWR76EwaYJaYEBn+PLEM4LxKhb7BXA/HGkcKsGoy0AlHbICbgymdjYCzjg51vysMLg2PMKYC2VkRa/nPCJ4u6tQYoWf23geMYA1NhMJR0PgZIfB5wFkYf2n+4uR1qN/Dt5hYaeS2sFXkDzkCW/mvoM2FGO/q6PZWug/YcgxTFFu4Yy4EWDRGV9DVYOIQkEKpuethNl1DzceT+76T6PJ9ASpav5uFZjWBKInaXDQYlVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NhA3Rd2UmeUqV1FRQzMtu2mvrxdNkmFhhDTDghj+D8=;
 b=PWkCYk0H32HCbTHct4t0Gfo8KtcR+Zt2yGhFjyhw4ultUucevZe9ryToIPspaEParpBavIlevM6ntaRu0lH+N0AI83SMF1y+MTvbU50SV1Z6rati6zzKXn0PGki6IcW6FUIu8EdCHvC9t7QLb6oX/kYndFg4AplgwPiXX92h5pA=
Received: from MN0PR05CA0019.namprd05.prod.outlook.com (2603:10b6:208:52c::26)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:01:32 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::42) by MN0PR05CA0019.outlook.office365.com
 (2603:10b6:208:52c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Mon,
 19 Jan 2026 18:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 18:01:30 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 12:01:19 -0600
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
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "James
 Clark" <james.clark@linaro.org>
Subject: [PATCH v5 06/10] perf sched stats: Add support for report subcommand
Date: Mon, 19 Jan 2026 17:58:28 +0000
Message-ID: <20260119175833.340369-7-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: da303346-d137-4ba9-bfad-08de5784c61f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tku1drr76rlPM/Nfz1Ci1X9zKwe8gIZ9RbkBqy4dkj34cYVzBd1o3J6H+cU3?=
 =?us-ascii?Q?1Xj3zpU95pfpm/bfp3k6PXe2ElDnZYLup9Cs5CFSqBeWZ/qyZtyWQWz5sGPj?=
 =?us-ascii?Q?kY3kwk+O8bA2qhJy4ZfAwDAfPaGv1KgtT3s5v1HFUqnZf/d6gg4VdGIth8h9?=
 =?us-ascii?Q?JfDN+k2trhRr7B2RHLyveiBI3dzspXv0AMmapSx3vsGzVdhCC+0Ti2eqCC5y?=
 =?us-ascii?Q?L6bWeUr7QzDUP+0ihocLSHMuUjcmS+tdJYjpVpKDTXKRJ84wzklGrRwg7Eno?=
 =?us-ascii?Q?nRnmfiwU7eSd9geefURsNhE/0wH8NZmP++TvBdZdDzIlZuBNTM31EGwoU/8X?=
 =?us-ascii?Q?OvR7USduDEjbLJEFGRUNqzSHLhISRgfU96gr1qj7UXIdXtWhxGlevybv0fMF?=
 =?us-ascii?Q?XLWizLYsMlEmfO//TAWtaYxSIjQRV518SmI7gPm3CJ3Q470VIsxsj2V1iTMR?=
 =?us-ascii?Q?LIy4z5WRhMp1kgMPwRzjr+a61tFC0aIL35iQ4BtkLcQZmus0sBck4Zim+3Ft?=
 =?us-ascii?Q?siIRm4jt4QmKiYMqTg8KtmZzSsGB93IxpjMK0IJCAhMXYZ/y1hkmwn3T3w/I?=
 =?us-ascii?Q?NB+73eIJjxdAdUwr3rDttJsX3iEh5WlCQaiAYuhJ7VToe/qAaAkfeAtzrTu+?=
 =?us-ascii?Q?9xIhYVfaTqTPGLKHjWMBPX6shLIQm9KGGDhsOTbzX+LR2bIbuKi9lbIgWoYu?=
 =?us-ascii?Q?mfLF67lBy0I50BrXnDC2YMRgrQ43LzwDTpmInmx5/pLMrUR9yKQCgAeUp837?=
 =?us-ascii?Q?OAualh1nawOVX/LvnXjY00xf0cNk9QJFwFIRLSxi5Qm0h32KolD5OdOv/98t?=
 =?us-ascii?Q?S82asMXj40gQjPp8xehT8Sfzl1q0oQD2+n5R8EnuIswOK74ANOcCYqg2Vr9x?=
 =?us-ascii?Q?+Wm+50R0nVvTpB+nTb1yhnmmWIEHEeqUov5N7C5xx0pz/qLuQLdKb1wFTOd5?=
 =?us-ascii?Q?VD7SLEtgeteGCLgntgE05Y89OOKor19GvzboqwLTjkBvW0ulYTU7rtaDZyo9?=
 =?us-ascii?Q?AQVeGgvkaKJ6GvQtbt8mpifORvMKLPXmqR89+uDAgLNudo3zgeodk9QVjCn3?=
 =?us-ascii?Q?yY/8KP1UdUE6qW35VnE6EBbUe/xSFMys5pMaFOAnJrvyTjLnXxf8gzZiKrwm?=
 =?us-ascii?Q?YtMM/eFJrQkyQ4N3/XzqjnUB+c/dKHTKn1ULvYnrt1XP7XlBNJmsF1w3LkrM?=
 =?us-ascii?Q?P70CGE6O7jMC4Z6/YY4k+L1S+NzihjWUXnqjF6KY4RKapG0sLhGmThqCpxRA?=
 =?us-ascii?Q?gw4YxGXRfg5/IaW6bbt9Z0IMsc5Qy2zw2oo9t3Y+IUa4XDbJ422nnBzscOHN?=
 =?us-ascii?Q?NMJlhJL0tpe9i8rvRmJ1XlAkuEDvgd8NjJLoivN+0tN6TaTzpr22JAFskrWA?=
 =?us-ascii?Q?BaesZlsf5tYAGDi2Qml+4FtlzOhX5MlZtP1/SIiOAC0kXprpgWx9DY/mcqlc?=
 =?us-ascii?Q?PIFRmbDtFEj7Rz332L4bKIIMzxoQVe7DkHIEuKvtpXz9nBlVBQi98WD976M4?=
 =?us-ascii?Q?WH/2JyftoYtga4Vc7sCNoRwjzxn/pXVZl8OX7v9mBpVjZpFOHZrelqOeMYBz?=
 =?us-ascii?Q?whZ7zH9w5mwxWWCzBTF8WbSBubujnE8usJQPrT/K+fzw5wIVbnwx66z8JIMw?=
 =?us-ascii?Q?IZeKXwjHZvvdfw6h9v/mPCWY6ggVYGs43S0nmbA0FZCUtC9S8FKJhBoD6WT7?=
 =?us-ascii?Q?pz5oMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:01:30.4005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da303346-d137-4ba9-bfad-08de5784c61f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040

`perf sched stats record` captures two sets of samples. For workload
profile, first set right before workload starts and second set after
workload finishes. For the systemwide profile, first set at the
beginning of profile and second set on receiving SIGINT signal.

Add `perf sched stats report` subcommand that will read both the set
of samples, get the diff and render a final report. Final report prints
scheduler stat at cpu granularity as well as sched domain granularity.

Example usage:
  # ./perf sched stats record -- true
  [ perf sched stats: Wrote samples to perf.data ]

  # perf sched stats report
  Description
  ----------------------------------------------------------------------------------------------------
  DESC                          -> Description of the field
  COUNT                         -> Value of the field
  PCT_CHANGE                    -> Percent change with corresponding base value
  AVG_JIFFIES                   -> Avg time in jiffies between two consecutive occurrence of event
  ----------------------------------------------------------------------------------------------------

  Time elapsed (in jiffies)                                        :           1
  ----------------------------------------------------------------------------------------------------
  CPU: <ALL CPUS SUMMARY>
  ----------------------------------------------------------------------------------------------------
  DESC                                                                     COUNT   PCT_CHANGE
  ----------------------------------------------------------------------------------------------------
  yld_count                                                        :           0
  array_exp                                                        :           0
  sched_count                                                      :           0
  sched_goidle                                                     :           0  (     0.00% )
  ttwu_count                                                       :           0
  ttwu_local                                                       :           0  (     0.00% )
  rq_cpu_time                                                      :       33525
  run_delay                                                        :         436  (     1.30% )
  pcount                                                           :           0
  ----------------------------------------------------------------------------------------------------
  CPU: <ALL CPUS SUMMARY> | DOMAIN: SMT
  ----------------------------------------------------------------------------------------------------
  DESC                                                                     COUNT    AVG_JIFFIES
  ----------------------------------------- <Category busy> ------------------------------------------
  busy_lb_count                                                    :           0  $        0.00 $
  busy_lb_balanced                                                 :           0  $        0.00 $
  busy_lb_failed                                                   :           0  $        0.00 $
  busy_lb_imbalance_load                                           :           0
  busy_lb_imbalance_util                                           :           0
  busy_lb_imbalance_task                                           :           0
  busy_lb_imbalance_misfit                                         :           0
  busy_lb_gained                                                   :           0
  busy_lb_hot_gained                                               :           0
  busy_lb_nobusyq                                                  :           0  $        0.00 $
  busy_lb_nobusyg                                                  :           0  $        0.00 $
  *busy_lb_success_count                                           :           0
  *busy_lb_avg_pulled                                              :        0.00

  ... and so on. Output shows similar data for all the cpus in the
system.

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 509 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/util.c     |   6 +
 tools/perf/util/util.h     |   2 +
 3 files changed, 515 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index ee3b4e42156e..c6b054b9b12a 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3929,6 +3929,503 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
 	return err;
 }
 
+struct schedstat_domain {
+	struct list_head domain_list;
+	struct perf_record_schedstat_domain *domain_data;
+};
+
+struct schedstat_cpu {
+	struct list_head cpu_list;
+	struct list_head domain_head;
+	struct perf_record_schedstat_cpu *cpu_data;
+};
+
+static struct list_head cpu_head = LIST_HEAD_INIT(cpu_head);
+static struct schedstat_cpu *cpu_second_pass;
+static struct schedstat_domain *domain_second_pass;
+static bool after_workload_flag;
+static bool verbose_field;
+
+static void store_schedtstat_cpu_diff(struct schedstat_cpu *after_workload)
+{
+	struct perf_record_schedstat_cpu *before = cpu_second_pass->cpu_data;
+	struct perf_record_schedstat_cpu *after = after_workload->cpu_data;
+	__u16 version = after_workload->cpu_data->version;
+
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)	\
+	(before->_ver._name = after->_ver._name - before->_ver._name)
+
+	if (version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
+	}
+
+#undef CPU_FIELD
+}
+
+static void store_schedstat_domain_diff(struct schedstat_domain *after_workload)
+{
+	struct perf_record_schedstat_domain *before = domain_second_pass->domain_data;
+	struct perf_record_schedstat_domain *after = after_workload->domain_data;
+	__u16 version = after_workload->domain_data->version;
+
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)	\
+	(before->_ver._name = after->_ver._name - before->_ver._name)
+
+	if (version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
+	}
+#undef DOMAIN_FIELD
+}
+
+static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs)
+{
+	printf("%-65s %12s %12s\n", "DESC", "COUNT", "PCT_CHANGE");
+	printf("%.*s\n", 100, graph_dotted_line);
+
+#define CALC_PCT(_x, _y)	((_y) ? ((double)(_x) / (_y)) * 100 : 0.0)
+
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
+	do {									\
+		printf("%-65s: " _format, verbose_field ? _desc : #_name,	\
+		       cs->_ver._name);						\
+		if (_is_pct) {							\
+			printf("  ( %8.2lf%% )",				\
+			       CALC_PCT(cs->_ver._name, cs->_ver._pct_of));	\
+		}								\
+		printf("\n");							\
+	} while (0)
+
+	if (cs->version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (cs->version == 16) {
+#include <perf/schedstat-v16.h>
+	} else if (cs->version == 17) {
+#include <perf/schedstat-v17.h>
+	}
+
+#undef CPU_FIELD
+#undef CALC_PCT
+}
+
+static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
+				      __u64 jiffies)
+{
+	printf("%-65s %12s %14s\n", "DESC", "COUNT", "AVG_JIFFIES");
+
+#define DOMAIN_CATEGORY(_desc)							\
+	do {									\
+		size_t _len = strlen(_desc);					\
+		size_t _pre_dash_cnt = (100 - _len) / 2;			\
+		size_t _post_dash_cnt = 100 - _len - _pre_dash_cnt;		\
+		print_separator2((int)_pre_dash_cnt, _desc, (int)_post_dash_cnt);\
+	} while (0)
+
+#define CALC_AVG(_x, _y)	((_y) ? (long double)(_x) / (_y) : 0.0)
+
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
+	do {									\
+		printf("%-65s: " _format, verbose_field ? _desc : #_name,	\
+		       ds->_ver._name);						\
+		if (_is_jiffies) {						\
+			printf("  $ %11.2Lf $",					\
+			       CALC_AVG(jiffies, ds->_ver._name));		\
+		}								\
+		printf("\n");							\
+	} while (0)
+
+#define DERIVED_CNT_FIELD(_name, _desc, _format, _x, _y, _z, _ver)		\
+	printf("*%-64s: " _format "\n", verbose_field ? _desc : #_name,		\
+	       (ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))
+
+#define DERIVED_AVG_FIELD(_name, _desc, _format, _x, _y, _z, _w, _ver)		\
+	printf("*%-64s: " _format "\n", verbose_field ? _desc : #_name,		\
+	       CALC_AVG(ds->_ver._w,						\
+			((ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))))
+
+	if (ds->version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (ds->version == 16) {
+#include <perf/schedstat-v16.h>
+	} else if (ds->version == 17) {
+#include <perf/schedstat-v17.h>
+	}
+
+#undef DERIVED_AVG_FIELD
+#undef DERIVED_CNT_FIELD
+#undef DOMAIN_FIELD
+#undef CALC_AVG
+#undef DOMAIN_CATEGORY
+}
+
+static void summarize_schedstat_cpu(struct schedstat_cpu *summary_cpu,
+				    struct schedstat_cpu *cptr,
+				    int cnt, bool is_last)
+{
+	struct perf_record_schedstat_cpu *summary_cs = summary_cpu->cpu_data,
+					 *temp_cs = cptr->cpu_data;
+
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
+	do {									\
+		summary_cs->_ver._name += temp_cs->_ver._name;			\
+		if (is_last)							\
+			summary_cs->_ver._name /= cnt;				\
+	} while (0)
+
+	if (cptr->cpu_data->version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (cptr->cpu_data->version == 16) {
+#include <perf/schedstat-v16.h>
+	} else if (cptr->cpu_data->version == 17) {
+#include <perf/schedstat-v17.h>
+	}
+#undef CPU_FIELD
+}
+
+static void summarize_schedstat_domain(struct schedstat_domain *summary_domain,
+				       struct schedstat_domain *dptr,
+				       int cnt, bool is_last)
+{
+	struct perf_record_schedstat_domain *summary_ds = summary_domain->domain_data,
+					    *temp_ds = dptr->domain_data;
+
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
+	do {									\
+		summary_ds->_ver._name += temp_ds->_ver._name;			\
+		if (is_last)							\
+			summary_ds->_ver._name /= cnt;				\
+	} while (0)
+
+	if (dptr->domain_data->version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (dptr->domain_data->version == 16) {
+#include <perf/schedstat-v16.h>
+	} else if (dptr->domain_data->version == 17) {
+#include <perf/schedstat-v17.h>
+	}
+#undef DOMAIN_FIELD
+}
+
+/*
+ * get_all_cpu_stats() appends the summary to the head of the list.
+ */
+static int get_all_cpu_stats(struct list_head *head)
+{
+	struct schedstat_cpu *cptr = list_first_entry(head, struct schedstat_cpu, cpu_list);
+	struct schedstat_cpu *summary_head = NULL;
+	struct perf_record_schedstat_domain *ds;
+	struct perf_record_schedstat_cpu *cs;
+	struct schedstat_domain *dptr, *tdptr;
+	bool is_last = false;
+	int cnt = 1;
+	int ret = 0;
+
+	if (cptr) {
+		summary_head = zalloc(sizeof(*summary_head));
+		if (!summary_head)
+			return -ENOMEM;
+
+		summary_head->cpu_data = zalloc(sizeof(*cs));
+		memcpy(summary_head->cpu_data, cptr->cpu_data, sizeof(*cs));
+
+		INIT_LIST_HEAD(&summary_head->domain_head);
+
+		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
+			tdptr = zalloc(sizeof(*tdptr));
+			if (!tdptr)
+				return -ENOMEM;
+
+			tdptr->domain_data = zalloc(sizeof(*ds));
+			if (!tdptr->domain_data)
+				return -ENOMEM;
+
+			memcpy(tdptr->domain_data, dptr->domain_data, sizeof(*ds));
+			list_add_tail(&tdptr->domain_list, &summary_head->domain_head);
+		}
+	}
+
+	list_for_each_entry(cptr, head, cpu_list) {
+		if (list_is_first(&cptr->cpu_list, head))
+			continue;
+
+		if (list_is_last(&cptr->cpu_list, head))
+			is_last = true;
+
+		cnt++;
+		summarize_schedstat_cpu(summary_head, cptr, cnt, is_last);
+		tdptr = list_first_entry(&summary_head->domain_head, struct schedstat_domain,
+					 domain_list);
+
+		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
+			summarize_schedstat_domain(tdptr, dptr, cnt, is_last);
+			tdptr = list_next_entry(tdptr, domain_list);
+		}
+	}
+
+	list_add(&summary_head->cpu_list, head);
+	return ret;
+}
+
+static int show_schedstat_data(struct list_head *head, struct cpu_domain_map **cd_map)
+{
+	struct schedstat_cpu *cptr = list_first_entry(head, struct schedstat_cpu, cpu_list);
+	__u64 jiffies = cptr->cpu_data->timestamp;
+	struct perf_record_schedstat_domain *ds;
+	struct perf_record_schedstat_cpu *cs;
+	struct schedstat_domain *dptr;
+	bool is_summary = true;
+	int ret = 0;
+
+	printf("Description\n");
+	print_separator2(100, "", 0);
+	printf("%-30s-> %s\n", "DESC", "Description of the field");
+	printf("%-30s-> %s\n", "COUNT", "Value of the field");
+	printf("%-30s-> %s\n", "PCT_CHANGE", "Percent change with corresponding base value");
+	printf("%-30s-> %s\n", "AVG_JIFFIES",
+	       "Avg time in jiffies between two consecutive occurrence of event");
+
+	print_separator2(100, "", 0);
+	printf("\n");
+
+	printf("%-65s: %11llu\n", "Time elapsed (in jiffies)", jiffies);
+
+	ret = get_all_cpu_stats(head);
+
+	list_for_each_entry(cptr, head, cpu_list) {
+		cs = cptr->cpu_data;
+		print_separator2(100, "", 0);
+
+		if (is_summary)
+			printf("CPU: <ALL CPUS SUMMARY>\n");
+		else
+			printf("CPU: %d\n", cs->cpu);
+
+		print_separator2(100, "", 0);
+		print_cpu_stats(cs);
+		print_separator2(100, "", 0);
+
+		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
+			struct domain_info *dinfo;
+
+			ds = dptr->domain_data;
+			dinfo = cd_map[ds->cpu]->domains[ds->domain];
+			if (is_summary) {
+				if (dinfo->dname)
+					printf("CPU: <ALL CPUS SUMMARY> | DOMAIN: %s\n",
+					       dinfo->dname);
+				else
+					printf("CPU: <ALL CPUS SUMMARY> | DOMAIN: %d\n",
+					       dinfo->domain);
+			} else {
+				if (dinfo->dname)
+					printf("CPU: %d | DOMAIN: %s | DOMAIN_CPUS: ",
+					       cs->cpu, dinfo->dname);
+				else
+					printf("CPU: %d | DOMAIN: %d | DOMAIN_CPUS: ",
+					       cs->cpu, dinfo->domain);
+
+				printf("%s\n", dinfo->cpulist);
+			}
+			print_separator2(100, "", 0);
+			print_domain_stats(ds, jiffies);
+			print_separator2(100, "", 0);
+		}
+		is_summary = false;
+	}
+	return ret;
+}
+
+/*
+ * Creates a linked list of cpu_data and domain_data. Below represents the structure of the linked
+ * list where CPU0,CPU1,CPU2, ..., CPU(N-1) stores the cpu_data. Here N is the total number of cpus.
+ * Each of the CPU points to the list of domain_data. Here DOMAIN0, DOMAIN1, DOMAIN2, ... represents
+ * the domain_data. Here D0, D1, D2, ..., Dm are the number of domains in the respective cpus.
+ *
+ *	+----------+
+ *	| CPU_HEAD |
+ *	+----------+
+ *	      |
+ *	      v
+ *	+----------+    +---------+    +---------+    +---------+	    +--------------+
+ *	|   CPU0   | -> | DOMAIN0 | -> | DOMAIN1 | -> | DOMAIN2 | -> ... -> | DOMAIN(D0-1) |
+ *	+----------+    +---------+    +---------+    +---------+           +--------------+
+ *	      |
+ *	      v
+ *	+----------+    +---------+    +---------+    +---------+           +--------------+
+ *	|   CPU1   | -> | DOMAIN0 | -> | DOMAIN1 | -> | DOMAIN2 | -> ... -> | DOMAIN(D1-1) |
+ *	+----------+    +---------+    +---------+    +---------+           +--------------+
+ *	      |
+ *	      v
+ *	+----------+    +---------+    +---------+    +---------+           +--------------+
+ *	|   CPU2   | -> | DOMAIN0 | -> | DOMAIN1 | -> | DOMAIN2 | -> ... -> | DOMAIN(D2-1) |
+ *	+----------+    +---------+    +---------+    +---------+           +--------------+
+ *	      |
+ *	      v
+ *	     ...
+ *	      |
+ *	      v
+ *	+----------+    +---------+    +---------+    +---------+           +--------------+
+ *	| CPU(N-1) | -> | DOMAIN0 | -> | DOMAIN1 | -> | DOMAIN2 | -> ... -> | DOMAIN(Dm-1) |
+ *	+----------+    +---------+    +---------+    +---------+           +--------------+
+ *
+ * Each cpu as well as domain has 2 enties in the event list one before the workload starts and
+ * other after completion of the workload. The above linked list stores the diff of the cpu and
+ * domain statistics.
+ */
+static int perf_sched__process_schedstat(const struct perf_tool *tool __maybe_unused,
+					 struct perf_session *session __maybe_unused,
+					 union perf_event *event)
+{
+	struct perf_cpu this_cpu;
+	static __u32 initial_cpu;
+
+	switch (event->header.type) {
+	case PERF_RECORD_SCHEDSTAT_CPU:
+		this_cpu.cpu = event->schedstat_cpu.cpu;
+		break;
+	case PERF_RECORD_SCHEDSTAT_DOMAIN:
+		this_cpu.cpu = event->schedstat_domain.cpu;
+		break;
+	default:
+		return 0;
+	}
+
+	if (user_requested_cpus && !perf_cpu_map__has(user_requested_cpus, this_cpu))
+		return 0;
+
+	if (event->header.type == PERF_RECORD_SCHEDSTAT_CPU) {
+		struct schedstat_cpu *temp = zalloc(sizeof(*temp));
+
+		if (!temp)
+			return -ENOMEM;
+
+		temp->cpu_data = zalloc(sizeof(*temp->cpu_data));
+		if (!temp->cpu_data)
+			return -ENOMEM;
+
+		memcpy(temp->cpu_data, &event->schedstat_cpu, sizeof(*temp->cpu_data));
+
+		if (!list_empty(&cpu_head) && temp->cpu_data->cpu == initial_cpu)
+			after_workload_flag = true;
+
+		if (!after_workload_flag) {
+			if (list_empty(&cpu_head))
+				initial_cpu = temp->cpu_data->cpu;
+
+			list_add_tail(&temp->cpu_list, &cpu_head);
+			INIT_LIST_HEAD(&temp->domain_head);
+		} else {
+			if (temp->cpu_data->cpu == initial_cpu) {
+				cpu_second_pass = list_first_entry(&cpu_head, struct schedstat_cpu,
+								   cpu_list);
+				cpu_second_pass->cpu_data->timestamp =
+					temp->cpu_data->timestamp - cpu_second_pass->cpu_data->timestamp;
+			} else {
+				cpu_second_pass = list_next_entry(cpu_second_pass, cpu_list);
+			}
+			domain_second_pass = list_first_entry(&cpu_second_pass->domain_head,
+							      struct schedstat_domain, domain_list);
+			store_schedtstat_cpu_diff(temp);
+		}
+	} else if (event->header.type == PERF_RECORD_SCHEDSTAT_DOMAIN) {
+		struct schedstat_cpu *cpu_tail;
+		struct schedstat_domain *temp = zalloc(sizeof(*temp));
+
+		if (!temp)
+			return -ENOMEM;
+
+		temp->domain_data = zalloc(sizeof(*temp->domain_data));
+		if (!temp->domain_data)
+			return -ENOMEM;
+
+		memcpy(temp->domain_data, &event->schedstat_domain, sizeof(*temp->domain_data));
+
+		if (!after_workload_flag) {
+			cpu_tail = list_last_entry(&cpu_head, struct schedstat_cpu, cpu_list);
+			list_add_tail(&temp->domain_list, &cpu_tail->domain_head);
+		} else {
+			store_schedstat_domain_diff(temp);
+			domain_second_pass = list_next_entry(domain_second_pass, domain_list);
+		}
+	}
+
+	return 0;
+}
+
+static void free_schedstat(struct list_head *head)
+{
+	struct schedstat_domain *dptr, *n1;
+	struct schedstat_cpu *cptr, *n2;
+
+	list_for_each_entry_safe(cptr, n2, head, cpu_list) {
+		list_for_each_entry_safe(dptr, n1, &cptr->domain_head, domain_list) {
+			list_del_init(&dptr->domain_list);
+			free(dptr);
+		}
+		list_del_init(&cptr->cpu_list);
+		free(cptr);
+	}
+}
+
+static int perf_sched__schedstat_report(struct perf_sched *sched)
+{
+	struct cpu_domain_map **cd_map;
+	struct perf_session *session;
+	struct target target = {};
+	struct perf_data data = {
+		.path  = input_name,
+		.mode  = PERF_DATA_MODE_READ,
+	};
+	int err = 0;
+
+	sched->tool.schedstat_cpu = perf_sched__process_schedstat;
+	sched->tool.schedstat_domain = perf_sched__process_schedstat;
+
+	session = perf_session__new(&data, &sched->tool);
+	if (IS_ERR(session)) {
+		pr_err("Perf session creation failed.\n");
+		return PTR_ERR(session);
+	}
+
+	if (cpu_list)
+		target.cpu_list = cpu_list;
+	else
+		target.system_wide = true;
+
+	err = evlist__create_maps(session->evlist, &target);
+	if (err < 0)
+		goto out;
+
+	user_requested_cpus = session->evlist->core.user_requested_cpus;
+
+	err = perf_session__process_events(session);
+
+	if (!err) {
+		setup_pager();
+
+		if (list_empty(&cpu_head)) {
+			pr_err("Data is not available\n");
+			err = -1;
+			goto out;
+		}
+
+		cd_map = session->header.env.cpu_domain;
+		err = show_schedstat_data(&cpu_head, cd_map);
+	}
+
+out:
+	free_schedstat(&cpu_head);
+	perf_session__delete(session);
+	return err;
+}
+
 static bool schedstat_events_exposed(void)
 {
 	/*
@@ -4106,9 +4603,12 @@ int cmd_sched(int argc, const char **argv)
 	OPT_PARENT(sched_options)
 	};
 	const struct option stats_options[] = {
+	OPT_STRING('i', "input", &input_name, "file",
+		   "`stats report` with input filename"),
 	OPT_STRING('o', "output", &output_name, "file",
 		   "`stats record` with output filename"),
 	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
+	OPT_BOOLEAN('v', "verbose", &verbose_field, "Show explanation for fields in the report"),
 	OPT_END()
 	};
 
@@ -4129,7 +4629,7 @@ int cmd_sched(int argc, const char **argv)
 		NULL
 	};
 	const char *stats_usage[] = {
-		"perf sched stats {record} [<options>]",
+		"perf sched stats {record|report} [<options>]",
 		NULL
 	};
 	const char *const sched_subcommands[] = { "record", "latency", "map",
@@ -4233,7 +4733,7 @@ int cmd_sched(int argc, const char **argv)
 		if (!ret)
 			ret = perf_sched__timehist(&sched);
 	} else if (!strcmp(argv[0], "stats")) {
-		const char *const stats_subcommands[] = {"record", NULL};
+		const char *const stats_subcommands[] = {"record", "report", NULL};
 
 		argc = parse_options_subcommand(argc, argv, stats_options,
 						stats_subcommands,
@@ -4245,6 +4745,11 @@ int cmd_sched(int argc, const char **argv)
 				argc = parse_options(argc, argv, stats_options,
 						     stats_usage, 0);
 			return perf_sched__schedstat_record(&sched, argc, argv);
+		} else if (argv[0] && !strcmp(argv[0], "report")) {
+			if (argc)
+				argc = parse_options(argc, argv, stats_options,
+						     stats_usage, 0);
+			return perf_sched__schedstat_report(&sched);
 		}
 		usage_with_options(stats_usage, stats_options);
 	} else {
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index b87ff96a9f45..03a603fbcd7d 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -299,6 +299,12 @@ void cpumask_to_cpulist(char *cpumask, char *cpulist)
 	free(bm);
 }
 
+void print_separator2(int pre_dash_cnt, const char *s, int post_dash_cnt)
+{
+	printf("%.*s%s%.*s\n", pre_dash_cnt, graph_dotted_line, s, post_dash_cnt,
+	       graph_dotted_line);
+}
+
 int rm_rf_perf_data(const char *path)
 {
 	const char *pat[] = {
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 1572c8cf04e5..394dbfa944ac 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -51,6 +51,8 @@ int perf_tip(char **strp, const char *dirpath);
 
 void cpumask_to_cpulist(char *cpumask, char *cpulist);
 
+void print_separator2(int pre_dash_cnt, const char *s, int post_dash_cnt);
+
 #ifndef HAVE_SCHED_GETCPU_SUPPORT
 int sched_getcpu(void);
 #endif
-- 
2.43.0

