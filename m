Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867EFC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 21:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6340F617E5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 21:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239914AbhKHVRw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 16:17:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239881AbhKHVRv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 16:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636406106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MCOvGOdbwWfmSKbGEXpg85AYxAaViRcIhAJ86OV5nXc=;
        b=AblEgKtgnurZVqKULA+3oXxjXoyG9TLt4sGD5j7Z3fpqqdnjqtGaUpI11G4DOx/E0ZyzLx
        BCHdyjvDXdIAiKmUocSJ/CkGwHglIBw59mCaXOD3A5ah7Va+HJkBmgvfLERrNsA7CSheHw
        i67czSKFobItoMFYM5AVF07J7MtYh18=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-9yh8WfTuNH2QPHOx9UNBQQ-1; Mon, 08 Nov 2021 16:15:05 -0500
X-MC-Unique: 9yh8WfTuNH2QPHOx9UNBQQ-1
Received: by mail-ed1-f70.google.com with SMTP id f20-20020a0564021e9400b003e2ad3eae74so15992510edf.5
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 13:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MCOvGOdbwWfmSKbGEXpg85AYxAaViRcIhAJ86OV5nXc=;
        b=JQFOmrZgMh91RtQUKwRujIrXDzAxvGdMQMrB/oysn4E73A6iNEflEM+iuOocNzomdK
         +0l8y3qih/EmSBs340EaKSLsMUtpuGTQqbhNEvyPcGt6aOdU6uL5KOfWpFd7w4dWNIws
         vVoaqDAY99F5dB9/jUTfUFqDB/T8b1r3kKj7YlJ0A5ZvdmtxtoqXCaoD0rxBfVuPH6Sl
         ibIA9GPZfFHhKdO3Y56sO/tuG+mBBb98UXuKbBH+gsCmZsqvjC8g2dIZQuQbmFt3Zovg
         K3t9JPWh5r7kz6r+rRK0fHZ4wffV1FoGRUwIVP0LFVVIZCSTawXWRxY4NEPK7H3wksmh
         DXFg==
X-Gm-Message-State: AOAM531PmP49d2cJeydlml50FXRBKZniWtdyhdhc+I/JGox7BWk6f8Nt
        vVTXDTtVCzA60c9Bft2Vm5KMwF7gMKQiKMBXZTizh/DsTe2WnRuYUhr+A7gr9PrcKkslmssqkIt
        V0QX/Zhz/60vd0RA/X2DCdGhOXejt6A==
X-Received: by 2002:a17:907:1c9c:: with SMTP id nb28mr2716575ejc.184.1636406103868;
        Mon, 08 Nov 2021 13:15:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4QqZU/VkYxF3YOj3RHNHloD3L2c05gPCP5lJ7BCylilFIGwHtbGvGkfcv6SWAoAi4JBIXIg==
X-Received: by 2002:a17:907:1c9c:: with SMTP id nb28mr2716530ejc.184.1636406103505;
        Mon, 08 Nov 2021 13:15:03 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id e13sm8450017eje.95.2021.11.08.13.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 13:15:03 -0800 (PST)
Date:   Mon, 8 Nov 2021 22:15:01 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 05/59] tools api fs: Move in the fncache from perf
Message-ID: <YYmTVRkRQXqN/MrT@krava>
References: <20211108133710.1352822-1-jolsa@kernel.org>
 <20211108133710.1352822-6-jolsa@kernel.org>
 <CAP-5=fWuAY=ML81CnujKGLu=-6PKqj6udt0sMzdr038T9Vaycw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWuAY=ML81CnujKGLu=-6PKqj6udt0sMzdr038T9Vaycw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 08, 2021 at 09:46:43AM -0800, Ian Rogers wrote:
> On Mon, Nov 8, 2021 at 5:37 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > Moving fncache from perf under libapi.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/api/fs/Build             |  1 +
> >  tools/lib/api/fs/fncache.c         | 63 ++++++++++++++++++++++++++++++
> >  tools/lib/api/fs/fs.h              |  2 +
> >  tools/perf/arch/x86/util/pmu.c     |  1 -
> >  tools/perf/tests/parse-events.c    |  1 -
> >  tools/perf/util/Build              |  1 -
> >  tools/perf/util/fncache.c          | 63 ------------------------------
> >  tools/perf/util/fncache.h          |  7 ----
> 
> This change looks like it could be independent. Could this code be
> simplified to just using a hashmap now that we have one?

true, Sohaib, perhaps you might be interest in this?

jirka

