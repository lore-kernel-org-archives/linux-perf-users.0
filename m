Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB5423BCE4;
	Wed,  2 Apr 2025 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607567; cv=none; b=V2xCDO5afNqfKDDlG+4zVvgsO5bzq21+po5BBk5hIWEDvm8jsnMgjSR8BbsxLwEdZ4QgqHwZySS0mDqaic4jaf+o+t+MBmS0owAeHxfxSmp0ZgwGa0p/0fOAR4CGVle4ka71PPrMvBL5eMz83bpEwDKYHrJDznT39X+IcSoX3cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607567; c=relaxed/simple;
	bh=Dq3mIiMUkMDPD8xmXQJoWOlUMfYrTzU4p/Ymwa/Eqjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KwN6vhIj7LlATZucwbb/YPKgPHVT2FCYpqjC7JZI7oBBkXNRBcWUZQjOHhExworK8uUuixcNEIY92bnJhv9YMN97P0lcm9MJfpLSXdcM3qtHb4yC9rPuBBd6gMBvhPPznY2dd5SUYiQtIRhV+89LZlWooo/umuYIYW3fHuek59o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOEnGuMF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOEnGuMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743607565; x=1775143565;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Dq3mIiMUkMDPD8xmXQJoWOlUMfYrTzU4p/Ymwa/Eqjc=;
  b=IOEnGuMFxSsMe5jJelt1eDcAG+M0leqNPLlzjenSPE3oleprSoaPazFn
   75yij4ndtjA4BWU1nrrGEm3ouVNvtYaMsrxjDZjo7l2vD5Y1wYCm8NteQ
   YdTYBdttngieko0wSUzTSZ3SQ8yr/cGl7DVu37SKk61WR/M8UfSDYkI+/
   eLBgAi7tsFNNysPoAYYY9X5V+sYbdp2WwVShxzuC6knBCgmooL6v1o512
   ZDAM13Qbd302qMah8C7CIG/rLXjbE8XP/CxK56jqTqwGKKuUyPQcauCg5
   YSea/Gb5s0oEcNTU5miUSPJ0gqhz3DeD3UFVdGCh5zPyBai/QfijIsyHh
   w==;
X-CSE-ConnectionGUID: 44EFNpaKT4anzlKxWa965A==
X-CSE-MsgGUID: XoRwG9+zTiitK2JxRdFLew==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="55610893"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="55610893"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 08:26:04 -0700
X-CSE-ConnectionGUID: K2727Pt0TNeD5MvcVSBwTw==
X-CSE-MsgGUID: 57L/2h/kSlSmBqbIAySeLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="126546967"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 08:25:50 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id D637920B5736;
	Wed,  2 Apr 2025 08:25:46 -0700 (PDT)
Message-ID: <a1d59121-f56d-409d-88e9-32fe0b748aa2@linux.intel.com>
Date: Wed, 2 Apr 2025 11:25:45 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] perf evlist: Refactor evlist__scnprintf_evsels
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
 Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>,
 James Clark <james.clark@linaro.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250318041442.321230-1-irogers@google.com>
 <20250318041442.321230-4-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250318041442.321230-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-03-18 12:14 a.m., Ian Rogers wrote:
> Switch output to using a strbuf so the storage can be resized. Rename
> as scnprintf is no longer used.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c |  9 ++++++---
>  tools/perf/util/evlist.c    | 19 +++++++++----------
>  tools/perf/util/evlist.h    |  3 ++-
>  3 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ba20bf7c011d..cea5959adadc 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -51,6 +51,7 @@
>  #include "util/clockid.h"
>  #include "util/off_cpu.h"
>  #include "util/bpf-filter.h"
> +#include "util/strbuf.h"
>  #include "asm/bug.h"
>  #include "perf.h"
>  #include "cputopo.h"
> @@ -2784,13 +2785,15 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		record__auxtrace_snapshot_exit(rec);
>  
>  	if (forks && workload_exec_errno) {
> -		char msg[STRERR_BUFSIZE], strevsels[2048];
> +		char msg[STRERR_BUFSIZE];
>  		const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
> +		struct strbuf sb = STRBUF_INIT;
>  
> -		evlist__scnprintf_evsels(rec->evlist, sizeof(strevsels), strevsels);
> +		evlist__format_evsels(rec->evlist, &sb);
>  
>  		pr_err("Failed to collect '%s' for the '%s' workload: %s\n",
> -			strevsels, argv[0], emsg);
> +			sb.buf, argv[0], emsg);
> +		strbuf_release(&sb);
>  		err = -1;
>  		goto out_child;
>  	}
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 49e10d6981ad..96cfc7ed1512 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -35,6 +35,7 @@
>  #include "util/util.h"
>  #include "util/env.h"
>  #include "util/intel-tpebs.h"
> +#include "util/strbuf.h"
>  #include <signal.h>
>  #include <unistd.h>
>  #include <sched.h>
> @@ -2468,23 +2469,21 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
>  	return NULL;
>  }
>  
> -int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf)
> +void evlist__format_evsels(struct evlist *evlist, struct strbuf *sb)
>  {
>  	struct evsel *evsel;
> -	int printed = 0;
> +	bool first = true;
>  
>  	evlist__for_each_entry(evlist, evsel) {
>  		if (evsel__is_dummy_event(evsel))
>  			continue;
> -		if (size > (strlen(evsel__name(evsel)) + (printed ? 2 : 1))) {
> -			printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "," : "", evsel__name(evsel));
> -		} else {
> -			printed += scnprintf(bf + printed, size - printed, "%s...", printed ? "," : "");
> -			break;
> -		}
> -	}
>  
> -	return printed;
> +		if (!first)
> +			strbuf_addch(sb, ',');
> +> +		strbuf_addstr(sb, evsel__name(evsel));

The evlist may include hundreds of events. The error msg will be too
huge for the case.

Thanks,
Kan

> +		first = false;
> +	}
>  }
>  
>  void evlist__check_mem_load_aux(struct evlist *evlist)
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index edcbf1c10e92..5fe5cfbbebb1 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -20,6 +20,7 @@ struct pollfd;
>  struct thread_map;
>  struct perf_cpu_map;
>  struct record_opts;
> +struct strbuf;
>  struct target;
>  
>  /*
> @@ -430,7 +431,7 @@ int event_enable_timer__process(struct event_enable_timer *eet);
>  
>  struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
>  
> -int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf);
> +void evlist__format_evsels(struct evlist *evlist, struct strbuf *sb);
>  void evlist__check_mem_load_aux(struct evlist *evlist);
>  void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list);
>  void evlist__uniquify_name(struct evlist *evlist);

