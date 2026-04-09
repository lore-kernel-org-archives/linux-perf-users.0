Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0423E1215;
	Thu,  9 Apr 2026 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751859; cv=fail; b=jKlK3sAtPR4EFC+JUCqZ0dTsSV7rVRkuUg38S196KgJXsdbVJPSMXrYhK74jxHYL+gw6o+ra5k4+jCvUOu9q0536Phe3K6d96PGOokB3i3s1Sif4ruDSF6G949zf7mZX/UIjNERU5pWdIYbEj++qM6VmhIRLgDy4zJpWAkS7UkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751859; c=relaxed/simple;
	bh=Qvj5JZRg4yjzNJpMLLEwzOGMhmJYHkxSGxy3sPTpyD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/ElAzR5r//rZp1zqj5ZH5AEXvQnxoHNqI7IHKeTQzNTJfZFM+QFmAz0QGfW91VTKlBR0fvCczHb7Z1mpYM2tdTOB8VEkbvbqcn7uu6Huvn65cbq6cXCPNGU6bg543ECL+kniHVp6aCMw4Mvhi5AsN/SVG0gpVWDCTrTrvvDM9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Iq2ECHGY; arc=fail smtp.client-ip=40.93.196.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Iq2ECHGY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufSUBqYEVKAiv8et1m/ESR9gbRUbCzCgWllqxpZBIvF4/S2VbJDp7yCHwRfhsk/E4K4LgnzpJ7Snz4jaQQ+TyZZ1xPeIiOzprTcpRX0JpGrr2XfqKGoGpN9tzAXNfs5BNzSyo3xiDo3EtZUXamlkF4bpPipjXXBmyth6tthc3wWXDbNfRiucC5U5ibDVmeK+zdElR5TiKjWMvIU0YPeafXt5l80OZwdlTntrRdkjHyHKwTzw6EDZ/YFUKmirnrwhPvhbpf7PZ4YbUswKgBIK9GGMDf+aK6B24EQN4736xIzxUIgH74SpRWhNIuxlnTwPaLUtDYV6IarbTCu8Dzxmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aleptZDEZLeZNu4y/ZELmKG3gtKm/T1aTEelSEFRqXY=;
 b=o2OHC3cDGrFqKSfACL1+yC8Pdk2qCqdmp922HSeGgx8RKI611W15taUtDuNWji5jzInwmQsQmEoWTkUha8AyAIB2DlFlwYEqvGjRGn+Wxg/agzy4oqvTanbZSuZ+8r0lYKrIQRNHs9StfRFknDlQRXWP8ZddTwMbVwMBJDZ8Fga7IGpYFiRNQ8gGyQ+g5IgOniR0ONcVWgZUvy6LGbNqXhCz4dm0YE4D5eB2or3+69NvRGL+5+kZiKibEevrVXh8Pf4lIgQ1jLo8oDMrpfO6/XoqlvytBrGfazYyjPMwfVAz3bYaYIj2V97oQ9+fCVg56BhpyFUYUL62hNOXM0Ie2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aleptZDEZLeZNu4y/ZELmKG3gtKm/T1aTEelSEFRqXY=;
 b=Iq2ECHGYeNCr/YySVefztmYn1kN9+DosJbd5+z/OkyC+xHuXdsLlvKLmCGXAX8sDCQf7oKZnu5ZFaRmzhkKeATSCvXxbY3Sypxq2l/iUCo5+iSy6GzQzgYkHCiAXpwFvWzGpx55loMq2Ib7uNiZe9O//VyyVxUIPN+Ha06SL7OY=
Received: from CYZPR12CA0007.namprd12.prod.outlook.com (2603:10b6:930:8b::25)
 by SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Thu, 9 Apr
 2026 16:24:07 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::1a) by CYZPR12CA0007.outlook.office365.com
 (2603:10b6:930:8b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 16:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 16:24:07 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 11:24:03 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH v2 2/3] perf sched stats: Fix SIGCHLD race in schedstat_live()
