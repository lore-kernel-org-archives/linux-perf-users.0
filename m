Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013058.outbound.protection.outlook.com [40.93.196.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5DB314A98;
	Wed, 14 Oct 2026 05:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791955032; cv=fail; b=rhu1E6Z1Ftn4zaKjHJzAlRFp5cjtyDKYa8pOQRW9u83tB0dO/qDFAfS/w4faxKwAmObZdaSCWGsL/tSIe8QlvBTZ2ZKXYa7/nT5gmDN+IBRziKIMNK7yEUUdiXVBZxzr6uT3XTobipyAQLXbYhc8RqcMhv5HygFb0QkYh7jQ/mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791955032; c=relaxed/simple;
	bh=pGC8l6UwXQyL710Aj1zdxUhwS9Db8gY8iCRkBLbmmEQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t3Os7SEaDkvcE9PeqPPEtsoSsPiX6OvHYmos3YDrdur+bTn9tnxyYRx0loHhlkIksGljPA1xdbloBAJCLPuG20gRUFJjDTBSX1vWoKw0Ur+6aSZlNqmD2cYgdU2a7YiV8D/jfxWZ2p6k7mhAgI+3aff9ZEyUwDRiCKsmWjohu3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pT/E3F/C; arc=fail smtp.client-ip=40.93.196.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pT/E3F/C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXxzu366kJ+ydn09YPk6Eiiy0mBnviTwsLQIXVlaAANVPPO+btVz0ib8+AkncwuAjyDPbxNK6HaCvJ4VVoLxcTIrSox10+oJ/ip2hrfYZ/9l2onebU4YO9DgoHY1n9XuKprx3djIbawga0bdglAB3MFIq+f74v8vWd15e6ceGWB6dI0M5ozmEQI4jddRtZdvyeOeqJd8EoJqBFLewqCyZuym3AXfYy9PG29phU+EacRa8Vl03ug1liCQx8yS3F+PbjwYcIMTtsQCRQisU5AiTW/XHZOBqK2uW7r1R3YKiRLrpOzCZsnKSs8oFCMq3xH4o1L2oLqDdfogUqBu2CLz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1guuEWic3BAShyUE71dhznqZaE2TdYxoVWqT1cWl5U=;
 b=pmR3QrTHupFhwB0vjlgClGmHBUYQ64Q2af2zp4qc+6fZhBJJzRWsvbivlgTXWVcCrKrZ2TH0YmSKEQVj/6//cWhiQzP74GZmTT15lEDBc50Chppfznf6aK37ZS0z71k2MGWWugAwfAbQTPblGVlZfvnNQCHjlyZTGyjzZGffGl3o0g/FXK3yJGiRn7/0iDX8/rsTCfopHz/9a/3NzoVunCFssSGu6prJq8pPVXmA260n9gz0h6kTWkzUPkJ7bK3w3A+I/N2NkuvdkZxcoMddkbm2ERZEmnz6rXrsXKk3YdBMVBKG9PCkB7FCW4ehfRXHt66vDbC3+k+TfMEhVcSZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1guuEWic3BAShyUE71dhznqZaE2TdYxoVWqT1cWl5U=;
 b=pT/E3F/CF+dMTcOoiTXBUdvHeUO7heDuP2R0fBCnRNNO9qYwafR3uiFaSkNqz40kzZD+prHGYhqjfPu+S9JdoqOM7SCIxH6s8Ts0x4RU7NOtZAa8jQ5Hcx+xgmjV03by4AsH/HEd+cYvldRBWo0zL074x0RX+JrLA1WXFRnPkC8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Wed, 14 Oct
 2026 05:17:07 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 05:17:07 +0000
Message-ID: <4410d7c1-d8ae-40d4-a3ea-8561a79dd6c8@amd.com>
Date: Wed, 14 Oct 2026 10:46:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/rapl: Fix use-after-free on rapl_pmus_core on
 AMD/Hygon
To: Jayapal Ashwin Nair <jayapalashwin.nair@amd.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, Thomas Gleixner <tglx@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>
References: <20261013095051.24777-1-jayapalashwin.nair@amd.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20261013095051.24777-1-jayapalashwin.nair@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::7) To MN0PR12MB5713.namprd12.prod.outlook.com
 (2603:10b6:208:370::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f88199a-855a-4ee0-2b11-08df29b2639d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	EsmmxPr7SpZNfTyHFywiVMQsVxXjahRHWOCR2aI0qVWZOY1K9zWl0oqD90n9Aw5UiFnygKHdrHh1GJWooySD0BTLvghxsUy/iJsR4FdxkK71BsyewnL1O8JpwQ/IkgfVQUmW3DZOHx3v9lBa6uxZSetbf6nso5mi5h9Mdymr+ajE7TsbQtO6QOwbDee06lVO1rbFT6kmho5uuy9ClqpCzgFHlGkmy9q9mIop620B/7lDxeQEMIok4a0P+RL9CnKVunSIno/AkNBZsBdSrJKvu/MCb2iKMWlY36y04kvHhjdTPlzRJzkNEm+W8uTb2IUR4moN+xZM7ULat6ce+6nnLqy5zVJOu2ASEgSEB/AYCosJuVSpzEz0Qe1qPwNeJ1dXR3NmFdg90woPpG+vbEvMDQuCyIr4Y3xlwZkCX3C1F0Ll7uCW7pAgjzqHbil7L1h5atOLzHyl0v/stjk34Durz3tWlZ2jnbqlQlCzk0yHFqQcoe4Iv4qgECTwt99ma68RJbctOBJIR9GGl/4Dzv+1s53vcvWVQCROHMXcKRDAyx/uXofGYS1xVj12/owvZe98HpPdoXfk6cOBk07eS1yWsBO1kx9rLYs2Oo06RyZKw80ib9WTiMn7x1iJ0DAw+E1poyCc0EKG92bw5eGa0rbFZmlbdpcVTI5O/+i5FquDnzc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDJ0RVErcVVSQTU3K0NsRFBaenJ4L2lhbngwWVJzcmR4N29JcnBGUzAyRk1Y?=
 =?utf-8?B?ZStBY3NiOWVvbkhYVys3N1V0eGI3R0p3U0VmVzd6RnRtOGdYZ0FoUS9kS3ow?=
 =?utf-8?B?MFNUSUk2L0xSRncwYWhNeVlFdmQ5c1RUb1BjYW1OT3ZFY3hqYVhGOUJWWWdk?=
 =?utf-8?B?MXlvTDNBbUV3V0dnK1oybktwM1dGYjRWNkpoN2F5TlNhTkFpMjY5ejZxVG5D?=
 =?utf-8?B?VHovTTVkTjMzVGsrMG4wWEREd010d2p1VjhKb3JlVkVHazc4SVpHSmZPWEQ1?=
 =?utf-8?B?dUc2UjYvc1BUd3gxMjdnZTBRa20vYTNsRGxHVzJpbWtHWFA0VGg5b2h2TEU3?=
 =?utf-8?B?QjVwMGpySGtrdWtIcjRRYjlGVCtXa3pFNFdWOXliMTNPMzlLRTlZVlZSaDJT?=
 =?utf-8?B?ckZIdmE2L0pTQXJUNWxVbmpRRml5Mks5NXczY3ZYUU5Od1lUcTg2YWdNYkdp?=
 =?utf-8?B?Mm9CNWsrRHJ2SkFBNDREazNyRnpjRE5udm9ydzIzWVhuWTJBWVBKSUhweThr?=
 =?utf-8?B?YWZ1NkVuYjVLUWY3NXJqUXE3aDAwLzRXR1ZSOWhVdWxJNlFjVEhveld3N09o?=
 =?utf-8?B?RWxJTllYaGxZSzdzYm1kVXdPa2Q0Vmp3RVkxemE3VjhIdzRKTnkrQTU4eUUv?=
 =?utf-8?B?dGVCQmswQ0ZEV2Q3emdjLzZPTVUwQkRmKzN0aExUSWtqSzNDVjlLSEdURk9i?=
 =?utf-8?B?UFk4VHJXNmhlei9XZzdvWXdrckpYRXQ5cXlzMVl5cHJDd1pIYjNENUMrbWJ4?=
 =?utf-8?B?Y21SMjVUSGQ1VWwwaDJDcVhMZnpaQkJZVGd4QkdRVzlvVnlsdkFFZTd0TVpN?=
 =?utf-8?B?VkxoL0Q1alpSbHcyNzFscWlYaEtHcEhTRFpablExd3lJVTR5cmFYM2hjcUEw?=
 =?utf-8?B?c0R3Q1ZDa056WFFNWi82bmllanBkbmRzS1ZqUXkyNXZVcFJsakh1K3JORW40?=
 =?utf-8?B?aFMxdGMxWDRSTzFmQTduOXgyWXplZmthc3puczJjd3FLa0VEcXRGQVJibGU0?=
 =?utf-8?B?a21IMG4vVXZjTDZsVlIvUm05VnNTcTZyL2hjUExKVEptdStzQUlHU0JqaThr?=
 =?utf-8?B?eUQ4T3ZDTm5sVzZyQlJ2aTN6Mmd0Y3Z2d2Z6VEdpQm00U2kwU3lLYTdONktK?=
 =?utf-8?B?SDFyWFFSUkdjSWh5TTUwaTY3UU9HODYyL1ArREM0aitCcjlyY3pmUnB2elFO?=
 =?utf-8?B?V1k3SEE3VHhZdWVObkRlKzRsTW5tOW5nbnlLcU5HUE1qRjVQaFlVQTRMUTlK?=
 =?utf-8?B?YmZaR2dxdEU2QXBsT1NDQlpaUTY1Z1RrRlVCK1pPMEJMbFJIWWJRUUNYRita?=
 =?utf-8?B?WEV1Vkc1SzQxU3BxMGNMcUlSUVNiWUFZWHNHeGxsVENXcFY1MTBHeXV4N2kv?=
 =?utf-8?B?bklkdlROY1dWeXZzQ05HY24zcUIxbnNQTXZMeHNZMGkvbi8zYURNczBpWWZF?=
 =?utf-8?B?MjRFV3F4clFsOGJ3RnREK0VoekFZS3A4OUZzanJvOHJRMVV3RkVGM3BCaTNB?=
 =?utf-8?B?dWQwVDROam9HZzJOV2sxL2U4YU1haFVEUjd3VVMzWmYxd1FzY2h4bzZsR1dC?=
 =?utf-8?B?U0hPbUwyeUZoZGdzOERoRGlLK1M1RXJTVlFGOHZTbDlONUQ0YTFFeG5MVmhT?=
 =?utf-8?B?UHZIN1JmZUJvVzhHanFYWlRrL1lWYnBMTm5ZRjNhM21aendGcUE4dkI1TzZJ?=
 =?utf-8?B?U1BVZUZZRHhteUxFY0tTV29zWVpRNngrTjE4ZVVWOVhCQ3IvUVQzK2ZHWWpL?=
 =?utf-8?B?eDcxZm93THJJT2JrdjU4ZEFvemxBOEpXSU5FcHJEL1EyUEJiMFJQdHVHaVhh?=
 =?utf-8?B?ajEzYkRhMHJGbHhxWDdFTldWL0JnSGFseTBDRHo0eGQ2U0JwWWxCUy94Ui9n?=
 =?utf-8?B?L3Qrc2h2ODl6MHJRRTM4c2N5V2FOS0liN0NkT3R6a21GSGsvRnh1bHcyZnd4?=
 =?utf-8?B?UVYrZEpQTzRkVWQ1R3FLUEN4SUJxblhkQVFSSEtKWCt1bFRDOW5XMXlkVGxo?=
 =?utf-8?B?Q1hXMzJwUEJrd1ZiaklHT0xYdCtDRjJDb3NpSjd0bk4veE9IOXZXeHZ5MzQ2?=
 =?utf-8?B?bVovOWQyM2tvcmpVV0JtT1dpeXVTMVBJanJObU5RRzRsT285elc1QWVrcWxD?=
 =?utf-8?B?NVQvZi9FZWFHTG1aMFpEZW5mU0dQSHloTFovRzZkdytmdkhuZFlpRXdNY1pj?=
 =?utf-8?B?WVNQNFFTK0xrSmFKR2UwNjlzSld2Slh2RWtWVHlQVEw5dXNuUFRJU09SVldt?=
 =?utf-8?B?SkY4ZDUwWC9ua3B1TkVWU0l0Y0J6Sk1FbGtEcE55K2dWWVN3NmIzSU03VTFL?=
 =?utf-8?Q?9i2XZ61Y/slh8rzgcZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f88199a-855a-4ee0-2b11-08df29b2639d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 05:17:07.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPkVv0NF0CI9fFx29Cg6BCOXkPDx2Et7HIhuoBNqetdn+yP3wpI1uVmZKfC1fTJgsbPM40pEMqluOdgKyv3UgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713

On 13-10-2026 15:20, Jayapal Ashwin Nair wrote:
> The global rapl_pmus_core pointer can be used after it has been freed in
> two ways:
> 
> 1) init_rapl_pmus() stores the newly allocated rapl_pmus in
>    *rapl_pmus_ptr before calling init_rapl_pmu(). If init_rapl_pmu()
>    fails, rapl_pmus is freed but *rapl_pmus_ptr is not cleared, leaving
>    rapl_pmus_core pointing to freed memory. rapl_pmu_init() then jumps
>    to core_init_failed, where rapl_advertise() dereferences it.
> 
> 2) If perf_pmu_register() fails for the power_core PMU,
>    cleanup_rapl_pmus() frees rapl_pmus_core, but the pointer is not
>    cleared. rapl_advertise() then dereferences the stale pointer in the
>    same way as in 1).
> 
> In both cases, rmmod can result in use-after-free and a double free.
> 
> Fix this by setting rapl_pmus_core to NULL on both failure paths.
> 
> Fixes: b4943b8bfc41 ("perf/x86/rapl: Add core energy counter support for AMD CPUs")
> Signed-off-by: Jayapal Ashwin Nair <jayapalashwin.nair@amd.com>
> ---
>  arch/x86/events/rapl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 8ed03c32f560..b67986c58146 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -763,8 +763,10 @@ static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_
>  	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
>  
>  	ret = init_rapl_pmu(rapl_pmus);
> -	if (ret)
> +	if (ret) {
> +		*rapl_pmus_ptr = NULL;
>  		kfree(rapl_pmus);
> +	}
>  
>  	return ret;
>  }
> @@ -939,6 +941,7 @@ static int __init rapl_pmu_init(void)
>  		if (ret) {
>  			pr_warn("power-core PMU registration failed (%d)\n", ret);
>  			cleanup_rapl_pmus(rapl_pmus_core);
> +			rapl_pmus_core = NULL;
>  		}
>  	}
>  

Reviewed-by: Sandipan Das <sandipan.das@amd.com>

