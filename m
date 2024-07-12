Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63ED17BB6
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 05:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720762190; cv=none; b=i4bCoXAFfmthrZPU/o14usI/BKhlBTBMIw6IgcxSOw+SW65O1RGF//+ikG+uNOQu9g10Nk3oJK0XJN2beXdnGX+P8plWXPzOVcV4Afo1YAy4h+0r4mHnNBF/yGMTr/QlGU51GHXBKtbzNJytpI75VXZqZaQSBmWRpLMeALqjXO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720762190; c=relaxed/simple;
	bh=+4ATkbznyLoN6zVGMmeZULR4dwuWetvm5a6Tsax0jys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/bqMkfDmG7mPAiXY6FuSahT5Sv849snPmTY9XHZWxHoxxjakQ+Ia48N/po3wWjq93NlPWC9lNquNzpNdFSUSWZ5Yr00icI1Mr7qOekcuWzmRsmynh3Q8mGgbRWHWC3AmtEl01Tlgw7jOnIx9NoFHdbWLAlWiCoC3u6v9JPKy6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qM+QAHHf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qM+QAHHf"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fb67f59805so61195ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 22:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720762188; x=1721366988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8w/Qltj5tvl8rOh7g0NZer1Qe6eHBaJ6/9z2yDe6ws=;
        b=qM+QAHHfoi4mQV7HeYQ3MSYDGWNLE3fukbE8wZHpCvk5B2ro/RSNTDb33JQHCpIjer
         QVgmTMfZa87E8vzqDgLtOpBSJKr1DaCusJk1Rrm2VupMp6Vwa1IpO2u3bOCFrACxvZQE
         YoErhcUI7+1btr3rVT6A6UK5hGFSf6JcoBT9DGp7k4IYMIQ74ifrJAZ42k+OKkvbwBJz
         ZOxBG/F3fYPRqWO5zgAgLbdZS2IkUpGRRPVo04SHqdq8HDF0zM29uG6Q7DHZczP0SLzy
         Bpo70Ym5OE69Hm9Ni8BTxSuukcEshckdf7Fkk3wWVGPTOtIv4d8n1Xln+dNguHlUPesH
         4Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720762188; x=1721366988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8w/Qltj5tvl8rOh7g0NZer1Qe6eHBaJ6/9z2yDe6ws=;
        b=Cav5jMeJJDix7WSIzjfk8xSf/Ya2TujsGIU2OnBMHliQpEU6/gVAbU8qcARS+htM6x
         sKgh7tYENBPx1KfaGWdV7Hnliif38GUIiYpUhO7ptrfhmZR+0208Lq43rC9UkbJnsLif
         AKtLyjZ3l1T07JeJLMLwyEWGqnPlIG5EJeoB9LPd1DJBB4IdA7VZRuNjrddMYnTdC8Lq
         FEb5VSuYPWcSe8nW+e2X4QlyLMkasofMlzgeOUld9MDNeGtF1jQTS+9f+jXzQEMYlFvy
         NhM3VpjHireSzkvKKUJlLIjNlsrf6mi/wQdzPK/YZI1Mvx3U8GWr5x6QFWSUWeRWVPh/
         g35g==
X-Forwarded-Encrypted: i=1; AJvYcCUet3aqWZHFBXi9TYqergXWMexGT5wVJ8lwlS4cu/4bVF7bGdkAtmJ7VOjwzakjzLCaTuH7qofcALRe79AbZd9H/gIP6QwUPOuaM8dgk+rlUA==
X-Gm-Message-State: AOJu0YyUg+WCn68BnhcbiQEupJk0tY612g3bxFukkdBfbPWhL4fKKkXY
	xsG28U1CXIpE5a1kg65UC5NY6VSTPyh7wudoPwlWNnQqsrDyfDVfPMXHvmyrK6a7Xc9pZIQBZSU
	JYB6nKtud37MQkUKOnRMgiqxRjI7dssRxbrKCBjCG1qiwMGRMqRNJ
X-Google-Smtp-Source: AGHT+IGrFWRrdb4V1shoVkI58dazLM5r8JcatX/AJuehwHduu/rIm467kLP8ExLgu+1qjoAnIdnoCECqGxBAUwA/LZk=
X-Received: by 2002:a17:902:f68e:b0:1fb:19fb:a1f0 with SMTP id
 d9443c01a7336-1fbf23201bdmr1802315ad.4.1720762187261; Thu, 11 Jul 2024
 22:29:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704015812.2119457-1-namhyung@kernel.org>
In-Reply-To: <20240704015812.2119457-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Jul 2024 22:29:35 -0700
Message-ID: <CAP-5=fWLhbgUxW4jyKtMy0QuQfBTXUpZHrqRCHgSHgcXQTV3Fg@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Cache debuginfo for data type profiling
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 6:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> In find_data_type(), it creates and deletes a debug info whenver it
> tries to find data type for a sample.  This is inefficient and it most
> likely accesses the same binary again and again.
>
> Let's add a single entry cache the debug info structure for the last DSO.
> Depending on sample data, it usually gives me 2~3x (and sometimes more)
> speed ups.
>
> Note that this will introduce a little difference in the output due to
> the order of checking stack operations.  It used to check the stack ops
> before checking the availability of debug info but I moved it after the
> symbol check.  So it'll report stack operations in DSOs without debug
> info as unknown.  But I think it's ok and better to have the checking
> near the caching logic.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate-data.c | 15 ++-------------
>  tools/perf/util/annotate-data.h |  2 +-
>  tools/perf/util/annotate.c      | 29 +++++++++++++++++++++++++++++
>  tools/perf/util/annotate.h      |  2 ++
>  tools/perf/util/session.c       |  2 ++
>  5 files changed, 36 insertions(+), 14 deletions(-)
>
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index 965da6c0b542..24c03475b3f2 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1764,16 +1764,9 @@ static int find_data_type_die(struct data_loc_info=
 *dloc, Dwarf_Die *type_die)
