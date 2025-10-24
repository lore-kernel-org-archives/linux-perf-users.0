Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BB31990A7;
	Fri, 24 Oct 2025 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329001; cv=none; b=a0XE1N3ZrWABv1dBV8dMoymLmKlOZkeeHzyOzlvHqyilaDO1aoHDP+Q/tWNI7g+ZYlVcFPGAJ4/73jUCC3djjMDsnyvIzQt2OahWpTzLP5nV7xfZ/7lcjfLbCvAZ65A7ms/LAKpVtKUzqvad0Tf9YmFv5Dh5Xl137ONTyhsL5Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329001; c=relaxed/simple;
	bh=zDmHT6EI+5KM36Gi2vKqy6ReftN+8VK2vT+rpSoN2RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LepGu+OjCfZ6FEgbESw4RCUXyDB3VrJ0/omhvNGmMhtBimezOKW2UYxanqPPrJ2CGlJUQbup3AoyPHo2Tk/6gMXb1XARrw/SFKDWogt0IvjgNln+lEPZGiMhb+fTRlwuinvigXZ2ToT2qCzpU4DmaxhFEI0EgsUEOe6gRROrKJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUcqSN5j; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUcqSN5j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761328999; x=1792864999;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zDmHT6EI+5KM36Gi2vKqy6ReftN+8VK2vT+rpSoN2RI=;
  b=XUcqSN5jbr310iDgdxmw0/rUNWnksQE0pSgoLoS6LGvfmJrD9FsB2XXK
   X9APqwXbaTiZxfWziFazocx6PLYFcKNRPp8oIqhCZBZLLq18yjOROLiYb
   qXAacxxRaCRMJJ2YA2bM9dzoUqhf5ai7Sf3EeA0JDsX77a+gf/69O2UQM
   eba/2XVYnpY+lm+5xFTdBdQ2v+iaPqrGkvWqb0As8HBU/C3NHC+jPiO/W
   u8/LCMEAzMW34rCHjj/uAODxhpE07BHXmKZWk/08mQNvcyoa4nsSgGg0S
   sr9Qsh/V1rZy6gLiOgbQFqeEM/s7LAjpv7SiIewfUQ8vtuIcTTKk9TbOw
   Q==;
X-CSE-ConnectionGUID: 0Vs/D58/QFik6nNU7364QQ==
X-CSE-MsgGUID: Ugs2M8MITX+wVkXknVODFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63406583"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="63406583"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 11:03:18 -0700
X-CSE-ConnectionGUID: eWSF1972SSCSbwwEROgUEg==
X-CSE-MsgGUID: a9zmkhTUROmCyfJhhXLbZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="188876624"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.241.241.181]) ([10.241.241.181])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 11:03:18 -0700
Message-ID: <576a7d2b-0a82-4738-8b86-507e4d841524@intel.com>
Date: Fri, 24 Oct 2025 11:03:17 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Refactor precise_ip fallback logic
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 thomas.falcon@intel.com, dapeng1.mi@linux.intel.com, xudong.hao@intel.com
References: <20251022220802.1335131-1-zide.chen@intel.com>
 <aPrktlANBHFtV52B@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <aPrktlANBHFtV52B@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/23/2025 7:30 PM, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Oct 22, 2025 at 03:08:02PM -0700, Zide Chen wrote:
>> Commit c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
>> unconditionally called the precise_ip fallback and moved it after the
>> missing-feature checks so that it could handle EINVAL as well.
>>
>> However, this introduced an issue: after disabling missing features,
>> the event could fail to open, which makes the subsequent precise_ip
>> fallback useless since it will always fail.
>>
>> For example, run the following command on Intel SPR:
>>
>> $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
>>
>> Opening the event "cpu/mem-loads,ldlat=3/PS" returns EINVAL when
>> precise_ip == 3. It then sets attr.inherit = false, which triggers a
> 
> I'm curious about this part.  Why the kernel set 'inherit = false'?  IOW
> how did the leader event (mem-loads-aux) succeed with inherit = true
> then?

Initially, the inherit = true for both the group leader
(cpu/mem-loads-aux/S) and the event in question (cpu/mem-loads,ldlat=3/PS).

When the second event fails with EINVAL, the current logic calls
evsel__detect_missing_features() first. Since this is a PERF_SAMPLE_READ
event, the inherit attribute falls back to false, according to the
fallback order implemented in evsel__detect_missing_features().

> 
>> kernel check failure since it doesn't match the group leader's inherit
>> attribute. As a result, it continues to fail even after precise_ip is
>> reduced.
>>
>> By moving the precise_ip fallback earlier, this issue is resolved, as
>> well as the kernel test robot report mentioned in commit
>> c33aea446bf555ab.
>>
>> No negative side effects are expected, because the precise_ip level is
>> restored by evsel__precise_ip_fallback() if the fallback does not help.
> 
> I'm not sure.. some events may need a different (i.e. lower) precise
> level than the max.  I think checking the missing feature later will
> use the max precise level always.

Yes, but seems the basic idea of the event open fallback logic is to
check whether it's lucky enough to open the event by falling back one
single attribute, not multiple attributes.

evsel__precise_ip_fallback() can restore the precise_ip level after a
failed attempt, while evsel__detect_missing_features() cannot recover
the event attributes from its failed try.

Therefore, falling back precise_ip first maintains the intended
“one-by-one” fallback logic. If it’s placed later, it may combine two
fallbacks, which can cause failures like the example above.  Of course,
in theory, there might be cases where an event can be opened if both
precise_ip and another feature are relaxed together, but I haven’t
exhaustively checked whether such cases actually exist.

> Thanks,
> Namhyung
> 
>>
>> This also aligns with commit 2b70702917337a8d ("perf tools: Remove
>> evsel__handle_error_quirks()").
>>
>> Fixes: af954f76eea56453 ("perf tools: Check fallback error and order")
>> Fixes: c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  tools/perf/util/evsel.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index ca74514c8707..6ce32533a213 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -2714,12 +2714,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>>  	if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
>>  		goto retry_open;
>>  
>> +	if (evsel__precise_ip_fallback(evsel))
>> +		goto retry_open;
>> +
>>  	if (err == -EINVAL && evsel__detect_missing_features(evsel, cpu))
>>  		goto fallback_missing_features;
>>  
>> -	if (evsel__precise_ip_fallback(evsel))
>> -		goto retry_open;
>> -
>>  out_close:
>>  	if (err)
>>  		threads->err_thread = thread;
>> -- 
>> 2.51.0
>>

