Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525DF635;
	Fri, 10 Oct 2025 05:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760075789; cv=fail; b=dzYAhTELU4BTRDBdlVAnMqLEPQdNzgb6mxt1lgltR4tJANQiirvriTTVVSYg287+kfyv7Tf/I80e6en+RPUkkWDqpGQx4n6PNM6CGO1sggUUxfA+4cezdiOr6XI9p/WItzVzrCjGTCuvCVbKN0naSC/0djvGYl8G33LNBfQooQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760075789; c=relaxed/simple;
	bh=5qcMVEhoj9vcEC5eaZmhql3Lh2MULTCNSDv/ImAkq6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M2VMNFtD2VqMdbmmSLpWttYtMO8ODXtH5icLG4bZCda/fYYnK/g4pDGtrWbO7lrR62vv6sZOUuxkVDMOYy4kVginAfUmPzbeNGdzn+wFr+ZaYxT/x82qyQUXQHpzVqPJbMzRXvt9Z90p23Zh3ts5VH7LbYs/k+QG+grhPeuEwAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WgCvVOF+; arc=fail smtp.client-ip=52.101.85.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WgCvVOF+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liyyIsZwJe2qeaR+95R2Q4pNAf/aa+mpgvbV71AoVj8VDvaWCaeIk8HyV2bGlvaCspTblfDedSPiY2+R8qr7ciIxnZzBDhRKBpIlx+9XVFzCkbcRu+HRQixZyvdIRMXJob4K2O1WZNL6lTWDP4OpTZNDLSEjv6p5WT5Km6J6RAUjZWn6UUYvjxYIY4XDglG6UR+x5bML6EyLVlN+lA2+crAThTBnjvzorbwBTV2fyDDcrMnTx6nNdt9nXmhd0Z+TyF93z+Exz6snbkGlDsxOGNt/vlXd+Pu+esqNmIb4xaqBMvG1vF7ktLy9Bi8U5/CTEuRF9qL7Ra30wOYDxRi64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6a45w9VIzYj8Ep7IwoGVafIflC6bzcq79QpKVbhHZk=;
 b=JqgzsswnIVwp71PR5/b82IUdYdr0GPPW1R3PThRM7do9iX8JGD8o15eAw6Rl2kMG4otmoTnvFESF89AmFPrWGF9fo2BX+QQoeGrKZQtEB8cZz1R+cMJcUX5D+5Qd7Fi7+QrqXHrhVGtT4OhgnG845aQjZjnkAxilIzDFh59uFpjflvsQOAAHq661dhZy3YWXCteJ5cNDKITbcC0Apj2p4JcE8jiqmAjrRj64IAPo3GnK07WDv72bQgX8KhFxXUXWczZRB13tdktSdEYJi2FLdRU6CCwRcvpND9LpO/LkGqCmKqfsQ3ist3fRNtUMCjjA1YgTsJ/OrK65Ns5hf225PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6a45w9VIzYj8Ep7IwoGVafIflC6bzcq79QpKVbhHZk=;
 b=WgCvVOF+/PtTPmDYl52DjymcCC5VJKAB5pvm5jVeAITUzm2B3wP4gQPXou4aKrsSSGdrVD2GqtpRM3VuIgtELGTFeCZAKZBtCknuo1dt+Ecdxcj9VMYlcv1wyjTaHxj8yH3onNC++dz2HJpxypn0/fRuq+PqF5emPwaAhJ7T4pc=
Received: from BYAPR21CA0028.namprd21.prod.outlook.com (2603:10b6:a03:114::38)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 05:56:24 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::c6) by BYAPR21CA0028.outlook.office365.com
 (2603:10b6:a03:114::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7 via Frontend Transport; Fri,
 10 Oct 2025 05:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 05:56:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 9 Oct
 2025 22:56:23 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Oct
 2025 00:56:23 -0500
Received: from [10.252.223.199] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 9 Oct 2025 22:56:16 -0700
Message-ID: <43ac631c-3404-4e15-a02e-d1976ead4956@amd.com>
Date: Fri, 10 Oct 2025 11:26:14 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] perf tools c2c: Add annotation support to perf c2c
 report
