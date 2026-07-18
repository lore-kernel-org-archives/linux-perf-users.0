Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021092.outbound.protection.outlook.com [52.101.100.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCDD37AA98;
	Sat, 18 Jul 2026 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784386910; cv=fail; b=quKpzT3Ouvy/2UOUjdyjFiMmWfz8PauRH6lfMMEMQKwXluPHb7E3jvBsnX5Xudm0caaCOj7ZIewvOEZBw0k9JP+gUrfDNEjxmXwSlleJWM5TLRSOKiCOBwF0mtHkscnf5gLlBrjsw+jG3zKDdtOoavu6WsZHKto2Z535ydjrR4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784386910; c=relaxed/simple;
	bh=xXI0jEblPJ2xvgj7Q0k8AynLS1Zv8bPevAugYOh+h7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qxwn+RZueOcPxkcRb4GQRyFxDR9unuKN1BPs6ZnscCv2J0sZQWAh6Hh99ZBcfc5akyh+Mszwu7AIV7+dUJCxvT87Q5aB90gDz3gOExPs6ynMiAB2P6KXimjjX7MUeKl+X2+4/ZASDuDXyoai+Q1C8h6XOjzy4+h85Q0FJ7c0o/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ec2rWaZadLGaitQ9B+EIsPBd2KZUtI3bOR8H3h3OFcYHv7gTfHWbM5iLKFZ/6YSwiawlk3cdYhoBFsPfjSt5C/2CDLW4V0XBsJNSm6jspGUMkIC5qwJh2RqFCQ+gUA7/xZzB15SItA2xetRknfxD5tXTAJjxK4x6WvYOKYnpuHHD3ImOTAhzdBf7Q8gf8CzR22tU+dLpPsZr7wHHreqLPmBiti5M0IBGuAR/om51V8pwXHna2jKa+SDxn6I4lQjDd3OdpBVD8OD6rzSNeeAYM0pDMSzRDL1JUQzQKydravXDqkUC0RePuL4bGbCwlG1NyUgul59ELHlB0BmzS9UsFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=1zipjUjizfcE2073Mg+PjlYeJPlxuijJZ80QrKmcjH0=;
 b=M2xiHBTPED6p6r3e6h0Su+KHzYn4PRsQO/UeN3SqIKcBI1Mcl1vrMzuLUqoRO/BOInDkOlZc3a1L0y142BjHNNuVGr2AcNY5tDeRULdB9HJwJA7FNa8I8wS7J3W0OWboG3maGntBM4K1Ik4Q7WYgP8bCOtL7jkXhRLuSnNYa9DtwHvyf9YjEIxvT2UwoftBSjX+MqeuWMEcP3fYvXc0YyxQk1KZRfdQ6dVJqDfvwgeGVRPYm+RmkN5vphUxepXhMvyahV9WE1x78CivN/o/izkOQQKwyXirlmqf6jLqEtuYoTKdFzAS3vj5qwIT5hnKwsH7jO05z+PKiTNYf4ywWUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB6988.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:31d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Sat, 18 Jul
 2026 15:01:45 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.013; Sat, 18 Jul 2026
 15:01:45 +0000
Date: Sat, 18 Jul 2026 11:01:41 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf trace: Add --bitmask-list option and correct
 cpumask formatting
Message-ID: <ok2srr6moiwqfk3b7bwowfm2ru3xs56zldypmluvygnkz5kjq5@6wcgdqxu7itz>
References: <20260717013544.257768-1-atomlin@atomlin.com>
 <alsI6DoHlx4NniDJ@z2>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alsI6DoHlx4NniDJ@z2>
X-ClientProxiedBy: BN9PR03CA0664.namprd03.prod.outlook.com
 (2603:10b6:408:10e::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e544c71-45f9-40e5-4255-08dee4dd7bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|4143699003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KuJOK9130fi68NZx60Khr8MV/ZxxKQJebB1KGdcceCJwKcU5MUOFyafxhM+uIFtcR/tnPZaBGBdqsBxpnVaSykWds7kZQoFoEO0sn1SsxbKblNmzTGa/o2qvobKL4HZzYuhcXTu53b6NhnrWsoXf3DEpEzS6ZwcR+/XJRWbghwF4m3m2yxOW9fBHYjyZ7hwh0ha589YUWUSgC5DCeQEJJKsfY6KbU+RqGfRPCu9rDCyPjn6H2QJhZu/YsRseJiJMdGooAqq2BXjV+kLpi9SrFp3HWyK+Ipwg2Pa/Ad6uFPEwM7Gu2HFU3DzlPQ5pzC2nDrA0bVZ0WT2jXGYb9c2Ka5vhJ9X7QUDvjrsdCUUqXqwngK5hkxXQwkFPepnmyavy4hklBAnRmmF3aMelLl4Bmxxi8gB0+wHCpe27serrX9VhXaTa7HGOk/+XiXUCmzAYZnXFRyGJaUEFTAxz8CVB2+E9W98x155y5WhEMctnfp9xfSnP47EbK5eBnfqO6u5Po/9UxcMR0Lz9TNQG2MKNSOXBTH+or4bPGb7ktf8GH1NshbuJigTL+lDLYQ9dNzemf3KgvjvWZiKUNCZtRXJTEiG0pjXQlaWy4v+giRW88RKd6/Ny0hdOeiokBA97F0RxOX7isZ5F7Hw1lOmbOMUsiIbEiFwfqIWp7vgnA09CwKg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(4143699003)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1lCc2F1S2hOWkhrbFIxckhidllxTjQwMlA2NkYvckNZdG93M2hUQ21PT3I0?=
 =?utf-8?B?RlJwSDIxblMzaUE2RVVBYWxpVEErNFBYMUZoZFZjZDg0RDVGd2hLOHozeEVk?=
 =?utf-8?B?WkFYaEFTRlZ5NXB2SUN1WlFMQjltVjNKbzF4TzV5MkZGeUhMYmdDZXVUcnJt?=
 =?utf-8?B?ZXE4Mzh3WVF6SDRKUXI5bEVJMTI2ZWZnRS9DdVZBc3hhZ1dIKzloYUpUajFW?=
 =?utf-8?B?elZRWnhFaTJ4ZHNLMjlnQzl1ZUNuRHRyYzdpbS9OMytYOEthOWoyVjc3N213?=
 =?utf-8?B?UG96SERQaTNIVHE1OEUwT21tYjBISXdPT1pTc3hjNUFVeWxnSHhVTVU5RU0y?=
 =?utf-8?B?RHNVNStGcXMyR1Fvc3VLTkhvenVDTkpSYUtXZTdLNDdUamVhaXQ0aWovZng3?=
 =?utf-8?B?K2VDQlU2TVpnV3BXdHJXeVRTV1J5ZFZDME11N0JnRWY3Rm02ZDd4NzhFc0Rj?=
 =?utf-8?B?RHBoZWxRby9hdXZEeFc4eHJRWklPTlMzcXdVcHlIWmtXWjZrdm5JYTQ1Vlh6?=
 =?utf-8?B?UEVRTTBucXpVb1NmV2lkYlFXaUJpR0ZMdnV4RHJzWGswa3BxOTdKNnU2QUxI?=
 =?utf-8?B?SHByRnB6M0llbkU1eXlGSGNQdHFrVWhwWkNyZjdnT1hzdGF4d28rc1lYSGtY?=
 =?utf-8?B?cy91WmpQWmVmdFdFakhxMTR4TGU4VlBqMHBodElVSy9WNWR1ZUt1V2dRRlc4?=
 =?utf-8?B?clV3d0ZvQnBLV2ZxQWJLR1RuaW1sVE90NDV2djZzN253b1FyWDB3STFuNEgx?=
 =?utf-8?B?cWZ4aEZrdmZCY1NNOGJIclJqaXpwMUd4ZnhOdnhZNGZhNm1tY1VWblQwQ1FX?=
 =?utf-8?B?cFRCL1NPeEtiMittbllUNmwyOW15ZG1ORUJMYWpCMnVzTG5mNkt5Q3lxV3F0?=
 =?utf-8?B?TWZ2ZEo4bWVzcWVvTVh0d2pPS1hxMjdVR3Y3R1VxZ2s3ckI4VUx0NFY3Zmc4?=
 =?utf-8?B?VnVYVHFkOHpJVzUwTzF3eXZYK3FxY29YOXlvVUJoNkFodE9OZEtBVXdVTzMx?=
 =?utf-8?B?MGhJOGRyek8waFdaZ2t4VXBRcjI5ZTBKTXlMOWR4eDkxZXNGMVNNRWh0dUN6?=
 =?utf-8?B?d1BMa0kvOTFjcTBXU3lYQjhJSzYyYkFOdGxaQjhBTnNMUkVNZXA0cHpBVm1N?=
 =?utf-8?B?VHFxdTV4SjZudzhBTFE2QnlUdTNKRjhlT3JBSUlsSk5UaGlhVGR5eEtVaDJn?=
 =?utf-8?B?aGNjVXh5ZklhN3FTL3hiaEx1OVUrVmtLVE12Sld2Z2xGSnZPTlVRM3dBUHky?=
 =?utf-8?B?R0NtNWJlN3FRMmpVUEltVnVvbjhjU2lHSHZ4eHVpLysxYWJSMFNXSnl0bi9l?=
 =?utf-8?B?WWJiSWNucVlYS1cwNXd6OXFQTVk4ZUFhUHF2TFQ3TjI4bURGVG5TVVF6cVF2?=
 =?utf-8?B?TFNjc0ZCMm1UcUFseng1RDNyMjZ2dEZnRUdlYmFiNUVxcW1DNFBrdHk3VEF6?=
 =?utf-8?B?bWFwTWkvUkdGYjJYdm90TkxlUDgxWmpKQXorc3BLWlNiaDRHR0JJYUlZc2lN?=
 =?utf-8?B?UFMvRUNmN3h2Z3ZEWFNRaW1nc1hJNFVRcUxKeUpWL2NqL2JLZFB2WXErcUcv?=
 =?utf-8?B?eUhYZ2FOVmNidVB6RVBTbHpwc0ltYjZLS3p4anRNckFkY2drakJHRzQzSHRS?=
 =?utf-8?B?MGNZUlpzK1pXcHJQK3RNeFpxMXlJNWJuN0k2TStTVnd0TGE5ZGh3c29oSm95?=
 =?utf-8?B?ekhma21qZmNEMmJaamxFeXRzOVRBTzBvQzRDYi84SzBpSE5qR1pQRnRzSWFy?=
 =?utf-8?B?RC9vdU9hUjZyNE9IcE9NOGZqWERKMTZUTStkREhvWXhmd01RUjQ4M2M2dzZE?=
 =?utf-8?B?SHFBalhzNmNHdm1RK0Y0eE1ESnhVTzhITVpnZ1BPRGY4TU1ObTdpTFNPM3dx?=
 =?utf-8?B?bGRQcXF6OGtiZWR6RnlQdGo4ckpsdmlzNUtMdWpUdTdYWGh0Z1lZZWdXRVA1?=
 =?utf-8?B?TEdwZk5PUFlacHRwS2VvaHRQZDBoaE40SktlMSs1Zlh1Tk1Sa05tS1R2c3c3?=
 =?utf-8?B?U0ZmVjAzVXMwL01zQkw1Q2Jvc0VCTTJuTktUanE0NURMMVdlS3pEbjRzRGFz?=
 =?utf-8?B?Q296NzJnQnQ2cHp3RDI1ekRoMFhrcFJLemlSL3RhSTBNaFRYK2dNd1lkSE1C?=
 =?utf-8?B?NGdaK3VENjJsTXM0R041dDFUMDFEQUEvY2tJaFQ0T3RhcXN3TDFwaEx3bmFS?=
 =?utf-8?B?TFRPelE4NE9QT1hzYjIyV1l2WUNjRGZkN0Q5a3l5N3M1N3YyazlYRjdtdXBu?=
 =?utf-8?B?cmRocktnbHYrRDc4VU5hbTVFenBqZEtYU09rbEpnRm93OWJTb3NsS1IwOUhq?=
 =?utf-8?B?WGo4SllBNlhpVkhlUE1WaGpBdmdsdUhPNHBqN3l2TVFDVE9BcjlWZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e544c71-45f9-40e5-4255-08dee4dd7bd8
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 15:01:45.1015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioO0MTsJ0pthjjB10xX+kh/GPWLfhybSlN7uFu9OlFDKKA937x6ckTSHVcaIBELzwvJ12MRAq1ztpP4arKsxEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB6988

On Fri, Jul 17, 2026 at 10:02:32PM -0700, Namhyung Kim wrote:
> On Thu, Jul 16, 2026 at 09:35:44PM -0400, Aaron Tomlin wrote:
> > Currently, dynamic non-array fields such as 'cpumask_t' are mishandled
> > in 'perf trace', causing the raw length and offset descriptors to be
> > interpreted and displayed as a literal integer (e.g., 'cpumask: 524320'
> > instead of the actual mask data).
> > 
> > This patch corrects the parsing of dynamic fields that do not have the
> > TEP_FIELD_IS_ARRAY flag set. By doing so, it ensures the pointer to the
> > raw bits is properly resolved within the payload.
> > 
> > Furthermore, it improves the display formatting for 'cpumask' types:
> >     - By default, the cpumask is now correctly output as a zero-suppressed
> >       hexadecimal string, resolving the aforementioned integer display
> >       anomaly
> > 
> >     - A new '--bitmask-list' command-line option has been introduced.
> >       When specified, this delegates formatting to 'bitmap_scnprintf()',
> >       enabling the cpumask to be rendered as a condensed, human-readable
> >       list (e.g., '0,2-5,7')
> 
> Looks like you are doing two things in a patch.  Can you please split?
> 
> And for any user visible changes, I encourage you to add an example
> output in the commit message.  Also please update the documentation for
> the new option.

Hi Namhyung,

Thank you for your feedback.

Sure, I can do that.

Acknowledged. I will implement this in the next iteration.


Kind regards,
-- 
Aaron Tomlin
