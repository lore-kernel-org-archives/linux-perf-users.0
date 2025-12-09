Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB108281376
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265196; cv=fail; b=GMDhEErrG1CAykwNQ430AB6ifmv0g6Fgm5H4RG5rMB2d2KdpCLLo9apK7ZQy2WhpqDpqcGPfDYD8zy49SqaU7L46AaKvyBr1qY4xLgufWb9qV9yKDwiL+oStThOpPBORbzV93X32CHuPl4bLujCF241ahfoeKMLX7oTaSGLZ9M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265196; c=relaxed/simple;
	bh=ewyVq515Il+m+dGeLttEPHOqQixUr+YvfjrGqdVEp0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WLcjNWYSBmEFI+w5zJ5H0PGlUzVXj8LdRf/mTKEnluu+Q+Gx21rTRxM3MoxZV5QwUguRUc0NHrcHXCJu7x6ZhcpaHZNs1jzs5UxzpY8lj7lHT2ixxVdIDn0Tlpr/BHNiBTwrz4kIbUw7YR64ML+Fdv9fCw2Vm/voWDG00Wb4vOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bGsMMNcW; arc=fail smtp.client-ip=52.101.48.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bGsMMNcW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uM5rGD6ifda07afqip6V51Rlb4Cfy5TzvDVOexA8iRJfOXEUy+xvQD+BuUD7Y475g/sHUPvnluPkjdDjVGBQ/Rfd92f1rVbDRAH+iDEUZjL1lxB9qv9as/7FMUI4J9kaU6I65YSuMXp5hVVoEzHcdJCqh+2G63OS9Zx0bo6Odxx1fiHzieslaE8n/M4pPXj6VB/hsGEKo/I8QbAwcZs1Ll5WZLvve5kUYW6M32W9TCguF8nLygCBRg33pauoxwvlVMGlvC/UF8sw548Ysz4VqnkxdX6kD3VvKX3F2b9WbqeUAAVEQ4NH4nOnhp5madjnVueW5xeLzJT1xvAXScyZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cwd7Ihn1Sax2i90iJdyQmSSrJwPEO8DLCBcKaaAnHe0=;
 b=BXoW/NT99yBW1t7W+msE13bBTYvgWXI0BSkKyw4GTTQXll2+oFXdahvse0Lt4Yvn/o338maet37ehHDkevej4Z+CCgeJDI4A0OCQJWzOtqR+vrF/xWavIsbOn8eFXtlMhIPlAbYIEkrmj9jXbTeb8u15KXtKmDxdJcNrcvSPNJpGkFM2c18lQiDEe1hlDtKpfqdBbZ7FRYyESopEDlgat09JJwCfTl44WMOq6AFHOGuWHguBErM9+iAI7jGik4vcHmMa0lyTVx1/JEmasNlbyMDN5z2H10Vbacfztumhn+0/3zXXt8nOQdPTheVADJIQyESDzVsDKUrl1kPd7UUgHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cwd7Ihn1Sax2i90iJdyQmSSrJwPEO8DLCBcKaaAnHe0=;
 b=bGsMMNcWcjtZ+SuF/VBrxw3ZCzCXhu0SNbms+E0iKPRdK4yC2wonk/Eh9hDqZzX5LvnjfYbL3qxG4hMmjax2nwVZa4sqpgP+vV0+5X7JYGH7mvHNgwxIiyuL9f2vi/I4Ww8QBqshekLprWyj1vzBN1xJj/TCtzpf6M4l+nboAEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by PH8PR12MB6795.namprd12.prod.outlook.com (2603:10b6:510:1c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 07:26:32 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 07:26:32 +0000
Message-ID: <0e64db3d-042d-4066-a04d-68e1dd573b5b@amd.com>
Date: Tue, 9 Dec 2025 12:56:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] perf/x86/amd/uncore: Refactor uncore management
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-perf-users@vger.kernel.org
References: <aTaI0ci3vZ44lmBn@stanley.mountain>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <aTaI0ci3vZ44lmBn@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::13) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|PH8PR12MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f20bd6-e6b5-4ff0-994e-08de36f446b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2N0ZWpyZSs0QVBEa3RBV0RPOHNPV24wMnJEYk9iSXVBUithYlN3Z3JSVjBY?=
 =?utf-8?B?djFGRVltQnpVcnlnWjNJNkNFdlRyVnpibUpXc25EbllFNEgzT0k4K1M0YXNM?=
 =?utf-8?B?ZGVwUm83MHV2WnlQQm9XNStETWhYR0UreFJLbWRiR1c4WDhRMk83WXZpb0ZT?=
 =?utf-8?B?WDhDNjlLYmR6alhhekdCcjk3Sko2TUJmZUcraEZxNkVmaldQKzVtc2x6VGJJ?=
 =?utf-8?B?REZuYjhzYWUrRURWUFlrNE1XVFVzTERmUVRvbmg3Tyt5bTF2ZGlMTmJOUWdj?=
 =?utf-8?B?a3N4RGo3QVBmTTRsU2pvVDNibGJDS0xSTzNRZS8rN2JyNGE3T0hLRzV0bWFx?=
 =?utf-8?B?dTd5RnV3NUpUQ2FSMlUzWjc5Z0dKeDc1YW9UV0dpdEQwV1FoVERFZ3F3RTdp?=
 =?utf-8?B?T1JtQW1vb0lPOTZiL0VyeFo0ek1FK1lYYlo4R3J2Z0F5bk8relhvajI0c21u?=
 =?utf-8?B?d3VnbkpYbjE5Qk0zSWsrLzdRa2IvZUhjTEZNTDVwU2R1aU1VdXhTM1JnMUI0?=
 =?utf-8?B?V2RnRnJpeXQyaUc3R0xrZHdlWWpPUVZ1RlhDR2hsd1lJOWdoeC92Rm1OWEx5?=
 =?utf-8?B?Z2xuNXg0NUJ4WDRJMGZXRXJGWDhjSklSaDBwY25oZWs1S29raDBaNE5OTE9r?=
 =?utf-8?B?MFJzU2NGTklBNkVObmlNczMybkJOQ2h2NjZHRUJQb0I5SnRxTHpKaEt1a0Z6?=
 =?utf-8?B?QkwvZDd2KzNIaHF4MXJzcWl4RWtyalgwMi9tdDFJMXJrLzRqRU5Rb0NuUFNa?=
 =?utf-8?B?Y1gvcGlKNll1aTN4a3FPdkkwYzZYVnVKd2VoTE81b0lrQ3loMXJmUGMrQmxj?=
 =?utf-8?B?ZktVUjNJeXlJUCtaRVhYMkh4WFhNcW91TktSK0xqcW02bzJWMExxRjFwTG1z?=
 =?utf-8?B?RG4ya1duRUVEWkpjU1UvTXl5ZHluR3dHcU9wYStIUHJQaUUvVnhUR3A3QkVj?=
 =?utf-8?B?ak5sOXFUTlVoMHE3WTRYTjRHcnZmSkRTQ0NrSi9EWkRqRDhuSm02QXhSN0NJ?=
 =?utf-8?B?SjNHR1pQb1NvSDdkbHJkOUhublFBMTVvbk02QVRvb1ZKSmtrL3dFZkgvc3Yy?=
 =?utf-8?B?UXhxRDcwZ0RVVWIwV2h3dTJGTlJnZ3dSY2NMdFhKQXRCL0FvK2IzWkxNVGIy?=
 =?utf-8?B?Wm43NFhzOEJ6b2xUUEV4Wnhnd0w5aEMvNmJQb2hhTGhtRWRDU3RlblNlRGgv?=
 =?utf-8?B?UGxvbmQ5QnhZYnRhQjF6dW1yOElhMnZaaEl6M1M0YzQ3cno3TDRqOXJEN1Ar?=
 =?utf-8?B?YWt1ZXBNaTl0MlQwcTZ0ZEpmZitSQ3hkdGNGNXl5TnVXa2R2ZzRubEhVcUZo?=
 =?utf-8?B?N1dSZlk3LytmakZsUTR6OXRPYnRqK1RUODN0Nk53djBWSC93QnI3VTF6LzBs?=
 =?utf-8?B?SXJBVkZ2VCt5UE5RRmR1RUh1M2xxTXFQc2NmTEljdmtkYVJ0ZTJCYktmRTdT?=
 =?utf-8?B?OXNGRGpPOWdlZ1BQcXRUMGJ3OXBaKzZtdFFjV1dVVE1GalZGUG85bXBxbGN2?=
 =?utf-8?B?MkZlTkZBeHVzMTNpcG03N1VwblNLTEtZa2hnbEFVWFMrUkU1aUFtbVJkWnR4?=
 =?utf-8?B?Vy91TUFKTllDUWVScnN6R0QzZ2dtVUd1NFV2dWZPL0tMZkZ5enFYNjhXNksv?=
 =?utf-8?B?dkNYN1pWbU1yZ0J4QTdFYWNUMUhzYU9kTHFRcithODBjbjZwSUJpZXVzSG5l?=
 =?utf-8?B?Uk5aY2VSUEIzeDFEMnhyT2dLNHQwTlYvSjFEaU0yemFZRERkbkVrek9wYVhP?=
 =?utf-8?B?R0g5OVRjb2NYTWY0RUhjS2dkakZ3RGtJK3FNdlpWK2FWTElGZ2JseWp4blR3?=
 =?utf-8?B?T2JBUXBDQXI2QnlrT0J2aDBBWmhtQWNsU1NOTEpaS3p6VHJwVW96alN2bXYx?=
 =?utf-8?B?Z0JySzY1K04rUWhEbXNINDhiWmhHaUN2SnpGVDRYbmFLVUI0UnBObHkwanRR?=
 =?utf-8?Q?qF3wV0skHy+ewf7xGVEPkbs/o38QRnH8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlN2bmttc3FHRGpxTUkvNE5XTU9DYkVaSG5nM0ExNnJnTTJadFBlZzlIQ3VN?=
 =?utf-8?B?SFlKM1NIQ1c2d21yMmU0aFk1ZDNaM2tYSm9SK1BaR2ttMEg1TElzY3o5VEgv?=
 =?utf-8?B?Y1BnclFCOXI0UjdmaElyeEtIMEdJRlBHWGR2dFNWUDVRSlNlcHFENXlQNFcw?=
 =?utf-8?B?VXUyVFF2cmNHTVlrcGhLZFEvM1M5dU0vMHJreFRqYThGMk10c01lallYRGZn?=
 =?utf-8?B?c3ZQT29aSThjUWZKK1kva2g0elVtM05xNGErSDNyS21Xa2NoUHJWZlpMOXJB?=
 =?utf-8?B?UWEySmZKRlpoVTBPMVVMeE8zcFpsYWlaRUQ4by9GM0krOUpVcmMyRmREWEl2?=
 =?utf-8?B?VlpacHZobU85T1U4cFBidG9meERkbHl4QkI4MVVIbnNFemt3eDVEUlBxZEdn?=
 =?utf-8?B?d0trSEozYXB3cysvRnYrUFZLdEdFVW1Fdk5IaS9WNFBRaDFtbHFrbS92NG9N?=
 =?utf-8?B?b2htMFJqUGxpeXlrQ2RnZVBWUFBUcjRPYTdHQzZqOUw0R1lOT1lzanpORGFO?=
 =?utf-8?B?bzZ6Rjl2aUdlTlhpdHZNQlV6eTFlMGUyNEFQL3VLSUxHMFlaVGFia2FCL2Nh?=
 =?utf-8?B?YitrWmc2cTIzTm80bU5DaW03aFAxNXBIbE5Dd2M5K3lpWXJmU0dwdlJhNHNt?=
 =?utf-8?B?SGlkWE5SaFFqVjJhanV2MUtDZUt3QU1qR1R5R1FOaTBCU0h6UWJ5SkhSd3BL?=
 =?utf-8?B?S0RRZDZmUkRDRlJYZnl3QW0vMGhEcVg5dVQ1TVZiMWRvYmRIaStoTzl4d3lu?=
 =?utf-8?B?WStBSzhPRklBZzRiMWRoT3VPNHA0Mkl1Qk1BSXNBSnM3bitOZE5MK0RIeUlt?=
 =?utf-8?B?QWtmQkM5dnhlMi9DM3FYY1lqa3JkclNFMUVHTTVzb1c3WG1YT3hiOFBaZW5V?=
 =?utf-8?B?a2EwWXM4N0RNMTVXZWtSTXplSGhvclh2czQ0K2ZmSTdqcTd3QXZYdWxJNCtr?=
 =?utf-8?B?NzhaS0NHVm0zZTFqUlZaWGpINTNHTzl6MU96K09oY2wrankyNFdKV1RzdHpV?=
 =?utf-8?B?MXloZFVBS0NGczZDVHpTcHR4UlJTSUU4RnRnTSt3MlNXS0FvKzduSGRma0Jm?=
 =?utf-8?B?OXNVM253UkFnUU9nRDRUZ0VneEpyWFMxWXJ0cHhUMlh3N09SenNHTmVpYUlh?=
 =?utf-8?B?UTdjR2JQeGR3VUxFeHhVWThldWVZUXFZSHJ6eTFsenB0bnlrcTAzbjNiQnpG?=
 =?utf-8?B?dXQyT2dleUF0d25zamJ6QzRudDV0dDVlVzNjcjJKSE8zbUJUTElWYm9KVEx4?=
 =?utf-8?B?S1NmZkZEYmJEYWdLcktZaWZmcjJORUZJR2h1cUdDRGhLbnYwUGhkRWJSQmE3?=
 =?utf-8?B?NWhtS2ZWRDFvYUVYVEhLdFlQeGdLeUw0b0tZb0F2bkRaU3RMYUI4K0YrMnlw?=
 =?utf-8?B?dTliS2QzRU9oWlZLLytQSmhnL2JmR2dnUElQUVFuODArKzM5VE0yd1RkNkRP?=
 =?utf-8?B?a1p0UVV5QllWbWdPemNtMnpsekJDQzVaQ2o5azhQdEowMDJiSGFFOERGL3Jt?=
 =?utf-8?B?K09hNElQSmpBYVZOWFppM3hWNk0yajRsakJML24zanF0WFp3QnhSZWNyaWN0?=
 =?utf-8?B?RlBKNU94dHlMbXBTQk04MWQxR1U5R0JOUHJZV3lmdWpDQVNPUG5IRVl4Lytv?=
 =?utf-8?B?djRNbXVYWDV0cysrcnJYTlJ2c0RvaDlGZ3Z6K01xTVVWU29YK0g3dWp2SE5I?=
 =?utf-8?B?WGc3ZE11cE5xYUFzd01jQytvRWQ4a1RWeUhBOGJ5ZGlJQnErWmhhKytzbUtT?=
 =?utf-8?B?RDJPYkVIdXBRNyt1dE5aNk1tN21aMDdnWFZwSWJBeExnY0xQb0FtMnVhdmFJ?=
 =?utf-8?B?V0hNcUhMV1hQTDNRdEJlb3Z2ZHFhUTQwQmhmcWdGVThWelZwQkI5NFdXdlpV?=
 =?utf-8?B?cU51OUZpMDEyZ3V5UmN0V3JTSmYwQ2JtdmUyaHo5MVZNWWUxTkN1UmxVMUxl?=
 =?utf-8?B?WmhsY3RwamlDR2VLeVRrMTdnd0FvNm4zeTRrRWQzS01CK1E0eFU4bmIwVFVB?=
 =?utf-8?B?T24vWmw5dHZ5ZWxHTWRjT2Q4NlRaUFh1WWhnaVMxUGd5ZFE2MDZDK1lXVncv?=
 =?utf-8?B?KzdkYnJEWmRXR2JHWEFBWitLbjRTN3dOQzZhMXhOd0svK2Y1NXlyWStqS1g2?=
 =?utf-8?Q?iaSVqENM8Gp22mLMNCE4miRyj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f20bd6-e6b5-4ff0-994e-08de36f446b3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 07:26:32.2390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTgyrrOku8I4apAIV8b3krxcCP88BtRbvY1s/0arA+jkbDOt30+MSZrSpIuGybPTtSh59K14Jf6MD6ONe2cy+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6795

