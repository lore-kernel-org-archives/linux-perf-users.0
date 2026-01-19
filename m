Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E84279DB1;
	Mon, 19 Jan 2026 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827429; cv=fail; b=dHR0hTgEoyqFNwXS/Zy0YziFW0J5GzoOT3QszMDEbnTsBsIq81eHLjLXLz4ZgOHRRBNNoiOQ5IKHOdZUNVzuNpjDPuWSH6YAf/Vwd+AqrGK6C/gDjYLq6TjnG4twHoVf2CMsad+/xV5CKawd3wWgFIpvHjKbngmMbHDLDZszWuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827429; c=relaxed/simple;
	bh=viUyXO7Z9V1mt28IKon0o7LrU6qDj0dHY4/v8pAR02s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qjb0pNhCT+3heoIC+R5NWBp3nV2gnCpAXmMF9tWaaORdnpnJkyBZkAfr381ndLxEPhaWXTDQETEjZYk+2SBTkm/6IoPLvCWsuzNekn4YzgHAAhRxgRIx3qnsW3a3rgs5yeo4/DD0VXCTKNnRyZMrItuIQcmES6OHnrdzeoPWL7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k5K2fTmA; arc=fail smtp.client-ip=52.101.56.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k5K2fTmA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1VP1i1S5jfId5ETIyF3IP3sTU75d4jGpV6lxoy8FRogmykZ4yzQJ7Tpj9P8lPgJyLt5SeLmbiGnfFsfsgUzECd2mdxW74k0Aj3STwcRVhDsXykwJu6KAnED9bDEs3gcCwcjEyN0ul6bv2VtNIzU1fUrvUntJoKYUueWgOrq7RisY8gyvaUjvxaczecg2WYO8xrCiNJKrB7oMmDlb27L5DEn9I2cXCiTMsHlGpUrts/cy863b0gbxXpYfc6ppABaIXw/Uni7Vk3pAMnmLQbdssPX5YN9TgFjksbcEZDVWdEqcDO3wTMZk2m7KmT8jc9WcERiiueqL9ixb/aOnWeI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP/M1HzTcgPwp6OsdlDilWv/6AoNlozJ2GP3WK8TFkQ=;
 b=WD+hqRjDvFKBuinmXdQ/hby3r9Srbgt4KFOPSb0oFxp5ElmaGOPD79F/XalTYyja0+8jsnd72zUWF6HUgN4TXyxjSr5qLs41Jde+YEhNHZh6VfJRtZ7tN/Tp7TSwTOQlfWEd07YzkVMGxig89BT2E/iARZPv453ncG+gTU2eDamdt05fZVB4QpYmvxZ8ts58/Vt4LgAPr0KNGbu6GcSUN2LZQ0YPgWiWDr/eiq7jofD7ni9aubu6XYZRRFDMcCuPtqqMuYsElNoEx2KRIEAy1f2ujAXfhH0LXlwTnkz6URRECbzXRCKrRKfO4ZOXuXZPu7G5z5iXntoyFmOYrCRp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP/M1HzTcgPwp6OsdlDilWv/6AoNlozJ2GP3WK8TFkQ=;
 b=k5K2fTmAu4jrnfS+EFH1Td6JNdJibGKiU6sQVHXJzKTU+uyLhTbF6GP1w1nadQc015VZYwBRew4As9qItp2u40cUyECAV9GZAwVpXSaPYDr+0psOIkdSBRfg1LpgIp3HzK9eXeVo22PTqa3D6Gz5iYSFz4Q15S8leaLDJKBfIzM=
