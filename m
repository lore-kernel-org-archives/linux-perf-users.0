Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021108.outbound.protection.outlook.com [40.107.192.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136D3321BD;
	Wed, 13 May 2026 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681702; cv=fail; b=c81gxk0YDWKWVYOdCmQMY9Fw6qT93Nlmo3bdWKKa8UkqlCJbeVq+HJZ5cnX+cz/FyXVV/f7n2JU7TAzhGNo7+Rx5LwT+ckAnqH7R1q1YQ463Lcnut5YCEDI2+HmHxpDyxPzr8WpEZYy7SqxEDd/FCqXw+RfOs+z/YweoL09Y7dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681702; c=relaxed/simple;
	bh=MFvkHvajoxTk9g4S5mV02lP/o2XqGrVE6zn48q97pTU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bEHYTE9jYsS+z5zD031vJhaI1d8j/ec8TNW3EOZL2xGHxSGrlRU2b4GXbfjPT9f0dqy+ATQNBkPwAXicNlCGuP/3btGNkHTcP6+Yyqk0FnBxP+/4S+YezOqVOoJ9jWRKyKyPqMw9dY2yFLcYOtSSSmiAr4xojOfiAX3uWum8LtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=pJJhFJBB; arc=fail smtp.client-ip=40.107.192.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pJJhFJBB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpDSz/+556es2ZBiiZxVqIpom/u0sIVJVDTXljTZb4qtkRi8O7YIwXwI1I1JNBnhLZlS7xOrGDTsB0JAs+ZvUvMtNnqDqdE+wnv8NO8VfpMlo7mqmo97CnDgVVXaj0xUkVly6wUaN/DWCmjRvTwVClE4/sPml021ESrKY84UT4PS1hPZDkdFv5bKq5FGotjvDhC46bPXgYqSE6q5Z8V6waomZHjil5Hg2v1zGkklQ06QvNNRMdOYEdnLhQdrTSDUfnwgTwA9gRlI/psMVvp+p8y5OL8VaZ4wAkq8u+DxFKQrGHgf7yTqFzjsHyI2yIZMTyuif1uZCGS/WbqVvWHKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EjIZgdyEiwsGREBT6O0mrwv7+8KA0Z4KihF8FyVsEg=;
 b=en6w1+nk8DYUbTd0G/o5j2oPUrwOvd/8DuDWFUtjjt2ZRatpLkR6WBpGXryBTGvfCO7zMy7C9p3VSuG7e68BlnuGa50fmKUOBMdeptHhqcTGBGWM8Wf1VcKQfkzt/7pHcrqVBnZ/fsALWQzkoCCABwtDyWaY+JmOqMeBfTeGp4YRyOy0lADfeTgrQkAVjSsYaYCiApwX6HDH+GBVmBKg+IuW+ceMWDG5R2Y3f2CdPHvRerql7Pv0mQdx33vj2IyPDuPulsOtCnCL6SZxGBJXtkTsIrnyCkt4R1hgLc6csrEGM26UC1aYZkdJKgNMz27SfnwfePQPLgCNhiDzd/QgfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EjIZgdyEiwsGREBT6O0mrwv7+8KA0Z4KihF8FyVsEg=;
 b=pJJhFJBBL0LVt5eBmWgSeHyzz0Xt5cQFaV6fF8CG1GNlZ/GbYoggmVnczhca3PtcmI3ReEoaraxp6oinxwIQIZx6d36T3d3L3AZ+3BIlajfrtnPUf4wCttdn7t8EOhGddX5bpDIDQ1eKWOBTJkpHTOxWym5whAlv37NZF7nGHo9wTLHPATCVJsHq2TKsT9VYh+9LnXRDze0PPsFV2SqYzJ2hk9/73viuSRSOzDldQj8mipJCW+WtKF2t1JInGZ0POOMPSkkt4uHrpwZf1D9G9KEpJYccf4JQ8R4Dg9SCOj4W3INlwDU917qNmxHysJ0bmi10GKjd6hZqKhf9XjQM2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6e::20)
 by YT2PR01MB9398.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Wed, 13 May
 2026 14:14:52 +0000
Received: from YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1ee8:6055:75fe:7c18]) by YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1ee8:6055:75fe:7c18%3]) with mapi id 15.21.0025.012; Wed, 13 May 2026
 14:14:52 +0000
Message-ID: <e6d88ec4-c6fa-473c-ae70-071bb6f040c1@efficios.com>
Date: Wed, 13 May 2026 10:14:50 -0400
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] perf data ctf: replace libbabeltrace with
 babeltrace2-ctf-writer
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Derek Foreman <derek.foreman@collabora.com>, Ingo Molnar <mingo@redhat.com>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20260512194710.162215-1-mjeanson@efficios.com>
 <CAP-5=fXMtbO=7JMg2YvhQNbqOEFH_ze=8EifYM7bDfR945=KHA@mail.gmail.com>
