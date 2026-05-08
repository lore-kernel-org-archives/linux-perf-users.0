Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012025.outbound.protection.outlook.com [40.107.200.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CEA2DA775;
	Fri,  8 May 2026 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220082; cv=fail; b=fOjqePG2HxK59FA+I2hFpWFl4R70I+7oS7fib/M8WmvvOD+QwFqpdTsfxYorwqTg4TWG0Dff0OuMsD8gJEQgJR5qohaP0WowAnQkAx1ZIQJHsU6liCuq2XpvlFFRUP3SgLm1jbFzAkrSkJh2BILxw8pgKAoKi+b/wB5emnhaZl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220082; c=relaxed/simple;
	bh=2I/7dNmvqfvLszuMBUvcS1yadoiZUAoSrRw0qa+Zwhs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlf2cfoSVplaNotibrt6K+ivZRLobCwA3GhqCp7VeJFeLF1XyNO/OCWImtvzoS5R42l5tlEfuywtoDu4b7yIuXWpkyC3DTiEMU93fEwhNGgBIVTJxm3gyXrFAbZSSl6SrIMHVVwHbpDOaYopTYSjc+zexzeEAfxmgoSTf1gOkY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fyyJALkO; arc=fail smtp.client-ip=40.107.200.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fyyJALkO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhKRpZihCk3Beusj0DitkFDhhcEFqw32SLNf2RT9yEXu8ajzKrmgegnYgpWlir6vIAp86k9Vtilaa3Al0VokaKaSjttrfzSLq8dV2iKaKGHylql/uhRN6biJ3Fo9Thl5p3UQJnkebb2kJitxiaa7LiK0LPrHqojvyUuRt/FrNI3EVF01hePx5SyiTKQ8bjPMGIXSqtimtv3OH6ya0G6zESsIyeE648GJ7oAfhWSbhZZ9bl6upzVTZrP6PwNrjypiIujRZc6nKAbLLsdR7GkebWFWxg8I18RlWbGOyXX6hmVsh7WKKsYI3vqL1B/9xHGENOxnZieqGUY/PRQDF9QgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfP3sE+We9xDC8s+n6Ny2N2/ClCb3HLTFPaTOIaHaIw=;
 b=v/btFsD8PV0MgYzTuy2m/P2BYcg09PGquxBZkTIhbt20NIHIcWiPFgvMwRKyC6U2eHxQKuCRGt0O7Ky4OWBn+CP3vB7KVvHhzYfOLg4LtKdGasb3ygSBttfqzqqBXTGHqx4K0uSnnK6XJeb+GtJXW6Yks7gUpXyBqvI/GMCYRLxDo6iJ5f7l8eW6+ad4tfV3Bafu5V014vt65QO1a8ZcFB6vLguIz9g+80TFyDNPmV1prI/LJLTpXoaDHb4QhA1lIgBOegNU6gAJ58LGnyNK2k+rGkoDCQufiuUAbOyVeZKPztLXZzt6juDfDc4Q1CPyc8pHOsWGFV6KvjxiWiLCnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfP3sE+We9xDC8s+n6Ny2N2/ClCb3HLTFPaTOIaHaIw=;
 b=fyyJALkOM4zTja48vOk/2ruplwKjV30I6cTMv1gC8h90tUCgPaJAzUGuwPucTzOctFlb5i84TrtMVAin1fHp9bl6k6V1LnLSKdT8s73xQXkmAyKaBy5Ry4KkfzTc60JEYXaV19UYZaC58sFI3t3VYbsQZelg4GmUYhXckqflC/4=
Received: from SJ0PR13CA0150.namprd13.prod.outlook.com (2603:10b6:a03:2c6::35)
 by BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Fri, 8 May
 2026 06:00:57 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::cd) by SJ0PR13CA0150.outlook.office365.com
 (2603:10b6:a03:2c6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.11 via Frontend Transport; Fri, 8
 May 2026 06:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 06:00:56 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 01:00:52 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v3 8/8] perf doc: Document new IBS capabilities in man page
