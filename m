Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D963A381C;
	Wed, 20 May 2026 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272504; cv=fail; b=Nplf9XjwZYdy9/xs8NTWQ6NvCrLGFKqcrDQKl2/8ZynOTF8F6c/bzEvOA411mDrk6dcGXKAj/CQY3z9OQHqifSOxp5Hy+cZF2xa1MR7YFC/YF5GQkMtpJHfoSzPBpg87KZEsGKH83SYolJjTGmW3SNQvwr9PBJw94AXWq3p9Mfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272504; c=relaxed/simple;
	bh=xdxneVRuhxrKiujq6UQxpi/hpNTalUXSTQoHab2Lffk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sY/TjTT2xEr7aYBhMbLTRWQKYTgtbn7zYQwe9+e8HcgBy4TiquriKN8zD9WKohgPhWdbx3hbfPUPDMFAQ89UEFNUkoYknjU1scxxwiHOfPBR4TDSgmNKi7uv6q+mNJed3jUmky4x2AxhYmnHfCfuoRWdeCUeoRt4CPN8FseYuVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xmBrUY/K; arc=fail smtp.client-ip=52.101.48.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xmBrUY/K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9UgDUPDg4mN9kppyrs917BxendEmbHo4nmsZFKDB1FlSpMfwzrcvdqw/coOHpKIkDahkdlubKLa2OXXxJZAEOtXV/L4MGnxGMmVkn9u7OIfW8w0/lmI7i/7Y7wyJTkBgZzUxAym6kL7ds0SioeAR13x4IivtCWf3omzGQ7SGMXe4azIrrm1IM9oTe0E4B+jQHOyDE70vekB3d80He1XMbBs0Imn7PSifJY2zgR0J9VDthTzGyXF2/2TQSfGGRPN0z2737OFEeVQkrl0XEiJwD06+Q9+J6DSXdfMZVjJoQVNpeixds7UHiuuvsZEx49pxme4V6BsFKJYqC3yeVtlog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weLZ22l0RwqOCJ0lLQ9BhUjgmbktq6D6qV6lU77l02c=;
 b=fWtA8GBMgDSyQZ7Udgbsnacua7quMyL7mChWTX7Mu5P/2bM+Bv43riSqXDvJJROCpYAXD4H4aqsNOSf26RISkrojX6DAQ9VvtJurLOo8hjkBV24G9xd5afzcaFETOxq0BwGYnh8T/Ir9L/LxMyfWigSipILkZCv4RxwvWsDVsu7AMolsj8QFOsWtVZssnUN4QfBBnjjO4n/9Nl/bKdLMglJKarbYrgpR9oitMD+FCNyd8KzyiC98LzRoFYf6JtXzhKb/I4LDyQ1Q/o/eRyFOX1ARQN5Dl6Icaa+utZcFNzrdY00XYOqjstHAKxUphEoe1D0jz5gcW1QKPmtM1V25yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weLZ22l0RwqOCJ0lLQ9BhUjgmbktq6D6qV6lU77l02c=;
 b=xmBrUY/K9JLK77RZ0HzjRHevjK9JK1qc3t2QMqJl1TlrbHjFT0ZfanaeZMfdf+XRCMreNakFhdUbUodLRSyqTJWYlLpxMDPzKpCr0yve+OAXMxWqAB14WBwIuFTATSxLLej9H0vaC4rRUigDKq4ZGwkFPcNk/VR8tRXOwNh1o6E=
Received: from PH0PR07CA0106.namprd07.prod.outlook.com (2603:10b6:510:4::21)
 by DS2PR12MB9799.namprd12.prod.outlook.com (2603:10b6:8:270::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 10:21:38 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::be) by PH0PR07CA0106.outlook.office365.com
 (2603:10b6:510:4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 10:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 10:21:37 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 05:21:33 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH v4 2/3] perf sched stats: Fix SIGCHLD vs pause() race in schedstat_live()
