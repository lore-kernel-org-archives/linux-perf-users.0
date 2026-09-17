Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC51156C6A;
	Thu, 17 Sep 2026 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627492; cv=fail; b=iIu1A4DyF4n0xDnCt4RorMxc6JVZhv3UUVqamcjEvgpgKYiVs/7UyBrVt7VgdfSm6CogrRJGAu78QhegObbrr0POO0g9oRGaKWIqMYnS+TSKyQzBEwXcZswE9HuhgYjgliuMBHzbhFzSXwPolTWwyclu5L2zys6BPQYEjUF/WNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627492; c=relaxed/simple;
	bh=1oddLDnIeUtHq9DGDzxYfH/k1K2U1od6LvymirSfHF0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E3RCPkaBR0/bSanKcgiWAKOshSrjmagA81gsSVGBK5WB1nD5nmGThbnhQYZo/jDE3HIcg5jDztHEiCswSTpJbEIeLFVps7ltUsnUzDsi/9UgqUXXlnCQ35w6ON+jQIC80TEo//fES+SW7oWKIUF7sNx7hxUt1vt9zO+XBe99eaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lWBHdL0V; arc=fail smtp.client-ip=40.93.196.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lWBHdL0V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JceLfbdvjTUxjRWE6Q0ruwqUHragizmZ8bV+JJSNCyTUtokQ4kwUlJvaMNbKc9cKvXRf9r7oMWUzFWqq6FKLNu81NI8flJAcKmPOjP0ui4nF/NV6IX4BhD0ETkQftrUUACiazOB3MwBvTJqY1yPNmPRP6wqXwuKks+M+ubiclGlxdDQIjxxI1oeBRNvGBb3cJK9fWraVJPxTo06Owwm8CFuqslmxo3qkhd65K7EZeVEr0Jvi9Oa5w/7/eQ46MSHeuomZSH4jaIFnOBSWZsgBrxqMyyHST5BFH98Kq4zn+4OYEyS0OOdPWJOuRZNgPPJZmB8Ar44mGMg1z52rYuiSXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5+7NknHeephla23ButpSU4oWrnxzzVk/CMvfFxyufU=;
 b=vL/hTB26xUY5+m1/DxHxR95xXnqTnzPxJcjN7KanNLnbugCB8LYpqVyr948H0PIAGCiBy6x90MKVEWq4etIKt5+0qNXZ1zpduhcc6aC/KeaqmVyXQpBfGxfppQzLOXEcVgLH9lTUL0Sgd3LcOTrLaBixIoSGt3S0ECoDQO5jTQigW4lLzoJbW6W/2ckx3b3zgaRua6GVheAcPj82Rzt+VA65UUbPJvhC3I9+aViGz30sfNMp8yEqq69CLPXSKeNU41kwo2/jbLoktb7le6ElEbqb5+ji5bCJM19VPlavs/8iA4a+4XxXbuBrINVpEjrHS1KamlEwupDOcGRXvxR//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5+7NknHeephla23ButpSU4oWrnxzzVk/CMvfFxyufU=;
 b=lWBHdL0V+73Tv7dNFqE4NIUjeu3DspLOEPcPaVKcylIqcwMGOK/KGJWp1MBSJZXMhJLIseAf3GvmIc7pQCBmNdGa6pEY+c9xV8i3aIPEiqvl38nqbuERCve63XQJxd/O7b4XAV6KKfqWU9ss3SYAVz0WXvTY8J/pTT8UGT3r1Rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 06:44:48 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 06:44:48 +0000
