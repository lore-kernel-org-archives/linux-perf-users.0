Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9700DDBC
	for <linux-perf-users@vger.kernel.org>; Sun,  2 Feb 2025 07:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738479849; cv=none; b=te47uGe0cko+r4U6PNnJKge9pNwdvOtFxwPrwGCFAV3OqiaKpSagZJo0rj0AtzOa1dkxqaDTZgmPHX4o3z+Fl6Dl629AbETn/y805TDKXOxujhpCj3FHS89ysNGZ2isjJeqSjf5j3gTmMa8P+RJW/LwhsB6UPgEM+zCqDqCKgpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738479849; c=relaxed/simple;
	bh=S/ODEyu/sDQz5ZMVmnTyP7uX15WIsg1hop4S/PCd2+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oijfnCFQckWNlpPDlJXTGTZmoSuTimLmMconwSJaWtyotALKyXsEBf6dRz4fJyfRvwD0TQoP3WIUNeOr1RqiyhmWa7Y9fQ7cfExSPHsNj5RI5CrMM9Cts1SZ+5t8CeDIPkpXPrBExazrhqwASWNba3VmZGp9oN6dnnCIvegCsDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3gwl0fC6; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3gwl0fC6"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so199615ab.0
        for <linux-perf-users@vger.kernel.org>; Sat, 01 Feb 2025 23:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738479847; x=1739084647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TW2WXdFoJdL4hr/KMjHXmSx3JuLPpNVrDh3bvonRhpk=;
        b=3gwl0fC6UU6YhRMIVY+/d1Ho6NdMXlqTo0S3uFpvmpPkYeiTDTj2L8F5BuYORXqNo6
         Y8Hm/s3csQ0LmyYsP1IQiGuJy27hdBs9DbE7jH87oyiqdR53N30emDd+HUVBrz+YZeCp
         4Q5iBBGkA0ujPneueEyHIvNV8X2kuP/tRVICu0KYgWM1KuiDWG/lr3SLUe+QrNJyoDrX
         3jH8QdkC+qQwkoBGfFfEzlEiqoz2uNA6wgRNnwdcoFK5eewuu30VnZi6Hy08ZNrHK8Y1
         yjpLEMZYNBjIjCjaqzmUZtW4IKwB52rxE8iLeL1jX+0hjTRuta3KgyTgtG4hC7ePksVL
         bO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738479847; x=1739084647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TW2WXdFoJdL4hr/KMjHXmSx3JuLPpNVrDh3bvonRhpk=;
        b=AZf1ArJt0ZnzEVcANlSP7fxXZmjkRyw7uxALNd9Wi1hVUhVwxWH5Brwi8Xpy/JtrIe
         M5co3MWJZ51KgiwRKc8X1ZPNBb+S4yhbpHo0MSk3VTl1FXr2wyYMyYPJz+0vdgfhfxKm
         IuiDAXUt4o/x/xwtu0kNVO/1yOpb2mzbgt9JyHr8RCaSddlznufWgE+uroG/JDsJ0RK4
         powRVYgJIBJTJ80RpLxE14teTe1tNZj4DWvsPxPzN6HJChioum8rItv/tfwLeuqy4kqF
         Ju/xMSnFtzL1CFEGkVKfHbJj943/WVbwt8HVHQjbOYpoT47wY182bog9N5Y4uJHCLgaT
         c6sA==
X-Forwarded-Encrypted: i=1; AJvYcCXsR1WCPQEoHBsv/53TWtGI6L6ajUEvxzawNdTuSc6KdQN99Lp9L6IhbxoiVdSwQRQ9xgx+KnryTOX9UcjxUNdH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2e05bdFetSCjb6B9tirQxCpPnUvYWXKZMRMJadhx+Gs3GUxwI
	oslwcnMiljgMcRj3c02vfb8LHWyev7PjE4hAms224heRORetx9XuGEqS/0CNrSyh2Wzc4vtvBpP
	tuz7ZWdWxbBEQetLp5SBmhrK1TnTmuN8sLjb/
X-Gm-Gg: ASbGnctnKdLisAJCIjBkGqNaIS88KjmZp0sBSxxUNu6NtwucZm0NNLxHXjrB1/f9Z0S
	zORhRBMKfqNNn+HQCaceOUSFRxJ49+Omtx+PXSzCvedL0SZ+0NN6cAwXM5+WFVNjNa+hTvirc9Q
	==
X-Google-Smtp-Source: AGHT+IF81ZqX7vPK+R4u8VMmH12X+xPYTa5N3v2X5iXJS2kZJ97rHSYVaKM/TO/f6Z+3eRjFf95QVWBU/TBSyno57Cw=
X-Received: by 2002:a05:6e02:1caa:b0:3cf:fe9a:4d4 with SMTP id
 e9e14a558f8ab-3d020184ba6mr3180435ab.6.1738479846565; Sat, 01 Feb 2025
 23:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130030525.1482498-1-namhyung@kernel.org> <20250130030525.1482498-3-namhyung@kernel.org>