Date: Thu, 9 Apr 2026 16:22:48 +0000
Message-ID: <20260409162249.25581-3-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SA3PR12MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7ae8b1-37b9-4ad4-13e2-08de96546c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UA5ASPCArJXgKAMqIVtXnnjXogG9QwFOHMZQ96bSXkBOtyz1HEkNIDvz6y1tGFWu6ItPmDtVaWXSPol9dz07YOEgPuwlgkAvmzwxHaWv8E2SgKh0Gt/Fk1GyY5vItTSmSx8wk9+LmXgowb2qgumolUV1LhMtI8VJIMlY1zuxZ6UtZMQyVuK4HR9NwN8GLZDp4uIIzs0d6QA92RUfRnKytVdPuJfOCk359y+VsXkKsXJpHGJTqs/zPc+NalBoJmYLrwgGSp11o6sJHd10a4rGwBjk9yZgvtZ1wm0ysjskiXT9C1hPZlbJzDfhWSyCC0t+8/isfhCsruEm3YOExooU5BW5b5mjdrlFuixv6RR8PIM6hgnAohOlcw9aOrdDPLYSEEY3Z8LrPp4M3bnL3Huwk2xeppFuzsCCz6qYSJbz4SEHhgAGbZyyVXFaKSc5csc0Dg8rB63pOo80cFTGL5dfe3EB4YAxdw9ysLYxk9SmwLY0fJOEp9TbYFZvI5H34ralW+S/15m8Jjhxau9pc0YoefOl64ue9jWwZHxS0pJAanoCHgNj1/AcA5dyf0eY/W4eHeEio/rhJxCzgtPxMUtKFairKUM2OUkdDtEkzlCLqnqoztZjXCqua/nhMdw7gDX4VJUBpjhbE4MvaJfC/CK7/CnZgdumLG3mYdE9mdrVlZCKoTzS7RDScsaxhbhTj96TgmKRO9QSlRHI7OaaLQcDjIGuFrpyyG7K85JS1zbOFNgdLNUh1SCL8/MP6g3gtpywmWG19Hh1BW+RaAp8093/ow==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	50y8dcsyFnHaj/W+JnSorqA/JqTPyWjV2nl8F645jl733EbDLE2A+KbMZPl162ku9iRpIGW0Iv3ND9JTLtc0fIOEsr7UqSZzH6z6UYgYH8wh4OdZvhW3w68IJp0ciE9moCx5ESLlCZQbAfIylbAambRCmOrXJOHd3r66kEeEjOxxAaCxt3RMDLiVTy57ZoMhXBqqF/8hJYqG+KiFwHcFY0Y9BwXArvPxiJMZchJhSg60B870zueciDvx8t5uzxvsqK2hBskBmVKc5UAUeVic5evOjT9cxMO0ffx3dGOyX3tmEN3pejjXOgWd+0S7nEe9iDHw4l0Ji7wji0ZoRCxvbUmdL0RZQwHoIp8hRbh8VD1etnAW4AHIZE1hhVF18jf5IE6bAUOpgwhww5/3OD8Fdm4GdZCsF64LxXTUo9yu4f0VZem+L1cORS1zF+eF/wfn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 16:24:07.2648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7ae8b1-37b9-4ad4-13e2-08de96546c6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9198

The same signal race that exists in perf_sched__schedstat_record() also
affects perf_sched__schedstat_live(). A very short-lived workload can
exit and deliver SIGCHLD before pause() is entered, causing an
indefinite hang.

Apply the same fix: block SIGCHLD, SIGINT and SIGTERM after the
workload is forked (evlist__prepare_workload) but before it is started
(evlist__start_workload), then replace pause() with sigsuspend() to
atomically unblock and wait.

Reviewed-by: James Clark <james.clark@linaro.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 3f448acd5046..c716dd33a9c9 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4653,6 +4653,7 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 				      int argc, const char **argv)
 {
 	struct cpu_domain_map **cd_map = NULL;
+	sigset_t sig_mask, oldmask;
 	struct target target = {};
 	u32 __maybe_unused md;
 	struct evlist *evlist;
@@ -4702,11 +4703,17 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 	if (err < 0)
 		goto out;
 
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

