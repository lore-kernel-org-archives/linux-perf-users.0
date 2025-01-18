Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9C110F2;
	Sat, 18 Jan 2025 03:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737169407; cv=none; b=DdaA+l4TZywJJkhtj/h5MbOciQG6LwpaagjT3HlMyxCYgZ2iP+RjJwXkrOfrzLPKL+ClYY4O4egnWsaZkHHlTEWQrJpRaSe6Y6u7l9qTHnsGFQZ9aohlRU+36gNqBqZBbj93TlFL9NzLicTc7quNKRBxR81NLoEiGbfmQMZBnxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737169407; c=relaxed/simple;
	bh=hje9bjga0lHUMdgn0Lht6DDygVZLP+XQW7OcggQ28Ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbZFXulJMNrOy+87f0lUJmptYU6sowM+c/A/7n69LFB8fyRGnola/qCUAWhSbHsNjADm7hAnbzGuocr9bA/bcs9GGVmPn1y6Om4vREwhkRqwGWV+ejMG9xhHVqDuHVLQNnuTvdvPGf3Y+p1O8wfV4hXxVuMVA8frz1jg1mw7mNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfBSmN/m; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfBSmN/m"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e399e904940so4307877276.2;
        Fri, 17 Jan 2025 19:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737169405; x=1737774205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSKp4iotqJT3vHTGoq9EjSiYcIa8N06H91s2WJYjxbM=;
        b=UfBSmN/mIqDHYCfOZnHYixbQu7tBrgdD9AP2mdwjUVobx5jB34g4TVck2AEpy3WXL2
         difqJ2OVHx54A8mDWXeWmtmHo/GKqVT1W+eSIy422rBkidduqgEqyhm0ypyhvB4QWyQx
         7rCjEomqhWIbuxIY+JvcIDD5//b6pbmvhgAeLTdteR/UVcfe5qnGM3rTUd0/XETHr+hm
         A6CeInnb01JewkUtm9ln2gi7D6yrYvDti5zKW+E+BwVS9WcSpSkbo227gKQQuzZYDlGf
         KP9aP2yCeAa3YzXn6uiYhOSghqlAfkZctEw/t3c7eF6itrUgZKu4Hs1uyclFl4W8f6OT
         CBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737169405; x=1737774205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSKp4iotqJT3vHTGoq9EjSiYcIa8N06H91s2WJYjxbM=;
        b=gbl07qwzIvbnvFxaMUNsfoh8+CnC5NaCx6FYbdisSNf/NadScZ15jm4K4VzAMu4my5
         72ZYTUQ+peS7MZm804hbWlzrBxxGuEXudZ5fblTFLNjDOd+uzAVZGwTee/XSBUZPUWGU
         3qc/I3wWH/BB1nvEWmM1R2Psnja4s23FOP9y2GLuFokSh9FPwLkFrYl8xJWk/GJdLGOd
         3wB8bd9pkMQ14n5y93vFy/ASCjM1ZivuHhgHDuGF+mUpo2zKjTlQ+9/8ruDDVe1TgEPr
         aNnC6fF1aLcixHcIs5c1YZRdGkxHeLSQbamVkwyVxC08OHag14Ogvtkb/g8H5K4ugiDP
         mSBw==
X-Forwarded-Encrypted: i=1; AJvYcCXNpk4zHlvQs40/7t0fsd/uHBHt5DhHSzYfhkoASWPVxXNyCRkpjXxOoFGLzxIN57eHDsNBuJD3NUR4USV9hr4O5w==@vger.kernel.org, AJvYcCXwm/IN8b7I2aUbckd+DZiInq1JWwoDRdNQvx/JrhZM7ftwOsTYfSMd8S+qjOei6SxDtVMXERh27dZG71Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWfQS2VXZVucWvmvcanN4eh2Xc6EpC+Ukf3EnNKCjb5eR08B/v
	Te7ZDBfX7Vwh0nfiWWHCx+liyH0EuF9Ggjn9q28EdOASLRNSOHvGAZ+U5aOd15j2IPcD0FmGu2T
	M6asmvU1CEjPMpnCKZDWloEI3b1Y=
X-Gm-Gg: ASbGncuWoeN8qMjJu9biszjTTssT+QDapgRk8D1EgCVoCp2AiOY9orgtQUvXHpkhxMO
	OEZKNNi2VPaGE8FwK/eZEgKeEXkPXfU99eMzsJXrmVj8GTttd3y93
