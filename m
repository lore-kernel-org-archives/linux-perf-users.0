Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CD41F63CD;
	Sat, 22 Mar 2025 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638546; cv=fail; b=H68jqm6hQ2d+PKKFJarZuKA1nljcuJDGerXfFs978f7yhe00UjtsNaTolcC9ba8/qE1dUQxic0lChvIF+Whbc/JbVPSoQ9MIjqdW+aUgA6BTMXDihvFKA3rnuvVmYJFJ5niuXscXzv2N0YGIW3mEXuC2xcCPUJB33cUVmTOPCj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638546; c=relaxed/simple;
	bh=dJh8ZYs0F/yRaEEKJmS+bhv43t6arvFyhrlr2EHNUVc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c94CuiGApoNeJLXr3f0jaksCBgilOAoGMuprVOPOXt5HWFkFNnQB2KrDa1ECrv76ytwq6C+32ju+F5XIRWRHgFOHdVnMHaRzzks9smbdrYfTK1a4N3yl6lLwh30N7BecOnb3IR9BujA7Y45FvPRJY0jynmpVpTqLQIYnY2am/LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a6ilJdy7; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a6ilJdy7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhZR1hlzgvVdACoH4jYB4dnjlYNoDQA6v0OVe2QihEaWfDSkiNHnN96/ZK4b53zMUFjbb79XLd+LGpGxB62mm1jkdGez5Wvj51/w9QPmG+09EnyZpV+9+9poLJv1NjK42rRIwjrfszL9/trDubb3ypTywWtitgzEJt8qulrftImiJ+1tmM9hH38bRoyEFljTUEDYrgdVtcEvg57YRci5Lzmiw0YHby/mt57DlME91Qgz5lfA8rK0FBRN3Bc0QUL1DIb7at0HudMMBv55IGg9LYe3ajzLCiDSXise7cQBGgkPjQp9Kg7HnbiV++Ajz271xK7niudwgy33BzTXxLoqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFJ4H/lJ45nEA5CdS5l/ZkESgzXuYcRtdbnOt243OoQ=;
 b=vyt78AztgGQ5BI5eFuFdqFRHmW807ANbo6BeLb/wC6n0GJINB+vPSuSr+4BkCF67GQaF+YJcbmdsqbfmuvw85R526tn28bgfkY3D2kDY7VJofBX/aZ11W67s638e9ppJQayp6/BDWeLzv25QZIL7z/HRY+tOqoF6haxGYdVLfd36dlsI70WSyvJcZTYtwrfU5uo0QV3pgKd0MniBFpaYLQDw8e261yMiJ2PErpskLfmy99erZ1fmDKG84borGNd7RihKxlfuLqSXPf5UmipkbSQNLs+yrfmoZ5upulAQGDX3lxkqDfoPbK1z3PUiyLftjyysCUaUf2JaT17KSSeKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFJ4H/lJ45nEA5CdS5l/ZkESgzXuYcRtdbnOt243OoQ=;
 b=a6ilJdy7B6esHtlpnTReh0E+gfThjgm1nSaVXttWHFarDzNTDMWH5YfJlHxFSqs1pUChzc2eZqRM9S3jSzgCg94+6/DRbB52zFxLXgOo3s89V8qTLhoiiaGrQcSrVBKs+c96fGpOVuiYT/xAjo+z9PfBk3pg/iiMAQritmhvNvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Sat, 22 Mar
 2025 10:15:38 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 10:15:38 +0000
