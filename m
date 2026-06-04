Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021080.outbound.protection.outlook.com [40.107.192.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8263B4A2E3A;
	Thu,  4 Jun 2026 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593532; cv=fail; b=nrgqCRt4+E+a8jfAn49KaOt+xzcgq3YCAukIojVPLLAMhyS5tCQSIXyd69MAknvcGreJ41ilorDaveYsuvaYPD9quj5QWVKGQt4YGth+/zeeeG3MqE2NV3qlmouDgD3S2nwGWh/USHyHTXBlBYsjkO5FGLFOGXenXC+xbmuqhtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593532; c=relaxed/simple;
	bh=sO4/84yWlicoqgKuzwNZ314xTsyiXP9BUReUVG9QZz8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nbvHhGXKxkuDl5M8DarL6F1UUkV+419LQlurt2CPWo3vehdrV7dLGu9Ml2G/7AaG+RHyf/fhWkgwdPuS7DQ9PWwD2EfUdPLxJduNbKXa+qZTQo9FeTJ8K2zsL3S2avqIifnsEkQ/rzYCp/m6x1bZqNAK2BYq88/jzk5TAp7avh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=AZnYjHGD; arc=fail smtp.client-ip=40.107.192.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="AZnYjHGD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaqHlfFWDJoRcesRb/ft+XynKe0tpCnCiU5dm/NOkC0GJ6ryKt6AyqQ1BvMuqWG+n4FX0sQmM7+T0Lf1XoZWruf5Ury71T4mMGbVN66SOXg0FAw9ZsOemFmbIXL7BSYpm/aza3VVbU8Hu8pQA9sz/CfEPUtHsQEWtKXa2TuMDdQrUxChgeWXYjN/xR7+NRYu2FOU05/FulGovi23r6sv8HfGyYMZmMhGQgrxWdnlQUjdZqhT6fTQDk0UNMvtvlMOMNr1TCBATiEWbJGDiXqt++btrHwVy7PPEMc3Fw82qt8JQuTsEZ5DzozBMdW+hFTgoGFyVa5vVBoBBo4NUJVVog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkuddJ2ls3Y2ztYxwiPDBc/FiG+VHqLkloVzfuTdVJI=;
 b=cDHtPUr+XPlp5OuxeUEXbJmqjrJb6c/rBSV//XdJ7V3NAdKell5OEQs1mHCPiIQ99tDj4dRjXLiirla0ALFWvBEE6v8TCOv2ZDSUoiMZ/SMeIn6bbkdGCcoGC628zKxrTRL50FwYOn4LzYWkYWTeHax9PatHgT3k0ZcnjEpMlYprDCyJf+G1g2R0YtIopGgWexiGrKjX0l2GG/1xKO427KSWG5syyYIS9W77Lxc0PDFgr6EfdFdcXdAe8ltEcmdJwgCuksrg/xhrmGLFUZS7LB8oo00RrhPnBWub4kTz+9k2OB+CaHIbe8yIAbcdty8QARJzQtjXkORR6yisZA+3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkuddJ2ls3Y2ztYxwiPDBc/FiG+VHqLkloVzfuTdVJI=;
 b=AZnYjHGDCQdFi2ELUaQDaR8QPqeu+yHlu5eiMngA6j2joyifLEOSuJhXcuYOqTAfhR8cF44xETf4n1TiTe7+XQVgcCKrl7HzKALVpEbtRhMOH0xY6QUvYEY+fRv5t0RSA+Mv2mxzYerqfPmXGPTBiSQGGZ/PRF3c1yxRlV3xFhMYnhiOimWkzCKn0f3SUWBKFT9VPyDyxiGueoX007VIZBF3D5WeQz09G8XE64VxdM/bSk06UyozwRxzSu9fXfH+kJRGW4qMxStHwmRsIn8/4+E8K8w1ENjKhBGTwDkbhJ2oETCz1NcDyN3E9vNTB9WOBdvufnHTpkQoIMfu2FUwJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6e::20)
 by YQBPR0101MB5524.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:47::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.2; Thu, 4 Jun 2026
 17:18:46 +0000
