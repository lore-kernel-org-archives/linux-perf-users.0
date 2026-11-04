Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.107
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793808619;
	b=KPJLg/xeGJ0rOnK6wiW2nWE7Iskp1TnVYWk/X2HLG3RMcpo5AHMuts9KS0/8JbjdN0Qz
	 ZW1wlTYgvnX+KIH2whKd/vILuEA8pQZcQXTY7akVQ3yVZxErN0/XAFQLPYljbzN7vm7Hz
	 51POuplYXCxqFkXhEBIe44HMgE0uwr6lA1QYXFHozPzHHbFtikYCEG8Pvb2H8etkwNAUQ
	 pCjholt9mk41fetK9qLVTw2Dz8eYnq+yEwzyKxrJWcHS6gZ+X9+WAbm2Yi4+gtTJNX65b
	 VLFlOOpte7rczuPz7vxGjsFjv0gq28Gx1rGQbR48SKrI+XmFHVuMlbh5sYJqx4GHMSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808619;
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
	bh=odg2xYqxHix/PONQ4BRrf8qKH/zXOoI5v9t80hp9gFc=;
	b=rcCrht9L2QCHdM0E5G/RbWTekYf6KDG+Pp5AQV6hTZh7QCidG5KrInJlyZZtHVvJnZYR
	 HHombsYZPmsFyUyW8e1G3FAsqzCmqOFOi4GUIvmmU1X4A2C5QcS6woeQJur8jaVJtelIf
	 qv+JRk6LsPremQpiYbKt22dA7gWM6juEXgkPJHCm2f8zk9R5gJVPrIILbeyPvB1aKQq3p
	 wJl334y4pfbX9y8WXFr/qRBm8qcru8jccqesUeK1CRLX4ItAYqSUle+Vd+z/UVs9n4E3A
	 x+3iPCz1Cwev40xyeSckMF1zOioqYqAZ78IqopXNU7lm/NX488TlbyVdH3BHfoRGNMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.107
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020107.outbound.protection.outlook.com [52.101.196.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50847606A326;
	Wed,  4 Nov 2026 16:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50847606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UF7dlJGi6flFy69a7tpoO2afvo4WEozaVTk+xY5Z2soWU446iCXP2VDqwHZdd5+fMKCMiaw2uxkSyLM6iGIfkenT9HR78FcKMa60pRCu6qdYmW8cobxrHXohiGqkknC2tK7fEGMepXYW0XJcB9clwimNIa+7uC/6LFxS7NMGYN4rh4Bs9ln1Ky5s+DV4tPs9tAUOR86Vvhl6bdbIo5mt3HI+o1x3wm3T7Ov4t9YqcdxTfNEeZllHhOdxDBjXzuH53Pm0q/MItHHc6skNXQemQz720iDwRIRCkMJSCMufUuxy6rKsgyWKyDmuI74se6ClrKGc/WViX6HtufEklYNJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=odg2xYqxHix/PONQ4BRrf8qKH/zXOoI5v9t80hp9gFc=;
 b=rgN5Edi9+lF60IJuLYRWRzm7axafw3bcOrMYV8y1XyATLwhJWpfHCsn80+J8uLxVH9mJIHTWYJGV3FzsTk+B7Woe1xcxReniz72FB3YyVckoT9pXa0rJXEZv2suTqChDCqEINUE/+qkpIsHk7bBWpP2A8OxoHJqhlUS80F71xXiJhHsmaAVM70LjclOU9hldP33PexwD54mrM21N5tl1O6K76bS//gFqx+rMUXyN27qAW8Io4d6Sjl8ZNZGsEcaio1CR6UIY/Fp3NzxWSc07rWi8vxukEICkapkNe/Sbyy6RhRUhhjv8WG9tJ8rGJBS/vs/YCvjEsm2dwSEJAgKyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO0P123MB4186.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:10:15 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:10:15 +0000
Date: Wed, 4 Nov 2026 11:10:11 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, chjohnst@mail.com, neelx@suse.com, 
	sean@ashe.io, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v12 04/10] perf ftrace: Add basic task
 call stack management
