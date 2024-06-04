Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F501146A70;
	Tue,  4 Jun 2024 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507006; cv=fail; b=K/YLH7sCtG3FwmSjP+baQz2hc3zcqEzIXAcj5fkM+PN+WD+dxsClHTkLY+3QYk/GSoZEnJXfrPLmm0RjN6hxSpsrlrhcmqW/Os09ryPrh/0F3edf7hwafpmWwntj30RZzIjKPXPOWW73rJzllM29KY+ZTX0I7fNhj9sGrBUndOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507006; c=relaxed/simple;
	bh=DUkOwH1VYH6tp02S8MhqiCHHlNM82NtCDkHmfBnfSaI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FUnFwBtG3iBAvWYmzEAUnl2EiysM0Ez71bP35nUXrcRaoshcoJzbK084GNv2QIKRWIuc+Sr8A3y1QAzeF9TlhHP5Q1LWm3+8zMW0SyfsdW0Kiq1Z2ybZJqYfQ+9HZltCdvorh/G9NtlDgFpniOz8zAqqcr9D6pA92hlsp9BVabU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t7JwK5iW; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t7JwK5iW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxgJQBKQbNq2mTPcG7Xqle2Am57X+iv1HQ2sNM8ONlbg/D0sZiGnvVsMN6TVEZDri7W/aopTkvI+twW04OUFgHI2lkmaNdf6xmBOdztasFcV6Quv+YBS4bIHft0kCMUWlzCzwG6ZPcm65NrwMNxbWSWJBk6Cz/1SLE633c/f9IooUOtlFVF9sENtnItIzS6Tg4h4Znhl3Ulg1aLutW4bq/wLIkESR0akJI7WUiy2LX3RZKCMZeNJW+TYY7o7jvXApcPf+6hvMAQKa0SAwhlpk4M0Ia8EfzLeWZuUY7MgCpLXUDTBGTEdg+2PeW6037DpKUxfbYYsqDhIhJgxf++QVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4UKdxL4Mw0Jx9UqVnWvG/p0kojpv67Uat1o142VZ9E=;
 b=mxXnJhewwbJpgzqfpqbESKFP19KmhzV4aJfZFl848cYCIN5Xx8U9piSkUd9ajn1e9bIprsMODfs5fMrX2faCKeNzqzjpCXI137OpiKeti2x9eWxy7qQJMYPsh0/DWk526/vLXkM/ZcKSdMM/TjUD1OCpXBUf28onMCkZaNlxyC47BbDMV4qLgqlirY6i8tjaN8ERgHRnscWEIw88G1twGAiNCePQM9yyITuCvhQ4DpQ66JuqMgQCb8dJSe6Qe0Wihc5ZhP8U7n9eRlc3PegRimQXrFry74Kcaw3xVviBi2dN5/yqdQTKkZnYD7GYJLWq8ZXJu3K3OHZsJvc4+R4SSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4UKdxL4Mw0Jx9UqVnWvG/p0kojpv67Uat1o142VZ9E=;
 b=t7JwK5iWLDVtJmakbVIDBYH+BiUCJVi43H6gzP1uD9thnTEzNybymd7bHKL+oxd8JE3Tt13nDgxDxa+5lp5nNU9bm1VeHmRwBgsTjrS3U172TblIyR6vRvUnHf1qlvAFcLa6lBhZpxZ++dTr4ymlAUz3zlzsg3OABMlxJ32OJiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 13:16:41 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.7633.018; Tue, 4 Jun 2024
 13:16:41 +0000
