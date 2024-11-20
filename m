Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9E31AAE3A;
	Wed, 20 Nov 2024 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111124; cv=fail; b=qwPofnxhJI+EUKlBmf41JCBt0a/xL6uQtmSUb3qOlWGZxW5BoBDdUAelP6Qd1AvcnjT8ZCx3Gph1Mz3ymdci8wzBIS19WNEp69TJEKc6e5znngt6Vk3wmnGNaIolnri+Gm7Zqe1PRmxeW0ym5dr+8iYWtsgXKyhU3G6x0Q0aGfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111124; c=relaxed/simple;
	bh=frq1tSmbHhGWZSzKY3q5GgUmnW/GDoUoRwZBxujXctE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gUprGhcKeVlgmXtOh7UQUXgFdlPobFnoxzLobHxml4GGLXvHMMkivghpm25wC0OhYlLNeB7UYuNAhhVJ84hJLTotFoInosDGaKTqEIySm8JD5lv9iM+j+8NETE4JNmlLY9usNIzX/Cm9x6assBqIRlloXzijY8K46M7TWMTpOog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AjleICww; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AjleICww"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ib3wcm3U2Ryott/p6dzM1a0SZ1Mgp+DGSsxVopTEQrrIGZP/CfeaMlHIW0WUpAe4XM7/eh65iA/g+L+n3Xr+LtZb+/UUhCmyjaQYDuGsk9AeEJSQOGoSzhA7T7o5fcTq971+a3NE54bYCM5rloqZ2HCx0xL0N+ck99NFv/VZrCgTNpF3UnS93hyFAXZkWemCEE4w4U1AyN2r2QyZ5A7C/JyGY0qHPe54Lhntn+W50cjaHyJwyUwH8hjW0gEN654FpAhjloOLrn0B4DMxMIMMn9eznZGJ3mugcGFEggGaMmgws+Nhzn/FJMYMTCKjSz6VH6Jb2h6CjDWdiO7OFVj+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tbc3aHCzJU1g+rcfdwiAtU/+O0yIGHDKOHOYjlGX4LQ=;
 b=A3X0tAnjLXv5DhZPANPO/RLrOwYsOnAFIocgHkz6VKjDPAYEKAp6fBOCjOHNp2aguYcZ1tSi4iF1142zQyGu9uYBTY1HSwiW+PM9o+9OqqwiMq2Uofo7CLw4kZcBHvQMBcdKBAE6r3BbasNqJ2eis8TRPqvhLSTsCvLZXwO8tJtDCiyjknt91y7+dNBNuiLS/baZmCAGBPt7EH2HraGTgqZ3yST0dSv8pSsLpLUoWCNGhCYZDR823CADNg2OUP18hGfSh+4XkJU/+Z3Y59sD99n0mY7iEyA6/QQUMKrJxqkW5biWKQoQ7rNaumr3wOi3FAfdMpgAVlOB9H4X0DbdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tbc3aHCzJU1g+rcfdwiAtU/+O0yIGHDKOHOYjlGX4LQ=;
 b=AjleICwwcl8o5Rc6y7x99RyQ5t8RiKPlTCMP0MpnFVu780VP3LImrXFQcylZhfByTBO8XseyWjon02GV9rAA5TNEGxCx6LjEqWQ7mjMSEtP6knzclnbaXGH0eE1YF9stvFWCz6cdzTqdeSsvPuWyDSacq7SUkA3Ez/odkDE1Etk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 13:58:38 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%3]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 13:58:37 +0000
Message-ID: <7eaf557d-7e85-4fd3-abee-f84ac01d92c1@amd.com>
Date: Wed, 20 Nov 2024 19:28:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] perf/x86/rapl: Add core energy counter support
 for AMD CPUs
To: Peter Jung <ptr1337@cachyos.org>, peterz@infradead.org, mingo@redhat.com,
 rui.zhang@intel.com, irogers@google.com, kan.liang@linux.intel.com,
 tglx@linutronix.de, bp@alien8.dei, gautham.shenoy@amd.com
