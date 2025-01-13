Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC2125B2
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775381; cv=none; b=lWS48mX1rM5tZjOgETJHHDAJqfUCDqY0lUMcTWHOchLSMhewMp4Y1MQyGv/ktyqzCBrapkkhQ9kswPK0LGq0pbOWnI8Pmj4XnZiT1OMlJgJ2FtxNBscabbOQyTXVdzJw1SmRwvgCvHAxCzYP5lFefdjR/ovMnAq0pGhp8B+Z5nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775381; c=relaxed/simple;
	bh=7MRnt5QtZ6eytjeXLxiMdsUdnYWBVLIw212wsNiS27Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEkLcqy8zUDxnZNDwHD/2yueVgnSJriVak1zDYMLNAW6BiFpCOw/WHEGPIY6tf2QjEvyM4pMRXvBVhG2hRYsrNlPqW6w2B5e6uRzuTpw1G2ABWepfEv8ktRv+p5w3h6YGz8k3AKNxPQmSSJ9E/fpW5n1cgZYkpI0mdCExIBO2pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LsDjMISB; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LsDjMISB"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3003d7ca01cso39337871fa.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 05:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736775377; x=1737380177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kL2jUEhMcxjXeDvuelQzdeqnEMD1AAlhUiZcass5nMA=;
        b=LsDjMISBi5YkTyyeuZRyS+Ajm+KuWDPN3viOKbcZ2ivdg1BQCDB/XzNttUbzDrphUe
         ZVLrOT54VO9ewt2VXhBJIFHj0oQzHn4LVxiAt4eygvRrjvdx+a2HSKLO5+diX9FmwH2T
         C6YwLVT5gPJrzxSGDNQ6GPAJ2dHPjrAQ2wecslqSvfhbxiwO1u3Sbh3YeugsZkNaId79
         4WB0sd3WWKsAd6ARb7GWt4hVJRxNXPraa3Ew1aZ2hi7PRxlcjBxduK21+sroqQin8kiW
         a+hYJ8JrSd9uFgs14hr8gHS3E81f8EcTMj/XDf9JxbM8pp2wxXyTzBjGZtDqn9WwlRjw
         +4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736775377; x=1737380177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kL2jUEhMcxjXeDvuelQzdeqnEMD1AAlhUiZcass5nMA=;
        b=nfKqfKJPgBGIsH5YE8B/flqvTSmW1rIoR02pXEK93MxnxMRErxlkcZBSFPvzatq+tL
         lND1kE1nsSchwDuZTMCwRkqY5Y+MmEDOmheihARON2fmKHlnbv8eUYuLtIf3GG++o47G
         IBqdaQ8g/6b/vEnJ65rvrWaxcWqwBWqHnJqlS3W1h1orj5r9MCE6garrY5eJaJsvxqk7
         t1s/o4LhNmBgXtsCgk9m7fSs2FJyBSFc4NzSoYh33wqMxNJTgxDksAg7s29oqJxbVm6P
         pvGjL4C9ZoNPX4zLzsQQO+dBifvgCBYRaGYdReCUMvOjK9zwBTASGPiCgDywsfu+q0a1
         fOoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoYarNv//0kpLhS2GA6VABjy8K1N+5KcK5nQSP7A3frAxOesebyeKxdFTJFWKqGrMjqJrxJzDM4RAVOGW3CPR2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3VkkXmoqQ4Uq5iONoP5VWobUk4srRU8PBSnGRLo0kTphjP9h8
	34ekgL83ixQ1Ty/g6urKsxd1bxRqVZBm1bKV+tpjS7NwdHycaCJcC9YfJGJmqFNlLKiUgUFPi+y
	7Hdzet0Tp9qJTj1wV+eGxKipG7+tOHr5hJqmq
X-Gm-Gg: ASbGnctcwOld88XZdN+8/CKqgKlCYKka/KXtBxVIqN9HZVLTf0WA2c06joRaIW9X1ks
	O8R69ka8tqvQLUyPse9HqGJOBvOnHpnWfJBdQk684IqiaoQG2uBELPLeHOsgOXRbuqzn9
