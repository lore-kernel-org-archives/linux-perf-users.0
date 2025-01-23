Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794AA1CEE8C;
	Thu, 23 Jan 2025 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737675470; cv=none; b=PjmkyR7LtAK2Xx9kXP4JPQugb29GVg+ZvqezSb+TVO8Vmr28HanvhvwaBwLR8p/mkDbqm1E5lunJiYKd0jC239NSrPz3SNX+dE6f+eHcSFF14a23tRqCy+PvZrEejgvvgpUeKU4EHylrNokrpQQgg2HbE2sYMLyc+It6gWW85pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737675470; c=relaxed/simple;
	bh=9zVreiUdUDo6j+DwEyr9HAbBJS/wBHgf+XydkAzP8V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pE3/T537uJrNNKixMG3+euoDE4rGzECnNCA/eHB1tj3set7o2pQLtCgqfG83GkRdc1eHLE+Bp3ePqe4jGkep3XoeFFCY23VYdlfPs97pOH4GFHkw33UuOjPUWZkLAHOoqgEttc1NLz4miqwUGrD02WToZv1URRDeLcoIyVVEF7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvizWzhV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvizWzhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2AFC4CEDD;
	Thu, 23 Jan 2025 23:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737675469;
	bh=9zVreiUdUDo6j+DwEyr9HAbBJS/wBHgf+XydkAzP8V4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NvizWzhVyZ+Rmrq5xFD42GGAhYZ1or39pJAUHnugjfQKetRKEOQG8oKHQDijq7cn3
	 zaDFU/wkb08BWWY34zNxZR3sbbfrqjyLy5IRPA1XXYduIPXHAd/Bi8kvAl3F8HTP7U
	 em7bZq2EwsctxSb0tScgLeMqjakSidl59Fu1pD+B+6OagUyVgcBxvZLfgyDZpNOKJQ
	 KYtkp7+0B7Shzz6GsrsmHLYhAvt0PC+gTbUhGCJ0ATJtJhTE3Cl7Y5w+4Zj9WLLAR5
	 ldNf21Eesl7kRQ+hoEexZyGvdmO57En7yvvOOF5o0501p75RCwUWvTBJIaAWHPrcQi
	 rZLb1D56+0dyA==
Date: Thu, 23 Jan 2025 15:37:48 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] perf trace: Convert syscall_stats to hashmap
Message-ID: <Z5LSzPlYMXl1mztO@google.com>
References: <20250114212256.160730-1-namhyung@kernel.org>
 <20250114212256.160730-3-namhyung@kernel.org>
 <CAH0uvogVw6UGxZf1OZRPt5YWpHtGbi6LbH-9VYpOipEWGwM_4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvogVw6UGxZf1OZRPt5YWpHtGbi6LbH-9VYpOipEWGwM_4A@mail.gmail.com>

Hi Howard,

On Fri, Jan 17, 2025 at 07:03:13PM -0800, Howard Chu wrote:
> Hello Namhyung,
> 
> Sorry for the delay caused by health issues. In my opinion, this

Sorry to hear that, I hope you are good now.


