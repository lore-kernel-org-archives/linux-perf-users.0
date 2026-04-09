Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAE437472D;
	Thu,  9 Apr 2026 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751820; cv=fail; b=Wz/J3y82dg5O6uGGXDYaNOdgCoFLG3NJO6XCXIjmHIse+xTEdBJ7ZwHOBKPW6XUFp901EP58kF27v3pWrjV4kMdsqLvtQK/hJjhS+fHwftg5KnmMtNPAViFCe78JqA4LRGHU+6BbOZEDa2RllUB+wtcpHwQM1uU5a1nYA8JWIeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751820; c=relaxed/simple;
	bh=76gU+HP8s7xpyT84sSNDT6/odFr3W7qYgpoBeO/NwGg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HVtj1libOnpkI5HLI9gt3k2fsb85+NbrHIuMfAZWet6fKNsiiLf61Yumi/BoQyRkhW4Vebt12vROXT5fQ8+fZhjOkn4SgWURt88XRg+qBl/5UeGplwOyDCypfQR2+lA4X4xLYwZnzpKegz1kB+kLW/i92OogTjs+76aMcHBjvfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uAl4Sh/E; arc=fail smtp.client-ip=52.101.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uAl4Sh/E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yS4IswCFcUsopNPaeLfalrkB4Q1E14UHPKT1WQAWdsoCNBkcj8QO/7Yz+vIAdcEzLqaBVhacptEPM70DO6U74h9W/kdn2a2xgsCf4Y0KGxJ0/DxMX/3L2pCgm7zvCni0IMCGc+YEtdkpuqxKnE/QXpxzqvuxtRM2ot44IliesWjxtIiGwzhFpoSXCMuZXq8hWDk8tsFioLHjC4PcdY5MJxtaINISaI64wue8vEmQnWX3O+lOn+fwq1NEDR4mQrtjaP6XDm3jwQupwdRITvLncrQtf8ICXnbw1gABggSCXWZQ+MrMl9eXF8VC1SyUzjII6feEovoVUGZ/TDr5saot2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHQFoDlw2xbWZFcw+NC+nF3CuWTdv/A93533bFtC/3I=;
 b=fCRT50QFKwBBkvaoYozPsz+vz9gS4aMPXS7kWfpjR3iba7hIeDxe+FtBXK+OUDmsd5oiWZgdvD8sBBN7qZPPqbMvvSYDkgw5rB9614/l+e8M5MBvDqDL+KcgInmDwj7D8/1IzhVwpU3Rqw7vPBDxnWn9S7wISfGdMFIx+4AxAS15iqMpnSGCawQjR0oTPN4t2+lIo0+PwgBLKN8y96731pN8/j/tOkpZcoKtUUYPkf6pv4gKvcYJvN9hJMzgpEbkCgsRtsDW9EnEM3X6nbHy9cBv8nb7IN368erIZtZnkPBybkhjVGfbP4z2g+TeASFri+UUyYv9ZcNO1oBIWLEXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHQFoDlw2xbWZFcw+NC+nF3CuWTdv/A93533bFtC/3I=;
 b=uAl4Sh/EdFniSHkR6L2oVtuxaOxOHGkIShGLR8NPOlXq40k1sBPrXnJfQon24Ydu1IkBg9lPiGiikoYs7zZxdhWYZDxnVkoGaqrzNEeEe71JR1NQ4TZTtyzyQYLA/F9gJ6g94jfg8gRZt1uIpjEwrhfYHv72xr/QHBdC5nga8ac=
Received: from CY8PR02CA0024.namprd02.prod.outlook.com (2603:10b6:930:4d::27)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 9 Apr
 2026 16:23:34 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:4d:cafe::23) by CY8PR02CA0024.outlook.office365.com
 (2603:10b6:930:4d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 16:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 16:23:34 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 11:23:29 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH v2 0/3] perf: Fix SIGCHLD vs pause() race with short-lived workloads