Message-ID: <121fe413-6861-4d45-a7d3-f3a3f91952dc@amd.com>
Date: Thu, 17 Sep 2026 12:14:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: Reject AMD Merge event as a countable event
To: "Absandze, Luka" <absandze@amazon.de>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <20260916123315.89042-1-absandze@amazon.de>
 <20260916125146.0E96F1F00893@smtp.kernel.org>
 <aqqhR9rZBUx-jscN@dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <aqqhR9rZBUx-jscN@dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::6) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|IA1PR12MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 0349062c-d3c7-4f1a-afc4-08df14872ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4jyzwm5Tb3JGQYWGShkapBcmVxCZMQ/GJytRA5UYfea1GaQmAK7ZZ5Oy7kDqDmjtj+OI1m6v55lDYMUYxrd4kqHuVRjHj2NIGNUjpscDdVWcTVgVdm96BqgbRgGKoHizmMFly05RNE7c8D1D7VJQXIavclkdvGoxJ1xhBEMtAVhGKAv4fm7P1p6XQBRIzBxD/7JvU6y0rTXILLgUehg2hCmoFPyjc8k3uqfHZNPy/o90PjHgAyJhbqMATsnXwE8AWyj/nAvPob1k5OUWxnSKKjwxkt9BApbKoSxXBR+IDqSAhypANU2YDMz7yX93mHkNuqZIP26btNbuZhTm/TYQNp1bhczInYa0uSsacBSYD+4Kbt4PSR3HXz59QXwARuqwHzqy2cppEM3pzosYyVg8EHm47od9MqsxSfmL/lZAh3Orxi5egyd4e5LeXF+iMduLok/SylqdBSYsDF2hpd9NhnSm/Ma0Hj0hr/HY0xgYEN5l94gRSEOnZsRoxo0+yA0YeoS570ZyDW3L5nWJqXamhNz25swNNCJpbf9EpzDli//Jk9dFWHuURne6JGEEXj1zheKD+jHa93DEc2Ucd/gLX6cotc0vYW+1Df3vTL5sSyQx3das5WCUr8RbRGM1oL4LsdTSdWSbPM00kVwIXl1LCKjjq/64jYZ1Oq93YuZIpJs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djlKN2I2Y1l3ZmdXcG9wZEdXSS9iK2ZwelZHamsrSzF5czVMbGNWaVFZSFJO?=
 =?utf-8?B?ODRYWGlLZW8zWG0yMytjNTN1MHBkMGZ2cGRmVTFUcGhSRjBPcnVjNUFPdVRx?=
 =?utf-8?B?cDZzZk11bUNrU3E4dVlManlpdTh4eXVQYUpwMUxPSGdUODFIM0h0ejRIaExv?=
 =?utf-8?B?Q3JQYi9qZk95OXQ2Q3g2b0FLOFN1MVVzcjNvc0dEK2hFazkyZ242Q0tIdVBy?=
 =?utf-8?B?TzNSZk03bkkrSHl3a3c3WGtibU4vSTNVZk9ZUG4xbDRkZzNZQS9JZUczZkZi?=
 =?utf-8?B?djlTOCtwVnlFUlZWbUZ6VGRkNVFlRzk0aGFQOWFybmdhUUpSeExMSEh3WUdH?=
 =?utf-8?B?czY4T25rbnNnWk1WVHY4dmFqWng3S0NyaG9DWmF1ay9iVEpZRnVzK1BGSWJn?=
 =?utf-8?B?akFkNVRFVzZiSVNqQll2YXpHSENEN2RkYzBXem42VkREemNld2UxOEp1TUxX?=
 =?utf-8?B?bWdSd3hlVS90U0YrZGVtbUd3K3Q1UGZyVWV4aDl5VnEyeG5TNmRDbnRwN1B1?=
 =?utf-8?B?RHh0SEJtTkw1T0hhQVVPZ1k3cGFoQXo3Z0Zlc2dMb1Z3c1JZa0N2dktXVFBM?=
 =?utf-8?B?MjZoSWVyOVhkMDRLcXpJbzgyWmhYdUlzaUczc3g5RkJmNVRGQk5CMGloT2Ix?=
 =?utf-8?B?V0ZHQXQyQnh5NHdQTVpta3dmV1d1MSt2S09QdllTSXFSQmRBZnJnRHNadmpi?=
 =?utf-8?B?SklmakRvWlBmMm9iK1ZVMnEyemU1WXppdCtqZ29aSVVOMkpzZVh6MnkyUWJu?=
 =?utf-8?B?L2g1WFRxR3UvQ0lUOGJMejlxQzFxQlc5TURvYnJSZE5nczZSalJyV3BsenlO?=
 =?utf-8?B?LzU5bUZCdUNVQzhSR1JHYkVaczZtWFpNRHp2VlNzREplUXUyWCtvcXFQNUZi?=
 =?utf-8?B?T3hSODdueHF4YUg4NW5tbHhHRXVYeVRDOW1IY1pNS1RHZWdnTzJLV1kvOHBs?=
 =?utf-8?B?emhncDBTb2s1MytWa3hBUE0rSHEydkJ0Rk9BZlVBaVZKT05WV1JHWkJPQW9U?=
 =?utf-8?B?aElvTHhPTlJBOEQ0bk9UaERFYmw3RWF5YXcrczQzZ25meWdjY1NGZVMvdFBT?=
 =?utf-8?B?dXZpL3h5a1ltams5WDlEVVlvOFpiQkJqdzFFUHA3USsyRFJQNXF1OENRTFp0?=
 =?utf-8?B?YlN5cSsyU0k0WVNydWdGNFlkVWp4MWtvRHpiNERKc29hWmM0TE1FMUZlaDQ5?=
 =?utf-8?B?Zkx2bFkrSWgyOVpnSThwS3R2MHBPWFZXQjRNUHR4ZDdvN2lWNkRoMUY1TTlY?=
 =?utf-8?B?alFFazJ6MmJHNE0zTXlwTW1qZkdtSmozQmQwbFZZeEgwZmlQVk5Qc3hLdEY1?=
 =?utf-8?B?ZkxFUHhSdVpnZCs0cnMxWkpjbVdiaFFLdTh4Y0RiOTMxZGNZcm85VjB2V2xO?=
 =?utf-8?B?MVBOUXZLWUJ4dnhrb3BMZmFCUkpmVVY1Ny9Ya3BCK0F4bW5QQTFvZWtybzkr?=
 =?utf-8?B?MmVGV0lEWWZFeHg1cVUxZjhjamZyMXNTM0I4YkFyU3dQWWtnWndrenVXZTRJ?=
 =?utf-8?B?Nkg3dXdNdlJPcXJZN2FuR1RTeHE2Nmk4UjZ1bHFqV3JBNHdIVm9rU0lqVnRr?=
 =?utf-8?B?VkMxYTROUXEvcmYvd0Q3dDF5Y3BJY2ZRelZwK1NGcDgxQjZGa1hXZ3lka1hP?=
 =?utf-8?B?R2ZJTWVHUlkzS0twWVNML1UxTldKeVZ5Um9wa0doamF4Q0JmOFFTczZYY2U0?=
 =?utf-8?B?bjEvYlJHUW1WMlJsYWdPcGhHSHFzalk4WjRSbmxqZHhaeXNWZUtQUno1a2hN?=
 =?utf-8?B?bFlBdkttdzNmYlJPblNMK3pqSFFGdVZCRlgwR2ZIaHRoQlF2alpjL3BaM2RF?=
 =?utf-8?B?ZmFwTXJZS0dBb0xjUVB6VVF0MGgvcUxCSi9HaC9Mb3pOTDh1K0xTOVc1bU43?=
 =?utf-8?B?TjZ3UU1tNEZkK1E3ZktnK2I1L1NDOWxHZ3ArNWUxbnBYRERUTVVjRmx5djlJ?=
 =?utf-8?B?ekpCMmpGN0tXRml0SGdvM2cwaklxWnZ2MmVyZE9XcXVTZjNkcjliK0hlL3Jo?=
 =?utf-8?B?ZHJmTnhGVzdLVmlTQ1lubC92UlMrV0c4QmZERU9Oc3BVUFJ0VG5mcEZkbkNT?=
 =?utf-8?B?TXN0YXJtcjFhZU93c3QwTXNiVDZ6OTEvMTBrUE5BM2kyVURETEpidnphN3lw?=
 =?utf-8?B?cllwWE5NZENIeDk3VjUxT2ZGVnQ4NGJ5RmVjZVE0T05zUmxiUldUa3E4Rk82?=
 =?utf-8?B?TXBvaW9sZG5WV0JSUFB4b1Q0Y0NxV3hyVDlabUNLRTJBNWIrUGg2L0YvZXFP?=
 =?utf-8?B?MTVEVktjTWtyMFUxYnh5Wk5mN09laGxZOWUxUldSY2tqNmI4VDRmbE9qTU1u?=
 =?utf-8?Q?jmRb8jfjNwyUcJa0jE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0349062c-d3c7-4f1a-afc4-08df14872ac5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 06:44:48.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUu9+vrVtrmr0+E7GOmw8rKGarUPAcEiQtY2LtHyVN2czWoFKde9xcLUIwjwguGydECGaAdgHj2vdZv+EDZm7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067