To: Tianyou Li <tianyou.li@intel.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, <wangyang.guo@intel.com>,
	<pan.deng@intel.com>, <zhiguo.zhou@intel.com>, <jiebin.sun@intel.com>,
	<thomas.falcon@intel.com>, <dapeng1.mi@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <aOTOEcNOiUiEJ9tz@google.com>
 <20251009042839.1643396-1-tianyou.li@intel.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20251009042839.1643396-1-tianyou.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: ravi.bangoria@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 253946cb-5d99-42e4-80aa-08de07c1beae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHRmam13bmIrY2I1L0U5VjUxbkF2NkczcHZ5cXJ5ZG1FZkh6Y2Y2M2w5bDFL?=
 =?utf-8?B?WVc5ZlQrQllNdW1oQ0FFaWxFaDhDNC9sZlE4YUt3TktmVzBtNW1xNHJIcktn?=
 =?utf-8?B?Nm1tTlFDMEg3TFZtbHVydTFhRUNxSy9yWjJuZk4vVlAyTjZ5dmMwaFBtZzNa?=
 =?utf-8?B?cGJuaTNpQmVIdG1NdmNmNkt5S25qMElpU1ZLSUJCeHJhcmphd05xSG1TSzll?=
 =?utf-8?B?NTdtWmRMY2lRTWhzcXppcmxmNk1pZHFCYWhkTVBYTmY3ajNpOC9WbTlRNklh?=
 =?utf-8?B?Si9GR0E5SUt4Wk55OGJucXlYL0ZYOUJ3YWlhTlhlQisyS0J1ZmthWWs5QlVi?=
 =?utf-8?B?Z2k1bldZMnFJRllvSjhaSU5CZUtXblQzcWJNM1BYTGxWWTRaZU5nQjczaDcz?=
 =?utf-8?B?eHl1TWpXL1dpWEs5cERPWjZ5R2RSY0diOCtHTG1SNnVNVk9GeUlKQTlwNEg4?=
 =?utf-8?B?elJUeXI3MVVsNUEwUjk4R3ZiMnJOOEJVQ005Ly82TVJjVlZJV3RmcG14UzVt?=
 =?utf-8?B?YSs3RWhGNzB6dkJkclAyUGVrckxHWnlaSDJmNzRYellwRGhnR0RDcmxtWEZU?=
 =?utf-8?B?UHpXZWJ6b1lKQ05oV3VoNW02T2M2T2ZJcXBmdVpvZERBQUtLaGUyUTRUV3M2?=
 =?utf-8?B?ay8zMGJoM0dUY3p1V3ByYmcyT0tHNG9vcVVMNWprKzk2bGw0Tkg0ZlJWQ2V2?=
 =?utf-8?B?bFVmVEZlb3I0ZWFSWEQxTWVMOUFlSHNLMHZ4OGlhWk5aRk4zbGVjeWw2TEFk?=
 =?utf-8?B?RGJSRUlZOW1pejREN3YvMm5FZGk4TFVNdXNMaFlZUHk5N0lFYWY0Uk5zanNQ?=
 =?utf-8?B?b3NQbWhYOUZFVnRuYUk2ajBrTE5UeDJFTTY3L2tZZ3Y0V0tQcFRieHVoZ0xR?=
 =?utf-8?B?dXpZSzZqakFVWEprQ3Z5U2J3MzZNYWt4anRIQkx4eXVqS1hHN1luSWZRc2xD?=
 =?utf-8?B?UE5ValNLVkl4VEhPL1gwUlZNWXd2VFVaSkNyWmFpYmdwOWhuMUYvNUNGc1BV?=
 =?utf-8?B?RUNmcjhRaVY0aWhtUHhzclU5U0cyajYrZnBQRnRkSy9COWFhSUxtbmMwK1RQ?=
 =?utf-8?B?WVpjVkcxQnFPR25kRzhpSGRsVzVJQnJEQXQ3ZnAxNTBRUnlBeE5sUU1aWGdM?=
 =?utf-8?B?eGJNQnkwYTVhNjNhT3dlUFdYWTlibGpsNHc3U29ETHFldzdzaGtjSGEwd0hX?=
 =?utf-8?B?ZzY2YTQ4cG1UZUs5alI4b216elhJWWdGZDRkM1FYVktZR0lXYWVlYWt3TmE5?=
 =?utf-8?B?aTVITC9JcnpqSjNEUWJxK3F3MWd3bmZNS0xZYjZZOHptbGtNdVdpTkpxeDZZ?=
 =?utf-8?B?SnRpQ2RaNDZoYzJ4Y0JsM2xxN0w2VTIwQklXNk9JcFZHMXZqUE54R29PZi9D?=
 =?utf-8?B?ZzkxTG42VDhMdzI1L0drTGhsSHkzZk1QbDhhLzFUcnlCVkhZbVNXYlRmNDdR?=
 =?utf-8?B?dmhvdFB0RUJyTncyQmI3NFFQRFBjQ3AyRkhKelJGWHFiUWZvWitVQ25xRTht?=
 =?utf-8?B?WFc4Y2E4Nmp1cURrLythR00xSndBb3NsVGZoa2EzRmIrb1V0ZFZYaXpmclJl?=
 =?utf-8?B?UDNtNWVBTkxYQjZvOWxvbjRhRER3anozQUFIWVBFd09VTVhLOWhDNmw4UUds?=
 =?utf-8?B?aWdhVGt1dmpSQ1ZDYlBHS3BGYm1vbnJPNGJGdDdUV1hYRnNrVkpLamNRWXpm?=
 =?utf-8?B?bHMxZlVwZ3VkWjBHaVoxOG1JdUNJWWlVMElZTUFsam92dWIxUUtzVWk0V09j?=
 =?utf-8?B?YjFYbzhmcGtTaFRESnNDTFdSSEZlU2NGTElnbGphalkxVWJtTTNCSFpaL0t5?=
 =?utf-8?B?TUFqMUpNQ1VETDh1N2pCV2U4OHN6OXhISzJDenJiTXdqWU1lTzQ5SWpNU2xr?=
 =?utf-8?B?bEU1MXhwMFE2OUh1eDFuNW1xM2FpZ2hya2doTFYvT3JWQkJLeHJsL00zdjg3?=
 =?utf-8?B?c0JUbGVZK251T0s0aUhYcjBiRVIyRFRBeW96b2svR3lpVjdmdzVZbU0yVUZu?=
 =?utf-8?B?cFViM3d6Q1RqMG9XZUV3VFZlRkt2ME4vbHVBRGF0dDdFWWI4VjM5WE92QW1n?=
 =?utf-8?B?eGNqcWVuNEhzbDV6T3hQV2V4Z0svNE1jNnpXNHA5RUtCM2lKZFg0OVlQNjFi?=
 =?utf-8?Q?gRlg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 05:56:24.1002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 253946cb-5d99-42e4-80aa-08de07c1beae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226

On 09-Oct-25 9:58 AM, Tianyou Li wrote:
> Perf c2c report currently specified the code address and source:line
> information in the cacheline browser, while it is lack of annotation
> support like perf report to directly show the disassembly code for
> the particular symbol shared that same cacheline. This patches add
> a key 'a' binding to the cacheline browser which reuse the annotation
> browser to show the disassembly view for easier analysis of cacheline
> contentions.
> 
> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
> Reviewed-by: Jiebin Sun <jiebin.sun@intel.com>
> Reviewed-by: Pan Deng <pan.deng@intel.com>
> Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>

Works fine on AMD.

Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
