Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9885682C60;
	Thu,  7 Nov 2024 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008306; cv=none; b=OHSTGAJ9N76DFL/nqi8J/L0s0M8V3t1XuOo9879VZ87cISw3sQoV5iWHow3t57l6N5GUTtjQzbsDnm/5dn9xSCO0v+m4S99XvOw2Dmgt0DySnl8UCZWaGfxNaagJoil/DuoItCqYKpDqQ0n5F6ePMFLqjglti7SgBHw6FWsrpXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008306; c=relaxed/simple;
	bh=4QQERWIIDTIqGdAubffihvqRN5EkCOX4rfD+7MhTHI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzMZ8OIqDtcjuKFsWh/Zd9jXNZRSdQleAUSRTaJeAPKinh4G8dUHOioh93T3IUDenbDHp1LTG6foMnrRDEimaQp97yoVd7I98pMZbfEME6FRXcfV7WyvhKQUUEBQJBbbwZtfQW29qC4x5c0te9jE38kwat43p1Sg0g+GX/mb5rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOKbW4WC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOKbW4WC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731008305; x=1762544305;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4QQERWIIDTIqGdAubffihvqRN5EkCOX4rfD+7MhTHI8=;
  b=jOKbW4WCvxuoySkpEwHnSdnVjTPW9GN6LW6XOH3bnrRBmdXKkRaStEa5
   wxdt3ywVLjKRYHkHYSFpW0PQlwBPTRoiqo7twRRH2VaNMbIZONwlGJ1TB
   PG3J3Y5BzDxfLYKWvT1jVWqS0TFBO1msz7NI/ki10rVekbkDpQT4pvEI9
   +Ucn/vqdLkEfQm2YcLzTpZFTg+HGyE595tAataVwa9QCpvdQ7rKs2zb4f
   WQ8HT7AFp91xztphUgEYacWbIgSTH2VTXqPTr1hDgr2MdSPEd7xGACCvw
   7p3xwGmYCVb+2kKjm5OqJEv1PvSpxKFVyFyX5qZQ1xALwY6PNOGhzgHk8
   Q==;
X-CSE-ConnectionGUID: 236SP3InQvmV4odp1OPGcg==
X-CSE-MsgGUID: oIKmord6SWi2fC/ZYx/wlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34566080"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34566080"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 11:38:24 -0800
X-CSE-ConnectionGUID: iWvrQI6OSGeo38jXAJNI2A==
X-CSE-MsgGUID: lRgIYtJSRBmmLXUUpxM54A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="85146686"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 11:38:25 -0800
Received: from [10.212.68.83] (kliang2-mobl1.ccr.corp.intel.com [10.212.68.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 74B1420B5703;
	Thu,  7 Nov 2024 11:38:22 -0800 (PST)
Message-ID: <a6f60420-e6fc-4b9d-8487-7ca8d3dc56e9@linux.intel.com>
Date: Thu, 7 Nov 2024 14:38:21 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf stat: Expand metric+unit buffer size
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241106004818.2174593-1-irogers@google.com>
 <126ebac6-fb52-4c3c-b364-0b423e164d40@linux.intel.com>
 <CAP-5=fV3RuvU0N_bt7R-ZMs2nX1_wfKh30PA59u3MW0TF4nzBg@mail.gmail.com>
 <06c73597-5b23-4759-9101-6594cc13cabc@linux.intel.com>
 <Zy0P1POgAe_fkLBF@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Zy0P1POgAe_fkLBF@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-11-07 2:07 p.m., Namhyung Kim wrote:
> Hi Kan,
> 
> On Wed, Nov 06, 2024 at 11:23:15AM -0500, Liang, Kan wrote:
>>
>>
>> On 2024-11-06 11:04 a.m., Ian Rogers wrote:
>>> On Wed, Nov 6, 2024 at 7:27 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2024-11-05 7:48 p.m., Ian Rogers wrote:
>>>>> Long metric names combined with units may exceed the metric_bf and
>>>>> lead to truncation. Double metric_bf in size to avoid this.
>>>>>
>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>>> ---
>>>>>  tools/perf/util/stat-shadow.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
>>>>> index 8c9292aa61d3..6b531d4f58a3 100644
>>>>> --- a/tools/perf/util/stat-shadow.c
>>>>> +++ b/tools/perf/util/stat-shadow.c
>>>>> @@ -507,7 +507,7 @@ static void generic_metric(struct perf_stat_config *config,
>>>>>       if (!metric_events[i]) {
>>>>>               if (expr__parse(&ratio, pctx, metric_expr) == 0) {
>>>>>                       char *unit;
>>>>> -                     char metric_bf[64];
>>>>> +                     char metric_bf[128];
>>>>
>>>> I thin there is already a MAX_EVENT_NAME.
>>>> Can we similarly define a MAX_METRIC_NAME for it?
>>>
>>> So in this case the buffer needs to be big enough to hold the metric
>>> name, the unit from the scaleunit (e.g. the "%" from "100%"). I'd
>>> prefer we used dynamic memory allocation to having hard coded limits,
>>> just to avoid a "640K ought to be enough for anybody," moment.
>>> Although this change is implicitly a hard coded limit, sigh. There is
>>> also the metric only name length:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/builtin-stat.c?h=perf-tools-next#n160
>>> That looked like it was planned to be dynamically computed but then
>>> the patch adding that never materialized - meaning "standard"
>>> metric-only output has its own cut-off rules at 20 characters. I'd
>>> rather wait on doing a larger cleanup and do this quick fix for now,
>>> mainly as I have enough to do.
>>
>> OK
> 
> Can I assume it as Acked-by?
> 

Yes.

Acked-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> Thanks,
> Namhyung
> 

