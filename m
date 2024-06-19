Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8761802E;
	Wed, 19 Jun 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811578; cv=fail; b=TIsZc/GEPOdbgWNmEFJCjvwYHzaO8fhCVkta0a8VIMWdBOWxnmCP/f0Oq9RD1ruUP8yvdrqWZiKt7s0nUKHHk+eIEimN9vYv7q4PmfP/NoEP6Wv3R/iGDo7otHRRQNqghDGYP15EWsRn1BeBE/poZ5ZCzpyLoUbUTYU769mMv1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811578; c=relaxed/simple;
	bh=c2DHLGIb/zhHwzSrMGMTzE1on99HlD/ESyiEZkZFtF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qUQpp319m90o+Pn9JR9PfkvbCFmzz/5SBDEM5n2L49lB/fRcDBe6ezeIV/NnrZzbTFixRVCv4PNmPOsW6qu9uMLvX7XNyOLqO23b4ejw4S1ppy6V/SkE74HKn+TuBwaBflX9iWmkv1IvgqAVzpIZiM2Erb00uJlo7tg9OI8/mwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Smdx+JDE; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Smdx+JDE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtIqq2wvV2OBghqC6XsVJaFa/t5Lk6PSX65RJOGIeYBt5mmFAYZEH5EjZ4daXJTxflOQqaHgmwl8By4I/rLi5TUmA6UoBvjHiIMASaLixD4p1U8UdEESZZAco4CakWzfoKqcjpdQOyr6XDJ1gtJEanC/5U6FIwlLwesZTz/H7ox7maWqRo7YEryy1Z8W9Ayhtm8aJZZnDG4uLIph82WyxUWDui3Cmv29Gtxxahi3a8NeQVy/gRPRuGmAsqnS7ssbdHrJFrKzQIiIo3MPPpSN+NvwBaK9yo3Ce1Kr4G5yROntWZNjme04zXVEc4BYfdQturObOua17DbLH65AJOYOxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45wpxSmLYMPs8D2jevrrzbe6p78f7FTDgKV9nyiaBsE=;
 b=W6l/fSqP6IrzO3ClYublK4cNKydSnAELmz19R6rLLPZkGhqNnXYRoETM8NjeL8W8nrZ3rGpJOtnGK0i7dRyY9qwFi6C3pClgDad7YS0DnROKyEqBRATQ9UsY76Kq4scgV6Kk81blZKSSqioaeJv4IQ8WD/kxWO65CV3maw6KqMNFYuRGA8h77U/w3P/vIe7RHoaUTuhSjt8ZXrTSP6ymL7LRcIT4v0QOilQ3FtI3Cgx3YZUtXGNes/Dh2LbVqs6yPiR2MZQzlJC/fjCPhzoVS3AHrlSYaRAk+yqc7aiOx9Az4xisgR1VdUr3pqV5QOpz4M9Ptip+fskD2t+11NeeLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45wpxSmLYMPs8D2jevrrzbe6p78f7FTDgKV9nyiaBsE=;
 b=Smdx+JDEHi2KoivlXgM9M7FiTz33bXOCCd1Wd3mw96DSbiftlSsBW+7PIbbFTsZ/JIZ5IdqYo+4aB69HirmxLDaJIoV7Ey//quWNCXoUutAEsTQ+dOm9+prS8ahwpoGC0ZtuaZ3emjm1lDRcDcaeWljFktN5QI0Z08MowlZ5568=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 15:39:34 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 15:39:34 +0000
