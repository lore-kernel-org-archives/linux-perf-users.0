Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB38132122;
	Thu, 21 Nov 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204724; cv=fail; b=Mg9djYaWe6QlGt0aI++sVVB4oYg1cSC1IkOiqSFmomLJdm2GCdZm2MrAYDeCiWP+HW9Qd36yPIXO6lH4V9hPMv3DV9HTg7NBIHglPL7UtAA6Hfpr/B880I0JTnGWkON6hwKxw32BWyiy2vOiDojGCOjWKcHrNljEiREgXhk+ioE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204724; c=relaxed/simple;
	bh=cgGkN2kD2NOxHe1eTsM1Gk8swvwrHrj7M+V0UnWthHw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fAtSGzL848WwFO0q2pokTDjUKu8/ESLrGRxrOHTL8eUb00BoBD+plA/xZgN1qkL+CzomfZwDgaFefL0uCKRB4Jx7un7YXKlXYsznOmS71rkiRFcRjo9+xbRvS4kj0P/37G9atOn0c3CTHb9J4R2r3FDMl4if8yTLlqGU7lCQHrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iuMXEbBy; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iuMXEbBy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8osqMNhz7ZvO8aQVXldnBZY9GH2h7xqUss/UlJ5f1NffrCvWaQpPZiqqrL6A8kvk8aQizHJxc4h3AYXChQkcVmGAIgMNW6NZikMBp5Ib3u/86og6xKGC5hQ+7P2xBWFNcNLBsippSEcYB+fVOHQjvQcZg9bcbTYi9W6TIi+6iKn3yteK0ZKDLpTg3f9tso5Am57ZUZNDIKukIW444Zgfr7eolT2gt7vOwZ085SFYYhsvjkJq7n4TxQNehoxzZ5F73iZbEIgSAw2wI2XYpgqsMmUiFeKCsK+LDthh/3K/l2i+42P4gfgtkcI5U5uEaPq/t+V3+U3ho5wNSFx8c7+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axj0BIITLzkBK++GG6kG4MmVrPK9ZAelxfsbh54KeJA=;
 b=W2XFjb0l3BE3Aa/JVyUIzEkEwtpbWFS8yUbOAeiuIIEJqOumvOSJ4A+VHLd0XYmM4dplfKCHWNwxF8RjA/KuWuX6d3ID78YLGo5aXS2Fd5eb+KkjvRBZ4fCerJqpD98cu2eDSbXxkrsi6yPb4WW0sYjLdUf4hDwBwCXMiVgHcGM0fxdDLhjcFYtnqYSc0uN+J2ezTKxnyUMLNOYpUfYhZvM07i4TEtmnXndNlNdsHT2CixT03VZWnNHbfNth2CqldgeMipOC/OPXt/acIQm5GDLGdJevfrFUcQH3n0gOGgOkMmbX9qVruEEcOMJUsusiXfE4Z9A2RzvPYQ7MlU9NYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axj0BIITLzkBK++GG6kG4MmVrPK9ZAelxfsbh54KeJA=;
 b=iuMXEbByeC/5pAu4N9CmtGnVKosTd7/ykEZJ4nhq0wrKfBAN9/QUfjoiPl89+sw301goyWVF+hKimk5HxJhtSC9BzVyleAQzn3024PnBt4EsQ43O9GcU4ni8yLeogLWFFf8iVFaguziNc4EUOl2b4+okGp87KSkdl76F8dAof28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Thu, 21 Nov
 2024 15:58:37 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%3]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 15:58:37 +0000
