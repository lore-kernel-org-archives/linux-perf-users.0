Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F08C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 17:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C080619E2
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 17:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbhKHRtr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 12:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239344AbhKHRtp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 12:49:45 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D95C061205
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Nov 2021 09:46:58 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id i11so8578690ilv.13
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 09:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gL4f+uKMoFEgSLUPCavceI+LSF7SH6xXDYYLwfmYtY=;
        b=TyIpz3NdTe/ILhnpAb+NULakeAsapfU3bBrcdl+yztaU0iqi433It1qtUDjm/A4OM9
         o1h3qFoMAebSL3uHJ923ciBb6aayi5oaUaqUUM4Io+k6fc1Xoy0KiXwtEY8fT+SAbg8A
         L4sNj9mrt/vUg4COnzEM81xCowy9JcGYEjURNZ2/U48KwyP0Dry8keEfSWKbRtCoUHyo
         JLWhOW/CPiPB5awLZLd3hcRCDOZ2HqDxRrOaDA2uXErz5OgdqH8fYAOhlCWO1HOpjlJS
         3qA4NDlYVUWXEdp1+H54LQja921tc2p+HQqcx3ja93l1WHwHIaBitAhEWmXgLw5Ux7rQ
         8k6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gL4f+uKMoFEgSLUPCavceI+LSF7SH6xXDYYLwfmYtY=;
        b=uHIUNTWTyn7Q3ZdNEEWncExh+ck2OaaNWeWheYQijYtEJSz/aimOgD1iC4CgpzFcoL
         G1JxK/XptfBRjlpyUT+ADrzX0pOuDsxpFE8NYMZDIx8cHN8Jz6EzvGSRKqMwSyhMdE9D
         q/WuinFO47TkTXUn8U1N9qSEQZSiSE6boqJgjzuLkWwZy+IyI+7SUkD6aIy2oubTQsLp
         gURuunGU5yN0hItUUiv2Xee++2PD9t0Lsp7Ukdv6V529A3tWo7RIfR0HrWBPPb/U7AQW
         KDgXrswls3EzptAMcpequqnVg+jrJHceq5/sQZkVlJTMwyo3Ia3WFJ3M+zZv8wmrn18p
         6ZSg==
X-Gm-Message-State: AOAM532kXUgLDwoisDsc3NXyyIu1ftBSmIC/EFJvVSfa1EER5sCu9J3a
        Xw3M1Re6foAvSwTdR1IWds5E3MDBUdnGiewi+n8167pgkvM=
X-Google-Smtp-Source: ABdhPJz1EcMaIOZ8K3PqyJcxj67ohMVmoN9YGnfPTUcozx4KNjLpE5jCyMvNE9H6aPLXkwBncRfwNzAbxVwjv6vWKSo=
X-Received: by 2002:a05:6e02:1048:: with SMTP id p8mr609326ilj.174.1636393617995;
 Mon, 08 Nov 2021 09:46:57 -0800 (PST)
MIME-Version: 1.0
References: <20211108133710.1352822-1-jolsa@kernel.org> <20211108133710.1352822-6-jolsa@kernel.org>
In-Reply-To: <20211108133710.1352822-6-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 8 Nov 2021 09:46:43 -0800
Message-ID: <CAP-5=fWuAY=ML81CnujKGLu=-6PKqj6udt0sMzdr038T9Vaycw@mail.gmail.com>
Subject: Re: [PATCH 05/59] tools api fs: Move in the fncache from perf
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 8, 2021 at 5:37 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> Moving fncache from perf under libapi.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/api/fs/Build             |  1 +
>  tools/lib/api/fs/fncache.c         | 63 ++++++++++++++++++++++++++++++
>  tools/lib/api/fs/fs.h              |  2 +
>  tools/perf/arch/x86/util/pmu.c     |  1 -
>  tools/perf/tests/parse-events.c    |  1 -
>  tools/perf/util/Build              |  1 -
>  tools/perf/util/fncache.c          | 63 ------------------------------
>  tools/perf/util/fncache.h          |  7 ----

This change looks like it could be independent. Could this code be
simplified to just using a hashmap now that we have one?

Thanks,
Ian

