Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53A23B0;
	Fri, 17 Oct 2025 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760685924; cv=none; b=SjhZNrK0m0Jl9PW+dLJ2YS8Cuy6Yatd97xlF7d/JI1UyvUDzlmqZrnIP9CJ/ChiPH0sb1WtbIePS9DTUSLlXL1hls0yJLp5SnrnN/p9A5Nq4WPw2eX/NAQMChztUDujWrP/9OeDnZuUXxk2+UkhE0WBMTZP/HLvGf7B/endwyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760685924; c=relaxed/simple;
	bh=Z7cyfSxaeuZUs6mlTYcEy3+AflyaN60cf+9SwynbcbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZIx3yL0Aku7KeiAnKbTtEihMbeJckMb5uPKeM3R44VF3dMQ+OSPDhNyF8MmCxQNoNZ0nnzm7SK/baj80qqr2pUhZMZUpvgJmpWS09ZlN1gCgFR6K0uyZPselHOvPCRSVJX1+jvLVX1qUvY8gD4z81x4MH8NI9ZAqNvADst8AyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXdeuTmW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXdeuTmW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760685922; x=1792221922;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z7cyfSxaeuZUs6mlTYcEy3+AflyaN60cf+9SwynbcbE=;
  b=hXdeuTmWcZiFb3F9nI16R+cVCFotKmR2ZxjCzk1DVF66IhqJFEpEpTQa
   3bkhpMTia1z/iTKYVIr0Z650XgP2xeaBnOrHLUn4g/J32srf0toJj3t7a
   hhHRZGzhRp4YMCkGs5HF5GjT0bqAIgLiCgTajK/NofG488lHx1RBqAxTU
   HKQSYaG/nZV5aixgMnTbCu5bWi0gyx6YhXhtyieIJA7vjM/wBhimzsAY8
   EBAtEoWb0s1JtEVmepZnadaIdh0F8x0E73D5x9dQ+c8zH1F4CokgkG7Z9
   w2/kP2pRYIGzVlRhhpiGBOjUclKdEGIvZYVEnVzH5dBVI3j92bQjnUK+/
   g==;
X-CSE-ConnectionGUID: QXX5TCJ9TWq1U/P0sdfYBw==
X-CSE-MsgGUID: YCVM5OH4Tv6Zm/WVlKBy0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="66757998"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="66757998"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 00:25:20 -0700
X-CSE-ConnectionGUID: 71AyV9i4TfOibcqOd+Sk6w==
X-CSE-MsgGUID: cVAq1Ro+QAOV0KWi4B37Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="187948572"
Received: from unknown (HELO [10.124.233.173]) ([10.124.233.173])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 00:25:16 -0700
Message-ID: <18f20d38-070c-4e17-bc90-cf7102e1e53d@linux.intel.com>
Date: Fri, 17 Oct 2025 15:25:14 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] perf parse-events: Add 'X' modifier to exclude an
 event from being regrouped
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
Cc: Xudong Hao <xudong.hao@intel.com>
References: <20250825211204.2784695-1-irogers@google.com>
 <20250825211204.2784695-4-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250825211204.2784695-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/26/2025 5:12 AM, Ian Rogers wrote:
