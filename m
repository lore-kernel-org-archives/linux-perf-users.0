Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2129.outbound.protection.outlook.com [40.107.94.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241351B81A8
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2024 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953180; cv=fail; b=RjXL+cy9VOo1IP42mJSTDaFYGrJlfj2eQhBpC11TOX/0d8oSRJbmSS8EemEw0fPmLbii+GgOcCrIc066yWWed8e8xgjudqqhQiR0ykW6a6SonED29U7qPPXkw6EVybeaBNuWR/lh2YuyUYRP6vRaSRFRuvgbfhDyp9sKdOFhkjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953180; c=relaxed/simple;
	bh=M9w7fDpkaNtEaFRYnClTeRs9INbEPhe7C/4CCozwBV4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HNioYjF0h2pXnKoATr3a5UJCJwsvqElUGiM0hCi322Dz4P3Ib5SxGZecqtAu8fm8tK/PrZfVcwdRBAUhTShjAMSBhPyhp1bLZmoIhkpJFKCiKirVa20a2ES+RtwQHnQft41AFPhtQPEgp57DREjPRJyQUKwEE8HpDlIiSiO+E+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=dopXYy4S; arc=fail smtp.client-ip=40.107.94.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="dopXYy4S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2U5tJi4stQsoe4Q20TosGwADjR2RXddi477CvqKp7PWrGhBvZqq82UL7JhTFR8M31SIduTCaqQ1moW3ZwwqXIrIJi13m+F7Q84qoNp+APsTgo+GVlTswsgAuAOeXmgDerTM5KxrXm/7rPgxURRiS/IvJQcG81G8Nl11xJpYuvKAMCwpY1tN6lNIuXI0H8ugsEQkWAD9tE0cm99L9/Js60SorWyL59OUDJzd5sdO8HghiCyBA/7GsJ8OEP0R6oPbvJPxPkKV+/e4vIFSvJOLzyaJeyxDdh+xCRhmT6gd6jCS36OuBkKzvd7Yd5fy6uCk5NQhZ9SiPJQJqK/yaZaj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+axp2xUZGPxXB0vkwsnadaEbXu/kDLqZDEIWuNjeFk=;
 b=S5IpaaxlpoLNJNDCh/dDqL/sq42u/8wHbVzWvfCi44vDYvmLqiNcztjOw3XxAC5cWnarMOyag3Yh8QqlcCkKJcbfwbwFWGvvWXLaoY9lXQA+Y+NyCOMDN79X7CWvR5kW/0dtgU1HFfQCI9sD4KxAIT+pfxs4IE9g7PKQVsn5pY9+jF/Hx5ACr9z9j2u97infoArsDOSAEAjfa8mJvTP1YXGlxYnh+Pa8nC65YektlYu5wilmryBC6G9QdLS5JdZM4iwVwn7+ARFFb6k0t/jFs1r4oKh5+ekzQNpOcCsrpEu+80tR+sJViSPOGCUQUxPYSnOvsVKc1mLMgX8/d8lxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+axp2xUZGPxXB0vkwsnadaEbXu/kDLqZDEIWuNjeFk=;
 b=dopXYy4STRxdYOTEoN30GU2MBoA1HfjPwAsy0X453/6XkUOy1lnGfFnPz59RUA8vGnfsB6Z45dog8X86HAqqwTMzd7zlLS1QiP3g6JKDuRu84jKCyf4pvfN8qXuXeGX0nC1k+CaKdA2ulHV5rzqfRykrgMCgVz+6VpZWCG5l2kA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 LV8PR01MB8479.prod.exchangelabs.com (2603:10b6:408:18c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Thu, 29 Aug 2024 17:39:36 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 17:39:36 +0000
Message-ID: <01419593-056b-41e9-a3d2-6ac490f7734a@os.amperecomputing.com>
Date: Thu, 29 Aug 2024 10:39:34 -0700
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V5 0/4] arm-cs-trace-disasm.py/perf must accommodate
 non-zero DSO text offset
To: Leo Yan <leo.yan@arm.com>, james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724879699.git.scclevenger@os.amperecomputing.com>
 <cover.1724879699.git.scclevenger@os.amperecomputing.com>
 <35c19a0f-580a-4d97-b0d4-b8708a4dbdb4@arm.com>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <35c19a0f-580a-4d97-b0d4-b8708a4dbdb4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::17) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|LV8PR01MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: a6468d82-cb07-4027-fdbf-08dcc8518cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZExtQ2V0ZVAyV2kvdnFLOWxJbzRJb0dwcjl2TFRxRklQbkZLN0dwMGZ3Q2oy?=
 =?utf-8?B?SnNONU5SYVhzK3ZuS3FOazRhYVM2SjN0aVFNOUt0WnRiRmQzNEQ2R0NlVDVL?=
 =?utf-8?B?YkFjMGxNMUVrVkJ4eHhOOFVrLzZjVWt2dVlRbXhZYXYyckhySUZVQXliVlp1?=
 =?utf-8?B?bE83RTEzeGNYQVdjRnpyUDFsdmJTNGFTZlEzZHIreWsxZ09NY0pjOFJTejRJ?=
 =?utf-8?B?SFhwcjVDaFZRVnY0cDZ6RzFIek9oV1FMaHA5RkluWThQK2VNeG5YM2NBMWVa?=
 =?utf-8?B?clFoWDJXRGV2ZHRNQ0V4dkQwaGpraHo5UktBOUMzN0Z6Uk9ySFhzMEp2UmRq?=
 =?utf-8?B?ZWgvR3VaeXhWcWZRdEoxU203cHJUUHVINDVxRFN0L3F6aHpDSHlyb3E5dE5V?=
 =?utf-8?B?Y251d2F2THRjRldWTWZFVm5BUmNudnNib0QvdFUyQ3FxWTdJOEwrOHVuTUxT?=
 =?utf-8?B?b2dYNU9NSE9HNzRVQkxmVlRDYXdlRTUyQVhTUXh1QzEvZm9lQk5STkRWVnpW?=
 =?utf-8?B?N0VIOWhUVGlPY0Vhd09Ld0YxU2I1T2s2MCsxbXh2SlZpbm4rOUY4THkwUkt0?=
 =?utf-8?B?NGRPTzgxc3NqOEdmTDhaTkhqOU0zWTVDTXJUckhvTk1vZlYvRlErNzdHSm5m?=
 =?utf-8?B?UzBDYmVPa0d4VWlSVFdGWTFmd2tGS3kvdHhuaGV1QTJhSWVwa2VndTRQNnd1?=
 =?utf-8?B?MzhCb0VOejBTL01BOXNEV0k2bjNyMjIyUUNrcDNvWVVoL3RyTnJiZWloc2xZ?=
 =?utf-8?B?TTljMWpudjdGc3dqeTZIdFRSc3NyZ3dNTjNYV2pJN01sckZjaGptNFQ1M1hu?=
 =?utf-8?B?MVhPdEkzVTV4aU1nMy81dldZRkRsdnovNzRhZXBKOERaNGZuZ3NTTytkZ3Np?=
 =?utf-8?B?K2tOVmFVdXd4Q0dUMDRnYlJYck9YcytIK1pxMnRtbmpKeXAwZlVLaXE1cW1y?=
 =?utf-8?B?WGQxT0IraEZuVVN6WmdzZE91WGtvaURoTVo4NTYyM2QzTFBMM1RhdjdYRHhV?=
 =?utf-8?B?MC9aajhvTGlUL0lLZUl2OW5iSVIrRGJJWVB3WEE1RTJMNytiTmViL3AySVJ6?=
 =?utf-8?B?R3ZzK0tDS2xCV05aYTVNUm1zaHRSOG1VdW5zcTVtalUxUzJLdzNtZFZXckF0?=
 =?utf-8?B?RVRyeVREc0NBdUJwMnVBNG9CZmhDNG9QZzVKWkxnaWk5NHd3UGRVNTRXUHRz?=
 =?utf-8?B?NktvOEZ2Qjk0T1hOV2JxVzZSa2h2dmNSMXNKd1d4QUNnQjNVc080aUdON3Qz?=
 =?utf-8?B?bXF4SURscDJDMEVkRzFNd3lpSDI4bE1EeGN3MDNkZ2dUdVRROWtUUVhpYjdG?=
 =?utf-8?B?Q0x6NzMzUldrbCtjVnFuVFlRN1hxb21zTzcvRXJZSlNWQXh6MS9uOVBiUnRy?=
 =?utf-8?B?NkdLTnZSQUUvQkI4djFsZVluQUdHYlFWMmhMN0JZSmp3emZjUjE4M0QwVWJp?=
 =?utf-8?B?MUhpVURMbmxLZGlvNEtucCtpV0UrcDhmbEh0eCtLR1FkTjJjazFUd0dUR043?=
 =?utf-8?B?K2dhU3UrRWVEV1dydnBHMEtxcTNDeDdkdXRwWkxibksxM1NlVXQ2Y295dTVx?=
 =?utf-8?B?TlUvcEwyT1dHRXRIWDJza2VSSWJJbW5CcmpoWFZzb1M0TS9uNy9mbWQyMXlP?=
 =?utf-8?B?UkowZUxUMmdUalc4ZmkwYktYTEI4RnZaU3ltR0VON0orSzh2bU44QXZCaWhS?=
 =?utf-8?B?Wmt1TzFlT3pScnZCK2ZLQTVyenlTMVdxYlhTczZVMTY1c2tJRmxzZ04rQTVl?=
 =?utf-8?Q?WBD5WJUqvq8+d1qNJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTBiSkI5M3NSbE9aeUI3SHBNM3QyamdEZjFETTBFTVVLT00xZWNFeEhUN0VL?=
 =?utf-8?B?UTNOVnRCb1MvWGd1YU81SjRPeS9pNitUZTdRdW1rWVhOa1MvOXloQTBXdVN6?=
 =?utf-8?B?VTdVcm0wZXltSXVVRWJrNnhxY2hXcldaaWQ0MUFSM2RJU2FFclNSWnFqL2Jj?=
 =?utf-8?B?c3ZJeVpqVURSVTYwRjBoKzRtTStKaWs3ZlFwZlF2RDZoUEdNWndZcDRFN20w?=
 =?utf-8?B?Q2pLUWFvR3VkaFNGWm5GY1g4dWpiYk8zcCtnOWdtZnFNTWozdnNZZ1NZNlEr?=
 =?utf-8?B?dW9Tak5UYXFIQUViYVlyZjl2KzI1Y1VUekZBbndld0tJajF6TEtwMjczbjZN?=
 =?utf-8?B?MDZpNU9QTGZUZndRaFMrZU1QWHNnd0tBUHhleG1SbkZiNDg1aUFPeS9RZlVy?=
 =?utf-8?B?QmJwNEhYdXdLVFdHS3pUZi9PRElhWjNIOXVVRHFBTExjNXhHcTJxTWlnVjNW?=
 =?utf-8?B?K3pZU3V4aU5SRUFrQmE0UU5BeldVNmpkYVBkSFFMK293dnFod3QwdE1DcDdS?=
 =?utf-8?B?bFladHhRVzVMUFdvREh5azNKUVRXTUIvV21aalBrRlRNTWdLbmMxZnlrWDcz?=
 =?utf-8?B?dWdKUER5Mm5YRy9peDQ0azhvU005OWRDVXZTb3F2Q2FBQ1VWQ3I4dFMzTWM3?=
 =?utf-8?B?VUk5WGYwTUZrZDR4TWNWTU5STkZDanZvcUpZQ0JhUXFTUFpWNHQxQXQ1YXR3?=
 =?utf-8?B?RjBsV2JvcmRwc0pjZ0RaeDBCKzJ1c0p2VXBGSWI4dXdQM1BCYWVoblF0U21n?=
 =?utf-8?B?c0JrM0hFcTVCZllPK25aR21UNXBQNGprQXBwQytrWnhXQldxKzdOSHpIR1pT?=
 =?utf-8?B?WnZzR1NSbWpSTEMwVm4rMERvQ0RSTGUrM2s4cFY5bWtZc21SejE3ZnJDWTFj?=
 =?utf-8?B?Rk5NNkdvdnpaaHBaTDNHZFNJVmFCeXhMS2FLalgrN2VnVE80Z2l5UDk3M0k3?=
 =?utf-8?B?aDBnYTVoUnZJbFhCVUxYYTB2dHk1amU2TE9nV1hSdU1iYVJFTTlFZ1BvS1ZX?=
 =?utf-8?B?bzlrTnd6WFdFSjE5VlJtdHNoS1hPaG45ZTN5NEU4dlF6VnNqbktKb2xteFFI?=
 =?utf-8?B?SVRiTmg1UUwvYXZDNUtPRjBpWVBHT0d3eHcrVzR2ZTNSc24yUTMvZlgrV1NU?=
 =?utf-8?B?OStPeHhwdFg2TVFrQTkxek16YlF1RE9lUGRpRjhHN1NNWmluVHlzcThOYWRG?=
 =?utf-8?B?Tmw5YzlrRDVHS1pGR2lhNTlHU2xic2dVdnJNTUpBdUVVdXUvSFlBNjBLR3FT?=
 =?utf-8?B?UHhpSHhPcGkyeExiRzMzdklvNnV4U1RGTG9FQy9jb0YvUGUyM0N3anB0bFhp?=
 =?utf-8?B?OEo3a01TVm5nWDVYUDRlWkk3OE1SV2huVldienByYVVML3FrY1hlRmVCUEE3?=
 =?utf-8?B?a1YrTjcrNVBrbVhtSWJVNjY0Tm5kNkdyRWxKdjg3dHJWaG1wd0FjZEhKTTZK?=
 =?utf-8?B?TTJEZGlYYW5jZmgzaTF2WWFrWE1WL0dBZ0lCdTFJSkxiMG9NU08vVTcrRGdO?=
 =?utf-8?B?U1RKY0lwc2xaTkZYdGJqS3J0bFZ2VXF5TDNSVnZmRmI5RUpFallUZGpEQTRo?=
 =?utf-8?B?elVyejBKUHZMWkFVbk9QSCtZVWdZUkY5SGtUUEhrZm11bFpyVk9GdU5uV2t0?=
 =?utf-8?B?czV3dkFva3QxMEg2T2VvZVB3L2wycXBqTFAxaGVOUVFKd2xNZzRYRGRrL29j?=
 =?utf-8?B?Ylg3WCtOanhYMVVOTmNKSkhkdkpsNEs1R3hLMVBtMjlNaC96WUJvN3BnV3Bp?=
 =?utf-8?B?SldVckl5a0NiNDRRZzdNemFzTjhJZnFCaGdUOU5MNEJiTTdpZEpJaEU3ekR2?=
 =?utf-8?B?emcyNytsWFZ6cklQVm9TT1FKUnFER2UyQ3ZGcG1SdDNzeFF3NFVXM3JoZ21R?=
 =?utf-8?B?QzY1NlN0MExBTmVTQ1JTQ3JQYjRhS0RNOVViNDlHWEdlSStkWUhzNmZjWjZ3?=
 =?utf-8?B?ZnRXZktNODBHMktLMWplN1ZFNkZxaHBQb0xOSUpxdXFhTytDZ1F5RGdEQWZm?=
 =?utf-8?B?YzJWUktDcWVCc1J6RGQvRzRFc0Vqa3JST2ZucTdTWElqSWZhYnQ1UVliU29k?=
 =?utf-8?B?WWR6aVYvYzN3MXNlUWZaek9NQUVTTDVlYTNEK2xudjFaWUJFb3Awa0NlUEN6?=
 =?utf-8?B?ckF6eHVkemNUcnovTFdSQnhtOUZHVFJrWTdUc3ZlYjZBV1haZnFXcGdJcGZn?=
 =?utf-8?Q?fbBc7JDx8wP7D2bLyjjO4pzyH9pyxrx7IsRGj311qjar?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6468d82-cb07-4027-fdbf-08dcc8518cf4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 17:39:36.3992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJsJ8nNxaRJG2kMZAKoxpWmnGpsvPiLTQZVhMywkaWgMx0u0BIbVQ1s+QozgOA6hXb+RDy5yBU/bboszdn9FrxvXrTLccRpqJ1TNUXXLmN50NpdWIQ/jFn5K85cPqJ9n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8479



On 8/29/2024 12:55 AM, Leo Yan wrote:
> On 8/29/2024 12:17 AM, Steve Clevenger wrote:
>>
>> Changes in V5:
>>   - In symbol-elf.c, branch to exit_close label if open file.
>>   - In trace_event_python.c, correct indentation. set_sym_in_dict
>>     call parameter "map_pgoff" renamed as "addr_map_pgoff" to
>>     match local naming.
> 
> For the series:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 
> Hi Steve,
> 
> Later when you respin a new version patches, it is better to amend the review
> and ACK tags you have received. (Just remind, b4 is your friend for helping do
> these things).
> 
> Thanks,
> Leo

Got it. Thanks, Leo. By the way, I noticed when I rebased to
perf-tools-next the kernel version was 6.11-rc3. Is there any chance
this patch gets into 6.11?

Steve
