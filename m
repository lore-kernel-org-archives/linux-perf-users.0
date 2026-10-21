Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792607046;
	b=Rmgx3Dm0KrMNMUqG3gNDmIp95Pwkid5j2lokFyIAXWHLoLi/Avkwu9wS8NNPAYkGQtdr
	 NgE4xoMw/LaISZ90JjhHI59htZPepvWxI+G757LZPsIgf7AzX3ZYLd3DtASKUj/12MA7F
	 n9m9v9F4ewKNMr+7IPyab4ZWAgp2+SMVL+jbcAPVpYh2yiqbtuHKmYWumBamEX0lj5Jiy
	 SI5rAmUeaMl4nxXFEE1KXz39VxA1QacUpz/R9vWFcM9F2JiWLnh+BH0ncm+dqExka0i9z
	 vhVOQs6ncppKOl+iGXE4WCztT1gjkl4l8itZmLj5m432UmLwZqdVceUyIu11FNSuSyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792607046;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=WUu/Ygwd6lBvyjjMRbAIgj0U2czq87q32h2ZPK7dHso=;
	b=4V5JfxTD/FB6++frxYyXt2NMlKvCdISG5w00BgiJpoE5kWYPZvQw1klY+o0GvyOoS43C
	 jRigXYC+F1Zx5dKLPq9Dlid8+mSaPMyXLhoXLNz4s8Kez9eDJP8XoUEm5vG5r+3IeIySE
	 QUxUD64UCU1B8DNkkKtkUkw3a7nW1f/3rx8AwGOPg2AR20+BFhu8wqEmzdn1BhV3vhIsi
	 5O7LG88ZvCm9tisRsrzIjtqdg8tw/LvzpQz8Iv5RQVtp7lnzEekNNcrhb92l4Pi/s476S
	 wsxgMxpFjatGfumX9/V2vKXUYa2pkfGLq3vhxo1ioSnyVxpSl+xmUaCsN2XeBRdq2rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.94
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022094.outbound.protection.outlook.com [52.101.101.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E49606A319;
	Wed, 21 Oct 2026 18:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1E49606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2ubgkZ04/bm4USD0KiQ1ZNzOozd711B75dZqRVtf1gyJNstsLx9xzzY6FBC3OR1Hf8pNdZTl3aq+Xswjsn9I7I+BmCGsORqGKogB5f2L07iZy00lhrgIMpWXmP8yDiJQC7nposZseAhxC+UZxpmDw97ZW/Ccd0JqyiB4FrY8D4zVfAT5LnWp99dkM7+iiYFMWV6Oy7YSQfT21zLzc04fc+/5pAWbsQMWNrI44W8e/gX5Pkg+mktUqPsOKcxA1ZWzAdPU85EMop6NrgA3JFW9OVGWgK5ua9MFpTyquNKkDoe6pp+Gaq33naEfbQEbloWJjLXpJ1IcK2bYKONOuvNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=WUu/Ygwd6lBvyjjMRbAIgj0U2czq87q32h2ZPK7dHso=;
 b=n/3jZtGpjTBnk6uJ5wkYtRc0KaBf+fjKUM8jfIwkKnkwKATqvXX0AsAjbOblWlNfuPdtIXXZ5X476zy4Xz1A5kM4aDyAgKtlEzY6cPVvcXnXOQZwRWEWRbhMIhkZPeuxddu+3p2/A0IvkkG2I9ZHhf1duLv/cIBqTPj4YNhS8HMHDMaVO/boQdCqcH2Wpfcxp9dTJHw2BOHYDV8IYmC10IVW/v/m4N74bW6X91APF/zmG6kbJuLQInN6iOI7FbY8vSP7PGXMasduNdjDfwI2C6kpyPghvzxUuTkbNJHjVGUirNjHu6Kp6grAh36xPQdTSNemVOG2Q6xG9Pw6xoD2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8272.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:25f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 18:24:01 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 18:24:01 +0000
Date: Wed, 21 Oct 2026 14:23:54 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, sean@ashe.io, neelx@suse.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v9 0/6] perf ftrace: Support inlined
 functions and display enhancements in function graph tracer
Message-ID: <csxzfr23eys6go2rx3k65kwppzuia52b7ew77akamspqfy6wzo@tz6qvkpgxqg6>
References: <20261021023337.809936-1-atomlin@atomlin.com>
 <CAP-5=fXx-0OmT4q0Y_nMGVQ35zOKaJ+bSLgHBvGJ7CFZVxL1cQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXx-0OmT4q0Y_nMGVQ35zOKaJ+bSLgHBvGJ7CFZVxL1cQ@mail.gmail.com>