> The function parse_events__sort_events_and_fix_groups is needed to fix
> uncore events like:
> ```
> $ perf stat -e '{data_read,data_write}' ...
> ```
> so that the multiple uncore PMUs have a group each of data_read and
> data_write events.
>
> The same function will perform architecture sorting and group fixing,
> in particular for Intel topdown/perf-metric events. Grouping multiple
> perf metric events together causes perf_event_open to fail as the
> group can only support one. This means command lines like:
> ```
> $ perf stat -e 'slots,slots' ...
> ```
> fail as the slots events are forced into a group together to try to
> satisfy the perf-metric event constraints.
>
> As the user may know better than
> parse_events__sort_events_and_fix_groups add a 'X' modifier to skip
> its regrouping behavior. This allows the following to succeed rather
> than fail on the second slots event being opened:
> ```
> $ perf stat -e 'slots,slots:X' -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>      6,834,154,071      cpu_core/slots/                                                         (50.13%)
>      5,548,629,453      cpu_core/slots/X                                                        (49.87%)
>
>        1.002634606 seconds time elapsed
> ```
>
> Reported-by: Xudong Hao <xudong.hao@intel.com>
> Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Closes: https://lore.kernel.org/lkml/20250822082233.1850417-1-dapeng1.mi@linux.intel.com/
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-list.txt | 1 +
>  tools/perf/util/evsel.h                | 1 +
>  tools/perf/util/parse-events.c         | 5 +++--
>  tools/perf/util/parse-events.h         | 1 +
>  tools/perf/util/parse-events.l         | 5 +++--
>  5 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index 28215306a78a..a5039d1614f9 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -73,6 +73,7 @@ counted. The following modifiers exist:
>   e - group or event are exclusive and do not share the PMU
>   b - use BPF aggregration (see perf stat --bpf-counters)
>   R - retire latency value of the event
> + X - don't regroup the event to match PMUs
>  
>  The 'p' modifier can be used for specifying how precise the instruction
>  address should be. The 'p' modifier can be specified multiple times:
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index e927a3a4fe0e..03f9f22e3a0c 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -89,6 +89,7 @@ struct evsel {
>  		bool			use_config_name;
>  		bool			skippable;
>  		bool			retire_lat;
> +		bool			dont_regroup;
>  		int			bpf_fd;
>  		struct bpf_object	*bpf_obj;
>  		struct list_head	config_terms;
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 8282ddf68b98..43de19551c81 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1892,6 +1892,8 @@ static int parse_events__modifier_list(struct parse_events_state *parse_state,
>  			evsel->bpf_counter = true;
>  		if (mod.retire_lat)
>  			evsel->retire_lat = true;
> +		if (mod.dont_regroup)
> +			evsel->dont_regroup = true;
>  	}
>  	return 0;
>  }
> @@ -2188,13 +2190,12 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
>  		 * Set the group leader respecting the given groupings and that
>  		 * groups can't span PMUs.
>  		 */
> -		if (!cur_leader) {
> +		if (!cur_leader || pos->dont_regroup) {
>  			cur_leader = pos;
>  			cur_leaders_grp = &pos->core;
>  			if (pos_force_grouped)
>  				force_grouped_leader = pos;
>  		}
> -
>  		cur_leader_pmu_name = cur_leader->group_pmu_name;
>  		if (strcmp(cur_leader_pmu_name, pos_pmu_name)) {
>  			/* PMU changed so the group/leader must change. */
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 62dc7202e3ba..a5c5fc39fd6f 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -216,6 +216,7 @@ struct parse_events_modifier {
>  	bool guest : 1;		/* 'G' */
>  	bool host : 1;		/* 'H' */
>  	bool retire_lat : 1;	/* 'R' */
> +	bool dont_regroup : 1;	/* 'X' */
>  };
>  
>  int parse_events__modifier_event(struct parse_events_state *parse_state, void *loc,
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 2034590eb789..294e943bcdb4 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -206,6 +206,7 @@ static int modifiers(struct parse_events_state *parse_state, yyscan_t scanner)
>  		CASE('e', exclusive);
>  		CASE('b', bpf);
>  		CASE('R', retire_lat);
> +		CASE('X', dont_regroup);
>  		default:
>  			return PE_ERROR;
>  		}
> @@ -251,10 +252,10 @@ term_name	{name_start}[a-zA-Z0-9_*?.\[\]!\-:]*
>  quoted_name	[\']{name_start}[a-zA-Z0-9_*?.\[\]!\-:,\.=]*[\']
>  drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
>  /*
> - * If you add a modifier you need to update check_modifier().
> + * If you add a modifier you need to update modifiers().
>   * Also, the letters in modifier_event must not be in modifier_bp.
>   */
> -modifier_event	[ukhpPGHSDIWebR]{1,16}
> +modifier_event	[ukhpPGHSDIWebRX]{1,17}
>  modifier_bp	[rwx]{1,3}
>  lc_type 	(L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruction|LLC|L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|bpu|btb|bpc|node)
>  lc_op_result	(load|loads|read|store|stores|write|prefetch|prefetches|speculative-read|speculative-load|refs|Re

Hi Ian,

It looks the "X" modifier only works for the cases without explicit group,
like this.

sudo ./perf record -e cpu/mem-stores/ppu,cpu/slots/uX -- sleep 1
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.019 MB perf.data (7 samples) ]

Once there is an explicit group, the "X" modifier would not work and the
regroup still happens, e.g.,

sudo ./perf record -e '{cpu/mem-stores/ppu,cpu/slots/uX}' -- sleep 1
WARNING: events were regrouped to match PMUs
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.019 MB perf.data (7 samples) ]

I suppose we should enhance the "X" modifier and make it work in 2nd case
as well. How's your idea?

Thanks,

Dapeng Mi

> ference|ops|access|misses|miss)
