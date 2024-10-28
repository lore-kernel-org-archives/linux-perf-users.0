Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B421190696;
	Mon, 28 Oct 2024 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107172; cv=fail; b=ZW+D5dN71D+kuSymnPfOnci/BaB+VGHMi00F/X1qbrBd2VBvP1s+nwMpOEfhgtcU3sG8o3JlXX50F6Pw+NqziSEWEwkMN+sD7hE3Q6MCWuXvgkWuMaMn/n18iCc22MDsiKMn4HkNRCyv1nI+QuXFH9LabjprynfFdnUvVMHZC/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107172; c=relaxed/simple;
	bh=P/cKaQwMLNu4ib+fnDTtC+gCifgqo2y2qs2F2q7KjpM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FoXXwph7A37PQUEyo19uCg9r9XYts40ioE3eskJyaO/1YrewXx3GpBobsWoz+WawiuSSTQFdVikzTjqY+fTbTQ23lGvT5dKhw2znsg/VnPS4qNakvxqjVAAj5dmnfocqCtDGgrHPTKFnSJWfJdaT3X96k2g/XECIKuDQWaT6x7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LLLjwBfA; arc=fail smtp.client-ip=40.107.102.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LLLjwBfA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUW5r9vgD6eQyZXidPof5NINgur4kK5xpj2W1AQPV5sMJez2I4UcQ8t0EhAE5SHNSNQOTPie8OhG2j2BxsXjOgcp0PEP0aRE9lkNw83hO232iMNoMuyj0EhJWPrNL4Ps1TipzIllUsyG0vTPpO0c8qRGmBQ0MScS0kS+y8ZaX/yOVrKfw004TDF03SnFaOaj1+vcllDpqDdfE0YG3dqQuH8HeF4yVvyhjCJUxhq+7FpDOR22RelcVLxoP9HUX+yZ+/Vke2X4TL1t/b1milwh1+/cDfqKam746TGu63LgXdLs9rPZK9vqLJg/yZikRUYnCcFPxMvlpwcWOK/9pyKSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIGcHL9nzCUq+PZjq2FjGTvHM/05QYMuJirRff5IxIo=;
 b=CWIEYTPc0jYIZgbaIF0lrdAFiWst4le7tltIH9LHwt0LrvH4I8ZNPMyBHrjfM1TtE8eKiNB8/He243GJV8Zk5qnxqLAL8rWukQiqJKDBXxjwgfKJBZOD1CVz2ZYz7be/gBekfiE32aQN9OPKB1bK2OI8DV6Khkr9ntmkCodYWeFzMUCGG66DBU7KWA6Smf/KxY8vG7iwkT7dcCtk9d+TM1lMa8j2NJI41/Jf81/nOR/Loc/4G0rZzb7tZ+v0QWfWBE7SxRlJcKBDiRCV5g3r3Dr2KZFdQwt1GTqe3lLjbleUIHO8Q/bAix0voUL5f2tqG73a6RfR30777o/Nez3gzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIGcHL9nzCUq+PZjq2FjGTvHM/05QYMuJirRff5IxIo=;
 b=LLLjwBfA06RASsr3JcAdUt20CFUbXYzoc7TNQxuWCzgXxo/y1OSGNT30ce4t5Lv1bilystEaJDtg0igndkmJ4uEmx24t/g5vo91SXYb5mohfsfBHHgq0cgsAPJx4CcG7UOgzPXictAkfgxOEZNYaEAYZpQKVCpJ2mxy0ZCRxwCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 09:19:27 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8048.017; Mon, 28 Oct 2024
 09:19:27 +0000
