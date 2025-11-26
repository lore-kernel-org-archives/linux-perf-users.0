Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2960C4C9D;
	Wed, 26 Nov 2025 05:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764134459; cv=fail; b=S4C0RmEUgHTFPnZUbSdgqTI9jDdxT+VTCfOtGkT/5bjJ1muJFHJkYAEzoU3b2U5APnjNkjgAaZ+m+2ZA2Ml/cCHvmExvitOL/9VACqz7TEh8s/SKYrq04JBWOksjFvNcaZjPs2xjANgMjxqdvd2OK9V0oEqL+nRgeCssHJ5hPzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764134459; c=relaxed/simple;
	bh=XHeRzTZXeQZOaEOnTDJ7e734lXscyruY4IL4ben4TXU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4k8FNNQeG8N4Kmz8XeyRPTgrZVFeRD/fd68rNeem2cm7NC8N5sSG2Iq2gxxNO/ORrTuox1O8T5CA07/XmY9ad7z8KlvoD7tG6hZu7wqfyA16htj/nBWYblU0Wcab4+O1a3E/RtGj8falPS0KOwLHlp4V2VcfUcW3kCftIH23Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EHv2Ecaa; arc=fail smtp.client-ip=52.101.48.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EHv2Ecaa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0Xx9rJOhVFcPQbd+DeHD7Nl0WNdMQscxEkaVYf5A2vthjQrIx3/9rQ3urJuosJwpP1SplY73xmv5mzetFQHJWR5xRK3VSgPAahKq2GqljvmuK0Y/vpodbNLLJplr5JyQV97lynHTxIM3v7XioiOutd8V4B2OMeY4v8DL8kGHwDgwoyrY/CxGEy3U3pOuFuZuENwnJHJqsBwaUEz657CXmM/bNif4kbt7hGSY7mUWcz2Jfg7086mlDRfPjru4tcsGNSactpBH2xQSeXBHWCJBhIJYPLFJusE4Wc8ufoHVNSV0VqRMwCDrwspqH/zlRScDiBkldL9EjkzoWt4aHKudg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8Lt9nhR+ppihVgpQkeyON6KQ+qV/HaVhwySdTH8+PI=;
 b=D32b6M3Qbq9Saki+38HptpYoqWprg3eFtXgsKkSr4TmCIU2GB4ExIJ2+g34lmaA6tFViLpe2ACx8i2FS3EL1u65uJSUkzrGjmEKm+zSm+fU9lukJuUmXbzwwxPUXFGAh3MqUqHmfT48ld1RIhBXg6XvakR/Z4hcmnpp0vzHbeU01uLRWFx8s1rqq6ySu2Un3ZSIPC++bqwIgiJo4DhWttLG6x6F8cHRiUFXtDtzDD8ECgP5FlZfe2R3eQ4Qut7FpsbxUjgMQ9CJoRsMBneITfKmZo9+IDhgq0uAL3DECOagfaIWWX/jv2IHoCm6ECt7D5IcxTP+FqqbYFqRBvdUjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8Lt9nhR+ppihVgpQkeyON6KQ+qV/HaVhwySdTH8+PI=;
 b=EHv2EcaaLPqq0FyZMLJhlGsV0SvywRqNI8CSTBkO+qJ4kBewuehi5zk6zZGrw7xsYXKA4P443xXVsCuejZb5WD3uLLtlaCftcLbgRA0FCwYKdxI59B6DP3gadvLe53vjbsko3799EgVHWttYuISDOmijgAx5HiBsw67PtyoVhUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by CH1PR12MB9645.namprd12.prod.outlook.com (2603:10b6:610:2af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 05:20:56 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 05:20:55 +0000
Message-ID: <abb4a851-319a-4c2f-a99d-c4e352ceb1ab@amd.com>
Date: Wed, 26 Nov 2025 10:50:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 23/52] perf jevents: Add uncore l3 metric group for AMD
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
References: <20251113032040.1994090-1-irogers@google.com>
 <20251113032040.1994090-24-irogers@google.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20251113032040.1994090-24-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::11) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|CH1PR12MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ef4903-2761-4aa2-feb2-08de2cab933c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3NYM3hsSHFTV0FuYXBPRWo2NDJON0hFOElPUC9IUU5wZkpYVThieWI4OVM2?=
 =?utf-8?B?VSs4b1h4Q0VCOTJncnNOVVpMUVdhaCtaZEE3a2RIL0xZMFZQTE5Ed1pkS1Zv?=
 =?utf-8?B?bE9FbUh3MlNkeWlsZHR0aWlIUmZjM1oxTjAyNkl2TUx0RHB3akxDOHhnTm1R?=
 =?utf-8?B?OGtJV3M4bXNGcGg4aVgxSC9zbmQreFdtRTA1c2ozODNrQjFzOVpwZkVub1Ri?=
 =?utf-8?B?ODFTdWR1WVFFTmJBSytWWUE2TFdLOXlSS0RPd0NZdGFXREdYamgrcnhLSS94?=
 =?utf-8?B?bW14eHlXWmt5V3FqcmtlTitjaXZ5bjkvdmhJWFVtd254YUp6OGdselpaOGkw?=
 =?utf-8?B?SFdyRXRpazlMbSs1Y0NpTlBlaHJzRERqcmRaM3FyUktTdkkvb0ZLd2N2WS9V?=
 =?utf-8?B?NTNRdzNqakFjUjFhRjlGdHFTTDRONzUwblJIbldxVFNna2lmRldsV1BkYlJa?=
 =?utf-8?B?SFdLSm82dnVZZzdEemtSU2xaSDlEWEhwU2JZTHJnaTdPbURVSW9wNldnVndE?=
 =?utf-8?B?d2huU1FYU1VwK2VHRkJjVkgyQ2RpTEVZWUJRTnhXZTFyVXdSUXkwTWIvaFZ6?=
 =?utf-8?B?MlgwUFJONHNvUmZHRndCdThBZFBMZVdpMThaR0ViWjE2NlFmd0FTWDZKTVJP?=
 =?utf-8?B?Zll1YTV1Mm45KzBoSVFLL0F5Y3pPSVg1VzBiODBQc1k2cC9HSVVUSU50Q0ZX?=
 =?utf-8?B?WVJNemhCc2dTMCtOMzNaSlAxcUVmMWdwRzZWTUpsRkpHMUN0Z0ZZNUEvZDJq?=
 =?utf-8?B?S1hzdmE2WTlqOWZwT3BWbXVEaWFYSlVMMGN4SStld1EwZWc5NDVoRE0xRE1X?=
 =?utf-8?B?TGxCT1RaODNzd01PWlBUbmF6YUVJTTZqZzR0TGx3QXRsazBNZXJNMzJlUmpD?=
 =?utf-8?B?QUtUcnFYUjZxYVNKak96bnlVOHFZWk9yS0U3ZlhFSnZ2dVpKN1hxMjgrMmwx?=
 =?utf-8?B?UXJoNm1EMWlnelhOR05CRXNUWEZlelBGVllTd3FseTR1R3R6YTg1UEFvK0NS?=
 =?utf-8?B?cjYzUndRVWhjbUVjMUpZNi9CZHZkQU9qZHYzb2RZK2sxQzNsL0habmJybWt5?=
 =?utf-8?B?Y2hVZFQ4TmdqMVF6elpOdDB1ZmNFZWV1QW1ybjV6Q2N5TjNuSGUrVFpoeTgr?=
 =?utf-8?B?WG13cVhRMWxuZ2s4R0FqZ1VOelJsS2lYMDA1dERwcTdVOHJ4RGI4M1A0Y2Y1?=
 =?utf-8?B?dG1INU5Td1FIZ3lDSEowSVJURXdXT2twUENwMFhMRHpXUFNwS2NaMzQ5RVMz?=
 =?utf-8?B?V2FCNk5hU0RHdlJkQUtVOVRnRUJzU2t2WnNWYUQ0K25wamc3RVZKcEFoY3dW?=
 =?utf-8?B?NFdEZC9RaWI4ZEtwc3JWUGhGRFA3aUZxMWhZZDh1enhNMlhXazFpQ1VFa1Jy?=
 =?utf-8?B?TTVqNlRwTTZkSlV5eFZTT2I3cktoZytOSmRhUUdTekwvb1ZIeG5rVzR0eC9v?=
 =?utf-8?B?SG1HSWE3d2I1T3kreTZOVm5GRVJTZ1ZuZTJ5REp4dmxGbElaN1lZa2pHZXNa?=
 =?utf-8?B?ZnNKbG9xY0xHSTRCSmhPQUhLS3JBOFUvN0lNVWx1VW1iQk9KL2xCU00yV01z?=
 =?utf-8?B?NnVyV3phN0s5VDd1S1MyYW9CcTFTck5Yankya3FwMktVdFlwZEhlL2ZWUlpZ?=
 =?utf-8?B?dGE2YzBTY25hMXVGZkpWZDF6TkxEQ1F3Rnc5ZEcxWDR0dTVOY1ZJMjNIMy9i?=
 =?utf-8?B?R1FSRVBKUXo5L3J2em9WQld0TFIzTlBBcGExQkxFaEpkUGdGRDB6UjBuNUhn?=
 =?utf-8?B?ZUpJMG9ORGNYdk5PZHpHaE8xbmRxWlVsMU5JODg2NGJqdmRNalVJQ0lJRVV6?=
 =?utf-8?B?MWpKRndHRnNsV2VXdCtqcG1SZFFSNkhmMzMyQjg3ZkU4ZXI3VTdSbmUvenRQ?=
 =?utf-8?B?SjF2bkhtU0dURnRQOFNmcDFBTmV3cXVpWE9XcXdMUi9Fa1RSVFhQdS9vYjhX?=
 =?utf-8?B?VStWSWk2cWF6ZFQ0WnU3ekFrQitYMy93QVlwSnRlekx1OFVlSm9WYnVmM01Y?=
 =?utf-8?Q?firDsYeKs5wzslrM/HxsE+ZLPMjSJ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXZOUHM5c0RVZG9sR3lsRFBCM2hkc1U2WEdEOHpwNWNKS0VBZGRGRTZKVGpD?=
 =?utf-8?B?MUc1UVRTWTRLdDlQRTB0aW5UcGtwN1BBeS9VcmdvRGNyNzVISEhnUVFaYnda?=
 =?utf-8?B?aHdyNFRLSGhoaXZmc2ZVeG1sL3g1bHRQT09yWDQwV3NPaEZiSStpekgySlkw?=
 =?utf-8?B?TDZ3dE9oUVd2cGRHNjhqb3lHRnVEakYycDhYQm5sc3FIZ2VZZFEvSXFKN0Jj?=
 =?utf-8?B?MTkvNXhmVEdPUUsxRmZzYzd2YUVaU3paNFhVSy90OVgxeDJOdVN5ZExlRUZv?=
 =?utf-8?B?aWZ6N1F3ckhOUlcvZ2FTZHFFNzNpZ28vbzZ4cGYzaTA5Vm1yMUIrakZUbC8w?=
 =?utf-8?B?ZjM4MkhsdzJxWGorSnNuRHptM1VCS1pQVC8ycnJRRVcyd1dXcEV4c2l0UXhW?=
 =?utf-8?B?YWtEVnFUblhHd1AydVJyZmJHamtkS2YvQU15dkNkRi9nMzhQRERLVUZFT1Bu?=
 =?utf-8?B?M2lWV0p6eW5BYmlRU1VpMjlqUks1Sm1XNkpaUiswQjJNdEV0dnpRSUUvWFVZ?=
 =?utf-8?B?OHBiSkVIaGZiWGliQXhrWGFPdVIwb2R4UDErZGRxT21hN2pyUkRqRkt1SlhI?=
 =?utf-8?B?YTNQSGIyc2xxcjBwZDJ6amhRRUp0OTZpK1J4TW14N3M5bTQzYUJHWjYxQUl0?=
 =?utf-8?B?MVlWT1EycHViWGwvV3BYN1ZDOTJ6WWlCMTUySVdsYnVybThOK1VJOE1aVEFy?=
 =?utf-8?B?REEzMk92L0FkZ1ZZdGhpUk9wZldiM2oxa2VXWTBmdnB0Vk8welBnZk9ZVDVZ?=
 =?utf-8?B?WkcwQ3RiTTYxQUNocDBibEFWbG9zcURuV3U4ck8yUFpvY05VeFA1QlJ0NitL?=
 =?utf-8?B?LzZDRURmT2NlaE9oTkhjZ3RCMTlSbXUzbWZwL2RnbWtQbHpxcnEreHRDeHJi?=
 =?utf-8?B?YWVTZFdUZUlUVm5DMUtiKzc0SnJQNm91N1BVeUROL0VnZWpCRjR1UzFZVG9q?=
 =?utf-8?B?S04zZm1SS3p4V29oaVhpRHZqZVp1anlNTzRsbDVmVDluanRQZVUvTEh2Nytx?=
 =?utf-8?B?VXl3WUFvOVJCN1BtZkJIYWllQ0FTLzJVUmo4Nmdlc1lKekkxU0F4d0ovbVdS?=
 =?utf-8?B?WmlZd2ViMGRmRDFDZ1VTQTN4eWpzTTE2RHpyMDZ6QXlMQnRXMG12ZlgwQlNz?=
 =?utf-8?B?T3F2TW5BNk1sMmVBYkozVHNDaHlSZ0V3ZEJPRnY4WXlWam44ZDJmOGJpRCtL?=
 =?utf-8?B?VXB6R1NIL1Nxc1Fmbloxc0lwL012YlcxOWRaUU85S01sYWV0R09QU0gzdStz?=
 =?utf-8?B?R3hEbVF1aVdqb20xZ1BFMW93aU1PeG15MXpRYWJWdVZVNXU4WFcyb0tVVmlr?=
 =?utf-8?B?R1hrb1pqUjd2SEdKY29ISmRmQmxsZVFucit2VjRzUlhOZU1BSTZCMTJMbDlh?=
 =?utf-8?B?eHV1dUdrRDFNU3ZrMWV3NGlWTnFLRHNFTHJPMUNyWG00RGlwc05NM3VvanFD?=
 =?utf-8?B?RkdYQ1BXSzVVOGVlaEZMY0ppSUZwYTY5Q05laXZVMS9mM1FjeTFiTWJZRGJi?=
 =?utf-8?B?TXdReXhLTFJuWWM4eFk2RUh3K3BUZE5ra2YzcEpTZkJwZVVubEliSnAwWkVz?=
 =?utf-8?B?TEJyT1E4bnRPbW1kRHNlQUhLUGw2WXVERk0vcExxcUgrLzI4bkQ3RFpoLzZk?=
 =?utf-8?B?U2tXOGJUZG9YbWFpOS9KbmVVd3Exb2NEazA5TVdPU0ZsWWhLMHlIaGJXQmcr?=
 =?utf-8?B?bEl6UFdFWlR3NDlVekdsMVllUnJmbVlPYm9ZYUM3Tk9MM1AxU1QxaEtqOGVT?=
 =?utf-8?B?a2IvR0JZeU9wVVVLOGNMMG9DckNqWkx4c0RMZDJzZGl0cER6QVVGQ1pGUU5v?=
 =?utf-8?B?enhtY1A3TnBvakVJSjlscElFVWdPQVFQNTAzWGEzc3l3c2xpRFljODlaVEMr?=
 =?utf-8?B?cC8rVmZjTjJvSHo1VmpIUFNMd0ZFeUdiY29SbDNRTDJYYWYwMkNsOW9XMWVQ?=
 =?utf-8?B?aFovcUg3WGJ0QUI2dXpVUE5iTGwxR1FvSG95d0Z6dWFYRHVFZ3AyQzRVdU1o?=
 =?utf-8?B?cXplcHl1ZmR5enpZd1NiQ0VFL1VJeWxBZUJLSDBFNnlzR1NtV29BZ3E0czhF?=
 =?utf-8?B?b3dvcGo1QUp2R051VGFHMUZlZWpsbGgxbXpNblJJTHRSNlVwN25OaVJYT3U0?=
 =?utf-8?Q?hHGpDYNWcZkWnsbIsuup2q61v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ef4903-2761-4aa2-feb2-08de2cab933c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 05:20:55.8568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5I9veFHNudpbEUm2M5geWyw5asKyW4FeF0gxoFmunB6JCRQzjjLavZw1tQGebTEyX+jjLSQy55KxJ6V49z9Ryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9645

