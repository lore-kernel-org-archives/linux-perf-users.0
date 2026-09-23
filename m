Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012070.outbound.protection.outlook.com [40.107.200.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B65490C17;
	Wed, 23 Sep 2026 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159950; cv=fail; b=jgwoda7OBcxif/lWnVtZQFLTBzv2Tq1FW5GQZNUeeWzJw7sGOwKQvkTfXE03VueIsLVPcYUeFx2V6XCARYiJ21evkHHd+UMdtJ6JZ0U/T9JkfJV/P7tY8lVtvWTEIbTNHmNqPCl4y1FF9c1cUkwmn2frmElKpjeFT5jwz6x38lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159950; c=relaxed/simple;
	bh=0ejEbG6UZBZEP/AieImcsAKolB0WnPw0kGSDLDrWPVQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lIBHx2FMXTm3rI/St+szy0qXJWwR8HjGInaLTo5gOoqXSm1B9tyJv0QMesQoMvT2R55L6KrSdrO57ciVCmOvr/3gNyvQkQ94cc0ASNHVn75+80scTfCqea1wv89lPGg99PYrzuRdaJRhnWzADliAe95olFg5KcpOrZ4qf9xw82M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YqpMQ+cU; arc=fail smtp.client-ip=40.107.200.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YqpMQ+cU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bue1FZY+X3XrC/5j9LYhh6T4ywsUeq23tQuXvCeRCpjr/cqGsV2sWLndYsfaXWUYuQeajYIa2GW2oqvwCXX5KyIbjYMS9uvuGC/fpk83UJ23Yj2KduRZQSjafmis4zVLSxXPcJhoTsaZfgSZY3yFyhPkgATydxWXvQaUsLwZN8VAOwn9XMKosZfQRUUxxW+gXB58MtibuD/RiGUMNOjVgLOjs2fKrbMiQfaw4eFrwJ1p4Gt1v/9M0vaL8hptqTqLGpvdLhkrOyGVQ4DSxZjKCUxKSk/3NOL6ZsS0ErSu2fPjPSO20p5uldLGEXjWZ2ztHpS2LvwlWvHoz6bYyPXbUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ic568VS9EkTC0WHr97FSlRC9RL6yxLq54rKSumyzz8k=;
 b=mDEtxjU39GrIiI/sKqQ+SRY/Fxpbi27XuDoYRmeKbFDBQy/+6sQb3XVhzkLFypFu6iymtaVqYsxba8r3aARqODGLKhmH7tUY09T4FeN65zhuW2nlnq9e16Aqrq4qX91OrOm8ITHl932PH42vrBuX1zFrs48w3722unI6nHZ56jJUBDdEbykkax3Ss4+LkPDxtzjM2O0ob9FCd+9rRBv3Glmlu7DBemX04m590uWs/JxgB8BSoTQeCjSvcC61qEXgDOSn80d0dOrt8wbBY3nO4Enq7D/y6xmrl3DkAfHZjmhvGN/0VHy2ozgyiPABtlqOFwNsunMPke1TCxyPmbUWSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ic568VS9EkTC0WHr97FSlRC9RL6yxLq54rKSumyzz8k=;
 b=YqpMQ+cUwMoS+5aLpa0Zc7F87P6hldc2YCxjLq8JJQEut07LwxMgWsZukh3XPOaQ+Dq7na9tUNbpyaZGlbj97OGtETMJVjMjp51V9TDB9VEe7aXgvZUrtU+7W4WAjNLklHsLICRd08V5SaZ//B5hXaXk7QRUUS2KG2VmmC/tvAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 10:38:55 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 10:38:55 +0000
Message-ID: <1486211b-1182-4277-b273-bdc84f6d23d7@amd.com>
Date: Wed, 23 Sep 2026 16:08:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] perf/x86/amd/uncore: Drop redundant counter slot
 searches
To: Usama Arif <usama.arif@linux.dev>, acme@kernel.org,
 adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, irogers@google.com,
 james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
 namhyung@kernel.org, peterz@infradead.org, tglx@kernel.org, x86@kernel.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 kernel-team@meta.com
