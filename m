Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E464286438;
	Tue, 30 Sep 2025 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759214413; cv=fail; b=aUjvRjWPvsbQP83KzcK8iCrEH8UngztQDLcXvGPBlDXJdQVV5ijQ9EY804ti6OEEiN8MsY3h8Rf5MG1uJ38C1NuRYI/BRFxqmRzc2Pu9Hvp1vWXolob2nB/CUTI4lejTGvWRJo+VgXhkMMC5O1AbIXb4wgkwfRMcIpBYYvR8F8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759214413; c=relaxed/simple;
	bh=oL3NqLnErGs8Qpcfop/fHCMiTO46D5Gt9CXmCjPC3UQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BwydWcT4ENxobZSIv0bCvL9E1QnTK2cz8JJoJvmY7neMSqqVa2xYbJYCgGA8GPmxcIMqThLqFZsJI5KGyOOEUhu8UljHYhrkewK2RCeCu7jm7FMxIzjVCATq3yTCiXfeG1TPWH+laHf+SG/LlHd0rQL/8dTPELZCAPuMaeIm/W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aI+1vC9X; arc=fail smtp.client-ip=52.101.56.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aI+1vC9X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMXkKBJt3mS5J9YXHdhIe1BaU6dM1xYP/h7fnDD23au4mld/iox7n/DKk1u/6jyfsi5DXMLsaHcA4c2qlHgcr9Uy/DB2Ig7gS+Q46UycmNHKUiyx7WJOd67AyMLHaTfX3zA1giQfd+esN29SnTDYEFxxlmx/37O6fph9sVqWAbNmGM0hjaoqB4UrocCYOV2ciX4QneMV/9HynwL3TlcdvDFJ+pUDnU8JkVzfdyROrt7ZFXGcQimXTgX+w2EkoDobrrwgYfaCE8X+Jss4QJOY3/9t/Y6YtKd3h8QNAW7uJ42PcYu8XgjsBfX//i48Txxh5qCuv6CWtlrYUAtNkSJ+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBHxS1Mt5tEGZFAFGNVlUUKjGnsNE55QeIllO+EH4MA=;
 b=pkrHZK1nGJTEL+f6V7nmxVi4SAVR9VMLXTpAjxOBPNcpoibMdOX/kz3Ub6WImv6QhVjMyEBNpG2o3kqVMT2drquvJY5AEah+2yEzZIsebJskwT66Jddh4IytcnxJTUfaK1DucXd6M5pPlZxKj11/RrFAdzO99QEs13NdxcBto0y2xFYigB/npv3Fo+7tiWQx2EKn6baeRyzZ2ayzq1mCW2UH4CBIvg5oRzuEvvIN8/8C8bevOBON9KAMJZzVU91qCLwi31d8nT1ExteKDvNGzXc8eijhSHPdUpJ4KRSazMgh63NF8uK/ZYIegPIU+1jPOUMtxoG5Jl6AYZFmN3VRHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBHxS1Mt5tEGZFAFGNVlUUKjGnsNE55QeIllO+EH4MA=;
 b=aI+1vC9X32qVk4haiyhZQKke642PddbYmJohWv+MzWveSnH/5Lmh8/SUwUcaBPqvJFu+vO9r8wvXBwTi3mqpCyC9ViZhXC2r3WFSZc2Pvdl8wc6N6DVYH7ioEMpjYXS90sf9qwURmSLjz1a4YhQQDVTzQkVyQY53fshguzGqwo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13)
 by IA4PR12MB9812.namprd12.prod.outlook.com (2603:10b6:208:55b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 06:40:09 +0000
Received: from IA0PR12MB8301.namprd12.prod.outlook.com
 ([fe80::e929:57f5:f4db:5823]) by IA0PR12MB8301.namprd12.prod.outlook.com
 ([fe80::e929:57f5:f4db:5823%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 06:40:09 +0000
Message-ID: <fd09a708-bc70-4a49-a6c4-860f93ff8b4a@amd.com>
Date: Tue, 30 Sep 2025 12:10:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools headers: Sync x86 cpufeatures and arm64 cputype
 headers
From: "Garg, Shivank" <shivankg@amd.com>
To: Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, acme@redhat.com, namhyung@kernel.org,
 yangyicong@hisilicon.com, bp@alien8.de, mingo@kernel.org, xin@zytor.com,
 yosry.ahmed@linux.dev
References: <20250929061644.19188-2-shivankg@amd.com>
 <20250929082733.GH7985@e132581.arm.com>
 <2797b8f2-fc56-41a6-8ab3-dd298fd3ea36@amd.com>
Content-Language: en-US
In-Reply-To: <2797b8f2-fc56-41a6-8ab3-dd298fd3ea36@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::22) To IA0PR12MB8301.namprd12.prod.outlook.com
 (2603:10b6:208:40b::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8301:EE_|IA4PR12MB9812:EE_
X-MS-Office365-Filtering-Correlation-Id: 943a8b7b-3ff9-49bb-868c-08ddffec32ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2pkbkpuN0p6RTZoKzM0VmoydzJVdjlJVnBkNXFaS3lVeTV1WlpDV29aZjVo?=
 =?utf-8?B?Y1FvakRtMkVIeXFra0drVkJ1UFRBc1lDK3dHVzE0eHpBWUQ5SXdMcGpxS3U0?=
 =?utf-8?B?SzdXYjNnbm84RXl0dUUzcklPT3JMYWJTK2g4QzRDVVdiMmQxTUZTMnZ1b2Vu?=
 =?utf-8?B?bVE3NExqSzZCeDlnVFQrTFJSczA3ZFRxb3Q1anlCNk03UEFtNVExTVpEMFJt?=
 =?utf-8?B?bkFpQ0x6TUNscnc2RmVmaHZOOGFmR2FsMmdwc3JlVjBPbjB3SEhvNnQxNHFV?=
 =?utf-8?B?b0FqUldqWCt5TzY5VE11bTBJd2c4UVVKa1BLMDZZTUdHVU1CSFZ1U1Mvd3A1?=
 =?utf-8?B?THVGRUg3Rmo3ekFveGtPSEJLY05LQ2czdzRuSEVEVFNJNVpOSThrbmFFOWN1?=
 =?utf-8?B?U3RGUEJuVUVMQ251SFp1UXgremJxZFVQMHFuZGRJQnFWRW9McjVuR1FFbDFN?=
 =?utf-8?B?cmRDVjFMSkh6S2ZNUDdTelhWUWlaRmZ3TTZBMUF1Uld1dVcwM0E2c3RVUW85?=
 =?utf-8?B?T1R3NmFLK3B4dUJEc2lqa0VLNDVLRU5mV1JsT21FTVFpK3BoWFdqb1AzSUVM?=
 =?utf-8?B?a2c5dURFci9rVmsxakl5NVc0T1JxWFM0RGh6WVpwWGI1RFB0TWhzNU5qWHJt?=
 =?utf-8?B?NE9RblNYamx0aWtWYnkydkNQYVNSYW1ZTUE3N0pSU0FpOUJCNzNDdlV3OVBZ?=
 =?utf-8?B?SzZWR2UzbFp0Y3pVU3RhK2xQWEVZYzNYcjYxMCtSVUF5SlFDMGg2UDJKU09m?=
 =?utf-8?B?U3FsWjdWaWRCQ0JDMDBvaFBveit5eTBCOVpiU0htdEJoNDNsWlpkZVNSNzc5?=
 =?utf-8?B?ODQzUkhpUThpU1l5Q0tKenk0SVdMNlRSbDFiNDQ3R1h2OU56MEdIcjNhOFFK?=
 =?utf-8?B?QVhydE0zOGxCdnROMjRWMHhoMzVFZzFpTUlsMzRUVUdsZDlVUFg3RUdWQVQ3?=
 =?utf-8?B?MlYzOVREb1lYM3ZSQ2VScG00M3JCem90ZWhuWkI4SUp0dGJOcHh5ZlFlMFlO?=
 =?utf-8?B?ZzVXcXBVeVQvUEdRZVd4N2RqMGF5QVVJazdhM1JpdlNIWjRNSWtoZzRxTW1U?=
 =?utf-8?B?Z1FIZkxNTTF5ZG8vNzVxQU5Fb09JeXJ6R2NnOGx5bDNQdVM5ZDQyRnFZRUFp?=
 =?utf-8?B?WFh6a24rUnFyZ1dabHpZbC83NnlvSGliZnN6RW1mdHBJbXRUOFFkc2tmTm1Q?=
 =?utf-8?B?NVVTZUVVSnNtRllnUHFFWjBBaUFKK3NmSDlPMExKbUIvWHN5UUMweVUzVE5w?=
 =?utf-8?B?cGpDWXA4enl0NkpWSS8xUXdpdFk3VFZqVHB1ZTVGL2Q0VEUzbHV1cE9FOWRm?=
 =?utf-8?B?cmZYN1VnaVNMQ202L1JQRHB4OEFnb1RUUVlYNXd2TC94a29UTjVNdG5TSnhi?=
 =?utf-8?B?MU9OREZsc3RuTTlUMnNrVjVSTkQxeVFUVFE5Q1pIV0xlVElFNTFsc3dySUQr?=
 =?utf-8?B?ZnVJUXR0MHNobzBteHp4cjZNbnVSOFBmQ01DK0ltUVZYdjRDWDI5RnRISDUy?=
 =?utf-8?B?TG5MMUNBS284ZUxCWlpVTWZNQUk2R2RZMUs3clgzZE5ueTQyVnZ4UHovRTJh?=
 =?utf-8?B?cGZaNENWWHFITFdLc3JNVG9oMmRCL3BlR20vSnQxQVozUWtaR3RWbEU3TFZZ?=
 =?utf-8?B?Ymt5bXJIL3MxTkpxdmpZaUM5RWREdkJJS2F5WGlEQ3VhTDZPSllkeTlBcTJa?=
 =?utf-8?B?YVAyRVhZTTJOcENkeGRLeFhrRVpjRllFTFR2RnRiK1Z1dXZRNGg5WVJVZGV2?=
 =?utf-8?B?K3RsTFBMY0lIQndxZnFnSkpXTzRXTnM1QkxXemQvRUdVOGxaWENObXdWbnFt?=
 =?utf-8?B?MVA2Q0Y1NytIM3BnNzM4Sm5LRXpjQXhoZ0x0d0NaOUp6TUxZaVBjVXJLdjJP?=
 =?utf-8?B?WWp3ZWNqVlhrdUdyL0lxSURSak9NS1EzV3lwUzJRaXY3SzhGUnp4NVU1OU9x?=
 =?utf-8?Q?qnYGNh3QZY1duothtHe/1NXHyS5g+puJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8301.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnFRU2t5YkpucGJvczAxSE1HeWx3YkdKVWhQLzR2bHJoSlVRRFkvS1B3S1dJ?=
 =?utf-8?B?S0c1Q2I0TE9GUHJRTnU4MnFyeU8rR2hERU4yMFBVTXdGUFV2cVh6ODgrQzMr?=
 =?utf-8?B?K3pkSk8vTDlJVEIvbjJMSnh5Q0cyYy94MWF4czNVaVFhck5hcHNsOEVZbG5E?=
 =?utf-8?B?VkZhYkluU2JON3RqYmJYby94Vkc2SGZBOHc2ZDgzL2F5LzhBcTFoYUNWdjl3?=
 =?utf-8?B?WGFkWHdvSEp2ZkhYdElna29HSGJjcEVmeHFxMFd5aS9IRGgrSHViaW8vcHRD?=
 =?utf-8?B?WTBGQTlScHp0c00yVnpOblV6SzFRb3dzbnBoRUpWdUh4ZE9rUXd5dXVVSmxk?=
 =?utf-8?B?TGI4WWhOdXc2SnZTM2xaeEM4UDZRVkJ1dUcyc3ljb1hieXNMRFltci9sK0M4?=
 =?utf-8?B?RFR4Z3hBRlRtVmc4NEhvb0h6VDd5Z0ppREU2dHNNZUt2MnhwQWVsNU5vcTRP?=
 =?utf-8?B?TUk4VURhb0l0eUlobDlvMG5xL1ZieW9jblFjSHpBQnBMYUNaMmE5Q2QyWVZY?=
 =?utf-8?B?TGJFZEdFMUs1alRGS251Ymw4cEVtL2g4TmhiZVpRcTZsei8wSkpqSGlESVlj?=
 =?utf-8?B?QTNvTXJJRHBYbE5JT2I5RHBoSWxvZTlBdUJVaE9PVHNBTExVZnpIcFAwWmdy?=
 =?utf-8?B?M3E4UENUdWxqOFRuSExTVFE0Q1R2SGRGTmdWRlJMNDYyNmlNL3BsNmFRWDlT?=
 =?utf-8?B?QWlNelo2UUVUVUttd09kT21kUUNCcy9OS2NSRjNJU3QxcU1ZS2tjNjQ2UmZE?=
 =?utf-8?B?ZjZtUGN2R0Y0ekplYm1BT0U4ZWhUZW8xdzhsQkJ6KytqaXJ2RndSQksvb0pJ?=
 =?utf-8?B?c3dWTVFXV2xhdGNWa0VmUUwyYjFQS0RlT05VWVJyR0tqWXFpS0phRVFCOHFL?=
 =?utf-8?B?dGtGZHFPYktzMGR1emRVaXo3RDVPdEpQbjA2b0F6T2ZRa29pNllFbzZ4RkNm?=
 =?utf-8?B?aWtBajVDSExBcEU4YkpnQkd4cy90UTRkTE5Ybk1FZEcybHpLUkFGWDdBUFdS?=
 =?utf-8?B?Vm1tUUVwYWppejhpUXhCQ3RPM2V0QkVQV05WOHZJeUkrY2NVVUpaSExBeERn?=
 =?utf-8?B?Ym5aVkhCU1FHNkt1c2JXazcvV2VKYlllbHN6aSt6clpreHNTK2ZIanJOcExR?=
 =?utf-8?B?VFNPUVkrU2EwUmJyUTZEeGw3SjdabnFqNUpBRE84OTlKbVlyVnp4ZVhEc29Z?=
 =?utf-8?B?a0c1VU5MVWwySjk0RVJsbEE4SUlvZjczRmpUZWE0amppWUlEL1VUMmRQTm5L?=
 =?utf-8?B?cUt4cUx3SnEzY0NRR0JOVTU0ZU00WHQxMlBUQThJVzd1aXljcGg2ZDNMRSt0?=
 =?utf-8?B?K0FXK1NrR0NjR3RJT2R6Q2ZBT2tGa0dhYVhhaXVJSGpNUFI5bjRsK2FqS3V4?=
 =?utf-8?B?ZlhvQklLZDNMWEtOUUlGMmxxb2h4NVFFamlVQ0g4WklUVERJRll3Zi95TUx1?=
 =?utf-8?B?MnpPZ2lIbUZaZmNrN09sb1R1Ukt4elF2K01MclBKYjhsbDdFb0RkemxwNnRS?=
 =?utf-8?B?OFNyNk9xUnJ6ZzB3a09neTFvcUVCNDZpYTIxOEpVSkc5TUpjbzVVd1h4ekQ3?=
 =?utf-8?B?Wm15aGpFVzVPaWdtUHluQ1VWN01valI5SzNuTGkxYWhGWWg4aUlBM1pzNWMw?=
 =?utf-8?B?ZGhiZVZGSTIvNXJHWHpHbmRZaWwzeGp6a1hYSXExakc4MnN5RElOalBzZUdx?=
 =?utf-8?B?NkxMVDZBWk04eWJ6MCtqb3ZRS1lGdEs2b20zTHVDdTdCa3VZVDQwc3VEYnZj?=
 =?utf-8?B?eW9xeU1nQnk1RHZhOTBWRThjWE95L2MrYSt3NWs2a3VJUDN1MTI1bmt5cmUw?=
 =?utf-8?B?RVo2ZjM2eFBtR0hJUmlxaThCQy9mbnJYanNBVWkzenM4Z20ybkZOK0g4MW1Z?=
 =?utf-8?B?bEtJZGxYYmpoU1lxdEl1RVdQSTVJVW9WWGRIaTVzRFEwZVBWZy9HaGgyaURC?=
 =?utf-8?B?blRyQy9rV0xLaHY3VG0vTTlHaGtIYzhUaWtteTNqMGRZRVFoUWkrRVVjeDlG?=
 =?utf-8?B?bDF6NStNUEdKWEthOGMrOG1SR3lld1JiamlrTmlRbXAyNDBGQ3BKQW9JR3d1?=
 =?utf-8?B?TTlaMW9yY1JuRmpBQXRBc3ZIL0tjaThsREZJc2w0R01HRTdaTHpCb3V6MlV0?=
 =?utf-8?Q?U91Ft/AMid5T4mALluwCyGq3q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943a8b7b-3ff9-49bb-868c-08ddffec32ad
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 06:40:09.4471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcS5P88ykEuDN/lxKlzXVv9K+PNUZ/HEgayX20PBilWTlIRdG1BMWPwwy/qdZgSz6JlFsCvf8TY5RuN3KsBzFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9812



On 9/29/2025 2:47 PM, Garg, Shivank wrote:
> 
> 
> On 9/29/2025 1:57 PM, Leo Yan wrote:
>> Hi Shivank,
>>
>> [ + James, perf-user ML ]
>>
>> On Mon, Sep 29, 2025 at 06:16:45AM +0000, Shivank Garg wrote:
>>> To pick up the changes in this cset:
>>>
>>> commit 2f8f173413f1 ("x86/vmscape: Add conditional IBPB mitigation")
>>> commit a508cec6e521 ("x86/vmscape: Enumerate VMSCAPE bug")
>>> commit c8c2647e69be ("arm64: Make  _midr_in_range_list() an exported function")
>>> commit e3121298c7fc ("arm64: Modify _midr_range() functions to read MIDR/REVIDR internally")
>>>
>>> This addresses these perf build warnings:
>>> tools/perf$ ./check-headers.sh
>>> Warning: Kernel ABI header differences:
>>>   diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures
>>>   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
>>
>> Please drop arm64 related syncing, otherwise, it will break perf
>> building.
> 
> Sure, I'll send V2 without arm64 sync.
> 
> Thanks,
> Shivank
>>
>> At the meantime, James is working on refactoring cpu type definitions
>> for Arm64, we expect to avoid syncing cputype.h.
>>
>> Thanks,
>> Leo
> 

tools/perf$ make
  BUILD:   Doing 'make -j128' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/include/linux/cfi_types.h include/linux/cfi_types.h
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
  diff -u tools/include/asm-generic/bitops/__fls.h include/asm-generic/bitops/__fls.h
  diff -u tools/include/asm-generic/bitops/fls.h include/asm-generic/bitops/fls.h
  diff -u tools/include/asm-generic/bitops/fls64.h include/asm-generic/bitops/fls64.h
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
  diff -u tools/perf/trace/beauty/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h
  diff -u tools/perf/trace/beauty/include/uapi/linux/fs.h include/uapi/linux/fs.h

There are a lot of new ABI differences today, so I think it’s best to sync after the merge window?

Thanks,
Shivank
