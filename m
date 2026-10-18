Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020096.outbound.protection.outlook.com [52.101.195.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAE5282F3A;
	Sun, 18 Oct 2026 02:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792290101; cv=fail; b=qjVBwCnYTAPlqoeorWHA3z1eCsul3vfG4gkvQauG8J81RZH+khnWArBSIQks7BsNvkwETgrQzEO/EKqnEpcZb3z4VtCkYskwdQP4+0lf2hPtTAbbSorv2UMt7ZxJ/VvD/ps3kNb9YOFsygqpGAQblOJZcPZaZwNQTayseExBX9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792290101; c=relaxed/simple;
	bh=bbxur9mM/bdcAjYIHAOSkNKXm44FPYO4w7vcvTer+Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mdlHuhhAA8C3qKTg64dHH40SDwAhKgB0TUxNDNP84oS8TYRczkmkk+5L4XEsAi0fq8GvOzugPqmPOmogc7HdPG0F8pgap2U2AdBhHCW9XSKVMzyDIwRQp91gNtPPXpyAQNS2odbv8k6wWPtSO5vNM7iiZ7UwvC0aJI7tl+31YF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IciIKQjXUs408qRFgoUixrWgb3aTmA8aBCe8drsH9njDvkeCwZNnls1yi9eYTyeN08P9X5mSf4tUDDatJn1AYORt23LLo3Owfz8JIXIqhyOQqMkHfJK3aS64C4BFz+Ca5krdsuqEf0yfypPsEtxyxenAr04QUcYbHZ86vGhEJfOBy73Fgu8LXaD2l9uXUh7+wG5+XNuYYw1XeyfqvELqH+IjERGKlDJ8iDRhodrbKBk+OuVjZqg0KSBDJ/80xoz1xYdkVUjizUpQY/u6k8xq/3qjvEkjzpbDISQq622hoEQ51anXjuGGbGUdqoFZRBcm2RFXXu1qDq3eHtYg9l9d2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=qPYtEuBKIa2pDynKCjHQinChJCy501m9fnigOeGoLC0=;
 b=Of6p1Vkj/39GUpS/EabQQN88HpIH1VJyNPdyr/9+LQ3OTQcUtMcX9gn9L5cwvsK7kwlbUGiiOS8peStX088fTHCku5SKkvzrqpwo3Pu1RUc4Ip3OV+Pns6aceQwQTsqdx/Pp0z3K40wU5s+aZ2oItBL9KYq1WwSfQbX/rZMuhfoYg/UTxhWhmWXafP51IBPUvlO7vShAfJh64cNbRwWI6xbmXJ2e55dgQ1YhnwgieWQa2iq7IH+rkHiaG20P+aoMk4g8R6D1P1ZwWlsuC1pb6lbFklOpg1014GKDKXQ+LEwqstNIRr75Gi6nlfTlJd+P0QQx0ES8RsvSnalc0NeP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB3467.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 02:21:37 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 02:21:37 +0000
Date: Sat, 17 Oct 2026 22:21:33 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v7 0/6] perf ftrace: Support inlined
 functions and display enhancements in function graph tracer
