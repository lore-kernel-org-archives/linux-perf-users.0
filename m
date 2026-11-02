Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793627372;
	b=4VlN4dLkHAbUfJSXBJqPP4yNd+xUONs1xrTUJE77bb5dEeqlsdm1yUiN9LVqda7Z0B2y
	 +uHAgVp7fLbSmjmrZIGLxgJSiF8lvD7M6YVYSm2kKeenB6yysrr0B9aBFC8z4ncR2PMJ7
	 Or8RWCk8CIvmpSHGxa+DhbxKt1oe4yf0ALmTVPVRlyfE7UWP4+m+yIGCKcxNQ25AhGiwv
	 0FG0lF1+1NB3t/kB0HL28L24S3cTJr0sEY0jwSjO+NCv2pnrn/1pLMphQEHB/OViFrSAQ
	 3uOdcEDOJD3YkuPF/GDWZW9j8+sOXUHfe3foeNqdQ+OOcBD0Ec7PnMPZ6Qb8DKp2SzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627372;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ujjWJzcs8bJw8lu5idi6LX/TScBk3RH7YD878AtEpmI=;
	b=W+pphrnbNFWdeSEO7hvFh96JSzeqHCsSHEnUqX62NeTRsk7uYS5KLLILCTODaWD5JS95
	 sbwPUYMXbDdgm2VSeMVLb0V1wfLKVttVgs0hnIdVxbALQOKJI23htQaQu5fWKnO99w0T6
	 26YmvT+xuDVE3+gFjiMoS9pdyRknIEz5836SVEeVSF6u6mQ1io6NQG+DLYbZjZDg3yAVH
	 2ydHDzHqqPWfmfj6ofrUODiTB8EnRCVmWGXM1PtPp+NPPo0ez0rnWC9VjeN+Xp1tl7FU5
	 zcYW/TOkaomhBiQzbO7Q0ydXrHtA7+l423A2VHlBlscROgVbKdm1cAClgKMOiWjkJhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="cx/zQmIb";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.54
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D83606A33A;
	Mon,  2 Nov 2026 13:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37D83606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cx/zQmIb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqDxrdkwxb9fw3+zvc6ER6MC7Yr7BPeBT2bafIiFftY0nzad9gRyPJCdEi0cf/j4+vOeZeo7eJi7nqF7XzDiNmWQX+r3CLjpFc0BTg64FZrqB+qqP77AspMz/wZf6RuLCo3PI2u5BWDY7A3fGxbsmD/ZB4qV0YQIqeo4id7JcpG01R2uIOto/mkTIVTN78B4j+sjN+P9ktmCjSpv1gSfoQeVMv/SwdwIjNdBulgA97rlZArij/hYOvrtOMb2UgaUU2QREQOUdBBzBnpyNOo9w/OY5wPIOLlFLi0LjXmeBhiU9lIDOg03rn6bmbTo7m37EvnwKXUwn/Wf34wN0FRCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujjWJzcs8bJw8lu5idi6LX/TScBk3RH7YD878AtEpmI=;
 b=G6kKiUWgY4RkdSTspD3AXb2K+YgabVfrDXWjICd6U6h9SVG3MkxiRAA1b3aVV1mn3t91eZadb+wYDb7foBTD4L0YYuIrGz2ReBpsRpbnA0fjTl3qlKjSJlWqd3E0GlWcNVRRs26gkJ004z8jJeZpQ2vT8W2SxU7aezUDC4f9MbK/8vytehDCHex8WD5TXOhbDgJfoMlynOSBaXKlPVFeuGevCYFHj0ZZXrlsIaeYSROK+NWl3D0iGvvrkKUbXP+aG5bJsjexA1yUdbEPo3Phr7asNpTzjG0MuxFG6Bpvod8ABvXsF5TkMSeVHCdTN/5rkynecM4SDE+YHAbtYxYCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujjWJzcs8bJw8lu5idi6LX/TScBk3RH7YD878AtEpmI=;
 b=cx/zQmIbYeB4mifoPDg4uWRvfD8cUHP0IoYlBY+RqMiQNgCIaaDT06VP8jK3laXHlDjezCs9G0ug9UvErA/slWG52TLqdKUN3KltkWd+FWDGeMYT9qfWctPPYRESd9Ar/hLDqzLfn21bHmHyfsgl+w6TQpyak+33+mKADvQ9JA8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18)
 by PH9PR12MB174847.namprd12.prod.outlook.com (2603:10b6:510:415::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:49:30 +0000
Received: from MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::cab0:6260:dd96:3fd8]) by MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::cab0:6260:dd96:3fd8%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 13:49:29 +0000
Message-ID: <f2a99c63-bd1b-4851-8d40-aead20614951@amd.com>
Date: Mon, 2 Nov 2026 19:19:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd/core: Make amd_core_pmu_init() return void
To: Ingyu Jang <ingyujang25@korea.ac.kr>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261101040356.3204097-1-ingyujang25@korea.ac.kr>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20261101040356.3204097-1-ingyujang25@korea.ac.kr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0108.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2bb::11) To MN0PR12MB5713.namprd12.prod.outlook.com
 (2603:10b6:208:370::18)
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
X-MS-TrafficTypeDiagnostic: MN0PR12MB5713:EE_|PH9PR12MB174847:EE_
X-MS-Office365-Filtering-Correlation-Id: b9fc5b55-2468-43a4-2a5f-08df38e81d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261021121427099003|261026140227099003|261022075727099003|261026121527099003|261022105027099003|261009223027099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	cEia2mozqHZ4lccrS5TqSJLK88i/OpsDaAANdHgVf0lwrthG4O8hrauwXUDXGpO4ZX8p/FaFX6ctziBAwQro7+8ZOEDTKxyVzfOW+TJ8bZlRZLZVEVpydQm3IAvDyGQvqXTGKgqvPda/SLx2LhX5c7OuhHj+I7OKCybSaqYC1bDM2umU7COfqMGIdG/rKc8+KBhmxyTx4usaLVfHfRUObMpsOsaN2UPZEotdoKWcAOgYtTxqgDx0NR/nF/k8gY65PHGIAl7pRdIoWpxQxBuvqVNPDLOfVYucU6bNhXSTRk0+GvTvqD9P2aGE+kMuor66OJQRDKLnlY9KjG+Val5OzVZLH68FFG4gfyNWHJk4exyZw6FionVqoxvUqwuAD1hywXw8ZuN60w8rA2pVB2acoW4m0haHsrILymAW0rgrhXbpOWFjo1siLGQghe7iSEFdCiLcT3VKhxpD/w1HxNJy6thQ8PMru5MSTtKzdfATVyJBt+Yh9zt4FpeTuPRxP0f5NQk1V1lmTeoeTEzKmVgzAyGRp5sWXR6O4gdVLZAztUI/fEPLBwlxqSuhj2Cbu17H4i3s5mij0BRmjXY27XkyFMu2aBB1XDcoF6ZdON1M2JyD8/iofTPvJc37Xa3GX2Cv4FtD4joU9a4l6IxGlHoaILLykPHtWm44bPdt1GWUjPM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5713.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261021121427099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022105027099003)(261009223027099003)(261021123027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFFodDRYWHRkM29OWi92UXR5OEJSd1V0RFNLcXhLMjMyNWQyQzd3bUxiUnlI?=
 =?utf-8?B?WXJUN1FTYTBMSW13aUhnMjJBQTVyZmxad1pZdU5aVVdBSDVhbkZzdThPeThK?=
 =?utf-8?B?N1lzK3FiVytsaWh2c21wWjFNbTZvUmptUnR1R3FRaHZUSVA4SGpjdnFycDM3?=
 =?utf-8?B?S2ZPaDBQeXNGYURld0U4Ym42YXFNMjd4S3hZUHZvZlBYTVJDNXhYRUNLUXgz?=
 =?utf-8?B?T0pIdkFnWmNYQmhYVFVWVFVBd0M5VS80aVlvUWZxRklvZWtYd2g5c3UxRWh6?=
 =?utf-8?B?RkJpK3VocmVES3BYSTBENis0TUtoNG8rL0d2TGs4d05hSldHdTVjTk9BZkMw?=
 =?utf-8?B?VmltMUFhVlhhMDJta2lBZ2pXNjZQejdBYk1wbmF3TEJkckQwbGtLNENiZkZI?=
 =?utf-8?B?TkJCUE1OMXBIajZkbjNaSFlmRUFCb0Rua05iNVd6WGFmdkIyY3hUTFVkZW4v?=
 =?utf-8?B?MnorVVZrV01zMTFPaXEvWFNkTkVJNU1vUXhhbVExWUVmcGYzeUpyODNRbU1W?=
 =?utf-8?B?QVp4b0VMOGNza0YxdmU4NkUvbDBsbW9Ea2gwaVJJcnQ0MkkwcVJ0Z0ZSZVNt?=
 =?utf-8?B?a0VuNUZBc1RHb2lSbjJyWnZOZ3FENThudEpsOEpCeDJDelhBamEvU05rdVJh?=
 =?utf-8?B?SjRxK1lXeHRoZkZIK080NG5XWFJYNEI0cEFGRHIyT2hqa29jdHYydzNCYmkw?=
 =?utf-8?B?d25aWnlVWVhKZDFhQVNadTlWb2dZTXlzWk1DQzAyRmdKWEpvMDlZdFFHYzB6?=
 =?utf-8?B?WENyM0M5MXFxbTYvb1Z3U1lPelFEQ0JWMHEyTGo2b1JvRnJvLzd5SmFnOW5M?=
 =?utf-8?B?UmdabkovQ25VUi8xeERPVWwxQk5KYWNpdUQwNmpqZ3piSGlJb25WWEx5K1Nk?=
 =?utf-8?B?ajZibE1pZWw2QjdDT2xDOEw0TThqU2ovQXEvYUFuMkpsOFpNWWtVcFhwSDFP?=
 =?utf-8?B?YlZJdURyRlE2SWphSUE2N3MrVUNYRldvWmtZZTVva29PaDY1NGVNQW9MKzFM?=
 =?utf-8?B?SmRYczJqY200c0ZUSitnYVpQNVRzeFJrL0wvTmFxZnFseXZ6MUVGOGxlbDBM?=
 =?utf-8?B?ZG5LQlF6R2xHUVVQekFiUnQzUUJ0b2VUSm40RnhTdlVKc1RwMStmdlJuVnhw?=
 =?utf-8?B?WlUvaHFjQmhZQ3VlbUFjSzlFSUwxditLa3BKQWl6ck85MWtLZUJ0c3Q4VUNq?=
 =?utf-8?B?ZGRTUHZFMzhmNVEvTy9iQXhBZGJvL1RMaVVLRmN1ZXQveWRyck5TQU9EdlJt?=
 =?utf-8?B?TnBRQjkrZzhjS3lhUy9kYURrbUhuTC9ESi9mWm5sRWVoeHUxYTVkdFA0d3FZ?=
 =?utf-8?B?c0lsR2w4ck1CNFNFcFRkZmFKU0lzYUFPbG1hMUJFU2lRamZkUnoxQjZ6L0xS?=
 =?utf-8?B?QWpzMWtHVUZML1ZzS05wR2ZqWldCYlhqT3NiblNCVzNsNmdiTzY3a1A5OFhO?=
 =?utf-8?B?Z0pVdThjRUtucE12dmxJeU1obnFCQ0dJRitvb1U1WkxYeFVSYVQzTlBuUFQ0?=
 =?utf-8?B?VUpFQ3gyTkhzbTJ4M1pOWVR1MmtBOWNLT1ByL3pUcEx1ZFFtYTByc3lxYnVm?=
 =?utf-8?B?cTRBQnI1dUtnKzJkSk5jVUFwVDU5NHlua0x1VG9VNkxwMUpXcXpXbTllcisv?=
 =?utf-8?B?NjRBREEveDlnYzcvZ0RvV3VXOVlUMmlENWpYd0ZpSnFtNGpiM3Q1Sm1qRWEx?=
 =?utf-8?B?S3BVOXNJR0RwdlVMSjlIK0ZmSlhqd1E2NkFPVWczeE1zTDk0dnpyeWQ3NlZ2?=
 =?utf-8?B?R2U3VGUrczZERU9hQU5vU3NFTE1xa3VBdEpRUGo4ZXdLcW83RnZ0NGZubDVJ?=
 =?utf-8?B?bE9kMXFGelhTNlRscGhHL0hKT2pDRWZKN1BZY29PYndLKys1SDFJU2NhVldi?=
 =?utf-8?B?WFY4UWl6aXNNYTlpOWZ5Y085ZTZTTGFJQmh0eGlKM040MGVITW5mNGdzRXVu?=
 =?utf-8?B?cEduRWw5dFZCM3FHemU3bG9PemNLc2U3T3pxNHllcm9nQmdaQWQ1V2xCQVc5?=
 =?utf-8?B?aDhRVFdHajhPNW5ZMWNBZ3FlZWdZWUc2UTZwTWlScDNnQUY2TWdLVkNlTFhi?=
 =?utf-8?B?MG1GUDZzZ1lFOW1HNS9qMk82aDNib1AvVDVrYUdEWGp0a2NRTHczMXJSemdJ?=
 =?utf-8?B?TXU4VU1scG8wSWZTTWJIdGtwU0JpdkZvNEJScTRCUHlwdVJOb1N3dTZtNldx?=
 =?utf-8?B?d1R0STMzVVFqb25GK2pjdU1MUVh6N0J0c0pMb1hkOWpsbVRXd1Bsd1VLdXFG?=
 =?utf-8?B?blZvNUFMVGdqbzMrS2R5ZVY1UnhZbS8xSjl2cnM3YVdEZUMzeS93UkZrNDZy?=
 =?utf-8?Q?OgmkwFFqR7KTpIrZH/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fc5b55-2468-43a4-2a5f-08df38e81d8f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:49:29.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSI57A+ebHFqtHIDiN2whgmhgSRz75KCzolBLlLmfiPmjTIBgw4ZMwE5VhXAswws43e+k/aVEqqf+Uot8TcsfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB174847

On 01-11-2026 09:33, Ingyu Jang wrote:
> amd_core_pmu_init() has always returned 0 since commit 471af006a747
> ("perf/x86/amd: Constrain Large Increment per Cycle events") removed
> its -ENODEV path for unknown CPU families, so the error check in
> amd_pmu_init() never triggers.
> 
> Change the function's return type to void and remove the dead check.
> 
> Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
> ---
>  arch/x86/events/amd/core.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 49b6b8fce5664..c72e745b2591d 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -1412,7 +1412,7 @@ static const struct attribute_group *amd_attr_update[] = {
>  	NULL,
>  };
>  
> -static int __init amd_core_pmu_init(void)
> +static void __init amd_core_pmu_init(void)
>  {
>  	union cpuid_0x80000022_ebx ebx;
>  	u64 even_ctr_mask = 0ULL;
> @@ -1422,7 +1422,7 @@ static int __init amd_core_pmu_init(void)
>  	perf_nmi_window = msecs_to_jiffies(100);
>  
>  	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
> -		return 0;
> +		return;
>  
>  	/*
>  	 * If core performance counter extensions exists, we must use
> @@ -1523,22 +1523,17 @@ static int __init amd_core_pmu_init(void)
>  	x86_pmu.attr_update = amd_attr_update;
>  
>  	pr_cont("core perfctr, ");
> -	return 0;
>  }
>  
>  __init int amd_pmu_init(void)
>  {
> -	int ret;
> -
>  	/* Performance-monitoring supported from K7 and later: */
>  	if (boot_cpu_data.x86 < 6)
>  		return -ENODEV;
>  
>  	x86_pmu = amd_pmu;
>  
> -	ret = amd_core_pmu_init();
> -	if (ret)
> -		return ret;
> +	amd_core_pmu_init();
>  
>  	if (num_possible_cpus() == 1) {
>  		/*

Reviewed-by: Sandipan Das <sandipan.das@amd.com>

