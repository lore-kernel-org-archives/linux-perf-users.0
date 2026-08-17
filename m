Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C236E471275
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001157; cv=pass; b=XsgEZOm1lnQ13a1Y7RajQ7ScpyeFH48qwk7uNqWsMLlgv1GNaZxXSXcxT5gVYVUlDMmmd7J5ryNlQT1cIA1dsdIPe9MhLfy2bEWa3ReQVww7Vkz9ZvK/IDj1fg8b4RRE7tEqghdAHy8dirC7R6VkaTnjXw0Qrbrsz1ZgfIRKMtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001157; c=relaxed/simple;
	bh=sXpBGdT0p83aBMkg+tNWwgnMbfSbOAmD/4xInzqia+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVkAqootsMaiwlsPQvff92oaTulfyiqyDXm1Kig+kYaDUqpP00L0UArRXDH4pIzT9qK+ajL+m7saHVGRurew8tUHy0DD9DlIv75l79kmZgZSUGb4+QT6+yfg438UEpOvNd4lLpfsQiwegS1p0xXGHQphs7XwiWXWJsVA99KxYIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jcg0Yhan; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jcg0Yhan"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c15a5b265so83771cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 14:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787001154; cv=none;
        d=google.com; s=arc-20260327;
        b=VWGDwx5gmdGPOwwSrM0snntd2d6whkHZeYMq93bGdcVlYAZ+LslrObnGYTNc0NsDoC
         Voyo1P85zLdpdDOcdcuTQum+V8vJdrMVrnbnDU5Tuczuur4MIgn4DVLYz1VYiWO6RQhV
         FBop3nEDlgLYkeIbfPIlfSje3X3pFT3fPYewokD3Cbr3SH1y8xH8oNtQN6GOrExlBiLO
         vijY7jizUq9JlWAc5T6rG1ppJqWre64I9v9ccqba9FZnmPwva6iBmTlzyPBBXs+Qvczq
         deJ4QPtoLnwf9VjsZhyRLO/pvbMppqjCzONlE+/X2iWkgJDpkTnJl4CQ9JVFc3pqRr+3
         2afA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LJWd8P8iAp7WLCkxuG+UM+YKshP/IYPVvqu1VnUEJZo=;
        fh=CUXGX6a44i5kG/4QtZaV1oeQVLWz9mk2wldP+toL7Gk=;
        b=PNqPQnRBeGrN/pZbHOp4c3mtVAkuzdZfLs6WrrdTl8KkLgNzp6Tw4j6qOJsGHflOCo
         3Xve3q8bP4QWXIysRZ8SE5KtdHMmqZiGjqV+vVZdbcMbIv91rLLFqcrJiqdCRe3/UBz8
         72MFD6kloDT/kcQpxV5oPz7HeOHPIP0kz1NF8xiO+IkCdH/Rb7di+Pu2wdlGQLos5Ptc
         N/95AdfyfTs4Iy8XRhLloYVdXgfQJRP7uH97L2SV8xi711JOIL+aZJF3w6hwQ12oDgiB
         s5UJg2+XRuGJoxIBJP5SyEuV1tWiv+6RjRD3w2XWz8bqeLxa8Ak5ULKXV4Xb8FB7HvDB
         DW3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787001154; x=1787605954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LJWd8P8iAp7WLCkxuG+UM+YKshP/IYPVvqu1VnUEJZo=;
        b=jcg0YhanKFJmgqew5gE+gSLAwUGa/KO3YYpJsiBeu1NxxMf2bkjrjxt9CTpl9Eb1Pe
         AQyExPWKnaCJoS77E/D2bH8FKyrSSE7Q9fRqDnV1i2n55E9PlMU5lC7oN+FgsCI8nf4F
         zu4VkmrEOMOv2KvdPbBNGxz+24m5JU6J52KL0qohkveUFHJVYxnAvHobaUm7KOw/jRIs
         fWXNcJ+vGiUt470xGblBSzdAJKerZ2R6KDx3CxylSisKinGQxh/yAQedwQrsbgCZzFvu
         FWCM408mfF/WBMfw/hdEB6XmWfvEC3oRHpyMLaEUCtZDxSYr+EyhLxa/+fk6ZZhavCVE
         XQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001154; x=1787605954;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LJWd8P8iAp7WLCkxuG+UM+YKshP/IYPVvqu1VnUEJZo=;
        b=rsIYCeFFLtgzc1qONDGfq8d/1g4VpJrL7NFcZGOBF8/gnfRuuatt58gCv00DiS/nWw
         ZZnBZtDqXGa3olq/Ksr0kCvFym4vaKYvFtri01tqlwJiEGSexYF8403srgp+8y5SsnEi
         5bE6YwnjoPD1fttyE8WoSRVHsJHeIQzGE/NnGR3eIG0fJ1mitkhvO/RVUNd0srgRLOwJ
         OIcLpfOwoUNc9fy/3DBlgsBEm7rr5MLOAq/RjwDI8c8s1l1UGQ+UCjAOMcEXYaCCmpr0
         y1+WH9Z+V1z9luHtxDrpTIawpGMp73zCx8wUOxyft0xxLQM2MJV2hreE0+ZaCLaRRF8S
         AjFg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/XxfxI2IiRKAXm7Hd3yQNbGkC5CqFxhBc95eg1yaihAPEBa7qtfzQKU8hkOaJXZ+1Us4MKrVGunBUPLJh/O+1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4OZqmUHIbYv05oESSv6pL0Bimmh1TaxhOZNoIlJZ6JWT9Th3P
	sLjRQNhhJvBvKFr3KBGPCAHooURDxm/65nRnYz7B0sQ+SdKjOKdKtczI0QiL7fJZ4u3QGYPsyhS
	ijpOOy4UPa1omqvTOiNoCYKjbACZMuac/S8o/5ULXRjkX2vDt8SliNLaF+Zw=
