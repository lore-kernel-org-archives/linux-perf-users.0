Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC7B19995A;
	Thu,  5 Sep 2024 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538799; cv=fail; b=VjDvWEig0FREsMeFRj/SmS3EKnnT/A0XAaI0CBplKoqlalRQNglvmxz1Y8EIdrK69mpPOt1TMLxsoN0UAm9e4XcPkeG5sP2phtymDrW6ZAA3m0ITEYupERGgED6kSBRgwbhR1AWybe8HQUTZfP41FVqXcyGiVL+my5GPJXbfahI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538799; c=relaxed/simple;
	bh=HxO9R7wci71EHF5aArP++kXBzvPfJCp+HRAqsmEYI+Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KikuUOkEBbsHFdxuRhJ+274FdCiIiq/EdpwiEtMuxRYclySCwiJK2NX9AnzTswQpdts2sLBIYwfWVFXsopAxHPLYBo3UQcBT2B4g1kYRQZf8dVN9AU8GGz7IIqvK6A/4hqsada9u7sRTiPkIJPdpTAVYsVm5wfItArC3MtMyLMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lfwL/r1Z; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lfwL/r1Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9ZszzuZC2ICsS6DTmQPjbwzxFlkg/ocwgN0/4ny92hMWp5sIy8mHy6lznf9NoonNEbIzgApI/6Zc1CFKUh2bxH9CSl8reubMGFobPPzsuzzsXwQjsKsRAn4NT7IQKIdNbL7TfHS+3fqCqFsOnKcUf0Fj8q5TmyAJ8PtiVY5oOFST9847YZEx/usBP2uKxrvoNzg/HTo9Ka/KLtVWXA7G+Oy+sHP07H/MtZhAzVdDdEvcb2a9AClA7pp+m41B1dAQKvGA+HL4elHHngC33JjaOMmYQ/IaMUNZh/OX9fwyOu6SKlj7br3ZpCPHHn2+PkXuBfhQ3VE9xAkG+50Ixi7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6c72PtIXj9xkgCMQ1LkN6puXMYkk0AS80Uz6qTTF7E=;
 b=DcLoI5bvSohKuODdWEl3/3D3VNI+yQlBqi4XmPVeAvPCtWtkDh4A2XWu+/MzBpt4YW3LAKXe6Hy2jW6We/CLLdahCmOclRXJzR6emKOqZURZ+ajVmWps5+X+YKKSWlnZDl++8+rJr8pq+JKTkiX8As/3Um4Nx1+/7/F/8IyvuJOH1tJ37PAfSCanKrvIrIMEEFVDtLKh+Ct70wAhJIe0ftmRwVCPLzsgiPGfo1AhjFWkOImXC2J2xPooOZcgXuA5NmEdGAR9qrcNz6hvHbQD9r1XjrQ/hexMxthaU8772fGbw7I2+tVLqAiSNprDJ6CSa0MP9j+8t6kCMdjkp+Xwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6c72PtIXj9xkgCMQ1LkN6puXMYkk0AS80Uz6qTTF7E=;
 b=lfwL/r1ZlL4ifY2zO/zd+/NEfMn3WtnLUzzCi+HJOvp6WJuBHyt68WZHb84Ptd7RtGaoVYo35lo1EEgQHg8A8iBbHkFx+BuZy6vwqqIsxncZk+epln0udXjDuhdvCTcJER/OAsVpGl76HYaIAyFm8VgpHgbNV8mElyYn6iK3pAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SN7PR12MB8001.namprd12.prod.outlook.com (2603:10b6:806:340::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 5 Sep
 2024 12:19:54 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 12:19:54 +0000
Message-ID: <b34e30bc-a003-4529-bcfe-8189ca7ddc5b@amd.com>
Date: Thu, 5 Sep 2024 17:49:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc: gautham.shenoy@amd.com, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240904100934.3260-1-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240904100934.3260-1-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::19) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SN7PR12MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b63d79-2906-4e97-d91c-08dccda50c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2wzeDhxK3N1bXB1RXFrUDFyczMycytCbUJrZTlKd1l5RlhPcE1kNVUrZjdR?=
 =?utf-8?B?d3JETUxWSXFWanhxc0ZDUjB1OTRId3hKSHpEcHFnNDFLYUZoallScXNUdG43?=
 =?utf-8?B?Qnd6dWZQb3hGVml0UlNzdnhPL01jYXlSUUhHV0JhblVqN1lOSHNVS2FMN01i?=
 =?utf-8?B?ZHZ0Z3cxeHdVWkZhWHo0MDVWWkdIUm9WZ1pVc2ljclA4ZGE0Z3FhSnhyRjI3?=
 =?utf-8?B?TUR6Y3RvempDWnhaZVo0aGQwL3VlV1QveG8xWktZaVdrYkRiNmUrRVZVbCt4?=
 =?utf-8?B?TG11WlhGYTFrRmJmTWN4RVN2eEVYWDhmQjhPKzc4OVdRNVFDa3pDVTRzQXEw?=
 =?utf-8?B?S3pDMjFzakpiWG9ERVM3RGE0bFlBUTB2aHVrWEE2eG94Ly8yN1B4dWIxSFBW?=
 =?utf-8?B?dHdjbzBncHlMdmgyUjVJVDc3ZUR3MlVLV1dEd2JSWW9yYndOZGp6TkxlM05r?=
 =?utf-8?B?SUo1VTRlNHEzaGpjemx4QmNxVGFYbGExZ1p5V2Q0cDVaZFZhSlFVUjNEQUZj?=
 =?utf-8?B?UFNBdndmdk90Z2s0LzZlY0FKdzRmdXpkR1o5emlTUi94ZDRQQ2pRQnczOXJr?=
 =?utf-8?B?Wit2ZG01YWZ6OERwaFQxM3I3VmpHVmtISzBVeXR1akRSb3R2dFcyUkc0MitT?=
 =?utf-8?B?Q2JUdThWbFp5NjJsaUJLY0lXaW5UY09lanpLYnM1ZmQxcWRPMnptVDlLMDB3?=
 =?utf-8?B?cCtIemxIZ05EWXNzckVIcjFSeDRqWmZKVG9YTVRReVlWZjh2cE1LbngzMm40?=
 =?utf-8?B?OXVrczFVQStOa1QrVkNUM3Fxa1gveXZKQm9zOEh4YzRJMFMwNkZxUWJXaVZK?=
 =?utf-8?B?VnFjMU9WN3NSWit1RDJSaEpqMlErR3dLSVlDWTdkME1uSG5Va09CeTlzZW5O?=
 =?utf-8?B?WDErVkpGa0ZEK1lxTUFSWEFxNkdjUUlrSGRHa0xwd1dnSGtYZW41QVBGVHRt?=
 =?utf-8?B?TlNzN1grN3VvWVY2djBPQy8xYit5RlgrRVJKTHBlSHBjbElvd2lPaVNtRGFW?=
 =?utf-8?B?R240a3VNV2xuRTZKY1JaeUFsWnB6N2dqVjhCM3hIc0FSSEhJc3dzaWtBMmRi?=
 =?utf-8?B?UjgxaWhkNEF1YWFVVWJkNXBsTm5wUlptY0wrZnkrMnphdm9XYWxaa21NalNW?=
 =?utf-8?B?U0NaTXVUM2dya3cxbUZUeURMeVQ0VGE5NWNSNkNMMmlVWmdrS0UyRHhsRURM?=
 =?utf-8?B?eHkwdnQ4Z0grTnkwN2h4MnM4WHlrdldkSTZ5dFlQaXRMbzVoUDNYZSs1NW5W?=
 =?utf-8?B?UXJLTXBWQitCSG85Q0twaHAxaThSOFlZUXlOTDVXU3dXWklFQXgzenQyS0xy?=
 =?utf-8?B?Ti9qYkNTMEo5cWo2TTJRYVREa2pMTDF3NUh4VlVOYXVYeFltcVRmSnd6SzRG?=
 =?utf-8?B?bUJFU0VCWUtlSk9RaFNMNUtTZ0x5eDJqOWVydXdIWVhMWHdXSTNWSVViOXBt?=
 =?utf-8?B?RDhpTTQwTjFOa2ZTY2RLdUpDeHRETDJTSmpGQ0tFVEpVYkpsWmI0MGVGanJj?=
 =?utf-8?B?b3BFYTZ2OC9EZ2FTYmNNK0JMeXExRnExODYzU2d6Qlo2TkZ3U3k0b1B6cHR2?=
 =?utf-8?B?cXhrcTNEOTEzU0FsZ1BlZ3dRQkI3RVF3WUpPTW9raU1rcjJMamxOUGZ1eDNT?=
 =?utf-8?B?STdkc2FGTVlEZ2pDQTBDNjM4UnpvUHorK1RBRzJrb3BmMFRSL3k0aGxrdUJq?=
 =?utf-8?B?Mld4LzFGd2ZIOGhTdFVlbUFGcitrZXE4bFQ2enFTcmhKNzJIQVhsazRuUjFE?=
 =?utf-8?B?cmlwTXhsdC9UbVllK1hqUlhpa085VStHN3c1YlFZdk0yNTlYTlNiTGxJREVS?=
 =?utf-8?B?Ykx1d2JPRUY0Q0ViM3lXc0JoMWhMeWdKOU5pczlkSzQyZGt1MXJNT2RiQW0w?=
 =?utf-8?B?ZUZ3VVovTkNTOWVzUE8vaG4wS2NycHA1U1RXN1VoZnFjM2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDMwMm9aRitYL1E0RmlCbTNCSVhzSmtHMEtRUnVKMUpCb2JLdUQ3K056cStp?=
 =?utf-8?B?MUd0OU96YzRFeHZtd0cyTkFTZzIycG5hb2JSNEVDNlZJdzVGU29GbngxVlhN?=
 =?utf-8?B?OTdvaVFMcG5SU280SElKYlFzTnl2VkZJdkkxR3dNSzlqT0NYOFA4K0ZYUlAv?=
 =?utf-8?B?eUVPSTJvSEF0YktmOWxGbUJuSXBCakFEa0VmbWZOWVpPZXpTbVdrSkNrV0RI?=
 =?utf-8?B?S0R5UUszdUQ0b29qdTN3c2lNQ3B5eC9FYXZrZGhQMHBPb0ZFZ1lyUXdSck5l?=
 =?utf-8?B?RDJwUi8ydVo2eGVIRnhsK3lpMUFSLzdmcFhZZ3E3ZzNPTmJ5OERNKytOcUJo?=
 =?utf-8?B?R3EwekszVmQzMU9wOGpCZXQ4cytQYjJlYzZoN2tpWkhZRDRtYjRkR0NxaGY1?=
 =?utf-8?B?cm9mdWVIVWw1ZDZoY0tRdVhuRjh2QVEveXh5aEdWMFAxTTJ0SGNBdHFlSmp0?=
 =?utf-8?B?eVZtL1JqZm04YXRML1Z4cFlpK0hJUmtGQ05GbW5hZTgwYVNqbzZLcjh5aTU2?=
 =?utf-8?B?RXlYZDkzdzVOZ04zdEpSaGcrQjVCaGZ3ZmdsUUI0N1c2dkdyVHJGVWxwSXMr?=
 =?utf-8?B?V3NkQkpMeEFlS1FxOHoyMzF4c3lxWWc1aGdWWlRVN0piOTJ1cXBmcUpGS3J6?=
 =?utf-8?B?SkpyTHIraDVHWDl0VGZ1Vkg3MC9LbnhiRU51emp5dmZ1bUNONUJlTGpESjVk?=
 =?utf-8?B?dWVnSzJlb2JtVDVqaVlEb2d0YVNqU2FTZ1RLQXFSUjRpb0Z5RVhMcDI5Y1Fn?=
 =?utf-8?B?SDFPaENZSUlrNnpCSGFtRHVYeDgyZ3IxRHFvZU5DUkJ2RE5URUo0V3BhWHJH?=
 =?utf-8?B?b0xjdlA5OHE4MDZuRFhlUDBJNkFMd0pFREFGZjhORkxPWithQ3ZrM0VnUW1Y?=
 =?utf-8?B?SDI2UmZVT1hhdjlQYnpobEVhT0YwejFDdy95UkFSSU5iZ1JzSlNvMS9zZUR1?=
 =?utf-8?B?eTZPZyswY3pWOTBST29Sajk0RUVUblBsQnJYNXN4Mm8zTjBpNGdxSHZWK0Yw?=
 =?utf-8?B?THpNUWFiQVlLQWZSRVQ1eENJWnZjM1pRRzF3WXRxRG4xUEZrcGtWbEphZmhP?=
 =?utf-8?B?dFdNcHV1elpTRlFLazZvdFpHdEVaZjkwWU1iQnh0QldiOEpGVHNGQVB5bmxZ?=
 =?utf-8?B?d2h3VVo3Z2l2OVFKVDB2amFDVWFGcTNzdXpyRjk3b2QweENBb1A2cFlzaFAr?=
 =?utf-8?B?Q2dQV2w4TldYdjRkT3Q4MUNrV3dpTHVTMHRBa0lTeE1TcWJOR3JzVHBFZGhW?=
 =?utf-8?B?T0V5VnhsUTNqSkFaaVRiUWU4b2xCVmpoY2trcUxMa2g4RWpCTHFIYWNUL1dO?=
 =?utf-8?B?YytRUTRuZHY0MTlJVHN0cVdVcnZ4K2ZUNFBxaXZkdWhUN1RLMW10NHI1QUQv?=
 =?utf-8?B?WHE4QUJUbTJ5RlRoVUN5akhtZ3RaZHdFVkVacGJ4cWZJNnNRaEdVUVNKQTFW?=
 =?utf-8?B?WXUxRW5wN2xEcjFJZGFkMEdSV2JxMzRwamIydTZmWW5nS3NibTNTemJsS3ZR?=
 =?utf-8?B?bEd4MkI5K1pwQjAzYXZTUzlYREN2SGh4Q1FvRC85UVVsTFpNWWNTQkY0RHVp?=
 =?utf-8?B?RUVxUUpnbWlEelNCWndWSDFRaDNmQjM0bGhhaFNPRy9KYm9hbjNkME44bWRx?=
 =?utf-8?B?RE1DOWFqOUZMRW5Vc2NZeEtVY3hjbUJsWXQwUTNJUEloM1JQQkJPOVAyRk5J?=
 =?utf-8?B?ME5YSDNtREVKVnNCREZtQVZjcmdiMzNiK0lVbFl2Z0l1QW5CTy9zN2MweDZN?=
 =?utf-8?B?a2pETzhyQU9Mc21yNmp4cmc1UHlPVU9Eb0duajc0YVB2RDg4NEttQ3o3ano3?=
 =?utf-8?B?UThLTUhFbGZpd1ROeEw3T1dzVExtZFR2eVFYOXRSWGZKUWJRWHd4NXN3Qzhz?=
 =?utf-8?B?VFNhRlVXd09FQXRTWERLcmIxc2dVeHpIZXByVjRVL2dORkhzeWEyaDJXSER2?=
 =?utf-8?B?MjcycC96Rjg4MnZEdFZQZGthbEQveGdsaG01QXA3cGJOMlpGMUpLN21XNFJl?=
 =?utf-8?B?cHBQbGxHVHhjdU03UFZ3Sks5K2RjQ0V4TWlPbmtBQ0NaSzFSV1ZVY1MxNm5v?=
 =?utf-8?B?RzZ6Z0oybWp5bXRvK09JNWNBNXo4V3RTajAyK2F3c0RYY1d4bFd1UXVBL0Nl?=
 =?utf-8?Q?ZhGMOnnSR6IeQ1AHm+DfzYg8A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b63d79-2906-4e97-d91c-08dccda50c80
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:19:54.5935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4gCixfB2Whd+nBfbCqXb1Oj62RcTEiZtTfJF7OZBC0GHnNKGaDoEOswm3JKOrFNwAebNTESdt8/6c5WamORug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8001

