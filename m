Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986F328FD
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 00:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490824; cv=none; b=HOVfqK48u4zsbHmVofdHqjwc8REfV0pdLZMQnWeqYeRQm8YmCyx2YH0crGVYphXMilCMuPViKKZByStHefIgqAUCOeb0x2+CjispyF404oUho3m9I5ma1ocNd8OwJMJZacfNdZQ/lOzWANhZthFzDhZb9QnWIvyNnsjl2Y29suI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490824; c=relaxed/simple;
	bh=5mNDSlpZBrH6wuBK2WXPGdLMkCQwP5HePfHyJ1mL9K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNFdcT2vQ1SoF1r6PigH2JSGK3eJNsUI3Sq3ucmk4zXUKXgalNRjPO1z/uSbiIeNUR38XFThxTX2SYwpdzYslhI5+hHH9O+J1y+WpeuvyhvbhNTLSJnNoCbBH+u3lQ3onNri0C2OJStk0jNsowi0ZPk1BD05H8KchvefSK+R6Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R95rrCGf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R95rrCGf"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2357c61cda7so39975ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 17:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753490821; x=1754095621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMbKGVVgqKFUYRBdwQ4iJ5mKeO9LhYjMm+hCWr+WlyM=;
        b=R95rrCGfnlujgQ5ON072fSHQwD1VKi8rOjE2bZLj6zJ4/WkEWlLuCtpxHMdxQn48ZB
         F6KxzGHTZziB5Bzq/NXEbKGz3OAMQh37ty61vW1sS25smlWv+C6wMz56TzQjM7ivn8Lw
         BhJ4TG9JK4v1z/O5f1eWKCy8VwUyzizrha1Z6N4yYgoRrJPJKBIq4OPrK/OK/u3ea8id
         cyu0oArEyNwgkbv6ulg7IEBKgm54eY3OBHAxEp2PFg30zhLvGpr8lBNdFrQbQ3bPS2y4
         qV+h6SNsst+wvO0KM/Ria+tUfOW1nhAxikCPlqWZ6rYZtwA3ZgZGauM1dQpA0jDCBKaS
         u9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753490821; x=1754095621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMbKGVVgqKFUYRBdwQ4iJ5mKeO9LhYjMm+hCWr+WlyM=;
        b=E5Wa+zdb1SElhVd9wDhAb1O7f0f9R+uAI1hl94dCrpM7DlXLSFLj+sdDqXCInkpbW3
         bgQ9yzAFAHgZjBm4eWhP3wrc2BM0nTggK9trHu0OiFFHriF584qzq7CZgNhL2WC+fg8Q
         cxvJ1cLoJk9bmI1UqUAV47h3Jl5+c8P9SVbDOIncDi1i2KzX4RM7gkEzO14Au3GT53/C
         NznGr5txf7lbyjQ057pvg+OwHk7QZCVvYI8dCLqtFHmUmdYuB55Oihi/VorpK/MaWpbQ
         I53hJ7L8Ns0usj6KBE1/vChrwKpGZTQ1s8lpxFjzexVw1h+CoJ68sAXs9Y42TffFFOh6
         haBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfy62iFjrJATSLyVoHnC9wf42w9vemDSdRCZfvFxkuZA1dR6fxXNgIEx73TZEliBgwPP9bEmYjtKSz5NDY7u6p@vger.kernel.org
X-Gm-Message-State: AOJu0YxYYW6p8KctH0g2m2b7E22bK45s4PYwpV0o3sGc/j5uGLlw8PRM
	X2Uc+JshPypaG5nHTv3o60mPSobSR25jjVpu4t2BjuqX0OvDXykoGj3/0vlgTSuJioyQ949X2t+
	T4lBDHoyzhOvBJAx6IJ8y0QqB9txUtUO6hM4kRrDY
X-Gm-Gg: ASbGncuFoZdotpQGs60//Fnd57w/WBx2f4ScyHUpQOn+fs7qxBZbssPmOoS9xeGFjKZ
	iy9wPWndc9zyrlCOiEmmmgxJfEKfSBntWM6aNeAuevf2K9NzMJ2eOILj7embaOo2hGkfu4ssYdk
	lr+D4tmQfwSlCt3007OsxKkh0I//6wvudHf4o8CwDMLSzaU/C3nAtskx+N/k1OjtFn4WdMoVOaT
	xA4Fp5g
X-Google-Smtp-Source: AGHT+IGT1Cf+m4uJZZPf6K3czYf+Au3+f4mS9kDC/fQ4UVNBP+2ZENdqZYI6i2oUiHTkPmFZvIs+MVgjmnHCh25DLoY=
X-Received: by 2002:a17:903:4b07:b0:234:a734:4ab9 with SMTP id
 d9443c01a7336-23fbfd0f5f7mr1213245ad.20.1753490820493; Fri, 25 Jul 2025
 17:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725193755.12276-1-namhyung@kernel.org> <20250725193755.12276-10-namhyung@kernel.org>
