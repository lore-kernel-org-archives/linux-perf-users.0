Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C91A44A3F9
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000740; cv=pass; b=d++dky8hffEhCEpy1/tXCWvvC5hoqvFs9FwRjTWmh5mfzwjzKUUqiAvm6Lem1m/x0tGKa7a7k7V/YOAQA3HbEd4EU+mk6R3m8G+sDeatNvL5YNY1IUZ+ZVP3uiR31iyBC+oC0qxm+EcXzpzon/gIl2HoxEt9OKhXz9u8nL4IY84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000740; c=relaxed/simple;
	bh=EdzTr465Dd9lCO58LzV9wIAOIpt2kUAFTCyY6t/Wb4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMMnG5F8cp0aOLCIw1+pdghOxydimB0IEElf5ZYe2MiBW1NyxERg5WMagJxkwr4nngjn3zas1tZKVPM1csZ4XXZo8ixOzDHVWabEy7XCU9gIDqyNK6+5qY/BdrQYnwvEPpCeMM8h/jG93KSTO+OEPPzDE6eCtE9rqegmcqtd+l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HXVvXhOJ; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HXVvXhOJ"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c10ed63c0so24201cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 14:05:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787000737; cv=none;
        d=google.com; s=arc-20260327;
        b=JOsFlM3gWcD5GDud9nKI04QRJTchTo7yXcaIPq1egk1G4G9dlqPyMAWBrLq8XhYhTj
         Tv+ycbNP48JYcGJqPaulRPz/avvuiUsf5H3FPBuw+gHEQgSAIqQYdRuVR9lHxbzZlHCc
         UN94pazu2XL+A61XfbUrS+ERuxjJkrhsnSVJ7FRzu6OmlKxd6y3ijDezlANlQb4DAtrP
         VyaLS8yv6XaKRUQY+77HB2eEXxbNVKWmIbGm7Qu6Q2jn+nR6I9tLr5dfKz8BTIgXwLk9
         M4Xd5LILSWnh9DkKJH7oaoEs29lJouTc+/cHPeJX5eaGcDyKpIFnEPZfhADwhr9xG6ov
         CZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4H/5WxBXGNTSweB2VqFezEab5qTO427ZPF+YQBwBGVk=;
        fh=pvPpK92atftosn48QbR3DL44j1ATwTFpj1ym2EeRZ6M=;
        b=cogjDjU1EWrQu8gwk5oeqwCueGMKMkG02nDZazR8+uPjl4iLB5GMZpajVPx63a58ly
         d/7tF8LLdLlJ4pkl5oQZpVfgCAfXy2im3u63bylv2gmAoe8jxB44BVlMZy774Cs+Sk0v
         w/NRN4E+ZmFjQjCgZ1j7IFjTlDRR4wKSeGLxihxSZsMfUdk+ICK34qAx3hRkBXPKVLKM
         Ok1N4xISMABE7xA2+7Kw5jq5Vr1WNrr8pZigwYo6jQ0g/mNuV0rJNb3kh7uZlwaGZEBj
         r93GyZ6A+mByoYnRpiEuZOU1UnOcYKd0lnXELVgH2+wtSszXh40Gs+VSYA04tNqiej+c
         4odg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787000737; x=1787605537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4H/5WxBXGNTSweB2VqFezEab5qTO427ZPF+YQBwBGVk=;
        b=HXVvXhOJOKPrK1dqjfIvhBr9JyOV42xk+QRpwbKRPJ50sCRtFKAMUdT8wjQvIqlbXz
         cQN9AN12TADOoE94Q8V6AbCKQGtCNszsb3X5pr57pZPD6++v32X+WWKUUZ64rYTJwTPL
         6DZcW5kh4fxrvoC5CE72ut4puv7BYIhpwO/pEyuy8DFNrOwsKnZO6HwIe68jzLlGAzvc
         bl5hG8YIhkCd+lXx/DFyw+M4nzK0eskpDIqlhItqZ0K+Zx0iibqvCMmJ76BFtJqoYsXj
         khBjNlXuBVTSjzbLF+ouK+imLXSs3jck2T/PGj9MW/Sc1qDU3okJBB0x6+tCybNJ+tZg
         qVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787000737; x=1787605537;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4H/5WxBXGNTSweB2VqFezEab5qTO427ZPF+YQBwBGVk=;
        b=DCsJAtjfy9iiajjfp41xZ4CZSeQwxASglrEFg0Kl5X8PYffQ3sNWPpmRSZt5P7geFH
         uhGKkDUGV8+CE3GPa+ITDfSZxc4dEiKV+qba2Cdk/hEFizMa+s7j95yFcAh21u0SmpxQ
         HFUsidBrB1C/dOPKD7F3XUIOrcGXNZKuHE6JDZjBbwDjAUxX/Zqyrr/EqHcqiOsgNgzE
         N/oXKVEAbIQX2dactY9yZwTw9fBqXnvOYlo009hMXeDBz2gjCDzzAjMmgNwmR04XqVPA
         b1cNDuMzRvmqIU2ndLPjm0yb4FyO7hUrXXGOcWcbTfMVXTbPf+r6P4PCA9+h2v85Jboc
         GEPA==
