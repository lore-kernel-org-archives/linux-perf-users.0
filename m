Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021080.outbound.protection.outlook.com [52.101.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F0938C2A7;
	Wed,  5 Aug 2026 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955992; cv=fail; b=jX85biFeNbBZM1dN9y/dhh80tiCgzqHb0e7TL9T1Wln+WYzc3NtUC8OkUIVC9Z3cf03RL7iIq/nR4b4A3A9oweu3jmR7Ghfh8n//wmbdJ/yOA7sy5+J1kjTL2lHmSd9cxVJBdVAiw8tFKtA/1jAVpg/3+3GzUi9wgSRO5L9ebjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955992; c=relaxed/simple;
	bh=XK3AsLP6Q+S0dHFZb4+Quee8RMuCArkuqX0gz6Y+9O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g8CSmGFhgfNvIQU3NyyUr5IhokqEa4vUkA4s5iycNmq/maCGlO9e1hqYu1BkSzwmpqOJSPEf1LhmeMrfRogo/X5bT3YQ8zxUd9bRZZd8QSs6DrvNQiVGdhs+vtVESsEPG2XUHMgVCzV1SIOXpBP8toz1FNcUycK8bX8txMOQDoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYrVCaQo5iN9IrAsQqGM7xWX/q933sEvFk8eqCQS5Z/Y3u5nQA0seZMUVt0UnX5bQ8NUSYjWc3oVrVIAmHChP7V24XfzQpA05Ljcnz0R1xaC+gABa4fg+vTbPPVXRmeKEn+lOHHHFQDNotsssExTfEbEhlxOiUcIlu+a9JuxIazDDFD+y4z7lcA1MTfhrbTuTxngMJJL25CPQWPvjHJAI/s5tHyF1LFK39h1D7mXXFe28SAqcs60wmahIFUZ8fF2j08S3l281F3wn2UlNJXqy48T351XYtTyP6XEZ8YVtmY3B51oKL1jBo0xhJLWNE9myv36o4y0/2qMrevFmIwFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=jWJ3Bfj/+0194R6EkN/yBl9B0IrDWqiiw/IspQZr6h8=;
 b=MDm99NpxYdZKrpvvpA7+FJJ+PTnYRNFBIS3BM1rrwaOsbMWhjhDvCRIZty7xrWhLKHaNfSZSSFEe/iTLUak4EnEMvjpet8sPor+UFS8X02UD6IoSWDIAc8uuvIIvyzbmnFBIH92wUlWIFFgSfVYJ3R4GMdJFxaIOQXNX2Zru3b6EvbGPVLaZVHOnstGwaOA8mB7G51N+uXtr4P/IOhHZvnkl5LjxLLYEnyKu0rLi1Oz+aRE3G8jI3HlrsdPSXERMGD1PzFsGM3an+aHhL0EpJLkjU9c1S+e88sjgWj8hbrcJJlOxwBFN/m89r82SAHUXcgmkMyVR30hav7RySn6iwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6136.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 18:53:06 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 18:53:05 +0000
Date: Wed, 5 Aug 2026 14:53:01 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, steve@abita.co, 
	rishil1999@outlook.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf trace: Format fields with hex specifiers in
 print_fmt as hexadecimal
Message-ID: <3iulqtbwakupwjjo3iksszlv5orvhssedya3mouw7ufxfdchlz@x3xqjtgmcwdo>
References: <20260803124845.213165-1-atomlin@atomlin.com>
 <178595449650.914389.87119431734742911.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <178595449650.914389.87119431734742911.b4-ty@kernel.org>
X-ClientProxiedBy: BLAPR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:208:32e::27) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b4c8e1-fcd3-4709-a164-08def322c8a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|22082099003|18002099003|4143699003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	R7RvAdeC5+F70+H9kLHl2wqxPFVO9J6sVM/tCsaJilv6YUNXycQkcPW8hMDzk8WUeXiEzpfH8lVfxFMIfl9pWwiGUdazKe0L+K+Rd5jN922GK83sgNbM2lyk1jWnJSoT90tP/Jweqj5c2joIlf3xkWx2LS/MoK7u6nAuS+ujSH7zTO9Cb9zvTWVyLrO6W+tyVsB5PW2hJuLbjoEpFYcBJbFnHqjY2X6i32/aRxBM8ygbDu5cAGrWCW6Zx0y+5zuZFMyjjXtvviPuZBuEZbc0Uhzkz7HJc0CaWTTvAChhHxvhTZKyG3QiadYrm4PfBPybBae7riPvs/znF9GLADn16njyW1zlQ44PBKZIy/w69pxmNiqmzrkokvM+D0o1efeqpkt4YMUF0/uu2Hs6BgNmNWRLkCb2Tt8Z968EM+qLChjHOKec2V0kAa7wEMTMhyyBg4YZW1JFAmyG/p6rXh3Hk7475Z3rgG5RHDBB5jNXHK5fvuhZtn/rvE44eAbC0yNGnlwNmAD3pfsNJBSaUCX81HLBqUTY9/DLR6h7jlgsUZkD4Btm/g0j1lPfgT40dj6PpgDrcENKfxbnXC7kGEHsjwAGXY2JbE4e4D9kT/JC3UBmGqpIBdlPKjoTuLozSpJS8p0atjfxBEHhSs9E6ddJXFTK4aS4EkKjbN9/WXsekYo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXpuZmVOYnhUd2JZODA5M3h5ZGZ4Q0xwUFJIR3dPWVZTekFhZnFqK1pZK1FH?=
 =?utf-8?B?aE5rSnR5NTlVVWVWbkMvbDB5alJtQlM3Qy9xV0Exb2h0S2NUTVJvb0Z1SjJk?=
 =?utf-8?B?b2ZTODA1a0hzVnVVcThWaEtDUEMvMHorUWl0alpTcncwcmxnRS9JVGNNMzJ2?=
 =?utf-8?B?L0lEcnNBcFNQWEdUNmI1aCtwREdYNEl2UXFrRjhhWjg5dlhlcHV5YUdxMWFx?=
 =?utf-8?B?cHFHSlZUNnBzVER3N3RsNGUySm1idkpmVTFlZ0w1US9udTAzeDBaR0ZQWklO?=
 =?utf-8?B?SjNuSmVWTjBWVDgzMDNNdk12bktSOUtRYkJGMm1tcUE2UFhVL0o1b2JENlNV?=
 =?utf-8?B?bTJCaDV4VTVMYzdmWFMzakdIMWJyYitNMVJJNXlkWVRibWNiVGhxRTRyOEpM?=
 =?utf-8?B?dmdBU0RIOUdkOUxTR3NtTjF1VGFubExla2pKbVo2S21FL3lRVmhUcFFRT2dI?=
 =?utf-8?B?akVWc1JOUU45WXByTVRmRmN1ZGhvMFNhWlA1enhMSUtMWWg4RW15cFBiRVYw?=
 =?utf-8?B?OWtKU1RjWTgzZUF0WWQvRlpWUlB3VnpCeEdIMS9HTGdLNUNpejRhOFk2MXdI?=
 =?utf-8?B?dEkrbXh1QytIN1RXc1JocHV2c1FaRDI5M2sxbUozdXlDNGxqd3ZPREhBY0pU?=
 =?utf-8?B?TWpzWEgwaEErWDNLT1VEa3BGYk1Od2NNaUFxRHlndTJzQXc0alpuZ1FqYTVW?=
 =?utf-8?B?WHFTc0U5QmZ4a0FzK3l4MFRZVnljR1RKa1hMbC9vRGdIYkQveVBSOEgydmt4?=
 =?utf-8?B?NGxkTGh3WWVaN2VJcTJyNkZldDI0dmZjc0pKb1J5ZCtRV043d0ZlK0xvZkQ3?=
 =?utf-8?B?SGRYZzhYMkJUNGpBMDlySTNmYzBsMXR3clFkaGgzWU5ZdHg3dC9WcDB4K29p?=
 =?utf-8?B?a0ZWbGZZbWdDcTdYTFF3eUw1UnpMTkQ1MjZ5ZVo3aldsQVhWZFBQR3BvNnEx?=
 =?utf-8?B?ZDNyWWRRL3JlQ09kZ28ybTl6MkZTbXBLWkVEZGRQYzNXUmNGcStKY25wUG9J?=
 =?utf-8?B?Q3NCNE5LaVcwTUwrVllNME5kajl1Vk1pS0hpbytLMy9sOWhVcXBabmdSM0tx?=
 =?utf-8?B?NFF6VytFWjVicUNveW5XeGI3RFUraUtIWEdTN21KcjZtREl5bm82RDZaY29h?=
 =?utf-8?B?N2lUL3pBdXpFdXJkV1MvVDVZUFZkTVd1anlYNFFDQmpkTHZCUVQzOFJtcDYy?=
 =?utf-8?B?bUg2NzFXTDJGMGlWSUNWcGNGZXEveEx6MjdEOWN4UEJmR0V6NFJ1aVFRY0t2?=
 =?utf-8?B?S0hXeDJ3YkZpbFI2cklJWmNVTWtGOWJya3J0MkRjSTA2ZWM5UDR1ZnBQWkJO?=
 =?utf-8?B?YTlUNmhQeG1BaUJLTmZwWThlQmNOQU00ZXdJeDJvdUN4U0RuN3JpbElONHdY?=
 =?utf-8?B?UXR4SStENDdCeDl0K2xnRW9CV2N6emNwSGxUWFZicm1uUDdIdlBleGoxZng5?=
 =?utf-8?B?bDV5QWcxc1NXMVJ3Um5oUmw0RkVUOGJueUR0ekxpUjJaSXBKTG0zZUJHTHY4?=
 =?utf-8?B?ajB6Q1luTlMrSktKYmRheEZ4M213UmUyeStiR2FoeDB2RUMrWklvaGdKbTBs?=
 =?utf-8?B?VGg4bFE2em5JRkxJTnFYWEtQUU9Kb0ZWSEVhbWhOTmcvalNzYXRJUUttazVQ?=
 =?utf-8?B?czdkR0RuMzBXMlFkN2ZXd2k1K2tKRjE0UDYxaTB6MTBhZkFsTlF6NVBiSUM4?=
 =?utf-8?B?Z0NRSHQ5OHBhTXpscmNLUkRDenRrbGo0c3k2L1JqcE4yQ0VDbThXZ2VFYktv?=
 =?utf-8?B?aERrblA0V3N4Rk0zbmtIMGhmMk5hU3NjbUhWd09ManRGemUzQU02MHROZ3Qx?=
 =?utf-8?B?MVdrSm9ESUxWY2JQci9yaVdGc1FXeWMzRndJLzh2UkFxR1RhZGxlSWNCZ2xK?=
 =?utf-8?B?SWhFdFQrV2NmYnNIYTBISURvei9xWlcrd3NwdzlPUlphTHpSU29sVEZyRzdZ?=
 =?utf-8?B?Q3IrOWs4QTVqdmcvMDUwSlVSMm4xaisxKzBFWlVTOXdUNzZmVTVzU0hOQk8r?=
 =?utf-8?B?cDhGY3dycmNpak1XL0phYi9jc3VXSTZraS93QTdnTHNzMWRhaVFXcUV1Vkc3?=
 =?utf-8?B?RW5rcFdpdmxYVG80YjNiTW5NWHoyUVFnVWZUQmg3L29DdWFTb1JscE1pUjFU?=
 =?utf-8?B?QVNHVUdhTWhsNjY4dWQrdDR2TVpmUlhSRGtiWGc0WEpGdWFIU3QxQkRmdjZu?=
 =?utf-8?B?STNQaDlydjNqbVhlcGJ1Y3hpWGMydmNTSW1kMWFnWnUxRmlUV2xuTzJHMDRq?=
 =?utf-8?B?cmdMakNPcnlKak9pZXJTY09mNW4xb3ZIZFBvZ1orenNDSWYrUmFjL1R4V2o1?=
 =?utf-8?B?NjlrVXQrNnVaaG52aWYwS254MnVCbEFsUHhhNHl1M1gxLzFlVWpMUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b4c8e1-fcd3-4709-a164-08def322c8a5
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 18:53:05.6639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyYiQWU5+roIeSg/58AAsyzImkpdqMSvImXMlCS6e4e/Tniixv+3Dj5DgmITFyuyl+g9Ps/XJDRE+JEdDHvZ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6136

On Wed, Aug 05, 2026 at 11:28:16AM -0700, Namhyung Kim wrote:
> On Mon, 03 Aug 2026 08:48:45 -0400, Aaron Tomlin wrote:
> > Currently, when a probe event is added using perf probe --add with a
> > hexadecimal type cast (e.g., var:x64 and var:x32), the kernel traceprobe
> > subsystem sets the field type to "u64" in the event's format file, yet
> > generates a print format specifier of "var=0x%Lx" or "0x%x".
> > 
> > By default, perf trace uses its internal beautifiers which only inspect
> > field->type and field->flags. Because traceprobe events declare
> > primitive integer field types ("u64") without a C pointer asterisk
> > (i.e., "*"), perf trace defaults to printing the field's value as a
> > decimal unsigned long ("%ld"), ignoring the hexadecimal intent.
> > 
> > [...]
> Applied to perf-tools-next, thanks!
> 
> Best regards,
> Namhyung

Thank you Namhyung!

-- 
Aaron Tomlin
