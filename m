Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F73283FD9;
	Fri,  9 May 2025 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746780030; cv=fail; b=ecIZWZKHigZVkzg0hQC4nfR4urxXoUj+p+rUbw0illTp0LhqDPPiooJI7lT82V5hhYTxyLGGeZgIXDCcTiqdke3xxr704/wTwmB/i6qsepOyQYIiSsmTn5aq7iCInuxRgperoELPPGZn9C0bKtT0PD/2EEe4vtJWnLqfI6vMaug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746780030; c=relaxed/simple;
	bh=0k3GiLoFcJvmgHYW2FYR6KcHxtUFG6KtQexlhg6snv4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c7nNwWwF7zYlBQNEwuplF9g+8o1wmsrel4cs8HevpBCUMzQoR1gZwZ8vFw8sdwWHf5EwhEhNRECWYy117K+ygNkYIYbYX+KXqDy1sCKtaarmxE/NRAWICdURFlH0LNDMWKtnKkie9Qn34zxA/8ABsJp8vJjqDd6Lx0jSpEZkhc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A9QlAJUC; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A9QlAJUC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPuUxdYN5CqOELUuH/489k/WsRyv0gc20O3MG4Bd3NVwC/lhmh+3oejgeKXcxvky3olYXmR0J2XmScWeUyxq/0i6iIHR3vutsRfoScLvLBdMtsdiuhGAOVP/Io0mxBnlqMc17U86oGgIV4ULeO4qepCFBQgaIufbK1CAPeLtuLGi14OMQY3+jhdVyXWWNt8DI2m1kjG0a5CtyYr7wTvcgTrjyXLp6jaKuJvL3A6KkJPZveR9PdA1CNwHrrMWDJkuKTAffeUWjHJW2wENqPN03UOc2E24Gv2iNnWYS0//yyETNggFujPCVznOAbW8B5ujhSZ+kHmuB6NDWurwmhQyug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irOY7YXFjdfy0eS7yzePIAl3JCUDl2+bsiwzLJFDrpY=;
 b=ghYEkq2NF5OmZzfguNGDR8ak1CEl9JP9DC21PeG+zcwYn4erEhopLKKj0YI3ivLfyF/wHH0WLSVXut3OoidugWJmmfXy3fH9CMgyZi/HOOFAE+yZRbU/uOF6Gx82hZdAvgVBWHURmDj6I66YLgLh1s+HrZjFefxapQvI++blKHtqsiw04QpECFqM+ULfArxhQPXEXw/E3d1i7rCO7vKXAJQPfSRXdOsSFGjJGDWKt08tPKpTXVuTEWHu433go6q9WBAvjb7Xt2p61BPWiEPnQUQO3VBR50lkOGUurKWMJs1lFwkCibF//JedIX4ml6Kc6DADywGRRFwF+K+WLFy9pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irOY7YXFjdfy0eS7yzePIAl3JCUDl2+bsiwzLJFDrpY=;
 b=A9QlAJUCRpP7WEoGQ4cNFtVdrOmI47w/WW0vl2rX0cCfPLSQlvoKt2+EF4EAUPfmps9ljBwmoBgJFptq1GoBVnN0u74OMo893gCigmf8jpCGnWKbND1pmMZ2+FSDYAZorgW/9U6AcIyEyn7yGbUwH5EBqNzESFZ4ky1akekKAg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by IA1PR12MB8286.namprd12.prod.outlook.com (2603:10b6:208:3f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 08:40:22 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291%6]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 08:40:21 +0000
Message-ID: <8fbf8627-e7d3-4271-95ce-2c17c5933cc0@amd.com>
Date: Fri, 9 May 2025 14:10:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] perf vendor events amd: Address event errata
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Stephane Eranian
 <eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>