From: Michael Jeanson <mjeanson@efficios.com>
Content-Language: fr, en-US
Autocrypt: addr=mjeanson@efficios.com; keydata=
 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 IZHa
In-Reply-To: <CAP-5=fXMtbO=7JMg2YvhQNbqOEFH_ze=8EifYM7bDfR945=KHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::17) To YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:6e::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB6451:EE_|YT2PR01MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: cf43a645-9aa8-4ec0-2b60-08deb0f9ffd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|3023799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FDlWkCfGtto6PbN/c6IMbVG+SPoBpeUw2a3ClQDIgaPLL2/22pSCWiFqx26p07brYgLKl4YhYc5Rh3tn4UWTkHu+k4bZz71qi4VsjyUL+tZeXDI9DGmZ00wR6NH+TrNA+WBgMx6vZlnQFG82c0hicRIqKv1mnpd9aWReTwujBQ+7U5A3lZhtuEU/nK5EGdSpVClWbuWD6qqzPLNcBBa06ae7gfMJNmEzG3gMSIlZCLzPIYjSd8XWepBYl9danwC3LauDPzUpkJT10mVDnPhHbkw6sCu25n8YYcTVN4J5ZR1FmAYAiTBxYNtRTQM87mvAS8pKW+SEwyXoMzJxLHR7dEVK/gtidKByymtgClYQaroorFFJR3iUN+QHtg2y/N5eziM86CKjofBw7TMuWk9bUIKt+GuYd1hBY0D0WqKpvAG+j4886C+u5QL7EYAkVKnaBKdbmcbi3nfD6nK4MW9eDSFcSDyQgDvs6CyRYTeVcKfAuAhSvADKC5390gaTyoEIEIi4b1F36qkyO6gCWoiutXapVtUOQ9yWZNDiI6hkU+yCzVvVS+3oXAjwsVXJ7vDqCO1YxExuarJWOzp5KRN9UsQgmXOj/CNgnZyAo0roaQ38weJUnWzOu9Wec/aGxPkQmSS6uTHktU+O86MV4ac+W7fabVLCnbC4dqsmwHOcS3w4iBYi0hdXpurFiRCE81gm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(3023799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWU0UC9YTHptRUNIeTRxTFJDQnJnaWVoRVpwT0U4bWREQ0JHcHpyQlhHK1o5?=
 =?utf-8?B?a0FYdVZVOWxla3hvbXdoN21kUkpyRVJMYmdnNEtRbVllb011TFdNZjBUazNF?=
 =?utf-8?B?bStteGs0bmFINEY1akJJVWd0T3Frc1dtSmRKMnJyT2lhdkJNRzc4YThlQjVi?=
 =?utf-8?B?Wm1rTXMxS25DMVdxRWRySk13ODNyV1o1aldTVm5pOXJRU2lzTWRoajNpNjZ1?=
 =?utf-8?B?a09TTEhtcTl4dHdNVzdUemU5Y3FpVEhtWi9rTmM1SkJmV1NzRm0yQmVaKzBM?=
 =?utf-8?B?Uk5BWEpkblB4WlhzSUk4ZlpmUmJHdUFCSTR1d3gvWExwdGZvY1VDelMwTzV6?=
 =?utf-8?B?M215ZXRUNFMrQmNDb1FWamswN1hFUVB6cHlqSHlTR3hUUE9KeDdSeFNadjdK?=
 =?utf-8?B?R2ZZY2tIYXVVdGZhUENEM1lRRlA3cUV4MkZYNDR4YitUbXNYK1lqR2xiM0J4?=
 =?utf-8?B?MzcyYTdzS3BPaURQTGJzTklZOUhVTXV5OXN0TVBFdDViajBEeXFOUW9abUVp?=
 =?utf-8?B?dXB4Y2UrVUgrZjJ4dEx1enVHTnJXdFNmMzZoaVlwT1RXWTQrdWVGdGJZMjRI?=
 =?utf-8?B?NkZjdkY2NzZoOVJzd2JubVIxSGY3UnJnajRzV1JZL0VZV0RQUFBTRTJja3cv?=
 =?utf-8?B?d1UwVWNOQUpJQitZZmVPWDc0aUFocmE0NE1UVnNOWXZseGpJTXVXZHgwbVI2?=
 =?utf-8?B?Z05SUDJuOXBDbXkwTlh2cktCMVZkWmJhclN2ZTcvU3BsL2R2ZENkWWxGNUkz?=
 =?utf-8?B?c2ZveGs1a3ExRjU1QlRvN1RjRE9nc1AvS1NlMzlYQ0sxcmpNNGhBK3A5eHpr?=
 =?utf-8?B?cGw5a0ZhQTVEQ1JTMkV6WGRXTDZINEtnQ2V4REsyMFdLdjlxUTdKUGI3ZlRI?=
 =?utf-8?B?RzhRY1loVEMwRzI5ZjlsbklpM292bkN1eDVUVnVaeVdGMXpncE9CVDJZQzI0?=
 =?utf-8?B?NllpTHpacTdOV1oxMnFXNEpSdmJLRW1uSmlzM1hWamF2dCtNVVYxUjR4NTNi?=
 =?utf-8?B?eUVCVUpLbWcvY2tkOHl4RjlLSGJPT2dZcVBFNHBBc3VnR1c3MHpnM2xzTWt4?=
 =?utf-8?B?ditqUE9ld0lEZjk0R0ZNNlFjc3hsR0QwT2pPT3haTzFyQ3ovR2ZOc3hZbzcy?=
 =?utf-8?B?QjE2QkIwYmJyS3JVb1Fvanh5Ykw1NjdQZkljNnE5SVRZTCtJWFRFaUNrTmlO?=
 =?utf-8?B?YmVGNW9qYzFQV1NQL3h4ZTB5WjRKKzZkazVzck5qK2hZVVp0d28waWQ1SFpU?=
 =?utf-8?B?STdXZTFWVkEwSDQ3bGlxbHphQThuRVFJYUVLL2haTVhkRUZJNGwyUXJJVzJK?=
 =?utf-8?B?b2Zoc1RSdmd5SFVmTFkweXpsTWJLTEZaL2xrT1ZQN1Y1UlpoWkdQcVNPZlBT?=
 =?utf-8?B?VkxUWFRwdWRsOXdqR0dQUm43ZWpyY203M3d5aXlnVWxDNktYTzdYNmx2Uk9i?=
 =?utf-8?B?c29EQ1YwaXF6YkFHZ3lOclZxNXNyREZyT3lYTzc5eDF5Myt2cWxqZktvUk9v?=
 =?utf-8?B?cXh3WkhZY2xveTB2R3UrS3ZOdDlCbytkMGQ1WVlCY2g2Q0RwSHk5QjdHbFRu?=
 =?utf-8?B?ZUlyT1NicDg0cHNGOXZ2ZGZRQjJXazQ3SjJyYlUyc2M2TEZvYXJQcHpoL3pF?=
 =?utf-8?B?SUFjVFJqT3N2WmZPUjFPaFNSMUhHMUFuN3lHekdnT1UvU0p2NWRsK3pQczRR?=
 =?utf-8?B?M2FBSCtDbXN4b0tZbHc3SnFzR0xuTFI4Zms5bEJjRlEvdWd3ZjRTcnZoSlRh?=
 =?utf-8?B?SjZia3p3bUdqaUJxRjFVMnpnTFRhbGhYcTM5a2JDV1BaUDJ3VWFMNU1ZQ3V5?=
 =?utf-8?B?bU5uWENBWmkwdzNrVEJheGVXTFBtRTRMQW1kdTJGdUt1eDUrMEpWaURlUWRx?=
 =?utf-8?B?b0VVZDA0ejkyWUVBSk5NanRqMWEvRXo5R0NJY3RCbms3U0QyUEJDNVpEUnBs?=
 =?utf-8?B?dzhOVy9QNGlrN0JGYTBEM25NSVhxaUFtU1dST2RPZWxjZGFaZGdnTVYwSXFz?=
 =?utf-8?B?aGErOGNXa3B5MXJ2SlNPQ0lNVlFIMzdEYnk4Lys3cGdRRUsxbHZ4QzQ1SnBz?=
 =?utf-8?B?YzJLc0hTNlo4RkZ6dFJXcDNXemVPM0FhQlRwVHpUcjA3NGpPbkZodUdwdEtS?=
 =?utf-8?B?d0FuRk53RVV1b2Q4WlIwS1VxaEdtQnQ4MHpDMG91M25XT2s5MVNpcFg0cm52?=
 =?utf-8?B?STk3bUdRMFp3QVlybmpXa2Nkd01uS0JJLzYyV3FSbk9FR3hIUVRPcjBzYUt5?=
 =?utf-8?B?ZVVzM1grUzZ2bTBVMEJwNEFESFlRL2YrM0ZmT1B4UGo1MkFxWUszYU85ZDdT?=
 =?utf-8?B?RXd3N2JLanN4NTlxVE00LzE3RzFsVit1UEViRnluMnB1NEhhRDdYUT09?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf43a645-9aa8-4ec0-2b60-08deb0f9ffd0
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB6451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:14:52.0130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRqHexshnl/eJoVbee7W97/n556iaKU3ve7OjXJ04Wh+OxOJEkkrkPFpsZ4YzQB8LD0z7ebZ6noS75o8SNINLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9398

On 2026-05-12 17:54, Ian Rogers wrote:
> On Tue, May 12, 2026 at 12:47 PM Michael Jeanson <mjeanson@efficios.com> wrote:
>>
>> The 1.x branch of Babeltrace has been superseded by 2.x in 2020 and has
>> been unmaintained since 2022, efforts have started to remove it from
>> popular distributions.
>>
>> Babeltrace 2.x offers a very similar 'ctf-writer' library that can be used
>> with minimal changes for the '--to-ctf' feature and has been packaged
>> since Debian 11 and Fedora 32.
>>
>> This patch replaces the 'libbabeltrace' build feature with
>> 'babeltrace2-ctf-writer' using pkgconfig detection, adjusts the naming of
>> the public headers and applies minor API cleanups.
>>
>> No changes to the output ctf traces, this API still implements version
>> 1.8 of the CTF specification that can be read by either Babeltrace 1 / 2
>> or any CTF compliant reader.
>>
>> Also remove some ifdefs in the cli option parsing to allow printing the
>> helpful error message with '--to-ctf' when built without babeltrace2.
>>
>> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Derek Foreman <derek.foreman@collabora.com>
>> Cc: Ian Rogers <irogers@google.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: James Clark <james.clark@linaro.org>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> ---
>>   tools/build/Makefile.feature                  |  5 +--
>>   tools/build/feature/Makefile                  |  6 ++--
>>   tools/build/feature/test-all.c                | 13 ++------
>>   ...ltrace.c => test-babeltrace2-ctf-writer.c} |  3 +-
>>   tools/perf/Makefile.config                    | 28 ++++++++--------
>>   tools/perf/Makefile.perf                      |  2 +-
>>   tools/perf/builtin-check.c                    |  2 +-
>>   tools/perf/builtin-data.c                     | 18 +++-------
>>   tools/perf/tests/make                         |  4 +--
>>   .../shell/test_perf_data_converter_ctf.sh     |  8 ++---
>>   tools/perf/util/Build                         |  2 +-
>>   tools/perf/util/data-convert-bt.c             | 33 +++++++++----------
>>   tools/perf/util/data-convert.h                |  4 +--
>>   13 files changed, 55 insertions(+), 73 deletions(-)
>>   rename tools/build/feature/{test-libbabeltrace.c => test-babeltrace2-ctf-writer.c} (59%)
>>
>> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
>> index 0b7a7c38cb88..9e097144817e 100644
>> --- a/tools/build/Makefile.feature
>> +++ b/tools/build/Makefile.feature
>> @@ -113,7 +113,7 @@ FEATURE_TESTS_EXTRA :=                  \
>>            gtk2                           \
>>            gtk2-infobar                   \
>>            hello                          \
>> -         libbabeltrace                  \
>> +         babeltrace2-ctf-writer         \
>>            libcapstone                    \
>>            libbfd-liberty                 \
>>            libbfd-liberty-z               \
>> @@ -162,6 +162,7 @@ FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z
>>   # Declare list of feature dependency packages that provide pkg-config files.
>>   #
>>   FEATURE_PKG_CONFIG ?=           \
>> +        babeltrace2-ctf-writer \
>>            libtraceevent          \
>>            libtracefs
>>
>> @@ -208,7 +209,7 @@ ifeq ($(feature-all), 1)
>>     $(call feature_check,compile-32)
>>     $(call feature_check,compile-x32)
>>     $(call feature_check,bionic)
>> -  $(call feature_check,libbabeltrace)
>> +  $(call feature_check,babeltrace2-ctf-writer)
>>   else
>>     $(foreach feat,$(FEATURE_TESTS),$(call feature_check,$(feat)))
>>   endif
>> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
>> index 1fbcb3ce74d2..7735e257c263 100644
>> --- a/tools/build/feature/Makefile
>> +++ b/tools/build/feature/Makefile
>> @@ -48,7 +48,7 @@ FILES=                                          \
>>            test-pthread-barrier.bin              \
>>            test-stackprotector-all.bin            \
>>            test-timerfd.bin                       \
>> -         test-libbabeltrace.bin                 \
>> +         test-babeltrace2-ctf-writer.bin        \
>>            test-libcapstone.bin                  \
>>            test-compile-32.bin                    \
>>            test-compile-x32.bin                   \
>> @@ -301,8 +301,8 @@ $(OUTPUT)test-backtrace.bin:
>>   $(OUTPUT)test-timerfd.bin:
>>          $(BUILD)
>>
>> -$(OUTPUT)test-libbabeltrace.bin:
>> -       $(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libbabeltrace)
>> +$(OUTPUT)test-babeltrace2-ctf-writer.bin:
>> +       $(BUILD) # -lbabeltrace2-ctf-writer provided by $(FEATURE_CHECK_LDFLAGS-babeltrace2-ctf-writer)
>>
>>   $(OUTPUT)test-libcapstone.bin:
>>          $(BUILD) # -lcapstone provided by $(FEATURE_CHECK_LDFLAGS-libcapstone)
>> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
>> index 1488bf6e6078..145abdee049d 100644
>> --- a/tools/build/feature/test-all.c
>> +++ b/tools/build/feature/test-all.c
>> @@ -98,17 +98,9 @@
>>   # include "test-sched_getcpu.c"
>>   #undef main
>>
>> -# if 0
>> -/*
>> - * Disable libbabeltrace check for test-all, because the requested
>> - * library version is not released yet in most distributions. Will
>> - * reenable later.
>> - */
>> -
>> -#define main main_test_libbabeltrace
>> -# include "test-libbabeltrace.c"
>> +#define main main_test_babeltrace2_ctf_writer
>> +# include "test-babeltrace2-ctf-writer.c"
> 
> So I still think the comment about libbabeltrace is probably valid:
> most distributions won't have it by default, so a separate test is
> likely better than testing with test-all. You also need to update
> FEATURE_TESTS_BASIFEATURE_TESTS_BASIC.

