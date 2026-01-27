Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B6328B71;
	Tue, 27 Jan 2026 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539927; cv=fail; b=KqBLzNembT942YaP3IQ5nW013lh2JCvQfiRikg8PuzKdQtV+wPz4OBcU8cpWToowd1UDzfp9OLlLiphUuxA1MWdGKVAkW7KA+qdwb+lHVkiY8QtQR6RPFo5Wwk1jFKAB2ms2ccgJHosIH5xqSEChY/dQWYdgTXQ02Z7DtbDGL9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539927; c=relaxed/simple;
	bh=1NxsM8cZCGrGItvMrq5e6aMXHiDcVLE31IVmFoU6EoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCUdpuAo0Py6FTTxqUJFkt2Vg5exoR4t4YkNa1z25baS7Gm3p6Smbzcu3CXs0cOl2iXNQTyZB06dPX3fcEwv0HwGow4XHp3bCnManwC2JXrZUsehaBtpgq5XW1FoHykLe/HtFAfty2V451kNk0ZXkYEABmmexndd6T26BhXMwKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PRYujkd4; arc=fail smtp.client-ip=40.107.209.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PRYujkd4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjabIRWJ8bQzhP0WA6L9aY1RCbdmpKE1zydo+4H1qDk0mHvaYoByTxqLTQS2Cs5fcGhYvKaIZgPefqUi0Bj/SRZlt9USEoZvJyg5YWO5mgvM3oFID/BKguDpVMSqI3vu1rzb2jEhMBVhqu7UJVMVm/zaI2BUQL6HHyFoCh8NbTkdgjp3FueX4OV6tysPDIBBtm8r359DiSwD5ZtF+dSi+W0rHd684unZ7myDToVn9Y77+/pD08Mh6JFB+NZ//XJpD5pghfiUcG86zw/L1URyfag8HJpxk6v0MQskO2PUzxQw+GAS4R2pE2SvTjTxA+rONEmLJB4pSJdh4dTGYrIkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5xUxp+OGId+9NKnpdJFwZed3sMicsRW1DRamgggAII=;
 b=ifqelg1Hb3VDCCOVAph/GIIT3O0+vEu93Bk1t3V5nsRLGgAsRzQJy1GHKILCvvW0+ZxLpySNqYL3LDD3gkBGtkMicsUqLDq7IDslzbEf5TnuCb8ehxENME6FyAmvVt0RJ4PnOGMDnU/FRZQx5bK7rm2QqLtX3rf95yN3DScrKfu8huMrwUVoa57+KpCWvVvJP/JRVLCtbgNPL0Sj/sE7VAQdWLvyWLZ5G2c9DUNqyspTB0XLKtVFMPaDwrqJ7gs1cK7zz0/XlPXy7FL30wRWR8AZp9fBBytlGMMDNTO69xmTfNGJStIBt9Br0SAGVbRUGk97fnDjV9LDkCnBWKW1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5xUxp+OGId+9NKnpdJFwZed3sMicsRW1DRamgggAII=;
 b=PRYujkd46gISGVkZFsRHFNS92E9Dk2EOpjLbGqEhpL91d/ZpuxXz1zgUdXw5+rheBSLneZYXk4aJX2agJ2vYvShZWyW3N4LcbfbjRr2Dzb1KhOqm3N/gwy5ohHdfMf4lC/cLzqe4m2MWiixqaVsCPEzhZbs/HhDE4nbDHazgrDk=
Received: from SJ0PR03CA0079.namprd03.prod.outlook.com (2603:10b6:a03:331::24)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 18:52:01 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:331:cafe::72) by SJ0PR03CA0079.outlook.office365.com
 (2603:10b6:a03:331::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 18:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 18:52:00 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 12:51:56 -0600
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <thomas.falcon@intel.com>,
	<ashelat@redhat.com>, <yu.c.chen@intel.com>, <sshegde@linux.ibm.com>,
	<gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH v1 5/6] perf sched stats: Define macro for SEP_LEN
