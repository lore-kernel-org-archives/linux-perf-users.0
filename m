Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792988356;
	b=XMVvrYza0X3z0Lh8ubZEeW3YmfOiclY80SbnjgqLsQwBRqM8UGS4E6sC2HQgrqHEBuxj
	 rRbW841saDuecMezDsy90mxY1WAN8BsW+DXhBiQWHrJbywCI9cgx+bVPQpwgUc93J2lDZ
	 ZoPH7ccXxz0Vw+Wn1JA0nbtnNtXVMhD5b16MKPRRGJviAD65CJoMKd/Nq99Gx6gorD6Cz
	 jpdWXr2HsqCrxiVUGMmWJF+18NU5Kfk4uijcd7prIxBLNeTXEBC9e1dnfqX5+lMzvsrJf
	 Weq/rRoftmptpoJyEqJ9mliQRWv8gPMoDyKkyTBTLtrbNZUsF5WEUUXKQ2uUq2u44pA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792988356;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Mvxju5QfJBX9d52uchimZb1v9K4bJDX147BLM5KZGYk=;
	b=uEGFHTZNTp78ucijHM6gwwKrOx2ACT5G5KgS7HO/rUQov1TFaypv2MlCkrgyTTZNU/uM
	 r98BeT3FbNqO3RoQdziyE7sg/eT+lsr2hMWTc43Z0JOEhGjSNDQzEdZ5qzHC1uAbJPeJe
	 fzK1kjCL3HNkIdZWDVjUZ375lrhao2c0fU3BUJDJPwwBUyrBJyGeCSXf3cDynTCWjc9HE
	 /kR5AyMT2/8BQaFVlXLMuoVYkaC8ymIONQ374cJplz+DUgikfxMoWUp4ofFkk1FZUyiEB
	 LY+zogY5qVj/owohe0cJcf4KuztisCzOytkiShTy+Xz0JlQNsDi0BV/q7/yJ7PIQfvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tjx3npli;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.11
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013011.outbound.protection.outlook.com [40.93.201.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1722606A324;
	Mon, 26 Oct 2026 04:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1722606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tjx3npli
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kh1DgI3WokWX00Avk4VgDx0L8CizlMZYcb9mHpJARjxyj88xwynZQC1Z1glvykljGKh6a4YqrMvVo6PiNEiHwyvRalcaK3ohKenz+2IOxeKv58WvweUeflOh246atRJ29aqaPk3xYMjg7uh2wxkq45VgoZuHR3PI4hookxzVU1/ku4Ac59pFKHCFwwFzOc7MVCY3EiVK7f22/j6ylNKzE39ubebYGqh7Fkz8tliBCSjBROGpclbAX67i1bIZ/Om71HysCTVizaorpYf3LBEe22b7/61UMpxkjVMtAh/O6ryM4oMGW9bDyrO//G26tBtw727Cqx+yiVCPMlfi/6C6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mvxju5QfJBX9d52uchimZb1v9K4bJDX147BLM5KZGYk=;
 b=JEBoOZkR71IEG277YgryBZ2/XiJVjqhA0cXY0+V+qQyBkJCGPFT4ARNpmPhcXNan+3SMK+vGMDXugSAsIKzS9vDEpbegSLxpre5HwJuwkLy+jVQiWADc6BUC1bxkvGtBGgR+OJrQPsoFx/9GWR31sP4zoGKAMQ5l6URD4VAHYHR+IoPG+k1F/M+VWxaUadVv2V9NvfhSKbw1Bd+BB7gdjWZoOJJ9o1P7pVejqBodCUEKXimjM+P1XhgVhUIUdPFouYG9SWe4iTpJAPoPxP8ZRTCJvsWyilhTUOjPUQvHxliQ3hMwv2X7RSL4iXrauVx0jkrGpcqTWBTyUpHlvX6nPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mvxju5QfJBX9d52uchimZb1v9K4bJDX147BLM5KZGYk=;
 b=tjx3nplib7B+owspcQWoZwzn0xg8A43VPWnpMtvFYbnqIsUCRTZfprmCT4jKKYEOgOej/CX64/y1u1lHoBdjhq8vMfJ8wU1iZCshR8xYGd+iv4GDIv24fJXzUaeBojcwrqVY4HZ+z/aFIed5PK8fZ8G2qYUeRuBLgPNF9cRnSDY=
Received: from SJ0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:a03:33e::20)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Mon, 26 Oct
 2026 04:19:09 +0000
