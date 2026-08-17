Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2D3F7899
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000820; cv=pass; b=BgKttwKqoXBef8/lglBVMvHw1iXWvJO5EjNYfOamxQkW53OUgSUaPjvT/Asw8sn2bGrlS12oh4YHEIaThAKWGptpWn0uqsHlZKVR3fKi+VxiB4Xu5Ni4KBc6OJ+OOrB5+15mfazTS7F/7B1fVjHKh4I3LE4dclJeC7XywZ/GuOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000820; c=relaxed/simple;
	bh=pIbO1CF/ZfcG425YqTuoktMoa4lHFB14VHzbm2A+fdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dm4QiokvpVHi3xi0FJQeYGhoeh1aN6oh+IuW0NYKS/fUymmuZECxbGoiAc8tcK/unf49ulTw1x4NQ0TFasAok48fpGuxo9kr9ZcQgw77n5J7rgpGU80YsT9xnM6AOaxZ3OKoDS4y7UH9X6cduM71TcQGMExBcSHV4vPDQCE5nWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zdc1PLpO; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zdc1PLpO"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c10ed63c0so24751cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 14:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787000817; cv=none;
        d=google.com; s=arc-20260327;
        b=Xp2V5evJOwSQhlMI9c0T1aY6MfXtRogqSczy+66J6bwqvGtTVs6ztLMPZ9BT8lT37u
         yaq+q5Hk1j5Hjpu6N8fSax9xK0JNolnnrUYEvtzheOV7NNfE/KMEOwz5qfn0e3rd+7bW
         syhS7vifYphRnrRzT14LyM7gmqsryIK/eXx1zjM1EJpxPZb92vj4XWeMjbFdB62czd5M
         2iFM7gl+diskAT3ksc3oua1BuS2d4HmO+9q2FzwV4c0SxeB7DFD0hHPE0t8OUFwsQIEF
         OfV0KwvaCwF5WoTFZ5AVASMnI2J9hq3wJ2KBs6R/hFXYz4bvbZ/idhi7vw07hfxVmkCo
         cbYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q75kBJ/5R3v0k51gVQFQWYaA9EZclkMNB3XXJPdpBVo=;
        fh=1H0g0Z4q9Gx+YHgKH4s2M8OMQYOkgR/RASYvLqLWvdA=;
        b=GTXFGUndzE2g6jJhoCWi0UCMPgi7yB7yZ9HuBUK/TrpHBo9nLDAZMoUXTw3iCwGtB5
         aoudMb4F3VKiqfIK871s4UB5gR9/bIxvdqDMK/KXOn52JAPetjyoUaZ/plhUn9arUvdC
         VDxIkJIRatxT65JlXgmw4Pwz4kiip5LDPbagasPAg6FuadyYh7Kb7NmddVQ3HhaKaqCV
         OOJ+zi/J5e/vXGmPQKeS7KHVe2gOZWXh4mLaEygvpSvtYpJgIIz0hGFlKFA9/Ffc7one
         +vNgcRU3a/36WyH8crq/sqVm5fISbL0aO4LIxKKyMKcYp8ETl1mfSaU0nJiXprdkJvQB
         B2DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787000817; x=1787605617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q75kBJ/5R3v0k51gVQFQWYaA9EZclkMNB3XXJPdpBVo=;
        b=Zdc1PLpOJltwh/Hhgayssjl9SEzcZMgcV4KxLyC4zGVc+d6qSRC5o92ozpC0QYRsW7
         s0yKZ9oP8H+BayBnrszRC+neQxoqq62xYpW8QIBqZJL85YykM+AGSbFlwa5DEksFxFmh
         p1qo1FtK8Hked4DOhIF2FjsGUWlHNIatnpxuW+9RarweMSCZjt52sLc6ktUVgrYahhoJ
         HyjMUAO5JOzcaxXVzLz+hjc8QGahv3LQr2ocUThC/Pz/YKrjdhaRxkmfTQecEiBaPItA
         Y5YThgo57hcLbVpY4d3LHeUilDCIgHraP8iVoj/GJNoiDNAOFpNGkdMrQ0rfCdM7HhLw
         AWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787000817; x=1787605617;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q75kBJ/5R3v0k51gVQFQWYaA9EZclkMNB3XXJPdpBVo=;
        b=HexzI0qEKLX4e05MEBqzFGokaNksE0c/6A5ieloQ5eF3A8IXakbBBmId3Yw/3ShO6o
         Fude7qAKE7l3nM3gFRIpEll/t+hf7q8nFRLofB64dy72xKsvBTX1/06dwgI20fkzLpAx
         nZ0aCRVqxx2mMNaeC0K7/ff7dgfk8qwOJJ6sR8S0Yxu4e5umRygVspVkG87tqN5eHwns
         ymmhUkSGZ53IpCQQGI7V56kkM39vs6m/zwoxUGvpmkJ/uwNHnp66yjpBafGgVVnicYcq
         bARmvfwuiLT8XzTLLC0xr7xJacXaFQ1UQkQhN2YUBydLVYKmKftKakAb1Ms6SgP3FtGr
         bgYw==
