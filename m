Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6E189BB1
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2024 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750898; cv=fail; b=ZXpO9+bqZLuCVBRjldps9zZM0FUGVaGRb8YZUV/MHcG0wPAEXNbdG4/V4IjkKOn+eicdS6ZyQzQgKbTdlVACPTq/p4armyXZBdC1+n0VyFMKbPMMuzfzv4rdCRCJUKdwnzQrX6GtB1j8qqWAvqXBz8932qblRZwj7BhdGY4V2XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750898; c=relaxed/simple;
	bh=OYOlwmR6wwMaGahkHg711uJQrTPwI4MD83JSqoJ7acc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gGiCQEHqFfId9tJCGhfYAJDmgmPRICreePoX7AbcLJzyyltrI7vnUdw1QpEqwCQ6J49dpohdYv4Hz5BUFm01Nc3Dsz7tofWt40M1WImUkJ2Zm611lTX7nTpY4+L8J19BXPyiLelFwdnYM2JdvhBqE0q/Rwsf3KzlV5tLtXweqJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=suv9dVr5; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="suv9dVr5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9H1NigFPJmZPSIjn6kshsm/slhLtcEXN/qUALv4u+T/iSVVMXEphh6fjlyJJ4OdxjLvKJZFN+7gh7kOld4tEly2/NQuW9lgfDjAb9N5E2pPlO+QgWbW4kgjB5BjqgYDzQQYCHaZb3GSvgN3z3d2KWsIYqxWlF4bzeBB5MHzqVIyBisZwemsTnOwqDKNzVj+Gp26zBGknxcRiQajTgym5nJjubUoXSSVXYiHgzz4EDImqKEEG0lEWHPuP8eNHsWyP9IHesCEiKKNPdakXyRvHXCHjzWZtkp0W9fk3cHbah4mVnmgBEn2Bb7wgRcF0xr6DhAd56Ze1nkM0lKnWnGsQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rV1nR2SKuBOJErQb+poGyit2p7lYgVf+0Wjh0TQF9so=;
 b=MmfQSoMJ08dTL/B85T2KrtIadN4p/MFk2V2rePpARsvQk4NUsaKJbTGg62u/rju7Cgc+AG6WPRI6SYjM183n0+OeWhE49e6O/zXuv2mFGRreWljL2BcEuingw5BCL8eh2VoEIFULCBHENFeO4m9aiS21Ot8xdZihbVVkMbL08ygraQOxy6sERbRtksr/ppISdSN9noC9cx4Kiokn9ACTDjM8uk8s4r1V9QAT09bgRWs9IJJD/89SrYhMrDHGQunNkgev9neFAMyv2VpMzXkzxSBmLBqKCd5Aa6zBElJQQsCr/Kkq/yGkAdJBJDk0LfSLCRQ2rvvZnIUnKsbKQBI9oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV1nR2SKuBOJErQb+poGyit2p7lYgVf+0Wjh0TQF9so=;
 b=suv9dVr58QoyIeW84LxyU/IZAvw+eCo5Jg/HgFt2+r7jHFZtOQcp9K70CBP62y1mDHa8aWGGaq9SqtaHqO4Y+9Bguim7rWEZo+OBPcTElE4+Vi3Ctp7LRFZA3BLEXfXDgupcka1qP0+rfC/rweK9FKpQmTNOnWvJHpmgsEEf1vE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 06:21:33 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291%7]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 06:21:33 +0000
Message-ID: <368573d6-fd3d-43c3-8c15-d01ef0c35026@amd.com>
Date: Thu, 24 Oct 2024 11:51:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] perf top generates kernel "unchecked MSR access
 error: WRMSR"
To: John Garry <john.g.garry@oracle.com>
Cc: linux-perf-users@vger.kernel.org, x86@kernel.org, ravi.bangoria@amd.com,
 Namhyung Kim <namhyung@kernel.org>
