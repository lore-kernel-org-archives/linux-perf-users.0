Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979D225A2C;
	Thu, 29 May 2025 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748522136; cv=fail; b=AF74Mv+vv5181ADBcTRig37lHoMn1KnOorEMHp3xwbaKE2ydMpTqKq6bZnRczzqiw3CoAFwgDvgBNo1tX/oLkMakZSSbuToRndKDqhmSs0ZEKK7XLEN6CUb/GrRRbvuVTSV/SF4wd96MXuAhR0ljBeuQu6byA/LlUapMp/jgBFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748522136; c=relaxed/simple;
	bh=r/A0hPlikeGJaW9Kqr/FNsYE5zSTLsbJywbRmbCsFwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDV7qLopn4WuQR0NN/wwr/cWOzdlM0825eGB1WJmuPz9/7LbiLuiizRec+B+EMD3U2JrEHwEcLzPS+8pUsn5FrqHEKEnT728AZcVAf1xpZmDd9klNMHzuSbn1SLwrXQgXy7ppStw1ZFoz2lNHks847AGABbJiycjbGePZ9nQZMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R9CZVHkg; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R9CZVHkg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVZT1MYPueaW1eDj7lmau4jHPyBeOMO2XKqC055Lp/8Y6HBmoXVgb6kzPauwhMjZhRt3wOxeiDr2vlKv0FpEf71A9gApysPRNXOnaSb4ghMmUQCuce6/UvINCuNvbYnF82sa7kLHq/PGFVxofe7ci+5FhLpH0exMsDiDY2NKORu6ONO/wYcpzI/Fay//lbziJsflIUpMPlT8FXEGGrSTZ41F/OERicp9/Nfm8W1UujRBG1wsM1WnUkhXp7vMFHLSlRgSL0tV7JOe9LjKRpe9zCaa03ms5pzap+cEngiS7wREWlsrr4vFFsjZ8YHoeqZqV5TmgmRGJKqtEV1UbpajBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tp7FFhhUlw+PBwU9pm8ZkVDOkQGDtuCiHmNblgHOLUs=;
 b=wLe2rFuAHtFimDe4Od/TpOPy5lPpDKfPD0fD78qs0vMa4/+0gTTyaVXbrg4tFgM232nQc1XoGsEpEZ/bgrxoEuY9ZcgwE78OKLv4aPaiKVEbxbmMgeJYp7Tm4xSzNNIIYkkRcjUMTwQTkMX5SJG5zAtYVmTQxmzxB0CakOamP4aIrU/+BaJmALkMzdxyNAVB1uD5A5EVpi4r9WlUrlkVMsNlhPW8XG38aMMrSo58kzGKJqbYHbiVu62L/4OtWVc0ZpTnhzJ7qK2W4SdiobEXPbMAJXShk4hhSocFDpz6sbY2Vzz+t5ZKnBL6pOaNoctdgzzxhX16RhSxekr7q++SJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp7FFhhUlw+PBwU9pm8ZkVDOkQGDtuCiHmNblgHOLUs=;
 b=R9CZVHkgTJyWY860o8uyNFNOykY5qz/RH+s2Fzx3EXLJNCELguF2qOjMIA5I+9kC0HqKg+aiz6rcVvnWtUmlPnBVUpnmjF4YC1p6OcKuRDw1VtfAOKgLKFAD38V4bDgVHhcjKnyIhLnmkwmdAQd1EI+yOsCKPHdfXdblb90sg4k=
