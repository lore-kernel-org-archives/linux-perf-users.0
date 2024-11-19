Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71A1D14FA;
	Tue, 19 Nov 2024 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732043134; cv=none; b=WADgmx9KS8DZf3BiA8w70r2OsoQhGkd+DE10Vf4/WrOphltKBwOU9ifg5flsR89gWSqes0CWXLSwSG21IZ2UYCuCFRkCtTRtIVdQMJFg0H0ytOxvd89UJay7x6wPZZfxHXapjstH2rD4Jqtnil3cGyRCNcxi4bdgtutDLkrbagc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732043134; c=relaxed/simple;
	bh=uApkKX+vPtpQ2d7VTL0fZ/yHEJ6QtwC5huBAv3Vo3ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WL8TPn5B99Wbpc4MRmnV8OudlOwAnc8Zo7aTscLLcCGjleKAM/LE/nEmnDiH8pS2mmfwiAqoC+xPmQWydLAT+VBv9/x8ULDlg0+jivng459BZjy33Gys1r2C3e4tMXMtfcxhy6fAX2GwmRTa1iEk63iOHwcKMctxrJFNV6/pLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhUIkyXM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhUIkyXM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F258C4CED0;
	Tue, 19 Nov 2024 19:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732043134;
	bh=uApkKX+vPtpQ2d7VTL0fZ/yHEJ6QtwC5huBAv3Vo3ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhUIkyXMv86pME6mvp5QhUX6QFLuM4/Mo137JnbOcXhY9CET5IgfONi7SgZWNLCUA
	 TNEDdR1J57rasv0TRJXpRweNJ5700sdTdZJ7xQ4aicw36VEXTEFYbmIuZhkvBGYtuf
	 6EiGSMx/MRIoRISxF8VmSzXVxxhJJa5g562z7pN/kYFFYAeMF6ztAhLeZ7SzJPoitm
	 YcNjteY8FXnAOUuRhDRgrhFP/itRslcYbICXXVSIcRH/Z6HjKCfun9/urQ5DzD3n1D
	 Ha9/FjHBODPU3OGarQ0oCvKwJS/7QKHhFIvpjfsVYBHOiFgrySJu536JfNTHnmwx3u
	 VB2r3/R9y+Pzw==
Date: Tue, 19 Nov 2024 11:05:32 -0800
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
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v7 15/22] perf lock: Move common lock contention code to
 new file
Message-ID: <ZzzhfMCjZ8oWVf9M@google.com>
References: <20241119011644.971342-1-irogers@google.com>
 <20241119011644.971342-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119011644.971342-16-irogers@google.com>