> unlocks the true power of perf trace—a high-performance, buffered, and
> multi-process (or system-wide) tracer.
> 
> On Tue, Jan 14, 2025 at 1:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It was using a RBtree-based int-list as a hash and a custome resort
> > logic for that.  As we have hashmap, let's convert to it and add a
> > sorting function using an array.  It's also to prepare supporting
> > system-wide syscall stats.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-trace.c | 121 ++++++++++++++++++++++++++++---------
> >  1 file changed, 92 insertions(+), 29 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 0691e817c15b4136..ad7f7fcd0d80b9df 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -39,6 +39,7 @@
> >  #include "util/synthetic-events.h"
> >  #include "util/evlist.h"
> >  #include "util/evswitch.h"
> > +#include "util/hashmap.h"
> >  #include "util/mmap.h"
> >  #include <subcmd/pager.h>
> >  #include <subcmd/exec-cmd.h>
> > @@ -63,7 +64,6 @@
> >  #include "print_binary.h"
> >  #include "string2.h"
> >  #include "syscalltbl.h"
> > -#include "rb_resort.h"
> >  #include "../perf.h"
> >  #include "trace_augment.h"
> >
> > @@ -1520,17 +1520,55 @@ struct thread_trace {
> >                 struct file   *table;
> >         } files;
> >
> > -       struct intlist *syscall_stats;
> > +       struct hashmap *syscall_stats;
> >  };
> >
> > +static size_t id_hash(long key, void *ctx __maybe_unused)
> > +{
> > +       return key;
> > +}
> > +
> > +static bool id_equal(long key1, long key2, void *ctx __maybe_unused)
> > +{
> > +       return key1 == key2;
> > +}
> > +
> > +static struct hashmap *alloc_syscall_stats(void)
> > +{
> > +       struct hashmap *stats = hashmap__new(id_hash, id_equal, NULL);
> > +
> > +       /* just for simpler error check */
> > +       if (IS_ERR_OR_NULL(stats))
> 
> I don't think stats will ever be NULL.

Ok, will change.

> 
> > +               stats = NULL;
> > +       return stats;
> > +}
> > +
> > +static void delete_syscall_stats(struct hashmap *syscall_stats)
> > +{
> > +       struct hashmap_entry *pos;
> > +       size_t bkt;
> > +
> > +       if (syscall_stats == NULL)
> > +               return;
> > +
> > +       hashmap__for_each_entry(syscall_stats, pos, bkt)
> > +               free(pos->pvalue);
> > +       hashmap__free(syscall_stats);
> > +}
> > +
> >  static struct thread_trace *thread_trace__new(struct trace *trace)
> >  {
> >         struct thread_trace *ttrace =  zalloc(sizeof(struct thread_trace));
> >
> >         if (ttrace) {
> >                 ttrace->files.max = -1;
> > -               if (trace->summary)
> > -                       ttrace->syscall_stats = intlist__new(NULL);
> > +               if (trace->summary) {
> > +                       ttrace->syscall_stats = alloc_syscall_stats();
> > +                       if (ttrace->syscall_stats == NULL) {
> > +                               free(ttrace);
> > +                               ttrace = NULL;
> > +                       }
> > +               }
> >         }
> >
> >         return ttrace;
> > @@ -1545,7 +1583,7 @@ static void thread_trace__delete(void *pttrace)
> >         if (!ttrace)
> >                 return;
> >
> > -       intlist__delete(ttrace->syscall_stats);
> > +       delete_syscall_stats(ttrace->syscall_stats);
> >         ttrace->syscall_stats = NULL;
> >         thread_trace__free_files(ttrace);
> >         zfree(&ttrace->entry_str);
> > @@ -2464,22 +2502,19 @@ struct syscall_stats {
> >  static void thread__update_stats(struct thread *thread, struct thread_trace *ttrace,
> >                                  int id, struct perf_sample *sample, long err, bool errno_summary)
> >  {
> > -       struct int_node *inode;
> > -       struct syscall_stats *stats;
> > +       struct syscall_stats *stats = NULL;
> >         u64 duration = 0;
> >
> > -       inode = intlist__findnew(ttrace->syscall_stats, id);
> > -       if (inode == NULL)
> > -               return;
> > -
> > -       stats = inode->priv;
> > -       if (stats == NULL) {
> > +       if (!hashmap__find(ttrace->syscall_stats, id, &stats)) {
> >                 stats = zalloc(sizeof(*stats));
> >                 if (stats == NULL)
> >                         return;
> >
> >                 init_stats(&stats->stats);
> > -               inode->priv = stats;
> > +               if (hashmap__add(ttrace->syscall_stats, id, stats) < 0) {
> > +                       free(stats);
> > +                       return;
> > +               }
> >         }
> >
> >         if (ttrace->entry_time && sample->time > ttrace->entry_time)
> > @@ -4618,18 +4653,45 @@ static size_t trace__fprintf_threads_header(FILE *fp)
> >         return printed;
> >  }
> >
> > -DEFINE_RESORT_RB(syscall_stats, a->msecs > b->msecs,
> > +struct syscall_entry {
> >         struct syscall_stats *stats;
> >         double               msecs;
> >         int                  syscall;
> > -)
> > +};
> > +
> > +static int entry_cmp(const void *e1, const void *e2)
> > +{
> > +       const struct syscall_entry *entry1 = e1;
> > +       const struct syscall_entry *entry2 = e2;
> > +
> > +       return entry1->msecs > entry2->msecs ? -1 : 1;
> > +}
> > +
> > +static struct syscall_entry *thread__sort_stats(struct thread_trace *ttrace)
> >  {
> > -       struct int_node *source = rb_entry(nd, struct int_node, rb_node);
> > -       struct syscall_stats *stats = source->priv;
> > +       struct syscall_entry *entry;
> > +       struct hashmap_entry *pos;
> > +       unsigned bkt, i, nr;
> > +
> > +       nr = ttrace->syscall_stats->sz;
> > +       entry = malloc(nr * sizeof(*entry));
> > +       if (entry == NULL)
> > +               return NULL;
> >
> > -       entry->syscall = source->i;
> > -       entry->stats   = stats;
> > -       entry->msecs   = stats ? (u64)stats->stats.n * (avg_stats(&stats->stats) / NSEC_PER_MSEC) : 0;
> > +       i = 0;
> > +       hashmap__for_each_entry(ttrace->syscall_stats, pos, bkt) {
> > +               struct syscall_stats *ss = pos->pvalue;
> > +               struct stats *st = &ss->stats;
> > +
> > +               entry[i].stats = ss;
> > +               entry[i].msecs = (u64)st->n * (avg_stats(st) / NSEC_PER_MSEC);
> > +               entry[i].syscall = pos->key;
> > +               i++;
> > +       }
> > +       assert(i == nr);
> > +
> > +       qsort(entry, nr, sizeof(*entry), entry_cmp);
> > +       return entry;
> >  }
> >
> >  static size_t thread__dump_stats(struct thread_trace *ttrace,
> > @@ -4637,10 +4699,10 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
> >  {
> >         size_t printed = 0;
> >         struct syscall *sc;
> > -       struct rb_node *nd;
> > -       DECLARE_RESORT_RB_INTLIST(syscall_stats, ttrace->syscall_stats);
> > +       struct syscall_entry *entries;
> >
> > -       if (syscall_stats == NULL)
> > +       entries = thread__sort_stats(ttrace);
> > +       if (entries == NULL)
> >                 return 0;
> >
> >         printed += fprintf(fp, "\n");
> > @@ -4649,8 +4711,9 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
> >         printed += fprintf(fp, "                                     (msec)    (msec)    (msec)    (msec)        (%%)\n");
> >         printed += fprintf(fp, "   --------------- --------  ------ -------- --------- --------- ---------     ------\n");
> >
> > -       resort_rb__for_each_entry(nd, syscall_stats) {
> > -               struct syscall_stats *stats = syscall_stats_entry->stats;
> > +       for (size_t i = 0; i < ttrace->syscall_stats->sz; i++) {
> > +               struct syscall_entry *entry = &entries[i];
> > +               struct syscall_stats *stats = entry->stats;
> 
> Maybe add a newline here?

Yep.

Thanks for your review!
Namhyung

> 
> >                 if (stats) {
> >                         double min = (double)(stats->stats.min) / NSEC_PER_MSEC;
> >                         double max = (double)(stats->stats.max) / NSEC_PER_MSEC;
> > @@ -4661,10 +4724,10 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
> >                         pct = avg ? 100.0 * stddev_stats(&stats->stats) / avg : 0.0;
> >                         avg /= NSEC_PER_MSEC;
> >
> > -                       sc = &trace->syscalls.table[syscall_stats_entry->syscall];
> > +                       sc = &trace->syscalls.table[entry->syscall];
> >                         printed += fprintf(fp, "   %-15s", sc->name);
> >                         printed += fprintf(fp, " %8" PRIu64 " %6" PRIu64 " %9.3f %9.3f %9.3f",
> > -                                          n, stats->nr_failures, syscall_stats_entry->msecs, min, avg);
> > +                                          n, stats->nr_failures, entry->msecs, min, avg);
> >                         printed += fprintf(fp, " %9.3f %9.2f%%\n", max, pct);
> >
> >                         if (trace->errno_summary && stats->nr_failures) {
> > @@ -4678,7 +4741,7 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
> >                 }
> >         }
> >
> > -       resort_rb__delete(syscall_stats);
> > +       free(entries);
> >         printed += fprintf(fp, "\n\n");
> >
> >         return printed;
> > --
> > 2.48.0.rc2.279.g1de40edade-goog
> >
> 
> Thanks,
> Howard
