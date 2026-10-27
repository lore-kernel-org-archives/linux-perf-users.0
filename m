Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793092627;
	b=ay3ulVl8rPz7/BjOABBNbc2DIczH23r9ZNZHrg/HA1EDmGKVNj5H7u8i4fWya58Riz5G
	 JFQytJsqT56P2bqoOug1TwlPsL+Te5M+tt8QB8XD7f6X1TXKkO308lKLzd5fiNy6uSY9K
	 fZoO47ExmlYkAl2eGklWRws5yQkzC4VQ9zmaspBr7E9YlI6ecGJrnG3xpS+HROncSod6C
	 BJg+VD/kCP23A3q/k1Vn3NVC1Mp2TqvuBXxh35n/hN2UGhO2SHlVyyo1hc+eB+PNBb++7
	 FZBlyD/Kb7XILUU3XgdRAqZPTQvwdDS1BPWBXn5xX/brU8seJTmns6LXY2Gw8cZyskA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092627;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=U9zYVVXlJgpX3/v0F55+JoW9OdbPKPL+KfxK6oXUrS0=;
	b=479ftC1jSCNWGO1FLu1Usy6KAlvCbux8c25JwEQU058u5nl6nGpS//L92WbzH6y35lxQ
	 2lip3ooqcmg8Oeoefxo/wstuad949OrUuGOysn5gsE3lgmXE5tjFPC/Nn/lMc6BlUCA6+
	 raCDlvDpJqhG0471Iz+YXvT9UlY6sS64UX/56OK4PnkIOtN2a2Rn2RDkFG9x5F2pHE35B
	 UPIgdwEIHmcztIzSkkJPDCXcHVoCipTYiG4Wnw9pIIHzT6/26AmS4fqzUjM6GWtoPOR33
	 ySLfmHD8lr2yD3TKMp9B+pFcz3KjshIpK1jb3V0Mk5slQWozZ84ZkThS4qz4l9NnGkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QMLAvAbV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.18
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125D6606A31A;
	Tue, 27 Oct 2026 09:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 125D6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QMLAvAbV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOoWQx+kQ3nuXM0U0W39zen/AOQ4sbwPUCd7k0mkI1Phk6VxcievNZE5DRG8bJHsDSayVPxsA05qllfH80pXJnHl3Zy0dkJf9PSQ3qpxlk+NxUA/zXVkM0OUk7Xxv/WVLRJ5x0grXUP8r8B2X39cio2B+6/DN5OGVhdQh5e1VnsA+aflFK3rcm+f8YZoZe0AUpqjtTOLSdqWQhWkgIoLwHz2jbDhYF5/iMr/87nI4NwEwmqgER8IQ3bCSv6i+OWBz3URZ1Duwi8R+GeBlQA26w98vV5SHP/Ae+aqHEE18z4UFkg0mDbBze1JFRaXEx7DdH78OcK0llyqwWZ8/5Mwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9zYVVXlJgpX3/v0F55+JoW9OdbPKPL+KfxK6oXUrS0=;
 b=tJ3u0cjXFA3LVq2xqfu0rvdF8O7NhgkavJBMFfAyFo5S4WcDX3QYkKg7HPYgod0VS5kllS+DZg8DRcGX569I4IYLrrjUXBo5kMpZCvbZZ7iENjOh9DrKkSsXfSAZ1UK+0mHr7Ih0FuV2CTzRzbevJ6n9a4xM1FZZIhDlWmNcqJeGZC71KoupZGcuZXwxYOyWozQ0dnRLavZa6zWeIMGK0IsaWC5Legr25DEMrhRV4U7jwnep9iicGcY68Hr16b4mbjQbBnagKCNREU8/fpY5QAaxAUMDtjHROUzRHb3yazP1j2/ciM5hHSpq6Xx6/vItz4Y1zw3kRElf9dx3cs4TPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=hygon.cn smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9zYVVXlJgpX3/v0F55+JoW9OdbPKPL+KfxK6oXUrS0=;
 b=QMLAvAbVWJmZ3JNqnicSY1L3UkVpBuprjbjdVSAHvlqIlSsd0O8ZVprVUSNWDocxs9a6/IUBbF5bxGf4Ijx/AC08pgsXGiIDBpPHVI43q9GxxR9jlDQIG6np6XZhhCA0NHO1DIShR7av6bhrYUeBP6/2MzsbB9ZaUgfEcv0GU3I=