X-Google-Smtp-Source: AGHT+IEoY1m7+9s9DfqDbnNrbgc13u9MGj+6yWgalY2f9FFDa2490w4DBIllryd1d8KHstnMvNat2+oaoafJT/6rbBY=
X-Received: by 2002:a05:690c:25ca:b0:6ef:7f34:fe08 with SMTP id
 00721157ae682-6f6eb6b26c5mr52950227b3.18.1737169405051; Fri, 17 Jan 2025
 19:03:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114212256.160730-1-namhyung@kernel.org> <20250114212256.160730-3-namhyung@kernel.org>
In-Reply-To: <20250114212256.160730-3-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 17 Jan 2025 19:03:13 -0800
X-Gm-Features: AbW1kvZE_cQMDZHP8AbEBcQGrK6oKNqPRzMsv_Z9kujM46VbrUg4Mb7XJQMol84
Message-ID: <CAH0uvogVw6UGxZf1OZRPt5YWpHtGbi6LbH-9VYpOipEWGwM_4A@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf trace: Convert syscall_stats to hashmap
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

Sorry for the delay caused by health issues. In my opinion, this
unlocks the true power of perf trace=E2=80=94a high-performance, buffered, =
and
multi-process (or system-wide) tracer.

On Tue, Jan 14, 2025 at 1:22=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It was using a RBtree-based int-list as a hash and a custome resort
> logic for that.  As we have hashmap, let's convert to it and add a
> sorting function using an array.  It's also to prepare supporting
> system-wide syscall stats.
>
> No functional changes intended.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-trace.c | 121 ++++++++++++++++++++++++++++---------
>  1 file changed, 92 insertions(+), 29 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 0691e817c15b4136..ad7f7fcd0d80b9df 100644
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
> @@ -1520,17 +1520,55 @@ struct thread_trace {
>                 struct file   *table;
>         } files;
>
> -       struct intlist *syscall_stats;
> +       struct hashmap *syscall_stats;
>  };
>
> +static size_t id_hash(long key, void *ctx __maybe_unused)
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
> +       if (IS_ERR_OR_NULL(stats))

I don't think stats will ever be NULL.

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
> +                       }
> +               }
>         }
>
>         return ttrace;
> @@ -1545,7 +1583,7 @@ static void thread_trace__delete(void *pttrace)
>         if (!ttrace)
>                 return;
>
> -       intlist__delete(ttrace->syscall_stats);
> +       delete_syscall_stats(ttrace->syscall_stats);
>         ttrace->syscall_stats =3D NULL;
>         thread_trace__free_files(ttrace);
>         zfree(&ttrace->entry_str);
> @@ -2464,22 +2502,19 @@ struct syscall_stats {
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
> @@ -4618,18 +4653,45 @@ static size_t trace__fprintf_threads_header(FILE =
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
> +{
> +       const struct syscall_entry *entry1 =3D e1;
> +       const struct syscall_entry *entry2 =3D e2;
> +
> +       return entry1->msecs > entry2->msecs ? -1 : 1;
> +}
> +
> +static struct syscall_entry *thread__sort_stats(struct thread_trace *ttr=
ace)
>  {
> -       struct int_node *source =3D rb_entry(nd, struct int_node, rb_node=
);
> -       struct syscall_stats *stats =3D source->priv;
> +       struct syscall_entry *entry;
> +       struct hashmap_entry *pos;
> +       unsigned bkt, i, nr;
> +
> +       nr =3D ttrace->syscall_stats->sz;
> +       entry =3D malloc(nr * sizeof(*entry));
> +       if (entry =3D=3D NULL)
> +               return NULL;
>
> -       entry->syscall =3D source->i;
> -       entry->stats   =3D stats;
> -       entry->msecs   =3D stats ? (u64)stats->stats.n * (avg_stats(&stat=
s->stats) / NSEC_PER_MSEC) : 0;
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
> @@ -4637,10 +4699,10 @@ static size_t thread__dump_stats(struct thread_tr=
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
> @@ -4649,8 +4711,9 @@ static size_t thread__dump_stats(struct thread_trac=
e *ttrace,
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

Maybe add a newline here?

>                 if (stats) {
>                         double min =3D (double)(stats->stats.min) / NSEC_=
PER_MSEC;
>                         double max =3D (double)(stats->stats.max) / NSEC_=
PER_MSEC;
> @@ -4661,10 +4724,10 @@ static size_t thread__dump_stats(struct thread_tr=
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
> @@ -4678,7 +4741,7 @@ static size_t thread__dump_stats(struct thread_trac=
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
> 2.48.0.rc2.279.g1de40edade-goog
>

Thanks,
Howard
