Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2107.outbound.protection.outlook.com [40.92.74.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E913FE5D;
	Sat,  4 May 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.74.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714843316; cv=fail; b=YlxF9VFMdAOQfdEbBi7lfM4O2Lq9foUrv0zyw6yF3m1EhGlhykVJBvx/GeC82EAARVQ/pI7M6gQ7lROrzXhRzBGRQympKz4fmD4S1aHMH3tbHF8ZF94mv1S9LfmDbEenNQ3wjvUkQFN/Q4vQzougrSC6sfAclQIKrQwHXVFkicU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714843316; c=relaxed/simple;
	bh=YqJVksLZ+8UoQ/HDX0wsCn2zbUBOn3bgNxiFMksPUZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e+eZUIW3XPQeQ8VfHadtBlVv0DVb+jCPTbL5y3OAzThp2GbfcEvaPDlV5IpUgp99Vg83v9gn4wgHCVnkFU4WABqXCZ62v0tbUgRlJD3mxk5Sdm3FeL1Oc6Q32ARs0vgqmgtfQlsg0BCHMhTKwX2G8SOpoYWxEZ8cBYDXIDHjdYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TW2tg1vG; arc=fail smtp.client-ip=40.92.74.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TW2tg1vG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqquoLCt1convXt/zOmSjS1NpixgQ3yIFWByyFuJkyHXy3p9sZKQosm3+TIu9vLO5QV44xb8KzmyAkyeddp1ASx92qh7IHnsANx3HdFuQa9WByq2TftVnDhcNn15Ea5EbVsspVvG8zZfMqJwiVklGY7N17VkyZc1gwIRN+zXZ3LK16FBunlu2tAOOZHA13IobeEjFo6wozF16slsW94vskardgazBkE9SUbylguNPwPorJnc9xklFk0ZZxLX2nmj1cS3WLe3miwxJR0MZNQzk5x71MjieuQK3pc+LkixImvgMY7u0Mw2oyh6mRdoc+4/95VRZ3pmdWz9luNKlNE3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FINE5lZZEWc6u05QaNWmqAMGgi+03fyaT3p6ddJD3xM=;
 b=IS7WONAKayd1C5vCYUgiy0fLFqzGP7NI6rThwcO3ZjKt8o8SSmqwd6hsoKuh8J6uiGb8VGxDREEbIf9snCpQww13buMvB8c4Kkc/6BwNj45h4WZoBTIr6GbT75iwhzyG72a+uRhJA8FVuo/FU+OkuTWqYQ7OyisJOxYpmV3NiyBodGYuQ7m+GvuFixydc1O2EPmI951K9+FruNZWOAbC6ak2/KpT4HSl2jl/rhEqAPJqj5xMUBNT4R54LArQ843L5Et93QduiesQRVF6J2TlsCQtgl/SBTLeLPUyXjgqO9fJC4t6Wkp4b1oi9mjKTK8BN0L5dp+GC2sTVGJqkXp9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FINE5lZZEWc6u05QaNWmqAMGgi+03fyaT3p6ddJD3xM=;
 b=TW2tg1vGfh4/VWLUPy47CJx6sk970IWV7cFrTYAJxZ7CucUEAE/XsbopJnHq3waGvqKwXfFAelwHFlCRSES6e5cvdxolXz+dg1cVuZFKykeoPYBLkaL+D2UhlMN4524qQad1XlHDKpE/9UbURfvHUA31VzkIirkF/Dtnk/cOWHeKgItOgdXRcnkUWoPOlbyElkSqD3Gh8Wr9DMDA6+Hlrl/PnfevwTbbn85tDo4y+AHoZjCJjWarwnoFKry7DoHQwKAEUfnD/p3zSkQ0VIZ+06kXqtua1sNSFvRQXbP+eKC9M/U8U0CpZMakYPELXKUsLYyKbOKMoYuDOIInTLaHkw==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DB9PR02MB6716.eurprd02.prod.outlook.com (2603:10a6:10:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sat, 4 May
 2024 17:21:51 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7544.036; Sat, 4 May 2024
 17:21:51 +0000
Date: Sat, 4 May 2024 19:21:48 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>,
	Erick Archer <erick.archer@outlook.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] perf/ring_buffer: Prefer struct_size over open coded
 arithmetic
Message-ID:
 <AS8PR02MB7237E1240937477D0D6F57AB8B1E2@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB72372AB065EA8340D960CCC48B1B2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <20240430091504.GC40213@noisy.programming.kicks-ass.net>
 <202405011317.AF41B94B@keescook>
 <20240502091837.GA30852@noisy.programming.kicks-ass.net>
 <202405021552.5C000EA@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405021552.5C000EA@keescook>
X-TMN: [n50IFuc7oitF9F8R20Tqs3CNL81BMjWv]
X-ClientProxiedBy: MA2P292CA0019.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::17)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240504172148.GB3490@titan>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DB9PR02MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7fba74-f48d-47e6-f17c-08dc6c5eaf9e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|56899024|1710799017;
X-Microsoft-Antispam-Message-Info:
	Mq/Q6UKXU7XQqC0r/7h+2R9/+ZlSW0sEdoo5x54+MMA0h0a7JxD06r1W8xZH9pGuYnZCLb7TfTc9E51FZoMiOhZ2Hl5vhIo+wIzTy61g8CRbNkMBu5y1c9TvdkkosFl7441ArUtC08hsq2+xi+ORhVe5BSSEu6sLomm99iW+FTorGgIHYVz9FeWPawofP1T2y6MuVhETkS5+4DmsSImP/kty1T8PwK3ofuad+djhw/0uUTaVyjW+nqL1HBru3cpnpBVrc2GDnOCqXoUZ5nrtbe4+m4SubwFRWoxrBIGMOVsSwzqXWS8KcAWIzyKe8gVYvFxiaArOooRRtUoSu53WYdrBhgtOydZQRqZAim//mBuwlUpL4Q+UawVVQe7FVhSxRZWYrOE31FwCHPhNcJJVEnUpUQJzD4wOhdndI/XO44rcQLCq1aeNyMl8A9CWy1KLLYMH72z9WtwxZI4qDiLRNzimwgIG6cvm+CfxmcNj25+nwNnWKTubxfhyyQjrdvOkX+JeZrFikTHzleXAiWYjoqnxFYNnHKnK12q6X6ls8EQXr0z2KQPVkDAu122+DE72dNLV6iw4VicN8Jql55nq733g1Gd0YsX3/OXQ4ZrIWixZb6uZh6ZOi4G88xLzsrADL9uRK4teqJbOPEC+hN8/XNpz2qcPHa0coZaApamld7s=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qQfS5W3zWnt2WaUdUiuYYjk8pjeEyQjc6hG+9c40mdD9vYkMEwOg3acQP2QZ?=
 =?us-ascii?Q?d5SY1jjrE9hpMK8lWAVsAmhR404mX9DEqKQ9+Q8D06Rq5jKmGwX83iasHz4d?=
 =?us-ascii?Q?CzVmsLQJErX87w1mRjvhRjUFoRRvivB/jn7TGI8HrtZVox744fxXLvLeNIp3?=
 =?us-ascii?Q?fXfT2NJxi1JhElFm/GMJmJmFHFGfSDF0Ou3F3Vww7Oj9foCO/bvazftKfamq?=
 =?us-ascii?Q?0ir4imnWGfDXuYvGsKL8f4rDuM57qoUdtW/0N/nxYOXGkjIu95mz5YiJQgke?=
 =?us-ascii?Q?VpDN3Lzuz2cHcD5EVn+2DmZqH1+cEFDfzY1KOsj1O4XPhxFe+E6UeAdoXaR+?=
 =?us-ascii?Q?05bbWk04y7jSY/J3hfg9YGqlVhJaObYIT7Iv59sQKRfexvnEFQ8w2edomuxr?=
 =?us-ascii?Q?aIDrNUWhNFFDycMh3Bt0gTcrMPG08N2evp54KYvI/KTgoeehvdckovuGlKyU?=
 =?us-ascii?Q?+DvP6JLPIXY0RxKz3j57vkZ3LpDqRTuDqEdQweQThmIE7ZCnbP1GDNzSz/WW?=
 =?us-ascii?Q?2Y0/NQhqVu3HY2OfBxzkYP1JM3sF9ns7//K44EhOSIzy0o8+uJs0yi0b3r86?=
 =?us-ascii?Q?Qb4mZzliXeV1JYfk3xYOeiridBbMKqnKzc2ECYbLlgtK4zypsWK9sxuf4IRG?=
 =?us-ascii?Q?+XrVvEu9FPJQ7vxYlv6yEDHfckLyeXR0jl0547ktBzCzR7/rW9q51UsyvFdw?=
 =?us-ascii?Q?UJLkasHMGuEFAJQ8mbXuxbD+uOyUqGms63hd0+iOv0a1mbi/T2oUF3cTXK7+?=
 =?us-ascii?Q?mOhEpjXM/zRKJuA9MVeDCAAj/HJWvotV6coFpVsp4Ywy/YtO76IT8DtyXd4Y?=
 =?us-ascii?Q?TD8uEBbj3ze46N9Ab80p+oDVsi2gRXU3pPrd5/CJI9gOdB5wTKanauACQDHg?=
 =?us-ascii?Q?vJmMM2P3K8JmOjTWfi9BiM2jfJxf8rXlRqAeOo1SgioSp/wEjJY7ISOCGlTh?=
 =?us-ascii?Q?6/9laiTyZR7AQD9Nwaucw3KNO3OQ6AgC6DyEDHfmuyzES6absxnmeRUKNwvr?=
 =?us-ascii?Q?vSzHd8aIxkc3SCGkHGDDx7wYbqNu8SpkHtWG4AsFijGHxJJQfHCIlDzTnEEJ?=
 =?us-ascii?Q?+WuERPTKITQCgfMZtTVQlKD9xuPiEnFtV5f7ac0Exw5JM/yW5ouIZvxtcorJ?=
 =?us-ascii?Q?ifxmpEg+I8flf6qeVQ9YxHqZAW3k8PHpLOnUoWuFlvNfwIWZPKlAOZM21yNz?=
 =?us-ascii?Q?OU0g27JJ0qTqMjVslk4avA/aaGCq31wvqySoWnKQMT3j/qJx18WwsIvnvIVu?=
 =?us-ascii?Q?wWCBJoCIOWpbg6ygfcmm?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7fba74-f48d-47e6-f17c-08dc6c5eaf9e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 17:21:51.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6716

