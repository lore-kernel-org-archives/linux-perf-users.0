Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.118
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793577879;
	b=XcCvOqhSPx2z6mS9c7ju+817bygiJz1qyyYjEblotvYF5IjAtVSolyi6cDGfKUZufBAA
	 FajyiyVvzzpTPIS9d0jRROlTQycx31Z5vqkTvs78AMTzxq2ECUE8OfwBezd4hq4lOyJms
	 m+OhR6XRLCcUHT5CncQd1w+afuUGDsglCtaWJZMs1WOTbtNEoJb0gN1Io6CYEomXPGhBq
	 WocOg71loOP5wZR/gWfXNRACaXfn++068DBVKB/7AxoxkIzJqFCUGP0Yx/qr38Wyabx2T
	 iTIm9wFivpGuoAGtBzHSzkoKDZcZLwd3WKOpnlVy+jgcwazDy4LqwNtPjTb+FIxLvMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793577879;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Z1AGA+lyu+UWpP+ykAZ4hIuMVP9CsM1f4Sqzquj13DU=;
	b=KF634SunAxYmkew6uvxWtJk7pBJxTQofvMn7V7PsyyDuAs8fWLGeGAPWQoSmpgAe6R5I
	 CvgdGQAJEYYS1QXRsClBIN0QvLJ3rzwPQYTrD+Bl+DRfy6XIihBr4x1m97b+UxCCzxaq/
	 fdwf9MeIC10447ipajHw6o9nZcn2Ot+n1JEGJDHNhEqc0BxgRxvP9u29F8jU2Md0b7L3n
	 bkgRyQ2DS8Hvrr3lRYGTovbDo4BQ6Af6GVCBlNdFRPT1l2CJ66V/zpXU9SzGF7ZqNavdI
	 tQ0YzKNQU+UN/ZuW4xz3wWz2v1r+4eWQB5Qgc/3+60xtjpO/35ApiLXqqzrMSF6Ylsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.118
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022118.outbound.protection.outlook.com [52.101.96.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455DE606A324;
	Mon,  2 Nov 2026 00:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 455DE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+FS81Dd0UO2H3HRLTJuK4qNkrEIQF7u6dhZm1JVYtONdh0q8jcshxgaX8Z3resC5pOkyB0MyZLsZp88Xr7UqWvX7RkNa/qbFckwltm/ICan2Mhci0id/Ehppafv00ZR60YBilj0LWDdELfrWPyPuEBslgDPCBOIgAkTSBcoOkfffZ4Ka54azUSLVsewrd8A0hQ1cBXFNQh39WoG3qrC9XlIYfp/jPV4CHA9vYvR8XWuEXNMuTf8eug2aCWw8qmxiMyAs7I697/raBvFUPczGBFU+BaqD1xJ0dYdBcyVPraWjGpuSW1PR7ZSQqeni4FNCu5m1+Ur0/lj7BEMDC/Iag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Z1AGA+lyu+UWpP+ykAZ4hIuMVP9CsM1f4Sqzquj13DU=;
 b=H00OrepS3mH0ygO2eHsMrYPNPjAtNuPGo/2YidMwUqXgEua6T4xUm5b3VtaPfoxL3ewbn2fwybBMc++/wH5+n0fE6ROrK1aSmlxCuI6jFhrjgRTDiqebmZe+5MC4ExUAIBZNNShlS3pokWuEaiJzU3QIqlFjnqhSVaa0mRg1v8rl8SRisse0ka5E1H2RZ6N5p5Fd/oLhcge1/fOgpXXR0IWbhNRlqNCA3wX8YOjdsx6fSporhOeUogm+EOOegQKWYYoYU3iDseIaQ619h6BcA6+38T4u8jwmPd/BiBLzrZu5jyB6CNyfGVyq+CjqT331hGBHE9YiKVFeXkInTqc8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO9P123MB8484.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:45a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 00:04:34 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 00:04:32 +0000
Date: Sun, 1 Nov 2026 19:04:17 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, chjohnst@mail.com, neelx@suse.com, 
	sean@ashe.io, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v12 05/10] perf ftrace: Support context
 switch tracking in function graph tracer
