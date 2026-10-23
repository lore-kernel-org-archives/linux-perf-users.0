Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.104
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792764416;
	b=z6nFyTDILOKjB3TCJJoT4JxBeo1awpqcOg7Hb3p+lizqmWYm4oD0534UITFrScMS2tvT
	 +1kAe4wL2ZbEZ1Zp2M7g9Zf8Ve27wR1WqOlWES0S7Bl5DPGwU5ATJLOuMdY70yC6+mV3j
	 i/6obaqN6WHm2wuQ9hASzF31KucTl8kPVZIUTD8zZVb8MhfjU8fVRa7GT73dhM8YIkwB3
	 kVG2X5oLksZBnEtRyJfhKKvsWucIHK35afHFCnizOvNk+8W+VOaWUFu3syVkRLiApIbFN
	 Br/pejLAQrTwyfzZ7hrcV3gDSEvG17FFch+MNQ4N01OiFu/6htlA5gfxTW4Wv7RY30Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764416;
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
	bh=2ftEu+AZePuRlSGRtweNLUtw29MoiVX0kTvh/Uz0SRs=;
	b=c722lsn1NR7OK4i9Hyr06jPsYHiv6pxHv2Rs4kIpJh6quqiSsuMOgvMqjhMxrAVcZALM
	 78S8vGRobWSvLSRb8KQbVi9RchvXSDpQ7tw7ZbA10iLl34RX6JpsGWT5NAfDM6appavmy
	 FpfzIR7cTNFriEhl/eJiCWmOBTnVyGWmxecfK6wyv6Lds2nmNMZXcfuuXTF1iXAbI1yNL
	 fIISj28fHM9W7/WQpy7GyNhqvmmp3dq7amh1bvJx/WD/w5Ec177uFGDEL8cAy3WZ3MW8O
	 06dmjE0C5jiC+Je/4ELq2Y6JXValI5F42Rk0kxrvEUcehluhx4ujs7MCgc2Mw37a/XQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.104
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020104.outbound.protection.outlook.com [52.101.196.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144AF606A31A;
	Fri, 23 Oct 2026 14:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 144AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q06cQfVxdZdh3waaLAnTL7PIq6v22qaSrZ/zH9C9WvjH82sppB68Ri2CJOgYxcWBNT3mB57GJPCQHjbY9e7KEgArc6dMBnL/14bhJhNCIG8NVGQAj4eZfT4joD6rEXfupBMd8nkRwZaXj+x3OAxkxlAYMJnWzPjg5sLfh5uMGwWDUBibIGFXu1CIKUTHMUNS+N+TU09Tw1FL6dDljDJqkgpZOrk3hmxh4La4dsHwWVl35ZIEFZVDtasiIlahOwlKDEBuVF0PfdGKl4xCVaVMlvW9S5e49ClVLgjgnMlYEChXdGaX3VtrjAw+M0YHMjfAEjMb61i8d0MW15h9nfhb5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=2ftEu+AZePuRlSGRtweNLUtw29MoiVX0kTvh/Uz0SRs=;
 b=fE/9w0ua5/ztewcHBwntlXOloa7c+17j13og2kWiIJCVT5fZ5ZvgBgi/NIGlfZCJMcTM/NvM4JULorja1d0rBipocq1Rph9fBzcpOTzR3hHhjqPPV0uYKZmEz729JGzTuI5CgKZZC47vKVfzs+NlFdiUJ8VnP3K0y32l12K8KFlkFHRs7xxHsGnKLnOV9k/drh0yiOVXT3naORRpZ3/Nwdb625i3e3I0Hq5T4f9SVIbjkE3sRuHwSe1zRoZEOYnzOP8RWonQshU1yT6QVERRopJ42gEs3SjGro7yeXhix5DdAXj4q2+rnolHj6+ZNG0cUe5yLKdNe1Xwdzc7/6GTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB5698.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 14:06:51 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:06:51 +0000
Date: Fri, 23 Oct 2026 10:06:47 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v9 2/6] perf ftrace: Support filtering
 return address comments
Message-ID: <drjspwwsa7cuagjngom6qfx45wl24vxu5lch2rnzz3gcairilo@3nhwovp2hu7k>
References: <20261021023337.809936-1-atomlin@atomlin.com>
 <20261021023337.809936-3-atomlin@atomlin.com>
 <atppRvpvPrm12_Z6@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atppRvpvPrm12_Z6@google.com>