Date: Thu, 9 Apr 2026 16:22:46 +0000
Message-ID: <20260409162249.25581-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de0b24d-966f-4890-945d-08de965458aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lLmv06n/pAx0ZSxO/IXXIhscs7KAKCijpaZuyWou+cGtwSVhGyNuENxM5NhoDd/L7Gy42JPyG2m9VCIY11l/e5EaUsoVVyIffyaYiyNt3lT8EXticJXVR4giNJzuAuGoc6QalQOsRnMx5MTY8eZ9zAYbXUzSu+yCxZYemBC6D3TFls0xONDZKXcai0NYHe3syaFcInE4OuDDZ/YI9LOagRqADMSDPRIcSAWQ74KDjER4mVbg8xLD4gvKEMD73hyT5uAweg02iPms1Ezr4v6DjIKp7RwUd3daRgHaO1ghQzFqNVa9qNZizuSyepw9a+Ne3o4ggPPrYi1pmLfLfl+vneiIrHoF9P6p2jC6NtvCi7ge657ILLm6BbQcNgQcBU8pT6kDqarAXPQFs6L4qmo/XpXVLG8NziHtVDtfYTYJ6k1AjxySPzH8dDh1oJo6989CZ7xTCM3jIFHb8Z/w8ECYkp7nBU5IGA1hzBSrE7/fZgjfnX5Otv8lzmSOJQbFpq8rPEr5Lfl/EFrcRRw407igxgH9tVWxAk/HjlK9b6az31VAHnM5IvEeTy92bvbU8CMdonH+FuZUoecTqYNSf4mcQ/hXjg8MhuFRSgA3i7o8W/tEaqZe8i3inh9ywdvj1AqTyJ2hsz5NlfsYJOZ+IUQAsPYupU8CXeWpihzY7AaFp0VZKNTXo6jZZj/zlxOJ8BTf/lIDp2mozszCfzDHlr3qrSZDf2gT9VIDQBt3bp+CFHuclop/PvxeYRfuDT8mPYSMpcghu9vv038JP1N4zpP3Ew==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+738LUzN4K8ckPArXT/rD2ECFJmB79WCNPo72NDIEIn4xhdtudx0dPUiC54ab+R7SDcmEZLk3RessskhyH4bFivS0rTfpGhJvG4VukG5/ix1Wgl9DBLKH9g+/yYSw98EefMzwS9sEBT7t3DANlHnCUOGIGdDLY/byv4LE9O8IkqMqUfmSd/AqWUCvv9CEgCCC/gx4gQNbsFebY7Vn/M5eQhngoqTKR3BYMTueO2tOaVXTeKfpu/aaLJvTRK/DeiLwtom/CCPIsVr+QAXceRKuCiVlvoLcwMT4uTdkdVHBm65KcFEVzftlaAfuzT28dgQkRgQhl932pbpP+13TLuwxVSe3BpXn1JanpSOtBUjCGJob7gDdrVEXanD2MjCpGKp+HlvwibeMt2uwtNY/MV+o9gno7E+9mheTIuXUVrh3LDWZCa17tW6ty6L2EfInB80
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 16:23:34.1305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de0b24d-966f-4890-945d-08de965458aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590

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

The fix uses the standard POSIX pattern for this class of bug:

1. Block SIGCHLD, SIGINT, and SIGTERM (via sigprocmask) after
   evlist__prepare_workload() returns but before
   evlist__start_workload(). Blocking after the fork ensures the
   child workload does not inherit a modified signal mask.

2. Replace pause() with sigsuspend(&oldmask), which atomically
   restores the original mask and suspends the process. There is no
   window where any signal can slip through unnoticed.

3. Restore the original signal mask after sigsuspend() returns.

All three signals are blocked (not just SIGCHLD) so that an early
Ctrl+C during the remaining setup before sigsuspend() cannot be
consumed and lost, which would cause a hang in system-wide mode where
no SIGCHLD would follow.

Three call sites are affected across two files:
  - perf_sched__schedstat_record() in builtin-sched.c
  - perf_sched__schedstat_live()   in builtin-sched.c
  - __cmd_contention()             in builtin-lock.c

The two pause() sites in builtin-kwork.c are NOT affected because they
do not register SIGCHLD or fork workload children; they only wait for
user-initiated SIGINT/SIGTERM.

Changes since v1:
  - Moved sigprocmask() to after evlist__prepare_workload() so the
    forked child does not inherit a blocked SIGCHLD mask, which would
    break workloads relying on SIGCHLD (e.g., Node.js, Python asyncio).
    (Sashiko review)
  - Block SIGINT and SIGTERM in addition to SIGCHLD to prevent an
    early Ctrl+C during setup from being consumed before sigsuspend().
  - Error paths before sigprocmask no longer need mask restoration
    since the mask is not yet modified at that point.
    (Sashiko review)

Swapnil Sapkal (3):
  perf sched stats: Fix SIGCHLD race in schedstat_record()
  perf sched stats: Fix SIGCHLD race in schedstat_live()
  perf lock contention: Fix SIGCHLD race in __cmd_contention()

 tools/perf/builtin-lock.c  | 18 ++++++++++++++++--
 tools/perf/builtin-sched.c | 30 ++++++++++++++++++++++++++----
 2 files changed, 42 insertions(+), 6 deletions(-)

-- 
2.43.0

