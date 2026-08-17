Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290803C1D79
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000332; cv=pass; b=HnPaYprsxqZvir/tGIDEJ592oYMP7Ya2ZuXFWim8qoiE8lvb8WSqruEKr9rBWTCmbVgcGJehaX4pCJZ7XjLF1ahWQvB4Lwv27KHVca1+/g5mURq8mUHxtVv5hhuCBIOZtCgGDfhoQFyNgBupRr8mN8HFBqjMkqKZt5fYpvF7wWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000332; c=relaxed/simple;
	bh=L2Z/fH4WgsqACdOtAAR3T1hVHaetIe/zZiBIFez3ayE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/hpl0RCJzMJvBHIdxnXasgkjoMdr3zA4ngt84yLEZfNH9gVv+Sd1E2UoMHiMGCynDWZUbQYahIaLrsL41F/MbbMldXXIbDc3TZVAz+85Riw+vsLp+bBIRpAlwY5gCNI+cw+NXiBUWcj1ZCbaElsWR3+GinK9ue00+Wx7I2fIhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z8NWFCI0; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z8NWFCI0"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c10ed63c0so22721cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 13:58:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787000329; cv=none;
        d=google.com; s=arc-20260327;
        b=DZuVXSQ3u2u0ZPy+aBpc8SxvrDEOePjvpJcqdM/1s8m1PLZBvWzMoP6PtX8lyNrCxx
         XeRbU38X+Tudd8SYTR1rLV81IiQdkZRz7MaaT77nESkY8SweTSifQWwa8YjyUHgewF5B
         yUChaTxYcNCHb5C9HB3fBkDL3fJIGAVu/nzGLz0p4slwEcnAbSpTgRfAV4bPPEvXMqEM
         DyZ6egDjW7j3R+vWwYORsLCB3k3DShDBCBjtt7n8CCiUBDP7xnDc8J4RXEoJ6VRzVKfO
         Ojxf1pwdumc9XjIWR8y4VtuoJHbM1+6C/KZDQxAVLC2CZWov5ypllFr+VIU1EpyNuDg6
         FFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zqh8KABVB1Wzl8EEFH4DyBwWJb1uFIsNtrxl4RBbXqk=;
        fh=WgHLqDsRyxZ43bo+bE0PovZ34DWHO4dcy/bvlD/ET74=;
        b=NuHsZz24384ZYDg8b1ivOQxUqDs6vUBImbmEjuRY4UQxKJDEsI3pbjUWdt3RRXKcgM
         McG4T88Dbvgtc6+Z4Z1zCyCSB3TqlT2aXxjCROX8/RxXx9yd6cDy+fqwDZcvo/AWYBw8
         64qEEyGTcztOzvKx8hfkgbP96dE7bhAEjg26z5FLd0Cr/g/cYnPgZU9TgQYKb0QIjriI
         U+7Y4L1Uq70kIDKJZpzg5HPtJSzGGelyoN2lSx+/XRvJ03A5ZwkFqbkbwQyi7CVHL08j
         Vg8c+eGp2Ucm9Z4KeekbXyjvySAqVScJPKPEayeDOlzs1TnrCuruhkRFDHPf9XHcQtaf
         Sp3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787000329; x=1787605129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zqh8KABVB1Wzl8EEFH4DyBwWJb1uFIsNtrxl4RBbXqk=;
        b=Z8NWFCI0YPEhJxyOkEc8stdRv69ORDt0xtYh9lyJ+02wxcvZPKcZEtWP3W+HlwfBT+
         4Sgw5T6GD+iYUm/pH2NJg9mCBEvkalu65YBglPPDw4ThaYSS3AXKcRQVjDkYwDOJDf5t
         KF85p2KBNSMwY4HcLqiJcIDEixqIhfheJdG6v6sE2T9hK5AUO2rsbfjc7mLJ/6mycFdn
         e5zgLW8l4j4/TdRtUcg/rSazO5+WpRVmfnain1NwNBSjit9WkgGY5PAFGRrSa/Wah54k
         FzO2dIp07cgj5mpg5+7Hhfn/zVFPP+02FJ8Bq1Dwv/nFtCZXDyrfJRWma39jGvHELfF0
         gpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787000329; x=1787605129;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqh8KABVB1Wzl8EEFH4DyBwWJb1uFIsNtrxl4RBbXqk=;
        b=C2MlUEciiBBMSGJMM8raAk5LOeHiPTvdxNItAH8RX4yRWWytw2mskDUnsXA7aecgoO
         cx+mqOPWkJw6M95zX8hOVRWU4Z1z3Efst2NmpwO4oYm5AY+LdfghWS1Knm8404/ZpSNw
         VkkqdzLyXLFgJQ0xBKAwkeEmL0R8KrKnIytoUTCx/vqiI0iDl5sc1CLnynze6CzlPfHB
         DiZviFkVAAOC4RiL+2J/UufdY2cO+90MjCXFZ8VqIsfwLRigWkYE5gkeue87eQ6NmBla
         RMPGLfQhNL6rvThyVxNzxzQ3SeMT7ca4FrnwcN9T7njjlZokflay1ZkPRRx+6MvHcty7
         phkw==
