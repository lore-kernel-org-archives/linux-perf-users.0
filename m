Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E4412C491;
	Tue, 22 Oct 2024 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579012; cv=none; b=ECci2gLagsi2Khqe+HEus69Bwy9CtE7euUkLYDP2g3FIg2UU8zQT4ToqQB9lpRVCeSPSpgM9oxlAcCqu4yfNi1wBbVVNWyrnaXFJMExub83U4IzbHFDVs4zgSrvI/EBxYzegirMN0/0Sksu0P4YblH6SnGhW+9IlAaR3v7i4Zvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579012; c=relaxed/simple;
	bh=kgom7S4dPlCjQ4rDpUTg5UtN9tz4unR1RuFCpmQYr4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgPWbCuCHx3SNiTLGnfOvhPH/SgxAHldy3nof84tI0XXaY5vHwx1zj1sNkPk0KLBd6IquQ0WehkR5gpKIpC0iGRwvML22WL/zFyVS3v61cvROcoGXTXKHrFFqvhUv/LcSyJrSGOWa2aX9/k+dxOdT3mpj9fFWZoHdUkr1EtRmzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzTccQX1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzTccQX1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DE5C4CEC3;
	Tue, 22 Oct 2024 06:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729579011;
	bh=kgom7S4dPlCjQ4rDpUTg5UtN9tz4unR1RuFCpmQYr4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZzTccQX1j4on01K8VyRf17gqFj0ymMUyxBZtwOyYPrdHSq0HsJatq0hT8InZv1D/H
	 XDJxI4qjhWaUdMbZrODgqT88qZQJC82fZhGBBSDBNZwAzWVwsX9fNro1O3M2Kb20+G
	 0OLhqf2uAq6XIP12BatWLl6opWnNsJbddsomfpvmd2LQoJeESVM20j5vFgj8CKU7XL
	 BkRIerY3xAGdXfvy9S2KogKBL71a2LtrrTKRH7/z9sTubA4lRuxRFz0opMnEgH8xhE
	 evgPcRP0wUt34nQ8L2RZGKBPyTI5DzFGgBIegQPxn1jbHBn6ppkp59StN4HG1cUrZN
	 Xr6HzShE0XyYw==
Date: Mon, 21 Oct 2024 23:36:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 12/16] perf lock: Move common lock contention code to
 new file
Message-ID: <ZxdIAfwD7YzyRMI-@google.com>
References: <20241016042415.7552-1-irogers@google.com>
 <20241016042415.7552-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016042415.7552-13-irogers@google.com>

