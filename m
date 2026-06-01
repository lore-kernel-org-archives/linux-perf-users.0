Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD0E38AC93;
	Mon,  1 Jun 2026 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325946; cv=fail; b=XqV18qKMJKLxZsXw5QmSWrmSA4Ajzs6REjuwY5YYRutMUbikPc1WrhIno5ddCkQnZjlogBRcKnGd9P+PeYIvp2wJW0MfeunM4TboInrEi8qFLtOlP5z/vTXteWqR6b8w8/e/9jUL9BuZC54jeUHYOapguo+CVD8FEoKBv7Lfh3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325946; c=relaxed/simple;
	bh=eW6CvbcAgEWXSrtg4of8j9JFtdTkwGX4zemg+daNshI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HL2pnyZaQ1vBJhKEFKZWL3YWd/B+FN9bt/OufI5m/WLa+WOeIy8z+5zHd9/F6v1yejOLnFk+ZoC/Rlg10ae5N09cFA5E7RDpjg4X4ubC7tKhk07Gb5mBWzEX2nt0225wRpvOrR02hum9dbANnYndYi0ESzJUOStej4oxA2XeQSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Le0pWag; arc=fail smtp.client-ip=52.101.43.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Le0pWag"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8VpoJNfQZNhc4hm8nm5J6BLjpAkToNPqPz4GVq04PqV7uNRNQ8Gis4D3njFhyTiQSWfWHNPnxP25hAlZhetS1Iwq54VCaOI3jsy8mE9WU1mAOeXkI1W1us/mFgVUMHNK90X0Ur+PMBthH1UFR5o1TFtv64RbvJysHosVYZstnfYVXtVzhJTdIzwqjJjvCC69TasLDDUuo3fZb3blC6mHksxm7ZWE0r2cgDkgaf/LEhFq6D7n0zY/ZyNvXZ5zsXY0SZzVJoKDCD59tAuMuyLg6F1zxDki2JW8nvo1QPGJmv3upbHvDV19z0wP16M3O0/lugzWbgPCcGhzwwbSOokXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgSf+liiVIlANObz7Puwv01FNSO2D/CJOXK73/EI6bY=;
 b=Pj5GhmPW9d74BLKcp7aYjXSho4f4KtepZ49bcvuVGNYxHF9ilzjsz2nE/0Hnb0L8+D4RB4PEB5jiwpeTqiiIs5ffTJjUcqBeieh5Zdz79y4LPf25VzCBN9/AEf1xImnnnhNPUkRM1VpLt1+r97xZgWDmeHbswMKZLHCqG9wmREBiK5APhyPEoyYGH5WZ3inO2s7XtYUQK/FH+WBZw5YH+aHHTXgWqTOJCR9O6ZU1oyD6h/DLVHXIsLyut2S8+duEB6L1ZIU87lHWmb3aXoTzfSjwDNPfa8cDaX5G4wnQbFNKoa5pH4SHDeb31h2JyYp7rzTs3loUujcKiynXjupuWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgSf+liiVIlANObz7Puwv01FNSO2D/CJOXK73/EI6bY=;
 b=5Le0pWagLGNuW9n40ukFRNpL1tjh0h8P9iQparJ5D422o6xDByJI1ggwJ9MsFQledY9mudkk2dGoTXXEDy27ij6VYEYhzPkOFX6bvHHSgSOX4U5QcZ2lECdyS+BXyYhNYKI7SPcbflNLFE4jqcoxBGd1UnViMnrH6d7YNx/AHgk=