On Mon, Nov 18, 2024 at 05:16:37PM -0800, Ian Rogers wrote:
> Avoid references from util code to builtin-lock that require python
> stubs. Move the functions and related variables to
> util/lock-contention.c. Add max_stack_depth parameter to
> match_callstack_filter to avoid sharing a global variable.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/builtin-lock.c             | 137 +-----------------------
>  tools/perf/util/Build                 |   1 +
>  tools/perf/util/bpf_lock_contention.c |   2 +-
>  tools/perf/util/lock-contention.c     | 143 ++++++++++++++++++++++++++
>  tools/perf/util/lock-contention.h     |  18 +++-
>  tools/perf/util/python.c              |  17 ---
>  6 files changed, 160 insertions(+), 158 deletions(-)
>  create mode 100644 tools/perf/util/lock-contention.c
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 062e2b56a2ab..f66948b1fbed 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -46,15 +46,6 @@
>  static struct perf_session *session;
>  static struct target target;
>  
> -/* based on kernel/lockdep.c */
> -#define LOCKHASH_BITS		12
> -#define LOCKHASH_SIZE		(1UL << LOCKHASH_BITS)
> -
> -static struct hlist_head *lockhash_table;
> -
> -#define __lockhashfn(key)	hash_long((unsigned long)key, LOCKHASH_BITS)
> -#define lockhashentry(key)	(lockhash_table + __lockhashfn((key)))
> -
>  static struct rb_root		thread_stats;
>  
>  static bool combine_locks;
> @@ -67,24 +58,13 @@ static unsigned long bpf_map_entries = MAX_ENTRIES;
>  static int max_stack_depth = CONTENTION_STACK_DEPTH;
>  static int stack_skip = CONTENTION_STACK_SKIP;
>  static int print_nr_entries = INT_MAX / 2;
> -static LIST_HEAD(callstack_filters);
>  static const char *output_name = NULL;
>  static FILE *lock_output;
>  
> -struct callstack_filter {
> -	struct list_head list;
> -	char name[];
> -};
> -
>  static struct lock_filter filters;
>  
>  static enum lock_aggr_mode aggr_mode = LOCK_AGGR_ADDR;
>  
> -static bool needs_callstack(void)
> -{
> -	return !list_empty(&callstack_filters);
> -}
> -
>  static struct thread_stat *thread_stat_find(u32 tid)
>  {
>  	struct rb_node *node;
> @@ -477,93 +457,6 @@ static struct lock_stat *pop_from_result(void)
>  	return container_of(node, struct lock_stat, rb);
>  }
>  
> -struct lock_stat *lock_stat_find(u64 addr)
> -{
> -	struct hlist_head *entry = lockhashentry(addr);
> -	struct lock_stat *ret;
> -
> -	hlist_for_each_entry(ret, entry, hash_entry) {
> -		if (ret->addr == addr)
> -			return ret;
> -	}
> -	return NULL;
> -}
> -
> -struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags)
> -{
> -	struct hlist_head *entry = lockhashentry(addr);
> -	struct lock_stat *ret, *new;
> -
> -	hlist_for_each_entry(ret, entry, hash_entry) {
> -		if (ret->addr == addr)
> -			return ret;
> -	}
> -
> -	new = zalloc(sizeof(struct lock_stat));
> -	if (!new)
> -		goto alloc_failed;
> -
> -	new->addr = addr;
> -	new->name = strdup(name);
> -	if (!new->name) {
> -		free(new);
> -		goto alloc_failed;
> -	}
> -
> -	new->flags = flags;
> -	new->wait_time_min = ULLONG_MAX;
> -
> -	hlist_add_head(&new->hash_entry, entry);
> -	return new;
> -
> -alloc_failed:
> -	pr_err("memory allocation failed\n");
> -	return NULL;
> -}
> -
> -bool match_callstack_filter(struct machine *machine, u64 *callstack)
> -{
> -	struct map *kmap;
> -	struct symbol *sym;
> -	u64 ip;
> -	const char *arch = perf_env__arch(machine->env);
> -
> -	if (list_empty(&callstack_filters))
> -		return true;
> -
> -	for (int i = 0; i < max_stack_depth; i++) {
> -		struct callstack_filter *filter;
> -
> -		/*
> -		 * In powerpc, the callchain saved by kernel always includes
> -		 * first three entries as the NIP (next instruction pointer),
> -		 * LR (link register), and the contents of LR save area in the
> -		 * second stack frame. In certain scenarios its possible to have
> -		 * invalid kernel instruction addresses in either LR or the second
> -		 * stack frame's LR. In that case, kernel will store that address as
> -		 * zero.
> -		 *
> -		 * The below check will continue to look into callstack,
> -		 * incase first or second callstack index entry has 0
> -		 * address for powerpc.
> -		 */
> -		if (!callstack || (!callstack[i] && (strcmp(arch, "powerpc") ||
> -						(i != 1 && i != 2))))
> -			break;
> -
> -		ip = callstack[i];
> -		sym = machine__find_kernel_symbol(machine, ip, &kmap);
> -		if (sym == NULL)
> -			continue;
> -
> -		list_for_each_entry(filter, &callstack_filters, list) {
> -			if (strstr(sym->name, filter->name))
> -				return true;
> -		}
> -	}
> -	return false;
> -}
> -
>  struct trace_lock_handler {
>  	/* it's used on CONFIG_LOCKDEP */
>  	int (*acquire_event)(struct evsel *evsel,
> @@ -1165,7 +1058,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
>  		if (callstack == NULL)
>  			return -ENOMEM;
>  
> -		if (!match_callstack_filter(machine, callstack)) {
> +		if (!match_callstack_filter(machine, callstack, max_stack_depth)) {
>  			free(callstack);
>  			return 0;
>  		}
> @@ -2449,34 +2342,6 @@ static int parse_lock_addr(const struct option *opt __maybe_unused, const char *
>  	return ret;
>  }
>  
> -static int parse_call_stack(const struct option *opt __maybe_unused, const char *str,
> -			   int unset __maybe_unused)
> -{
> -	char *s, *tmp, *tok;
> -	int ret = 0;
> -
> -	s = strdup(str);
> -	if (s == NULL)
> -		return -1;
> -
> -	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
> -		struct callstack_filter *entry;
> -
> -		entry = malloc(sizeof(*entry) + strlen(tok) + 1);
> -		if (entry == NULL) {
> -			pr_err("Memory allocation failure\n");
> -			free(s);
> -			return -1;
> -		}
> -
> -		strcpy(entry->name, tok);
> -		list_add_tail(&entry->list, &callstack_filters);
> -	}
> -
> -	free(s);
> -	return ret;
> -}
> -
>  static int parse_output(const struct option *opt __maybe_unused, const char *str,
>  			int unset __maybe_unused)
>  {
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 21b497df440b..f38eb8262370 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -122,6 +122,7 @@ perf-util-y += topdown.o
>  perf-util-y += iostat.o
>  perf-util-y += stream.o
>  perf-util-y += kvm-stat.o
> +perf-util-y += lock-contention.o
>  perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
>  perf-util-y += intel-pt-decoder/
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
> index 000000000000..92e7b7b572a2
> --- /dev/null
> +++ b/tools/perf/util/lock-contention.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "debug.h"
> +#include "env.h"
> +#include "lock-contention.h"
> +#include "machine.h"
> +#include "symbol.h"
> +
> +#include <limits.h>
> +#include <string.h>
> +
> +#include <linux/hash.h>
> +#include <linux/zalloc.h>
> +
> +#define __lockhashfn(key)	hash_long((unsigned long)key, LOCKHASH_BITS)
> +#define lockhashentry(key)	(lockhash_table + __lockhashfn((key)))
> +
> +struct callstack_filter {
> +	struct list_head list;
> +	char name[];
> +};
> +
> +static LIST_HEAD(callstack_filters);
> +struct hlist_head *lockhash_table;
> +
> +int parse_call_stack(const struct option *opt __maybe_unused, const char *str,
> +		     int unset __maybe_unused)
> +{
> +	char *s, *tmp, *tok;
> +	int ret = 0;
> +
> +	s = strdup(str);
> +	if (s == NULL)
> +		return -1;
> +
> +	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
> +		struct callstack_filter *entry;
> +
> +		entry = malloc(sizeof(*entry) + strlen(tok) + 1);
> +		if (entry == NULL) {
> +			pr_err("Memory allocation failure\n");
> +			free(s);
> +			return -1;
> +		}
> +
> +		strcpy(entry->name, tok);
> +		list_add_tail(&entry->list, &callstack_filters);
> +	}
> +
> +	free(s);
> +	return ret;
> +}
> +
> +bool needs_callstack(void)
> +{
> +	return !list_empty(&callstack_filters);
> +}
> +
> +struct lock_stat *lock_stat_find(u64 addr)
> +{
> +	struct hlist_head *entry = lockhashentry(addr);
> +	struct lock_stat *ret;
> +
> +	hlist_for_each_entry(ret, entry, hash_entry) {
> +		if (ret->addr == addr)
> +			return ret;
> +	}
> +	return NULL;
> +}
> +
> +struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags)
> +{
> +	struct hlist_head *entry = lockhashentry(addr);
> +	struct lock_stat *ret, *new;
> +
> +	hlist_for_each_entry(ret, entry, hash_entry) {
> +		if (ret->addr == addr)
> +			return ret;
> +	}
> +
> +	new = zalloc(sizeof(struct lock_stat));
> +	if (!new)
> +		goto alloc_failed;
> +
> +	new->addr = addr;
> +	new->name = strdup(name);
> +	if (!new->name) {
> +		free(new);
> +		goto alloc_failed;
> +	}
> +
> +	new->flags = flags;
> +	new->wait_time_min = ULLONG_MAX;
> +
> +	hlist_add_head(&new->hash_entry, entry);
> +	return new;
> +
> +alloc_failed:
> +	pr_err("memory allocation failed\n");
> +	return NULL;
> +}
> +
> +bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_stack_depth)
> +{
> +	struct map *kmap;
> +	struct symbol *sym;
> +	u64 ip;
> +	const char *arch = perf_env__arch(machine->env);
> +
> +	if (list_empty(&callstack_filters))
> +		return true;
> +
> +	for (int i = 0; i < max_stack_depth; i++) {
> +		struct callstack_filter *filter;
> +
> +		/*
> +		 * In powerpc, the callchain saved by kernel always includes
> +		 * first three entries as the NIP (next instruction pointer),
> +		 * LR (link register), and the contents of LR save area in the
> +		 * second stack frame. In certain scenarios its possible to have
> +		 * invalid kernel instruction addresses in either LR or the second
> +		 * stack frame's LR. In that case, kernel will store that address as
> +		 * zero.
> +		 *
> +		 * The below check will continue to look into callstack,
> +		 * incase first or second callstack index entry has 0
> +		 * address for powerpc.
> +		 */
> +		if (!callstack || (!callstack[i] && (strcmp(arch, "powerpc") ||
> +						(i != 1 && i != 2))))
> +			break;
> +
> +		ip = callstack[i];
> +		sym = machine__find_kernel_symbol(machine, ip, &kmap);
> +		if (sym == NULL)
> +			continue;
> +
> +		list_for_each_entry(filter, &callstack_filters, list) {
> +			if (strstr(sym->name, filter->name))
> +				return true;
> +		}
> +	}
> +	return false;
> +}
> diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
> index 1a7248ff3889..bd71fb73825a 100644
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
> @@ -148,8 +149,17 @@ struct lock_contention {
>  	bool save_callstack;
>  };
>  
> -#ifdef HAVE_BPF_SKEL
> +struct option;
> +int parse_call_stack(const struct option *opt, const char *str, int unset);
> +bool needs_callstack(void);
>  
> +struct lock_stat *lock_stat_find(u64 addr);
> +struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags);
> +
> +bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_stack_depth);
> +
> +
> +#ifdef HAVE_BPF_SKEL
>  int lock_contention_prepare(struct lock_contention *con);
>  int lock_contention_start(void);
>  int lock_contention_stop(void);
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index fa25e7ed8a7f..6851f9b07e04 100644
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
> 2.47.0.338.g60cca15819-goog
> 