>   */
>  struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
>  {
> -       struct annotated_data_type *result =3D NULL;
>         struct dso *dso =3D map__dso(dloc->ms->map);
>         Dwarf_Die type_die;
>
> -       dloc->di =3D debuginfo__new(dso__long_name(dso));
> -       if (dloc->di =3D=3D NULL) {
> -               pr_debug_dtp("cannot get the debug info\n");
> -               return NULL;
> -       }
> -
>         /*
>          * The type offset is the same as instruction offset by default.
>          * But when finding a global variable, the offset won't be valid.
> @@ -1783,13 +1776,9 @@ struct annotated_data_type *find_data_type(struct =
data_loc_info *dloc)
>         dloc->fbreg =3D -1;
>
>         if (find_data_type_die(dloc, &type_die) < 0)
> -               goto out;
> -
> -       result =3D dso__findnew_data_type(dso, &type_die);
> +               return NULL;
>
> -out:
> -       debuginfo__delete(dloc->di);
> -       return result;
> +       return dso__findnew_data_type(dso, &type_die);
>  }
>
>  static int alloc_data_type_histograms(struct annotated_data_type *adt, i=
nt nr_entries)
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-d=
ata.h
> index 0a57d9f5ee78..40c9377fa1a5 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -100,9 +100,9 @@ struct data_loc_info {
>         u64 var_addr;
>         u8 cpumode;
>         struct annotated_op_loc *op;
> +       struct debuginfo *di;
>
>         /* These are used internally */
> -       struct debuginfo *di;
>         int fbreg;
>         bool fb_cfa;
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 1451caf25e77..821e4b2c3bcd 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -25,6 +25,7 @@
>  #include "srcline.h"
>  #include "units.h"
>  #include "debug.h"
> +#include "debuginfo.h"
>  #include "annotate.h"
>  #include "annotate-data.h"
>  #include "evsel.h"
> @@ -2313,6 +2314,20 @@ u64 annotate_calc_pcrel(struct map_symbol *ms, u64=
 ip, int offset,
>         return map__rip_2objdump(ms->map, addr);
>  }
>
> +static struct debuginfo_cache {
> +       struct dso *dso;
> +       struct debuginfo *dbg;
> +} di_cache;
> +
> +void debuginfo_cache__delete(void)
> +{
> +       dso__put(di_cache.dso);
> +       di_cache.dso =3D NULL;
> +
> +       debuginfo__delete(di_cache.dbg);
> +       di_cache.dbg =3D NULL;
> +}
> +
>  /**
>   * hist_entry__get_data_type - find data type for given hist entry
>   * @he: hist entry
> @@ -2347,6 +2362,19 @@ struct annotated_data_type *hist_entry__get_data_t=
ype(struct hist_entry *he)
>                 return NULL;
>         }
>
> +       if (map__dso(ms->map) !=3D di_cache.dso) {

Does the di_cache need a mutex? Otherwise another thread may be in
this same code racing with it.

Thanks,
Ian

> +               dso__put(di_cache.dso);
> +               di_cache.dso =3D dso__get(map__dso(ms->map));
> +
> +               debuginfo__delete(di_cache.dbg);
> +               di_cache.dbg =3D debuginfo__new(dso__long_name(di_cache.d=
so));
> +       }
> +
> +       if (di_cache.dbg =3D=3D NULL) {
> +               ann_data_stat.no_dbginfo++;
> +               return NULL;
> +       }
> +
>         /* Make sure it has the disasm of the function */
>         if (symbol__annotate(ms, evsel, &arch) < 0) {
>                 ann_data_stat.no_insn++;
> @@ -2391,6 +2419,7 @@ struct annotated_data_type *hist_entry__get_data_ty=
pe(struct hist_entry *he)
>                         .ip =3D ms->sym->start + dl->al.offset,
>                         .cpumode =3D he->cpumode,
>                         .op =3D op_loc,
> +                       .di =3D di_cache.dbg,
>                 };
>
>                 if (!op_loc->mem_ref && op_loc->segment =3D=3D INSN_SEG_N=
ONE)
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index d5c821c22f79..0686af637ed9 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -540,4 +540,6 @@ struct annotated_basic_block {
>  int annotate_get_basic_blocks(struct symbol *sym, s64 src, s64 dst,
>                               struct list_head *head);
>
> +void debuginfo_cache__delete(void);
> +
>  #endif /* __PERF_ANNOTATE_H */
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 5596bed1b8c8..f9072e003367 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -36,6 +36,7 @@
>  #include "util.h"
>  #include "arch/common.h"
>  #include "units.h"
> +#include "annotate.h"
>  #include <internal/lib.h>
>
>  #ifdef HAVE_ZSTD_SUPPORT
> @@ -304,6 +305,7 @@ void perf_session__delete(struct perf_session *sessio=
n)
>                 return;
>         auxtrace__free(session);
>         auxtrace_index__free(&session->auxtrace_index);
> +       debuginfo_cache__delete();
>         perf_session__destroy_kernel_maps(session);
>         perf_decomp__release_events(session->decomp_data.decomp);
>         perf_env__exit(&session->header.env);
> --
> 2.45.2.803.g4e1b14247a-goog
>