X-ClientProxiedBy: SJ2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:a03:505::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e160443-2eb5-4b1b-32d5-08df2fa07aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|261021123027099003|56012099006|4143699003|5023799004|261009223027099003|10067099003|18002099003|22082099003|6133799003|261021135927099003|3023799007|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	C7cHO2lU+U/hguYcsFptdnbI+2WL0aZxYCfV+4YWMzAC7Mg+RKbCW/vBU40oRvMzWEiUv0qiwXZM4LpUqqanhQVOiueNRpYhqIaXpKZ8hGIof6iMDhOnCiFEpYDuNYRR8HPG2h19DIs/WNg7tjxUqMQuwarqYWsHuwjx7nOGx49yvxpRtXMqMO/Fk76iY+OPSf2YIKc5H/DENS3pEEPDc3GQUtixhESIwdPBdNrylakINDF7cMZkKNcMMOUlDrFvaNpyAUANSMAxbdlfiDdBFPK33lOa4fTimzmPpmB1irzguRal+eP+m9wvBVNJOf7oPtfbIkuoWd/4Fq9gM7Tj/JtHV0f/U6jA6n3xiqCugE61a5uH4phzr6VRyeJu8YACR1fTrV5RU68ohyJoOyEt/CxDcMHxdDjmqgnnYVOxKYzD0H7cswjBDlyjgnuvbVCx7zU/88031o99TwlP79Yp3XgBhVWbI4eu7eMHEXFbt/aGK5CZ2BRRNRfxz6aY+tPylAQBfs6tLc1rytldLmkIqKiFjm2jYz2JP7KwQzpRa3pWC8ye6YSOz5qevw4ke1yJoCNH1CLD3sm5kSgPjARRrfeci+vRSrirdQkZ2LYnILRgw0XuJoY2XUUbKz9uzOMbiWZmnQ6r5aXuRPUJVBnCNWL5jItgTaekhPvPs4JllFM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(261021123027099003)(56012099006)(4143699003)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(261021135927099003)(3023799007)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODFDanNkNXQxNnNIM2EyVXJ1VUVDN1RlSDZwSTZKNUxleWdkeVdqU1NIZFV2?=
 =?utf-8?B?RXJNd1pjZlZHU1RCR3l6TlpLQ0lhcFY5Y2pvMHB6R2ZPY0hVZVM1WndGREMw?=
 =?utf-8?B?WHZnYm12SDhjME52UVlucGlheEJObEw4ZVRCQWhvcFdSUFdBY2krNDJ4RGZL?=
 =?utf-8?B?cTZWWmt1MlZGZzNibUFJaW44V1ZVQ2YvQ3ZKWE9WZ0lhRlAycFB6UW84TTkw?=
 =?utf-8?B?QjFVSlVyRlNIczZDdnB2SEtLV2hmZjVqemZrUXEyU1FobkxXNHFwYWR2ZnVP?=
 =?utf-8?B?WkFrUWEyTmwxbThpcnVkeDIvalhRdUZLTndIWXFnV0w3S1RINm40OXFwdElt?=
 =?utf-8?B?bFR0Q0s2M0FMdmQxb3llb0pyMXdMa3BpeFFmWmdYM2E0K2VtcW1RRnhMR3V5?=
 =?utf-8?B?VFBSVjF6amFadmxpTkZYVWdMK1JWZnF0Qlo3TnVueHEzR0Fia2NibUMwNFFE?=
 =?utf-8?B?azJ2c3JacTdFSk42SndCRjFrYXN2VnN1dlNaQnR0VlJLSDBBWmxHZnFlYXVD?=
 =?utf-8?B?ZUpBZ2dPZXMxOWx1Z25YblNORzRFSnl0ZDVxTEV4NzV0OFd4VWMzcGd0MDhN?=
 =?utf-8?B?bVphRzhnaG9GQldaVytwanIwUE1OUDZ0TTY0OGc2cXNuZ2I4YndsRlpCQ0Yv?=
 =?utf-8?B?Y2NURGNaZTBhY0daL1Z1WWRGalJjeWpZWk9WTVRJWjlmUk1odVJFdEMzdllq?=
 =?utf-8?B?MzZmVEgza1ZqVnpMcmRNbGxIL2dyMmdUUWNBRExqdDZTU3lqeWkrVmVIYVVl?=
 =?utf-8?B?UHgzK0x4U0s1djJnWngweFdQbWR1RHVFd0hlSkRBRHhYZDc5VTczaXpOZ3kr?=
 =?utf-8?B?c0t0V0V3NmM4M2pDVms3MFhiWEdvcWpCMW1KVnl6TG45T0tERWc1ZzhxSEpY?=
 =?utf-8?B?VFFXeXY0ZDU1aHBGWXhGU1VOc3pJYVg2ZzZBbVBSbitydE50dzN4OVdKM09E?=
 =?utf-8?B?cmJGZmZDMlNRZlJVVWlnVDVSY3cya0l3RzYra0cwT1k2UXRxald5K3JESGJ1?=
 =?utf-8?B?Nk1hUkRIT0dvNzJRQk1mNGV5UEpnUEk1YksvVzNQT1p2WE1MdmpHR0pHc3Vu?=
 =?utf-8?B?ZGJ6c0w0SmxBaS9SMVBwQnpQdEE2cHJYa0RQckdjUHBGekJBb2NibGl3UHAw?=
 =?utf-8?B?RU41d3RPUGVyUkhpcm1vVEh5aFRhK1lZcnFCOGphYWVDTFRLVUpSbzNhb0Zy?=
 =?utf-8?B?d0ZIMkoyKytyaFlFUTArS1czRlowQ1g2bk1mbFMvWjd6aUNoRE9ncG4vZnpE?=
 =?utf-8?B?d1A3NlhNRFMwL3l5WWxlWm5HSkh4UW43V3NVa0ZtSzNQNTIrdVZodmszSFhB?=
 =?utf-8?B?b2lhTDdaUmpwTkMvSk9ySzJEUEVaRXpwTGhaNm9HM3RVUkFDL3VNWjhjbkJ6?=
 =?utf-8?B?OWUxdU5mZENzeWg2TkhRY2dYajI4cnhORU84bytRbDlQUEZ3UUFVbTl0QkRr?=
 =?utf-8?B?R0NYc1hML0doRGdXUG1aMis0RDZrNU1jd1JwZ3UyWHBvVm1ZSnVFUURueDBh?=
 =?utf-8?B?dDU2anZPbS82dCtQNFM1eCtpNVJiK1Vwd0VQdERvTlhJNVBQWTBCQ0lveEtT?=
 =?utf-8?B?QmFMT0JJdHN2M3VTbzdPYnZpZTFrc3ZaR2lxOCtYL3hJQ1dySzA0NEVtRFZJ?=
 =?utf-8?B?VjlTOGpTVkVkLzRnNUpkUXFKZCttbytVQ0dsRGtNY2dsQmZFTm8wTXhzY2Vr?=
 =?utf-8?B?L2JndlFRMVowVFV5NFlNKytXakVXZlA4VWJCQVVNaFhjZEJ2YzZSME5wd042?=
 =?utf-8?B?S0hQdUczQU1aWDNnT2JXQUFsL1NmZWZ0c2NNbEtCT3ZCNC9pM2szRE1PaDFm?=
 =?utf-8?B?RVZMYUFydVo5SkhUbEMwdU4ySmVKYUhTWXJyTGplQko0M1gxeStLSmdkV2kz?=
 =?utf-8?B?bTlYV1hBUklZeEQzYXR2SFk3Q3E3WVJUNStuRkRvNm05Vkh4VUZoc3pEQi96?=
 =?utf-8?B?WlE2QkpLUjJ5MkpTSFNHMjRJb0RVcG4vWE56OVJXNG02TW4xRzZrMTZ1Tmxs?=
 =?utf-8?B?MnR2YUdGYlBnWk1hSERZWFBpVGNZTk1FVUlicWVJZGhoRWF1ZXRsTFJpajk2?=
 =?utf-8?B?OHRxNGJ6Q0VVMVBRNm4wNThwK0hZSmZEbFJES0FQSUdUdnhNZWlpbTlGUHV4?=
 =?utf-8?B?MlgrYSsrclpJcWYvTXlvUEx5WEVXRStveno4NHd3OUdUZitjYjRCOEJza2VX?=
 =?utf-8?B?cGVFMnVhdkd5ME5NcmZTQ0V4NHJPbWNFVmkrRWxWeUl2M0FaVmd5dDFmR25P?=
 =?utf-8?B?K1o0N0U4RXRsVll3UUpyL043YzdiUThGTGpGMU5EeFRwY0N6WTRremdHU0tC?=
 =?utf-8?B?ek50MkVWYXFRTVNHdnVuZlRaa1d3dmRHbEw0dlBtRDVud0FGSld6dz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e160443-2eb5-4b1b-32d5-08df2fa07aad
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 18:24:01.2871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWr7v8VB3lpngtbPgG5VnVj4AbI4m8ZFbnSQXLvKmJoes1vyyrquOUOjy1FZ8dUwMVJOdDmzXDMNBzbHb8wSwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8272