X-Forwarded-Encrypted: i=1; AHgh+RoCHegTKJYPCC8bgXVnXIs72GshRu5XvpsaqMNO1C6G6+mV52ky80Xv87JTYGGqzg1OBhRKpNwnLFObuwTGFu/h@vger.kernel.org
X-Gm-Message-State: AOJu0Yye1Qj5ux7oyO5rvkRMLnBAJsJ9MOu0/hi+SeeRn+3Cs5ak0fog
	Ey4he3YhH2nclDN+wdTLakLX6BnfwLmlrJ1/tPDfaTKIWSx5YNYmEaZupBshGXvQLuzZNreSvZs
	o/LDa2mGrua/K95xCFuZmexew9CJLmfsDv7l31rji
X-Gm-Gg: AR+sD12SP7yqvYEzNFyAO+rJqcGHcGXUXhg9sYbWwLgsvgzkW1rhrucKFPLK94wLDRW
	MOqrJYvd1wnTXWMiB6N8vHkLTBTktcrDL9ntbBOlG1OEDlF7Z8T2rmzBnIc3gLbopp9L/LeE4Rp
	PGzevoPwkBVyI4MDX3tls3H7zW+jT+J8eS5nHqCAQBD5VdZyJYJojIrPNadyj+c1R/eDiNf6uG3
	SgCxF2kJ6jYN7OyJqPnM6lpDYY3JMmSGC1AzQPlHrwZ/5on/ZybwO3jY3/LsLjLetS0zI7MPNuY
	rTnkn+2LQIqTVPfIABgO1wiFLfLkXiPfFcfiJhZCPrZhCOaZ+V+bsLFGq46iwQqRNz11+TidJUY
	aHlkh
X-Received: by 2002:a05:622a:a16:b0:52d:3432:82d with SMTP id
 d75a77b69052e-52dc0b4575emr4758411cf.9.1787000736756; Mon, 17 Aug 2026
 14:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817094623.3288456-1-jiebin.sun@intel.com> <20260817094623.3288456-6-jiebin.sun@intel.com>
