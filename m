Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AB469D;
	Wed,  2 Apr 2025 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743618524; cv=none; b=tXHhl7eRHJnEIZT2leLabBqmz8wSDttuGkk9gHUUjNHCn9Y4jPJvdf18vC8SlE9EoUrCogBdDA4NpJcOmSujfvCg+djPuMIQTRtJ11JVgGf7i62CmxPf5H5hBWWAjMrSf/CQsMdPHHU+STtTQdKBb273rC9NldwGC8WqeXKZ3gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743618524; c=relaxed/simple;
	bh=LKBTEmrOg4f3ADlRbKaMQVewhi7vuD5t8mU1g9imwng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtEUMK0tUwtT5w/azVVE29TYMnj1Nk4cyeaSQBDf9iYB9n3uJ5wo8RM9GY9+hMo9baR2i5QoYqQ3YYNvLkUbcC2JmZ8plQj/EzjJb9f7UoJqj8ZpXaolCr2nvRaj3NtkxR9hjfAxBUlEl9G6x3FN8htPdw5nswtLSz3qiUmdZB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fd78JkRy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fd78JkRy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743618523; x=1775154523;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LKBTEmrOg4f3ADlRbKaMQVewhi7vuD5t8mU1g9imwng=;
  b=Fd78JkRy9YBCWC89LeChHex2HWm4ZR3gp2EN4v+Rj+T+GB7BkD3wA9Zc
   1yQHxlGRTkh2bS6W9bYmLgtU7oGT2os0fPKMjNHGOJwYTlgwG0Jah+du0
   b8ITwhPhZT7HmEPRwvoRpXEOJ2bSEI1Ve0vtm/Zb6Kq4TONkASsdw2XxE
   a0Vx0yWs7K0sUevcMtNjYh0dvtRqzPY8xIeZdu7p4bhrOGhWjrU3FKW/D
   4AhEaLtSmb1AYqaKCfMO7cwYxyt8cxz1gHT+LYJ1225sv0milDqFbbIpR
   pHTbzHkqu+MAxFQXDYOHeUNc4x85+tLeQCdcFkBm8gpXSo0knGfgukDkJ
   w==;
X-CSE-ConnectionGUID: eDkIXyFISIylfMsfg/QUgg==
X-CSE-MsgGUID: eLB37ROiSBerMBR4HucKOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44711835"
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="44711835"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 11:28:42 -0700
X-CSE-ConnectionGUID: Z8WNpHNRQT6xExDwhFo6OQ==
X-CSE-MsgGUID: j1av4cUbSuCyrIYFCRKnMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="131647243"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 11:28:41 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 2346220B5736;
	Wed,  2 Apr 2025 11:28:39 -0700 (PDT)
Message-ID: <07fec072-9e2a-4de1-b31b-66dd3a5af6e8@linux.intel.com>
Date: Wed, 2 Apr 2025 14:28:37 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] perf parse-events: Add debug dump of evlist if
 reordered
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Howard Chu <howardchu95@gmail.com>,
 Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen
 <ak@linux.intel.com>, James Clark <james.clark@linaro.org>,
 Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250402164720.3847573-1-irogers@google.com>
 <20250402164720.3847573-6-irogers@google.com>
 <6ba85605-39ea-40e0-a6f6-379deec30db7@linux.intel.com>
 <CAP-5=fXhpx7O-BRLaaCpiXaG+vdcD+s8jpBJwzk3qptFRXsZEg@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fXhpx7O-BRLaaCpiXaG+vdcD+s8jpBJwzk3qptFRXsZEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-04-02 2:15 p.m., Ian Rogers wrote:
> On Wed, Apr 2, 2025 at 10:52 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2025-04-02 12:47 p.m., Ian Rogers wrote:
>>> Add debug verbose output to show how evsels were reordered by
>>> parse_events__sort_events_and_fix_groups. For example:
>>> ```
>>> $ perf record -v -e '{instructions,cycles}' true
>>> Using CPUID GenuineIntel-6-B7-1
>>> WARNING: events were regrouped to match PMUs
>>> evlist after sorting/fixing: '{cpu_atom/instructions/,cpu_atom/cycles/},{cpu_core/instructions/,cpu_core/cycles/}'
>>> ```
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/util/parse-events.c | 16 +++++++++++++---
>>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>>> index 5152fd5a6ead..0f8fd5bee3a7 100644
>>> --- a/tools/perf/util/parse-events.c
>>> +++ b/tools/perf/util/parse-events.c
>>> @@ -28,6 +28,7 @@
>>>  #include "util/evsel_config.h"
>>>  #include "util/event.h"
>>>  #include "util/bpf-filter.h"
>>> +#include "util/stat.h"
>>>  #include "util/util.h"
>>>  #include "tracepoint.h"
>>>
>>> @@ -2196,14 +2197,23 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
>>>       if (ret2 < 0)
>>>               return ret;
>>>
>>> -     if (ret2 && warn_if_reordered && !parse_state.wild_card_pmus)
>>> -             pr_warning("WARNING: events were regrouped to match PMUs\n");
>>> -
>>>       /*
>>>        * Add list to the evlist even with errors to allow callers to clean up.
>>>        */
>>>       evlist__splice_list_tail(evlist, &parse_state.list);
>>>
>>> +     if (ret2 && warn_if_reordered && !parse_state.wild_card_pmus) {
>>> +             pr_warning("WARNING: events were regrouped to match PMUs\n");
>>> +
>>> +             if (verbose > 0) {
>>> +                     struct strbuf sb = STRBUF_INIT;
>>> +
>>> +                     evlist__uniquify_name(evlist);
>>> +                     evlist__format_evsels(evlist, &sb, 1024);
>>
>> Why is the size even less than the one in pr_err?
>>
>> The user probably prefer to get the complete list in the debug.
> 
> I thought the previous 2048 excessive but kept it for the previous
> case to not change anything. If you are happier with 2048 here I don't
> particularly mind, it is a lot to display in verbose output.

Yes, I think the verbose output wouldn't bother the normal user. We only
use it when there is a problem. So detailed information should be
preferred.

Thanks,
Kan>
> Thanks,
> Ian
> 
>> Thanks,
>> Kan> +                  pr_debug("evlist after sorting/fixing: '%s'\n", sb.buf);
>>> +                     strbuf_release(&sb);
>>> +             }
>>> +     }
>>>       if (!ret) {
>>>               struct evsel *last;
>>>
>>
> 

