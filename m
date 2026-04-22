Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAC12E173B;
	Wed, 22 Apr 2026 05:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776834438; cv=fail; b=C0O3Ec+TZgqCN9iw0dmen30OVot0DjxFD1ZythBjotlNmBYDQ28jxYeHaVhBqHeomJ12VIqqBFJKpUlYjNI/hU9bF+fKkO/8fkquvrtPbXqGisDfjJdzApvWyMpkwTvJCSMvdIGpFU9T7NsZwUVj2FklueoepvLBCjRiHIPPKz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776834438; c=relaxed/simple;
	bh=X62lAxnXm/PWKBP3ZgejZTkX7PBk+DD1kxTthVa61uI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKtUgSONXBvJej7ttsQZG4yRvmVAbgMV+MAqGwSew3vgTJzjpDxsHC0X1wkUo3hw4tdSy4fNsOZADtOD6BWVP9a8VkRgt2dQYgJ3pQxLHzchLaZS+ctq9hKZYhhLrMbKCEDiazj0yLfY38q7FfHKL5m4aL9QWQ2Ax5vARWT5IFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HaHp6apR; arc=fail smtp.client-ip=40.107.209.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HaHp6apR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9FDn9TNFkyY1SlSd8PCtW4Xlc7laJJ1H91/8BwrOBDlInMnGYnNmu2QmdhT6igO8/fMG0uMgk0ywWmL5hLFKJ3czoCwpX4BVI3KFpjpR5/h1D9g4s6HJGV2TtvafaN8dZV3xz40BvrADhotD5mNHc5NNv+NQX1B5xFdP6GVI/ujRYWODEA5YEonESOcaiYOtxFUYbSXzs6H0aVb22JGSavj0uybX14c1mpdNq2gnbc2fPaLPD/K8w6Qs3Sypv5//c5Dp2x+4UCyLxMyT9LTV2T0dlQEMF+vFPs9v1BQXTZNue6HT9AuJaa8hg11kOu0DnW8zZZdirFkFZd34rf0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yRl+25GMZkf5XOKZ8tVjWgUi4bLLkH8QK4iZaDL/w8=;
 b=P/17YVC3l48R7yc3CR5ZebuQuS6kyF7BMKs3WwF4kXCm5R48ZJyy19tM4WB2l9ilSX8KBXvfIXNC8Ht24a2flKS1sTRF/J9RwdIZXS6F2OEcI590+Jh+mvuunhN22sqy3Izzpap29thWTM3SIOho6DHlOeYNloM56r8ortTjeGBWZs7OVdMn826rKdTjYyPI1iKywWwclhgVwquK+lXWIQpnc//j4YGzcUb6ZasMxJHK9k5uVGOCBGWY3BrjhvCMLDv1LvTGFRfJ9ntlCJ/EGmkBr5ySU9O9osms4VnwGZt7IyBi6xTlBAP3q0sBVjiNvSZCKJ/tIG15mPv7Bt7Tsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yRl+25GMZkf5XOKZ8tVjWgUi4bLLkH8QK4iZaDL/w8=;
 b=HaHp6apRDu+K5WNuI5cLnXLBQezgbZ37pRZyQkPsKzqNxcosCZarV11CNv28EPNp8E3VmRm7g175nr/IRvU4KDYsI78qyDesjy1YIoUoSvWWDX9wb+QjaSqJYYuYfRJsdI/JiyyWshk45zois1hdUkn/mSBghjZQ4+JtADoGmpI=
Received: from BY5PR16CA0006.namprd16.prod.outlook.com (2603:10b6:a03:1a0::19)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 05:07:09 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::c) by BY5PR16CA0006.outlook.office365.com
 (2603:10b6:a03:1a0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 05:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 05:07:08 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 00:07:04 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH v3 3/3] perf lock contention: Fix SIGCHLD vs pause() race in __cmd_contention()