Received: from CH0P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::33)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Mon, 19 Jan
 2026 12:57:04 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::24) by CH0P220CA0020.outlook.office365.com
 (2603:10b6:610:ef::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 12:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 12:57:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 19 Jan
 2026 06:57:03 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Jan
 2026 06:57:02 -0600
Received: from [172.31.177.127] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 06:56:57 -0600
Message-ID: <d686a873-6257-4f6b-ba43-22d49ebca1bd@amd.com>
Date: Mon, 19 Jan 2026 18:26:56 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] perf/amd/ibs: Throttle interrupts with filtered
 ldlat samples
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
References: <20260116033450.965-1-ravi.bangoria@amd.com>
 <20260116033450.965-2-ravi.bangoria@amd.com>
 <de24ee43-fa1d-418b-855f-aef5c681a302@linux.intel.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <de24ee43-fa1d-418b-855f-aef5c681a302@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: ravi.bangoria@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: eff5dd05-7122-42d6-1a56-08de575a3e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UU41Z0xVSG82RGdQK0hrdlo2RmxWVnI2aG96V3Avc2VaWW0vL04wZWk1TGYz?=
 =?utf-8?B?aEFKSXlHTEdkaDRRODBnNTE4SytweHJzVUV4RjBuc0kycnhSQ0VkYmxlV21q?=
 =?utf-8?B?ZGZaMWlzLzRXOWQzTlhEck5rVHNMMG91TVlzWjd6UDFkMzlQblllOW5URFF1?=
 =?utf-8?B?aU5zMlIvazF6V3o5U0RSdEtwbnNLODRrelIvZnBCWkpFd0ZleVQyd0FTeTg5?=
 =?utf-8?B?dEk1cEZCMzlHTW94ZlRSWVRDd3RoSnF5emZkL2JhUXRzcjc2dzRmNWtGeUhs?=
 =?utf-8?B?NzNXdzd2K1E0UEhUcE53OS9CYXpUWW5YZnEwRVE2MTlqblprY015dDBKWWNv?=
 =?utf-8?B?L3dtMXRYQ0pRTjVJdXA0QUFnMHgxQkVNbjY2SmV6bHo3WVBoRUFZL0NuQWJO?=
 =?utf-8?B?QmQ2OHBBcDNTQnloMlVmTjhCWUxMR2pVZ0UvdzFSNjRreW5hU05mYzBwT29t?=
 =?utf-8?B?YmlyL09KOFpkSXI0YnFBMUdJa05zUkRabGlnL2l1ekw3cjloT3hmT2RDZGsr?=
 =?utf-8?B?SDlIRDRXck9CY2NRSWV3c3hxaFBLdjVKeUtSS3R0ejFuSks5a2J6azJqanQw?=
 =?utf-8?B?ck9DRXJDSEgvRi9vVmtsdDRQa3cvbDNreWJmR3ozRFZsOTFHWkNuRGdHUWlH?=
 =?utf-8?B?cGF6UjVlelJrdGtXc0VSOXFrTFZIS2RhcGlNZE5vemFkMzJPc1ZxTFB6ZEM5?=
 =?utf-8?B?WEtmTk01NmFIRzlJa2dReUdtWTdyTkZvNFJTNWFpUk1TQ1g5WHhHdjRMTWZT?=
 =?utf-8?B?WXpweVZmYUZwL0JqQkVkM1Z3LytReUZGRjdOSVdlLzcyN2tOWThmNXBYZXdJ?=
 =?utf-8?B?TFVjVzc3T1NJOGUxcGRkMHM4d3V5ZS9iY0ZGRmJGZUx6VjBNR1BHdkFOZW5z?=
 =?utf-8?B?b2FodC9vUnFNYnNxeGZBbFBkKzh3QlpWNnRTQmt3d0VNaU5EQStTenlvZzBq?=
 =?utf-8?B?VzJiaEFSaDFuVjVkYng5UVBjVGVJRXk2ajA5VDdqWjNFQmdCb25qMVV4TFh6?=
 =?utf-8?B?S3Y5U2d3dXJMLzNOZHYybTRCdzYzV2k4V3lPU0RWYTYzcEkyYWp4VGNUYkJD?=
 =?utf-8?B?RUROM3luSjBqSVl2ZFlRdFIwM05ZMnFEWEdHa05VcmlKZFVnWXBBMTVNNWR4?=
 =?utf-8?B?SWhHNWhuU0txL2MxZXh5eEJGeWJERzU1UkdGWlNWSEgrSWpQV1Y2YWczRnMy?=
 =?utf-8?B?NFpjeDJzUU95ak5XbERNYllVRlRWRHM0bnB6MWl6c1hrNnJDdXFncVozV25T?=
 =?utf-8?B?SHc5QWsvdTJ5NXJ0bm5JUCtibmZUOGxTQzhNUTNUbE02Lzd1djJ0NXhnTDJw?=
 =?utf-8?B?Um9ia0lLNld6ZHJXd29FOWI4bVY3VDE3eWx5OVBlSGJIdm54T3I5b1N5aXQ4?=
 =?utf-8?B?ZDN2UEJESW1ReFBLWWNMVzh3aExEK0wrWjB2eHNzQU5raW84V2lNczBXQThY?=
 =?utf-8?B?dmd4RCt6TUFFOHY0VGEzSm80MXNibktXYXZKbjREa09lTmdSaWVOWHc3bEZs?=
 =?utf-8?B?RW5LZDdpSXV2SlRibEJEaVhBZE5ITE80NWY4SVNsU3AvMkI4WVpjM2VNREdB?=
 =?utf-8?B?SDlveGJFVkxra0s5TUNld2RacmZUWStpQTVGVDZqQmlEMnk3WmtrdElnU3Ra?=
 =?utf-8?B?VllpKytiUUF4Z3MwTEVyZGxZNWNLRWlDaHZWbk1qRFRxaWJCd29vbFBZN3Nl?=
 =?utf-8?B?RWZjdTE1THVsS2ZSQWtwTVJua0RDbG9tbFN3YzFOb2FpMElkbDV5bm8zMVJU?=
 =?utf-8?B?aXlQRm1OK3dwb1loczRLTmlBNXV3U2Jma2gxMlVCeVdnWjZzT1g0KzVrbE5y?=
 =?utf-8?B?SHVZZkNwem9UdlRqdmdFL29NK0hXVVU0WlRJelRLTktkaHNORUNTQ2Q5N1lK?=
 =?utf-8?B?KzNCalhvYU9VWmhjbzhUeEpZTWloNmFrMGltZ1ljb1BuTXBJdEUrUXNIVnpH?=
 =?utf-8?B?TlhoUnR3enQyRXpMZzl6Ukxnei82SzBJN2pRMmRUam42cmN4WHZzSExzNjcw?=
 =?utf-8?B?KzBoVFBMREN2VmVEYTJKcko2WW5ieXdiTmJFQjNmT2hsY1lNbXRPVE9RVnVn?=
 =?utf-8?B?cWwzVmhweHdVWjF2aEx1dDltYzFlMXRJTHh1L1lEU243MVR6TWI0SUI5U21Y?=
 =?utf-8?B?eUhwT240OXloNUphRitycldIVzB6OHMzM0RLU1pHSktiTlk5UHlhbkpWVDNu?=
 =?utf-8?B?b25tZENpYjl0NWpNL2gwWXV5OGZoL1UwZVdQMVg3OXhWRWpNeXppUXBNYkkr?=
 =?utf-8?B?SVhMYzJjMFZVb2l5dkt5RXdHb3BnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:57:03.2730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff5dd05-7122-42d6-1a56-08de575a3e0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561

Hi Dapeng,

>> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
>> index aca89f23d2e0..96bb0974057f 100644
>> --- a/arch/x86/events/amd/ibs.c
>> +++ b/arch/x86/events/amd/ibs.c
>> @@ -1293,8 +1293,10 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>>  		 * within [128, 2048] range.
>>  		 */
>>  		if (!op_data3.ld_op || !op_data3.dc_miss ||
>> -		    op_data3.dc_miss_lat <= (event->attr.config1 & 0xFFF))
>> +		    op_data3.dc_miss_lat <= (event->attr.config1 & 0xFFF)) {
>> +			throttle = perf_event_account_interrupt(event);
>>  			goto out;
>> +		}
>>  	}
> 
> Not quite familiar with IBS code, but should the below code call the
> throttle as well?
> 
>         /* Workaround for erratum #1197 */
>         if (perf_ibs->fetch_ignore_if_zero_rip && !(ibs_data.regs[1]))
>             goto out;
> 

Yes, it should. I'll add a patch in next version.

Thanks,
Ravi
