Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17194254AF5;
	Mon, 19 Jan 2026 02:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790639; cv=fail; b=N0GkBRdiEkbgomoWLmTGM0KEKKg9jjVdAsewwThNt05z3rfkZNZEKL8qJXglVnX8ZbQT1YTB+XSV8snEVhbzzMb4rRfS7bBpYXaSkAn6rz3on+CBZqOpzbfrtdy24pJC6clnx+v7G1vBQveuqj/ntoVZdGQbyTZuDUWXs6JQGQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790639; c=relaxed/simple;
	bh=efHyAc8oVHJ0gqXqQ6rd9fHxSYtBd8xXnHx7TyeRqpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQF8WHgM2ml7Ng6USPf6clAp4SJYBGQjfMIGbY9qtZGDbapL1Oq4wirOAHDfUZUbNWcKaLserqTfK6BOjaktcFB74R4p3OULbQJSW350D0ErIGrcEFZNmRgW2Bt6S9+yc5gs/FWrFO36ozYpWzC+yNeL6VUWex9qOo5HtsouaY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jZVRvPOX; arc=fail smtp.client-ip=52.101.62.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jZVRvPOX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUSzgdYZYQm1ril4ufWgB6oJiA+FPga44eYrq/8nCC4lL3SCfCeodcF9QWhxLMWIKvJqU94meY75lB5vSSitG4zDLhm9hddOcH+BhtG1LlnRM0aaotJdegc9m5VI7vKXfUZ+lqqADDv37F78BPcG3h6PJOo+JTBSqBLm/jrTy7HNzhm+RmNBxVc8kCp0ZezXSFGEnEgtNCUk/YFKd4scPZBpTDF6KjJbTvSK4Cd3WwUqSnsqLh3ZMRYlmII4ve3+saY+bsf7SwMcigufRr+lr9vEeOWnqi9ayKbbHvypEh1T/QZ5hYxEpogcgzrzJOEtaDdzfFzDbSFHUahslKpvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqARB4OEkyXYSePL0AFiSnLU3LbV7+Rc0K/NlwVlZjg=;
 b=ltQOVANHjXOvM36zdAcZxncRM/5w4/Hqumsp73wfwrsTF5BRGqW5kQF8ePcTziz31QConNfTCGzgwUoMWr9llWjhy0pnYSeOCXj2gzzU2qnclNadZWzMkC+j2CsA0QVSUKsaodjeRcqhhsoP+Vh8gBxzblIBR52YVUrWRtn4Uy1BtmaLCOzgnsdAcRpnBEiNdVa18MYZdLOtGybAEbgxoCHl6nod8IMhGIZDdPNY+3RnqlQRiEAWztS5dajkVmfAgEFf8hFAJk7VEOmRWaVoy2pC3lJe/FdVd5JKZgIGIytTvPJQxJCGzRZUFopnWibr9CDN4QE/yP3p+sAGyMkuQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqARB4OEkyXYSePL0AFiSnLU3LbV7+Rc0K/NlwVlZjg=;
 b=jZVRvPOXDASrF7rze0pBOcO6priP1uxlp8XqIVFuzecvY2Mn3A7PlN3uIjVC9Dx8aFvvPwQucuXg6aB66QatVtukSe2Ra3smKEPkRLc3ooEaGZtR7oOVU3Y4MfbIe/UseM5h0pzmssImO3zYQmxXUbK6KfkcurZOrdrAbnmDhME=
Received: from CY5PR20CA0017.namprd20.prod.outlook.com (2603:10b6:930:3::13)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 02:43:55 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:3:cafe::df) by CY5PR20CA0017.outlook.office365.com
 (2603:10b6:930:3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 02:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 02:43:54 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 18 Jan
 2026 20:43:49 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 1/6] perf tool ibs: Sync AMD IBS header file