References: <20260921153108.2713179-1-usama.arif@linux.dev>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260921153108.2713179-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0252.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::7) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a889506-9c4e-4051-edf1-08df195eddda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|921020|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	pbVSjDe18pBSjCXsIx1EQ7E/7rWiiPku/IgBb5RZXTYrsr3azErpdxhgB2OlO9H7vIjLQ+sNl2XaOQ5YRKYz83bDFvaWTkq7sy7Y17L2o6djP5HxRIdUCdHZVeLSxKKmVu1UfxECzzgz6sybaKU3HyGjjsJIsHd2HnJPJX4FWk/pFL2kfS+KkwZarsJqN1SkKd8T82BoUnQoKJ22senKcg/PdEQSGi/N/KnWIXpae63jlWyiWJwBGCJ3ashuebRznTHJFLpgnseaaYW9XaJO4/o208lTS5Ol5XS2hfewTgKW+LZCbHxyPvcuSLQNv9PofdBRT8QPQg7193dLuOF8MJTTL11dTkpIOGywTHcukr33WH6HUa8wSY/mfdaPQ9n+9bfo6PXB6UKvgPIT6J0+H7elWIVO4XIjcL52jN1HaHEUMRMaiCjwfnnQw2w8tlrgFonE5p1BjKR31cDImguMeVXWJfgKPWQp2fQqTcCTuEDuNyK7HyS3z1v85Hqe5BjjwRbPg+meXfIUS0M8xfIazTpztt2OFMK5aCRXrEVVGPQnMIGr94qzdKMXz91U7OTxbmx2Jz92n2zN1iMi+Gz/A4f9ky5IHlKyGNag/EQ0sOqEdkCy82oE3VDogWzdzyT2n0yRoj0ZYwtdtOhZsvFsYMGzpG7a422FendkyhCEnkY6Mf87xSkCo+pPytN2ROyD63uVWGbKHXmSgSsvB5KnyQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1I5TTd5OStPRHBQVHNRUWFEdXhJaWtwbTVjS01VZ2dYRlBUaVdaUTRVU0JU?=
 =?utf-8?B?djk5L0x6NWsyUXdsYVo0MnI1aWRtYUtWcVpqNzdyaUk1YS9aYXJnd1k1K2Zp?=
 =?utf-8?B?RmZkbWJBbXhualBpWkNPaUtLODY5S2xiWVQxVDc0ZnIwc2YyY2lGM1FOSVdm?=
 =?utf-8?B?Z2l0WVdSenByQkZyVVRxcWViVlNoT1p5aHlPZUd3SUdnK2NZa0RuRnVkS2hL?=
 =?utf-8?B?YmdMWmV4RUJMMHlWSUkxSmVheFF5M09HRTFIVER1WHhDZWlBTnJWVGJjWFBE?=
 =?utf-8?B?VFRPSDczU3ZVNkhUK1h2aXBJdUJBNnNNR0E0NSt4dHNaMlFNZlZuLzI1cktI?=
 =?utf-8?B?SW56ZEVzNzVTRkp0YjRsWGhwQTFBWnc0WVp3RFJjZW9BbWhIVFdndmp0c2V3?=
 =?utf-8?B?S1NSaEF0Ynh2Wk9zODJ4emNKUlVzc2NZT1oyYVpMTGs4ZVFDY3QwMWgxa0J6?=
 =?utf-8?B?bEhnL2xraHZHTlRBanE2bm8yWnBtdFB0WFB3NTNkSVhkRnV6UU5obitTaWxE?=
 =?utf-8?B?QVpwcVlyT0VYRE9oYklTeEZBTW5LaG4zZFZhckVXWkwvT3JVMHN3OTVtUGxZ?=
 =?utf-8?B?U2ZaMGVrNll4UzVJWHdWNG4xeU5NQXZyaC9WaHp2bkgzYnBEeTNBTkpPaERB?=
 =?utf-8?B?WWlYQ1YrVWpOZ29oQUFnQnpldUIrc0hLSGtpbUpEYk1sUW1RTTd3RnpBQk5p?=
 =?utf-8?B?OGRGVUJlcExTR1RNcGFuWFpYbFo4ZytLRXRGNmFtTU8yaU5GTlhVVHBzQThj?=
 =?utf-8?B?MHJKbzJIWm42RzNHbzFmRWxPajV0NE9ZdmNrc1BLQkxMT0dnWDZBVUZjRk9T?=
 =?utf-8?B?UmFmdDJJbVRPb1pLNHAxTnBnc1ZXNGlTZGNVRDd4M3JySHdhM1RMMmhaK2Ux?=
 =?utf-8?B?aFNTU0J4bThnSTJ6ZTNRSSthdnNaMllGY05NQkRxcVN6eWNBaGRxdURpMmZY?=
 =?utf-8?B?SkliaW5sY0NmSmo1MW5tMUk0aldyU25uaGZ1aXBCTFo3bU1zMzJvbDFEQXMx?=
 =?utf-8?B?ZTQyZWRxWkxJbnJkY1M4dy84OTNhdEw5T1NUZCtpdUt4K2FPVFFSa3BGNllI?=
 =?utf-8?B?alE5SjBFNk9tRTBERnZuKzVic2ZHZnljQTlrREhlRGlNRUF2YmtNWEU2b2sr?=
 =?utf-8?B?Vk9XcjJ3R3RaUVdHamxhWTFNVlhvMjFsNEVka2lFOXdzN1FwN1AxSTA3TFJB?=
 =?utf-8?B?dkhtbnNwVXRxaE1peHhyZU1hWVB0TDRJRVZZU3JpNUNGYzlRSG1uaExwUUNo?=
 =?utf-8?B?K1hnaUg4MkthbmdGSEJ0eDh4Ti94SllIM0swcnpYNEQwdWNYNy9EZXN4RnZH?=
 =?utf-8?B?aEh1NHVRQy8vQXMxTmZaa3puNjZQWVpiZlg0YW1KUWVwQ2RJRllVaUxReDA2?=
 =?utf-8?B?bVJXR1FzT2N5bGU1Ulg2ZUJKejd4K3lRMU00OEFiemNtREFXcUUwUEhEWWty?=
 =?utf-8?B?TlVTdG9nd3ppbkI5dFBXcjE3TS9ZWlE1TXRZT09ITUU4Yis0ZTJLd0RFYWl1?=
 =?utf-8?B?Tit4UjJ5QzUrTjlhTGY2V3ZrUW00Ukl4UjJxZ0hQM3oyTXpRL3FvK2gxT0RF?=
 =?utf-8?B?NFJoQlI5WmlVcm9ycUhsVndIcHdseG5KL0d0dUk0QU4wR21kNmVLN1FrdnZG?=
 =?utf-8?B?OWFHcDE5ZVlwbm91bFZSd25OSHVqeGF2T0J1MXVxNDUxWklvdTBXVUlvQUJD?=
 =?utf-8?B?bEtDL2RmcFgwSVB5UlhZSjdheUs0UGJoUmhyS2RDYmFLZVN3OFFjRGpaS3BH?=
 =?utf-8?B?YzU4aFFPa0xMWGRCcjhPdGVFZHhxOE10S2hKMUZ2QjM4dmZiUTVvLytNN3ht?=
 =?utf-8?B?dXY3S0w4NW9UaE1POWhvQU5pQnN0TjdNaVhHcDhhbkhyT25mSm1UMHQwVDBp?=
 =?utf-8?B?cU5LRGxuWFROUWhVYmhOZGR4TnkzSGZQem9aN0drTVZGeDRmVy82eGN6d240?=
 =?utf-8?B?cHBaOTA5YW5yK0ZiczM3K1NXRmVNQkJlMW1HTmpzRnZaY3NtTjZlekRsVGdj?=
 =?utf-8?B?ZHV3VDl3VXh0RDVETXFQbkRFcGcydEZPME4vaGhEZms1TlY2UmZIZVB5K2Z6?=
 =?utf-8?B?UnNsR2V2R0JCb2tiVDBPREFpRDRTc0RRaEpWNjlyN1FZdW1teWIxWDcyKzNB?=
 =?utf-8?B?S290Mk5PQ1EyeWZhaEhCUVZkSzF6ejJ1dzRGd2xBUkpTeThYTmlyeTRmODNw?=
 =?utf-8?B?NXhQL2lyQzUxSFduYlFrZlJKRy9aN2RJOWpRcU16VjBTOUIxc1FFMU9BWC93?=
 =?utf-8?B?cE04eUpWTVpkZnlpUG1nSk9KWE1aaGU5SmsrMnBucXRFZmJyZjVHR0tZWFgy?=
 =?utf-8?Q?0/8zGYg8pXPDzotQgK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a889506-9c4e-4051-edf1-08df195eddda
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 10:38:55.1464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1bRT7QPDLNGmAg9sqsnIsgIpiK+t5HkTITMB7ghsitaODDHTnLG8dt++O/t5SIoDm8fIUi+L5pgimcTkZe87A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519

