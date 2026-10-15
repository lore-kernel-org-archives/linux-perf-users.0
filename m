Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7DC432BF5;
	Thu, 15 Oct 2026 06:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792044300; cv=fail; b=Swe3XFT4Ab7T4c/FCN3NqNkFWTUIPSczUS1eZBUgJD30q3O2NNKjcC5iEOByj4LXlj+ABaInR6tMTxY4zuSgI6PmxnT0bZvPFRhON9cL+onmVuIuN0bHu0xUT+lBUKk5baEeadGv/OmcKJW4399gNQrvM6siLPHYneC5BadtANg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792044300; c=relaxed/simple;
	bh=AyBWaZxS12nmEzYFWzsmee8CDsy5rdHjZfBM37f0iRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fammxyk3/u1I/qj6JS8ZCGPSm3XviIqBqVVRfvQNZePLhFg7ML/HD2GEvyIRdE/js3JFyIF4YdWyWK1yZXsPzjOIuU+JedAPiTxdmcfvKj+qriZfzSn0PvYMDxABP6GzQpRotYVp5UdY3kB7CIh8r6pK6Vfsp13O6MxQM5Q4oeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UEMa7kas; arc=fail smtp.client-ip=52.101.46.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UEMa7kas"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygYtVPIikFGOPXMAm7bqnA5zHL2MBZ90qy7jKza7MQLsG5kZCZEJJJJi48pFa+EE05qzrh2+l9wWtCpMJqw2/7gRVwt5sGPzbVHkAeApmsJQMH4DWuwstDwgcyIWOE367jUFSsoHGCskbTQKwqJ/lE8op0vEewlRZcrIPyplj7BeKaLfzeK/RNdNd1m9i+skZZOCHD+VRY4BcOnN3/WD/OEUYJQkChQIr42+XtA+3fp6KmA6vtSzhqEk0ASCa642nMsK95yd5JjKbO18chk537ygQPSQcmNqfu3bIgkLESStgbhHc7E1dlBbNLjdWWvwClJiMH/J8DDReCWtsNGRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxCMTULGFd0yaL5fQTBEiGQvDgyf0hGBmkWhp9r8uu4=;
 b=lCt4Yt8QcHgFkMHiy5dyUsDE5oL6OUs3jTmuFH7n8R9dsGWY342/+eFk9OiIeNT1g54O5MAB52SNBoxtOq8MbA/AuDKnajDGs/4cjGLE7PzlMrARHpwQu8Z18eE4XjBcxe9Loebc2lnxD0tBud22jhG5zWxOrpZmWncS7Ee88n0aKUqtR1sXiDt2ASLbr3eVyeo2wxq7a1U6RY8ShBA/7W0MOq1RFrHA62E7JvoRgzzfXMj5lsXQvE5/4NplsoXO2NCzy94woMLfY0WDsPDyPOcMkExwUcU+DxU7BXYOiIZnyYf2oqMXRlqwRcthhl62HP01JFmW1+xdlpb+JKLD0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxCMTULGFd0yaL5fQTBEiGQvDgyf0hGBmkWhp9r8uu4=;
 b=UEMa7kas6v8tdYPqlXJaq8AB6q3tVhC22uEVZEVtI5wY+4dIhmD1uu2J4PdEQNn88GtQUErTNvXDLKhJErYzdSk1UFHedKCbYrmWTsai3Qwa3cGjorwgrDDixkYC+qu4wKCNXP8JGrRtCwsXDS6373E6e8GloUJr90ku7K9kZO0=
