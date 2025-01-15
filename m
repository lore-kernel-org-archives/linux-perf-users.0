Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFD41DB159
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2025 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928146; cv=none; b=YPRC0OWLGruzKQimXoA5wlhAfMLBS784Ges05H7yDDQtk0AIipMYuCnkXXQV3iwZyPGNbQqWuhHjErEnXAqcoJW/5HJcdtiWvZITScFFhRVg5lTHoY/G5g7AsWs0wRqxcm0m+A2gII5i5EC4BnqNiQUP85bZQBlrB6jpaSRCngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928146; c=relaxed/simple;
	bh=9SR6eNBaix7dI4gir6x76qxlDnK3TpaX+VytheAmmv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qysqwPunUwCFGPrfq4n1YLCMbAowxz32UNdZWmv0l+2tI8504aTGDKlvKA92aM6HDm3crsOx1fiPmjLsYCT+205sSkfdwYMV4KoPoG8cqXoWc2v2W+HKjg0fR90MN9qKS60AX6bgv6ACejy8by740JrXp7CzYdQ5hmOURLbQsg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fwmhqe4s; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwmhqe4s"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30615661f98so41057321fa.2
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2025 00:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736928142; x=1737532942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aGBP3/A+nD/KjxBNO6UWx8EejIRdLM/OU+p876/XP5E=;
        b=fwmhqe4swOT83YSywElvqx6hV6KPhGagwB5rFPkLBYfxm0bHWHr++/hUs15G6rt8Z9
         Si2IeHyNfyaUorrSyXm9Rc3Mjv5EUVlS7Nx+Ts4jfQRppft91O7TXm0pRwsCe0uM8uH7
         yu0p3GIZP8oNLXLYO3Ob8107pJCTbZGpkVxeFxZtfUtdxGBNvDwNhJMuXtl1kdyNiYnn
         UCGkLayNUzJLChVKshx+SYYe5oanW5Gah81neFQUDDeWZfkCKcfHKRmupebLAWd/yJGY
         Ig3sRwkvuTSbUeDjPEq+cknTwC0n3iPHaJTmK4/HRqQmXYJ2Sl78vSnexQe1Ia7YHt8J
         EDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736928142; x=1737532942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGBP3/A+nD/KjxBNO6UWx8EejIRdLM/OU+p876/XP5E=;
        b=Qw37XMbYat06xxoDtu1MCJ/Ah00beZabpLpqBAG6vvkRpGUsaopgbxYFhFaDioGAau
         Rb6xzXWM7OUT+hoHoNxh4W4Lm8HimDpyv5LYydivTLcOt/5gyW+xyvqvDsLhggNGEiEP
         giaEbULyOeZjcmeg46mflsrIi8mwvQHFbMQPYsIKjPFhAxjGi5XkiZYIwr5PBr+pJQSj
         I1NHxciPv0UuQmc44Cbe56ZO7G4srCaVjWPaJSpEz8URwSQCbB4VhGYYY3Tec+oi5GO0
         AFTx37LfE2ysXouuL6la5UvNaoICK3MKGOCo75x7krGWQY4SIMcIdnbui8R/Gwnd4Uoa
         d1CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuNYTU8GZYonlj9C579cMrSQdHpMtLCT7GFGU5aonQYNCQaZsPaM9PgsTSwP0UPYvdFQDcwc7sAgHKC7SLj6GD@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLee/whgfHw2ebXKSamrzE5m/7oJTTPdru1zHXv2xmCEnT7D2
	t5Ruwr5fpuPxfstnNB7JVe5YCAJJfoL5A+B61bUmTNoesrL8imPwrPh0WAvQWGmCHdmDAzsc34Y
	CZOk0YtTH/jlxRqw8+uJ7VKFHYBZGeAVHay+FZgS2xRrUMWnZzg==
X-Gm-Gg: ASbGncvEUgVga6B89JWsnitGGtMWNpNFDTJ/IgsC1hP8s0lWVVZQ4LhQ0nFXuvB3JN7
	IL2kADsxbRtF5FUa5N+8CLeg+cXJJiHg2grReKAZwCfk1FI6kf6apKw9Hyylq92+QpmOs3MI=
X-Google-Smtp-Source: AGHT+IFrVVXM89lX5l6S/FPlm0pnJxGYya3vCZo/tFOvBCBLJcgAzVgnA807ISXu0MfNQH7+Zaa+E+M/aZtaAT4ALc0=
X-Received: by 2002:a05:651c:a0b:b0:300:1f2c:e3d1 with SMTP id
 38308e7fff4ca-305f45a09abmr93569641fa.23.1736928141964; Wed, 15 Jan 2025
 00:02:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1736775109.git.dvyukov@google.com> <52f5a4dcc10ecb00fdf78750d1b32dabcbaf2a31.1736775109.git.dvyukov@google.com>
 <Z4cKNjudLDJBrlM_@google.com>
