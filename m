Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1883370E3;
	Wed,  1 Apr 2026 06:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775025745; cv=fail; b=bDJI3DL/m0UXG52sXu3MM7BDzClsMmgMyS0xjrzqTfoY1KK6QbeioovWszYPRbXloH9XN+DRN+fXNOhHZZTjI1bPh6Jm6IDouJOg4J2TvwjlqPySxyRd92P9z/nAyF1fMfaZuSOY4u5ajsLUu/qbVoJeBb3lBgZzacWKoRIKx/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775025745; c=relaxed/simple;
	bh=lI9wvZ87eMjVkf+MorNDlVxcfHoZ7sRo6jGszV61BKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urVJSGUOyxZ7iqu3akF8OZz8cfbKlXoiWgCdoHLSFAuWO4+LbEB4H2R+Iu/z1x/td8jWxDB/ZDmg42t+Bd6wEddIOqmjBjAo82j7W9pYgjT4leLOs8Gc5JvKEJS3r+8p1GRN+DbztyV8rUaazf9yji56ovT9KUUoNQXH6Ev5+pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kr4LyhLi; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kr4LyhLi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjWiFAx2pkZ3+jSsgwhgOiCFFctp9/AD1bQgY3Ww256EqHcZidvPAn3zvzB60pk0F34iTOuiKVhPalLTmgdyxg1gBCMdJC2IsLj5PMQfczeSwzhg+wAZHPqYgKiZ5bIoSPzl3efqJzMk3SWZwPNTzUF0Cf0wT1YV/W99UkogzhKOvcciq7AW3P/QTyBxoeKEXMypoMs2YcMsQZ2BSzC7TSOZDAe0hH7QiQg0/h4VdEhQq491FvU6BsKYKgtPRwBi/OuXZ1WYUJYZhKKeIemxEsRlE7xLjnX7x8nsT9ndQIKu70fFtgMhO5BmWpFEY2A03gW3QijpN70u0DL6zZMw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luB1tlAekKf+b303Xhib/yfc6ffd71LgdAyxIz34pSQ=;
 b=QugUSzpFefPL2vnLGfln+TeaV1oR9O4f9muxJMPyGyxrL8lrSpZR4MlU5RFL/A/cDLklYIPMplSKOEozfg9Wk3Fk7o0EDhGUEEssNuTRAXJBVHB4lSN6+vafqI0cs+sX+N8X4Vt5pl638o+wI8zqY4q0Jwz7EZ2UTt0tL6N6LPTAZs5ucH2ikToKopadNFTHS37cmXz3b8lFPKKUXwvUehvW0tJ8awybM/xm2O1dwNNtA/UehUYLGUUas6dXx9qDeM1jiIJ0x/AnjE1KMG4O2xwECuSB6C8tqMrgObsDdPjxk7AJGMmAMMOJRZyGjSR7bXPQyLs8r2PHVPgQYlY/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luB1tlAekKf+b303Xhib/yfc6ffd71LgdAyxIz34pSQ=;
 b=kr4LyhLicglB7PrJoBHkNslMV+Q7911vZuDCvQEB8IhIAhVz32zmugowolbV420RLnMtD7QsXpUnR0Bw4d5rZF3WkxBEop1Jisqm6tFARoaOtlNwAQjSyRm/ZFGUtnw4Wl/SD/gXrA6ZYSxjIbCXOogemOVQnrQBiiv98MqBtQ0=
Received: from CH0PR03CA0093.namprd03.prod.outlook.com (2603:10b6:610:cd::8)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Wed, 1 Apr
 2026 06:42:21 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::f5) by CH0PR03CA0093.outlook.office365.com
 (2603:10b6:610:cd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 06:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 06:42:20 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 01:42:15 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <gautham.shenoy@amd.com>,
	<ravi.bangoria@amd.com>, <KPrateek.Nayak@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH 2/3] perf sched stats: Fix SIGCHLD race in schedstat_live()