>  tools/perf/util/pmu-hybrid.c       |  1 -
>  tools/perf/util/pmu.c              |  1 -
>  tools/perf/util/python-ext-sources |  1 -
>  tools/perf/util/srccode.c          | 10 ++++-
>  12 files changed, 75 insertions(+), 77 deletions(-)
>  create mode 100644 tools/lib/api/fs/fncache.c
>  delete mode 100644 tools/perf/util/fncache.c
>  delete mode 100644 tools/perf/util/fncache.h
>
> diff --git a/tools/lib/api/fs/Build b/tools/lib/api/fs/Build
> index 0f75b28654de..3af4b5265a5f 100644
> --- a/tools/lib/api/fs/Build
> +++ b/tools/lib/api/fs/Build
> @@ -1,3 +1,4 @@
>  libapi-y += fs.o
>  libapi-y += tracing_path.o
>  libapi-y += cgroup.o
> +libapi-y += fncache.o
> diff --git a/tools/lib/api/fs/fncache.c b/tools/lib/api/fs/fncache.c
> new file mode 100644
> index 000000000000..7fb4586c341a
> --- /dev/null
> +++ b/tools/lib/api/fs/fncache.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Manage a cache of file names' existence */
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <linux/list.h>
> +#include "fs.h"
> +
> +struct fncache {
> +       struct hlist_node nd;
> +       bool res;
> +       char name[];
> +};
> +
> +#define FNHSIZE 61
> +
> +static struct hlist_head fncache_hash[FNHSIZE];
> +
> +static unsigned shash(const unsigned char *s)
> +{
> +       unsigned h = 0;
> +       while (*s)
> +               h = 65599 * h + *s++;
> +       return h ^ (h >> 16);
> +}
> +
> +static bool lookup_fncache(const char *name, bool *res)
> +{
> +       int h = shash((const unsigned char *)name) % FNHSIZE;
> +       struct fncache *n;
> +
> +       hlist_for_each_entry(n, &fncache_hash[h], nd) {
> +               if (!strcmp(n->name, name)) {
> +                       *res = n->res;
> +                       return true;
> +               }
> +       }
> +       return false;
> +}
> +
> +static void update_fncache(const char *name, bool res)
> +{
> +       struct fncache *n = malloc(sizeof(struct fncache) + strlen(name) + 1);
> +       int h = shash((const unsigned char *)name) % FNHSIZE;
> +
> +       if (!n)
> +               return;
> +       strcpy(n->name, name);
> +       n->res = res;
> +       hlist_add_head(&n->nd, &fncache_hash[h]);
> +}
> +
> +/* No LRU, only use when bounded in some other way. */
> +bool file_available(const char *name)
> +{
> +       bool res;
> +
> +       if (lookup_fncache(name, &res))
> +               return res;
> +       res = access(name, R_OK) == 0;
> +       update_fncache(name, res);
> +       return res;
> +}
> diff --git a/tools/lib/api/fs/fs.h b/tools/lib/api/fs/fs.h
> index aa222ca30311..c42d4ff30ca7 100644
> --- a/tools/lib/api/fs/fs.h
> +++ b/tools/lib/api/fs/fs.h
> @@ -59,4 +59,6 @@ int sysfs__read_str(const char *entry, char **buf, size_t *sizep);
>  int sysfs__read_bool(const char *entry, bool *value);
>
>  int sysfs__write_int(const char *entry, int value);
> +
> +bool file_available(const char *name);
>  #endif /* __API_FS__ */
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index 74d69db1ea99..c875dded65bb 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -13,7 +13,6 @@
>  #include "../../../util/intel-pt.h"
>  #include "../../../util/intel-bts.h"
>  #include "../../../util/pmu.h"
> -#include "../../../util/fncache.h"
>
>  #define TEMPLATE_ALIAS "%s/bus/event_source/devices/%s/alias"
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 8875e388563e..69381fe1655d 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -9,7 +9,6 @@
>  #include "pmu-hybrid.h"
>  #include <dirent.h>
>  #include <errno.h>
> -#include "fncache.h"
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <unistd.h>
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 03d5d6ed7fe4..b93828aacc27 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -52,7 +52,6 @@ perf-y += header.o
>  perf-y += callchain.o
>  perf-y += values.o
>  perf-y += debug.o
> -perf-y += fncache.o
>  perf-y += machine.o
>  perf-y += map.o
>  perf-y += pstack.o
> diff --git a/tools/perf/util/fncache.c b/tools/perf/util/fncache.c
> deleted file mode 100644
> index 6225cbc52310..000000000000
> --- a/tools/perf/util/fncache.c
> +++ /dev/null
> @@ -1,63 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/* Manage a cache of file names' existence */
> -#include <stdlib.h>
> -#include <unistd.h>
> -#include <string.h>
> -#include <linux/list.h>
> -#include "fncache.h"
> -
> -struct fncache {
> -       struct hlist_node nd;
> -       bool res;
> -       char name[];
> -};
> -
> -#define FNHSIZE 61
> -
> -static struct hlist_head fncache_hash[FNHSIZE];
> -
> -unsigned shash(const unsigned char *s)
> -{
> -       unsigned h = 0;
> -       while (*s)
> -               h = 65599 * h + *s++;
> -       return h ^ (h >> 16);
> -}
> -
> -static bool lookup_fncache(const char *name, bool *res)
> -{
> -       int h = shash((const unsigned char *)name) % FNHSIZE;
> -       struct fncache *n;
> -
> -       hlist_for_each_entry(n, &fncache_hash[h], nd) {
> -               if (!strcmp(n->name, name)) {
> -                       *res = n->res;
> -                       return true;
> -               }
> -       }
> -       return false;
> -}
> -
> -static void update_fncache(const char *name, bool res)
> -{
> -       struct fncache *n = malloc(sizeof(struct fncache) + strlen(name) + 1);
> -       int h = shash((const unsigned char *)name) % FNHSIZE;
> -
> -       if (!n)
> -               return;
> -       strcpy(n->name, name);
> -       n->res = res;
> -       hlist_add_head(&n->nd, &fncache_hash[h]);
> -}
> -
> -/* No LRU, only use when bounded in some other way. */
> -bool file_available(const char *name)
> -{
> -       bool res;
> -
> -       if (lookup_fncache(name, &res))
> -               return res;
> -       res = access(name, R_OK) == 0;
> -       update_fncache(name, res);
> -       return res;
> -}
> diff --git a/tools/perf/util/fncache.h b/tools/perf/util/fncache.h
> deleted file mode 100644
> index fe020beaefb1..000000000000
> --- a/tools/perf/util/fncache.h
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -#ifndef _FCACHE_H
> -#define _FCACHE_H 1
> -
> -unsigned shash(const unsigned char *s);
> -bool file_available(const char *name);
> -
> -#endif
> diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
> index f51ccaac60ee..65fdce81a384 100644
> --- a/tools/perf/util/pmu-hybrid.c
> +++ b/tools/perf/util/pmu-hybrid.c
> @@ -13,7 +13,6 @@
>  #include <stdarg.h>
>  #include <locale.h>
>  #include <api/fs/fs.h>
> -#include "fncache.h"
>  #include "pmu-hybrid.h"
>
>  LIST_HEAD(perf_pmu__hybrid_pmus);
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 55d834160428..13e1835955e0 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -26,7 +26,6 @@
>  #include "header.h"
>  #include "string2.h"
>  #include "strbuf.h"
> -#include "fncache.h"
>  #include "pmu-hybrid.h"
>
>  struct perf_pmu perf_pmu__fake;
> diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
> index a685d20165f7..992a76c2af01 100644
> --- a/tools/perf/util/python-ext-sources
> +++ b/tools/perf/util/python-ext-sources
> @@ -39,4 +39,3 @@ util/affinity.c
>  util/rwsem.c
>  util/hashmap.c
>  util/pmu-hybrid.c
> -util/fncache.c
> diff --git a/tools/perf/util/srccode.c b/tools/perf/util/srccode.c
> index 476e99896d5e..5c1ff87eb98c 100644
> --- a/tools/perf/util/srccode.c
> +++ b/tools/perf/util/srccode.c
> @@ -16,7 +16,7 @@
>  #include "srccode.h"
>  #include "debug.h"
>  #include <internal/lib.h> // page_size
> -#include "fncache.h"
> +#include <api/fs/fs.h>
>
>  #define MAXSRCCACHE (32*1024*1024)
>  #define MAXSRCFILES     64
> @@ -86,6 +86,14 @@ static void free_srcfile(struct srcfile *sf)
>         num_srcfiles--;
>  }
>
> +static unsigned shash(const unsigned char *s)
> +{
> +       unsigned h = 0;
> +       while (*s)
> +               h = 65599 * h + *s++;
> +       return h ^ (h >> 16);
> +}
> +
>  static struct srcfile *find_srcfile(char *fn)
>  {
>         struct stat st;
> --
> 2.31.1
>
