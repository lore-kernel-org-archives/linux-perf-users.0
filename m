Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7127510F
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Jul 2025 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678051; cv=none; b=VCWOeMIhe8wdqlhBJXsYMnbwcI9bZ3t/nBfEtvFghR+35WQj9qyaFKsBcA2hJA26l7DJfSWz3S9N2JoGuMvOmEjBut824QAY4VCAi985QvgfXU3sjfza71MkKgxHkppwfPTJ7834eaXwglPy8KHU6sqy9b1wp2XIFq+bvT99X9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678051; c=relaxed/simple;
	bh=11Ig6mxkemwXJvajZpoajVsAjklxO9Nn5kMOT9dHzRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leO9JcceOiFFMuA2JYXiV5t1Yg8ffmCr60qpLCc//j2p75KWfA2BNs6dSA9ZBFICQ7pu8OM6qLPZfuP9mmYQVv1cliKU68X0g1XXrkdyRpe5L/Ra9rq8CDSo2HYoQpMCL1KudyrHr1ZZMHxqLqgAUJSs1HAEqFN0rfF89NQTako=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pOyiYnlG; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pOyiYnlG"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so255305ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Jul 2025 08:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752678049; x=1753282849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2w8n4snflAfdRSl3UlImmyhdZsh30DeZ7gVcfxLn4k=;
        b=pOyiYnlGyfjXiA4FmZhVOci30uxo8tFP/oRhIcqNTwM+uzAVs15ieUfVwhv71fPJdl
         JfOdVQ57QHZF0lUCMFGyggZb0rSHE15ZVjb1gosIoZd0XqavYel3r+o7/zKXdmNkVon/
         fJ+bYII7nJkjKcchi02F8nbJuSFZ3ITZg/CmsJRyprxyHfUbQxrnTG8+yklGA7lXfUM1
         OQ1Pv3c11YFq/mEyU+shWM6VqdP+5Zzm93Jf3UFzp4jbfSeXua3BAA+h6Gb/8yH9+LI5
         SBOskbiEa7kmrBi5ILd8F8vaKcfoDBy1a2Z98v36u1OIofoekbXRFC2C0uK3CaFRjAc3
         AS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678049; x=1753282849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2w8n4snflAfdRSl3UlImmyhdZsh30DeZ7gVcfxLn4k=;
        b=hsjlt7mCgWY8s+2wJYTA1hRg9Q2UaeXDEovZMFs8naY3tAEFjjneI7GFDgeLdOp9f2
         8r7Mlbi+Ef0dZFVXqc3n7rkMuDVHBQp1LS53fhdwN4ujmF7HX5a/IgGfaof7wjPQzkBi
         6035Nv9El8L3jcLTwOvE7apoHUD35ERbOCDU3LX6c8Ohua9fq2lPNnY9RBVYX4zgEYv1
         eIsGyj5SR9gYj9llRi4XPBNDaIO4uXlEbjZUK3jhBpLJ00OaOobBnL97l4ekfPYoR+zF
         NnRV66d87okKJB6ICRNKpUVWhCi5df1v6MWLHIZuzTlsTucNy94vh0r16x2d3VcDLWvA
         4AuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQh/tsO8oNf1cwN275/vAHzcB0SKGNYTDd7KyOfs/jENTQjrH7RbPK23c9AfXg9bNKrjxzja1rcqZ1vIAUiEUB@vger.kernel.org
X-Gm-Message-State: AOJu0YwcQXKTbRELzXsz+4Vk82168m9GrW01AyNvy2fK0X8FRwh11sC0
	WLEIeaizyhQyvTSWxmP02KEwRLw+ASjgdTYo7J3KBVXUCWB+uLC2t+SHyKqvcqbXYmOhwVaoQeO
	nobhV+uY4B7wHOvnIm86q7MxRfUnYNwHAUskKqsW7
X-Gm-Gg: ASbGncv01ziZPZyLrm5tVn7ytWLxovf7ga2Ovnu/GepWFCqaByFKl2KwbXzB72aMOsP
	cTuw5hXQBrPAIsCjs8EEeGThfQg7o3jjAB68k+59GLPGsFA5yi3qync0pHKpSt7BsbMcqijKSA2
	PgQ+3peo/TsevN5VlSUQkKNwnmF307z8m3uI4RcCFhO96Hly3/LykZ4tbVnmZnlYXnW3F/Yx/Gd
	iV4ZdIr8d904Op+A4HcCbPIqnDDAUM/Gg==