In-Reply-To: <20250130030525.1482498-3-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sat, 1 Feb 2025 23:03:54 -0800
X-Gm-Features: AWEUYZmHzgE77FMjNC4oCHjXnM1LEFv0B-W4EyO4EP6wb-nUuLjcJmaLn8D-7fA
Message-ID: <CAP-5=fUK_aMf8ZYJxmbOLzbu_zZWKYwx_Vvj64x3_2=0u7jbMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf trace: Convert syscall_stats to hashmap
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 7:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It was using a RBtree-based int-list as a hash and a custome resort
> logic for that.  As we have hashmap, let's convert to it and add a
> sorting function using an array.

How is a hashmap connected to a sorting function of an array?

>  It's also to prepare supporting
> system-wide syscall stats.
>
> No functional changes intended.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-trace.c | 122 ++++++++++++++++++++++++++++---------
>  1 file changed, 93 insertions(+), 29 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 7e0324a2e9182088..1d32ef2b05ae8c1c 100644
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
> @@ -1519,17 +1519,55 @@ struct thread_trace {
>                 struct file   *table;
>         } files;
>
> -       struct intlist *syscall_stats;
> +       struct hashmap *syscall_stats;
>  };
>
> +static size_t id_hash(long key, void *ctx __maybe_unused)

I find the use of "id" in this code confusing - it is a pre-existing
problem, but you add to it here. I think a more intention revealing
name would be something like system_call_number_hash.

