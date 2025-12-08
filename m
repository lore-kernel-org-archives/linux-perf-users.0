Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A62DE70C;
	Mon,  8 Dec 2025 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765185734; cv=fail; b=ozwU6LBp7DvACXvqlIwwk6W150zTmLZu+EK4fTpkM1sPpj9IPvtUwlJ3L7lZqUPNMZBS3110s20StRa6uYsnebresNy/DQ8AC8xPUNn9iZMdy2DUzuLd/uPfL7qDw5i6vMDS8wo9RRw0gxoRF4JGyRAndY7jcka06pHbfnkCDhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765185734; c=relaxed/simple;
	bh=cvnZhytygz38zGEuAnCesHKU8kDxuLt4Qa0I46GCSWo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fptL58D64FeXpfAHpKqwTZVPvp6ww0YDdm/v7h4yiYq0IRhwrzjJSoVjHZp9HsuGPcUV1VbDmCJnZNP2l/XAaRYumMDYcDd1d3Eq24uc2vhKfyEuYu5vTmK+IZcUurfLTOQPiKa1YkpOG1GQj1YRlm+fGd0mVRZe8Le+Q9Cc8mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lA7mhRSn; arc=fail smtp.client-ip=52.101.52.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lA7mhRSn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rR5ifjNTK7vREnFnD3w31YsGuerpGYHhaAI6Zj4N4hO4yGeVLDmcv0lje4e6tL5zRByd50Nbd5mxP+D01C0w48T2yW0fX3H18VOU8F3o4c75uhqTf7bMyweHeQgzp99Vx3xjai0e+y2HsluNVVc8tM+QPEr68dwcQZAIO1TcjsP/6cIh+E+JmvA1pkfI2zKkWuWv42qTWw4a1yVmDf/bNIihKArxIDr25UvKpBXO+qKEb4n0mybAPgw2NLdO45M8vUR2p4yyhC5JxyPXnLSH29s07vVNM54lc4SyMsDaTGd37LA1G65j/DWjbgiK78EWpCfuhLGVFmlzjZ0AsL3PWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZWRlA/G3FSwLDNLs0r20ix5GG0/3HGqE+rP+GQycOc=;
 b=uq1I8Jih9jhlm3z2DYs6EK9iRfSinrhptDwugVJZDt9xZ8831qhJY/Nai3vTE3Twozpam8A4O6/WYEBSMJOlX1jQUM7SZcR/UyNnuvIsnjzl6w9dXE2Dp0pAfVE9BS3Hin+/W9AV2RpQOYBAS9/3zTiTYr/5y7ydYpBYj1wPfzz8acIWmYZZOAKepQXBGHplK//vN0NzOMa4X0IjdkVz3yC05uCFI3x2h1QpdWn8syTjFC3IZ8YUR4ZQ6AEI1hldOLBYUHQr8INOyNDP3IEQsQZUKfLclnKl3vEE2sPK6GiFNiT6t7ADlGD+GLY02nh4/83dYiKXyZvlJPRLXFhpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZWRlA/G3FSwLDNLs0r20ix5GG0/3HGqE+rP+GQycOc=;
 b=lA7mhRSn5wTI7hV8QBjaSCElb45bhWZf1Scx544vJOirXaXBdC5uD9XKHn0roHhLtlhGjq0SYGDD86dIAyC1Mda60T7xO4i3giGuVjBNp71A/KIvwUnYmRI4Pf59wVhN+iop7IweeCUnVieNnvO1GOh/6CV60uU4iqJoDSvBzZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Mon, 8 Dec
 2025 09:22:08 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 09:22:08 +0000
Message-ID: <00cde6ff-d9d4-4d03-bee7-a67b192896c5@amd.com>
Date: Mon, 8 Dec 2025 14:51:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 22/48] perf jevents: Add load store breakdown metrics
 ldst for AMD
