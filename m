Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE084275B08;
	Tue, 26 Aug 2025 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756175427; cv=none; b=ALW4ustb5cxgbnPAjabnPfo9TcbCvziskdpqwig0uU97XOPUXVviUZXGAtOB1ONM3AV5pMXoR6U+TN/x+UGrwPctfmrscvWssx8y9byFxzOb35vObsURzOvYoDHy/zPLDAA2wr7tmXdbvEi7s2QUBKkJjdTStY217KI2hNDir64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756175427; c=relaxed/simple;
	bh=PDYGgURrqD8Pekg5PAD5urHgYBmmDCYBZYK8k66bJf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b+RupR8jQoTNndfJEe+Ny/8Vwarvb6ziIS4umAXpj/fBQwq+b2v8GIKO8WT/kGeiZZPUTNH/Dh12Hqtp4TJJNiM6WdNkHYnFA2EFMPJZke9kWHPCFLNyV9/8Vg5kGM7RTvTEfCmuqToJinPKCq3u0iTcjHlmNAOVQI8JFOrkxtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ejk/0Y3s; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ejk/0Y3s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756175424; x=1787711424;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=PDYGgURrqD8Pekg5PAD5urHgYBmmDCYBZYK8k66bJf0=;
  b=Ejk/0Y3sK/ZvosyuiJrGUeyIFl0K1hCw4apMVIXgVMzebh1dxhqi5ZCo
   qN7F8vlp0N3YmUwvjEyUZzsjmC3vfKJ+SJdXFpCto67px+tHgEAVzadso
   zLw/1zRvhiuK3LiVvrY1VuvSLUOdiBSYzh8yhsMYgrzv8AtEH07vSLqdZ
   thuR7tNKupb+fI3pn5gFJAV+LrXvQUhAN5TqFrCvI53bYB1tcPC+E7vBC
   74KOlZrZcI7l5wxamhiUZa3IVOEgT7Le1gYVrVQxp4zpgrvj7cT4AbIV7
   YVox0RzsJ/17g4G5xMgci9dbOqGadJaBWLEzBj117paHCw+wlHNnIAbPU
   g==;
X-CSE-ConnectionGUID: QwN7ziN2Rl+EdTb33G0/4g==
X-CSE-MsgGUID: XtAChPMASvy/mhDPwBQ71w==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="61035643"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="61035643"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 19:30:23 -0700
X-CSE-ConnectionGUID: iQ5vnswFQo+dhkSAx8v53Q==
X-CSE-MsgGUID: 9QUIfZPYQ2Obk/PdSKg0LQ==
X-ExtLoop1: 1
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.233.125]) ([10.124.233.125])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 19:30:19 -0700
Message-ID: <3f481d00-2c9f-45a5-807b-037930903b1c@linux.intel.com>
Date: Tue, 26 Aug 2025 10:30:10 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] Improve event groups for topdown, add X event
 modifier
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yoshihiro Furudera <fj5100bi@fujitsu.com>, Howard Chu
 <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250825211204.2784695-1-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250825211204.2784695-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/26/2025 5:12 AM, Ian Rogers wrote:
> In:
> https://lore.kernel.org/lkml/20250822082233.1850417-1-dapeng1.mi@linux.intel.com/#t
> Dapeng Mi and Xudong Hao reported that Intel topdown events have
> issues with parsing when events are duplicated. While some of that is
> intended, things could be better. These patches:
>
> 1) give error messages specific to topdown event grouping constraints,
> 2) fail groups if non-leaders fail to open (this appears to be old tech debt),
> 3) adds an 'X' event modifier to allow events to opt-out of being regrouped.
>
> The 'X' modifier should also give a means to side-step future issues
> in parse_events__sort_events_and_fix_groups should they come up.
>
> Ian Rogers (3):
>   perf evsel: Give warning for broken Intel topdown event grouping
>   perf stat: Don't skip failing group events
>   perf parse-events: Add 'X' modifier to exclude an event from being
>     regrouped
>
>  tools/perf/Documentation/perf-list.txt |  1 +
>  tools/perf/arch/x86/util/evsel.c       | 62 ++++++++++++++++++++++++--
>  tools/perf/builtin-stat.c              | 48 +++++++++-----------
>  tools/perf/util/evsel.c                |  7 ++-
>  tools/perf/util/evsel.h                |  3 +-
>  tools/perf/util/parse-events.c         |  5 ++-
>  tools/perf/util/parse-events.h         |  1 +
>  tools/perf/util/parse-events.l         |  5 ++-
>  8 files changed, 94 insertions(+), 38 deletions(-)

The whole patch-set looks good to me.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Tested the patches on Intel Sapphire Rapids and Panther Lake, all results
are expected.

Tested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Test results on Sapphire Rapids.

1. sudo ./perf stat -e slots,slots -a sleep 1

WARNING: events were regrouped to match PMUs
Error:
Topdown slots event can only be group leader in '{slots,slots}'.

2. sudo ./perf stat -e slots,slots:X -a sleep 1
 Performance counter stats for 'system wide':

    55,734,800,895      slots                                             
                     (49.99%)
    57,217,900,875      slots:X                                           
                     (50.01%)

       1.009697323 seconds time elapsed

3.  sudo ./perf stat -e slots,topdown-fe-bound,topdown-fe-bound -a sleep 1

WARNING: events were regrouped to match PMUs
Error:
Perf metric event 'topdown-fe-bound' is duplicated in the same group (only
one event is allowed) in '{slots,topdown-fe-bound,topdown-fe-bound}'.

4. Perf stats test

sudo ./perf test 100
100: perf stat tests                                                 : Ok

Test results on Panther Lake.

1. sudo ./perf stat -e slots,slots -a sleep 1
WARNING: events were regrouped to match PMUs
Error:
Topdown slots event can only be group leader in
'{cpu_core/slots/,cpu_core/slots/}'.

2. sudo ./perf stat -e slots,slots:X -a sleep 1

 Performance counter stats for 'system wide':

     1,592,899,478      cpu_core/slots/                                   
                     (49.98%)
     1,682,298,980      cpu_core/slots/X                                   
                    (50.02%)

       1.002821768 seconds time elapsed

3. sudo ./perf stat -e slots,topdown-fe-bound,topdown-fe-bound -a sleep 1
WARNING: events were regrouped to match PMUs
Error:
Perf metric event 'cpu_core/topdown-fe-bound/' is duplicated in the same
group (only one event is allowed) in
'{cpu_core/slots/,cpu_core/topdown-fe-bound/,cpu_core/topdown-fe-bound/},cpu_atom/topdown-fe-bound/,cpu_atom/topdown-fe-bound/'.

4. sudo ./perf test 99
 99: perf stat tests                                                 : Ok