On 9/4/2024 3:39 PM, Dhananjay Ugwekar wrote:
> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
> on AMD processors that support extended CPUID leaf 0x80000026, the
> topology_die_cpumask() and topology_logical_die_id() macros, no longer
> return the package cpumask and package id, instead they return the CCD
> (Core Complex Die) mask and id respectively. This leads to the energy-pkg
> event scope to be modified to CCD instead of package.
> 
> So, change the PMU scope for AMD and Hygon back to package.
> 
> On a 12 CCD 1 Package AMD Zen4 Genoa machine:
> 
> Before:
> $ cat /sys/devices/power/cpumask
> 0,8,16,24,32,40,48,56,64,72,80,88.
> 
> The expected cpumask here is supposed to be just "0", as it is a package
> scope event, only one CPU will be collecting the event for all the CPUs in
> the package.
> 
> After:
> $ cat /sys/devices/power/cpumask
> 0
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
> v2 Link: https://lore.kernel.org/all/20240730044917.4680-2-Dhananjay.Ugwekar@amd.com/
> 
> Changes from v2:
> * Rebase on top of kan.liang's PMU scope patchset [1]
> * Set pmu.scope variable to package for AMD/Hygon CPUs
> 
> tip/master + PMU scope patchset [1] to be taken as base for testing this patch. 
> 
> [1]: https://lore.kernel.org/all/20240802151643.1691631-1-kan.liang@linux.intel.com/
> ---
>  arch/x86/events/rapl.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index b70ad880c5bc..0c57dd5aa767 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -139,9 +139,32 @@ static unsigned int rapl_cntr_mask;
>  static u64 rapl_timer_ms;
>  static struct perf_msr *rapl_msrs;
>  
> +/*
> + * RAPL Package energy counter scope:
> + * 1. AMD/HYGON platforms have a per-PKG package energy counter
> + * 2. For Intel platforms
> + *	2.1. CLX-AP is multi-die and its RAPL MSRs are die-scope
> + *	2.2. Other Intel platforms are single die systems so the scope can be
> + *	     considered as either pkg-scope or die-scope, and we are considering
> + *	     them as die-scope.
> + */
> +#define rapl_pmu_is_pkg_scope()				\
> +	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
> +	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> +
> +/*
> + * Helper function to get the correct topology id according to the
> + * RAPL PMU scope.
> + */
> +static inline unsigned int get_rapl_pmu_idx(int cpu)
> +{
> +	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
> +					 topology_logical_die_id(cpu);
> +}
> +
>  static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
>  {
> -	unsigned int rapl_pmu_idx = topology_logical_die_id(cpu);
> +	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
>  
>  	/*
>  	 * The unsigned check also catches the '-1' return value for non
> @@ -617,7 +640,7 @@ static void __init init_rapl_pmu(void)
>  		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
>  		rapl_hrtimer_init(pmu);
>  
> -		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
> +		rapl_pmus->pmus[get_rapl_pmu_idx(cpu)] = pmu;
>  	}
>  
>  	cpus_read_unlock();
> @@ -646,6 +669,12 @@ static int __init init_rapl_pmus(void)
>  	rapl_pmus->pmu.module		= THIS_MODULE;
>  	rapl_pmus->pmu.scope		= PERF_PMU_SCOPE_DIE;
>  	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
> +
> +	if (rapl_pmu_is_pkg_scope()) {
> +		rapl_pmus->nr_rapl_pmu	= topology_max_packages();

Just noticed, better to update nr_rapl_pmu before we allocate the memory for rapl_pmus at
"rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);", so that
we dont waste memory, will fix this and post new version.

Thanks,
Dhananjay

> +		rapl_pmus->pmu.scope	= PERF_PMU_SCOPE_PKG;
> +	}
> +
>  	return 0;
>  }
>  
