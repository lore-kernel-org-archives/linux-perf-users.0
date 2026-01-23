Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827D11BC08F;
	Fri, 23 Jan 2026 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186565; cv=fail; b=og9FnTeXfFuf28DCNHhYc6N6tMgGiOyIvpag0dhvJuhmuNdtcOZ/Uo2N5hNH7hFLRP2hrErzYVJ2YtFC6TpSYQu0+q8O6kyA+Qe88UwfqyOP79f4GU92DMQ4Nqb7KRcZnhWxAXrfwRMeA8qxSYcHPIuVshkHb1vmFWedS4Gxcj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186565; c=relaxed/simple;
	bh=MsrqV/+gW6Qoxo/uOs3IquqHyxp1iRzNrQrD+2vKIVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OI++hi46f3h9HVVpxdoDywTqhUwCZvx9M+Ki4/pdgGwYo+O6EnlaYjZuochh8v83de+ZKXA34shVkXsCXHDHhSWujUb2FdYrvl8Fi1P8n9XkXdXAoDZapAtvscLT8JD+jee9kW5yl/J2cXTBfeIT9KRCNO6J2fcwVDHylg0MfUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N0BtyeUl; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N0BtyeUl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhlcKO/ttLaezTDUM6CPkoPSMSBzknlYwmM8BcXusnG4NMHXQNVNJzV83DvNszsLiz5y9LMuf/52YKHTEKmnUZshriwPHM6tTOP8YB3s8Ny6fd504ktQIC3sSVE9W63FRDqk0DN16AamBbk+GZUuti8H+n3COi95Rh/maSiGExWPePfu1TVacqTJmYxST1cwbvaL8boqPUzPA7C2EggTTwNIKd7fVXm/SeP589+vD1dfxCebtkfgyBL1hYxNn5JU5eUw2B1GffPgs1zQ8DtOpfDfgF31o1wPQaJ7GmdN3Nc15/5VryKVEpnoOZkgi6ESS+cruqSIqiQkg+F8603t8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNBSOrs1h4M+nmd37u+PddSUacbuPywr1v6UVY98KII=;
 b=nSm2otxmKOqROv6xiyQ5dAF6uO3V5/zRYkbT8n/abW9JVVcRJTygmQjaL3l7QdACUxmxiNHN5eLfPj4HDVA+Km7W/Ijl7egA7T/iqgWFt+GCw5UrH3pgkYmys1FWkBIdLDB5PN+luGg0g7CpAgxlPkRH9EkD5wI5ExMxfyMHx0bT10/TqJaY1Qj+XRG/Q8zzx3yNgI7LG/6f2nrKpe/uGUmO+EKhRmoU2ft/kxmmSleSzF60aAiK9nHvkblwSVHNnObMIpi/RrpStrGBQLs+6m9DC/h4axi+AuKOb+NqJpjLH94I62hMfVWbdOeVFsmaxg0LznDaHm0erWYOWRAJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNBSOrs1h4M+nmd37u+PddSUacbuPywr1v6UVY98KII=;
 b=N0BtyeUlfg3D7189b4eK/MMR3S/EmQQZaWEeaCYvM0V3LZDxwdm0rUIpss7gEmzJEbK76RheMlik0INZbq6mKeakQIf/zz1mGU1RL2DLvwIQo85NL3YP845WFS9SEq9UA8w5eOQ2ktJ1V1dU+NV48uq4kA07ZY3g6R6owQ5b9ag=
