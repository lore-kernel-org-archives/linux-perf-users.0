Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F00204698;
	Tue,  4 Feb 2025 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697418; cv=none; b=VBVOtDlNOePcMGrIIUN7iBJ8zYIbAQ8gTC7P9MroS958dW3IJ1GO6EugW+ig9bNUPWmm1vW/X4D7ZgcXggYd72wKPh4bHWw/8ucX0HJLfgY8+TFeQGPq0cXyuKGZupeJlI3dzAc0xbhpvC+9SjHEBEnQdqoSV/04bjoB0sEkfO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697418; c=relaxed/simple;
	bh=imTEKMI08W146RNX1SRWUHYvcJwqiFbxPIRXmyovK8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPdbdZNcJ1MPX+tb0XqAgLPjd0Fyg+ZyvNJgsVBDbuq66lK2xBlUuuMhuWqQNHH14HdQLH2jFoJ0d573BLMfefsCWJomnOXNlOMvwZaG52o35Ze8K0fqeLTEjwZavJBv1TY4YSysMHKm+Sno7ceofRAmAxR1Pg6DlzwMGZ3Rg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvezSJIk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvezSJIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC1FC4CEDF;
	Tue,  4 Feb 2025 19:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738697417;
	bh=imTEKMI08W146RNX1SRWUHYvcJwqiFbxPIRXmyovK8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvezSJIkoKnkVzO8j6mWzzzpDZWHj9ZWl0Txn8O76JFLwQlg8ThhXjAOghxMl7jiT
	 z1hmI8U54N76Z4JTn/Dhpmw5OAWvQvy9Zw30dajlaUg0/Hx/EX8Tv1Iv0wfMvMf5OX
	 Ce9sd7vQY8TKfF06RUXEIrtn/m+MyZpBTl23F8Zxp3BHQvyKEbD/2rIN+4dkvTR5Yx
	 PGLsCEIT8iNqpDSeWBIWqUJPgUoslMfOaGfU1J+kJEUJqyh6P1RQTbBpgKUWZSZ4j7
	 c3WlWRdBQi/x8OrhAn6lOc+hh2H19Rf4TcW/hoPiaIJSxZyZUfZmrIB7QPIuO6fpYQ
	 fEik0XfxrLbkA==
Date: Tue, 4 Feb 2025 11:30:15 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2 2/4] perf trace: Convert syscall_stats to hashmap
Message-ID: <Z6JqxzMDP9Y2I3LQ@google.com>
References: <20250130030525.1482498-1-namhyung@kernel.org>
 <20250130030525.1482498-3-namhyung@kernel.org>
 <CAP-5=fUK_aMf8ZYJxmbOLzbu_zZWKYwx_Vvj64x3_2=0u7jbMw@mail.gmail.com>
 <Z6GFxj4ksBG78Pbu@google.com>
 <CAP-5=fU9Bh0_AiNhEKCKKyaWZxPyzQKNeOODL-yZFo-cMSB8Jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU9Bh0_AiNhEKCKKyaWZxPyzQKNeOODL-yZFo-cMSB8Jg@mail.gmail.com>

On Mon, Feb 03, 2025 at 08:28:08PM -0800, Ian Rogers wrote:
> On Mon, Feb 3, 2025 at 7:13 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Sat, Feb 01, 2025 at 11:03:54PM -0800, Ian Rogers wrote:
> > > On Wed, Jan 29, 2025 at 7:05 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > It was using a RBtree-based int-list as a hash and a custome resort
> > > > logic for that.  As we have hashmap, let's convert to it and add a
> > > > sorting function using an array.
> > >
> > > How is a hashmap connected to a sorting function of an array?
> >
> > By not using the int-list (and rb_resort code), it needs a new (re)sort
> > function.  So I added one by copying pointers to hashmap entries to an
> > array and calling qsort(3).  Anyway, I'll update the description.
> 
> Wouldn't pointers to entries be broken by rehashing?

