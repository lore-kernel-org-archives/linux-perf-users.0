Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194120B7F8
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736514126; cv=none; b=DbAxF9gZy5Bti6Gsapd9UA2xR0JTRA6MTXuVz9mJVtP15sVU0PFKTkK/qm7JAqGpmLCrnZ1J86An38gD+FdToI7Lr5RjaVZ9UQApjVpbm1GZ9g0DCFT/7au/o+kpIkEZQVxQPayRUOOSft4OXOQrvIYhf+lBTmU69oH4C4kZNDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736514126; c=relaxed/simple;
	bh=Z1Uz6ZJed86ji0XJL8PRjB6zEwYRWO7DKK4CAGVN+4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/I14FpbT5YDrK0PAAwLeJpuagq3xW8nsLcqb/cD+MMPfSC1LpYw3po4j/WCEfRZCk95um49LKezP1pR1PAbsu9CKqr67mu4xY9vpxVtMhkv2yBRerXvF5p0+dDL08Dtf/j2Uf7xq0DNbu5GcZAFGWUCpmQybvgMWtqWVi8C0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B5WuMZSK; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B5WuMZSK"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30225b2586cso28299551fa.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 05:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736514122; x=1737118922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GIuJaAcBh+r7/ShmaoODtZ0yk30WEYhss4VTwuY6EOc=;
        b=B5WuMZSKwypzWAY1uJFrq252cMIsTh8KVsJSeSvRFertk+kOMrpHWZkZ5Bl6j48rad
         AiDjdGmVC6V6tY7WfNHxTpo2MMqdnj4Zj8rxnBq1X6iG7i9KDXyYztRMY2yLA+sy+s1J
         BdItQ36nxOZ+91oBAbKRm6arsUdVco6m4cx3GfX4q8lX31EHJMeEoFxWHJL9wvYHPGrI
         UqlYZHbmpseYadn1qe24sxDhik86utXERNDX8cviQBJw1fOGK/sDG5foSk2+rKV0vp0z
         +ORfXDsOeu7bMfKz9LfVWwQvD0nDqFiw+ggOgaPw3yAFaArvrhv4tl8dzmul3FdYj3ln
         fYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736514122; x=1737118922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GIuJaAcBh+r7/ShmaoODtZ0yk30WEYhss4VTwuY6EOc=;
        b=CALkZPXtP4Uk2vJlKA1PfeJYKZnVgk07b50FtiT9BKh/mTx2kz/7dD6qQGa/qumPqd
         NR5KYK0ztTxGXPs9qYX/oXlG/tj6Hvr9lFYV6VX0e1nt2vMjU/deDNb1WI0tOYLF4qiC
         svoXTjT3I0PHbe7ayNqXzQeRz//coUx9lRSpZqx/6329Fd2pWdb2Y2pwsi3g41z4QNkJ
         aYaAJnbs+4uSO96is0COPKLtmhc+Gy2JIkwgsBvMeUbVMpO94gQga0ijgjvNHb5vJeRF
         T2zKxDFFTNiQMdchRzjIjpWrGRfCApieQv6yfsk1RJZlG1lE9S59lz2ZO3HwMZSW93/w
         9iQw==
X-Forwarded-Encrypted: i=1; AJvYcCV6cSSJC7wLmXCOiDQT2UpBN7jqLPV6pHlXicspIm4kiu6tB/1mY2b55rYoGxiT4ouXUjLqpBjuzT2sRLwBb66M@vger.kernel.org
X-Gm-Message-State: AOJu0YwVhVyRMyfiq93o/2ZV5fPNp9Bv6/x2YQ4GaSO76GlveIGAjMC5
	0ze4UAqWGliMfDtKsfPkd5TeSPeX75ygCWcDZVIU7mjIt3JwarDoaDkvB8qe4+sAspCNiLntSIC
	CuPzYkqE/A5QvVpB7vOheTdKLPwWAz6IS8VQC
X-Gm-Gg: ASbGncvVq+rdsKyevImSxx1rmn4scM8oIQ6WbckHTdhxCQ8RPIcYULjQB0OquObPl2L
	oZlo/hWDAsZADqlSTlWk5GtgKFVHN1PnfOyEuQgQp+VhXN3ovHWsEt5tK62txjGn0jegylV8=
X-Google-Smtp-Source: AGHT+IEXHT0qoxBwxT1z36KB1QUksLLsmmh0uUBfvDj54hax/MNOvMeNWnJ6/p5xvJ3ZEpAZuBHuD3CPhuijLz4bkpw=
X-Received: by 2002:a05:651c:b25:b0:2ff:5589:5a1a with SMTP id
 38308e7fff4ca-305fcfa0440mr22232021fa.6.1736514122117; Fri, 10 Jan 2025
 05:02:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1736321686.git.dvyukov@google.com> <4bf65a9a789a0bb78e4a3e120ad30389725d2249.1736321686.git.dvyukov@google.com>
 <Z4BDEz3Bmd2DmfNi@google.com>