To: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Benjamin Gray <bgray@linux.ibm.com>, Caleb Biggers
 <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>,
 Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Jiri Olsa <jolsa@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Samantha Alt
 <samantha.alt@intel.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20251202175043.623597-1-irogers@google.com>
 <20251202175043.623597-23-irogers@google.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20251202175043.623597-23-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::25) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a1f5ff-6e91-4248-b276-08de363b4283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bk5MVXFCbDRQRUxhci9pQjJhdy82ckVFSUJYRE9sQ01GMEl6dFNBT1hiRUpS?=
 =?utf-8?B?dkRacGYwbFVhbU9rdHRRZWhQN0lrRTlsVC9pcmNzN3dmaUluRXQwNjJTYjVj?=
 =?utf-8?B?R2JCTUV5Y1drLzQvdFBBVHVQaFc5eVZFR09SdFFtQnp3MlBRWlB0YmFFZ3Zm?=
 =?utf-8?B?anpVUW4vNFc2ZUt3VTlzOFkwcnJPS2NKOUtrOWFYUSs2dW9FWCtzcDJMeTRk?=
 =?utf-8?B?QWE3N05rZndFTDVJdFMxeDA3N0pSbnJkSHJtYmY0b1VJZW80VHdWSW5OeTRB?=
 =?utf-8?B?UFkrLzVUTVBwUTNoZnVQQzl6b3h5UnpGNUZmVytTOHphS1FGYndhalJXeVoz?=
 =?utf-8?B?Y283T3l0ZnlwYS92elVSdkVYZyt6ZXdWbzJCTzBpdHlZWG80a1lxRDJPSEd2?=
 =?utf-8?B?a0lrKzcyZngzVmhiMFM3c01pQ3JmdFZpSXJuamI4ME9Sa011dXZBYyttTW5C?=
 =?utf-8?B?Tmt1RTRBK1RNT0xMZ2J6TG1WaGFZdVhJZHp4YkxzWTlENjZyVXlpZ0JlRVEx?=
 =?utf-8?B?KzZMUHMyNlRlWk1nZU9LRXRIQTZIQ2xkY0tubVRnQ1UyWWdWbk5lL1N0bThT?=
 =?utf-8?B?LzVVMDNOdnJKTVpLUHRTaDNqOFNZQkd6OG93alIvZDRzWFJlc1NNanRvNGIv?=
 =?utf-8?B?RFluMTJTcG5uR1kwQmxjeWV2akovK1J3aEE3aWxnVjlPSVE2U1o5cXo4VG1K?=
 =?utf-8?B?S3JYK1NwVXRDYTRyNDhjN0RSYzJobVU4SGUrZ2RlMFZrZWVMS2l4R25qeGVS?=
 =?utf-8?B?M2lDVHY0ZkhaMnUwZE9nTUNmdXVNekVkdXptV2pkMXd3S2dUYUN6NnUwRXUv?=
 =?utf-8?B?cTdnZ3ZCM3d1cXlkeVJYeCtSRG1GTUJSamYyMXpDT3h6VS9QVXc5a0o2VW5O?=
 =?utf-8?B?dGN0Y3p1cjRMVGorWG1zanMwSFc5SStsYUJFa3ZudmIxNUh3OG1rU1RoQXZE?=
 =?utf-8?B?ZGJRdXFpc09YQWFraFA5R2syZHIzVU9sUFJXMGJqOUluanZnVmtHSzVHRE1D?=
 =?utf-8?B?MnNiTkNlQXd4V1p4bG1sWFlCUmJ3UVlCN1N0MFVWNCtzck80bnNSNy9tZXR4?=
 =?utf-8?B?d081OWpoSHdIQkVKUGJWb29LYkUxWEpvZFVCVlF5aC92Qk9kb0FsWlQxSi8x?=
 =?utf-8?B?OE43Y2VxbkNESDdXM2o5akJuNG96cnR6RncrR05hNjlCeW1nQVJBbC9VbjR6?=
 =?utf-8?B?Y0hCa2ZKblREVlV6Rklxd2VFRGwyQitpVE93djg0SEVOZEY4ckN0a2N3UGZ2?=
 =?utf-8?B?VEM1b0hHNGdHRDg1TEtKUmRTa3hOcDZiUFZrbWRLc1ZOcmNyaFl1TjZ5alE0?=
 =?utf-8?B?aGxDNkhKRUxkWGtmMTNzTXVKOUFlNWZYUkZQYW52K3MzMUc3anI4QldxN08x?=
 =?utf-8?B?WWF3bFp5bHIydDlLRTU2QVVTcnBKL0RYZmE3c0VYUkk2dWd3cU1PRTdmYXR4?=
 =?utf-8?B?UDZCY1hTRTRQaFZjSWNDSytpdHdvbENyWXo4S0NFQWpEL2VvMjg4OHhDdnF5?=
 =?utf-8?B?MDRaQ0libEZIYlVmSnRXT0ZOVktMMnFGKzhUZkFZeDdxSXYrMkxqUHcxM2Z5?=
 =?utf-8?B?TlZvOExjNXFwY0thUnhyMHhOYWVLbkUwbjVXc0xGRWJSenpLazAvYWk1azhq?=
 =?utf-8?B?ak4yLythUVNZYWZvZTZsQW5sbzI5eG5keXpmeGVlc1JEWTdKZXlJWmhaeThu?=
 =?utf-8?B?MndRS0VsSXY3emY0ZDRKWDlLYlc3MFlZUVp1TGxPREFFWkt3VnpwMytrUTZz?=
 =?utf-8?B?bDJxdVphZVhxdVlGQXJwdU00UG9sRHh3NEJSR29meHlHREoycjVZLzFvN1Zj?=
 =?utf-8?B?QmpxWFFpdVJZbHdaV3JHSzY3MEFQdzhoZ1grc1p0UzRpbm54emlRaFBtVU5U?=
 =?utf-8?B?NktMeGtXSmVoQllkcUZMNVkvc3N6ZWJQWGxaNExFOE5JVWF0ZDhMaS9xVHVE?=
 =?utf-8?B?VENSYzdXTVRZVGtGUGNMdXNOaGQ5bjF0Z2VWMFZNV3lEUzhIQXBJa3FUOUZ2?=
 =?utf-8?Q?AFU21SlHetI6sJnvZukhkBlh5yjWiY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0t1emg1Z0VvbE1TZkxnRWErS1dRdVFDVWMrdGZpdUtRSnlKR2VSejhBMjlI?=
 =?utf-8?B?U1UyQjNzbUdXSXRIZjJXT2RYRmE4TXVpenV0WENBVUw5RzlXQnhLUFhmejY4?=
 =?utf-8?B?RDlEWVR0Q1VaRmNkK0ZzaXA1cXozUVptdXRTbCtSbEZOM25mWExJdzZYdGdk?=
 =?utf-8?B?OVBTaVgrM3R1MG9sTThYcnFoVmVZdnpoWkxwVUZGOVk4RUIvSy9xRWN4WTk1?=
 =?utf-8?B?d3FuaVhDaUFlRzBHRmorNDB1cllJcXN2blNPTm9ObVlQenplN1lhODNpVUph?=
 =?utf-8?B?WUJOMFVtTU1XaFdQRDREU2RFOFhmOEdKOVl3alkzN2pWRElWQXJXWlNCQnFI?=
 =?utf-8?B?MW13b2g1WEpPVUVBQ040anFmYkl1TUsxRnpxYmdMZkMwcnZsSE1neE51Y2ZD?=
 =?utf-8?B?alNHYmFBaXMxdjY0SkdDcHN6Qm4vckt5ZTlkbHR0SnluN2VxUFFubFhKVEVT?=
 =?utf-8?B?UHhNVk9NYXRhN3pQcE1NeTdhZkV6RXVSajhHYWRERG9GWWR5MURtd2VOOC85?=
 =?utf-8?B?eFhqR21iWk55L2dxV0VYTk1ldEhOYllPRmpSY1FvTEk3UW9sMkhlNXFiY25v?=
 =?utf-8?B?MVBuK2RHS1p6UjhYTW84M28xSHA3czVDWW41SUJqZWRoWmk2UXl3cVBRa3lR?=
 =?utf-8?B?cG40U3ppc2dHWnBoWlBvMmdhTVNacUdldURldFk1K05xM1UzdXByOTlYaity?=
 =?utf-8?B?WlpBd0xFY09Od1dpRlVCTGJoZWJnOU90cTlLK2VsN2U3RzFseHpDdzlsMFhC?=
 =?utf-8?B?VTRTMGZGQjNJR3N3aGpMSUVCQys5R24xaitKNE5ROE9IejJzOHUwK0tEa0FV?=
 =?utf-8?B?MkhJbnUxNktSWllDRlU5Q1F3TWJDQlRsaFBWTUFQSElUYWVqdUV2L3grRXha?=
 =?utf-8?B?QWVFVG15YlZ3V1lHQjVNL1pUQzFUN2pTeTB1aGxDRUg4dHp3OXJxQ254ZEhm?=
 =?utf-8?B?NCtKVHZ4MDNiZDhkSXdvWDlrK1F4SWYzL2RoRlFNWXg5N0FqWXN0anJpbGJL?=
 =?utf-8?B?cTUveDIwd2NscnUvNXZyZzFiYVlhRXBtVVlVTkRLQXVxaERjWWU5bFZUK3FK?=
 =?utf-8?B?UXdGc0NNT2RWYXI3ZUJWU24yMXI2NFFkOFYvTjFPN29JYTU4TDhHSjkrMW1Z?=
 =?utf-8?B?cFU4UEpjQkxQWVE4emczTU40ZmZwQUhPUmFZSzZkODZnSHhhVFJQd1ZsUnU1?=
 =?utf-8?B?TjZUQmRTY1NtT0pDNUUwOStaZUNtVTVnMDZqb3pVVXkvOG53UVdJUTZKZm1I?=
 =?utf-8?B?cnRCM1RSOVRsT3RmYS9zblo3TjExNXBkRU9YdGVaOUZTeUdCWHBmb05JWEtt?=
 =?utf-8?B?dG9qTm0vaXhhWUIxc1RmVFduRXpHOTNLN01OWi9HL3BWd2FIcXByNEZDMlVF?=
 =?utf-8?B?WFVYVGRHSXNjZGp5ZEYvTHJ6VVk3Y1BQenM5YTB5ekZIR3JPV3diYTluaTRS?=
 =?utf-8?B?UG1pc1pFZDBQTUlDQ3pJamhQMnhlWlpKSkpoeFBmd2k2T3BmaDlVendLVG9t?=
 =?utf-8?B?TXR2UWJ6cno4djZwa2p4dEZTbTExdjhETjJ0QngrdGx3NE5CaDNNdlZ4Uzc2?=
 =?utf-8?B?eXN0Qys2Sm94bTVFanI4NzJBRkFyalZpclUvK256TElWdEE5OVNaN3dBd2JO?=
 =?utf-8?B?UzNPRTRYWDJ4aGo0KzBZblZpRVZQQTRaR2RuQWFCMHg5TmF0bjVlcmFta1ZB?=
 =?utf-8?B?dTl6VUNqOVpzTG5mYmh5bXY3ODVPSlNCTFNhdlBsckc0enF0Q0RjcGgralNh?=
 =?utf-8?B?QVJuTjNVWkxtYUZLY2NtblZ3V2xOODQrK29jejRTMFp4WjE1RDNZckcyRERo?=
 =?utf-8?B?WkduSWdNbXBjaFpjOG5HdjhRRk1oS3dvYnBZaUdKRlBXQ1o2bEF3YmYwL05p?=
 =?utf-8?B?d1crOGl0dVBNT01Tc2NUNnI1dG9STHdVQkk5YmFWODhKazhITFp5ZTlSQ0pS?=
 =?utf-8?B?VlMvSlBUSVdSWTVkRjA0RTRkS0ZpYkRSZ2IxVk9md0plNVdUZDBDR2pxdW95?=
 =?utf-8?B?M09CTkdHQ1ZOMmZLbTdRS0E1RStrZVZ0OWU3UFZFZnI3WTJmM1kzREJveExD?=
 =?utf-8?B?c2FlOXhadDBndHJhZ0l2VmlnQUsyQ1RtcjFvYkcweFpJcWZLYXF1TE5vUkRV?=
 =?utf-8?Q?XMtX1mukDoGyrxbUh357y4SGR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a1f5ff-6e91-4248-b276-08de363b4283
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 09:22:08.1696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wrTVvWjMTySj6UWULcxsOkDeYEOOYaET8t9/ZRRYu8E5ciHoqQZSC/2e16mDGYhmpMdbWUOniDwvWSl8pqFnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052