Message-ID: <3ec1cb26-c889-45ab-b8cc-92f933a2b5d1@amd.com>
Date: Tue, 4 Jun 2024 18:46:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: check event before enable to avoid GPF
To: George Kennedy <george.kennedy@oracle.com>
Cc: harshit.m.mogalapalli@oracle.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 ravi.bangoria@amd.com
References: <1716990659-2427-1-git-send-email-george.kennedy@oracle.com>
 <75f6aba1-8ed6-4ef8-8811-de40ae40be90@amd.com>
 <1e14ca4b-6e3e-4d57-acec-bc3ee2bed6ed@oracle.com>
 <0494aedf-9759-4427-a7f3-39a91bd5771d@oracle.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <0494aedf-9759-4427-a7f3-39a91bd5771d@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::20) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MN2PR12MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: c196635f-eb99-4292-d7aa-08dc84989281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDBVbjZ1VGRNcWV5aUFnQ1c3THdpa3VzNjRkQkVpdmkyU2Y1a0g5ekNIMTU1?=
 =?utf-8?B?ZXJ0Yzh4N1NZSkNiNzBxYWZzTUJsK0lrdUorb01Ba05scThGZmhwRjU4VTNH?=
 =?utf-8?B?THB2Tm5HVXVnanlmNVdvL3F2RFhodmMvNmc5US8yRW9CUEJQVndiYzlLN290?=
 =?utf-8?B?bVlycUFtT01GZllRa0dqT3VHS2pFMGxwT00xcFNHVndSSkxBT2NpRE5EYnky?=
 =?utf-8?B?Y2NlRzNNSHdnRllLaG5ZcXpVbS95WUxoU1BMdjRsaUFtc0s3RGZJR0FhQ1R3?=
 =?utf-8?B?Y3l2WEF2RnF4NXNUNi9aVE0za0tmR09DSjczQkFxYXpLMzZ4cTRSUDEySWlq?=
 =?utf-8?B?bUdlc1h5MG1lYzNVM2REOS9oSEIxdTFrZE9VNGg0NVhiMjN2T1VWdTJHL29X?=
 =?utf-8?B?RUdjcDBNMEtVRmlKWkVKZDNtVTlRbjg1cjlKUVZQUWkxL2gwU2s4dHY1U1c2?=
 =?utf-8?B?VVhvMHdtR0VyVFVya0FTRzM5WUI4Y3RINmNWbjJMM0JUN3d2bFkxZ2RUU0Z1?=
 =?utf-8?B?RS90RFBDNFN1NGZKV0FQT2RLVVlhWnlkQnRVOXFnNFBrMW5HNjc3eHplVlBZ?=
 =?utf-8?B?L0FTN0pzajhUWDFjc2UvVzMrejBWblh0MS96Q2NkTTkybzM5RmgvSnVCcGJB?=
 =?utf-8?B?aDExejAyR1QyUm5ycmFLdkM2VEJiMzcvMk50UmIwWnFCTEJXSU55LzVRa2w0?=
 =?utf-8?B?MDRaK3lseU5LUGZpR2xPdUhQSWpCbXkxSjkrZmExVVBJR2g2VXNBUVlNaSty?=
 =?utf-8?B?aTNJMnM1MVZXUlRSKzh3bWVJM3NFK09JWlhrVjVoeDFwdG5SbXpYUkZpWFgv?=
 =?utf-8?B?RzRDeGRLR3dFQkFQYW1aa0gvb2FvMm5FcW1MMUptSUNYbHNiOWNrWXVlSUlX?=
 =?utf-8?B?czRTRm1nZGFzUzFvcHNkUFZlaVNOaCtscEZPNHI0T0tWTC9rR3UwMzlmeUx5?=
 =?utf-8?B?c1JrdWlBbGt1R1QwMk03YjZQMWoxOEJEU2RVZmpobHpvUWp6M3lyallqV3N6?=
 =?utf-8?B?L1JJVXdhMFVkWC83TVJQTmptVDFiRGhRVXpla2lTU0hGUWZ5ZDFwU2lPRWIr?=
 =?utf-8?B?SDZITmswLzZQRUd1dlFlTWMxS2wrYm5FMHRFcHRpaG1GMWF6eE5XeVFrYytS?=
 =?utf-8?B?UVpLZ203elptd2JkMjZXZmlHT3BJaXIzUEM5MUFLUXRYOE5lOHVDcTBTYWs0?=
 =?utf-8?B?RTVBZWJoNTJuUVJDaW13SFJHbGViUmZONU1VNG9qUXJEb3djaGVlcnJ4RlZ0?=
 =?utf-8?B?MFVzYmR6eDE3VmJRUWFUdnFnY2YwNGdrQUExL3lmZFNGSzZhOUNMK0U2VFdi?=
 =?utf-8?B?eldodkNxR1crbllCY0hKbjdEckxEd1JQcnpxK1c1K3JPcjc3VUFYaDUrdytm?=
 =?utf-8?B?ekZXYkV3VTB5cU1CcU4ybFVKMC9sVGlJd1RzdXBrUGVJWEI2OGhvQWVPNEhB?=
 =?utf-8?B?L2V3RTdxeWgyR1ljN1BXdjJNblZXVHN1N0FZTjVvbjNBNVhMcmd2TDR5R3U5?=
 =?utf-8?B?NU4rYndsMHRMOUEwVGhMUG1IOStGV0xmMjlpU1BHNCtQNVMzeFVZTEVUZGpR?=
 =?utf-8?B?bmlidlM2cVlySXFmNHpPOVBEV21tOHR3RFBrVkpOMFJiaTB2Y1AzUERFZjl3?=
 =?utf-8?Q?QQUs3OwXMWSwaHdm6ZZYJ4S5ObnYEb/xESKCj9duQmU4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2xXUkYxc3h6bmhoNHFPcGhpTy9YUUc4RVQ2dTY2NmdwYWNHekxPUXJWZEQw?=
 =?utf-8?B?aXE0dml6NzJuc25ZVGRsR3FMSUpkZTVNNEMxbitZZjhBeGl5eElZNEJEeC9F?=
 =?utf-8?B?UXJGVTBQeTBGajhtekk4Rnc4S0J5U2ZhazYxWmJlOVVNc2M0SGMxM2JQVTZF?=
 =?utf-8?B?clkzeEZmN3EwWjRTakZ5SHF5ZUhQNWtOVzNhRlI5ZDVTM3pQNGdiUnRYWStN?=
 =?utf-8?B?Qlo4clh5bU1iaWlkSVlUTTZWY0V1czVwd1dsay95czJDaExWWlB6a2FuZWhB?=
 =?utf-8?B?K3lidkVraFBlNVU5U2xGelowNEFnWWM1ZEtlYjdpNlBuRjI0Wi9JMk1qMXBJ?=
 =?utf-8?B?cHFsUURkRnhmNysvWVBtUUI4bmk2cStQa2xSSHFFTWgwWUoybU9KVGttaTAx?=
 =?utf-8?B?dit4MktCYnEzN0doTWxsZ0JCU2Y5MFBEbTFvRncxb0FGT2JJRU5SaEJONVFh?=
 =?utf-8?B?ZHRIOGhubVBQQmdGNmlSOStFQk96dm4wNnpKQTNIczYyOERJSm84VVVWajJF?=
 =?utf-8?B?UzdCekJ4WmxqYnFmWHJtbTdFNG9kTHJsdzVBMFlGbGpuYmk1U3Z5Wm4wdzNi?=
 =?utf-8?B?b1lVMHZMa04vOWhkeVdrV3BWb0prTUV6MEo1b1E2TzZOcEQwc0JuSUdqaXNY?=
 =?utf-8?B?dnFmL3ZBYTZycTVBcDRxaDhySHJoZ0hkQWNiSmRlU0hlQ00vZ2RDTWpQVXJW?=
 =?utf-8?B?QnRTZEE5aG5Ta3FOZGN5anJjbWZQLytmSjBJUnFIb0NtRmdIaHovWlVkeG1D?=
 =?utf-8?B?Vk1MRWlVZjdmWnd6TXpQR2VHNTlFOFVMbjFvZUtFR0thdW95Y1QrNkZRNVly?=
 =?utf-8?B?Nm5CRmdCWm05ZjU1cVl5eE42Y3dmOHJjTEIvc0E0WGNVQ2xnZjIvZWlvUGl6?=
 =?utf-8?B?aXNwczFvUkVwZ0RiNVRRMEdxdEt6OUx4VVowQVNVVEhJcnZ3akJqZXZxT1p1?=
 =?utf-8?B?cUswamFiQTRENjBmSkF6b0lxODA3N0pvWm1XbU84R2NqQTd1RU1sSWM4eUI3?=
 =?utf-8?B?S0ZSbEtLRE9CbEtvQnNqb3IxNE5Ua2JWL2FyNkkwaVJtRXFKcUFSUDdLTTRq?=
 =?utf-8?B?a0FNbmsrTDlISGR0bm9wbnl3VnRURExlelRuYjZHZkVsMWtOZTZwREtYcVVr?=
 =?utf-8?B?ZkpsUzdTU0xwbGYrbDJMRGZ2bnZDOFJkZ0xyVmJLOStKYThBSk1PUHhyZWNv?=
 =?utf-8?B?N2tSTE1wYkpsOHhjWDNpYi9zdnBNbTRuRzNkd1BMRTY2QmdqeldLMG5uL0cr?=
 =?utf-8?B?ZDB4SHpSZGYzVGtWSXhsVUc4TDM2NUtiL1ZJNTk0dXAyd1V0RGVLUjdlNjFj?=
 =?utf-8?B?Qmc4cXNCcldvUFA3TWdQK2QxaVJETjJaQVFoLy9jYW9ick5DUkZmRG5UN2FK?=
 =?utf-8?B?ZEFOdzVYQTFWQmkwT2tTdm9PRkp5NENLYUU2eHBFWW9scitZMWl1a3hSQ2cv?=
 =?utf-8?B?RVpCaXhNMXp2ODcrM3hQdHgxcm5NYWZEMTkxenZrYnZBVVJHcjZFOE56VmE2?=
 =?utf-8?B?bjdENGJrdnVYdjlLUHdGRVlrQk0zZk9SRStVSnlnME0xa2ZSS21GUWh6a2Q5?=
 =?utf-8?B?b0JPejVaQS80VHJhWS85VmQ5MkoyYWprMHlPdHZTUndSNStCRkJ5UFdHc2ZR?=
 =?utf-8?B?U2p6V2xZR3I4b1R6ektzVHQyd1JKQ24zRUQyZDQrTzc5d29nK0M3UTVJdkNn?=
 =?utf-8?B?d3N1Y201UjFuRmlweGE5WnV5TzhDVzFRUElIZUZCNVNEWm5zRGM3T0N4cnNP?=
 =?utf-8?B?ZTF0VmZvcnhmVk14QTN1OGFYcG8xYjRMV1RTNUcwVXBIdGZ4a3doRTNhUDBU?=
 =?utf-8?B?M3FiQ3NRRWtzRXlqSTdoekhKN25tcVFVb0YzZ05MUnZsT1Ewb0t4NzhPTkdw?=
 =?utf-8?B?MStFai9YSWYxamJHdG1VWjQ3MzhSV24xQk4zTDU3a1VMTjN0SHdMMlE0bjV6?=
 =?utf-8?B?VzZZYVR3YnloWVA5NEVXaG4yVkZ4UjhteUtMS201SUpEY3JwcEh6aEZMUHVZ?=
 =?utf-8?B?Y0FGdERVZHgvQnNHK2E4Nm9CVHA3V1hreGNtczVqVDBaN25CWDdzcHFnZyt6?=
 =?utf-8?B?R3h1UXVGemJXUlB5Sk5pdFBLdTV2SEdLWnpNUDJCcnl2dGo0YUFmUCttTGtB?=
 =?utf-8?Q?0QQ7PtphOlYkTX2ujapFNizwf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c196635f-eb99-4292-d7aa-08dc84989281
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:16:41.0905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwkoL2iHb5rBB2OJD4/BiL4w0dW0jlrr1upKSRSRnMJQMSVD18H/YDMv+F3Fn5aqGNkgAP10FEvikqlmJHvrkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317