In-Reply-To: <20250725193755.12276-10-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 17:46:48 -0700
X-Gm-Features: Ac12FXyJ91YeAJqGSfv9w09U-zsgEwNQ_21htrTyXG8HvXsaGupYMbJFpQ-1bGc
Message-ID: <CAP-5=fXj5pcuut9dTVqZfmipTb-sRkZXUwjhJ41rTDNOKDJPQQ@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] perf annotate: Add dso__debuginfo() helper
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
> It'd be great if it can get the correct debug information using DSO
> build-Id not just the path name.  Instead of adding new callsites of
> debuginfo__new(), let's add dso__debuginfo() which can hide the access
> using the pathname and help the future conversion.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

:-) and my prior review comments now make less sense. I think putting
the ui__warning into dso__debugingo makes sense, wdyt?

Thanks,
Ian

> ---
>  tools/perf/ui/browsers/annotate.c |  4 ++--
>  tools/perf/util/annotate.c        |  6 +++---
>  tools/perf/util/dso.h             | 10 ++++++++++
>  3 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index 2a4db5bdcdb7e9d8..54610621c5f910fe 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -1042,7 +1042,7 @@ static int annotate_browser__run(struct annotate_br=
owser *browser,
>                 case 'T':
>                         annotate_opts.code_with_type ^=3D 1;
>                         if (browser->dbg =3D=3D NULL)
> -                               browser->dbg =3D debuginfo__new(dso__long=
_name(map__dso(ms->map)));
> +                               browser->dbg =3D dso__debuginfo(map__dso(=
ms->map));
>                         annotate_browser__show(&browser->b, title, help);
>                         annotate_browser__debuginfo_warning(browser);
>                         continue;
> @@ -1128,7 +1128,7 @@ int __hist_entry__tui_annotate(struct hist_entry *h=
e, struct map_symbol *ms,
>         ui_helpline__push("Press ESC to exit");
>
>         if (annotate_opts.code_with_type)
> -               browser.dbg =3D debuginfo__new(dso__long_name(dso));
> +               browser.dbg =3D dso__debuginfo(dso);
>
>         browser.b.width =3D notes->src->widths.max_line_len;
>         browser.b.nr_entries =3D notes->src->nr_entries;
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 6fc07971631ac8a3..05eb19b110ab7dcf 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1270,7 +1270,7 @@ int hist_entry__annotate_printf(struct hist_entry *=
he, struct evsel *evsel)
>         apd.addr_fmt_width =3D annotated_source__addr_fmt_width(&notes->s=
rc->source,
>                                                               apd.start);
>         evsel__get_arch(evsel, &apd.arch);
> -       apd.dbg =3D debuginfo__new(filename);
> +       apd.dbg =3D dso__debuginfo(dso);
>
>         list_for_each_entry(pos, &notes->src->source, node) {
>                 int err;
> @@ -1375,7 +1375,7 @@ static int symbol__annotate_fprintf2(struct symbol =
*sym, FILE *fp,
>
>         if (annotate_opts.code_with_type) {
>                 evsel__get_arch(apd->evsel, &apd->arch);
> -               apd->dbg =3D debuginfo__new(dso__long_name(map__dso(apd->=
he->ms.map)));
> +               apd->dbg =3D dso__debuginfo(map__dso(apd->he->ms.map));
>         }
>
>         list_for_each_entry(al, &notes->src->source, node) {
> @@ -2888,7 +2888,7 @@ struct annotated_data_type *hist_entry__get_data_ty=
pe(struct hist_entry *he)
>                 di_cache.dso =3D dso__get(map__dso(ms->map));
>
>                 debuginfo__delete(di_cache.dbg);
> -               di_cache.dbg =3D debuginfo__new(dso__long_name(di_cache.d=
so));
> +               di_cache.dbg =3D dso__debuginfo(di_cache.dso);
>         }
>
>         if (di_cache.dbg =3D=3D NULL) {
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 7df1673f08d3ddb4..fd8e95de77f78dfc 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -10,6 +10,7 @@
>  #include <stdio.h>
>  #include <linux/bitops.h>
>  #include "build-id.h"
> +#include "debuginfo.h"
>  #include "mutex.h"
>  #include <internal/rc_check.h>
>
> @@ -914,4 +915,13 @@ u64 dso__findnew_global_type(struct dso *dso, u64 ad=
dr, u64 offset);
>  bool perf_pid_map_tid(const char *dso_name, int *tid);
>  bool is_perf_pid_map_name(const char *dso_name);
>
> +/*
> + * In the future, we may get debuginfo using build-ID (w/o path).
> + * Add this helper is for the smooth conversion.
> + */
> +static inline struct debuginfo *dso__debuginfo(struct dso *dso)
> +{
> +       return debuginfo__new(dso__long_name(dso));
> +}
> +
>  #endif /* __PERF_DSO */
> --
> 2.50.1
>
