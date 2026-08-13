Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057E4963CE;
	Thu, 13 Aug 2026 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640542; cv=fail; b=bby1BAjh0D3KkLzuLyZWzghmJb044uAHK7TcEARUQksPBIl7ju1NrUMfebAs757A5rWwH9jYWNLWyu4gSkqHaSXFk3HTbPiKZ3fqaCosVUm6NSBFfR9+lInyo2wahnBHbAzJ7aALt53AGFyErqi5HqfsljRO7I8TplTMMQ2KSPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640542; c=relaxed/simple;
	bh=bBJIMHMQpSsCX2E8ENEmd8SAPP64s/qx2A59kb1G77U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C1MDN3O2JBP5BDcsX5kT5fSunnrNORbkpgtJA52hQxNwRKlPMF3Q74dg4g3CLdEx6KNPc+1uBSkZZZFPGA5iW2jauoX9l2mVMkytynYCb9y2Y1ePel7DgZ4H0293eG5oR7OYLL1i6hx0aRB13JzxbDGzJ1piXyNj8LarLcaUpKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hCuPFy0j; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hCuPFy0j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpkOsOvst5JvLmhL+c+672Q0x5DG50CETf3zvgSmc+aFDuJzu80Th416YVCAbwkA5kQaJUrQxTI4abS4LUrgbAypipZGJBvzg443jDOhMB+q3sAyo+BMs09/6ljPp2k+Opf5Avfv2GiFroOPBJBRoWnbVyT6BZtQLjyO3mDykFEbh1pFAahq6BvSdM61gAcbnWKpjLsvf4C1NRX3bLWjTadXAd1RzeYwlxklaHB5D6MRm3IfWGQCbGeRPleJj9N14xg01dQLaA3vqevIzEe3sGubzQFMpZlwRF3q/tAtejcQ2pG8l7JanHg7aNaSfrh7Ho8YfgwLh2n8Zb2VuOJjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X844hANN/nq4cZrXn8srmcUygu9fU94wsVrZNfaNruM=;
 b=GLaPk+QIl1LROIodMSjN63PdaXm8A87Kra9krhiDgwo1qlpSvvNMwSTpqOaR/0FZtjfoTh9Ade8QzEROyU4GCyOd+k6md7hq9LzcuSj5wy18TocFgZROBUwri0F3FcZyQYOerByP9YyCXVTtQnYHm2Io7uVVbwQDzz5AowVWgxLjvZOWeAi7q4ccvimAU9oKQN6zTC2fR54y6YzDvW9HV2+O63sxyfUuDp/ewjxabFbOCsxITN1CMjUbwuakP3wonnrjLF4rvhEqNwKYcqUA1yM+lfUaKbTtBVdRi4OUoRr4AWSOxqtjsr1Q9NEro0GF97sCeJMuHsI23lBKw0evBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X844hANN/nq4cZrXn8srmcUygu9fU94wsVrZNfaNruM=;
 b=hCuPFy0jQ2kFqIn1NhMdPOYuvpooPAgqadeiN/qkqngMZVuTyVlX5WeTgIYhKdImZZum/YAC8HBbNgBRKYdnMpmj8zNf+VQtPj1Sa2h1gEL02dPbYZlikTf3ezlnqjRMq1hyN/oTd26qCvk2lkCl2ueox8x1FB9PIoyggBvBK1f4pElebgGJsP4aVrROCd4x+2/+AaLoVuFHGwAGbMLIi+AacYqH20Mic9RoFyp2GrCidMj379eeVCro4RAcmcv0qRx0yEcInzbP+o6KhROMPwnp+UE8vF+nWur7TfBcbt6vo99RCQ7HpJJaN+u4yMiV/YVqzJRjn2234YRbeVSA9g==
