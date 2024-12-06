Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA6B1EC010;
	Fri,  6 Dec 2024 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476040; cv=fail; b=ZX9b636Kc7dLeIsBaXhhp8sX0bKrKUbWWQPFnWPyLHkh6L3pEAwVrdxovrDSQLBdUBw2ovTAQHZXJn6n/0QPAdfT/f4jnUrNFlEQonLa1JpX9YxYGJDfsqIlUotraUYnwzksrkbp49IUFMSGOcD8hbAzYm0VSqh+qHgFQ4pZDqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476040; c=relaxed/simple;
	bh=DwXMk4PMtZaGRHDpSW9koyGNnxfVi4PVWXFX5CPZ9KQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OH9ExXlStxKObuIoMmmyVQTz+xFZgvardjnjcir2OJs78oL7R3FeSaIy2QPHao9Flg3UPKkRc9M5VTRvY9Z1FqWnj7qj3KbBx93vKM/M2WX3wOFdvJIcRikhNpeUbxWNx4p3Y1kE8PzXHzE699d4UWxwOmnwqcjU7tcMcCZfDpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vuwcapfY; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vuwcapfY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ti7yvyRNI4xomfrauW+Ly/wjQ90/JUZIJcEdi88nM72S/c+OwNHLaRTECLZpPoNeSm15P1F3NN1ST7Mb89K1HCu1EhHJTDRVu9W0znW/h1k9FaooGI4zPPPE5xZnts4/BwCAOJkLKTMZirsijzGSuuV8xQNrV8mreWBSZ1ROLteDbJXmrGXEG0PGd1sdjhvOSROGZbGpnLLa0lXibQYPEDzs/7haNtRhRLl7fH8xBSbJmJquAE8/pm1Rh/Kn9aug8+ZtYdJVrYvnctTT647HKAvNnIAf1N5v7UQfb3P3xQw0O9jF5A/lFzm6mu78Es7qus761/4SBSmlRKowLWIuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfgASD12dOwk2VN84fpu4JuQ/HMDG7Vzj3iLUD0jwCg=;
 b=k6k/k2mETPzSTydQy3gIsparpKRAHnFVl8QFxWVJcqecM+AfjnXLcHu4AjWBUl1oe6MrxByuMJCzELKvKBsEtHMWKfYzaPKQQu4/HeWkYptEXDVDL6R5bqHw10DIYc4J+R0rLDasgornTjcDsMvys0Jvs4LkdmjpQhYAm0fBGyOra+E9ZdG+QbIpkQSmfn5PGhyqeSfUNJWGtZisOyEtHinY59pa2hWfTbVw7eoI4X6NCMaYvXGAnX/qYs3zfPXIa9dXycZrzvzgK/f5l+sv4rAouv3m/rDfnQDLW7J670svDWI8V/fMvbZaVvZDQChEgAVDZmEJ0Zajmk8nF1DvaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfgASD12dOwk2VN84fpu4JuQ/HMDG7Vzj3iLUD0jwCg=;
 b=vuwcapfYL0PdEgrorkRcCuGbr/zZZ9scEPQVRXN3t9E1kg3261d5ofEq0A23++oNAl4GiAgWQqETDb/BSyKRPtZJUD4qRigeoIrSVCPASyeQ+5mNYLwpKrb5lIYqEBs0UABIAjnRqInsd48R3EATZHI0s3fR9CPqgVIE3cNxiDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB8779.namprd12.prod.outlook.com (2603:10b6:510:26b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 09:07:16 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 09:07:15 +0000
Message-ID: <abe58150-735f-4d9d-8ff4-a20b0fc6b376@amd.com>
Date: Fri, 6 Dec 2024 14:37:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] perf/amd/ibs: Don't allow freq mode event
 creation through ->config interface
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 acme@kernel.org, eranian@google.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241206051713.991-1-ravi.bangoria@amd.com>
 <20241206051713.991-6-ravi.bangoria@amd.com> <Z1K6IckahmlME6Py@gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Z1K6IckahmlME6Py@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0226.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::9) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b7896c-145e-4892-73cb-08dd15d560f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REhPd3FWbHVaSjJDVlA3ZVdOdUJlaHl2Y1c3bXlTV3d2UWJSWldjaDlrTWp2?=
 =?utf-8?B?ckowOXJray9uYmNqbllBZi9rVzhZMmFFOXA2dnNRejN5dExCYWw1UlAwNmI2?=
 =?utf-8?B?TEVvWDRqOG85L0ozb2R6ZHRVbVM1R3hXVDNpWnZPeUIzVDJkVCtlb0hFZ2Ev?=
 =?utf-8?B?QUNXeUdXOFNOdzdBcUdLSjZlUmRjb3FieGNPTnZaQWhtUkZObTdkblh5T3ZG?=
 =?utf-8?B?WXBIYVU2VVExTWRIMmpPdEpFZUFWNytrVXowUS9BbEZSNkNUQVkvRTc5eURR?=
 =?utf-8?B?OTdOSzgvdGpDS2NhOGltaGlQeVlYaEU5ekRYYXBmSWlydDFxZTNSSEN0dTVY?=
 =?utf-8?B?OEo2ZUJHbGdlS1VoSHFNOHNFY2ZWNHNIV0lzQXYvVnBtS2xrMTA1R3hNQTdU?=
 =?utf-8?B?L1RWQTYzcFhXc1lCTHl6ZWNlcFRzODZHK01XdWFjUkpDYnFJUmdUbzVXY0Iy?=
 =?utf-8?B?S3ZZVXlsT0lvbWlEMFpDamxwaEFpMkdnbncyUlpvdldYelhPcVlpaEY1ando?=
 =?utf-8?B?MHpZQjJncnlGVSs5SXFzNkloV0RyUVdKdlVNQTRycUd0VVB5NWNQbUJBa0xO?=
 =?utf-8?B?SDZyQjNscXZEOFhCMlRTa2RiMktzNzYzM0FiMm1JdDIwd0ovcEx4TndjYzg5?=
 =?utf-8?B?U01uQklYYmRkbzB6T3E2Y2V2cDFwZ1FGYllpRWhkci9aTUR5VWVzYUE0TmlI?=
 =?utf-8?B?ZGhVWmhVa0s2R1ZxL0I2SzFhdG1LcERxZTlkL0hoaVZFMjQyRnRWVys3V3RJ?=
 =?utf-8?B?M0MyUkRtWjJ2SUZjUnBzMHpPWjRHL3JHeFRHeGw4VG9wc21wZUJFdFVJcGQ3?=
 =?utf-8?B?alU4eVNHSFE5YU91TWN6eHowRno0a3NGdmcrckpmTlBaRTFvUHliRzU3d3FP?=
 =?utf-8?B?cGcrOE80aTViMFpWYVYxZllOTEwyS2hLYkNxQzJDZzBYM1lyWVA0dUZNZ25K?=
 =?utf-8?B?RkdqVEZNU0RqZW5hbmFVMnAwRnFuSG9KK3YrUG1WZUVKUWR3enJiaGJCVUJh?=
 =?utf-8?B?T0dOTzJDNjVsV3cvS3gvT1prV203bThjTnZvZ1dHTGZEZFlQM2VpcWNLZnBU?=
 =?utf-8?B?a0hxeUhEVWtIc3BrWlJrZHM0TkRwcUYrdGpOL2pFQ2x4NXRPdWh6ZkFVSjJN?=
 =?utf-8?B?VlVER210TnlSNkxPSXM4S2JSMFJlTG1yYWNzZmMrMng3NGdCeXJqaXFqVXdl?=
 =?utf-8?B?cGlRSnkzNFVXUlVhcW52RGltWXZ2SHUrNGhtanc2c2JwUTlzWjZ0Q0ZBV3p5?=
 =?utf-8?B?RUZ0amI5LzZqN0crajl1eVdEbTU5OVpPMi9JYVNJZXJpa0hIRzU1S2tWdmNS?=
 =?utf-8?B?WVNQdzQ0Yzg5RlZPZHBXcWxDQlRpcFZXb212cGx5K3NvakRxWkNYTVJrcERO?=
 =?utf-8?B?OXR5Nk8vQm91ZVBvdmlEVWFRbHNYTGRUY2dSMmYrS2Y4M3lxSkVyd1k2Tjg2?=
 =?utf-8?B?eW02SnhsZElJSklqR1Z2NnVPd1hWOXJzdGh0WGVDUmpLWDQzb05vYUZmTUx1?=
 =?utf-8?B?ZDh6d2lDK05jb2I5dXl5bkFscFNYZUVZdWlIci85WU1FLzMyelBjeHNIUk9W?=
 =?utf-8?B?aGJRTnd2SVB1NmZ2MzJHWDQxb2FGR0pFeDk2L3lyV0IvdjRqNlgyeW1qUW03?=
 =?utf-8?B?RHJBUFdubGJqU3hpR0k0SEpsVGphcEVzSkdsaVB3VHBDYm5DQTdFQWt6akpj?=
 =?utf-8?B?c2VZZi9Xc3RuaHNLYnk3U0dXR1Bia0FyME90WGl3UTcrdEM4NXd1OFF2aGQ5?=
 =?utf-8?B?UXM0dGkra0Fnc09pN3RoSGNXaTdPRGtjQTd2RStOejJYR2kxTEZMd0JQcVFa?=
 =?utf-8?B?d0xveldhWnkxNlQ1VjJNUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1pOTzkveWV4R2pjN3BuaFZLZ011NldDd0dncW9DQk43cFlid1VLV1hFYXZE?=
 =?utf-8?B?d1Y3RFNlZmY1Q04rZkMzTENGcTEvRnVWcUo4QVd0WFZDdVp6RHdVb3lpNlJz?=
 =?utf-8?B?Z2Q0cXhCZnJQUklGdG9LTTcrTmk2OEppQnU1TUFyWG9ndUFNUEovN3VZQXBO?=
 =?utf-8?B?bFJ2dTQvaUUvRXpYazZtZHVYQkVNbVZWT3JjTlBreHhhMXlUZHRPUTZzNHdz?=
 =?utf-8?B?UXcrWG50RWsxK1cyZ0RxenN1MWI0TGx3eWNkTXp1bzAwS3dqOWxyMnNxeUV1?=
 =?utf-8?B?eUNPSUJ3TFNjUXVUS0ZWUHN4NThidk40ZEE0TnczcThFeWpiMDRReitRUVVz?=
 =?utf-8?B?TEpLbFM0dDhzNU93djNTcEFaMUt4M1V4cGlTUU1UOW9YNEdCMkQ1REloakc3?=
 =?utf-8?B?VEIwZkZMSDZJcXBIeVNEbTVKQmlGbUZZR0lSWVlaYnpGWGhsTkZEY0h3RmxR?=
 =?utf-8?B?a0NJMGMxdkZsanJqb2ZVdGJOYitIbWhydlJBRDBGUEhWcVZGMzcySytTSkVm?=
 =?utf-8?B?NDRiY0tBOXd2VS95SjZhWkg2QndyUmhLaE1qbzVwaHExcFd3bXRoWE9VQktZ?=
 =?utf-8?B?dmZaR2RlS1Y2Z0dsd2g4bXo3UzVmbHdXOWF3djhCdnppM0VaM01tNWpYMXBy?=
 =?utf-8?B?TTJrU2REUGYwOGw3YWUxbEZoaWdtUnAyaFBwdVJuVmkwVExnelpnTnY4VHdp?=
 =?utf-8?B?TUNIbXpSb3FKT2I1aFNqcmIzbWRCa0N3dnQxNHlmcTl3ZnFaV0dIUlRDVXFC?=
 =?utf-8?B?N1JDOXJpamp3QjNKaG9iY2t1OG1vSFpHVHVhdi9Fd1gxcjgyVlZnVFcwRCt2?=
 =?utf-8?B?Njh4NFZmMEFMVnBjL0RQRXVUcXVXbTRqRXMvSVJXL0tEeEJmN29SSjVDcGlD?=
 =?utf-8?B?czI0QkZxQUt2Y2t2ZGVSckNxVWFUamxuRTNKSVA3S3IvNlBZeklCNmgyYkJF?=
 =?utf-8?B?ZDNBRFpsb05yalU3M1dvRm9FVjV4Tm4yc0d4c21uMGdScnR5NkFDbVRVd0lP?=
 =?utf-8?B?dzgvWjhBTXpRY3pwczRhZHZOcENzZDhXVlhuMVhDcGJ4MlcxTVBPcG1uZzMx?=
 =?utf-8?B?aTFxMmpmTFU1L0JxZ2FWYzlkMFVwYllUZ2FWcHo3TmhxZzhzQ1JzZGxpUUdl?=
 =?utf-8?B?Mk95aENzZmpSQ0U3MC82WUhzQ09FZmZCWHAwblRsR3B5dEhvUHpvU0cyUmhh?=
 =?utf-8?B?cmxGWHYzV3Z1a1FoeFVFZFVFWnFUeFVEcUlkTU55Z0pOcVI2VXFnSlA1S25W?=
 =?utf-8?B?R3Aza0orRWJ0eU9TbWZmVkN4NUJMaDF5cFRMK0NmeDd1REZYOTB3RXlEekpL?=
 =?utf-8?B?ZjlZRllmcElhZ05yYVFVOE1zZDYxVUNYNGp4RVJHbXEvS05EcE5DNk9MUkpa?=
 =?utf-8?B?ZFFtTllDNnU2S3pyVmlCdWh0VWhVeTlMaE9pYkY2V2ZoM2VpNUZOMThZbjhE?=
 =?utf-8?B?QTlrMFVSenlQVG03S2YzQ0t1V3F6WS9zNm9rRnJFaXVNOWVEQTU2Ykl4cDZ5?=
 =?utf-8?B?MFJic1BvekV2dHl5M1lVaTVKWGZsWmtwa0NuNkQ0UDV4REVwZXhvTXZuaTU0?=
 =?utf-8?B?a3FETlRHQkQ3eEk5cENrM1RHREFmMmNQb1VzTlU5VjVWbkxJWWZsdUZ0NHJm?=
 =?utf-8?B?Z0JMai9ab3p6SXZHOGlvSElqNm5tRmV4NytSRHNJaG9XUDV1T0JjTmdHWlBS?=
 =?utf-8?B?dC92QXdFMktmdytDbCswS0FlamNpNHlQb01WRU9md1A0YVBMY1FUc0d5M2pm?=
 =?utf-8?B?Mk5HeDEzVlVxUnRjdW1yZWZoZWZZa2dQRFdBVTl1ZGtRMW1oc1JGMTlodDdq?=
 =?utf-8?B?VW93QTI2b2NabDFpZGZsVlBrd2p2dDU0RjV4S1N5Y1lFcTNNTllVODNNUHhG?=
 =?utf-8?B?UUhjYmRlYVlnSXpvVFhFUExTQk5HM2FqL1NjWjRrZmp2NS95b0dPWjdsT0Ns?=
 =?utf-8?B?azVXUSsxc0l4dlpOakN6dXhBV0Izclg1QzB6cHlnNWlTVGVDZlFFcy9oZy9H?=
 =?utf-8?B?a0xPRC9YYjFqMDI4KzRBWEdzdDFHN3VJL2dPRDJrcWw3RDRsVldTaStzQ1lK?=
 =?utf-8?B?cGNRTXJvUlhmcUdBUlFEb0s2ZmpCeHdyd1REUlNjclJXN1pMaHZWMnBxWVF1?=
 =?utf-8?Q?EzPdqLKku2dl2/piHI35F8Dya?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b7896c-145e-4892-73cb-08dd15d560f5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 09:07:15.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcUSW060z0KmiXv17bQpEUsKAR00/3BqOdQ233H4vVLd/0Knxa4zN5sroVMvb7TUKCmWi0H+bfYZ5mMRiFMP8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8779