Date: Fri, 8 May 2026 06:00:04 +0000
Message-ID: <20260508060004.2575-9-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508060004.2575-1-ravi.bangoria@amd.com>
References: <20260508060004.2575-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b029be2-a5d1-4d43-97d9-08deacc72c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|3023799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	amC9rb0kjR5XzZ5Wo5oSd475zpyv4myH2+CfPhzkcQsH0fmv/BNSH1ULKOySRt0xxfoCLpp/TS4PNP7r/ZNGP4UQMTG4Gtuye6GtMEd90GH4j4OH4bmeePqqzxwnv+QyJ0OS1jNzlDXe1rgqr9fbPz+8aQYgTlztGkg5adJKfJvttagRgxPGZqsKd30fIOBaVRBLoFqjVubx7SeBo5WAQtyyXOEul70vrHah3CkSkDLXs/v+TPx90G1seidvA359zv9Ip804zAn/+677qR52h3yrJSWTexI8hEGST//VWQMCcvV09W5ul64jMI3Dd/aqQw5wn99YqtjJ7xT3nbwJRjq4Vt+Sfsx7PATBYWDMPxjNgpCS8G93UqI0PFN5izmKy3Mqg/5nxdpLcBdcdIWdtzfXxNWiEI5btkZGa+SEm7XWQM8uO0iThJ26rdBUnGJkncTfJywOY1gi8b49sxV3hcJc6gmQIonNO56o10npWvJmNpy46gB0vV3G+H2qutueG4XS88OfJOzXTp6HEsE+ooQN6K67XmfaFJNLfpp9GXTR0nye3uaa/NRailgap6L6zH5tJQ4iniOrIi/Om4sjheatGhwrN/rhV+WRRbm0FSKDgFESTAzJJI1FiGoqDB/WsXuD1jlG4XWNXFzuBd87zY80DufTlhbWBjDjNLPlffCrxBSbJn+PJCpCgWCXJdR3cLo0OeHIJEBjr3md0KwE5K8HhtYlvWe9g21YuGaw1Ac=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(3023799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OuiWCIjLbRN4noPvxnxVfIt2nRxwCcpLnxHrFwqbOByr6ilF86jLMG76Hj2ZM3CVKKHD/BN+WMcu1cwWy+uiEtjgECZm56WFCqhui7aUjUsnkh6ugUZZzPHJHtW4RR9Z1LE8Xn1e09YV/p9TIOKfs1nFe0xrJziaOJAA2OUJqGXae/sWCex2DXMTjmpGNUkv4LjzHZsFxTkIyoCfB0GRuZQqJAuro5Ze6Ha/XW2kk40AMr+Qhhe3vk0Huhlrh+5gfWUIKkx+JUWjFzmPXjSqjlANszAXgjaX73bLRQ8lhzocx0iFXcHEIJfdz5nd5WfoF9dVs1iVZemfN5oODJLklddkJf+KB4RIosxcyvfDiOSltMzirQGp+r4JQW8m6AzAieckk07ESoomqotK2VQG//Hb1Ic2Mz0E9a1sQufEBtaZNdzAAfRNI6W/e3qtqvTc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 06:00:56.9320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b029be2-a5d1-4d43-97d9-08deacc72c09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512

Include examples of
o Privilege filter with Fetch and Op PMUs, including swfilt approach on
  Zen5 and older platforms and hardware assisted filter on Zen6 and newer
  platforms
o Streaming store filter with Op PMU
o Fetch latency filter with Fetch PMU

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/Documentation/perf-amd-ibs.txt | 39 +++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/perf/Documentation/perf-amd-ibs.txt b/tools/perf/Documentation/perf-amd-ibs.txt
index 548549935760..253a7375c88a 100644
--- a/tools/perf/Documentation/perf-amd-ibs.txt
+++ b/tools/perf/Documentation/perf-amd-ibs.txt
@@ -69,6 +69,14 @@ Per-cpu profile (cpu10), cycles event, sampling period: 100000
 
 	# perf record -e ibs_op// -c 100000 -C 10
 
+Userspace only, per-cpu profile (cpu10), cycles event, sampling period: 100000
+
+	Zen6 onward (See NOTES):
+	# perf record -e ibs_op//u -c 100000 -C 10
+
+	Until Zen5:
+	# perf record -e ibs_op/swfilt=1/u -c 100000 -C 10
+
 Per-cpu profile (cpu10), cycles event, sampling freq: 1000
 
 	# perf record -e ibs_op// -F 1000 -C 10
@@ -94,6 +102,11 @@ onward)
 	Latency value which is a multiple of 128 incurs a little less profiling
 	overhead compared to other values.
 
+System-wide profile, cycles event, sampling period: 100000, streaming store
+filter (Zen6 onward)
+
+	# perf record -e ibs_op/strmst=1/ -c 100000 -a
+
 Per process(upstream v6.2 onward), uOps event, sampling period: 100000
 
 	# perf record -e ibs_op/cnt_ctl=1/ -c 100000 -p 1234
@@ -150,6 +163,14 @@ System-wide profile, fetch ops event, sampling period: 100000
 
 	# perf record -e ibs_fetch// -c 100000 -a
 
+Userspace only, system-wide profile, fetch ops event, sampling period: 100000
+
+	Zen6 onward (See NOTES):
+	# perf record -e ibs_fetch//u -c 100000 -a
+
+	Until Zen5:
+	# perf record -e ibs_fetch/swfilt=1/u -c 100000 -a
+
 System-wide profile, fetch ops event, sampling period: 100000, Random enable
 
 	# perf record -e ibs_fetch/rand_en=1/ -c 100000 -a
@@ -158,6 +179,15 @@ System-wide profile, fetch ops event, sampling period: 100000, Random enable
 	helps in cases like long running loops where PMU is tagging the same
 	instruction over and over because of fixed sample period.
 
+System-wide profile, fetch ops event, sampling period: 10000, fetch latency
+filter (Zen6 onward)
+
+	# perf record -e ibs_fetch/fetchlat=128/ -c 10000 -a
+
+	Supported fetch latency threshold values are 128 to 1920 (both inclusive).
+	Latency value which is a multiple of 128 incurs a little less profiling
+	overhead compared to other values.
+
 etc.
 
 PERF MEM AND PERF C2C
@@ -216,6 +246,15 @@ sort keys.  For example:
 
 Please refer to their man page for more detail.
 
+NOTES
+-----
+Hardware privilege filtering uses bit 63 to distinguish between kernel
+and userspace addresses. Hardware privilege filtering is not supported
+on 32-bit systems. Also, the bit 63 convention is not universal and can
+fail in specific environments, such as, using 64-bit host IBS to profile
+a 32-bit guest, using 64-bit host IBS to profile non-Linux 64-bit guests
+that do not adhere to the bit 63 privilege standard etc.
+
 SEE ALSO
 --------
 
-- 
2.43.0