Message-ID: <76af0bc2-fecf-4f5b-8c52-924f49ac9b7a@amd.com>
Date: Thu, 21 Nov 2024 21:28:29 +0530
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
 <7eaf557d-7e85-4fd3-abee-f84ac01d92c1@amd.com>
 <f90ee4f3-704d-4776-99e7-04f30969d93e@cachyos.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <f90ee4f3-704d-4776-99e7-04f30969d93e@cachyos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PEPF000001AA.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::10) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: f36a0ee7-a298-4a38-406f-08dd0a455c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUNXdlhsd0pjTm9VOW5kQ09BY3g4RmV3K3hMd3IzbHczODlRSGI4NDNyRm9h?=
 =?utf-8?B?emF0ZDlZaWJGSGJvYys0RVdna0hBTVZ1L0MvVVFSWE8xelhGd1BsdnF2R2RJ?=
 =?utf-8?B?TFZTeHdVLzBoUmV5V2dtWVpzUy9wYjZuWFg0UGJVS2w3MXdNenJCMDlFSHI0?=
 =?utf-8?B?TEgyaFh3V3hiMGIrUTJ2WXVhNjUzclAxYVV1Qy95TVBRQUdLMzduU1FKWjFO?=
 =?utf-8?B?Z1MyL3ZJTXhaTWxJNUdMTUZrVW0zR1pSYVhPc1RndEVXVklPVWUrVE1ONjNY?=
 =?utf-8?B?RmVpWTNBZk5XVGU5eGUvaUlBdDBNRDM5L1AyU3lWUTg5R2ZZaVFPMVRJbjdh?=
 =?utf-8?B?b3FXQkVUQUd4SGxwbklrWVpXLzBEZkR4WU0zVlh1RlFqS21RTjFuNjVmVnlE?=
 =?utf-8?B?UjdsaXd0QnFLNElCaGhuY04xNEwrcXlzSW1jeG90bFJHb2F3L2JiTE5PLzEv?=
 =?utf-8?B?R3ZRT01ZY1N0dGtRTzhicDh4d2Z3NERMSzg0ZkhHUS9xQVF0WkdnWDFBMG1p?=
 =?utf-8?B?THM4ZmE3NklaRGdHYjRFMlh2ZWFMTStvNmozWnpvdmI5c2ZNV2xBNDFzazR0?=
 =?utf-8?B?dE5OaFcwcWNqTU45REw1MllOdWp5MUQ2SkNPNkJFc01rdFJDbU5nSzc0T0Fq?=
 =?utf-8?B?RVdZcUNrYXk3ZWRDckwzZ1BQU1lFYjFQSjNVSHAwcGhhZ3NQVDFvdXd6MjlN?=
 =?utf-8?B?SzlHNDIvSDVmOWNCS0czQXNGZnhpdmdXcTg1dkxWaVl2WnNaYnBlVGVLc3Ix?=
 =?utf-8?B?T1I0REw1dUNnSlpIZnl3YkhRTWZLZkJGbE4vbFRhK0h4WFZiSVIveFgwbjhh?=
 =?utf-8?B?d296eE1vU1pCcWR0UkNKUDB3c3c0cjd5SmtQbG5LanZSL2FudjdGdjZRUGxE?=
 =?utf-8?B?bldubG52UDNVTkpqcjRXQzUrYnI4d05HRk9UcUd3cFNkVWlOVnZjcjVaRGVt?=
 =?utf-8?B?eWVrS1VRSHY4elRWNWVjVUFtNTdrQi9QWjNwVTFtQUliWjY3eFIxemVYZkY4?=
 =?utf-8?B?NzFJTXlEeG56allpZ1hRM29XMDVad3BsR3g5RlQ0Skw2bTZzVFgxcU5nWThq?=
 =?utf-8?B?YlNRSVR2cUNLZnlvL0phTG5sdWx3aUpYZldjYTBMUStDcXhNYmY5a0dxUHkr?=
 =?utf-8?B?dTcreEZlL2dTd0EvVUhYbmlFWWMrcmVzVmFWRGFDREtLcnl5eWhuSnNZM21x?=
 =?utf-8?B?OEV6Vm0zZytoZjVZWjk5azFiZUpwZUk0NmhDK1QyaDg1K1lhR0ZvbzB4S2ZC?=
 =?utf-8?B?S2R4VzVtTnlxZUUxQ0grN3IwQ0JiVEpJaFR5SXFmMVdYZ05yMkk4SVduaWNG?=
 =?utf-8?B?bC90VVNZMThPQm1JZ01QQmRQKy9ZNi9jTXJ4YjNHejJvZDM4cUdQVzZJbkZN?=
 =?utf-8?B?REMzSjQyWGR1RG05VWJEdldYNjZpT0t5Ry8wWkVGdUVEa2dib1NaTUoxVlRr?=
 =?utf-8?B?VGRUYzdyQUlCODNuWS85N2dtVVdRY3BIblVKWkdLb3RaNWNZTksvb200aFV0?=
 =?utf-8?B?WnVqamN2QVRpOWhjczZzMVE3Ukk3cHUzSlpGdEs0V2EvWmNuZXhYSWJpcTNU?=
 =?utf-8?B?VkZLNGNuUmNTanhYVkMwNkRLSGZpU2VMaHBlUERLMm5MWUVzbU12azBaSUFX?=
 =?utf-8?B?SVhlVS9rSzVnTnV4c3E4bkFPQ2JJVXdjS3J2cnVrdkFHVThjTlkyL2txWW5n?=
 =?utf-8?B?UkE4SHVhWVczdlFUSGlPcUVjbXlVSURva1FvMmhDenRmeTZjSVA2L24xdlRC?=
 =?utf-8?Q?WVDYDZgAAYMcal2UbK1vpYFLqdYPmVrublNdFtF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2ovNjE5OGZqQ1dNNmdyVVlqK3l0MGNlQjdERFlWWkpCTmpPUVZNVlBCZ1dQ?=
 =?utf-8?B?RzRUaVVEaGZwWitRYk9SN1AxSUZOV3ZENURLZ1JIczBMdldDeHc5QWR1dEQ2?=
 =?utf-8?B?MWd5QnhTMkYvb0ptR2dKYXEwOXhVTWFXbE9lYXc5MzhrT3puaXlDVVhqdnIw?=
 =?utf-8?B?OHMzN0ZTeUQySEROOUl0M1lEV1pyNTV3NzVXMnB5RmJXZWY4bmlBaFBoVHdB?=
 =?utf-8?B?RHZIdjVDR2lka3JaT2htQ25zUzQ2TEgvcGlNaFBIVC82TGdRdmRuejdtb2Iv?=
 =?utf-8?B?dWdoZVlIYk95dkdZazUyUGo4L1JXcFlFeDJyWlFSY0xBY2ZkSmd3d1VsTlVu?=
 =?utf-8?B?dkVVUndkcjU1YjhoZXlMOGtzWFRia2hwMjNhS3NWK0FqRWlIb1dZT1hRbUt3?=
 =?utf-8?B?clluUHF0dG5yUkhHQWJaT1BNdUcrbkY3TTV1dWw0MnJpSnpXMHJoRUpjdS82?=
 =?utf-8?B?Y2Z5RDhNSE1iM2Y2VlhDKzRJdGlkam5VUXVJcEt0NERtYnN3N1JlVUlFbEtl?=
 =?utf-8?B?cXBFQVRKYnBDS0tpRmVUeDliRStZK3BOOE9kTFhMOWw2aEdtYUJERFB6dVps?=
 =?utf-8?B?WVlvQkhlM3JYSDZDTzRQYndmTTB3MGJuWEJaUnpGbDBHUlVyeDVmNStBUG5L?=
 =?utf-8?B?Tmd4MFhVd2Y3OWtkazd2ZWhDeEVPNHlyZGV4d2o1dlFxeG5WYVdwSXpBL3cr?=
 =?utf-8?B?U1R3OC81WGQzZXh0Yzg4UFhyVEpHOWErZnN6a2k2TzFibjA4R2RuY0c2UUNL?=
 =?utf-8?B?WkJDbDhhMTBBOGxDaHJ2c01RTERxaHJLdDlJdVJsb2p2NjNWUmRHc2NObVd4?=
 =?utf-8?B?UGJzeHFTQzdKVmU5bTlyMk5KWm5aTHB5Skt4RUVaVDJqOVV4T0hydVBoR044?=
 =?utf-8?B?QldrZFRnS3JWQ29HVkZaQW1GNlM4WS8wOVFnQTJlN0FJK2NmaGNBRjZLWjEv?=
 =?utf-8?B?TkRCaGVNa1BSRlhlUVcxQmF3ajhiWmNRSFQrMXRETmRPSzdmaTgrUGF0S2U1?=
 =?utf-8?B?QU4zZGpydUE1eWdOYWJleDh0YWFkTWNtZXZheGt4U3huTUx4M3lkeTQyMVNi?=
 =?utf-8?B?dDBydGxxdmdmOFVIT0VrclFIMDQ5TkpJVXRxZExIVnZ3Y0NheUVIRkpLRUtX?=
 =?utf-8?B?UEJFM2FtOWJ1S0V4QnlJbHQwVGZhNGpsc3FzMVovMG5lc1Jyc0ZjcG1mVW9v?=
 =?utf-8?B?ZTJpTStTODJNQWxkYTRxRU9QT0ZMNFpPUUc5aEpPM24vK3VFL0NSbnQwclhD?=
 =?utf-8?B?cFlMUGx0YVdzV09NRDV0YkR4SUhwQWwxOXZKblZsZ29wbEhCVjAzWCsxdWh0?=
 =?utf-8?B?NWE2VGs4TVNTYTV3ZEZ3Y1VTdEFKb2hvL0VEYmdPOHB3SG85WXhaMXlKN1F6?=
 =?utf-8?B?Q0JPVlJRY3lzZHZWZGVxRjZTVWN3TkhRWXdsamdaZjc2cHdvemxBVExEbGNy?=
 =?utf-8?B?dTFFNUxxSmFzK3U2dzJkbUE2cWJDWHp0bzBqbzR6dU5SWExSWTJxUlh1RmFI?=
 =?utf-8?B?NjZDTitlY0UwRDNRMloxQTNHeDhUU1VCcUl3amxNMHFlbGlUS0lEd2M5cUxr?=
 =?utf-8?B?UnVjeG00Z0V3dDBaaTlvdXFuelhPU0pqanZ2eVYyMW5QSHNQWU5WdC9jSjJU?=
 =?utf-8?B?M25Pay8zd3dLZVVUbUoxSVZsSzBCaEozdHVHbDNyanFvaDhFVTJ4V0NDMFlj?=
 =?utf-8?B?MEFZRDNxRHM5SVJsRjJkMkdvYXRDOEVSektpczdJWUxjWEFGTDhLNzJkdU9X?=
 =?utf-8?B?MlpwWXl1cWdhN09TNU1nQUtTL2lDMjRtdGpnT0JWSEgwMEVLOXR3MkpKSHg4?=
 =?utf-8?B?S1I5SjRWVS92aDFlMjBsVlBnUW50R0xBNFhXTXdlN3ltcGpmdzQralFGdENP?=
 =?utf-8?B?QnllbXY4eFo4Y2NMc1A3Q05za0pWV2ZVRUtIc1RjS0NhaFNDR0VZN1ZaWDdM?=
 =?utf-8?B?RGwxQUxmRjhhcHVFeDlNWGtZSkFlOWJiTm5wNk1zZGJQSTFUVzZIelFndzdr?=
 =?utf-8?B?UUJZVDlTUjhJa3lDZi9NSXVPNFUvQVBUblNkcEJBeko3WG1TaDkvMDMxVUth?=
 =?utf-8?B?TmpkdUVyTUtyVzlpQ1YwWDhTZEd2cEhjUlJkYU1kMEVYNEdzRHM4c3UwaVJC?=
 =?utf-8?Q?vox8ihQ1bi9W/QZDIj8eCN/Yj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36a0ee7-a298-4a38-406f-08dd0a455c4b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 15:58:37.7389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnBdit4ISGSBvXdDVFlqbTiZb+JiUWj5uAI2GEAYOdgZQLTNDmvmvlig8t01t/2+q0kqvfGCFzRJFyctKQdo/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675



