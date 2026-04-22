Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905162BDC16;
	Wed, 22 Apr 2026 05:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776834403; cv=fail; b=ltuJGszaDGPuQgiuTedvaEWWfiKVkaaA4++M3FCjtO9TAHsPKry98DtFxPuwCN8Q76ORhLCCnu5C4uLp95TtWZUYgMPS3u93wrfZ3sTu1JM9wSLjG8Jksw2AgEqtKw5eQZ7KPw4ZGkF0ejr8mlMa4To3DMW1sUthpVC2nfHCWuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776834403; c=relaxed/simple;
	bh=PEgPHtFPbwlRQkZQy47LaYuSa8CSfJH8HJGhWBYegGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3pXow/NmMSua7CmrgCiGUhjdQpYwCL3hzHpRyHPN5l9EiPzUYiExVKe4i3jbzFbn7Pc4zXPwG3sFQOc/+G2GHnYQmRPki1MP02K6KJv5BhQPNJK2QBrXAAm8Koy8DOmXbYJXXX8rhXWmZVKEaZQTb++LHpSXngCU5BTP/hijqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GHDsQorV; arc=fail smtp.client-ip=52.101.193.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GHDsQorV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqGMXjPut99lqdqZzehLrrTzYjH3dTTLHRLfi43pfUhOsKG1ucix2eljAXRBGNw2pdJENj9be6N96Eux3UQauK9d6rPuJW3Opa8VRctcGOdoQ/jPx3x/V+vriQFd/uxi9a2wh1wYMfXf9lVIQYg2/GSxSHERfLW1cKsv0Trr2WR+0m5D7h3OkCJlPlDx6bYz+AgA+0RE5EgDgXdB2oM5R9IiFqgXHF6r5yB7d6XQ1jfelCxM5fUlL2wErrdlYHSmPw4sW0260Lw+Wy1VHKtXA7snkfBwa0eJsoK642tnjqD+yqTSPPWK7daDTXAB22ery7wefBVlnAraK31CGaIPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPHvLcXyeC14CRYvKcXSgmMXnbTtiQi1ioD5nB66/CQ=;
 b=jYQK0WW5nLRESZYlhFw9KXdXVZox2EdYhRX/f6tCnQd0H+1o+DXUQecWOmnOgd0B2i5sn+VQWlJtuXfJ/QOD32rJhBqcdHoPMqprSaeJXpzEHLWSSy3+gsolRXgeFU1GrM3vMJE1tNNxdEZKZ2ZOw0QEXIhOF/X1sBuPYqBbUXe+bMEqGmpwUBvr9l8SaIyaR5SBcqBQewTjpVOyQtFU14iDyabX4ex5mTLicUySsZlI6pP3iIO9jAtjJ2VQFXU8RoX0EnL/poduUyztPV4d7rRkF4iMYzXil+05M1gsUwoa+wtnLjHDXiFwEYD5KvXWU12GsHBYVZ9f6jS1OmYNJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPHvLcXyeC14CRYvKcXSgmMXnbTtiQi1ioD5nB66/CQ=;
 b=GHDsQorV/HWKZhC0I+evECGaPdFkJeYnKGykcoJu6X98WL+wTKjfRO4hUdBatEpFQwFpnqikEL1e5JJEPy/MLXT1YcdjAAn4ioCWgiPtx7AzkbHI/88xY5HPW90h/MX4SB0MF6xWbP83s35W1Se4glQhhYGZjpl+X7YECW3B0zQ=
Received: from BY5PR16CA0022.namprd16.prod.outlook.com (2603:10b6:a03:1a0::35)
 by CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 05:06:35 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::b0) by BY5PR16CA0022.outlook.office365.com
 (2603:10b6:a03:1a0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 05:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 05:06:35 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 00:06:31 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH v3 1/3] perf sched stats: Fix SIGCHLD vs pause() race in schedstat_record()
