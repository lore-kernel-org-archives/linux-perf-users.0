Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941641EEA4A;
	Wed, 12 Feb 2025 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393686; cv=none; b=lGGTy1jN0TbNjQazJkXzI/omjJjXzTiolOuReB1aA3Otih0Zh36qQRNZlPJz6o48lxiynAtUDohRFMjTXyHihiG1VtMJbQ1qtW6PP9TD0u5wYSUdh9M6b/wbIJ6eIjqN0FXzqAMjmgUncJ86mu126x+Mm/VRSxuhA2iRLjQ4ZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393686; c=relaxed/simple;
	bh=jDt9WdgsU+OP0v1Z7vmEmGbnVIM1hDHWxND7/5d+FJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLYna6KsiXXBhHn9gptb59A1Txi5O6mt/aHCQ9dASTyV4iUK8YqKra5Wv9VPORFZY1wTSLlPM+xZhw8HiCDL24dnoFUUNOFLHLsoGHKxGyu6InP+3xW1n+Zvy18rEjPdOAxNMnKyhdqwrF8kiVBF3mfmTfQ/iD0yECNDE2eIaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5GnrLvI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5GnrLvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D77DC4CEDF;
	Wed, 12 Feb 2025 20:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739393685;
	bh=jDt9WdgsU+OP0v1Z7vmEmGbnVIM1hDHWxND7/5d+FJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5GnrLvI8AxYEQmlrVDctsAljBNROUKjmBlGdJUGEAhiWjkFiFRNus/paSJK8Jc0y
	 2H3B803Dn7XlN33n+7PfL16N4KqatdybST8LmcQTy5UIoA+wYCsAHXmIRLf9JVR/5i
	 +JyarpQN28ld0u+FCOXb0yfu+0LZchMEMWGZDdzEJ0Dy3sd7NeBzToUXwLigbHstxm
	 QnWvuZJRAkCttC02rhbiKRE3P8GnJ/kOgtl1hG9Qw+K1JV0b6oU7c4eIR/0n7TflOF
	 vnWwQ1jgSUP7draoyr0PqAklNEckqq7G/iN5hpi4aw78E4bloWS89YyGqwZTCml4s4
	 3zVuL7Ch2v1yQ==
Date: Wed, 12 Feb 2025 21:54:41 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v3 2/4] perf trace: Convert syscall_stats to hashmap
Message-ID: <Z60KkdjzX0P1UqTk@x1>
References: <20250205205443.1986408-1-namhyung@kernel.org>
 <20250205205443.1986408-3-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205205443.1986408-3-namhyung@kernel.org>

