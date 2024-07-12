Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222B78F49;
	Fri, 12 Jul 2024 06:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720764255; cv=none; b=H9/E3541nxPoa9y7HLt5JdawAwTZWgbrgZsAZScE96dL+qieClUP2biGTvn6Df9aRBSpERIUvwMryo0tGY8bZc9LRiaO/5T61d5h6/3r9MqUP19p+UpF7stg/+wQoeXcv4yytxZ+Nh4M1CZ0jbYYdhJZHb8CjhY8EsF3fGEkoTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720764255; c=relaxed/simple;
	bh=+M6LyJnBUDJGtP37RGbyzw6U8uqJEZsHpwKco/BWpMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afazMRKVHFxzrM+DhqBCyDGaRoaUk4JtIvMwEp97aEFbMKU4StJOPvZ4z/kwPTFKKGb+/V1HJ2PnaXe//8WTzZaHX9BbS8EbDBpLM51yT4CipbOyLWcX9/PYlBlntF5lFf1OJ19nCdemJu53yAOLFIU0IqDupJjdZwmKvAuqIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-75c3afd7a50so1187307a12.2;
        Thu, 11 Jul 2024 23:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720764253; x=1721369053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IH5WEfgeqhqifFDky1dpLHDI2P0AwAdU3wwOlpmCYds=;
        b=oyyZ6J5IJKeI732ShsrlLykF3TJOt+nWACGhAmA0lKU7qwXfobNG+CaBtYo11lLWSl
         7n6lIisK2CXKvC9qwVhER0vQixyoeZPcm8WeIkdz3NfXrqpbghMzryzai6iyIjmZGRSy
         /Tnplfo/0q8vw6ln3vnWi9T3peP/qW9LKpXXc26XDVKonolDjuOU6+Geif38mterlBiC
         9a5gr2EOEUjNU6uNa+x+3K+bhMmq4BDxwqW+LpWTVXj8OuVgIxt2xuSUExFjPCWMFDhx
         uRzkLts0Hk8M04JE2eo4sg3J6YMR6LUbTb4JLBzMXU9VPQ2fOV6ggM/t94eq/hHC5E1X
         noWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH5YN844lJhffaPZHoRttTccqcQK5bPR+GaGiSKE+sbepH4QsfxEdAeI+iYRA5KYL01/uP67Obx56aYRC28jfOIxkWLCBQ00d3est84wnxxm1HFkCgUlRx+Gy+t1NlKkj3cWj3ulAdH0aXWtr2NQ==
X-Gm-Message-State: AOJu0YxgZxHVq/8JQkjleRe2okHD7kKpFZOlRRvhD4kHPHhCcek8IRdT
	sHq7xHB4T7krDVPO2l9Ktcw3yOby1tnm1yLaexZdvyMVG6HwWRYI8Ol05SV7uRVNrkSpo2cRi4S
	hIFQfckZ7otcmW5S6nQT0K9rgNB0=
X-Google-Smtp-Source: AGHT+IGFfmmKtf8bh7oWwCjNt/AtScH67tze86vhKakkEtxxqJXGSegwdMWMPcCkWpra09QBeegUWSu0idEsYgeCD4c=
X-Received: by 2002:a05:6a20:734c:b0:1c0:f328:8e5a with SMTP id
 adf61e73a8af0-1c2984cdf96mr11022912637.47.1720764252842; Thu, 11 Jul 2024
 23:04:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704015812.2119457-1-namhyung@kernel.org> <CAP-5=fWLhbgUxW4jyKtMy0QuQfBTXUpZHrqRCHgSHgcXQTV3Fg@mail.gmail.com>