Date: Wed, 22 Apr 2026 05:05:43 +0000
Message-ID: <20260422050545.129448-2-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|CY8PR12MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac79da7-6e64-4f02-dc1f-08dea02ced53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5b+K+yrknmT8p2yHWUYjNzVQXuRWdERYBv3UY3AMCV2C4BIlU+AIxQ+XZ2F8vsQYlfB5jm1PYJ6oVb1NbOCEV/X7fj4uvfx63ZKuzzt1pjj5cR3P4tuSOgzNsl0i90/YYth2SAZDeoA5DO/Fd0xkPH/U5EFX1VJsGKMFlFjQnXIUCyX2PC87C/wIJp2HMsHodKlin2jMjRaQDCPAO17c9MhW6YvLHtnDVfmX5vdyjLl0+mvwRmpxPoefCAXceH/hL8BL4/F1tCSyjlL8iqRu4275Ty7csQMxKI01TRSo0KGopbVzzqfNZDO7Il1SQ9vqR9eN+h1ZyTASPz4cUjWam1VXc5uWwkCWxvdkJvV+o9M35KFZmk2JbOxGCOD51mOYGB4x4c9frFwH8XH61+7US3/VPh5KiaSe64CF3zA3YubZBqttDKmdKm1WGr6evqtXr8IiHYGdZGEtUjPQM4r0w+DOfzM2SaSiutUd/m4WWzmy1QtFPCxq8mO1WLk92q2PhXv/ZsdOwHlTF7IybydQSTdHHQV/wSN+Y31D4OC4kFonSIW3snFOFYz83RwTLkPvDS0jKIGirvHWxyBC3WJmwYnqkrWErDK7NjCG9ZW0iDAWn4q3Wwu7LTrh6I7TinoS7v0DJy+fkduUwHZIIPEcutQc1vPNMWgWQRhYUXPxPNfwoyd3N4/7tALIp/fP/FbMFcRBlilv1abV+dJ7RVIWH7NcQiInS5dEIxSCrOJMqUyDARmUAgWEmWIqU4vikl6I/3JI9FgJwU0kxImKAujbjw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mg+llaAIAB/wibS1sqWVUsdcjuFcu0xSawoJ3YHc0RIrTfCCDUgFxLmrxEavK+Q4/5xRwlf5c95bQ5dkOzexzqy/w0vN5jQVp96OpSnBaa9ySXyASKBuVMVF4r1yBbqY/yjIiYNyXBpfttjX1j4Pmmgy2avFZ3CSb5lI4SoWkHuOZEwCpLliv+GhAMaNFIA+Pb/6rrhftHHiidsmne2SCECJFchge5o1Tr73Ec47R3L0FKOoOaAe8fIgCfU4PXCa0jC3gv6PJJ0VrlcYh+HEY8IpmUZhVTAwnQX/xtwWZLixxQembXfCjLQT2lQXusItPwnTekNI4BHsoFCtsNs5DL31Qph+g7X0S9uegxuyR6ird58Txc7ThLcXSU8GcoS/LThNJbWthYT4lEUld4XZQ7iQ2Q3acbzDS1iatLx48cTYn8Hdxak2ioU3Zc7v9jxU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 05:06:35.2807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac79da7-6e64-4f02-dc1f-08dea02ced53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363

If the profiled workload exits very quickly, SIGCHLD can be delivered
and consumed by the empty signal handler before the process enters
pause(), causing an indefinite hang.

Fix this with a simpler approach:

 - When a workload is given, use waitpid() to directly wait for the
   child to exit.  This is race-free since waitpid() will collect the
   child regardless of when it exited.

 - In system-wide mode (no workload), use 'while (!done) sleep(1)'
   to wait for SIGINT/SIGTERM.  The signal handler now sets a
   'volatile sig_atomic_t done' flag, and sleep() is interrupted
   by signal delivery, so the flag is checked promptly.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 3f509cfdd58c..cfd93bf11c2e 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -36,6 +36,7 @@
 #include <linux/zalloc.h>
 #include <sys/prctl.h>
 #include <sys/resource.h>
+#include <sys/wait.h>
 #include <inttypes.h>
 
 #include <errno.h>
@@ -3757,8 +3758,11 @@ static int process_synthesized_schedstat_event(const struct perf_tool *tool,
 	return 0;
 }
 
+static volatile sig_atomic_t done;
+
 static void sighandler(int sig __maybe_unused)
 {
+	done = 1;
 }
 
 static int enable_sched_schedstats(int *reset)
@@ -3899,11 +3903,15 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
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