Date: Wed, 1 Apr 2026 06:41:13 +0000
Message-ID: <20260401064114.141066-3-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401064114.141066-1-swapnil.sapkal@amd.com>
References: <20260401064114.141066-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|DM4PR12MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 061a7efa-44f0-47ca-37ae-08de8fb9d314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uRILiw5uobqoaVF1tLtlQKDrxIQZSiUK+emBv2J/OWwQuSeMOSjKrzrZ0pTMvtk6WerebX0pUGFHKVXXVvHNmjRoxE9ys7QWUwq8XDYldwJ2IeCTSYQwyNtSIVJPRuGMwLdJ70giwStzw6ChwQmcfV3HRAX5zQPUnnZKPvTmKtoZIChq8o2A4/G3tcjvvPAIj5rjNLVcL+oxi5THFjYBEvOmydf8y8heSSDcVv6XP+HPBeTjNNHFwzmvPkIIyAYAAkY7sR2HDY9iK73QtWY54FXEQ6L67OAzuAUhJyGl3i+usCwSgFpCtPabhS7bNEs1+c5WESVgYMmGj8qSrk5lIFhwkItJuX6i1ImBdMkqeKJBUKCtnM/FyoxB4qNHiQfYmCbUjfwjFP5eYtvnY796+LWRjgVq4c43HigX+ZXfk1lohHPBfswYDp2ZiicAzQ6GFJ66dSnwosTRfQle8eW0j7L7IUz7/D7Tl0k+1oiAtixhNDRxzJwuhHb4p6rtoog2UeRYIPwDwLTcxrBRc8Mf95JyWWqIjXlJvhe0jXe2fIDilv16jrydWnzi2RodKnaojIn83Ji96TyGYuJrO7QqOsaOG0Yz1BWExnEWFYpVcjNFQmUTwECZpjHDbeNzfN2VDtx9ImPH+bf4mX5AxEBjghBISPLJaAKmg/s0Z9yMap4FZYn/MmSxS5abeCZH+tVWK1KxiEgdsBHetQ1FTx3aastp3ZL7GdFmtztOmWqV68SJRK26EtCK4YQvT2rmAHla+COVPMfUI1sNbA8kxKYFZw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PTRJfNX6NXNouh8LlMu9ntiWf0ku1Qh6v8fgXSeHeWDsXg+Xd38nWHXvDDDCuDY8+tbQynoNZZQdNpqbyYxejS0U1sseX6taPIHMNxsgS8De0AKfLZ3DcCveQY1oeu0sWXibfSBCOyvOGrO7LNn0AkfrKxLXoRyldBpoyKrPzvQeh3glR2s5J4q4kIFZStjmnMXATBlSYfOxuoNouqaqv/rjVaUqi2N+Y2Ml8qdducgihbV9DMrJi/Hs+x2dmDB2dpvPwvhhuq8SvljZeyaLYZ068ygtcwyVxa5mRv67wYCKQxZBZz4kU3pdk1/D1Nr+B0rPjvtt5C9xF/5U9/lD/yQpKwVfGBRlk9xFkpRxn9baPusohb8ogl9vZFHmT7KdEUbzeJOm3pgto30iZrGHgESDJ7Dpc5JXDNy/1TRi0g8jZccUYqLagfiHrLDUhS+A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 06:42:20.5690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 061a7efa-44f0-47ca-37ae-08de8fb9d314
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695

The signal race that exists in perf_sched__schedstat_record() also
affects perf_sched__schedstat_live(). A very short-lived workload can
exit and deliver SIGCHLD before pause() is entered, causing an
indefinite hang.

Apply the same fix: block SIGCHLD before starting the workload and
replace pause() with sigsuspend() to atomically unblock and wait.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index eb3702d98fd1..1d8f4ceda1eb 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4655,6 +4655,7 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 				      int argc, const char **argv)
 {
 	struct cpu_domain_map **cd_map = NULL;
+	sigset_t sigchld_mask, oldmask;
 	struct target target = {};
 	u32 __maybe_unused md;
 	struct evlist *evlist;
@@ -4666,6 +4667,10 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 	signal(SIGCHLD, sighandler);
 	signal(SIGTERM, sighandler);
 
+	sigemptyset(&sigchld_mask);
+	sigaddset(&sigchld_mask, SIGCHLD);
+	sigprocmask(SIG_BLOCK, &sigchld_mask, &oldmask);
+
 	evlist = evlist__new();
 	if (!evlist)
 		return -ENOMEM;
@@ -4707,8 +4712,8 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 	if (argc)
 		evlist__start_workload(evlist);
 
-	/* wait for signal */
-	pause();
+	sigsuspend(&oldmask);
+	sigprocmask(SIG_SETMASK, &oldmask, NULL);
 
 	if (reset) {
 		err = disable_sched_schedstat();
-- 
2.43.0

