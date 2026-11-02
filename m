Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.130
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793646558;
	b=zBw1w4dg9aMohN69L4auyZSbzMF9J9nSUGddRm+loDnpzKzBD5sjljJHg5gi2oofeKUJ
	 p80XGamh7nFuqU5wPDjAbEgw/aD+MwqmfHu+fZvexr6YfLaZ4xfmrSbJnUjf0aqLkkBrz
	 1/3VzjGRQFz93H3vDkFi2mBEYPQNME7uJWmK8Iy7uQwRkYU3j0WGp2MM+AiXmQMwvKM1X
	 9y5LaL7uQa71DbJFwnNPzh/bSO9p8+TZ1H1FpSeYSovHoMdtKC4rM2HIgcAnOa4V4nO06
	 m2fgsGjqm9ozPegoGwK/X+Zyr5oR++d2Oe5NiozAuToaAulab2mpKayOhmP9J/zNdmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646558;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:cc:
	 Subject:In-Reply-To:Message-ID:References:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=4yVDYyuY2UwaKBaMt1bRpLvG5otTBVNZuNh/tmf8OHY=;
	b=hVWGeVczrcTDSUvZdXaftaXFLJcOprO2ZvxKYSKRrsWS6g9T8j7Cf61ZCT7tkl0SdIVa
	 YmsUM7T30g50N/83n8tlpGog9mmQ9AYBiefKnlzdoE+XswahPwHlKCYjD/Mh+rxC0uiFE
	 dYY7pvHCuqGVrJrZjKG2p8q96qmSE4QFTi7zBBWZ8SdR29n5c5tk6aDqMgBctvwSUcxEf
	 5Si3lFeVcI0+0zBYU5JvFdiPl4WRslot2d5Iq657JQWa5wQtWlq2MN0ZWelH87Bq81BDO
	 QijQqcy4IU3GPYRCId0wyPQLrCz2cB50tEpVV+r9qggxOKdvbSlQdznVR8aYO4o/U0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=os.amperecomputing.com;
	spf=pass smtp.mailfrom=os.amperecomputing.com;
	dkim=pass header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.a=rsa-sha256 header.s=selector2 header.b=uVT+OZkR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.130
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022130.outbound.protection.outlook.com [40.107.209.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11DA606A324
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 19:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B11DA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.a=rsa-sha256 header.s=selector2 header.b=uVT+OZkR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7624RUb7HjM/ICuKRcyL7Oq4C6fO+4FiyILxQfM6xj1hlQOUoWUzz1PuwWQzDr87/8VWmRfDM3bPWwk39m6jp6t1dFUsi6vppEt0OgvnHAUck96wgyZAvw689yEFlbThNlrxHe0bQx7sjBu6+2wECaryqShxKWeJrMU8oJGhluboXLKnKH8s5SBOFXMUQCflByNK/FwuTJJ4AbQ4ryt3FMTEwWPaNm46jU/TprIaB3I1ibai0CN0hw2eo60CEWh8Tb+yzizZYocWPKAoeDR3HEjsT0ZXTmQy41IRqfD0G9x5sAPzD5zpBxJjVlROcPtsWnZubXpbEkvCwgM9GYW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yVDYyuY2UwaKBaMt1bRpLvG5otTBVNZuNh/tmf8OHY=;
 b=GA0tTLsO46hHDQ3UwpR97QYetbw/opW9q6hnSimx+13SRtB/0Rq3aiYTkNZzLNLiarZlX+397qPisnw+mnOhGQwPloraC7EyIRwh8rf7K1+WwNHm+rCBh2uHbE7AqUeY5Br1hpRMCJ2IlOEB14FDSUbjhF5/1VJeLTArMz5pdqfI5NUNv3dCByYPj9gB6Edv6OhjRh7bPcdF4BnaK2NeBOkZTvpCq57fQ862aFStmgJMCaa1z1zXjjG4jo/diHyCMmNqpx8GiP9oEJ6JbUmW8cO3h0zjT7GEJBKIfYNNClMyMz/u+5oCQEuOQZu2Kd5T6vmgC1B9st+9gdm5z6HLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yVDYyuY2UwaKBaMt1bRpLvG5otTBVNZuNh/tmf8OHY=;
 b=uVT+OZkRLtgOoWH8iUb+5a68yWx4oeKHkOI7S/7B/pKx79FLCDLiIriuGT5qBp/skknqxBCS6hpRnr79Ng1W8pEH0lZ69za4n/ULPEANkArAthOvZtHg2zcoW2zgWfM6CnewQrVutg6N+WmxWcZ7cu5AwdqUSrUAiJiEtE7cvYE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH3PR01MB488663.prod.exchangelabs.com (2603:10b6:610:34b::13)
 by CY2PR01MB808244.prod.exchangelabs.com (2603:10b6:930:112::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 19:09:14 +0000
Received: from CH3PR01MB488663.prod.exchangelabs.com
 ([fe80::117d:9e02:c9e7:5973]) by CH3PR01MB488663.prod.exchangelabs.com
 ([fe80::117d:9e02:c9e7:5973%6]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 19:09:14 +0000
Date: Mon, 2 Nov 2026 11:09:11 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: TAKANO Mitsuhiro <takano32@gmail.com>
cc: Ian Rogers <irogers@google.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf vendor events arm64 AmpereOneX: Drop stale
 BPU_FLUSH_MEM_FAULT entry
In-Reply-To: <179333866449.669133.15101451727175644059@gmail.com>
Message-ID: <42801873-8908-07a6-aed1-c7076c689e8e@os.amperecomputing.com>
References: <20261021224527.167637-1-takano32@gmail.com> <auEK6E-jX12Bi8u_@phoenix2> <CAP-5=fX+2eRGCHcU43sqU=gi9iKvxqyS6ipwRSnvFcap3D+QzQ@mail.gmail.com> <179333866449.669133.15101451727175644059@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MW4PR03CA0314.namprd03.prod.outlook.com
 (2603:10b6:303:dd::19) To CH3PR01MB488663.prod.exchangelabs.com
 (2603:10b6:610:34b::13)
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
X-MS-TrafficTypeDiagnostic: CH3PR01MB488663:EE_|CY2PR01MB808244:EE_
X-MS-Office365-Filtering-Correlation-Id: e3239731-5df8-441e-db04-08df3914c8d6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|55112099003|18002099003|22082099003|261102123227099003|56012099006|11063799006|5023799004|4143699003|261022113327099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	gZBX9nXBf8hon0h2DN8W+b+d/bjqMlaTX0y4JixJKk1DjVuvh7Qj7qPWeXWONboA9xXx12zlcqrw0nYBa6lhguTOqhHzms0YM9lj5fiRYvvZd47qFChbcFoBi4PAAs0JH0RfNZONjqYrklE5QX+jEab1Nb19R7URdgMCWcbma5kTY3B0GkoTzVFJBrH4An+0yi0S9iy4sQYheiP/Hch7FXGi86kcUxOtDlgBI5CjQGEXWvRpkx9wepdedlBE4Wrpxi10c2cp3vJ29bfKS6PFqmYybN+DaTFvHza83EueLvV/60r8ussIAIu+E69Ru+ntw0S29yWZZcD4sj+eoBwYs32+yBUcz+v6zt5SIm3GofeW/B+daVVAz3crg5zDr+wf7Jo3TTXWiy2Fh5eXXDxRW+JBQFf2NW6uqx2PS4E+J7jMpxPzQiOD3W+Q1RRIbdzRQqDtH6S6RnzG4LgaqcP3nNb2+cNmPP3s3tTfpowBofnnK3ZOQkbodkZEhRPamGcVI+jGzCgp9WEVKukGx6bzCPiybDa34r7KTkF+vL6NNfSfUNZX6Z71n22PBxRc1NxIuNx/x/O2XDB1EBkm/qwoNzYDFD6omwFJdC87Pj9djPwyT7e9Gl4AWKZJvg1sKKv7nAF142fOsM/cnBQnmw4crPvuU94v7xfwX/zCcco55UI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR01MB488663.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(55112099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(11063799006)(5023799004)(4143699003)(261022113327099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aQpxWVDFoVrKX01cuXXOjiNc4sPCUxxO7tdJY1TvFQR99EOJRTCBKlQuTCWw?=
 =?us-ascii?Q?X2S3wxEnV9THTNLFVwv3xWOgnvzlzuRGbN8q934F99n1RSfUU9k4NNG9+T8L?=
 =?us-ascii?Q?7dyJgf6HcAC8jp3MMBmFALUneC3udWRxYveGK3hP0pcnR+LeOTMNLT9LpmKp?=
 =?us-ascii?Q?bpo6RtRrwoo67ayWqBnNBcP8dZ21VfS/teFa1yHY2wI2qqKazaIPctFnY0Im?=
 =?us-ascii?Q?PDJNhY7jKqNTdbC7COul3bmwJWr3ECJcipb6tl3/oow1Sqs4XRMJOUIckkt8?=
 =?us-ascii?Q?5PTi35zhtpgQfgXVikGLrbXXKbrUB3fU0uLa0wSOrlVlFH4B6/DAaZlkTj1c?=
 =?us-ascii?Q?TBYP0Q7tRZhfADO7VAy7ir+ebUly5XfVZpTz693fRwP1mCJsja3ozgQcJAB1?=
 =?us-ascii?Q?hxZjH1aPnIPcwg2K8mpH+m4TSAWSq5vRuS1RZV/Ti1j0wNMHOawxjKXkW/DN?=
 =?us-ascii?Q?GIlwiCe2YyypF4fvmEEjnYpiAPzyVqEkrWuIgG4OxajSaeluQoS0ld5F/dw0?=
 =?us-ascii?Q?ilyqD1qmir+z3zfgcQ3c+nHfMu5U/64EuTqll0aGev0TzBpbNDKHAOjpyRRl?=
 =?us-ascii?Q?wHdb7yelFyBGU+1Qd5ukg+nOO/DZSXIYQac5X2Yggo5wdIfzj2ndaV0FFpr9?=
 =?us-ascii?Q?89cMhPzk1GifMqmzoQTqairF9EK1gz9OAQhKgcAphDisZ23VjT8pg6Y0TScg?=
 =?us-ascii?Q?EdcM0UKEqGhN3tfzgQu3dChM0QfeiFl9hMXFp2LysYYgyoWT4SNzisk96mcM?=
 =?us-ascii?Q?kv6bZ6FBT/H+UJnUXO7iwfpjIL7TUQb+oHs+3Nvrcg4m/HLeggkoNhcIp52r?=
 =?us-ascii?Q?xvOFgP/PtHBprb2j0yfF/an9kZmRshgSEzUT3TBxmvxeKN97sSrSvRZpfnj/?=
 =?us-ascii?Q?WbDHZY6tcF8F3Gk0sTulxFkCWOHVmpKXTdgaj2AUZlSOCtVkh0m1ajA9SfA3?=
 =?us-ascii?Q?2ehjh49xhcJ+fP8H36N/fQRC0kmJI94EfRIBXeTOIICfME0fQg9b/nFWpr6y?=
 =?us-ascii?Q?qitV+SEsvzGHNO1N4bc2WhGvHXdtHJ6YjgyQsStUaEts6VTrLhBCi1pDKSo7?=
 =?us-ascii?Q?NuwNgcL7SY9rhpT6ZlUV9hyFMM9htVrIq/bezB7MwmQbpVuI6KAal8cXWZ0f?=
 =?us-ascii?Q?1Q0hRvcCmp1wlpBhak6ZJbZ0LgicYe7JV1KBkM0LFUKhnatR7nBHgLa7QpwZ?=
 =?us-ascii?Q?YBzzC8Sdcz04u9sVnSxFZs59MSI9xeWM+32AuYEd/CEAjxpwHDjUg+pt5Ley?=
 =?us-ascii?Q?s1xLWEPumS/dase2BCi2g/qNuiI0uSPZTm2Q4BuSTnSS8lrdLDnw0Ac/yz9u?=
 =?us-ascii?Q?FLA0VNoUlV+Bo8wZoEsVAEGYGY8nZkFxXXT9PIBfi/W9BEvumxtYdgClN5YT?=
 =?us-ascii?Q?QU24hU7UyZjKmoj4A6Ycs9R7SUOiaJg+VifqM58zBbdH1eXbWV6TFdgLfQRO?=
 =?us-ascii?Q?+Wj7D1QjIsZUlRjNr+6u8jVf9+R5sDQf5wvjERun6rPQEcajwwx77dpjrVHD?=
 =?us-ascii?Q?+du4n0hofFni2sqN0Z9ULDrUMUVBh9u+hgRy60XyfJZB1XMEEfUDll2v9DHh?=
 =?us-ascii?Q?aXVojZzW6zV5gsFSqm/WkRTgwZVjXICX96LIya55ArcZJVmEZnmP363UiBcX?=
 =?us-ascii?Q?R+tjbeG4jyWTz1hkNij7qO+umUZiv3750E7gli3DK81yNZqB5fKxmnKM0P5Y?=
 =?us-ascii?Q?ImaqpEGnc8pkOZsPM92z1pxlYfTq6ziE42SVVIcgCv7wgAFYF+lZ9z8yX0QR?=
 =?us-ascii?Q?u4N+4LiiojvVT3HMj/a+4GLtRSHiRBc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3239731-5df8-441e-db04-08df3914c8d6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR01MB488663.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 19:09:14.2207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fh9+ykU7Xvi6xrQTsC07oNB/GII+/IMLywwDgrZTk9Ew8l/WIMAaT/YdUiXtQCLJVHKi5Q9uniuoLqgn00/hgrOz8WdUZ/8hfDQtJpj47KjRWXM7ZWIxXXwIeeWzcGs8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY2PR01MB808244


Hi Mitsuhiro,

On Fri, 30 Oct 2026, TAKANO Mitsuhiro wrote:
> Hi Ian,
>
> Agreed, and v2 is in this thread: the entry stays and is marked
> deprecated, with the description worded the way the x86 tables word it,
> so perf list shows the counter once and a script that names
> BPU_FLUSH_MEM_FAULT keeps working.
>
> Ilkka, your Acked-by is on v2 as well, since you said either option was
> fine -- say so and I will drop it rather than have it look like you
> acked a diff you did not read.

You can add Acked-by to v2 as well if you just add the Deprecated line. I 
tested both the versions quickly and they work as expected.

Cheers, Ilkka

>
> On Arnaldo's jevents.py question: a general duplicate-EventCode check is
> not possible for the reasons you gave.  Across the 1463 raw EventCode
> entries under arch/arm64 this is the only duplicated code, so a check
> limited to those tables would flag this and nothing else in the tree
> today.  I can send that separately if it is thought worth having.
>
> Thanks,
> Mitsuhiro
>
>
