Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2402003AE;
	Tue, 12 Nov 2024 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425246; cv=none; b=RpsigfZA9UHPUgpgcUP/2/axjIQVByIzn8obV3bbyWUB7h8ei/El1x7Jx4HOMtJ5k+CDTnu0z7+wD1j9pLqYEH7zs0lp15qb2Og25U9o8e/kw2ZKTL0Jte/5qjVYL6fbwPXQHpLG7fharKhLHpN7E5hlS8ek9cN8wZOWWUe8HcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425246; c=relaxed/simple;
	bh=vhCCncqYGmUdJ7NTEzYzq4itwiEnrYNxZG/mvhBCWH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=odbqTB2sY9mBpzQkHtFrYrRC/MfA3haB1zFQ881eBk1b+RGJYZ9PtDV45Yfdo4tfM9tTPYUJm4FqkQkIfAEndRI+9JoS3M29XvKqEw54dcqzNf040puhcmckZBdYBzvZEEaK5U2tVAM/puSUpKldkM35Ajhy2QDOykfxdnc+Hls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=1NYh8DoK; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="1NYh8DoK"
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACCtRHK004345;
	Tue, 12 Nov 2024 16:26:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	9C5jRymTu4hAN9ZEjiTRkIi2mPHYWLZOhaiYPKeGVbM=; b=1NYh8DoKIs8pyMQ9
	Q0o4Fg5BT9nUzH8SEr+auHwRZErZiEcEpwVAp7oAQiSyKvRU+3k99Uh8ibSRaROC
	G2er62hfn/8eCaY4+4NIDYO5DxDLdSs1xJI9JtrfOvH6NKmF7eBO9xzPjV6LeFVV
	WwyembtjC9snEsz9U86/rd6OAAxVbVTE+GLqKVBgSP8VFywDV0A9g4mfAanYS0+d
	6rukitQNlWKEyFL4CQWk2Ygi/2xk8hFHyiZwqxSoXFaTt/VksCCuB+xxj7/1uoWb
	J3JxpVtigxsp8AWcGbIuAGIacCL+sFCoF99+8qH+rzzr1g7f0qJHiU1DIaIzRvVW
	4YFW3w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42syggmu2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 16:26:47 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1E2EB4004A;
	Tue, 12 Nov 2024 16:25:20 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BA2A22BEF8D;
	Tue, 12 Nov 2024 16:24:26 +0100 (CET)
Received: from [10.48.87.2] (10.48.87.2) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 12 Nov
 2024 16:24:25 +0100
Message-ID: <3ccc6d4d-cfbc-49ba-8d7a-5ef867fa0f37@foss.st.com>
Date: Tue, 12 Nov 2024 16:24:17 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf list: Fix topic and pmu_name argument order
To: Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo
	<acme@kernel.org>
CC: "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim
	<namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Junhao He <hejunhao3@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241109025801.560378-1-irogers@google.com>
 <7676a058-e7ae-4c6b-a9f8-be450b64f5e1@linux.intel.com> <ZzJAQeHqFT_Z9JiW@x1>
 <CAP-5=fXEe+O+pctnO-MhCLrX071uvkLzA-L9AWP=LR81YKYG6Q@mail.gmail.com>
Content-Language: en-US
From: Jean-philippe ROMAIN <jean-philippe.romain@foss.st.com>
In-Reply-To: <CAP-5=fXEe+O+pctnO-MhCLrX071uvkLzA-L9AWP=LR81YKYG6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01