I went by the comment in 'Makefile.feature' that says features in 
FEATURE_TESTS_EXTRA should be included in 'test-all.c'. I'll remove it.

> 
>>   #undef main
>> -#endif
>>
>>   #define main main_test_lzma
>>   # include "test-lzma.c"
>> @@ -178,6 +170,7 @@ int main(int argc, char *argv[])
>>          main_test_libzstd();
>>          main_test_libtraceevent();
>>          main_test_libopenssl();
>> +       main_test_babeltrace2_ctf_writer();
>>
>>          return 0;
>>   }
>> diff --git a/tools/build/feature/test-libbabeltrace.c b/tools/build/feature/test-babeltrace2-ctf-writer.c
>> similarity index 59%
>> rename from tools/build/feature/test-libbabeltrace.c
>> rename to tools/build/feature/test-babeltrace2-ctf-writer.c
>> index 10bb69d55694..9c89082e9f88 100644
>> --- a/tools/build/feature/test-libbabeltrace.c
>> +++ b/tools/build/feature/test-babeltrace2-ctf-writer.c
>> @@ -1,7 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>
>> -#include <babeltrace/ctf-writer/writer.h>
>> -#include <babeltrace/ctf-ir/stream-class.h>
>> +#include <babeltrace2-ctf-writer/writer.h>
>>
>>   int main(void)
>>   {
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index 15fbba9f4ca8..f2f5051c94e3 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -196,13 +196,13 @@ FEATURE_CHECK_CFLAGS-libdw := $(LIBDW_CFLAGS)
>>   FEATURE_CHECK_LDFLAGS-libdw := $(LIBDW_LDFLAGS) $(DWARFLIBS)
>>
>>   # for linking with debug library, run like:
>> -# make DEBUG=1 LIBBABELTRACE_DIR=/opt/libbabeltrace/
>> -ifdef LIBBABELTRACE_DIR
>> -  LIBBABELTRACE_CFLAGS  := -I$(LIBBABELTRACE_DIR)/include
>> -  LIBBABELTRACE_LDFLAGS := -L$(LIBBABELTRACE_DIR)/lib
>> +# make DEBUG=1 PKG_CONFIG_PATH=/opt/babeltrace2/(lib|lib64)/pkgconfig
> 
> Delete?

Sure.

> 
>> +
>> +ifneq ($(NO_BABELTRACE2),1)
>> +  ifeq ($(call get-executable,$(PKG_CONFIG)),)
>> +    $(error Error: $(PKG_CONFIG) needed by babeltrace2 is missing on this system, please install it)
>> +  endif
>>   endif
>> -FEATURE_CHECK_CFLAGS-libbabeltrace := $(LIBBABELTRACE_CFLAGS)
>> -FEATURE_CHECK_LDFLAGS-libbabeltrace := $(LIBBABELTRACE_LDFLAGS) -lbabeltrace-ctf
>>
>>   # for linking with debug library, run like:
>>   # make DEBUG=1 LIBCAPSTONE_DIR=/opt/capstone/
>> @@ -1058,15 +1058,15 @@ else
>>     NO_PERF_READ_VDSOX32 := 1
>>   endif
>>
>> -ifndef NO_LIBBABELTRACE
>> -  $(call feature_check,libbabeltrace)
>> -  ifeq ($(feature-libbabeltrace), 1)
>> -    CFLAGS += -DHAVE_LIBBABELTRACE_SUPPORT $(LIBBABELTRACE_CFLAGS)
>> -    LDFLAGS += $(LIBBABELTRACE_LDFLAGS)
>> -    EXTLIBS += -lbabeltrace-ctf
>> -    $(call detected,CONFIG_LIBBABELTRACE)
>> +ifndef NO_BABELTRACE2
>> +  $(call feature_check,babeltrace2-ctf-writer)
>> +  ifeq ($(feature-babeltrace2-ctf-writer), 1)
>> +    CFLAGS += -DHAVE_BABELTRACE2_SUPPORT $(shell $(PKG_CONFIG) --cflags babeltrace2-ctf-writer)
>> +    LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L babeltrace2-ctf-writer)
>> +    EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l babeltrace2-ctf-writer)
>> +    $(call detected,CONFIG_BABELTRACE2)
>>     else
>> -    $(warning No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev)
>> +    $(warning No babeltrace2 found, disables 'perf data' CTF format support, please install libbabeltrace2-dev[el])
>>     endif
>>   endif
>>
>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>> index f7b936deeaa2..1f4e84a8472e 100644
>> --- a/tools/perf/Makefile.perf
>> +++ b/tools/perf/Makefile.perf
>> @@ -79,7 +79,7 @@ include ../scripts/utilities.mak
>>   #
>>   # Define NO_ZLIB if you do not want to support compressed kernel modules
>>   #
>> -# Define NO_LIBBABELTRACE if you do not want libbabeltrace support
>> +# Define NO_BABELTRACE2 if you do not want babeltrace2-ctf-writer support
>>   # for CTF data format.
>>   #
>>   # Define NO_CAPSTONE if you do not want libcapstone support
>> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
>> index 3641d263b345..e9d14a960a03 100644
>> --- a/tools/perf/builtin-check.c
>> +++ b/tools/perf/builtin-check.c
>> @@ -43,7 +43,7 @@ struct feature_status supported_features[] = {
>>          FEATURE_STATUS("dwarf_getlocations", HAVE_LIBDW_SUPPORT),
>>          FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
>>          FEATURE_STATUS_TIP("libbfd", HAVE_LIBBFD_SUPPORT, "Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el]"),
>> -       FEATURE_STATUS("libbabeltrace", HAVE_LIBBABELTRACE_SUPPORT),
>> +       FEATURE_STATUS("babeltrace2-ctf-writer", HAVE_BABELTRACE2_SUPPORT),
>>          FEATURE_STATUS("libbpf-strings", HAVE_LIBBPF_STRINGS_SUPPORT),
>>          FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
>>          FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
>> diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
>> index 85f59886b5cf..260d74476439 100644
>> --- a/tools/perf/builtin-data.c
>> +++ b/tools/perf/builtin-data.c
>> @@ -40,10 +40,8 @@ const struct option data_options[] = {
>>                  OPT_INCR('v', "verbose", &verbose, "be more verbose"),
>>                  OPT_STRING('i', "input", &input_name, "file", "input file name"),
>>                  OPT_STRING(0, "to-json", &to_json, NULL, "Convert to JSON format"),
>> -#ifdef HAVE_LIBBABELTRACE_SUPPORT
>>                  OPT_STRING(0, "to-ctf", &to_ctf, NULL, "Convert to CTF format"),
>>                  OPT_BOOLEAN(0, "tod", &opts.tod, "Convert time to wall clock time"),
>> -#endif
>>                  OPT_BOOLEAN('f', "force", &opts.force, "don't complain, do it"),
>>                  OPT_BOOLEAN(0, "all", &opts.all, "Convert all events"),
>>                  OPT_STRING(0, "time", &opts.time_str, "str",
>> @@ -65,29 +63,21 @@ static int cmd_data_convert(int argc, const char **argv)
>>                  pr_err("You cannot specify both --to-ctf and --to-json.\n");
>>                  return -1;
>>          }
>> -#ifdef HAVE_LIBBABELTRACE_SUPPORT
>>          if (!to_json && !to_ctf) {
>>                  pr_err("You must specify one of --to-ctf or --to-json.\n");
>>                  return -1;
>>          }
>> -#else
>> -       if (!to_json) {
>> -               pr_err("You must specify --to-json.\n");
>> -       return -1;
>> -}
>> -#endif
>>
>>          if (to_json)
>>                  return bt_convert__perf2json(input_name, to_json, &opts);
>>
>>          if (to_ctf) {
>> -#if defined(HAVE_LIBBABELTRACE_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
>> +#if defined(HAVE_BABELTRACE2_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
>>                  return bt_convert__perf2ctf(input_name, to_ctf, &opts);
>>   #else
>> -               pr_err("The libbabeltrace support is not compiled in. perf should be "
>> -                      "compiled with environment variables LIBBABELTRACE=1 and "
>> -                      "LIBBABELTRACE_DIR=/path/to/libbabeltrace/.\n"
>> -                      "Check also if libbtraceevent devel files are available.\n");
>> +               pr_err("The babeltrace2 support is not compiled in. Ensure you have both\n"
>> +                       "libbabeltrace2-dev[el] and libtraceevent-dev[el] installed or set\n"
>> +                       "PKG_CONFIG_PATH to find a local installation of those libraries.\n");
>>                  return -1;
>>   #endif
>>          }
>> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
>> index 6587dc326d1b..04f9b686cec0 100644
>> --- a/tools/perf/tests/make
>> +++ b/tools/perf/tests/make
>> @@ -93,7 +93,7 @@ make_no_libbpf            := NO_LIBBPF=1
>>   make_libbpf_dynamic := LIBBPF_DYNAMIC=1
>>   make_no_libbpf_DEBUG := NO_LIBBPF=1 DEBUG=1
>>   make_no_libllvm     := NO_LIBLLVM=1
>> -make_with_babeltrace:= LIBBABELTRACE=1
>> +make_with_babeltrace2 := BABELTRACE2=1
>>   make_with_coresight := CORESIGHT=1
>>   make_no_sdt        := NO_SDT=1
>>   make_no_libpfm4     := NO_LIBPFM4=1
>> @@ -170,7 +170,7 @@ run += make_no_libbpf_DEBUG
>>   run += make_no_libllvm
>>   run += make_no_sdt
>>   run += make_no_syscall_tbl
>> -run += make_with_babeltrace
>> +run += make_with_babeltrace2
>>   run += make_with_coresight
>>   run += make_with_clangllvm
>>   run += make_no_libpfm4
>> diff --git a/tools/perf/tests/shell/test_perf_data_converter_ctf.sh b/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
>> index 334eebc9945e..65d49a10c028 100755
>> --- a/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
>> +++ b/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
>> @@ -24,11 +24,11 @@ trap_cleanup()
>>   }
>>   trap trap_cleanup exit term int
>>
>> -check_babeltrace_support()
>> +check_babeltrace2_support()
>>   {
>> -       if ! perf check feature libbabeltrace
>> +       if ! perf check feature babeltrace2-ctf-writer
>>          then
>> -               echo "perf not linked with libbabeltrace, skipping test"
>> +               echo "perf not linked with libbabeltrace2-ctf-writer, skipping test"
>>                  exit 2
>>          fi
>>   }
>> @@ -97,7 +97,7 @@ test_ctf_converter_pipe()
>>          fi
>>   }
>>
>> -check_babeltrace_support
>> +check_babeltrace2_support
>>   test_ctf_converter_file
>>   test_ctf_converter_pipe
>>
>> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
>> index bcccad7487a9..7f3b67c8eeab 100644
>> --- a/tools/perf/util/Build
>> +++ b/tools/perf/util/Build
>> @@ -233,7 +233,7 @@ perf-util-$(CONFIG_LIBUNWIND_X86)      += libunwind/x86_32.o
>>   perf-util-$(CONFIG_LIBUNWIND_AARCH64)  += libunwind/arm64.o
>>
>>   ifeq ($(CONFIG_LIBTRACEEVENT),y)
>> -  perf-util-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
>> +  perf-util-$(CONFIG_BABELTRACE2) += data-convert-bt.o
>>   endif
>>
>>   perf-util-y += data-convert-json.o
>> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
>> index ba1c8e48d495..91d8cdc9e8c7 100644
>> --- a/tools/perf/util/data-convert-bt.c
>> +++ b/tools/perf/util/data-convert-bt.c
>> @@ -11,14 +11,13 @@
>>   #include <linux/compiler.h>
>>   #include <linux/kernel.h>
>>   #include <linux/zalloc.h>
>> -#include <babeltrace/ctf-writer/writer.h>
>> -#include <babeltrace/ctf-writer/clock.h>
>> -#include <babeltrace/ctf-writer/stream.h>
>> -#include <babeltrace/ctf-writer/event.h>
>> -#include <babeltrace/ctf-writer/event-types.h>
>> -#include <babeltrace/ctf-writer/event-fields.h>
>> -#include <babeltrace/ctf-ir/utils.h>
>> -#include <babeltrace/ctf/events.h>
>> +#include <babeltrace2-ctf-writer/writer.h>
>> +#include <babeltrace2-ctf-writer/clock.h>
>> +#include <babeltrace2-ctf-writer/stream.h>
>> +#include <babeltrace2-ctf-writer/event.h>
>> +#include <babeltrace2-ctf-writer/event-types.h>
>> +#include <babeltrace2-ctf-writer/event-fields.h>
>> +#include <babeltrace2-ctf-writer/utils.h>
> 
> This is cool, I'm surprised at how non-invasive the change is. I'd
> done a similar thing but keeping both babeltrace 1 and 2. I'll post my
> WIP in reply just as a heads up, but I have to do much more heavy
> engineering.

