Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020133.outbound.protection.outlook.com [52.101.189.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCBE3F4DC0;
	Wed, 20 May 2026 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299918; cv=fail; b=CEbTacFzBUCQhB4EQ2a0N7VP80waM/KpVGaSY89o1CmoS2MfgTEdubgkYjrernt0HXH96yWtGddkWDqS0E/P5E5nklkqluYkF9EZZ0FeuQZLKp7I10g1Ax6sFrr5nQlcR/PopGWqXW3ic4Rry0dysamZURctRGdvy5ept0fRcuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299918; c=relaxed/simple;
	bh=zEg7f1vZYhdqTgsDfMWPbDFMiUZf1pqkY4WjaeXmVeI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=feAswmDuoygn8vzLCfQQMf0MpI7M0XF5F8NpXSUJwlCgiH+7uRsJyAoNRH88skxZxg+j2wQtKMneioeDZPIFFKthzltNI96UEL8ItJHvD1o67XnwRhRc7zHHJ3msNCs2J6YeO4ErXe5keAEEg9hpc5szESW0+VPBmtu5kDQCqWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=uqG6RgGK; arc=fail smtp.client-ip=52.101.189.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="uqG6RgGK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dN9eagKEwQF+pfpPO8giZ37fz2fI10WPAtIjhL3G1qGTChx+c3BCueFTDT/gDcikr+EpzldUsyKTo0xp7vAEkT9Xd1D8ndar4IHPg1tt2Iqie1XE3c6cegD1hNxZjeFcj8GT5QtFc1ttfp22ULIPkBp6Z3RcL0fL9G1bbPpHR19cVVoYnNgogkvyMKDCQwvy3Sr7SFUyHKp8F7n2oqKAn2jdeH1Td3voNG4u8iYPc+tWkjpoYkRa3TDRE9zHG7zLTAYkhVFtItoUxTKk/U8TiMvl+xWP5i/gm7DD3QHAzgAXVOsURZcKRIJsW4KnbF0QI3K2SfzkfoBc7O+EtzEVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DF/Hg0ge5b7CTD7dv/CtyqC5eAg0B7GtCGzSXjzEZnY=;
 b=bTt0bgwke5V/NeUB8om4J7+ijDeF/8NG24M2H2upABYXMA44mmPLDveYNaeqCTRqLMd1zVxlVvj6wpBvp/euo3zN/2uXV2I0ojnEdnyzwIrIcLoG6GxxACwyjMuNuRrvk4mukMN12/Spm2NmIHG4e8YlKmBbrsQxLRy+fT7PN8BZE2StM/eSopYPL+Mx7HflQtWdKQ31ZFHe0ifr/iFWyJSOISoXao1qBO8IDZ+9rGUrYztDc4wmX39HfRMFAH0UA4K0a92gWZWbOIlErkT4b50Q5/6ImLHUZQab59Ut2vW2oXBq4y6T4p/rOyfe5Di1elIqrfbBIlfc4cEN8NluBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF/Hg0ge5b7CTD7dv/CtyqC5eAg0B7GtCGzSXjzEZnY=;
 b=uqG6RgGKc3GPdR4YYV1P5tPF9gXow0EOcyCBJl47+QqpzE/E4Um3P02XSeDGRx5iMUmwk72nvDr7NxEbvaSEyziUm9at23Yykp7OPkd0XRDf9hSGIhNAs5v0fz4D7sXVFj8+APl5uKUp+O9UUiX28m2DEPThwM4jjk+0orMFn4D8ISFM7N0EdkrQf2nTN2cMMzN9sqKGh5un2eqfjhqNHJEkmwe6fhRRDJoqu0m1CaY89vFpBpAxOr7y2fSvEM2zVcF2xy3A+3Kosd5SYFPS+NxGpkh4+gSqmmeYRJadhd7SBWpEtB33zSqj3SQfGnkVCcykqnIjpqK9N5dJK5Isfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6e::20)
 by YQXPR01MB6447.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:43::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.6; Wed, 20 May 2026
 17:58:28 +0000
Received: from YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1ee8:6055:75fe:7c18]) by YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1ee8:6055:75fe:7c18%3]) with mapi id 15.21.0071.005; Wed, 20 May 2026
 17:58:28 +0000
