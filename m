Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F501395244;
	Mon,  9 Mar 2026 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056418; cv=fail; b=n7eroPDWLTGQA/3xIyB6U3l90QZmfKawYozJADN3RNhEUzCkdCqNm6ImLbd9CqcWR9dyaFIgT1aMEssriqaUT87bAa9g0Yi14y1sfgWdjISAg/pT4Y7pLuu3A9H/8s/J3bm0u60Xj0fiYRvVYzIVLhaGuokvMNy67Xj1fwy/ABA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056418; c=relaxed/simple;
	bh=knXUT0gJUKEIQhq6hAQGcJ1Q8AlstiD9U12q02v4ric=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KPraCaE/CecDdqKhPY9VXh4ikis8rDpq9dC1qx82eoWcK4coxGF3CGLgMbTBx1yY/KfYw/O0s4dvgFL2jEe015kc793xvJq8avDfF+Tqez2qoSdfRpXhHleoh3YwgzL66e+NrIiV2QmqEnAb6t9p1m26H3sq2tZOdDS0AovHUi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ob+8kyUC; arc=fail smtp.client-ip=52.101.48.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ob+8kyUC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cL46FF/0gpVCfJ55t7w1GecA296g10Q8whx1Na2Y81tDFy69M2c3NgMd9dYwpkxYoZMrGEP3ib673lSoEICBhPfqhnYw8YJPNqce5sUtdLfhnKAXvrx0RkF1+VAyWRFEeL3aXh76qMKSvwL8vEkpT5I7WeiQdnI9UHjDJlvrOHOgaxJLtuqD+aikQpC1uu5/IFXWtPIHzm9NZTCXa3vcfxeWYkNgDT69NAeh/kM5m5MBaatOo8rOkFOOkp4X5bWQFX/nLpfawWHBU1O30dMvbKHzaX2CyAaqKvApDpCh1rebSIwO1gXaOPDFA390edP9GDME5yOzZ/26uIxIBxTO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knXUT0gJUKEIQhq6hAQGcJ1Q8AlstiD9U12q02v4ric=;
 b=J+YgoNeFyTWNOQ1Ybyz+wX9T944iBa2DsFh/MNpVG5FHzjq+OtY7Q7oY5DX/QuzFgh4TjudlRmm63jaQEcbZF3xNo3O6PPln7Xq07qcEl0za+K+MdBevDf5WvcxN1t/CMsdMbrkZKTBB1ZflhwLU4GUdSTHLL5ZcY/yRelM9gzUbmwqia0QbteQk8Dcm9eyGVbrJuegqtX6HmdcgQDa8lLdexcPJEjU2LLCQtDaoJn6k+6tJVkXUgLc9udY9NuRVyT9U9mWCrvHS/9HGpbIRAupHVmxioLZqyZYMyp0XTBVuJeUflTbifFpADZ/XdZKKmNmsGwMNnYFgJBsXIWeTJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knXUT0gJUKEIQhq6hAQGcJ1Q8AlstiD9U12q02v4ric=;
 b=Ob+8kyUCyxP2za/mjR5QHfV8HEePPnRjpkMw1Pg2/gT8m0oxK9sYXl1qaUcg0XY1l1weEnCGAHY9rHJ3G5hvwYJjaHKdLlBpPI7gVt2YGsgbxK1az8SPhWBcpJJPSNNIK1Dnj0JOma5ttg0kWqhfsSyVqV+q8F1CMntqMZNuAuk=
Received: from CH2PR18CA0037.namprd18.prod.outlook.com (2603:10b6:610:55::17)
 by LV8PR12MB9619.namprd12.prod.outlook.com (2603:10b6:408:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.7; Mon, 9 Mar
 2026 11:40:13 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::b2) by CH2PR18CA0037.outlook.office365.com
 (2603:10b6:610:55::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend
 Transport; Mon, 9 Mar 2026 11:40:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 11:40:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 06:40:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 06:40:12 -0500
Received: from [172.31.177.127] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 06:40:07 -0500
Message-ID: <9145b8b7-fb83-49c4-aa17-acdba069359a@amd.com>
Date: Mon, 9 Mar 2026 17:10:06 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] perf/amd/ibs: Avoid calling perf_allow_kernel()
 from the IBS NMI handler