X-Gm-Gg: AR+sD12hOvXIrW79Z80EYMbeYKJOT00vYxyd7ZMHX+9FPSBZO2lXk2VbkelW7Qg1yKy
	eUu4YySp+MfcDsVpm4qLrbgHFX8CvlfaFqQ2XJ7qV7EvM9FB00YCgDGjqExTbKzFzoidAF4N/Ea
	uc1qkaIph2LUGYNx2Md58/f2qu/lzBoAPoaNRRMwrcqRoTL5m50zwsi9PAdQpp6FMNEoxLU6QCw
	C/ARwk0+ZNG9oRZmaF+pkkKezrKzxE4oX9+Ql2PK7AE33vdszKT5lTId2G3MmfzSqmfAo+9CMz3
	TdXz69oU74Hu3FwYFTh4kh0gop4QOy/YIE0rhdhzPs+Yd6pI2+ghER5G1Nfgc6nqyYxx7rWCcb0
	=
X-Received: by 2002:a05:622a:1194:b0:50e:5eba:cadd with SMTP id
 d75a77b69052e-52dc08c8835mr4714741cf.2.1787001153765; Mon, 17 Aug 2026
 14:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817094623.3288456-1-jiebin.sun@intel.com> <20260817094623.3288456-9-jiebin.sun@intel.com>
