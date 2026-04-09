Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96573195E4;
	Thu,  9 Apr 2026 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751841; cv=fail; b=ZWygd019XzvUoxLxns69iU/cnG2i7uO2MzzN90r3YLla6eGSM4bkbaGk2yEFwbBDeWql2DuB9QkVgY/HUCm8VoCpHsE7my86f7qYIGEZ7gl1j0A/CGvVg0Tzn7IcMjIF8nQhuRUQgp5PRl4sJUFeVixpnTtwscxxhxGeHoqE0cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751841; c=relaxed/simple;
	bh=XqOOwA2O540R/+z3T/cgCynSoBnXgQ1C7Mlc3PVFsww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3aqr8l7uJxpMuhp4Y0G6B1cW+ADLF0d3/T190UvCRu4elDv9svU5+8IkiN2RNVCArwEd1EgFXKYbI6JPmQc0lRRSAv7hzzUgk19z9HEw4DOx1cTI+2dGPDAgyD8537Lr2JVeklM48oGLaqPBJ7h2xhZdciQJQRlar83fx6vwKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gBzoj7sL; arc=fail smtp.client-ip=40.93.195.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gBzoj7sL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRGwupv8mMuFdZuDm1TWVBcB7cIGihycOEg0rQUzHxnT0E2VxPtJkRObniPp/MpM/piJ5Os6xRYP8oRmzl4sZ7NvqTQaYNiH1wIcAKpePOaXxWGbwQRevDGYpSwAhSRd+z6tnqvCRKRNLwN2dzZpc7mD2emh1eIvgFnMi9ecED6rYJxoYHOVGmyXbdoXypgjAuIlKaDMKzfr8q/BuNn8oz8c85H8LgWCmsytWk2BDkOvgMcKfcb9OXVkL37vA0aK2xj1r2WQ+np+ZJ9JYNWrVMAsGjihkypib6A1ZkypUsuSuK4K2L1ewQiHJFGkyjs838GFaRMiQ4qxrFj3ig4Nfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLL6aRD4HGzaTrkcI3J9Ug2WWHAUoWWG/0zIx96prg4=;
 b=cCOI61mwEdpkPXyjrQ9GOrdJhnqUmlUQNBzoHM8TDyj0u1PUGABnxOXacNRMVqL/vKgVF22L6l6aR3Aj7toA6pSyBBRXiTajnJcZp6KhMxDWa6SLywc2dQvjJ7K5hsQf/4wNc7L63EimnHWVyjWgzs3Ck/voh9A4t2gVScXaRve//5nwUfUoi5W7bc+P0rhSH8JCfk1YILthK623XV2AjODp2gFAwLSxiOjPGQSeGkxxG46MXZCFhUrKv6vruuCryF8eazj3h0n4qcf41ngZxkH3dylEwT2fzd9yhuAomMGQJs8g4ygWtj8xSmPVYYmO8Ppb89yZbzudn5Oe7asryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLL6aRD4HGzaTrkcI3J9Ug2WWHAUoWWG/0zIx96prg4=;
 b=gBzoj7sLn1lv5nZg8u3bGDkbbx4L4FtOBYSfaG4fmgRD98KMWHv+3Np1zdMF4b3bKgRKxOZ8pEA1AbLvyQkFXQz2izQLGn8X6dQg0gklidZZrgoH24gIhMXUoRcWEFPh25SpdXzFNl+wBzAYlrZNjn6I9ybUGsgY4FlnlAVubMA=
Received: from CYZPR12CA0009.namprd12.prod.outlook.com (2603:10b6:930:8b::24)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 16:23:51 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com (2603:10b6:930:8b::4)
 by CYZPR12CA0009.outlook.office365.com (2603:10b6:930:8b::24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.42
 via Frontend Transport; Thu, 9 Apr 2026 16:23:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 16:23:50 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 11:23:46 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH v2 1/3] perf sched stats: Fix SIGCHLD race in schedstat_record()
