Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977AF13C914;
	Mon, 12 Aug 2024 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477068; cv=none; b=aSJOvqG/d109W/7vhpK7y0ieUIlXah/1s/AdYDAjG9fxn7u8OAVdcxwYXiO7NuD8jRQdfgtuaS7hVmbMLqPxikzHskilpmI4dj3cpy+gTsvtzJ5l6vWZdWqD52W5pKCm/DlbPqg4tDOy2kntC15UXoDDg4WFSWscDX282OjHFLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477068; c=relaxed/simple;
	bh=8Hjm1/IFZkDKbzzM86qkJ0VVnODcexaFGKfuAN7Ht3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHkDPGBk8+gqPHMR9khacOzu7qDQ6Yp688o/JlZiz6imc1hTYjSfHixf3HhLQmS2NT59SqeXEnFOls9SzoDaUqXaeAVzh6yZvS0lKbrIrva//8DIu2rGs2h7BeNpbgbzIoKF6bQ1NUH01UJdNXeYkjyAsczT95xWxMAg4LlrSis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WqQHY6eZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WqQHY6eZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723477067; x=1755013067;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8Hjm1/IFZkDKbzzM86qkJ0VVnODcexaFGKfuAN7Ht3E=;
  b=WqQHY6eZsjoPoVaFey5fuMMYMQTJXi4fvitUkzTM3k9HO49rLWXSRme4
   TiZt/0RmlsY2Cipo/z3yMec5QU4Kbq7AU7+2V7NBPJ4AYVpM6hjr3avkv
   wv4UPp5+1b2srQq9bBkjaPtohN2zb3VgGUrmYMW1eOIl2FNAcQk5R8fE6
   Ieth95J8HygYqdqWTJImt3+zr64Rrpt0NT7axrzX0ruUJ7XBphLQHnIAq
   hrNrlhnkwJnFBZXHel4m/s0QXgHVllwpqQPZ+A6FVGABfVYHA5Q9kBQ6i
   dQAnUmTV/mfgFtyfRiAu9UaioItfKcezzSuTuirn9YoAF1XiIW5SUSBso
   Q==;
X-CSE-ConnectionGUID: Gjp1iSNsRgK2Pv7yh+UHbA==
X-CSE-MsgGUID: 5fMy30FYTzqyJXrdkkAunA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21761507"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="21761507"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:37:46 -0700
X-CSE-ConnectionGUID: QbZqhkEgQNmTS7pgaanK5A==
X-CSE-MsgGUID: XWOj6JaXSS2UIf6rNUXJxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="81559746"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:37:45 -0700
Received: from [10.212.112.28] (kliang2-mobl1.ccr.corp.intel.com [10.212.112.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C9D1C20CFED6;
	Mon, 12 Aug 2024 08:37:43 -0700 (PDT)
Message-ID: <83cfa057-1791-4aab-ace8-fb0ad5a607b7@linux.intel.com>
Date: Mon, 12 Aug 2024 11:37:42 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 3/5] perf x86/topdown: Don't move topdown metric events
 in group
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20240712170339.185824-1-dapeng1.mi@linux.intel.com>
 <20240712170339.185824-4-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240712170339.185824-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-07-12 1:03 p.m., Dapeng Mi wrote:
> when running below perf command, we say error is reported.
> 
> perf record -e "{slots,instructions,topdown-retiring}:S" -vv -C0 sleep 1
> 
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4 (cpu)
>   size                             168
>   config                           0x400 (slots)
>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
>   read_format                      ID|GROUP|LOST
>   disabled                         1
>   sample_id_all                    1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4 (cpu)
>   size                             168
>   config                           0x8000 (topdown-retiring)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
>   read_format                      ID|GROUP|LOST
>   freq                             1
>   sample_id_all                    1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8
> sys_perf_event_open failed, error -22
> 
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-retiring).
> 
> The reason of error is that the events are regrouped and
> topdown-retiring event is moved to closely after the slots event and
> topdown-retiring event needs to do the sampling, but Intel PMU driver
> doesn't support to sample topdown metrics events.
> 
> For topdown metrics events, it just requires to be in a group which has
> slots event as leader. It doesn't require topdown metrics event must be
> closely after slots event. Thus it's a overkill to move topdown metrics
> event closely after slots event in events regrouping and furtherly cause
> the above issue.
> 
> Thus don't move topdown metrics events forward if they are already in a
> group.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/evlist.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index 332e8907f43e..6ae044f21843 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -85,7 +85,12 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>  		/* Followed by topdown events. */
>  		if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
>  			return -1;
> -		if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
> +		/*
> +		 * Move topdown events forward only when topdown events
> +		 * are not in same group with previous event.
> +		 */

Do you mean this case?

perf stat -e '{slots,branches},topdown-retiring' -C0 sleep 1
WARNING: events were regrouped to match PMUs

 Performance counter stats for 'CPU(s) 0':

        22,568,316      slots
           569,904      branches
         3,805,637      topdown-retiring


But if I add one more event before topdown-retiring, it seems break again.

perf stat -e '{slots,branches},cycles,topdown-retiring' -C0 sleep 1

 Performance counter stats for 'CPU(s) 0':

        25,218,108      slots
           647,598      branches
         4,345,121      cycles
   <not supported>      topdown-retiring

I'm not asking to support all the above cases. I just try to understand
which cases you plan to support.

Can you please add some comments or update the document to clearly show
which format is supported, which format will be automatically adjusted
by the tool, and which format will be error out?

We should also need test cases for all the supported formats, not just
the standard one.

Thanks,
Kan

> +		if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
> +		    lhs->core.leader != rhs->core.leader)
>  			return 1;
>  	}
>  