On 12/2/2025 11:20 PM, Ian Rogers wrote:
> Give breakdown of number of instructions. Use the counter mask (cmask)
> to show the number of cycles taken to retire the instructions.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  tools/perf/pmu-events/amd_metrics.py | 75 ++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
> index 6542c334a82b..1611d0e50d03 100755
> --- a/tools/perf/pmu-events/amd_metrics.py
> +++ b/tools/perf/pmu-events/amd_metrics.py
> @@ -279,6 +279,80 @@ def AmdItlb():
>      ], description="Instruction TLB breakdown")
>  
>  
> +def AmdLdSt() -> MetricGroup:
> +    ldst_ld = Event("ls_dispatch.ld_dispatch")
> +    ldst_st = Event("ls_dispatch.store_dispatch")
> +    ldst_ldc1 = Event(f"{ldst_ld}/cmask=1/")
> +    ldst_stc1 = Event(f"{ldst_st}/cmask=1/")
> +    ldst_ldc2 = Event(f"{ldst_ld}/cmask=2/")
> +    ldst_stc2 = Event(f"{ldst_st}/cmask=2/")
> +    ldst_ldc3 = Event(f"{ldst_ld}/cmask=3/")
> +    ldst_stc3 = Event(f"{ldst_st}/cmask=3/")
> +    ldst_cyc = Event("ls_not_halted_cyc")
> +
> +    ld_rate = d_ratio(ldst_ld, interval_sec)
> +    st_rate = d_ratio(ldst_st, interval_sec)
> +
> +    ld_v1 = max(ldst_ldc1 - ldst_ldc2, 0)
> +    ld_v2 = max(ldst_ldc2 - ldst_ldc3, 0)
> +    ld_v3 = ldst_ldc3
> +
> +    st_v1 = max(ldst_stc1 - ldst_stc2, 0)
> +    st_v2 = max(ldst_stc2 - ldst_stc3, 0)
> +    st_v3 = ldst_stc3
> +
> +    return MetricGroup("lpm_ldst", [
> +        MetricGroup("lpm_ldst_total", [
> +            Metric("lpm_ldst_total_ld", "Number of loads dispatched per second.",
> +                   ld_rate, "insns/sec"),
> +            Metric("lpm_ldst_total_st", "Number of stores dispatched per second.",
> +                   st_rate, "insns/sec"),
> +        ]),
> +        MetricGroup("lpm_ldst_percent_insn", [
> +            Metric("lpm_ldst_percent_insn_ld",
> +                   "Load instructions as a percentage of all instructions.",
> +                   d_ratio(ldst_ld, ins), "100%"),
> +            Metric("lpm_ldst_percent_insn_st",
> +                   "Store instructions as a percentage of all instructions.",
> +                   d_ratio(ldst_st, ins), "100%"),
> +        ]),
> +        MetricGroup("lpm_ldst_ret_loads_per_cycle", [
> +            Metric(
> +                "lpm_ldst_ret_loads_per_cycle_1",
> +                "Load instructions retiring in 1 cycle as a percentage of all "
> +                "unhalted cycles.", d_ratio(ld_v1, ldst_cyc), "100%"),
> +            Metric(
> +                "lpm_ldst_ret_loads_per_cycle_2",
> +                "Load instructions retiring in 2 cycles as a percentage of all "
> +                "unhalted cycles.", d_ratio(ld_v2, ldst_cyc), "100%"),
> +            Metric(
> +                "lpm_ldst_ret_loads_per_cycle_3",
> +                "Load instructions retiring in 3 or more cycles as a percentage"
> +                "of all unhalted cycles.", d_ratio(ld_v3, ldst_cyc), "100%"),
> +        ]),
> +        MetricGroup("lpm_ldst_ret_stores_per_cycle", [
> +            Metric(
> +                "lpm_ldst_ret_stores_per_cycle_1",
> +                "Store instructions retiring in 1 cycle as a percentage of all "
> +                "unhalted cycles.", d_ratio(st_v1, ldst_cyc), "100%"),
> +            Metric(
> +                "lpm_ldst_ret_stores_per_cycle_2",
> +                "Store instructions retiring in 2 cycles as a percentage of all "
> +                "unhalted cycles.", d_ratio(st_v2, ldst_cyc), "100%"),
> +            Metric(
> +                "lpm_ldst_ret_stores_per_cycle_3",
> +                "Store instructions retiring in 3 or more cycles as a percentage"
> +                "of all unhalted cycles.", d_ratio(st_v3, ldst_cyc), "100%"),
> +        ]),

A subset of dispatched loads and stores do not retire. So PMCx029, which is used by
ldst_ld and ldst_st above, does not provide the number of retired loads and stores.
There is currently no event which counts retired loads and stores :(

> +        MetricGroup("lpm_ldst_insn_bt", [
> +            Metric("lpm_ldst_insn_bt_ld", "Number of instructions between loads.",
> +                   d_ratio(ins, ldst_ld), "insns"),
> +            Metric("lpm_ldst_insn_bt_st", "Number of instructions between stores.",
> +                   d_ratio(ins, ldst_st), "insns"),
> +        ])
> +    ], description="Breakdown of load/store instructions")
> +
> +
>  def AmdUpc() -> Metric:
>      ops = Event("ex_ret_ops", "ex_ret_cops")
>      upc = d_ratio(ops, smt_cycles)
> @@ -365,6 +439,7 @@ def main() -> None:
>          AmdBr(),
>          AmdDtlb(),
>          AmdItlb(),
> +        AmdLdSt(),
>          AmdUpc(),
>          Idle(),
>          Rapl(),

