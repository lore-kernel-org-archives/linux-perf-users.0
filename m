Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD943403E2;
	Wed, 20 May 2026 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272527; cv=fail; b=MclWRY+/LN+GnKuEFFso5TBMSa5Oh8z2dwID2/2s5iRpOK1rXgIJITXRV3gDzJE7B5gI4fyXwvsKSHIPgR5gUisgUfDVyNiMgwtuf9mV2XEUdT5GXyZp+3FjyqxF7QeeKhjD6Fn1m5J1orS4yRGYq4Y0/hhe0p94y126N+8xf6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272527; c=relaxed/simple;
	bh=Jt0rJG4riUCqOvNMRZIex50qrzhFkbsHWXex1Uzx+iY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dz2reTtAlgNaExzcxHIf+uXJIWNqVKC3qe+Re83008KcGjiHsYEh0Xo5C9oyizeoqtmYibVekswlhYL/5E3pm0DlsYc3HVtsHzitP+6LG8J6mkCB15xiHrGpFQHskm7MpEhcNBTsJLsHBRwBBhfZf+SWPJ5Od1/tcwbyGfNxmO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lFWhn+JC; arc=fail smtp.client-ip=52.101.56.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lFWhn+JC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpGwufu7YyhcAhgt1yHVBX4OUNTojdjmqUp0vU7L5ClS1ms1pd9KbBhy9Z0/OsmUK5MwTsXAiJpWgxxB8jzloTBo4mc9qDfHqLDOCLCH8ZlElDhXioxrXtbPjA0FNMAO2Xdrenob8Xrq3va8h2d8/WT5dSidFX8MspS4J/mqAGD90bzwsg3ZHr16i+t+YP+raTc82Z5JlHJGf7+Yn3pG7M9Y3HmQHyRD3Q6C0WmyBirI+dEIwTBoJo7zpmtHy+TK/e0nLXnxNL4xdOJ7hUXzzb9zjdlPNCfyVu3AykOrIn4tC9T9D/Pq4nNUTRjejqtYRo9gnht1V6miZHGx13jYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAFLPH18/rck1NjCIysQsSnH48YMObCDbfJFqPGwrs4=;
 b=mh1cFbHFO9zaK5GbWrrIm2ElPs2KaCJjnHjSJEw06gQwS4EWRizBeTseRf3uOSlDd0cbQlW2jKIrJwK0VS3cppnE8af+ofyKwkidf+GGfaUaDHq5vP6UJuvQGIKvD11loRUQ8LqdH45FyvDFauDtAOf/GgPZRCTF3ihsXCHrMygnX5eVuOgU4uU9s1P3ZEEouzfwqmCH8paAYyZUYH931Rru5JN2cVyQY8Ilq3gqPlPh/V5UIwIcqqh2a4k2oPdxeIJst3JDpC2YdVD/h1Q+2DsBuCmOIuCwskFjcNMSCOr1DjB5KZYHhFe5lAtSBI+hTa64/v40MlVvDJTXO9qopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAFLPH18/rck1NjCIysQsSnH48YMObCDbfJFqPGwrs4=;
 b=lFWhn+JCZzkHxjRzpL8dFL/PGAUFWT3tSi/PQC8eZF6fBB24OZJicO4Lr67iClyugJY6P+4EmV9wEApmgVlK0qoMBQCvqtTmFYQZa/VhVMpwKL77e+tjoBVXfnYkO7jJTqIrpfaQCRF+iCVBiNfk0MG+T5/gQ8M/CTIN6AnQ5Oo=
Received: from PH8P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::18)
 by SA1PR12MB9515.namprd12.prod.outlook.com (2603:10b6:806:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 20 May
 2026 10:21:55 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:510:2d7:cafe::89) by PH8P222CA0003.outlook.office365.com
 (2603:10b6:510:2d7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 10:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 10:21:54 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 05:21:50 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH v4 3/3] perf lock contention: Fix SIGCHLD vs pause() race in __cmd_contention()