References: <156a0ee3-18d5-4144-9f86-230a3946940e@oracle.com>
 <Zxl_4TvxWTtmO_e8@google.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <Zxl_4TvxWTtmO_e8@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001AC.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::12) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f01fe37-55e4-47ad-9752-08dcf3f41ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUtZd0dJY21JbDR5eEQ3aXQ2NDhVSndLVVJrcGVHZ1N4cllPL1RvS3k0TCtK?=
 =?utf-8?B?bmJlbUphR0tRS0VZaVc1d1ZERXZHcWQyVEM4eXo3ZlE2OENOVy95azVQMWp2?=
 =?utf-8?B?NzBsUWlDR1VxeDdOakpHS3BwMitXby95S1VsMkg0Vk40b1dLc094L2Z5dXJT?=
 =?utf-8?B?U2lndjFOcVo4NjFpa2ZvUndFQXVRRmZhQnROdGt1ckg4ZzlkSFBOTmk5SWhu?=
 =?utf-8?B?WkR6aHRCeU9NQ2FSczRGRDcxcnVSckVBRXQxaWlObURqMmRMV1dPNUVCUi9H?=
 =?utf-8?B?V0VWR2RJTy9ldTl1UnJUWSt6ZGt1L2g5bFVGUVdBaFUrQWhRVFI5THhScC9s?=
 =?utf-8?B?bkxBOGpQd2dKb2t0Z0J3OGdkRVFGYU1JUzdJRGdsU1FTb0RFbnJDYXdyMTBo?=
 =?utf-8?B?RjdhWHBIWDVFdVltdHpnOXZyaXlDa2l4emdRVmJNZ1lGMEtKVi91a3RiOGFk?=
 =?utf-8?B?KzErcThmRVJUTXZadFRNdnVvaWoxMVVraTArZlZIdHl5ajJ3aGt4eTJaV2FF?=
 =?utf-8?B?SHp3RGt3Um9SSGFNY1BKd0s2L1NGN1ZuaDhqUzRYQmp4MW1HNnpFeWtyOFFN?=
 =?utf-8?B?VzVRU2hneU5MeENOcmdzOWVzenlCNnZwWWhKeS9vaU1RRHYrUDJNYW5lSEV1?=
 =?utf-8?B?TkhOK3pMazV0M0xCZTdaT2MrZWJjT0k4WVQ0TkxvVHliNzM3cHAvOTE4dFRW?=
 =?utf-8?B?V3AxaE83QnAxYzhiMVpvY3hKUkVieDR0U09JYm85cElaVkdhK0N3YzB5UVA0?=
 =?utf-8?B?Y3BZTXdFa3hid1JDMzYrYlNXbW02UjFYU3huZHVNd1pxd3ZXV0FvUktQYkow?=
 =?utf-8?B?MkZqWUZtZU0zQUc4c3hlZmJMbFVaZkVPU2ZPdXJwcFVlSEhZV1N6YTNHdjRZ?=
 =?utf-8?B?VVBpcmxOLzNuRXM4a3E5dGpyOXpFVW95N1V3NEk2NkhQbjBLeTlhcDdENmVx?=
 =?utf-8?B?V1g3NnNXZHNtTmFUM0UxY2h5ODZWRHhKTEQ4ckJCckxoNjU0bE1PZyt3QjhK?=
 =?utf-8?B?V1VzM1JLSGwrREpXaDkxaXVZa3lnVzNHVkFMZkd1VndxaGY3VTFXeHA0VWR5?=
 =?utf-8?B?eGFBd1dzTzBTdmNDWGFNNnUrblQyZjZrcEFIbWl6QlNlSFVPbjJIR2pveVh3?=
 =?utf-8?B?eVV2eEg3RW1ZRGpDMzJFK0JRN0orZ216NlFiZ0M2SEYxWjg2UGx0RUduY3Q3?=
 =?utf-8?B?WlNhVXE4eE5aM1RsUUs4Nlk2MW1ETCtLQjFqWExBdW8xVC9ZbElNQ2NoQjhW?=
 =?utf-8?B?Tkp3MXRTNUZma1YydEplNnBNNTZqYjkvbDNuSjNpOS9OWFk3Z3B3SzhxUVcz?=
 =?utf-8?B?WnpST0hEZEtyaVdaZ1hhYUhXaWdXU05vV0V4aWZxTzFjRUZqZ1JGZVBKOW5G?=
 =?utf-8?B?MzVqLytiMWJONUltVVpnZFJGMlpXU2RQMXkxVEs4VGFuYW5mK280dTJUVWIx?=
 =?utf-8?B?R25wbHZlbTJNU2REWG9sUzFaN2lERHN6NHd4bUZvZkZEMnFLaUlLend1RGZQ?=
 =?utf-8?B?VGxqYWdvek9iOG1CdnBSREpJTkd1UDZwcVluV3NzZm5yYTNMSlVhbGZhckZm?=
 =?utf-8?B?cU5rZmlUWWhQM2lRNS9VOFhrcUJkd2UrS0VrblQxVHZoSCtOKzYwY0luYlhl?=
 =?utf-8?B?aGZud21Rb3gzTVI4eDZHbG14NU02MTBabEhNNld5WTBNMTkxdmlXZDhiMHZD?=
 =?utf-8?B?b0VMbCt6dGEyS0hOa0RvZkJDQVc0VWhBMHVLS3FVc09aN1ZtbGp0dHNBanhR?=
 =?utf-8?Q?kKvWVwIGSzWcVSOso9XqPkT70P5A1Hvqqp1zKRy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzdtTWtVOUVwcEl0ZzRUYitNendkamkzczV5UFdROVoxZGdiWmlBNm1NeGNH?=
 =?utf-8?B?R1puNStYcm9ocGNQY2xrbWtMWkEybFBVY0Z5SmMxMWJRUWpxbzYyRzNjcm96?=
 =?utf-8?B?MGltaTZZbkpkelpCRDA5U3MrL3B1dkhBNDVrdUpVMlBhRlNMQXVPZ3JBUlJJ?=
 =?utf-8?B?b1dLWGxpcU9SQ2lSSUYzdEpyUld2eGxwZG8yZ091bEV2SUdIMzdFZXZYOXF4?=
 =?utf-8?B?WFlvREN2RENFMTZJQWxEZ2tBZVowUC90MktpRFVVTFR1MjJyVFRQcVQvdlFH?=
 =?utf-8?B?Sk4xdUFhZE1wOUNDcnQ3b2pVMDdaYUxRWHdXTm83OHFJT2YwcEIrRW9tTVF5?=
 =?utf-8?B?NTdhbjBONmRVZERiaUtKNEZsbHNiS3hkUUhaRWxKb05kaDhYT2dMRDdDWFdq?=
 =?utf-8?B?U3VweUJQd2s3ZkNPQ2RiaTZqRXdXVmNCVTF2NzN0M09TeGEwOFFETzlTUTRo?=
 =?utf-8?B?QmFGSDVQVTl6TitwWEFKS295ay9taFlYQXJ0OUc5dDBOUE44VmpsMUhqTjU5?=
 =?utf-8?B?S2hDMWphY3N0TTZpeTF0elBvVkJPT2pjUGxXVGpKZkhHdWpMVHE3QTVNL3JX?=
 =?utf-8?B?VDVZcHlOR0VpVFh6YzdBQjhsNTM3a1JoK3g3SGRUN3Zva2lZd2xwMWpQT21W?=
 =?utf-8?B?MERROGZGZkkxc3lPdXlDWGtjT0d3WldWblVwb0hUZ0Jaa3dWU0ZLSkE1OXds?=
 =?utf-8?B?VDZiK1FocUZnSFBneW1MRWZSY2l3UTRZbkl5OEE1L2pSZ2xEeDFUYXROaUJK?=
 =?utf-8?B?aThweG1KTml3ZEo0WDVFMjZyemZFTUlneDBCS2FKUDcybWdBVmFhM3R5QXc4?=
 =?utf-8?B?ZnRydGZ4elppZUpaWFBUV2xEcjFoVXZ5WnllendSd3ZTWDhVcmFabjVlbWlq?=
 =?utf-8?B?S28xUkkrZFNEcW0xTU1yZXN6VjBXOFNRUWI2cVcybWF5QzQ0N1ZMb2hoenZU?=
 =?utf-8?B?NGpzL25XU2ZIcGtWa0g5UWJ0LzBNajJkTXY1Y1J5eWtIY05oTDZodzVGQjNr?=
 =?utf-8?B?SXFTeVp1M1FWOVNtMkdhNjBFUXUybTRXM2FOdTBrc3BCZGZpMkRBSE5QRDVt?=
 =?utf-8?B?WjlHSDcrYVQ3bWcvTU9uTExPZVlpT2x6R1J2WGQzU1ZTbFl3eXpVVWNQckw1?=
 =?utf-8?B?RkFUeG9ESmFjUkpNQ2ZCdEpvbnFvUW85VVVNRS9GUWZsdFduMGQvcy9BOHNV?=
 =?utf-8?B?VGY5eDZvcm5qbVdIVHM3R2pzaC9mWS9KRFMyWGxud1IzbDhIUnRKTW9IZlFI?=
 =?utf-8?B?blJQdkpVbEQrd2hNTXNjOHc0QjRzcjlvQVFZVmdrZ1BveWxya0VUWEVlQXNN?=
 =?utf-8?B?QU9qQzV3RVhDVk5YdFFiL2dQVDkvV1ArY21wR3IweHFhK2dpZmV6QjczeFlG?=
 =?utf-8?B?QjAxV2dEMkMyQ2NIWlVmdFNnbGphTWdMUFN0Q2VzNGtxNTJOUkxUWWMxazFj?=
 =?utf-8?B?dlRZek5NTmRlK3VoMlBXZFNpSWJUbUJwQndPY3l1dGdaUkszUFB1RG1NOUtV?=
 =?utf-8?B?MG1Uc0s1dkZkRjNuL1dhNEF2YnJITUJmMGEzWGZOWk5oR05WR0MzSVNZamRo?=
 =?utf-8?B?YjhNNCtJdEU2TGVHRUJVV3BuMm5lTmRzYTJhWDlBMEU1VUltY2EyNERpVnIz?=
 =?utf-8?B?Ull5TnpkdzFvUG9yUjlYUS9rSVl4ZzdiWWUrajRYN1ZSOTJLTVphUnpvVENx?=
 =?utf-8?B?WnFMOGJYOEJpZnpQSUE5RTNpZXAydXNIUzkyV3g3dzJ0YTNlUjRkTXBwcjlt?=
 =?utf-8?B?RWU5VU45ZVFidjkzV3YvR0ZIdWVwekh6SjEvcG5DUWpDS1FSTkE1RVR1dE9n?=
 =?utf-8?B?bmFlajZnTk1Fem8vb25IWUF6MzZHLzJkK00zcDYwOHlhQnhxcnlQK3pPbHdq?=
 =?utf-8?B?YWtLeEI5M1l3M09VbkN5QlAyN1dMT01uNHBwM1lIdmcxSUlwSjQraGFERkhv?=
 =?utf-8?B?bTE3bUhtR0oxK3UwcGFZMXdNNnVqWVZEaU9NS1Rvcyt4TXBDMUo2N0xpRG45?=
 =?utf-8?B?b05ta0ZTaG5pLzY2RTc2dEY1d1VkckxsNWpWaUVyS1VCelhZa2xsbFBpb1gx?=
 =?utf-8?B?d1dUbng5ektFMWF2L2FlSWNLN2xEeUl3MW14WTlEK0s2Qm8rWmxjY3B1TjdX?=
 =?utf-8?Q?wA8a8c7iKDotIfuXJhl3ILl8q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f01fe37-55e4-47ad-9752-08dcf3f41ade
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 06:21:33.1909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqFqfp0rXxkZ3QbB0O8JDK2wxowPmjeso/87RJcqeEZ4NH84teP2GISluTFsG6hZudknk/1Qngzx3r+3KmmA/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459

