Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C6D27E045;
	Wed, 20 May 2026 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272503; cv=fail; b=T3jJzDQ3SAUvijzOubGas9u17RK72C/jxwqHTOi6FXtDfmSpeWQCgyd+bRaiJNkRC7jxFmPt5142/3MfN03UyKerzSmqVWpRk5gTUoiMYNT8Hr7YX0BO1qWJ735h8zojGMhvfMt1yq2I3BdXKDx+eiaLe0AGY2hm87HTIZmn/TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272503; c=relaxed/simple;
	bh=PnEPBHwxEJ9KmE9Lsyccg6JUmV5ie/S0sRNkvE0nRl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKRuupinZrdt9eu0CBrV2BvTr1wnpKXWmc1mqknxSrwgxsMchhM7EIjcaAIDnbkwhUc7z7rJueD4hZiqguObEFrfZ8HidJAqHeCS0rQC7KIb14cMuqf+CVWsUEPUlGkyhk2uQIgtCm6mdMUCOcERt4BTh1QYgwtsE9VbLDGpQrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sTgUp6SX; arc=fail smtp.client-ip=52.101.43.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sTgUp6SX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jssnDugq7Vql7WWinMr8CmSeRKgE9k6NMtneAeyw+0IOsiDw11rMN9ESQDW7Al1qNKidk443xzPHOws8588Nc/7G4ScXdaSTTTw65F6E8y/uONTsSQXcDTiCmpQW15TxUjPD3SSS9oS94Wn4PIMH6UHT30hz0I0v4Slu2Z3iccjZxYTjL5MD/Z+ht+1eWO9GTApcVbNt7arwbfGtQvmMPAkeXDrTmxz1P9DiY8yEcJ33BXzSK5g/tyU3udb8B80Pm50YiChcaxdlH/GKLfBAicmDVYkOa5A83yrgfX5fb3RoEy8Bmoxab7+KartUWp2oU9yLQc8TgjnW0Kge0fjamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OlT3lvbG3hbCnSIAXwxNzWVgh2Sh8W+H+eheodh40k=;
 b=YBnSBQubiJZqVcTc1afzAIXipr+MQLUuOWYbmyPIa2/8xBxxaq2+pB21GSHaNIvgTDfYTkvwnRU3ec31XjQhC8wBUerF7BLeEXy0LCyLOWeTv05DEw7093ieAawdp5H2oQi4O9j5JhIKA/ys8gs/XNqjQDyeJ6h9OjGFSruguuZqfWjqc2PRAdDSjJ2H26rImIby5rqXAKVnKY1DsqB45wAOBMVw6uuj97qG4YS/eRZXYqBYXpTxXLwmAP/VPwwtG/SE5wt4JTvq9RKov2gh+XHVd64Z+SFumGnBfvU46MvsJkZB93yZHjKiXSwf1MIFbX7YA9zdQIED2oOe6f+EKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OlT3lvbG3hbCnSIAXwxNzWVgh2Sh8W+H+eheodh40k=;
 b=sTgUp6SXUCkYCUKdgQNe/L6gProl+Oh4t1rN9tLI/tjZwSeDovsLa3DDc7B8UwZOTxbIOBklffu7TMkcktHyalw2YkJgg/WDI+duMU4MZHbJSjW2TgyPF7Z+pa7lg+FChHO9DYoNX3woaoqecuA+oQWEfbzH3V8uOlbHq9ze5qA=
Received: from PH0PR07CA0091.namprd07.prod.outlook.com (2603:10b6:510:4::6) by
 SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 10:21:35 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::dc) by PH0PR07CA0091.outlook.office365.com
 (2603:10b6:510:4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 10:21:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 10:21:35 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 05:21:17 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH v4 1/3] perf sched stats: Fix SIGCHLD vs pause() race in schedstat_record()
