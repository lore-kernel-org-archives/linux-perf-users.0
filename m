Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793615161;
	b=w+YZ6dmLv0Iw9gAhs2x7+7scPbVKy21X5ieVrVCgjh3X68gafiBzcJTUw2AMviniU1NJ
	 LChez8jQ5CjNAE2pM50q1mRUaorOaojMwintqw1rzoeuFDNGNKc+q6A8g+tq1lTguTm2c
	 ZcW9tbNVNswSpuqOhO+liS7jUGW9048EvGILxh3r7eO/wJoFXqS2Bp+b9xAOhNK124hy0
	 6cxarQgfu4vodwvL/hAAJ1Y/uD1ETkZhi0DZC0jXnUXxvOAfuCIhYywK25KpGlQFZdbyH
	 ULEa6GGaSSOU08jZ020/9CeHuclIVTG+1SFcNOX4tEzp2uFuTyUMn7gxlfpRNaWNcEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615161;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Y6Yu9ms+jFGqQPUwGLofVtgWnj5sh5IckiUT3W+eaDo=;
	b=1f7nuHVumS3MwJ1LiEj7c5IB9nTvhEKwirVYjROFW1AVvWkGPmnDxB4iXldRhh0tsepV
	 cFjeCVBoGrQdqo7HdWjh07+WtUvbursibA86inEMjfvdPEHvGMExJxH9u4P2Zo8+Ll+/L
	 lQrYisNMO9i4Yo1DInAKvRLv2QZkTRQq3bDFhpccrvnLmx47cmEDXnmLXVBgr8GjKK/bA
	 owM7wfn70bvBtQJQK3VnqavXVFTCvyqVy9Bxq4WXR4AGf3jVglR6EEuYaAgdVmgcUFFt2
	 owlM7NapBXN+XSA2wp9Z5GVEsk7LRuqUK8gfU0H1NLCXPRF2lGdGWO5pvlbWJH/eq8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZskuaY23;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.45
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1841606A324;
	Mon,  2 Nov 2026 10:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1841606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZskuaY23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCE/2Dr0mjgXJqGC869nrWW+Ws2yeodIAmQ4d097jyq0oU8+ngPwPjHfVYR8WNuwBJs01Koj45ecKcYxmu0dEQmIli4gY6kFCakDan0tQg7uQdHKMd5NXVbmxj3C+2jh67kqRD18FbTN+oGgRUYD004oxQ4c+oqdZNNcL6PJoPOWoBp0/DKbwJUtrfnPJhGnMgdEnw/7QOrPW9/KPPdIvtkA+VpfxdDaKhHrpQiWN6lDqUxVgdn26Z6xn0o8Al8JS1JLANGZms1npXLwkqEtl1ye3/YdUUxaD0VAQEn4HBtBl9tQtfuG8dLFRbnzX+RhgqKX3NGRPLFypSey7JdweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6Yu9ms+jFGqQPUwGLofVtgWnj5sh5IckiUT3W+eaDo=;
 b=Efc+940ZUDokmpk6+MF8HjWlX1ezyFBohbojcGggiUjNk74motEs4ZKfHFDh86/iD5rOR9FAzn83L6xp2KT1ANwZusHfyHAyTomQuMofw3ICT+FVnLZ08yEY0EpMl7avpFuF4rd19w7eA4gJWkeJeuPDsxTzPrl8hs94X/cHE/sdqZKhfPMXvb3jL7vwgiWJY3+wf8x3Rj/TMfnqOlLvrWLAnrQL6Jajne03N35S9neRBOL60q9Lgh1vKiUP4bhfsviorId4XtU4vJ3NneK+SZiXoAUe2tj2+G03NAeQxV3MpYHO6eLlskJggAemPQn+tcv4tHreNvb7S3iSKh80uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6Yu9ms+jFGqQPUwGLofVtgWnj5sh5IckiUT3W+eaDo=;
 b=ZskuaY23Ql3G1xR3y5eJJNEVfq8zS+DilEooubREK115Ccojwhuj6WG6ykIPp1SvnPQByH9ft9I4C0NeYUm2kgEkc1OwM7dlzAGohZJHnRXsoa1o0GA8hxtggOdO00sIS8tY+iqgc+zQy1TIDGAc8NvlGI9b5Lz0f2DBwQdjY8g=