On 10/24/2024 4:29 AM, Namhyung Kim wrote:
> Adding Ravi and Sandipan to CC.
> 

Thanks for bringing this to our attention.

> On Tue, Oct 22, 2024 at 03:55:05PM +0100, John Garry wrote:
>> Hi all,
>>
>> On my VM, "perf top" gives this stackframe on v6.12-rc4:
>>
>> [  930.527581] unchecked MSR access error: WRMSR to 0xc0010200 (tried to
>> write 0x0000020000510076) at rIP: 0xffffffff94ead548
>> (native_write_msr+0x8/0x30)
>> [  930.531135] Call Trace:
>> [  930.531456]  <IRQ>
>> [  930.531749]  ? ex_handler_msr+0x138/0x150
>> [  930.532285]  ? search_extable+0x26/0x30
>> [  930.532780]  ? fixup_exception+0x9c/0x310
>> [  930.533405]  ? exc_general_protection+0x10c/0x490
>> [  930.534081]  ? asm_exc_general_protection+0x26/0x30
>> [  930.534768]  ? native_write_msr+0x8/0x30
>> [  930.535357]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [  930.535998]  x86_pmu_enable_event+0xa5/0xd0
>> [  930.536641]  amd_pmu_enable_all+0x4e/0x80
>> [  930.537211]  ctx_resched+0x13b/0x1d0
>> [  930.537735]  __perf_install_in_context+0x2a2/0x390
>> [  930.538439]  remote_function+0x49/0x60
>> [  930.538931]  __flush_smp_call_function_queue+0xdc/0x700
>> [  930.539694]  ? __pfx_remote_function+0x10/0x10
>> [  930.540480]  __sysvec_call_function_single+0x38/0x140
>> [  930.541134]  sysvec_call_function_single+0x6c/0x90
>> [  930.541970]  </IRQ>
>> [  930.542269]  <TASK>
>> [  930.542766]  asm_sysvec_call_function_single+0x1a/0x20
>> [  930.543493] RIP: 0010:pv_native_safe_halt+0xf/0x20
>> [  930.544195] Code: 22 d7 e9 ff b5 13 00 0f 1f 40 00 90 90 90 90 90 90 90
>> 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d d3 e3 25 00 fb f4 <e9>
>> d7 b5 13 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
>> [  930.546841] RSP: 0018:ffffffff96a03e68 EFLAGS: 00000206
>> [  930.547563] RAX: 0000000000000006 RBX: ffffffff96a269c0 RCX:
>> 0000000000000000
>> [  930.548579] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
>> ffffffff94f53f31
>> [  930.549568] RBP: 0000000000000000 R08: 0000000000000001 R09:
>> 0000000000000000
>> [  930.550529] R10: 0000000000000001 R11: 0000000000000000 R12:
>> ffffffff970608e0
>> [  930.551582] R13: ffffffff96a269c0 R14: 0000000000000000 R15:
>> 0000000000000000
>> [  930.552683]  ? do_idle+0x1d1/0x2a0
>> [  930.553182]  default_idle+0x9/0x20
>> [  930.553670]  default_idle_call+0x7d/0xc0
>> [  930.554226]  do_idle+0x1d1/0x2a0
>> [  930.554696]  cpu_startup_entry+0x29/0x30
>> [  930.555154]  rest_init+0x12e/0x1d0
>> [  930.555621]  start_kernel+0x60f/0x6d0
>> [  930.556064]  x86_64_start_reservations+0x21/0x40
>> [  930.556633]  x86_64_start_kernel+0x91/0xa0
>> [  930.557107]  common_startup_64+0x13e/0x141
>> [  930.558038]  </TASK>
>> [  930.738880] perf: interrupt took too long (2511 > 2500), lowering
>> kernel.perf_event_max_sample_rate to 79000
>> [  930.772912] perf: interrupt took too long (3414 > 3138), lowering
>> kernel.perf_event_max_sample_rate to 58000
>> [  930.797764] perf: interrupt took too long (4275 > 4267), lowering
>> kernel.perf_event_max_sample_rate to 46000
>> [  931.117733] perf: interrupt took too long (5345 > 5343), lowering
>> kernel.perf_event_max_sample_rate to 37000
>> [  933.862829] perf: interrupt took too long (6765 > 6681), lowering
>> kernel.perf_event_max_sample_rate to 29000
>> [opc@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 ~]$ ^C
>>
>> a known issue?