References: <cover.1746627307.git.sandipan.das@amd.com>
 <CAP-5=fUEeFb3jh-MtxEEH0Z+HFAD0oxSc4uE66Rfg+BRzYRB5Q@mail.gmail.com>
 <9a76fcc7-a8e0-4b88-b93c-7dbf65bc695e@amd.com>
 <CAP-5=fU3fk79xtNAGwk35PCkiii=QoBdhbzit1Ax9OsEtrPExg@mail.gmail.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAP-5=fU3fk79xtNAGwk35PCkiii=QoBdhbzit1Ax9OsEtrPExg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::15) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|IA1PR12MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd07b8d-8353-4f39-00a5-08dd8ed52129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEs5eUppNG9oQk1ybi90RUtxSmg0UmNtbmcyRUhTWUVWWjVwSkZxNTZwQ0NV?=
 =?utf-8?B?bEwrYzBqbTRvYi90UnpRTzJMdThBZjgrVlFRNzQ5ZW9EY05leUpRNVpjQ3Ru?=
 =?utf-8?B?VldUb1dIa0hZQkhCdmFIaEd5c29obzNXdlFScEMyTEVrQm5FdnNYQ1F4MURj?=
 =?utf-8?B?WE1rdU9MTExHeUJkWloyU041djZUSWRyQzVEbDZsMXdzVEhvVWNOY3B0RWdE?=
 =?utf-8?B?bi8yelI4NFhjMDdyeXRVNCs1YUpkVWlPOEVoaXl6VHJwWlQ2R2NmNUcydi9i?=
 =?utf-8?B?V0ZZRG9VU0VscFNBZTIwMU5RWDJDUGVBMmp5Z0VYWmYyaGNZY3dRd21yTHVR?=
 =?utf-8?B?UFF4aXBaOUxwaVh1Mzc4QXk5elZoZThvU2FWNVl3K0sxVE4wWFhyZHY1WnR0?=
 =?utf-8?B?eUJZU1pZQ2RQblRKOTBwT3RzanowUDNQMGFieW1pVmZrbXdPV3BmS3lPaTBH?=
 =?utf-8?B?Tkx3S2JmVjBJUjdFTmMxNE95VWtvdDFwb1k3cU9kQW5OU1lZeEdkQmFCcVIr?=
 =?utf-8?B?dUpnQ1k1VUd0aUZ4TFpId05HUVN6eEprTGhSbTdGWURxaWN0dTFWV2J1d1Zw?=
 =?utf-8?B?UkVyQmt5M25ldEFjZng1V0xqNkk0bVJmSUlHcDdDd1J2cUVGdHdUWHA5d3U2?=
 =?utf-8?B?MVZqbVdFYlcrVFAwZGRObkpMMFg1b05uNHhvTGsrNlJUMU41SzBoMnBvYnJk?=
 =?utf-8?B?eFF6MHVwMmRlQnVVSnh3elN5L3ArWkVFVERWenJWeGdzYUwzTS95VktlRFJI?=
 =?utf-8?B?OE5TdHFrOUx3NkltaDc5ZnRpRHI3d1BFV2p4Y1ZzOVVFR1Axc0ZJUG1hTytD?=
 =?utf-8?B?YU14WTBaZnc1ZWUvcFZDZ3BPNGd5NVM2VFEwd2VPb0g5d1FSK0Y5WVVtNFZ1?=
 =?utf-8?B?SmJFOWlOTlN3QldsK1lTWnlPeHVoeGdMMU9UM2NLRG0ybnA0MlRFWXRNL1Fj?=
 =?utf-8?B?WlQ1a3pNdk52bW1ZNGpKRzRjWFo1TkhIWVZaeG5uMzQxSFZOVDB2dHpvT3NE?=
 =?utf-8?B?NUwzdWQzSUhsNm9xaitjaXFJN2NqNVhsWnVXb0ExTkNqdnJtTFUrdDZrRDBE?=
 =?utf-8?B?bUdmU09nUENqTmdyOUUzNFg2bmd2S1lyZGdoNnMvdXFuYWRZV01RRnpRMklw?=
 =?utf-8?B?aFdwWlNxcm53eFpYazVUYWV3azl2ZWpMRWNUeWVaQW9HelIxYXBVZWlVUVJX?=
 =?utf-8?B?dE51NFBUUFNxaVVteWFHM0RTOGdRR3NTRzFidXhNa1dodm90MTB4RHlxSzhK?=
 =?utf-8?B?S2gweS95cGlaQU9pV2NxSE5pOEJFcFJ5ZDA3clozRy92TjJFMlN1eTVqK1hh?=
 =?utf-8?B?TEpnYU43T2tDV2IxNXMrQmVDV05TWG1XckkveUF6bDdERkg1cHhWVVpvZ3lF?=
 =?utf-8?B?bnNNamZhZkdXQTI0bVhEQ1ViWFZ0RGNWenE2dzZ1Vm15bkxxT0srSUN3RUc3?=
 =?utf-8?B?UzRLLzhOLzR0c2cvbmdFaEUwYWkrRGx0V05SbHd3TERCY29CZWRXa3ZObnlP?=
 =?utf-8?B?ZWxKTWJpT0J3UWt2UUUzT0RId1RwMSt1UWFSREI0KzNuaXhJUkgyeVRZNVhC?=
 =?utf-8?B?dENXczh5TTVoUVBnVXdYQUp6US9SZWdiV1krTXRjVGljdDJZMkhWSGlyV1Zz?=
 =?utf-8?B?eFZ5LzQ5eWdXV3daWGRvVVFsZjBUN3VEOXZIV2xBQXVkMkVMUVZqSlE5OS9N?=
 =?utf-8?B?V0p0NzZnWG9IeEFXUVI4aEJpODF0MVZXTlRuaVhrUGdHbkZobk9xcFlwQVJj?=
 =?utf-8?B?TkE2SFpoNnAxQUxRc2JaRDRFeVdFR2d1UHNNZHFKYTk3eW9YWDNFeklkdXBE?=
 =?utf-8?B?Y1BMN3BLTEhMeU13QmZhY0JERG1EOGlsMTBxcHRxa24xRTc5aVdWK2NZbHRE?=
 =?utf-8?Q?WGeQm/IQDoEkI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXNtbG1majRoVEllQXBTQWZKTGg0VWZuaWUzSm1JTFlmN1FDbzNHOEVoRjlw?=
 =?utf-8?B?NHhWdmFBNjBPdHhVZFlHSk5MVmh0a0Nya2pPYmZMWXE3d2FDazJ5K3BPNkpU?=
 =?utf-8?B?dFJycWd5RU9sZ0xxbms2N0ZubmlTekcxMDJhNTlCR3ZUb2FoT1I0Rzhoa3JE?=
 =?utf-8?B?Njk5a2gwalQ0QWdsUU1kaGhjL2hXcGtHZFlJMWVUY2VEajdFekNhT0tjNHo1?=
 =?utf-8?B?QUpEaHk4WENuaXYyeU00S2ZSSmg5Y3FBUXhER0dObElKeUxtRDRoNmdTSWp6?=
 =?utf-8?B?T2dKMHFiM1l1Q2dHQzRtdzdITkdubmtLYlRmWGk5bXNYUEpIRVRURVNXYUJX?=
 =?utf-8?B?MVl2VFhHUWhwUmNvRXJYY3dTUlJjUzFLdUw5WE52aTQ0SUM3c1hMekxzQ25Z?=
 =?utf-8?B?eFVGQldodlZ0S25Sb3VzMmdZK1haUWFnMmMyZUxMZHRCNkgyeHVGUy93T2VJ?=
 =?utf-8?B?b1VZWHZKY09jK25XL0tNNVp5dDdENmtjWDdzV2w3QUJGd08zUkUxc3VGUUh4?=
 =?utf-8?B?Ty9NVmdMSEVHWHBTak9qaE1Ec3k1SDRUM0FBSjNqeWU2UjJ0MjFEVHJ0VERr?=
 =?utf-8?B?b2UvQkEzMUl2NlFSTVBLMS9Qa0RrZE10cVoxc2ZFdFB4akNmYmxyUGM5aG1t?=
 =?utf-8?B?M3Z6S01qTjJ1LzF0QXJXd25hYTY2Q1l2TEtub0JoUnJMdVI2UUFONlNSajNP?=
 =?utf-8?B?WWtvQ1J1dUJ3TmZYamtXb0taaU81QVBDOG1NaFVmZGVlZmt1VllwMXFMZTYx?=
 =?utf-8?B?Q01ISVpqR1h0SG1VcFRSRFVxc21ac1h4dEZya0JQNytkcHhQMUNNUng5aTI4?=
 =?utf-8?B?aUhkUy94Sjd4eCtqbkt3eG9tNzBKZEhFY2d3dVdMRmZld3drOEorVzBNZjF0?=
 =?utf-8?B?VGh4MWhIalRwU0FlWjZ4V05pT0JjVHlNYm80RTFDZkdEeVVkaUc2aWpoNmxE?=
 =?utf-8?B?NUtnckVkYXVEUjBWdU1CbTRrdzhoRlpsUjNGa3libWFXWVFCckRUL3NSbGRr?=
 =?utf-8?B?Z0I3QWpnYUFoaDFjT3VVWDBXSk1YWFpEVkhHMTZPTFY2V0oxV2hTWXMvWnRq?=
 =?utf-8?B?UVVPdmYzL2h5Q0ZDVkFiMUthVnZ5UDE2Z2Y1TU5neTFHMU5hRkxoNUY0NUxX?=
 =?utf-8?B?Q0p2bitwU2RXOWNxWGFqZm5qL0ZhVHNPd0YwY2VKMGFWYjM1V1AwVjM0MGx4?=
 =?utf-8?B?RVQ5OTE0RWFqeU05RzY1VGQ0anBnOFA2SDJXMktDOGlyS2xXczZTYzVtL05F?=
 =?utf-8?B?VUVEdWRBYXAwdXR3bHNPcmZGN1hlWHBsQnk3K0FjMHpUUkVZRFJkSHhIamlN?=
 =?utf-8?B?Qkt4ZjZvVVY2MDJoUDUzRHFURXNiN2w1bWVRQllHWXJXNk05RDJiVnF5Mktz?=
 =?utf-8?B?bVJKcjlZQ2tWeGE3cXJJTGJaQWhPY0kxeXJxeGxNYjg4ek9uRnd6UkVBSEhH?=
 =?utf-8?B?TWV5bWNvdE5oU2ZNSlBnZ3A3SjNCZnl0YnRCMmFQT00zM0loclpTdnR2bjl1?=
 =?utf-8?B?VUdGU2o3VFpmL3BkL1ZGMUx2Mm04dHZKc2c5U0JjaXhDSnF5czdLWXZWNlIw?=
 =?utf-8?B?WGhYMlpWczJrc3Vsc3Q4WVkzRzNqMDZXUmQvRWZvLy9IdzBVeTFiYlVwNkRv?=
 =?utf-8?B?QU9sQ3MxZXJTWml1ZEtMZVFuZlFvcmhRU1BZLzAxM2hTckhqQUhjN1JaTis0?=
 =?utf-8?B?cjRDS3Rpa2syMXowZVVzbnA3YU9PWUxCVEYvaVBudHQrYjZkcUFuUWV3M2xU?=
 =?utf-8?B?UlhRbFl4eDd6aGlyR3A3ODRiZjdySmFBY2JONHQzOEhIZ3VUYVV2WFN3UW1Z?=
 =?utf-8?B?NU1FWWlXaTlwdFVIOW9HbHJ0NUh2SjcxdDRSeTN5WUZUMVBTYk5vUytGUjlq?=
 =?utf-8?B?T3IwNXNPNm00bGwwQWVtSm4wK05PN2ZZM3NuRk1XNWxZRkhzQnFJK2FNbFAr?=
 =?utf-8?B?T2dZQ0RhWmlsWG5YNGNoRDd1Zi96Z29UZWNVOXJvdXhWN29XNTY3Y0liMnVi?=
 =?utf-8?B?eUNiUmg3V3NqTDhyM1IvU1RHdTdRLzd3S1dtWDRCYitFY3Y3aEloQkpPcUhY?=
 =?utf-8?B?eEFCVnJNVUV3TDdBZFhldzlGbTlEQ3R1WTZFV2t4eUhqQzQ0QzZMS0RaZUN5?=
 =?utf-8?Q?tcQpBkysYoU+EekxW3kK26wJH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd07b8d-8353-4f39-00a5-08dd8ed52129
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 08:40:21.0765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiTmAqJbHmjLsbIXeeXdA6N1VESiB72ItrC4+PkToWEyXtW7y7PrivvS4K+DMgojlXYsXH8VfbPRn9VVJRshSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8286