In-Reply-To: <20260817094623.3288456-9-jiebin.sun@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 14:12:21 -0700
X-Gm-Features: AcwNN1VfyYiToRoGeCMtEXyJW7MDEIcSVq5aBjRmxrGtSpCDq-rtM7K4cbr_0lQ
Message-ID: <CAP-5=fViHskMJMoOwa7ZsF+3+svZTnpnyUy7RrWjBuWUOgJUPw@mail.gmail.com>
Subject: Re: [PATCH v9 8/9] perf c2c: add function view browser UI and
 cacheline detail
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
> Add the browser front end: create/run/delete the hist_browser and add the
> title. The d shortcut opens the existing per-cacheline detail view for th=
e
> selected level-3 cacheline. Level-3 entries retain the source cacheline
> index, so the shortcut can locate the original entry without relying on a
> potentially ambiguous virtual address.
>
> Report a warning when the common model rejects a cacheline coalescing fie=
ld
> list without `iaddr`. Without it, the detail histograms may already have
> merged samples from different functions and cannot support reliable
> function attribution.
>
> Keep visible-row accounting local to the function view by wrapping the
> generic browser refresh callback and recounting the currently reachable
> hierarchy before each redraw. This keeps navigation correct when a level-=
1
> row is collapsed while level-3 descendants remain expanded, without addin=
g
> C2C-specific hooks to the shared hist_browser. Also handle Ctrl-C like th=
e
> other function-view exit keys.
>
> Keep callchains hidden while the function browser runs, restoring the
> user's setting while opening the cacheline detail view.
>
> Wire the builder into perf_c2c__browse_function_view().
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
>  tools/perf/builtin-c2c.c              |  10 ++
>  tools/perf/ui/browsers/Build          |   1 +
>  tools/perf/ui/browsers/c2c-function.c | 209 ++++++++++++++++++++++++++
>  tools/perf/util/c2c.h                 |  22 +++
>  4 files changed, 242 insertions(+)
>  create mode 100644 tools/perf/ui/browsers/c2c-function.c
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 16b00a36fdfc..715b75d42f2a 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2745,11 +2745,18 @@ perf_c2c_browser__new(struct hists *hists)
>
>  static int perf_c2c__hists_browse(struct hists *hists)
>  {
> +       struct c2c_function_view_args func_args =3D {
> +               .cl_hists         =3D &c2c.hists,
> +               .cl_sort          =3D c2c.cl_sort,
> +               .symbol_full      =3D c2c.symbol_full,
> +               .browse_cacheline =3D perf_c2c__browse_cacheline,
> +       };
>         struct hist_browser *browser;
>         int key =3D -1;
>         static const char help[] =3D
>         " d             Display cacheline details \n"
>         " ENTER         Toggle callchains (if present) \n"
> +       " TAB           Switch to function view\n"
>         " q             Quit \n";
>
>         browser =3D perf_c2c_browser__new(hists);
> @@ -2771,6 +2778,9 @@ static int perf_c2c__hists_browse(struct hists *his=
ts)
>                 case 'd':
>                         perf_c2c__browse_cacheline(browser->he_selection)=
;
>                         break;
> +               case '\t':
> +                       perf_c2c__browse_function_view(&func_args);
> +                       break;
>                 case '?':
>                         ui_browser__help_window(&browser->b, help);
>                         break;
> diff --git a/tools/perf/ui/browsers/Build b/tools/perf/ui/browsers/Build
> index a07489e44765..ae67a2161f7d 100644
> --- a/tools/perf/ui/browsers/Build
> +++ b/tools/perf/ui/browsers/Build
> @@ -5,3 +5,4 @@ perf-ui-y +=3D map.o
>  perf-ui-y +=3D scripts.o
>  perf-ui-y +=3D header.o
>  perf-ui-y +=3D res_sample.o
> +perf-ui-y +=3D c2c-function.o
> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> new file mode 100644
> index 000000000000..3d23e9d84981
> --- /dev/null
> +++ b/tools/perf/ui/browsers/c2c-function.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * C2C function browser - TUI front end for function-level sharing analy=
sis
> + */
> +
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <stdlib.h>
> +#include <sys/ttydefaults.h>
> +#include <linux/rbtree.h>
> +#include <linux/zalloc.h>
> +
> +#include "../browser.h"
> +#include "../keysyms.h"
> +#include "../libslang.h"
> +#include "../ui.h"
> +#include "../../util/c2c.h"
> +#include "../../util/debug.h"
> +#include "../../util/hist.h"
> +#include "../../util/symbol.h"
> +#include "hists.h"
> +
> +struct c2c_function_browser {
> +       struct hist_browser     hb;
> +       unsigned int            (*orig_refresh)(struct ui_browser *browse=
r);
> +       int                     (*browse_cacheline)(struct hist_entry *he=
);
> +};
> +
> +/*
> + * Count visible entries in @root, descending only through visible, unfo=
lded
> + * parents. Match hists__filter_entries(), which drives generic browser
> + * navigation, so the count cannot include rows the browser skips.
> + */
> +static u64
> +c2c_function__nr_visible_rows(struct rb_root_cached *root, float min_pcn=
t)
> +{
> +       struct rb_node *nd;
> +       u64 rows =3D 0;
> +
> +       for (nd =3D rb_first_cached(root); nd; nd =3D rb_next(nd)) {
> +               struct hist_entry *he =3D rb_entry(nd, struct hist_entry,=
 rb_node);
> +
> +               /*
> +                * The generic refresh folds filtered parents and therefo=
re hides
> +                * their subtree. A percentage-rejected parent is merely =
skipped;
> +                * if it is unfolded, qualifying descendants are still re=
ndered.
> +                */
> +               if (he->filtered)
> +                       continue;
> +
> +               if (hist_entry__get_percent_limit(he) >=3D min_pcnt)
> +                       rows++;
> +               if (he->has_children && he->unfolded)
> +                       rows +=3D c2c_function__nr_visible_rows(&he->hroo=
t_out,
> +                                                            min_pcnt);
> +       }
> +       return rows;
> +}
> +
> +static void
> +c2c_function_browser__update_nr_entries(struct c2c_function_browser *bro=
wser)
> +{
> +       u64 nr_entries;
> +
> +       nr_entries =3D c2c_function__nr_visible_rows(&browser->hb.hists->=
entries,
> +                                                  browser->hb.min_pcnt);
> +       browser->hb.nr_non_filtered_entries =3D nr_entries;
> +       browser->hb.b.nr_entries =3D nr_entries;
> +}
> +
> +static unsigned int c2c_function_browser__refresh(struct ui_browser *ui_=
browser)
> +{
> +       struct hist_browser *hist_browser =3D container_of(ui_browser, st=
ruct hist_browser, b);
> +       struct c2c_function_browser *browser;
> +
> +       browser =3D container_of(hist_browser, struct c2c_function_browse=
r, hb);
> +       c2c_function_browser__update_nr_entries(browser);
> +       return browser->orig_refresh(ui_browser);
> +}
> +
> +static int c2c_function_browser__title(struct hist_browser *browser,
> +                                      char *bf, size_t size)
> +{
> +       scnprintf(bf, size,
> +                 "Shared Data Functions Table     (%" PRIu64 " entries, =
sorted on Cycles %%)",
> +                 browser->hists->nr_non_filtered_entries);
> +       return 0;
> +}
> +
> +static struct c2c_function_browser *
> +c2c_function_browser__new(struct hists *hists,
> +                         int (*browse_cacheline)(struct hist_entry *he))
> +{
> +       struct c2c_function_browser *browser;
> +
> +       if (!hists)
> +               return NULL;
> +
> +       browser =3D zalloc(sizeof(*browser));
> +       if (!browser)
> +               return NULL;
> +
> +       hist_browser__init(&browser->hb, hists);
> +       browser->orig_refresh =3D browser->hb.b.refresh;
> +       browser->hb.b.refresh =3D c2c_function_browser__refresh;
> +       browser->browse_cacheline =3D browse_cacheline;
> +
> +       browser->hb.title =3D c2c_function_browser__title;
> +       browser->hb.c2c_filter =3D true;
> +       browser->hb.show_headers =3D true;
> +       /* Keep title line count consistent with forcing headers on. */
> +       browser->hb.b.extra_title_lines =3D hists->hpp_list->nr_header_li=
nes;
> +       browser->hb.min_pcnt =3D 0.0;
> +
> +       return browser;
> +}
> +
> +static void c2c_function_browser__delete(struct c2c_function_browser *br=
owser)
> +{
> +       free(browser);
> +}
> +
> +static int
> +c2c_browser__browse_cacheline(struct c2c_function_browser *browser,
> +                             struct hist_entry *he_selection)
> +{
> +       struct hist_entry *he =3D c2c_function__find_cacheline(he_selecti=
on);
> +
> +       return he ? browser->browse_cacheline(he) : -1;
> +}
> +
> +int perf_c2c__browse_function_view(struct c2c_function_view_args *args)
> +{
> +       struct c2c_function_browser *browser;
> +       struct hists *hists;
> +       bool saved_use_callchain =3D symbol_conf.use_callchain;
> +       int key, ret;
> +       static const char help[] =3D
> +       " d             Display details for the selected level-3 cachelin=
e\n"
> +       " e/+           Expand/collapse the selected entry\n"
> +       " TAB/ESC/q/^C  Return to the cacheline view\n";
> +
> +       if (!args || !args->cl_hists || !args->browse_cacheline)
> +               return -EINVAL;
> +
> +       /*
> +        * Function view does not display callchains; cacheline detail te=
mporarily
> +        * restores them.
> +        */
> +       symbol_conf.use_callchain =3D false;
> +
> +       ret =3D c2c_function__build(args->cl_hists, args->cl_sort,
> +                                 args->symbol_full, &hists);
> +       if (ret) {
> +               if (ret =3D=3D -EOPNOTSUPP)
> +                       ui__warning("The function view requires iaddr in =
--coalesce.\n");
> +               else
> +                       ui__error("Failed to build function view hierarch=
y (ret=3D%d)\n", ret);
> +               goto out;
> +       }
> +
> +       browser =3D c2c_function_browser__new(hists, args->browse_cacheli=
ne);
> +       if (!browser) {
> +               ret =3D -ENOMEM;
> +               goto out_reset;
> +       }
> +
> +       /* Reset abort key so we can receive Ctrl-C as a key. */
> +       SLang_reset_tty();
> +       SLang_init_tty(0, 0, 0);
> +       SLtty_set_suspend_state(true);
> +
> +       while (1) {
> +               c2c_function_browser__update_nr_entries(browser);
> +               key =3D hist_browser__run(&browser->hb, "? - help", true,=
 0);
> +
> +               switch (key) {
> +               case 'q':
> +               case K_TAB:
> +               case K_ESC:
> +               case CTRL('c'):
> +                       goto browser_done;
> +               case 'd':
> +                       /* Cacheline detail honors the user's callchain s=
etting. */
> +                       symbol_conf.use_callchain =3D saved_use_callchain=
;
> +                       c2c_browser__browse_cacheline(browser, browser->h=
b.he_selection);
> +                       /*
> +                        * Preserve any toggle made in the detail view, t=
hen
> +                        * re-disable callchain for the function view.
> +                        */
> +                       saved_use_callchain =3D symbol_conf.use_callchain=
;
> +                       symbol_conf.use_callchain =3D false;
> +                       break;
> +               case '?':
> +                       ui_browser__help_window(&browser->hb.b, help);
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +
> +browser_done:
> +       c2c_function_browser__delete(browser);
> +out_reset:
> +       c2c_function__reset();
> +out:
> +       symbol_conf.use_callchain =3D saved_use_callchain;
> +       return ret;
> +}
> diff --git a/tools/perf/util/c2c.h b/tools/perf/util/c2c.h
> index 6548b9ba81f1..53f024e25d99 100644
> --- a/tools/perf/util/c2c.h
> +++ b/tools/perf/util/c2c.h
> @@ -110,4 +110,26 @@ void c2c_function__reset(void);
>  /* Valid only between a successful build and c2c_function__reset(). */
>  struct hist_entry *c2c_function__find_cacheline(struct hist_entry *he);
>
> +/* Inputs and TUI callback supplied by the c2c command. */
> +struct c2c_function_view_args {
> +       /* Source cacheline histograms used by the common model. */
> +       struct c2c_hists        *cl_hists;
> +       /* --coalesce field list, used to require iaddr. */
> +       const char              *cl_sort;
> +       /* Do not cap long symbol names. */
> +       bool                     symbol_full;
> +       /* Open the cacheline detail view for @he. */
> +       int                     (*browse_cacheline)(struct hist_entry *he=
);
> +};
> +
> +#ifdef HAVE_SLANG_SUPPORT
> +int perf_c2c__browse_function_view(struct c2c_function_view_args *args);
> +#else
> +static inline int
> +perf_c2c__browse_function_view(struct c2c_function_view_args *args __may=
be_unused)
> +{
> +       return 0;
> +}
> +#endif
> +
>  #endif /* __PERF_UTIL_C2C_H */
> --
> 2.52.0
>