Cc: kprateek.nayak@amd.com, ravi.bangoria@amd.com, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
 <20241115060805.447565-11-Dhananjay.Ugwekar@amd.com>
 <a7159bad-92a1-47e8-b892-2ae0dd9a94f6@cachyos.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <a7159bad-92a1-47e8-b892-2ae0dd9a94f6@cachyos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::11) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CY8PR12MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ed9758-8327-4afd-34c9-08dd096b6e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S25kQS9XOUY5aHNUT3ZyM2NyWklGRWRka3lFWlVCM0M0YjRMaEl2L00xUmxY?=
 =?utf-8?B?dnBiRjU2U0cyVUx1aUIxbVI5YnR1MzM0VER4U2IycW5IN2txdUlROEgwVUNq?=
 =?utf-8?B?V3JlaTF2Q2cxNTI4WGcvZm42bmVzUE1aQjFuaVUya3Z2MmJtb1BDdU10ckZ2?=
 =?utf-8?B?WHRvR3FyZGkzMzZiU2xXdjQ0TktjL1V2NnBmci9yb0o5NlluVFlzc2EySm9i?=
 =?utf-8?B?ZXloejJwL3hLWE5XM21BZi9YN2FrRGhRUFBzOUVyaXNBZ2xFVGF4Uko0aHll?=
 =?utf-8?B?NzJ0MFF6NWt0NTE1OG03dEk3STRPcTdTRUZDWGwvUWNMSGI4ZHowSjB5KzRO?=
 =?utf-8?B?TjdwNkQ2VjZjV3FPQ1poM1BtcmNDc09jR09ZSFNGL29UUE5ISjlVR2RtL2NJ?=
 =?utf-8?B?ZG5VcHQ5dnpNd1pURTFCbytkNDgzOFBVcy9lbjRQTW9pOHB1R2JvRldlK3c3?=
 =?utf-8?B?di9xcnRodnZvK0kwMFNrWW5RdFkrbG45MWkrL0NBL2pwM2t6NFM4eWZING10?=
 =?utf-8?B?ZXVmWENDM3dJWlpJV3Bkd3N6aDJDa045MWJaa1RTTVl4VGJwcHV1UUN4eXoy?=
 =?utf-8?B?bXE2ZjgzbHFYbis0Uk9XcE1TQmxvOU41U2RmWTZqNjJNdzdUcitxTEJMRTEw?=
 =?utf-8?B?WHczeHU4VmNGTy9uZ25UNlE3L1ptN3M3dHdMSjRqNmRLc0w5ZU5iaEIxN3NW?=
 =?utf-8?B?NFZqNzQrNVVkSjh2L0NBRjU3MWxtclhMY3ZhNGJnUWk0bHNnaVFVMDZhR2VF?=
 =?utf-8?B?dmIzOGlwWGkxaG1tbnNPN0hCSGFPTzBTaG5TRFlyZEJzZjFicTZraVBHaWIx?=
 =?utf-8?B?NWFCUUVMekFuNkcvbVd2Q3ZOd25DMmM0MXFhdzF5eWFHRFB4cEhVNUM3bE5L?=
 =?utf-8?B?b0VyQVNkOGNDcGl0NDNsYzJpT1B5blpmdTVSQ2hqNFc3TGZDK1g5bk5SdW5X?=
 =?utf-8?B?NU53S3F0WjZvaFpZK096UTFtUzlKcVN4aHlNdHhXc3BYTWQzbUZDMjBudTI0?=
 =?utf-8?B?T25wWlZpZGFPNFcwRG5LbzRGTHJWYlN3M1JhcHc3c2loN3l3Smp4dHAraTRP?=
 =?utf-8?B?dmllSmVFdytnaU5wSUZoY0xkd0tjSVN6MVYzdFdEUXhMa2tBU3RGclYwd2hx?=
 =?utf-8?B?bjE0NzJiUGNaTDQvMVV5VDJkMHl0bEN2V0pyd09jRkpNT01vTExZK1RlS0di?=
 =?utf-8?B?U3lMajZIR3p4K3Qra05Ucm16NmJTbVpBVkluS3BVa1JYOGlxc0doR3JqYjZx?=
 =?utf-8?B?c0VpOE9wRTRwY1FiL0YxTWttanM3S3hGbXdkSDVjYVRrQ1hWcGRvMzZFREty?=
 =?utf-8?B?a0xGNWY4VmZTeThHVGJRQ3R4c1I1TDRMdlh1Wmg0Vml0ZmRWZzZwQXNITjdY?=
 =?utf-8?B?SEQxU2o3alMrdWtGMVhBS2RObkZsT0Y4a2Y3Ri9UVmdlVEhsUE5ZaGg5MGUv?=
 =?utf-8?B?VkwzbHNxWmhUdFhINUp2Y2grVTQweFlSelU3WjR0QnQ1cDFWTXRSdkhlRzFa?=
 =?utf-8?B?NnU0VFBwa3NtUkpZQ3JxaFlhNmNpQS91SUkwT1R6RFRYQU9WaTJUdXdudGRq?=
 =?utf-8?B?RTc1eHB0NXlORndZOGVmaDFrRnJFRndtK3hNRlFLV2dOd1huNEVGNit2bHRJ?=
 =?utf-8?B?MWl2VnFzZmVSMTNCWDA4N3hDRTVCSnFzanpQWWVOYTgrT1N1VE5pYVBuSWJU?=
 =?utf-8?B?NkkxVndQT0c3UHNVVkNHVVBHeHRmcGhtQ2R2d3E4ZHFPZGlpSG1xOGV5OTc2?=
 =?utf-8?Q?2N5C83//kPNogNt2KNhBHWSNIYVO7g9RMEhofYi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXdYQTdYRldUN09pM0NCVmNZdHZxRW5qWjhlTEc5U3lQN2plaWFxRlFzNXRO?=
 =?utf-8?B?ZjVPQjNkVkdnSXRUQXlqM0Uvdk1URXRFNlFLbE5sZ0RTeVVIK0hoelMrSWcx?=
 =?utf-8?B?V2VubTgxT3p3bkIreEIwT0t3SXJiaEcvTnRLUmttVDhEK3ZIZ3RIZXN5UllU?=
 =?utf-8?B?cEJ0WXNjbmRibkwxd0pmeDlvMGVIOGZuQWcrbTlzQnM3Rk5uRHlDL2J4dTlT?=
 =?utf-8?B?SU1Xa0IwWUYvSDA2TGtHd3hCUFpHcEVNbyt1UXRyYUJxM2lZVFFZQVVYODMz?=
 =?utf-8?B?cVNUcmJPSjZ4T1B5VS90bWEwMFdLbFhtbURHaGd0eW54MnFwOFN5dTI4cVFr?=
 =?utf-8?B?VU5nOXN3aC9aeVg5N0FwZkhBWDk2YUVjVGYzWHQ0SzVJeS9VeWhoc2NnWHYy?=
 =?utf-8?B?QndqNk1jWld6QmZMM2lFQW45NVlkVDdtVi9ROWxidzFVa0dJNlh6YTRuZ0ds?=
 =?utf-8?B?WFhsRGNGaGN6dE9kY1ZiclVJWERzWEcrVHJod1ozUDZuVHhpSlpHanI1TEdo?=
 =?utf-8?B?RVFvQUwvbVVYZk9pdFN0a01IZFFXelh4QU5PTUJKNDVkWG9ldE40THk5N09F?=
 =?utf-8?B?L0hUS0VNTzdFa0txWjB2V09YbjNJWnYraUVWTnVCK2dTc1hmbmZtb2lUdG9N?=
 =?utf-8?B?R2plaGpQYTRWT3VwK3BMeW1rV0cyN1N0WjFyT0w5RCtLRWFHcHgxSUNzMTMy?=
 =?utf-8?B?YlZnV2lKYzVTcTZWOTd3dS83cUEyUWxpTlZxOE01Ymc0cThmNitTeklQcTJu?=
 =?utf-8?B?NENxbjZ0VlZZZXhIOGJiWU0ram45UnZtWVY0aldmNVVjRFlGTmpzWGIyL2s0?=
 =?utf-8?B?NXdLWTdwMmdiVVZKaHZTM2V3VklyclRpaUFDeVI1Nit2R1hGL2VHaEJhLzVy?=
 =?utf-8?B?OTY4SE5VaE9TdFVLN3dIcVlGN1pSRVl6SW42ZEFlQ0NYaXJMV0dZazN3VkZ1?=
 =?utf-8?B?ck1MS3Z3WnhxNk0yT1pzRUxsak5jZXE0VFl4RlRXcm5TeEZuZEpiUFdiajcy?=
 =?utf-8?B?Z2VITDJQa3FyZ3QrWDg5SmthQmJoZ0dwaGNhUnU1d1UwQXptaXVMWHhjbE1P?=
 =?utf-8?B?NGpEVzVGR2dPbUZObHUyT0JYdW9icDZYT0VsbTZEZUJwbnM1ekV4Q3lKbGlM?=
 =?utf-8?B?NHJ5aHBtMmRnMDRKZFd1M2JGYWoyWk00TCsxcmxpTEMzaUNyZytVbEF5c1dD?=
 =?utf-8?B?T1lITW11Z2pCcFBWZUpKYTJCdVErNHBEenBDbEVLV05Gam5TQnRrTGl4RVVX?=
 =?utf-8?B?MFdxaWhNYXR2VDEvVHkwbnhlMXQ4amNtZnJIR1BHc2hQeXhEK0ZNdXlzU0M2?=
 =?utf-8?B?TnNBTkhnVE9zMGRicEd2R3JuQm1vQWM3M3V4a2NYZ3RERThRODh0WnJzbGZu?=
 =?utf-8?B?dmpxS09JK1kxdXNmMGl4NGlTZ3Q5TlF0cWdueVorU1Vab3g2YldXKzN3VmVm?=
 =?utf-8?B?NWhVdmJxZGE5cW5wSmxaRVA4WlR5bWpRaXVSQWZncUVQMEJnc2tkVFptOFVZ?=
 =?utf-8?B?dk5vNTJUdWc3aWtkbUN6MnNVVTdjRmk1SnJ3OUxzdkZUejZZNi9GTC9kZGZ4?=
 =?utf-8?B?SlRqQUhJSjVtd25oMjZ6ZzNzYWJNNVRXbnkxMnUrRDlxaTVDcWJrV3dZU3pM?=
 =?utf-8?B?OFNlUGxhVTFMWlgyYk1ZSklRWWk5U0Z2aWdiTXh5RFdLN1JXUHV2Qjh4bC8w?=
 =?utf-8?B?MTZvRmh0WUhXSU1sRlh6SzlrNkJjMFF2YXFOb0I5azN6Y0JPTDNtUU1KdmNs?=
 =?utf-8?B?Q2J3cnpOMUd0Z3FJcjJxZkVraVRQVVFZaSsySlp5eXVUN2R6dmQvdmFiZG8v?=
 =?utf-8?B?V2dHNFd3MWV0OHpPQ1BxQ201ZkRFbHlLZEpjSHNMV3V4S0tmbEJNK1ZnVk52?=
 =?utf-8?B?V3c3YUtwZVVaM3F6dGR2QUE4ZmdYK3JGNkRiRXhEYmhzSE1QV2lJc24vUnpi?=
 =?utf-8?B?Ync0N0x4S3BNcTZDRnNvZWl1UjErZXZNTjZSWEFWS2VwdTF6UHhRaTJtSzN5?=
 =?utf-8?B?SGU4SXErM2piWVFBYUIzQmhiV1FTWHBjQVppNExud3puMVBacUVoWkZESXgv?=
 =?utf-8?B?Wi90QjU5T1ZnTXBGWVlkSkpFbndsZ0RySHorN3N1TTBQQVIzK0Z4ZldKb1dw?=
 =?utf-8?Q?g/oHARbsShdOB1nCJE4fB8Rt6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ed9758-8327-4afd-34c9-08dd096b6e65
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 13:58:37.8563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ljc5sjMMmNp5Nzij+WX2pAL9VXSf0Z88yz8lY+NceJiO0+DJxlQ5tsnK9ne3L2Jz/S19JIDeBWgCuCn+JVMrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193

