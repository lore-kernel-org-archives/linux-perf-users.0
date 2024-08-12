Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA45170A0D;
	Mon, 12 Aug 2024 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470178; cv=none; b=bHKIoiO6BP0dtNyNaREdEw7oCs+I8gPvbNoNcXfsZFGscxC5jzGyoZ2FYzOtOzzqCrAbbYMJdg4VD6961XX/kSol6RHhd+A/egxih3+tLuQ1Uvb7cKvEtOL1WpXPDvsDtMMj87ybqIWdB+DX/hmq+crOwr/ZkuZIYjKaqvDkl5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470178; c=relaxed/simple;
	bh=cOYjPpWnnivPZapU6kTtloNV6yoFphgKCrYVyQy2DIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFE3sOtObJzMH3+k9C9VPoGLFRK+JLGCkCFBpRdVIcNYH+lBEAZFiitVIj8RlxM06lGRahezva3qi7ElfDW2UmbBFWsLn1Pi/5J17MDBd7anDI5ftxohmm6ZloPhJ7KOkiofYiSQ+u8AD9lg4nF2JRdhVWlJCMYxINg9oFL4bwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAHRKvd4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAHRKvd4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269E0C32782;
	Mon, 12 Aug 2024 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723470177;
	bh=cOYjPpWnnivPZapU6kTtloNV6yoFphgKCrYVyQy2DIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FAHRKvd4R4CU94sZEEQaHzgHsf6aEeRrBUnBn3hWaRi833jo3loWqesoo5c2r/MTg
	 oOGTMHgCkU89l/kS1BYXRg754FbplerxOzjgncLb8H/hAhUV5gsyOpZgxiTiiZOPUS
	 zno6CjaeVegBCugJ/FkJfeUveifjGNLB0bWxs/o4gxziaqUv+Azsa40R8CcqGBXxUg
	 ElgUSoj1SVpkT3Sy8UhrRCLEJoAYxRqcjOo41JV+62fV794suHY2COS2iwzokFnWXC
	 frgpwkKJOPp0X3YCtNxDiY4sAIQNq+fAyXul/jWDWWAaPduSQJCQBhVM5tllK6rcl2
	 HXX8HizrhWucw==
Date: Mon, 12 Aug 2024 10:42:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v3 2/5] perf x86/topdown: Correct leader selection with
 sample_read enabled
Message-ID: <ZroRXXlV-ePkj-On@x1>
References: <20240712170339.185824-1-dapeng1.mi@linux.intel.com>
 <20240712170339.185824-3-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712170339.185824-3-dapeng1.mi@linux.intel.com>

On Fri, Jul 12, 2024 at 05:03:36PM +0000, Dapeng Mi wrote:
> Addresses an issue where, in the absence of a topdown metrics event
> within a sampling group, the slots event was incorrectly bypassed as
> the sampling leader when sample_read was enabled.
> 
> perf record -e '{slots,branches}:S' -c 10000 -vv sleep 1

Kan, can you please take a look at this patch and the others in this
series?

Thanks,

- Arnaldo
 
> In this case, the slots event should be sampled as leader but the
> branches event is sampled in fact like the verbose output shows.
> 
> perf_event_attr:
>   type                             4 (cpu)
>   size                             168
>   config                           0x400 (slots)
>   sample_type                      IP|TID|TIME|READ|CPU|IDENTIFIER
>   read_format                      ID|GROUP|LOST
>   disabled                         1
>   sample_id_all                    1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             168
>   config                           0x4 (PERF_COUNT_HW_BRANCH_INSTRUCTIONS)
>   { sample_period, sample_freq }   10000
>   sample_type                      IP|TID|TIME|READ|CPU|IDENTIFIER
>   read_format                      ID|GROUP|LOST
>   sample_id_all                    1
>   exclude_guest                    1
> 
> The sample period of slots event instead of branches event is reset to
> 0.
> 
> This fix ensures the slots event remains the leader under these
> conditions.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/topdown.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
> index 49f25d67ed77..857e00cf579f 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "api/fs/fs.h"
>  #include "util/evsel.h"
> +#include "util/evlist.h"
>  #include "util/pmu.h"
>  #include "util/pmus.h"
>  #include "util/topdown.h"
> @@ -87,11 +88,22 @@ bool arch_is_topdown_metrics(const struct evsel *evsel)
>   */
>  bool arch_topdown_sample_read(struct evsel *leader)
>  {
> +	struct evsel *evsel;
> +
>  	if (!evsel__sys_has_perf_metrics(leader))
>  		return false;
>  
> -	if (arch_is_topdown_slots(leader))
> -		return true;
> +	if (!arch_is_topdown_slots(leader))
> +		return false;
> +
> +	/*
> +	 * If slots event as leader event but no topdown metric events
> +	 * in group, slots event should still sample as leader.
> +	 */
> +	evlist__for_each_entry(leader->evlist, evsel) {
> +		if (evsel != leader && arch_is_topdown_metrics(evsel))
> +			return true;
> +	}
>  
>  	return false;
>  }
> -- 
> 2.40.1
