Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB8F3BB135
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998916; cv=pass; b=ahYhz8j05Ps5yYBllcB/oQR9XOPA4myQyTCwZnS0lGJtYHPQ7NoIcj+FSjnF2g0sETYDH18lf4OXuzt29UIKaMnK6lLyb5KivIK3kG6k17BE8UgFVG1EOpMw+iH82hXONZUCaUzEefe5pS04G3tWRJpdEzomenXSaJmzUjzgAP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998916; c=relaxed/simple;
	bh=nCi1m6WIPhHrwME+sfuX9hjuvy2z/B+f/zJGMkZ3vcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eb/ybNO05mzhvO4LV/9RNhmOKxZCx8IECf1g+MJCXIN1McxdTiT7CXB3WhJnVBpixP2fh0efmPVD5gQN2BUOXfYR4cvoQMXk1kupeqbcTxjM28jKgTYK8unPNviGJ34qWKerpFp6YQzu1NBuo629T6e7Fwyrd8kQTU841tMJtvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQXTboxf; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQXTboxf"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c10ed63c0so17311cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 13:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786998914; cv=none;
        d=google.com; s=arc-20260327;
        b=E3nBH+Ce8bXo07PJeDLu/Vhp9HnXemCsltqfHVf8Tyc6ddF9UKpLdsO1U8Tf80jm4s
         7TI8VIuR0TnZ96aGR4L3YXdw8Q49aV7jDHExm6cYl9nqX4Z7gMPM+VZa5kAnXJEDCXmR
         3yq4+4ZMkdMINrzK+esfH/FtkHRrTRhn+BNe+1kjIbgfAhu7TwID/0WBQM0OOGJ8z08d
         crGC9GXlyGUbBbSn7Lbxx7b6I9FQeQ88LLxWcnJtblny7gTWCsyCjajA76xygmHJs2J3
         BRTn7AcqMETQmZ2FUe9LSSdtAI3pZGRTKmugE3aAZlq4UKloJmY7vIK3qHCqIdPIoDMW
         0kPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XuaJu0hYzvtLZSK9Ysg8c3/fblfPKc2Iada2jS/hK3k=;
        fh=aCMGHlswr0mk6x0ZzQkr4/tBtyIOGfSCBGWODHTX9ok=;
        b=AUhS1ezhFQhjZrtVboDYEMTuLLpW3jyWWjPA9NYWF6euGSKypxzHcLhjB0ay9JkJbN
         pawSOm4vPSD8q+crLTX/th3KVzdVoOp9ZDn9HNDDA7y46NJiT9QEDsY8j4lj9F2TiV8I
         rhXoQol9STluAetGx9ilL+OQLvbqneqODjaEqyepIElU2AIW6yzar9nmNjOUHPXor/mC
         X45qu0jbfLaMeh/WcRExECdcVPm0cjV1kAh9TkiFK0uPTVV6pgAHJktdpvYzTxelRxvN
         fOPX1dLprmbq9eeIx9nTe/AIQ8ud6+uMFNCKHgGQFJRqiEYd3heAilMMzpsVMRew8ghP
         0Sew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786998914; x=1787603714; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XuaJu0hYzvtLZSK9Ysg8c3/fblfPKc2Iada2jS/hK3k=;
        b=gQXTboxfmf1zBM93EPq1IqTsPhlMY7jw8SzqRsJHYA4ZPDtcJKCZbSbB67GyQjmkCc
         R9Kp/bs9ScceVksKYvmK4J7NxddS3YzI0k8D5+tk8JTGMfjKUahQVuk84ucxa0kBzGkw
         LFBok+F2oNiy0hmOuYPUmf1z3IL+f+jGOF9F4xNiZ/aRynBtAZL0hG28RRXDs/rgGqo7
         W8UnlMeTi6xkHszv9ModhJMLOmgIqoR+cJfxXpczGjyMxHugQmF1YSSRYP/UeDJSMbCf
         Xlb7a468Qgs2dLfeofT/4GYYyQdTvuNdWy2gByYaUFqVjz0RB2vmT7P0/njj5L30YOFX
         06nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786998914; x=1787603714;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XuaJu0hYzvtLZSK9Ysg8c3/fblfPKc2Iada2jS/hK3k=;
        b=EyH9W9HJtUDOlR8RvvQttcVmK6cvm2dlsPI9ekkQKuOwdTLlNa7aXEiQ3L8XC73Pa9
         EtMUd82KJ774GWqG0UStWbppuJOHGV4+hXPN1VuVVLEvIgrcuFjDZpKvH6HTUhAWZKkz
         Lfa1aUUU8WEHA8vSEA2TTbNEE7A4NU1lE1xsQTLBFSAvE7YMSfKuRxcism61/3ACcsap
         +lb9c4gpdtEBc9pg3FHycsk1q13PdBeL8Q79jgwfcCL9h2v/ZKmQsA1PCpJi1StqGEFU
         V6/PsIKdGv8wyo/gq4aIT87lm/5rTZH810e20thlNmS7gn0vKaLhQjxDc6pB6Yy8IUiG
         31KQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYpHugy8EG3DzXtOmz6kyXfeXTjKH+mYgkCfj4/EV1ZdGqQtbHARAj+Foo+yl1zGSEjBMwxOQFXbFWDtYn67nz@vger.kernel.org