Message-ID: <qavabkz2qznknyttzymkppwz64ho6hvqeooqn4ktsxpw5hq4t3@4jfxdhl6c2mu>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-6-atomlin@atomlin.com>
 <auZlT1eIOjpTnqHZ@z2>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <auZlT1eIOjpTnqHZ@z2>
X-ClientProxiedBy: BN9PR03CA0617.namprd03.prod.outlook.com
 (2603:10b6:408:106::22) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LO9P123MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 240638ca-fc6f-4cc1-54c0-08df3874d8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|4143699003|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2XVBIGuQ18N6wtEBu4scpFtqaBeDPL2Vbd5HXih1WebfiPkgSG2PfRur6LwplUr8QKBn5faud1m5X9YMx5N2TtsBldKNgN/LMaO2tv/rnlKZ0mzLTXhda/gTBxpleH2NLnZOTU0JxVSdJa2KNi95D98CyRuIEWFLHIzjSbasZdGOA+thyMLHWGu7nsoTAB0+3xIHXYf6wz8OBq/FYoySY4LTShXgIS0Zq8Enbodt9fM56vrXucoskSqgjgUDQD1hq40RDjGKtq88ID4CYI+nhD0bEJcVY75vJesQFqcD6nY5T9M6yb3sEtH428CaW7yiKuUOGNRqB1YTNMTXr1tlB78KB2P/jRzDXyOiKZJsp83M0Aod5LCKF9rswPflCSbMFGLq4jamH7CkafrJPX6V2G0DTCzFXNSrXCPjT7E5eYZrXmRgdDWLOS4GJ/JhGH6oLFqAbyCv6Mfqv4VbuqHDPg+hmAeYZSh4i2BfbkvjBoX/KEzeMvITot7G7SMpGKFkVTLgA5YflF2w/dpa9B2x+T02uhc+qRNtqvFgW6l1ixpkq1BVe4M+txRMpN8ggKTa9dDUAUqlrhHW1Atn8tCbx2HNbP2fwaIdZ8VyQiArs/4fEm802cDPZyUbSF84dLaSocMceZeCjY9UEflLg88aR5B/eexDvNM2yTB3cGRAq4s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVhqdGtxZmJwR2JwS05RcE1uMDhaNS9kNUpITzlMNE81QzEydmdEWHlKeHhN?=
 =?utf-8?B?OTVFWXZXWVhSSUtsTkNBVGNZV3ozck1PWU5reEsvVEQwVHFEdEl1M1dXVFpS?=
 =?utf-8?B?NXlZRmpOUGIwRDMwQjJhYmNSNjMvcnRpRzUrVEUyZ0pDODBzYy9KVGdJNHE1?=
 =?utf-8?B?MGNkdmdBSHpkbWJXaENWWWVFam9KdXBDT2RRYXAvRjJkNS9jM1NtUXBSTjV6?=
 =?utf-8?B?MWJkSU5qMzY5YmtZUGxlcnVkZWNLQXJFWGNkaENDL0NkRHRZQ3VIaWs2VFgr?=
 =?utf-8?B?Z0RDMTRmbXN5Z0hWMU84YzBqdUw4OThmZmV0UG9MMitGV3kwVVJEYjBIMU9m?=
 =?utf-8?B?QmZKeDRlSkVxbUpjUWxnakdIaWNwajlMbW9LK2w2cG1INHZCZHlleTFjcVRO?=
 =?utf-8?B?SWYvRC82RG41Qkt2MEkrZVQrUThnRnh2QkQrZFVPRzN5cXBNbUU3cWI0M2wz?=
 =?utf-8?B?YVRHTm5hQ0tPeVhMSnJPVUtYK2NCY2h1bkMxMXp0RC8wb2hWUWM2UUNPWkpN?=
 =?utf-8?B?K2RoUEtjOUlDakZ4Kzg0VTZHb1NubXk4b3RITWdyOGV4N1JmaEF6cjBCZ3Zw?=
 =?utf-8?B?YWNmU01ERTk2TWM0ZWhRRTdyeWtyZjM3SGM1VkRpNktjd3FGVEtnRjB2V29J?=
 =?utf-8?B?M0Ixck45Uk50UGNJY2R0bGdZd0RlOEVhbVlnd3Z6eW5KZktSa2pJYWdaNjFX?=
 =?utf-8?B?Ui9DV25iTnlpbGRiamhLWi84S1pBSSs1MzgzYkJhdGp1d3NNMFdLb3RjQ0w5?=
 =?utf-8?B?VmkrMUtPZitDSFU3NzBiZC81RERTZktJcDR6L1p3UTZwNFBGV3U3VHByeVll?=
 =?utf-8?B?OFdKaWk3a3g4OWdTVE5aNXUyTHNNQlJITVdiUzV3czhCcVdObkdtRG00czlB?=
 =?utf-8?B?UlNyRXM1bDM3blpkcmJFSHd5NUpETGhoL0V3V2loU0hEcmR1dHpockNQSUpx?=
 =?utf-8?B?RGdwY0JlVjJHNVJQTXRsZTBxSUQ5TkxaYWVZTmVHVnU1WlplWWNYVzV6SEh2?=
 =?utf-8?B?RmE5d1VmUE1ZQVVPU3A1b1hveE5ZUEg2TlhuWnYyZWYzeU55VU5nSXVxcm05?=
 =?utf-8?B?U0xFTW1VOVgxdmVzYTdkbzNQRmNvZEkzQWl5SHBxWExOWkEzNlNJZmFPbDA1?=
 =?utf-8?B?bHRGRStWMjZidjF3b2hEQmpzQXNjZFF0T0c4Y0hWZzZEQ0hlRHZZZVV0VUFx?=
 =?utf-8?B?TFlEcTY0UDJvY3hnQWVBVzBKVFhpMHpJaUxSb2FWR2JpcVZtSUZ5S0VtUytR?=
 =?utf-8?B?cGJ3ck9UaTZINndTaThZd3loRUthb0YxWVg5QWF3aXlmZVV5MVRObjRXNi9O?=
 =?utf-8?B?MGlvSGJOb2tCSVkxUnF5U0J5KzhBM1N1aG1ENGVHcGVOYnUxdEZNZ0ZZOTI2?=
 =?utf-8?B?cVZCUXJNUUprZ3NQaFBaZzNkVkxMaEIxSUw4VXpzenJ4TU15RXVVTHBWaGdq?=
 =?utf-8?B?STl2NTRxak5VNWdDajI1dDhicU9GcWUrMjRTK2RDQmR1OVdYZUhDSzh6aGNZ?=
 =?utf-8?B?eHdrTEFWVXV1SUxOME1jR2tNOCt6M29FNTJKK1Ezb1E3V0QySGc0V09pZWFv?=
 =?utf-8?B?VFFvMFNTcWM1bU1CaUEwSHUvMjYyOVFRY1VDS1ErWDN1aE5SbklFemVxVEts?=
 =?utf-8?B?ZGhOcTN6eDc4N2pQMnlOREx0bkYrRW51RHc0WUVGdVVFMzNVTUN2TVgzKzRn?=
 =?utf-8?B?UzVFQVJQV1pOeWorM1pueVl5N3pVMy9Nb0RFUUVTQ2RwSFhKb1VpMTRUMG16?=
 =?utf-8?B?NW52VStXR3JIRUR6a0dwcGtxdStUQzRDYXRSU1dDd1ZFUFpZejY4YjdEQlo2?=
 =?utf-8?B?ZzAxM2U5U28yeVZjUFRESzVtNStEcTQ2ak1Ra25UTEk1Mk5jZk5ibWFHNm1h?=
 =?utf-8?B?OVlxQmg4TGt2SjhmTkdPeVJpK2lIU2k5L0daY0lTdDY3MElQdDMxZm4rbnJ2?=
 =?utf-8?B?SFV2dlZsdGVuczBINFVNUWFoU1VLc0Rrc1hkV0trRTBGY1JYMGNsYjJrakQw?=
 =?utf-8?B?VjNvQ2o2aTdOUlpSTGdPeVpMMTgvNlhXcnNjbW80MklXaW9VbjgzVS8rVjFX?=
 =?utf-8?B?bk5sSzdsWThkd0xEc2QxTUhiMitGeDFpQXNXRlZGNDRDczRzeE4yd3FyNExL?=
 =?utf-8?B?aVFkVUl5WXhXRktXRUFVVW5hREU2bFpLTlNZNnU5cG1BLzdXVk5jYnFJTWZw?=
 =?utf-8?B?YzFYanJDQWZldk9qY1FNWTR5TWt4QXhRUTgvVUxSQzRVTTBqbi9jOHRxcjlE?=
 =?utf-8?B?aTNEVExDbTNvY21nVkM5K0pqUFY0eGMrazlXa1puSTRVYjBZa3QwTGFLZ0R4?=
 =?utf-8?B?clAwdXJqQWJyY04wYWxCYnlIMlZ1cWRIUWgyNkRxQnRPcFVUUW81QT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240638ca-fc6f-4cc1-54c0-08df3874d8c2
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 00:04:32.3269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wu/557jV8ZqqXMwlP0r1DzSLdghOTlclio9NgtBhyo00Om9sPdt3YJT3wpqi4G5luW+bhO9+Ob6oWf/rE8MqMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB8484

