Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21BC37475D;
	Fri,  8 May 2026 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220052; cv=fail; b=mQ/Vy4nINUPJbw0zx0bpgDRpAzTcYo/1uN0t/cGHfs2C5eqqKNQjLH1sZPI2vTbrMzvCzjCzAgldNm1Bf2m1mY7ooiilBclOvGDT6H0in5NfhqjmDlgpO0kBZFlEQ9iNwmLHdcrtBJr6JPyJQ79q3lffg3f2v22s5HlI3YxCC9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220052; c=relaxed/simple;
	bh=jti+wx4RQEmAWZBIMC9thhgQRx3BIH0NLdA4brtV/8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8DFedUuFTB/TR2qZj8r5I7GQUJxzJXFzK2HwSRI5Z0kED0+W5ZK4hAu7q7xHD8lYW32nuJNg2ocnBKxy8AfPBCCN5nFidO4n/HjaLnIH43+NMywq23r7O2Z6Pi6kexCcFShzl+R091LqulyMIWJa5upfiU0Q5+7UGa5DV64Ssc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PLV2DQK+; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PLV2DQK+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFRkaFacZR61uDfUdB4pyX89cKeJgI2E+926g2PBE3BBlJSYhkjoyM5FuTTH87shH+tKOqJeX49859aqICkDXKM3zF6vnxjvqzM9xz1xVp8+bbzl9UaplAbUjejY7EfRkw9hrzh8nHaqFfwwV5ZyTsTG0G0raKpSnGLKkDXxezZKSEKSq0Vg3zahTjw7CE/lPkFfd2bQqCUURqPsL+vRA7VxTEqBEpy10ff4f8OOhDimE9cZMk9evuLTkExZDZ537zZ9jOtfxeRSJVMsGETK2NRiHyYoQfziK/mlGXohArTaSj8674InC+Rn7BHZJO6G46brJv3rv8s+k9kCHscYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKgpMmiQ5a8KubfLkliHhhH5L1py4OWe3rbrHp0NWyQ=;
 b=dVTyQgUCP8OQuQ/eI8xMsv+vQ50C1txjO5QNUu9urflTxh0k9JcbamA+3kea268njTPWoHCUqKMMlhasymGydUdnJe5KWjrGqW8Z+wfnPfeAe766Ybm2omVY5WpILMmeuLsyn5tCdCnAmE/tW7JxFtQx6RrVDjR9/BwFbY0ciGT/61Tf+WG6RYWie97Xd7TVg2xlqoiGr+G+MSQyeUaV8sV/+VItR8MJWEGWCqf/LGlLN5g6HbseF5lg1pM8E4SIZGedTaYI2DWip13eF8iuqaMzafxWwvaBN4pmiKfwlkZmJBBKH0zkJIEq1hemQPA3oEExw9Kn9jYT3uHUulqX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKgpMmiQ5a8KubfLkliHhhH5L1py4OWe3rbrHp0NWyQ=;
 b=PLV2DQK+T3LnZFxsgOJPUlKm4lEYSXNWp08e6Yw/6WGT6GeGGsBpl9ELYViKURloXbq12ThdjwcoUzQDXGKx3+XhOjDElMRd66VYduAEeapE6LEi5fg15KFLoOoRR7SVt1Z1pJToL7k8GA5/qMlmenkXH/scGDSRTlM7UmuqslY=
Received: from BYAPR03CA0010.namprd03.prod.outlook.com (2603:10b6:a02:a8::23)
 by DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 06:00:30 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::11) by BYAPR03CA0010.outlook.office365.com
 (2603:10b6:a02:a8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 06:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 06:00:30 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 01:00:26 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v3 2/8] perf tool ibs: Sync AMD IBS header file
Date: Fri, 8 May 2026 05:59:58 +0000
Message-ID: <20260508060004.2575-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508060004.2575-1-ravi.bangoria@amd.com>
References: <20260508060004.2575-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|DS7PR12MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: 35752cd5-e6b3-4ad7-6657-08deacc71c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mpGk2hgHp4PNqxc7lzqB2RNqFWpV2GUXKYAT9k2ftVUTJVXXMm1zZWHBShuxdMPInllIyOnFaVALJjvUZpBK9KjoKJQgvs+mLZX47KGugIZ4T4NPUTwF/XxWHVD6zlUBfYHzvKJqTIoCGov27v2TS8LzqWXLGH82Es/GK6CZR639jNa31UcY4flHAX2l73fpkosT2O0eKUbPwJNFC46iM5J8lkamOHfR8J4oP5DcNlUN4NHNjHKusvFzYtl6tollHfQ7qLD+jYsgUTdmCdq0vUlGzluoK4Bu/4eB1piNkqXJ724q7djcZUO0YbI7RyAhldLfKQxOZvjB2FY/1kXgzlcgn4Wx64noL2DdFGpFa5qoSh23VbURi5xJUifUAGFp/wY7h6zsHsCL7RmYFYtRTeIIVboksBdpebi3CSHcfUFUUG2FCeHqA83IkqAdecyovGbtCUKfb8XUrfFu8qez9+XYdwmQf+C+ZgrFbqYxxvLcFYhgbhYDTMFx2I/mE2fM585wG7qQM0vAuv+8U47B+GIZPzZk5K3R63w+r5OkWzpY8Yh2KUlCdjDtoPJVymzGhPT5TFtPZD3pmVBY2SLkamwsm4QAkKSBEYmYtc6HvVGG1AEdxdzrvjs+Uklp+mTs3dpAKAE/LcUWpHMiGCovgwpzDa908R3FRkJ4+Q4ostQPKCP9b24iiRCeUQCsDfUsRTIEUSKEX2B+tH207o0C3m7nILqManu5EoDvz/X300Y=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HyrqemV4XDENLiQcbenZsNgyP/JiM6h350zcwE1dWvCxDBq7MQM7SaUf2AWjdolQ3q7NkTQc4g0hjt1eVhKjapyVwI/SFcwZzjW2FqenYZgPuqOIZXYgm5WFHPBH1cq5u3UTB6bnkULysw9RyAjbg6D97K7S1Dgi9fxbglWCd92dYVyjRL5icraqtHzr/LWH1E2scQp9vVD00+S/JuzDc2Tiy9m1i2nlMn83RP5wQ9myPOOmceDjCZwvFaieF98bHyQ29kuociM17lshXnXATlW8Cjlenyy2x2FjPSwEj/kmo43pdT7CoJ9n7CPEafE/2cGYXy1SZ6+RWMZMEUIXc7hgxQ3Hx1kDXu6IQdkmZo5c9uap0nEgLYdDtvbmcFTfyUxiFw4JPqpypvf1yLEDNdIu7qrShYhs+ayksmHAMdQa6wKHdDdQgMOMfz5/7n5R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 06:00:30.6969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35752cd5-e6b3-4ad7-6657-08deacc71c61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550

IBS_OP_DATA2 register will have two more fields: strm_st and rmt_socket
in Zen6 and future AMD platforms. Kernel header file is already updated.
Add those fields in tools copy as well.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/arch/x86/include/asm/amd/ibs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/amd/ibs.h b/tools/arch/x86/include/asm/amd/ibs.h
index d0777b597322..6f25074e669f 100644
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

