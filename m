Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E273DAC03;
	Tue, 10 Dec 2024 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823380; cv=fail; b=aHm2md6HipnALvEmd7IYVecPZLINVNE9Ml3UivIzh4LXfJjSPBrzENuzbVBX5GzKZdJbai+67pi7BZyn8fVo4XJ6NYFFNU57pEcomELugvjwPkXPXbzUUwZKLmbn/fZM388yKfIykLWOnj/dJSOsMzgDbbtdJBWnful1GONf4jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823380; c=relaxed/simple;
	bh=drxzPZRjUmQywzoZnjHpe/W9Q2rWV0XQlFe7j6UzpbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7mapT5Ar3FO5gpVBCuYiFvNXLt8Fh+EGCgQhzVW6/czBtiqvrYHcC85blreNhzazK76IOX5N9B9ewK9f9po6oVPpbuJD0XVDno1+A4M8Ph9ugylDL0pCjQdb1xQAz/jIfWefkTOMJ96PhF0fBdWemYkvsxO+t5MrImeQyxPwgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fhGF2bqV; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fhGF2bqV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngwHd1NR/U+xk+IBmzUtIR6XKMTLHr0JA1RrOp615x8V0iMQMZpZNtf9pznOgmhWzZXbZZS12EcRK+bITBWQy4k3WgZ41gPeZ3LqtRBUXbx3hwztE+85Xvcy/Q0bEAkT2j69/Qm+WdI2EEkueCIFckSDTFZLAl2TIxosxLSMzhGhVg8DMPdliox3Ero1aStv/baWL8qS8zLwXt01Kbj7MNOytwlolAyz4iG3464PA8lLguMQ9KQck2H3DyNiXDokdDrN8vXxgvb62oeUkTvmer/kwRiWDGWE3r8xvc35Q61SDlvzu7PkTlm3pbVREKNScLlJYAeMxDvW5t9Fm6GzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0XtYqDJJ1bCxzYSCuSDX0wLfN9IQ7FdrZiFR6bqhfI=;
 b=saH799sguliLMU0dbBr6OVhBunoEeTCYvdEiVnosdxs9NC/HTsR+FNUaNy2GTJP4yv9LA9+mS/FWKvrNBTmDS+S7P3WEC55Eq3sjtzqmuMlEOsUGMNu7sD0t0mEpP6yygIDxOBbC9BF6MoaynwWmdVUdUEjLDyBcW48fglLe5u59GJAyZ1nSm33IcjmpUccjKkChP2pki9cGDp4FlbrGpA34XPOQIRRKAZy2fK8XyW5hY2cAVDqBv0n3ChDwCAtzddtuBCqxRPGbbt4Ddz5ADclbHowKaUNM9yjbfZUetoWBpDprFF9gP0hxTxU8ebzzliurHQbL8AqIMIrZP7WNWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0XtYqDJJ1bCxzYSCuSDX0wLfN9IQ7FdrZiFR6bqhfI=;
 b=fhGF2bqVQ4V/pcO3pa1namMxfeQQL8D50Y0VnfAqO8BQvEgqrIlMNAlOd2fuaePq78lFOABBSRHQ8Qw1+k9T7ker76zD5YjIUh7lkzrDIFgcKtQIhCUz6ziieyHiKT1athYjKG1eVCpd/azsssLBsi6j9l8j3e8U4t0HfCnXBWg=
Received: from BLAPR03CA0087.namprd03.prod.outlook.com (2603:10b6:208:329::32)
 by CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 10 Dec
 2024 09:36:08 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:329:cafe::cc) by BLAPR03CA0087.outlook.office365.com
 (2603:10b6:208:329::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Tue,
 10 Dec 2024 09:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 09:36:08 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 03:36:02 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 09/10] perf test: Introduce DEFINE_SUITE_EXCLUSIVE()