In-Reply-To: <CAP-5=fWLhbgUxW4jyKtMy0QuQfBTXUpZHrqRCHgSHgcXQTV3Fg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 11 Jul 2024 23:04:01 -0700
Message-ID: <CAM9d7ciZXsMSwmLViDVJLsP60k4zynr7XGxvLS3TrupdTm1aPg@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Cache debuginfo for data type profiling
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Thu, Jul 11, 2024 at 10:29=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, Jul 3, 2024 at 6:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > In find_data_type(), it creates and deletes a debug info whenver it
> > tries to find data type for a sample.  This is inefficient and it most
> > likely accesses the same binary again and again.
> >
> > Let's add a single entry cache the debug info structure for the last DS=
O.
> > Depending on sample data, it usually gives me 2~3x (and sometimes more)
> > speed ups.
> >
> > Note that this will introduce a little difference in the output due to
> > the order of checking stack operations.  It used to check the stack ops
> > before checking the availability of debug info but I moved it after the
> > symbol check.  So it'll report stack operations in DSOs without debug
> > info as unknown.  But I think it's ok and better to have the checking
> > near the caching logic.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/annotate-data.c | 15 ++-------------
> >  tools/perf/util/annotate-data.h |  2 +-
> >  tools/perf/util/annotate.c      | 29 +++++++++++++++++++++++++++++
> >  tools/perf/util/annotate.h      |  2 ++
> >  tools/perf/util/session.c       |  2 ++
> >  5 files changed, 36 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate=
-data.c
> > index 965da6c0b542..24c03475b3f2 100644
> > --- a/tools/perf/util/annotate-data.c
> > +++ b/tools/perf/util/annotate-data.c
> > @@ -1764,16 +1764,9 @@ static int find_data_type_die(struct data_loc_in=
fo *dloc, Dwarf_Die *type_die)
> >   */
> >  struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
> >  {
> > -       struct annotated_data_type *result =3D NULL;
> >         struct dso *dso =3D map__dso(dloc->ms->map);
> >         Dwarf_Die type_die;
> >
> > -       dloc->di =3D debuginfo__new(dso__long_name(dso));
> > -       if (dloc->di =3D=3D NULL) {
> > -               pr_debug_dtp("cannot get the debug info\n");
> > -               return NULL;
> > -       }
> > -
> >         /*
> >          * The type offset is the same as instruction offset by default=
.
> >          * But when finding a global variable, the offset won't be vali=
d.
> > @@ -1783,13 +1776,9 @@ struct annotated_data_type *find_data_type(struc=
t data_loc_info *dloc)
> >         dloc->fbreg =3D -1;
> >
> >         if (find_data_type_die(dloc, &type_die) < 0)
> > -               goto out;
> > -
> > -       result =3D dso__findnew_data_type(dso, &type_die);
> > +               return NULL;
> >
> > -out:
> > -       debuginfo__delete(dloc->di);
> > -       return result;
> > +       return dso__findnew_data_type(dso, &type_die);
> >  }
> >
> >  static int alloc_data_type_histograms(struct annotated_data_type *adt,=
 int nr_entries)
> > diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate=
-data.h
> > index 0a57d9f5ee78..40c9377fa1a5 100644
> > --- a/tools/perf/util/annotate-data.h
> > +++ b/tools/perf/util/annotate-data.h
> > @@ -100,9 +100,9 @@ struct data_loc_info {
> >         u64 var_addr;
> >         u8 cpumode;
> >         struct annotated_op_loc *op;
> > +       struct debuginfo *di;
> >
> >         /* These are used internally */
> > -       struct debuginfo *di;
> >         int fbreg;
> >         bool fb_cfa;
> >
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 1451caf25e77..821e4b2c3bcd 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -25,6 +25,7 @@
> >  #include "srcline.h"
> >  #include "units.h"
> >  #include "debug.h"
> > +#include "debuginfo.h"
> >  #include "annotate.h"
> >  #include "annotate-data.h"
> >  #include "evsel.h"
> > @@ -2313,6 +2314,20 @@ u64 annotate_calc_pcrel(struct map_symbol *ms, u=
64 ip, int offset,
> >         return map__rip_2objdump(ms->map, addr);
> >  }
> >
> > +static struct debuginfo_cache {
> > +       struct dso *dso;
> > +       struct debuginfo *dbg;
> > +} di_cache;
> > +
> > +void debuginfo_cache__delete(void)
> > +{
> > +       dso__put(di_cache.dso);
> > +       di_cache.dso =3D NULL;
> > +
> > +       debuginfo__delete(di_cache.dbg);
> > +       di_cache.dbg =3D NULL;
> > +}
> > +
> >  /**
> >   * hist_entry__get_data_type - find data type for given hist entry
> >   * @he: hist entry
> > @@ -2347,6 +2362,19 @@ struct annotated_data_type *hist_entry__get_data=
_type(struct hist_entry *he)
> >                 return NULL;
> >         }
> >
> > +       if (map__dso(ms->map) !=3D di_cache.dso) {
>
> Does the di_cache need a mutex? Otherwise another thread may be in
> this same code racing with it.

The whole data type profiling code assumes single threaded
so I don't think we need a mutex just for this di_cache.
But I can add an assertion in the code to make it explicit.

Thanks for your review!
Namhyung

>
> > +               dso__put(di_cache.dso);
> > +               di_cache.dso =3D dso__get(map__dso(ms->map));
> > +
> > +               debuginfo__delete(di_cache.dbg);
> > +               di_cache.dbg =3D debuginfo__new(dso__long_name(di_cache=
.dso));
> > +       }
> > +
> > +       if (di_cache.dbg =3D=3D NULL) {
> > +               ann_data_stat.no_dbginfo++;
> > +               return NULL;
> > +       }
> > +
> >         /* Make sure it has the disasm of the function */
> >         if (symbol__annotate(ms, evsel, &arch) < 0) {
> >                 ann_data_stat.no_insn++;
> > @@ -2391,6 +2419,7 @@ struct annotated_data_type *hist_entry__get_data_=
type(struct hist_entry *he)
> >                         .ip =3D ms->sym->start + dl->al.offset,
> >                         .cpumode =3D he->cpumode,
> >                         .op =3D op_loc,
> > +                       .di =3D di_cache.dbg,
> >                 };
> >
> >                 if (!op_loc->mem_ref && op_loc->segment =3D=3D INSN_SEG=
_NONE)
> > diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> > index d5c821c22f79..0686af637ed9 100644
> > --- a/tools/perf/util/annotate.h
> > +++ b/tools/perf/util/annotate.h
> > @@ -540,4 +540,6 @@ struct annotated_basic_block {
> >  int annotate_get_basic_blocks(struct symbol *sym, s64 src, s64 dst,
> >                               struct list_head *head);
> >
> > +void debuginfo_cache__delete(void);
> > +
> >  #endif /* __PERF_ANNOTATE_H */
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 5596bed1b8c8..f9072e003367 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -36,6 +36,7 @@
> >  #include "util.h"
> >  #include "arch/common.h"
> >  #include "units.h"
> > +#include "annotate.h"
> >  #include <internal/lib.h>
> >
> >  #ifdef HAVE_ZSTD_SUPPORT
> > @@ -304,6 +305,7 @@ void perf_session__delete(struct perf_session *sess=
ion)
> >                 return;
> >         auxtrace__free(session);
> >         auxtrace_index__free(&session->auxtrace_index);
> > +       debuginfo_cache__delete();
> >         perf_session__destroy_kernel_maps(session);
> >         perf_decomp__release_events(session->decomp_data.decomp);
> >         perf_env__exit(&session->header.env);
> > --
> > 2.45.2.803.g4e1b14247a-goog
> >
