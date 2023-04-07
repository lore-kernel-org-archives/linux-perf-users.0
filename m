Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A633C761A6
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 Apr 2023 00:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjDGAkv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjDGAku (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Apr 2023 20:40:50 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229597DB6
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Apr 2023 17:40:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f04275b2bdso118015e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Apr 2023 17:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680828047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOEEgrTpJjLlZtXAbjYiq9A4C3vWAWTmRG5Yn4qZiZY=;
        b=RuAQI8DWoks1cC1UT5cZlayvPzt18y3lAlCP9R6mCtiRBIEkr8n3X4IbemzF6Xd+3O
         ZVtKFpm0ZAQ0i1DiVAMAENKXdI9gnNYghaQuvWESFra3KLNJLUEDOKE9FGtWA/uX9mmL
         qPQBLP0JHL1F3KEegfcdgGPV/dWXCPPmvdLutzoG1cEWqVGVWkuRs4pWJkQhdFrpTGCs
         pQDplNOe/wU61B6/XSHvDeZTJ/iXbYOhxjT8PYT2SJ9Ax+52oHSpJN9LD2VoqH32PYzJ
         guRPFBGkeTChO3glM21UAZSFhIyJcfzbIx9RszucwpKlIEuRMs9W6tNeA0lk4LPh2BYj
         9ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680828047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOEEgrTpJjLlZtXAbjYiq9A4C3vWAWTmRG5Yn4qZiZY=;
        b=pwrwfl/narjntj9K4iMxmt9U9jIB5f5QNfPyyxc+swk7z/4LP/mzOgNl3UhCsKTT5s
         ULS3255BxNPhXrJQ+PN1SQMrjTY4YHFZF/AIbgTo8L4I2gib74JRkg2cH6sYH8IMHls5
         zokITsLFy2denBhxVfkN7Jtced39B5JZOqhSEfOLjSm/48ZHw5noa9+kGqrcXZzouhFj
         Lbdrp/GTanjaJYpo1rAYf4tkhymMs8LQGMCkvP/f1dI0gzG3LXwPFUBGTuKbkoPOeLuC
         qIGAvAvWP9RstRa7T9mwdcTzMbOudKLnJIN/VgsmzsNw7ZQdBzo+pPuCQcmF4jRawAYa
         LAKQ==
X-Gm-Message-State: AAQBX9dt65+oz+le80m6GQ2MHmjIv6nvioxd8XPeYe/A9nqOWWkRXANg
        S4iPrE/HQarcAEE41iU516/sZRLHruLerUp+nD7OIg==
X-Google-Smtp-Source: AKy350ZJepwoKDjR0PP+xbpNCq8//cT+n/SKUPtrariwfLjnww8WA4BABlKSeQEEEMVe9q1Af/hr9kGEL7+wRqopO7Q=
X-Received: by 2002:a05:600c:1ca2:b0:3df:f3cb:e8ce with SMTP id
 k34-20020a05600c1ca200b003dff3cbe8cemr28778wms.7.1680828047389; Thu, 06 Apr
 2023 17:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230404205954.2245628-1-irogers@google.com> <20230404205954.2245628-2-irogers@google.com>
 <ZC12sgYsbvF/C28z@kernel.org> <ZC14YdPV+Az3A7/G@kernel.org>
In-Reply-To: <ZC14YdPV+Az3A7/G@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 6 Apr 2023 17:40:35 -0700
Message-ID: <CAP-5=fVvwhRedVWLqWA8VkG5ieMTchjHVKzGHkvLJhZrXUCJzg@mail.gmail.com>
Subject: Re: [PATCH v6 01/12] perf map: Rename map_ip and unmap_ip
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 5, 2023 at 6:32=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Wed, Apr 05, 2023 at 10:25:06AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Tue, Apr 04, 2023 at 01:59:43PM -0700, Ian Rogers escreveu:
> > > Add dso to match comment. This avoids a naming conflict with later
> > > added accessor functions for variables in struct map.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/builtin-kmem.c    | 2 +-
> > >  tools/perf/builtin-script.c  | 4 ++--
> > >  tools/perf/util/machine.c    | 4 ++--
> > >  tools/perf/util/map.c        | 8 ++++----
> > >  tools/perf/util/map.h        | 4 ++--
> > >  tools/perf/util/symbol-elf.c | 4 ++--
> > >  6 files changed, 13 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> > > index f3029742b800..4d4b770a401c 100644
> > > --- a/tools/perf/builtin-kmem.c
> > > +++ b/tools/perf/builtin-kmem.c
> > > @@ -423,7 +423,7 @@ static u64 find_callsite(struct evsel *evsel, str=
uct perf_sample *sample)
> > >             if (!caller) {
> > >                     /* found */
> > >                     if (node->ms.map)
> > > -                           addr =3D map__unmap_ip(node->ms.map, node=
->ip);
> > > +                           addr =3D map__dso_unmap_ip(node->ms.map, =
node->ip);
> >
> > As we chatted, I think this is a good opportunity to make this more
> > clear, perhaps rename map__unmap_ip() to map__addr_offset_to_virt() and
> > map__map_ip() to map__addr_virt_to_offset()?
>
> Maybe prefix both with __, i.e. __map__addr_offset_to_virt() and __map__a=
ddr_virt_to_offset(), since
> then you need to wrap map->unmap_ip() to
> map__map__addr_offset_to_virt(), that in some cases will map to
> __map__addr_offset_to_virt(), modulo in identity maps, like with the
> kernel where we use identify__map_ip().

Thanks Arnaldo, I'm not following what you are asking here. As it is a
refactor unrelated to reference count checking, could you follow up
this patch set with it?

Ian

> - Arnaldo
>
> > - Arnaldo
> >
> > >                     else
> > >                             addr =3D node->ip;
> > >
> > > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.=
c
> > > index 1d078106abc4..af0a69c7f41f 100644
> > > --- a/tools/perf/builtin-script.c
> > > +++ b/tools/perf/builtin-script.c
> > > @@ -1012,11 +1012,11 @@ static int perf_sample__fprintf_brstackoff(st=
ruct perf_sample *sample,
> > >
> > >             if (thread__find_map_fb(thread, sample->cpumode, from, &a=
lf) &&
> > >                 !map__dso(alf.map)->adjust_symbols)
> > > -                   from =3D map__map_ip(alf.map, from);
> > > +                   from =3D map__dso_map_ip(alf.map, from);
> > >
> > >             if (thread__find_map_fb(thread, sample->cpumode, to, &alt=
) &&
> > >                 !map__dso(alt.map)->adjust_symbols)
> > > -                   to =3D map__map_ip(alt.map, to);
> > > +                   to =3D map__dso_map_ip(alt.map, to);
> > >
> > >             printed +=3D fprintf(fp, " 0x%"PRIx64, from);
> > >             if (PRINT_FIELD(DSO)) {
> > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > index 7852b97da10a..9d24980a0a93 100644
> > > --- a/tools/perf/util/machine.c
> > > +++ b/tools/perf/util/machine.c
> > > @@ -3058,7 +3058,7 @@ static int append_inlines(struct callchain_curs=
or *cursor, struct map_symbol *ms
> > >     if (!symbol_conf.inline_name || !map || !sym)
> > >             return ret;
> > >
> > > -   addr =3D map__map_ip(map, ip);
> > > +   addr =3D map__dso_map_ip(map, ip);
> > >     addr =3D map__rip_2objdump(map, addr);
> > >     dso =3D map__dso(map);
> > >
> > > @@ -3103,7 +3103,7 @@ static int unwind_entry(struct unwind_entry *en=
try, void *arg)
> > >      * its corresponding binary.
> > >      */
> > >     if (entry->ms.map)
> > > -           addr =3D map__map_ip(entry->ms.map, entry->ip);
> > > +           addr =3D map__dso_map_ip(entry->ms.map, entry->ip);
> > >
> > >     srcline =3D callchain_srcline(&entry->ms, addr);
> > >     return callchain_cursor_append(cursor, entry->ip, &entry->ms,
> > > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > > index 416fc449bde8..d97a6d20626f 100644
> > > --- a/tools/perf/util/map.c
> > > +++ b/tools/perf/util/map.c
> > > @@ -109,8 +109,8 @@ void map__init(struct map *map, u64 start, u64 en=
d, u64 pgoff, struct dso *dso)
> > >     map->pgoff    =3D pgoff;
> > >     map->reloc    =3D 0;
> > >     map->dso      =3D dso__get(dso);
> > > -   map->map_ip   =3D map__map_ip;
> > > -   map->unmap_ip =3D map__unmap_ip;
> > > +   map->map_ip   =3D map__dso_map_ip;
> > > +   map->unmap_ip =3D map__dso_unmap_ip;
> > >     map->erange_warned =3D false;
> > >     refcount_set(&map->refcnt, 1);
> > >  }
> > > @@ -590,12 +590,12 @@ struct maps *map__kmaps(struct map *map)
> > >     return kmap->kmaps;
> > >  }
> > >
> > > -u64 map__map_ip(const struct map *map, u64 ip)
> > > +u64 map__dso_map_ip(const struct map *map, u64 ip)
> > >  {
> > >     return ip - map__start(map) + map->pgoff;
> > >  }
> > >
> > > -u64 map__unmap_ip(const struct map *map, u64 ip)
> > > +u64 map__dso_unmap_ip(const struct map *map, u64 ip)
> > >  {
> > >     return ip + map__start(map) - map->pgoff;
> > >  }
> > > diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> > > index 16646b94fa3a..9b0a84e46e48 100644
> > > --- a/tools/perf/util/map.h
> > > +++ b/tools/perf/util/map.h
> > > @@ -41,9 +41,9 @@ struct kmap *map__kmap(struct map *map);
> > >  struct maps *map__kmaps(struct map *map);
> > >
> > >  /* ip -> dso rip */
> > > -u64 map__map_ip(const struct map *map, u64 ip);
> > > +u64 map__dso_map_ip(const struct map *map, u64 ip);
> > >  /* dso rip -> ip */
> > > -u64 map__unmap_ip(const struct map *map, u64 ip);
> > > +u64 map__dso_unmap_ip(const struct map *map, u64 ip);
> > >  /* Returns ip */
> > >  u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip);
> > >
> > > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-el=
f.c
> > > index e715869eab8a..c55981116f68 100644
> > > --- a/tools/perf/util/symbol-elf.c
> > > +++ b/tools/perf/util/symbol-elf.c
> > > @@ -1357,8 +1357,8 @@ static int dso__process_kernel_symbol(struct ds=
o *dso, struct map *map,
> > >                     map->start =3D shdr->sh_addr + ref_reloc(kmap);
> > >                     map->end =3D map__start(map) + shdr->sh_size;
> > >                     map->pgoff =3D shdr->sh_offset;
> > > -                   map->map_ip =3D map__map_ip;
> > > -                   map->unmap_ip =3D map__unmap_ip;
> > > +                   map->map_ip =3D map__dso_map_ip;
> > > +                   map->unmap_ip =3D map__dso_unmap_ip;
> > >                     /* Ensure maps are correctly ordered */
> > >                     if (kmaps) {
> > >                             int err;
> > > --
> > > 2.40.0.348.gf938b09366-goog
> > >
> >
> > --
> >
> > - Arnaldo
>
> --
>
> - Arnaldo
