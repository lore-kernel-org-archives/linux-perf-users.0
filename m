Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012006.outbound.protection.outlook.com [40.107.200.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D41374E67;
	Thu, 30 Apr 2026 06:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529541; cv=fail; b=jM3R92UA62Nl3YoLVVHwnMs6DNv16+ZpJckTweHPQyfh++Gw5c6EFjM/DGXzQ4tULP2ZAbo2zQetysDxskSDEQL3ELme0z6l3lA5u4R8tvanzqiX6RDZ4otSPKOl1rGAiqaG9+v7bYKX7XhxRZDkqbPSEk0QTidR9KFIIu8eNMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529541; c=relaxed/simple;
	bh=2I/7dNmvqfvLszuMBUvcS1yadoiZUAoSrRw0qa+Zwhs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzsXuXbj55v/zNs3uInUn0w9efaGktGRoSX0Yke18th7J2Z+rCuKkXTTVw+X/akaD035hb/2Sa+/EdV0SAznLIBfXdveaJ7co91IcCqCU3Q8JG2+lbjd48w3R3YVPS8fBZt8Z4wWlbPSr4iQNKGTvjaaxZ+k/qd6YeSMKI65CMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wyaiCk0D; arc=fail smtp.client-ip=40.107.200.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wyaiCk0D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9bHMvxr68U+C90vW0APXrF+RAPrRIq/4B6y3073o0IVIpT9PSk+bgc4BeMaeiI4BKi4DKfbR9HIOlFWH3H1gCzcF2Pqm3v5OqGj/WKPmhj3yLtVl2vv6hqKz/DUHbuQkK/a7jo2fdQhsl7S3KuZyE/gM7a3wfVEVMoTgG2TS7+2WckM56yd+BOGqVOrHQybRWntBgWqh7b7qv0Fh4sTKQrLo9OmWF0RKnvuxEIY8nd6EmDwYuH29WThKDYjvEvCSAdXhSeVW1VipwmmRbHP09V2nu/oX1XT8b0SRgVyGGazapd99EPhTFrmgu8ml50gX2TbjEEbbfe3G67IM5DhlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfP3sE+We9xDC8s+n6Ny2N2/ClCb3HLTFPaTOIaHaIw=;
 b=xgHMD20ZXpvHiMyXfpIl1iKcExBFfAwQiTWRoqimSXm+36I3KYC29mwjqlUQLU3BSQ1pk9x9cDkuslH4C2Ff3J5ZNWx5r0VInTizdbZ91kNqSkj/N0XnDgV1js1onjpM4pbRm1xt+ckJooz6f9x6eRk3NBNTSvi8oThrYKccD1U+uiL+xpMoTA3rZMG1JKcTPQN0lnfvCQ8p1pfHhZIB+MFkLLZB2VhaTmEYlFYwGyntrS4sU4ltX1TpQUnLaA5m0hG8o5raDPFKrMhl8CS345ViXmQc9US0MDzdV4/uIDhCC6pOqvJXkjfrAN74yHI887fFcKukA+5jwS0wNq2kNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfP3sE+We9xDC8s+n6Ny2N2/ClCb3HLTFPaTOIaHaIw=;
 b=wyaiCk0DXBRMTC3tFeIUlJHScs1DbD4h0mUVM4tFKtrvFz+P3fb9KHwpGQprmy2I/GJ5qlthovcmSt1USuskzRtI4VpJGkTCchYiKPu5EDLGdy5O8rONXttb3cH1EKvhs21SqudEkK/P04lBTlur6ziYjfZWeWTiJHDN33qtSdc=
Received: from CY5PR15CA0241.namprd15.prod.outlook.com (2603:10b6:930:66::10)
 by LV5PR12MB9777.namprd12.prod.outlook.com (2603:10b6:408:2b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 06:12:14 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::76) by CY5PR15CA0241.outlook.office365.com
 (2603:10b6:930:66::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.31 via Frontend Transport; Thu,
 30 Apr 2026 06:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 06:12:13 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 01:12:09 -0500
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
Subject: [PATCH v2 8/8] perf doc: Document new IBS capabilities in man page
Date: Thu, 30 Apr 2026 06:11:15 +0000
Message-ID: <20260430061115.10266-9-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430061115.10266-1-ravi.bangoria@amd.com>
References: <20260430061115.10266-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|LV5PR12MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de3723a-89f3-448e-7264-08dea67f6c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jyK8kEqzZSINw0hSVNlkAQpWgWRxoQq4OIqaMSD0ZJ+jD3rQ2E0DirOrmIaBp4PuuTGgEHZ/JwPUB6ykyK0C/nzkFnUMaUzoz/5ZcW3/J2xxG8b5Zm16VMz6hseVNLgxvryuyn9tAhm1KQkCnpkdLKJlIHRPmbVpWDw4mRatxwm/WfUI7XVWGjTkKfIFCTYB/PiVONe+AVsyN7xGxfWQMOznpMwHcB59HxiP6axSeWvqY9BJv5s3Pdrj3A7Sed2SgSwGsRZ0cBHSYHAF2pvpqh5p3hjaiGI+F3neOJGGI47N79ey1gfCHwcFvZFfCXWlZHXWINVFi0kQPj6sSMG5+RJev/BEg6JIvzZOz2MTWopRH1qibbIRKkxCN7Fa5F7GCkML8Uc8XaRSM9gT8lH/7GXf15BkzMh/RiEzHHVT+CF1mOaGV0KZrTcSSWRbCwFOizHDIgBDUjDsE/2BCkvphQu3cbXwdLrueZykZt2E2G+Plp11h+OjtOjmYpALNtTC4bG/6boDvF6qBEcOOglHgo2W14AmnNEGBmUGD0wip+pJvkNjDDubRmWMMMG2iZNYG9MwWw+bD6fOULJB/jm1Ak+G+cSoo9ag9OZRzXkFQNUyR4IuDUAqYo6t2DPNvRV7UXkGDqfRb9r+oQLxUnHufYMwjv0C8D4Je8gFyGZv0WhZ7O6tthNDay3qXEsRuFmAiTHiDiqx82CFg96c83XqO3YBbtwCHF90z2omz0a7CCQ2fKMiKQBUQ85MEP8RiSUqs7nYav2KKHCv5mKhMZn7Dg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/iFo5XKZRMa4Qdw0s3aT+jW9MI+0han/nj00hvUFO/6JZ99sA2B2H9CcOoUhCj/vgBkYaWeoq9+2NqfNuIRrlha+bDWUiD+T7CJXhD3LonOEIwTBSierWkZkoMdkenziKU64gcj+NrYfT8dJSce6HCquFTbbegaasagEaoRpoa3UHgd+z2ij5utBl8kSFj85eKX+n/U9eW0F4AT4s/WHTTgwq4lSdbjQMVQMgp6wynkv6UE2/YpU44YCSqtrAzdh5GFrPuboIZTabCe+skdOayiZSzQYx80tytzzYEaPklvv2s7eEJ6fBeQYhyLIF4FZKuffKesgPXXcWr5qGclKTbJUkTU17/7xoB51vcuizy6poxWsg1q8KnxmmnhmD9EKT/vejzOErPuNDDx7J7axOSuQf4TZzu7N6mZdLmmFRyXS+VD1Ut8QUsL3zfx3Usga
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 06:12:13.7775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de3723a-89f3-448e-7264-08dea67f6c22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9777

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

