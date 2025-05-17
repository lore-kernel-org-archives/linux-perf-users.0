Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51C1AF0BB;
	Sat, 17 May 2025 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747483414; cv=fail; b=QOAcTAUeaiF4Xt3VeGMModzizCzrFpJqUZ+OIobP8UaE5VBnc5sEOvQ3WGq1U1bejsFPCg0w6Tx2pKkFveNCVp4CkALfmstM1vRRVWQdL5t4bA6DqwZDGkhGa+j+kvF9EPiQ4sEOQpIOZJYPbNSw3/bQnQs05Ld9/6cqEe3LMlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747483414; c=relaxed/simple;
	bh=OwdfZ3Mf3xEj3q2qZfctAcmJAdwY1dvw79Z0lh0fXHg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qJqgrhX2U7pjFHpqXOk4y+cDF1CIZ0hFFyOHkUAxkpfSQfYQ0ln4KnXhS8xm3AkGDHZB5wDkT2zzZ4XMW/N/yA/n0FjqRLqnYffNBmPAwZw+s3zBkbwBuBBwktWgdy3+PQcmGeCFAYCRvw3SNcengCQFQ039F4NBgoUQlZmspME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tJFe4E16; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tJFe4E16"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bH9Iln2hv3bY2QNcOdW1xfo02UJzTIdzHbVRXN756lYjgNLDIgjF+i7vRoF6zgwi8SFZ7jRpjGOYdYRriv5TCuJQKOtZbIoc4EWh42nYQ5jCUXhABpL8sSU3b74T0JysL3XE0GSZeS0gJJyF5ppV514+WjteWNxfWf/NeUu8v63COo1j3mv1qG3SyZmyfVUyIw2VbMSFypggb9S+OYU+5OytNNdbVGiTu9OmG2ZztNcpYLZWD8J/imTXBu/b9WW40U24XQavBkpvsQahK2rU7W0kW5sU7TMAY7FYlYPbr7MrdgXC+nNu/j+42JxpBIVUt5Rl6nk4MskNosACsDfflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRrUii6f+zFeB2/IqeZopQxDJOzFReeBVpslkWZGMms=;
 b=mkDDSxXqxkhHBYCQSR9n++xg3y8A8keq/aCAQNj9YjuKjPd6DzwblIBj2FDp4omYJDaOM+wN5XWHtp0X2NEhxdzrFAoL2XRPspNZkDAimW4UTBh3Jc8Zai1D/5LcGx1Nn9rqhKz5osmBVaDkfwpMQeS6D/cLesBXvaZWZQzLqPp/NRiyN9q1vW8EC/5jWV/NuM2NA86eZxBEljrT2+xnkX8ch4rPNO+iX0d+KBT4PeCp3JL0V6okJO4pzt9LH6G0z+k42XKVbqt8lXsFQA14t6xuOPzqGS/OJmvGGzaaJ9UXKh2uznfjQkI6cnZADvWaaCTeafzdik9DCsaneGAhNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRrUii6f+zFeB2/IqeZopQxDJOzFReeBVpslkWZGMms=;
 b=tJFe4E16XqEIKH3ogE4cdcFYPwQ3Z9301D7+K0RgI88NzuvdMADwGXyEDXPfusHaQLpbCnnhhAb04l6x+sn88fASdW3hNotTj1vhcJDQP6i6cF7zQ3ORhr/dD8C3UF04T12eLKRRDYG+45wOal18isU2I2qTccwflX23T4zpo9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DS5PPF4A654669B.namprd12.prod.outlook.com (2603:10b6:f:fc00::64b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Sat, 17 May
 2025 12:03:27 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%7]) with mapi id 15.20.8722.031; Sat, 17 May 2025
 12:03:27 +0000
