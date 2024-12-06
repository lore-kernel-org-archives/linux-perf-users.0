Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947A41CEE90;
	Fri,  6 Dec 2024 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462323; cv=fail; b=jng1se/lNgy9jGmTHWA3/AvkyfXXetiUJW8zn5llK6x6DbuYfq9TemNc0lvL7a1eR6Ew+UJyVeBORJIlDEX2uUFgpeE/dcY2lh3Mhf/nQmfrii6+FrjyZUYceojNNyHkfKSAyFo0oBKSJY7olKBdwRAFaT1eQzaYZRuNYkRr9Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462323; c=relaxed/simple;
	bh=P8OoPgvtDTFaxoJGE51XulFmjag9MsqdoEPdF5Wtn/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBoaoldXGE/6EFmxL3+JlstX1MDBNMj3r967RgqAgPveFZNGCZsr1UkY8+2Ej+31EE/2ZBESmeXxxFQQNXjZnavpMWolYS+wQflsdBZk7wjFXsKu0Zf8xIXLq4CsJqEFN4ZyFXsCeijZw/O2IrOf9agZrl6IHtkj39paztt7Jz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=29RiQOsf; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="29RiQOsf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KF17PFSXZpV09/1hLINP2vwi+PeaOsyaKTp2jJK6Bn95IQiIeX7sCMrg93T5L6CoCb5yiqxeEzaCXQMVQvydJiWEaUbGVRXV68vA/ePByPH+SQT9ACP3Xx4CxkB5KbHLMIsSG1kmf/QZjWBv+q0gkaAHz/Uoowm6sQR/CSC8LBauBioz8b2PgqU90pcQTsRjL/3pzuvqA2xbVPee2RO6pPfGmBSWkMkf/MixEx33ncpLJ2RjbIeef2UDpsl6FM5tn9gyAFrvQkK24+7pYw+c4A4FmOp96AnnC0VzBlreo5Vl3KrVBLRy4H7dZJcQs3g5UhBpRk60eAAihI5Blg/g3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvlTOSS7H68pxrmHGchrjoQBtdNIhEsETv/+BGgjN7M=;
 b=cQsK49Zv1QAQXNgU3nOqQq17h4/STH3mJUFmfNzZeZbFN3e6zMkqKxzPZB4Ck+BFJPuuzYkZhfqL2vriMhyZxRibGUBmHTqtoXA3eADyOwE4sRnh7YEmCWoGgSBxWmyiZYUH168ViQqxlWWWKOxfQeGahXfGuM7hJQwKpl0+syFOnjPuM7urChoUof316AHFf4shFvPzkiMtDJ3z9RutfJ5J7JSyldT8g+3y5TDYP6TPxLUejvoeT0EjPiAbERBDmqm4NXsUJ9g8c3M0H8j2yseOlEtwqBQGnDh5qtVvvSG1PrILHuiGX8+Pdm/SxFjZagIKczSyveWfXaV/c+sTLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvlTOSS7H68pxrmHGchrjoQBtdNIhEsETv/+BGgjN7M=;
 b=29RiQOsfE6xNBF7R1PX/UDNPDUCuum+zJ7hGVVS/QcLQYXJ2z3CWh2SwWtESnA2XZr9lua8gZ9Djtx6VJUyxEBOUnyewLtZElnV/l/S5frongsci7NdEzoFJRcR6flO/kEj+IoUutXeZNxJTXVTcwPrDh2zwIVN7NBtSblcsMow=
Received: from BYAPR07CA0093.namprd07.prod.outlook.com (2603:10b6:a03:12b::34)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 05:18:36 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::99) by BYAPR07CA0093.outlook.office365.com
 (2603:10b6:a03:12b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Fri, 6
 Dec 2024 05:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 05:18:35 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 23:18:29 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 09/10] perf test: Introduce DEFINE_SUITE_EXCLUSIVE()
