Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE680045;
	Fri, 16 Aug 2024 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836886; cv=none; b=XfscMetios8XiWJhcIBJTumayo8BdvPL8u1ETczj6Zqgrn/Flu0QPwS557lw7MXWdPVgfPD7jz2qOcEAj/OOwxkrMwAWxzWeCRM0r5QjL5g/EXpyHXiIGOrem47ypIzS4qd9dv2zTAWAT0njgYK67pqMZQ+moi79wF5u3imeG1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836886; c=relaxed/simple;
	bh=Dq0NpHjb98fLGowXWIwgQbP1aYd4cC+HY/p6PVZACK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NiTIIz4LGDlFVyCpxR+VSw1J1NxZMeWnV6/witAHs/+ZQxFyanyqbX9ABBtQqxaK7Zbl/NpSsrpZ5kcI3oBtT8Cc2o58Z01VPxbDDy8qszsn98IcLx7rY+bamVBiLv9RjjaAbo0k7wcLYsdt0rl8pQT4ca7U1h74dF+AOnTPUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ot/PeEYN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ot/PeEYN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723836885; x=1755372885;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Dq0NpHjb98fLGowXWIwgQbP1aYd4cC+HY/p6PVZACK4=;
  b=Ot/PeEYN8Ky2edy0PUozOYGdrEJUnN6gXqf7k9UiA/4pf0ik9RBP3vhu
   9GgJLwTKJ4chhBAzoG5cCo1OBUETwMsuPA3jB/dfmEluuU7OgrStkDtq7
   Hj3kH+kYHwXuhiGuYPrcPt50xknZRbEv5wA0roVTo3P2Xj0XAh498hcOi
   2DsGS6uFtgFubwopV/5uxGyQKhZmi3A49a9Vupnue+p+WvIUlaV29vkIj
   6RRojKlQl1NPsziRdxrXgK+MT8Nd7yp47JjgVVk6U823t+URbLy0BwuA4
   kHSPGXnsH8xDVuzbv7ccJqKOGvlLCroiKPQRekjkhOxcyBoIvZp/A3B4y
   Q==;