On Wed, Oct 21, 2026 at 09:36:59AM -0700, Ian Rogers wrote:
> On Tue, Oct 20, 2026 at 7:33 PM Aaron Tomlin <atomlin@atomlin.com> wrote:
> >
> > The Linux kernel's function graph tracer operates at the machine
> > instruction level via compiler instrumentation
> > (-fpatchable-function-entry), recording entry and return events for
> > physical function calls. Consequently, functions inlined by the compiler
> > are invisible in the resulting call graph, as no discrete call or return
> > instructions are emitted for them. While technically expected, this
> > omission frequently obscures the logical execution flow when analysing
> > kernel subsystems heavily reliant upon inlining (such as the scheduler,
> > memory management, locking primitives, and RCU).
> >
> > When the kernel is configured with CONFIG_FUNCTION_GRAPH_RETADDR=y, the
> > funcgraph-retaddr trace option records the caller's return address on each
> > function entry, manifested in the trace stream as a comment
> > (e.g. /* <-wake_up_new_task+0x1d1/0x3e0 */). By interrogating DWARF debug
> > information from the kernel image (vmlinux) utilising libdw, perf ftrace
> > resolves this return address to its inlined callchain and synthesises the
> > intermediate inlined frames directly into the streamed call graph.
> >
> > This patch series addresses these challenges through six focused commits:
> >
> >     1.  Stack frame optimisation in __cmd_ftrace()
> >
> >         Replaces the 4096-byte stack array in __cmd_ftrace() with
> >         dynamic heap allocation alongside struct strbuf streaming,
> >         reducing the stack frame footprint by over 96% (down to
> >         ~160 bytes) whilst ensuring complete line-delimited records,
> >         explicit NUL termination, and robust error unwind and EOF
> >         handling.
> >
> >     2.  Return address comment filtering
> >
> >         Introduces ftrace_parse_retaddr() and ftrace_filter_retaddr()
> >         with --filter-retaddr and --graph-opts filter-retaddr to strip
> >         caller comments from trace output, accompanied by an initial
> >         unit test suite in tools/perf/tests/ftrace.c.
> >
> >     3.  Preparatory vmlinux lookup helper
> >
> >         Introduces vmlinux_path__find() in tools/perf/util/symbol.c and
> >         symbol.h to search standard vmlinux paths and return the first
> >         accessible kernel image, providing a generic helper across
> >         tools/perf and avoiding hardcoded access() checks in tests.
> >
> >     4.  Inlined function call graph reconstruction
> >
> >         Introduces --inline and -k/--vmlinux, dynamically synthesising
> >         inlined frames marked with /* (inline) */. Correctly matches
> >         bare closing braces when funcgraph-tail is disabled, clamps stack
> >         depth to prevent indentation drift, and expands the automated test
> >         suite to verify inline resolution, comment filtering, and stack
> >         saturation recovery utilising vmlinux_path__find().
> >
> >     5.  Execution duration suppression
> >
> >         Introduces --graph-opts noduration (accepting noduration=[0|1])
> >         to toggle the kernel's funcgraph-duration tracing option,
> >         omitting the duration column when the user is focused purely on
> >         call graph topology and inlined hierarchy. Rejects noduration
> >         when invoked under 'perf ftrace profile'.
> >
> >     6.  Extraneous function filtering in function graph tracer
> >
> >         Introduces userspace call graph filtering when targeted
> >         tracing (-G or --graph-funcs) is active. Suppresses transient
> >         unrelated entries arriving before filter activation as well
> >         as detached callee trees (such as ring-buffer wakeups)
> >         originating outside the target hierarchy. Dynamically resises
> >         the synthetic call stack to eliminate saturation edge cases and
> >         accurately suppresses detached subtrees without orphan exit name
> >         collisions.
> >
> > Synthesised inlined functions are rendered with an explicit /* (inline) */
> > annotation at both entry and exit:
> >
> >     # tracer: function_graph
> >     #
> >     # CPU               FUNCTION CALLS
> >     # |                 |   |   |   |
> >      0) enqueue_entity() {
> >      0)   update_cfs_group() { /* (inline) */
> >      0)     calc_concur_shares() {
> >      0)       tg_cpus() {
> >      0)         cpuset_num_cpus() {
> >      0)           class_rcu_constructor() { /* (inline) */
> >      0)             rcu_read_lock() { /* (inline) */
> >      0)               __rcu_read_lock();
> >      0)             } /* rcu_read_lock (inline) */
> >      0)           } /* class_rcu_constructor (inline) */
> >      0)           cgroup_e_css();
> >      0)           class_rcu_destructor() { /* (inline) */
> >      0)             rcu_read_unlock() { /* (inline) */
> >      0)               __rcu_read_unlock();
> >      0)             } /* rcu_read_unlock (inline) */
> >      0)           } /* class_rcu_destructor (inline) */
> >      0)         }
> >      0)       }
> >      0)       __calc_smp_shares();
> >      0)     reweight_entity();
> >      0)   } /* update_cfs_group (inline) */
> >      0) }
> 
> Lots of tests, Sashiko is happy and a useful feature!  I'm not sure
> "--filter-retaddr" is the best name for an option to disable comments
> on return addresses, but naming things is hard.
> 
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks!
> Ian

Indeed the name is not the best :)

Thank you Ian!
-- 
Aaron Tomlin
