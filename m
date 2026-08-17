Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEC33C3C0F
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 21:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001082; cv=pass; b=i4huSgfkHKqmnYk6STlKdZYDfV4EkQBwJsn6QXLWNZ1fDrYun2gO1eUDkxv33hzLYgk9RXsGUz+Y3RRwWTSKlQseza74CqpLV0p6eiYrLAFSey4RjQxsKdJdggnpiN0i76wV5lRujCMm2AeAn84UMvxcg1bshWEL9wIoDP0aWMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001082; c=relaxed/simple;
	bh=e1OAK/Q7wmB8Cr0xDDupx+FW+hJ6zpFuVcokDD2kNIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhDP8HxMOfDh3IcNUQ1hYdNnT8lcd0AlJ3UE8kdnZEi8Mml8wpAX/Bhbrj0GC0IHZuPccQJLcMeg053SgbQ0PbV3L+2xDyi9Ly4ysweOOev896kGya1deAhEiRbud88VUioUw+JFnY0a3DUnujoQCqiUBPrdi+LAfvHk4cwcY5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKVk0VDr; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKVk0VDr"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c10ed63c0so25981cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 14:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787001079; cv=none;
        d=google.com; s=arc-20260327;
        b=qdHNsFAw51IykbDsAg7sWIudb8BAE8fSyMKr2jPsyaEruaWXnU+gZbCWABcdzFeM6F
         NUheTrXipI+jSfOwA70T7vzJCnFsGLj3Iy5MLDVMxAC4AQ0Y6p4j+0uj18eZMbFYYVSh
         f/UmQAhGMMjbpxzblwgEx4ck2vB/LoW653IT3bXJPNYvta6d19leAsjkSE0o8JcI3BrS
         e1iTyqUmZ2ElO/VBJoyMcudaTztrUXE3MuJqM3L9uNcwMJ0mWKMMr6tHcjE8YY6eO7E/
         /avYJIhaNvlur/F3I2bTnxFWzOYAYTBlmFIN7I31nHiGP+nUNTa8mPRz5lFXavmM0Fnl
         bOZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NTzITL/8KAZWzB0WH4tM8a5mkUZVeIWUfQTCKUUV6Ww=;
        fh=YCHWaJMHqUCutX2UO5tKNENHvJS5wr8SJyiNMgLYJOA=;
        b=MDxDR+Eb5lNow63N8kkV9Ganw+IBOikQwisXg2QzuoftKJwJeYPt9jzGfVnNgbcXJv
         0fmiI6NGZ195EQLPJn2CRDkND5andywJO4d6Sfpi3phsZAnWZ6JsHIMCac7hS2KlkLRs
         o0qY5FwGCQJZwcXCM+rTL2j+s32ZmKXfa2PC3wjNE4C77nJYg65h1uPXbcdWkVF/2Txc
         g/SC0dFVjg1ABcEzU+nkeGhq5pCWG801JtAe6yXvtm7jTTBTp6cRxzci9yDsRpYui65J
         woo3tJCc7v9f7u5zrZ1QZmMnDV31PL16NSl4mgmn3vxWH9EtPRMyoICSwcvU/MC5brtm
         jC5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787001079; x=1787605879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NTzITL/8KAZWzB0WH4tM8a5mkUZVeIWUfQTCKUUV6Ww=;
        b=JKVk0VDr6qfIGzYkV7EkeW0w5qI7+RKhwyQayVq95dJRuD538/NJGgYA3owbXzI1h5
         k//mW0y3fTdUAi7if4HKnhAZACEwmsNgohltL9U1h46NW7cS/8nsiDjEMyDQ5RkUwfRT
         SbEUP3D5oS1Yx0uNGKRhMExKYO7Stay8+sSyBN1jj2/VAQt2eQIIIZttfWP0xHFMV2XD
         mNzXni/2lnMr97IVbPw3Vw2c0ks3aHKyGzex1CcWSwKta8+s6TB+oL0CeirLYx2T052+
         2bQAetdc1XpbAK01EwY5zJ7R4dbzu6zkZQIIGEl2WWCRmHcjgii5KIu3tOF+m/ld/2Ok
         Abeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001079; x=1787605879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NTzITL/8KAZWzB0WH4tM8a5mkUZVeIWUfQTCKUUV6Ww=;
        b=pUqxE5FmR9c4r6P+5fABbw+oBRsG1sZRTU+PT/YFlZn1m9BO6NljnVTAfl7gO/l7Po
         BJsoR3JwFHGe4irnc04DKsZmVEFuOFX3b04aWyRpNTWmUxHWi5P1KRtOgYInoKq7YuL+
         cuAWiNYJgtHGMVG2WubkoIw9ORRjtgnZlYvr+NLapQrA55gJ7ONbEd2CptPGnXnYxmKp
         0pFgh54dNHIoV7WlV0E4F4sMRyY+adPspB/NfAssuus+6XIemzI5oVSrplwaOYjVcnWC
         vYQMpeOooYnETmh9UQjqelkwVJ6vmD6GOOf55jO8i0s81Uwd+APLsJsUMgdJpevL/Or5
         xqVA==