X-CSE-ConnectionGUID: qyn0eMO+S4+2Djrse47yvg==
X-CSE-MsgGUID: 8WBpo79ARCWOGZ8Hilunyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22114366"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="22114366"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 12:34:44 -0700
X-CSE-ConnectionGUID: 7YLI+eO4TGOILABjHOZc4Q==
X-CSE-MsgGUID: 7i27mFRCTBiomI4xpLFvIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="82968920"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 12:34:44 -0700
Received: from [10.212.50.43] (kliang2-mobl1.ccr.corp.intel.com [10.212.50.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 34D4C20CFEDA;
	Fri, 16 Aug 2024 12:34:43 -0700 (PDT)
Message-ID: <1b0464bf-0258-44d3-adca-4346a9fdfd31@linux.intel.com>
Date: Fri, 16 Aug 2024 15:34:41 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf report: Support --total-cycles --group in the tui
 mode
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org,
 mingo@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240814141942.2513194-1-kan.liang@linux.intel.com>
 <CAM9d7ciPg_1DJ+gJxqU2O0nwX_L9-2+K+NkObq64e12_6vDA_g@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAM9d7ciPg_1DJ+gJxqU2O0nwX_L9-2+K+NkObq64e12_6vDA_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-08-15 6:44 p.m., Namhyung Kim wrote:
> Hi Kan,
> 
> On Wed, Aug 14, 2024 at 7:19 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> With the --total-cycles, the --group is only supported in the stdio
>> mode, but not supported in the tui mode. The output is inconsistent
>> with different modes.
>>
>> if symbol_conf.event_group is applied, always output the event group
>> information together in tui mode as well.
>>
>> $perf record -e "{cycles,instructions}",cache-misses -b sleep 1
>> $perf report --total-cycles --group --tui
>>
>> Before the patch,
>>
>> Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                         [Pro
>>           6.45%            2.0K        0.57%         667    [dl-cacheinfo.h:164 -> dl
>>           5.62%            1.7K        0.74%         871            [dl-cache.c:230 -
>>           5.21%            1.6K        1.37%        1.6K          [setup-vdso.h:37 ->
>>           4.92%            1.5K        0.09%         109            [dl-cache.c:367 -
>>
>> Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                         [Pro
>>           5.62%            1.7K        2.76%         871            [dl-cache.c:230 -
>>           4.92%            1.5K        0.35%         109            [dl-cache.c:367 -
>>           1.12%             346        0.55%         173
>>           0.87%             270        0.43%         135                    [rtld.c:5
>>           0.64%             197        0.03%           8      [dl-tunables.c:305 -> d
>>           0.60%             185        0.01%           3      [dl-tunables.c:305 -> d
>>
>> Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                         [Pro
>>           5.90%            1.8K        1.28%        1.8K                  [strtod.c:8
>>           5.70%            1.8K        1.24%        1.8K            [strtod_l.c:681 -
>>           5.68%            1.8K        1.24%        1.8K            [strtod_l.c:508 -
>>           5.48%            1.7K        1.19%        1.7K          [strtod_l.c:1175 ->
>>           5.21%            1.6K        1.13%        1.6K          [setup-vdso.h:37 ->
>>
>> With the patch,
>>
>> Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                         [Pro
>>           6.45%            2.0K        0.57%         667    [dl-cacheinfo.h:164 -> dl
>>           5.62%            1.7K        0.74%         871            [dl-cache.c:230 -
>>           5.21%            1.6K        1.37%        1.6K          [setup-vdso.h:37 ->
>>           4.92%            1.5K        0.09%         109            [dl-cache.c:367 -
> 
> Hmm.. it seems the output just removed the second one.
> I guess it should combine the first and second output somehow.
>

The patch is just to make the behavior/output the same between --stdio
and the tui mode for --group. I didn't change the algorithm of
calculating the cycles.

Yes, it looks suspicious. I will take a deep look and see how the group
information are processed.

Thanks,
Kan

> Thanks,
> Namhyung
> 
>>
>> Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                         [Pro
>>           5.90%            1.8K        1.28%        1.8K                  [strtod.c:8
>>           5.70%            1.8K        1.24%        1.8K            [strtod_l.c:681 -
>>           5.68%            1.8K        1.24%        1.8K            [strtod_l.c:508 -
>>           5.48%            1.7K        1.19%        1.7K          [strtod_l.c:1175 ->
>>           5.21%            1.6K        1.13%        1.6K          [setup-vdso.h:37 ->
>>
>> Fixes: 7fa46cbf20d3 ("perf report: Sort by sampled cycles percent per block for tui")
>> Closes: https://lore.kernel.org/lkml/ZrupfUSZwem-hCZm@x1/
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  tools/perf/builtin-report.c    |  6 +++++-
>>  tools/perf/ui/browsers/hists.c | 12 ++++++++++--
>>  2 files changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index 1643113616f4..574342fb7269 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -541,7 +541,11 @@ static int evlist__tui_block_hists_browse(struct evlist *evlist, struct report *
>>         int i = 0, ret;
>>
>>         evlist__for_each_entry(evlist, pos) {
>> -               ret = report__browse_block_hists(&rep->block_reports[i++].hist,
>> +               i++;
>> +               if (symbol_conf.event_group && !evsel__is_group_leader(pos))
>> +                       continue;
>> +
>> +               ret = report__browse_block_hists(&rep->block_reports[i - 1].hist,
>>                                                  rep->min_percent, pos,
>>                                                  &rep->session->header.env);
>>                 if (ret != 0)
>> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
>> index 49ba82bf3391..22af1a6e29d6 100644
>> --- a/tools/perf/ui/browsers/hists.c
>> +++ b/tools/perf/ui/browsers/hists.c
>> @@ -3665,11 +3665,19 @@ single_entry: {
>>  static int block_hists_browser__title(struct hist_browser *browser, char *bf,
>>                                       size_t size)
>>  {
>> -       struct hists *hists = evsel__hists(browser->block_evsel);
>> -       const char *evname = evsel__name(browser->block_evsel);
>> +       struct evsel *evsel = browser->block_evsel;
>> +       struct hists *hists = evsel__hists(evsel);
>>         unsigned long nr_samples = hists->stats.nr_samples;
>> +       const char *evname;
>> +       char buf[512];
>>         int ret;
>>
>> +       if (evsel__is_group_event(evsel)) {
>> +               evsel__group_desc(evsel, buf, sizeof(buf));
>> +               evname = buf;
>> +       } else
>> +               evname = evsel__name(evsel);
>> +
>>         ret = scnprintf(bf, size, "# Samples: %lu", nr_samples);
>>         if (evname)
>>                 scnprintf(bf + ret, size -  ret, " of event '%s'", evname);
>> --
>> 2.38.1
>>
> 