Date: Wed, 20 May 2026 10:20:17 +0000
Message-ID: <20260520102017.293419-4-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|SA1PR12MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf22454-7916-4d2e-f238-08deb6599d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	LDd2zlnloy1kEo1q6GGg0BPPvltrwH2cZwNIC/SOlesZZpYNdvwUOi5L7ftpRq1TMB3jN+wHv4zwX1pCtiDk8I+V1HOTElwAKunyWujywmwGhNVcvsOq1vH1EopTM+JRsP0z51i/mP9p1t2f1nxiA1V93+cT5/LZofDJFVO4lGjk7jDIw+Pqho1a83riQ61XnRBwe3DztoiTzy9RPPsPpXwi4FqsDF2KKYlaefix1pkN4rUdvDeLr5fZuhXI1eMzaKWX98DdFLGaqHV+9rokKomcuHIgXhFbDzTfTszs6tTEHCUXZ9hEIsVY4KcvyX2hqzAZLI2oKjfIgasmtGzRXbU/MPpoT8GxC3Y4pvuMtI3hphW+RYlq+ddaKzH0eFxHExEfZhfPzded7+3v+pU2HboA0teIV0LusKhevlESlSo7ityrFZ6Tvln4gYjR8mB7NhDX0rk+kicYkgrk8QQW7RkrhlSrYvy7L237SFzQvzqQKVSR6y8fHqLX9mtNDYifUad+bybg8w+s6VIlSHVWdlP1SdiR7ZNrWQz+CLrMK7sDW9ifdIVg5m/Wqhi7i47J/4/ZOxTgcddBZ6WXm0s5/ToInNMbYGtIOn2OMfszBmeMBc5WmSimBhsp1pttbKuSKNVpUJJh3QC7ETp9ni4vPiCuQJbJscRAI6Z3GB7ksWh4OQ9BNhwQNU37DD79Qz+PS40O7VF0KZuUtJvXGk+6txYW1OdjPzbNQw/hEvM0M8c=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VXk2PNQ/9qDSPuNc6FcSIwPCC6sOO1/xnG2eutT/6b5rAOsD3tIyN2+j9dwwqgEDligf7+N89tczrHGcC+2Q5x0DCuNpRYUA+fzdUfaSgF1fWQa+j8Uyq7P+HFG21pJn10F0lE/riQL8HForJso3Ox7G+lp9dzxut2xWM/Fk+qHBeLsgbRq43rzjZge2861RTXXPHOTohzqOSavZDG32pqcIri2ppaPfAmFvws+J1xmuhb37yqcJCeo8b0+d7Zw48LRmqbJHJR9uZIlxgkgSvLayBSEYWGzva+sVz0uhG7lVP1ZSMArJxqc0A1U4bNXFa86WccJoVnycCnAYHd6/06wEFp88i4J3/WNKECAaoR3Gy1JLRVsZxsqhVaUAj+9UHpJUv5udSi8CxGtIh16qVgCzQLF+AISpcYw5Fq8V/xN4Vi6v77Dr0CGo7WUjPdhv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:21:54.4778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf22454-7916-4d2e-f238-08deb6599d97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9515

__cmd_contention() suffers from the same lost-wakeup race as the perf
sched stats paths: SIGCHLD can be consumed by the signal handler
before pause() is entered, hanging the process.

Apply the same fix: replace pause() with a loop checking the 'done'
flag and using waitpid(WNOHANG) for the workload case.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-lock.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 5585aeb97684..e1c033e3a8d5 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -31,6 +31,7 @@
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/prctl.h>
+#include <sys/wait.h>
 #include <semaphore.h>
 #include <math.h>
 #include <limits.h>
@@ -1921,8 +1922,11 @@ static int __cmd_report(bool display_info)
 	return err;
 }
 
+static volatile sig_atomic_t done;
+
 static void sighandler(int sig __maybe_unused)
 {
+	done = 1;
 }
 
 static int check_lock_contention_options(const struct option *options,
@@ -2060,6 +2064,7 @@ static int __cmd_contention(int argc, const char **argv)
 			goto out_delete;
 		}
 
+		done = 0;
 		signal(SIGINT, sighandler);
 		signal(SIGCHLD, sighandler);
 		signal(SIGTERM, sighandler);
@@ -2127,8 +2132,11 @@ static int __cmd_contention(int argc, const char **argv)
 		if (argc)
 			evlist__start_workload(con.evlist);
 
-		/* wait for signal */
-		pause();
+		while (!done) {
+			if (argc && waitpid(con.evlist->workload.pid, NULL, WNOHANG) > 0)
+				break;
+			sleep(1);
+		}
 
 		lock_contention_stop();
 		lock_contention_read(&con);
-- 
2.43.0

