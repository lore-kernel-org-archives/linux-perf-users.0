Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020110.outbound.protection.outlook.com [52.101.195.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40CB2E6CB3
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785093867; cv=fail; b=mdLgg+x4/+qtGSBFWVEU7ucKBsBJXhBgw1SJ237zIMTFtwtSrXZb/PWyFlbBwLm0HJOUGBqaWQNhA8pvU6ja28ItJAf5rknxjWDLZLw4WBEbMR8NDARQSfMwU8YFCmCcuByieDaQkXH/eCLdZCgcTjuFncKSDS0xeWf3gB+H2Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785093867; c=relaxed/simple;
	bh=e7sT6Vxgghykq9/iysGZsJuoNWFraioYcxBJe2nzPOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FbaHiUfDi13Q3Zq2MneU/ZNtPt2FqHIlTWBLUmT2SZf4J5TqqP6SFW2rP+oX1DJQzeqDjY+iHnG6zG2O5MJYns0lFurDjm4GhEVVVJmY/9SaTumFFJxL2se/Vo9w1bEw86x1NKcQEO/+tvTWfffARXwbb7d0tV9+ZYIZ5PSnkrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brv6r0swAOCTGnlvsGdjnjJOwMHJ35AfZFj/RNv3bSIOqeALyg5Hcqv9iHU7MfiICaFQpvoARHUdmPH67EZCLDFzpOehdQNNQKmKyMGYZjI4yDakpAghqsCvHAHM79rZqUKYxcVXdQncn6RR8zvfzVl0BLKiqHJ7Xk44IifbiatylmK2iAuFEwKdQdGRCKhVvojRypx2qIJXNE81sBtIN5hSbOyGkmPepJrF1BEN2cWKmwTNueD1bEGjChS3tyaxOVuyZu6tB4hvek8XTVh7Y3fPfd/IZJ/TsqrneY68uZ/Zi5CY1rf1GvJlfaOcgd6mDJi3G1Xigcy4SJFs2I2y/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=4SX7SPx8Gm+R44yldwmZps07xGIR3SptmKrOTjhS6DA=;
 b=Q2V61It1j3LQHnS1Fb+S98CW2m6HH9rKnOupwVQedtkY80J/1aex8N0t/z73wkFsWSKu/OoNB2SM3CwrdtUpL87ChFhG4W11P3oCTMpqjyc5/Skvae4FU+UabSNsy9RUJ8X5TEH9YXGmc+wEkuJzsmzo3ck8H40XiJvvf6CDG7yTvdQCN0C0PfBgWBrqGp/RUxgUK7NTKb055ZDebLpp+pFRwkW8C+xgxyTSyfLl10WwBc6t+MuLJC4s1rzjn9/QKG1dtRLYXp1deTnNyqyUNefLs80whJxu07bCugI/c/Z8u3wW/q/eEQmzFqGmI0Os94Bbqm61PG111SNwx4QuLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6976.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 26 Jul
 2026 19:24:21 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 19:24:21 +0000
Date: Sun, 26 Jul 2026 15:24:17 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: irogers@google.com, namhyung@kernel.org, acme@kernel.org
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 2/3] perf sched latency: Auto-scale latency and
 runtime display units
Message-ID: <ko7asuqctrcz2c5agrcmslgm55t337upupbh4npqye5do34obj@o33cdhnlfa4c>
References: <20260726032533.712462-1-atomlin@atomlin.com>
 <20260726032533.712462-3-atomlin@atomlin.com>
 <20260726033343.6A31A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260726033343.6A31A1F000E9@smtp.kernel.org>