X-Google-Smtp-Source: AGHT+IFvSXdi9tzzAJ0y+ojTdVoWoxftZCsbcTPVY1jdQlFO4iFv8DT8k5yBai9BdqtbdqApX8yBYEui0Uyi6G9v3/M=
X-Received: by 2002:a05:651c:4ca:b0:2fb:54d7:71b5 with SMTP id
 38308e7fff4ca-305f45a1f8emr61074811fa.22.1736775376960; Mon, 13 Jan 2025
 05:36:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1736321686.git.dvyukov@google.com> <4bf65a9a789a0bb78e4a3e120ad30389725d2249.1736321686.git.dvyukov@google.com>
 <Z4BDEz3Bmd2DmfNi@google.com> <CACT4Y+ZK_r7sGTrEv5kKnrX4SLAvHPc_cu53wP36K+zmoTjExA@mail.gmail.com>
In-Reply-To: <CACT4Y+ZK_r7sGTrEv5kKnrX4SLAvHPc_cu53wP36K+zmoTjExA@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 13 Jan 2025 14:36:05 +0100
X-Gm-Features: AbW1kvYPvYh7qJZuJN6xRMkbk4kTyW9Evm2mvSVnoo2Ih9m9-p4pb4qDU7A8Vho
Message-ID: <CACT4Y+Y_Mk9BHE0qVobsAp_ROSxQ+dVrbwHWkmg77B9YexQ4cw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf hist: Deduplicate cmp/sort/collapse code
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Jan 2025 at 14:01, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, 9 Jan 2025 at 22:43, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Wed, Jan 08, 2025 at 08:36:53AM +0100, Dmitry Vyukov wrote:
> > > Application of cmp/sort/collapse fmt callbacks is duplicated 6 times.
> > > Factor it into a common helper function. NFC.
> >
> > It's interesting to use offsetof and cast it to functions. :)
>
> Is there a better way to do this?
> Intuitively I reached for member pointers, but then realized it's not
> a thing in C...
>
>
> > > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: linux-perf-users@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >  tools/perf/util/hist.c | 104 +++++++++++++++++------------------------
> > >  tools/perf/util/hist.h |   2 -
> > >  2 files changed, 44 insertions(+), 62 deletions(-)
> > >
> > > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > > index fff1345658016..8e4e844425370 100644
> > > --- a/tools/perf/util/hist.c
> > > +++ b/tools/perf/util/hist.c
> > > @@ -32,6 +32,9 @@
> > >  #include <linux/time64.h>
> > >  #include <linux/zalloc.h>
> > >
> > > +static int64_t hist_entry__cmp(struct hist_entry *left, struct hist_entry *right);
> > > +static int64_t hist_entry__collapse(struct hist_entry *left, struct hist_entry *right);
> > > +
> > >  static bool hists__filter_entry_by_dso(struct hists *hists,
> > >                                      struct hist_entry *he);
> > >  static bool hists__filter_entry_by_thread(struct hists *hists,
> > > @@ -1292,19 +1295,27 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
> > >       return err;
> > >  }
> > >
> > > -int64_t
> > > -hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
> > > +static int64_t
> > > +hist_entry__cmp_impl(struct perf_hpp_list *hpp_list, struct hist_entry *left,
> > > +                  struct hist_entry *right, unsigned long fn_offset,
> > > +                  bool ignore_dynamic, bool ignore_skipped)
> > >  {
> > > +     typedef int64_t (*fn_t)(struct perf_hpp_fmt *, struct hist_entry *, struct hist_entry *);
> >
> > Probably better to put it in util/hist.h and each members (cmp, collapse,
> > sort) use the typedef to make sure they remain in the same.

Good idea!. Done in v2

> Noted. But let's decide on the "perf hist: Fix bogus profiles when
> filters are enabled" first, that was the motivation for this
> refactoring.
>
>
> > >       struct hists *hists = left->hists;
> > >       struct perf_hpp_fmt *fmt;
> > >       int64_t cmp = 0;
> > > +     fn_t fn;
> > >
> > > -     hists__for_each_sort_list(hists, fmt) {
> > > -             if (perf_hpp__is_dynamic_entry(fmt) &&
> > > +     perf_hpp_list__for_each_sort_list(hpp_list, fmt) {
> > > +             if (ignore_dynamic && perf_hpp__is_dynamic_entry(fmt) &&
> > >                   !perf_hpp__defined_dynamic_entry(fmt, hists))
> > >                       continue;
> > >
> > > -             cmp = fmt->cmp(fmt, left, right);
> > > +             if (ignore_skipped && perf_hpp__should_skip(fmt, hists))
> > > +                     continue;
> > > +
> > > +             fn = *(fn_t *)(((char *)fmt) + fn_offset);
> >
> > Doesn't just below work?
> >
> >                 fn = (void *)fmt + fn_offset;

No, this just calculates a pointer to the field that contains the
function pointer. But we also need to dereference that field and get
the function pointer.

> > Thanks,
> > Namhyung
> >
> >
> > > +             cmp = fn(fmt, left, right);
> > >               if (cmp)
> > >                       break;
> > >       }
> > > @@ -1313,23 +1324,33 @@ hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
> > >  }
> > >
> > >  int64_t
> > > -hist_entry__collapse(struct hist_entry *left, struct hist_entry *right)
> > > +hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
> > >  {
> > > -     struct hists *hists = left->hists;
> > > -     struct perf_hpp_fmt *fmt;
> > > -     int64_t cmp = 0;
> > > +     return hist_entry__cmp_impl(left->hists->hpp_list, left, right,
> > > +             offsetof(struct perf_hpp_fmt, cmp), true, false);
> > > +}
> > >
> > > -     hists__for_each_sort_list(hists, fmt) {
> > > -             if (perf_hpp__is_dynamic_entry(fmt) &&
> > > -                 !perf_hpp__defined_dynamic_entry(fmt, hists))
> > > -                     continue;
> > > +static int64_t
> > > +hist_entry__sort(struct hist_entry *left, struct hist_entry *right)
> > > +{
> > > +     return hist_entry__cmp_impl(left->hists->hpp_list, left, right,
> > > +             offsetof(struct perf_hpp_fmt, sort), false, true);
> > > +}
> > >
> > > -             cmp = fmt->collapse(fmt, left, right);
> > > -             if (cmp)
> > > -                     break;
> > > -     }
> > > +int64_t
> > > +hist_entry__collapse(struct hist_entry *left, struct hist_entry *right)
> > > +{
> > > +     return hist_entry__cmp_impl(left->hists->hpp_list, left, right,
> > > +             offsetof(struct perf_hpp_fmt, collapse), true, false);
> > > +}
> > >
> > > -     return cmp;
> > > +static int64_t
> > > +hist_entry__collapse_hierarchy(struct perf_hpp_list *hpp_list,
> > > +                            struct hist_entry *left,
> > > +                            struct hist_entry *right)
> > > +{
> > > +     return hist_entry__cmp_impl(hpp_list, left, right,
> > > +             offsetof(struct perf_hpp_fmt, collapse), false, false);
> > >  }
> > >
> > >  void hist_entry__delete(struct hist_entry *he)
> > > @@ -1503,14 +1524,7 @@ static struct hist_entry *hierarchy_insert_entry(struct hists *hists,
> > >       while (*p != NULL) {
> > >               parent = *p;
> > >               iter = rb_entry(parent, struct hist_entry, rb_node_in);
> > > -
> > > -             cmp = 0;
> > > -             perf_hpp_list__for_each_sort_list(hpp_list, fmt) {
> > > -                     cmp = fmt->collapse(fmt, iter, he);
> > > -                     if (cmp)
> > > -                             break;
> > > -             }
> > > -
> > > +             cmp = hist_entry__collapse_hierarchy(hpp_list, iter, he);
> > >               if (!cmp) {
> > >                       he_stat__add_stat(&iter->stat, &he->stat);
> > >                       return iter;
> > > @@ -1730,24 +1744,6 @@ int hists__collapse_resort(struct hists *hists, struct ui_progress *prog)
> > >       return 0;
> > >  }
> > >
> > > -static int64_t hist_entry__sort(struct hist_entry *a, struct hist_entry *b)
> > > -{
> > > -     struct hists *hists = a->hists;
> > > -     struct perf_hpp_fmt *fmt;
> > > -     int64_t cmp = 0;
> > > -
> > > -     hists__for_each_sort_list(hists, fmt) {
> > > -             if (perf_hpp__should_skip(fmt, a->hists))
> > > -                     continue;
> > > -
> > > -             cmp = fmt->sort(fmt, a, b);
> > > -             if (cmp)
> > > -                     break;
> > > -     }
> > > -
> > > -     return cmp;
> > > -}
> > > -
> > >  static void hists__reset_filter_stats(struct hists *hists)
> > >  {
> > >       hists->nr_non_filtered_entries = 0;
> > > @@ -2449,21 +2445,15 @@ static struct hist_entry *add_dummy_hierarchy_entry(struct hists *hists,
> > >       struct rb_node **p;
> > >       struct rb_node *parent = NULL;
> > >       struct hist_entry *he;
> > > -     struct perf_hpp_fmt *fmt;
> > >       bool leftmost = true;
> > >
> > >       p = &root->rb_root.rb_node;
> > >       while (*p != NULL) {
> > > -             int64_t cmp = 0;
> > > +             int64_t cmp;
> > >
> > >               parent = *p;
> > >               he = rb_entry(parent, struct hist_entry, rb_node_in);
> > > -
> > > -             perf_hpp_list__for_each_sort_list(he->hpp_list, fmt) {
> > > -                     cmp = fmt->collapse(fmt, he, pair);
> > > -                     if (cmp)
> > > -                             break;
> > > -             }
> > > +             cmp = hist_entry__collapse_hierarchy(he->hpp_list, he, pair);
> > >               if (!cmp)
> > >                       goto out;
> > >
> > > @@ -2521,16 +2511,10 @@ static struct hist_entry *hists__find_hierarchy_entry(struct rb_root_cached *roo
> > >
> > >       while (n) {
> > >               struct hist_entry *iter;
> > > -             struct perf_hpp_fmt *fmt;
> > > -             int64_t cmp = 0;
> > > +             int64_t cmp;
> > >
> > >               iter = rb_entry(n, struct hist_entry, rb_node_in);
> > > -             perf_hpp_list__for_each_sort_list(he->hpp_list, fmt) {
> > > -                     cmp = fmt->collapse(fmt, iter, he);
> > > -                     if (cmp)
> > > -                             break;
> > > -             }
> > > -
> > > +             cmp = hist_entry__collapse_hierarchy(he->hpp_list, iter, he);
> > >               if (cmp < 0)
> > >                       n = n->rb_left;
> > >               else if (cmp > 0)
> > > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > > index 1131056924d9c..6cff03eb043b7 100644
> > > --- a/tools/perf/util/hist.h
> > > +++ b/tools/perf/util/hist.h
> > > @@ -342,8 +342,6 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
> > >  struct perf_hpp;
> > >  struct perf_hpp_fmt;
> > >
> > > -int64_t hist_entry__cmp(struct hist_entry *left, struct hist_entry *right);
> > > -int64_t hist_entry__collapse(struct hist_entry *left, struct hist_entry *right);
> > >  int hist_entry__transaction_len(void);
> > >  int hist_entry__sort_snprintf(struct hist_entry *he, char *bf, size_t size,
> > >                             struct hists *hists);
> > > --
> > > 2.47.1.613.gc27f4b7a9f-goog
> > >