Date: Mon, 19 Jan 2026 02:43:22 +0000
Message-ID: <20260119024328.897-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119024328.897-1-ravi.bangoria@amd.com>
References: <20260119024328.897-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 4878a571-94e5-45e3-8a67-08de57049684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D4cFjrgLu7DXFgeRnPuvCxTx/e8BwePJ6JPz2WTbPtNlMpYKB6tTrbT6XQyn?=
 =?us-ascii?Q?j0bcUlq6SeALXB0Tkn4vDdYNiaOEgZ7li9jNc5J1bwf4lwCi1FabMor0YIYH?=
 =?us-ascii?Q?hmgsr4TH8x3icNvAHJZiQqLeuVeyFkJ7065dT/HJPGxXahvH0vYShw/DFcK4?=
 =?us-ascii?Q?NVuy51YHH2nH72TxDu+u4fRxsk71v6Y0FU3fJ/IF/ag+xR17mE7LQoqKe7HK?=
 =?us-ascii?Q?8DOedVPqMxuqPhifeYsaraoB2wFOpLDvyK/LvHVUiCQxWuOi3E/YUiqYKYvx?=
 =?us-ascii?Q?VTTwMtO4TvzmQ+IDUBHcWn7BAyzYYAnDJdQ2cF1LFnTRoZS7JVcYjK9FlJQb?=
 =?us-ascii?Q?8MB6G43hkFwB5InJeruRMfeFcuA/L03Td3Jy93Gv9wRrP3kk887WgHU67ZPI?=
 =?us-ascii?Q?8sluMMa8yXm/AM9Q5u/8tsMaiAj9Zl5NI+vsMnBWv9KrlOoECsaUfRWBsGs7?=
 =?us-ascii?Q?lAQRQTTAX4HIr2ZCNwExUh+VqNVyTHpjR9w414FrbLsT54ZAIKFPsBOp71mR?=
 =?us-ascii?Q?S5Gr+ExTvdDoX+FEhTRNvXDmJNLGSpM3uWzY34zLhd16AWVLNw6FeOh4RyjP?=
 =?us-ascii?Q?Bu99VqXn1De5kszd30I/xW7wFu8FU5jW+e3+IdjDY/PXlTSyikRPdYg4gOn0?=
 =?us-ascii?Q?L++7e4htA5Ayx7DJJkdPwCPWclmAK3F5EVJIuFZLIvZU6OIwuz27KwkBp9tT?=
 =?us-ascii?Q?vby0bbXV7TVwHi6g6I0jN+3sCR7b05xcLpLAaAbFT0GsZsdfba67NlpD8KhP?=
 =?us-ascii?Q?S5nnkj6vhkTqicr0fn936Kj6i7lwESAwsOuP5eJer69B57L5eSSBqEFpqu5Y?=
 =?us-ascii?Q?gn9JJpc43nZlY3YIG//EwKjl8TtUCnegB459IGhNqjs9YXz4H1+spXggOzT7?=
 =?us-ascii?Q?xdvMOuTAYdnhhvsNtZuwOLhYl7GTJsS6llSm5AAt8+pzs5GhcCBKU+ZPcG+s?=
 =?us-ascii?Q?QFM5EE7G4EAcJkmzq6aboouTxwgvzFCZKUwJrqS9IJhGmIrH36fTzpY5ZCS5?=
 =?us-ascii?Q?nqbmsXtI2Kite5Q4EuX8SBZcaLJocXVsllMGZmB5JS9v9M81bANnK0hcU3Dt?=
 =?us-ascii?Q?/mqUPj+x+jxsxsbp80r+i3x6dsqbbGAfbqTDmd52Z917v6jG6J5iEVbHyxY9?=
 =?us-ascii?Q?8DhsKmqYMMPVhR+Pz8yuSJbGE6eexKr3OjzYgzjPWmwpaB1o4USqg1/jCmVW?=
 =?us-ascii?Q?A1w5eJVWJnW1t06hRgJNbDIIlErMU1+BbHOunmV6SSu9FzwBVOg3J9jIIavV?=
 =?us-ascii?Q?rn+8oYR9buC236gilCMMPezQJHhL963zxg5TOs1j96jbA02kIRB13DofSGKC?=
 =?us-ascii?Q?YEUZi0MFqA11h/xc7xpUCz27l2u/eZPnoVJCodqzkeNzxuFtbloOsfyf85Oc?=
 =?us-ascii?Q?zCuZ5HsYly3k3r6kV+dfyqmbXpZeWHbqxjwR9Qez7dTQQrd6VmsU6by98nHM?=
 =?us-ascii?Q?5uXWWRG7UzNSvcM3BPkZxbZ/5IW+GACqH2F/HDfWvlynFcxMUURnBmHzK1OK?=
 =?us-ascii?Q?iZWDQgyQZW/0Rq4C72kJge7AhDgF746pRQxmB4vS/uHGmhximhgWoKhC5wAn?=
 =?us-ascii?Q?6RYwKc03vN29ZHQ6Yvwvn6NoB9F522pPd6XXpZTFO2twZBz3m70pkUY3+0YO?=
 =?us-ascii?Q?azQ6hMWqn3FpFYbPL/KG8MqectIuov1qV3GhMupoIWYuN62RRikqwU1Ggtij?=
 =?us-ascii?Q?9CymjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 02:43:54.9066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4878a571-94e5-45e3-8a67-08de57049684
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977

IBS_OP_DATA2 register will have two more fields: strm_st and rmt_socket
in future AMD CPUs. Kernel header file is already updated. Add those
fields in tools copy as well.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/arch/x86/include/asm/amd/ibs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/amd/ibs.h b/tools/arch/x86/include/asm/amd/ibs.h
index cbce54fec7b9..e9662370e690 100644
--- a/tools/arch/x86/include/asm/amd/ibs.h
+++ b/tools/arch/x86/include/asm/amd/ibs.h
@@ -99,7 +99,9 @@ union ibs_op_data2 {
 			rmt_node:1,	/* 4: destination node */
 			cache_hit_st:1,	/* 5: cache hit state */
 			data_src_hi:2,	/* 6-7: data source high */
-			reserved1:56;	/* 8-63: reserved */
+			strm_st:1,	/* 8: streaming store */
+			rmt_socket:1,   /* 9: remote socket */
+			reserved1:54;   /* 10-63: reserved */
 	};
 };
 
-- 
2.43.0

