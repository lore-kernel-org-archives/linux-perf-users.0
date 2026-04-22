Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40712836BE;
	Wed, 22 Apr 2026 05:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776834385; cv=fail; b=QiVI0Woveh8DUi7XsNjjOsIpvpXMDOKpkRjXOWFfQx7PMahp8VliDn6jkZx/G0Q7yo0jRzu4AnIx9KxmmOzqubtp6xj59a15xaGv7TlttIx3iO6R4HuOFViYAMd97wMU9pgUhZjHRbUeymdszo9Yl3vprHAog/hX4nbcsDFFaCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776834385; c=relaxed/simple;
	bh=FSO2L8XUGqII7213bm771Lf/rzHwipsHYu61UjuCJ2s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b8JDSyzo1/bL7RQtB8575ZSORL+LY71BaM2KFH9/v3AKOgXklIvQ7jTM3i3hgrRYtT8roglJYbf4wz0UcJNOYkNP/ac6VK2kIQRF1v+RTl+R1DB8Utlj91fEW9QB8A0qQWCmSakThhlk8/7sDAcPOPSBV6gU1oI1mGGeKgL4Tfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vq07awKu; arc=fail smtp.client-ip=52.101.56.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vq07awKu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MC9Ojo9CHETxMHnMJgsJOCDGtL/bQQB1nNcJpyKbig5K6TWDOFxW8VPWLYYTpPOgzntt/mFXhl2y5dWIzRYHasMcwbnVgjspX9W1Yk7ryX2T/5ORfbNYxPN4yaZQBU1HWNAEWqHn931L941gXFjKkh/s2jvPamPjYXv/clbbHV2drHIy2o9W0yjTjymotPuDjwHuYY0VcoOsLNmIZzAJxvco8no0b0ObppJ7yNsu4HmBpeYVSTFqKKsGm7ITtUcorYs25isUjXVenMqVevkE+Uk2ZFn0zjkEihefPS1mLLF6eM2CqovlKL9Dbc7LI1NPtAE4RWtZzj2pyTgJtBhPwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCi/f207oxzR+S4i1dgCfL1y5lN8HcdFG2URhPD0a8c=;
 b=kNCRq9OaQzo5jqS/cw0454Y9LnQBd2lBxbTT586kBw2kafqyb6+yoa6B5oTkYN/xcIZ+rjG0cLXnLweqqdn5TZ9/lqL6zdYLomCMIhg/yTR91JT7BcuxqyA1D6RuahuWt/3OWQSllYgbNTGy7sJeJ0Zw7b/bUwPrt5u4acPw8Rut11pjHxwpQxTYD9hDRIDwSLC5A/KWPu8C4GA9rJkygQr/gqe5ZeaZKcZ46PdJz08NvEltdN3dVQjw4NzxpozCwm4vh0WDlpF/oBzyyuugQSqXSlLSddc1xOaXQNE7XtX02koU2LMQdu7tVymtwkTn2MBh9AZmPKo5FY1+z37rgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCi/f207oxzR+S4i1dgCfL1y5lN8HcdFG2URhPD0a8c=;
 b=Vq07awKuSb2xFwtGxBuAwz7jhw8QHtlftec8LIuAsE2lQ4QoqEk0lIQjajwRRgfV9YomgS2/ezFAp+KBZ+vTqzrEge5F9MEU4ORkkmbDSh9JLOvnkTw8lrwiu6sccgi26PvtvpBgnhDo5OBvbzwizyqv4CDeYmwVS636f4MLgEk=
Received: from BY5PR16CA0011.namprd16.prod.outlook.com (2603:10b6:a03:1a0::24)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 22 Apr
 2026 05:06:19 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::ac) by BY5PR16CA0011.outlook.office365.com
 (2603:10b6:a03:1a0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 05:06:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 05:06:18 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 00:06:14 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH v3 0/3] perf: Fix SIGCHLD vs pause() race with short-lived workloads