On 11/13/2025 8:50 AM, Ian Rogers wrote:
> Metrics use the amd_l3 PMU for access/miss/hit information.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/amd_metrics.py | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
> index 1592d7db2ac7..d748b5c1d791 100755
> --- a/tools/perf/pmu-events/amd_metrics.py
> +++ b/tools/perf/pmu-events/amd_metrics.py
> @@ -479,6 +479,24 @@ def Rapl() -> MetricGroup:
>                         description="Processor socket power consumption estimates")
>  
>  
> +def UncoreL3():
> +    acc = Event("l3_lookup_state.all_coherent_accesses_to_l3",
> +                "l3_lookup_state.all_l3_req_typs")
> +    miss = Event("l3_lookup_state.l3_miss",
> +                 "l3_comb_clstr_state.request_miss")
> +    acc = max(acc, miss)
> +    hits = acc - miss
> +
> +    return MetricGroup("lpm_l3", [
> +        Metric("lpm_l3_accesses", "L3 victim cache accesses",
> +               d_ratio(acc, interval_sec), "accesses/sec"),
> +        Metric("lpm_l3_hits", "L3 victim cache hit rate",
> +               d_ratio(hits, acc), "100%"),
> +        Metric("lpm_l3_miss", "L3 victim cache miss rate", d_ratio(miss, acc),
> +               "100%"),
> +    ], description="L3 cache breakdown per CCX")
> +
> +
>  def main() -> None:
>      global _args
>      global _zen_model
> @@ -515,6 +533,7 @@ def main() -> None:
>          AmdUpc(),
>          Idle(),
>          Rapl(),
> +        UncoreL3(),
>      ])
>  
>      if _args.metricgroups:

Would it be possible to include the L3 read miss latency metric here?

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