In-Reply-To: <20260817094623.3288456-6-jiebin.sun@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 14:05:24 -0700
X-Gm-Features: AcwNN1XapHCNb5AJGOHe8c2KsLDs8M0JTyHMiGx_ye4sogKPlIYeDsHoXaizCxA
Message-ID: <CAP-5=fUo-EXrAqqd-gP=0ya0kHwMdrb0vhLR-YiL=zKUjVym3w@mail.gmail.com>
Subject: Re: [PATCH v9 5/9] perf c2c: add function view stats merge and memory management
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
> Add the per-entry stats/cstats aggregation helpers and hierarchy teardown=
.
> Child common fields are released through hist_entry__delete(), while the
> function-view free callback handles the private child tree and containing
> allocation. Also add a helper for pruning writer entries with no stores o=
r
> cacheline children.
>
> These are used by the entry-creation and builder patches that follow and
> are __maybe_unused until then.
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
>  tools/perf/util/c2c-function.c | 163 +++++++++++++++++++++++++++++++++
>  1 file changed, 163 insertions(+)
>
> diff --git a/tools/perf/util/c2c-function.c b/tools/perf/util/c2c-functio=
n.c
> index d27544016660..aa6be7c72977 100644
> --- a/tools/perf/util/c2c-function.c
> +++ b/tools/perf/util/c2c-function.c
> @@ -680,3 +680,166 @@ c2c_function_hists__reinit(struct c2c_hists *c2c_hi=
sts,
>
>         return function_hpp_list__parse(&c2c_hists->list, output, sort, e=
nv);
>  }
> +
> +/* Welford online merge of two "stats" (from util/stat.h) accumulators. =
*/
> +static void c2c_stats_merge(struct stats *dest, const struct stats *src)
> +{
> +       double delta;
> +
> +       if (src->n =3D=3D 0)
> +               return;
> +
> +       if (dest->n =3D=3D 0) {
> +               *dest =3D *src;
> +               return;
> +       }
> +
> +       delta =3D src->mean - dest->mean;
> +       dest->M2 +=3D src->M2 + delta * delta * dest->n * src->n / (dest-=
>n + src->n);
> +       dest->mean =3D (dest->mean * dest->n + src->mean * src->n) / (des=
t->n + src->n);
> +       dest->n +=3D src->n;
> +
> +       /* Update min/max */
> +       if (src->max > dest->max)
> +               dest->max =3D src->max;
> +       if (src->min < dest->min)
> +               dest->min =3D src->min;
> +}
> +
> +/* Merge compute_stats during function aggregation. */
> +static void __maybe_unused c2c_add_cstats(struct compute_stats *dest,
> +                                         const struct compute_stats *src=
)
> +{
> +       c2c_stats_merge(&dest->rmt_hitm, &src->rmt_hitm);
> +       c2c_stats_merge(&dest->lcl_hitm, &src->lcl_hitm);
> +       c2c_stats_merge(&dest->rmt_peer, &src->rmt_peer);
> +       c2c_stats_merge(&dest->lcl_peer, &src->lcl_peer);
> +       c2c_stats_merge(&dest->load, &src->load);
> +}
> +
> +static bool __maybe_unused hist_entry__add_c2c_stats(struct hist_entry *=
he,
> +                                                    const struct c2c_sta=
ts *stats)
> +{
> +       u64 nr_events =3D c2c_hitm_count(stats) + stats->rmt_peer + stats=
->lcl_peer;
> +       u64 weight1 =3D c2c_hitm_count(stats);
> +
> +       /*
> +        * Allocate before touching he->stat, so a failure here leaves th=
e
> +        * entry unmodified and the caller can bail out without having
> +        * half-updated the statistics.
> +        */
> +       if (symbol_conf.cumulate_callchain && !he->stat_acc) {
> +               he->stat_acc =3D calloc(1, sizeof(struct he_stat));
> +               if (!he->stat_acc)
> +                       return false;
> +       }
> +
> +       he->stat.nr_events +=3D nr_events;
> +       he->stat.period +=3D nr_events;
> +       he->stat.weight1 +=3D weight1;
> +
> +       if (!symbol_conf.cumulate_callchain)
> +               return true;
> +
> +       he->stat_acc->nr_events +=3D nr_events;
> +       he->stat_acc->period +=3D nr_events;
> +       he->stat_acc->weight1 +=3D weight1;
> +
> +       return true;
> +}
> +
> +static void c2c_he__free_hierarchy(struct hist_entry *he);
> +
> +/*
> + * Free a function-view histogram entry (hist_entry_ops::free).
> + */
> +static void __maybe_unused c2c_function_he_free(void *ptr)
> +{
> +       struct hist_entry *he =3D ptr;
> +       struct c2c_hist_entry *c2c_he;
> +
> +       c2c_he =3D container_of(he, struct c2c_hist_entry, he);
> +
> +       if (c2c_he->hists) {
> +               perf_hpp__reset_output_field(&c2c_he->hists->list);
> +               hists__delete_all_entries(&c2c_he->hists->hists);
> +               zfree(&c2c_he->hists);
> +       }
> +
> +       c2c_he__free_hierarchy(he);
> +
> +       zfree(&c2c_he->nodeset);
> +       zfree(&c2c_he->cpuset);
> +       zfree(&c2c_he->nodestr);
> +       zfree(&c2c_he->node_stats);
> +
> +       free(c2c_he);
> +}
> +
> +static void c2c_he__free_hierarchy(struct hist_entry *he)
> +{
> +       struct rb_node *nd;
> +       struct hist_entry *child_he;
> +
> +       /*
> +        * A leaf entry stores its callchains in the sorted_chain member,=
 which
> +        * shares a union with the hroot_in/hroot_out child trees, so its
> +        * hroot_out is not a valid subtree to walk. Leaf entries never h=
ave a
> +        * child hierarchy here, so stop before touching hroot_out.
> +        */
> +       if (he->leaf)
> +               return;
> +
> +       if (RB_EMPTY_ROOT(&he->hroot_out.rb_root))
> +               return;
> +
> +       nd =3D rb_first_cached(&he->hroot_out);
> +       while (nd) {
> +               struct rb_node *next =3D rb_next(nd);
> +
> +               child_he =3D rb_entry(nd, struct hist_entry, rb_node);
> +               rb_erase_cached(&child_he->rb_node, &he->hroot_out);
> +               hist_entry__delete(child_he);
> +
> +               nd =3D next;
> +       }
> +
> +       /* All children erased; clear the tree (and its cached leftmost).=
 */
> +       he->hroot_out =3D RB_ROOT_CACHED;
> +}
> +
> +/*
> + * Drop level-2 writing functions that carry no stores or
> + * no cacheline children. Writers are only added when they store into a =
shared
> + * line, so this is mainly a safety net. Returns the number of surviving
> + * writers.
> + */
> +static int __maybe_unused c2c_he__prune_empty_writers(struct hist_entry =
*l1_he)
> +{
> +       struct rb_node *nd;
> +       int surviving =3D 0;
> +
> +       if (!l1_he->has_children)
> +               return 0;
> +
> +       nd =3D rb_first_cached(&l1_he->hroot_out);
> +       while (nd) {
> +               struct rb_node *next =3D rb_next(nd);
> +               struct hist_entry *l2_he =3D rb_entry(nd, struct hist_ent=
ry, rb_node);
> +
> +               if (l2_he->has_children && hist_entry__displayed_stores(l=
2_he) > 0) {
> +                       surviving++;
> +               } else {
> +                       rb_erase_cached(&l2_he->rb_node, &l1_he->hroot_ou=
t);
> +                       hist_entry__delete(l2_he);
> +               }
> +               nd =3D next;
> +       }
> +
> +       if (!surviving) {
> +               l1_he->hroot_out =3D RB_ROOT_CACHED;
> +               l1_he->has_children =3D false;
> +               l1_he->unfolded =3D false;
> +       }
> +       return surviving;
> +}
> --
> 2.52.0
>
