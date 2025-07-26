Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1501D554
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 00:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489243; cv=none; b=t7rzxMEPbSWRQ5E9xCgRM/IWgx2bfucpnA1okFLtZ5R0T1PnyIbEeUW1/HSW/xGyJcXwheycAxAebpRiunZScK21LL+q+RcDJM/tcI5Q9xy3fUYZiClVdjj+XvFTSZP6uyI1AIsGYHOzxEP/XRf2jm0470CS6Q7GP3FMNwIl5Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489243; c=relaxed/simple;
	bh=8mdAn7esO9kgqKIiFyEk+vavxHnQvbLI+rw7Io7jEx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhWv6bNlszdJtz9v7AitPTgOBtu6mYQWC51+eAzva/D+g0Xo+cdwSKBjsnVfUSU7i9Q29VsNGD9ypka/zFiEAGUfYlJrHsziocJusaV8xsOL1W0QTdSMnS5UeBgeVJAfybmdiBKil6XLr7/X5QrMpM/eJt5j3uAgmD9I9+WdPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4xCcYo/b; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4xCcYo/b"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so40475ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 17:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753489241; x=1754094041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0ThNftGLRJi4dVC0GeekYa0MUDCrH2SS/ObhJguIgY=;
        b=4xCcYo/bNqEJLg982dn9L1MivK2qvseADXjIwD4K/piURy18M7SK660xjUVjHEJqmc
         5FkECOHmTdKnqDCA26zsY8Gf9las/u0HG7gwvwys8PtHU2m7HuTNb1RextbaAEYQiWYo
         DuoeG/KaLYQHM4ZFJROLTsKjOdkIa9I4y9DSLhElb7zbjNkLUYFv4966+YqhaNSoLj7j
         Sn7moGvGgNyUfBgK41eJ6tVmAuWYzM4MHySLU+7HYdb8ExZ9XwhSuFZCeMSsP/iuRIH6
         WCYkVeIXU4CvBEdZe88qp2BdfB2jij/6yymSl3mhu6FmUkVbjNCJUznCwj0TyvlUwDbi
         VKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753489241; x=1754094041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0ThNftGLRJi4dVC0GeekYa0MUDCrH2SS/ObhJguIgY=;
        b=WwlEl7lZPb9ivl24ylncOLmQLZNjR0gHpnkn1C/FL6LFHb6wNjFa+g/5jqO3pg5kK6
         nOKhPMUwz9JjaC52FvavU5YKMwUNw10zE8DrJ6wL4ljP5bEg05w1kzT/FXw58+YxQTWc
         bpln50BYY1jVpzGFFnDwebmSwPH+rhIwWj6USINgkBXgWncSWqKO1INSHwU1Nn5AVpoN
         et/sm2zviBMdHnlstO2iLk5CUb6Ees4pRCimS2SMri4NluWxPVy58aJ3HS/LM6U4ftHB
         hUK4edKoCXK05fwnehmB8EYnDOosp4rJ9lN8JNd/W7a4hdYsOMuFWHhgMZVUQoY2wAvF
         UfeA==
X-Forwarded-Encrypted: i=1; AJvYcCWWbbh0U3wMTocDL34b/QBFCFGZLyTZMr5FBMYIaloylXGRipwqrkS0PJsjhMXGVwkh3vEV+gPjSWaPDhCAtXlI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6+KVdOpCvSm5WdRjBmeYGbr4EwD9jZEo41DSTAqahR87x89Ad
	NhOzK/r+2hLL9jdiLZ9dWWR1sZfWF79g1ZWqSFEz5a4Ais+ztYF6gXqAFpnbB11tVcYRntmz3yK
	8cdD96LlIVys3r0jphJVEnIW5U9DYRImlgyB7iLot
X-Gm-Gg: ASbGncuRwZErJ/dekVd5NEyAN8optI/veD0z8I1XMt7CJHZEBMzV3o1t2uOdLeWe/wP
	3dbEPWDs2h7qhIuRRngb9rH4mBk4+vzjqoX8fFNMqJ09DiZBTjieP3liU2oxUfoiMoJ0Axci31o
	/JVrCZtKTnmmoG+HKfUaDPc2ZCCa1rryDxbWGYU7YYmw9zCXn9LJQEG1N04Dotu25dRXdgRbCtv
	nMBHGNmHDaq74AQnBo=
X-Google-Smtp-Source: AGHT+IHdpZ34wkix9hte7Ol6Inljd+wADLNhCfB/bH4AezN3sfG8aMhxvDuIUDmStPHbyz+Tc8HpKgxZdAG5Nl7VXWQ=
X-Received: by 2002:a05:6e02:1905:b0:3df:2dd7:19c6 with SMTP id
 e9e14a558f8ab-3e3cbe72ee9mr1555095ab.0.1753489241102; Fri, 25 Jul 2025
 17:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725193755.12276-1-namhyung@kernel.org> <20250725193755.12276-3-namhyung@kernel.org>