Received: from PH8PR07CA0035.namprd07.prod.outlook.com (2603:10b6:510:2cf::22)
 by PH8PR12MB999296.namprd12.prod.outlook.com (2603:10b6:510:40e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 09:15:02 +0000
Received: from PH3PEPF0005961B.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::77) by PH8PR07CA0035.outlook.office365.com
 (2603:10b6:510:2cf::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 09:15:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH3PEPF0005961B.mail.protection.outlook.com (10.167.243.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 09:15:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 04:15:00 -0500
Received: from [10.136.37.101] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 27 Oct 2026 04:14:54 -0500
Message-ID: <5af2d381-408f-442e-bba3-5bfeca01161f@amd.com>
Date: Tue, 27 Oct 2026 14:44:53 +0530
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/amd/ibs: add phy_addr_only software filter for
 ibs_op
To: Huang Shijie <huangsj@hygon.cn>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>,
	<yingzhiwei@hygon.cn>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@linaro.org>,
	<tglx@kernel.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <liuqi@hygon.cn>, <lijing@hygon.cn>,
	<wangfengyu@hygon.cn>, <wujiangyong@hygon.cn>, <shijie8@gmail.com>, "Ravi
 Bangoria" <ravi.bangoria@amd.com>
References: <20260902085251.4046240-1-huangsj@hygon.cn>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20260902085251.4046240-1-huangsj@hygon.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961B:EE_|PH8PR12MB999296:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5e881e-7192-4ff1-9b62-08df340ac7ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|36860700016|82310400026|11063799006|56012099006|10067099003|261021121427099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hBcDzaoBmHovO9tc4aL9+LRaTiZx4/7h5N9dolSDmtA1w95AP+WKxsIT0lyWEWroCGCYE+okCSj2qQ05uTvPXlm9gby0XSd0juUv+xPJv/kdUnDAwWXToMWHh98SPKmS2chZC0H9w4YJY6cuRmFEbUZTFkaB4U9b23TdnFQmAJcM5wav95C64gGo+RL2fVG4vy//rXgz0+OJz+t5zw4Mgof52jRJAh/PaB+aXqPytbasrjGP47MOH3fg3YgZH5V9iFp/77KafMVh6LNaQkwpiDCKe0JzRg10IOuXmooOPuM0lhLp1m5GUOe5UsdlZs4voMMQQ5p6OJaZWr+VAfUIGORt8ovEzG9n5kZKXISRHXH5S0ygnyaPNKXs6TfCX4LEXSvbrZ0IfZeOpAIv4u8Xte6xgD1frRbw1j9pDqAhWmETG6M+eqoC4kmm48MytEekTPmX3OJWFxuv8VhSWvY9fQAcXL8fgeOJNqVMCIOBkio296VWMNFWKehYRmr09QyTmw1SI82wQr23UIM308lNeKuDdhcnARjzkS44P6lqjysXufgN5/35SaJVztCstDaWF7RkGEXIbPcuoy8J9nSMDSK2dVEBoqga4038P/26vaNmRtY+H16YTi+gC/9aXLGFWlCoLLwMjZRTjDrP5b2SAp8ewTYt1fvd8JUrVG8F9uOs54mntUSqh46HJyJ4N8SmoQVB3FCvJmA2zBa6PUqo9w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(10067099003)(261021121427099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	logwr2nlVnf+w1E7PWwgbClGOfTm8RBj/O154LRnfTV0dW7ZCjQyjkbXWpFixvXtMQBncNLUKKDgt9aeYWGMFLY5jSxPI3i9Xc91U6mL+IZ/tnmYscf1zGOrEt4IOvafWScTjVCIQfDEav5Jn2unNRfkDffCChqqYR0avfp5M39TThQBxQwp7/H/fHkzufPuiK7ZAZpXNVCzQ3fqrjL5z34nIpwKEwG8xyRA2aAwo3GIpTeXW0RESlRrv3mZne2QJPZOYZ4YVrHYLDDljZoptVOOajGrwDjAzr7Q/jEmyyOUl+2lpFq309NCliAUAvBaieKB1K/gGvv6BBlJ+UMdYoaDYwMmJP+yBO42jaT/cJXM15sYYl5/c2FLRtClJGIrBf1oBIjHFJ0r3ZjBSQMV/uCGGYPXtkoijY1GFQGl3vMOwjfU4LBTCYMD5CH88MxV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 09:15:01.4469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5e881e-7192-4ff1-9b62-08df340ac7ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF0005961B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999296

> We use the following command to track a process's memory footprint:
>   #perf record -e ibs_fetch// -e ibs_op// -p xxx --phys-addr -- sleep 10
> 
> In the mysql tests, I catched over 1,804,973 records for ibs_op event.
> I found that over 53% records(970,554) are like this:
>         ibs_op//:  ffffffffb6017739               0
> 
> The physical address is 0 for these records. These records are not needed
> by us, and they wasted the CPU cycles.
> 
> This patch adds an ibs_op/phy_addr_only term that discards samples
> without a valid physical address (dc_phy_addr_valid == 0) in the interrupt
> handler. And it avoids the phys_addr=0 noise when used with --phys-data.

Why not simply use the BPF filter?

  $ perf record -e ibs_op// --phys-data --filter 'phys_addr != 0' ...

Thanks,
Ravi