X-Forwarded-Encrypted: i=1; AHgh+RoME/PoWkDNNo2FaMYadvYlaYBIGhMcG9CzsmsJXnq47QED6GABlSbCGCMdeCFA+NRMDnl92WAh2LivYHjtHgWj@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYXLUB77vcHQnJ+GBE73gqRXDkbXeNwa7TdVEfRGs0JRdcqvG
	/aAXvNhYwPnkEIJvp9Mw5m6e5++Pddvqlv7rCBNv4FDVxP9MXeFYGWsS9hltGqy+jTb2GXWis/Q
	w6iBaMA+Kt3y5C79/ccLFSVyQ4jEUYajwp7t5ET6W
X-Gm-Gg: AR+sD11dbXg4fFYlDPixSQ3sFFnOfcyQcAOn0vzgjzHisjjx+7Kq6WxRFPqx7cPr8G3
	61GnzUcsIQ1AatxasgIBM2+BV+qemt4UyDMlLp+FClkrVwwdzMloRT7fIGb5Uw5llj7hsf9TClg
	qrRkNpgQUimAKxpszV04Y8/xDWroweWCzCqpab5SbvznHusGTHkZY/8UIqmssASCG8MW2LSW1od
	M2X29LP/bwS19LQu36EzOvunIIK2mJOHIqrFwr/HkzaIscWbCOUO5OiJbtuzfNBMt7kdxRFo3QV
	9393SY2HPs0EysIlD65ibiDtB4RnekL9iemNqgNeRqAThnzIaxNj8hmk+9ssamo/EAK7+WD+YRl
	eZ6v6Y7Pc9MM=
X-Received: by 2002:ac8:5f95:0:b0:51c:ca9:3d15 with SMTP id
 d75a77b69052e-52dc0a516a2mr4450981cf.12.1787001078126; Mon, 17 Aug 2026
 14:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817094623.3288456-1-jiebin.sun@intel.com> <20260817094623.3288456-8-jiebin.sun@intel.com>