Date: Wed, 22 Apr 2026 05:05:42 +0000
Message-ID: <20260422050545.129448-1-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: b325ce74-7fbc-452f-0408-08dea02ce37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	uS7DrYJzBxX0HHRIeei7tvnhcY2lKhcbHqTBXdE4LBqDyRXTdlxOHTIlioJYPzAGJfQD516BoKhxVlpl/B28h/DNHeDOqNg3BpSBKJ47ljZls2zqhjqq8kQdj76zrGN/jDwugRWp+W9I2g0i9qgsis5sVWLiJo7H/uBIdxhCYBKWuZvb6vEuvtPaw9/GzvdzjXrnDJoMhO/dqOVtsiFWE9H83z/+UJVtu1d5AfxKTAJab22Q/c8JSTLCmmL2qH7WWoI1EG8RkTgzE21zrFgN4ybtHon/MUQBmYgBnJXFmGdIsncUljG7UjThSu1GshqKwJ18HdD5O1t5MFVFycB8DQOadi+WaKSKOViJ26D8AbBrQKdSQJUqxChk/hvGowZmqbKKZUlhujfNud5gmtUfsr/qbK9xTcHQe1cbaCWFwFC4liFHmob8gU9FETmHPTGTVulC0jEWbV3FDZKjUfc5P1NwQdb2xVAl50CofWpL48tj+F4RL4ajRIAx4y4sNSAcF0YFVlEGvgex/ozZWYQJ7YewGKTwW/CYZjWqdBq+D54aK91jZNfGBt+j5SA4dmlB7XUuEOMF/cNbt9B5O+76tc2Mw4RXVg4OuQh0ZWqrWMkidNTrWz4hdagP64UjYZ2fu1uahEYkc/GKHKXGfJLI3VjYX2Gd5A/wCrJyCjIUjj59cf9qA3SnHn+8PYGJi7Ys4mzPLXS5SAHBjrXnjArYUuSafisjQ8f6BmVHsrmfJERpP8570aqke0MvhhEKZlHgwpJX/iDMuFlO+e18qWp7dw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JascuN5YW8NNeaC5IbZYO8rGeTvh6B/qun4LYeIH5KpCnBVaES4r1a5aWDtGH1HdxS0GxsIdcR5HI0+Fqq2aQxLVqjvQaFND6UnMiBc5HMz3fSeFAqILq2Br8czdEeAEF8TNpWAo+wbmqsJ98WzE5Mg47jfcn6xEX9FoKFe1yn+LxZdhkW/bgYvnDpvPq8fRv5aH0kvAAzJ6EBVH/lyaD7s3mNCOcNqiiKFtbkD16u4RDNCPdCVqwJUfmm6bX1RuElUs4XSddOLzOYqFpIVlizxLXOWlh0/j64Lqf/lyW0VfgOb+feLfdw+eXE2t1bwzIWGzxls7u/EiKh5JWTzjbwuOFQ/GmPptNTBf9htVCgXjxnSkr1ccSG79pOdYQd30rIk1xUvLqqSw+430yzCdrthdfQNebdUS4RUl46imMu1epSPZMd6PL/0/dtQQPgB2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 05:06:18.7648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b325ce74-7fbc-452f-0408-08dea02ce37c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690

Several perf subcommands (sched stats, lock contention) use the pattern
of forking a workload child, calling evlist__start_workload() to uncork
it, and then calling pause() to wait for a signal (typically SIGCHLD
when the child exits, or SIGINT/SIGTERM from the user).

This pattern has a race condition: if the workload is very short-lived,
the child can exit and deliver SIGCHLD in the window between
evlist__start_workload() and pause(). Since pause() only returns when a
signal is received *while the process is suspended*, and SIGCHLD has
already been delivered and handled by the empty sighandler(), pause()
blocks indefinitely.

The fix replaces pause() with a simpler approach:

 - When a workload is given (argc), use waitpid() to directly wait for
   the child process to exit.  This is race-free since waitpid()
   collects the child's status regardless of when it exited.

 - In system-wide mode (no workload), use 'while (!done) sleep(1)' to
   wait for SIGINT/SIGTERM.  The signal handler sets a
   'volatile sig_atomic_t done' flag, and sleep() is interrupted by
   signal delivery so the flag is checked promptly.

Three call sites are affected across two files:
  - perf_sched__schedstat_record() in builtin-sched.c
  - perf_sched__schedstat_live()   in builtin-sched.c
  - __cmd_contention()             in builtin-lock.c

The two pause() sites in builtin-kwork.c are NOT affected because they
do not register SIGCHLD or fork workload children; they only wait for
user-initiated SIGINT/SIGTERM.

Changes since v2:
  - Replaced sigsuspend()/sigprocmask() approach with the much simpler
    waitpid() + while(!done) sleep(1) pattern as suggested by
    Namhyung.  This eliminates all signal mask manipulation while
    still being race-free.

Changes since v1:
  - Moved sigprocmask() to after evlist__prepare_workload() so the
    forked child does not inherit a blocked SIGCHLD mask, which would
    break workloads relying on SIGCHLD (Sashiko review)
  - Block SIGINT and SIGTERM in addition to SIGCHLD to prevent an
    early Ctrl+C during setup from being consumed before sigsuspend().
  - Error paths before sigprocmask no longer need mask restoration
    since the mask is not yet modified at that point.
    (Sashiko review)

Swapnil Sapkal (3):
  perf sched stats: Fix SIGCHLD vs pause() race in schedstat_record()
  perf sched stats: Fix SIGCHLD vs pause() race in schedstat_live()
  perf lock contention: Fix SIGCHLD vs pause() race in __cmd_contention()

 tools/perf/builtin-lock.c  | 17 +++++++++++++----
 tools/perf/builtin-sched.c | 28 ++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.43.0