Message-ID: <v25akf3qmsncyec2awcyl4btk4jybkog33fp6w2l7q33t4246a@uwmknpmfbvgo>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-5-atomlin@atomlin.com>
 <auWTUJd4VJUI32S3@z2>
 <5s4fy255agvlgqdg4b4f5ekvhgmpjndydvsaadeq56cubrtgot@mrflkcricted>
 <aurgSbFGfN0VC2L6@z2>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aurgSbFGfN0VC2L6@z2>
X-ClientProxiedBy: CH0PR03CA0368.namprd03.prod.outlook.com
 (2603:10b6:610:119::17) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LO0P123MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 699f464d-fbd1-48f9-5f92-08df3a8e1ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|7416014|4143699003|56012099006|261009223027099003|261021121427099003|261028144727099003|261026121527099003|261022105027099003|261022075727099003|261102123227099003|261026140227099003|10067099003|18002099003|22082099003|6133799003|3023799007|27256017;
X-Microsoft-Antispam-Message-Info:
	Fm5vjVpgnsHKV8CS64B7iZGjgtBw5qdJDXAU9vg8Ajq3BICq2PYCYLPvLkyf+o6+iUakSOJQEfRREePKlwkgqubJxPQLoluK5rPntjdFk8PZrI8hfgFssGr6koy5NWpWOy6Be/+qeVNUUceH+mYGHFlpyFlAnPE+Y6Hd+k4IzRIxhV5Wc2MMMBWQvSU6LZ1e9ggp36bhcVDLloCigSjXSYwuDUpOozAs90A4sA16qxt+8v2Von3FGP/vt1bbmezoqWXy7KILkL3I5p8YYXFBb/+BDCkf4U/YRwV/CMpVRAGQxfLWN6lOGkoHvThA1gyjxqlteLjGdWOAXI5SojrkP6T2B5LU/Qf7+1mQq6pvJ2rYxLG1FN/fYrIyhg1Mu5tv+W1acm9Icy46aMx68TViHotIMVc4CbQeSKIH3x6HZE4bDBl859ehC4w6gjNnSl8pDp+QJ7W9cLIUSV9LLA1samnG82f3wjYDzA1glfwpBlpOe+s2MxVVzBfSMT9x1SFfFE3CWjGU9YM00bbHUjYnvLJSwchsr5M+I65jsjB1riqPtECeqHSisj+tCNIPCiz76Rg2iFXwsof9cj+8WWBLiaQAXu5J6PUKefwCKLXkM76UrGbL64CYo3qz0ZQZG0HQNFXAJCrQr8kWp6D6c4xVG2tFnIWteX4GyKsF04bOjKnf4fDKj71ynSuhKq9vX5CCZZpm/UeSsHxlDgEB9ieB0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(7416014)(4143699003)(56012099006)(261009223027099003)(261021121427099003)(261028144727099003)(261026121527099003)(261022105027099003)(261022075727099003)(261102123227099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkZZRVZHU1BEbW5uQnFsekFGTWpqU0tsSzdZQlowNDhSTUh1a1hWMDFpSllN?=
 =?utf-8?B?Nm1ScVV0c3BQWGlFa0VhV3pFRUxQSnV4ZTF6WWRTRmZqU0lQenpZNTgxc0x6?=
 =?utf-8?B?VTYyQTV2K09IMmNWbUhzUHd4K3doSmdvYWVzSTZmUVJSbGNwNytTS29Xc1c2?=
 =?utf-8?B?d0Q5cHZFUDdpajl6UFEzWHBQRFdQWjFWT2JOTW9WWjM1dVNVZk1DVExwRmJi?=
 =?utf-8?B?RWNkSEg4VUMxSDVXMk5TMWtQdTBsd2pOZHpSamd0WjZRRFFQQzRVOEFQV3pq?=
 =?utf-8?B?MGRkWGtxZEc2RE56a1RYbk5RdzdJQ1VRM2lNblJ3SGh4ZVQzZDdZelN2Nm50?=
 =?utf-8?B?Ulhrb2RsT0YrZ3hqU3AwMUUyTkI5SERrZU4rOXNaZzZrL2pGWHBqMmVIdUlm?=
 =?utf-8?B?eTk1Uy9NQ3pnTStFemdicDBlcGI0TFplTkQycDFIbjhuQ0NrWXNSYkNON05V?=
 =?utf-8?B?bzBYcU9UMXgwYVVUS1pWcmtpNlprVVZiSDI0OEdKKzRuVlRQZWdVNnZubk9u?=
 =?utf-8?B?QnN6Y1k0U0VzWUJ6L2lvWHRWWHk3RFpEbXF1V29pdlFodCsyNE5LQmJ4N05Q?=
 =?utf-8?B?TWdseU53a0FZQys5V3lQSVFRNWxlVWFpTmFZaW9nUlFzb2pISm05NEtQNG9l?=
 =?utf-8?B?T2Ntb3hBRDZoVTBqMXNHYzVxdW4wWGp5TkhwTjF1NXIzUjBUWE9UelF5Qm83?=
 =?utf-8?B?Y05TTy8xS2d4czgxZjE5SzJqa1hTaUJSZzBPdkxWbHhtOEVlL0ZRa0YxMGV6?=
 =?utf-8?B?OHY3N0dWdmN3WURJcm9VTFlVNkt2OEVnbVZLTW1nS1VzRTVOVkczR2xmUGJ3?=
 =?utf-8?B?QXBVd3Fjck5FN0lmMlhmLzQwK3JGYUdyOHR5aDJTNE04QllEbXJzQjBNcysr?=
 =?utf-8?B?SHBKalprbFEyWXRaWC9uQlZmUzdpb2hFbEM3bHJoL3pqb0hETEhDOGE5NS80?=
 =?utf-8?B?bmFnNU9DaU1qNGZOVHhkc05pTFp1Wko5ZDkrU3BBazZ1ZTVZK0RSRFh3bFVl?=
 =?utf-8?B?WWpPcFJiSWNVampVMzY2MnIrQU1aWFZkcnZJVEl2WGJkTFNoOWVzWEVXZndI?=
 =?utf-8?B?TWJBS2FNc0Q1NzJ4L1E0YmgrblYxdkpBZEFub25Fc1Z3L0NYTUlUSjBnUWlV?=
 =?utf-8?B?SGJaSTVsMy9qcHErU1JkeFNweTdzTityanVpNjlaZm9wL2dGM1lMbDZ0OHVz?=
 =?utf-8?B?NVZiSjk1cS9UdHBJblFlL0E2eFNoTHF5VW1qVlNjZ0I5aXhwMDd3Q3NRZndh?=
 =?utf-8?B?eUpteHZuOWJXckgwKytxVU40WG9ZR0lFalAwYUNWRDlub3JDTUlZMVBVQkM4?=
 =?utf-8?B?ait4TzFjbThhekxWeWlRVUpMYjBVTWt1MTFTUDZzYmZEbVY0NnNMN2ZWc2V0?=
 =?utf-8?B?L09QTGRNZG5EN0tXSmdFUVpNdENZR3F2V2JxRkNJZUJjYzJFMC82ZlpvZkl3?=
 =?utf-8?B?TEdBSEpUZFcwaXEvRUpGVWFOSnZxNWpWZno2RXNYL3MxTUQ2ZnZOeXk3aGl6?=
 =?utf-8?B?YUZYdG5TdWkxejNEcGgzUzBUM0pKZzF0Q3ZpQVg0NWFjZUxLNGNSdUg0MXdH?=
 =?utf-8?B?a3pKbllnMm92M1BwOUpvR2FJWWludjB4WmtSZVJ0VzdXdm0rYTBhMXdzSThS?=
 =?utf-8?B?d3lGTUxwSVZmVkZKeERCcFhuOWpNNUlJUGtsYnNENzk3aXFpS0N5N1cwdHB3?=
 =?utf-8?B?dkVRRHJwK1lOZ3NnVkxJNjd1b2ZxM2lOSE5Rd1JWd0FLSDIwM2VXdTI2Uk04?=
 =?utf-8?B?NDQzaGloVngxaDU3VVZxWlBXazRzYjVHVjE2a2ZnbHZ2ZkdUbDAyZGpIOHlM?=
 =?utf-8?B?NC9lL3hmSWRlVjZxamkwLzNSNlFMN2VVZnlsdlVjSE5ESVY1MERCU3huTC9u?=
 =?utf-8?B?SGd5NHNEQm1PSTlxMmo4bVpRSXJvYnk0eTdNaUxTeStlTm9yMmVlSDdiYW5D?=
 =?utf-8?B?S1NFRmExajUzd2Jna0wrUnlGYjZDVUNGeGRIRG5jRWpSUWkrVmVIbHJCVVZz?=
 =?utf-8?B?MGl5RWhPRmhlK0lMdW96UkIzQ21WbDg3Y3pPOTAzR0JpelJhU2JKbXh1eElB?=
 =?utf-8?B?aXIrVStadnFSc2hMNHU1MStXWFVLdldxNDlPdHpsNzByQzlSbXV5emk5Z25t?=
 =?utf-8?B?eDRRYmVUQUxheGRncGVDOE5adjYxR2IrUEZockxpejlUdElkclZWTy8zY1ZY?=
 =?utf-8?B?L2JFcHNKbi9NekVqOWlLZ3NVSDRYL1hQZTZBMzU2ZWh3Mm1YRWZzUmJ3YWVV?=
 =?utf-8?B?R3pWSXBDeUl5aHBGRklIMDROTUhQVzkyakZDbFQ2dTB0NHpnMkhWWUVEVVBX?=
 =?utf-8?B?djJYTk8wRVR0OThwVG5IR3hYQm1UdDUyLy9uVkY2N01LbUgyN1JGZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699f464d-fbd1-48f9-5f92-08df3a8e1ce7
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:10:15.7066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7PHAv4YLC001Wl0y04FK4Gv3QILmUYUht3+xkinpicm/txyKRg8M9RbR6BNR8BX+yhfsbKCnbdC05wGbLRdpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB4186

On Tue, Nov 03, 2026 at 11:35:37PM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Sat, Oct 31, 2026 at 06:27:42PM -0400, Aaron Tomlin wrote:
> > On Sat, Oct 31, 2026 at 12:05:52AM -0700, Namhyung Kim wrote:
> > > On Sun, Oct 25, 2026 at 10:57:29PM -0400, Aaron Tomlin wrote:
> > > > The function_graph tracer records kernel function entries and exits with
> > > > nested indentation. To perform call graph analysis and subsequent inlined
> > > > function reconstruction, userspace must track the active call stack on a
> > > > per-task and per-CPU basis.
> > > > 
> > > > Introduce basic call stack management for the function graph tracer:
> > > > 
> > > >     1.  Data structures
> > > > 
> > > >         Define struct ftrace_stack_frame to track function names,
> > > >         indentation, and inlined status.
> > > > 
> > > >         Define struct ftrace_task_state with a dynamically resisable call
> > > >         stack array, tracked in a hash table keyed by PID alongside per-CPU
> > > >         active task bindings (ftrace_cpu_tasks).
> > > > 
> > > >     2.  Trace stream processing
> > > > 
> > > >         Implement find_func_column() to isolate context columns (CPU,
> > > >         timestamps, duration) from function graph trace lines across
> > > >         standard and verbose layouts.
> > > > 
> > > >         Implement ftrace_process_fgraph_line() to parse function entries
> > > >         ("{") and exits ("}"), pushing and popping frames on the tracked
> > > >         stack and matching bare closing braces against preceding frames.
> > > > 
> > > >     3.  Integration in __cmd_ftrace()
> > > > 
> > > >         Stream complete trace lines through ftrace_process_fgraph_line()
> > > >         in __cmd_ftrace() and clean up allocated CPU states on exit via
> > > >         ftrace_cpu_states__clear().
> > > > 
> > > > Tested-by: Ian Rogers <irogers@google.com>
> > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > > > ---
> > > [SNIP]
> > > > +/**
> > > > + * ftrace_process_fgraph_line - Process and output a function graph trace line
> > > > + * @ftrace: Perf ftrace context
> > > > + * @line: The trace line to process
> > > > + * @out: File stream to output to
> > > > + *
> > > > + * Parse function entries and exits, maintain the task's call stack, and
> > > > + * output the trace line.
> > > > + *
> > > > + * Return: 0 on success, or a negative error code on failure.
> > > > + */
> > > > +int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
> > > > +{
> > > > +	const char *pipe_char;
> > > > +	const char *after_pipe;
> > > > +	const char *func_start;
> > > > +	struct ftrace_task_state *cs;
> > > > +	int cpu = -1;
> > > > +	int leading_spaces;
> > > > +	int top_raw_indent;
> > > > +	int match_idx;
> > > > +	int i;
> > > > +	bool is_exit;
> > > > +	bool has_open_brace;
> > > > +	bool has_semicolon;
> > > > +
> > > > +	pipe_char = find_func_column(ftrace, line, &cpu);
> > > > +	if (!pipe_char)
> > > > +		return print_line(ftrace, line, out);
> > > > +
> > > > +	cs = get_cpu_state(ftrace, cpu);
> > > > +	if (!cs)
> > > > +		return print_line(ftrace, line, out);
> > > > +
> > > > +	after_pipe = pipe_char + 1;
> > > > +	func_start = skip_spaces(after_pipe);
> > > > +	leading_spaces = func_start - after_pipe;
> > > > +
> > > > +	if (*func_start == '\0')
> > > > +		return print_line(ftrace, line, out);
> > > > +
> > > > +	is_exit = (*func_start == '}');
> > > > +
> > > > +	if (is_exit) {
> > > > +		char exit_name[128];
> > > > +
> > > > +		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
> > > > +
> > > > +		top_raw_indent = -1;
> > > > +		for (i = cs->depth - 1; i >= 0; i--) {
> > > > +			top_raw_indent = cs->stack[i].raw_indent;
> > > > +			break;
> > > > +		}
> > > 
> > > This loop doesn't look natural.  Why not just use an if statement?
> > 
> > Hi Namhyung,
> > 
> > Thank you. I completely agree.
> > 
> > A loop that unconditionally breaks on the first iteration is
> > unnecessary here. I will replace it with a simple conditional check in
> > the next revision:
> > 
> >     top_raw_indent = -1;
> >     if (cs->depth > 0)
> >         top_raw_indent = cs->stack[cs->depth - 1].raw_indent;
> > 
> > All subsequent similar instances will be addressed accordingly as well.
> > 
> > > > +struct ftrace_stack_frame {
> > > > +	char *name;
> > > > +	bool inlined;
> > > > +	int indent;
> > > > +	int raw_indent;
> > > 
> > > Can you please add comments that explain why it has two indents?
> > > Also inlined field may be added later.
> > 
> > Certainly. The two indent fields serve distinct purposes once inlined
> > frames are injected into the output.
> > 
> >     - raw_indent: Records the original leading whitespace count after "|"
> >       as emitted by the kernel's function_graph tracer. Because the kernel
> >       only traces real stack frames, raw_indent is used to match entry and
> >       exit frames against the raw trace stream.
> > 
> >     - indent: Records the adjusted visual indentation (in spaces) used when
> >       rendering the frame to output, accounting for any extra indentation
> >       added by preceding synthetic inlined frames so that the closing "}"
> >       aligns with its opening "{".
> > 
> > Agreed, these fields are not used yet. I will move inlined and
> > inlined_depth into the subsequent patch that introduces inlined function
> > display, and add explanatory comments to both structures.
> > 
> > > > +};
> > > > +
> > > > +struct ftrace_task_state {
> > > > +	struct hlist_node	node;
> > > > +	pid_t			pid;
> > > > +	struct ftrace_stack_frame *stack;
> > > > +	int			max_stack;
> > > > +	int			depth;
> > > > +	int			inlined_depth;
> > > > +	int			overflow_depth;
> > > 
> > > Ditto.  What are these depths?
> > 
> >     - max_stack: Current allocated capacity (in frames) of the dynamically
> >       resized 'stack' array.
> > 
> >     - depth: Current number of active frames stored on stack.
> > 
> >     - inlined_depth: Number of active synthetic inlined frames currently on
> >       stack, used to compute the extra visual indentation offset for
> >       child frames. This will also be moved to the later patch.
> > 
> >     - overflow_depth: Number of nested call frames entered while stack is
> >       saturated (at the maximum depth cap or on allocation failure), used
> >       so their matching exit braces can be consumed without prematurely
> >       popping valid parent frames.
> > 
> > I will document all of these fields with comments in the next revision.
> > 
> > Please see an example. When synthetic inlined frames are injected, the
> > visual display column (indent) shifts right relative to the kernel stream
> > (raw_indent):
> > 
> >     1.  What kernel function_graph emits:
> > 
> >            |  foo() {                 <-- raw_indent = 2
> >            |    bar() {               <-- raw_indent = 4
> >            |    } /* bar */           <-- raw_indent = 4
> >            |  } /* foo */             <-- raw_indent = 2
> > 
> >     2.  Rendered output and stack state:
> > 
> >         When perf injects inlined function inline_helper() onto cs->stack,
> >         inlined_depth becomes 1. Every subsequent child frame shifts right
> >         by (inlined_depth * 2) spaces so bar() nests visually inside
> >         inline_helper(), while still retaining raw_indent = 4 to match the
> >         kernel's closing "}" event:
> > 
> >            Rendered Output            cs->stack[idx] and ftrace_task_state
> >            ---------------            ---------------------------
> >            |  foo() {                 [0] foo:
> >            :                              raw_indent=2, indent=2, inlined=false
> >            :                              (depth=1, inlined_depth=0)
> >            :
> >            |    inline_helper() {     [1] inline_helper:
> >            :                              raw_indent=4, indent=4, inlined=true
> >            :                              (depth=2, inlined_depth=1)
> >            :
> >            |      bar() {             [2] bar:
> >            :                              raw_indent=4, indent=6, inlined=false
> >            :                              (depth=3, inlined_depth=1)
> >            :                              ^
> >            :                              '-- indent = raw_indent (4) +
> >            :                                           inlined_depth * 2 (2) = 6
> >            :
> >            |      } /* bar */         <-- kernel function_graph emits "}"
> >            :                              at raw_indent=4. Matched against [2]
> >            :                              via raw_indent=4, but printed at
> >            :                              [2].indent (6 spaces)
> >            :
> >            |    } /* inline_helper */ <-- Popped automatically; printed at
> >            :                              [1].indent (4 spaces)
> >            :
> >            |  } /* foo */             <-- kernel function_graph emits "}"
> >                                           at raw_indent=2. Matched against [0]
> >                                           via raw_indent=2, printed at
> >                                           [0].indent (2 spaces)
> > 
> 
> Thanks for the example,  the comment also look good.

Hi Namhyung,

Thank you and you are very welcome.

Kind regards,
-- 
Aaron Tomlin