Hi Dan,

Thanks for reporting this.

On 12/8/2025 1:44 PM, Dan Carpenter wrote:
> Hello Sandipan Das,
> 
> Commit d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore
> management") from Oct 5, 2023 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	arch/x86/events/amd/uncore.c:660 amd_uncore_df_event_init()
> 	warn: set error code if 'pmu_version < 2'
> 
> arch/x86/events/amd/uncore.c
>     654 static int amd_uncore_df_event_init(struct perf_event *event)
>     655 {
>     656         struct hw_perf_event *hwc = &event->hw;
>     657         int ret = amd_uncore_event_init(event);
>     658 
>     659         if (ret || pmu_version < 2)
> --> 660                 return ret;
> 
> If pmu_version is < 2, do we really want to just return success?
> 
>     661 
>     662         hwc->config = event->attr.config &
>     663                       (pmu_version >= 2 ? AMD64_PERFMON_V2_RAW_EVENT_MASK_NB :
>     664                                           AMD64_RAW_EVENT_MASK_NB);
> 
> Or do we want to set:
> 
> 	hwc->config = event->attr.config & AMD64_RAW_EVENT_MASK_NB;
> 
> And then return success?
> 

Right. If amd_uncore_event_init() returns an error, this should bail out
irrespective of pmu_version. I think it should be okay to set hwc->config
even if amd_uncore_event_init() errors out so that this can be simplified
further.

@@ -656,14 +656,11 @@ static int amd_uncore_df_event_init(struct perf_event *event)
        struct hw_perf_event *hwc = &event->hw;
        int ret = amd_uncore_event_init(event);

-       if (ret || pmu_version < 2)
-               return ret;
-
        hwc->config = event->attr.config &
                      (pmu_version >= 2 ? AMD64_PERFMON_V2_RAW_EVENT_MASK_NB :
                                          AMD64_RAW_EVENT_MASK_NB);

-       return 0;
+       return ret;
 }

 static int amd_uncore_df_add(struct perf_event *event, int flags

>     665 
>     666         return 0;
>     667 }
> 