Date: Fri, 6 Dec 2024 05:17:12 +0000
Message-ID: <20241206051713.991-10-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206051713.991-1-ravi.bangoria@amd.com>
References: <20241206051713.991-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cfec2fc-4ef3-4712-326c-08dd15b56f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?upHyPhHRKSF51uoKu9WOFJ7mpXj9YKzM0tQG5r1BGEWJ1uy7Vmu37pY+9eOU?=
 =?us-ascii?Q?GZsLn7GIBwjAtpp+Fcs65W3pc75ZIe/7FkdiiOEYiRkGD8I+zbQPT+S9I33U?=
 =?us-ascii?Q?b3hU+H31AGAgP1pxqN9rOFHlgyU36eRO0TcEwDBVT1IWoCLW0Jvtc1uh8IAV?=
 =?us-ascii?Q?C3LuoTTZthHOyA9GzrYgv+EOZbSJbn+Of5g4yDsAmJ2AvhG2e7XPuVTQaEFM?=
 =?us-ascii?Q?RVJmq8LTLog6xn9Ch6aRF8dJkBuWBepv+/IqUHdizOAIAeFbPH8ed6J9siyK?=
 =?us-ascii?Q?jDaAzTCJOPbxXp65oWny5Pq2OY4P0Aazjro6YY4fdUYdVKfFrb3WX80HCRdK?=
 =?us-ascii?Q?/HTXRHp3WLSAurM2mxLTyUkrBW8MGsc3fCojqoT6cij8t/clVYm8USulDcoc?=
 =?us-ascii?Q?qWzJ+CIDjAr2NZGm/Ss14PDSoFlO1SyUJbPg6e+pMSmRmTfC2UyK8+lOZ4lS?=
 =?us-ascii?Q?9rln56jpoFWgw5xK/7c3uDrB7TnhA7t/vmBxoSfzgGpJNsUAbLthkJ9FR1E0?=
 =?us-ascii?Q?/3jeg0yLITrdwLmIK1x8lFjnhOqmPXg/QrFewnssD0KGW6HqdD/tCZQ84HDf?=
 =?us-ascii?Q?xdpP7LCtjIjFHpKnjgpDe25RRv33HjHXAPWfXsiADYB8a5YnkcMbTIQi6X3V?=
 =?us-ascii?Q?2o8m8I9p8K+HMV8yiO+GyU3CEXQsCW+/PUMe47ebtdn7/2QPITlprVnzXxnA?=
 =?us-ascii?Q?RpetuFZTlp+5KeHqSgrduuOL03bDMu1Ve2T4Ppy5ztSBhhL4CyKf6HBueiwG?=
 =?us-ascii?Q?0kcd9WKbXecvjR5nAouX/FDo2K47tY55HbgZhOkLP/9l7m1TT/HyzJMExSUg?=
 =?us-ascii?Q?Jtupkvv3r5QmrKhHIivFxsHQm1CtP0Xk/AvoahWbdJMDweJLaorryf3sT9fl?=
 =?us-ascii?Q?rwEmtuN+P5WBJSqtEfJSox3dMVxVdVjqkzYGXcD2acnRIrZQVy2nohQvViw7?=
 =?us-ascii?Q?LUjWGbhIqi5TNG134IwULmkb3itg7Fx04QPwugW9JdX8kRG9qzEnWNDJbXjP?=
 =?us-ascii?Q?izZVpp+c58acJ28Tj3o0jGsPjOr9hVrwOj5GhBPaTURZSR5Mg0erRaY1CJPP?=
 =?us-ascii?Q?t0dkW0ovUI45jtGBPheQ3eSjSjkwx7DJc44h9TkO18/RGUqIRnbH2z6Ga4dy?=
 =?us-ascii?Q?2kqV9NJ9yJTwTIw8MEy7ukiyhjXn7yozjkfvixp7KbPtEh30HwgDep/vNSWL?=
 =?us-ascii?Q?iykqt43Qa23tgMxdTj1beRF+VakNRZaKh4kSALdTCtA72cm7l1r5d/x1Yqd5?=
 =?us-ascii?Q?QuKBQlrdUYLTjwG5dkdnGGGyRrZmxCxFR5njEAtgZKDNGMgoXRwNKsCj+6CO?=
 =?us-ascii?Q?bARNR47oWmZRVW4w5Frt/u3jwA3Ou5G3PCSW+iIWTXtUcDux4oEFuDz1BENO?=
 =?us-ascii?Q?WXh3MM5HHledGbvlXprazragaWfr6hU2bJk/+QwTq6EYY3upssF1NEauDlkD?=
 =?us-ascii?Q?kxfjHj5CAj9SqPaML2q8VsPpuHKx+joN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:18:35.4133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfec2fc-4ef3-4712-326c-08dd15b56f38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507

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
2.47.0