Received: from SJ1PEPF000037B4.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::16) by SJ0PR03CA0045.outlook.office365.com
 (2603:10b6:a03:33e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 04:19:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B4.mail.protection.outlook.com (10.167.244.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 04:19:08 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 25 Oct
 2026 23:19:02 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	"Jim Mattson" <jmattson@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Jayapal Ashwin Nair
	<janair@amd.com>, Gennady Kupava <gennady.kupava@gmail.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>,
	Manali Shukla <manali.shukla@amd.com>
Subject: [PATCH v2 1/3] perf/amd/ibs: Reset CPU0 IBS state on syscore resume
Date: Mon, 26 Oct 2026 04:18:35 +0000
Message-ID: <20261026041838.941-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026041838.941-1-ravi.bangoria@amd.com>
References: <20261026041838.941-1-ravi.bangoria@amd.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B4:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 5adbfa9e-4fc5-491f-5b7c-08df331847f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|23010399003|376014|36860700016|18002099003|22082099003|261022105027099003|261022075727099003|11063799006|261021121427099003|261009223027099003|10067099003|56012099006|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	rw85uJIc1d7Z2hNq9zTEdNfSF7i/8k5skGFalnxz8p1EkkERMRbpSR2Hamu2YjrS+Y/fON8UlRPBz5ob3mbLjqwD3X9viWhDShyCidpATSuStcoPGE++2fYL8krSELMCgcRgGJXIQeOPrAu7XiLwartUL7u8+lyn8P9jYKmZ7sPpM+b6RW6fwHY9jwJa18lfiOT7TSNnNOCkpBa6xxDABYjy8e0Wj69wgjUJ3u6yGdwoaVz57RqFJ88omsYidTyjU+KnK7UUGxjFfSxm3CMUl1ETDR35G/pZMeOWTvYCnVHvV9SALfc2SOSASgz/AVdNkafEMyK7Q2A6HEz3+HjyzM13tLiCakPTtYhlP0IJsm2fLlEseXpsIs07RaJlFgInIXTp6Tm5ihd9iQQWDTFNpXwH6GJ/QlLVLtFkMKbptQqlGk6eGhMEV8H9NduoZLcWBolsecsCqxNyTCwQBmBFeYpscXFR/d/oqeWff2uK/fikI/5nvPNvl7y6YZV9xv5BXpVEeh+6T3To7f4VQKInBT90xDdRP7uSSldYcLX+avibgqwwPH2n41C+JyuDf6nl0c0U+BqX1LkWTm2JnAqHPUGK3IdogS29wus5nr34axvzZwiHZspbLkv716E4ibVjFfSBuRdEi4ljuYv6JTMBjLFgVAe7fdvOQo05vvmwQ4AEI9+JFwUknQ7V0D+ozC73jY3ZsO+sog3mFWtSH3CyVQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(23010399003)(376014)(36860700016)(18002099003)(22082099003)(261022105027099003)(261022075727099003)(11063799006)(261021121427099003)(261009223027099003)(10067099003)(56012099006)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YYktoKm/N9cm1wqVGRhv6ecy99a+7kuTZL5y5Tx83Yfnt8x5iezEUV61zHN9TtyJI4MbwgKgajLeEo+Lkap/OJ7gV0QHm5zURTAskhqaCkO3EbgE4ZimuN1PIr3Kz+3okhDsuhb+RCMjUT11B7jNAvUN4MM1wr9SPUP9Jbvut8YAgHYfNrO7XI+IN+DwnWQP8IBmb+Uf5Tg8c/j5liL98a36gbNiIKY7eA3ijPNEY/1zyyGpJaJsc8rU+auKLgIT+hWcc7TDT9xXUXMxtcu0LRVOXg0wceG3e4zfZO0JiN8mqe0N92d93RUDiD2q7RmPfKz0P6a60kX4ToIV6jHXhzsplhedEzmlEFGvyJbzUKrvweDe2GApoWGXAkNaG50UmufrSWWUS5ZEcoxBbJ9SYHZ/9H0skGbPOuZKfISW+5aX3ONeJcjBGiAgcoHfeT1w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 04:19:08.7927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adbfa9e-4fc5-491f-5b7c-08df331847f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718

During a suspend/resume cycle, all CPUs except CPU0 go through hotplug
callbacks, which sets up IBS state. CPU0 bypasses this path, leaving its
IBS state stale after resume. Fix this by explicitly setting CPU0's IBS
state in the syscore ->resume() callback.

Fixes: efa5700ec0da ("perf/amd/ibs: Support IBS_{FETCH|OP}_CTL2[Dis] to eliminate RMW race")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/events/amd/ibs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 3531f9c23b8c..bfb51f8e184f 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1948,7 +1948,7 @@ static int perf_ibs_suspend(void *data)
 static void perf_ibs_resume(void *data)
 {
 	ibs_eilvt_setup();
-	setup_APIC_ibs();
+	x86_pmu_amd_ibs_starting_cpu(smp_processor_id());
 }
 
 static const struct syscore_ops perf_ibs_syscore_ops = {
-- 
2.55.0