Date: Wed, 22 Apr 2026 05:05:45 +0000
Message-ID: <20260422050545.129448-4-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 3430da2d-95d0-495f-cae1-08dea02d0125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	b8wTQUTVyV/8e6B+Uqr8YTYg++JWZ0lTAJY8ba7cs3Ag8rKZWEm+CzamDkIxV63UlOl9CncfGW8nKn9CnqoDCJEWGSY7GVOD6CswHMo6aywC4+pENobaPDM5sd2fRhO0m9YXZqV2romFfaTVirHbgtZHoGd445KvsDq+Sq3tzuHRo8axhXsrBWa+vstD9wOIPujah0l6o2rTdG0GQooYzxRU5yGVFMyhdxE90kpQRCLhQ1W1qElBKQDtmbp9cJo7gssQo5BwVEz8IR+F3tNoEeWdLwwvNeMxed5Jv49Z7X2JmbbE43LM+sLEPvjUvGdYIyB0gnjhM2EMgDLbswhc4E7Ok5pZUK6UkrJk+vQ9leIka1O4/gM/HOB+uKzBlqkPfyvSLYo9D2BtuF/3usCTF0pIVe8mf8rxdtkY/q6DCtFPLIBwh1/1NqSL3/X6U5+47b6rv8w9+DW8nzSL54Hy7yoY4geC+y7EB6Qmj0T2eDwBTJJzL00ggRtd4htvwqYgXMeuB14eIt4zzP1tZKtBgQ6Kq2vuANJqBCO5OCu+JLSD6Palg0EedLPbLRRRCFXu/hRXEyJdv9BlBR1mFfFrz9GdpKE5WDjCJGF1zdfkVMvVsz850/UT1bTZev2ozORrRhE4Yz5X7oSwD1/8dv7ywbWNhLEjsDdfAiDdcX5kESLPbL73AA6rtgRdja8Dal2FEm6E+RQTkS+CJIqXuyAAo3zK2MBRzupn5QU6xqeG4MJhI7EbAp4vnoU8ctJ+rBe/UjP0PnSVASMEAyuSBh5b0g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CCmaS8vLdlaOPZa3QFARteNUX7+t79h7Fn1tjQ++697SZbQDl+VapOHmWfS1HWlK2/+8kygCX7kGCwmOtQzmGFjnXVihFdAL31ldSTaMNBjoZyZhoTnh+C8z1TC6/ZOGQi/sUNjSl2/aDwrlyTFcJtt60WE3yeWPSsiH8KJZD4jSOVUUCulAOSWpVjp3IoXXTjou5TSrthNXMQOtPM5irjAjwDpHr0j1i+vttxxyhZWh4fyZlgMdqNPnWecszuuOkJF/lZZ/WaStUsk18w7U+/VyP9ue10H7vCI/T17/hraCDw4FFso4YLXw7Z6sqOiqvpiMv13XHou+nBv2ysaBVuTe6d5L3Zt34S8HhAD9oR+Ip0jOkduhs5maP2uDA9V09DrCEfF4cal8W2QExsfDyE0T599qJDUP+7eMUOcL6U8Jm1+69yeBWftNYJTKgaN4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 05:07:08.5325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3430da2d-95d0-495f-cae1-08dea02d0125
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208

__cmd_contention() suffers from the same lost-wakeup race as the perf
sched stats paths: SIGCHLD can be consumed by the signal handler
before pause() is entered, hanging the process.

Apply the same fix: use waitpid() for workload mode and
'while (!done) sleep(1)' for system-wide mode.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-lock.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index e8962c985d34..3c165d632941 100644
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
@@ -2124,11 +2128,16 @@ static int __cmd_contention(int argc, const char **argv)
 
 	if (use_bpf) {
 		lock_contention_start();
-		if (argc)
-			evlist__start_workload(con.evlist);
 
-		/* wait for signal */
-		pause();
+		done = 0;
+
+		if (argc) {
+			evlist__start_workload(con.evlist);
+			waitpid(con.evlist->workload.pid, NULL, 0);
+		} else {
+			while (!done)
+				sleep(1);
+		}
 
 		lock_contention_stop();
 		lock_contention_read(&con);
-- 
2.43.0

