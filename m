Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022122.outbound.protection.outlook.com [52.101.101.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D181F30BB;
	Sat,  1 Aug 2026 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785620737; cv=fail; b=NV4Ujx+RfTDZxBjbM/N7RNaSbuOGusE4sl6/tH3PUhsMS8txgK+iIpkhj/J8E1gmwcTRgjejaN6uIM0CkvBvbnp/3IWbijpH4FPxA2+qKMyT7ECuV7+xkGEFEjf4pOG4n6PVwf4S3rT2z4b6/3a3wIEJIYojnnttHA8jk77m85c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785620737; c=relaxed/simple;
	bh=iaKNa5K3emxq8CfRGsELCAi2wm4dcl6QkbDoOi+a5Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZgP2YPyUKrv3izk/oqOc1Fly9VEaCYDtytHaDIsHpCxp48RiB8s5nZkjQCGfMur6W9LF8wvWhWValeE4b4LLsVJFBlQujbUlYDATgtdOvEqKeU0uvN20btcyBBENl+8vx4XNsT9hxVxI+2xVRUzAmZZvDyI0EKXAfra/y20DJmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXatNt8ZfS0bcwdVCdixomJeTB81OT7gow34JMbr/MTLV6pelx7GFS4oX/t5PJgMT9F7nfLx0eAzfwLhM2Bg8d7q69aD2m/ljaLZ3jVaYJ0M10wkqhRtxg/rLtWPFpf9h5hlgOT1mNnG8SN5gFgxA8nCuYyFNNWD0CfKsIkXHl9WxUiJuz2rVeAPPC9T9P+TSa+W6AfQFAMR+B3b7bBoE6uMU+S+duxrboesd41YYkV5Hd60mwosLeQi0/KFrxvrEX68VP8nn4/+XrV85NeqgtUwzut13JTTzL2IbbLmW1GoM/YtGIjVEyT3DscSe0HoPkdZ3nIHqMcL7p/cPPfvdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=+wvQ00zCXOCA5AZKeWyBE0gFimZxZ51iORysTMSabZU=;
 b=W88ZdREo7J03c17k2+Bxn6hPPpwBlPt0/JSqYOMXJkWPJNt79/XmWMawqJ1T4EVuDkk5fbqpBMLCLASHTD8s155OWgQ56t1leAnmtvPeHaZ0P67RC3HCfQ5XEAf/N0/NOHvawW6rgy6eusdjktEW16RhVt8oSgQM75nK18P8vcFe4ZS90Yk06jCuNxnxsWpHhntjbkj0LUZjsKyPF01Vhd3xoljQyxN42rl/5RzwTSMPXRNFMZbcwLly8Jj1jtHIDy9VTT6BgiykmL2seY5EHHwnjHEo76abf5TEWsWgcR0xgE2vIB8AcPSLinYMtPjtj6bDqXvJo827DmZgOe84dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOBP123MB8220.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:440::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sat, 1 Aug
 2026 21:45:32 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.016; Sat, 1 Aug 2026
 21:45:31 +0000
Date: Sat, 1 Aug 2026 17:45:27 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, steve@abita.co, 
	rishil1999@outlook.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] perf sched latency: Auto-scale latency and
 runtime display units
Message-ID: <oisjadpeh7gyua3hhqni6ctazrosulcvbndftuxuovfczuqn2a@cej6shjbossa>
References: <20260730185416.97166-1-atomlin@atomlin.com>
 <20260730185416.97166-3-atomlin@atomlin.com>
 <am0bSUV7tRYWoWyr@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <am0bSUV7tRYWoWyr@google.com>