X-ClientProxiedBy: BN9PR03CA0714.namprd03.prod.outlook.com
 (2603:10b6:408:ef::29) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dd36db8-727d-4ab2-dbc8-08deeb4b7e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|4143699003|10067099003|56012099006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5v2OExoc4+T8QwyBzHtBZUYtzApJiwDNCTFn62lOWY2u7MdoCZhu07eychsajMw3bfMcJIfJe99Z7szZavMzqPHjEUwM8AtAd8J0WtNxEzp88DoVmGnsoK5SZ1gEKoJek672GkKCxhwjZcCCo4hWfF8zSwE9Px1P2fSfjtCDwZnI4SkIljVZjlysh5CcXc1c7BSppJiaQAi287OaJAK1hICFCyWwngcNYCrS4m+SsAHgeKIFY5dRUXGf9tx7czYmHMMW5Dku/kJpaGcz8Iwcucd+LfRRF6GaHhI0x9WxdRT1ATheypfAI6sNNBCx35c6TVt8UlHTLCosWgK5sampRCYcK6qYYy0IzwCsNcAGXCCoErcP4MPVFWTO2b/KsQqAbWRn5xRKL3qOgkI5NMTDZEysP0lsfhCe/wqkzzoHeexzQefL1pMm4i1QAaMkXwz1GxReTTji1OGpV9W08VPnslZwvurQhAVn/X7VtxVOfpqKZcZhZCL4/7upPhGHVIKNy0kd012C4kqxdmD3XRWmmS82yU8ucw0xGZ3NOO2/kzLZx0wn7kbYWM23qwzPJH4CV7Fm6ru+9zXV779M/BTjEkLwwDZm2XM1zwqE9FVPwaw6HUzcF/U8IjVfDx8Ci/pARWKdfc+X5q1qKl+DzGN4PYN1A/Lg+dIF+xqgzIc7TEY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(10067099003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1FySWcvNzdnMndFcE1hME5BZzlRcnZJWkxYd0ZISXdOK2JMVzVKQ2FFWFE3?=
 =?utf-8?B?a0lXbFFOREk1MWtRYVZVRkM4a1gvbzVLZ0l2Nlc0eEQ5ZVo4NGMrNDRXK1hV?=
 =?utf-8?B?Z1NmQ0ZhRWFZcTJOWnhLL2VmWGZORHdLM3JXaTNmcTRMckxwVnk4ZWVTZXIy?=
 =?utf-8?B?TlY5clFvSlBaRzd2Q1U0VUN0VjgrUzRZbjlDSzcxNVhCaXo0b3V3bUlYVnBW?=
 =?utf-8?B?Y0pCa3UyOENjNlF4LzZPVGhCV210OHNOY3lIRDQ1eS8vL2RtSkdpMlpQeVBs?=
 =?utf-8?B?RkMxYnh6OFhZUHh4NE0yWGZRUDdiaVlxcGY2dTNMN1NmbnBsak1XSGdGd2Q3?=
 =?utf-8?B?ckZQYnNDY2dseFdzUXVvOWF2RUxjeGQ4Z1J6VDJjSGt1SkRobDArMGVHdzdn?=
 =?utf-8?B?Z0huaXowT09ZSUl3d2ZhQTVYclZyNnNPSnovcldRbGpFSjU4UC9PVGJ5em5r?=
 =?utf-8?B?cWlkckNKdTdyK0tvSEt5UWR3RDZwdkZxREJXNThiNW9nQWJJZElUV2ZrWDBh?=
 =?utf-8?B?RGN1ZnVSZzEvRUtpSkpxUzVDMjAxU1V3T0Z1dmNIcE5jbnBodmxnQXk4YmJl?=
 =?utf-8?B?dEI0eE5FT3FMeVZQUGNuWkNPOFZjbzVHUDhha1hXcUVGcTJ6dzIyWC9lNVZZ?=
 =?utf-8?B?MDgza2pvMUl5aXp2L0E0TWtpUzhWc2dRWnhWMVhlVGd6NjFLd284K3ZrUmhS?=
 =?utf-8?B?Snl5RHpweFJadUFBWWM0OWtiSGJKNnpCd3NjbURjQ25TYjM3NTJuUGRpbjhj?=
 =?utf-8?B?S25lM0hQM3lIdlNCVjdaL0ZTTHJYSC93TTFMLzdrcXlEN1FBRm84bXZVV2hn?=
 =?utf-8?B?SnZQUUJ4U2RYeVJDSTYySzN0V3lFeStkY2lUWllQUlpYNUZwbXdQeE9hbFhD?=
 =?utf-8?B?WlRtbUQzamUzTENoN2IrU3A3dVZVaGJvUkhGRkxRSTNGSzB2dDJKT2ZPc1NL?=
 =?utf-8?B?OVpuUGJmNDhYbXJxYUVlZHFxTzJoUENuUDZacG9CRHN6WDlvRnkxNkluY3U5?=
 =?utf-8?B?N2tFWXAyK1FEallPdjk3Y053OENVRW5wVEpFczdMaERCSFlYSGFZSDFYbFcy?=
 =?utf-8?B?RjNtYk12aDRkcHMvL1EveS95dGQrOXJoWmJWN3hIQk54blRHeHk0NDcrWGFU?=
 =?utf-8?B?amhJZko5UjVkRmFtMkdsZnl2cHU3aVNoa09Rd1I3a3dxdzJ6UFdBM3c5aGVV?=
 =?utf-8?B?QkdYVTlXWmZvb01WUmlqemF3L0NwYThkVkNZVkNybytDTmlnUWcwRnBYNlFC?=
 =?utf-8?B?NmUySFAxREk5VnJqSkswV1dCR0FzQTZURXFMOXdKWUcxbHhMMUx6M0dUeFdo?=
 =?utf-8?B?VFMxcTREMld6MyttSXpNQUdxVTJzVGFYZjh2R3dKOVlwbkFjT2FwTGwzRVVC?=
 =?utf-8?B?MVpxSkt2WWFXRlJxL21NMnJRQkJFU0drWmFleDlKazJab0s2WnRsbXRNS0pX?=
 =?utf-8?B?ZFJHTUlzVzI0d09ReitDMFgzZ09hOUlIV3dhM3RRWU9DMWg2OUdZeTBGbzFM?=
 =?utf-8?B?bnR6WU54Tk9ITitYeVcyRjVEbGp0cjZpNDNXVzNOaTRPdFJyamV0ODd5N0xB?=
 =?utf-8?B?enNTdXVIQkgxY3FjYmoyTVFKOU4zTVg2YWF5cVZOZ1NoZFd1TXJjeHFMS0Nn?=
 =?utf-8?B?S0tiTVZHVnFEeWlLRjlZQmtwU2FIa3Nid2MxUGlqWlAyWVl5VnFjMnVSaHBB?=
 =?utf-8?B?bFUvdlM2dVpISWRzelBKNVBxT2VtY1BCVVVLdTYrcFVtdDJudDN6bTh3bnV6?=
 =?utf-8?B?emRrUlZ5RlVaTHB1VXp2cjZXbEFyUmR4M2tNcEwxN0N5SFFnVXp3TCsvc09h?=
 =?utf-8?B?a05lUHIxb1VvandFaXZZcVhyMjVZN25hdzZUUEJlclNZMmgrMUFKWFZYbGoz?=
 =?utf-8?B?NHRrUzlFcDl4dUlBRDJnTUlraGp0MnEwaUpTTHN3SVhJRXQrdDdVTHdubkJm?=
 =?utf-8?B?cmR3c2Q4Z3J0dEVNQi9KRGtBUndqVkhTa0JWWE03RTdPY2FCM2MvVWsxTXdC?=
 =?utf-8?B?c1E5OW01NGVEWTJPNjRqRW5ZTTZGOVBEUjF6WGZnWnF6M1Z0WWJWTlF0Yk5j?=
 =?utf-8?B?SHhtV05QUHZLRlA0K1hicW5SMUpuVk1rSDByekVGaUdJU3lxNkR2dXE2MWlJ?=
 =?utf-8?B?NWRDZlJzeUVRKzdtQ1hlZ2E2T1VnR3VMU2NzNklmKzd6QXpHWFJNZElZcjR0?=
 =?utf-8?B?VC9UM09RN3hRMTl3OXpUY2tBYTBBMzNMUHdoL29xLzdvNDFRSzZ0Zk9WaC9m?=
 =?utf-8?B?Rkp3Yit1NmtlQ0JuUFJ0cFVoZnliTkFoWVk5cG5uNGJIbW15MEs4cm1zSVpa?=
 =?utf-8?B?SHJtWU4wUmRlQTlteVl6NkhvLzlZYXlZWTV6YTd4YnJ0cEJPNE9hdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd36db8-727d-4ab2-dbc8-08deeb4b7e79
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 19:24:21.2925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMRpb5XX6Pq7TCOox67VRYyUdJ6TnfW7Xhkj9pmp1n76eWo5CTGu1YjmCG7EvYppt/PuQgWndkD+k6ocYkE8rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6976

On Sun, Jul 26, 2026 at 03:33:42AM +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index b3cf678573e0a..8c83dc423b571 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> [ ... ]
> > @@ -1430,14 +1443,17 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
> [ ... ]
> > -	printf("|%11.3f ms |%9" PRIu64 " | avg:%8.3f ms | max:%8.3f ms | max start: %12s s | max end: %12s s\n",
> > -	      (double)work_list->total_runtime / NSEC_PER_MSEC,
> > -		 work_list->nb_atoms, (double)avg / NSEC_PER_MSEC,
> > -		 (double)work_list->max_lat / NSEC_PER_MSEC,
> > -		 max_lat_start, max_lat_end);
> > +	printf("|%14s |%9" PRIu64 " | avg:%11s | max:%11s | max start: %12s s | max end: %12s s\n",
> > +	       runtime_lat,
> > +	       work_list->nb_atoms, avg_lat, max_lat,
> > +	       max_lat_start, max_lat_end);
> 
> [Severity: Low]
> Does this format change cause the data columns to misalign with the table
> headers during output?
> 
> The updated data row format specifiers " avg:%11s " and " max:%11s " expand
> to exactly 16 characters each (1 space, 4 chars for the prefix, and 11 chars
> for the string). 
> 
> In the old format, " avg:%8.3f ms " expanded to 17 characters, which
> perfectly matched the 17-character width of the corresponding table headers
> shown below.
> 
> [ ... ]
> > @@ -3612,7 +3629,7 @@ static int perf_sched__lat(struct perf_sched *sched)
> [ ... ]
> >  	printf("\n -------------------------------------------------------------------------------------------------------------------------------------------\n");
> > -	printf("  Task                  |   Runtime ms  |  Count   | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |\n");
> > +	printf("  Task                  |   Runtime     |  Count   | Avg delay       | Max delay       | Max delay start           | Max delay end          |\n");
> 
> Because the "Avg delay" and "Max delay" header columns are 17 characters
> wide (" Avg delay       " and " Max delay       "), shrinking the data row
> columns by 1 character each will shift the subsequent data columns leftward,
> breaking vertical alignment.

Hi Ian, Namhyung, Arnaldo,

This is a minor concern. Nevertheless, to remain consistent, I will address
it in v4.

Kind regards,
-- 
Aaron Tomlin