On Sat, Oct 31, 2026 at 03:01:51PM -0700, Namhyung Kim wrote:
> On Sun, Oct 25, 2026 at 10:57:30PM -0400, Aaron Tomlin wrote:
> > When tracing multiple tasks across multiple CPUs, kernel context switches
> > cause different threads of execution to interleave on the same CPU. Without
> > context switch awareness, interleaved function calls corrupt the tracked
> > call stack.
> > 
> > Add context switch detection and per-task state tracking:
> > 
> >     1.  Context switch banner parsing
> > 
> >         Implement parse_context_switch() to parse context switch banners
> >         (e.g. " 0) <idle>-0 => migrati-19") in the trace stream, extracting
> >         the CPU number and both outgoing and incoming task PIDs.
> > 
> >     2.  Task state rekeying and migration
> > 
> >         Implement ftrace_task_state__rekey() to reassign initial unknown
> >         task states to real PIDs upon discovering outgoing task identity.
> 
> Yeah, it's unfortunate that the default ftrace output doesn't show PIDs. 

Hi Namhyung,

Thank you for your feedback.

Yes, it is indeed.

> > diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> > index 95db57e70d11..fc385d680911 100644
> > --- a/tools/perf/util/ftrace.c
> > +++ b/tools/perf/util/ftrace.c
> > @@ -13,11 +13,14 @@
> >  #include <errno.h>
> >  #include <sys/types.h>
> >  #include "debug.h"
> > +#include "evlist.h"
> >  #include "util/ftrace.h"
> >  #include "util/string2.h"
> > +#include <perf/threadmap.h>
> >  
> >  static struct hlist_head ftrace_task_hash[FTRACE_PID_HASH_SIZE];
> >  static struct ftrace_task_state *ftrace_cpu_tasks[FTRACE_MAX_CPUS];
> > +static u64 ftrace_event_seq;
> >  
> >  /**
> >   * ftrace_cpu_states__clear - Free allocated CPU and task stack states
> > @@ -36,12 +39,14 @@ void ftrace_cpu_states__clear(void)
> >  			for (j = 0; j < ts->depth; j++)
> >  				free(ts->stack[j].name);
> >  			free(ts->stack);
> > +			free(ts->watermarks);
> >  			hlist_del_init(&ts->node);
> >  			free(ts);
> >  		}
> >  	}
> >  
> >  	memset(ftrace_cpu_tasks, 0, sizeof(ftrace_cpu_tasks));
> > +	ftrace_event_seq = 0;
> >  }
> >  
> >  /**
> > @@ -98,6 +103,119 @@ static struct ftrace_task_state *get_task_state(pid_t pid)
> >  	return ts;
> >  }
> >  
> > +/**
> > + * ftrace_task_state__record_indent - Record an indentation watermark for a task
> > + * @cs: Task state to update
> 
> Why is it called 'cs' instead of 'ts'?  Same goes to the later functions
> too.

Agreed. That is a relic from when the struct was named ftrace_cpu_state.
I will rename "cs" to "ts" consistently across all functions in the series.

> > +		if (prune) {
> > +			free(frame->name);
> > +			frame->name = NULL;
> 
> You can use zfree(&frame->name);

Acknowledged. I will switch to zfree(&frame->name).

> > +static struct ftrace_task_state *ftrace_task_state__rekey(struct ftrace_task_state *ts,
> > +							  pid_t new_pid)
> > +{
> > +	struct ftrace_task_state *existing;
> > +	u32 key;
> > +	int j, c;
> > +	int to_copy;
> > +
> > +	if (ts->pid == new_pid)
> > +		return ts;
> > +
> > +	hlist_del_init(&ts->node);
> > +
> > +	existing = find_task_state(new_pid);
> > +	if (existing) {
> 
> I think it's better to handle the else case first as it's much shorter.
> You can save an indentation level for the true case then.

Agreed.

> 
> > +		int orig_existing_depth;
> > +		int total_needed;
> > +
> > +		for (c = 0; c < FTRACE_MAX_CPUS; c++) {
> > +			if (ftrace_cpu_tasks[c] == ts)
> > +				ftrace_cpu_tasks[c] = existing;
> > +		}
> 
> I don't this is necessary.  IIUC the rekey function is supposed to be
> called for a specific CPU and caller will update the CPU state.

Fair. Since ts is keyed to a single CPU's synthetic unknown PID
(FTRACE_UNKNOWN_PID(cpu)) and parse_context_switch() immediately updates
ftrace_cpu_tasks[cpu_val], no other CPU slot can reference ts. I will
remove this loop.

> > +
> > +		/*
> > +		 * Prune frames on existing and ts that exited during subsequent
> > +		 * execution recorded on the other state.
> > +		 */
> > +		ftrace_task_state__prune_stack(existing, ts);
> > +		ftrace_task_state__prune_stack(ts, existing);
> 
> I'm not sure about this.  In this context, it knows the 'ts' is uptodate
> and the 'existing' contains the old state.  Does it need to prune the ts
> using the existing?
> 
> IIUC this code assumes either ts or existing may have uptodate state
> like in general cases but it would make the code unnecessarily longer.