Message-ID: <7c9a00c3-b2a0-4f8a-945b-cc90e492988a@amd.com>
Date: Sat, 22 Mar 2025 15:45:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 tip:perf/core] perf/amd/ibs: Prevent leaking sensitive
 data to userspace
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, namhyung@kernel.org, mingo@redhat.com,
 acme@kernel.org, kan.liang@linux.intel.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 matteorizzo@google.com, linux-perf-users@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250321161251.1033-1-ravi.bangoria@amd.com>
 <Z95lo6J37emCRvme@gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Z95lo6J37emCRvme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::22) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: e28e0a26-f00c-44c6-3814-08dd692a7df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFE0eTIxekdlcEpyVXF1U3d2WWtZSmNPbWFJVC9mVnNHMlZ6Vkgxenp6dEIx?=
 =?utf-8?B?d2dmRUowcDhraWJ6amNVVkpNLzlsV1RvdGcyMTQ0OGZsRng3cGUvc2pnSnJQ?=
 =?utf-8?B?c05iNDRaeXA1ZlZYSnpFY1Y4eDduL2hja0lSZXJpVjRma0c1THM1K2RiUzdL?=
 =?utf-8?B?QkNaOTJLUjN1ZGNFd0dYeWtSNk51NmNGdWxkUzBja0RNaVhrR3poNG90Yi9V?=
 =?utf-8?B?NWxyL01rMG8wV2FDemRvZ3lzemJEK3JmV1dOSkhOMzdnS20rWDdOVG1WSWdz?=
 =?utf-8?B?RHVPUyt6UnJVWFBRRllKZTQwSnVTMDRwd21XMTdOYkdEM1VZL1RRQkoxM0t1?=
 =?utf-8?B?bDA1Y1BPMXZPMHVOelUvN20xeVNrUldoWk5hL09wNElvYTV5NVRibmJNZkxQ?=
 =?utf-8?B?SzFFVUgvZDRNNW4xNHB4VTYrY21yNWc2cDlZUmphUHNSQlJMZXlBbmFtSkx2?=
 =?utf-8?B?MTFweUxyYk02UE9xT3V1RHczMlB5R1dVNXVwTjVuOTIyY2kxWGRTQ0duMHVi?=
 =?utf-8?B?dE5YTTVBRWtGTHZZREh3Mm1xdWR6THFHck1Xa3hHZ0cyRjVMcHNoaHgzTGpy?=
 =?utf-8?B?NE82Q1hmVFZ1ZDdtRFAyRlh0bkZiQkJOYlFpenducmJGd29QRW5yLzdSM1lr?=
 =?utf-8?B?V2VoUWptT2o1b2RSb2NKR3R4ZTVQaFpFOWJ0TERHc3JLTXZZWlpsRjJnREpK?=
 =?utf-8?B?UFU2QkZZWDhoNlloYVpVc2pMNzdUWStQc2ZrS0FJSDVPYWhqUkdaalVYL2hj?=
 =?utf-8?B?Q3VYS0N3ZC8rVmZzMXB6TWp0TmhnVmlSaTdMbnpuMWFMcEczUUVXaU9pVTZs?=
 =?utf-8?B?aC9nTm5OcEVpNzllZ1NUbkErTG0rZFJSV0ExSHZlUlVIL3E2cU5NVjdpK3pG?=
 =?utf-8?B?dERZdU0zTUZwUXQ3QlJmd3lxOFRwdUgwL3d3M3dXRUh2eWpmTzNib3I2Vkoz?=
 =?utf-8?B?QzhoTFFvSVJDZ1lpWWJaOUtGeDlRdFBnUmFEQTU1dmZGTmZ5K2lHMUE1NWp0?=
 =?utf-8?B?c2cyYTVQU055NEZYSUx3SGwraVQ1UExwbG1HK0FyQnJWMHBHSm9RWHpkTThW?=
 =?utf-8?B?STROOXE3elNhb3hJbVVOQnc5dXcxRit3NC81RlE1d3hoSlRZTm5pMEl1Yys0?=
 =?utf-8?B?S0tFamd1NW1hUE9vdlQ2bCtyVkJvaktHU282UTBBWndWNm9kU0h0R1c1dEhr?=
 =?utf-8?B?d2pvdGlyYVpXRmhjelV6SE1yRitCN2UxKzBKRWJaZUtPT2FPTmV6Wm40WFIy?=
 =?utf-8?B?djlBUDI4Mlk3VlB6OUl6YTVmNTRiOU9ZeGlPMmx1SVNBL3grWStnQmQxOHVK?=
 =?utf-8?B?aVJtWndpM0J6SzBjcHVsVU00RHNxK04xUFd6YXgvZEtIc0I2eVo2eEZiOGY4?=
 =?utf-8?B?dUtYM0ROd21ubTU4OXBqVVI3dXJuNVdONWw4ejdrakJtaUk1YXU5dFJvTWh3?=
 =?utf-8?B?R3ZWdDZYSDRGR3BwaXZZUWJMVVFEejRNOGYwUkZuMUFxNFRZb0lWOWYrSHpP?=
 =?utf-8?B?VVBaVzJvbkdpR2dJakx0M3FocnB1Qzh6ckM5L3pwakVGaWZ6c0VBbjNaZTdD?=
 =?utf-8?B?cDZwOEdOeXJ6djRBZnBFNXJSdlVtQ1VmRGQvUFVheVNLOUViUlRVZGFVQmR2?=
 =?utf-8?B?bmJ3L3ZDQmRRL25Sc0dpZmlCeEZveUVEeTQ1MkNxdmIrejVvdklLaU9UaHpJ?=
 =?utf-8?B?dkt1dWV2WWVnMFkwM0pnMFNJWS8vQk9yM1I0YjZZNEJrVDBjenYrdGgwVStE?=
 =?utf-8?B?bDdSVENKRWRlN3E0ZHlrM0hEcVNFZllXbVduSHlQdUtmdUR0aTJldlh0RGht?=
 =?utf-8?B?UGpTbU9oZWtUcTZ1SkJHNXVrR0xlUFh2YVNQVlpnakdaOHIvVldRTXMvSTZM?=
 =?utf-8?Q?h3Ez1B8SJKScJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blhxTUhrc2RLTFcrZmlNWFlzejJoN3F2aG1DNlg0N2s2Rjk4MzF0cFVEeUg2?=
 =?utf-8?B?cjhVM2FNL29CZDZaV3JvNVY0SVdEZzR3bVFYV0gvMWxZc2laQzRZZFFza2NL?=
 =?utf-8?B?bWRvSW1adUtoUHZzSWJsbjBucjZRaVIwSnpFcXlJaTZSTlpwLzlmekJZTEdF?=
 =?utf-8?B?dTRmVFYza2lQdEhxeWNlK1FKUmhQUzk1YWlmeEpVaFNOcmtpU0o4dVI4NW5I?=
 =?utf-8?B?VVhvL3kzNnI3SndZVGVCMEtzTllPM05IanExTmxwT01jUllFTGN2YThmUkhQ?=
 =?utf-8?B?bmJ5Z0VhZXJVUWVyeEFjT0c3TzFIb1pLY0ZRWDV5c1phUm4zTTlFcGJnTjdl?=
 =?utf-8?B?dUp4akRpZ2Q3UmFEdTV0c2xiRHJIeGdOUmxRN25SOVJDMVJ1NlNnR3Y1aC9F?=
 =?utf-8?B?dVRkcFdIeFZLNXZCZUFpc3MvUFEyRkN6S0hzR3pGQlA0aGNWdW4vNXJLVzUr?=
 =?utf-8?B?M1EwTW5wYVpnS0JzK3UzNlhTQzU3eE9za1hxcU9PRktyTTcxZTdLZFdEam1m?=
 =?utf-8?B?a3JrVnNkZlNvMjNNUjlFMENwNHJoSWRKU28yYUpjVld2c2t3UjRwOTN0eVJW?=
 =?utf-8?B?QnlaZG1uUFZOcDBGaG1uWW5RTTBNREZQMlVVM01JNzFUdjM0RVd2cjZ1ZHEv?=
 =?utf-8?B?TnFJL1lONWRIUXM2Y1krRGt2TWhVcitFU0crb0M4S1pjaC9Pc295SURUZUg4?=
 =?utf-8?B?d2xoNU5YQnZTOWhsalV5bkY2RFRGT0V0dnk2clNhSFZGbkZqdiswNWZSb1JN?=
 =?utf-8?B?Q1hjVDhwZ1dHR3FhZ25NNVNtQURqQ2Y1RnIweEFoWEdQbTlzRkRhWERkdXAr?=
 =?utf-8?B?UVZEc2JtNG1jSG9LaXF1eWVGWHI0elkvcTBybWlYRjViZjVVTVZJZnk2TWEz?=
 =?utf-8?B?ZWdXVVhkSEg0Q2JaSWlRRVJFTFp3MlkxT0xsMDNlczRyZTN6OUpnVGRlMW9q?=
 =?utf-8?B?T0tHVUQ3YmZ2TmNXYkt1VWdZdHZlYUpGeUVEb1pTdWlIQlRsb2dIUlZ5NjhK?=
 =?utf-8?B?UHBuUmtTRVNONGw1VEp3YXhNTmlwUnM2Z2RjMERXUXRUNm5zejNqcUFaY3FR?=
 =?utf-8?B?MXJiendvWDNDQjZGdCtRWWdXYUFzdDBSZE5tVXdZNGJ5cmdGR0p3WWNVWTd2?=
 =?utf-8?B?NE5YeWJid3gzOWRzelRkZmg1NXNkLzJwdnRqZ2ltckxwSUlmR1p3dlA2NG5J?=
 =?utf-8?B?ZnFqQ3lib3J6MWp6Ulg4aG9CeGhTUkhZTm1aYTJTMzBCbW1MaGF2dDlCazl6?=
 =?utf-8?B?WGliVm1mYVYyWUd4bEl4RGZpa3pwaHd5Y2FLTlN1SnQzWGtiV1NFQTBEUmpB?=
 =?utf-8?B?UW5CRWNOa1JuOSswTzJxV283MzZtbENBZEFUcG52S3ZML0JIRVlSSW0rbXlq?=
 =?utf-8?B?UVNvZFhudVVCdHdYMW9ubHF3MkNlMFVEQkswM2ZpbFdDSG9Xaks0NlNBY1ha?=
 =?utf-8?B?ckVwT0V3WEZaV0lIbVV0VjRqWjgvSXlXTDR2SHhaMHpBc3pDMVNXMFpCelFO?=
 =?utf-8?B?cnVMRFRhdVZzMlYrVHU3LzFRVDBVbFBubm5XY2loZGdwejRxbjR0QS8xUXRW?=
 =?utf-8?B?cFpQZ29FYmsweTlmTVFSaHBGVUt1aVR3VHhwM2prcnJnVkpsTHVtTlJ3ZVRC?=
 =?utf-8?B?RFRobGVsWkwwMSs4NytLUXAzZXJaV3F3elFrUFJKSGJDRENBbGtuY2pXQVJz?=
 =?utf-8?B?bjNyZ3RxUU9MT1VBekJxeFJnN2lQTkpiU21aWGlDL0J3Q1N3TlNDdTYrY2NK?=
 =?utf-8?B?S0JPUUQwczd4QVpQNjNYT0p2bjFLKzZGRCttQmdtOE5jVm1GUytWTDFpaGJ6?=
 =?utf-8?B?a2Rnd1VtTnVJVktMZkpKdzVOazAzaDBINTNObWZEMkFxc3NrSXBBWmFZVExr?=
 =?utf-8?B?dk9EaEVqTkNybW9RZWdBemRIdExxa0ZsQzBCc05XUVV3L09Vc09xM0t4QWs2?=
 =?utf-8?B?dUIwbGFJcmVaOGRRbFNtRE52cDd4cWdMTTlNdVd2OEIzSWNDY2w4dkFpSWdx?=
 =?utf-8?B?Y2lnTlVENHR1SllnU0xkdUdpbVN5am1ULy9hNkhpVkNCU054bkx3NE5jeFp1?=
 =?utf-8?B?NEVkanYzRzZDaTducFlhSTNqcHM0TTlWSkEvcmRReUMwc0N3b3I4eXExamZV?=
 =?utf-8?Q?jr+nzE8XyUzNVks2GYLvYv6U8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28e0a26-f00c-44c6-3814-08dd692a7df3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 10:15:38.2913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSbZFjUXpNZpL38lsoA0pIGsq4ZL4ErY3w7gCiSSfHGYhG2C+rczUWA1rR3AkpQl1SVOpfjl3I/KmfcH6WwafA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642