X-Gm-Message-State: AOJu0YxzK7DFGXk8XS0Sr99Ki70GBi2yFGH1FFWtAyzTOdKYsrgx2tGK
	ghkt62CeinemdcRtGd5y3TcoRiZuQDN3V/GPC+Bikhe0s13cfNOeb0jzQgYvxEm+HWCWWaG1tbs
	/1NVsWzlkqfgdqbB3y4aLpeEQ/Z0uITEanQbnbHkq
X-Gm-Gg: AR+sD11vyfBzwFVxV4/vqQhZ0Pk9mzyxXzW0en2mfgSxZNxTpeRXZqJmkSZn1RCvrnK
	0L4bOeOj2QTh6plFGpXIjp7MTiPjXnPtD8n3izu4Cy28h2rO0JvNzc5EcgyXxdzq7gtyPNtICiB
	OunefH1NrgKYIhTsAqr8txtJbj6PBW9rvX8C1zF/EidxQqfZdeSe5UbwyS4Edz0/35wPZ+IUUKw
	nXwg7qfsVzgMiLlU4WZy/DDFPsupBl660GbQ+i8GDmxL3L9GbMz7Rhej75RI5N+AtZHJcDiweRN
	xHBaM3Y3Oq1lNcVsvQxzxDY9wDnbfnB5vnHFVcBWzDo+vsasyiF5LQ4zAmARCbe2T2WzTC9Ln3i
	zVjGG9Sd4Ig==
X-Received: by 2002:a05:622a:1189:b0:51c:6b7:d3de with SMTP id
 d75a77b69052e-52dc0aeeb66mr3906661cf.5.1786998912763; Mon, 17 Aug 2026
 13:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817094623.3288456-1-jiebin.sun@intel.com> <20260817094623.3288456-2-jiebin.sun@intel.com>