Hi Ingo,

>> Most perf_event_attr->config bits directly maps to IBS_{FETCH|OP}_CTL
>> MSR. Since the sample period is programmed in these control registers,
>> IBS PMU driver allows opening an IBS event by setting sample period
>> value directly in perf_event_attr->config instead of using explicit
>> perf_event_attr->sample_period interface.
>>
>> However, this logic is not applicable for freq mode events since the
>> semantics of control register fields are applicable only to fixed
>> sample period whereas the freq mode event adjusts sample period after
>> each and every sample. Currently, IBS driver (unintentionally) allows
>> creating freq mode event via ->config interface, which is semantically
>> wrong as well as detrimental because it can be misused to bypass
>> perf_event_max_sample_rate checks.
> 
> Then let's fix those rate checks?
> 
> AFAICS this patch limits functionality because the IBS driver would 
> have to be fixed/enhanced to support frequency based events?
> 
> I'd strongly favor fixing/enhancing the driver instead, as 'perf top -F 
> 1000' is easy to use and it is a useful concept.

No. This patch does not prevent opening an IBS event in freq mode. User
can still open freq mode IBS event with usual interface attr->freq=1 and
attr->sample_freq=<freq>. i.e. 'perf top -F 1000' with IBS event will
work fine with this patch.

Thanks,
Ravi