I am unable to replicate this with KVM guests. MSR 0xc0010200 is the
first PERF_CTL (event selector) and generally, unchecked MSR accesses
happen when the hypervisor restricts what guests can access.

Can you share details about the hypervisor?
If its just KVM, can you share the host kernel version as well?

>>
>> more /proc/cpuinfo gives:
>>
>> processor       : 0
>> vendor_id       : AuthenticAMD
>> cpu family      : 25
>> model           : 1
>> model name      : AMD EPYC 7J13 64-Core Processor
>> stepping        : 1
>> microcode       : 0x1000065
>> cpu MHz         : 2445.322
>> cache size      : 512 KB
>> physical id     : 0
>> siblings        : 16
>> core id         : 0
>> cpu cores       : 8
>> apicid          : 0
>> initial apicid  : 0
>> fpu             : yes
>> fpu_exception   : yes
>> cpuid level     : 16
>> wp              : yes
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
>> cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
>> pdpe1gb rdtscp lm rep_good nopl xtopology cpuid extd_apicid tsc_kn
>> own_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt
>> tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm cmp_legacy
>> svm cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw topo
>> ext perfctr_core ssbd ibrs ibpb stibp vmmcall fsgsbase tsc_adjust bmi1 avx2
>> smep bmi2 erms invpcid rdseed adx smap clflushopt clwb sha_ni xsaveopt
>> xsavec xgetbv1 xsaves clzero xsaveerptr wbnoinvd arat npt nrip_sa
>> ve umip pku ospke vaes vpclmulqdq rdpid arch_capabilities
>> bugs            : sysret_ss_attrs null_seg spectre_v1 spectre_v2
>> spec_store_bypass srso ibpb_no_ret
>> bogomips        : 4890.64
>> TLB size        : 1024 4K pages
>> clflush size    : 64
>> cache_alignment : 64
>> address sizes   : 40 bits physical, 48 bits virtual
>> power management:
>>

I tried replicating this on systems with an EPYC 7713 (very similar to the
one above) and an EPYC 9654 but had no luck.

- Sandipan
