Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644471C9DFC;
	Thu, 31 Oct 2024 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730403403; cv=none; b=pBPUNM1LYrhYaC44wIQ/i3xe4znjn4y31U1fJb1krxn0/cJZII3XW96/FN+Duyv+3bOEkeECi5r3qOuwYlTQdl2UYynBurtPLwOlIzqK3p+S4yY5CIMXWzeD5cej9o6eFP/0RanYNEpwQ3z7iDx8kwgeZS802metFOvQGDyfbOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730403403; c=relaxed/simple;
	bh=Z+MNBNPcIJbe79s24w92JEM2jmiPbQ2E95lxShI9ddE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X83ixyIdPc/wzBUuGCgExZ0Pg7PZba5O0ah9iiSG6VtgLftAH0flQjvh1bdt9FhYcaMlCht86xG94U5RpRMfgrf4gteMciMzQ7X8paFDrXNDzzPHg5Zk9SnVCQSyOr7sUJLo7TSgP7lry9WZSrNXIy9grAOsaGu89AtYUsBfm3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjiSiw1s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjiSiw1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E57C4CEC3;
	Thu, 31 Oct 2024 19:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730403402;
	bh=Z+MNBNPcIJbe79s24w92JEM2jmiPbQ2E95lxShI9ddE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjiSiw1sRok26s2IuSoRWt11nOrMcW7IQFvr3pwmkp25DcfOjkU67KBJMi/ag6ucx
	 9BQAcNnlVQKACbeqx9bUx2As7KLVtPimXftAKVLnIoU/ySXzb5R4jAC1MuvecJihTY
	 7njwN197UPZwLYO8oWTTWHuXg9q42W7/wDOV7xR6jOxldaM5JgAF6cUXysGFen28Nx
	 5/JC+rwkzE31XTO5WxceKUVeG0z742QjPsE4WgM1GevMaaWI/3vVYqOoapVC1MyeYB
	 VBm8mIkvfhsjpIUwF4GjejgAwhlRNtX6/pu8YKz+8Dd2vPkS1VvzD256QAJ7aRbOZP
	 60G120K5GvJyQ==
Date: Thu, 31 Oct 2024 16:36:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
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
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 14/21] perf lock: Move common lock contention code to
 new file
Message-ID: <ZyPcRn9UdigvUmuE@x1>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031014252.753588-15-irogers@google.com>

On Wed, Oct 30, 2024 at 06:42:45PM -0700, Ian Rogers wrote:
> Avoid references from util code to builtin-lock that require python
> stubs. Move the functions and related variables to
> util/lock-contention.c. Add max_stack_depth parameter to
> match_callstack_filter to avoid sharing a global variable.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
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
> index 340544a6f5ec..3c6cd8d81d88 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -121,6 +121,7 @@ perf-util-y += topdown.o
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
> index 000000000000..841bb18b1f06
> --- /dev/null
> +++ b/tools/perf/util/lock-contention.c
> @@ -0,0 +1,170 @@
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
> +
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
> 2.47.0.163.g1226f6d8fa-goog
> 