Message-ID: <abbf2ec4-c25d-4cc8-8ec7-a86c8de8be7a@amd.com>
Date: Wed, 19 Jun 2024 21:09:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf doc: Add AMD IBS usage document
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, irogers@google.com, peterz@infradead.org,
 mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 yangjihong1@huawei.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, sandipan.das@amd.com,
 ananth.narayan@amd.com, santosh.shukla@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20240619092234.1165-1-ravi.bangoria@amd.com>
 <ZnLc9V9UHBFvuqRg@x1>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ZnLc9V9UHBFvuqRg@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::14) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: 037d2bf2-bf09-4902-6a61-08dc907604b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWR4ZytqMk5vQVg5Q1ZkOUY1dFRQSjBtL3h1T2o0OVlLK2g1bnluRG9xN1Bi?=
 =?utf-8?B?R3l4WjNuaTZmM3lTektVQlpBRytDcVBCK1l1OFYwSXhuRG1pZm5zaDVhbGZk?=
 =?utf-8?B?U05HbTB4anBvSjd0bFhJdFhhTVFDUFZrWFdYQ3pDYVIxcStUS2t3TzJydVYx?=
 =?utf-8?B?MGJKT1BKRXV1NEwraXZPZ0ZNUVA5WHJTZExMc1MxUndod0dqd3BaWGpkZ055?=
 =?utf-8?B?YUtEVUY3NVdvN1dtTUpIVlhIclIzSUpIWjRvcjR1QXI4RWJUZHpxdHgzOGlY?=
 =?utf-8?B?NSt0K1RaWkFwOUdmbU5aTU1CUjdLa2VSR2dUSlVPNlk0NEE5UnVIQW5DM0FM?=
 =?utf-8?B?TlViZWY4TE1lUEwxbW4wbllMdzRzcXhMRU1TTHlBVWVBUHo3VGtKZDhhTkx2?=
 =?utf-8?B?Z21sWm9TNzdWUEIwNVFiMDBJSU1kNGhicE9BSTFZcnE2RlNmKzNCb08xTjZU?=
 =?utf-8?B?N3gyZmxIVTNGa0loQWJzMjY2THVUYkNUZWZZcFNFSWVQYndHYTlCRXRwV0Vy?=
 =?utf-8?B?aFBieDN4eUVhVkJRNko4eDdUcTZjV29kRDh0OThlUzJoRnVUcTNyTU1iWUhj?=
 =?utf-8?B?cmxyL0dNS2lPY1JHWVZqcktYUWpuOTAzSkRpYUY0RDNjODNwMWZNelpmUVFj?=
 =?utf-8?B?Q3YzdlhheWVwZHlnOThocTlVTU1HaVpZZlNMU2NySi93dW16ZlppNG1XeWJ1?=
 =?utf-8?B?UTJFQW04MEVSZEpaWm4rSkNRVWErNGVqSFBVRnpLVFdFWkZBZTV0TVlmQ3RK?=
 =?utf-8?B?SUJTQXNFSHZRb3ZyMzJXYk53THRuOGdjSGtNSnhXY1UzdGowaXZRMUp5ZElR?=
 =?utf-8?B?UUt6RmkweDFjUHRrNjh2dGR2aTdGLzhMOW9lclphWituNkhodEh1aytzMEhN?=
 =?utf-8?B?c21DeENyK1Nob2ZVLzNZdkQrMTRKdVI2R0RqNmtTNmwrWWNKZjJYOWpDMVZY?=
 =?utf-8?B?cUNCT2gwNldwMis5V29EcE1GQ3NzQVRTRFVLY1dncnZtY09SZjZ4Lzc4Qm4v?=
 =?utf-8?B?dzdmRzBjUlNVSEt3RlUwVkdLVDBxcXJSSnpvUHMvRWZ0Q1Fub2ZTb1BnaW5u?=
 =?utf-8?B?OFMzWmE0bHh6L1FNS2xQWWowWWRROEZHOWtvTURRR1kxM05nSU5hb3lnbDRE?=
 =?utf-8?B?eGxsYVNtL0VRMk5DMFdmMWJZWUNrRkJoNFFPTG80MUVJdVVMM1VGa3dXT25a?=
 =?utf-8?B?WklLbkgxcTV2OEVrUFJUbXRuZDB1OGJZZFpaT05wU1Z4MVQ5YWEwZUxuc0Nt?=
 =?utf-8?B?bXR3RVpPaU1yOVdzVEhjMG4vYllldW4xdC9EYWFiaUNEYVR2YzN1MWRpZENq?=
 =?utf-8?B?ZmQ2bDMxNUJuVlFjeE5KK0JvNy91V0p5TWZCMnl3d3A4MGIxdnpTWlVmRjVw?=
 =?utf-8?B?c3ltMFJRQUZEa1FVVEpkWFFRdWZ5dGZGMFMrZkpUQzYyc0toTHBQdU83Y1hQ?=
 =?utf-8?B?Qkpvb0tJTmRHNkYxODRjTSt3MERaZUFucHNCd3hDRWhxZDNaYU9vNmlRVEpm?=
 =?utf-8?B?Z1ZJVnlTTHpsUHJwenJXUnBzRG95bWZYWlR4L2RTNnhBOS9xWEFSZzR1OTJI?=
 =?utf-8?B?dHptR0wvSW1Ea1llbGZNbDhIQnVPMG5KSi9CVVlXbkZobGVERkw4b2ZLNDQ4?=
 =?utf-8?B?Q3dJcXlCVkZQa0o0N3hzeENVTXdiUXptUit5TnlxSFU1S2Q5WENHcVN6UjVp?=
 =?utf-8?B?d1BZOWhGRXp3Ujg2QWtMTmVMYWE4NEV2Q3JuYkIwOWFwVHNEN0hoMFRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3Rtak5TR1BsaEE2VVIzeHkwZjBrNXRwUVBxWkFpM3p5Q0xsMldQckIrYlBI?=
 =?utf-8?B?amFhbWxJRkZlZ1loQ0VlakR6Q1A5U252bUNLWmdlY210OE94RkNkaTUvZUFp?=
 =?utf-8?B?alBjcXlaOEtRLzY1YUhaYXpJZnZWMHU4R05tVkd5ZGQ5OXFUZksyRVVFdkNX?=
 =?utf-8?B?cmtYeFRuTXdhbk9nVXQwcUFJcCtmV0hqaFdKd1BWcENmQUNDWDQvaGd6MmVY?=
 =?utf-8?B?dTd1aFhwUk1xbnZJN3BhVjNKeVk0b2dmSWFvTTVrUTU2ekQwVUNsSUdCVlhH?=
 =?utf-8?B?U1dtZUU1WFI1RWs1TXZBMGc5VXRtTzNhMkM4K2k2RjhPN21GemdnWksybVRO?=
 =?utf-8?B?L2FKbk44bHpheTYxRm1iMWVRS0o1TU1tM2JUOUNwSXZBWGN3QmUvdHo3OURr?=
 =?utf-8?B?NHFnZHlCUCs3WTBJRWV5V0pVaUxBekNpQ0dWc3EzUkU5eGRMcmF5QlUzNFB1?=
 =?utf-8?B?dEprOWtibnpzTnhIWDQydVpQZGc1YndSdlR3UytzaS8zYmc0N0NwWHhhc1JN?=
 =?utf-8?B?NUZUTGY2TDl2Vlc2UVhLcElpVzZLSnM0ZmZza3U3cnFTSFprSUlEQlVzY3dC?=
 =?utf-8?B?T0hma1RScmRySFRwSE5DK3h5UFZwaTRLWjV3ZVlPV1BZZFllZGNHL21wd0Rv?=
 =?utf-8?B?VXo5aXZYSG5xYkliWVFoRjdZNmx2dFRjakdOQktBRFNjLytSMnRZcHFEdVR4?=
 =?utf-8?B?OU9FcHF0bFZ3ZHdtTVBQdHlBd1hLbVJMUXQ3T0pLc2t1S3JDMFppUzhKZENB?=
 =?utf-8?B?R05POTJTQ3NwVXFCbzRNZVJuUzJaQTFZYXFKOWNXQzNjdEpHam95UUFhY0JF?=
 =?utf-8?B?NkRYb04waHdITGJhUzd5b0Jwd2JKS2NFTGxGUnN6dThyS3BrUmhLckJYRkY4?=
 =?utf-8?B?VWZ5cXJNek9OWVB5b1phVEIwRTJoWlVodVBiTVV5MVZ4dzVmWTJ4UVYxOThm?=
 =?utf-8?B?Z2tRUzh0KzJ6ZWF0Z3RsSXFoUWQweG1lSjRiaWxaeExXR2lzakliQUNaR2dV?=
 =?utf-8?B?c2wra2dqOXZmY3cvV1ExZzZNTEg0b3k1OFNyRWNlTHlsK2hNaHBzY1FLcDlU?=
 =?utf-8?B?eWV6OUpjdGtac01RMGZ3REZDTkYvbHM0TDE5REJLdENBaVIxWXRTQ01CNWVr?=
 =?utf-8?B?TUdGejhldGZsc2tNZkprQmJFdVRuMXIwcU02NjFkVTMyZnRGVFA2QmFvOWlC?=
 =?utf-8?B?NnlVQ1h5bHRsRVdGdGtLa0s2ZVJXaUlIT1JDVklmYVBBRnozbXgwYWtOYTJ6?=
 =?utf-8?B?N2x4QS9WOUlJTTVwSk1rUTEzWjdLdEJ1QlAvRkNuY1R0cHZ5a1YrMUZyWS9q?=
 =?utf-8?B?amQyaTdCODJGT3pvUjRUU21jM3VJZDYyczNZK3liYkZMSTJ3OFVjd1htN2t4?=
 =?utf-8?B?U0hTTEpGVFg2TXNPc3JLVHRqZlpNN1g1MjNVRWt5R1E1YjZaaU0zYVJyUGVM?=
 =?utf-8?B?TnFRMnJqcFMzZDNxNm9aRGRDKytFL0xtOU5aRnVYZEFtd1pBMTRwZkZKWWY2?=
 =?utf-8?B?WElHVlRSNmJKYWdIMkJ0T1orNjlyQ1VzYm5VV1ZyWGFFOHRUbUVxdFBCS2lu?=
 =?utf-8?B?YW9ldk9SMXJzYXVQSUM3K2I4c3R1TXd6V2pVNldPWkFVbFVoTnMwaUpXUjdr?=
 =?utf-8?B?V2JITXFCYm5uMkdEZ1AxYTF4TFVPanh1VVZMVWNiNnZUV3RMUlJjWWdQRUkx?=
 =?utf-8?B?dkVtVm1OczBKSERtODloNllIenZWQVQ1MS9lL202bExDRXo4bnJpNCtrVURt?=
 =?utf-8?B?S0o1QWhBekxEZEhSeUd5TlJBTXp6VWV2dkFUajRZRXlGcEZKRHhmMGNRZUk2?=
 =?utf-8?B?L1dpRWlScm83UmlDMnYxaHova0drL2J6TDU4VFFSdHk5d3J3RHZjSVhNWFVy?=
 =?utf-8?B?dUJQU0JjZTByVGZmSEhqaVdHVUdkM3duczBJQkFGRDRhU3dpbCtqbG1rZDRa?=
 =?utf-8?B?dlRmVlJQakM2N3NMeFhDb05TUEF0alF2T1VIdDI4bWtPY29DYkxTSkVQdTlz?=
 =?utf-8?B?VDhHZnVFSWJRanMxbit5dndrOWxBdFVUVXlMTzdiNDFrNHpKMlVxTkpJd3V0?=
 =?utf-8?B?SUIvZFUwUkpReU1tQzhRSU9YK21CYkFEVm02ZkZ2WitBQ0NKdGJmMFVTWWVJ?=
 =?utf-8?Q?0iy6j+AVTYq2gGWYLl+XY7RI7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037d2bf2-bf09-4902-6a61-08dc907604b0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:39:34.0144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KXwwgU/GePSf+QWIOHBbyaWS+NNCMEEK8yToe6oaI3YOKd6UkLKgsMAlxj6zTvfO07MqGY01BgVA0ZuJQ7gJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031

