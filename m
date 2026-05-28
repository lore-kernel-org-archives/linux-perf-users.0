Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D877734389C;
	Thu, 28 May 2026 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779927894; cv=fail; b=k7CSCA0U2NQs8VTh5z6QltYGV/sIerBq50VCICata/cblEjD7VeW+wrLCYLPH26H2Z2OCQpLeV3Yim9F1mPfd6nRxVQ73sST37rjyhFZGY+88zYcfjCTxbh4slAaHoRT2VrWRvUnedbEVuN8p/2qiz6FNR3OWRoHNboPMvriFt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779927894; c=relaxed/simple;
	bh=AKU9VTLFx06SmvwnPTuLFbxSKb/2J2sT5b/tWgp37to=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X6FEmGzL7Rm0CS6B98u617bRvGJWNncXEWbqcaxCib/IqAgB4DOQrYHYCMsTr1HzYInQritSXvRXICGmzAL7BNmwB/nNn68szEVnziihw/CZcK0P2VgSIsO12HqhtJHXV7eb4y3fWlqfA0C2LIu/HSIQN4go9+0k1zDxhfOONLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OTs7w+r7; arc=fail smtp.client-ip=52.101.61.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OTs7w+r7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snWYA+96dO2BYfookofvDiIBamFXKEKArz6wFcBz0yWLf+QVqbZPw3LyDSq4vNKTjUHMGKGcHmgE1x1OImQLf0ua0OCS9T7YwzZjDt/TysjCCi497nMpcCjMxSqqTES6whPsjUYBw+V2CY1bjDsuVcc2JLgfkmcIXuQ7JAvbvH4wyQyP+gQohsfv+Vzm7t7OW5z/6eMHyR8Xpe1uGW80bBPDaQxSqNCd7+zonP6VEXCac2EPS0NGkNUn+vfy1wyvvN838BwadxB1r9569J9/BorLduxCUFwUD6ugyQ999oy5ETB8rLGMUXOhTuuDxfLxR8yg7xetyPrnZLHe416feQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3eLLEG2ecmCuUPeJmDPay+YNAeZL6enLwbup2Bgfuc=;
 b=c8WaXBZz0PPIjsj08HYOx4+RMM68o0OU5TnxaEk1ijYOTvYhOyNejPus38ItCRvJlZMiryp9xll1hLjf+aG7ckjx+J2IO3oyXP0zQoncqGinea/Of8mKRpIW6crItFcu2j0wMQiSPrcO7oS4/BWlyBugsH1kxHkQQJZI5IWYDqevSJGOEZEQwF313C29FFIPtsONDzBZH7HwkgCxit1XbZfW5FjE/3UgTOVsvTN/6Mkkp1zXtLM648gU07O2gT6NcQZl9YEhPj0hZyrV5nAM7S1GytyYVWhqMgk69eVUB6AjS5Y+lpki9J8WaF+bAva6t6LbqFltpCF0Jcegr3T6ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3eLLEG2ecmCuUPeJmDPay+YNAeZL6enLwbup2Bgfuc=;
 b=OTs7w+r7teXuCZJ+uSitQrAXeMC+UW+zX305MWckf/p5HHtNyIjXQIkOqL1RSYgpvcK/uc6W83ry7/k4iscPOmecENcnjpGMtfefrzm8KFIC9hC+QA1UBbUk1SfnA8YLf21MroQXk5fQTdFJp9ihQy0aiCTwWIT0Ipw5fCdQSQI9Yuclz28U3xwPc4+7snnP5veWarSpDrJ6KlgleECWxqrEVeGdv66NidbJ1lDEsGB97/yp5/kSD/bbMdzYDxT6uoB/diyofll/BzQIHrhOBGspGrsQDJBhZoJaE8K+6puHZAKknM/sRPTLUs3G1UJMoA88p+5+dE8ymPZxhCB9Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Thu, 28 May 2026 00:24:39 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 00:24:39 +0000