I think it's ok since the hashmap uses dynamically allocated entries.
But the hashmap is fixed at this point because it's called after
finishing the trace.  So it should be fine anyway.

> 
> > >
> > > >  It's also to prepare supporting
> > > > system-wide syscall stats.
> > > >
> > > > No functional changes intended.
> > > >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/builtin-trace.c | 122 ++++++++++++++++++++++++++++---------
> > > >  1 file changed, 93 insertions(+), 29 deletions(-)
> > > >
> > > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > > index 7e0324a2e9182088..1d32ef2b05ae8c1c 100644
> > > > --- a/tools/perf/builtin-trace.c
> > > > +++ b/tools/perf/builtin-trace.c
> > > > @@ -39,6 +39,7 @@
> > > >  #include "util/synthetic-events.h"
> > > >  #include "util/evlist.h"
> > > >  #include "util/evswitch.h"
> > > > +#include "util/hashmap.h"
> > > >  #include "util/mmap.h"
> > > >  #include <subcmd/pager.h>
> > > >  #include <subcmd/exec-cmd.h>
> > > > @@ -63,7 +64,6 @@
> > > >  #include "print_binary.h"
> > > >  #include "string2.h"
> > > >  #include "syscalltbl.h"
> > > > -#include "rb_resort.h"
> > > >  #include "../perf.h"
> > > >  #include "trace_augment.h"
> > > >
> > > > @@ -1519,17 +1519,55 @@ struct thread_trace {
> > > >                 struct file   *table;
> > > >         } files;
> > > >
> > > > -       struct intlist *syscall_stats;
> > > > +       struct hashmap *syscall_stats;
> > > >  };
> > > >
> > > > +static size_t id_hash(long key, void *ctx __maybe_unused)
> > >
> > > I find the use of "id" in this code confusing - it is a pre-existing
> > > problem, but you add to it here. I think a more intention revealing
> > > name would be something like system_call_number_hash.
> >
> > Yep, probably 'syscall_id_hash'.
> 
> What is with "id"? man syscall calls them numbers. Calling the ids
> makes me think they have a value other than the system call number.

But it's already used in this code widely so renaming it now may bring
another confusion.