In-Reply-To: <20250725193755.12276-3-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 17:20:28 -0700
X-Gm-Features: Ac12FXxJZD15GJiKtCSr4iS1J72SBJiIFe8b2YuxjHx1OWQlPxBRQuaLxIE1nHU
Message-ID: <CAP-5=fVG6q37_tVvFo12OCiiE4zu0fqkf_3Z1rmoanVLXR7DOA@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] perf annotate: Remove __annotation_line__write()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 12:38=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Get rid of the internal function and convert function arguments into
> local variables if they are used more than once.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate.c | 46 ++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 0dd475a744b6dfac..69ee83052396b15e 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1935,24 +1935,26 @@ int annotation_br_cntr_entry(char **str, int br_c=
ntr_nr,
>         return -ENOMEM;
>  }
>
> -static void __annotation_line__write(struct annotation_line *al, struct =
annotation *notes,
> -                                    bool first_line, bool current_entry,=
 bool change_color, int width,
> -                                    void *obj, unsigned int percent_type=
,
> -                                    int  (*obj__set_color)(void *obj, in=
t color),
> -                                    void (*obj__set_percent_color)(void =
*obj, double percent, bool current),
> -                                    int  (*obj__set_jumps_percent_color)=
(void *obj, int nr, bool current),
> -                                    void (*obj__printf)(void *obj, const=
 char *fmt, ...),
> -                                    void (*obj__write_graph)(void *obj, =
int graph))
> -
> -{
> -       double percent_max =3D annotation_line__max_percent(al, percent_t=
ype);
> -       int pcnt_width =3D annotation__pcnt_width(notes),
> -           cycles_width =3D annotation__cycles_width(notes);
> +void annotation_line__write(struct annotation_line *al, struct annotatio=
n *notes,
> +                           struct annotation_write_ops *wops)

nit: constify wops? If its const are the local variables worth it?

Thanks,
Ian

> +{
> +       bool current_entry =3D wops->current_entry;
> +       bool change_color =3D wops->change_color;
> +       double percent_max =3D annotation_line__max_percent(al, annotate_=
opts.percent_type);
> +       int width =3D wops->width;
> +       int pcnt_width =3D annotation__pcnt_width(notes);
> +       int cycles_width =3D annotation__cycles_width(notes);
>         bool show_title =3D false;
>         char bf[256];
>         int printed;
> -
> -       if (first_line && (al->offset =3D=3D -1 || percent_max =3D=3D 0.0=
)) {
> +       void *obj =3D wops->obj;
> +       int  (*obj__set_color)(void *obj, int color) =3D wops->set_color;
> +       void (*obj__set_percent_color)(void *obj, double percent, bool cu=
rrent) =3D wops->set_percent_color;
> +       int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool curr=
ent) =3D wops->set_jumps_percent_color;
> +       void (*obj__printf)(void *obj, const char *fmt, ...) =3D wops->pr=
intf;
> +       void (*obj__write_graph)(void *obj, int graph) =3D wops->write_gr=
aph;
> +
> +       if (wops->first_line && (al->offset =3D=3D -1 || percent_max =3D=
=3D 0.0)) {
>                 if (notes->branch && al->cycles) {
>                         if (al->cycles->ipc =3D=3D 0.0 && al->cycles->avg=
 =3D=3D 0)
>                                 show_title =3D true;
> @@ -1966,7 +1968,8 @@ static void __annotation_line__write(struct annotat=
ion_line *al, struct annotati
>                 for (i =3D 0; i < al->data_nr; i++) {
>                         double percent;
>
> -                       percent =3D annotation_data__percent(&al->data[i]=
, percent_type);
> +                       percent =3D annotation_data__percent(&al->data[i]=
,
> +                                                          annotate_opts.=
percent_type);
>
>                         obj__set_percent_color(obj, percent, current_entr=
y);
>                         if (symbol_conf.show_total_period) {
> @@ -2115,17 +2118,6 @@ static void __annotation_line__write(struct annota=
tion_line *al, struct annotati
>
>  }
>
> -void annotation_line__write(struct annotation_line *al, struct annotatio=
n *notes,
> -                           struct annotation_write_ops *wops)
> -{
> -       __annotation_line__write(al, notes, wops->first_line, wops->curre=
nt_entry,
> -                                wops->change_color, wops->width, wops->o=
bj,
> -                                annotate_opts.percent_type,
> -                                wops->set_color, wops->set_percent_color=
,
> -                                wops->set_jumps_percent_color, wops->pri=
ntf,
> -                                wops->write_graph);
> -}
> -
>  int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
>                       struct arch **parch)
>  {
> --
> 2.50.1
>