Message-ID: <52e578d0-a885-4d6c-836d-fc3ec0f491b2@amd.com>
Date: Mon, 28 Oct 2024 14:49:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/10] perf/x86/rapl: Remove the cpu_to_rapl_pmu()
 function
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, rui.zhang@intel.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, ananth.narayan@amd.com,
 kprateek.nayak@amd.com, ravi.bangoria@amd.com, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
 <20241025111348.3810-4-Dhananjay.Ugwekar@amd.com>
 <Zx9RHtFAURrORTrd@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <Zx9RHtFAURrORTrd@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a17a91-9f47-45c3-1772-08dcf7319ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzgxalFaU1FlWEZBVnJUTmY2b1M3ZU12ekRYWnc5Ry9lRHBHL3BlTnE3UTVj?=
 =?utf-8?B?bE0xSHIvTW5zdlNRS2VnS1lzZ0hnazdtRkkxTzFZb05MdkhlUmxVWlhtQy9O?=
 =?utf-8?B?ZWRkWW01QXVNbFR6Q0hHY0pYZjhRY0NZV3VmSEE2bmRHYVNWM2VjeXRMcGMz?=
 =?utf-8?B?TGxxcGtYTWxubGFyMU8zUmlXNEI2WE4rUmUvSkJGaFdCWjJRNW81WTZ2TFJy?=
 =?utf-8?B?R2lYWk50Vnc1U1FBWEJVZXhleE1RMlJPcHd5aDFvZ2xLdENKZit2bEdVeTJV?=
 =?utf-8?B?RFN6ZXRQOWR0ajRKN1lDVVMvRFRNazJrUHlPWjVXbHhNWWE0c1M2c1A2d21k?=
 =?utf-8?B?MjVVNWhHTmNodzFwU0hyNmJOLzMwS2s1cnJiSUhkYUFxN3BNbERsUDZXcTlM?=
 =?utf-8?B?S2svdHBDMHZ1Z0kvZE1RY1g0MjBtSmwwTGFJaXBBUFFaTGgxd2dGbWo3REFD?=
 =?utf-8?B?c3BjMkllTXAzVzVINlEzMUtRemF5NWZwK0RWWFp4Wm9PeTA4aGRrNVpuYWo4?=
 =?utf-8?B?SEF6a2xEL1JOZ0R2ZHdCTFQ5aHc1dzUrU2ZBU3kvMnI4WHFmN3k4YWZmakpW?=
 =?utf-8?B?QVVLUldqM3Z5bjk5RHk2ZUF0b3Ziak0zVnl5cEFRWHNmRDVocXJVMSs5VkJo?=
 =?utf-8?B?TUJYOW02d0VGRTFZT1dkQjI3SG1YWEJWL3ozVmgyRFlnRkJJRFBiVExMMW5t?=
 =?utf-8?B?anRqNXdJMm1hSFBlM2J2OGhMSlJIeGZWNHVSWXRXSW9kQ25TOG5BR0VZenNF?=
 =?utf-8?B?YXRxbk1wL2FsQ2ZsV2I4SG5TbWRXYjVYK0h0akVqeVlzZWtKK3lTSC84eDhi?=
 =?utf-8?B?OFIvc2hGdkhsNG4yZldwRExlbmMwbmh5c2NJZUhnN2dIUXdwVDVwY29yS1hZ?=
 =?utf-8?B?VkF2NnpsREYrNy83cHIyT0l3S2tUeDBNRTlCSHhDekd2d3k1OHkwQUhmWTdR?=
 =?utf-8?B?Wlk3KzczSVZ6Wk9nRkFvM2NsT3BGdUVONnFGNWRWU2trQUhRZ21yNWxjamFM?=
 =?utf-8?B?M29OM3RtVENJR3ZTdkZvQ2JVQWVYU2pmSzVzeEp2K2hHaUxzUnE3OGdwVzlE?=
 =?utf-8?B?UmdrTXFha0hNMVhxOUx1RzRxNkVuSmQyb3IwT1l0dEFMVGNoaWduTEpXUDIr?=
 =?utf-8?B?NjhiQTJ4VnRkYWROa0duOExwUWkwR0RuUzdSUmxseVRmcVRjOXVTNC9GcEpG?=
 =?utf-8?B?SGNqRVA1ZVpoZGw0MGdhdUY4bDh5SFBLQTBzZTJzallRY0cxbGIzeTRPR3Vp?=
 =?utf-8?B?di8zN25xd2JNNG45MDRYWjNNeVQvV2lyVTNhdzFrdW9TWHFhVUxRUGNva1Bu?=
 =?utf-8?B?NStxZGVJNlA0d0FhSnBxWDlnVjV6UmN6eGw4emlzNml0cjMrWExKS1VialZD?=
 =?utf-8?B?Z041ZkwySU5Nd1VPYlMrM09DWjBsd2dubEttOUIxRjlvSVh3TUJ3ZHVycUN0?=
 =?utf-8?B?U3ZBdmx2RDJIQ3RWOHpsZkhRMFc4NnYrcU1aMjZMcjVPOVpzTlFsT291ZTE0?=
 =?utf-8?B?NW5Qdjk1SWVRN25qZkRlMjdJWlZ2dHFjUFk0b0o4N0R0QldCZi9PNzFLeWJP?=
 =?utf-8?B?WVphcXFqb1NSVWhNcHgzVHRHbEJnV3NSYzdQdWNJTDhtdGdNU0hERWxFWlE5?=
 =?utf-8?B?ak1RWDAyRUZUT0l2VFdqeSt6UjFyeVltTW9xN2taQWtyWXpPUGtmVEpENGQv?=
 =?utf-8?B?SFdxK1FYM095WVA0aXRuMzJqeGlVOVhYbzVheERCUGVjZWNML3B1ZWZYN2g5?=
 =?utf-8?Q?5Z3URTHKiUSdAGVldc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkZuck1tcjhaMnpiQW5GTUVSTElTSmR2U0I4cUlYcUsybE1jQkVXUmlqc09S?=
 =?utf-8?B?UjFOeC80L1ZOUUhlTm9QQ1lJeXM2d09CckRMTi9FVk9jbVgyUzFvbERZWTQ2?=
 =?utf-8?B?WDI1bTJNNG9UaFNNNXZMQlRtaS96RC92Nko4QmQyVlJrSEsvL0RGR0g0VDkz?=
 =?utf-8?B?aHBkVklObEw3Y0ZCK0g1S2dOOFh1ZTgzaG5Xam1PQTRKV3VwcGVDbGZUaE0w?=
 =?utf-8?B?WFlsMXl3V2FWeUtybmRpRURHQ2crenEycHBxbUNTL2IzVElwNjZ2MlNHQ0J4?=
 =?utf-8?B?MktudXYzSVlBTTZVbDIvemY1eDhEbWRHYmZqQ3dsOTF3MGlXVjdXZHBjKytr?=
 =?utf-8?B?TTZFOEMwc3NKVnpFUGFXeTBsM2lBS3FUQ1NKL0paNzJmVjVDNkJFUk54bllE?=
 =?utf-8?B?RkdTNEFyVWhRdmcrRmt6WUtRTG5ZZjZ4R21uSERKNlAwakdoUWJycXVSWmx1?=
 =?utf-8?B?RU5QZnNnSzZZOFpib09xQzkwZnFQUExBTGpiYi93SE5XaFZHZWZEWnFudzc4?=
 =?utf-8?B?c2UyWENqbFVSbkcrWDFORXUzU1RGejczc1FpWE1Nb3BVKzZSVm9HTmdlcjA4?=
 =?utf-8?B?M1N1QnEybHhUdjFHczRtS0tKOWZSd1JySi80bzlDSFY5eHFiQzVoVHA5RnRL?=
 =?utf-8?B?U2ZkcitxaGxaVkJsK1RydmZKcW1ZTkVTYUpuZ09mN3FMUmdQaGhrUXlmOEk3?=
 =?utf-8?B?dW45VmlpZ2dUMGIxeHRENGtuTm9JOURpZmMxeEx1QW5WOHQwSGdtbFdnVTNs?=
 =?utf-8?B?RGpqS1paTGZOMFVlZzNUUEhXc0ZYazdacVNQR1o1ZVlOSkNtaklyeGpiZTZU?=
 =?utf-8?B?OTJwSzFzc0d2elVXdU44NEFRZEFmMUpqQ0ZqRWhJcG81d2FjdXdYZnc5OFhV?=
 =?utf-8?B?WnhSRG1YcmVnY2FQM1IxVE8zdmdxU0dSNm9PNDc2UzJjMGNoR2VtTmFSaWx3?=
 =?utf-8?B?SnZhNjFiTDJzcEZxMkZjTEtXbjBZM2Q1QUN0OHlUZ0I4bHh2MExTdTBFbnJG?=
 =?utf-8?B?Z2xSaVFZUExaTlNBcWViVGVscjlZYm9DK2xrbWQ0N21OMjg0TklmeHZIUUdi?=
 =?utf-8?B?RjM4RjNQUWhrYmJIaFZYRVBzT1BRRFRCSlZDWXA1NlRQZS9SVmhkcHRSRjk3?=
 =?utf-8?B?eEcxWFVxaXhWZG8xeFFTUlBIK0hMcklhNUpqWXUzMDM5NE5KSXZGTmhkMXp6?=
 =?utf-8?B?OXRrNW5lbDVoUTZ6dG9SMFBKRDV5VEZIUkhjZkMwV0wvK09iNThLKzhwU21V?=
 =?utf-8?B?ekhZSXljdThUT3lpdy9TZ1BOZG14TzZNd0Z2Sm9taGxxaEF2aE5qWkorMzN1?=
 =?utf-8?B?dTV3bWdvc29pT0RLMExIV3pXL1kxWmJxaFJLTUEwQVZYTG9CUS9SUURrYmsx?=
 =?utf-8?B?ajdQL1ZvVE5vRk03dEJ4djNERzVCZk9ua1pRWXIxN2VJVnRBekdhdDR6N2RL?=
 =?utf-8?B?VVcwS2VwVWloeVUwZ05HQzFRWFp4WUg1NEYvRnNrR0ZzQ0NtVThRZE5SeTgw?=
 =?utf-8?B?M0I3SzVUMExaRkVPSStCdnF3Z1c2S3B3OTVwR2hKWlBNUDdTd2JxTW5ISVVs?=
 =?utf-8?B?ZEVBWFlhZ2pHZW85U1l3LzQrZnlIZzVORnpDS1hUMDdwNDkrd0hzVHBUVnVM?=
 =?utf-8?B?NEgwV25HeWFMUXBkUGFmL2dXUTRNOXNFRVY1eVpHUGVPZy9iQjRhSDFldERG?=
 =?utf-8?B?N1Q5UWRJOEpTd096WDFnTVpKZEVTcGhiNGR5NTgzeUJOR21jQitJK0pwRldj?=
 =?utf-8?B?YVkwbXd1aVlDcmtER0xJUjVLb09tb2VIcnFCSEZtb04zWklaY0dRak8xZmIv?=
 =?utf-8?B?Y0x2dHlIN1FhN1JIcFUxKzduVU1kbytRd01zT2Z0WVRydzhFWFFhdEJESVZM?=
 =?utf-8?B?eHRJUUpiV1FrTDdtWlNodUJpMThPMjJZK3JxZmRSbGxwSk83bExnZ0tMUVYy?=
 =?utf-8?B?RVJMb3NrRC9XZHNRbHdMRUhjQmZpaTlMZFZ3MkUwUmdqU0tNcXFxZG4yQkcy?=
 =?utf-8?B?bS9PNERsSWZTOW1GVUhYWk9UdGdKRkJWbWlBeWVRbEpHQ3JMYjRRbFhFLzB4?=
 =?utf-8?B?SjlYR0FiZHhhWVNXM2pUYXRkbHNxdmJLTzQ1YUt0WFJYdWNLSmVhRm8vVFE3?=
 =?utf-8?Q?yjWgXuHLwSR6Pl3ObbbOqF+NS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a17a91-9f47-45c3-1772-08dcf7319ec5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:19:27.2532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmOcjOgAV7tlIdFvURkLNPAWnxmwEHjCtBywb4/Qx0CY28svO8exj9fJVXUEDqWz/KK1tJaMg2emycGEinN0+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696