X-ClientProxiedBy: BL1PR13CA0312.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd51a62-a454-4ed8-510a-08df310ee2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|56012099006|261022113327099003|4143699003|10067099003|261009223027099003|261021121427099003|18002099003|22082099003|3023799007|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	JrzU4INyC4pjGbk3ntz/JqNIwVPZzpM5bJDULcPY4yp//DKkp4BBDsjaRkgWlOG779rdrtd1eynf1W2hy9GPEsx623RofBYq1+fwm201Go4QdFlqFaLMAxH2bzQEgs0pMKy3dXD1ec7PaAydvXwC4iLKDSoQO6EPZZCqc3RX7kYPXvHqlSgqEAxWilESrMtOd2aTWw/l+gZcag/ZcjtmZ7/ie4c4e9763F3tj75x6BA9Nfd3ytea3hik4ziPJJpvG1yw6HeTRR5I5WqPtAx6TO0ijQZ8+ZmZk2YyEcWqc3b/8ymL6i6XmFB+PeD/Ja0Y7mEUiB0+r1JkBkY/dydpX9ALzttiHQFMJnQpxrVlWzRaS/dP9Uf0siLpivEOzW0QsGszfaACKjv6gBPCxh2INnYYb3xcqChNHXAoMEC9E7KDof3LvAxmjj5G7lhncrxVtIHUwvKYaRxyw5Zt1FYolvUK8Q02HLJqoG2NQ4TbIQycBm/0u54yQkpmU0b6iKAof4UPKgJDK0wSAPMwTF++lKYnH4di7hhoTnswAgdiNstkOeqyFQvgRgMUTrQiR1PNURZoM9KwyjqXPZCQ8wDlG4BmeXtDx+q2iC00p2yv8QxWSAVYfy1mfecGRoQ4uEmG6SCCjfZd1h+Tr98ts2h9r483mVsahPOx2UtiLJzeNZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(56012099006)(261022113327099003)(4143699003)(10067099003)(261009223027099003)(261021121427099003)(18002099003)(22082099003)(3023799007)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzdjdVVaWXBKTWsyKzEwSU91VjNIVXUvb3RkV3BnVnpTNDE0Ry9PWkdPNDJR?=
 =?utf-8?B?ZTFqaVZxS2dIVjNxRFBFK2hoeWtvRzZpdjRCWVVvblhRWlRGOS9OcjhBTUhY?=
 =?utf-8?B?SXNwSlpiVGhmMFRLY1JFSC95bkFxZzh3RWJudXpFdmliRXdiV1Y1b3pXK0JX?=
 =?utf-8?B?UlAyWGZRS2VJOWlzWjhhNEpTa2czUUFaMlVZZi85S2ZQWHE3bWxhRG5RS1BG?=
 =?utf-8?B?WW55L1dRajRldkF5YXZJMlcxQ2hnZDMwc0Jyd1RUZXQ0dmtvS0Z3cStqc1hQ?=
 =?utf-8?B?RW9aOEZWOXFnZVB0MXhLNVFjbDRFd21JU0o5bGR6eFdqMytVMXlVOVhjbllM?=
 =?utf-8?B?R3RlTHVQTE8wVHBDbWtyTEVJUG5CSEVQNXlqa044Q0hhSEhVNmw1WTNQYWQ4?=
 =?utf-8?B?WGR5SE1KWHQ2Q3dSRkFiYk5HdloxRlRkd214RE92N3pDVWdBRjNraVdvRVZi?=
 =?utf-8?B?UTFQbU1lMDdydXFOMGJhL1JUYjA0Q3lqQ0pDU0R2MHRXSG1mUGFjVC9KUVo5?=
 =?utf-8?B?dS94NGVsaCt1RTdSODBCeXNOd3htRW8vaFU2dnB1UFhQc3d3eWlMWkRXL1k4?=
 =?utf-8?B?OEhHL0FCUkxaTXo2SXJieTd1b3lOelFZd3hVR3YrVkRnWjVmK2pSNkhpemVj?=
 =?utf-8?B?MGd6THBRdnJkOWFkbjdjT29ibmJxbjNQczZjWXkwV2RscDdvbFJvNEtBa3Fo?=
 =?utf-8?B?RW5idkJ5Q3V0L0ZUSy9mcGJlRHB5MmVYZFU3S2FYZy9iUm44UFdkMDVTSkhR?=
 =?utf-8?B?NjZmbWhDOUQwQTFIWGRLcm9jVTNpK3Z3V0ZTK2ZPcy8wdVZFa3BMZ2xzaTNo?=
 =?utf-8?B?eTBLSUY3WmNwQTE3WkNtdythZ01ManJheTBNTzdHWVhMTWVxdUIxVjdIeGw5?=
 =?utf-8?B?RkxrNzAyRHo1YUN1eVErQVJnT2N1SVovYmdZL1RIQ0cxSDArb01Ldk5xeC9o?=
 =?utf-8?B?OWZ2WTZzWTBPRE9DNE9semZCblRWY0xMMGJNTEhTOWhJL0tacllTZ1RoY2pt?=
 =?utf-8?B?V3JyZEM2VDFGRS9EUlBVcnpXc0UxUUYxdU0ycGhGckVEckwySThCa1YzSS9G?=
 =?utf-8?B?aVdJTVRLRE9YcHRUalRtRWVwZW9aTFM3UVYzdkt0RDYwY0JIYmdRSC84QUNY?=
 =?utf-8?B?OGNkeVlmOGdrVUVCOEZsSU5heDJGektEWWNXb21lWlR2bloreUxJNkVkRUw1?=
 =?utf-8?B?VFp3NTFqZjlGZlhWdlUzRGI2anBFamF3eUZXVjZYeVRNOE95N0NJK1pFcGFt?=
 =?utf-8?B?eW9IV0FDaE1zdHYyY0FndDczVTBUTVkwZkNKbWQ5WUVEM3VpWGduL2xIaWNq?=
 =?utf-8?B?WDlqTDJ6RUhWbzJYd2FNdER3VEgxYSt1WWo0OWJpeFF1d1dYeXlUSDNzdzZJ?=
 =?utf-8?B?V0J3cDZEVGNCYWpSOWJobDRPZzhPenVlRms3SWdvS1pES3o1d2JqZzFlZi9Y?=
 =?utf-8?B?RTVvWVZXQ3h1ZEhvK3BORjB5amYvQWhIYi9PTFhVNXNNZFR3QjhnTVlIUysr?=
 =?utf-8?B?UUNGdE0wK2tEVWVzQXlMazNHZGtiZlZpVkFtbjN3M0hXRFpTOHNRNHV2cHJQ?=
 =?utf-8?B?azdiMENVY3ZIeWJTWFJ3YmhxalVkL1hnc2NMNkVuVVZQdXRBcFVsSVdIdGFJ?=
 =?utf-8?B?TzUvc29QTUJnMklsUS9pTmNwR2VldkgxMW5lbERQVmtwOG1zKzh5YWd6L0Fs?=
 =?utf-8?B?TzhLSEhHdnJPVlRyZ1VsbmJVcUgvRmFZSGZCeGVwc1JOemZXOElwVC9PRkVo?=
 =?utf-8?B?MmZ0bWt3b2lsSFJ4NWwrbm1weDVOeDdzMTJQbWwrUmlxWGFHdjUyZ1A4WFp4?=
 =?utf-8?B?RTJFU0FpTnh1MmdPYUh2SGtKemd3eVdGVFFldERwTm1FRXAva2oxMnZmZldG?=
 =?utf-8?B?bDgwck1vQkhRdlVGb2prcTJ6V29pRzBTYlMzVTM3RVpvenZHT01NV2VyOXdE?=
 =?utf-8?B?bWlXZWUvdGdsSWEzaXdDQ0hhY2plQXc1MXRKRm14Q0EvV3ZEK2RuZml2Wjhy?=
 =?utf-8?B?Wk1rYWpFSFY0Z2E2eFloT3VVMFRlUVJBK3pkOWpzNUEwWGIxQTJ2T3ZZNGhx?=
 =?utf-8?B?UUhvanpOZ21BeU1RQXpmNnJJaGNiRUNMWHBnUFZtdVJxRFVZZTI0YUlVYzZX?=
 =?utf-8?B?R255bDhDdm1wb20rRFdnUTNvQi84Rm5nS09uMXN3Z21HZlFGQldvLzVyUGpR?=
 =?utf-8?B?eU1saHM2cE9Td0liakpHV1V2VFdYem1hSE5EUEVhdk1oTUxlQ2lGRnc3aW1o?=
 =?utf-8?B?QVVNalp3ZmlqdHFPcyt1bGN0QUFROG5Rajdha00yemZna05VZ09ydFNyU2Qv?=
 =?utf-8?B?ZXpPYjQ4OXg3N3BoNTdLeVY2NTc5NzBMbkFPaW93aUhpdTg1TFhxUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd51a62-a454-4ed8-510a-08df310ee2cb
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:06:51.5561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xow7E/+SEhEBCbj+xCCnhz4mwcQUHcJRIp624DA5qxr7isnQTcPpPi1aLGptaXS5MtZy//+D2r/7WF4EfjK72w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB5698