Received: from YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1ee8:6055:75fe:7c18]) by YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1ee8:6055:75fe:7c18%3]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 17:18:45 +0000
Message-ID: <51de7395-c93a-486d-9076-88a4bece6b69@efficios.com>
Date: Thu, 4 Jun 2026 13:18:44 -0400
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3] perf data ctf: replace libbabeltrace with
 babeltrace2-ctf-writer
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Derek Foreman <derek.foreman@collabora.com>, Ingo Molnar <mingo@redhat.com>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20260512194710.162215-1-mjeanson@efficios.com>
 <20260520191452.218717-1-mjeanson@efficios.com>
 <CAP-5=fUehWvDZB+u1wYGMRa1WD8SUQMqzPqyQB4O78KBa43kOg@mail.gmail.com>
 <aiF9vEuU2A3m0gUq@x1>
From: Michael Jeanson <mjeanson@efficios.com>
Content-Language: fr
Autocrypt: addr=mjeanson@efficios.com; keydata=
 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 IZHa
In-Reply-To: <aiF9vEuU2A3m0gUq@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0384.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::13) To YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:6e::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB6451:EE_|YQBPR0101MB5524:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d797a01-fe8a-44d8-37a4-08dec25d5599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|6133799003|3023799007|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xQQyndZWe4qwJfGNdY7cPFm7SEOdRWOBaA/W1zk6kgGbHT4WcVni9LyYJZJGVLNfIPVxyeenFO12lLufvaUe3mfZDRaZQ+gnaAX92G83aS8ZbkfdX9mSPDncZGODWjxgEDRzCyLpZo4LtmepjwbOdCgO/+AdJY9TzLhuOfHjR5UWzgob30GfshKXxnoiE1M2yBAW7GToB9oAuSiKmMvHR+a2kiuh/cjJ0lVvE9hmQuQp2yVXQsKrLi4naP+57J2aSrAw5L+T5TlccM7aPDoHz0tZ7oRfneTx2lscbDqLI1nwYqrAeSw1pSc9sQ9jR9gyWx2mv2xIPkBIEBNgjSUSj7NTXzrRornbTARwr9VSJ83tG0lXw5Gp8bfjj/rslIAc64nr18VxSPfJ6NecqSQ4wxNRBl/k4n0E4rjmaSHFV8JkGzXgwVAJS+LLqp7bO/UylsRGwIdKf1qbaerb4bIYAsak1sr4+rpvw+16yvETIEy1+hU8d+aCwQwxaQIicQZVHHw/EUrGvJPfIX2r0Nh3dg0VdbElDP8H0dN+6QsabHOd1kvRIrYRD7dghl/ya4oW2yOL8+0ra7RnSasrqGwkHtVUcsilP95gD1ZnPWAOpnFeh6o1LzvjiTuvaIT8GkztRAtC2LuV3zI7i6cxohVVc4/J1/R3cNKTKnI+GZAwALCNJYx+A4RN64PmULZyN9uL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(3023799007)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmZiWUZyK1ZjY3VOdVhDUHRqejVmV3NPSlVPUFkxZnNMTzZWTm1xVSsrQnFv?=
 =?utf-8?B?a0JpZzZqbE4rUjI4N0hwdHNwSlBkRVMvakZNRTZZVkYvTjVnNzNMUWI4SUhV?=
 =?utf-8?B?dlpwMEhOQXBhV2xuVjVjalFCSWR5VEJyT0ZJYzMzZmJ4Q1VqS0R4bnBSc1RE?=
 =?utf-8?B?bVk2dzFxRkRpS3YzR00yVmE4SXFxekRlNmNkTTI1Zy9hRFg5RTRQK3V5M0tK?=
 =?utf-8?B?V3JiMng2ZCtVd2JBaUpydXU4MW0wYTRSc1QrOXc0WGkvUDVVc2hETjBBdXk4?=
 =?utf-8?B?WGo1WlE3akkrK0p1ZnpkRlBxVVI4YUJaZUthOHZkMnVJSzh4ZGR0RU82Wmg4?=
 =?utf-8?B?THhGcmpDU29lM212Nkd5RlUvTEMvNUh3UUNzSUJjQ2twaTZScDlsWTBOdFlN?=
 =?utf-8?B?YUFiUUdqTHpKYlZYU29uOVFidXMrRFpOYlBTdTNTRHErdHU1YkwzUGlEc1Nh?=
 =?utf-8?B?RkR2SUJPeHlOSGs2ZjBRZWhEYkdIZTZ0RFQvL3E4cUJPazZLTnpyenV5Y3Y5?=
 =?utf-8?B?YnJUaFljRE9kdEZiSFErWTNGOS9aamhYWDRjUGFxejBVbXp4a3BOMHpzdXNJ?=
 =?utf-8?B?TkU2TXF5QmplQjhEaTNkRWZIdTFwcGhUbEJFNmVqcy9IT3hCTTErdi83V1lt?=
 =?utf-8?B?UDFoWklLekIxdVhHK1RHL2RtdEsyemU3eENXc2pLLzJPa3B1aXkvRDZKbW5L?=
 =?utf-8?B?Vngvd3dSQ3I2QUx3TW1yTzhGWWV6dUJLMmRZWlBzWTBMOWZBMzU2UGlTRms4?=
 =?utf-8?B?aWYzVjQ5Qm9yL0VWb3o0WGRIOUFpNEh2UnJ1L0laa1JXK0cwNFRqYzVab2JK?=
 =?utf-8?B?QThBSUhaZU84OE1qMCtwN1Rva3BJdUNKTjNGUUZqQzRHcDcvbUdwc0hzRXVX?=
 =?utf-8?B?TS92NGphRnR4clNlQVFBdzdTQ1NCbktwcGVjN2hwcnFFcUt3YXhzbTFpM3Jq?=
 =?utf-8?B?c044dDI3TU83YWZOWUt0eGV2cVUvdWRLYXpoQXVod3NsV2tSTDdtazNZU3lV?=
 =?utf-8?B?OENnZ0RGaXhuK3ByaVhscW5wL1JMYXFXUEMrM2FrblRiZHFWakxBN09pTUJT?=
 =?utf-8?B?RmxORXBrQ1Y1a2RFSk9zV3lxSE93ZDZxRWF0Z3UwcXduYlV0Z3dheHZQb3Fj?=
 =?utf-8?B?YVpabExLRUVWUlJLbW9SUlhIZUVJbGlCaVF5OHhsOFJRdy81TnJsTkZGa2w5?=
 =?utf-8?B?UGNmWEI3SStnbVQvWjVQb0xBVEdGdUx0N2sxSkY1RVluWk14NnczcXh3SWJ1?=
 =?utf-8?B?NS9EWHd4UVR3MEJlSFJ4b25rYkhKYStRWWxiQ3FkUlZiSVVza05NNEtLc04x?=
 =?utf-8?B?ME9OTGsrUGxUZEJYMUd4T0pmeHIxS0Frck91aGliQzNkaE5oMXZpVnJYZGs0?=
 =?utf-8?B?ZFI2WHIvUEZuMFhaTWdTMHpVcGNsVlRRRGRKVUtyd2pXVHF5RnFJeU9RTHV6?=
 =?utf-8?B?UCtWUk9xRlg4Nmk5Wm5OVTFHdktHcWc1VC9WUVNlR0NGNnVocHlzenpDRzVG?=
 =?utf-8?B?cnhkS3lTR2FjMGJTR1hMWG9ud2I2MXQ5WjBqRk1FSFRKbFlyY2x4SmRWeDhj?=
 =?utf-8?B?ZXZ0cmpmOVRjc2tHdWo3TjE1alRJSTBxeTk5ajVKM0wxWGlXS1p3WGdadUJQ?=
 =?utf-8?B?bmg0UGNhOEMzenhIelZZN0RPNUhOYWF3Yy8vdFdrb1BEUXpGSDhUUmdEdktG?=
 =?utf-8?B?eGsvbTFSVEZ0TEphZGQ0SjlRWGgxSzFVWTVSQUxWaHk1bjZJdkR0cFdHQVlI?=
 =?utf-8?B?aW81c2lXQTFsanB6MzNNSTVaOUlia0RUVGRKaU5pdzhLbGxUUnlEZ2FBcVlD?=
 =?utf-8?B?ci9KNzloS1Nibko5U0UySFBmcURUWGpQdW1vVVgreG53SlNON3phVE0yWmpy?=
 =?utf-8?B?dDBnNmN4YVNISkR1SDlrclBwa05neWU4TWxPbXNsUlhHNmZxRlk2Mmo4Vko5?=
 =?utf-8?B?WUN2L21qdzRETEd2RUR4OFpYaVY4ZXhhOWR4ckdhMnZmc1p5WFNRWkVqMTd0?=
 =?utf-8?B?K1VwMWhvZzV4bDdod2xhYWV5Q1BGZ0Z4V1RGYmVvSEpMOEFwWkdXbzllRzlH?=
 =?utf-8?B?ZkhBN1BFNTFKd0lnbXBaUnNMWDN4dGk3SXI0TFFlVGFlVUt6cktua2xXUmZF?=
 =?utf-8?B?dXl5MVJMTVhGSTVPTURkREVpQmxrNklNRXMxTWMrbHV6UjF2M2lNU2xXSkxX?=
 =?utf-8?B?cFRzeXBWbjdoRHZxY2F4cnQ5emlYMkdqUzlRQlBZWXpuN0l0WWNrSXpFRCs0?=
 =?utf-8?B?ODVGR2s0dUNoaElFbU5GTUlhQ0JQVXhyaTVlbUJQU25uckE5c1VNVU1naEdu?=
 =?utf-8?B?YXZaNG9zenlESDgreTViWTNXMWdXaFFFTVd6aTAySGZ4N0UrcFRPZz09?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d797a01-fe8a-44d8-37a4-08dec25d5599
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 17:18:45.8187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLgoYwtAxVn/1JByIKYWdVchvjeRfmcHXw2BBeR2lqcG1bc6xoTMO9c4Y6B3spV+hPyWZ8HQwjQ40su02wUc/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5524

