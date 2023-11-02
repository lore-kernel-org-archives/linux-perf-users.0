Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CAF1CF8C
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 22:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JHaMZxzz"
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF49192
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 15:59:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so2345a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 15:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698965959; x=1699570759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP31fLX+pxaO5hDZO6DHoxgvhUAHCcHqxZGWN/MwNfQ=;
        b=JHaMZxzzpF1Cn1yV/IA/F6iFUVhaXwA2p/OVH7ugye6yb3i9Ari5JBkjeNPBPfO5cT
         Fh2qxB8sJjjHk42A+Kg1i+UoTGzywh4EM3x+r0JuYXg3BjaFWjinvVx8b3AT7vQWPoTP
         m2p3YJsaHX2wIAoLRuCwMtO6NHiARKlQCxcMwg8HtchLMFKlMLs7FMeMPdmHQUTB2J+/
         Ju0mZMhlbCWxyK3CqQEh4F7Vvfqj5a4oMNFuzxmL0EkcztD7J+pX1qBiTgRq7iLGBINE
         zie4hc6FIqClCPcGnwc35sEO98Qq0l5sIU4OzAtQ6UH9uB1VXywl+1vwSMlJ6dCWr5MA
         UjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698965959; x=1699570759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QP31fLX+pxaO5hDZO6DHoxgvhUAHCcHqxZGWN/MwNfQ=;
        b=RTMhJiEvpOoK8WTsh+3BIyomBCeKFKEzeAhasF6JDtzU9oFIM+fDmXjtXgUHl1LTrn
         YyAjBq6eR4UFHxfRytSNUCMaTVhvzzVuUgcOOlprVJEkzYmhQG8u4yqxAZcaSD/6+H+W
         mJva+rHBIKelmDtZQqc0sZrkmJZWa8GtPTChmVK77fkMv4+4FJoA7OU0yc/hb7D/BdVd
         4k0cTBhCbreePGIOZuGZzt+CXcr6j7XXr2I0l3mlRCukYY2D3/V9hN8TI3chC1J4Aw0w
         qU0UVSEeAYsdmBORMhpeawAVU2GynLG6yVQFXAm1LDBNgZh5n+Z35mYp5qafe1l03nYp
         aERQ==
X-Gm-Message-State: AOJu0YwCR2yo+Q5IIib09uVEZq9pqHZjeOux0tv5woSXK+4r50E1U91w
	64bPTBJ5IjcqRDqCCAh4BChiftLxIlMzLLi55KtEcA==
X-Google-Smtp-Source: AGHT+IER/U62zMtD0dfjlB8xVUMWLzaEfk+FVmtEYeeOf4e2H7qaz0cqMSQAHaoKrBNn0fyQr4PgrJoZLliy0h0JKx0=
X-Received: by 2002:a05:6402:501c:b0:543:fa43:a361 with SMTP id
 p28-20020a056402501c00b00543fa43a361mr146040eda.1.1698965959359; Thu, 02 Nov
 2023 15:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102222653.4165959-1-namhyung@kernel.org> <20231102222653.4165959-4-namhyung@kernel.org>
In-Reply-To: <20231102222653.4165959-4-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 Nov 2023 15:59:07 -0700
Message-ID: <CAP-5=fVWKrSN+c5gc9KwKjP-_tXDi1RaFhEvbD9aP20qMJiHJg@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf annotate: Move max_coverage to annotated_branch
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 3:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> The max_coverage is only used when branch stack info is available so
> it'd be natural to move to the annotated_branch.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-annotate.c | 7 +++++--
>  tools/perf/util/annotate.c    | 2 +-
>  tools/perf/util/annotate.h    | 4 +++-
>  tools/perf/util/block-range.c | 7 ++++++-
>  4 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.=
c
> index aeeb801f1ed7..a9129b51d511 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -94,6 +94,7 @@ static void process_basic_block(struct addr_map_symbol =
*start,
>         struct annotation *notes =3D sym ? symbol__annotation(sym) : NULL=
;
>         struct block_range_iter iter;
>         struct block_range *entry;
> +       struct annotated_branch *branch;
>
>         /*
>          * Sanity; NULL isn't executable and the CPU cannot execute backw=
ards
> @@ -105,6 +106,8 @@ static void process_basic_block(struct addr_map_symbo=
l *start,
>         if (!block_range_iter__valid(&iter))
>                 return;
>
> +       branch =3D annotation__get_branch(notes);
> +
>         /*
>          * First block in range is a branch target.
>          */
> @@ -118,8 +121,8 @@ static void process_basic_block(struct addr_map_symbo=
l *start,
>                 entry->coverage++;
>                 entry->sym =3D sym;
>
> -               if (notes)
> -                       notes->max_coverage =3D max(notes->max_coverage, =
entry->coverage);
> +               if (branch)
> +                       branch->max_coverage =3D max(branch->max_coverage=
, entry->coverage);
>
>         } while (block_range_iter__next(&iter));
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 2fa1ce3a0858..92a9adf9d5eb 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -946,7 +946,7 @@ static int __symbol__inc_addr_samples(struct map_symb=
ol *ms,
>         return 0;
>  }
>
> -static struct annotated_branch *annotation__get_branch(struct annotation=
 *notes)
> +struct annotated_branch *annotation__get_branch(struct annotation *notes=
)
>  {
>         if (notes =3D=3D NULL)
>                 return NULL;
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 9c199629305d..d8a221591926 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -280,10 +280,10 @@ struct annotated_branch {
>         unsigned int            total_insn;
>         unsigned int            cover_insn;
>         struct cyc_hist         *cycles_hist;
> +       u64                     max_coverage;
>  };
>
>  struct LOCKABLE annotation {
> -       u64                     max_coverage;
>         u64                     start;
>         struct annotation_options *options;
>         struct annotation_line  **offsets;
> @@ -356,6 +356,8 @@ static inline struct annotation *symbol__annotation(s=
truct symbol *sym)
>  int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct per=
f_sample *sample,
>                                  struct evsel *evsel);
>
> +struct annotated_branch *annotation__get_branch(struct annotation *notes=
);
> +
>  int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
>                                     struct addr_map_symbol *start,
>                                     unsigned cycles);
> diff --git a/tools/perf/util/block-range.c b/tools/perf/util/block-range.=
c
> index 680e92774d0c..15c42196c24c 100644
> --- a/tools/perf/util/block-range.c
> +++ b/tools/perf/util/block-range.c
> @@ -311,6 +311,7 @@ struct block_range_iter block_range__create(u64 start=
, u64 end)
>  double block_range__coverage(struct block_range *br)
>  {
>         struct symbol *sym;
> +       struct annotated_branch *branch;
>
>         if (!br) {
>                 if (block_ranges.blocks)
> @@ -323,5 +324,9 @@ double block_range__coverage(struct block_range *br)
>         if (!sym)
>                 return -1;
>
> -       return (double)br->coverage / symbol__annotation(sym)->max_covera=
ge;
> +       branch =3D symbol__annotation(sym)->branch;
> +       if (!branch)
> +               return -1;
> +
> +       return (double)br->coverage / branch->max_coverage;
>  }
> --
> 2.42.0.869.gea05f2083d-goog
>
