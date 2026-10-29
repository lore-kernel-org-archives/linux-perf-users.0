Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793246929;
	b=muxOa8okkUQfP+0A93hAHlrkB4ilHkOubasaCKHoVaP82UXDjQIws5+ScObXq06qEf70
	 zzhffzS+fqnnabZGXRV2tJq/IZ+qrbJ5VB+WOJNMAa6Ks9QvhkydmuDBtCdyO3RR/zqvT
	 +JkUCewqfxKE5k21vbtsQ3nScwSh56OuHi9j/5Xn55H5rM/BpntdfD2vb93gqLZORip0x
	 4GgsyMMSQPYIGYUo9OkBwFMC7984RqNH+08UcH2aWpKxEOUWhdvKmPd92qkkeAY5Ho1Ep
	 5KT4NvgyUdaJEs2Ac81o8symT7lVZ7k2ZPY3Py3UYThbW1unbGeEycBT+h04aJLXZvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246929;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=8x2WoH4wwZ8XzW3c31YlMpcLt0PVcDLI2RicXyEqx0I=;
	b=Jz6VGhYBpao4T4hm2a9vgoSmoEsnoVc2wPhpAnzhCxg34CoJeAV9wNhjDnP74OpX4Lo4
	 yOgedBBsuDt7LD57u52JrReCDpQDGRnYGaeeliaO5KCigxX5sHI+/5llbqra5MVeZRi5c
	 jgmLYeViZG3lWhwV5Lt3oVcZ4Wjx2cfRcE3jenA9C8coxjR2uNvUJUnNYSTaxMXHzcbji
	 M1Sr5dnIP4elk/w/xAHLT5dvQRYvDQoZN06cHrvJPGql88LNF/Ips/qfQHF0h00AcTdO0
	 8Z8AhYpeOwROyAnr2COYYdelpY7FGRduObyjD843165CASWs9EbmOsy+60TnfvPwQgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0qk3a1mI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.49
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010049.outbound.protection.outlook.com [52.101.193.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C101606A323;
	Thu, 29 Oct 2026 04:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C101606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0qk3a1mI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U19I6FAmqGYYQOFY/MADDIeyujbaG90YZUKmY9cA9yKcVzM2vDFReu8SSS9nYs/H3FGn4Ca1UmmCMFCr+5MnUa+4cQcb847IDbOhby+8+O4XBoAs+Sqc0D5ijw2DpjMMMXxJan0loYuV+eb72oyjIrn1y5ganIWNo57HJotVxA+c2mB5MMmAyyd+XVfNWxccg+K8YoGGFYe82cNLT4d9HGrEJvlOCZHSXyoXo1k98AE3xoLpv3URSHzEmTJgBIiLx7f5v2O2PMmbOiNDB6BY4R4gJvzijFzgT+SY8Wj9nTpAYEA86WXGq7sawQkkiCjxOA13aKMqBhMYtOu0PrG43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8x2WoH4wwZ8XzW3c31YlMpcLt0PVcDLI2RicXyEqx0I=;
 b=fFyFI5Zwin0UwBbq5iPpny2/G5Jjm0PohCCEdRv9TjaL8lngTVp+UxzlqcPU2kiZYdIQ49Lpx4cBczl0xrp96ZPMGh6p0tnO+e9EvzT0Ygr/8e9S1lry9M30NQnDO61ivYcLQ2Xsfwsp6l9h/Kn4JGOMg7RJqlwaNNDnLk+SrjGqKjs0XzNDPgfwVKDD6z2ezyqJj4ygIRvHb0mLex7MBGAKYb63w4nSDswSqesF9CrG+om9PtUpxlxL/b2KF5/a1c+UxE/fGNK4veTCJL34X6d6g+UCieIVhD9sWXgiWpLxahVb4uxPx3kDak9a2C0Z9CSvMJrwA1IsTrE1l/RfAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=hygon.cn smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8x2WoH4wwZ8XzW3c31YlMpcLt0PVcDLI2RicXyEqx0I=;
 b=0qk3a1mI3Quu6Weefo1rd6ADg3KXDTGAsSCkrQwQZLHs+pWz0Btp7Vihi+iEBqFFhF2Z6C2QMHQFgNAY2tbkPbv2ROVa/a4f3UimkRkYfgxKwHIKXjKReyL5gZM9PqDJ/0N7G/Mbyo+I29KYT1izIkfFg32HxZluhr7DdPVbOaU=
Received: from PH0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::15)
 by PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 04:08:43 +0000
