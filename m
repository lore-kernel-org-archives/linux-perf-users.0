Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741793A1C9;
	Tue,  9 Sep 2025 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418405; cv=fail; b=R6VPuD2MObNI8vAgVMzbPDjkmqi0q8QTYIYhSqiLwaWrUdl/11Q5Esblj/+iHI5yuzLhkBN2ESdVSuKDXJJnkpeTy9xuIKcdZFD22o2yaNfyY2Sulv9+CVBFfF4NjcxBbyVmvQy8oEIxrPHWfO8pRC8M6Tpdz0RhTDHf8HHX3ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418405; c=relaxed/simple;
	bh=re5aark05SAWAjeVlSOp0aljB8igxjdDGEL8eDhq6OI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XT47dduQxd828bttj1pKzyb+Wzg5H1FPlXqL4QIf5T2l++sis1Eac4cE69iHo1PRjFiaP2mjCleLvbAbyP2w2qTu7e4jk+WAY0In5d6XLTQIt8HGL2vWzYX5FXOxVu4xA4wqZrn9MuhWTC3Rcmmq2UpPq8sNLJ2BxEBFjuyD2pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=48gNy20U; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="48gNy20U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvzgmjGsMkxasFTks9mh1xmTfIvkb+vOs7TaAC0H4IAkYGW0p0LgN+s/2HY+5nL0YCMLJiESLdp2dJvhGcBTQhQQ2khHplPziXlCgqMD/ofSs+QwwB3wOxq0VCENW4XuSij8eLkzT/HzeUU8MwF67QYjjv3Xf2Wq0XzyLWbZUfB0E2EKt1ZvDqaai9ZDZkuNwnbyaHKrPX/i7c9dgn0BnJGARtnfOB/fFI+RvT+3xO7JcA/ED4CgFWlw5e/z5ub5T10zroq9ACJoA+TWtnlUfx0xNk41xSpHXYdYKVfkHim7fiXW0GnuiQOht3F3PovvxEoX/XtLnAjWLUVGs9bMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZDLb27WQGUgDzCconJAK6S8FtNNRDhGSDwyXo4oPCM=;
 b=T8djaWsmeE3FnUSSt0Bj8A7BUljPrgyW7WHYlPTWPhchKAcMHEfUhppZX9JWUq+pCDpLbHorGDgQxCHR1xHUTcpx3ajMyoqzKIKDb8am5DckGRBhHV+uhlS3uPx3114UFxGGlO9zC9mUT3fDloYloP8iIV/+nWJwmbdeKopqca44py/o5BeYRoGL4O5E82Kzc40KpZVcLQqTiDdflGLFNlhGKcOkyhaUUmeO8BJuH/lKSA/TzhVOfBVV6ASg3KnahAb0Wc+F5QU+gGX/RcDrnEw2B6uU5Z0FpEQPB04rdX15ulhAaBy7QCvQdhslhgpJgYSBS6VRNJDFvDO6iLzjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZDLb27WQGUgDzCconJAK6S8FtNNRDhGSDwyXo4oPCM=;
 b=48gNy20UxssRHeuMimPdYRxfFXFjGT7JIVtP3bnkfCnUn70RQ33GihzVR9cNwTOKIx6rODg60tUumMTeWmI3oy02qAjBw1HTtkUJ2JyeZh2YZ649WY2dybZ994xbZbPSffo5ycSG/5peh2m+CTnZ3U1Y0yPoUAx5HFpxhgBzJoA=