Date: Tue, 27 Jan 2026 18:49:59 +0000
Message-ID: <20260127185000.431884-6-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127185000.431884-1-swapnil.sapkal@amd.com>
References: <20260127185000.431884-1-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb53bde-3bdf-41ca-9b60-08de5dd527cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gVylFSeF+uBUYowlE3UF6Dp+VudFKxvC4/e3eyZzsymN2bcatWhSqTFoU02t?=
 =?us-ascii?Q?Xe7ST8pj3q8/EQy7FjUYCHFW751POHz8oPAygZ3EB40wXHrFYgBbQ140gXqH?=
 =?us-ascii?Q?gi+yLUawMCHKvs7mUdDPAyKMt1w4nK2c3CgQ7tAxhW10epWj06V3VCoDNLc0?=
 =?us-ascii?Q?Mqm+kRtSSlGcv1+ZnD9Ro+iivmMhPKzrIL+VvnL50/0O9KkReGXfOwVFSNHK?=
 =?us-ascii?Q?edFWC1nHvYjesEYtJtJZ4ErXL4sWH7IjM8dznkYfLhBfsqyhXzOcxw4FDI0H?=
 =?us-ascii?Q?c/4lxysclKc1zpS0CQWyEBX6UV9pkGI+mIn3PzWPzNWXyGzplxd/mE95l8O3?=
 =?us-ascii?Q?hbshU2wWGxBxwUq7MlhQpAgO2BSIafIdOscnAyUo6ireTWLT73GM0Ao+metl?=
 =?us-ascii?Q?uobHN8e3A31EzTIGQbmZDbuGVEts+gWvBKACYZ6hy2hQLMvgRlaPG/QpfRS0?=
 =?us-ascii?Q?/GdvOrlWaCPhoHDnwcC4Dj9K7ZMonUX58GUcJ2XvBw5+FstUT1xn6wTDpipG?=
 =?us-ascii?Q?UQVh1uJhvqQ0aU1a08Cg9C9cXPopg+ss8SPmyTu/eEj86Z8tl7v+A61+a3Ja?=
 =?us-ascii?Q?PhJsGLs6050bUbKFzybt/ncbVB/+hECEhXTrHOPhHZbLf2gBoUBvbCa8Ua79?=
 =?us-ascii?Q?QfqgcuS4N3OFXA/lEw30Qnx75Sysa+y8O/Kqo5m2QEW2HFTVDEY92yEDj2VH?=
 =?us-ascii?Q?mQXTzv0jR+O7rqHSEXB1ya6wu+Blx1nO/jpQ7IYnWavztrxsnxXaZAAc3EHE?=
 =?us-ascii?Q?I+HxuxO9U4OqkAB6+SpNvH0dYzxl4NHhJ/Qk5hlIF9gMCB0rTIZ9UtU47SJ7?=
 =?us-ascii?Q?o64IV/75r9gdok6ZcDWPsqHZb96UgqQOyBh30ueYigLLvOV5KBvdGElFTtCi?=
 =?us-ascii?Q?yh5lIqEhktVcp9HPKNfdbC5DiuMvjo0bXRkvZJb8jvho91uCfIzDvxdPRncA?=
 =?us-ascii?Q?EFtlkGR/pDAb9TjI3qu/k+pXF2fZzQQaOPO+yMTvP6HSzZ8lcs2UCTX7Ctcq?=
 =?us-ascii?Q?wW6MzV0ks3tcA2sDgoUBsJ0c/6pZP2Lj4I4WfbbqWJTAzRNNZTQapNIKU/Hd?=
 =?us-ascii?Q?qIlW3akNw1gKM+Q6C4Sbh9PanL+aTXWp6WDhCu10LGwx+uyTu9Zt3cORIqHF?=
 =?us-ascii?Q?5IOgkGcRjH5zwWt3w0J3ukCdfu+je9k3rYrnqL+gOFG9IqX6SOIBj/5NhZ5I?=
 =?us-ascii?Q?94SnXuUH4ffAfSyo4b1P/VnquIdDJCTN0RAB79dBiJ2+JowKoKEPkJVYFLno?=
 =?us-ascii?Q?UKtrNYGLdwV0mAJKe/JAHUdTv0Mc65pamJWcETEwk0WkPcC9m63a+f71X5f/?=
 =?us-ascii?Q?RyVBM5CzA2wFNMngVcA6CZXnV5mWtieDMLFBy8vlYfUtigNHEwv4UtaIjvVm?=
 =?us-ascii?Q?gJFZYfJU+lHhL9NDwdgyyPfKihTxdc0DOfhSyRpseq5Vj1fJfG+DzsWLQwKN?=
 =?us-ascii?Q?VQ1k+o9Uf/+bM6oE/CqQfXs8k4sGliUJUgQGrGkFh1hOlsCwNrLKx4uqDluT?=
 =?us-ascii?Q?UX+J8Qv6uv2ZnbWlOMziYButvAvBBdIOWoy9alliUwieti4Phhyn/VKZFvip?=
 =?us-ascii?Q?evAGrC6dcCViAnEF+dvmewTc7TZ4huc+GWfeb4T8Rs0Gis4HsxYtb5IcW8hZ?=
 =?us-ascii?Q?CfPVCAdsa2DUwQ8B2zKdA2xTpDLWi05QJlubZfZxt9M4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:52:00.9517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb53bde-3bdf-41ca-9b60-08de5dd527cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240