Message-ID: <33978160-74a3-42ee-a4a2-1b0ad968a46e@efficios.com>
Date: Wed, 20 May 2026 13:58:27 -0400
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] perf data ctf: replace libbabeltrace with
 babeltrace2-ctf-writer
To: Ian Rogers <irogers@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Derek Foreman <derek.foreman@collabora.com>, Ingo Molnar <mingo@redhat.com>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20260512194710.162215-1-mjeanson@efficios.com>
 <CAP-5=fXMtbO=7JMg2YvhQNbqOEFH_ze=8EifYM7bDfR945=KHA@mail.gmail.com>
 <e6d88ec4-c6fa-473c-ae70-071bb6f040c1@efficios.com>
 <CAP-5=fVnNyScv=fWy++iucCWWe8G7jcEn=AiDbLEV6PaeBooHQ@mail.gmail.com>
 <CAP-5=fX5QpRcVhnZCd230FQWsJ8KHbCrv6y_47vcrBK0fhWWxA@mail.gmail.com>
From: Michael Jeanson <mjeanson@efficios.com>
Content-Language: fr, en-US
Autocrypt: addr=mjeanson@efficios.com; keydata=
 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 IZHa
In-Reply-To: <CAP-5=fX5QpRcVhnZCd230FQWsJ8KHbCrv6y_47vcrBK0fhWWxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0329.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::21) To YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:6e::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB6451:EE_|YQXPR01MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b439a33-52a6-440d-5637-08deb6996548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|4143699003|6133799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	g0kOY/Nc51CamtYD0NcE3mxinBeFiYit6p3oxFAfZ3cwZxA0SnDm0aL7i80B52yb14+l53ihP9ImuOMZqc6q+wUMu5SSeasxF0AmwSrg7dLAL8LkjHUaw+wmgTKuzq+yZmyV0YDKmXhJVgRQoff1RS5hG2695LJwc79jkHlx6NkQ/ZLx/TcKMJSmZg6H81MwEcIdYb7YeW4jwlhK0TcA7rANh/4UbBqrxe1HiZ3nyz2ajILM2Kvr5CK2dOkhzjVBANWfwffMezbjQ19dKub7HVwU01HNdHAvyBMf6GTi3IWK+vW/opOOaN724Z419Y3GjthivYoAYa4vHsCOMcOqUAEKF5D5+UhN2I690oIAjXYARXjWY6nlJu+GQs1APoEeUTWdbwtSMIiLXOah8za1/puIJMypv1Z9qmp5JYDUoHrH7c7XbIiEbOh3wA2Z6JPYmy1+ewfQc6QE3MFUFT8WzQ7dYYAJmIdadH/5QmvXfne0ww9BtIPZNMem/GRgrsOmDztsS2OP1VjPTHWl4wl8NOnIc5Umdh5iPGoxFiCAo7VYEb6ggaq3mDsMWAAjTE14LUlR/Y0AF2mZRgRP223w8w+62HepztJrWSl3OniwIMatGVHCebxDALuhVpVI0Ne6hlIk5AMofKkDGKbi9DX6IoLlSMuJ9X7pj3u49i/v+b/RPKpJemc+DgWi3+5zFMfD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(4143699003)(6133799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXdMTDJJT05PK2FHM0ZCTlh0VTlLMFJsMklOTXIvQTZOY0ZRU3kvY3c3WC9X?=
 =?utf-8?B?cWxuUTR0SzRoa3dReW5GMXZmaWdLOHV2Q2tzM2hoMC9ZWFVpN2VDNGRLVTU0?=
 =?utf-8?B?dDg5eTVuTnN3TXBXNnlmblg1anYrNkVaZG04MmNrbDBSczRoVmxDaHlXa2V6?=
 =?utf-8?B?KzBDMlcyZGtqMDRDRnVLcGNhc2dhNEQ0TXlQRE1oTVZ2Z0Q4cGtDckNTaUdx?=
 =?utf-8?B?SnN5YnRxc0xna2NiNEVQajVIdFdvcEl4aXRxazgwc1pybkd0aEY5YjloMmhT?=
 =?utf-8?B?bFpzZE9tR1dZaWIwUmwyUmRqUVVEaytUeloySXF2V3hhcG1PMVJsY0FNRnBW?=
 =?utf-8?B?YmkwRGR1VGFzbTJjU3RKOE5RcDZZTEdTNmhlT2c1SjZrbUJmTW4vdHdianJY?=
 =?utf-8?B?NDNmc2ptbFUvVFlBaW1NdGRlTDRUYWFqdUtadU1ock9lREc3M283c1dzc2ta?=
 =?utf-8?B?NFNld3l3ZTR1ZTczRDkxamJnRzV0ZXN5M3dZZWZKZk9jTEprZUp4aGdjR2o1?=
 =?utf-8?B?WnFTM3pnUXNCOTY2bkd6WElFYy9YUnFQRWp1R2tPRGN1ajdyd1FIemF4VFBp?=
 =?utf-8?B?dDVESG9ZMlR3RTZ3SnBncEUxUmJDdjNrZHg1Z3JIbHZlMldFS2lPVHVtK2kw?=
 =?utf-8?B?T3UyNERoSlREaTVrdEF6OXRXWjk1WTFtNjA1NFlTYi9GSXhsQlc3V3JwWDR3?=
 =?utf-8?B?bm1ZN2JDN3NGQ3l4NmlNZlFidUdzZkJXNDk0R3J0TW91bFBlNnRZRnBCemZ4?=
 =?utf-8?B?WmZSL3FyMUJibnZseE50MDlZTWpITi9nQ3pOQVg4T3pUNzJIU0ZJREI4eXVE?=
 =?utf-8?B?czJ5RGt6b2tsZjF5eVhVRmpRZjlRWm9STDFnYXRET2Fkd2M5a2xYRS9UZ2pm?=
 =?utf-8?B?Q3FCZmhWVzRyZExQZ3VKd3lnZjJXa3ZzQjR3bDR6ak5ZM1dIUTNFR2IyOW9G?=
 =?utf-8?B?K2VQc3VzRVg0OWVIMFlNbFdmdkt3SGI4S1I1L1BhMkhSYWtPZnJGS2FzUjVp?=
 =?utf-8?B?cGVCYnlRa3B5b2h5ak5JNzM1elRxS3NGQjA4NXVaL2pQaG9RbzJWcFViTjB5?=
 =?utf-8?B?aWFpR0tQc3dBcTRJZm1MK0hSUjRrSDRmRGVQdFREY0xUMVI1eUJMREZVaDdX?=
 =?utf-8?B?cHpJdFArUjFGYXgvb25RQ0g0dFNHemJWaGVFQXdpWk1weDRIVm1BWUFDTXZ1?=
 =?utf-8?B?bE80Z2VCaW1BNXR1d2JxVXk3MHZKbnRPNVY2Y0oxd2YvWmVvNVFtc29NM2Qw?=
 =?utf-8?B?QktKL0hSaUUrdm9na1h0cXNNVVJsZVpwR1lCemlJaCtlUkRGWXJlVGx1WTBP?=
 =?utf-8?B?YXBaYWZXZGpNNVhUVUp4U1hCMWhqQWcrYjQ0eGJVY3A5SXFQQWRjdVpNRnNw?=
 =?utf-8?B?dHBoQjVsSWR5a0x4eXpmeGY3WWJXUnd3d1BSbS9FMkJyc3AyMGx0YURTZkJ1?=
 =?utf-8?B?TmNIWllza1JaNWQzRGNaZ0tONTF4Y1dwTk8rTkthWndqU1pDNWFReGxVbHVC?=
 =?utf-8?B?Z1ZLMnZydlBBOUlpOS9vVGtXTzZaNTJKWHlvVUYyNEw2ajFOUnpLbDNRSC8r?=
 =?utf-8?B?UXljL3FhZms4Y1FmNldsd1hVK2Jzb0FWVGpEdVFacWdMY3o1S2NXNGlMSGJ6?=
 =?utf-8?B?RkhkYlErRGp3T0VXNER4SGJnZWpsUXp4ZmYrNDJydVVwQ1NQWVowRWQ0VlZr?=
 =?utf-8?B?SjRHVFA0eFgxSXFmNzV6OGdQYjZmZ3djK0YrdnJRS1RpWnhNb29zWU11S1ZH?=
 =?utf-8?B?YjBMU2FMUXZ0eWl4TEpFMW9sY3Bka3MxLzhTYi9WQm9XOUJYcWdPNXkrbDhP?=
 =?utf-8?B?MUdUZVhZdy8xMnpjdjJMQzBDVkNtbE9XYjA1emVXVWFFeWhmaWdldEpnYjlw?=
 =?utf-8?B?Zmw3VUhkWXF4bEtHbzhQN2NTZSt5eFVGdjBDeDYxWExRbm1BSzVJU3JoTlNV?=
 =?utf-8?B?dmhuNzlveVgwdmdEMGpWeTYwc2F0b3kyZG1MZzdWb2NKNU1ra0pTUXplWlNE?=
 =?utf-8?B?REd4d2RIS1I0VCtQRU4vWVJmQmcrT2NmeDlORW1UMVpRVmQzT3A5dEgzRVJi?=
 =?utf-8?B?Yjg2c3ZBU2xidTZjU09UMDhtajNXcEMvVm5VTVdseEJBV1FzYlZrbTZRdy96?=
 =?utf-8?B?MERXaDZKWnlZdTBXem5udnUxN012R1FVNkpKbEVXSzMwOVZnR3FGODlhY3Z5?=
 =?utf-8?B?cFlIOS83RlVwRVZRT1ZlY1RGcEJ2OFMybTFROUZSSnMySTNGK3dBbGJxOStV?=
 =?utf-8?B?Uy82bXh5aVlVaWhRNGNMYmZSVEx6UERXMkJ1R0tEVnUrRjBSQk9CMVVlMHBR?=
 =?utf-8?B?MVltbzU1TTEza3ZZQUM0MHE3dGFXZFlCWm55bVNpbEJRZGhwb0xpQT09?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b439a33-52a6-440d-5637-08deb6996548
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 17:58:28.0535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEapKsPIWdYjVM3GJniVE7S7uu92uix5/mJFiMjkm19nyMCgcnjIUuxQLMtGJWZ89bQV3IN0xX5t6aDh8g17jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6447

On 2026-05-20 12:13, Ian Rogers wrote:
> On Wed, May 13, 2026 at 9:06 AM Ian Rogers <irogers@google.com> wrote:
>> On Wed, May 13, 2026 at 7:14 AM Michael Jeanson <mjeanson@efficios.com> wrote:
>>> On 2026-05-12 17:54, Ian Rogers wrote:
>>>> This is cool, I'm surprised at how non-invasive the change is. I'd
>>>> done a similar thing but keeping both babeltrace 1 and 2. I'll post my
>>>> WIP in reply just as a heads up, but I have to do much more heavy
>>>> engineering.
>>>
>>> I think I can rework this to try babeltrace2-ctf-writer first and fall
>>> back on libbabeltrace1. The change is non-invasive because
>>> bt2-ctf-writer is basically just a compat API for the ctf-writer of bt1
>>> but it doesn't expose any of the new features of bt2.
>>>
>>> Your WIP patch that uses the proper libbabeltrace2 API is definitely the
>>> way to go for the long term. In the meantime would you like a v2 of this
>>> patch?
>>
>> We have a problem with the perf tool in that it carries too much
>> baggage due to its library dependencies, so I'd prefer we stick with
>> v2 support and your cleaner/simpler patch. I'm also hugely
>> appreciative of the work you've put in! I'm too busy to review my own
>> work right now, and cleaning this up ASAP offers an advantage.
> ...
>>
>> * We support libbfd although libbfd is GPLv3 and license incompatible
>> with perf, which is mainly GPLv2. We carry around libunwind support
>> but that project appears unmaintained. We have LLVM support but the
>> LLVM dependency is huge in terms of size and dependencies it brings
>> in, so people avoid building with it, etc.
> 
> What's the plan here? I'd prefer to carry the v1 patch, ie let's lose
> libbabeltrace (version 1) as a dependency.

I think I misunderstood you, I thought you wanted to keep the bt1 
support as a fallback. I'm fine with either version of the patch being 
merged.

I can send an updated version of the v1 patch addressing your review 
comments.

Cheers,

Michael