Message-ID: <33e86415-c90d-420a-b7a8-6a360769aea4@amd.com>
Date: Sat, 17 May 2025 17:33:19 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: IBS perf test failures on 9950x3d
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <aCfuGXUnNIbnYo_r@x1>
Content-Language: en-US
In-Reply-To: <aCfuGXUnNIbnYo_r@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::34) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DS5PPF4A654669B:EE_
X-MS-Office365-Filtering-Correlation-Id: 2851c082-4039-4a42-2222-08dd953ad4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dW90ellHZ2tvZHliWFZNNTB4TlpuelMvSXRLRXFaN0tpRDh1TkFtWHFvZi9N?=
 =?utf-8?B?dGxDT2xraWg4MU5weHNsZitTamJDNkVYNnloT3RnYVFacGQzOXpBVXhJbVBy?=
 =?utf-8?B?cGw1YXJQRnE5NytwZDJUV3JLZDZLLys2aUpmY1FEWHoxbktMdVNDSjQrejNr?=
 =?utf-8?B?YzZEeHJUUjFuN0JETXZrcWNrZXFSQ0JRdlVwd3dkaFJtWThUa2JHMDNTR1F0?=
 =?utf-8?B?ZjVEdDVJQXh0OGxNcnVhdHA1aDdGRkl0TVFqbjRaVHhUVnUwN2VRYjYySndo?=
 =?utf-8?B?OHA2Zk9xcFN3T0l0MGo2dnFDaUY4Q3FxUlA4eXQvZFRBRWtNUE0yWDJJdWwx?=
 =?utf-8?B?bUQ5OGc4WUVMMHlkemxBUzFtQXBTWFZhbFRPNDBiMERBRXdJc01kMGhQbVpY?=
 =?utf-8?B?N0lzRmFIMUZPMHVTWHMyK2Y2ckkvS1R6WFFiMkZpWDJwOE9tZzUwMHB4V09s?=
 =?utf-8?B?a2JadTF4R3IxYUJaRnF0Z016QXhzQ1lnWUJ3SjNmZExqN0RydUFvWmpHV1Y2?=
 =?utf-8?B?ZEg4UDNPc0NQc3pzQXFwZWlsWXp6RmM3enlPVXY1TGU1aXl0UUF0WnloR1Zy?=
 =?utf-8?B?TkVFcHdYT3RVWUZYTzBnUlBIMDMrZlpCVTkrSlcyTFp4QkI5WVhIdkFBNENF?=
 =?utf-8?B?MXUwNzVMOVY4NVQwZ3AzQTB0UFRoSnUzMjFJemJSaU9mK216Nk1HTVcxSzA0?=
 =?utf-8?B?RmlLTEtKdW1WL2txVGlyVHVibG1BUzZ6YzlGVzZJMXdma1krVkw3TnpreEJ4?=
 =?utf-8?B?YUs5R3VvWnpXUkZlT290MjEyQ0lDY2VDejIybjhrdk5GZkg1TFdjWmpaNHBu?=
 =?utf-8?B?Ly9KZjczanBkTEpqKzAxRkZKemVLa05RTHVsQVNoUW5jOVd3Z1VNMmEvNmxT?=
 =?utf-8?B?Mk56UHB4a0tLbzFrcXF2eFFaa0FhejhmL0xSR21Ud3lnWHNHY3VmZlZYYmlm?=
 =?utf-8?B?L2hwdi95aUNDV2tqejY1N0VOQXZUMklZNXg3cFVBNHdJSGpTUXk2VmhiZnhM?=
 =?utf-8?B?MTRTaFhhN3BoRjJReWRZNFZkTWNSUmltcjhlVEM4QWwybk1yK2ZkMk04S3dB?=
 =?utf-8?B?V3BjeFBZTjJYc1lEblZJMnE3WTZzdEd5VkdYMjd2andtT1Y5RW5IRFhSL1lt?=
 =?utf-8?B?Wklkb3lvY21rdkNGMysyMnBRZlBTTFFlem9rNWQ0NGdleU8wUFFBUy9sdkFp?=
 =?utf-8?B?akdpSnhtNEdnSk5Oc1RpWEM4R1BiV3ZiT1FtS2s1dzFKL3BDK0Q2R0tyMkN2?=
 =?utf-8?B?Q2FMaElNUFJDR3oyT1V3aDhYSDhBNFdCR1pvSlk4NGtLNGhwNWhSVHFqZGho?=
 =?utf-8?B?cUplSUQxeUtUcHgrK0krdG5wVVh4dGErRVJUa0s4M1J4YmNCWStRWWkxUXBw?=
 =?utf-8?B?QzZVSG5jS3JneVlrcThmU1R4N0NrYUZCL2NuRFNMcmFuUWF1RDltbHBrNnU5?=
 =?utf-8?B?UGZlZVg1ZEV3NGpPc21kNS9WdFpSOTVKamorcmZ1Ry9wQkVCblhqTkg0TUt4?=
 =?utf-8?B?akVWeDZ2MHFJQU1lbTZwaUR4TVZtKytVU0N5TFF3Ym9LR2UvQWNRaW5HVlhh?=
 =?utf-8?B?VFA2ajY4Ykd0eHNpc2hwanlqaktkWmJrY2FvN3ZEc1haTml4N0RhV2Z3Ry9x?=
 =?utf-8?B?bDBwT0pUc3hDeTNSL3hHTzRmZ3RaMEVhMnlMWkdMY3VUWGFMRWpMdEhjWTQ5?=
 =?utf-8?B?ZnpKZzQ5ZHZWUC90cVFQN1ZORG9vaC9ocTVENjZhSHZPT1NDWUVEVmJDUUEr?=
 =?utf-8?B?OFdxY2FBODJaeTJybXpqRTV5Qm5MM1hySW1KRmNJbWVEd2piSkJtd1dlekE5?=
 =?utf-8?B?WG5lWjZkZkpQWGtQcFBzTm5zQzVUYkhyZkE5bVFvVzNqN2JzSlFLa2pQK2NZ?=
 =?utf-8?B?NkNlTzRsVWhXR3ZwcXQwNFB1NTRKS2VhN21UWXZ5SllvVzBSWEM4MVpJTW1X?=
 =?utf-8?Q?dejVAgZ9jzA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjllZHlvWVcyNDFUMmw5R1N5d3dyaWVuTWFQckdHSjZXcmEvZDhiNkVYTzU4?=
 =?utf-8?B?WkpmM3FXelhVaGp4V29MekFOQkpTRjdXZlpRcEJ0elpuT0tXck14SCtHTzFT?=
 =?utf-8?B?N0xtQzhqbDArZ0VYQXoremsrYVh2MDdOM29iYmNZeFJRS00va3NsNngzdXJo?=
 =?utf-8?B?bHkvN0NTWUQxcS9Hc3dpZTBlUkduODNOeUdvajJBQ3VaeTMxZzZZM1lNdG5B?=
 =?utf-8?B?U0paY09nWXhERklSbWIveE1Ha1ZZSFVhZTJUR052cFBrdVlscGxxWEFkdUU1?=
 =?utf-8?B?eHV2Rm52V0JyVzlueWkxcGg5YkkwYVNVbG5FNkttdHFiWnlrdVpQV1dYbEZ3?=
 =?utf-8?B?ZVdobXpCYkY3V0lJUjZ1RElIa1d1MHU1dms5YU5oaUVSdjV1VE9uUHMxUmdV?=
 =?utf-8?B?TDBneVNOazFtZGtGRFd5U1dHb3dVaXhXa3JMTExTeU80MVFYQmcwTU93Y3Uy?=
 =?utf-8?B?SnBnQU1WZmJBb01RaHpNTWl5U0dZYWpCYWVpSHlMaWIrN01FSEJ5VWNLUjJ1?=
 =?utf-8?B?a0VqdzJoV280SlVXTDJodXpoQmxPZTNCZ2x4emkwR3hRck9mVnVtYW5LOGNW?=
 =?utf-8?B?ZFo4R2ZBdlBSRGpCZ2VDQVJOMTRMVG4rODZ5TVV6clo0UENGaGljdFJub3ls?=
 =?utf-8?B?b0dLU1RHeGxyTXFURTVBYzVMTER5Q0F2VHl3VGx3bmVNN2JycFlaSUQ3RCsz?=
 =?utf-8?B?YXZYc0VxMUZBZms3UERMQThoWTBZOXVMNldsOUVRcFIvYVd3NHErZXlNeTZ3?=
 =?utf-8?B?cURHWHFTbUVvc0xRNGxuemF5QUpYK1NyQlpBb0dJUW9lS0xYdE1OV3RPU2hu?=
 =?utf-8?B?aEhocWgrS0Z3V0tKTTF3ODFWcGRYSU4xWXpUM09EUVNPaEg5aC9nVER3b3BU?=
 =?utf-8?B?cUdNc2NYRWU4SUpzVzU3VmdMYVZHSDR6N0dvZU96MURpR01EMjlyZ05OSWhx?=
 =?utf-8?B?dGhCYUltdXl5MWd4RWRYU2g4VEh1dC8yTVZxYnVBSnZDS3gvZWp4N1VpMitt?=
 =?utf-8?B?WFhVVGVQdnNVdE8rY2ZDREdxaksyQktUUmpybGQ4aWw0UmdJa0dnYWZrMm5v?=
 =?utf-8?B?b21ncEhTQWg5dVpOcnUzdGpsZ1VyMitEeTFMUkpsK3dsZjNneFpBQWkwK013?=
 =?utf-8?B?b3ZmNXFYbThMWU5qWUJJTDczUC96N081VFJLNFZLSzMrS0RIQ1FBa3Bvek0y?=
 =?utf-8?B?bXRQa1g0RGlxbkJkV25aNTBKWTE5N0N6QjdDaEtQWDFZamlob0JNQzk5Z08r?=
 =?utf-8?B?d2dyR0xWenMwTGkxbTRkU0ZnaVNvOWFDWkhWQVdLQnd1cGxTeXdyaHhoVDZH?=
 =?utf-8?B?bkxDSzRlbkMzZTZqTS9Bd1RTR0U0RWVjNUlVZk9iRFJRbGNKYXJQV01SNHVW?=
 =?utf-8?B?TCtHcEJPZWlqT2lFS2FHTEZHSHljYlAvRUlWNFRURWFEUkZPVUVWRklCK2xZ?=
 =?utf-8?B?YnpKeEU1ZmI4YVFLWUVRQXNCNHl6TzZDdzRRYy9xdUZXbnRENUZxQVRHYnB4?=
 =?utf-8?B?cHk0QW91aFdUVWFMeDdmZDBTY09VQ3lrV0Y2WEJKUmlicEViemFZSW1MM0li?=
 =?utf-8?B?UGR6amkvOGdDU2x0SjBaYWJvTm9QNmJPL2lTNU9RV1AxNTFUM0x2a0xvbW1S?=
 =?utf-8?B?UmpiUWhLL3ZKRlcrZ2hMTEw0elZncTQwUkhJUTNSNGMybkN4KzB6V2V1YVk0?=
 =?utf-8?B?TGVDZjNTN1AyeXdzM3BmdHRjREJkODhTdmQ3eFI2QTJybnllNGJZSGR0WjBF?=
 =?utf-8?B?emdtd3BxbDJ0OVBNakdpWjhya1EvVUg0djhJWnBtSXRqVWRHVEpVRDk0a21J?=
 =?utf-8?B?aXRpTEM4T2dCU21Nc1JWZjZwODZ2cFVlU1NwbUxySFhBWHgvMW4zUHQzNGZD?=
 =?utf-8?B?ejJ4MzBqbUZmMzNLaVg3YmNwZmJ6cElnd0taYWdlRDlPdjArcCtaWS8wVk5t?=
 =?utf-8?B?R0Nva01nQlFPSS9WYjh2c1lxdklhZi9JQXFDYjJob3dFV2VMMEZSQkxyODhw?=
 =?utf-8?B?UmpiY2E3MUpOQWNuNitPNmxFOUdYUUJMMThoZUhKU1VmbVJ2YXZzcXI0cG5M?=
 =?utf-8?B?ZE5XVFdDT28zTHpKVTRFV0NIeVgvVHlndTlxREJTWWtMMnhhV1VoYlN1VUR3?=
 =?utf-8?Q?3sGSjbeezN9wwWvj9npW66lTc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2851c082-4039-4a42-2222-08dd953ad4c6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2025 12:03:27.1474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIP3DjYwsvz2q+7/VURORtin0itawLlHxOhSP6EYhgEwOqtaYvaZxc2SDs6EvpogbON9GXDtDWpysUwX+8L2zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4A654669B

Hi Arnaldo,

> If it needs a specific kernel, then the test needs to cope with that,
> etc.

1) Bunch of IBS kernel fixes went in recently (v6.15-rc1):

   https://lore.kernel.org/r/20250115054438.1021-1-ravi.bangoria@amd.com

   Since you are running on 6.14.5-300.fc42.x86_64, the failures are
   genuine and indicating that kernel should be fixed.

   I'm wondering how would the test cope with the buggy kernel. Or
   probably 'perf test' a wrong place to put such selftests?

2) "mprotect() failed. Permission denied" seems to be because of
   SELinux enforced mode? I'll prepare and post a fix but, even
   with the error, it's just part of the dummy workload function
   so wouldn't break any test functionality.

Thanks,
Ravi