> +{
> +       return key;
> +}
> +
> +static bool id_equal(long key1, long key2, void *ctx __maybe_unused)
> +{
> +       return key1 =3D=3D key2;
> +}
> +
> +static struct hashmap *alloc_syscall_stats(void)
> +{
> +       struct hashmap *stats =3D hashmap__new(id_hash, id_equal, NULL);
> +
> +       /* just for simpler error check */

What is "just for simpler error check" ?

> +       if (IS_ERR(stats))
> +               stats =3D NULL;
> +       return stats;
> +}
> +
> +static void delete_syscall_stats(struct hashmap *syscall_stats)
> +{
> +       struct hashmap_entry *pos;
> +       size_t bkt;
> +
> +       if (syscall_stats =3D=3D NULL)
> +               return;
> +
> +       hashmap__for_each_entry(syscall_stats, pos, bkt)
> +               free(pos->pvalue);
> +       hashmap__free(syscall_stats);
> +}
> +
>  static struct thread_trace *thread_trace__new(struct trace *trace)
>  {
>         struct thread_trace *ttrace =3D  zalloc(sizeof(struct thread_trac=
e));
>
>         if (ttrace) {
>                 ttrace->files.max =3D -1;
> -               if (trace->summary)
> -                       ttrace->syscall_stats =3D intlist__new(NULL);
> +               if (trace->summary) {
> +                       ttrace->syscall_stats =3D alloc_syscall_stats();
> +                       if (ttrace->syscall_stats =3D=3D NULL) {
> +                               free(ttrace);
> +                               ttrace =3D NULL;

This looks overly indented.

Thanks,
Ian

> +                       }
> +               }
>         }
>
>         return ttrace;
> @@ -1544,7 +1582,7 @@ static void thread_trace__delete(void *pttrace)
>         if (!ttrace)
>                 return;
>
> -       intlist__delete(ttrace->syscall_stats);
> +       delete_syscall_stats(ttrace->syscall_stats);
>         ttrace->syscall_stats =3D NULL;
>         thread_trace__free_files(ttrace);
>         zfree(&ttrace->entry_str);
> @@ -2463,22 +2501,19 @@ struct syscall_stats {
>  static void thread__update_stats(struct thread *thread, struct thread_tr=
ace *ttrace,
>                                  int id, struct perf_sample *sample, long=
 err, bool errno_summary)
>  {
> -       struct int_node *inode;
> -       struct syscall_stats *stats;
> +       struct syscall_stats *stats =3D NULL;
>         u64 duration =3D 0;
>
> -       inode =3D intlist__findnew(ttrace->syscall_stats, id);
> -       if (inode =3D=3D NULL)
> -               return;
> -
> -       stats =3D inode->priv;
> -       if (stats =3D=3D NULL) {
> +       if (!hashmap__find(ttrace->syscall_stats, id, &stats)) {
>                 stats =3D zalloc(sizeof(*stats));
>                 if (stats =3D=3D NULL)
>                         return;
>
>                 init_stats(&stats->stats);
> -               inode->priv =3D stats;
> +               if (hashmap__add(ttrace->syscall_stats, id, stats) < 0) {
> +                       free(stats);
> +                       return;
> +               }
>         }
>
>         if (ttrace->entry_time && sample->time > ttrace->entry_time)
> @@ -4617,18 +4652,45 @@ static size_t trace__fprintf_threads_header(FILE =
*fp)
>         return printed;
>  }
>
> -DEFINE_RESORT_RB(syscall_stats, a->msecs > b->msecs,
> +struct syscall_entry {
>         struct syscall_stats *stats;
>         double               msecs;
>         int                  syscall;
> -)
> +};
> +
> +static int entry_cmp(const void *e1, const void *e2)
>  {
> -       struct int_node *source =3D rb_entry(nd, struct int_node, rb_node=
);
> -       struct syscall_stats *stats =3D source->priv;
> +       const struct syscall_entry *entry1 =3D e1;
> +       const struct syscall_entry *entry2 =3D e2;
>
> -       entry->syscall =3D source->i;
> -       entry->stats   =3D stats;
> -       entry->msecs   =3D stats ? (u64)stats->stats.n * (avg_stats(&stat=
s->stats) / NSEC_PER_MSEC) : 0;
> +       return entry1->msecs > entry2->msecs ? -1 : 1;
> +}
> +
> +static struct syscall_entry *thread__sort_stats(struct thread_trace *ttr=
ace)
> +{
> +       struct syscall_entry *entry;
> +       struct hashmap_entry *pos;
> +       unsigned bkt, i, nr;
> +
> +       nr =3D ttrace->syscall_stats->sz;
> +       entry =3D malloc(nr * sizeof(*entry));
> +       if (entry =3D=3D NULL)
> +               return NULL;
> +
> +       i =3D 0;
> +       hashmap__for_each_entry(ttrace->syscall_stats, pos, bkt) {
> +               struct syscall_stats *ss =3D pos->pvalue;
> +               struct stats *st =3D &ss->stats;
> +
> +               entry[i].stats =3D ss;
> +               entry[i].msecs =3D (u64)st->n * (avg_stats(st) / NSEC_PER=
_MSEC);
> +               entry[i].syscall =3D pos->key;
> +               i++;
> +       }
> +       assert(i =3D=3D nr);
> +
> +       qsort(entry, nr, sizeof(*entry), entry_cmp);
> +       return entry;
>  }
>
>  static size_t thread__dump_stats(struct thread_trace *ttrace,
> @@ -4636,10 +4698,10 @@ static size_t thread__dump_stats(struct thread_tr=
ace *ttrace,
>  {
>         size_t printed =3D 0;
>         struct syscall *sc;
> -       struct rb_node *nd;
> -       DECLARE_RESORT_RB_INTLIST(syscall_stats, ttrace->syscall_stats);
> +       struct syscall_entry *entries;
>
> -       if (syscall_stats =3D=3D NULL)
> +       entries =3D thread__sort_stats(ttrace);
> +       if (entries =3D=3D NULL)
>                 return 0;
>
>         printed +=3D fprintf(fp, "\n");
> @@ -4648,8 +4710,10 @@ static size_t thread__dump_stats(struct thread_tra=
ce *ttrace,
>         printed +=3D fprintf(fp, "                                     (m=
sec)    (msec)    (msec)    (msec)        (%%)\n");
>         printed +=3D fprintf(fp, "   --------------- --------  ------ ---=
----- --------- --------- ---------     ------\n");
>
> -       resort_rb__for_each_entry(nd, syscall_stats) {
> -               struct syscall_stats *stats =3D syscall_stats_entry->stat=
s;
> +       for (size_t i =3D 0; i < ttrace->syscall_stats->sz; i++) {
> +               struct syscall_entry *entry =3D &entries[i];
> +               struct syscall_stats *stats =3D entry->stats;
> +
>                 if (stats) {
>                         double min =3D (double)(stats->stats.min) / NSEC_=
PER_MSEC;
>                         double max =3D (double)(stats->stats.max) / NSEC_=
PER_MSEC;
> @@ -4660,10 +4724,10 @@ static size_t thread__dump_stats(struct thread_tr=
ace *ttrace,
>                         pct =3D avg ? 100.0 * stddev_stats(&stats->stats)=
 / avg : 0.0;
>                         avg /=3D NSEC_PER_MSEC;
>
> -                       sc =3D &trace->syscalls.table[syscall_stats_entry=
->syscall];
> +                       sc =3D &trace->syscalls.table[entry->syscall];
>                         printed +=3D fprintf(fp, "   %-15s", sc->name);
>                         printed +=3D fprintf(fp, " %8" PRIu64 " %6" PRIu6=
4 " %9.3f %9.3f %9.3f",
> -                                          n, stats->nr_failures, syscall=
_stats_entry->msecs, min, avg);
> +                                          n, stats->nr_failures, entry->=
msecs, min, avg);
>                         printed +=3D fprintf(fp, " %9.3f %9.2f%%\n", max,=
 pct);
>
>                         if (trace->errno_summary && stats->nr_failures) {
> @@ -4677,7 +4741,7 @@ static size_t thread__dump_stats(struct thread_trac=
e *ttrace,
>                 }
>         }
>
> -       resort_rb__delete(syscall_stats);
> +       free(entries);
>         printed +=3D fprintf(fp, "\n\n");
>
>         return printed;
> --
> 2.48.1.262.g85cc9f2d1e-goog
>