In-Reply-To: <20260817094623.3288456-8-jiebin.sun@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 14:11:06 -0700
X-Gm-Features: AcwNN1US4JB8hn2BpiwWaIgRQstuclfdzJk6bIcpx3K2pOEcUooFgOU-RBp5EGM
Message-ID: <CAP-5=fU8o-3PLaTdx4manLcvZr5FUmwEnWxFtj82Vd1A3Uso3w@mail.gmail.com>
Subject: Re: [PATCH v9 7/9] perf c2c: build and finalize the function view hierarchy
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: namhyung@kernel.org, acme@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	mark.rutland@arm.com, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, wangyang.guo@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 2:40=E2=80=AFAM Jiebin Sun <jiebin.sun@intel.com> w=
rote:
>
> Add the builder that walks the top-level cacheline entries and, for each
> read-side function, correlates the functions that write the same lines
> (level 2) and the specific cachelines they contend over (level 3) within
> each retained detail histogram. Aggregate the write traffic per contendin=
g
> function, resort by store count, and prune writers/functions with no
> contention. The finalize pass then computes the Cycles % denominator from
> the surviving level-1 entries after pruning, so the column shows each
> function's share of the functions retained in the table rather than of th=
e
> whole recording -- the semantics documented for Cycles % in perf-c2c.txt.
>
> Expose c2c_function__build() and c2c_function__reset() for the TUI front
> end added by the next patch. The builder requires iaddr in the cacheline
> coalescing fields and returns the completed hists through an output
> argument. Validate the inputs before replacing an existing model.
>
> Function-view entries do not carry callchains. Suppress callchain handlin=
g
> while building and tearing down the model so the common API does not depe=
nd
> on the caller's current callchain setting.
>
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Falcon <thomas.falcon@intel.com>
> Reviewed-by: Tianyou Li <tianyou.li@intel.com>
> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/c2c-function.c | 530 ++++++++++++++++++++++++++++++++-
>  tools/perf/util/c2c.h          |  10 +
>  2 files changed, 525 insertions(+), 15 deletions(-)
>
> diff --git a/tools/perf/util/c2c-function.c b/tools/perf/util/c2c-functio=
n.c
> index c005fb5454a7..5b6a06a5a067 100644
> --- a/tools/perf/util/c2c-function.c
> +++ b/tools/perf/util/c2c-function.c
> @@ -45,9 +45,9 @@ struct c2c_function_model {
>         bool                     symbol_full;
>  };
>
> -static struct c2c_function_model c2c_ext __maybe_unused;
> +static struct c2c_function_model c2c_ext;
>
> -static inline __maybe_unused u64 c2c_hitm_count(const struct c2c_stats *=
stats)
> +static inline u64 c2c_hitm_count(const struct c2c_stats *stats)
>  {
>         return stats->tot_hitm;
>  }
> @@ -82,7 +82,7 @@ static int64_t c2c_function_cmp(const struct map_symbol=
 *left,
>         return _sort__sym_cmp(left->sym, right->sym);
>  }
>
> -static inline __maybe_unused u64 hist_entry__iaddr(struct hist_entry *he=
)
> +static inline u64 hist_entry__iaddr(struct hist_entry *he)
>  {
>         if (he->mem_info)
>                 return mem_info__iaddr(he->mem_info)->addr;
> @@ -219,7 +219,7 @@ static u64 c2c_hist_entry__cycles(struct c2c_hist_ent=
ry *c2c_he)
>  }
>
>  /* Sum c2c_hist_entry__cycles() across all level-1 entries. */
> -static u64 __maybe_unused c2c_ext__total_cycles(void)
> +static u64 c2c_ext__total_cycles(void)
>  {
>         struct rb_node *nd;
>         u64 total =3D 0;
> @@ -359,7 +359,7 @@ cycles_percent_entry(struct perf_hpp_fmt *fmt, struct=
 perf_hpp *hpp,
>
>         c2c_he =3D container_of(he, struct c2c_hist_entry, he);
>         fn_cycles =3D c2c_hist_entry__cycles(c2c_he);
> -       /* Populated by build_function_view_hierarchy() once the L1 tree =
is built. */
> +       /* Populated by c2c_function__build() once the L1 tree is built. =
*/
>         total_cycles =3D c2c_ext.total_cycles;
>         pct =3D total_cycles > 0 ? (double)fn_cycles / total_cycles * 100=
.0 : 0.0;
>
> @@ -665,7 +665,7 @@ function_hpp_list__parse(struct perf_hpp_list *hpp_li=
st,
>         return ret;
>  }
>
> -static int __maybe_unused
> +static int
>  c2c_function_hists__init(struct c2c_hists *hists,
>                          const char *sort,
>                          int nr_header_lines,
> @@ -680,7 +680,7 @@ c2c_function_hists__init(struct c2c_hists *hists,
>         return function_hpp_list__parse(&hists->list, /*output=3D*/NULL, =
sort, env);
>  }
>
> -static int __maybe_unused
> +static int
>  c2c_function_hists__reinit(struct c2c_hists *c2c_hists,
>                            const char *output,
>                            const char *sort,
> @@ -730,8 +730,8 @@ static void c2c_stats_merge(struct stats *dest, const=
 struct stats *src)
>  }
>
>  /* Merge compute_stats during function aggregation. */
> -static void __maybe_unused c2c_add_cstats(struct compute_stats *dest,
> -                                         const struct compute_stats *src=
)
> +static void c2c_add_cstats(struct compute_stats *dest,
> +                          const struct compute_stats *src)
>  {
>         c2c_stats_merge(&dest->rmt_hitm, &src->rmt_hitm);
>         c2c_stats_merge(&dest->lcl_hitm, &src->lcl_hitm);
> @@ -740,8 +740,8 @@ static void __maybe_unused c2c_add_cstats(struct comp=
ute_stats *dest,
>         c2c_stats_merge(&dest->load, &src->load);
>  }
>
> -static bool __maybe_unused hist_entry__add_c2c_stats(struct hist_entry *=
he,
> -                                                    const struct c2c_sta=
ts *stats)
> +static bool hist_entry__add_c2c_stats(struct hist_entry *he,
> +                                     const struct c2c_stats *stats)
>  {
>         u64 nr_events =3D c2c_hitm_count(stats) + stats->rmt_peer + stats=
->lcl_peer;
>         u64 weight1 =3D c2c_hitm_count(stats);
> @@ -832,7 +832,7 @@ static void c2c_he__free_hierarchy(struct hist_entry =
*he)
>   * line, so this is mainly a safety net. Returns the number of surviving
>   * writers.
>   */
> -static int __maybe_unused c2c_he__prune_empty_writers(struct hist_entry =
*l1_he)
> +static int c2c_he__prune_empty_writers(struct hist_entry *l1_he)
>  {
>         struct rb_node *nd;
>         int surviving =3D 0;
> @@ -953,7 +953,7 @@ c2c_child_entry__insert(struct hist_entry *parent_he,=
 struct hist_entry *child_h
>         parent_he->leaf =3D false;
>  }
>
> -static __maybe_unused struct hist_entry *
> +static struct hist_entry *
>  c2c_function_hists__level1_entry(struct symbol *sym,
>                                  struct hist_entry *detail_he,
>                                  struct thread *synthetic_thread)
> @@ -1029,7 +1029,7 @@ c2c_function_hists__level1_entry(struct symbol *sym=
,
>   * sort semantics. All code addresses and cachelines for the same writer
>   * function aggregate into one row.
>   */
> -static __maybe_unused struct c2c_hist_entry *
> +static struct c2c_hist_entry *
>  c2c_function_hists__level2_entry(struct c2c_hist_entry *level1_c2c,
>                                  struct symbol *sym, struct hist_entry *d=
etail_he)
>  {
> @@ -1077,7 +1077,7 @@ c2c_function_hists__level2_entry(struct c2c_hist_en=
try *level1_c2c,
>  }
>
>  /* Level 3: one source cacheline where the L1/L2 functions contend. */
> -static __maybe_unused struct c2c_hist_entry *
> +static struct c2c_hist_entry *
>  c2c_function_hists__level3_entry(struct c2c_hist_entry *level2_c2c,
>                                  struct c2c_hist_entry *cacheline_src_he)
>  {
> @@ -1140,3 +1140,503 @@ struct hist_entry *c2c_function__find_cacheline(s=
truct hist_entry *he_selection)
>
>         return NULL;
>  }
> +
> +/*
> + * Re-sort child entries of @parent_he by total store count, descending.
> + */
> +static void c2c_he__resort_by_stores(struct hist_entry *parent_he)
> +{
> +       struct rb_root_cached new_root =3D RB_ROOT_CACHED;
> +       struct rb_node *nd;
> +
> +       if (!parent_he->has_children)
> +               return;
> +
> +       /* Extract all nodes and re-insert sorted by displayed store coun=
t */
> +       while ((nd =3D rb_first_cached(&parent_he->hroot_out))) {
> +               struct hist_entry *he =3D rb_entry(nd, struct hist_entry,=
 rb_node);
> +               u64 he_store =3D hist_entry__displayed_stores(he);
> +               struct rb_node **p =3D &new_root.rb_root.rb_node;
> +               struct rb_node *parent =3D NULL;
> +               bool leftmost =3D true;
> +               int cmp;
> +
> +               /* Remove from current tree */
> +               rb_erase_cached(&he->rb_node, &parent_he->hroot_out);
> +
> +               /*
> +                * Insert sorted by store count, descending. Use the disp=
layed
> +                * store count so a level-1 function and level-2 writer (=
whose own
> +                * stats.store is 0 / partial) sort by the aggregated wri=
te traffic
> +                * beneath them, not by their own store field.
> +                */
> +               while (*p) {
> +                       struct hist_entry *iter =3D rb_entry(*p, struct h=
ist_entry, rb_node);
> +                       u64 iter_store =3D hist_entry__displayed_stores(i=
ter);
> +
> +                       parent =3D *p;
> +                       if (he_store !=3D iter_store) {
> +                               cmp =3D he_store > iter_store ? -1 : 1;
> +                       } else {
> +                               /* Stable tie-break: instruction address,=
 name, then cacheline. */
> +                               u64 a =3D hist_entry__iaddr(he), b =3D hi=
st_entry__iaddr(iter);
> +
> +                               if (a !=3D b)
> +                                       cmp =3D a < b ? -1 : 1;
> +                               else if (he->ms.sym && iter->ms.sym)
> +                                       cmp =3D strcmp(he->ms.sym->name,
> +                                                    iter->ms.sym->name);
> +                               else
> +                                       cmp =3D (iter->ms.sym ? 1 : 0) - =
(he->ms.sym ? 1 : 0);
> +
> +                               if (!cmp) {
> +                                       struct c2c_hist_entry *he_c2c;
> +                                       struct c2c_hist_entry *iter_c2c;
> +
> +                                       he_c2c =3D container_of(he, struc=
t c2c_hist_entry, he);
> +                                       iter_c2c =3D container_of(iter, s=
truct c2c_hist_entry, he);
> +                                       if (he_c2c->cacheline_idx !=3D it=
er_c2c->cacheline_idx)
> +                                               cmp =3D he_c2c->cacheline=
_idx <
> +                                                     iter_c2c->cacheline=
_idx ? -1 : 1;
> +                               }
> +                       }
> +
> +                       if (cmp < 0) {
> +                               p =3D &parent->rb_left;
> +                       } else {
> +                               p =3D &parent->rb_right;
> +                               leftmost =3D false;
> +                       }
> +               }
> +
> +               rb_link_node(&he->rb_node, parent, p);
> +               rb_insert_color_cached(&he->rb_node, &new_root, leftmost)=
;
> +       }
> +
> +       parent_he->hroot_out =3D new_root;
> +}
> +
> +/* Initial per-cacheline capacity for the seen[] set; grown on demand. *=
/
> +#define DEFAULT_SYMBOLS_PER_CL 64
> +
> +struct function_seen {
> +       struct map_symbol ms;
> +};
> +
> +static bool function_seen__find(const struct function_seen *seen, int nr=
,
> +                               const struct map_symbol *ms)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < nr; i++) {
> +               if (!c2c_function_cmp(&seen[i].ms, ms))
> +                       return true;
> +       }
> +       return false;
> +}
> +
> +/* Aggregate stats from the cacheline-side entry @c2c_b into level 2/3 @=
dst. */
> +static bool c2c_he__add_sharing(struct c2c_hist_entry *dst, struct c2c_h=
ist_entry *src)
> +{
> +       /* Do the fallible update first so a failure leaves dst unmodifie=
d. */
> +       if (!hist_entry__add_c2c_stats(&dst->he, &src->stats))
> +               return false;
> +
> +       c2c_add_stats(&dst->stats, &src->stats);
> +       c2c_add_cstats(&dst->cstats, &src->cstats);
> +       return true;
> +}
> +
> +/*
> + * Process one cacheline: for every function reading it, create/update i=
ts
> + * level-1 function entry, then for each function that writes the line
> + * add it as a level-2 writer and add this cacheline as a level-3 child.
> + */
> +static int c2c_function__process_cl(struct c2c_hist_entry *cacheline_he,
> +                                   struct thread *synthetic_thread)
> +{
> +       struct rb_node *nd_a, *nd_b;
> +       struct function_seen *seen =3D NULL;
> +       int nr_seen =3D 0, nr_alloc =3D 0;
> +       int ret =3D 0;
> +
> +       for (nd_a =3D rb_first_cached(&cacheline_he->hists->hists.entries=
); nd_a;
> +            nd_a =3D rb_next(nd_a)) {
> +               struct hist_entry *he_a =3D rb_entry(nd_a, struct hist_en=
try, rb_node);
> +               struct c2c_hist_entry *c2c_a;
> +               struct hist_entry *level1_he;
> +               struct c2c_hist_entry *level1_c2c;
> +
> +               if (!he_a->ms.sym || he_a->filtered)
> +                       continue;
> +
> +               c2c_a =3D container_of(he_a, struct c2c_hist_entry, he);
> +               if (c2c_a->stats.load =3D=3D 0)
> +                       continue;
> +
> +               level1_he =3D c2c_function_hists__level1_entry(he_a->ms.s=
ym,
> +                                                            he_a, synthe=
tic_thread);
> +               if (!level1_he) {
> +                       ret =3D -ENOMEM;
> +                       goto out;
> +               }
> +
> +               level1_c2c =3D container_of(level1_he, struct c2c_hist_en=
try, he);
> +
> +               /*
> +                * Aggregate every source entry into its level-1 function=
 parent.
> +                * level1_he is keyed by symbol, so all code addresses in=
side the
> +                * same function collapse into one parent. When the cache=
line view
> +                * splits a function into siblings (different code addres=
ses, or
> +                * --coalesce pid/tid/dso), each sibling holds a DISJOINT=
 slice of the
> +                * traffic, so summing them here is correct accumulation,=
 not
> +                * double counting. The seen[] set below therefore guards=
 only the
> +                * subtree build (to avoid building a function's level-2/=
3 subtree
> +                * twice for the same cacheline), never this L1 update. U=
pdate
> +                * he->stat first; on failure leave the aggregates untouc=
hed.
> +                */
> +               if (!hist_entry__add_c2c_stats(level1_he, &c2c_a->stats))=
 {
> +                       ret =3D -ENOMEM;
> +                       goto out;
> +               }
> +               c2c_add_stats(&level1_c2c->stats, &c2c_a->stats);
> +               c2c_add_cstats(&level1_c2c->cstats, &c2c_a->cstats);
> +               c2c_add_stats(&c2c_ext.function_hists.stats, &c2c_a->stat=
s);
> +
> +               /* Build this function's subtree for this cacheline only =
once. */
> +               if (function_seen__find(seen, nr_seen, &he_a->ms))
> +                       continue;
> +
> +               if (nr_seen =3D=3D nr_alloc) {
> +                       struct function_seen *tmp;
> +                       int new_alloc =3D nr_alloc ? nr_alloc * 2 : DEFAU=
LT_SYMBOLS_PER_CL;
> +
> +                       tmp =3D reallocarray(seen, new_alloc, sizeof(*see=
n));
> +                       if (!tmp) {
> +                               ret =3D -ENOMEM;
> +                               goto out;
> +                       }
> +                       seen =3D tmp;
> +                       nr_alloc =3D new_alloc;
> +               }
> +               seen[nr_seen].ms =3D he_a->ms;
> +               nr_seen++;
> +
> +               for (nd_b =3D rb_first_cached(&cacheline_he->hists->hists=
.entries); nd_b;
> +                    nd_b =3D rb_next(nd_b)) {
> +                       struct hist_entry *he_b =3D rb_entry(nd_b, struct=
 hist_entry, rb_node);
> +                       struct c2c_hist_entry *c2c_b, *level2_c2c, *level=
3_c2c;
> +
> +                       if (!he_b->ms.sym || he_b->filtered)
> +                               continue;
> +
> +                       c2c_b =3D container_of(he_b, struct c2c_hist_entr=
y, he);
> +
> +                       /*
> +                        * The level-1 function contributes read-side loa=
d weight for this
> +                        * cacheline. Associate it with functions sampled=
 storing to the
> +                        * same line.
> +                        * The writer can be the same function; after det=
ail coalescing and
> +                        * function-level grouping there is not enough id=
entity to attribute
> +                        * that case to a specific thread.
> +                        * Only writers are contending functions, so keep=
 the ones
> +                        * that actually store into the line.
> +                        */
> +                       if (c2c_b->stats.store =3D=3D 0)
> +                               continue;
> +
> +                       /* Level 2: the writing function (aggregated acro=
ss cachelines). */
> +                       level2_c2c =3D c2c_function_hists__level2_entry(l=
evel1_c2c, he_b->ms.sym,
> +                                                                     he_=
b);
> +                       if (!level2_c2c || !c2c_he__add_sharing(level2_c2=
c, c2c_b)) {
> +                               ret =3D -ENOMEM;
> +                               goto out;
> +                       }
> +
> +                       /* Level 3: the specific cacheline they contend o=
ver. */
> +                       level3_c2c =3D c2c_function_hists__level3_entry(l=
evel2_c2c,
> +                                                                     cac=
heline_he);
> +                       if (!level3_c2c || !c2c_he__add_sharing(level3_c2=
c, c2c_b)) {
> +                               ret =3D -ENOMEM;
> +                               goto out;
> +                       }
> +               }
> +       }
> +
> +out:
> +       free(seen);
> +       return ret;
> +}
> +
> +/*
> + * Remove a level-1 function that has no contended cachelines left. It i=
s a
> + * normal (owned) hist_entry in function_hists, so mirror hists__delete_=
entry()
> + * for the no-collapse case: unlink from both trees, fix the counters, t=
hen
> + * delete. Its hroot_out is already empty after pruning.
> + */
> +static void c2c_function__drop_level1(struct hist_entry *he)
> +{
> +       struct hists *hists =3D &c2c_ext.function_hists.hists;
> +
> +       rb_erase_cached(&he->rb_node_in, hists->entries_in);
> +       rb_erase_cached(&he->rb_node, &hists->entries);
> +
> +       --hists->nr_entries;
> +       if (!he->filtered)
> +               --hists->nr_non_filtered_entries;
> +
> +       hist_entry__delete(he);
> +}
> +
> +/* Length of the identity text (symbol name or cacheline address) at @he=
. */
> +static int c2c_function__ident_len(struct hist_entry *he)
> +{
> +       char buf[512];
> +       char *symbuf;
> +       size_t size;
> +       int len;
> +
> +       if (hist_entry__is_cacheline(he)) {
> +               u64 addr =3D he->mem_info ?
> +                       cl_address(mem_info__daddr(he->mem_info)->addr, c=
hk_double_cl) : 0;
> +
> +               return scnprintf(buf, sizeof(buf), "0x%" PRIx64, addr);
> +       }
> +
> +       if (!he->ms.sym)
> +               return 0;
> +
> +       /*
> +        * Match symbol_view_entry(): sort_sym adds the cpumode prefix an=
d, in
> +        * verbose mode, the address and DSO origin before the symbol nam=
e.
> +        */
> +       size =3D strlen(he->ms.sym->name) + 64;
> +       symbuf =3D malloc(size);
> +       if (!symbuf)
> +               return size - 1;
> +
> +       len =3D sort_sym.se_snprintf(he, symbuf, size, size - 1);
> +       free(symbuf);
> +       return len;
> +}
> +
> +/*
> + * Grow the symbol column so the deepest, longest identity cell fits. Th=
e
> + * generic hists__calc_col_len() only measures the top-level (L1) entrie=
s; the
> + * hand-linked L2 writers and L3 cacheline addresses live in hroot_out a=
nd are
> + * never measured, so with a short L1 name the indented L2/L3 text would=
 be
> + * truncated. Account for the per-level indent and the folded-sign prefi=
x.
> + */
> +static void c2c_function__update_symbol_width(struct hist_entry *he)
> +{
> +       struct hists *hists =3D &c2c_ext.function_hists.hists;
> +       int need =3D he->depth * C2C_FUNC_INDENT + C2C_FUNC_FOLD_WIDTH +
> +                  c2c_function__ident_len(he);
> +
> +       if (need > hists__col_len(hists, HISTC_SYMBOL))
> +               hists__set_col_len(hists, HISTC_SYMBOL, need);
> +}
> +
> +/*
> + * Prune writers with no stores, drop functions left with no contending
> + * writer, sort the survivors by store count, then compute the global to=
tal.
> + */
> +static void c2c_function__finalize(void)
> +{
> +       struct rb_node *nd_l1;
> +
> +       nd_l1 =3D rb_first_cached(&c2c_ext.function_hists.hists.entries);
> +       while (nd_l1) {
> +               struct hist_entry *he_l1 =3D rb_entry(nd_l1, struct hist_=
entry, rb_node);
> +               struct rb_node *next_l1 =3D rb_next(nd_l1);
> +               struct rb_node *nd_l2;
> +
> +               /* Drop writers with no stores before sorting. */
> +               if (!he_l1->has_children || !c2c_he__prune_empty_writers(=
he_l1)) {
> +                       /* No contending writer: this function is not sha=
red. */
> +                       c2c_function__drop_level1(he_l1);
> +                       nd_l1 =3D next_l1;
> +                       continue;
> +               }
> +
> +               c2c_he__resort_by_stores(he_l1);
> +               c2c_function__update_symbol_width(he_l1);
> +
> +               for (nd_l2 =3D rb_first_cached(&he_l1->hroot_out); nd_l2;
> +                    nd_l2 =3D rb_next(nd_l2)) {
> +                       struct hist_entry *he_l2 =3D rb_entry(nd_l2, stru=
ct hist_entry, rb_node);
> +                       struct rb_node *nd_l3;
> +
> +                       c2c_function__update_symbol_width(he_l2);
> +
> +                       if (he_l2->has_children)
> +                               c2c_he__resort_by_stores(he_l2);
> +
> +                       for (nd_l3 =3D rb_first_cached(&he_l2->hroot_out)=
; nd_l3;
> +                            nd_l3 =3D rb_next(nd_l3)) {
> +                               struct hist_entry *he_l3 =3D rb_entry(nd_=
l3, struct hist_entry,
> +                                                                   rb_no=
de);
> +
> +                               c2c_function__update_symbol_width(he_l3);
> +                       }
> +               }
> +
> +               nd_l1 =3D next_l1;
> +       }
> +
> +       /*
> +        * Compute the Cycles % denominator from the surviving level-1 en=
tries
> +        * after pruning, so the column shows each function's share of th=
e
> +        * functions retained in this table -- not of the whole recording=
. See
> +        * the Cycles % description in perf-c2c.txt.
> +        */
> +       c2c_ext.total_cycles =3D c2c_ext__total_cycles();
> +}
> +
> +/*
> + * Release all per-visit function-view state. Keep the hists object itse=
lf
> + * initialized so its mutex is initialized exactly once across TAB re-en=
try.
> + */
> +void c2c_function__reset(void)
> +{
> +       bool saved_use_callchain =3D symbol_conf.use_callchain;
> +
> +       /*
> +        * Function-view entries never carry callchains. Keep their gener=
ic
> +        * destructor independent of the caller's current callchain setti=
ng.
> +        */
> +       symbol_conf.use_callchain =3D false;
> +       hists__delete_all_entries(&c2c_ext.function_hists.hists);
> +       if (c2c_ext.function_hists.list.fields.next)
> +               perf_hpp__reset_output_field(&c2c_ext.function_hists.list=
);
> +
> +       memset(&c2c_ext.function_hists.stats, 0,
> +              sizeof(c2c_ext.function_hists.stats));
> +       c2c_ext.total_cycles =3D 0;
> +       c2c_ext.cl_hists =3D NULL;
> +       c2c_ext.cl_sort =3D NULL;
> +       c2c_ext.symbol_full =3D false;
> +       symbol_conf.use_callchain =3D saved_use_callchain;
> +}
> +
> +static bool c2c_function__has_iaddr(const char *cl_sort)
> +{
> +       const char *field =3D cl_sort;
> +
> +       while (field && *field) {
> +               const char *end =3D strchr(field, ',');
> +               size_t len =3D end ? (size_t)(end - field) : strlen(field=
);
> +
> +               if (len =3D=3D sizeof("iaddr") - 1 && !strncmp(field, "ia=
ddr", len))
> +                       return true;
> +               field =3D end ? end + 1 : NULL;
> +       }
> +       return false;
> +}
> +
> +/*
> + * Build the three-level function view in a single pass over the cacheli=
ne
> + * entries:
> + *   L1: read-side functions (aggregated across all their code addresses=
)
> + *   L2: writing functions contending with each level-1 function
> + *   L3: shared cachelines for each function pair
> + */
> +int c2c_function__build(struct c2c_hists *cl_hists, const char *cl_sort,
> +                       bool symbol_full, struct hists **hists)
> +{
> +       static const char output_fields[] =3D
> +               "cycles_percent,total_stores,symbol_view";
> +       static bool hists_initialized;
> +       struct rb_node *nd_cl;
> +       bool saved_use_callchain;
> +       int ret;
> +
> +       if (!hists)
> +               return -EINVAL;
> +       *hists =3D NULL;
> +
> +       if (!cl_hists || !cl_sort)
> +               return -EINVAL;
> +       if (!c2c_function__has_iaddr(cl_sort))
> +               return -EOPNOTSUPP;
> +
> +       saved_use_callchain =3D symbol_conf.use_callchain;
> +       symbol_conf.use_callchain =3D false;
> +       c2c_function__reset();
> +
> +       c2c_ext.cl_hists =3D cl_hists;
> +       c2c_ext.cl_sort =3D cl_sort;
> +       c2c_ext.symbol_full =3D symbol_full;
> +
> +       /*
> +        * __hists__init() (called by c2c_function_hists__init()) also
> +        * mutex_init()s the hists lock, so only run it once for this sta=
tic
> +        * hists; on re-entry just re-parse the columns via reinit().
> +        */
> +       if (!hists_initialized) {
> +               ret =3D c2c_function_hists__init(&c2c_ext.function_hists,
> +                                              "symbol_view", 2, NULL);
> +               hists_initialized =3D true;
> +       } else {
> +               ret =3D c2c_function_hists__reinit(&c2c_ext.function_hist=
s,
> +                                                /*output=3D*/NULL, "symb=
ol_view", NULL);
> +       }
> +       if (ret)
> +               goto out_reset;
> +
> +       nd_cl =3D rb_first_cached(&c2c_ext.cl_hists->hists.entries);
> +
> +       /* An empty C2C report yields an empty (but valid) function view.=
 */
> +       for (; nd_cl; nd_cl =3D rb_next(nd_cl)) {
> +               struct hist_entry *he_cl =3D rb_entry(nd_cl, struct hist_=
entry, rb_node);
> +               struct c2c_hist_entry *cacheline_he =3D container_of(he_c=
l,
> +                                                                  struct=
 c2c_hist_entry, he);
> +               struct thread *synthetic_thread =3D he_cl->thread;
> +
> +               /*
> +                * Detail hists are finalized only for cachelines retaine=
d by the
> +                * top-level C2C filter. Among those, include any line wi=
th sharing
> +                * activity, not just HITM.
> +                */
> +               if (he_cl->filtered ||
> +                   (c2c_hitm_count(&cacheline_he->stats) =3D=3D 0 &&
> +                    cacheline_he->stats.tot_peer =3D=3D 0 &&
> +                    cacheline_he->stats.store =3D=3D 0 &&
> +                    cacheline_he->stats.load =3D=3D 0) ||
> +                   !cacheline_he->hists ||
> +                   RB_EMPTY_ROOT(&cacheline_he->hists->hists.entries.rb_=
root) ||
> +                   !he_cl->mem_info || !synthetic_thread)
> +                       continue;
> +
> +               ret =3D c2c_function__process_cl(cacheline_he, synthetic_=
thread);
> +               if (ret)
> +                       goto out_err;
> +       }
> +
> +       ret =3D c2c_function_hists__reinit(&c2c_ext.function_hists, outpu=
t_fields,
> +                                        "cycles_percent", NULL);
> +       if (ret)
> +               goto out_err;
> +
> +       hists__collapse_resort(&c2c_ext.function_hists.hists, NULL);
> +       hists__output_resort(&c2c_ext.function_hists.hists, NULL);
> +
> +       c2c_function__finalize();
> +
> +       *hists =3D &c2c_ext.function_hists.hists;
> +       symbol_conf.use_callchain =3D saved_use_callchain;
> +       return 0;
> +
> +out_err:
> +       /*
> +        * On error, migrate any entries still in entries_in to entries a=
nd
> +        * delete them, so a later rebuild does not strand them (the top-=
level
> +        * __hists__init() memset would otherwise lose the pointers).
> +        */
> +       hists__collapse_resort(&c2c_ext.function_hists.hists, NULL);
> +       hists__output_resort(&c2c_ext.function_hists.hists, NULL);
> +out_reset:
> +       c2c_function__reset();
> +       symbol_conf.use_callchain =3D saved_use_callchain;
> +       return ret;
> +}
> diff --git a/tools/perf/util/c2c.h b/tools/perf/util/c2c.h
> index f95e636edc0f..6548b9ba81f1 100644
> --- a/tools/perf/util/c2c.h
> +++ b/tools/perf/util/c2c.h
> @@ -98,6 +98,16 @@ struct c2c_fmt {
>  void c2c_fmt_free(struct perf_hpp_fmt *fmt);
>  bool c2c_fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
>
> +/*
> + * Build the function-view hierarchy. Returns -EOPNOTSUPP when @cl_sort =
lacks
> + * iaddr. On success, *@hists remains valid until the next
> + * c2c_function__build() or c2c_function__reset(). On failure, *@hists i=
s
> + * NULL.
> + */
> +int c2c_function__build(struct c2c_hists *cl_hists, const char *cl_sort,
> +                       bool symbol_full, struct hists **hists);
> +void c2c_function__reset(void);
> +/* Valid only between a successful build and c2c_function__reset(). */
>  struct hist_entry *c2c_function__find_cacheline(struct hist_entry *he);
>
>  #endif /* __PERF_UTIL_C2C_H */
> --
> 2.52.0
>