Received: from SJ0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:a03:39f::31)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.17; Mon, 1 Jun 2026 14:58:59 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::90) by SJ0PR03CA0236.outlook.office365.com
 (2603:10b6:a03:39f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 14:58:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 14:58:59 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 09:58:53 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Ravi Bangoria
	<ravi.bangoria@amd.com>, Ananth Narayan <ananth.narayan@amd.com>, "Sandipan
 Das" <sandipan.das@amd.com>
Subject: [PATCH] perf/x86/amd/core: Always use the NMI latency mitigation
Date: Mon, 1 Jun 2026 20:28:46 +0530
Message-ID: <29a3c970da289ab8f24282933bdb36545c0403e8.1780325517.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DM4PR12MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de75048-b356-47ca-d8bc-08debfee4f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|5023799004|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	wttdmvU17oTU5lKQqAJvk3UGS4GVPtl/7JjM3PVbDPEVOEAyGtG5Umzro1hD3tMbqcCA6d7bBWZQHtSuqWWMV3KBl9vjtTyRurdsCgNlaNs6OObc2KQW+Ek204jeZ2aAjke607ug+LULBPD2uV1Pjma9aTO/ZZ6IunTcNqGDl0FdACH3biL+mOA3rES7vz3pSHzavdT/SeZ6id73Ig0qgFFVrMTdmQVvL/9p342l/yc+m4nSARdjwpDcx/o+ibU1wiHII++9PoObnaZ1e1ESaMMagLkBCQ9jz1oVQWyPlM9p8D/4iXTnDbxoCJ97u+os9GGI0DqivXKtEQFedJdxpcmYaIw17qVAStRczIwjEVOCjHTWoAnsBqowZVn69h7phqjNm6RQz6mSI+ApMKUqYhhtpHdWo2jZk6myA4GPFNm/a1WGQG8S2EwqEROxqeAOmW/gnQMrEifbJay3oZUhcQfVuWYyOQRXHbtzVjsYoFmNXGA5xvRQXdocoYFusHmg3OTxGiuz/y36V18R+abRO8+9f5XGLoOop7PqwxKZTCWaaYwya3LpdIlBx2o4odo8wVloCxZBbmUsKAIonceBvD5cV3A7pWJ4ukikpJ1kVGyUoh3z4DUw2pWUzCbBKIjkC/ibk5DzYvj52C0XfuM4ZYDGUPOMd5EFEw5wGGiDVwRL9xIwvmZN0O8OGGYB5qnshHeJH/xR2+2EY+OapwUdyfsBgc2Vduo9F3ydY/1NPL4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(5023799004)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zu9+HlP/EFIY4BBe0nRexC1NETwHXnRu8Y/CtMyAPt7HxDFT1P/w+pXAb7Pttr9d0df6bPzMxpbQttfLjRFUjYZP1DpUCIW5IkQSpifeC0wIiuGNvpwI6XgmlBvWEb300B/K07hLyw6KP0w+9W12pAzM4yE1u6Udr6mTMzTdumrAbDornSJEZrA42AS3Yn2zQDETsaMWv0vZ6/O8VFQFdO8QAF9ZUqt5p+haMBF2/Y6zAElNHeDeaCSOuyYCKF63WErg1leSCXd7uI43mmkvNf/NapyzRZJMIFVsOZvMQ8opwj1RwhFPwpCXT8JJSwzDq0mva6+qUiltxjFTWhaDKQde4qlCkKao27/M1acarL3q8g+p0ILktZ72+gFW8T4jR1crv7Jfyngq+8f8unNVC3wDn7vqbnXdpJybd0a5rF2AN1tGsOr0KIX6Loacm6Lt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 14:58:59.1028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de75048-b356-47ca-d8bc-08debfee4f9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472

Commit df4d29732fda ("perf/x86/amd: Change/fix NMI latency mitigation
to use a timestamp") fixed handling of late-arriving NMIs but limited
the mitigation to processors having X86_FEATURE_PERFCTR_CORE. However,
it is unclear if processors without this feature are also affected.
When Mediated vPMU is enabled on affected hardware, it is also possible
to bypass the fix inside KVM guests if X86_FEATURE_PERFCTR_CORE is
removed from the guest CPUID (e.g. using "-cpu host,-perfctr-core" with
QEMU). Hence, use the mitigation at all times.

Fixes: df4d29732fda ("perf/x86/amd: Change/fix NMI latency mitigation to use a timestamp")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 6a4dfc9ecabe..6569048a8c1c 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1414,12 +1414,12 @@ static int __init amd_core_pmu_init(void)
 	u64 even_ctr_mask = 0ULL;
 	int i;
 
-	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
-		return 0;
-
 	/* Avoid calculating the value each time in the NMI handler */
 	perf_nmi_window = msecs_to_jiffies(100);
 
+	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
+		return 0;
+
 	/*
 	 * If core performance counter extensions exists, we must use
 	 * MSR_F15H_PERF_CTL/MSR_F15H_PERF_CTR msrs. See also
-- 
2.53.0