In-Reply-To: <Z4BDEz3Bmd2DmfNi@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 10 Jan 2025 14:01:50 +0100
X-Gm-Features: AbW1kvakSUi_GepURCxmO2p08MvR5f1bmHmXxInHUvQ-ueSmRURkKU2nh-b2XeY
Message-ID: <CACT4Y+ZK_r7sGTrEv5kKnrX4SLAvHPc_cu53wP36K+zmoTjExA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf hist: Deduplicate cmp/sort/collapse code
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 22:43, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Wed, Jan 08, 2025 at 08:36:53AM +0100, Dmitry Vyukov wrote:
> > Application of cmp/sort/collapse fmt callbacks is duplicated 6 times.
> > Factor it into a common helper function. NFC.
>
> It's interesting to use offsetof and cast it to functions. :)

Is there a better way to do this?
Intuitively I reached for member pointers, but then realized it's not
a thing in C...


> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  tools/perf/util/hist.c | 104 +++++++++++++++++------------------------
> >  tools/perf/util/hist.h |   2 -
> >  2 files changed, 44 insertions(+), 62 deletions(-)
> >
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index fff1345658016..8e4e844425370 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -32,6 +32,9 @@
> >  #include <linux/time64.h>
> >  #include <linux/zalloc.h>
> >
> > +static int64_t hist_entry__cmp(struct hist_entry *left, struct hist_entry *right);
> > +static int64_t hist_entry__collapse(struct hist_entry *left, struct hist_entry *right);
> > +
> >  static bool hists__filter_entry_by_dso(struct hists *hists,
> >                                      struct hist_entry *he);
> >  static bool hists__filter_entry_by_thread(struct hists *hists,
> > @@ -1292,19 +1295,27 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
> >       return err;
> >  }
> >
> > -int64_t
> > -hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
> > +static int64_t
> > +hist_entry__cmp_impl(struct perf_hpp_list *hpp_list, struct hist_entry *left,
> > +                  struct hist_entry *right, unsigned long fn_offset,
> > +                  bool ignore_dynamic, bool ignore_skipped)
> >  {
> > +     typedef int64_t (*fn_t)(struct perf_hpp_fmt *, struct hist_entry *, struct hist_entry *);
>
> Probably better to put it in util/hist.h and each members (cmp, collapse,
> sort) use the typedef to make sure they remain in the same.

Noted. But let's decide on the "perf hist: Fix bogus profiles when
filters are enabled" first, that was the motivation for this
refactoring.


> >       struct hists *hists = left->hists;
> >       struct perf_hpp_fmt *fmt;
> >       int64_t cmp = 0;
> > +     fn_t fn;
> >
> > -     hists__for_each_sort_list(hists, fmt) {
> > -             if (perf_hpp__is_dynamic_entry(fmt) &&
> > +     perf_hpp_list__for_each_sort_list(hpp_list, fmt) {
> > +             if (ignore_dynamic && perf_hpp__is_dynamic_entry(fmt) &&
> >                   !perf_hpp__defined_dynamic_entry(fmt, hists))
> >                       continue;
> >
> > -             cmp = fmt->cmp(fmt, left, right);
> > +             if (ignore_skipped && perf_hpp__should_skip(fmt, hists))
> > +                     continue;
> > +
> > +             fn = *(fn_t *)(((char *)fmt) + fn_offset);
>
> Doesn't just below work?
>
>                 fn = (void *)fmt + fn_offset;
>
> Thanks,
> Namhyung
>
>
> > +             cmp = fn(fmt, left, right);
> >               if (cmp)
> >                       break;
> >       }
> > @@ -1313,23 +1324,33 @@ hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
> >  }
> >
> >  int64_t
> > -hist_entry__collapse(struct hist_entry *left, struct hist_entry *right)
> > +hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
> >  {
> > -     struct hists *hists = left->hists;
> > -     struct perf_hpp_fmt *fmt;
> > -     int64_t cmp = 0;
> > +     return hist_entry__cmp_impl(left->hists->hpp_list, left, right,
> > +             offsetof(struct perf_hpp_fmt, cmp), true, false);
> > +}
> >
> > -     hists__for_each_sort_list(hists, fmt) {
> > -             if (perf_hpp__is_dynamic_entry(fmt) &&
> > -                 !perf_hpp__defined_dynamic_entry(fmt, hists))
> > -                     continue;
> > +static int64_t
> > +hist_entry__sort(struct hist_entry *left, struct hist_entry *right)
> > +{
> > +     return hist_entry__cmp_impl(left->hists->hpp_list, left, right,
> > +             offsetof(struct perf_hpp_fmt, sort), false, true);
> > +}
> >
> > -             cmp = fmt->collapse(fmt, left, right);
> > -             if (cmp)
> > -                     break;
> > -     }
> > +int64_t
> > +hist_entry__collapse(struct hist_entry *left, struct hist_entry *right)
> > +{
> > +     return hist_entry__cmp_impl(left->hists->hpp_list, left, right,
> > +             offsetof(struct perf_hpp_fmt, collapse), true, false);
> > +}
> >
> > -     return cmp;
> > +static int64_t
> > +hist_entry__collapse_hierarchy(struct perf_hpp_list *hpp_list,
> > +                            struct hist_entry *left,
> > +                            struct hist_entry *right)
> > +{
> > +     return hist_entry__cmp_impl(hpp_list, left, right,
> > +             offsetof(struct perf_hpp_fmt, collapse), false, false);
> >  }
> >
> >  void hist_entry__delete(struct hist_entry *he)
> > @@ -1503,14 +1524,7 @@ static struct hist_entry *hierarchy_insert_entry(struct hists *hists,
> >       while (*p != NULL) {
> >               parent = *p;
> >               iter = rb_entry(parent, struct hist_entry, rb_node_in);
> > -
> > -             cmp = 0;
> > -             perf_hpp_list__for_each_sort_list(hpp_list, fmt) {
> > -                     cmp = fmt->collapse(fmt, iter, he);
> > -                     if (cmp)
> > -                             break;
> > -             }
> > -
> > +             cmp = hist_entry__collapse_hierarchy(hpp_list, iter, he);
> >               if (!cmp) {
> >                       he_stat__add_stat(&iter->stat, &he->stat);
> >                       return iter;
> > @@ -1730,24 +1744,6 @@ int hists__collapse_resort(struct hists *hists, struct ui_progress *prog)
> >       return 0;
> >  }
> >
> > -static int64_t hist_entry__sort(struct hist_entry *a, struct hist_entry *b)
> > -{
> > -     struct hists *hists = a->hists;
> > -     struct perf_hpp_fmt *fmt;
> > -     int64_t cmp = 0;
> > -
> > -     hists__for_each_sort_list(hists, fmt) {
> > -             if (perf_hpp__should_skip(fmt, a->hists))
> > -                     continue;
> > -
> > -             cmp = fmt->sort(fmt, a, b);
> > -             if (cmp)
> > -                     break;
> > -     }
> > -
> > -     return cmp;
> > -}
> > -
> >  static void hists__reset_filter_stats(struct hists *hists)
> >  {
> >       hists->nr_non_filtered_entries = 0;
> > @@ -2449,21 +2445,15 @@ static struct hist_entry *add_dummy_hierarchy_entry(struct hists *hists,
> >       struct rb_node **p;
> >       struct rb_node *parent = NULL;
> >       struct hist_entry *he;
> > -     struct perf_hpp_fmt *fmt;
> >       bool leftmost = true;
> >
> >       p = &root->rb_root.rb_node;
> >       while (*p != NULL) {
> > -             int64_t cmp = 0;
> > +             int64_t cmp;
> >
> >               parent = *p;
> >               he = rb_entry(parent, struct hist_entry, rb_node_in);
> > -
> > -             perf_hpp_list__for_each_sort_list(he->hpp_list, fmt) {
> > -                     cmp = fmt->collapse(fmt, he, pair);
> > -                     if (cmp)
> > -                             break;
> > -             }
> > +             cmp = hist_entry__collapse_hierarchy(he->hpp_list, he, pair);
> >               if (!cmp)
> >                       goto out;
> >
> > @@ -2521,16 +2511,10 @@ static struct hist_entry *hists__find_hierarchy_entry(struct rb_root_cached *roo
> >
> >       while (n) {
> >               struct hist_entry *iter;
> > -             struct perf_hpp_fmt *fmt;
> > -             int64_t cmp = 0;
> > +             int64_t cmp;
> >
> >               iter = rb_entry(n, struct hist_entry, rb_node_in);
> > -             perf_hpp_list__for_each_sort_list(he->hpp_list, fmt) {
> > -                     cmp = fmt->collapse(fmt, iter, he);
> > -                     if (cmp)
> > -                             break;
> > -             }
> > -
> > +             cmp = hist_entry__collapse_hierarchy(he->hpp_list, iter, he);
> >               if (cmp < 0)
> >                       n = n->rb_left;
> >               else if (cmp > 0)
> > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > index 1131056924d9c..6cff03eb043b7 100644
> > --- a/tools/perf/util/hist.h
> > +++ b/tools/perf/util/hist.h
> > @@ -342,8 +342,6 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
> >  struct perf_hpp;
> >  struct perf_hpp_fmt;
> >
> > -int64_t hist_entry__cmp(struct hist_entry *left, struct hist_entry *right);
> > -int64_t hist_entry__collapse(struct hist_entry *left, struct hist_entry *right);
> >  int hist_entry__transaction_len(void);
> >  int hist_entry__sort_snprintf(struct hist_entry *he, char *bf, size_t size,
> >                             struct hists *hists);
> > --
> > 2.47.1.613.gc27f4b7a9f-goog
> >