>>>> Events can be deleted and the entry can be NULL.
>>> Can you please also explain "how".
>> It looks like x86_pmu_stop() is clearing the bit in active_mask and setting the events entry to NULL (and doing it in the correct order) for the same events index that amd_pmu_enable_all() is trying to enable.
>>>
>>>> Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
>>>> This appears to be an AMD only issue.
>>>>
>>>> Syzkaller reported a GPF in amd_pmu_enable_all.
>>> Can you please provide a bug report link? Also, any reproducer?
>> The Syzkaller reproducer can be found in this link:
>> https://lore.kernel.org/netdev/CAMt6jhyec7-TSFpr3F+_ikjpu39WV3jnCBBGwpzpBrPx55w20g@mail.gmail.com/T/#u
>>>
>>>> @@ -760,7 +760,8 @@ static void amd_pmu_enable_all(int added)
>>>>           if (!test_bit(idx, cpuc->active_mask))
>>>>               continue;
>>>>   -        amd_pmu_enable_event(cpuc->events[idx]);
>>>> +        if (cpuc->events[idx])
>>>> +            amd_pmu_enable_event(cpuc->events[idx]);
>>> What if cpuc->events[idx] becomes NULL after if (cpuc->events[idx]) but
>>> before amd_pmu_enable_event(cpuc->events[idx])?
>> Good question, but the crash has not reproduced with the proposed fix in hours of testing. It usually reproduces within minutes without the fix.
> 
> Also, a similar fix is done in __intel_pmu_enable_all() in arch/x86/events/intel/core.c except that a WARN_ON_ONCE is done as well.
> See: https://elixir.bootlin.com/linux/v6.10-rc1/source/arch/x86/events/intel/core.c#L2256

There are subtle differences between Intel and AMD pmu implementation.
__intel_pmu_enable_all() enables all event with single WRMSR whereas
amd_pmu_enable_all() loops over each PMC and enables it individually.

The WARN_ON_ONCE() is important because it will warn about potential
sw bug somewhere else.

Thanks,
Ravi