X-Forwarded-Encrypted: i=1; AHgh+Rqejz8+yi9Fq9L42EfpP12yQEIb11L08Ap19fB7SsLk74k4AJ42JYWi6IjAPH7Ngdj+CAqIxW5JXM7VV/S6I1//@vger.kernel.org
X-Gm-Message-State: AOJu0YzzAOx8oVluBEoqku5K8C74SAS3CcpelA2mwiW0X0uEagkaC8j6
	NmwAEiCOh7hEze6F36WYIbW/SGBBzZO2dADeMghqlbwF+1c37j1V7VbuZ7m0XitPirvRFgGrvMK
	j5hxmka1sxhw0sax1XntxZSyFcm+JRPnSLz8wzFzBW5GVpd0S/e0ePC7r
X-Gm-Gg: AR+sD13rh+vV28wy+PnfMS9BEeOmTLjFvHrAPyJLkBH1nIJ2hS/wnwyvuAWbYs0XGMc
	DY8EVHmNw5IP3vGkJ/FHNn32g2JfG/BnxAgI1168HNGrLLHEcS4F5RXG9GB1Smyzm9O5Bzb+mHu
	LsLEl1/S1v5J1Uih3Ax51i39m8kEP6PkM34xXL/3URQNOupPzD4HKRefMy0u1lPm1ImFL1RV2MZ
	PsMeUtqCk9ZSDbd56EvS6evX8QyraTJw4/O0CUnfBWZLZqLfy5mawSjPIqSBwXH6M4n2XnKwcjY
	QgLqdcE46z45AOb/MWGDg3cWH8MyWvem2heKmJ1V4OSTWgWsry+VvZGAsLMTyyVtDM0Bwq1dq40
	=
X-Received: by 2002:a05:622a:1ccc:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-52dc09dbb5amr5229181cf.10.1787000328315; Mon, 17 Aug 2026
 13:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817094623.3288456-1-jiebin.sun@intel.com> <20260817094623.3288456-4-jiebin.sun@intel.com>
In-Reply-To: <20260817094623.3288456-4-jiebin.sun@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 13:58:36 -0700
X-Gm-Features: AcwNN1WxdTLWW3EjPbT3ILW6ICkMw68hiT8H1FtPyHEaJro-PJd39EyHRzU9BLM
Message-ID: <CAP-5=fUPqnTVDJACAhkj1JWEE=YNcDoPfKe0sq=YX__MnBpf5g@mail.gmail.com>
Subject: Re: [PATCH v9 3/9] perf c2c: add column rendering for function view
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
> Add renderers for the function view's Cycles %, Store count, and
> hierarchy identity columns. The identity column renders the read-side
> function, contending writer, or cacheline, with indentation for the
> hierarchy level. Also add width and header helpers, estimated-cycle
> calculation, comparators, and the dimension table that ties them together=
.
>
> Clamp the identity renderer's returned length to its local buffer before
> using it for pointer and padding calculations. This handles snprintf-styl=
e
> would-have-been lengths without changing normal output.
>
> The next patch connects these dimensions to the view's HPP lists, so the
> symbols used only there are temporarily marked __maybe_unused.
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