On Thu, May 02, 2024 at 03:55:36PM -0700, Kees Cook wrote:
> On Thu, May 02, 2024 at 11:18:37AM +0200, Peter Zijlstra wrote:
> > On Wed, May 01, 2024 at 01:21:42PM -0700, Kees Cook wrote:
> > > On Tue, Apr 30, 2024 at 11:15:04AM +0200, Peter Zijlstra wrote:
> > > > On Mon, Apr 29, 2024 at 07:40:58PM +0200, Erick Archer wrote:
> > > > > This is an effort to get rid of all multiplications from allocation
> > > > > functions in order to prevent integer overflows [1][2].
> > > > 
> > > > So personally I detest struct_size() because I can never remember wtf it
> > > > does, whereas the code it replaces is simple and straight forward :/
> > > 
> > > Sure, new APIs can involved a learning curve. If we can all handle
> > > container_of(), we can deal with struct_size(). :)
> > 
> > containre_of() is actually *much* shorter than typing it all out. Which
> > is a benefit.
> > 
> > struct_size() not so much. That's just obfuscation for obfuscation's
> > sake.

I do not agree with this.
> 
> It's really not -- it's making sure that the calculation is semantically
> sane: all the right things are being used for the struct size calculation
> and things can't "drift", if types change, flex array changes, etc. It's
> both a code robustness improvement and a wrap-around stopping improvement.
> 

Also, in the "Deprecated Interfaces, Language Features, Attributes, and
Conventions" [1] it says verbatim:

   Another common case to avoid is calculating the size of a structure
   with a trailing array of others structures, as in:

   header = kzalloc(sizeof(*header) + count * sizeof(*header->item),
                    GFP_KERNEL);

   Instead, use the helper:

   header = kzalloc(struct_size(header, item, count), GFP_KERNEL);

Therefore, if there is a convention to follow, we should not make an
exception. Moreover, struct_size is widely used in the kernel and
widely accepted. Also makes the code safer.

So, I will send a new patch with the changes Kees proposed and I
hope that it will be the first step in the adoption of struct_size
in the perf and sched subsystems ;)

Regards,
Erick

[1] https://docs.kernel.org/process/deprecated.html

> -- 
> Kees Cook