Received: from SJ0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:a03:33e::13)
 by SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:46:37 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:33e:cafe::2e) by SJ0PR03CA0038.outlook.office365.com
 (2603:10b6:a03:33e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 11:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Tue, 9 Sep 2025 11:46:37 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 04:46:24 -0700
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
Subject: [PATCH RESEND v4 07/11] perf sched stats: Add support for report subcommand
Date: Tue, 9 Sep 2025 11:42:23 +0000
Message-ID: <20250909114227.58802-8-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 11070c80-ebeb-4067-5b43-08ddef9688d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s3VDa5sJ7Ue/372w/eKGpGf2iAv5QU1nHpMYk/rKRWYBYsR00nGGDAFhOEQx?=
 =?us-ascii?Q?Oq59hqWVkeRmp6j9KUP1r9ht4keHZdlhUx14m45zScOD+hDAri+Xq5LoI6PM?=
 =?us-ascii?Q?YMkXz0GKxF5W+dBAjikjACknFQej7/feqi0qH3Ga3xkppAe2CqOABVPfC1nl?=
 =?us-ascii?Q?5dScHEcCljdCoMMI4zfAzsHAd+xwvtsp8GVgxiL7N5hXr5VVLsKhJXhG70K2?=
 =?us-ascii?Q?R7HSBrWiP9Jss4P1oxB6muaqR+sgYpM2o/flwekqZbjR0R2n1oGG6IFFLp71?=
 =?us-ascii?Q?N94I1IYRxQENusYXW+64MbnfzXCBZvt4wHlnaMuzYRtLg0ktid6o3EKPP/0H?=
 =?us-ascii?Q?Ezbt3LvcHwFKF4gTVIBIVgqq35k/7JDsFg37VpRt3U3xMTZPehW2VrKptkzK?=
 =?us-ascii?Q?jdbJVI6xvxxe/lZIpaBKsZ0CPIZn6AYxI7acV9GVnemx1tP8z2EvjDBFM7+u?=
 =?us-ascii?Q?u0yBSarzCFNGbcY/5BJP/qBt0d/KdBO9WQRzMS94jxDP7nN2njiPUtr7/LrW?=
 =?us-ascii?Q?J4RHo867kbDuo+W8xVcbjgiNBstdCBlEY3rbA80FnLIVQLqU3/DmB1fVRCGY?=
 =?us-ascii?Q?hri9VbwQa+MXGE53IUOxdu8Qom/ee+vM1JZNf9+unvNAv0bw6tA4msB/bpuo?=
 =?us-ascii?Q?JyvlcwXDfirJh6kRvFBdVRFKar8jeDGZALQvn86vboS+9BXDMbaWtf86/abV?=
 =?us-ascii?Q?B2xsgZHKNzQvDNArhUWO2Gja4f/e0ABKmsLZoeSRJGMkTkMNOZ34wjjZomiT?=
 =?us-ascii?Q?qHPLIXHXv4H0CbHl6jnCvNIhZ4RQZzCTo5Wv3lK4Yb2Sv71WUqv9JwTADgsZ?=
 =?us-ascii?Q?ZRz9TYUr3q4pKbOxl/c3XMwFOehmoO1SZWEfvbkp/lynl4zulif7iGDTJ3OL?=
 =?us-ascii?Q?spL+oeHcA+XHyxWqWaYBLqnRbLekzs1pNHLxUZmP3sERJY9KEnvG7zfrDe75?=
 =?us-ascii?Q?cSJvXMUXdBGj8pmuUXyqs451A7yM/zNIuPEe2JjHeiRdmInux05xRZj21YlA?=
 =?us-ascii?Q?LArf0lJ7H8XWXMrHl/e4ckLuC00lwHaTuPBNTMCE2Vu2vDQU0+lBfE3SvoaC?=
 =?us-ascii?Q?/3KXdlqQ/DJDuFavFYrI/+AWBPqB+aHEqQRJT3Q2AD78zDSw6870zGlncodp?=
 =?us-ascii?Q?LYsO6SUQDTbXpxDfteHoCT2qUe5OxtuJZ7LiQPMpVOKvHy6aHoYhaHpSWBCr?=
 =?us-ascii?Q?yzGlIa5FxxCtoEhADiaPYpyQj/U4hXXZIxl7lr74XWnnUPHF6g8BwjaPbDKT?=
 =?us-ascii?Q?/MyeFBIQL+mCpihgr01BJfVe3/fjB3Qt2taBbx5ghAkL8nYT06IHAoacxIJi?=
 =?us-ascii?Q?UvDcRWc6a3BvbQG93oqdXtXkwagEZQnmcsQodwC78XTICCOCqddyWLBR37YH?=
 =?us-ascii?Q?C7GYoCtpY8kLhnrgJcvwxPE9NwgINWOtemcXkxRYoXjIkyIKPG1Ut04x91KD?=
 =?us-ascii?Q?FLwnyOzs6rPYnrX5bhNoNLAjuih2rXkHCFiNEiadmR5ma6gWSYW3vzDQSn5T?=
 =?us-ascii?Q?10xJJWnB/4GOiljCJ/hK3UP8OB7P8JnKmQgk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:46:37.5217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11070c80-ebeb-4067-5b43-08ddef9688d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741

`perf sched stats record` captures two sets of samples. For workload
profile, first set right before workload starts and second set after
workload finishes. For the systemwide profile, first set at the
beginning of profile and second set on receiving SIGINT signal.

Add `perf sched stats report` subcommand that will read both the set
of samples, get the diff and render a final report. Final report prints
scheduler stat at cpu granularity as well as sched domain granularity.

Example usage:

  # perf sched stats record
  # perf sched stats report

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 509 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 508 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 2573491fa5f8..e23018798f5b 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3940,6 +3940,505 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
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
+		print_separator((int)_pre_dash_cnt, _desc, (int)_post_dash_cnt);\
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
+
+	return ret;
+}
+
+static void print_field_description(struct schedstat_cpu *cptr)
+{
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
+		printf("%-30s-> %s\n", #_name, _desc)				\
+
+#define DOMAIN_CATEGORY(_desc)							\
+	do {									\
+		size_t _len = strlen(_desc);					\
+		size_t _pre_dash_cnt = (100 - _len) / 2;			\
+		size_t _post_dash_cnt = 100 - _len - _pre_dash_cnt;		\
+		print_separator((int)_pre_dash_cnt, _desc, (int)_post_dash_cnt);\
+	} while (0)
+
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
+		printf("%-30s-> %s\n", #_name, _desc)				\
+
+#define DERIVED_CNT_FIELD(_name, _desc, _format, _x, _y, _z, _ver)		\
+		printf("*%-29s-> %s\n", #_name, _desc)				\
+
+#define DERIVED_AVG_FIELD(_name, _desc, _format, _x, _y, _z, _w, _ver)		\
+		printf("*%-29s-> %s\n", #_name, _desc)				\
+
+	if (cptr->cpu_data->version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (cptr->cpu_data->version == 16) {
+#include <perf/schedstat-v16.h>
+	} else if (cptr->cpu_data->version == 17) {
+#include <perf/schedstat-v17.h>
+	}
+#undef CPU_FIELD
+#undef DOMAIN_CATEGORY
+#undef DERIVED_CNT_FIELD
+#undef DERIVED_AVG_FIELD
+#undef DOMAIN_FIELD
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
+	print_separator(100, "", 0);
+	printf("%-30s-> %s\n", "DESC", "Description of the field");
+	printf("%-30s-> %s\n", "COUNT", "Value of the field");
+	printf("%-30s-> %s\n", "PCT_CHANGE", "Percent change with corresponding base value");
+	printf("%-30s-> %s\n", "AVG_JIFFIES",
+	       "Avg time in jiffies between two consecutive occurrence of event");
+
+	if (!verbose_field) {
+		print_separator(100, "", 0);
+		print_field_description(cptr);
+	}
+
+	print_separator(100, "", 0);
+	printf("\n");
+
+	printf("%-65s: %11llu\n", "Time elapsed (in jiffies)", jiffies);
+	print_separator(100, "", 0);
+
+	ret = get_all_cpu_stats(head);
+
+	list_for_each_entry(cptr, head, cpu_list) {
+		cs = cptr->cpu_data;
+		printf("\n");
+		print_separator(100, "", 0);
+
+		if (is_summary)
+			printf("CPU <ALL CPUS SUMMARY>\n");
+		else
+			printf("CPU %d\n", cs->cpu);
+
+		print_separator(100, "", 0);
+		print_cpu_stats(cs);
+		print_separator(100, "", 0);
+
+		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
+			struct domain_info *dinfo;
+
+			ds = dptr->domain_data;
+			dinfo = cd_map[ds->cpu]->domains[ds->domain];
+			if (is_summary)
+				if (dinfo->dname)
+					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %s\n", dinfo->dname);
+				else
+					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %d\n", dinfo->domain);
+			else {
+				if (dinfo->dname)
+					printf("CPU %d, DOMAIN %s CPUS ", cs->cpu, dinfo->dname);
+				else
+					printf("CPU %d, DOMAIN %d CPUS ", cs->cpu, dinfo->domain);
+
+				printf("%s\n", dinfo->cpulist);
+			}
+			print_separator(100, "", 0);
+			print_domain_stats(ds, jiffies);
+			print_separator(100, "", 0);
+		}
+		is_summary = false;
+	}
+	return ret;
+}
+
+static int perf_sched__process_schedstat(struct perf_session *session __maybe_unused,
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
+			free(temp);
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
+			free(temp);
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
@@ -4117,9 +4616,12 @@ int cmd_sched(int argc, const char **argv)
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
 
@@ -4244,7 +4746,7 @@ int cmd_sched(int argc, const char **argv)
 		if (!ret)
 			ret = perf_sched__timehist(&sched);
 	} else if (!strcmp(argv[0], "stats")) {
-		const char *const stats_subcommands[] = {"record", NULL};
+		const char *const stats_subcommands[] = {"record", "report", NULL};
 
 		argc = parse_options_subcommand(argc, argv, stats_options,
 						stats_subcommands,
@@ -4256,6 +4758,11 @@ int cmd_sched(int argc, const char **argv)
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
-- 
2.43.0