Date: Wed, 20 May 2026 10:20:16 +0000
Message-ID: <20260520102017.293419-3-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|DS2PR12MB9799:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d413c6-d40a-46cc-6bac-08deb65993a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	7IeSURZj1fwlDtcMmUIdkm+USWRZUgsv18Pfg4AGSBvkn6bxdiEEZcTxmJDexlHWY2a4JAGGPEv6hX8k/1QFXm1qUnTdLp1PdexLhztnGasSyXG9ETnjBdE3ZvNMs3WxrT5qNcaIskJO9bJj467NFVrP7us2fxNnN4ve65R/USLrUGObOwZSroKmTtCWA4VoUTcOfrf2r1ir4oUlVR81ewCenmHtlAv1d/nshd+VEKL7BmrXFWAJeUcU84LWuMFX4hS3y2EWzn8g1JxtpN7z/JblPO+datvhBzxDSP5uYP56wtC7Fc1W5NIJiYw5vARrXntpXokhKEMOF5rElw2UkUXVqxVleidpOmP7XIlnZkzlnmULy1XckFHG0JnWtimVbwAiax5bRSkXswZTs7Kb6VuzX/eXib6yEXc7M6GpOyejcqY8LIFzXZSZKEzgMwxatSO747UzpWg89TAM4+CsyG/Oc1k1ybSdjV4BL3oimtHf+90ySPfbQl4m3cCNXmaMMxqqzmeCmK4bQzAaXoqGWJuOGjyg38AtysGbuBn3RRS/Sz8thdTPVmz6asHiAaiJe3dpHNAn5Lrb6PgxwvFYzTTsGMIbllQevtCgo70dChgtbxWMGjLjKElYgZPSXazMSIT5yQ0/6x7hucrske6qZmX0EPBRLz8ZOUqKNXsSc6bEOehZe21HV3QKr/AC6qh+Lg/MItFNEKIZtDiNzouXE6D/JEym8dxzKJF07R4WnjE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(18002099003)(56012099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i/cKeC1Yc5rbpk6NNa9ocxhNzQRfjgcoMhIzWdCEyWYE6jdkfm1uN/9/LmJjKiRfVRznD0tXVfEnS9kOR9637j7gEF0hveXfGQTm8JEkuhOJAPpQqwQSIXo0puPDRyOIIQIhmcBGxLbATPqthyfLKYtu/AgMgtpaQmeYTCtb0DHafhKy6zADO/eMenrVLfblGQVpyNNsuKg5R63EH9Ae1euJ6abgrwc/dj75zkV9m9qm3MTqhBAyCf8ZqJ1BOq4pOzzx2b9nJVn1DqaFBEVnTGqwfdh1UVP962uu/f0uuWnHIY+kg9zKfO9O3CidIlfViQpsA4q2BpntvANPrMr0kWH3GaIkr1Rywwazui1/77e1CqknAKnaFonB4uuwrUL7lOSrbg/jCsdvqGaEC9y0DGGHnpi1dsc6qE+gmiBwTUBDWh8Z9WdmoXqvjTo8UVN7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:21:37.7629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d413c6-d40a-46cc-6bac-08deb65993a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9799

perf_sched__schedstat_live() has the same lost-wakeup race as
perf_sched__schedstat_record(): a short-lived workload's SIGCHLD
can be consumed by the signal handler before pause() is entered,
hanging the process.

Apply the same fix: replace pause() with a loop checking the 'done'
flag and using waitpid(WNOHANG) for the workload case.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 7da71c372e25..9e8941ae1b3d 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4755,6 +4755,7 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 	int reset = 0;
 	int err = 0;
 
+	done = 0;
 	signal(SIGINT, sighandler);
 	signal(SIGCHLD, sighandler);
 	signal(SIGTERM, sighandler);
@@ -4800,8 +4801,11 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
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