On Thu, Oct 22, 2026 at 12:51:34PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Oct 20, 2026 at 10:33:33PM -0400, Aaron Tomlin wrote:
> > When tracing with the Linux kernel's function graph tracer, enabling
> > funcgraph-retaddr records the return address of each function entry as
> > a comment in the trace stream (e.g. /* <-load_elf_phdrs+0x6c/0xb0 */).
> > While valuable for tracing execution origins, these trailing comments
> > can add considerable visual clutter to the call graph, particularly
> > when examining deeply nested call trees or when synthesising higher-level
> > abstractions.
> > 
> > Introduce support for filtering out return address comments from
> > function graph trace output. Provide a standalone --filter-retaddr
> > flag.
> 
> I think we agreed not to have this option in the previous discussion,
> no?  The retaddr will appear only if user passed an option, so you can
> unconditionally filter out the comment if it's not given, right?
> 
> Thanks,
> Namhyung

Hi Namhyung,

Yes, we did. Since --graph-opts retaddr already defines whether the user
wants to see return address comments, there is no need for a standalone
--filter-retaddr option.
  
Whenever perf ftrace enables funcgraph-retaddr internally (for --inline or
-G/--graph-funcs), we can simply strip the /* <-caller */ comments
unconditionally if !ftrace->graph_retaddr. If the user explicitly passed
--graph-opts retaddr, we leave them in place.
  
I will drop the --filter-retaddr option and its documentation, and wire the
filtering directly to !ftrace->graph_retaddr.

Kind regards,
-- 
Aaron Tomlin