Date: Tue, 10 Dec 2024 09:34:48 +0000
Message-ID: <20241210093449.1662-10-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210093449.1662-1-ravi.bangoria@amd.com>
References: <20241210093449.1662-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|CH2PR12MB4102:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea4c553-f1e8-4ac7-62be-08dd18fe13c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V0EigCpk1HJ4rchFAqvdupQZD6jUNxiSk5J4llPFXpRteGZvrHgyBiSHTLiF?=
 =?us-ascii?Q?m3tJ3sUsRQHyfLvC8dcMmjGfloPW+0YJ6qd4vQKuWMUAsRFeqQsjNEMzQDg3?=
 =?us-ascii?Q?sEb1Q7sE0wPTakRG2czeFkpa2CSCUGjkqrAtlwxHuNN8Pw/dzrRGBFoSjwOi?=
 =?us-ascii?Q?w49904Nqnv9OGph8pGqr5oeh84BegCFeaEh6SBCONYvBPMnlXBVOmFnTyLK0?=
 =?us-ascii?Q?9gC5ykSGZmabdIp+TxqacU+YeMWoUZp0IGxoiMGPe6Qhv4N0M43J6pQjzIH/?=
 =?us-ascii?Q?lf1Kt919YeDH1mCK6ox7EPg/lI5zcya53T7gdypfs2+dcurzxmunIwsELtmM?=
 =?us-ascii?Q?+Mv5IOGjJPCvDf2svTJx9AYXu+1ebPEqOC/OuvZqB/QupFJ5+7l25k3VYxGx?=
 =?us-ascii?Q?LA4Q4i/vI1OSD6jT0DTIWhWtJvmUIy0OIoU+cMxiHZUJGZb4tw5iJ/2QuSLM?=
 =?us-ascii?Q?8YEskj4nDp+J1a7eUztk3KICbcphomqBUrP2+P/kXmeYN6Lsys5FxRM0MiTD?=
 =?us-ascii?Q?pT1h4wNAnL8a0ipn0xhKZrAevBmU5IQdtfo2VZC3saLbKHpkweXWbMYjheKq?=
 =?us-ascii?Q?rjNfQOUnxF2CLUkftVRggOOuPd7y7lL4c6X/98SebarD1jFd21aHXUP2lMG/?=
 =?us-ascii?Q?2sz5gizC3wY3S1BpWa12uSF5pZaWNaoicIOT6TAW+n+Rhm1pUyxGCB7WXfU3?=
 =?us-ascii?Q?lIunrladahcFlnr6FUV8W5Tj/fe9zasjkCp0iYPGpM3GcRg64Rxj+WElZVoq?=
 =?us-ascii?Q?m/JrjhWzpc7F2bzxY32edWf3NsirArA8CvI+Rx6YgjfpScb5Mk5IruighUM+?=
 =?us-ascii?Q?hkXlhqXoq3zNjMtSoNLxsZ64Vx6W4y9ojX0ZaUrxUxvaMIwZYj4j3Lfgb8wl?=
 =?us-ascii?Q?VnvePFltaa+/aF19sgC1E6o/wQ0cJygO+J/TW7IBKHL2oJKdf92ztcaSayvn?=
 =?us-ascii?Q?NHWnRVkK4TOheEC6DdYwODDYcI+rNsZvfwEXMqwSo/2qNJJnFiVLRe1OO+hV?=
 =?us-ascii?Q?J63mKwQRpAj3R7vccYouquITvdnHntnOdmspjY0wKHtO2/YXvZOQ9Dq8uAKO?=
 =?us-ascii?Q?8r8mw64yWD3c6AKcH1kX6XFGD0Le7az1oh/GloyomR0KjwFpcqP8Y4niutX0?=
 =?us-ascii?Q?O2h1gT9Nu3POQeYvs95fXzvxOAksALEKMbHBOLJeauNaAzfBi0I5OqlSOpaI?=
 =?us-ascii?Q?0Q0SU3FnvmGbwGZC3XotHzsCzaBMoyLy6QnrvSJ2fvqNN3jfkGz6zpxE1dxK?=
 =?us-ascii?Q?CeDRHnr+qn0ZvOC2J46YzACfZ3yIMibVReyAS0pSA0EYzucgmzco7LceYlE9?=
 =?us-ascii?Q?7PKpW5DO3Z/xJRY8mIyYZ13byd8tGD45NbGlTcxAyrFwxA+jsnfrZJwkwZtt?=
 =?us-ascii?Q?sBrpjN9NBUNdS8lmcKVI4Kx8U7+TsM2zw8qLP5Qde9WdOLkmHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 09:36:08.8160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea4c553-f1e8-4ac7-62be-08dd18fe13c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102

A variant of DEFINE_SUITE() but sets ->exclusive bit for the test so the
test will be executed sequentially.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/tests/tests.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index cb58b43aa063..8aea344536b8 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -81,6 +81,16 @@ struct test_suite {
 		.test_cases = tests__##_name,		\
 	}
 
+#define DEFINE_SUITE_EXCLUSIVE(description, _name)	\
+	struct test_case tests__##_name[] = {           \
+		TEST_CASE_EXCLUSIVE(description, _name),\
+		{	.name = NULL, }			\
+	};						\
+	struct test_suite suite__##_name = {		\
+		.desc = description,			\
+		.test_cases = tests__##_name,		\
+	}
+
 /* Tests */
 DECLARE_SUITE(vmlinux_matches_kallsyms);
 DECLARE_SUITE(openat_syscall_event);
-- 
2.43.0