X-Google-Smtp-Source: AGHT+IEtQbaRAFocztugfBzfRKGbl08trVCdekhMQzmOSHCwgabOwedkIMhaAT9m198O4ryAz4A1Rtb9HN+aD8Cqnro=
X-Received: by 2002:a05:6e02:19c8:b0:3dd:a4b7:c737 with SMTP id
 e9e14a558f8ab-3e284e834f3mr3288195ab.19.1752678048456; Wed, 16 Jul 2025
 08:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716050054.14130-1-namhyung@kernel.org> <20250716050054.14130-6-namhyung@kernel.org>
In-Reply-To: <20250716050054.14130-6-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Jul 2025 08:00:37 -0700
X-Gm-Features: Ac12FXyOxQMK8duAS431cvISCXCiSNJr30kThD5TyXwc2XcWWupvMnzlZBck8i0
Message-ID: <CAP-5=fVAYNy9pk9zyQRySrJ-1j12dC9ogiW94133Li_WQHd6RA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] perf annotate: Add --code-with-type support for TUI
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 10:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Until now, the --code-with-type option is available only on stdio.
> But it was an artifical limitation because of an implemention issue.
>
> Implement the same logic in annotation_line__write() for stdio2/TUI.
> Make disasm_line__write() return the number of printed characters so
> that it can skip unnecessary operations when the screen is full.
>
> Remove the limitation and update the man page.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-annotate.txt |  1 -
>  tools/perf/builtin-annotate.c              |  5 --
>  tools/perf/ui/browsers/annotate.c          |  6 +++
>  tools/perf/util/annotate.c                 | 61 +++++++++++++++++++---
>  4 files changed, 61 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Docu=
mentation/perf-annotate.txt
> index 46090c5b42b4762f..547f1a2680185e3c 100644
> --- a/tools/perf/Documentation/perf-annotate.txt
> +++ b/tools/perf/Documentation/perf-annotate.txt
> @@ -170,7 +170,6 @@ include::itrace.txt[]
>
>  --code-with-type::
>         Show data type info in code annotation (for memory instructions o=
nly).
> -       Currently it only works with --stdio option.
>
>
>  SEE ALSO
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.=
c
> index 9833c2c82a2fee46..6debd725392db4a4 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -917,11 +917,6 @@ int cmd_annotate(int argc, const char **argv)
>                 symbol_conf.annotate_data_sample =3D true;
>         } else if (annotate_opts.code_with_type) {
>                 symbol_conf.annotate_data_member =3D true;
> -
> -               if (!annotate.use_stdio) {
> -                       pr_err("--code-with-type only works with --stdio.=
\n");
> -                       goto out_delete;
> -               }
>         }
>
>         setup_browser(true);
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index 23bea5b165774ae7..cdee1969f3131a7c 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -4,6 +4,7 @@
>  #include "../ui.h"
>  #include "../../util/annotate.h"
>  #include "../../util/debug.h"
> +#include "../../util/debuginfo.h"
>  #include "../../util/dso.h"
>  #include "../../util/hist.h"
>  #include "../../util/sort.h"
> @@ -1101,6 +1102,9 @@ int __hist_entry__tui_annotate(struct hist_entry *h=
e, struct map_symbol *ms,
>
>         ui_helpline__push("Press ESC to exit");
>
> +       if (annotate_opts.code_with_type)
> +               browser.dbg =3D debuginfo__new(dso__long_name(dso));
> +
>         browser.b.width =3D notes->src->widths.max_line_len;
>         browser.b.nr_entries =3D notes->src->nr_entries;
>         browser.b.entries =3D &notes->src->source;
> @@ -1111,6 +1115,8 @@ int __hist_entry__tui_annotate(struct hist_entry *h=
e, struct map_symbol *ms,
>
>         ret =3D annotate_browser__run(&browser, evsel, hbt);
>
> +       if (annotate_opts.code_with_type)
> +               debuginfo__delete(browser.dbg);
>         if (not_annotated && !notes->src->tried_source)
>                 annotated_source__purge(notes->src);
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index d69e406c1bc289cd..06ddc7a9f58722a4 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1362,6 +1362,11 @@ static int symbol__annotate_fprintf2(struct symbol=
 *sym, FILE *fp,
>         };
>         struct annotation_line *al;
>
> +       if (annotate_opts.code_with_type) {
> +               evsel__get_arch(apd->evsel, &apd->arch);
> +               apd->dbg =3D debuginfo__new(dso__long_name(map__dso(apd->=
he->ms.map)));

This API looks unfortunate. A dso may have a long name (it'd be easier
to understand if this were called path rather than long name) or a
build ID. The API isn't the fault of this change, but I thought I'd
mention as we move toward greater use of build IDs.

Thanks,
Ian

> +       }
> +
>         list_for_each_entry(al, &notes->src->source, node) {
>                 if (annotation_line__filter(al))
>                         continue;
> @@ -1370,6 +1375,9 @@ static int symbol__annotate_fprintf2(struct symbol =
*sym, FILE *fp,
>                 wops.first_line =3D false;
>         }
>
> +       if (annotate_opts.code_with_type)
> +               debuginfo__delete(apd->dbg);
> +
>         return 0;
>  }
>
> @@ -1743,7 +1751,7 @@ static double annotation_line__max_percent(struct a=
nnotation_line *al,
>         return percent_max;
>  }
>
> -static void disasm_line__write(struct disasm_line *dl, struct annotation=
 *notes,
> +static int disasm_line__write(struct disasm_line *dl, struct annotation =
*notes,
>                                void *obj, char *bf, size_t size,
>                                void (*obj__printf)(void *obj, const char =
*fmt, ...),
>                                void (*obj__write_graph)(void *obj, int gr=
aph))
> @@ -1771,8 +1779,8 @@ static void disasm_line__write(struct disasm_line *=
dl, struct annotation *notes,
>                 obj__printf(obj, "  ");
>         }
>
> -       disasm_line__scnprintf(dl, bf, size, !annotate_opts.use_offset,
> -                              notes->src->widths.max_ins_name);
> +       return disasm_line__scnprintf(dl, bf, size, !annotate_opts.use_of=
fset,
> +                                     notes->src->widths.max_ins_name);
>  }
>
>  static void ipc_coverage_string(char *bf, int size, struct annotation *n=
otes)
> @@ -2116,11 +2124,52 @@ void annotation_line__write(struct annotation_lin=
e *al, struct annotation *notes
>
>                 width -=3D printed + 3;
>
> -               disasm_line__write(disasm_line(al), notes, obj, bf, sizeo=
f(bf), obj__printf, obj__write_graph);
> +               printed =3D disasm_line__write(disasm_line(al), notes, ob=
j, bf, sizeof(bf),
> +                                            obj__printf, obj__write_grap=
h);
> +
> +               obj__printf(obj, "%s", bf);
> +               width -=3D printed;
> +
> +               if (annotate_opts.code_with_type && apd->dbg) {
> +                       struct annotated_data_type *data_type;
> +                       int offset =3D 0;
> +
> +                       data_type =3D __hist_entry__get_data_type(apd->he=
, apd->arch,
> +                                                               apd->dbg,
> +                                                               disasm_li=
ne(al),
> +                                                               &offset);
> +                       if (data_type && data_type !=3D NO_TYPE) {
> +                               char member[256];
> +
> +                               printed =3D scnprintf(bf, sizeof(bf),
> +                                                   "\t\t# data-type: %s"=
,
> +                                                   data_type->self.type_=
name);
>
> -               obj__printf(obj, "%-*s", width, bf);
> +                               if (data_type !=3D &stackop_type &&
> +                                   data_type !=3D &canary_type &&
> +                                   sizeof(bf) > (size_t)printed) {
> +                                       printed +=3D scnprintf(bf + print=
ed,
> +                                                            sizeof(bf) -=
 printed,
> +                                                            " +%#x", off=
set);
> +                               }
> +
> +                               if (annotated_data_type__get_member_name(=
data_type,
> +                                                                        =
member,
> +                                                                        =
sizeof(member),
> +                                                                        =
offset) &&
> +                                   sizeof(bf) > (size_t)printed) {
> +                                       printed +=3D scnprintf(bf + print=
ed,
> +                                                            sizeof(bf) -=
 printed,
> +                                                            " (%s)", mem=
ber);
> +                               }
>
> -               (void)apd;
> +                               obj__printf(obj, "%-*s", width, bf);
> +                       } else {
> +                               obj__printf(obj, "%-*s", width, " ");
> +                       }
> +               } else {
> +                       obj__printf(obj, "%-*s", width, " ");
> +               }
>         }
>
>  }
> --
> 2.50.0
>