To: Michael Petlan <mpetlan@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>, Sadasivan
 Shaiju <sadasivan.shaiju2@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260216042216.1440-1-ravi.bangoria@amd.com>
 <20260216042216.1440-5-ravi.bangoria@amd.com>
 <81204aa7-9d81-8d53-b82b-6c4ad8c89c2@redhat.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <81204aa7-9d81-8d53-b82b-6c4ad8c89c2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|LV8PR12MB9619:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ab8452-ca55-413f-daf9-08de7dd0a05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	UIwNzSpUl/F3VT9gi80bxwVObtuu6rz8Y9m6MkG8o1POALfLKNru/R5HC691y7fq5VwV4KuA6i5iBJ+4000/IYaTfl65uxVNJ6h9B+Tppse9C4a1bRsLmdzagj+Llr/d4/Ee099XWD/DKf3tOcXmo6trkULLdG2gRW942Pj07WeyX+CjvU77ClzlGvIx0mEA03MXg3QsyN7caDoBw9z1efxfJ0aPn8zIls8GYjgG8sebDd7t8p340Hp/w5ESeDNMAX4UBBnnv0OFhFNk3I4wCW0ZCUDY63Yi9pZYwkStCKVzA9gbs7aA3wG9JCApq8Cp4J9M6Yzd6n7+Yd9vR4LeiDih7QfQcWRJiI2GNT2mvTnqgHCQzUrbZneWah5WHxoODubNIFFP6w71J98qugyZg1oMPl3ze7FQJyy+Bn8miBVJvEZNYT1A/J8cseWf4JFM6XZniUlg0YjKrX5saNX/hRLJ7ocKaCQiJVZa30bKiyB4CW9UkH0/Wz+aFESbFL1HbtSrbnWoUTxugmcEeVhoAu/HkCm6LltfW1vlTrE2VOVs7+Tj+HNZITebBwpaEfljW/jOXKWHBFpQXT0TIRIPjdHnSHOwS6Gp3II3KRPFUxjPFE8aUYcUIOcdTJJgA77BIbrTI84TECBL7f2QO6AamexmyTZGaWUbMATzqgcJLTFI7O4BHdghbzy5h3bY5QSV8fEWJwRHNx1/Hga65huBV8284VfyPkoKeuyPKdyXqu6ot4RdEb90FSoEp2EZdN0zOTy4LYm7JGHPszY5a+L0Ow==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tDCDOjVI1LDH42b1GMvPoIurO1ExUde1dWmoNIoV2tbdWYjaZXCy8wWcSCjh1zEFVV45gEdkj4zUCxWO0c58oSjZ33+wl+G2f2ABzERSCGThteVvrBY027UdZK7NIsxI6tCyGEbP+7OJPSS0Ibyjjqd4v9PEQnenB3PGRLLaVN5fLZAr6EE5mz+JGvnRE9wO59xMXrleh9TxfDDvY3qmY3qLZdjqJZUM7SA1LnQIdx7DkX+lkCZVf/kf9EZmVvBemmV3kOR5vD3q8zuFnImMoER9djBuhDf1It9RMaooHLsz0Iuy9SBicsBCDX2bsHldZugvwY+dr4PAeGKj+KdMTb7HmFPb319ULV5EoJawSa1wQQs2VGLwJ5VHglNaLGdQdO4OxoQMCuf6md5F2hQDM8JeKvDNRQHPLOAhoNjw1aBYHTTySg+oaViQtqZ+ZIz/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 11:40:12.9982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ab8452-ca55-413f-daf9-08de7dd0a05c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9619

Hi Michael,

> By evaluating the privileges at the event-init moment and using cached
> value later, couldn't it lead to the cached value being obsolete at
> some point? E.g. a setuid program later dropping the privileges but
> still being able to read physical addresses?

Yes, but wouldn't the same concern apply to all other call sites of
perf_allow_kernel() ?

Thanks,
Ravi