On 16-09-2026 19:32, Absandze, Luka wrote:
> On 2026-09-16 12:51, sashiko-bot@kernel.org wrote:
>> [Severity: High]
>> Does returning a permanent -EINVAL error here cause an opportunistic retry storm
>> in KVM?
>>
>> If a KVM guest programs a Large Increment per Cycle (LIPC) event by writing
>> AMD_MERGE_EVENT to an odd vPMC, KVM intercepts this and attempts to create a
>> raw host perf event.  When this fails with -EINVAL, KVM's reprogram_counter()
>> propagates the error to kvm_pmu_handle_event():
>>
>> arch/x86/kvm/pmu.c:kvm_pmu_handle_event() {
>>     ...
>>                 if (reprogram_counter(pmc))
>>                         set_bit(pmc->idx, pmu->reprogram_pmi);
>>     ...
>> }
>>
>> Because KVM treats all failures as transient and unconditionally re-adds the
>> failing counter to pmu->reprogram_pmi, on every subsequent PMU refresh KVM
>> will repeatedly retry the failed counter.
>>
>> Could this create a permanent retry storm that degrades VM performance and
>> wastes host CPU cycles?
>>
> 
> There ins't any substantial load generated, we short circuit here before
> the expesnive parts. However, a followup in KVM could be beneficial to
> reject this case outright.
> 
> I'll wait for opinions

I think it makes sense for the host layer to reject PMCxFFF altogether. Today,
at least for emulated vPMU, when a KVM guest programs a LIPC event, 3 PMCs are
consumed. This will ensure that the 3rd one, initiated by the guest programming
PMCxFFF, is dropped.

I also agree that a followup in KVM is required.
