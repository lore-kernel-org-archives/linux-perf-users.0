Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B737B20DC3
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jul 2024 03:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721965288; cv=none; b=XVVP9FHwZlHWhZYN7kkuqAkKywO3AlAItSLjoDC3orsEqJynKTnhCCm4YRa4FaGeCRBUW30m1rj/XRABbQRcucdXrg8Cr08wh1ZZvbp7IofUEDhmVaGzoBTWWFu/F2A8G4HQsV7PhxebQ6HKv+7iFfX1LeTsr3px1xyd2E5TRD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721965288; c=relaxed/simple;
	bh=wCS3Hy/e0dLKUiWGy1+j3YEr9DmU8aazVoY75JCORDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Inq+Y1TcvXcfnVW/VazgALaDN/rbGK2asH93OI9zOzDwvKL0EnPVlMOdqBsP4qlpEDLbIGCv6gjxypeEiXQtk3s84tngjz55rqhUwe8ZV/m0iFFCHGj6o/sbH2rPab5J91wWulE4FZbSOzyrhJ5XEjAuzaDpROEpH2VAK+18LzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DDB5bZoQ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDB5bZoQ"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44e534a1fbeso72511cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 20:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721965285; x=1722570085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euKB/T8zKRxrtVe4gbmh5YI7hQsM3NOu+4vovgHj2AU=;
        b=DDB5bZoQMW4OvQewHcNQE0qNfrh/PSOs0nbfe2jwG5JAUTR41NL1YJ+oOyYG7T8y0B
         PiiDDvprs08BYc7QPnkm4YWkgt6U3LAOYLmKwdd9TH2HfpBRXdRL2wkzCZenwf2vcp4V
         Z9Fg7kSq4Ysuis0rXN5KfEGJ+MMk4AvnSdm8b1ipYAyVcXy46nKcfCEw90N/xpcIHU9M
         Z9oNAE1Lwgd7iMgihoITsrALSAVPdUa8tV1utH/0sG1wHjBt2FkyscjAHzUTt6XXztXF
         xetoTscg6dqKBy2BsfpTiM4zbLtdD7a/7txhAQOduCLxmfXZC0FJqT3Ar1PLhire2jiM
         Fz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721965285; x=1722570085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euKB/T8zKRxrtVe4gbmh5YI7hQsM3NOu+4vovgHj2AU=;
        b=IUu79kJGH7SU4UFMLkkieSVulv12NAiapomcXMoYd8Qg1hBtj7PD0qf8nEp+UEzHpf
         euIBhOISpq8jqpDl5/UrB01qdesnlAT4I6OtX+rhuVvXHd9Fe/bgsEV2DjkuV3s5OHcP
         08NL4w0af1KgCX8jY+MA8Ew0WPqC2Mh3wYsxYvk2u8SLoplAOuBeklyqBxrdtjPwg0RF
         w2wUhrE5ZM4BCf7RLAXooQyjhuZmV9rYab30leKn+yG53UG3vf0SXnZDFDbLAQ37nvpc
         CY2792Sq28xepac68B5+mXy1K8WXH0ShU3wm3IG5kLd643pINlPArWujif9NWn3QaDbW
         kFXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1oIgH6OZsxNgUCA5MoxwFIRYcMs58FTGzMFBgdPZ/5OH61/Ytz1nVCmbM7pPj3DV2Fnqy/IXjHcrAlBzyXpjVTNeHEtxnGhkDirVTU/4Y8Q==
X-Gm-Message-State: AOJu0YxGqDG/wTfv1iPQYWa9WjzQmVWF5i7cl8VNOv8NWtntvoysS4TN
	o/31BoWXLSRilVHc4PFcPK+KqCu6PBHCELD+mAzf7sQoE3l4eXT3zxaCgxH7A+25GqsQJQwGAMx
	ZWUZRhcFP58ziPeTdmExxmzgZ6rg0ydQFcAHB
X-Google-Smtp-Source: AGHT+IE0idwatz1SKv1sOPZFsNQVdu62wT0beJFu7EFJFlRThFe6li0Jh/tYwhJ8QoTNI9AUgOpA5KY/UgU4p+rTOAg=
X-Received: by 2002:ac8:7d0a:0:b0:444:ccc5:f4c0 with SMTP id
 d75a77b69052e-44ff3e86da8mr1619811cf.15.1721965285354; Thu, 25 Jul 2024
 20:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726015723.1329937-1-namhyung@kernel.org>
In-Reply-To: <20240726015723.1329937-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 25 Jul 2024 20:41:14 -0700
Message-ID: <CAP-5=fVK3g-8oMoBUAHSR=sufQrU_Xed22Xf0Eu6JGbhDu9e5w@mail.gmail.com>
Subject: Re: [PATCH v2] perf annotate: Cache debuginfo for data type profiling
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 6:57=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
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
> v2) add an assertion for the single-threaded case.
>
>  tools/perf/util/annotate-data.c | 15 ++------------
>  tools/perf/util/annotate-data.h |  2 +-
>  tools/perf/util/annotate.c      | 35 +++++++++++++++++++++++++++++++++
>  tools/perf/util/annotate.h      |  2 ++
>  tools/perf/util/session.c       |  2 ++
>  5 files changed, 42 insertions(+), 14 deletions(-)
>
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index 734acdd8c4b7..f125ac5f0bda 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1345,16 +1345,9 @@ static int find_data_type_die(struct data_loc_info=
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
> @@ -1364,13 +1357,9 @@ struct annotated_data_type *find_data_type(struct =
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
> index 992b7ce4bd11..37a1a3b68e0b 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -123,9 +123,9 @@ struct data_loc_info {
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
> index a2ee4074f768..2ef119539336 100644
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
> @@ -2326,6 +2327,20 @@ u64 annotate_calc_pcrel(struct map_symbol *ms, u64=
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
> @@ -2360,6 +2375,25 @@ struct annotated_data_type *hist_entry__get_data_t=
ype(struct hist_entry *he)
>                 return NULL;
>         }
>
> +       /*
> +        * It needs to protect di_cache as well as data_types and global_=
vars in
> +        * DSO when enabling multi-threading.

Perhaps:

/*
 * di_cache holds a pair of values, but code below assumes
di_cache.dso can be compared/updated and di_cache.dbg can be
read/updated independently from each other. That assumption only holds
in single threaded code.
 */

Thanks,
Ian

> +        */
> +       assert(perf_singlethreaded);
> +
> +       if (map__dso(ms->map) !=3D di_cache.dso) {
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
> @@ -2404,6 +2438,7 @@ struct annotated_data_type *hist_entry__get_data_ty=
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
> index 9ba772f46270..27d9540604ef 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -543,4 +543,6 @@ struct annotated_basic_block {
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
> 2.46.0.rc1.232.g9752f9e123-goog
>
