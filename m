Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.109
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793810920;
	b=VKpSfEAjjm3bh8Y4SPScCcwReaVi80gtix7oWRtMAzfV9xylM0e7cRhu9++NSM6J38GH
	 zYHYpd780G+IdjAUATldhSeptjzQ3uma1mK46CEG2yq2N1gbmWh+8GkfWTxM/az8ZJWmd
	 bSIsu2dvlJAgnFscE9fMxyUhM0xYRFPXNst0r+3MpFOo/dhpJw9pHC2GiFNxVJxGeBqNm
	 Z5XxNicvFNy21p543KwRQYXndi8rvUMw1j6xoKQFQ+0A3iWVGGc+DtGLK5BmfJ9TXH/pX
	 bxMCVv8kBsWx6K5W4sQqaeu318Cik/pPxAQoodg9uGTafhMH4F6mLk00qZOe7qrQlbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810920;
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
	bh=9rtOZXrLA0l9dtDj7lJSbPkkVvjeFZPWJkf/TqeFPpM=;
	b=Gxdm9Z0I8WllXp0ps1dRVHMMxCbXucBijIXG93VreI4qq/CjvoLtzoeIphBVuzniTC7z
	 40E7T6O+/rKfJwXeg5/sUyfvQ4U9VX8Rc4elOXbXMD56nod/VD7Fvqk5vt0fBHUq0idpC
	 jHsDf9cNyMeQ6L641/IoBcGbeQ1jHlsPnOmX1IOieCpzoA8G27v4+dr2c9UjnUmfBu4Ga
	 4JQ0fH+rKXuEK0FQ90VgEuPL3IbEwR+BHE+53GjKRbEA0ZdDL0154hCHV80JA6YN0nhG0
	 gejUHtD+BlUN2ZIyJtmNDLYKon+kzqNiB4eL7AIpznDVtkxXJWSyo1EPK2aYxTcI8uQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.109
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022109.outbound.protection.outlook.com [52.101.101.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA46606A330;
	Wed,  4 Nov 2026 16:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAA46606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljjfSZaMIK73VcyaJsanUTxTxiAbzZ5SyAFOQNKR7YJD5GsVvmftX+bn9B2+F/vLzqJBFoN8YDCt9KgtLWF0/XOiV7AwTftkmlSILY/QEDvwq3dxxm5p35fUSBjJboLFzl3GDSmy295q1dUvgwYE+7JjBgV/QpCV0J9lGXnpR6YNeCyRIkfjscVKr1zGwGF+Lwu9scdvTi0m2Y1w5JaL3kGCnaep0gcW9wxjdhVGfPNtxZkJ7H2Nk2VK1Z+FeasHIVMexnBntcdcZWu1+fpo4nKVrNup3Vpssb/xRoaHvMFj0EkBpNRFJgMcpcl/b5I5LtWvJPv/FeDTW1H/CNrLgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=9rtOZXrLA0l9dtDj7lJSbPkkVvjeFZPWJkf/TqeFPpM=;
 b=m3gzKQSfRzgtaJmwh+/4zTwgABTYJlZ//njjlf9J9GZELmelrWsq73QkB3H0mnVWXYRtDHNNwYH73cr1QIVfM8EtmppHhv/e47rYmKK+3Lki+sxG8Hcwo7SOveYLtSgTL9FHgfzeveQq0TadpdePlK8C4pG3FJKdbL6bN6i6YWAgn0hBLSUjW+MAAtmXoNARiVc83GHhzQPuBhDhw2wKCRclmp1X+5tK7XU7n40bAvoOwiARnRxAPt/DgylPjU8vmln9bQlD0h7GUWjiHxkdZC95DgxMSRx1u/DWaKRXtAwHO2mBXb1JU6hezTvxBLdVGzNlNV9PZjdBYLFdNo0J/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by CWXP123MB3256.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 16:48:36 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:48:36 +0000
Date: Wed, 4 Nov 2026 11:48:17 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, chjohnst@mail.com, neelx@suse.com, 
	sean@ashe.io, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v12 06/10] perf ftrace: Support display
 of inlined functions in function graph tracer
