Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013061.outbound.protection.outlook.com [40.93.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F8C43F0A7
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435443; cv=fail; b=k1HJGoax5O/A8RxaYDZ/vGz/LH+WC4Ah0iWzxUhJ2n6TbK8/PYO8ExN4/3ugLQDT/46KdUGDH3XEWlabKnYUZP532vmJ2EFUjc5RkhItyAl5D/exg9rYigC4swhLne1fwYJdGlYVd4o+Pb1r+aTbyNa2h3duw6RNIHI+qpZF/I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435443; c=relaxed/simple;
	bh=/RTt8nIzOiSNKR8qSUZRBcXJKL/ewvZdk9YQOUv204g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ajA1NXUEIpEjchXsrHaaPntoxsg1vQ4dnRl7DeaVvPiBFOpfQ5uGdH3vv4ybEmTbRzUIpQzNuUgVNkh9PrCbdW77tkJneyfBMR7SK1KtayLJnoBAUbALpug8psOOD2Gw1lhyZqMFNgreQX4HxT8oi6FHqpuJk7E1Nxm1X8tBVlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZaUQf7j0; arc=fail smtp.client-ip=40.93.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZaUQf7j0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4avcmm7NMoVbuBZP/qeeKcoM9qsDrAUmZj0BxLtIUApXUvLwzJnKdO7faiwsZIUvxsGhJ7S30OUGNBTL2YNnnhuL5al4oZgAqMurVJufKyx43DNAz9hNY0D9PEerGEA+0eD6EIU6CxdnJnjyHNfPDOLfiHzLAYNhqRLjPZx2Vu+pEI1Xcol1TSia8+/BAGvQniV3SdCUCQm1pCs3+ZW2yGyu3jH8k0s3zdmr98cfY5kY/dTUsUBOWq8Ttt9Wb/2YXEEuuWK9copPeafTURzTX2QwY+5bhQZj7oEeM8eXRhg+cWKSSE0ZgP35WDJfyfYcJ77TOZ2fg6SDsf1+ARBfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kc1M89F2Ebh2SHQ1csm1fMkUqxhIm00UVb3LVtVuZ0=;
 b=VOO7iaZS5XyBqzyGdTw8foFW5yyPVvkpp05eM9VPrYm+cvM6IZs842z/qNWuIwEDUHnwDmfU8cBBdBm+V3QNs0KME7H6Sj3qR9Iv4UDbFkaBTKdPPoMkQeQCMYcgGX/tbsuF+Pw730Wwq62r9BMwXvA7bGFCmaYKS9HB7bmPtfKSZu7t+8gU4d483LIM7gDLUf/1XK7RV+Uo9hqmXp1Lu2bAeGUsmDssFddvGbAJYp/8I5HueaSTjRdSg4xP29pGrTJhYW6UgpdTo5FpjTbbR+yNgXwsWjKkLMHZ/UXs/hBMrTCU/Ol7zICA9irjwzgZAHIb4sR1x9YWwWJ5pCzHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kc1M89F2Ebh2SHQ1csm1fMkUqxhIm00UVb3LVtVuZ0=;
 b=ZaUQf7j0nDfTl5GiuppC7LxwHqTrJ66gSdWpPe22eEOMgR+35szPjoZK3Mnd4GGg4dbljwKWPrBHg7UDX9N9Znc+Vhy/V1zeanECf3jQqDak+ShqzGBGhlpKU9mj/Npv3OHIJGKDwHKKDHsUKuPOg+aTDv5RuRY+sXenWkymVgM=
Received: from BN9PR03CA0246.namprd03.prod.outlook.com (2603:10b6:408:ff::11)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Thu, 3 Sep
 2026 11:37:04 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:ff:cafe::31) by BN9PR03CA0246.outlook.office365.com
 (2603:10b6:408:ff::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 11:37:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Thu, 3 Sep 2026 11:37:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 06:37:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 06:37:02 -0500
Received: from [192.168.0.101] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 3 Sep 2026 06:37:00 -0500
Message-ID: <7b4cba95-dacc-4cf1-953f-c59e06e693d0@amd.com>
Date: Thu, 3 Sep 2026 17:06:59 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] Three problems behind broken "perf --call-graph
 dwarf" on AMD: IP and stack dump mismatch, libdw fails on lld's layout, and
 the unwinder fallback never runs
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, Namhyung Kim
	<namhyung@kernel.org>