Received: from BL1PR13CA0257.namprd13.prod.outlook.com (2603:10b6:208:2ba::22)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 23 Jan
 2026 16:42:37 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::37) by BL1PR13CA0257.outlook.office365.com
 (2603:10b6:208:2ba::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.4 via Frontend Transport; Fri,
 23 Jan 2026 16:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 16:42:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 10:42:36 -0600
Received: from [10.252.192.223] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 08:42:27 -0800
Message-ID: <9d442f21-45f1-4242-95b6-1246b8319860@amd.com>
Date: Fri, 23 Jan 2026 22:12:26 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] perf sched: Introduce stats tool
Content-Language: en-GB
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ian Rogers <irogers@google.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>, <ravi.bangoria@amd.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <ctshao@google.com>, <quic_zhonhan@quicinc.com>,
	<thomas.falcon@intel.com>, <blakejones@google.com>, <ashelat@redhat.com>,
	<leo.yan@arm.com>, <dvyukov@google.com>, <ak@linux.intel.com>,
	<yujie.liu@intel.com>, <graham.woodward@arm.com>, <ben.gainey@arm.com>,
	<vineethr@linux.ibm.com>, <tim.c.chen@linux.intel.com>, <linux@treblig.org>,
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<mingo@redhat.com>, <namhyung@kernel.org>, <james.clark@arm.com>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <6a434657-5b5b-41ec-a79a-c648c2829602@intel.com>
 <20260121163342.GI166857@noisy.programming.kicks-ass.net>
 <CAP-5=fX=QuRw8M4Xco=A8WbBfDSPmyjtQ-JdnBEM-VRdX65_1g@mail.gmail.com>
 <20260121195155.GP166857@noisy.programming.kicks-ass.net>
 <aXEyJCSqlPPUS9YG@x1>
 <20260121201034.GC171111@noisy.programming.kicks-ass.net>
 <aXJJirXQ9jsnewn9@x1> <f735d3c7-d3b9-4056-ba76-e0b4e8366356@amd.com>
 <aXOju9cYoX6nMPA5@x1>
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <aXOju9cYoX6nMPA5@x1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|CH0PR12MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 04efed58-58b0-45d7-23e3-08de5a9e6a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elFxZkljdnFzWE04NGxwdmw5NXhsNTJCcXNqZVNuSW5sK1dnOWtDQzM1VWxh?=
 =?utf-8?B?M2M1TThqWWhKNTlYZ1dvU3lyV0diRDIvYkJoVFlWU3lKc0JmMTM0UkFRSmFl?=
 =?utf-8?B?QmI4L2pVM3ZnOW9leFNqWGdkelJ2Z2VKV2JEaTBkcTJPbTBkREE4TmpQZkc0?=
 =?utf-8?B?SHRGaytkNkRRbFppWXgvMUlMU29UdjdyaER1REpkd1oyMldiUlBpMVo2NlFt?=
 =?utf-8?B?T0tqVDF2V1dPSStUVkFrT05QTGpZcWJjWjJaUEhKc3lCUTNNZWc2ZG83VHRh?=
 =?utf-8?B?WHlVbXJ4YndGMUFJMmlhWHkvMG5Za2tnTm5ZZjhiMUVmck8ydnZZQ0kvRnA0?=
 =?utf-8?B?eXhmQ1NpdXJTOEhjbW1OZWlKcnFIOGFxRTAxTmp2U3VKSUxHQXdjMW1NaDF5?=
 =?utf-8?B?enpFKzIxTXFvVGN0UTJlR0U1NFJyR2xyUHpoS2lQajRlMW4yTU5IRUVQY2F4?=
 =?utf-8?B?ak9aSEh0Q2hWV1l3WG1CR1BDKytjYUVSUjZlNittVEFubnpmc2dMQzdhTDkz?=
 =?utf-8?B?aGMrQW5wMHQ4b0VRbUVSdWg3UVc3NERUQVNuYm5LRWhBZXRvWStiT2VoOFNN?=
 =?utf-8?B?OUJQcm93Nld0aEF0NFlrZ0dFL2tOSU1mV3plalF3Y1FGSzdOWWZCZE9HaHhu?=
 =?utf-8?B?NGdxNUFhNStqU2ptVW9BMGVURHkyWkpVWEY4ZlRqUzJMMkZMZlI2RWNwVzQ2?=
 =?utf-8?B?R2NBTjZEZ29wcDhiRGZJdVB4R1REVVJkYzhjTC9lU3dINmtGZXBBbHQwa2ZW?=
 =?utf-8?B?UHVSUURwck5CeVAzZHZoUitIK1AvM09ndWcweExRdWdFMG1IbHdjNVZtV1NH?=
 =?utf-8?B?Y0ltM1hWVFk5Q1pPQmZTT0FCR3QrWnA0a1BlZW5zaVVGNVhUNm1hTW9zaWc5?=
 =?utf-8?B?SXZvWUZSTVNuSWFZbVB5NkFVdnBwTjZVYTFPU255REpZaXE5cHNOdmxtY1F2?=
 =?utf-8?B?VkdKLzFTREhGeWhSUHZpN3N5cmJXTHlad3BYOUJ1ZHpIR3ByT0l1bjVpeTNU?=
 =?utf-8?B?aFZ0QlRzc1YxZzBzbmJNaG1OUVFWOUNZTzBWY3Z2UEVvN3phWncyM3cwd3Vu?=
 =?utf-8?B?a1BUNzh1SnNZN2dQQXBFSlpmQno4dHlVZnZoSTlnU1MzczRFMHlrSGlvZHlP?=
 =?utf-8?B?SnJsYjZaSU9OQW9CSDYwN1ArV1RyczQyRC9tMDhiOTBhbzN4MFk0S1BNYTVp?=
 =?utf-8?B?NG5FMDcyUXpQQlZEOHErN0VGaU94QUR0Z0lTQUZDOVpLNm1YTW1oOVRNL3FT?=
 =?utf-8?B?N2VCY3pZdHphWGZNVzZleFlTZm1GcXBUZ241NmtqZVJkdUtkanI0NEJWS0xC?=
 =?utf-8?B?cElJZkgrT3AyRXF0RjZYMUhta1JUb0xVbi96NFB1VWhPUUNMV0d1eGdzQ1h5?=
 =?utf-8?B?N2FOYTFnMlhDZE5RUFlrQXdLbXFzU3JYS1Z0MzJzQ0ROQWFPZHpmOU9LZHNV?=
 =?utf-8?B?dVZkUUh3cEFpWXpKdTJGUFV5MnE1M0t1bnE1dVBQN2o0QWhPbVdlSHZaOTBs?=
 =?utf-8?B?eitCbnB6ZmhwcHhmZFdnMUQ3SVlYUnVaM3pWSThXcUNXVVhlOW10Zis2TFFT?=
 =?utf-8?B?T0orRGxFUXNvRm05MkdWdE82NWxtcW1uZXJwU1FjOVlZcVlJVVdjY2Y2RTVh?=
 =?utf-8?B?cnR1QkMxUWpjaE56TkN5Y2liK2ZXT0tzTXJaNnZwYnBTdHA1b0VvWjNJQkll?=
 =?utf-8?B?YU54RTY4bnoyZ2xLcGZhN1MxUEQ5V2gxcE5PSFRsSnVYQzQ1N1c1NXFXb3Yr?=
 =?utf-8?B?WEdDTHpEN1lyQ1JHSTJZT1p1eW9VZWZBYkNKL3ZxN29FbEl3ZSthdDdBcFlH?=
 =?utf-8?B?b3J3VlAwUEFhUGxLUDhTclkrbUFDS3IxeWgvMXdvSnBDWXY1OHEwb21md3FP?=
 =?utf-8?B?YVZTejFOdURid0R5cmNmdnhOOVZsSFZFdW91L0twQ1FTU1VMNlBHMGhzSC9x?=
 =?utf-8?B?Yjg4R0JTZ2VScEloOTRacHFBOXJhMkNjWUxHTTAxbXJ5OTUxM3BNSGpPY0xM?=
 =?utf-8?B?TFBBK2IwM1RsMm1PVTVTWUltcmlzTE9XK0p3THcraG1GS3BVZ3Z1UjMzenli?=
 =?utf-8?B?bTRRY0JjWkQxc0tOcGJrM0VRNzdmd2xZUFhQeUJCMVVJSDFhc2lNbTBIVjJ1?=
 =?utf-8?B?ZmdNK0VWMFBSS0IzUGhIMGdKYWdmcGhxYnh2ME9lMVRZQUFiSkplbWNVa2ZB?=
 =?utf-8?B?VlhWN3dKOTh4Zk5jWENWckpzb3pOaFI2bzFTY1RvOWpldjhreElGQTgvSGZ5?=
 =?utf-8?B?OXYzYjExdDQxcGJzUVY4UHFWdlhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 16:42:37.1774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04efed58-58b0-45d7-23e3-08de5a9e6a8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529