Received: from SJ0PR13CA0146.namprd13.prod.outlook.com (2603:10b6:a03:2c6::31)
 by CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 12:35:31 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::6e) by SJ0PR13CA0146.outlook.office365.com
 (2603:10b6:a03:2c6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.16 via Frontend Transport; Thu,
 29 May 2025 12:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 12:35:30 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 07:35:25 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Ingo Molnar <mingo@redhat.com>,
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>,
	"Leo Yan" <leo.yan@arm.com>, Joe Mario <jmario@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "Santosh
 Shukla" <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 3/4] perf test amd: Add IBS load/store swfilt tests
Date: Thu, 29 May 2025 12:34:55 +0000
Message-ID: <20250529123456.1801-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250529123456.1801-1-ravi.bangoria@amd.com>
References: <20250529123456.1801-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|CY5PR12MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 100f8b31-2834-4748-a16f-08dd9ead4c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AmyZwo1HUG1EqspM24N8BvnGIHsJIj7QlvePRvCBAHep24DzqDkEzZzm9BJ/?=
 =?us-ascii?Q?NkcqIoLiC4NGCH7kzKhyZQb/2YXvou9Q2lvHQ7XrImUJXlW5fWvKTC0jtEvQ?=
 =?us-ascii?Q?UyESvpj+J3CvISjfWx6+8G0KFGuHjERVgEN/wJ9WePnH4V5E4+Fjb9a+NDCD?=
 =?us-ascii?Q?KuE1hQX6xb4SHHSh/Nbyxa2HngOPVplMlmF4lUS2qjarydvtBvd9zILO5Jjg?=
 =?us-ascii?Q?6EkRvCIF55KOXD940VXfZCsBKdQoeiiv0qQ/NV7/KYaDo6SFsiGh1DOAHEhO?=
 =?us-ascii?Q?hM2w1/xmM5wQMFXV4DWZntyCEQN2cjawHNsU/innVuJuVh5dwkBmMk5v9mdd?=
 =?us-ascii?Q?MVCJBFK7hwQRcoYgxBB/tOMe7hDqeESarXCRv1RR0at1T4sZvl2GAmOuPhtt?=
 =?us-ascii?Q?9yv6MZCflqRTgqfqLeJFik8RvlkeJngaBQx6K7GIf0gbAq7WgpuvCqLDVoA5?=
 =?us-ascii?Q?3p3c406EnMVkJ9szIjLnP/+W5AfWsBU4mQC0ox+S/iUs925n4Jt3oA1If12+?=
 =?us-ascii?Q?rHslJ+ItagDgjz9P6qvhRos/Z03hfBSGysEWVQ692+yrdLxmf3qXnTwNe5bd?=
 =?us-ascii?Q?uv4PXmnHwmFi1EHrCpAvoqqFJ8hXDDSyU0mRJO9Q2CkQ/1xtlpnRXc05N35q?=
 =?us-ascii?Q?lt729H8C7sz8e1puo/1vG24ieOpxKw90EV3n1dGNE0snh/eXukiWTPyCivSz?=
 =?us-ascii?Q?yfvj9+dE/VcZ1hyzdhEHXpjt+xW8RNhv6pJCdTJD/+RDSb1q0urDcKyo5Chy?=
 =?us-ascii?Q?z8pcv1zkgusetYCIva2e9/yJeBULP46D616BgyQB5L6vLlZpty+7QVZGYgnq?=
 =?us-ascii?Q?84viy/XieQ/Xd9g4hGXA2z2Wn8s2dQGNRNmXiM2UMnTONCHrUbgK6aIp5MBn?=
 =?us-ascii?Q?t7o+5CvF595HdB4N0/VhAoeBdRH5P6+2GIWYs2+Fn29vBpOzdWDdThABXbuG?=
 =?us-ascii?Q?+PtX+g3KC6cVVltpVGkmOKnihi+BzKBmLXyQS6+cQIRWhV3iG68ma0DQ/xCZ?=
 =?us-ascii?Q?hHUJCrDfKeuMp5fCdDXCFnSqpSgrPuTy8R0ZK2D4m0LAkhJcFpq/8ZpzIMUk?=
 =?us-ascii?Q?U1qSyjUduyqfo7n8d/Zbnm252O23KKjmjMAKwgeImL2ivbzdftMPg9vr24Js?=
 =?us-ascii?Q?stnIxaBMvrtMjN87iysCUQW1Q/O2O4IDXGicQ0OvP7n2kvYExdfmGoWkbKIW?=
 =?us-ascii?Q?/BohwvasARAfJwtYkGfmDLQCM/f4v/5MnaiR2b2LpS6mG7l+pBkwS8niDzri?=
 =?us-ascii?Q?WWkoJI5mrzeuI3PDJfHGNtcFL84BD8lpdD1TwRGVE31LjOyVGzogspOJ9iVG?=
 =?us-ascii?Q?SWGtWunfaUUL1icDoPeHt5uayl8mSy0oXDkYB0EwI/E0COYm41ZX2k/0g161?=
 =?us-ascii?Q?JtJYQ6lFmFHD06FyAFcOKpjqnkJb6onNh2paWH4vvSpseVLRchGBG1ilFq/c?=
 =?us-ascii?Q?yNpTEumyAJRqrLlrlpvOh5GDnTaexK06oBo4RPxYr/8UvNYJaA/vXaq+PK6u?=
 =?us-ascii?Q?r7vzsqkm8EI+KXyWl3JR8vXAwuV7NFz99GH8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 12:35:30.1183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 100f8b31-2834-4748-a16f-08dd9ead4c42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6252

Add basic sanity tests for load-only, store-only and load-store-only
sampling with IBS OP PMU.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/tests/shell/amd-ibs-swfilt.sh | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/tests/shell/amd-ibs-swfilt.sh b/tools/perf/tests/shell/amd-ibs-swfilt.sh
index 83937aa687cc..bc052a36a9b4 100755
--- a/tools/perf/tests/shell/amd-ibs-swfilt.sh
+++ b/tools/perf/tests/shell/amd-ibs-swfilt.sh
@@ -65,3 +65,29 @@ if [ ${user_sample} -ne 0 ]; then
     echo "[FAIL] unexpected user samples: " ${user_sample}
     exit 1
 fi
+
+echo "test load/store swfilt"
+
+# load/store swfil
+if [ -f /sys/bus/event_source/devices/ibs_op/caps/swfilt_ldst ]; then
+	# test load only sampling
+	non_load_sample=$(perf record -e ibs_op/swfilt=1,ldop=1/ --raw-samples -o- perf test -w sqrtloop | perf script -D -i- | grep -c "LdOp 0")
+	if [ ${non_load_sample} -ne 0 ]; then
+		echo "[FAIL] unexpected non-load samples: " ${non_load_sample}
+		exit 1;
+	fi
+
+	# test store only sampling
+	non_store_sample=$(perf record -e ibs_op/swfilt=1,stop=1/ --raw-samples -o- perf test -w sqrtloop | perf script -D -i- | grep -c "StOp 0")
+	if [ ${non_store_sample} -ne 0 ]; then
+		echo "[FAIL] unexpected non-store samples: " ${non_store_sample}
+		exit 1;
+	fi
+
+	# test load/store only sampling
+	non_load_store_sample=$(perf record -e ibs_op/swfilt=1,ldop=1,stop=1/ --raw-samples -o- perf test -w sqrtloop | perf script -D -i- | grep -c "LdOp 0 StOp 0")
+	if [ ${non_load_store_sample} -ne 0 ]; then
+		echo "[FAIL] unexpected non-load/store samples: " ${non_load_store_sample}
+		exit 1;
+	fi
+fi
-- 
2.43.0

