Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEAC27E045;
	Wed, 20 May 2026 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272473; cv=fail; b=WiYF+qzoW0Ld5zLsPqVTKLUYfHOuKhajJmFMXHiBgQA8/rISl6HAnPy/jkrcgbpH/6P8kGetIVV23T3lecf48QJ/EN1XUF8Kb8LpC4JBtl6mFUhj638DXhiH/GZ07lTmydKG2sK3Wce/hGhkjNdWx6Rhd5VOMIYCd+q719aSN7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272473; c=relaxed/simple;
	bh=s8L7Ex62mIOcgmo3C4eGdYzVvvPmku0kQMX+Pz7ciz0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rFvfU8FSPeC45t2uFXIAaqmMRcySBYB8pHsaAUS5PsDYPHAd9xinmrgvSwNid6fB+uUfnCwDtm1809AbcptEPyrqmAEsdyvZjL+ddZkUas+Ku2HH7BOYZqHP1UCWa8xfiHbgffSa+ybUqj0lMhZzZPmkdR/cT3DezFL18AF+uxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0dENNT7I; arc=fail smtp.client-ip=52.101.62.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0dENNT7I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcbyB2XunhJuQRZvXLTfvzZspCZ6DWKyLWCD+Z5nnQJhv7TgI9lFAZ0t3ueRdjYyhjHV/BvBTAqnyrmxzLoAlM3Qt4ZLG/ceP3RUuXiKIobKbi3lUf9hG7PKB7tKQDTx7NGQz7fPXIGNX9zNseS4zF3eKlUqn870dYUyUK3YKGueyeXdgYpw6WxFTF1FhNT6H4+iWkfFfXicYpjhq7sSQkGOioezqhpdjmdnkMxgN7hqNrixhVmiElD2s5Molyq31eyBjgzvRiYGEprWLD5uAzzv+skdCKC6fE98cPaFZiM6TMSBaoqhIa5qsCCmgl+NhOI+VtzEeMt1fi+GIfL1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRJdMv5XU5hws/SvZFYwfBOosQNgkw7cnY06lv2rY0g=;
 b=ltgYd3uVnXkk52Y8MMWAkzOKa4/G0Wyek02ofutByqg1DLaOJYCq1vF5kAWg6Ze5GDdiCVi8X04zz5T80QiggD8WPIZkmHJbiQBxgyam4tPhhMinV3+tYmn6bfVboE6wQHE++rHXUjhWtw4ATlWvMlOlE1Ba1M5CT4RQyso4XhXZFWjQdMLobdWB7um681yV5BxnwsmydWL1DTPC+8HsFKXn5Tf7CjtyK0zY2VnNlPjH6rpII/cpIDYnSDhXREoey/mAVMWbhJBZF3xa5GaNb4UVylbmYCWh3tdDiT1Tf8iCoAgKRCNT+xgLm/ROyvgHh2iBLw5HxqFMc1GPRWWo/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRJdMv5XU5hws/SvZFYwfBOosQNgkw7cnY06lv2rY0g=;
 b=0dENNT7IFKyeluANeOuEGkg4Nn/+wpr2qlaUMHKRO9GmQiJ33rVzl9RRJND7yRf61IbfDKOETLPaPl2CGukFAd71OOslFzsDwHmsH/rqSAq9Ym5peym2W941n730ztN8vI7gHI4TkW8e8D/sorRi9LtgO24S2hTNjeoj7Tyj9/o=
Received: from PH0PR07CA0091.namprd07.prod.outlook.com (2603:10b6:510:4::6) by
 SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 10:21:06 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::6f) by PH0PR07CA0091.outlook.office365.com
 (2603:10b6:510:4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 10:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 10:21:05 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 05:21:00 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH v4 0/3] perf: Fix SIGCHLD vs pause() race with short-lived workloads