In-Reply-To: <Z4cKNjudLDJBrlM_@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 15 Jan 2025 09:02:10 +0100
X-Gm-Features: AbW1kvZMLnSsvvTqdK6tKxY_nn0-txf8ZwCW8yEJob_5eE3M0_dXvy8DeW4hsGc
Message-ID: <CACT4Y+btZxgsBStAAQ8RYhNoidR9Ub0KQYHZFE5TSihPVmAkMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf hist: Deduplicate cmp/sort/collapse code
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jan 2025 at 02:07, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Mon, Jan 13, 2025 at 02:34:14PM +0100, Dmitry Vyukov wrote:
> > Application of cmp/sort/collapse fmt callbacks is duplicated 6 times.
> > Factor it into a common helper function. NFC.
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> >
> > ---
> >
> > Changes in v2:
> >  - add perf_hpp_fmt_cmp_t typedef to util/hist.h
> >  - use the typedef for perf_hpp_fmt::{cmp,collapse,sort}
> > ---
> >  tools/perf/util/hist.c | 103 +++++++++++++++++------------------------
> >  tools/perf/util/hist.h |  14 +++---
> >  2 files changed, 49 insertions(+), 68 deletions(-)
> >
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index fff1345658016..a4b8ec3805565 100644
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
> > @@ -1292,19 +1295,26 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
> >       return err;
> >  }
> >
> > -int64_t
> > -hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
> > +static int64_t
> > +hist_entry__cmp_impl(struct perf_hpp_list *hpp_list, struct hist_entry *left,
> > +                  struct hist_entry *right, unsigned long fn_offset,
> > +                  bool ignore_dynamic, bool ignore_skipped)
>
> Maybe it's a matter of tastes, but I think it could be simpler like
> below.
>
> >  {
> >       struct hists *hists = left->hists;
> >       struct perf_hpp_fmt *fmt;
> >       int64_t cmp = 0;
> > +     perf_hpp_fmt_cmp_t fn;
>
>         perf_hpp_fmt_cmp_t *fn;
>
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
> > +             fn = *(perf_hpp_fmt_cmp_t *)(((char *)fmt) + fn_offset);
> > +             cmp = fn(fmt, left, right);
>
>                 fn = (void *)fmt + fn_offset;
>                 cmp = (*fn)(fmt, left, right);

Done in v3.

> Otherwise, looks good to me.

Thanks for the review.

> Thanks,
> Namhyung
>
> >               if (cmp)
> >                       break;
> >       }
> > @@ -1313,23 +1323,33 @@ hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
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
> > @@ -1503,14 +1523,7 @@ static struct hist_entry *hierarchy_insert_entry(struct hists *hists,
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
> > @@ -1730,24 +1743,6 @@ int hists__collapse_resort(struct hists *hists, struct ui_progress *prog)
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
> > @@ -2449,21 +2444,15 @@ static struct hist_entry *add_dummy_hierarchy_entry(struct hists *hists,
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
> > @@ -2521,16 +2510,10 @@ static struct hist_entry *hists__find_hierarchy_entry(struct rb_root_cached *roo
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
> > index 1131056924d9c..46c8373e31465 100644
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
> > @@ -452,6 +450,9 @@ struct perf_hpp {
> >       bool skip;
> >  };
> >
> > +typedef int64_t (*perf_hpp_fmt_cmp_t)(
> > +     struct perf_hpp_fmt *, struct hist_entry *, struct hist_entry *);
> > +
> >  struct perf_hpp_fmt {
> >       const char *name;
> >       int (*header)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> > @@ -463,12 +464,9 @@ struct perf_hpp_fmt {
> >                    struct hist_entry *he);
> >       int (*entry)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> >                    struct hist_entry *he);
> > -     int64_t (*cmp)(struct perf_hpp_fmt *fmt,
> > -                    struct hist_entry *a, struct hist_entry *b);
> > -     int64_t (*collapse)(struct perf_hpp_fmt *fmt,
> > -                         struct hist_entry *a, struct hist_entry *b);
> > -     int64_t (*sort)(struct perf_hpp_fmt *fmt,
> > -                     struct hist_entry *a, struct hist_entry *b);
> > +     perf_hpp_fmt_cmp_t cmp;
> > +     perf_hpp_fmt_cmp_t collapse;
> > +     perf_hpp_fmt_cmp_t sort;
> >       bool (*equal)(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
> >       void (*free)(struct perf_hpp_fmt *fmt);
> >
> > --
> > 2.47.1.688.g23fc6f90ad-goog
> >
