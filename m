Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4590C3D810C;
	Mon, 16 Mar 2026 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685025; cv=none; b=AsyVUOjwfg2zoIfgRbXhCVoaqwG6T2+8qR5ziDNNQb112wzGTMHUhv9sF0XBfrwnygmkW/esfY8S/oZB1l5xjX0RAHuA3korEGugx+dZslTeJ3MRjJyKPPyYGRbKDbUxElpS6eA9kNWGUR9gCNrD4UeXkSxHK7lxAyNRQSh7IVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685025; c=relaxed/simple;
	bh=iG+Add5ys416NNZxdTEyzXi8HW32YFjkpDzoqqQSWl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ES5elYKupwAmqw+mbZNuuH0mKTHYwgewfyFQEhAgF4UCac/i3w8V3rdWUmfZtLWZsPauHWwohAYiu98/cfFw9GXsuqC8kOP8+EiLgB4P/6e+Q7a8YdYzeF4ZigE+TEyAfwHuema+IXhA1Mh/czB3av2Ab3y62qwYETzF11oIsgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nmb8J9Qk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nmb8J9Qk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7F5C19421;
	Mon, 16 Mar 2026 18:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773685024;
	bh=iG+Add5ys416NNZxdTEyzXi8HW32YFjkpDzoqqQSWl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nmb8J9Qk7nbF9+qO5nvYBTJc1GNk3tk/ij3ig45Pvxj6cpykotp0NePJyIqU8fIdi
	 2Zh993PmNFyjA0XH6XT3T9uWbfs/cv+5NWSsEoeboHOREykjLq2rJnQbY+IPkP4w/h
	 uXVEAJ2QKrLep40EFn2BtBVrDXZ1Grp+UB3O1H5cZJqEnIH0LOT6o5U1jDHQuH1e7t
	 LDb0t2HLPvR9Y8RjGZqmShLxHQ2bEsVLOs/ikWF4gALrLImyZJd351cRC2BemsicrJ
	 ubdzqIjiMGRxbkXApWvJtOs5qpd71qXeCBIojYf94DR/VUUc/gisYZ2jJD6Oc+sheH
	 q2HXqgGM79uIw==
Date: Mon, 16 Mar 2026 11:17:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zli94@ncsu.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, xliuprof@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] perf tools: Improvements to data type profiler
Message-ID: <abhJHjMHbHILpbmN@google.com>
References: <20260309175546.916039-1-zli94@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260309175546.916039-1-zli94@ncsu.edu>

Hi Zecheng,

Thanks for working on this continuously!

On Mon, Mar 09, 2026 at 01:55:13PM -0400, Zecheng Li wrote:
> This patch series improves the coverage and correctness of data type
> annotations in the perf tools.
> 
> Here's a breakdown of the patches:
> 
> Patches 1-4 improve variable type matching:
> - Add die_get_pointer_type() to properly handle typedef'd pointer types
> - Preserve typedefs in match_var_offset for consistent type handling
> - Skip redundant check_variable for die_find_variable_by_reg and
>   die_find_variable_by_addr since match_var_offset already performs
>   sufficient checking
> - Improve type comparison when variables are found in different scopes
> 
> Patch 5 handles array types in die_get_member_type, allowing proper
> resolution of struct members that are arrays.
> 
> Patches 6-7 improve global variable handling:
> - Allow collecting global variables without symbol names (DWARF provides
>   the address directly via DW_OP_addr)
> - Handle global variable access when a register holds a const value
>   with negative offset
> 
> Patches 8-9 improve caller-saved register handling:
> - Add invalidate_reg_state() helper for consistent register invalidation
> - Always invalidate caller-saved registers for call instructions per ABI
>   requirements, even when the call target is unknown
> 
> Patches 10-11 use DWARF location ranges to improve type tracking:
> - Track DWARF location lifetime to preserve register state across calls
>   when the debug info indicates the value is still valid
> - Collect all variable location entries instead of just the first one
> 
> Tested with the Linux kernel vmlinux with sampled functions and five
> programs from binutils (as, ld, nm, objdump, readelf) with all
> functions. Coverage rate includes all memory access instructions,
> excluding stack memory accesses.
> 
> `lost` means coverage loss (only including annotated -> none);
> `chg` means type name change. Net coverage gain is new_rate - prev_rate.
> 
>          -------- vmlinux --------   ------- binutils -------
>   Patch  rate     lost     chg       rate     lost     chg
>   ----------------------------------------------------------------
>   base   88.87%   -        -         72.55%   -        -
>   1      88.87%   0%       0%        74.22%   0%       .03%
>   2      88.88%   0%       .05%      74.32%   0%       0%
>   3      88.90%   0%       .69%      74.38%   0%       .31%
>   4      88.90%   0%       .83%      74.38%   0%       .17%
>   5      89.11%   .01%     .08%      74.41%   0%       .01%
>   6      89.12%   0%       .05%      75.33%   0%       1.62%
>   7      89.18%   0%       0%        75.33%   0%       0%
>   8      89.18%   0%       0%        75.30%   .02%     0%
>   9      89.09%   .09%     0%        75.24%   .05%     0%
>   10     89.05%   .08%     .09%      75.53%   .03%     .03%
>   11     89.97%   0%       .10%      76.63%   .26%     .07%

It's interesting that the patch 11 lost some coverage as it merely added
more variables (well the same variables with different ranges).
Have you checked the lost cases and what happened there?

Thanks,
Namhyung

> 
>   Total: vmlinux  88.87% -> 89.97% (+1.10%)
>          binutils 72.55% -> 76.63% (+4.08%)
> 
> Changes in v2:
> - Reorder patches 1-3 to avoid temporary regression: pointer_type and
>   typedef patches now come before skip check_variable (Namhyung)
> - Skip check_variable for both die_find_variable_by_reg and
>   die_find_variable_by_addr paths (Namhyung)
> - Add dso__kernel() guard for const register global variable access
>   to restrict it to kernel DSOs (Namhyung)
> 
> Zecheng Li (11):
>   perf dwarf-aux: Add die_get_pointer_type to get pointer types
>   perf dwarf-aux: Preserve typedefs in match_var_offset
>   perf dwarf-aux: Skip check_variable for variable lookup
>   perf annotate-data: Improve type comparison from different scopes
>   perf dwarf-aux: Handle array types in die_get_member_type
>   perf annotate-data: Collect global variables without name
>   perf annotate-data: Handle global variable access with const register
>   perf annotate-data: Add invalidate_reg_state() helper for x86
>   perf annotate-data: Invalidate caller-saved regs for all calls
>   perf annotate-data: Use DWARF location ranges to preserve reg state
>   perf dwarf-aux: Collect all variable locations for insn tracking
> 
>  tools/perf/util/annotate-arch/annotate-x86.c |  69 ++++++---
>  tools/perf/util/annotate-data.c              | 119 ++++++++-------
>  tools/perf/util/annotate-data.h              |   3 +
>  tools/perf/util/dwarf-aux.c                  | 145 +++++++++++++------
>  tools/perf/util/dwarf-aux.h                  |   9 +-
>  5 files changed, 230 insertions(+), 115 deletions(-)
> 
> -- 
> 2.53.0
> 