Hello Gautham,

On 10/28/2024 2:23 PM, Gautham R. Shenoy wrote:
> Hello Dhananjay,
> 
> On Fri, Oct 25, 2024 at 11:13:41AM +0000, Dhananjay Ugwekar wrote:
>> Prepare for the addition of RAPL core energy counter support.
>> Post which, one CPU might be mapped to more than one rapl_pmu
>> (package/die one and a core one). So, remove the cpu_to_rapl_pmu()
>> function.
>>
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> ---
>>  arch/x86/events/rapl.c | 19 ++++++-------------
>>  1 file changed, 6 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>> index f70c49ca0ef3..d20c5b1dd0ad 100644
>> --- a/arch/x86/events/rapl.c
>> +++ b/arch/x86/events/rapl.c
>> @@ -162,17 +162,6 @@ static inline unsigned int get_rapl_pmu_idx(int cpu)
>>  					 topology_logical_die_id(cpu);
>>  }
>>  
>> -static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
>> -{
>> -	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
>> -
>> -	/*
>> -	 * The unsigned check also catches the '-1' return value for non
>> -	 * existent mappings in the topology map.
>> -	 */
> 
> 
> See the comment here why rapl_pmu_idx should be an "unsigned int".
> 
> 
>> -	return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus->pmus[rapl_pmu_idx] : NULL;
>> -}
>> -
>>  static inline u64 rapl_read_counter(struct perf_event *event)
>>  {
>>  	u64 raw;
>> @@ -348,7 +337,7 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
>>  static int rapl_pmu_event_init(struct perf_event *event)
>>  {
>>  	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
>> -	int bit, ret = 0;
>> +	int bit, rapl_pmu_idx, ret = 0;
> 
> Considering that, shouldn't rapl_pmu_idx be an "unsigned int" no?

Correct, with unsigned int we will be able to check for negative values as well with the 
"if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)" check. Will fix this in next version.

Thanks,
Dhananjay

> 
> --
> Thanks and Regards
> gautham.
> 
> 
>>  	struct rapl_pmu *pmu;
>>  
>>  	/* only look at RAPL events */
>> @@ -376,8 +365,12 @@ static int rapl_pmu_event_init(struct perf_event *event)
>>  	if (event->attr.sample_period) /* no sampling */
>>  		return -EINVAL;
>>  
>> +	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu);
>> +	if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
>> +		return -EINVAL;
>> +
>>  	/* must be done before validate_group */
>> -	pmu = cpu_to_rapl_pmu(event->cpu);
>> +	pmu = rapl_pmus->pmus[rapl_pmu_idx];
>>  	if (!pmu)
>>  		return -EINVAL;
>>  	event->pmu_private = pmu;
>> -- 
>> 2.34.1
>>