> IIRC if one does:
> 
>    perf record -e cycles:P
> 
> on AMD systems it maps it to 
> 
>    ibs_op//
> 
> No?

Correct. man perf-list already covers that under event modifier section
but will add brief detail here as well.

> I don't have access right now to my 5950X, so its from memory, about
> "IBS invocation from core PMUs with precise_ip set"
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=78075d947534013b4575687d19ebcbbb6d3addcd
> 
> One other thing to mention is 'perf mem record' that will use ibs_op//
> as we can see in the cover letter for this perf-tools merge commit
> upstream:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9d64bf433c53cab2f48a3fff7a1f2a696bc5229a
> 
>          # perf mem record -a --filter 'mem_op == load || mem_op == store, ip > 0x8000000000000000'
>          ^C[ perf record: Woken up 1 times to write data ]
>          [ perf record: Captured and wrote 2.199 MB perf.data (2913 samples) ]
>          #
>          # ls -la perf.data
>          -rw-------. 1 root root 2346486 Jan  9 18:36 perf.data
>          # perf evlist
>          ibs_op//
>          dummy:u
>          # perf evlist -v
>          ibs_op//: type: 11, size: 136, config: 0, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT, read_format: ID, disabled: 1, inherit: 1, freq: 1, sample_id_all: 1
> 
> Another examples available in the merge commit of when ibs_op support
> was added to 'perf c2c' and 'perf mem':

Correct. Will add brief detail about perf mem and c2c here.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d465bff130bf4ca17b6980abe51164ace1e0cba4
> 
> Showing how you can use 'perf report -D' to extract info about these
> samples should be interesting as well:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0429796e45ec17eee26d7a59de92271c275d7666
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=291dcb98d7ee5cd719f4c5991d977794b1829c16

Sure. Will add that in the example below.

>> +To go over each sample
>> +
>> +	$ sudo perf script
> 
> Here I think it would be to have an example of such output.

This would be a normal perf script output but raw dump contains IBS
specific raw values. I'll add a sample output in below command.

>> +Raw dump of IBS registers when profiled with --raw-samples
>> +
>> +	$ sudo perf report -D
>> +	/* Look for PERF_RECORD_SAMPLE */
> 
> Ditto

...

>> +SEE ALSO
>> +--------
>> +
>> +linkperf:perf-record[1], linkperf:perf-script[1], linkperf:perf-report[1]
> 
> perf-mem, perf-c2c

Ack.

Thanks for the review,
Ravi
