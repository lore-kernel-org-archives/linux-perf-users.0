Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EE1355F49;
	Fri, 18 Sep 2026 03:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702554; cv=fail; b=Rt5Ez6tkymyHOCsSIhLN8Iyu7HWkBsUfyXailHLD+HDgaswabMk4jMNHApte9n93arAF5XLyI8wtcaYA1bDrvYtJgMetdJQvPLHcbp4yqVYzamlmLBTGXE9vZl5lafIZKeKQ4J+2oGi0k3bDuYo7PwhaSuVj8R/tAJVvUlMTRR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702554; c=relaxed/simple;
	bh=tIbGvkY6FRSjxxPL8/U///IG4UQGyc7JIm3G8L8du2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j1FQjUdiLhJbwxOxL2ZOPoTCkanfxggHO5emcZatgWC3BgnGFFia74KEZOfWvXXpuseiIy1apy6t2Rqp6R2bQ0cOmEO3guAWbzHFQjZJ2O4jD031msealV5OE0MBt2rES1LgynL0qgTqxZuh/DSpzrq73v7K/K6sYdrSYAyj/44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mXAAEkwN; arc=fail smtp.client-ip=40.107.200.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mXAAEkwN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y02U4U23IjlVofIBmmT1mVshACaN3/AXnyDOYvmd58zdUGfSdREUsUHT6gvje/Zr7QH8TIUHdK7WhwOCZOdnvlCbOjT+AQXhz5ai7ilVKUnKdL1AAAH5bSwZfKHhG3UH3G5vpvs9jNB8oEscbfRDxbEVxfuazhgZGTA2rnGGQiUR208vCwwbYNZm2YXSnUKwciFZAPptmfo3foaCMbJy0A19QNHWzPW3bgZzzSsNzCFv1wlEfi1MedEfu8/nOD9/4Q9yuI4wH3E/GKKBWF6gePHAClCF/IHDbPxaGXVYqyuBSxgAQoFninMv/iKzw4Zs7AAre6yDLATYocS1cyy3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2XybF9sGK0Y4cM6MHdbvfhuFAoBgiJOmdg6COYj23E=;
 b=ejRzFJ/waeFZ+mnwfs85nQHwsgRe+PUhL66pxc89Cm30KgKpQhs5sWiWYSF7d5cwrfSStk0VWrFq75JYlgWmsrDBv5aXCDzzgLkPXJVb8CSADX4Y/TOzv4dCy/ZRgSIaieZzlpun/neiv4IQZT7qcEPlb0Gg29bEUpkk5V+d83GOk8Sa7uybiSdgKiT74GWM2YgfXg/JyY64hkQmu3ZadxX1Zg7e/Mlm/BtdHP48uNiBuU6nbKnewvo9es9mbyuJG2PJyfswGNmHy2/hrbe9c1ZXSmU6emrRpL+o7bW6h4ayj7Gr4cHU3QcTwHK2KcU45ue0hDNOmPz1YK+zrC5m4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2XybF9sGK0Y4cM6MHdbvfhuFAoBgiJOmdg6COYj23E=;
 b=mXAAEkwNxEXh689cSb179XpIi602t8NFEFo21Ctb17h3icOV/0awKNIVURZTKPGdlWuD7fK2sJ3uoUSfJzPYsqC7gf1XgqWgD6Mkp74256hRovzjUdYmPR2+s1FPzd3c/UjKAhq23dluo5xYagoHSGQ8QgsqFIt55LaJU59Xq4I=