Date: Wed, 20 May 2026 10:20:15 +0000
Message-ID: <20260520102017.293419-2-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520102017.293419-1-swapnil.sapkal@amd.com>
References: <20260520102017.293419-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7d7a48-b1bd-48c7-e436-08deb6599251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cywglpbe98HqFtbcFp0UA45A5nMDeuM9/zKsm68fpWxrUvLwSap3WC9wcXiM6UdSFotrnxaVPbR4jb40/sK4H+9Wx3ohw2q9udcow9mSQ1TrAkjDMfNrelzhGs+28a0eo5K2kM56INVvAXE+ae+tk/hfuN0nhoRC0wKLciJFDfKA/44krYVP9bbLMNFgfp3/yon6W89hoi6z1zSF2NUe3BSGso91zYg+YqrxtCikb1oUYeRApDcUB1RhmG7jDqpfn3TJCI06zD1ovUUrgHb3MS+M4xCsgDBrbLmtqKhlKZ2QJ3GfiLCvc/TFYgIOu36v+DdU7bIbkqRAKq+iqCdEzuIkt8qooDCcbqGsV6Innh2fPbsowzkKxegrSN2W92XLeaeTpxlWQqCjrWEdY2YMbqu2M8D7pmqg6hehruwbwxHtv6d71KLynzZfn7F8q2Slbnl8zvFSDehMqA4la5x2VwLEdu0koiM5SkkC9AVCkxpqZfBPhSk28qTgxlfnoNJrLZPEeyAEeFwgq8GEgPvnlha83acKoHpwD/tQ61g3kamfTIOK3LV+szYCE/tljau7qTwbKMAw5CsuzrGEDPnrFeDkZcF8vy/jj7eyy4Yz4g1TLcWg70meXWnacrielrV8CYSgFDe/McdisJnj8uI7ZSCD/QE4do+/QZ4lz5cfds3mYJSutNWe+UIA/2Trr9/Wwcu26E/LaK9C7fRMX/u57idtL5NTjhmgbXFW7lZWOOg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(11063799006)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OAYNV8ey98hKTieiYQtJ+a3GMZvjKXLIo6rm8HydXyA9J0b4wKCspfvgndV8Jk0GzNOSHP02OesM7hL3sAY5Duh6Ufj0DaAhZij3BaxIeHMlVVl3f0HZXxZgY/mT5Dju5OkpU63OYmffJ6ANM9Jmjwc7Vs21wnpV57ReVbjDsIf6P4Lj0bCxNk1lzLZ/iBy0uK8/q97gvxl9OwUj7SLGsfW8czPn9bqxuIFgMsGFhIGMT4sT4RErqnK5vzOYpeNB2S6Q52hK+j2hvK4UUzpHer0R3kZoiYgtIjCE+42fQ2TLpRveYXN5wNHC8d3nO2g3bQox3PVAGTou9BNY3pzkUfOFVXPSHCj5jgPiU6PdJt9WgcGmycYx0qZzi2pAYGoLM++SDUpywAFdhSpS3CKzg8dv6LT9rBvWOmpK7UI9hRnCCPkOKwzWckK22L80nlo1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:21:35.5645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7d7a48-b1bd-48c7-e436-08deb6599251
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601

If the profiled workload exits very quickly, SIGCHLD can be delivered
and consumed by the empty signal handler before the process enters
pause(), causing an indefinite hang.

Fix this with a simpler approach:

 - The signal handler now sets a 'volatile sig_atomic_t done' flag.
   Reset 'done' before registering signal handlers so that an early
   signal during setup is not discarded by a later reset.

 - Replace pause() with a loop that checks 'done' and uses
   waitpid(WNOHANG) to detect child exit without blocking.  This
   handles both workload mode (child exits) and system-wide mode
   (user sends SIGINT/SIGTERM).  Using WNOHANG avoids the SA_RESTART
   problem where a blocking waitpid() would auto-restart and ignore
   the done flag if the child doesn't exit on signal.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 53a93aa18853..7da71c372e25 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -36,6 +36,7 @@
 #include <linux/zalloc.h>
 #include <sys/prctl.h>
 #include <sys/resource.h>
+#include <sys/wait.h>
 #include <inttypes.h>
 
 #include <errno.h>
@@ -3758,8 +3759,11 @@ static int process_synthesized_schedstat_event(const struct perf_tool *tool,
 	return 0;
 }
 
+static volatile sig_atomic_t done;
+
 static void sighandler(int sig __maybe_unused)
 {
+	done = 1;
 }
 
 static int enable_sched_schedstats(int *reset)
@@ -3819,6 +3823,7 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
 		.mode  = PERF_DATA_MODE_WRITE,
 	};
 
+	done = 0;
 	signal(SIGINT, sighandler);
 	signal(SIGCHLD, sighandler);
 	signal(SIGTERM, sighandler);
@@ -3903,8 +3908,11 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
 	if (argc)
 		evlist__start_workload(evlist);
 
-	/* wait for signal */
-	pause();
+	while (!done) {
+		if (argc && waitpid(evlist->workload.pid, NULL, WNOHANG) > 0)
+			break;
+		sleep(1);
+	}
 
 	if (reset) {
 		err = disable_sched_schedstat();
-- 
2.43.0