Message-ID: <26bonobg6427x2laqddoawnk43ho5ogscxch6hbyjcmbi6joj6@wtv7y6qogxyq>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-7-atomlin@atomlin.com>
 <auZ6tj_5-m1MNGDM@z2>
 <zri4x5jfbpykc7jxdicixkrjdw4f7tui72t7is3mos6cnzbhj5@2wct4vkl7sno>
 <auri6Q6oisHLi9Y6@z2>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auri6Q6oisHLi9Y6@z2>
X-ClientProxiedBy: MN0PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:208:530::19) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|CWXP123MB3256:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d8a4b8a-b7ad-4258-6798-08df3a93782f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|261021121427099003|261009223027099003|261026121527099003|4143699003|18002099003|22082099003|261102123227099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	NasRHlu0N0HfRHZh1lXG97id/lILaVcuPW9Qdj3w6/S7j8by8kQ6VvNWAGEIwc0sfGzcKJ9A7AXlg7hhpd9m2UzTRCp+SngiZv3pxivPRfIQar8hok8YmDk+3oshkZsgJ5bMYAQ2dienmO7RR4EEV0+pkmSpeIIY9+Z9N+HoabUuoxLFm0HxjUC1Rp1WME1sibBHONjCKGsCPsb3SKBMnw+mfr5lwGMVXU4Ga2STrn15GvO3OzMC8YWG7gt8BghqNuXJmH2GHE8KDOOAyE0SWFzKUULRH/8Lnw3ldNMICNXgpVZCFHUWBFeanfkLiIffC45HdHadds0R5AP5UtItifOl4vdBUjEViQu6qWb4KJwoUOfpjGCgLdVtnZ6nLBB9b3CVws0U7YAGgtjd8jCckvEzRIeNx0QKWFgLdfqxLcsSHvkUV68/zfRv1U3YOmvntNTW2umZPsf+IV/PnfRpdcdEqmh1hYLHvZOmHErz+CJtqzQgl2c/+VgMMEkOm8F9a/OLwoc9YGa9aaDikscpS/mhS3RJNkEaeXEzfSR+gviLiB8aDCHaLsHzPYc16N+LOt2MN1qDVpRPjcvlSgQGq9Z6PUJd0xdH9VyNeclZCZwKeAcrQecTAZ3CK8Jawv2+/jSQWV2DLjapkiB0bR8t3H2APxamTkVuVOa39POkXUY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(261021121427099003)(261009223027099003)(261026121527099003)(4143699003)(18002099003)(22082099003)(261102123227099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWt2MDFaV1NveFhWN1h0TFFQM0RIN2hwR2orUFIvazlRU24yemRSZFJxZkVP?=
 =?utf-8?B?QXJXM25sUmVoWjVCaTlDVFJvT1N1a3FzSDk0TUV4NHhtVTRwZU84QTNVSHpY?=
 =?utf-8?B?WmU0WnY1ekpIYzF4SkNTS2swRnVoU2dxeThucW9yNm5aK1JWdWphS3dkalVZ?=
 =?utf-8?B?eFNDOWhVSWtmd1B2a1VLVEY4SG1JZmhRODBxZWRqYnlrT3dQT1Vwb3dEakht?=
 =?utf-8?B?NE5QZW1STG5iSVBVK08wSzhFZzhYaUxVeHAvVmRCRjJLVVRCZXU0ZXA5OXYr?=
 =?utf-8?B?bGpLNks2bWtsQzExMVRJeWdpNDV5NWhEb3lQaklTTHg2OEkxYzNvWVNyU3kw?=
 =?utf-8?B?ekwwSWliSENPV242TXYvRUVmeDBkMUNNMzlLMjJSektnVk9WZ2w4bjN4dzk4?=
 =?utf-8?B?cm0rbGtaeHhvQzRNUmJTUWFkT1pYSVFKd2tpWHJUSTVkWkZRUkIrdkRJLzVC?=
 =?utf-8?B?QkZIcUpMMFpZeXVpcU1KME9ETm90R3hVang5RWtTc242dXJnK0VZcnYzUE8z?=
 =?utf-8?B?a1dlVFNKRyswazlVQm9SejkrdWhJclhwTkwrTWphZnIxcnVqN2lCaS9MekRO?=
 =?utf-8?B?TG9hcFByNWo3U1hPUXlzeHlqT2lvT2hNak1Wd2FIUWhmL1RUdEVyTDdyeExR?=
 =?utf-8?B?b2RPc0N4ZW9tS1l3R1JaRURJN2dsWjR5Y2hPSmpIZUgwQ29jV3ZjalFVR0xC?=
 =?utf-8?B?ODF5cGZKL3hvbmxNdW9aOWFNYlhMWko5elM5cmNMMTY4WmlSQ1IxTTNWaGhH?=
 =?utf-8?B?NUdlU1RoK1NCMU1wcDA2MlFhN1VBL3RrbDlXN0JwUmNVamZ0OCtRdC9Idjlp?=
 =?utf-8?B?S1ZKYjh4aTM4Q0cxaG5PWHh3SFhoSlhUVHZ6T0FZUmVkc3JqTkdBT2N0TFVO?=
 =?utf-8?B?VGYwMUtvZmFpaGFyZGpYZ0ltMHZFbktYcU1IRHhZSlJwcDNvczZySm05L0dO?=
 =?utf-8?B?Z0g1YW10UndyZVBPUlVZdXVIVHB4OEZHSVBZOXBIRkdhTkdhZDMyMjU0OTdo?=
 =?utf-8?B?dlpNU1BucnlveGVoSlVOYTVpb1BTMzI4UVRQbHk3NS9uakd5dW84dFUxeVBo?=
 =?utf-8?B?c2JEZGI4TE5PK3loK01EemlNeDIvV2dKeVN4OHUxR1RyeStkNmtqckhIV3Bi?=
 =?utf-8?B?STNXaFRvZGtsM203cG1JZi9heXdSWmdzYVBuNWw4bDhMUlJycC93UlZ5NndY?=
 =?utf-8?B?bXNxSll6NGVCdkFNeFNBU2NJN0ZxOE80d1hOODFKMXlMdXplSUpWVytkNXlN?=
 =?utf-8?B?VlpFUml3NmZSQ2hldVV5Vk1SVzdraVdwOHdoZ0FCamE1RytCdm5VY2Rtdm1U?=
 =?utf-8?B?SlptRlh3TTF5YVQ4eVF6SEIyQVhCckpwVC9MbUNzSW9vai9vUXRnYUY1THQw?=
 =?utf-8?B?MVQ2MXQ2eFN2SEY4WkVQV0JHaDdvZkovcGFLTUt5bkJORUFNaE0wZHVoVjVR?=
 =?utf-8?B?cnVlQTZTTDh6ekZ3Mm10ZE41K2Z2R1MvdStFem9KVTNSeUQ0ZXZ5K0REOTFt?=
 =?utf-8?B?UlFvQmtZa2ZEcjVJQllzSzFiOVpXREFkSGpUQnNnUmVlN2NKMSs2RWNLZGh3?=
 =?utf-8?B?dUsyUjZJeStxbnQ2OGxlbHlqUi8yb3BqTlZjVDJlQUxtL2NNK0JIRldzWmdp?=
 =?utf-8?B?TTBSNUpVRkRDUTc1QjluWmZRaHkxUmdqeWVGM1kveXpNemJlZnQwZy96cEhP?=
 =?utf-8?B?ektOc1pqRFlYSnA3SEFTZUNvZmJCUkNmdWNvR3NoZ1dpR0JRSFVsdUxNUno2?=
 =?utf-8?B?S1E0RTJQS0dYdStqdEhocEEwcnBMdnhRNE9rYTJqNFBnOVNVbkRtKytkM0NL?=
 =?utf-8?B?T2h0WnhVZTV2MEhVVFVKZlBZb3RQY25pQkdxeDA3eUVEY2k2ZVJkSjNFN1Jv?=
 =?utf-8?B?ZFVBUXNPMjYwV0VSV09NcENycG85L0UzUGxmTkR3YlhNS0pqYVkvWE9aSGhL?=
 =?utf-8?B?WW03Q1g3Zkdza3U1VEZUSm9FUTZZa3FsLzJxUkdKaExmNHdpUzBZbS9QYjZk?=
 =?utf-8?B?L2J6WkxpQlBhK0JXWVFiZnB5cURQSGlWZFQyKzR1K255MCtqZkhNa2pXU2NK?=
 =?utf-8?B?Z1ozemRVVmY1dndFbHR5NVdhZXZ2d01CY3hpeUZVdWQ4am5FeFVsU0xmOFNW?=
 =?utf-8?B?N2d4dGhVZGRNdVI0RFY5QytTUi9TQ1h0Z2syeTgzUmkrVnQ0dnZlU2ZmYStj?=
 =?utf-8?B?THdpa21kc0VxUGptVnNQenBDRzBaajgrejVXVFMzYVBMZjJ5b3hjdFgxWHNz?=
 =?utf-8?B?MXJmT1ZUMjZlNUN3Vjg3amdoSWVmUm0ra0wzRm1VREFCS2Q3bkcwN2I1NTZS?=
 =?utf-8?B?S0dyWVB0TXoxRVlLVUFUUE1NZWMwK21QTXZyYUo3Y3lZL2d5UTJ6QT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8a4b8a-b7ad-4258-6798-08df3a93782f
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:48:36.4730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjOkWyCNAo/Ko3Gcu10jAV1GSRaXxO1E8k2vNjz8jCAtwsUEeKhNm2UC68lg0Jv4CKlAVvUEjbFYDP2Hueq59A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3256

On Tue, Nov 03, 2026 at 11:46:49PM -0800, Namhyung Kim wrote:
> > > > +#define FTRACE_MAX_INLINES 32
> > > 
> > > Isn't 32 too big?  I guess 8 would be enough..
> > 
> > No, 8 is not enough in practice. I will prefer to keep 32.
> > For instance, after a -O2 kernel build:
> > 
> > ❯ addr2line -f -i -e vmlinux 0xffffffff816916e9
> >       __do_trace_rss_stat
> >       include/trace/events/kmem.h:427 (discriminator 20)
> >       trace_rss_stat
> >       include/trace/events/kmem.h:427 (discriminator 20)
> >       mm_trace_rss_stat
> >       mm/memory.c:169 (discriminator 20)
> >       add_mm_counter
> >       include/linux/mm.h:3469 (discriminator 20)
> >       add_mm_rss_vec
> >       mm/memory.c:492 (discriminator 20)
> >       zap_pte_range
> >       mm/memory.c:2087 (discriminator 20)
> >       zap_pmd_range
> >       mm/memory.c:2151 (discriminator 20)
> >       zap_pud_range
> >       mm/memory.c:2179 (discriminator 20)
> >       zap_p4d_range
> >       mm/memory.c:2200 (discriminator 20)
> >       __zap_vma_range
> >       mm/memory.c:2240 (discriminator 20)
> > 
> > Another example:
> > 
> > ❯ addr2line -f -i -e vmlinux 0xffffffff821c34af
> >       constant_test_bit
> >       arch/x86/include/asm/bitops.h:202
> >       arch_test_bit
> >       arch/x86/include/asm/bitops.h:232
> >       _test_bit
> >       include/asm-generic/bitops/instrumented-non-atomic.h:142
> >       test_ti_thread_flag
> >       include/linux/thread_info.h:133
> >       test_tsk_thread_flag
> >       include/linux/sched.h:2102
> >       task_sigpending
> >       include/linux/sched/signal.h:384
> >       fatal_signal_pending
> >       include/linux/sched/signal.h:406
> >       ptrace_report_syscall
> >       include/linux/ptrace.h:427
> >       ptrace_report_syscall_exit
> >       include/linux/ptrace.h:477
> >       arch_ptrace_report_syscall_exit
> >       include/linux/entry-common.h:233
> >       syscall_exit_work
> >       include/linux/entry-common.h:266
> >       syscall_exit_to_user_mode_work
> >       include/linux/entry-common.h:297
> >       syscall_exit_to_user_mode
> >       include/linux/entry-common.h:334
> >       do_syscall_64
> >       arch/x86/entry/syscall_64.c:89
> 
> Oh, indeed.  Thanks for providing this!
> 
> Namhyung

No problem!

Kind regards,
-- 
Aaron Tomlin