In-Reply-To: <20260817094623.3288456-2-jiebin.sun@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 13:34:59 -0700
X-Gm-Features: AcwNN1Ua2a2G9aHeOK4_A5WREgOjQs42ANKhM9mxXZm2a8t-4u86lm0UUPVvICI
Message-ID: <CAP-5=fVCRBrjPXxWSmqf+vFbhhiFsWNp8TrDLCMT-XiSYHcZ=g@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] perf c2c: extract shared data structures into util/c2c.h
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
> The function browser belongs in libperf-ui.a, but that archive is also
> linked into python/perf.so, where builtin command objects are unavailable=
.
> The browser therefore cannot depend on types or callbacks owned by
> builtin-c2c.c.
>
> Move c2c_hists, compute_stats, c2c_hist_entry, and the shared column
> formatting definitions from builtin-c2c.c to a new util/c2c.h. Move
> c2c_fmt_free() and c2c_fmt_equal() to a new util/c2c.c.
>
> Keep struct perf_c2c, the command instance, and
> perf_c2c__browse_cacheline() private to builtin-c2c.c.
>
> No functional change.
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
>  tools/perf/builtin-c2c.c | 105 ++-------------------------------------
>  tools/perf/util/Build    |   1 +
>  tools/perf/util/c2c.c    |  21 ++++++++
>  tools/perf/util/c2c.h    | 101 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 126 insertions(+), 102 deletions(-)
>  create mode 100644 tools/perf/util/c2c.c
>  create mode 100644 tools/perf/util/c2c.h
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index bc16a57e0927..16b00a36fdfc 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -52,46 +52,10 @@
>  #include "ui/progress.h"
>  #include "ui/ui.h"
>  #include "util/annotate.h"
> +#include "util/c2c.h"
>  #include "util/symbol.h"
>  #include "util/util.h"
>
> -struct c2c_hists {
> -       struct hists            hists;
> -       struct perf_hpp_list    list;
> -       struct c2c_stats        stats;
> -};
> -
> -struct compute_stats {
> -       struct stats             lcl_hitm;
> -       struct stats             rmt_hitm;
> -       struct stats             lcl_peer;
> -       struct stats             rmt_peer;
> -       struct stats             load;
> -};
> -
> -struct c2c_hist_entry {
> -       struct c2c_hists        *hists;
> -       struct evsel            *evsel;
> -       struct c2c_stats         stats;
> -       unsigned long           *cpuset;
> -       unsigned long           *nodeset;
> -       struct c2c_stats        *node_stats;
> -       unsigned int             cacheline_idx;
> -
> -       struct compute_stats     cstats;
> -
> -       unsigned long            paddr;
> -       unsigned long            paddr_cnt;
> -       bool                     paddr_zero;
> -       char                    *nodestr;
> -
> -       /*
> -        * must be at the end,
> -        * because of its callchain dynamic entry
> -        */
> -       struct hist_entry       he;
> -};
> -
>  static char const *coalesce_default =3D "iaddr";
>
>  struct perf_c2c {
> @@ -460,36 +424,6 @@ static const char * const __usage_report[] =3D {
>
>  static const char * const *report_c2c_usage =3D __usage_report;
>
> -#define C2C_HEADER_MAX 2
> -
> -struct c2c_header {
> -       struct {
> -               const char *text;
> -               int         span;
> -       } line[C2C_HEADER_MAX];
> -};
> -
> -struct c2c_dimension {
> -       struct c2c_header        header;
> -       const char              *name;
> -       int                      width;
> -       struct sort_entry       *se;
> -
> -       int64_t (*cmp)(struct perf_hpp_fmt *fmt,
> -                      struct hist_entry *, struct hist_entry *);
> -       int   (*entry)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> -                      struct hist_entry *he);
> -       int   (*color)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> -                      struct hist_entry *he);
> -};
> -
> -struct c2c_fmt {
> -       struct perf_hpp_fmt      fmt;
> -       struct c2c_dimension    *dim;
> -};
> -
> -#define SYMBOL_WIDTH 30
> -
>  static struct c2c_dimension dim_symbol;
>  static struct c2c_dimension dim_srcline;
>
> @@ -1391,23 +1325,6 @@ cl_idx_empty_entry(struct perf_hpp_fmt *fmt, struc=
t perf_hpp *hpp,
>         return scnprintf(hpp->buf, hpp->size, "%*s", width, "");
>  }
>
> -#define HEADER_LOW(__h)                        \
> -       {                               \
> -               .line[1] =3D {            \
> -                       .text =3D __h,    \
> -               },                      \
> -       }
> -
> -#define HEADER_BOTH(__h0, __h1)                \
> -       {                               \
> -               .line[0] =3D {            \
> -                       .text =3D __h0,   \
> -               },                      \
> -               .line[1] =3D {            \
> -                       .text =3D __h1,   \
> -               },                      \
> -       }
> -
>  #define HEADER_SPAN(__h0, __h1, __s)   \
>         {                               \
>                 .line[0] =3D {            \
> @@ -1930,22 +1847,6 @@ static struct c2c_dimension *dimensions[] =3D {
>         NULL,
>  };
>
> -static void fmt_free(struct perf_hpp_fmt *fmt)
> -{
> -       struct c2c_fmt *c2c_fmt;
> -
> -       c2c_fmt =3D container_of(fmt, struct c2c_fmt, fmt);
> -       free(c2c_fmt);
> -}
> -
> -static bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
> -{
> -       struct c2c_fmt *c2c_a =3D container_of(a, struct c2c_fmt, fmt);
> -       struct c2c_fmt *c2c_b =3D container_of(b, struct c2c_fmt, fmt);
> -
> -       return c2c_a->dim =3D=3D c2c_b->dim;
> -}
> -
>  static struct c2c_dimension *get_dimension(const char *name)
>  {
>         unsigned int i;
> @@ -2023,8 +1924,8 @@ static struct c2c_fmt *get_format(const char *name)
>         fmt->header     =3D c2c_header;
>         fmt->width      =3D c2c_width;
>         fmt->collapse   =3D dim->se ? c2c_se_collapse : dim->cmp;
> -       fmt->equal      =3D fmt_equal;
> -       fmt->free       =3D fmt_free;
> +       fmt->equal      =3D c2c_fmt_equal;
> +       fmt->free       =3D c2c_fmt_free;
>
>         return c2c_fmt;
>  }
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 330311cac550..1dfd92cbe3b7 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -11,6 +11,7 @@ perf-util-y +=3D blake2s.o
>  perf-util-y +=3D block-info.o
>  perf-util-y +=3D block-range.o
>  perf-util-y +=3D build-id.o
> +perf-util-y +=3D c2c.o
>  perf-util-y +=3D cacheline.o
>  perf-util-$(CONFIG_LIBCAPSTONE) +=3D capstone.o
>  perf-util-y +=3D config.o
> diff --git a/tools/perf/util/c2c.c b/tools/perf/util/c2c.c
> new file mode 100644
> index 000000000000..58c7342dff46
> --- /dev/null
> +++ b/tools/perf/util/c2c.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdlib.h>
> +#include <linux/kernel.h>
> +#include "hist.h"
> +#include "c2c.h"
> +
> +void c2c_fmt_free(struct perf_hpp_fmt *fmt)
> +{
> +       struct c2c_fmt *c2c_fmt;
> +
> +       c2c_fmt =3D container_of(fmt, struct c2c_fmt, fmt);
> +       free(c2c_fmt);
> +}
> +
> +bool c2c_fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
> +{
> +       struct c2c_fmt *c2c_a =3D container_of(a, struct c2c_fmt, fmt);
> +       struct c2c_fmt *c2c_b =3D container_of(b, struct c2c_fmt, fmt);
> +
> +       return c2c_a->dim =3D=3D c2c_b->dim;
> +}
> diff --git a/tools/perf/util/c2c.h b/tools/perf/util/c2c.h
> new file mode 100644
> index 000000000000..bd0c9d1c9a1a
> --- /dev/null
> +++ b/tools/perf/util/c2c.h
> @@ -0,0 +1,101 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_UTIL_C2C_H
> +#define __PERF_UTIL_C2C_H
> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <linux/types.h>
> +#include "hist.h"
> +#include "mem-events.h"
> +#include "stat.h"
> +
> +struct sort_entry;
> +
> +struct c2c_hists {
> +       struct hists            hists;
> +       struct perf_hpp_list    list;
> +       struct c2c_stats        stats;
> +};
> +
> +struct compute_stats {
> +       struct stats             lcl_hitm;
> +       struct stats             rmt_hitm;
> +       struct stats             lcl_peer;
> +       struct stats             rmt_peer;
> +       struct stats             load;
> +};
> +
> +struct c2c_hist_entry {
> +       struct c2c_hists        *hists;
> +       struct evsel            *evsel;
> +       struct c2c_stats         stats;
> +       unsigned long           *cpuset;
> +       unsigned long           *nodeset;
> +       struct c2c_stats        *node_stats;
> +       unsigned int             cacheline_idx;
> +
> +       struct compute_stats     cstats;
> +
> +       unsigned long            paddr;
> +       unsigned long            paddr_cnt;
> +       bool                     paddr_zero;
> +       char                    *nodestr;
> +
> +       /*
> +        * must be at the end,
> +        * because of its callchain dynamic entry
> +        */
> +       struct hist_entry       he;
> +};
> +
> +#define C2C_HEADER_MAX 2
> +
> +struct c2c_header {
> +       struct {
> +               const char *text;
> +               int         span;
> +       } line[C2C_HEADER_MAX];
> +};
> +
> +struct c2c_dimension {
> +       struct c2c_header        header;
> +       const char              *name;
> +       int                      width;
> +       struct sort_entry       *se;
> +
> +       int64_t (*cmp)(struct perf_hpp_fmt *fmt,
> +                      struct hist_entry *left, struct hist_entry *right)=
;
> +       int   (*entry)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +                      struct hist_entry *he);
> +       int   (*color)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +                      struct hist_entry *he);
> +};
> +
> +struct c2c_fmt {
> +       struct perf_hpp_fmt      fmt;
> +       struct c2c_dimension    *dim;
> +};
> +
> +#define SYMBOL_WIDTH 30
> +
> +#define HEADER_LOW(__h)                        \
> +       {                               \
> +               .line[1] =3D {            \
> +                       .text =3D __h,    \
> +               },                      \
> +       }
> +
> +#define HEADER_BOTH(__h0, __h1)                \
> +       {                               \
> +               .line[0] =3D {            \
> +                       .text =3D __h0,   \
> +               },                      \
> +               .line[1] =3D {            \
> +                       .text =3D __h1,   \
> +               },                      \
> +       }
> +
> +void c2c_fmt_free(struct perf_hpp_fmt *fmt);
> +bool c2c_fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
> +
> +#endif /* __PERF_UTIL_C2C_H */
> --
> 2.52.0
>