Received: from SJ0PR03CA0137.namprd03.prod.outlook.com (2603:10b6:a03:33c::22)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 17:02:13 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::81) by SJ0PR03CA0137.outlook.office365.com
 (2603:10b6:a03:33c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 17:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 17:02:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 10:02:00 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 13 Aug 2026 10:02:00 -0700
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 13 Aug 2026 10:01:59 -0700
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: <john.g.garry@oracle.com>, <will@kernel.org>, <james.clark@linaro.org>,
	<mike.leach@linaro.org>, <leo.yan@linux.dev>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>
CC: <linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tmakin@nvidia.com>, <vsethi@nvidia.com>, <rwiley@nvidia.com>,
	<skelley@nvidia.com>, <rajjoshi@nvidia.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <mochs@nvidia.com>, <sauravsc@amazon.com>, "Besar
 Wicaksono" <bwicaksono@nvidia.com>
Subject: [PATCH 0/2] perf vendor events arm64: Fix Tegra410 Olympus PMU events
Date: Thu, 13 Aug 2026 17:01:53 +0000
Message-ID: <20260813170155.1156593-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 449fa327-0f1f-4e2f-a333-08def95c9ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|23010399003|11063799006|56012099006|3023799007|18002099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	mW2Qq5BLX8JSrzEdofLhuT/sSZ53xxjxWavdvegJguOYI8l490VuPSRVF7mmUxtirrTl5LgcyiNnhkyqKu+RgXCMnsyGJne6EhOSvJG4QVEzsEQ8KsjldT3leKi3WO9+UgELKlDUUSzB0PmX9kiCptSVIems1mor7E6THfYD0XZ68nrcK/R/Wi47AGGgJPjO1HsjRIaG7HQ7ZUROCBgsAz70PuIqLFNGOjZDXLC3KsZZ8WsXqF7Oo3kp4KsTZTlDM9PMEqQgIvntSblQwHK1QeJvkg/EJll6zupMWpKLCM9re/nBcajyq03OXTeUy1lCrFJG7QihfHSkA2nN5t3/+dp6zqsevP4OflLG7uUvCt4KwObaUWaxnzMxBHG1F9+QvjO/FLstFwn3/nDZHyizYhm1Br8LSaQKCfWo7Kfjirn3etD50mt6G4PGigloG9iYdtNpoP/OfElbFMM9mhIjoLCI/HZmeSak73NUdDuVBIToqMSHe+0UMz/++VTZwi7ttmZMX1J44pczpzymzm3T5wAtiwUOm8FXYVJWjsOEtIUSAUWeoksnI1ZAICECU5STMnGSedbU6jJpuTjezQkSEn92+SQQ3Mp+IKoPp/ZzivT3f6EGIZBswo3mjySq7yrtwKy8ZsZTkQdWRrWhbL6o1bL1xa+gODTTOyqlqDA4vMPzblCtvzebT0BGhNR2YxnZItpD6JvFJdZwqso7ciVImxFYzr+5qZ0BxQNZpLmi0DzPgubc9eiDUwJ/NBT4hBrg
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(11063799006)(56012099006)(3023799007)(18002099003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3b4TWKwQpsraS0OGpI6jcDlGYBrORwJlIV/+qb6U2I21gILKJtjRDtW1jProSmODc3gsKRBj4212RuSjsCSdQ64Uk+SUwYYjs18sZ89+NQ1CTn5WLymyNIwhtIJBlS3h/b47pdSIWz907sGZMDqwi2jjZvSU21YFb/oW32QnO9oFaxpn1cg00F4mXnxML7eOTDvFOPCN7fhrPQ4wqHxGQ5YlxcYOGbGvQgFEAe/AT/amD/731Ix9bBsbnZ0CMd8bboK2py/nVXFxZIS+ThzCidLfEH6MsS0paEpFAxhm1vv6LTUwQkgm0jN5SEAgu9D8MKFJejv5ea8vKehNAODPIsM5ubIhliKZdhbAo1T0O/evGdoD1s2tcRPOSMgFb4/zbTwmJJo32/1ZkyZGrC4Ck1PEJy/2FVPwXZ8MlDS932JiBfpBQ7eQ7yhVI93rxGx2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 17:02:13.1258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 449fa327-0f1f-4e2f-a333-08def95c9ee6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728

Fix two issues in the NVIDIA Tegra410 Olympus PMU event definitions:

  - Correct the swapped MetricGroup assignments for the L1 data and
    instruction prefetcher metrics.
  - Correct the name and description of implementation-defined event
    0x0197.

Patch 1 resends the original patch from Saurav:
  https://patchwork.kernel.org/project/linux-arm-kernel/patch/20260511210832.91408-1-sauravsc@amazon.com/

Besar Wicaksono (1):
  perf vendor events arm64: Fix Tegra410 Olympus event 0x0197

Saurav Sachidanand (1):
  perf vendor events arm64: fix swapped MetricGroup for Tegra410 L1
    prefetcher metrics

 .../arch/arm64/nvidia/t410/metrics.json       | 28 +++++++++----------
 .../arch/arm64/nvidia/t410/misc.json          |  6 ++--
 2 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.43.0