Date: Wed, 20 May 2026 10:20:14 +0000
Message-ID: <20260520102017.293419-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: d69eb84e-afd8-4852-126f-08deb6598098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|3023799007|13003099007|11063799006|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lPqccVEhBRt88oNzclhLi3mIdzjpF4nwa/40NKLjR9iJFUCZXSZSrW1uMWqmx9dgRfXl4q7gnSG/qpe6w1fYoE5czjdmrgu5pDfyCjbsMUnOU82Q1ArSZA81KFovJYnUOMIrGGMgRH7eF6SrMNUVGMVpOglbsM+616/fzHRM9RVGTVGx8xx+/hfKZDwIXHkoEmCNV5Wd3c2cc04VgDj84MjDvvgxIHaTJ+QtGuWL1W+QgE/kitd10B+kkjhShFjYYJgxCZM+ahUjXry2TBFHVVJ6zlPmkBZu9ij2s4V78+pS8/Xy+fBZwyga4T0QPSXQf/vpK0HnxWkRf/2ZGHAAKl1JXDXNRMBuWucKKvlmsJuwAxNvY2ZRIcnU28oyhvx5qT1Mns8sIyOVT9+dutyJoAnsO/2aoGPFc5Qwr+as+BVNmolG9ld2jF0Zpm2fwAVHVJuPewkdcItSGtVLRTAZtCdYMZaJMUox1YescxY3JKHiW16NjhoYItnJVB0sLf9gHu5kNEGdf7JQnEJUxJdJhdlEklRwbfPbXM7ppRfb12qx4d/HsmXlRWVyhbETRoUo0c6LA/pqQaPR91dOXVkHYy4gHTq63ePlZWjKz0VUKDLDJZfWlD6s4ZJGY9cE43oQV/wrbWiOemv7pkTzuSkwVBn1DPTzqYfQI9TmnBBAf0nCwY5wlzMfmPBqi+8YbHxGhd7ddqxeoVx/t35Y2QSkL3Ma5ypEONP+h4XarNVpxUY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(3023799007)(13003099007)(11063799006)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q7j/YdvQuuTBQnlW2u63c29stkszWII0NDe64DlHGZ/mC/WzM+vZ1LvR19RDhC9z9uOJi8phKCaosQvxwgYhv/QOIg6ZaTyoA6A79wx0wRBj8/bprj4YbUItH+aTMBzP1OEAV8I+Z5KJScLjDhaNX8nFE5vpBe4Cw6WKSmtpcaUIsKzb/3k0DF3vRgXRcmOyMcINXFhWfMWn16S9R5wAKfTFHNIIMeom2diq4iMVJDEm+rF7LMIImteSAPojyB7Ov+RWlgkroAgjX1uAGb3+UmuhJMNBbJrUu1p60UtBVGfLmQuRlGFJlWRXWW/3SE+3ZdwYA1zf1RNWV7P22APTzxYIWcew7mckwSHZeTmqMbgSEWuRwzYKub2ph3zGW5/pPCERLbKMZHYONlJcuPhzpGi6vQwcZ+Ya6LDdEgGh7frhDo3RzX/vk8WI31SFr65K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:21:05.8371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d69eb84e-afd8-4852-126f-08deb6598098
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601

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

 - The signal handler now sets a 'volatile sig_atomic_t done' flag
   to record delivery.  The flag is reset before handler registration
   so that a signal arriving during the setup phase is not discarded.

 - Replace pause() with a unified loop:

       while (!done) {
           if (argc && waitpid(evlist->workload.pid, NULL, WNOHANG) > 0)
               break;
           sleep(1);
       }

   This handles both workload mode (child exit detected via waitpid)
   and system-wide mode (user sends SIGINT/SIGTERM setting done).
   Using WNOHANG avoids the SA_RESTART problem where a blocking
   waitpid() would auto-restart and ignore the done flag if the child
   doesn't exit on signal.

Three call sites are affected across two files:
  - perf_sched__schedstat_record() in builtin-sched.c
  - perf_sched__schedstat_live()   in builtin-sched.c
  - __cmd_contention()             in builtin-lock.c

The two pause() sites in builtin-kwork.c are NOT affected because they
do not register SIGCHLD or fork workload children; they only wait for
user-initiated SIGINT/SIGTERM.

v3: https://lore.kernel.org/all/20260422064700.12345-1-swapnil.sapkal@amd.com/
Changes since v3:
  - Replaced blocking waitpid() with waitpid(WNOHANG) in a unified
    loop that also checks 'done'.  Because perf is compiled with
    _GNU_SOURCE, glibc's signal() sets SA_RESTART, causing a blocking
    waitpid() to auto-restart after the handler returns.  If the
    workload ignores SIGINT, the tool would hang.  (Sashiko review)
  - Moved 'done = 0' before signal handler registration so that an
    early signal during the setup phase is not discarded by a later
    reset.  (Sashiko review)
  - Used single unified loop for both workload and system-wide cases
    as suggested by Namhyung.

v2: https://lore.kernel.org/all/20260409162249.25581-1-swapnil.sapkal@amd.com/
Changes since v2:
  - The signal handler now sets a 'volatile sig_atomic_t done' flag
    instead of being an empty function.  pause()/sigsuspend() alone
    cannot cover the window between signal() handler registration and
    sigprocmask(): a signal consumed during that unblocked window was
    silently lost.  The while(!done) loop detects such early delivery.
    (Sashiko review)
  - Replaced sigprocmask()/sigsuspend() approach with the much simpler
    waitpid() + while(!done) sleep(1) pattern as suggested by the
    maintainer.

v1: https://lore.kernel.org/all/20260401064114.141066-1-swapnil.sapkal@amd.com/
Changes since v1:
  - Moved sigprocmask() to after evlist__prepare_workload() so the
    forked child does not inherit a blocked SIGCHLD mask, which would
    break workloads relying on SIGCHLD (e.g., Node.js, Python asyncio).
    (Sashiko review)
  - Block SIGINT and SIGTERM in addition to SIGCHLD to prevent an
    early Ctrl+C during setup from being consumed before sigsuspend().
  - Added signal mask restoration on error paths.
    (Sashiko review)

Swapnil Sapkal (3):
  perf sched stats: Fix SIGCHLD vs pause() race in schedstat_record()
  perf sched stats: Fix SIGCHLD vs pause() race in schedstat_live()
  perf lock contention: Fix SIGCHLD vs pause() race in __cmd_contention()

 tools/perf/builtin-lock.c  | 12 ++++++++++--
 tools/perf/builtin-sched.c | 20 ++++++++++++++++----
 2 files changed, 26 insertions(+), 6 deletions(-)

-- 
2.43.0