On Tue, Oct 15, 2024 at 09:24:11PM -0700, Ian Rogers wrote:
> Avoid references from util code to builtin-lock that require python
> stubs. Move the functions and related variables to
> util/lock-contention.c. Add max_stack_depth parameter to
> match_callstack_filter to avoid sharing a global variable.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-lock.c             | 137 +--------------------
>  tools/perf/util/Build                 |   1 +
>  tools/perf/util/bpf_lock_contention.c |   2 +-
>  tools/perf/util/lock-contention.c     | 170 ++++++++++++++++++++++++++
>  tools/perf/util/lock-contention.h     |  37 ++----
>  tools/perf/util/python.c              |  17 ---
>  6 files changed, 185 insertions(+), 179 deletions(-)
>  create mode 100644 tools/perf/util/lock-contention.c
> 
[SNIP]
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 2a2f7780e595..ea2d9eced92e 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -121,6 +121,7 @@ perf-util-y += topdown.o
>  perf-util-y += iostat.o
>  perf-util-y += stream.o
>  perf-util-y += kvm-stat.o
> +perf-util-y += lock-contention.o
>  perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
>  perf-util-$(CONFIG_AUXTRACE) += intel-pt-decoder/
>  perf-util-$(CONFIG_AUXTRACE) += intel-pt.o
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index 41a1ad087895..37e17c56f106 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -458,7 +458,7 @@ int lock_contention_read(struct lock_contention *con)
>  		if (con->save_callstack) {
>  			bpf_map_lookup_elem(stack, &key.stack_id, stack_trace);
>  
> -			if (!match_callstack_filter(machine, stack_trace)) {
> +			if (!match_callstack_filter(machine, stack_trace, con->max_stack)) {
>  				con->nr_filtered += data.count;
>  				goto next;
>  			}
> diff --git a/tools/perf/util/lock-contention.c b/tools/perf/util/lock-contention.c
> new file mode 100644
> index 000000000000..841bb18b1f06
> --- /dev/null
> +++ b/tools/perf/util/lock-contention.c
[SNIP]
> +#ifndef HAVE_BPF_SKEL
> +int lock_contention_prepare(struct lock_contention *con __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +int lock_contention_start(void)
> +{
> +	return 0;
> +}
> +
> +int lock_contention_stop(void)
> +{
> +	return 0;
> +}
> +
> +int lock_contention_finish(struct lock_contention *con __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +int lock_contention_read(struct lock_contention *con __maybe_unused)
> +{
> +	return 0;
> +}
> +#endif  /* !HAVE_BPF_SKEL */

Do we really need this part?  Why not leave it in the header file?

Thanks,
Namhyung


> diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
> index 1a7248ff3889..bfa5c7db0a5d 100644
> --- a/tools/perf/util/lock-contention.h
> +++ b/tools/perf/util/lock-contention.h
> @@ -67,10 +67,11 @@ struct lock_stat {
>   */
>  #define MAX_LOCK_DEPTH 48
>  
> -struct lock_stat *lock_stat_find(u64 addr);
> -struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags);
> +/* based on kernel/lockdep.c */
> +#define LOCKHASH_BITS		12
> +#define LOCKHASH_SIZE		(1UL << LOCKHASH_BITS)
>  
> -bool match_callstack_filter(struct machine *machine, u64 *callstack);
> +extern struct hlist_head *lockhash_table;
>  
>  /*
>   * struct lock_seq_stat:
> @@ -148,7 +149,14 @@ struct lock_contention {
>  	bool save_callstack;
>  };
>  
> -#ifdef HAVE_BPF_SKEL
> +struct option;
> +int parse_call_stack(const struct option *opt, const char *str, int unset);
> +bool needs_callstack(void);
> +
> +struct lock_stat *lock_stat_find(u64 addr);
> +struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags);
> +
> +bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_stack_depth);
>  
>  int lock_contention_prepare(struct lock_contention *con);
>  int lock_contention_start(void);
> @@ -156,25 +164,4 @@ int lock_contention_stop(void);
>  int lock_contention_read(struct lock_contention *con);
>  int lock_contention_finish(struct lock_contention *con);
>  
> -#else  /* !HAVE_BPF_SKEL */
> -
> -static inline int lock_contention_prepare(struct lock_contention *con __maybe_unused)
> -{
> -	return 0;
> -}
> -
> -static inline int lock_contention_start(void) { return 0; }
> -static inline int lock_contention_stop(void) { return 0; }
> -static inline int lock_contention_finish(struct lock_contention *con __maybe_unused)
> -{
> -	return 0;
> -}
> -
> -static inline int lock_contention_read(struct lock_contention *con __maybe_unused)
> -{
> -	return 0;
> -}
> -
> -#endif  /* HAVE_BPF_SKEL */
> -
>  #endif  /* PERF_LOCK_CONTENTION_H */
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 35d84a96dbec..91fd444615cd 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -18,7 +18,6 @@
>  #include "mmap.h"
>  #include "util/kwork.h"
>  #include "util/sample.h"
> -#include "util/lock-contention.h"
>  #include <internal/lib.h>
>  #include "../builtin.h"
>  
> @@ -1311,22 +1310,6 @@ struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
>  	return NULL;
>  }
>  
> -bool match_callstack_filter(struct machine *machine __maybe_unused, u64 *callstack __maybe_unused)
> -{
> -	return false;
> -}
> -
> -struct lock_stat *lock_stat_find(u64 addr __maybe_unused)
> -{
> -	return NULL;
> -}
> -
> -struct lock_stat *lock_stat_findnew(u64 addr __maybe_unused, const char *name __maybe_unused,
> -				int flags __maybe_unused)
> -{
> -	return NULL;
> -}
> -
>  int cmd_inject(int argc __maybe_unused, const char *argv[] __maybe_unused)
>  {
>  	return -1;
> -- 
> 2.47.0.rc1.288.g06298d1525-goog
> 
