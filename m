Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB1F1D04A0;
	Fri,  6 Sep 2024 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633192; cv=none; b=BSsFU1uUFUfncXiXN/3Y1nYx45UdQFlP3JLeUqxXRdSLP4lqFe7PlOSTKjSDdiBCp3EiQOjkLs2fkdMixL2hWzYQvwZiHlpM8a05oCxLv+l7Of0lNaOyG6aMBzovcQORNzTxqzOf6AKvRGNbTD3xbQzz+29m0GmJsLY3hSgG+JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633192; c=relaxed/simple;
	bh=8dpaCdue66SpPxJeJyg203ScP5Exdrq0AoQXlpDpZUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4t4eoNwJ1z4nw9PF0oy1Zng6ZEc/OIpF8LcoJ4T5KebJfjppXX2oDO8N3WBtoBqNgnALUMgdcdTbOnRq5jWK8UTFYlmhjXJXuCuiQxeT3/xahBCXbbOYk/w+ER3b3PEYaKmkfxhwuT1Y39s7ar2nIidWgJmuUnof3vkU9Y0MxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+/MypGK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+/MypGK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725633190; x=1757169190;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8dpaCdue66SpPxJeJyg203ScP5Exdrq0AoQXlpDpZUw=;
  b=K+/MypGKLLx/qbxZ6imDe0q6AL9QUwEEmd0YOBF9vY5p/FOUVXhawV79
   /51gsOq49iPBG+JT9LNEQGwVw/m2rrDeQzS4kPbCyTbG4jsealoBLlbKB
   k9I5YTedSRcAsYaXyQ1Hx0zEyGOIgac1Elm7wUhzyAD0rSglYadOjSLm/
   69xw07zRDjrK7OvVdCC4f+PJwKd/LT/t78jj9eJeNpW2nCnvParqMgj2r
   BTW4mXeG2u9u+dMxg8g/Ng9qEM9q9gyIvG0HySI7cajXSKzuNnDO56qqk
   lEqbQhy4crdnAZd+55tlKQaX8u/48TW9W0gyuR6VzdE3HIj/LcgIYLUxB
   g==;
X-CSE-ConnectionGUID: VpG5O3mvT7a90WfDUeUTNg==
X-CSE-MsgGUID: yi3lAZxFRJCztOtAU5jilQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="41902996"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="41902996"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 07:33:07 -0700
X-CSE-ConnectionGUID: iw3PU8QNSY2AZN1WMu2O0Q==
X-CSE-MsgGUID: +sM4bXIZSW2mRVRbmZ35pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="66003875"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 07:33:07 -0700
Received: from [10.212.119.23] (kliang2-mobl1.ccr.corp.intel.com [10.212.119.23])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E796920B56FE;
	Fri,  6 Sep 2024 07:33:04 -0700 (PDT)
Message-ID: <b1002dc7-78bf-40ed-83af-12a50622fb76@linux.intel.com>
Date: Fri, 6 Sep 2024 10:33:03 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] perf stat: Add --exclude-guest option
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>,
 James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>
References: <20240905202426.2690105-1-namhyung@kernel.org>
 <20240905202426.2690105-5-namhyung@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240905202426.2690105-5-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-05 4:24 p.m., Namhyung Kim wrote:
> This option is to support the old behavior of setting exclude_guest by
> default.  Now it doesn't set the bit so users want the old behavior can
> use this option.
> 
>   $ perf stat true
> 
>    Performance counter stats for 'true':
> 
>                 0.86 msec task-clock:u                     #    0.443 CPUs utilized
>                    0      context-switches:u               #    0.000 /sec
>                    0      cpu-migrations:u                 #    0.000 /sec
>                   49      page-faults:u                    #   56.889 K/sec
>                  ...
> 
>   $ perf stat --exclude-guest true
> 
>    Performance counter stats for 'true':
> 
>                 0.79 msec task-clock:Hu                    #    0.490 CPUs utilized
>                    0      context-switches:Hu              #    0.000 /sec
>                    0      cpu-migrations:Hu                #    0.000 /sec
>                   49      page-faults:Hu                   #   62.078 K/sec
>                  ...
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-stat.txt | 7 +++++++
>  tools/perf/builtin-stat.c              | 2 ++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 2bc06367248691dd..d28d8370a856598f 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -382,6 +382,13 @@ color the metric's computed value.
>  Don't print output, warnings or messages. This is useful with perf stat
>  record below to only write data to the perf.data file.
>  
> +--exclude-guest::
> +Don't count event in the guest mode.  It was the old behavior but the
> +default is changed to count guest events also.  Use this option if you
> +want the old behavior (host only).  Note that this option needs to be
> +before other events in case you added -e/--event option in the command
> +line.

I'm not sure if we really need this option. I think it may bring more
trouble than what we get.

The name of the "--exclude-guest" sounds like a replacement of the event
modifier "H". But in fact, it's not. It should only affect the default.
It doesn't set the "H" for any events.

Except for the perf kvm user, I don't think there are many users which
care the exclude_guest. The behavior of the perf kvm is not changed. So
the option seems not that important. If we really want an option to
restore the old behavior, it's better to choose a better name and update
the description.

Thanks,
Kan
> +
>  STAT RECORD
>  -----------
>  Stores stat data into perf data file.
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index d8315dae930184ba..4d47675af5cc3094 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2491,6 +2491,8 @@ int cmd_stat(int argc, const char **argv)
>  		OPT_BOOLEAN_FLAG(0, "all-user", &stat_config.all_user,
>  				"Configure all used events to run in user space.",
>  				PARSE_OPT_EXCLUSIVE),
> +		OPT_BOOLEAN(0, "exclude-guest", &exclude_HG_default,
> +			"Don't count events in the guest mode"),
>  		OPT_BOOLEAN(0, "percore-show-thread", &stat_config.percore_show_thread,
>  			"Use with 'percore' event qualifier to show the event "
>  			"counts of one hardware thread by sum up total hardware "