X-Forwarded-Encrypted: i=1; AHgh+Rq64INRryh2+c+N2CMZLPkYdwYvDv5v3W293DM0e/N72TOIwia5aALoJuoyRWez3DFwO41JjGcI4lsLdyWcnqo6@vger.kernel.org
X-Gm-Message-State: AOJu0YxNuCAYyjqGdocsWWxXLUvWED0RiRaOJXKDD0fy3fBZ2tOyiby7
	EoVooxqm46A5gzrGj0u4+hvxGYcpmPoeOu8x/TK2DWqvbYlynhO+ZgrVkcDkmGnfvGMxShbKv1j
	pI6nGNzpDShWs4Xhq2tZOZFxMIYlR1o6IiJjqPoyh
X-Gm-Gg: AR+sD12riiywPd8BXYmKVJ2bhGQ+Vqa6MlAzWyA2AIwqXVc3JKYp3c3Q4wquYapJDx5
	L52RS4pgliiS/mcD5lRkESeSLkB2GwHfbaqeRLS3BNg0IJy64l07E+0RCZNllp6slsljYdJkmPA
	2e7XpsYXLA0Dt65H29ZnCvMOF4aTKBKmoUdFcniceTKEN6NZqJmw4QFwqTZLwR0vt7NRbtLBAe9
	7UHqGM5HoHg9k3S3BiFeZSoetQGW6x//p0P1qPGoM+2wY+Gyryv1VD6OOBLwwgRNRlieVM7PgQM
	o2RfcP8q9TeZRnCS+nk6Cmo2c/qhCTjkU7Ly4fD1L1MlumM7mzqKvHcLdi5AsZr1KSEl3GHAFsk
	=
X-Received: by 2002:a05:622a:1f16:b0:517:64f6:3365 with SMTP id
 d75a77b69052e-52dc08aa2d1mr4811731cf.4.1787000815901; Mon, 17 Aug 2026
 14:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817094623.3288456-1-jiebin.sun@intel.com> <20260817094623.3288456-7-jiebin.sun@intel.com>
In-Reply-To: <20260817094623.3288456-7-jiebin.sun@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 14:06:44 -0700
X-Gm-Features: AcwNN1X8O2cmtLBF5E0rHCmDEdGgq5_ZM7Axon4GlImwRqz5jf_3wwoiu4ad4WM
Message-ID: <CAP-5=fU5tM4vmu0PFJOOOb-caS6bs8=aRyfP2rr_L56TOLksgw@mail.gmail.com>
Subject: Re: [PATCH v9 6/9] perf c2c: add function view hierarchy entry creation
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
> Add the entry-creation layer: owned-reference child allocation and
> insertion, and the level-1/2/3 lookup-or-create functions keyed by
> function symbol (level 1 read-side, level 2 writer) and by the source
> cacheline's existing index (level 3).
>
> Give synthetic children normal entry operations and acquire their thread
> and map-symbol references. This lets the hierarchy teardown use
> hist_entry__delete() for the common fields while the function-view free
> callback handles the private child tree and containing allocation.
>
> Reuse cacheline_idx to preserve the source entry identity without adding
> function-view-only state. Add c2c_function__find_cacheline() to locate th=
e
> original cacheline entry by the same index.
>
> These are driven by the hierarchy builder in the next patch and are
> __maybe_unused until then.
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
>  tools/perf/util/c2c-function.c | 319 +++++++++++++++++++++++++++++++--
>  tools/perf/util/c2c.h          |   2 +
>  2 files changed, 310 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/util/c2c-function.c b/tools/perf/util/c2c-functio=
n.c
> index aa6be7c72977..c005fb5454a7 100644
> --- a/tools/perf/util/c2c-function.c
> +++ b/tools/perf/util/c2c-function.c
> @@ -24,6 +24,7 @@
>  #include "c2c.h"
>  #include "cacheline.h"
>  #include "debug.h"
> +#include "dso.h"
>  #include "hist.h"
>  #include "map.h"
>  #include "mem-events.h"
> @@ -51,12 +52,34 @@ static inline __maybe_unused u64 c2c_hitm_count(const=
 struct c2c_stats *stats)
