Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2B02E173B;
	Wed, 22 Apr 2026 05:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776834418; cv=fail; b=VeYHP8T/ndHsVcszrI0wIBVelgwTKZUK1JBzGEVyfl3uHvUr9l8whgGA/Ax419HxTSQI77ap2K0bWcYMMnq2OHYZigX71Un1cia04f3OKw7cD76KrBOsamIpA0pvOdQJjeu7pYbEY6gHMBv7nkXFUKgP5/TyzzMBwqTmSAztn9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776834418; c=relaxed/simple;
	bh=eRmKVieMb2GQhY7FLV+GuhjTyrJ/5jRV8s2yAiUwRpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzyEjWQZ4syVhdfMxT3bG1qxw068zeCEIGs2Ez9rHTSiQ/xStkKUqWZqNeHt0oORUOyVppUJsbnpRuZAvTskvM3IbTGCDpTpFXM+4ysXVVwp1OICpc6J2UZ+u+OsbcL/w5gQYjvJzk/PVNU3dkP9wLop+DHEs/zAgwYqEYKsG1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zMb8vq9c; arc=fail smtp.client-ip=40.93.195.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zMb8vq9c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=barJt9y7i9l6IISN2Z2q56XDNqtr0jwQ6GTDstZiFfajxbYz2M9nwjZ1LkmWbRP8c021yL66Ni8v8SH5rmuEWvgbkPY7CCXE6MLdgNnzYHZ4FhVNVQqGQEGbhRSMOJbUflP14NejSwL9B3FKgWRgZQmCyCeAdcQCMZnFY9sENQ8hCCEOpXneP3U+0YTNzrI5x7orfPgePp9vicg3bf47TfU3IlJ0g8G2XERTMXa459u3TTYQJvRX7inAJHsseNATiD/tdc26z9d/yhNtBJgzKsm5wYeUxFuQx1FZzCAWZpGFLtPwAwZ7hJVgzSRytBQdcv0FbOZiSG8Sc3J67RDY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiD3E2u1rQ4an8KSILuwSnhvlQsSqE/mAAb9qDjIOlo=;
 b=p+r7ehnD98cIDUYEp50CuawnUGgd7BZsdCMzKKYLmhisLZfZSXRUgkX6uG+ejKzabu5nCUswfAH1JfO82oXKB5JBATP3pEdsl+8U7zDhLLD19PfZUNpAyNcpRbTWAcjCH5LpIeGljEIBzKIEx6NMRl6+iveck+kN0wasJayag73fwPjo9HBUPfFp9kIY4G7N4Bb8ZqjrOceul7L7lTyDiLoP0eoi+CbfzLqIwl1Orxmd59vdKFJ1jvr78IhaJtaT0x6iNhDTSPGqKxUUr0P5+XIJM4qxmiKll+EzK1YSpfJ4O/2NktQBhsLOnmHFuVasp8HhOxJXjK1xbh2OgQWfzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiD3E2u1rQ4an8KSILuwSnhvlQsSqE/mAAb9qDjIOlo=;
 b=zMb8vq9cpCb9OGtQjuq0O8Cd40vGn4FYuXmqE+49q4VPEB2FzigAJTM00VNvbcyOHGwLKrJMkconnG2QKhDWKTF5Ua/AniQKJLShsHQ9onasXfibHHnE+wphgCsXTDVhdnQBxFwNBoMlTtuvUVYao1K9+kY/kb5u+5OLj/W1nBs=
Received: from SJ0PR13CA0206.namprd13.prod.outlook.com (2603:10b6:a03:2c3::31)
 by BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 22 Apr
 2026 05:06:53 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::1c) by SJ0PR13CA0206.outlook.office365.com
 (2603:10b6:a03:2c3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.15 via Frontend Transport; Wed,
 22 Apr 2026 05:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 05:06:51 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 00:06:47 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH v3 2/3] perf sched stats: Fix SIGCHLD vs pause() race in schedstat_live()