Hello Arnaldo,

On 23-01-2026 22:07, Arnaldo Carvalho de Melo wrote:
> On Fri, Jan 23, 2026 at 10:02:11PM +0530, Swapnil Sapkal wrote:
>> Hello Arnaldo,
>>
>> On 22-01-2026 21:30, Arnaldo Carvalho de Melo wrote:
>>> On Wed, Jan 21, 2026 at 09:10:34PM +0100, Peter Zijlstra wrote:
>>>> On Wed, Jan 21, 2026 at 05:08:04PM -0300, Arnaldo Carvalho de Melo wrote:
>>>>> Until then, since you and Ian acked this one, I'm going over it and
>>>>> tentatively merging it,
>>>> Thanks!
>>>
>>> It is on
>   
>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next
>   
>>> Has the two minor fixes to overcome that 'sv' maybe used uninitialized
>>> on the error path + 32-bit build, I will move to perf-tools-next after
>>> it gets built on all the test containers, later today.
>   
>> Thank you for the two fixes.
>   
>> I have a fix for the man page, do you want me to send a separate fix patch
>> or will you please consider it with this series?
> 
> I pulled it already into perf-tools-next, so you can now go on working
> from there, with patches fixing things like the NR_CPUS case, etc,
> please add Fixes: tags pointing to the csets where the problems were
> introduced.
> 
> - Arnaldo

Thank you for pulling the changes. I will send the fixes separately.

- Swapnil