Define a macro for separator length of the line in perf sched stats
report.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 1a24c4869331..3f509cfdd58c 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -55,6 +55,7 @@
 #define SYM_LEN			129
 #define MAX_PID			1024000
 #define MAX_PRIO		140
+#define SEP_LEN			100
 
 static const char *cpu_list;
 static struct perf_cpu_map *user_requested_cpus;
@@ -3997,7 +3998,7 @@ static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs1,
 		       "PCT_CHANGE1", "PCT_CHANGE2");
 
 	printf("\n");
-	print_separator2(100, "", 0);
+	print_separator2(SEP_LEN, "", 0);
 
 #define CALC_PCT(_x, _y)	((_y) ? ((double)(_x) / (_y)) * 100 : 0.0)
 
@@ -4047,8 +4048,8 @@ static inline void print_domain_stats(struct perf_record_schedstat_domain *ds1,
 #define DOMAIN_CATEGORY(_desc)							\
 	do {									\
 		size_t _len = strlen(_desc);					\
-		size_t _pre_dash_cnt = (100 - _len) / 2;			\
-		size_t _post_dash_cnt = 100 - _len - _pre_dash_cnt;		\
+		size_t _pre_dash_cnt = (SEP_LEN - _len) / 2;			\
+		size_t _post_dash_cnt = SEP_LEN - _len - _pre_dash_cnt;		\
 		print_separator2((int)_pre_dash_cnt, _desc, (int)_post_dash_cnt);\
 	} while (0)
 
@@ -4238,14 +4239,14 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
 	int ret = 0;
 
 	printf("Description\n");
-	print_separator2(100, "", 0);
+	print_separator2(SEP_LEN, "", 0);
 	printf("%-30s-> %s\n", "DESC", "Description of the field");
 	printf("%-30s-> %s\n", "COUNT", "Value of the field");
 	printf("%-30s-> %s\n", "PCT_CHANGE", "Percent change with corresponding base value");
 	printf("%-30s-> %s\n", "AVG_JIFFIES",
 	       "Avg time in jiffies between two consecutive occurrence of event");
 
-	print_separator2(100, "", 0);
+	print_separator2(SEP_LEN, "", 0);
 	printf("\n");
 
 	printf("%-65s: ", "Time elapsed (in jiffies)");
@@ -4286,16 +4287,16 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
 			return -1;
 		}
 
-		print_separator2(100, "", 0);
+		print_separator2(SEP_LEN, "", 0);
 
 		if (is_summary)
 			printf("CPU: <ALL CPUS SUMMARY>\n");
 		else
 			printf("CPU: %d\n", cs1->cpu);
 
-		print_separator2(100, "", 0);
+		print_separator2(SEP_LEN, "", 0);
 		print_cpu_stats(cs1, cs2);
-		print_separator2(100, "", 0);
+		print_separator2(SEP_LEN, "", 0);
 
 		list_for_each_entry(dptr1, &cptr1->domain_head, domain_list) {
 			struct domain_info *dinfo1 = NULL, *dinfo2 = NULL;
@@ -4329,9 +4330,9 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
 
 				printf("%s\n", dinfo1->cpulist);
 			}
-			print_separator2(100, "", 0);
+			print_separator2(SEP_LEN, "", 0);
 			print_domain_stats(ds1, ds2, jiffies1, jiffies2);
-			print_separator2(100, "", 0);
+			print_separator2(SEP_LEN, "", 0);
 
 			if (dptr2)
 				dptr2 = list_next_entry(dptr2, domain_list);
-- 
2.43.0