Received: from MW4PR03CA0100.namprd03.prod.outlook.com (2603:10b6:303:b7::15)
 by DS2PR12MB9640.namprd12.prod.outlook.com (2603:10b6:8:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Fri, 18 Sep
 2026 03:35:45 +0000
Received: from MWH0EPF000C6195.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::8c) by MW4PR03CA0100.outlook.office365.com
 (2603:10b6:303:b7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Fri,
 18 Sep 2026 03:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6195.mail.protection.outlook.com (10.167.249.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 03:35:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 22:35:44 -0500
Received: from [10.85.43.235] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 22:35:40 -0500
Message-ID: <4349c387-5b8a-4e8d-932a-5175a7598e1e@amd.com>
Date: Fri, 18 Sep 2026 09:05:34 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] perf mem record: Use the IBS swfilt filter when
 available
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Clark
 Williams" <williams@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo
	<acme@redhat.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-13-acme@kernel.org> <aqsRVABj23jaaiSq@google.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <aqsRVABj23jaaiSq@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6195:EE_|DS2PR12MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e2fcff-3e88-4333-e2c7-08df1535ec15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|7416014|36860700016|18002099003|6133799003|10067099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	dxNZaQ2hz96Qt0h4Duw2zuLDzWQ6BCZLSVdKPu2e0A1dr9Y71l8VEXgIJlOXdBeVYTU4JEQlJWM3/sHyDS7ohR7sYFK4qWv4Yy/B6KU0dUig07NEDcFCKuokJ9hiPmmeETCXlgxmrD59GRgpj7cX3Cdqu/Tvl+HwFPEHl90PDXpdRyVHxUDGATan03ytZOXCGWWRkIk30jX/+y6dwz3+NbOOoQeGdMfWj71IUNc5nfFhCN+bpRyoHAuEtVKWVXQ4KZqfAdvoC30l8A/z5q0FXweAe5e8TTLzIPGi1xkdSeULz/6o86+fbKyxf/LcK814ea6wim8AKK/c4zHO/d5y/tVXMLOOPK1RK4G3ZJgAPmwGHPhL+psYhxexf2fJf2hxt7ZZ3qHGqCSIrmpBtS98V9BQS7ZB81aPbPIbEXgHkydSNLo7aEpYGLxkjU8fF4i6SA7nb/LmI+0jQWWpfJbf1E5riFGGOlrkx22m6dka8TE7kHmnEfHQvZlWhVszdPStgEnxKCS9xzPeH+dfJ2aKxdlui/i++8bjx6mXXGJjGtJ9ZggDMxIrjS6zZfk51bUBOnztVF1P9re2V1HEi80KUJ1xxKIR0E1SD4b84yo2PEBWjJv8RUcS30Cg8PC+KOgIw33j2p28oCS1WqKSsybRpEv7v96tY+lVa0LPZh9RMgyDggOoQUqacHr9NiD7WcTr2yobSxmeXGwlnt4hRiBOVQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(7416014)(36860700016)(18002099003)(6133799003)(10067099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Zh35vAgGEGF7KaOtu/vNSCW/pvvu4IhsBnXvP/wSipQsxNezl58zofXXBfyeqf6aZRFUVP+M2EAhQ9QafJDvzK84FKMC2/ANgRh66d2OlYjvAKU9bMlohiafKeekCYhYhwgKTxoVHNRgimNRWKExfdjYjq0tICxABN/Xltl94AM6O3kUHMY/3/aWr/GafM5rnwix7Rkb7GSSzTcPn8QDnO8CFiEF6sqLa9gJEiQfhwtmx+RshdaacUj9y3lEpKB949t3tvA5E2wkKtAqDMdHQ0XuEdNBUolN4EqKs6LqlMmjgyZPDug7bD/KdbFaES1upZAQDSj9dIShgShIVJJbtCoMmAiWKiFY6lxbftb6ENUTDRvajoJOiwtkcaQdd0aj8bOCeUjvv09iQdZ4SkRk/CtSqtCnfaswrHsZGMhI1FnZvPyw/V4TvDPopITDWPcd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:35:44.7513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e2fcff-3e88-4333-e2c7-08df1535ec15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6195.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9640

> It's a bit unfortunate we hardcode "swfilt" here.  Probably better to
> have it in the mem-events array and add it to the name format
> dynamically.  But as it's only needed for IBS, I think it's ok for now.

Something like this? (Untested):

diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index b38f519020ff..816c73d75bc4 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -27,8 +27,20 @@ struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
 	E("mem-ldst",	"%s//",		NULL,	false,	0),
 };
 
+struct perf_mem_event perf_mem_events_amd_swfilt[PERF_MEM_EVENTS__MAX] = {
+	E(NULL,		NULL,		NULL,	false,	0),
+	E(NULL,		NULL,		NULL,	false,	0),
+	E("mem-ldst",	"%s/swfilt=1/",	NULL,	false,	0),
+};
+
 struct perf_mem_event perf_mem_events_amd_ldlat[PERF_MEM_EVENTS__MAX] = {
 	E(NULL,		NULL,		NULL,	false,	0),
 	E(NULL,		NULL,		NULL,	false,	0),
 	E("mem-ldst",	"%s/ldlat=%u/",	NULL,	true,	0),
 };
+
+struct perf_mem_event perf_mem_events_amd_ldlat_swfilt[PERF_MEM_EVENTS__MAX] = {
+	E(NULL,		NULL,				NULL,	false,	0),
+	E(NULL,		NULL,				NULL,	false,	0),
+	E("mem-ldst",	"%s/ldlat=%u,swfilt=1/",	NULL,	true,	0),
+};
diff --git a/tools/perf/arch/x86/util/mem-events.h b/tools/perf/arch/x86/util/mem-events.h
index 11e09a256f5b..f707de380370 100644
--- a/tools/perf/arch/x86/util/mem-events.h
+++ b/tools/perf/arch/x86/util/mem-events.h
@@ -6,6 +6,8 @@ extern struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX];
 extern struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX];
 
 extern struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX];
+extern struct perf_mem_event perf_mem_events_amd_swfilt[PERF_MEM_EVENTS__MAX];
 extern struct perf_mem_event perf_mem_events_amd_ldlat[PERF_MEM_EVENTS__MAX];
+extern struct perf_mem_event perf_mem_events_amd_ldlat_swfilt[PERF_MEM_EVENTS__MAX];
 
 #endif /* _X86_MEM_EVENTS_H */
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 2c24ef3140da..fd4491fda117 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -333,6 +333,7 @@ static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha
 void perf_pmu__arch_init(struct perf_pmu *pmu)
 {
 	struct perf_pmu_caps *ldlat_cap;
+	bool swfilt_format;
 
 	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
 		pmu->auxtrace = true;
@@ -348,7 +349,10 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
 		if (strcmp(pmu->name, "ibs_op"))
 			return;
 
-		pmu->mem_events = perf_mem_events_amd;
+		swfilt_format = perf_pmu__has_format(pmu, "swfilt");
+		pmu->mem_events = swfilt_format ?
+				  perf_mem_events_amd_swfilt :
+				  perf_mem_events_amd;
 
 		if (!perf_pmu__caps_parse(pmu))
 			return;
@@ -358,7 +362,9 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
 			return;
 
 		perf_mem_events__loads_ldlat = 0;
-		pmu->mem_events = perf_mem_events_amd_ldlat;
+		pmu->mem_events = swfilt_format ?
+				  perf_mem_events_amd_ldlat_swfilt :
+				  perf_mem_events_amd_ldlat;
 	} else {
 		if (pmu->is_core) {
 			if (perf_pmu__have_event(pmu, "mem-loads-aux"))

---

Thanks,
Ravi