> 
> > >
> > > > +{
> > > > +       return key;
> > > > +}
> > > > +
> > > > +static bool id_equal(long key1, long key2, void *ctx __maybe_unused)
> > > > +{
> > > > +       return key1 == key2;
> > > > +}
> > > > +
> > > > +static struct hashmap *alloc_syscall_stats(void)
> > > > +{
> > > > +       struct hashmap *stats = hashmap__new(id_hash, id_equal, NULL);
> > > > +
> > > > +       /* just for simpler error check */
> > >
> > > What is "just for simpler error check" ?
> >
> > Probably it can go away.  hashmap__new() returns a pointer or an error.
> > But normally allocation functions tend to return NULL in error cases.
> > So I changed it.
> 
> 
> It would be easier to read something like ",If error is returned
> change to NULL for a simpler error checking by callers. "

Thanks for the suggestion, but I think I'll remove the part.

Thanks,
Namhyung

> 
> > >
> > > > +       if (IS_ERR(stats))
> > > > +               stats = NULL;
> > > > +       return stats;
> > > > +}
> > > > +
> > > > +static void delete_syscall_stats(struct hashmap *syscall_stats)
> > > > +{
> > > > +       struct hashmap_entry *pos;
> > > > +       size_t bkt;
> > > > +
> > > > +       if (syscall_stats == NULL)
> > > > +               return;
> > > > +
> > > > +       hashmap__for_each_entry(syscall_stats, pos, bkt)
> > > > +               free(pos->pvalue);
> > > > +       hashmap__free(syscall_stats);
> > > > +}
> > > > +
> > > >  static struct thread_trace *thread_trace__new(struct trace *trace)
> > > >  {
> > > >         struct thread_trace *ttrace =  zalloc(sizeof(struct thread_trace));
> > > >
> > > >         if (ttrace) {
> > > >                 ttrace->files.max = -1;
> > > > -               if (trace->summary)
> > > > -                       ttrace->syscall_stats = intlist__new(NULL);
> > > > +               if (trace->summary) {
> > > > +                       ttrace->syscall_stats = alloc_syscall_stats();
> > > > +                       if (ttrace->syscall_stats == NULL) {
> > > > +                               free(ttrace);
> > > > +                               ttrace = NULL;
> > >
> > > This looks overly indented.
> >
> > I'm not sure.  Maybe we can change the code to return early if some more
> > logic would be added.  But I didn't feel the strong needs for that.
> >
> > Thanks,
> > Namhyung
> >
> >
> > > > +                       }
> > > > +               }
> > > >         }
> > > >
> > > >         return ttrace;
> > > > @@ -1544,7 +1582,7 @@ static void thread_trace__delete(void *pttrace)
> > > >         if (!ttrace)
> > > >                 return;
> > > >
> > > > -       intlist__delete(ttrace->syscall_stats);
> > > > +       delete_syscall_stats(ttrace->syscall_stats);
> > > >         ttrace->syscall_stats = NULL;
> > > >         thread_trace__free_files(ttrace);
> > > >         zfree(&ttrace->entry_str);
> > > > @@ -2463,22 +2501,19 @@ struct syscall_stats {
> > > >  static void thread__update_stats(struct thread *thread, struct thread_trace *ttrace,
> > > >                                  int id, struct perf_sample *sample, long err, bool errno_summary)
> > > >  {
> > > > -       struct int_node *inode;
> > > > -       struct syscall_stats *stats;
> > > > +       struct syscall_stats *stats = NULL;
> > > >         u64 duration = 0;
> > > >
> > > > -       inode = intlist__findnew(ttrace->syscall_stats, id);
> > > > -       if (inode == NULL)
> > > > -               return;
> > > > -
> > > > -       stats = inode->priv;
> > > > -       if (stats == NULL) {
> > > > +       if (!hashmap__find(ttrace->syscall_stats, id, &stats)) {
> > > >                 stats = zalloc(sizeof(*stats));
> > > >                 if (stats == NULL)
> > > >                         return;
> > > >
> > > >                 init_stats(&stats->stats);
> > > > -               inode->priv = stats;
> > > > +               if (hashmap__add(ttrace->syscall_stats, id, stats) < 0) {
> > > > +                       free(stats);
> > > > +                       return;
> > > > +               }
> > > >         }
> > > >
> > > >         if (ttrace->entry_time && sample->time > ttrace->entry_time)
> > > > @@ -4617,18 +4652,45 @@ static size_t trace__fprintf_threads_header(FILE *fp)
> > > >         return printed;
> > > >  }
> > > >
> > > > -DEFINE_RESORT_RB(syscall_stats, a->msecs > b->msecs,
> > > > +struct syscall_entry {
> > > >         struct syscall_stats *stats;
> > > >         double               msecs;
> > > >         int                  syscall;
> > > > -)
> > > > +};
> > > > +
> > > > +static int entry_cmp(const void *e1, const void *e2)
> > > >  {
> > > > -       struct int_node *source = rb_entry(nd, struct int_node, rb_node);
> > > > -       struct syscall_stats *stats = source->priv;
> > > > +       const struct syscall_entry *entry1 = e1;
> > > > +       const struct syscall_entry *entry2 = e2;
> > > >
> > > > -       entry->syscall = source->i;
> > > > -       entry->stats   = stats;
> > > > -       entry->msecs   = stats ? (u64)stats->stats.n * (avg_stats(&stats->stats) / NSEC_PER_MSEC) : 0;
> > > > +       return entry1->msecs > entry2->msecs ? -1 : 1;
> > > > +}
> > > > +
> > > > +static struct syscall_entry *thread__sort_stats(struct thread_trace *ttrace)
> > > > +{
> > > > +       struct syscall_entry *entry;
> > > > +       struct hashmap_entry *pos;
> > > > +       unsigned bkt, i, nr;
> > > > +
> > > > +       nr = ttrace->syscall_stats->sz;
> > > > +       entry = malloc(nr * sizeof(*entry));
> > > > +       if (entry == NULL)
> > > > +               return NULL;
> > > > +
> > > > +       i = 0;
> > > > +       hashmap__for_each_entry(ttrace->syscall_stats, pos, bkt) {
> > > > +               struct syscall_stats *ss = pos->pvalue;
> > > > +               struct stats *st = &ss->stats;
> > > > +
> > > > +               entry[i].stats = ss;
> > > > +               entry[i].msecs = (u64)st->n * (avg_stats(st) / NSEC_PER_MSEC);
> > > > +               entry[i].syscall = pos->key;
> > > > +               i++;
> > > > +       }
> > > > +       assert(i == nr);
> > > > +
> > > > +       qsort(entry, nr, sizeof(*entry), entry_cmp);
> > > > +       return entry;
> > > >  }
> > > >
> > > >  static size_t thread__dump_stats(struct thread_trace *ttrace,
> > > > @@ -4636,10 +4698,10 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
> > > >  {
> > > >         size_t printed = 0;
> > > >         struct syscall *sc;
> > > > -       struct rb_node *nd;
> > > > -       DECLARE_RESORT_RB_INTLIST(syscall_stats, ttrace->syscall_stats);
> > > > +       struct syscall_entry *entries;
> > > >
> > > > -       if (syscall_stats == NULL)
> > > > +       entries = thread__sort_stats(ttrace);
> > > > +       if (entries == NULL)
> > > >                 return 0;
> > > >
> > > >         printed += fprintf(fp, "\n");
> > > > @@ -4648,8 +4710,10 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
> > > >         printed += fprintf(fp, "                                     (msec)    (msec)    (msec)    (msec)        (%%)\n");
> > > >         printed += fprintf(fp, "   --------------- --------  ------ -------- --------- --------- ---------     ------\n");
> > > >
> > > > -       resort_rb__for_each_entry(nd, syscall_stats) {
> > > > -               struct syscall_stats *stats = syscall_stats_entry->stats;
> > > > +       for (size_t i = 0; i < ttrace->syscall_stats->sz; i++) {
> > > > +               struct syscall_entry *entry = &entries[i];
> > > > +               struct syscall_stats *stats = entry->stats;
> > > > +
> > > >                 if (stats) {
> > > >                         double min = (double)(stats->stats.min) / NSEC_PER_MSEC;
> > > >                         double max = (double)(stats->stats.max) / NSEC_PER_MSEC;
> > > > @@ -4660,10 +4724,10 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
> > > >                         pct = avg ? 100.0 * stddev_stats(&stats->stats) / avg : 0.0;
> > > >                         avg /= NSEC_PER_MSEC;
> > > >
> > > > -                       sc = &trace->syscalls.table[syscall_stats_entry->syscall];
> > > > +                       sc = &trace->syscalls.table[entry->syscall];
> > > >                         printed += fprintf(fp, "   %-15s", sc->name);
> > > >                         printed += fprintf(fp, " %8" PRIu64 " %6" PRIu64 " %9.3f %9.3f %9.3f",
> > > > -                                          n, stats->nr_failures, syscall_stats_entry->msecs, min, avg);
> > > > +                                          n, stats->nr_failures, entry->msecs, min, avg);
> > > >                         printed += fprintf(fp, " %9.3f %9.2f%%\n", max, pct);
> > > >
> > > >                         if (trace->errno_summary && stats->nr_failures) {
> > > > @@ -4677,7 +4741,7 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
> > > >                 }
> > > >         }
> > > >
> > > > -       resort_rb__delete(syscall_stats);
> > > > +       free(entries);
> > > >         printed += fprintf(fp, "\n\n");
> > > >
> > > >         return printed;
> > > > --
> > > > 2.48.1.262.g85cc9f2d1e-goog
> > > >