On Wed, Feb 05, 2025 at 12:54:41PM -0800, Namhyung Kim wrote:
> It was using a RBtree-based int-list as a hash and a custom resort
> logic for that.  As we have hashmap, let's convert to it and add a
> custom sort function for the hashmap entries using an array.  It
> should be faster and more light-weighted.  It's also to prepare
> supporting system-wide syscall stats.
> 
> No functional changes intended.
> 
> Acked-by: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-trace.c | 117 ++++++++++++++++++++++++++++---------
>  1 file changed, 88 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 7e0324a2e9182088..5e37f05737b75a14 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -39,6 +39,7 @@
>  #include "util/synthetic-events.h"
>  #include "util/evlist.h"
>  #include "util/evswitch.h"
> +#include "util/hashmap.h"
>  #include "util/mmap.h"
>  #include <subcmd/pager.h>
>  #include <subcmd/exec-cmd.h>
> @@ -63,7 +64,6 @@
>  #include "print_binary.h"
>  #include "string2.h"
>  #include "syscalltbl.h"
> -#include "rb_resort.h"
>  #include "../perf.h"
>  #include "trace_augment.h"
>  
> @@ -1519,17 +1519,50 @@ struct thread_trace {
>  		struct file   *table;
>  	} files;
>  
> -	struct intlist *syscall_stats;
> +	struct hashmap *syscall_stats;
>  };
>  
> +static size_t syscall_id_hash(long key, void *ctx __maybe_unused)
> +{
> +	return key;
> +}
> +
> +static bool syscall_id_equal(long key1, long key2, void *ctx __maybe_unused)
> +{
> +	return key1 == key2;
> +}
> +
> +static struct hashmap *alloc_syscall_stats(void)
> +{
> +	return hashmap__new(syscall_id_hash, syscall_id_equal, NULL);
> +}
> +
> +static void delete_syscall_stats(struct hashmap *syscall_stats)
> +{
> +	struct hashmap_entry *pos;
> +	size_t bkt;
> +
> +	if (syscall_stats == NULL)
> +		return;
> +
> +	hashmap__for_each_entry(syscall_stats, pos, bkt)
> +		free(pos->pvalue);

nit:

zfree(&pos->pvalue);

> +	hashmap__free(syscall_stats);
> +}
> +
>  static struct thread_trace *thread_trace__new(struct trace *trace)
>  {
>  	struct thread_trace *ttrace =  zalloc(sizeof(struct thread_trace));
>  
>  	if (ttrace) {
>  		ttrace->files.max = -1;
> -		if (trace->summary)
> -			ttrace->syscall_stats = intlist__new(NULL);
> +		if (trace->summary) {
> +			ttrace->syscall_stats = alloc_syscall_stats();
> +			if (IS_ERR(ttrace->syscall_stats)) {
> +				free(ttrace);
> +				ttrace = NULL;

nit: zfree(&ttrace);

> +			}
> +		}
>  	}
>  
>  	return ttrace;
> @@ -1544,7 +1577,7 @@ static void thread_trace__delete(void *pttrace)
>  	if (!ttrace)
>  		return;
>  
> -	intlist__delete(ttrace->syscall_stats);
> +	delete_syscall_stats(ttrace->syscall_stats);
>  	ttrace->syscall_stats = NULL;
>  	thread_trace__free_files(ttrace);
>  	zfree(&ttrace->entry_str);
> @@ -2463,22 +2496,19 @@ struct syscall_stats {
>  static void thread__update_stats(struct thread *thread, struct thread_trace *ttrace,
>  				 int id, struct perf_sample *sample, long err, bool errno_summary)
>  {
> -	struct int_node *inode;
> -	struct syscall_stats *stats;
> +	struct syscall_stats *stats = NULL;
>  	u64 duration = 0;
>  
> -	inode = intlist__findnew(ttrace->syscall_stats, id);
> -	if (inode == NULL)
> -		return;
> -
> -	stats = inode->priv;
> -	if (stats == NULL) {
> +	if (!hashmap__find(ttrace->syscall_stats, id, &stats)) {
>  		stats = zalloc(sizeof(*stats));
>  		if (stats == NULL)
>  			return;
>  
>  		init_stats(&stats->stats);
> -		inode->priv = stats;
> +		if (hashmap__add(ttrace->syscall_stats, id, stats) < 0) {
> +			free(stats);
> +			return;
> +		}
>  	}
>  
>  	if (ttrace->entry_time && sample->time > ttrace->entry_time)
> @@ -4617,18 +4647,45 @@ static size_t trace__fprintf_threads_header(FILE *fp)
>  	return printed;
>  }
>  
> -DEFINE_RESORT_RB(syscall_stats, a->msecs > b->msecs,
> +struct syscall_entry {
>  	struct syscall_stats *stats;
>  	double		     msecs;
>  	int		     syscall;
> -)
> +};
> +
> +static int entry_cmp(const void *e1, const void *e2)
> +{
> +	const struct syscall_entry *entry1 = e1;
> +	const struct syscall_entry *entry2 = e2;
> +
> +	return entry1->msecs > entry2->msecs ? -1 : 1;
> +}
> +
> +static struct syscall_entry *thread__sort_stats(struct thread_trace *ttrace)
>  {
> -	struct int_node *source = rb_entry(nd, struct int_node, rb_node);
> -	struct syscall_stats *stats = source->priv;
> +	struct syscall_entry *entry;
> +	struct hashmap_entry *pos;
> +	unsigned bkt, i, nr;
> +
> +	nr = ttrace->syscall_stats->sz;
> +	entry = malloc(nr * sizeof(*entry));
> +	if (entry == NULL)
> +		return NULL;
> +
> +	i = 0;
> +	hashmap__for_each_entry(ttrace->syscall_stats, pos, bkt) {
> +		struct syscall_stats *ss = pos->pvalue;
> +		struct stats *st = &ss->stats;
>  
> -	entry->syscall = source->i;
> -	entry->stats   = stats;
> -	entry->msecs   = stats ? (u64)stats->stats.n * (avg_stats(&stats->stats) / NSEC_PER_MSEC) : 0;
> +		entry[i].stats = ss;
> +		entry[i].msecs = (u64)st->n * (avg_stats(st) / NSEC_PER_MSEC);
> +		entry[i].syscall = pos->key;
> +		i++;
> +	}
> +	assert(i == nr);
> +
> +	qsort(entry, nr, sizeof(*entry), entry_cmp);
> +	return entry;
>  }
>  
>  static size_t thread__dump_stats(struct thread_trace *ttrace,
> @@ -4636,10 +4693,10 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
>  {
>  	size_t printed = 0;
>  	struct syscall *sc;
> -	struct rb_node *nd;
> -	DECLARE_RESORT_RB_INTLIST(syscall_stats, ttrace->syscall_stats);
> +	struct syscall_entry *entries;
>  
> -	if (syscall_stats == NULL)
> +	entries = thread__sort_stats(ttrace);
> +	if (entries == NULL)
>  		return 0;
>  
>  	printed += fprintf(fp, "\n");
> @@ -4648,8 +4705,10 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
>  	printed += fprintf(fp, "                                     (msec)    (msec)    (msec)    (msec)        (%%)\n");
>  	printed += fprintf(fp, "   --------------- --------  ------ -------- --------- --------- ---------     ------\n");
>  
> -	resort_rb__for_each_entry(nd, syscall_stats) {
> -		struct syscall_stats *stats = syscall_stats_entry->stats;
> +	for (size_t i = 0; i < ttrace->syscall_stats->sz; i++) {
> +		struct syscall_entry *entry = &entries[i];
> +		struct syscall_stats *stats = entry->stats;
> +
>  		if (stats) {
>  			double min = (double)(stats->stats.min) / NSEC_PER_MSEC;
>  			double max = (double)(stats->stats.max) / NSEC_PER_MSEC;
> @@ -4660,10 +4719,10 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
>  			pct = avg ? 100.0 * stddev_stats(&stats->stats) / avg : 0.0;
>  			avg /= NSEC_PER_MSEC;
>  
> -			sc = &trace->syscalls.table[syscall_stats_entry->syscall];
> +			sc = &trace->syscalls.table[entry->syscall];
>  			printed += fprintf(fp, "   %-15s", sc->name);
>  			printed += fprintf(fp, " %8" PRIu64 " %6" PRIu64 " %9.3f %9.3f %9.3f",
> -					   n, stats->nr_failures, syscall_stats_entry->msecs, min, avg);
> +					   n, stats->nr_failures, entry->msecs, min, avg);
>  			printed += fprintf(fp, " %9.3f %9.2f%%\n", max, pct);
>  
>  			if (trace->errno_summary && stats->nr_failures) {
> @@ -4677,7 +4736,7 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
>  		}
>  	}
>  
> -	resort_rb__delete(syscall_stats);
> +	free(entries);
>  	printed += fprintf(fp, "\n\n");
>  
>  	return printed;
> -- 
> 2.48.1.502.g6dc24dfdaf-goog