Hi Ingo,

>> Although IBS "swfilt" can prevent leaking samples with kernel RIP to the
>> userspace, there are few subtle cases where a 'data' address and/or a
>> 'branch target' address can fall under kernel address range although RIP
>> is from userspace. Prevent leaking kernel 'data' addresses by discarding
>> such samples when {exclude_kernel=1,swfilt=1}.
>>
>> IBS can now be invoked by unprivileged user with the introduction of
>> "swfilt". However, this creates a loophole in the interface where an
>> unprivileged user can get physical address of the userspace virtual
>> addresses through IBS register raw dump (PERF_SAMPLE_RAW). Prevent this
>> as well.
>>
>> Fixes: d29e744c7167 ("perf/x86: Relax privilege filter restriction on AMD IBS")
>> Suggested-by: Matteo Rizzo <matteorizzo@google.com>
>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>> v2: https://lore.kernel.org/r/20250317163755.1842589-1-namhyung@kernel.org
>>
>>  arch/x86/events/amd/ibs.c | 76 ++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 75 insertions(+), 1 deletion(-)
> 
> Since the initial fix is already upstream, I created a delta fix below 
> for the PERF_SAMPLE_RAW fixes in -v3.

Thanks! The delta looks good.

> How well was this tested? v6.14 will be released tomorrow most likely, 
> so it's a bit risky to apply such a large patch so late. Applying the 
> -v1 fix was a bit risky already.

I understand. Although I've done a fair bit of testing and ran perf-
fuzzer for few hours before posting, I'm also not in favor of rushing.
I think it's safe to defer it to 6.15.

Thanks,
Ravi