Date: Thu, 9 Apr 2026 16:22:47 +0000
Message-ID: <20260409162249.25581-2-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409162249.25581-1-swapnil.sapkal@amd.com>
References: <20260409162249.25581-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SJ0PR12MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 857b31a2-6471-4602-e2f3-08de96546284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CVmUwS89YwiQB+vcQXTOlipLIYTkimxsgv4CuWHQCjGIKLeajysmMjlm3nrZMdqsstRjK4eRq/ZttfoSSOD47imjvsvo8WpR+K16vtTsYVa0MbtNnxvy0eOhcnnFPZa/2lRxp2/LWRVDOdGhe/NH9VAYFBe2DlctlTGiNC+impjYwOMPYDHI/X8bjmNqPbD5JHFbkM1/mjklhXBh8Wnh1v5pYQIEgZaE+blTk1mZ2XrYm8/PmclE8ZL1wV64w53u4bRnFxXQ9U8ymJB6Mv0+p5cWKao6jdgqwZQilLuHY6VmypSlnNt60gzEJDwuvf4o+lr1zJMjVBZr9h4yI6KMdId7TDCXwVJJcQqG5TktQXmCiy9g59uR0FB7cCqfvkvcLeEDmWTK4MhSlf5YuFPousCst1OSj1nj22n82LyTvL6GE1o81Vub6uvIAWqXFWjaaDTcx6kdZyuwySBBM+JHwm87g0s5ARKLHXHgpNn714XuPMlWkLPVYUC24qs1q4pNA8Nf8uMLpfT61pGbG4MIP7ZJA10sP7j7va0tFNWXZFEHTers1EWj3ItamT5z8nbeP0PGMd1r4v7D3HB7b/O6C5pqy98NUt4BT7Y3daMLxsQ4/S+NR63qQgPSSfcn0ca7sqxVRFLaY1uHmCuMUdfpIjT/NiW4JUUbbJFmq94MH4WPXgMN+d69mibOKKOUro3Yg2/9FRWWjy3xC3u9Co1v1a7Zb+z1urHEHfy2KVC8D/52HTaeJbNbph4IQ6ZlEJsL+YLrPWlE7r2dkaL/zuRHYw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gzFGtgxSGU/j131/Om4jPoC5FCkgdD5dQRIBHSC8mVj9asHKEjc8Y6GNSx5ReKo51hHVj5LSuPRNHvKoKczsU+EqFiJrvGa3+gWZGMF5SUD/f6wIDc+wHsE7GdrQBUF770UW5ewFOjS2ZOhDyhO1KnJIvsLCGhA0Wn+v9EJ3z7Hs0ztCO8CpT2/RistTpx3iDC+WX9OrIKibVb2S6JDDT1vqmq6sEcCVkNp8ZRH30zU8EkNDbByO507ub09/bzBD6iBmx1MXMZwIZt3GDEWfpuWsBiri48kmHywGX7OqO/dTXtDYixP40BWKOeH2N3Bo+YLzzy+H78fp8gM9qOofH/XAMnxUvuA7tFo2uHRUdEb4m6QepesYDgDo8Rnzymc6qiInC07DLbhwVMBwlVsZ0Lh/ex5cm7DA0ywKXTDagUYvzBwjkMs9H5277ee0k11A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 16:23:50.6644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 857b31a2-6471-4602-e2f3-08de96546284
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090

When a very short-lived workload is used with 'perf sched stats record',
the child process can exit and deliver SIGCHLD between
evlist__start_workload() and pause(). Since pause() only returns when a
signal is received while suspended, and the SIGCHLD has already been
delivered and handled by then, pause() blocks indefinitely.

Fix this by blocking SIGCHLD, SIGINT and SIGTERM after
evlist__prepare_workload() (so the forked child does not inherit a
modified signal mask) and replacing pause() with sigsuspend().
sigsuspend() atomically restores the original mask and suspends the
process, ensuring no signal is lost regardless of how quickly the child
exits or the user sends Ctrl+C.

Reviewed-by: James Clark <james.clark@linaro.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 3f509cfdd58c..3f448acd5046 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3807,6 +3807,7 @@ const char *output_name;
 static int perf_sched__schedstat_record(struct perf_sched *sched,
 					int argc, const char **argv)
 {
+	sigset_t sig_mask, oldmask;
 	struct perf_session *session;
 	struct target target = {};
 	struct evlist *evlist;
@@ -3899,11 +3900,25 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
 	if (err < 0)
 		goto out;
 
+	/*
+	 * Block all handled signals so that a short-lived workload exiting
+	 * (SIGCHLD) or an early Ctrl+C (SIGINT/SIGTERM) during the remaining
+	 * setup cannot be delivered before we are ready to wait. sigsuspend()
+	 * below will atomically unblock them. This is done after
+	 * evlist__prepare_workload() so the forked child does not inherit a
+	 * modified signal mask.
+	 */
+	sigemptyset(&sig_mask);
+	sigaddset(&sig_mask, SIGCHLD);
+	sigaddset(&sig_mask, SIGINT);
+	sigaddset(&sig_mask, SIGTERM);
+	sigprocmask(SIG_BLOCK, &sig_mask, &oldmask);
+
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