Received: from DM6PR08CA0044.namprd08.prod.outlook.com (2603:10b6:5:1e0::18)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 06:04:54 +0000
Received: from DS8PEPF000000E3.namprd05.prod.outlook.com
 (2603:10b6:5:1e0:cafe::89) by DM6PR08CA0044.outlook.office365.com
 (2603:10b6:5:1e0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 15
 Oct 2026 06:04:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E3.mail.protection.outlook.com (10.167.23.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 06:04:54 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 01:04:43 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	"Jim Mattson" <jmattson@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Jayapal Ashwin Nair
	<janair@amd.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Santosh
 Shukla" <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>, Manali Shukla <manali.shukla@amd.com>
Subject: [PATCH 1/3] perf/amd/ibs: Reset CPU0 IBS state on syscore resume
Date: Thu, 15 Oct 2026 06:04:28 +0000
Message-ID: <20261015060430.5877-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015060430.5877-1-ravi.bangoria@amd.com>
References: <20261015060430.5877-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E3:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: a2961fd2-fde3-412d-c3c8-08df2a823b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xV9XHss1oV8cb3HaweL/Zy2mTFhKw1iBqINLwZHhe5YhUAbd0AN1ziK7rr2mPtNkhU/y1/EWRagPEiv+/86YZBSjXZAKs7ZUPn9GoBZHAB7wi7GV2oquXuMGKLCJfL7MSYqX8WX/fps8GUM39d6d3TOuHOPGC5o9JlrYAplyEQMXJwdm5Q17WuhrDTd2Xn6tbgDPzkrRzLqc6+/b7+GdN8dTC1IvieuY6dexW0ZQLywpWem+C1G1YIPhQfbcDcJtlAks+gpPI2mb5hSQvg3iF/c6TS1BD8wNLu4nWsOmMxwqOzXRnX0KA3e0uqV7AtgXQIdYkV4XIUT7XW5SWOMWVc5K2pPwnYohdEveygNo2EEr8PGfkegnWLYnf9IGL7Y5+7lu+lc1TYlKl9QllkqlqZ7qxnVlmbk6g22cxfm66QztKtV3pPua8OenUNdSjRTVeUpAR/WJpBfXYhLJvTdOakBRkHQBpEmmnYyN0YeEgW6oQBMPZqTlhc6w77bjg9tk/PJtOCElDLktszwhJJSpHmo4yD1+sw28JZIUo44s7T4a/5DNA/dng70OoMxlGcR1msrDekeXD234zN9//QYTqM5qGxPcIv+5JmSheuIbhBh5Jkdjqy802hXdvQhTZ3/U8UrBFY0oNvG2B4Qtt/XZO0p8k0K1zWe0pQt8+edqdNmIrb6ogRz8JyErpWWX3ktfoyR0j3L96ZkZqDetZSsmhQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	johUQH78wkGgjQ/OPjlDEMilJ+ckwQRT9W/VJMJxL+WuuL9gzUYNlMT4XPsOZPV+kWgmYq0nsiPc3c+onp4eoR37IoRuu3QU67JDombBehm6szfZeFIL+gPUwWtTqqJAFh24aJ0snz4jXbY0EorYWu/9bOSsVoGDsSo7eevna+myfUHxjVPuA9zg+gHRBld+TpnFX2dpM+097nIiUtS9bHGuZ5qL+nKheOrdMjLzJoglb3VR5BCF+fkZabAvBiCMxAHutr58OnIWvs5IBnMwQOU8/6BT/9hqb3/3Knnkcl6e35pp8TW+LoWsnrisMP7q02D1fxhjZVt3Pfi9jUGKH7xBPYVEW0M0e37hzAiNLM2KIzL3j5BbVo+kUh8UCOreP7s3iRSvGKDFOJ2TkuwfzvelmKbE3Q7SDeRqiFNukwpIiq/+2wpp65ZktPiRITa6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 06:04:54.1758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2961fd2-fde3-412d-c3c8-08df2a823b7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088

During a suspend/resume cycle, all CPUs except CPU0 go through hotplug
callbacks, which sets up IBS state. CPU0 bypasses this path, leaving its
IBS state stale after resume. Fix this by explicitly setting CPU0's IBS
state in the syscore ->resume() callback.

Fixes: efa5700ec0da ("perf/amd/ibs: Support IBS_{FETCH|OP}_CTL2[Dis] to eliminate RMW race")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
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