Hello Peter Jung,

Thanks for trying out the patchset,

On 11/20/2024 1:28 PM, Peter Jung wrote:
> Hi together,
> 
> This patch seems to crash the kernel  and results into a not bootable system.
> 
> 
> The patch has been applied on base 6.12.rc7 - I have not tested it yet on linux-next.
> 
> I was able to reproduce this issue also on the v6 and the only "good" version was the v4.
> This has been reproduced on several zen3+ machines and also on my 9950X.
> 
> Bisect log:
> ```
> git bisect start
> # status: waiting for both good and bad commits
> # good: [2d5404caa8c7bb5c4e0435f94b28834ae5456623] Linux 6.12-rc7
> git bisect good 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> # status: waiting for bad commit, 1 good commit known
> # bad: [372e95a40e04ae6ebe69300b76566af6455ba84e] perf/x86/rapl: Add core energy counter support for AMD CPUs
> git bisect bad 372e95a40e04ae6ebe69300b76566af6455ba84e
> # good: [fd3c84b2fc8a50030e8c7d91983f50539035ec3a] perf/x86/rapl: Rename rapl_pmu variables
> git bisect good fd3c84b2fc8a50030e8c7d91983f50539035ec3a
> # good: [96673b2c940e71fde50a54311ecdce00ff7a8e0b] perf/x86/rapl: Modify the generic variable names to *_pkg*
> git bisect good 96673b2c940e71fde50a54311ecdce00ff7a8e0b
> # good: [68b214c92635f0b24a3f3074873b77f4f1a82b80] perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
> git bisect good 68b214c92635f0b24a3f3074873b77f4f1a82b80
> # first bad commit: [372e95a40e04ae6ebe69300b76566af6455ba84e] perf/x86/rapl: Add core energy counter support for AMD CPUs
> ```
> 
> Nov 17 12:17:37 varvalian kernel: RIP: 0010:internal_create_group+0x9a/0x4e0
> Nov 17 12:17:37 varvalian kernel: Code: 7b 20 00 0f 84 cb 00 00 00 48 8d 74 24 1c 48 8d 54 24 18 4c 89 ff e8 15 8a 99 00 48 83 3b 00 74 59 48 8b 43 18 48 85 c0 74 11 <48> 8b 30 48 85 f6 74 09 4c 8b 5b 08 4d 85 db 75 1a 48 8b 43 20 48
> Nov 17 12:17:37 varvalian kernel: RSP: 0018:ffffaa5281fe7868 EFLAGS: 00010202
> Nov 17 12:17:37 varvalian kernel: RAX: 796772656e650073 RBX: ffffffffc2a642aa RCX: f781ec27a963db00
> Nov 17 12:17:37 varvalian kernel: RDX: ffffaa5281fe7880 RSI: ffffaa5281fe7884 RDI: ffff90c611dc8400
> Nov 17 12:17:37 varvalian kernel: RBP: 000000000000000f R08: 0000000000000000 R09: 0000000000000001
> Nov 17 12:17:37 varvalian kernel: R10: 0000000002000001 R11: ffffffff8e86ee00 R12: 0000000000000000
> Nov 17 12:17:37 varvalian kernel: R13: ffff90c6038469c0 R14: ffff90c611dc8400 R15: ffff90c611dc8400
> Nov 17 12:17:37 varvalian kernel: FS:  00007163efc54880(0000) GS:ffff90c8efe00000(0000) knlGS:0000000000000000
> Nov 17 12:17:37 varvalian kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Nov 17 12:17:37 varvalian kernel: CR2: 00005c1834b98298 CR3: 0000000121298000 CR4: 0000000000f50ef0
> Nov 17 12:17:37 varvalian kernel: PKRU: 55555554
> Nov 17 12:17:47 varvalian kernel: ------------[ cut here ]------------
> ```
> 
> Ill do on the weekend some additonal tests based on the latest linux-next snapshot and provide some more logs.

Can you please try with the below diff once,

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index e9be1f31163d..d3bb3865c1b1 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -699,6 +699,7 @@ static const struct attribute_group *rapl_attr_update[] = {

 static const struct attribute_group *rapl_core_attr_update[] = {
        &rapl_events_core_group,
+       NULL,
 };

 static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)

Regards,
Dhananjay

> 
> Regards,
> 
> Peter