On 11/20/2024 8:00 PM, Peter Jung wrote:
> Hi Dhananjay,
> 
> On 20.11.24 14:58, Dhananjay Ugwekar wrote:
>> Hello Peter Jung,
>>
>> Thanks for trying out the patchset,
>>
>> On 11/20/2024 1:28 PM, Peter Jung wrote:
>>> Hi together,
>>>
>>> This patch seems to crash the kernel  and results into a not bootable system.
>>>
>>>
>>> The patch has been applied on base 6.12.rc7 - I have not tested it yet on linux-next.
>>>
>>> I was able to reproduce this issue also on the v6 and the only "good" version was the v4.
>>> This has been reproduced on several zen3+ machines and also on my 9950X.
>>>
>>> Bisect log:
>>> ```
>>> git bisect start
>>> # status: waiting for both good and bad commits
>>> # good: [2d5404caa8c7bb5c4e0435f94b28834ae5456623] Linux 6.12-rc7
>>> git bisect good 2d5404caa8c7bb5c4e0435f94b28834ae5456623
>>> # status: waiting for bad commit, 1 good commit known
>>> # bad: [372e95a40e04ae6ebe69300b76566af6455ba84e] perf/x86/rapl: Add core energy counter support for AMD CPUs
>>> git bisect bad 372e95a40e04ae6ebe69300b76566af6455ba84e
>>> # good: [fd3c84b2fc8a50030e8c7d91983f50539035ec3a] perf/x86/rapl: Rename rapl_pmu variables
>>> git bisect good fd3c84b2fc8a50030e8c7d91983f50539035ec3a
>>> # good: [96673b2c940e71fde50a54311ecdce00ff7a8e0b] perf/x86/rapl: Modify the generic variable names to *_pkg*
>>> git bisect good 96673b2c940e71fde50a54311ecdce00ff7a8e0b
>>> # good: [68b214c92635f0b24a3f3074873b77f4f1a82b80] perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
>>> git bisect good 68b214c92635f0b24a3f3074873b77f4f1a82b80
>>> # first bad commit: [372e95a40e04ae6ebe69300b76566af6455ba84e] perf/x86/rapl: Add core energy counter support for AMD CPUs
>>> ```
>>>
>>> Nov 17 12:17:37 varvalian kernel: RIP: 0010:internal_create_group+0x9a/0x4e0
>>> Nov 17 12:17:37 varvalian kernel: Code: 7b 20 00 0f 84 cb 00 00 00 48 8d 74 24 1c 48 8d 54 24 18 4c 89 ff e8 15 8a 99 00 48 83 3b 00 74 59 48 8b 43 18 48 85 c0 74 11 <48> 8b 30 48 85 f6 74 09 4c 8b 5b 08 4d 85 db 75 1a 48 8b 43 20 48
>>> Nov 17 12:17:37 varvalian kernel: RSP: 0018:ffffaa5281fe7868 EFLAGS: 00010202
>>> Nov 17 12:17:37 varvalian kernel: RAX: 796772656e650073 RBX: ffffffffc2a642aa RCX: f781ec27a963db00
>>> Nov 17 12:17:37 varvalian kernel: RDX: ffffaa5281fe7880 RSI: ffffaa5281fe7884 RDI: ffff90c611dc8400
>>> Nov 17 12:17:37 varvalian kernel: RBP: 000000000000000f R08: 0000000000000000 R09: 0000000000000001
>>> Nov 17 12:17:37 varvalian kernel: R10: 0000000002000001 R11: ffffffff8e86ee00 R12: 0000000000000000
>>> Nov 17 12:17:37 varvalian kernel: R13: ffff90c6038469c0 R14: ffff90c611dc8400 R15: ffff90c611dc8400
>>> Nov 17 12:17:37 varvalian kernel: FS:  00007163efc54880(0000) GS:ffff90c8efe00000(0000) knlGS:0000000000000000
>>> Nov 17 12:17:37 varvalian kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> Nov 17 12:17:37 varvalian kernel: CR2: 00005c1834b98298 CR3: 0000000121298000 CR4: 0000000000f50ef0
>>> Nov 17 12:17:37 varvalian kernel: PKRU: 55555554
>>> Nov 17 12:17:47 varvalian kernel: ------------[ cut here ]------------
>>> ```
>>>
>>> Ill do on the weekend some additonal tests based on the latest linux-next snapshot and provide some more logs.
>> Can you please try with the below diff once,
>>
>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>> index e9be1f31163d..d3bb3865c1b1 100644
>> --- a/arch/x86/events/rapl.c
>> +++ b/arch/x86/events/rapl.c
>> @@ -699,6 +699,7 @@ static const struct attribute_group *rapl_attr_update[] = {
>>
>>   static const struct attribute_group *rapl_core_attr_update[] = {
>>          &rapl_events_core_group,
>> +       NULL,
>>   };
>>
>>   static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
>>
>> Regards,
>> Dhananjay
>>
> 
> 
> Thanks! This patch appears to fix the issue, when the kernel is built with clang. Thanks for providing such fast fix! :)

Great!, Thanks for the confirmation.

Regards,
Dhananjay

> 
> Peter
> 
> 
>>> Regards,
>>>
>>> Peter
> 