The reason this handled both directions is due to how trace_pipe merges
per-CPU buffers when a task starts on CPU 0 (unidentified, tracked in ts
under FTRACE_UNKNOWN_PID(0)) and migrates to CPU 1:

    1.  Task X starts on CPU 0 before any context switch banner is seen on
        CPU 0, so its initial frames are recorded in ts.

    2.  Task X migrates to CPU 1. If CPU 1's incoming banner ("1) idle =>
        X") and subsequent function exits are read from trace_pipe before
        CPU 0's outgoing banner ("0) X => idle") is flushed, existing is
        created on CPU 1 first and actually holds the newer state, while
        ts holds the older pre-migration frames from CPU 0.

    3.  Conversely, if Task X was already known on CPU 1 (existing) and
        migrated to an unbannered CPU 0 (ts), then ts holds the newer state
        and existing holds the older state.

That said, I agree that maintaining a dynamic per-task watermarks[] array
for arbitrary multi-hop migrations before the first banner is superfluous.
Replacing the dynamic watermarks array with a single scalar minimum-indent
watermark on struct ftrace_task_state makes this much simpler and removes
ftrace_task_state__record_indent(), ftrace_task_state__min_indent_after(),
and the watermark merge loop in ftrace_task_state__rekey().

Thank you!

Kind regards,
-- 
Aaron Tomlin