>         return stats->tot_hitm;
>  }
>
> -static inline __maybe_unused bool symbol_name_equal(struct symbol *a, st=
ruct symbol *b)
> +static int64_t c2c_function_cmp(const struct map_symbol *left,
> +                               const struct map_symbol *right)
>  {
> -       /* Two unknown symbols compare equal, matching cmp_null() in util=
/sort.c. */
> -       if (!a || !b)
> -               return a =3D=3D b;
> -       return arch__compare_symbol_names(a->name, b->name) =3D=3D 0;
> +       const struct dso *left_dso =3D left->map ? map__dso(left->map) : =
NULL;
> +       const struct dso *right_dso =3D right->map ? map__dso(right->map)=
 : NULL;
> +       int ret;
> +
> +       if (!left_dso || !right_dso) {
> +               if (left_dso !=3D right_dso)
> +                       return left_dso ? 1 : -1;
> +       } else {
> +               /*
> +                * Use the same DSO name as _sort__dso_cmp() (short name =
unless
> +                * verbose), so this matches the DSO comparison the level=
-1
> +                * entries are deduplicated by; otherwise same-basename D=
SOs
> +                * could be split or merged inconsistently across levels.
> +                */
> +               const char *left_name =3D verbose > 0 ?
> +                       dso__long_name(left_dso) : dso__short_name(left_d=
so);
> +               const char *right_name =3D verbose > 0 ?
> +                       dso__long_name(right_dso) : dso__short_name(right=
_dso);
> +
> +               ret =3D strcmp(left_name, right_name);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return _sort__sym_cmp(left->sym, right->sym);
>  }
>
>  static inline __maybe_unused u64 hist_entry__iaddr(struct hist_entry *he=
)
> @@ -753,7 +776,7 @@ static void c2c_he__free_hierarchy(struct hist_entry =
*he);
>  /*
>   * Free a function-view histogram entry (hist_entry_ops::free).
>   */
> -static void __maybe_unused c2c_function_he_free(void *ptr)
> +static void c2c_function_he_free(void *ptr)
>  {
>         struct hist_entry *he =3D ptr;
>         struct c2c_hist_entry *c2c_he;
> @@ -768,11 +791,6 @@ static void __maybe_unused c2c_function_he_free(void=
 *ptr)
>
>         c2c_he__free_hierarchy(he);
>
> -       zfree(&c2c_he->nodeset);
> -       zfree(&c2c_he->cpuset);
> -       zfree(&c2c_he->nodestr);
> -       zfree(&c2c_he->node_stats);
> -
>         free(c2c_he);
>  }
>
> @@ -843,3 +861,282 @@ static int __maybe_unused c2c_he__prune_empty_write=
rs(struct hist_entry *l1_he)
>         }
>         return surviving;
>  }
> +
> +static void *c2c_function_he_zalloc(size_t size)
> +{
> +       struct c2c_hist_entry *c2c_he =3D zalloc(sizeof(*c2c_he) + size);
> +
> +       if (!c2c_he)
> +               return NULL;
> +
> +       init_stats(&c2c_he->cstats.lcl_hitm);
> +       init_stats(&c2c_he->cstats.rmt_hitm);
> +       init_stats(&c2c_he->cstats.lcl_peer);
> +       init_stats(&c2c_he->cstats.rmt_peer);
> +       init_stats(&c2c_he->cstats.load);
> +
> +       return &c2c_he->he;
> +}
> +
> +/* Entry operations for function view */
> +static struct hist_entry_ops c2c_function_entry_ops =3D {
> +       .new    =3D c2c_function_he_zalloc,
> +       .free   =3D c2c_function_he_free,
> +};
> +
> +static struct c2c_hist_entry *
> +c2c_child_entry__alloc(struct hist_entry *parent_he, struct hist_entry *=
src_he,
> +                      int depth, u64 ip)
> +{
> +       struct c2c_hist_entry *child_c2c;
> +       struct hist_entry *child_he;
> +
> +       /* Function-view children never own or display callchains. */
> +       child_he =3D c2c_function_he_zalloc(0);
> +       if (!child_he)
> +               return NULL;
> +
> +       child_c2c =3D container_of(child_he, struct c2c_hist_entry, he);
> +       child_he->ops =3D &c2c_function_entry_ops;
> +       map_symbol__copy(&child_he->ms, &src_he->ms);
> +
> +       if (src_he->mem_info) {
> +               child_he->mem_info =3D mem_info__clone(src_he->mem_info);
> +               if (!child_he->mem_info)
> +                       goto out_free;
> +       }
> +
> +       child_he->thread =3D thread__get(src_he->thread);
> +       child_he->cpumode =3D src_he->cpumode;
> +       child_he->cpu =3D src_he->cpu;
> +       child_he->socket =3D src_he->socket;
> +       child_he->level =3D src_he->level;
> +       child_he->ip =3D ip;
> +
> +       child_he->parent_he =3D parent_he;
> +       child_he->depth =3D depth;
> +       child_he->leaf =3D (depth >=3D 2);
> +       child_he->hists =3D &c2c_ext.function_hists.hists;
> +       child_he->filtered =3D false;
> +       child_he->unfolded =3D false;
> +       child_he->has_children =3D false;
> +       child_he->has_no_entry =3D false;
> +       child_he->nr_rows =3D 0;
> +       child_he->row_offset =3D 0;
> +
> +       memset(&child_he->stat, 0, sizeof(child_he->stat));
> +       child_he->hroot_in =3D RB_ROOT_CACHED;
> +       child_he->hroot_out =3D RB_ROOT_CACHED;
> +       INIT_LIST_HEAD(&child_he->pairs.node);
> +       child_he->hpp_list =3D &c2c_ext.function_hists.list;
> +       if (symbol_conf.cumulate_callchain) {
> +               child_he->stat_acc =3D calloc(1, sizeof(struct he_stat));
> +               if (!child_he->stat_acc)
> +                       goto out_free;
> +       }
> +
> +       return child_c2c;
> +
> +out_free:
> +       hist_entry__delete(child_he);
> +       return NULL;
> +}
> +
> +static void
> +c2c_child_entry__insert(struct hist_entry *parent_he, struct hist_entry =
*child_he,
> +                       struct rb_node **p, struct rb_node *rb_parent, bo=
ol leftmost)
> +{
> +       rb_link_node(&child_he->rb_node, rb_parent, p);
> +       rb_insert_color_cached(&child_he->rb_node, &parent_he->hroot_out,=
 leftmost);
> +
> +       parent_he->has_children =3D true;
> +       parent_he->leaf =3D false;
> +}
> +
> +static __maybe_unused struct hist_entry *
> +c2c_function_hists__level1_entry(struct symbol *sym,
> +                                struct hist_entry *detail_he,
> +                                struct thread *synthetic_thread)
> +{
> +       struct addr_location al;
> +       struct perf_sample sample =3D {};
> +       struct mem_info *mi;
> +       struct hist_entry *he;
> +       /*
> +        * Key the level-1 entry by the function, not by a specific code
> +        * address: use the symbol start so every instruction address ins=
ide
> +        * the same function collapses into one entry. This makes level 1=
 a
> +        * true "function view" rather than a per-code-address view.
> +        */
> +       u64 sym_start =3D (sym && detail_he->ms.map) ?
> +                       map__unmap_ip(detail_he->ms.map, sym->start) : de=
tail_he->ip;
> +
> +       mi =3D mem_info__new();
> +       if (!mi)
> +               return NULL;
> +
> +       mem_info__iaddr(mi)->addr =3D sym_start;
> +       /* mem_info__put() will map_symbol__exit() these, so take refs. *=
/
> +       mem_info__iaddr(mi)->ms.thread =3D thread__get(detail_he->ms.thre=
ad);
> +       mem_info__iaddr(mi)->ms.map =3D map__get(detail_he->ms.map);
> +       mem_info__iaddr(mi)->ms.sym =3D sym;
> +       mem_info__daddr(mi)->addr =3D 0;
> +
> +       addr_location__init(&al);
> +       al.thread =3D thread__get(synthetic_thread);
> +       al.map =3D map__get(detail_he->ms.map);
> +       al.sym =3D sym;
> +       al.addr =3D sym_start;
> +       al.level =3D detail_he->level;
> +       al.cpumode =3D detail_he->cpumode;
> +       al.cpu =3D 0;
> +       al.socket =3D 0;
> +       al.filtered =3D 0;
> +       al.latency =3D 0;
> +
> +       /*
> +        * Synthetic sample: period/weight are placeholders only. The rea=
l
> +        * c2c counters live in c2c_hist_entry::stats and are added via
> +        * hist_entry__add_c2c_stats(); no function-view column or sort k=
ey
> +        * reads he->stat.period/nr_events, so the +1 that __hists__add_e=
ntry()
> +        * accrues on each dedup hit has no effect on what is displayed.
> +        */
> +       sample.period =3D 1;
> +       sample.weight =3D 1;
> +       sample.ip =3D sym_start;
> +       sample.pid =3D thread__pid(synthetic_thread);
> +       sample.tid =3D thread__tid(synthetic_thread);
> +       sample.cpu =3D 0;
> +
> +       /* Add entry - histogram handles dedup */
> +       he =3D hists__add_entry_ops(&c2c_ext.function_hists.hists,
> +                                 &c2c_function_entry_ops,
> +                                 &al, NULL, NULL, mi,
> +                                 NULL, &sample, true);
> +
> +       addr_location__exit(&al);
> +       mem_info__put(mi);
> +
> +       if (he)
> +               he->hpp_list =3D &c2c_ext.function_hists.list;
> +
> +       return he;
> +}
> +
> +/*
> + * Level 2: a function that writes a cacheline the level-1 function read=
s,
> + * keyed by the DSO display name and symbol, consistently with perf's sy=
mbol
> + * sort semantics. All code addresses and cachelines for the same writer
> + * function aggregate into one row.
> + */
> +static __maybe_unused struct c2c_hist_entry *
> +c2c_function_hists__level2_entry(struct c2c_hist_entry *level1_c2c,
> +                                struct symbol *sym, struct hist_entry *d=
etail_he)
> +{
> +       struct hist_entry *level1_he =3D &level1_c2c->he;
> +       struct rb_node **p =3D &level1_he->hroot_out.rb_root.rb_node;
> +       struct rb_node *parent =3D NULL;
> +       struct c2c_hist_entry *level2_c2c;
> +       bool leftmost =3D true;
> +
> +       while (*p) {
> +               struct hist_entry *iter =3D rb_entry(*p, struct hist_entr=
y, rb_node);
> +               struct map_symbol key =3D detail_he->ms;
> +               int64_t cmp;
> +
> +               key.sym =3D sym;
> +               parent =3D *p;
> +               cmp =3D c2c_function_cmp(&key, &iter->ms);
> +
> +               if (cmp < 0) {
> +                       p =3D &parent->rb_left;
> +               } else if (cmp > 0) {
> +                       p =3D &parent->rb_right;
> +                       leftmost =3D false;
> +               } else {
> +                       return container_of(iter, struct c2c_hist_entry, =
he);
> +               }
> +       }
> +
> +       /* Key by the function symbol start so all code addresses collaps=
e. */
> +       level2_c2c =3D c2c_child_entry__alloc(level1_he, detail_he, 1,
> +                                           (sym && detail_he->ms.map) ?
> +                                                 map__unmap_ip(detail_he=
->ms.map, sym->start) :
> +                                                 hist_entry__iaddr(detai=
l_he));
> +       if (!level2_c2c)
> +               return NULL;
> +
> +       /* Key this level by the looked-up symbol, not detail_he's. */
> +       level2_c2c->he.ms.sym =3D sym;
> +       if (level2_c2c->he.mem_info)
> +               mem_info__iaddr(level2_c2c->he.mem_info)->ms.sym =3D sym;
> +
> +       c2c_child_entry__insert(level1_he, &level2_c2c->he, p, parent, le=
ftmost);
> +
> +       return level2_c2c;
> +}
> +
> +/* Level 3: one source cacheline where the L1/L2 functions contend. */
> +static __maybe_unused struct c2c_hist_entry *
> +c2c_function_hists__level3_entry(struct c2c_hist_entry *level2_c2c,
> +                                struct c2c_hist_entry *cacheline_src_he)
> +{
> +       struct hist_entry *level2_he =3D &level2_c2c->he;
> +       struct rb_node **p =3D &level2_he->hroot_out.rb_root.rb_node;
> +       struct rb_node *parent =3D NULL;
> +       struct c2c_hist_entry *level3_c2c;
> +       bool leftmost =3D true;
> +
> +       while (*p) {
> +               struct c2c_hist_entry *iter_c2c =3D
> +                       rb_entry(*p, struct c2c_hist_entry, he.rb_node);
> +
> +               parent =3D *p;
> +               if (cacheline_src_he->cacheline_idx < iter_c2c->cacheline=
_idx) {
> +                       p =3D &parent->rb_left;
> +               } else if (cacheline_src_he->cacheline_idx > iter_c2c->ca=
cheline_idx) {
> +                       p =3D &parent->rb_right;
> +                       leftmost =3D false;
> +               } else {
> +                       return iter_c2c;
> +               }
> +       }
> +
> +       level3_c2c =3D c2c_child_entry__alloc(level2_he, &cacheline_src_h=
e->he, 2,
> +                                           hist_entry__iaddr(&cacheline_=
src_he->he));
> +       if (!level3_c2c)
> +               return NULL;
> +       level3_c2c->cacheline_idx =3D cacheline_src_he->cacheline_idx;
> +
> +       c2c_child_entry__insert(level2_he, &level3_c2c->he, p, parent, le=
ftmost);
> +
> +       return level3_c2c;
> +}
> +
> +struct hist_entry *c2c_function__find_cacheline(struct hist_entry *he_se=
lection)
> +{
> +       struct c2c_hist_entry *c2c_he;
> +       struct rb_node *nd;
> +
> +       if (!c2c_ext.cl_hists || !he_selection || !he_selection->parent_h=
e ||
> +           !he_selection->parent_he->parent_he)
> +               return NULL;
> +
> +       c2c_he =3D container_of(he_selection, struct c2c_hist_entry, he);
> +
> +       for (nd =3D rb_first_cached(&c2c_ext.cl_hists->hists.entries); nd=
;
> +            nd =3D rb_next(nd)) {
> +               struct hist_entry *he =3D rb_entry(nd, struct hist_entry,=
 rb_node);
> +               struct c2c_hist_entry *cacheline_he;
> +
> +               if (he->filtered)
> +                       continue;
> +
> +               cacheline_he =3D container_of(he, struct c2c_hist_entry, =
he);
> +               if (cacheline_he->hists &&
> +                   cacheline_he->cacheline_idx =3D=3D c2c_he->cacheline_=
idx)
> +                       return he;
> +       }
> +
> +       return NULL;
> +}
> diff --git a/tools/perf/util/c2c.h b/tools/perf/util/c2c.h
> index bd0c9d1c9a1a..f95e636edc0f 100644
> --- a/tools/perf/util/c2c.h
> +++ b/tools/perf/util/c2c.h
> @@ -98,4 +98,6 @@ struct c2c_fmt {
>  void c2c_fmt_free(struct perf_hpp_fmt *fmt);
>  bool c2c_fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
>
> +struct hist_entry *c2c_function__find_cacheline(struct hist_entry *he);
> +
>  #endif /* __PERF_UTIL_C2C_H */
> --
> 2.52.0
>