On 5/8/2025 9:04 PM, Ian Rogers wrote:
> On Thu, May 8, 2025 at 3:56 AM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> On 5/7/2025 9:26 PM, Ian Rogers wrote:
>>> On Wed, May 7, 2025 at 7:28 AM Sandipan Das <sandipan.das@amd.com> wrote:
>>>>
>>>> Remove unreliable Zen 5 events and metrics. The following errata from
>>>> the Revision Guide for AMD Family 1Ah Models 00h-0Fh Processors have
>>>> been addressed.
>>>> #1569 PMCx078 Counts Incorrectly in Unpredictable Ways
>>>> #1583 PMCx18E May Overcount Instruction Cache Accesses
>>>> #1587 PMCx188 May Undercount IBS (Instruction Based Sampling) Fetch Events
>>>>
>>>> The document can be downloaded from
>>>> https://bugzilla.kernel.org/attachment.cgi?id=308095
>>>
>>> Hi Sandipan,
>>>
>>> the document is somewhat brief, for example:
>>> ```
>>> 1583 PMCx18E May Overcount Instruction Cache Accesses
>>>
>>> Description
>>> If PMCx18E[IcAccessTypes] is programmed to 18x (Instruction Cache
>>> Miss) or 1Fx (All Instruction Cache Accesses) then the performance
>>> counter may overcount.
>>>
>>> Potential Effect on System
>>> Inaccuracies in performance monitoring software may be experienced.
>>>
>>> Suggested Workaround
>>> None
>>>
>>> Fix Planned
>>> No fix planned
>>> ```
>>> Given being able to count instruction cache accesses (for example) is
>>> a useful feature, would it be possible to change:
>>> ```
>>> -  {
>>> -    "EventName": "ic_tag_hit_miss.instruction_cache_hit",
>>> -    "EventCode": "0x18e",
>>> -    "BriefDescription": "Instruction cache hits.",
>>> -    "UMask": "0x07"
>>> -  },
>>> ...
>>> ```
>>> to be say:
>>> ```
>>>   {
>>>     "EventName": "ic_tag_hit_miss.instruction_cache_hit",
>>>     "EventCode": "0x18e",
>>>     "BriefDescription": "Instruction cache hits. Note, this counter is
>>> affected by errata 1583.",
>>>     "UMask": "0x07",
>>>     "Experimental": "1"
>>>   },
>>> ```
>>> That is rather than remove the event, the event is tagged as
>>> experimental (taken to mean accuracy isn't guaranteed) and the errata
>>> is explicitly noted in the description. Currently the Experimental tag
>>> has no impact on what happens in the perf tool, for example, the
>>> "Deprecated" tag hides events in the `perf list` command and is
>>> commonly used when an event is renamed.
>>>
>>
>> I agree that events like IC hits and misses are generally useful and am
>> fine with the idea of keeping them but my concern is that unless users
>> read the event description, there is no way for them to know if the
>> perf output that they are seeing may be unreliable. There is also no
>> guarantee that such events will be fixed in a future uarch. From a
>> quick glance, I couldn't find a mechanism that makes perf stat/report
>> show a warning for named events with known issues.
> 
> So I'm forgetting the flow, but rediscovering it. We do have an Errata
> json value as shown in:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json?h=perf-tools-next#n2
> ```
>     {
>        "ArchStdEvent": "LD_RETIRED",
>        "Errata": "Errata AC03_CPU_52",
>        "BriefDescription": "Instruction architecturally executed,
> condition code check pass, load.
> Impacted by errata -"
>    },
> ```
> It doesn't impact perf stat/record but it does get added to the event
> description for perf list:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/jevents.py?h=perf-tools-next#n340
> ```
>     if 'Errata' in jd:
>       extra_desc += '  Spec update: ' + jd['Errata']
> ```
> which means the perf list description ends up as "Instruction
> architecturally executed, condition code check pass, load. Impacted by
> errata -  Spec update: Errata AC03_CPU_52". We could change this so
> that the Errata is distinct in the encoded in perf json and then we
> could display the errata when perf stat/record parses the event. I'd
> be a little worried about this breaking things that parse perf's text
> output, but the impact would be limited to Zen5, Ampere and older
> Intel CPUs. We could also make the errata output conditional on
> passing a verbose flag to perf. Would just `perf list` support work
> for you or would the perf stat/record changes be a requirement for
> keeping these events?
> 

Adding "Errata" tags to the affected events is a good start.
We can sort out the perf stat/record changes eventually.