Message-ID: <gyuunio7caeujnzpugfsqw2abwnz2ma5hvvfggchw7mll52vfm@xsjyts3tvuwb>
References: <20261018021346.582845-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261018021346.582845-1-atomlin@atomlin.com>
X-ClientProxiedBy: BN1PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:408:e1::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB3467:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f9df61-2715-49df-821b-08df2cbe8979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|6133799003|22082099003|18002099003|10067099003|3023799007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/Q6Yqj7EAM3k+ipZYgA8C55E49zqLOHBD65iRm2QtwwKl/Ov0EXFCCzmJkSVDKecWmoG5d+VT1dj74tw4/kK/e3KP6B7IA6xTepJyHhukb19NMO8gdFQKjCKlbMDrKifAShh2NVZ6YrETOMZ5jma8iAgoyTMD3almmKZLn4nLUyXhp/t28qgmILIaHIbzEdJrNlILeYnNyPSXe3HIoXrnYNJgRBuAIBRcnf01Xw98yB9tqRLsyruEyVst/OgAeYJJfXr6la2Uq3EQkukrEv3c8KFfd3yVIeFsDQhTWMEhUoEMZUsCUkotv7mByGK1pyZQQz+C3oP607jhIpw+aoDIsZbpGsKncGf+YrzF/bYtErlnyf3gVB56tCQai3XIAU81YAfRCNZmTIkrjju/GYZb9QxpVM9/8po5OO3Uljknz3KooVQD4QImTElqX+ZPWUqYUH/mwJjY7Qm9H8CgSi5/t6XycxuYxfhHNIR3DsHwu/noHV+X/jbff2itpmCZ7nOZKplr2q2SqgIOivR9v2bAVEpXKMlvCFoaEjGm71IXJRCBKSzyLOaj6e/KlI68YfAI/aDsOoGtuXYB9ztEtQMtVUpnvZoZQnjwQW+mue3MvifqhltZi51sjDqdi4JL7a6RXFA5FN+GL0BdQzTlnY54hNpUyjJZ88U6F81VJ2+ZRc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVJ1ZWRiUk9obnJpcVo5YWRmeWNBWncwUkRRVkc3YnplZ1BJcHRZNnN0RWhi?=
 =?utf-8?B?cDY0aXBaemNNcTZaYXljNU1HY05JUFlsZm91aU1qNU8wbVRoWk5nMGlEV1FK?=
 =?utf-8?B?bmFIc0hZVUlQUjBYcG5iQVMvemdDSlZybC9XMks3NVJ4UmloMkVjUnV1TlNK?=
 =?utf-8?B?RTZPcVNERVUzUzNWOExVME5vQm5EYlVITUNJMnNUR2phRTRMZnBsQzBydnpz?=
 =?utf-8?B?QVBzY3FTTjlPT05nb1ZVd2lzY3hUVXNiT3I1ekpiZVdHK1cwanErTXFGY0N6?=
 =?utf-8?B?WTNOdTVKK2MrVVhxcGxJT2I5VGs5UktYMDlJRi9qQWFBU1lVUENpK3NJN2tF?=
 =?utf-8?B?VlpiZUlnQnNVY2tZMWo2VlVzQWNzTVhFVVJvNlBOQjZ2TmVyQktTV1NXMDk4?=
 =?utf-8?B?d09uU3FOZUhEMGszR2E0ZTg1Vml4R2xJUnZoMkpMSEIrL2xxSVBEZCs3RUJQ?=
 =?utf-8?B?K09ZaUNKZDhXaGpGak1aaTl3c0tXYnhMRHMxSVJ6eXZ6ZHNxY3ZKMVJyVmJp?=
 =?utf-8?B?MVY4Wm1mNDhkbjJqenl4RC9OVnE2bllyWmIzRGxDOTRoUUk2STVCOE5LNTFF?=
 =?utf-8?B?eUJiemJMbEZ5WWZuYmhmVmI4L0FSaXBoTjlFQS95eEZrVk8yakJpazBqYXBv?=
 =?utf-8?B?VFBoZWJ2V1FmYmdPL1FRSVNTTXV5Q0NYTVZFQnJyS3NxS3hCaTV6aExBbGt1?=
 =?utf-8?B?OFFhdVhTVUppZUlsZUdrSm5hS0U5SnFKaXNhbVJudURCWnhadTZLRmZ2d0dh?=
 =?utf-8?B?N3FGZDdQdExpZi9jK1I2eko1aWFXSVp1c2R2OTNZbnZUejhacHBxampKaUR1?=
 =?utf-8?B?WDlHcFpUck54TVRPakxVZmRZRXIxWGdvbVV4dzRRN2w1V3JueWxteGtkeW1Q?=
 =?utf-8?B?N3hpamZsWFc4aXptajJ6TmpsQXFNaXB1d0o0QlFycXl6QThBajhrL1pHN1RS?=
 =?utf-8?B?cnFFbkJRQXFDdjQvQy96R2xNMnI3NUF1dmdpS09SQkRta0F0WkhHbFZBcVhz?=
 =?utf-8?B?eVBjdTdrQkhnd3Y0eVpkOGZWU3A2K1Robjc5ajBhN2ZyRDQ1VEJsSVh6NVBm?=
 =?utf-8?B?cS9xM1FyNUpUZStXdG9qdlFSUk9aUm5NSXhnS04ybEVvaldUdXkrUFdiZWoy?=
 =?utf-8?B?QzgwMVVaZjNvWFh3aWZsSW1HQjhLZFU1TTBPb2JCRTVwS2VLUTZmOURVUEFo?=
 =?utf-8?B?UUR4clloVEdyays1MFdFWjZNMlJNb2hTbm82L2hITktBcEFyTU0wSEE4WW1Z?=
 =?utf-8?B?eFFxN1dMVE9sVmV3THRhZlBwNHdoNEpUME5sVCt6aS9HNUd4UytGOFR0dG03?=
 =?utf-8?B?NlNpVDVRY3p1T0xCL1dvbmZZRTVPR2V4aTRlMEhHZVIwNEViT29tbUlLWVRp?=
 =?utf-8?B?YXRCQ2EramRBTG1ycTlGR1YrTlhJSXArMldYdkRmb3NmM0pLR1FHTXFDMVRU?=
 =?utf-8?B?ZERSK0c3cThZYi9YUkJwaHRJWjcvc1RQY1cxcVhEeGp4bWJuN21VODJxQUQ1?=
 =?utf-8?B?ZmtRNm5tNGkwZFQxTUREbURvcC9GVFltUTh0SC9keGhQVHRHYklxUktjZUVS?=
 =?utf-8?B?RG43cmlNRUNBbERQYVRpbmdyVHF6V0Q0VmJGY0thV09VNU1Rdk5ndkx4cGNJ?=
 =?utf-8?B?WXMzOENlKzhrRjVMdUZuaUIzRGVoNWdmaHZFV1ExWlhFenNhRUdvdE9TVHBH?=
 =?utf-8?B?cG5oM0tRM1I5REZJMXVnOHBmTWRKakorZUsyWm5lOHpqZ201TUM3MzJXdjdu?=
 =?utf-8?B?OFlxcXpXc3g2N3JjdVgzeTVGM2o1OUJmd01OQWV0SFhpTDdmSkpiT2dDL1l4?=
 =?utf-8?B?akxsa29PQ0hPdEIzVC9uckZveFZDekQycmRESlZsSWlvc09oU2hVTWNheDFP?=
 =?utf-8?B?bUgwN2k0TGtXUFRHQXp6RUlmNnRBcmtCR1RFemFWL3pJdFEyVzdvdGZuNmdl?=
 =?utf-8?B?TWs0RkNRbDQwKzU4bDZ2VG9jblhIQmN6R0RPdlhkSmttbUIvTFdZeUtjOGV3?=
 =?utf-8?B?VmZnbWd1RUhHbkxIZlR6QjhXOW5Pamc2QlZUU0xGU1hDQUZwbVVFY244YTRt?=
 =?utf-8?B?WVRUcnNvZWxTWkRLbTk1Z0J4TDNRTXhLYWdLM2pCTll1WW5IY01DU0ZmU2lo?=
 =?utf-8?B?MnNIM2xqa0NUbG0yT0dLT0pNZVhhMHJtUHNKaWpoRW9hc2c2R2p1UThzTCtW?=
 =?utf-8?B?SmxnSkNnVStUL3dsc1FGY3RaSUl6Z2VSSGV1SkMrRVN4aDU2SGVDdkJGbkpO?=
 =?utf-8?B?Ui9EMEtGTWtXN0ZTR2JYQ05TK3UyVkdjZGkzaEZVN281dS9GSVlZYWxiUktJ?=
 =?utf-8?B?TXRJVHc5Zm5Hb245UTZ5WmM5WjZSWXloN2lsWnRrOHRXRmJmKzFyUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f9df61-2715-49df-821b-08df2cbe8979
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 02:21:37.3001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pl72hJGFgQ+0FUy2/Oc5YkphsOqxH4fw1Xo+5XBjkI8cZ45HuHJJ0dn5nJfw0q5joqYcxLxne0gtbysQxdleoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3467

On Sat, Oct 17, 2026 at 10:13:40PM -0400, Aaron Tomlin wrote:
> The Linux kernel's function graph tracer operates at the machine
> instruction level via compiler instrumentation
> (-fpatchable-function-entry), recording entry and return events for
> physical function calls. Consequently, functions inlined by the compiler
> are invisible in the resulting call graph, as no discrete call or return
> instructions are emitted for them. While technically expected, this
> omission frequently obscures the logical execution flow when analysing
> kernel subsystems heavily reliant upon inlining (such as the scheduler,
> memory management, locking primitives, and RCU).
> 
> When the kernel is configured with CONFIG_FUNCTION_GRAPH_RETADDR=y, the
> funcgraph-retaddr trace option records the caller's return address on each
> function entry, manifested in the trace stream as a comment
> (e.g. /* <-wake_up_new_task+0x1d1/0x3e0 */). By interrogating DWARF debug
> information from the kernel image (vmlinux) utilising libdw, perf ftrace
> resolves this return address to its inlined callchain and synthesises the
> intermediate inlined frames directly into the streamed call graph.
> 
> This patch series addresses these challenges through six focused commits:

This does not apply against perf-tools-next/perf-tools-next. Kindly ignore.

-- 
Aaron Tomlin