Received: from PH5PEPF00000031.namprd04.prod.outlook.com
 (2603:10b6:510:d3:cafe::94) by PH0P220CA0006.outlook.office365.com
 (2603:10b6:510:d3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Thu, 29
 Oct 2026 04:08:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF00000031.mail.protection.outlook.com (10.167.243.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 04:08:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 23:08:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 23:08:38 -0500
Received: from [192.168.0.101] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 23:08:30 -0500
Message-ID: <97652b0c-6b51-46d8-9787-4669af3f4eb7@amd.com>
Date: Thu, 29 Oct 2026 09:38:29 +0530
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
	<wangfengyu@hygon.cn>, <wujiangyong@hygon.cn>, <shijie8@gmail.com>,
	<1537577747@qq.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260902085251.4046240-1-huangsj@hygon.cn>
 <auGpt6wenUj5mFP8@hsj-2U-Workstation>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <auGpt6wenUj5mFP8@hsj-2U-Workstation>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF00000031:EE_|PH0PR12MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: e50dd2cb-1b6a-4c7d-dc34-08df35725158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|36860700016|82310400026|11063799006|4143699003|56012099006|261022075727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1M0eGcJM9Fz7UibIY3D7OyeF/ISCIHJoPM/E0IvNHwhcmv5MBleK1U3272JxPwlXoNQqz+QGPhJenOxyLeUPL1+qns0yaK4GZmrOm05SGnXnSQ/UR+eRr0agu8hP2VwsA2lPVQI/34GrjvDrrC16Xk7vkIGWzLYyeGg/TM+9lmK15BxUn6LSS10l8eE3lgsIkX3LgyRjszKPkFdYOlUSD6mlxxyeKwB01lVnhjM9Lu1rvwH+QQn12E9Wf2zOCbNhQR7TdXwyQveWfcsyN2BhyNQTF2S5JwyOoX/AncDwhTMj9Yre5uYWm3RV6jbLAWX9uPvMoQysK3qcczUV166OntIZyhAo7IxJ9f9SbUDWHoYUHLjJh/jcwNALNNmYrnDdC9MnJXO6vAAewOYAMpyKjZURzI3uwNEDdLHH21NGMpGOO1i908wU2bpjXivp0HfxfkBkhCpsPpq/FPbxhhXw+XuKglzn2aadk0EQ5WDA5GqsP0lE9zHTsHB2stQRkWR0pnjau+4tMNsSRp+mir2mSiaD0Wwp/dHP0nipgo1rWJ+PNGU+mrdGzPNwq+ZnVl/iIq5O7VmoyKwlK+fhTG4ShsWb4djaCCuTM8bbKasV01lZReShnnN2s4WfpovYRU9JpgP0d9Pv+98OQ8kuQi0Qal/I1iJdl0A6t3c++jR2hzhJ9mEzfA8KVGIiqglf3hyUe59VJoI2iE1n24FGK9+5fA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(36860700016)(82310400026)(11063799006)(4143699003)(56012099006)(261022075727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	99T54tRs5NfRqm42xwQyiie1y/SvfFDAckhFSZqBrNzcDIBeJsOFd6p4PTjN7a0NqiamUtffLdHJUmGPC3mZW6RPx9ztUEj2LTvazIBuk2EciLU6SArXFC1P/4/SoKYkPbN2e9jp8T3cLPKQslX0G/RYLSgWgIZoJMDCjMBGqXzXz1wM4I9eYYlXGDhqgO49nrqpzjLEtoDLlnVG0vBijrWaC3ytAt3cfGzUZGZu3lO5DqoVowYTztMP6UnZhyAi8shI1vKOmSJp60BKD6eDWSN1A1GepB1pzrw/qpig8aP1UXOe6LTaeVlPyn5IRf9IOzmNEuUO7dB1gWz0EB8EaCWkOZuaaM1pql6hqKPfNEzk00DypQ0RdRoGK3MhnH+2ftDLD3aeTRjdYV0rXbdk3pOBTGlY9nJyQ66Cr2iJ0AD36ukTpAs38ji4Y8E3i89j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 04:08:41.6470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e50dd2cb-1b6a-4c7d-dc34-08df35725158
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH5PEPF00000031.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981

Huang,

>> Why not simply use the BPF filter?
>>   $ perf record -e ibs_op// --phys-data --filter 'phys_addr != 0' ...
> 
> I did try the BPF filter.
> 
> Measurements below are system-wide ibs_op sampling for 5s on a
> 384-CPU Hygon box under a 400-thread sysbench oltp_read_only load
> at three sampling periods:
> 
>     -c     filter        valid samples    
>   ------  ------------  ---------- 
>   100000  phy_addr_only  19,345,907 
>   100000  BPF filter     17,939,819 
> 
>    30000  phy_addr_only  54,670,617 
>    30000  BPF filter     47,926,784 
> 
>    10000  phy_addr_only  61,606,488 
>    10000  BPF filter     40,826,086 
> 
> 
> The phy_addr_only produces more *valid* samples than the BPF filter.

Can you please confirm if those additional samples are genuinely valid.

Thanks,
Ravi