> ---
>  tools/perf/util/c2c-function.c | 353 +++++++++++++++++++++++++++++++++
>  1 file changed, 353 insertions(+)
>
> diff --git a/tools/perf/util/c2c-function.c b/tools/perf/util/c2c-functio=
n.c
> index ca82425a28dc..7fce415c0f07 100644
> --- a/tools/perf/util/c2c-function.c
> +++ b/tools/perf/util/c2c-function.c
> @@ -64,3 +64,356 @@ static inline __maybe_unused u64 hist_entry__iaddr(st=
ruct hist_entry *he)
>                 return mem_info__iaddr(he->mem_info)->addr;
>         return he->ip;
>  }
> +
> +/*
> + * Hierarchy levels (by depth): L1 =3D read-side function, L2 =3D the wr=
iting
> + * function it contends with, L3 =3D the specific shared cacheline.
> + */
> +static inline bool hist_entry__is_cacheline(struct hist_entry *he)

nit: I think the inline here is to make things compile/link in the
partial state. In general it shouldn't be necessary to have "inline"
in a .c file.

Thanks,
Ian

> +{
> +       return he->parent_he && he->parent_he->parent_he;       /* level =
3: cacheline */
> +}
> +
> +/* Spaces of indent per hierarchy level, like the normal report view. */
> +#define C2C_FUNC_INDENT 2
> +
> +/* Width of the folded-sign prefix ("%c ") each identity cell emits. */
> +#define C2C_FUNC_FOLD_WIDTH 2
> +
> +/*
> + * Write he->depth levels of leading indentation into @buf, so lower-lev=
el
> + * entries are visually nested under their parent. Returns bytes written=
.
> + */
> +static int hist_entry__indent(struct hist_entry *he, char *buf, size_t s=
ize)
> +{
> +       int indent =3D he->depth * C2C_FUNC_INDENT;
> +
> +       if (indent <=3D 0 || (size_t)indent >=3D size)
> +               return 0;
> +
> +       return scnprintf(buf, size, "%*s", indent, "");
> +}
> +
> +static int symbol_width(struct hists *hists, struct sort_entry *se)
> +{
> +       int width =3D hists__col_len(hists, se->se_width_idx);
> +
> +       /*
> +        * Cap long symbol names as the cacheline view does. The stored c=
olumn
> +        * length is grown up front to fit the deepest, longest identity =
cell
> +        * (including a level-3 cacheline address), so this cap never shr=
inks the
> +        * column below what the cacheline address needs.
> +        */
> +       if (!c2c_ext.symbol_full && width > SYMBOL_WIDTH)
> +               width =3D SYMBOL_WIDTH;
> +
> +       return width;
> +}
> +
> +static struct c2c_dimension dim_symbol_view;
> +
> +/*
> + * c2c_width - Calculate width for a C2C column in function view
> + */
> +static int c2c_width(struct perf_hpp_fmt *fmt,
> +                    struct perf_hpp *hpp __maybe_unused,
> +                    struct hists *hists)
> +{
> +       struct c2c_fmt *c2c_fmt;
> +       struct c2c_dimension *dim;
> +
> +       c2c_fmt =3D container_of(fmt, struct c2c_fmt, fmt);
> +       dim =3D c2c_fmt->dim;
> +
> +       if (dim =3D=3D &dim_symbol_view)
> +               return symbol_width(hists, dim->se);
> +
> +       return dim->se ? hists__col_len(hists, dim->se->se_width_idx) :
> +                        dim->width;
> +}
> +
> +static int __maybe_unused c2c_header(struct perf_hpp_fmt *fmt, struct pe=
rf_hpp *hpp,
> +                                    struct hists *hists, int line, int *=
span)
> +{
> +       struct c2c_fmt *c2c_fmt;
> +       struct c2c_dimension *dim;
> +       const char *text =3D NULL;
> +       int width =3D c2c_width(fmt, hpp, hists);
> +
> +       c2c_fmt =3D container_of(fmt, struct c2c_fmt, fmt);
> +       dim =3D c2c_fmt->dim;
> +
> +       if (dim->se) {
> +               text =3D dim->header.line[line].text;
> +               /* Use the last line from sort_entry if not defined. */
> +               if (!text && line =3D=3D hists->hpp_list->nr_header_lines=
 - 1)
> +                       text =3D dim->se->se_header;
> +       } else {
> +               text =3D dim->header.line[line].text;
> +
> +               if (span) {
> +                       if (*span) {
> +                               (*span)--;
> +                               return 0;
> +                       }
> +
> +                       *span =3D dim->header.line[line].span;
> +               }
> +       }
> +
> +       if (!text)
> +               text =3D "";
> +
> +       return scnprintf(hpp->buf, hpp->size, "%*s", width, text);
> +}
> +
> +/*
> + * Return the estimated total cycles for a c2c_hist_entry
> + * (rmt_hitm + lcl_hitm + rmt_peer + lcl_peer + other loads).
> + */
> +static u64 c2c_hist_entry__cycles(struct c2c_hist_entry *c2c_he)
> +{
> +       struct compute_stats *cs =3D &c2c_he->cstats;
> +       double cycles =3D 0;
> +
> +       /*
> +        * compute_stats() in builtin-c2c.c routes each load sample into =
exactly
> +        * one cstats bucket (rmt_hitm, lcl_hitm, rmt_peer, lcl_peer or p=
lain
> +        * load), so each bucket's cycle total is its mean times its own =
sample
> +        * count. Summing the per-bucket totals avoids both dropping peer=
-snoop
> +        * cycles and double counting a sample that carries several data-=
source
> +        * flags (e.g. Arm SPE sets HITM and PEER on the same load), whic=
h would
> +        * happen if the mean were multiplied by the non-exclusive stats =
counts.
> +        */
> +       cycles +=3D avg_stats(&cs->rmt_hitm) * cs->rmt_hitm.n;
> +       cycles +=3D avg_stats(&cs->lcl_hitm) * cs->lcl_hitm.n;
> +       cycles +=3D avg_stats(&cs->rmt_peer) * cs->rmt_peer.n;
> +       cycles +=3D avg_stats(&cs->lcl_peer) * cs->lcl_peer.n;
> +       cycles +=3D avg_stats(&cs->load)     * cs->load.n;
> +
> +       return (u64)cycles;
> +}
> +
> +/* Sum c2c_hist_entry__cycles() across all level-1 entries. */
> +static u64 __maybe_unused c2c_ext__total_cycles(void)
> +{
> +       struct rb_node *nd;
> +       u64 total =3D 0;
> +
> +       for (nd =3D rb_first_cached(&c2c_ext.function_hists.hists.entries=
); nd;
> +            nd =3D rb_next(nd)) {
> +               struct c2c_hist_entry *c2c_he =3D
> +                       rb_entry(nd, struct c2c_hist_entry, he.rb_node);
> +
> +               total +=3D c2c_hist_entry__cycles(c2c_he);
> +       }
> +       return total;
> +}
> +
> +/*
> + * Store count shown in the column: a level-3 cacheline leaf shows its p=
arent
> + * level-2 writer's stores on that line, not all stores on the line. A l=
evel-2
> + * writer shows the sum across its level-3 cachelines. A level-1 reader =
shows
> + * the sum across all included writers on the cachelines it reads; this =
is not
> + * the reader function's own store count and is not additive across read=
ers.
> + */
> +static u64 hist_entry__displayed_stores(struct hist_entry *he)
> +{
> +       struct c2c_hist_entry *c2c_he =3D container_of(he, struct c2c_his=
t_entry, he);
> +       struct rb_node *nd;
> +       u64 stores =3D 0;
> +
> +       /* Level-2/3 entries already aggregate the stores they represent.=
 */
> +       if (he->parent_he)
> +               return c2c_he->stats.store;
> +
> +       for (nd =3D rb_first_cached(&he->hroot_out); nd; nd =3D rb_next(n=
d)) {
> +               struct c2c_hist_entry *child_c2c =3D
> +                       rb_entry(nd, struct c2c_hist_entry, he.rb_node);
> +               stores +=3D child_c2c->stats.store;
> +       }
> +       return stores;
> +}
> +
> +static int
> +total_stores_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +                  struct hist_entry *he)
> +{
> +       int width =3D c2c_width(fmt, hpp, he->hists);
> +       u64 total =3D hist_entry__displayed_stores(he);
> +
> +       return scnprintf(hpp->buf, hpp->size, "%*" PRIu64, width, total);
> +}
> +
> +/*
> + * symbol_view_entry - Render the unified, indented identity column.
> + *
> + * All three levels share this single column so the hierarchy reads top-=
down
> + * with progressive indentation, like the normal report hierarchy view. =
It is
> + * a function-centric view with no dedicated code-address column. Verbos=
e
> + * function rows can still include a representative address:
> + *   L1 read-side function: "- [k] cpupri_set"
> + *   L2 writing function:   "  - [k] pull_rt_task"
> + *   L3 shared cacheline:   "      0xff2d0082809da080"
> + */
> +static int
> +symbol_view_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +                 struct hist_entry *he)
> +{
> +       int width =3D c2c_width(fmt, hpp, he->hists);
> +       int text_width;
> +       int ret;
> +       char folded_sign;
> +
> +       ret =3D hist_entry__indent(he, hpp->buf, hpp->size);
> +
> +       folded_sign =3D he->has_children ? (he->unfolded ? '-' : '+') : '=
 ';
> +       ret +=3D scnprintf(hpp->buf + ret, hpp->size - ret, "%c ", folded=
_sign);
> +
> +       text_width =3D width - ret;
> +       if (text_width <=3D 0)
> +               return ret;
> +
> +       if (hist_entry__is_cacheline(he)) {
> +               /* Level 3: the shared cacheline address. */
> +               u64 addr =3D he->mem_info ?
> +                       cl_address(mem_info__daddr(he->mem_info)->addr, c=
hk_double_cl) : 0;
> +               char symbuf[32];
> +
> +               scnprintf(symbuf, sizeof(symbuf), "0x%" PRIx64, addr);
> +               ret +=3D scnprintf(hpp->buf + ret, hpp->size - ret, "%-*.=
*s",
> +                                text_width, text_width, symbuf);
> +       } else {
> +               /* Level 1 and level 2 are both functions. */
> +               size_t cell_size;
> +               int len;
> +
> +               if ((size_t)ret >=3D hpp->size)
> +                       return ret;
> +
> +               cell_size =3D min_t(size_t, hpp->size - ret,
> +                                 (size_t)text_width + 1);
> +               len =3D sort_sym.se_snprintf(he, hpp->buf + ret, cell_siz=
e,
> +                                          text_width);
> +               /*
> +                * se_snprintf() accumulates repsep_snprintf() calls, whi=
ch cap
> +                * their return at the remaining size - 1 rather than rep=
orting
> +                * what the format would have needed, so len stays below
> +                * cell_size. Clamp anyway so ret cannot leave hpp->buf.
> +                */
> +               if (len < 0)
> +                       len =3D 0;
> +               else
> +                       len =3D min_t(size_t, len, cell_size - 1);
> +
> +               ret +=3D len;
> +               if (len < text_width)
> +                       ret +=3D scnprintf(hpp->buf + ret, hpp->size - re=
t, "%*s",
> +                                        text_width - len, "");
> +       }
> +
> +       return ret;
> +}
> +
> +/*
> + * cycles_percent_entry - Render cycles percentage column
> + */
> +static int
> +cycles_percent_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +                    struct hist_entry *he)
> +{
> +       struct c2c_hist_entry *c2c_he;
> +       int width =3D c2c_width(fmt, hpp, he->hists);
> +       u64 fn_cycles, total_cycles;
> +       char folded_sign;
> +       double pct;
> +       int ret, pct_width;
> +
> +       /* Hide Cycles Percent for child functions and cachelines. */
> +       if (he->parent_he)
> +               return scnprintf(hpp->buf, hpp->size, "%*s", width, "");
> +
> +       c2c_he =3D container_of(he, struct c2c_hist_entry, he);
> +       fn_cycles =3D c2c_hist_entry__cycles(c2c_he);
> +       /* Populated by build_function_view_hierarchy() once the L1 tree =
is built. */
> +       total_cycles =3D c2c_ext.total_cycles;
> +       pct =3D total_cycles > 0 ? (double)fn_cycles / total_cycles * 100=
.0 : 0.0;
> +
> +       /* Add folded sign only for level-1 entries */
> +       folded_sign =3D he->has_children ? (he->unfolded ? '-' : '+') : '=
 ';
> +       ret =3D scnprintf(hpp->buf, hpp->size, "%c ", folded_sign);
> +
> +       pct_width =3D width - ret;
> +       if (pct_width <=3D 0)
> +               return ret;
> +       ret +=3D scnprintf(hpp->buf + ret, hpp->size - ret, "%*.2f%%", pc=
t_width - 1, pct);
> +       return ret;
> +}
> +
> +/*
> + * cycles_percent_cmp - Comparison function for cycles percentage sortin=
g
> + */
> +static int64_t
> +cycles_percent_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
> +                  struct hist_entry *left, struct hist_entry *right)
> +{
> +       struct c2c_hist_entry *c2c_left =3D container_of(left, struct c2c=
_hist_entry, he);
> +       struct c2c_hist_entry *c2c_right =3D container_of(right, struct c=
2c_hist_entry, he);
> +       u64 cycles_left, cycles_right;
> +
> +       /* Cycles Percent is only shown for level-1 entries; others compa=
re equal. */
> +       if (left->parent_he || right->parent_he)
> +               return 0;
> +
> +       cycles_left =3D c2c_hist_entry__cycles(c2c_left);
> +       cycles_right =3D c2c_hist_entry__cycles(c2c_right);
> +
> +       return (cycles_left > cycles_right) - (cycles_left < cycles_right=
);
> +}
> +
> +/*
> + * total_stores_cmp - Comparison function for total stores sorting
> + */
> +static int64_t
> +total_stores_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
> +                struct hist_entry *left, struct hist_entry *right)
> +{
> +       u64 left_store =3D hist_entry__displayed_stores(left);
> +       u64 right_store =3D hist_entry__displayed_stores(right);
> +
> +       return (left_store > right_store) - (left_store < right_store);
> +}
> +
> +/*
> + * Function view dimensions
> + */
> +static struct c2c_dimension dim_cycles_percent =3D {
> +       .header         =3D HEADER_BOTH("Cycles", "%"),
> +       .name           =3D "cycles_percent",
> +       .cmp            =3D cycles_percent_cmp,
> +       .entry          =3D cycles_percent_entry,
> +       .width          =3D 9,
> +};
> +
> +static struct c2c_dimension dim_total_stores =3D {
> +       .header         =3D HEADER_BOTH("Store", "count"),
> +       .name           =3D "total_stores",
> +       .cmp            =3D total_stores_cmp,
> +       .entry          =3D total_stores_entry,
> +       .width          =3D 7,
> +};
> +
> +static struct c2c_dimension dim_symbol_view =3D {
> +       .header         =3D HEADER_LOW("Function / Contending function / =
Cacheline"),
> +       .name           =3D "symbol_view",
> +       .se             =3D &sort_sym,
> +       .entry          =3D symbol_view_entry,
> +       .width          =3D SYMBOL_WIDTH,
> +};
> +
> +static struct c2c_dimension *function_view_dimensions[] __maybe_unused =
=3D {
> +       &dim_cycles_percent,
> +       &dim_total_stores,
> +       &dim_symbol_view,
> +       NULL,
> +};
> --
> 2.52.0
>