On 2026-06-04 09:29, Arnaldo Carvalho de Melo wrote:
> On Wed, May 20, 2026 at 12:26:13PM -0700, Ian Rogers wrote:
>> On Wed, May 20, 2026 at 12:15 PM Michael Jeanson <mjeanson@efficios.com> wrote:
>>>
>>> The 1.x branch of Babeltrace has been superseded by 2.x in 2020 and has
>>> been unmaintained since 2022, efforts have started to remove it from
>>> popular distributions.
>>>
>>> Babeltrace 2.x offers a very similar 'ctf-writer' library that can be used
>>> with minimal changes for the '--to-ctf' feature and has been packaged
>>> since Debian 11 and Fedora 32.
>>>
>>> This patch replaces the 'libbabeltrace' build feature with
>>> 'babeltrace2-ctf-writer' using pkgconfig detection, adjusts the naming of
>>> the public headers and applies minor API cleanups.
>>>
>>> There is no changes to the output ctf traces, the ctf-writer API still
>>> implements version 1.8 of the CTF specification that can be read by
>>> either Babeltrace 1 / 2 or any CTF compliant reader.
>>>
>>> Also remove some ifdefs in the cli option parsing to allow printing the
>>> helpful error message with '--to-ctf' when built without babeltrace2.
>>>
>>> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>> Cc: Derek Foreman <derek.foreman@collabora.com>
>>> Cc: Ian Rogers <irogers@google.com>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: James Clark <james.clark@linaro.org>
>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>
>> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Its not applying to perf-tools-next, Michael, can you please take a
> look?

Not sure what happenend, I rebased it on current perf-tools-next and 
sent it again as v4. Sorry for the noise.

Michael

> 
> Thanks,
> 
> - Arnaldo