Received: from CY5PR15CA0078.namprd15.prod.outlook.com (2603:10b6:930:18::14)
 by CY5PR12MB6383.namprd12.prod.outlook.com (2603:10b6:930:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:23:50 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:930:18:cafe::76) by CY5PR15CA0078.outlook.office365.com
 (2603:10b6:930:18::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 10:23:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 10:23:49 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 04:23:42 -0600
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
Subject: [PATCH] perf/x86/amd/uncore: Avoid context migration from non-owners
Date: Mon, 2 Nov 2026 15:52:07 +0530
Message-ID: <273135a6d33a40f442fb18e140a90689fae7cd32.1793614726.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CY5PR12MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c509ac1-b318-4dc9-4866-08df38cb62d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|6133799003|10067099003|18002099003|56012099006|5023799004|11063799006|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261009223027099003|261028144727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	FhSTo/e9Wj4Sr74cIuTBzKDHuSRfntp1xOoFpa++gywj/+rpQvqWUDdfHQ4usQ2R+F2xmKUmFsw4Uj9Q8a7jIyuZ4BvoX+NQ9QPZdvebi716MI4RXZHtKlFoaAnS95CD4g+cyIP7YR8GnbBTjTmZlYDwrFcDandQ/9L49KrRtuLD/wIc6dqGEu7fpCvFOwk2Qdj+eYfuDMUA0wNGKb/o46u/ZtUX8ObM8HQidA5w+Oc86CVMhQ6GhYUr14rLyB9FO6AUKWVQPfoG6ufYvmRT8/01eKm0Db8kny2Z+My/ZLm/wsxYpLQ59DZvyk6IijtT7sr7TvrNzrXlJk7nbLIB6roW3rIKPVVsV+VZJ9UMMZvDeiDfw9iaegjcGfk08Fnbo6XHqv0lKVICnXyEgv3abdoCdTQI0Wv/cXji8cEPVrHSf3ITT67S5eP+0X1YmT1Nb38Q4DR/LngP18pDlfpuCJkdoTfo00wZrlw7oDWWziy6XM+e95Vqk7tHABc1wq53Jpjw6jy/9TVlUFscVKzhWJHCB39VDpG0W7kzQe/DEZQxjhRRb161Qk3Fd+x7SKg4pvRqSQtaEtbaaeNzkLmXssn0jqpGqjqjYob7gdJpOsiOPkcfAC2r3V2Xg2fDADm0gcHlMM57JcE7XqV3Nfuy3VaUKVZbMnrQjIleqzpxd0HYqgacKSwXREgIaHrO/B3qhdWf19TbpiaDCMF9/RTlYQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(10067099003)(18002099003)(56012099006)(5023799004)(11063799006)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9eK187jsV6ZlqAa+orUZE7unNjnegc0HX4LZiXHBdWf7lZ7F9bODKnvKXjVJ2NOeFnW0BJXIlAmwDnu9MctT8l07pysLQGbl26pU8HTrd9kxYHOLqO1t5Tv6+o5tVe5DW5ZHWcuxg5djqBuN2fg06k4FxMnm6sv8Bp21prkqcdizv3kHSUKWEN5x/nMAsdW9I1+jMG/KLKbfo4/863DcwS3nVNmXrVJGiT4C3p+4DVTGA+EvaKndqobnCU41yewOqNsonEuGcJrD3ie2heOSbCBo5Fzf6ibNzlNjj7Fnsce4+8AcdJ8PICuz6h2J1dh5qfwI8S2sY7TpPw3uK7I8fFwyVVoZS9oFyZ4he2nNrfCONoarFZVs8o2T7uzwwIX9T0/VhfDlIriLxUuSDTp8MQIdMlp0yf4ksHSdFENsFVgZNgSq9wUMG1eALC+NzqAD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 10:23:49.6874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c509ac1-b318-4dc9-4866-08df38cb62d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6383

Each uncore context is owned by a single CPU that hosts all events for
the corresponding uncore domain and is advertised through the sysfs
cpumask attribute. When a CPU goes offline, the context is migrated to
an online sibling if the departing CPU is the owner.

Before commit d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore
management"), uncore_down_prepare() checked whether the CPU going
offline owned the context. The check was lost when the function was
replaced by amd_uncore_ctx_move(). Hence, when a CPU that is not the
owner goes offline, ownership is always handed over to the first online
sibling in the uncore domain irrespective of whether another sibling
already owns it. This goes unnoticed as long as the owner is the
lowest-numbered online CPU in the domain, since the first online
sibling is then the owner itself. Once ownership has moved, that no
longer holds.

For example, consider an L3 domain spanning CPUs 8-15,136-143 and owned
by CPU 8.

  $ cat /sys/bus/event_source/devices/amd_l3/cpumask
  0,8,16,24,32,40,48,56,64,72,80,88,96,104,112,120

  $ echo 0 | sudo tee /sys/devices/system/cpu/cpu8/online
  $ cat /sys/bus/event_source/devices/amd_l3/cpumask
  0,9,16,24,32,40,48,56,64,72,80,88,96,104,112,120

  $ echo 1 | sudo tee /sys/devices/system/cpu/cpu8/online
  $ cat /sys/bus/event_source/devices/amd_l3/cpumask
  0,9,16,24,32,40,48,56,64,72,80,88,96,104,112,120

  $ echo 0 | sudo tee /sys/devices/system/cpu/cpu10/online
  $ cat /sys/bus/event_source/devices/amd_l3/cpumask
  0,8-9,16,24,32,40,48,56,64,72,80,88,96,104,112,120

Offlining CPU 8 correctly moves ownership to CPU 9 and onlining it
again leaves CPU 9 as the owner. However, offlining CPU 10 then makes
CPU 8 the owner while existing events remain on CPU 9. Both CPUs are
now advertised for the same domain, so tools that open an event on
every CPU in the cpumask count the domain twice, and the context gets
modified from two CPUs without any synchronization.

Restore the ownership check that was lost during the refactor.

Fixes: d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore management")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 7aa5a5b652a2..c307323f6390 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -595,7 +595,7 @@ static void amd_uncore_ctx_move(struct amd_uncore *uncore, unsigned int cpu)
 	for (i = 0; i < uncore->num_pmus; i++) {
 		pmu = &uncore->pmus[i];
 		curr = *per_cpu_ptr(pmu->ctx, cpu);
-		if (!curr)
+		if (!curr || curr->cpu != cpu)
 			continue;
 
 		/* Migrate to a shared sibling if possible */
-- 
2.53.0