> 
> Thanks,
> Ian
> 
> >  tools/perf/util/pmu-hybrid.c       |  1 -
> >  tools/perf/util/pmu.c              |  1 -
> >  tools/perf/util/python-ext-sources |  1 -
> >  tools/perf/util/srccode.c          | 10 ++++-
> >  12 files changed, 75 insertions(+), 77 deletions(-)
> >  create mode 100644 tools/lib/api/fs/fncache.c
> >  delete mode 100644 tools/perf/util/fncache.c
> >  delete mode 100644 tools/perf/util/fncache.h
> >
> > diff --git a/tools/lib/api/fs/Build b/tools/lib/api/fs/Build
> > index 0f75b28654de..3af4b5265a5f 100644
> > --- a/tools/lib/api/fs/Build
> > +++ b/tools/lib/api/fs/Build
> > @@ -1,3 +1,4 @@
> >  libapi-y += fs.o
> >  libapi-y += tracing_path.o
> >  libapi-y += cgroup.o
> > +libapi-y += fncache.o
> > diff --git a/tools/lib/api/fs/fncache.c b/tools/lib/api/fs/fncache.c
> > new file mode 100644
> > index 000000000000..7fb4586c341a
> > --- /dev/null
> > +++ b/tools/lib/api/fs/fncache.c
> > @@ -0,0 +1,63 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Manage a cache of file names' existence */
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <string.h>
> > +#include <linux/list.h>
> > +#include "fs.h"
> > +
> > +struct fncache {
> > +       struct hlist_node nd;
> > +       bool res;
> > +       char name[];
> > +};
> > +
> > +#define FNHSIZE 61
> > +
> > +static struct hlist_head fncache_hash[FNHSIZE];
> > +
> > +static unsigned shash(const unsigned char *s)
> > +{
> > +       unsigned h = 0;
> > +       while (*s)
> > +               h = 65599 * h + *s++;
> > +       return h ^ (h >> 16);
> > +}
> > +
> > +static bool lookup_fncache(const char *name, bool *res)
> > +{
> > +       int h = shash((const unsigned char *)name) % FNHSIZE;
> > +       struct fncache *n;
> > +
> > +       hlist_for_each_entry(n, &fncache_hash[h], nd) {
> > +               if (!strcmp(n->name, name)) {
> > +                       *res = n->res;
> > +                       return true;
> > +               }
> > +       }
> > +       return false;
> > +}
> > +
> > +static void update_fncache(const char *name, bool res)
> > +{
> > +       struct fncache *n = malloc(sizeof(struct fncache) + strlen(name) + 1);
> > +       int h = shash((const unsigned char *)name) % FNHSIZE;
> > +
> > +       if (!n)
> > +               return;
> > +       strcpy(n->name, name);
> > +       n->res = res;
> > +       hlist_add_head(&n->nd, &fncache_hash[h]);
> > +}
> > +
> > +/* No LRU, only use when bounded in some other way. */
> > +bool file_available(const char *name)
> > +{
> > +       bool res;
> > +
> > +       if (lookup_fncache(name, &res))
> > +               return res;
> > +       res = access(name, R_OK) == 0;
> > +       update_fncache(name, res);
> > +       return res;
> > +}
> > diff --git a/tools/lib/api/fs/fs.h b/tools/lib/api/fs/fs.h
> > index aa222ca30311..c42d4ff30ca7 100644
> > --- a/tools/lib/api/fs/fs.h
> > +++ b/tools/lib/api/fs/fs.h
> > @@ -59,4 +59,6 @@ int sysfs__read_str(const char *entry, char **buf, size_t *sizep);
> >  int sysfs__read_bool(const char *entry, bool *value);
> >
> >  int sysfs__write_int(const char *entry, int value);
> > +
> > +bool file_available(const char *name);
> >  #endif /* __API_FS__ */
> > diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> > index 74d69db1ea99..c875dded65bb 100644
> > --- a/tools/perf/arch/x86/util/pmu.c
> > +++ b/tools/perf/arch/x86/util/pmu.c
> > @@ -13,7 +13,6 @@
> >  #include "../../../util/intel-pt.h"
> >  #include "../../../util/intel-bts.h"
> >  #include "../../../util/pmu.h"
> > -#include "../../../util/fncache.h"
> >
> >  #define TEMPLATE_ALIAS "%s/bus/event_source/devices/%s/alias"
> >
> > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> > index 8875e388563e..69381fe1655d 100644
> > --- a/tools/perf/tests/parse-events.c
> > +++ b/tools/perf/tests/parse-events.c
> > @@ -9,7 +9,6 @@
> >  #include "pmu-hybrid.h"
> >  #include <dirent.h>
> >  #include <errno.h>
> > -#include "fncache.h"
> >  #include <sys/types.h>
> >  #include <sys/stat.h>
> >  #include <unistd.h>
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 03d5d6ed7fe4..b93828aacc27 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -52,7 +52,6 @@ perf-y += header.o
> >  perf-y += callchain.o
> >  perf-y += values.o
> >  perf-y += debug.o
> > -perf-y += fncache.o
> >  perf-y += machine.o
> >  perf-y += map.o
> >  perf-y += pstack.o
> > diff --git a/tools/perf/util/fncache.c b/tools/perf/util/fncache.c
> > deleted file mode 100644
> > index 6225cbc52310..000000000000
> > --- a/tools/perf/util/fncache.c
> > +++ /dev/null
> > @@ -1,63 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0-only
> > -/* Manage a cache of file names' existence */
> > -#include <stdlib.h>
> > -#include <unistd.h>
> > -#include <string.h>
> > -#include <linux/list.h>
> > -#include "fncache.h"
> > -
> > -struct fncache {
> > -       struct hlist_node nd;
> > -       bool res;
> > -       char name[];
> > -};
> > -
> > -#define FNHSIZE 61
> > -
> > -static struct hlist_head fncache_hash[FNHSIZE];
> > -
> > -unsigned shash(const unsigned char *s)
> > -{
> > -       unsigned h = 0;
> > -       while (*s)
> > -               h = 65599 * h + *s++;
> > -       return h ^ (h >> 16);
> > -}
> > -
> > -static bool lookup_fncache(const char *name, bool *res)
> > -{
> > -       int h = shash((const unsigned char *)name) % FNHSIZE;
> > -       struct fncache *n;
> > -
> > -       hlist_for_each_entry(n, &fncache_hash[h], nd) {
> > -               if (!strcmp(n->name, name)) {
> > -                       *res = n->res;
> > -                       return true;
> > -               }
> > -       }
> > -       return false;
> > -}
> > -
> > -static void update_fncache(const char *name, bool res)
> > -{
> > -       struct fncache *n = malloc(sizeof(struct fncache) + strlen(name) + 1);
> > -       int h = shash((const unsigned char *)name) % FNHSIZE;
> > -
> > -       if (!n)
> > -               return;
> > -       strcpy(n->name, name);
> > -       n->res = res;
> > -       hlist_add_head(&n->nd, &fncache_hash[h]);
> > -}
> > -
> > -/* No LRU, only use when bounded in some other way. */
> > -bool file_available(const char *name)
> > -{
> > -       bool res;
> > -
> > -       if (lookup_fncache(name, &res))
> > -               return res;
> > -       res = access(name, R_OK) == 0;
> > -       update_fncache(name, res);
> > -       return res;
> > -}
> > diff --git a/tools/perf/util/fncache.h b/tools/perf/util/fncache.h
> > deleted file mode 100644
> > index fe020beaefb1..000000000000
> > --- a/tools/perf/util/fncache.h
> > +++ /dev/null
> > @@ -1,7 +0,0 @@
> > -#ifndef _FCACHE_H
> > -#define _FCACHE_H 1
> > -
> > -unsigned shash(const unsigned char *s);
> > -bool file_available(const char *name);
> > -
> > -#endif
> > diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
> > index f51ccaac60ee..65fdce81a384 100644
> > --- a/tools/perf/util/pmu-hybrid.c
> > +++ b/tools/perf/util/pmu-hybrid.c
> > @@ -13,7 +13,6 @@
> >  #include <stdarg.h>
> >  #include <locale.h>
> >  #include <api/fs/fs.h>
> > -#include "fncache.h"
> >  #include "pmu-hybrid.h"
> >
> >  LIST_HEAD(perf_pmu__hybrid_pmus);
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 55d834160428..13e1835955e0 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -26,7 +26,6 @@
> >  #include "header.h"
> >  #include "string2.h"
> >  #include "strbuf.h"
> > -#include "fncache.h"
> >  #include "pmu-hybrid.h"
> >
> >  struct perf_pmu perf_pmu__fake;
> > diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
> > index a685d20165f7..992a76c2af01 100644
> > --- a/tools/perf/util/python-ext-sources
> > +++ b/tools/perf/util/python-ext-sources
> > @@ -39,4 +39,3 @@ util/affinity.c
> >  util/rwsem.c
> >  util/hashmap.c
> >  util/pmu-hybrid.c
> > -util/fncache.c
> > diff --git a/tools/perf/util/srccode.c b/tools/perf/util/srccode.c
> > index 476e99896d5e..5c1ff87eb98c 100644
> > --- a/tools/perf/util/srccode.c
> > +++ b/tools/perf/util/srccode.c
> > @@ -16,7 +16,7 @@
> >  #include "srccode.h"
> >  #include "debug.h"
> >  #include <internal/lib.h> // page_size
> > -#include "fncache.h"
> > +#include <api/fs/fs.h>
> >
> >  #define MAXSRCCACHE (32*1024*1024)
> >  #define MAXSRCFILES     64
> > @@ -86,6 +86,14 @@ static void free_srcfile(struct srcfile *sf)
> >         num_srcfiles--;
> >  }
> >
> > +static unsigned shash(const unsigned char *s)
> > +{
> > +       unsigned h = 0;
> > +       while (*s)
> > +               h = 65599 * h + *s++;
> > +       return h ^ (h >> 16);
> > +}
> > +
> >  static struct srcfile *find_srcfile(char *fn)
> >  {
> >         struct stat st;
> > --
> > 2.31.1
> >
> 

