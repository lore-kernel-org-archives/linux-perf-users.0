Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E831BDAB0;
	Wed,  7 Aug 2024 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037229; cv=none; b=E9BV3ioPJSh4bn+wYZi5dXaQ3OoAC3IJEk3ZnxyEi2rZcZotzM220CcDGV6bWDm//5icV757bwRml+tMnf7ThuUR2VjKfO7rJ65wiVLg4NqeANAcZnC524pcGVQqkegTVEvEbpXJTWqhmGp5YgmYxVGh8VqUG0k2AXll/P+Ahyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037229; c=relaxed/simple;
	bh=iJrj6qrdrMmEvqJMyjJlaAyKSOWpXc64n/7jFfli/UI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tdC2dQxgP1iHouGIG37MDU08IJAQzILQ4rPG5gjbl8btxldZTgZIaA3Evw+vHQamKnTaOZlSYnha8G5Xmzhh7kBv3YXoIH3aJr1xzgWvf8bVRh115PiJ+D0/SU4uXea8oVo8ljVAOHFyzonPLwdSqP88gKLzBtGuzizkAN3WBHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7BT+F2S; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7BT+F2S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723037228; x=1754573228;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=iJrj6qrdrMmEvqJMyjJlaAyKSOWpXc64n/7jFfli/UI=;
  b=c7BT+F2SWaBgHpY/z3Gx6ULhIVz2us2GW+OfAilWApFXH/O+Vc6JnXxE
   +CghB96lDSxw0K4wVsPQPbIaIn0GxllfFESnH7QF6KDqGGMrdnRWc/8cG
   JH4oVFTfvkJ/pttP3JSovQx5tTGXGmkhE6nupIi/WEXGX4C5svk91QVh8
   F4CMnjUWW4F8ElsJb5GujzN0wV1fxkIyqch8LJODkr8XT5Tyt3Yv2+Xe2
   rYRlwXbpFp4xFvx229zyaUFy4Xb+VObegnN0+JY790bpIPyF7ZIw6Ep/q
   AXLz2kB/a70/qFcLUzCX0+PLOCBn3UhlnqBWe770O39gqag27aAUTvOp3
   g==;
X-CSE-ConnectionGUID: YTaGoI7eQ1SS1RQ/lMVgvA==
X-CSE-MsgGUID: BXGQT9XWT3Clw1lSlVXgHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="24016425"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="24016425"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 06:27:06 -0700
X-CSE-ConnectionGUID: aAHz8o4qR3OXrjb1lwASig==
X-CSE-MsgGUID: E5faa4yRSEK6NUf97CqOhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="57077296"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 06:27:07 -0700
Received: from [10.212.63.105] (kliang2-mobl1.ccr.corp.intel.com [10.212.63.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4BFD520CFED6;
	Wed,  7 Aug 2024 06:27:04 -0700 (PDT)
Message-ID: <277a02a5-9355-4f06-9158-026cf4b330f7@linux.intel.com>
Date: Wed, 7 Aug 2024 09:27:02 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf hist: Fix reference counting of branch_info
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Sun Haiyong <sunhaiyong@loongson.cn>, Yanteng Si <siyanteng@loongson.cn>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240807065136.1039977-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240807065136.1039977-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-07 2:51 a.m., Ian Rogers wrote:
> iter_finish_branch_entry doesn't put the branch_info from/to map
> elements creating memory leaks. This can be seen with:
> 
> ```
> $ perf record -e cycles -b perf test -w noploop
> $ perf report -D
> ...
> Direct leak of 984344 byte(s) in 123043 object(s) allocated from:
>     #0 0x7fb2654f3bd7 in malloc libsanitizer/asan/asan_malloc_linux.cpp:69
>     #1 0x564d3400d10b in map__get util/map.h:186
>     #2 0x564d3400d10b in ip__resolve_ams util/machine.c:1981
>     #3 0x564d34014d81 in sample__resolve_bstack util/machine.c:2151
>     #4 0x564d34094790 in iter_prepare_branch_entry util/hist.c:898
>     #5 0x564d34098fa4 in hist_entry_iter__add util/hist.c:1238
>     #6 0x564d33d1f0c7 in process_sample_event tools/perf/builtin-report.c:334
>     #7 0x564d34031eb7 in perf_session__deliver_event util/session.c:1655
>     #8 0x564d3403ba52 in do_flush util/ordered-events.c:245
>     #9 0x564d3403ba52 in __ordered_events__flush util/ordered-events.c:324
>     #10 0x564d3402d32e in perf_session__process_user_event util/session.c:1708
>     #11 0x564d34032480 in perf_session__process_event util/session.c:1877
>     #12 0x564d340336ad in reader__read_event util/session.c:2399
>     #13 0x564d34033fdc in reader__process_events util/session.c:2448
>     #14 0x564d34033fdc in __perf_session__process_events util/session.c:2495
>     #15 0x564d34033fdc in perf_session__process_events util/session.c:2661
>     #16 0x564d33d27113 in __cmd_report tools/perf/builtin-report.c:1065
>     #17 0x564d33d27113 in cmd_report tools/perf/builtin-report.c:1805
>     #18 0x564d33e0ccb7 in run_builtin tools/perf/perf.c:350
>     #19 0x564d33e0d45e in handle_internal_command tools/perf/perf.c:403
>     #20 0x564d33cdd827 in run_argv tools/perf/perf.c:447
>     #21 0x564d33cdd827 in main tools/perf/perf.c:561
> ...
> ```
> 
> Clearing up the map_symbols properly creates maps reference count
> issues so resolve those. Resolving this issue doesn't improve peak
> heap consumption for the test above.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>


Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  tools/perf/util/hist.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index f8ee1cd6929d..c8c1b511f8a7 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -472,7 +472,9 @@ static int hist_entry__init(struct hist_entry *he,
>  		memcpy(he->branch_info, template->branch_info,
>  		       sizeof(*he->branch_info));
>  
> +		he->branch_info->from.ms.maps = maps__get(he->branch_info->from.ms.maps);
>  		he->branch_info->from.ms.map = map__get(he->branch_info->from.ms.map);
> +		he->branch_info->to.ms.maps = maps__get(he->branch_info->to.ms.maps);
>  		he->branch_info->to.ms.map = map__get(he->branch_info->to.ms.map);
>  	}
>  
> @@ -970,10 +972,21 @@ iter_add_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *a
>  	return err;
>  }
>  
> +static void branch_info__exit(struct branch_info *bi)
> +{
> +	map_symbol__exit(&bi->from.ms);
> +	map_symbol__exit(&bi->to.ms);
> +	zfree_srcline(&bi->srcline_from);
> +	zfree_srcline(&bi->srcline_to);
> +}
> +
>  static int
>  iter_finish_branch_entry(struct hist_entry_iter *iter,
>  			 struct addr_location *al __maybe_unused)
>  {
> +	for (int i = 0; i < iter->total; i++)
> +		branch_info__exit(&iter->bi[i]);
> +
>  	zfree(&iter->bi);
>  	iter->he = NULL;
>  
> @@ -1319,10 +1332,7 @@ void hist_entry__delete(struct hist_entry *he)
>  	map_symbol__exit(&he->ms);
>  
>  	if (he->branch_info) {
> -		map_symbol__exit(&he->branch_info->from.ms);
> -		map_symbol__exit(&he->branch_info->to.ms);
> -		zfree_srcline(&he->branch_info->srcline_from);
> -		zfree_srcline(&he->branch_info->srcline_to);
> +		branch_info__exit(he->branch_info);
>  		zfree(&he->branch_info);
>  	}
>  