On 21-09-2026 21:00, Usama Arif wrote:
> Both amd_uncore_add() and amd_uncore_del() search ctx->events[] for an
> event whose counter slot is already recorded in event->hw.idx.
> 
> Perf serializes ->add() and ->del() for an event, and the driver never
> moves an installed event between slots, so an installed event can only
> be at the recorded index. Both searches are redundant.
> 
> Neither callback is normally hot. That changes once more events target
> a PMU than it has counters. Perf then multiplexes them: every mux tick
> deschedules the resident set and schedules the next one, so both callbacks
> run for each rotated event on every tick.
> 
> Meta's fleet-wide profiles attribute 1.1% of kernel CPU time, excluding
> do_idle(), to amd_uncore_add() and amd_uncore_del() combined. On the
> host that exposed this, a workload holding 15,782 perf event file
> descriptors drove 56,575 calls per second into each callback from mux
> rotation, against a 16-counter DF PMU.
> 
> Patch 1 removes the scan in amd_uncore_add(). It walks every counter
> before the free slot search, which is the common case once multiplexing
> has scheduled the event out.
> 
> Patch 2 makes amd_uncore_del() free the recorded slot directly instead
> of rescanning from slot zero. Deleting all events from a full PMU with
> N counters drops from N * (N + 1) / 2 compare-exchanges to N.
> 
> No functional change intended.
> 
> Usama Arif (2):
>   perf/x86/amd/uncore: Remove redundant event slot scan
>   perf/x86/amd/uncore: Free counter slot by index
> 
>  arch/x86/events/amd/uncore.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 

For the series

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