CC: Gennady Kupava <gennady.kupava@gmail.com>,
	<linux-perf-users@vger.kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>
 <apCyQ93c48Dy4H-S@google.com> <apG-RzV0zyjoC-FY@google.com>
 <27d79477-c469-413b-95bd-c6c1f8a40f55@amd.com> <apbs8gywyAfFVzqm@google.com>
 <c38b254f-21e5-4a02-8934-7a4da61e4571@linux.intel.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <c38b254f-21e5-4a02-8934-7a4da61e4571@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e7340e-d42f-4fc7-befc-08df09afad1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|10067099003|3023799007|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Tauj7bhKHa2UkKWH1WXpwMSkII0yu5xUmR22zxuWpWkXxM+xs+F2hblkVQqjRzMSwEjsiksY3uk5y/Og3TY12i+h4hbtNgku0a8AkKe4JcooKQvMSIm7dVXlt3StVM3ERSSdUrOWEn6dlyfTAywa52Tde1QbQk7f2vSyrADwA+rnxSPlnOMOB1Ti/wh7lAK57ZaxKdR3Kr5oXtPPt+rVeniCKhUp6BzkK4usyVbnd+lP66GuMvtXK2FMKiIxHFIq6PkvZgivMQu75WFkuZGYTXVW+OV4xAa4OUO5xZSjXirexnF7RamUMWK96CdyAXGPAQRQdWHuLnoBPQb+qDWK0jJ8ic/U2dyegUotQ6B2xaDUknUO6b1mKqBJ3lPyBx1xJa7sm/0qzJRe7bItQGTiEGkALL2APvRuojx4aLkbPPM1j+SuflMzn6I2c2pfuwZdc+a0rG3p4jxjypaqOhlN4WNb4nDShIx/BIUSRbH+dDLAFswE1pGbu+Gbnv5cGRZFeYVdLyZ3jaCQ0GJJX3ROH2vk8jPyeOGSsag4IsbeESOvz/gp+r3r+XtY8ZDFG6bLSxolu0jb16uL6sOBJPWWsXp+35kKebJzDKtzldYzWTRBNTtg9UipB0c2vMima0bf8GepsiltjM0I3FLZQOQnytzdCsAiYNl9EtscyX/5KgGpeawixYTdeDbjRJHoKnLjbjTIwhXMD7GgopEIhpKjyA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(3023799007)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nsJC6oYumjDcYveXTAW161uq+4M6sK2wxRqbPIh5OxBK/p+sZvIo7X+xyqC0sYskwWh9jjtmcDQvtdqnVTrd4yG7xb/BJIJSuOHSHrcpVsCbpE3WLWfiEM7lxJKP4ABEeyc5vL6F21/Yh8j7YbxSqBuYI4YbJ8HNirBhB3ADp1Dn1/z4J7Fb+eDsAbQ7xTuk1W5A88QH8/TCAy4hEv0XDYIG+439C347gnnKN/hNRmXDX62LYw/hjPylYyVdosJqH/+eOeb1fiWz6abqnhf0RlKyO2Dp54udxhMyRJ7XGKxN9WwFm/8mphXA2Pwx/V6QiFgedF5Q8/L1z2wUL8wggFoZU1lhRYsoKNPaOOXoqHcI02R1w1klejErGEyxsRaPpViSf9S8NMurpGXPURaoZdxYTtY0IInw5fkXw/wvfuiDHvIGYWumQ2qeQkI6TkzW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:37:03.7643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e7340e-d42f-4fc7-befc-08df09afad1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975

>>> This should resolve the DWARF unwinding issue with IBS PMUs:
>>>
>>> --- a/arch/x86/events/amd/ibs.c
>>> +++ b/arch/x86/events/amd/ibs.c
>>> @@ -1523,8 +1523,11 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>>>  			goto out;
>>>  		}
>>>  
>>> -		set_linear_ip(&regs, ibs_data.regs[1]);
>>> -		regs.flags |= PERF_EFLAGS_EXACT;
>>> +		if (event->attr.sample_type & PERF_SAMPLE_IP) {
>>> +			data.ip = ibs_data.regs[1];
>>> +			data.sample_flags |= PERF_SAMPLE_IP;
> 
> We may not set PERF_SAMPLE_IP here, otherwise the kernel address leakage
> check in perf_instruction_pointer() could be bypassed.

Yes. I realized this wouldn't be straightforward, since the privilege
level might change between when the HW captures the sample and when the
NMI is delivered. So, any perf code that depends on user_mode() (e.g.
perf_exclude_event(), _REGS_USER, _REGS_INTR, header->misc, etc.) may
regress with the above change. In addition, guest entry/exit occurring
between sample capture and NMI delivery further complicates the problem.

>> Right, that's what I thought.  And I believe we should do similar on
>> Intel and not update other registers.
> 
> For Intel PEBS, the call-chain would always use the interrupt regs instead
> of the PEBS regs, so there would be no issues for Intel PEBS.
> 
>     /*
>      * We must however always use iregs for the unwinder to stay sane; the
>      * record BP,SP,IP can point into thin air when the record is from a
>      * previous PMI context or an (I)RET happened between the record and
>      * PMI.
>      */
>     perf_sample_save_callchain(data, event, iregs);

This wouldn't take care of _STACK_USER, right?

Thanks,
Ravi