X-ClientProxiedBy: BN9PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:408:fb::21) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOBP123MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f966ea-7f53-4b48-0e5d-08def01635b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|18002099003|22082099003|3023799007|56012099006|5023799004|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	WgzfDCcBwMmQxaRY2/vYOazN5xK9kavUSAss6D2fTkrCA1xT6CgcOx6GD9L5x46kb9/TzHphndHhYSAgoBWRszlmY+C3bPX5OUfbDOV8kkuopjYQ9pSP5z4x4QCuHs+43Cyy51gafSmBK4oKxLhMCPXY5qUNhbFSwKPKQ0zix5gjj9vXDfkyj0yEfPMFHXXPcynyrWHHGdSfDegWJqnWLsZcM5APhuqxKwT17P/cdOV+GCTiSp1wBW70hD6+lm/ZBA0c75l/pVb3eoIRu+AS/eVXKhbehdYlkE8g6upP+TWFxMYN9UiyZ3YHgztG2n4lf8I5eQ8NJY0nLl0Vv6haOhxdPklaIIn8KluvGwRqNGCl8hhK42J8Esk0leIgKXG8k0/P0zbk0K826ww22vBzcZhcc99jPDL4AOE4ScyBYFVR2S/+Y0bfjFR4UQGbitgAlSns4n2NMkzffp8uyc8dlktA8EZBihIQD7Dt/NK4iP0rpB+hl5mUrFPxAfNGKytOCsLu/VEd5i0W0pmPUhvhVs83PShepAmvgTTur7WcqfaayLTT1mfylXfcYmJ1IDWz9Fj0ooDZUWgyoWutUKar4unb9AlU6Cbe/kyzQ4whbYLgvXAwTzi54ChGCqsw+dgKbocx8OOwkGJjmOoBK9nEiFw6NGyJ0O8swjApI76EURY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkhMTmtHZjkxSkxPMFFPa1drdU03QWlvTzZYR1g3YW1GcXJIbXMwckZpcnpQ?=
 =?utf-8?B?eDQ4Y1A0RWx4MFVzMkYrUmtPMXdWcHdFV2tQaUUvd3R6WnkvK0VpeEZKQWpk?=
 =?utf-8?B?cDBKbGRSdzlFZmpicVVYbWtNeHFyRkg2L1hWWmlrMlhZakN1UllpMFNacjRz?=
 =?utf-8?B?MEZyMU03Q0cwQmI5VDRFbGdZNVZDYVBmajVwVTc4MGxneENHUkE2d3grOUJi?=
 =?utf-8?B?N25JVTFtcm5jWjg1bWUzakt0Wm1EZnh6MXJYNE9qS3lpTWtNMXJYb1dPcTlT?=
 =?utf-8?B?VWFIZFFESkxWam1FZWM0NC9ndmVPaFh5bEdwUlNVYXFlUjY2VkxRUDVoemtl?=
 =?utf-8?B?RUtnOUd2d25JcGN1akt5VUxWZ2s0OHdLYjZjdFZORk5aREVNV0U2TFFuc1pS?=
 =?utf-8?B?TGFtdVBPaXJwL2kvWEEwRUhRU2I1WTFnV05UTkU1SUFxQkNscmdqQmVkb2hK?=
 =?utf-8?B?QmwxTVBOZG9qZTJ3SnFiazBScXlQSjJZOHhFQ2szMldiNUpJWU5sWnp5clJH?=
 =?utf-8?B?bjdzZEZQNGZjVmZremNqc2pBQ01EOVBwOWoraUNlakVsclVjU2ZhSkhraitl?=
 =?utf-8?B?ODRLRExNblBibVpBYWhVdHV0TmhoWHhTQS9KczZ5SVVMTzRxUk5velRiRjI2?=
 =?utf-8?B?UnFEcUt1UnpMazh2SWFwNVZNS05ocWxRU1p5azZ5SXBsRWNtaUxOSmFZUmV1?=
 =?utf-8?B?eitzNDVxOHlqNVNaQ2JiODR2ZVJEZ1dLNXYrVzczT2ZWdFFrSXlLLzEzVkhC?=
 =?utf-8?B?ajEvOTBxWEhTOUYyb0NKV2RsKzBFenNMc2YyQlVZMURYNU1vaHF6cmNkbytk?=
 =?utf-8?B?NllwcmE3VUp5alh1Z3AzOFg1YXNFMzZ4UW8vS0VlUVNXbytaSTRWWE5oSTZM?=
 =?utf-8?B?SlZjTCtIYmViNi9oakdyZ0pUQkdMaTVCUzNjWHBIT3FHMEZRQlhWR2lJYnpj?=
 =?utf-8?B?MVhFeDc4YWhRS1RDUXZtYXFIVnZXUzV0VWFMUk02eWVtYkx6cDZFZ1dEbHNW?=
 =?utf-8?B?eFhHdXVCREZVSE91Q1lrd1FMdWZTZklHNFB3WUt6ZXBPYUVzMllaQlY3WVcz?=
 =?utf-8?B?bzJhMmdTOWJqLzJYNzQyOGRtL0hpWHJOQ3ZQNUt2Q1dQVW92YWJQQjVhK29I?=
 =?utf-8?B?TUorNUdSbW93WG1OMDNqN05DZ1dmUUFoVnMycVNOT3VXVVNKYTgzbWdlMUEw?=
 =?utf-8?B?MWNnS3Z6RDI1Yyt1UjhOcGErRTR0ZVlEeklMQUN3UmpMYUNXNDV6L3Fvd0RY?=
 =?utf-8?B?VEwxTHNIQzlSenFQeWJDQlhuRU1CcXgxVXFZVVc3NWNVNmhqNmxtZVFZVVF3?=
 =?utf-8?B?bVJnV3haSHhEVTlpTWhEU2kxOWNQU0dtUzhFTnlnR3ZUNG5ibHBlVUJQZ1ZX?=
 =?utf-8?B?NHJ6dkZzZnAzS0xlYytiS3lvK2dLZGp2amExbDFqN3RhNkxFNnA5aGtBckhK?=
 =?utf-8?B?dGdVaEtNNy9pMkVFRFZOdVhRd0o0ZzUzbjJ0ZnFRR3ZXb1YrSHkySlh4Rkt5?=
 =?utf-8?B?M25sbmpvQzhyQzI4M0huakFOYTRuekZ5Q21HVUc2YXIvM3pIcnQ2YjZGbkFm?=
 =?utf-8?B?M3JQTWFRd2h5TVdqN3ZuV01rbkNhRyt0dmV0RkJoZUVTNVl6SlEvdlkvSnRY?=
 =?utf-8?B?OTNQNG1YdHZNaXFCWXVZRi9IMDVWcTQ1Y0NwWEU1WlVmQUJvQVFlTlpUdTl2?=
 =?utf-8?B?QkowVVlWRVRLMUJEaXNlSXpaN0dtWER0bW9CZTJmeHZ4cjVjdFBmRU9DVWJz?=
 =?utf-8?B?U3kyZVh5SFZOeTJ2Q0oreTR0ZEFhV3VINk5VUURObDBJVG9WZTZRTjI0WUYz?=
 =?utf-8?B?bnBiUXNVMlRITFlYSVhnaGVtMDQ0eVF0WnNaMEI5REx3dDB5NkN2UG5sNG5Y?=
 =?utf-8?B?OVNtUWNwYXJGTkpQQUYxT01RbGtDcVNob3phMmtEMkg4TWpCZ0xOZHJCVDJn?=
 =?utf-8?B?ZG8xQWF5Z1E3VVVwRDl2eGNISUpSVGJrOHRlU0dBTWRLMjFEWUZiRXN6MWRC?=
 =?utf-8?B?ejdJWG84ZnlGckhJSno5UHczMVExS21TdFdyWUFJOEVMQkg0UVgrRVhBZW13?=
 =?utf-8?B?bjVNRjJMMTFJNjhOWndWdHRMeU5FeGFWSnZrN0FZeWxlTnZPaE5scWw5Y3pw?=
 =?utf-8?B?RkUwRWpYN0hUcFNoV1M0eFkxL0F2bzJsWTNPWHorVWJreGpZSDNGUkRuOFBz?=
 =?utf-8?B?M3JYVWFtam1odHVIQkZ5ODRzbVo3eTh2Nm9Ob01LTHhKQXJvbFZFK1ZCWENL?=
 =?utf-8?B?a1B3eXlmRGN1a28rQnhLN0RkejZuWWdpTkRHLzdMSW8xSFVYZGlIR2NxZFFu?=
 =?utf-8?B?VFJhUzlMdDhLNm1weUd2M2VOaE1wSjlDQmZmWlpRWVkxZG1Sbld2UT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f966ea-7f53-4b48-0e5d-08def01635b6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 21:45:31.6471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkJpiYdH5SrIpdWZPNOeMjqyLe5CHORQixMe9TvzNzHE3tVJJ3zg3MDzyTYa+Lod09ecAEyAF5EpFe9gp0wnlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8220

On Fri, Jul 31, 2026 at 03:01:45PM -0700, Namhyung Kim wrote:
> On Thu, Jul 30, 2026 at 02:54:15PM -0400, Aaron Tomlin wrote:
> > Currently, 'perf sched latency' displays task runtime and delay values
> > exclusively in milliseconds (ms). This can be hard to read when
> > latencies are very small (in the microsecond or nanosecond range) or
> > unusually large (seconds).
> > 
> > Introduce auto-scaling for latency and runtime display columns. Values
> > are dynamically scaled and output with the most appropriate unit:
> > nanoseconds (ns), microseconds (us), milliseconds (ms), or seconds (s).
> > 
> > Additionally, rename column headers from "Runtime ms", "Avg delay ms",
> > and "Max delay ms" to "Runtime", "Avg delay", and "Max delay"
> > respectively, adjust spacing to maintain column alignment and stripe
> > redundant prefix strings from each row's format string to produce a
> > clean, tabular output.
> 
> It'd be nice if you could include example output when you touched user-
> visible area.  Comparing before and after would be great.

Hi Namhyung,

Acknowledged—will do.

Kind regards,
-- 
Aaron Tomlin