On 11/11/24 19:20, Ian Rogers wrote:
> On Mon, Nov 11, 2024 at 9:35 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>> On Mon, Nov 11, 2024 at 09:48:41AM -0500, Liang, Kan wrote:
>>>
>>> On 2024-11-08 9:58 p.m., Ian Rogers wrote:
>>>> From: Jean-Philippe Romain <jean-philippe.romain@foss.st.com>
>>>>
>>>> Fix function definitions to match header file declaration. Fix two
>>>> callers to pass the arguments in the right order.
>>>>
>>>> On Intel Tigerlake, before:
>>>> ```
>>>> $ perf list -j|grep "\"Topic\""|sort|uniq
>>>>          "Topic": "cache",
>>>>          "Topic": "cpu",
>>>>          "Topic": "floating point",
>>>>          "Topic": "frontend",
>>>>          "Topic": "memory",
>>>>          "Topic": "other",
>>>>          "Topic": "pfm icl",
>>>>          "Topic": "pfm ix86arch",
>>>>          "Topic": "pfm perf_raw",
>>>>          "Topic": "pipeline",
>>>>          "Topic": "tool",
>>>>          "Topic": "uncore interconnect",
>>>>          "Topic": "uncore memory",
>>>>          "Topic": "uncore other",
>>>>          "Topic": "virtual memory",
>>>> $ perf list -j|grep "\"Unit\""|sort|uniq
>>>>          "Unit": "cache",
>>>>          "Unit": "cpu",
>>>>          "Unit": "cstate_core",
>>>>          "Unit": "cstate_pkg",
>>>>          "Unit": "i915",
>>>>          "Unit": "icl",
>>>>          "Unit": "intel_bts",
>>>>          "Unit": "intel_pt",
>>>>          "Unit": "ix86arch",
>>>>          "Unit": "msr",
>>>>          "Unit": "perf_raw",
>>>>          "Unit": "power",
>>>>          "Unit": "tool",
>>>>          "Unit": "uncore_arb",
>>>>          "Unit": "uncore_clock",
>>>>          "Unit": "uncore_imc_free_running_0",
>>>>          "Unit": "uncore_imc_free_running_1",
>>>> ```
>>>>
>>>> After:
>>>> ```
>>>> $ perf list -j|grep "\"Topic\""|sort|uniq
>>>>          "Topic": "cache",
>>>>          "Topic": "floating point",
>>>>          "Topic": "frontend",
>>>>          "Topic": "memory",
>>>>          "Topic": "other",
>>>>          "Topic": "pfm icl",
>>>>          "Topic": "pfm ix86arch",
>>>>          "Topic": "pfm perf_raw",
>>>>          "Topic": "pipeline",
>>>>          "Topic": "tool",
>>>>          "Topic": "uncore interconnect",
>>>>          "Topic": "uncore memory",
>>>>          "Topic": "uncore other",
>>>>          "Topic": "virtual memory",
>>>> $ perf list -j|grep "\"Unit\""|sort|uniq
>>>>          "Unit": "cpu",
>>>>          "Unit": "cstate_core",
>>>>          "Unit": "cstate_pkg",
>>>>          "Unit": "i915",
>>>>          "Unit": "icl",
>>>>          "Unit": "intel_bts",
>>>>          "Unit": "intel_pt",
>>>>          "Unit": "ix86arch",
>>>>          "Unit": "msr",
>>>>          "Unit": "perf_raw",
>>>>          "Unit": "power",
>>>>          "Unit": "tool",
>>>>          "Unit": "uncore_arb",
>>>>          "Unit": "uncore_clock",
>>>>          "Unit": "uncore_imc_free_running_0",
>>>>          "Unit": "uncore_imc_free_running_1",
>>>> ```
>>>>
>>>> Fixes: e5c6109f4813 ("perf list: Reorganize to use callbacks to allow honouring command line options")
>>>> Signed-off-by: Jean-Philippe Romain <jean-philippe.romain@foss.st.com>
>>>> Tested-by: Ian Rogers <irogers@google.com>
>>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>>>> ---
>>>> Note from Ian, I fixed the two callers and added it to
>>>> Jean-Phillippe's original change.
>> I think that in this case we need:
>>
>> [ I fixed the two callers and added it to Jean-Phillippe's original change. ]
>> Signed-off-by: Ian Rogers <irogers@google.com>
>>
>> Ok?
> Sgtm.
>
> Thanks,
> Ian
>

Reviewed-by: Jean-Philippe Romain <jean-philippe.romain@foss.st.com>

Many thanks,
Jean-Philippe

>>>> ---
>>>>   tools/perf/builtin-list.c | 4 ++--
>>>>   tools/perf/util/pfm.c     | 4 ++--
>>>>   tools/perf/util/pmus.c    | 2 +-
>>>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
>>>> index b8378ba18c28..9e7fdfcdd7ff 100644
>>>> --- a/tools/perf/builtin-list.c
>>>> +++ b/tools/perf/builtin-list.c
>>>> @@ -113,7 +113,7 @@ static void wordwrap(FILE *fp, const char *s, int start, int max, int corr)
>>>>      }
>>>>   }
>>>>
>>>> -static void default_print_event(void *ps, const char *pmu_name, const char *topic,
>>>> +static void default_print_event(void *ps, const char *topic, const char *pmu_name,
>>>>                              const char *event_name, const char *event_alias,
>>>>                              const char *scale_unit __maybe_unused,
>>>>                              bool deprecated, const char *event_type_desc,
>>>> @@ -354,7 +354,7 @@ static void fix_escape_fprintf(FILE *fp, struct strbuf *buf, const char *fmt, ..
>>>>      fputs(buf->buf, fp);
>>>>   }
>>>>
>>>> -static void json_print_event(void *ps, const char *pmu_name, const char *topic,
>>>> +static void json_print_event(void *ps, const char *topic, const char *pmu_name,
>>>>                           const char *event_name, const char *event_alias,
>>>>                           const char *scale_unit,
>>>>                           bool deprecated, const char *event_type_desc,
>>>> diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
>>>> index 5ccfe4b64cdf..0dacc133ed39 100644
>>>> --- a/tools/perf/util/pfm.c
>>>> +++ b/tools/perf/util/pfm.c
>>>> @@ -233,7 +233,7 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
>>>>      }
>>>>
>>>>      if (is_libpfm_event_supported(name, cpus, threads)) {
>>>> -           print_cb->print_event(print_state, pinfo->name, topic,
>>>> +           print_cb->print_event(print_state, topic, pinfo->name,
>>>>                                    name, info->equiv,
>>>>                                    /*scale_unit=*/NULL,
>>>>                                    /*deprecated=*/NULL, "PFM event",
>>>> @@ -267,8 +267,8 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
>>>>                              continue;
>>>>
>>>>                      print_cb->print_event(print_state,
>>>> -                                   pinfo->name,
>>>>                                      topic,
>>>> +                                   pinfo->name,
>>>>                                      name, /*alias=*/NULL,
>>>>                                      /*scale_unit=*/NULL,
>>>>                                      /*deprecated=*/NULL, "PFM event",
>>>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
>>>> index 107de86c2637..6d4c7c9ecf3a 100644
>>>> --- a/tools/perf/util/pmus.c
>>>> +++ b/tools/perf/util/pmus.c
>>>> @@ -501,8 +501,8 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>>>>                      goto free;
>>>>
>>>>              print_cb->print_event(print_state,
>>>> -                           aliases[j].pmu_name,
>>>>                              aliases[j].topic,
>>>> +                           aliases[j].pmu_name,
>>>>                              aliases[j].name,
>>>>                              aliases[j].alias,
>>>>                              aliases[j].scale_unit,