Date: Wed, 22 Apr 2026 05:05:44 +0000
Message-ID: <20260422050545.129448-3-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422050545.129448-1-swapnil.sapkal@amd.com>
References: <20260422050545.129448-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|BY5PR12MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: 43540684-3013-43db-61fe-08dea02cf73f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ID/RBAirMN5WS0HcGl+DDPdeF7JJEz/sOaTn0ok7rOtOwAPGxuiGL1Q4crtfpMlUuDxxBWI0cKIXnGMit36MzuCCCToZIG9rJSgFZvhWuEojDeaYEeNjq0B2t6cMUYWCpI2K5ezDjpT/zRXcJs+DO8AA2UtTgEGOk3aMhZvKcr/MRx+pg/YihdodCWPTvZunpWKW/raMwS0lbtpIpyJJb/fxjhQ6Nl8Uv38ADeWcyaUCu4nFqtMieNnunh4G4IMpJyWUXIkthiRLsU9O3nTKnltuyfoCWssyalewV8BjNKZMvXpb0s6/mvgDr/Lg8wlAExiovM0bBiIkWrr9wwgnqsN2HGGvZu7Y2n71Xn9eN1z1HL8rcDkg11571zEEzJXnn1OalpwJTLqw2OeL5/aYiT5Y/rnQCwO0V87ENtE4WEtrWkduS2l7JrkYlSa59mJuJLwX0WPXDOURj3Eat037mqIPtUTdGq61T2DNOgY1VWd6YEUtGwbMyjP7HIkLURmYgjh5JLKo8et4WDzRFdn/nhtBzS9YFHgR73fjZSHM8A+yX4EV6GBEsJpjtrXaMnOsv1CG/EbAtxngX9G3FEvee0Dap5Qk+hiqp7tsbFHfthqRYugwDXn5YMcuRZR4PlrNa0m8MMklXdWjp3WM/wiGGdx+AFMFaQt3I6yLHrQT0IFBUccdM8dARXFSbWnmoiCFRhGSWotOUsgvkpi8iewjG6bBrbOk1IWXlqhaAHdSTWO2a2IY0coQSQEOWvho7TIVbPnS7GtnMRB7l9DIPkNRyw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZgSoJFTDrRxN0L/3/bxS3Hw/YXiTiepljFVLdyu+h2sacTik9sNgjTu0EhBG0l0Yw6oBTM9ulV3vL1ozZPWnoXsESM32k9H75ikATGXj12iJcNgHvy5Ibq1EgvzqyWgvOTlJPYmWNb3HVQzgXZqkupsT8e0ColW9EOFQnsMTo5wcdd99dUDIQxukkq+bo1pkizGWJkLyjCf57tnN+M8+SB1z+OffsgUwyjEXgxaa+fpDdjgcRYs10or7UJc64wLUXOaRNyPQqMIm3QKmXU40XH1ycz4+qw70r/vDI6pujV/D9fAwAzKfZ4s74trYsGky9BumxcAk07NlDiQUpiE2N2jGoOfzDoAr0BCGilldTh7y+zO9ENOj40F5P7cqrjM1ooXWFLcRnFTjAQCY526SoqqXwUJvmtUNzcc3npevkeYRZ1gvykJxh5QYK6M21ffq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 05:06:51.9511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43540684-3013-43db-61fe-08dea02cf73f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274

perf_sched__schedstat_live() has the same lost-wakeup race as
perf_sched__schedstat_record(): a short-lived workload's SIGCHLD
can be consumed by the signal handler before pause() is entered,
hanging the process.

Apply the same fix: use waitpid() for workload mode and
'while (!done) sleep(1)' for system-wide mode.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index cfd93bf11c2e..36fbc20dbebd 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4695,11 +4695,15 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 	if (err < 0)
 		goto out;
 
-	if (argc)
-		evlist__start_workload(evlist);
+	done = 0;
 
-	/* wait for signal */
-	pause();
+	if (argc) {
+		evlist__start_workload(evlist);
+		waitpid(evlist->workload.pid, NULL, 0);
+	} else {
+		while (!done)
+			sleep(1);
+	}
 
 	if (reset) {
 		err = disable_sched_schedstat();
-- 
2.43.0