I think I can rework this to try babeltrace2-ctf-writer first and fall 
back on libbabeltrace1. The change is non-invasive because 
bt2-ctf-writer is basically just a compat API for the ctf-writer of bt1 
but it doesn't expose any of the new features of bt2.

Your WIP patch that uses the proper libbabeltrace2 API is definitely the 
way to go for the long term. In the meantime would you like a v2 of this 
patch?

Cheers,

Michael

> 
> Thanks,
> Ian
> 
>>   #include "asm/bug.h"
>>   #include "data-convert.h"
>>   #include "session.h"
>> @@ -121,13 +120,13 @@ static int value_set(struct bt_ctf_field_type *type,
>>          }
>>
>>          if (sign) {
>> -               ret = bt_ctf_field_signed_integer_set_value(field, val);
>> +               ret = bt_ctf_field_integer_signed_set_value(field, val);
>>                  if (ret) {
>>                          pr_err("failed to set field value %s\n", name);
>>                          goto err;
>>                  }
>>          } else {
>> -               ret = bt_ctf_field_unsigned_integer_set_value(field, val);
>> +               ret = bt_ctf_field_integer_unsigned_set_value(field, val);
>>                  if (ret) {
>>                          pr_err("failed to set field value %s\n", name);
>>                          goto err;
>> @@ -374,10 +373,10 @@ static int add_tracepoint_field_value(struct ctf_writer *cw,
>>                                          data + offset + i * len, len);
>>
>>                          if (!(flags & TEP_FIELD_IS_SIGNED))
>> -                               ret = bt_ctf_field_unsigned_integer_set_value(
>> +                               ret = bt_ctf_field_integer_unsigned_set_value(
>>                                                  field, value_int);
>>                          else
>> -                               ret = bt_ctf_field_signed_integer_set_value(
>> +                               ret = bt_ctf_field_integer_signed_set_value(
>>                                                  field, adjust_signedness(value_int, len));
>>                  }
>>
>> @@ -471,7 +470,7 @@ add_bpf_output_values(struct bt_ctf_event_class *event_class,
>>                  goto put_len_type;
>>          }
>>
>> -       ret = bt_ctf_field_unsigned_integer_set_value(len_field, nr_elements);
>> +       ret = bt_ctf_field_integer_unsigned_set_value(len_field, nr_elements);
>>          if (ret) {
>>                  pr_err("failed to set field value for raw_len\n");
>>                  goto put_len_field;
>> @@ -500,7 +499,7 @@ add_bpf_output_values(struct bt_ctf_event_class *event_class,
>>                  struct bt_ctf_field *elem_field =
>>                          bt_ctf_field_sequence_get_field(seq_field, i);
>>
>> -               ret = bt_ctf_field_unsigned_integer_set_value(elem_field,
>> +               ret = bt_ctf_field_integer_unsigned_set_value(elem_field,
>>                                  ((u32 *)(sample->raw_data))[i]);
>>
>>                  bt_ctf_field_put(elem_field);
>> @@ -545,7 +544,7 @@ add_callchain_output_values(struct bt_ctf_event_class *event_class,
>>                  goto put_len_type;
>>          }
>>
>> -       ret = bt_ctf_field_unsigned_integer_set_value(len_field, nr_elements);
>> +       ret = bt_ctf_field_integer_unsigned_set_value(len_field, nr_elements);
>>          if (ret) {
>>                  pr_err("failed to set field value for perf_callchain_size\n");
>>                  goto put_len_field;
>> @@ -575,7 +574,7 @@ add_callchain_output_values(struct bt_ctf_event_class *event_class,
>>                  struct bt_ctf_field *elem_field =
>>                          bt_ctf_field_sequence_get_field(seq_field, i);
>>
>> -               ret = bt_ctf_field_unsigned_integer_set_value(elem_field,
>> +               ret = bt_ctf_field_integer_unsigned_set_value(elem_field,
>>                                  ((u64 *)(callchain->ips))[i]);
>>
>>                  bt_ctf_field_put(elem_field);
>> @@ -728,7 +727,7 @@ static struct ctf_stream *ctf_stream__create(struct ctf_writer *cw, int cpu)
>>                  goto out;
>>          }
>>
>> -       ret = bt_ctf_field_unsigned_integer_set_value(cpu_field, (u32) cpu);
>> +       ret = bt_ctf_field_integer_unsigned_set_value(cpu_field, (u32) cpu);
>>          if (ret) {
>>                  pr_err("Failed to update CPU number\n");
>>                  goto out;
>> diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-convert.h
>> index ee651fa680a1..d174e6f2729d 100644
>> --- a/tools/perf/util/data-convert.h
>> +++ b/tools/perf/util/data-convert.h
>> @@ -11,10 +11,10 @@ struct perf_data_convert_opts {
>>          const char *time_str;
>>   };
>>
>> -#ifdef HAVE_LIBBABELTRACE_SUPPORT
>> +#ifdef HAVE_BABELTRACE2_SUPPORT
>>   int bt_convert__perf2ctf(const char *input_name, const char *to_ctf,
>>                           struct perf_data_convert_opts *opts);
>> -#endif /* HAVE_LIBBABELTRACE_SUPPORT */
>> +#endif /* HAVE_BABELTRACE2_SUPPORT */
>>
>>   int bt_convert__perf2json(const char *input_name, const char *to_ctf,
>>                           struct perf_data_convert_opts *opts);
>> --
>> 2.47.3
>>

