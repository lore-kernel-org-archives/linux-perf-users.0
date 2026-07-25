Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020083.outbound.protection.outlook.com [52.101.196.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11BB312815;
	Sat, 25 Jul 2026 03:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784949052; cv=fail; b=EK7uudlO+ND74BmPalwDhV5UFDl/45oJz29+EeZnMwA0HB9b0qieYCLiyYI4jLSto294dp0Rl3HwvNRAqaKSFEqn2NBf/kb15Z+PWx8d0Fm3apRodvMEySZUUFvKxRwftlVPraKIrXURLTD9NyRsuCQyfIlEw7AAAV5SC3Sa3sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784949052; c=relaxed/simple;
	bh=H1S22dBJmbDjKnMS9qvLfG4s0FnstRSBhtWn29jGVEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k8y8UsqM3Dmf8h21ZTni11fNJRteb53ZeuXbc2jIrvUl2NRjb9lXAnhFgNuVYa1r8lamo9ltEIQspfXNJvjlR24SJXVljVYNA5JTrGOiXs1XAc6atVfAAx98ilDl83nE8PFQNwIoWMubd2LI7qFCzE61QEKtYpyGtfRV0g9SaXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5989CCeJNXCot9eXZgGPEELzqTtiCvQ2/ooCmGtNh9WK0MdZe0Q5ZdiCkQSsh9t+q0MVTbCTkUUsZc7THFYNpgdoUp4X+jULIGUCqr0KG0yxfx/3iDQA2hnb/E2nMMeZzkdzgi/wItGv7/jOdGUJsBOQCYZpI8e321NOFpop7WIBrxdNsJN0yrwzzbozMS5g2Z5altX8ZtbLsXvxLaRURQK/yWDBxTtl1FfLD0i7ox8NIgm6A6JT8YtRNNqiHg74oCEYjuDxNfkiUYc8Pq3+MNZkzMV4kPW8cAsEgsnqWDkKxZBYCk7qIJGOR6Hk4hCKurOrvC2N3s9xLW0qdKUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=KEfwUiUCG26p2qGMtCsyTdVOt0sErx1BOUwZbbkhHo8=;
 b=bpcND7IG/HTH88+yyLdZGHJ4W3bwcUTaqMWjdwysDxF6feZiXUbzJD2qkN6Dnr9DeJUTc3qpj9IQm4FFgr9XOoIw2oEdmqkS494nuhxV2RGVAjr2dT3V2j4NKRDTL5SzkSio3zMW1yfP6GbTF6I5uhZt5ieLkPbEZa5gvKRXI0X19fjgM1aBpcDkgQTboWBqRWladOALKElq5z6ngXr1xwOTNptxpNM1/FiCIN07maoG1coBgzhtt0GbkH1IsEHopt0lDP8n+4aLkVNWryVFi3hr8PQdLwiAamNg1Gx1xvFv40qepUQEuoNMzKzzdOfOG6jYZVdfbtREiIQQpI/FnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6857.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 03:10:40 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 03:10:39 +0000
Date: Fri, 24 Jul 2026 23:10:35 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, steve@abita.co, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf sched latency: Add histogram and time interval
 options
Message-ID: <p3zqhktlhux2cgb3v43ehvpovjqeztyjfc2tgr326gabuetb7o@n3x7zrltz4nc>
References: <20260724201207.661300-1-atomlin@atomlin.com>
 <CAP-5=fWmV2YoBdGKhxt9G_VByMzqimxEamxbjh_Gf_vBx9=cng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWmV2YoBdGKhxt9G_VByMzqimxEamxbjh_Gf_vBx9=cng@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0365.namprd03.prod.outlook.com
 (2603:10b6:408:f7::10) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 06cdbda9-4047-4c3f-ffd8-08dee9fa4df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|4143699003|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	agQyOLZpWIcDTBU3lxrAR8D7zKEOfbpYch8YwAmEz2FEscXzgxK6j9c0WYRvzIw1fn6xORddylp5BK1/WD2umWEtMBWRBu8Unzs0IvI3VKUFfd6knwR2sTCt8wqEmoyKugLDyVo88PzkmmdsMzNUX/I5BdIqGifmTB2Y0MFgdcHljAQfP0tG5XhhS7ksbujMkB4VmpjPbD3TW93xlqeKuKs5Dl1PkdyDEm7WmuEOylYMMl3bLU3j2XLK1XceKiSr//nyZsv9l4FQZ8fHKlGo7zy1k9B2xz7IgNAd+6aA7U0+6vaRfM8IDRp1RLeaA+FB0LQarvfnw0XHiU/27pqSUOq/4DPZqds+U5FcFJOTMyoZ64qw5gEDQ6b0KBMtFG2Okqd0pKubS+zCmvDLEKkqobcweMVZ3738upgoV/gJQmo3pSbD2CmvaN7LqBKmFZKyY2kUPISFjFIrnSOczLR1h/RqMftu8hyy1rq7dBQuiIYoLiWiqX9/BfT4JN1XPcXkreEADS8Knvi9pPf92ehyJD8W5PEPY9cTxePG40bFO7P5NLIykS75S+RUBBeDuqH9SUUYqSmxPSghgefnL1ZZ1cN8VCz0Dt0GT30151gZUmdAAxJBPT69UvZTRUxgPJuMlZXV6SGcYAbA0zf/TXaTq6vgNAn34i9EUgZA/3HLoro=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(4143699003)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDNDVGx5elNiNVBkWTNLU2JjYnl5cjNlTTFlakdmRVc2R0lzQ2NlOWVXZmN2?=
 =?utf-8?B?MERSY0pkY0h6bndFVXg1YmJPRzRvcEJiK0tkd1ZlbzVsb2g2VTF0cmptUUZT?=
 =?utf-8?B?L2FldGtoSWtkMkpENmNkNS9UY1BmcENya3NOYjFadUFxKyt4ZCtWTXgvbW5T?=
 =?utf-8?B?ZUh0d3Q1ZE1RY2JqQ1FxcW1mRHZKNVM1R2RjL2wyU0VmbWxCMmkwWGtxN29O?=
 =?utf-8?B?aGRVS0ZiRUdOUFhqMkt0dk5QMVY0UWo1ZSsyVk55VFZyYXJZZ1dtZnM3N0dh?=
 =?utf-8?B?cjNPRmJKbERSUm96MVBpbUVUSUVnOWhQd2lYTy84NDJCcmI0b3RURzRVdUlB?=
 =?utf-8?B?c3VWb0M3ZC9uL1QwNkhIR3lQN1g5WHNQRWJjR0ZENDkvakl5TmVZRnRUU0RR?=
 =?utf-8?B?emtaaUxMMVdaOWlsUXNKaGYweUE4ejV1d3JNTm9Hc09yZEZreUx4TlF4b3dM?=
 =?utf-8?B?Uk9OUGszT2hkRmZwM2xLZkhtenRjNVJJaVhpSjdjMm5YZ2M4VWZLTjZ5bERT?=
 =?utf-8?B?c3YvUlFjUHJTTExodWE4VXRuNzd0RDgzWTE0VEQ4VUkyWVNkNURCVmtabC9m?=
 =?utf-8?B?RUoyK1BSekdkU2EyeFpwa0xRcnkxWlNub2t6YVRZWjdhanZTU1V6ejJsejdM?=
 =?utf-8?B?VnRKOEVUb1g0SzVpYzY4NFZ4WVBiM3hrZTAxSjVmbGRoSE1DUXRYelhuWWZv?=
 =?utf-8?B?anc1SkZzNEpxaWh3SzIwYmNVWFA3NkhaK2hrREpVd052ZmZGUnArdDJYMlJy?=
 =?utf-8?B?T0NsaVZvbzJTSE5FelBtRlJ2a2V1aHcxcEhTOStabFMzNVJTamdVZ2VLemgv?=
 =?utf-8?B?eElQeU1ybXR4Ry9rWS9rR2VWNndWV3FBUUdhSy83bks4bnQ3S0VVVmc3aGpQ?=
 =?utf-8?B?TGd5S1Rpc1NtWjJEaTh2MzBoNDNta1lFU091THhRelcweWRMUWhnN3lrWVNv?=
 =?utf-8?B?eGhmMllGaWI3QVBzbmRMbjJxQUNOejVwV3pwaS85Y0UzSk5abGtvNWtscVdL?=
 =?utf-8?B?QkkvdWJHRUtDb0U1UlVEZkY4dEFlQWlOODNoWHV3aTFkQmwrN1lGV1dHbTd4?=
 =?utf-8?B?Y2NvVWdNQTBHb2FrZ1lnN3VlV3NBMFhPT2x6cE9UK3FoMzcxS1hSaHFSUTZW?=
 =?utf-8?B?TXVyYXZPYlB1Y1M3eEYrZmQzWlZIN1RMdXpNRm1QZGJmajV4T3pDZUk2bHE4?=
 =?utf-8?B?cEp3K0cyRTVuK0d6UGpUL2VFNlJtYWU1TFFhcnpYaGtsb2VTeEtJeWFmdXI0?=
 =?utf-8?B?UGt2b04yOTJweE5oc0FIcldUTjQzNUsveDB0SkhsdlhpcTF5cTY0VzVnWG5n?=
 =?utf-8?B?QzgyQUptQndjU2ZPekdTdXo1ODJJL25PeXo3U3dHbU9jNDVnWkNzbngvMTMy?=
 =?utf-8?B?dXUwOWhSZTZ4UVdNMS9GMU1tNklOalRCb0ZMYkVFRVFBRmpVd245VW5UTnlU?=
 =?utf-8?B?d2szcDlvMzNBUWtnak9OS2dnL2ZvYUNrRUU5WEYzQUh6RGFVcmFOTlozM2tM?=
 =?utf-8?B?cGJtUzViZTBDS1V5NW9tSlNjb1JPdjYvNkhnZmhQeTNnTENKbDJCVnBDWFhl?=
 =?utf-8?B?UGJTRDAyTVcxczBNb2cxcGZvS2lvSXVBUlhFZVpxSDh3L3l2bmQ3MHlycVVx?=
 =?utf-8?B?WFdScXVCNXNlMlJlK2dic09qY3d0eGRSMHRveFJkQ2owSnk2VlVHSmNGMDBm?=
 =?utf-8?B?U25vYzA5QUtxU1lKYkJXTlFMRUdZWFJnWmVxRmlrMlRjOVBnVlFIL01lRXdj?=
 =?utf-8?B?VXRidWE4dmIxT3ZXUXU0cStwWWF6UStWY1dxV0xiVmdJcUxPbzdCdzAvUThY?=
 =?utf-8?B?SVh3TFhQeFZqYjhYUFo2a2tndG5XRVk0Ky81TUw0b2t0ZkpnV0dvbDVlK0sz?=
 =?utf-8?B?MFQ1MWxac0N3WkFnMmVEcWtKWXlpOWYzSW1mTXNEQ3ZKZ3orQjF2c2RleUgv?=
 =?utf-8?B?N0Zibmc2cjBqNHNrWU45cEcvem0zbzdFMFVST2dBN1lCeVR1aFpIT1Nsak40?=
 =?utf-8?B?ejc3cDN2UzU3d1pnNUk1R0RXeGFvOGpkUFZBdjg5UEQ0bElEOGJQcXBvMDZB?=
 =?utf-8?B?Rkw1OStvYzlQMTRnVGpRbG9FL3BySGlUK29WRHBscTNBNk1SSjVGM0swOThq?=
 =?utf-8?B?WDJacC82YlNaWExMdTNnTkF2eGlHOTM1YjBBMWJxcDNuZ1hiaktrV3kzN2o0?=
 =?utf-8?B?V2ZtNlIwT05XT3AwTjcxL294MjhiUkt0VCtuSVBqNnhiT3c4Rnlpb2JlVW8w?=
 =?utf-8?B?M0FBbnRpVDF5V1V1LzROTmRtdWZFOThiUTVGMnYzT1l0UHZOWlJkYU5KNWpi?=
 =?utf-8?B?cXRRQ3VjZ09nSVkxbnEvTmpVUGtCbEdiVUViN2lDZGFhWm9NQU4yUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cdbda9-4047-4c3f-ffd8-08dee9fa4df1
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 03:10:39.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNl3lijqoV7QJJSW0MPt/YwPbOwSwbMDO5zVpEwLzmF+2iLtxwLlQOdnPB8HIjO+aW8FzavfEXFgKSqszrS6lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6857

On Fri, Jul 24, 2026 at 04:27:07PM -0700, Ian Rogers wrote:
> On Fri, Jul 24, 2026 at 1:12 PM Aaron Tomlin <atomlin@atomlin.com> wrote:
> >
> > While 'perf sched latency' reports task runtime and delay statistics
> > (average and maximum delay), it does not provide a visual representation
> > of how task wait times are distributed across latency ranges between
> > snapshots (start and finish of the analysis window).
> >
> > The --histogram option collects CPU wait latencies (time between when
> > a task becomes runnable and when it gets scheduled onto a CPU) into 22
> > latency buckets, displaying an ASCII bar chart distribution.
> >
> > The --hist-mode option configures the bucketing scheme:
> >   - log (default). Logarithmic latency buckets ranging from
> >     sub-microsecond (< 1 us) up to >= 1.05 seconds
> >
> >   - linear. Equal-width linear latency buckets
> >     (i.e., 100 us steps up to >= 2.1 ms)
> >
> > The --time option allows filtering trace event processing to a
> > specific time interval [start,stop].
> >
> > Example histogram output excerpt:
> >
> >     ❯ sudo perf sched latency --histogram --CPU 0
> >
> >      CPU Wait Latency Distribution Histogram (between snapshots) (total samples: 36114)
> >      -------------------------------------------------------------------
> >       Latency Range    |      Count |    Pct | Histogram Graph
> >      -------------------------------------------------------------------
> >       < 1 us           |         17 |   0.0% | #
> >       2 - 4 us         |        673 |   1.9% | #
> >       4 - 8 us         |       6237 |  17.3% | ######
> >       8 - 16 us        |       3224 |   8.9% | ###
> >       16 - 32 us       |       1388 |   3.8% | #
> >       32 - 64 us       |        709 |   2.0% | #
> >       64 - 128 us      |        690 |   1.9% | #
> >       128 - 256 us     |        789 |   2.2% | #
> >       256 - 512 us     |        541 |   1.5% | #
> >       512 - 1024 us    |       2256 |   6.2% | ##
> >       1 - 2 ms         |       3577 |   9.9% | ###
> >       2 - 4 ms         |      13259 |  36.7% | ##############
> >       4 - 8 ms         |       2523 |   7.0% | ##
> >       8 - 16 ms        |        222 |   0.6% | #
> >       16 - 32 ms       |         10 |   0.0% | #
> >       >= 1.05 s        |          3 |   0.0% | #
> >      -------------------------------------------------------------------
> >
> > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> 
> This looks like a useful addition and because the behavior is behind a
> flag it won't break anyone. I saw Sashiko had some issues, but I'd be
> happy to add my tags once that's cleaned up.
> 
> Thanks,

Hi Ian,

Thank you for your feedback.

Understood.

Kind regards,
-- 
Aaron Tomlin
