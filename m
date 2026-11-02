Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793614104;
	b=1vzr+fQ5ED5fTHFfr/gZ2MNyMpvUfx6f6p/ZXvhMJBrAkH5S9XBHgjSflowptE97T02W
	 vcYxFiNKM3jl/tBoXZ6rwuv2BF2pIYIE+rvvezf8l7aL3m86ADhqcxC9FzfB8UcYFQly9
	 ck+69PAvJSBJIOieXAolPX9UHYpc+1d305pS1CWpQ87PsbbqvgOfrSdR6jzpKA22hw/5l
	 ACJduQSc2u2rOEmXo8bGVR7P4egRW4NYdjAMpMquEHfvC3KBndMemI7PnMePU1ZtH5e0u
	 vxiTbThKIWNv6a2oozGPMc0YYyjUVgKNLpwMh9Sndaic/2FKGjeVk0qaE86BaEyNNJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614104;
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
	bh=UHy4xw/YrRn7e1F1lebr/G5xZ48d+LU6Svs5fao00Fs=;
	b=cANlTBYzvhp2/aUzim30aXA2s0hG7Z1DOrLY1Lze225le9WJnX64KiyYJP9BMaP8gX+f
	 wh2lGWSUQcy5gBDen9M5XHNjufS5/O+KmVRLniVVu9ta+y4+7bw+ZkXPINEo6w+KYeoie
	 o4gpjgtcXXK/lg3HD6LGcXb8q2DWA4p2xWcycil0PxKQr7Ww3PAVom31XmT3S/YJ9UMwh
	 Y/AKNzklG1hJCVqqTNRdx8MOqtoezJXlSfqf5k1iZALLmF5Q+lo06SQB7KQ/NR+PMd0k1
	 Aqvq9BgD+MLPxAfUV6B/RLcwyRmG52d6WJu9GZHxFjJlwdYwnKTufABQ/UtaAJpTChA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5XzzrzKr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.12
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E98606A32D;
	Mon,  2 Nov 2026 10:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94E98606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5XzzrzKr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOSlmYUj0v0ExRXHJlvoN96nPEpbIztL2WJZCuWazFzId8fupPDOkfmVpWxS9HRQuJckE3FpoxrZVEyixDlvf5ndXt3Ys2EiNLyvZw1bC3PYVlFfHim0kQryNuIStjWBK1MSpesFtYNLOh0hJhJRsC9aAh404FcAl5sxel/nuhEoKSglZBhn4tsqndWT4SgBHBGGKTZCMBMy/v73expUJ108WBTYxbJASH1iaDr6hmuRgSqaW3zkw5PXVFs3qIfae1t21uhqVT7rhfSGd4NSzNVuEgviteqcg4hzZ1YtdaQpiN4MNSUVsAuUKXeAru943UatNHU5p/Hi/xQctq452g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHy4xw/YrRn7e1F1lebr/G5xZ48d+LU6Svs5fao00Fs=;
 b=c34j13N8dNY+dLhPcIo67HR+CAPDcMdXFVBkzSSJk0FcWtDXWMmaXAYUrA09sLdciTEvlugsLd4Uo3LGKfaqfNckUkmj/Uu9uftYke5AZZR4HRdAR4+xqwYdz30riuyj4p2hsu/CwYQnCNhlCdJ4LKDOylHVDI+cRfYzExSFwfiZiucS3i24jXE5TPLvPNyPAlDFEMKnelj7H7MmAgxhsfx7kKOEdASoqCTw3xrTqw8zkmgfBfk1Zv30F0XOJEG2XY8K0RG4JnodI38l5KnPf3T9RooTx21FisU1xF+Gh4Tf+xPvFJWPFyrbIzadXwmhlLK+pyB6nQ5FeUtNTP7xaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHy4xw/YrRn7e1F1lebr/G5xZ48d+LU6Svs5fao00Fs=;
 b=5XzzrzKrGNDniK3FtEEF1Y+R0YCo9wsLDWDnDlof4TtuDDssSehjYHjDLOXqyL8bARVbTe5ZC1XlUYhrFDh97jtwYn6Ex9DwB0AYhsM5MotvChmhC0Ei3OnVeibbm00O7WR7yMoWcoblH8oHxaBEa5S2dTlBrZKcFAAG2BbkjME=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18)
 by CH4PR12MB093331.namprd12.prod.outlook.com (2603:10b6:610:507::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:08:18 +0000
Received: from MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::cab0:6260:dd96:3fd8]) by MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::cab0:6260:dd96:3fd8%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:08:18 +0000
Message-ID: <317a989b-c79a-41a3-8c0a-7e952bdae6d0@amd.com>
Date: Mon, 2 Nov 2026 15:38:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd/lbr: Freeze LBR on PMI only when kernel
 branches are recorded
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Andrii Nakryiko <andrii@kernel.org>
References: <20261023124157.75524-1-puranjay@kernel.org>
 <CAEf4Bzb2jEjqpZrmtTk_+YCW3_jU8fcVzk26CBZnxkpYJ8kCbQ@mail.gmail.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAEf4Bzb2jEjqpZrmtTk_+YCW3_jU8fcVzk26CBZnxkpYJ8kCbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b4::17) To DM4PR12MB5721.namprd12.prod.outlook.com
 (2603:10b6:8:5c::10)
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
X-MS-TrafficTypeDiagnostic: MN0PR12MB5713:EE_|CH4PR12MB093331:EE_
X-MS-Office365-Filtering-Correlation-Id: 7233b9a7-325b-4359-faf5-08df38c936e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|4143699003|11063799006|56012099006|261021121427099003|261009223027099003|261028144727099003|261026121527099003|261021123027099003|261022105027099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rWtsvogyM8Ds8CYzdrWQ7U2VRK2YpPdczFPDHb12JOfWpjINZeqTtxrO67wj7LyuwYuRSXGGKrCMEojJMVneQhaVzh+cpI34ggavpkNJBFySmv1bvnUGDEyB4BjEuJOaRFYj6Z2Imok/064Qsikwe3Qn7AkfipfSAW/bJ7wpjO6XNVxnBZ+UlsYBHDRukSf25628vrUr7Vmyxl2+ZwTLvKXFIzC1tjcsOsoHuy3BdgvX36CKPWrDeTW6Ukju7It6sOa33cPy2aHWSw3LWi8GgSKKhvkah/nh2diKUxgeosdVrYPmxNDgDqHu+MDRnkRZ58oSNLCDNAwtO6NVmilP/3NzpNrDTiGXuAXiYwSD9thElwmcaXJj6loDqIACW/64EybdXP0VERfTKO/NW7aemEEt7MoKSRqnoJWYg4AhGRimFlHIXmOn7AowqNVx2i28WMFHK8elUI+7RYtkkPdAzpMfxqqOu5uI0OlkfEHJM8bfEdONDPO8Rk1zgloi5KyhBfPIIjyr2A77mFxamGAVw5aGGtZFx2gTgDb2Mm+h5tZ06bHepUDjrGP1t/+rTiSiMv0vRVKSIcLLyRObbvEuYomS73MZN2AiMEtk0bS5UHKNrfkxCIi0HFRPkxFfxqArJULeWmWeT8yHGblsAWzRKW3+iIqkV6vFn835bt50lrs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5713.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(4143699003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261028144727099003)(261026121527099003)(261021123027099003)(261022105027099003)(261026140227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEVqd2MzVVRnbUdBdXViRkY4Y0pYWlV1cUpENnZHTnpQbjVqR1BRMTNtdllZ?=
 =?utf-8?B?MWJKRVQ2Vk5Kc0hWQW9zQVZvakJkaFdCek5uNmx1RmR0MGhzQVhaTjFybURD?=
 =?utf-8?B?ajRjb2hzRW9EenpjMndvbUFxcmRMaWNmRUdRUmFQbmhNdExGVzlzQ21KUG5p?=
 =?utf-8?B?T1c3eVBkNUVRY3lscVJuRlRYTndGNFExU09xc29iTEw5T1VMekJjU1JaaThX?=
 =?utf-8?B?WVBlUzJaWFVDc01jYVk2ZnREbUxZUUo1SDF6Yzd6UW9EdStlK1NUeFoxcVl2?=
 =?utf-8?B?TUFNZDMvdlVVdHdmMmtucHdINmh6SzlGMEtCZXdocWN2d0NFOStBWnVQM2h5?=
 =?utf-8?B?bHZ1VHJqMk9sNVRhaHlVcEtGTHBCenRsZGxnVVQ1TUcxNjFjOTlDMmdpSFJS?=
 =?utf-8?B?NGtDNG42VE0yMEo4T3NSMEdBMVlLeThTNGt5MVJjeGRHNmFzNlJHejlaVlda?=
 =?utf-8?B?VXBwN09sVjJJSXpoV0U4akV3eFlWeGpIcjNyNkprNUdDaDVLL1ZZb0djblQ4?=
 =?utf-8?B?VHk1TGUySmE0TUNMWVNyL1d1Z0twaWg2djM4bkVtUXZKNnFOcHNyOVppS25m?=
 =?utf-8?B?ay8zL21vSUY2VU83YzVtQkVSSkZiVzk4NWJjMEczalVvWHFlUVV4YUpmUTNE?=
 =?utf-8?B?NEtEaGYzSWNkU3FvMHIrbk9qMWRPbmh6MkRYRUZPR1hBWnZiNWpSci9xQmdi?=
 =?utf-8?B?U25uUXEyYi9lWlQxYlBrZ3YyUGpNbExOTG1od0ppNFZydmR3L1BJbUFMOE5a?=
 =?utf-8?B?T0JhQ0VFb3owTDdQZ0V5RWpCUWQzR0d6VVh6UTlaWHQ1Ujd2RzR2Qmx1c0tC?=
 =?utf-8?B?WTBRS3pGRXpUbk43bHhNU1VBbk0wYmhVdWl1NXkvSklUaW0ycW5OSHJwVFJN?=
 =?utf-8?B?akxHaXVLbk5DaXJtSytXR0pmSlhFSGhndXVvYm9uS3VhdHdSNWNZb0dmVEth?=
 =?utf-8?B?Tm0ydDc1OHlDYTlaNFF6NHlkUEs5dWRkaFJSK2Z6RXFtdDF0VXI5TmVHWE8v?=
 =?utf-8?B?UW1ZWUcxYVYyM2FYOUFDSmRTVUNScHpKUkw3SlJwL2ZBaE4vTUljYUJENDRX?=
 =?utf-8?B?VGJ2NG5vV01LMTdKQm1rclI0YkczMHlFTU1QZWFGVkRQMW9BKytYdDB2VjVR?=
 =?utf-8?B?YWdSVFlhMTVsNVJTRTdES0RXUDZPTXFPV3ExL0FkNVFXVDNsZ3kyaEU3QkxK?=
 =?utf-8?B?eFB4SXBteGFLeUdXdW1YbEdEOEp2S0ZlQWNvZTN4SGZnSCs3RksrMFZ3SHVa?=
 =?utf-8?B?TU5QbGlWWWJCUXdPeGJoZ09vM25wNURIeTVzZzUwQjNWRmZiekFjd0V5VGxW?=
 =?utf-8?B?VTlIZTFNMlJQU0VocHlTNlVERjM3Mm4zekk5ZzlkLzV0elptbG1FMzB0SlEz?=
 =?utf-8?B?WVRHQndheVJaS3cvNVZ6TGxCQlR6NnYrVWRRRVBTT2NTQ0E0NytPWVUyYjFj?=
 =?utf-8?B?MlpGZXBvd1phMUEvbTQvQUZ4OElUNjdFVG5Ja0UzdGJ0d3dsYzBLT0Zab0hK?=
 =?utf-8?B?cE15VVI3aUFNeGxnWVJiZC9Ibzk4NVVveHN6MzNwc3o0YS8vRS9hZC9iTnMx?=
 =?utf-8?B?TVNvZVMyR2pYOEdielVsVTV3akFKdXlBclZ2M2JBOVBxdkRsWkhHdW5oaTkr?=
 =?utf-8?B?ZTdESjVLMnZBWHA3czBkZVZaQnZ6NDZlWXBZUUxRMDd0aytiUTYySEV0MHVp?=
 =?utf-8?B?N3BSV3hxT2Job2lJd1BFL2tFbHk1RFNHaCt2dkVQSFlrbk1aV0RId1JCSnhm?=
 =?utf-8?B?TitFRVdGVVBjNk9PVWVyME15a0dwUktqVmNEdWV0RXpxNmtzdU9CQ0NsZjVF?=
 =?utf-8?B?OFhPZ1FPSUJIcnJXc1ROYUMxQXNyTVI4ZUNmclRmWVFPUk5QdVg0cldXNG00?=
 =?utf-8?B?aVl0UjI5N252aitGZVFHSzlxQjBhOFdxV1NqcG9Ba3JVTEFXVDY1a0ZLNEp2?=
 =?utf-8?B?WUpWZkk3NGxEaHlMV1lmczl6a0pHU2VqS2ovQ0s3bUwwWWdRZ2pZcmRDZE5W?=
 =?utf-8?B?OWwvVUhEMDNUcjZWbEp3blVpQjdzUjNWYUNOaUszMFFCMFZOYWxNckNOZjJj?=
 =?utf-8?B?c1VoRVdJZi9VTGFGczFzeVRHYmk5bytPSFBjNUtXWHlBZFpWdWNUL1p0bm1P?=
 =?utf-8?B?cWRIRjlQU1U4SGMreXBmZEtYK25oTUREQ05aWGZHdjlCVjdsNXN0Y3BPNlBy?=
 =?utf-8?B?cHFvODVINlltZTFIWkNibGRiMDJ4akkwcGw3MEZaY2hqV3ZaT1Zqb0J0RmhV?=
 =?utf-8?B?NDNoWDF0NW5ENExkYXlUYmtkMXZPWlF2SUdFRU9mK0Rkem43cEFNbmNYRXBW?=
 =?utf-8?Q?esvYwKd8whUMz8Z3/q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7233b9a7-325b-4359-faf5-08df38c936e7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 10:08:18.2140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOPuvsIT4he/7q3hgU1jEYky7oGvozlrJ9mbMuvvF71voiyuaRZm9bSHKrLhMiNEpw+YgjOvwvK6gTK5Ls75TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB093331

On 30-10-2026 01:42, Andrii Nakryiko wrote:
> On Fri, Oct 23, 2026 at 5:42 AM Puranjay Mohan <puranjay@kernel.org> wrote:
>>
>> On CPUs with X86_FEATURE_AMD_LBR_PMC_FREEZE the LBR is always frozen on
>> PMI, so the branch stack ends before the IP and callchain, which are
>> taken when the NMI is delivered. IBS rejects branch-stack events, so
>> there is no precise alternative.
>>
>> The freeze only keeps the PMI handler's branches out of the stack, which
>> matters only when branches into the kernel are recorded; without it the
>> stack fills with the handler's own branches. A user-only filter does not
>> record them, and parts without the feature are never frozen (see commit
>> 598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability")).
>>
>> Freeze unless the value written to LBR_SELECT, which is shared by all
>> events on the CPU, suppresses branches into the kernel.
>>
>> With perf record -e ex_ret_brn_tkn:u -j any,u on a Zen 5 part running
>> CPython, the function of the sampled IP differs from the function of
>> LBR[0].to in 84.3% of samples with the freeze and in 0.1% without it.
>>
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> ---
>>  arch/x86/events/amd/lbr.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
>> index a55646fcb8465..7ec50380ac81d 100644
>> --- a/arch/x86/events/amd/lbr.c
>> +++ b/arch/x86/events/amd/lbr.c
>> @@ -392,7 +392,7 @@ void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
>>  void amd_pmu_lbr_enable_all(void)
>>  {
>>         struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> -       u64 lbr_select, dbg_ctl, dbg_extn_cfg;
>> +       u64 lbr_select = 0, dbg_ctl, dbg_extn_cfg;
>>
>>         if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
>>                 return;
>> @@ -405,7 +405,12 @@ void amd_pmu_lbr_enable_all(void)
>>
>>         if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
>>                 rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
>> -               wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
>> +               /* Freeze unless the filter suppresses branches into the kernel */
>> +               if (lbr_select & LBR_KERNEL)
> 
> On Intel CPU side, we reset this FREEZE bit in
> __intel_pmu_lbr_enable() if is_lbr_call_stack_bit_set(), with the
> comment "LBR callstack does not work well with FREEZE_LBRS_ON_PMI.".
> So this is not *exactly* what Intel side of things is doing, and I'm
> not sure I fully understand the differences, so hopefully someone more
> knowledgeable can help.
> 
> But what Puranjay is trying to do here is to at least make a
> user-mode-only LBR and IP + callstack to be coherent (for PGO data
> collection, which we then use for user space app compilation), by
> disabling freezing for LBR.
> 
> It doesn't seem like there is anything we can do on AMD hardware for
> when we want kernel-side LBR and precise IP to be in sync,
> unfortunately, but at least for user-space only case it would allow us
> to not plain disable freezing altogether at kernel boot time.
> 
> Does this approach make sense?
> 

Yes, the intent to keep the LBR and IP coherent is clear. However, my
concern is that this may end up dropping the branches preceding the
hotspots since a CPU might keep executing in userspace until the PMI
handler runs. I'm not sure about the effect that this is going to have
on PGO but what if we rely on a mechanism (UAPI + tool flags) to let
users explicitly request freeze?

If there is an use-case where freeze helps, then the facility can be
explicitly requested.

> 
>> +                       dbg_ctl &= ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
>> +               else
>> +                       dbg_ctl |= DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
>> +               wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
>>         }
>>
>>         rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
>>
>> base-commit: 0f443787a7f6ae907975742680aac2600483eaf1
>> --
>> 2.53.0-Meta
>>