Message-ID: <542aef46-583b-412e-bd1b-50cd77c76289@nvidia.com>
Date: Wed, 27 May 2026 17:24:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] complete perf_allow_* trio and use in drm/xe
To: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20260523013326.129491-1-jhubbard@nvidia.com>
 <20260523084056.GE3102624@noisy.programming.kicks-ass.net>
 <8871a158-7a68-4247-a09f-bb3d970d6dc2@nvidia.com>
 <87ecixv82m.wl-ashutosh.dixit@intel.com> <ahcQ9Ns5mjsnrbEa@intel.com>
 <20260527163014.GI3102624@noisy.programming.kicks-ass.net>
 <87a4tkv4oo.wl-ashutosh.dixit@intel.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <87a4tkv4oo.wl-ashutosh.dixit@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: feab57d8-cb2b-4913-aeb3-08debc4f8169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|56012099006|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	tDBmcipTBG8BwPEUjS+HMPtgX94bOaOwhjnOAOq3HbuyzpVjQryxKX9VOKuitDCorD9e9kYVwJW3aVZ3iz4xTrMWdSQtLIbUWEQ7lPWniHk5ggK1ng4oQlCB/wKGJvKQ3QJqDxmFOgR8Opk5w8jEOKxV37rFlVuAdLP2hqZHuqxhpTnbV+Ke4PQ+L//wU0IIF64ZC5fqqbwXBCKDupM0oz9/898Ngwf2oHm1XEw6Oxcdo0cmSeLKYEwu4i8Dr1t8fWytq/a4XqiolStMILTyuIvSkoh9Tgc1o6ZnM7QNTyQSrHuMwnN8idajOiKDWL8us3DqNfsEOCp0gCP6YWNqXHPVIsV/iAPTROCykogZiVV29Lfi6qtLVxd7cN5oaaI6M57e2+u0FU3TeKIhoIKQwXrd52nXFPCJKzMH5O/zY4slukDcUo8cB9thTO4sKIGBDICkldHnTBTbtvd9Pk3lAopMb+rWhLsVpkAVaH25sMyH0yo1rCZAhGLoflBpdt5RJP7+Q5rGiUn48wu4qlZSSx1L/T1khUFIoG0ME5rAfrytnRi89dACmK975IScYBr8tSUHP41VjrUsoz3d1FP4vvtMEqMJzRa854EhqNNMr8KDel3snFepwZB86hSX8iyhqtHWn3dEXBo2hiUauyttU1OiD4pHQFJ3vSnqGwMje4ZyfOpFeVIzMwEw4geljRuB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(56012099006)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MU5JZ3o5OXB4cjkrSHAwaFV2eTNCU0s1Q3dtcXR2MlNLdlpsYnhUaTF0N2JK?=
 =?utf-8?B?MGpCZEtDLzBEVGorempVZlhQd3NJUTJURVhGSU03dVh5Q1RqbE1McjdoaDl5?=
 =?utf-8?B?MzBXOTlXRGFqbXBOaUxwbVlTMkMxcFp5TEZaZGlZc1FlT3lPbW43bEpxaFA1?=
 =?utf-8?B?VDZmKzZzSGRsWjZmZ2Q4RlZwTmpHR3l0QWZVRHJVMG1vcDhSTlducTZEUWNU?=
 =?utf-8?B?ZTE0SFZrdEJhK3dNTkxuMldaY0U3THJtWlpqV3RhYU1sZVBHenRMQUFWYWtt?=
 =?utf-8?B?SVNVNUdxcEpSRmQvQURKM25SQkQyNkFQVnY2Umh4N1ZBY210eGc1UHJOT3FV?=
 =?utf-8?B?Wk42WTFYRjBQU3hmblIyd05PYVZGY2J4SHk1b0xMT1JGbE5iRFh0WDVFaHBR?=
 =?utf-8?B?SmZzVzhIN0F6Y243TDJuNndXS2YrWC93NlpwWDZRcmJjMmNXOWllL2hHb3ho?=
 =?utf-8?B?ZS9PUDlveTdoL3NPaEFtY2hueXdpdDgwMC9vdUpsZitSYWM0UHpJT1VST3RV?=
 =?utf-8?B?cEY3T0RETHJ4eHR1dDVNLzcwWTR3OEpzd3NTc3FvakU5WFllQ1FSeDdtN2E0?=
 =?utf-8?B?TS9mVkplenVTcHFDL2hEMjlvRy8reWRncEtubk1RdFEyNzk3TDFmN1lWNVU5?=
 =?utf-8?B?Y1U4aDNuRzZsYXlBY3dUcnRmV0ZwSFllMituT3VBTmJzdzcwV0J1UFdyazZs?=
 =?utf-8?B?TE5TNllYOEVWRGwrcW1naUhUaTRtdGg0ckVUYmhFZVBTMnRJTmRjbGdnTjI0?=
 =?utf-8?B?aldINEp3OU1KMWZRcEEwZzJXeVQ5eDZ0TXVKZVpHbElBOVhGSWdJZjBhNEp0?=
 =?utf-8?B?S1l0MUtEaVd2T2xVOEE3WG5xNW1XOGg2Q1VnalR3bHhHMkh1U0s1TlU1aklk?=
 =?utf-8?B?M2ZvT0VPRHdoTWN5azNDUmFvamFWam1ueXAzOWtSV0ZjdUNVU0dUbzNDbStE?=
 =?utf-8?B?WDVtaHNyakpYY2xTclp5RE41ckVlMVVUcHJRNkZmWGNSM1EzcGR1K1cxNnBG?=
 =?utf-8?B?L0V5Yytpc1FrS200VVZMbjBaNEg1TWNybVhFTTdsZVlqY3FSWU1WZ0E4N1lJ?=
 =?utf-8?B?cS8zM3pnL29OYmtGdkUvTWVIaWJZRlZWcXhKN29lNDR1Vk5QRmxnazJVa1Rt?=
 =?utf-8?B?U2lIeWxzaG8xOUQzWXFMZUNReUszUWtrTjVaTS9tRnJmUldIVUFEQ2E0c04x?=
 =?utf-8?B?YXkzQkRwUDF4YXRXNkI4UjkvOFAyUDdIaEVkbmpJbkg0dGw0MlVLd00yeTRv?=
 =?utf-8?B?eGQ4VDk1SjdSS3F1eHd3UDljN0RZYmtJOEJoM1FWSk1VYW5seEljVEc3VEZq?=
 =?utf-8?B?VGJ6cXJCU0ROK2FLdmVEK0t0RUxHakZhWmt2YWtiM3VqajZBZnVha2M1dm9I?=
 =?utf-8?B?N1V6OGFORnRPSlJUb3JpbkU2TCs5WXBHMmhYZFFucFdTMFdBOHArV3NFcTZJ?=
 =?utf-8?B?TlJ6VVVBc3Q0SDZXVjkwdXZsREtmek1IOHVsYXFISEdnbyt4MmJFazl1U2R5?=
 =?utf-8?B?QzJuZmNUTDA1Z0hjWENyMmhQWGs1dHZwcHFkbHozendHZW1ZUHVyNE94dnpL?=
 =?utf-8?B?R1AvUjM0c3NYS3YyYURvNHg3VzZZcllhN0RMZEpSM3FSclVYWmd2ZzZiajg0?=
 =?utf-8?B?T2x0bEtVVVdpZFJhTVhnWDIxclhuSDlEWTk0N1RqbTBMUVhxa05ubDY2clQ5?=
 =?utf-8?B?cXVvbWR0NDVNME4yOTlXekgxL2ZSM3pTRTRSZExXSVVSWUtqaUNMTGtJcmUv?=
 =?utf-8?B?bUcyZmZjeGt1WHlyTzdEN0MrRWl2d25HT3ZUeWdJM21RQ0d5ZnJwZzZQbUd1?=
 =?utf-8?B?a2xXeFY3dWFGclkyK3lhcWRsQzZGaW1sc0dqYis3TUpmOXQ4U2VRUVRPRVlp?=
 =?utf-8?B?UDJVWC9iWW1ONHptVVBSM3o1cmt4L2F5Ni9yeXJDTVBvdktEWWhGUmROaXBi?=
 =?utf-8?B?cHRYbC9JRlJhYXhHMUpXZWVuK1hOcjNvTG9JUFNmQk5EWFZIZWFIekdPTnU0?=
 =?utf-8?B?ZWw4bmZmRjc1cHFiQ0dNTzYyWjZxUEc4M2o3dklDNmFlRFd4MDZwZ1llbDJG?=
 =?utf-8?B?M1lWNXpQckpkdFR2cFZaVXdjUUtVT01sbjVBTFNWeUF2Rm1rckZadkxna0F1?=
 =?utf-8?B?ZVUrZ2ZZVDN1dHhJYzNtaWlKZVVoeDRyaFNSbWJISnJqbXMyZVBBdHVpNE51?=
 =?utf-8?B?enpCd3M0cE5vdmdseU9vN2w2N0FJM1FUQUdCZnMvbG8yc1Zpc3pwL2RsQjJS?=
 =?utf-8?B?TUhRa3NqekRtNllkNEw1d1Zzc1lLa3g1Vks4R2VtT0RkNGx4TU1WZkxtNEkr?=
 =?utf-8?B?WVRCZDN3Mzh2aHN0YVo1OTFNYnF4K0NvM1hFUXdjLzNTWUh2TmtTdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feab57d8-cb2b-4913-aeb3-08debc4f8169
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:24:39.4935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mv0jQXefvYw1vH1uZ9evUyQ0Hqh9Mff0FxJZ1jd8RWtVWd4C/UQQulT3uuFQeBwggBiA4Co4suz6hvmnchPy2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157

On 5/27/26 4:00 PM, Dixit, Ashutosh wrote:
> On Wed, 27 May 2026 09:30:14 -0700, Peter Zijlstra wrote:
...
>>>>>> Sure, works for me. How do you want to route these things, Xe tree or
>>>>>> -tip?
>>>>>
>>>>> Hi Peter,
>>>>>
>>>>> Maybe -tip, but really, either way is perfectly OK with me.
>>>>
>>>> I've R-b'd both the patches. If you want to merge via Xe tree, let me know
>>>> and we can get them merged.
>>>
>>> To get them through drm-xe trees we need ack from performance events subsystem
>>> maintainers.
>>>
>>> Peter, Ilgo, anyone, ack here?
>>
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I have submitted the patches for the Xe tree CI. Once that completes, we
> will merge them:
> 
> https://patchwork.freedesktop.org/series/167137/#rev2
> 
Thanks Ashutosh, Rodrigo, and Peter for the reviews and for sending this
on up!

thanks,
John Hubbard
