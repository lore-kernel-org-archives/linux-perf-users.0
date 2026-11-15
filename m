Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794746002;
	b=z5IWZOgF8RlV/0Oq3QWBh51NP2zUyU1lsa/u9TUisGEaaeipyH1Qxm6ofICsSBnEVuVm
	 iytvlZ7QGx7tZTq8x3oqR6IRvpcGlp5QypcATOw1S9EA1VoU9HsIYm7S0BJEb0VaX6nMm
	 L8nDwAinJ5IExHq39A6+otFG7BJ2cFi+VMcW+WU8s2Uybdun4fHqvQX2dRZaYyP5jrYda
	 b0HwyTY22rfevHCPJZ25nHk8GvPnEMMh8iZcAjXFuEk5Y8OnvGllq5UCPWYifDk2OSyig
	 /z2AhUtZbgGgZsg+RBXtTg5faQC+wRW9kf6G8EgAG5MscAFKZfiROW+X16pidcoseDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794746002;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=MlxHTMtgQZlFMHFfa2s5sttImA4cu2yB1BqHKbLAkTA=;
	b=ikQnIfHVh3U3XPEEo1HMh32/m9ETbXM3NnIkoPFC951cc08KEPi80aphyKl1RHIf0/0k
	 bvvWhRdS7bDRPIaitwLmmJijOEdCfMgX9deZmcLI+ScH8e6tCXtltZYYvbgz/X7QgREUx
	 t9+Mo14V8tfSYxLZq7bGaTUPpjMoSaJ+qx/9UZNktLvCrjkIGMCxLVWGz24nAF8IVtNh5
	 clTU+rf8mI/O4X7ff9KMMraHU0VZqSIsImupKTzOhgU08Mt/G6m1GSYPMJTvCsKAv/TF8
	 /STATIjzFB2buLCeN+qYu3yFN+Y3hQLHnmOBcRWHkepXjFE0Qg/NJOi4BbwdUe805tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=G4d5iyLt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.66
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F3E606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 12:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80F3E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=G4d5iyLt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVtj2ov8mCM/3l1qsPEoa6S1Ku/M/W86U6IxlGCt3O6R9W2Q60qEl0fWRzzOxhAVEXt/qhDFe1ZwYr038zCa05CkzEHVo0i3h+WQN7idlXCR36wJcmVL4Xo3qYi/nnHCmlHNbuHKgru2n2Tj1sheld7IFIPNYvfCCSPqTMoqQnOP/k6ZdhB8nOfupkM/pfaT9U85x6gb+82Kw3B/c5jWyLmfcn6ODqr/NXhgV67RuIPidP4iem9pJ/c2CFUY1yeVA3HMrwn2FndojBYfDBCcRTRBZzpyS5FXlfGbEWgbmvHf7qwnkuUoOogtegC/h91MROSl6kCpsu9hJsNIVk2GVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlxHTMtgQZlFMHFfa2s5sttImA4cu2yB1BqHKbLAkTA=;
 b=FanUpnacT+/4QH8xF+uTO1/VF1jK5U0syTuWPcYJVLCdh9CV5bmHoTF57HO+nR1m8bpnRwRNUPIodfyNW70qg8TTPcKuNKZzJQ5hzbYw48ki/mTjFK6ozdJynABGJkoN5RLztrzQxtUy1G9EiKJSOVM6fgOdUUbwRLnGTOTJGMv0EYyed5zo/5/8JHmSCI7yLNL+oMPkA4wWe0zPFLUtRbxSKpCW9kBWU0gJIShOY9LlLErWkJVEYlFkN8n8Pl7KrSzA91ktnTYCjHU2Eb6cKumr+3FKaAq4Dgur2+BO+g1wp38JnIo5IOXICuyyTHK43MjIgbbHn603WxVYTM3Igg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlxHTMtgQZlFMHFfa2s5sttImA4cu2yB1BqHKbLAkTA=;
 b=G4d5iyLt2PXK6l7f7NUUyFJ9GFzLJB3RXXDtvIwUykoU6SjGggzjhAyVBePqW9jolmL1t8Taxt13a7ulTQpCgPiFdYMqgZLXbtTJ4DwqcoocOz+idxf2IMuj/U8gxbPWRr5iNju8Tn5kWJhsyAyW0lN4OhX0vB8A/IdKF9cASxA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DM4PR12MB5986.namprd12.prod.outlook.com (2603:10b6:8:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Sun, 15 Nov
 2026 12:32:01 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0615.009; Sun, 15 Nov 2026
 12:32:01 +0000
Message-ID: <5c053c37-2928-41e9-88c1-7e9a615faf76@amd.com>
Date: Sun, 15 Nov 2026 18:01:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/events/amd/iommu: Use a per-IOMMU cpumask
To: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
References: <20261113150502.685887-1-vasant.hegde@amd.com>
 <sashiko-outbox-213096@kernel.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <sashiko-outbox-213096@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::6) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DM4PR12MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: a48ce9e7-802c-4dc8-6015-08df431472c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|6133799003|261009223027099003|10067099003|11063799006|261102123227099003|261028144727099003|261021121427099003|56012099006|261022105027099003|261026140227099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	69o73Z1CqnSnTo+HHbaQNh4fLvbMX5Nvkobk/uwDDB8n0Ja4QvRWccZ9jEtY5c1XXpcHmauDnJ960ypSsf2RFbjUq+BRrYMwzPa7JbgnuNhSW9dXFbfyo63OYAPPcfER1MuBnHpOdFJoqcqyk/I23Su3INSMJHAlC6d+VZV0x0ZDb0EjGvrecbPey7VhAIApipjKyJZg18DQ/pS7kor7WGvG4InThfV6ZhT2QVTiCAd5CpRqXeNFS8dpcnImEXVlKVD7STn0DNmWY4wOKkRlpe8vnGRJqGhYGbO6Cn058NduEWZv2yRcc8hbbMba5VgBE8HzYwxU6Ks31R5l/G/GB4HNdpSqBFrM0gg+VLn7fjh7h+ao8dL349Lcwg9Qhy6amif8uCgabynOPnMcKf9AUuSttprK4mVXsZYKXnB6Z6t13SzS0LfLArsrWeoW09MAdxoDDaopbsm2JZdebWQC97lL44gFbZHYyRTZoAWEbdXi2rb2pu4dDaUCjbEjSNiDF4ptXvxvWoxnJLr6lW7fITYkRtSXl65sw8vJ664phIWnAa4UJwubs1o8ZgZqNwvUi07Q6A0MXy2Dd1YXM9fNVZTqGgwVuDpu5Jqc4Xdpq5Qf/88eKccXEnHQsq4VkPIBZtn3qp/TZ4MdWI66HoO9Opd5xlLSyLQCyVa+IIEi3CY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(261009223027099003)(10067099003)(11063799006)(261102123227099003)(261028144727099003)(261021121427099003)(56012099006)(261022105027099003)(261026140227099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTgwcTBiQlhjNERlL3lSaGN3VDJzS1JvdHkzU2hCY1FLZnhlRUNxUlgxb3I1?=
 =?utf-8?B?VUtPaWlCaDFsZEtQTk9qdFVWN0ZERVliM3hNVjMreDNtYVR3blV2YXMreEVo?=
 =?utf-8?B?QzlOVHF1YnlXazBTRzZsMGRHQXhPYzNlUHgxWFlKUlh5SkNzRW13NloyY1BC?=
 =?utf-8?B?L0RvYlU1UnpwSjRkYjRTcFBXVnJSQnNOdWpPSXB3TXJrMU03MVFYOE5HVXBZ?=
 =?utf-8?B?cHhvTzkvMXd5bnF4cnB5V0tMTkVMNTVqYUV4d0g2aHpvOHJiWnIxdDE1a2RV?=
 =?utf-8?B?ajlxZE5Vdy9CUFYya0tIRUU1WG5QcEtaMG1KbkFrVjdkNm1sUWYwOVhCUWM0?=
 =?utf-8?B?QUxaMVF1Z3FmTEZmUDg3UEQwMEtuNzlmNHJrR1RzQ21lY0NJTU5OcnNXb3E1?=
 =?utf-8?B?R0tJUWlURDBsd2tGczZ4QUx1RSswc2szOWo1ZXVOU0ZPRTd0cjB2UXFqYXR1?=
 =?utf-8?B?TVZMZjVFbVRzdHo0OTN2R2xKM0QwMGgrYk1DM3EvVXhDK3FWMHZBdVBsdmp6?=
 =?utf-8?B?Y2N5aGhUZ3g5NG43TG5WSDBkaFFYbVlVYUFHeEZIZzR3clU4UWRQQUhqRTh2?=
 =?utf-8?B?R2FTR3FnKzZMMUxOeElFM3UwbnhjT084SzFBOE1sR2tjRHFIem9hUDROVHl0?=
 =?utf-8?B?RzRKb0dqMHppVXlzRjd6WGV0YVpyd2lhNlhndE5IaW02ODdFRTRuT295a2Jx?=
 =?utf-8?B?UktyZDFjT05Oam1MZldGb1VTb3dWcFRQVThTVVZSTHY2cjlRSnFwSThqakht?=
 =?utf-8?B?SHpxKzkwOXRLSlh4VjFrRG9EQjVQdHVIN2NGS0NCYzBjWVBRUGEwYUhYMnUz?=
 =?utf-8?B?M0psaFRYUU1IZk8yWDBLbzdWdENWSEFtQkVMTW9nTWkrS1ZLS3ROdW1BaVZK?=
 =?utf-8?B?bUNxVjBUWmdqbzN1WXA2Mit2RDN0c3JQUno3VHlGaHNaam9uRmdiR0hmcTk1?=
 =?utf-8?B?bTJ5d0NtSElUQ3NibE5TNnFnVVRBWGhhVDFpL0NzLzFrUG1LK2xxMGR0TFZ2?=
 =?utf-8?B?VXgrdXg5OEZBK1JmcnBxSWNESnFHOUdHZDFlbVd3KzB4VTNBK3AxSm0wT212?=
 =?utf-8?B?V21lbUQ2L0tRR1dpVGx0TTBFRE1xRVFocEoyT2NleXhTbTkvSVlKZFRHUXYw?=
 =?utf-8?B?ZEhRbjV2dWZBZHVHVldBNXU2YXVmazBUdTFJUVdYL1o2OHhOYVNlQnpjUnI2?=
 =?utf-8?B?cXk0cktIelVoSzJvMEErTDhUc3pZYkVkYmtLd005YTRLRFloamZlUTVyMFRO?=
 =?utf-8?B?WWkyR0gvTjJhV0ZLZEVGRTNBczZOK3FKUENReFk3MEV4Q1NGamdpM21YQ21N?=
 =?utf-8?B?K2lnWFFqTUg3UzNqdnkvTzNtQ0hrTXNteE5STGZyek8wcmVtZDZVSVhHWXl1?=
 =?utf-8?B?akNTNEhOcFpQUC9uMzBwbm55WlpiSHNQd3ZpMVZpbGtuS3NFR1RkaEkreGdS?=
 =?utf-8?B?Q01CTlQ3NGpyRk01azFiTnllVTRuNXFTNEFJOURmVnJkQWEzeWpvS1Y5R0pK?=
 =?utf-8?B?Y0tMcnpQMTRmOXJtNXRrOE91RVc3L0lJYk5FV3hHdWdiVFlYdW55alliVEZD?=
 =?utf-8?B?bjFkQndJK1dTdVdJTEdNQlY3VkNQQm9mblNZTVIwODBvazhQODJQT2lYNTFN?=
 =?utf-8?B?TDIyd0FHb3lDZGNsRjMrYnVGL0tPdjkwUTJ3Vm9LRWxBUkZQMTNubEFBRUVP?=
 =?utf-8?B?a2pnZ1IyNmxqNnpXT1czUjZvV1h0d2x2aHhiSDk2ajNDeUJqRVE1SmVweEF3?=
 =?utf-8?B?OUZIdVRuM25HcU91UWdiTXpXWjkvc0luVkk1d2F1RXpCRi82U2wvKzMyQk5P?=
 =?utf-8?B?am1jNEVzd2ZBaWpQbzVCRGdqdEVkR29WK0dnTVd4YnVlNVJQdW5WclFzNlF6?=
 =?utf-8?B?OUVjbkptU0hMQitVVjFnWEpIRTRxeDg1KzQvY3k1cWVjTmFLNm42WGptdlI4?=
 =?utf-8?B?MjhWbEhaOUhKNDRYNW1UeWlVOW15RUhEVzF4VUhyK2YxMWxuaVBqaHE0c25U?=
 =?utf-8?B?RkM1UklEMW8yTExJM1FQaUZJbHYrVHpvZEo0Tk1DTkt5VFk4VU9HRUtwdDFG?=
 =?utf-8?B?cTlRMStXL00xaTBmdGhhQzNQN0dNQVRQN2VZbWRURFFBY1FLN0plQnFVRWYw?=
 =?utf-8?B?YnBIZ0JYMDZoVUNHR05LV3hiSDlIUHRKenpLalQyOVFhNS8weXBUcXNrU0Jr?=
 =?utf-8?B?WFZEVGJteWxjSWpaNTBCcEsxdXh4cmo3QnB5UXM3SWFldHpjeGtVYnJiKytZ?=
 =?utf-8?B?VFhuYTdPUE5IelZGNFhVZW5wc3B0MFBPWmRCZzdmbXFvVVY0ajBoTGlRSm9L?=
 =?utf-8?Q?DT6+T6LbviTGcF+C0k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48ce9e7-802c-4dc8-6015-08df431472c4
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 12:32:01.6300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +m+VSOllGhOJdU1aapdxtro738BWFPe4oDaplnaOWTkdEoAVCLlwj86fJswSmLPYNZ0sxsPvObgDyOoIVaDhag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5986



On 11/13/2026 9:02 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] x86/events/amd/iommu: unlocked cpumask read in
>   _iommu_cpumask_show()
> --
> 
> commit 90882d03fd52ecfe91f951e077a922dfbbba36d6
> Author: Vasant Hegde <vasant.hegde@amd.com>
> 
> x86/events/amd/iommu: Use a per-IOMMU cpumask
> 
> This commit replaces the global CPU0-pinned cpumask in the AMD IOMMU PMU
> driver with a per-IOMMU NUMA-local cpumask and adds CPU hotplug callbacks
> to migrate the reader context when CPUs go offline or return online.
> 
>> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
>> index f332c7089bd59..3b35702aa702b 100644
>> --- a/arch/x86/events/amd/iommu.c
>> +++ b/arch/x86/events/amd/iommu.c
> [ ... ]
>> @@ -131,13 +134,15 @@ static struct amd_iommu_event_desc amd_iommu_v2_event_descs[] = {
>>  /*---------------------------------------------
>>   * sysfs cpumask attributes
>>   *---------------------------------------------*/
>> -static cpumask_t iommu_cpumask;
>> -
>>  static ssize_t _iommu_cpumask_show(struct device *dev,
>>  				   struct device_attribute *attr,
>>  				   char *buf)
>>  {
>> -	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&iommu_cpumask));
>> +	struct pmu *pmu = dev_get_drvdata(dev);
>> +	struct perf_amd_iommu *perf_iommu =
>> +			container_of(pmu, struct perf_amd_iommu, pmu);
>> +
>> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&perf_iommu->cpumask));
>>  }
> 
> [Severity: Low]
> Should _iommu_cpumask_show() hold perf_iommu->lock while reading
> perf_iommu->cpumask?

Yeah. I will add lock around sysfs read in v3.

-Vasant

