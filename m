Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37EBEB64DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Aug 2023 15:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjHKPPo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Aug 2023 11:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjHKPPn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Aug 2023 11:15:43 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990E130C4
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Aug 2023 08:15:42 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40c72caec5cso237641cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Aug 2023 08:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691766942; x=1692371742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCQOMCIJ3ODl+wGkuZQNLRUnlNxhV/C4QcKoC6aSRCU=;
        b=nxhadB45gvyyW3RU+s6Rjz4Qte+JR0MKkNMB2g7qtsW9MX8Lpkg7dlLvDPUs+fmZ0t
         7mE8bA0q+dcfIzEw6ieEuh2LuGBzYnuEcMlRzOpUz7+5ZGw0QZbiki7QNkTK29hhKcbs
         ceq8Ek6TN+VwUTydTCjLXGsZUlo/dFjqOMvsdKlL1mK+v1RcDSFmPUErQFvLymt5wN0c
         WFLQr2toFDRqSqFQx9vMdOVUso0vm/+bUBdFfGQNBbkd0N/zxgSsLDFB5L3GaljhIg87
         zAL1drLoxBy8Eh9I7vcXFJQ+fuO5NeHglD5U7QOHHJ0FbLzikCrYF2FVaJA71gmxUPNn
         EDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691766942; x=1692371742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCQOMCIJ3ODl+wGkuZQNLRUnlNxhV/C4QcKoC6aSRCU=;
        b=fCkbhk89E+z9b080fpRL/UnzuKGkzAg733biMMxxCzc2jd6GtM1VMjb0l8wlttHIEs
         R7itpqhDMqDJNg4TIX+jlZFnildUZztqiC+77oPMzlnd/e6Ety1EcHhlh85K5MeBKoSW
         kDK3B2Y9AwCs52UKaMyErEeuPd2pLRFMzCPwjJbAX4YuS8YFFJ/FmR6Xa4VcwqXyiYXB
         JP79ZTyWRL4zycdjbj+Vh9rDDbjbvM+mEpDZCKdsdejpuKEsmJm5oQRcFx0YhIwnODlI
         kzNP7jAWEBIvTxHgL7YBsIejL2AjwQdyNpoPqwvZ90l+MBsoAbeN0qrtZrxMpDdUqFVg
         5MAw==
X-Gm-Message-State: AOJu0YzvqwlxhWfVClYQHHU/0qZUhSu07lUeQF1v7KpqULoJQHv9qKUq
        teIjtwWC/BFiRoAMnAqlNZKcXuXKe8Dc2tTQE06P0Q==
X-Google-Smtp-Source: AGHT+IFAo1gfZpJm2w3fztRZ61lsrzHk0CI8mcd0eQ6JVoajj7kFVWXv4p9cq7MfOaNJMxVjMWV8oW3hL99mMtFDo3w=
X-Received: by 2002:a05:622a:1888:b0:3f5:2006:50f1 with SMTP id
 v8-20020a05622a188800b003f5200650f1mr240726qtc.12.1691766941556; Fri, 11 Aug
 2023 08:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230810214952.2934029-1-irogers@google.com> <20230810214952.2934029-2-irogers@google.com>
 <ac57e637-7281-59b8-5658-3195e6d335f5@oracle.com>
In-Reply-To: <ac57e637-7281-59b8-5658-3195e6d335f5@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 11 Aug 2023 08:15:30 -0700
Message-ID: <CAP-5=fXETrt00wNVR6JifpHAF2kYHF9WU1z8uVfo+Gr7jw1S+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf pmus: Sort pmus by name then suffix
To:     John Garry <john.g.garry@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 11, 2023 at 7:00=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 10/08/2023 22:49, Ian Rogers wrote:
> > Sort PMUs by name. If two PMUs have the same name but differ by
> > suffix
>
> I think that the wording here can be improved. If they have the same
> name, then they cannot differ. I think that you mean that two PMUs have
> the same name apart from a difference in suffix.

Sure.

> > , sort the suffixes numerically.
>
> I don't know how this will affect some hisi pmus which have special
> naming formats, like hisi_l3c_sscl1_4

Anything not starting with uncore_ is assumed not to have a suffix.

> > For example, "breakpoint" comes
> > before "cpu", "uncore_imc_free_running_0" comes before
> > "uncore_imc_free_running_1".
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/util/pmus.c | 48 +++++++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 48 insertions(+)
> >
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index c58ba9fb6a36..3581710667b0 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -1,8 +1,10 @@
> >   // SPDX-License-Identifier: GPL-2.0
> >   #include <linux/list.h>
> > +#include <linux/list_sort.h>
> >   #include <linux/zalloc.h>
> >   #include <subcmd/pager.h>
> >   #include <sys/types.h>
> > +#include <ctype.h>
> >   #include <dirent.h>
> >   #include <pthread.h>
> >   #include <string.h>
> > @@ -33,6 +35,31 @@ static LIST_HEAD(other_pmus);
> >   static bool read_sysfs_core_pmus;
> >   static bool read_sysfs_all_pmus;
> >
> > +static int pmu_name_len_no_suffix(const char *str, unsigned long *num)
> > +{
> > +     int orig_len, len;
> > +
> > +     orig_len =3D len =3D strlen(str);
> > +
> > +     /* Non-uncore PMUs have their full length, for example, i915. */
> > +     if (strncmp(str, "uncore_", 7))
> > +             return len;
> > +
> > +     /*
> > +      * Count trailing digits and '_', if '_{num}' suffix isn't presen=
t use
> > +      * the full length.
> > +      */
> > +     while (len > 0 && isdigit(str[len - 1]))
> > +             len--;
> > +
> > +     if (len > 0 && len !=3D orig_len && str[len - 1] =3D=3D '_') {
> > +             if (num)
> > +                     *num =3D strtoul(&str[len], NULL, 10);
> > +             return len - 1;
> > +     }
> > +     return orig_len;
> > +}
> > +
> >   void perf_pmus__destroy(void)
> >   {
> >       struct perf_pmu *pmu, *tmp;
> > @@ -122,6 +149,25 @@ static struct perf_pmu *perf_pmu__find2(int dirfd,=
 const char *name)
> >       return perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirf=
d, name);
> >   }
> >
> > +static int pmus_cmp(void *priv __maybe_unused,
> > +                 const struct list_head *lhs, const struct list_head *=
rhs)
> > +{
> > +     unsigned long lhs_num, rhs_num;
> > +     struct perf_pmu *lhs_pmu =3D container_of(lhs, struct perf_pmu, l=
ist);
> > +     struct perf_pmu *rhs_pmu =3D container_of(rhs, struct perf_pmu, l=
ist);
> > +     const char *lhs_pmu_name =3D lhs_pmu->name ?: "";
> > +     const char *rhs_pmu_name =3D rhs_pmu->name ?: "";
> > +     int lhs_pmu_name_len =3D pmu_name_len_no_suffix(lhs_pmu_name, &lh=
s_num);
> > +     int rhs_pmu_name_len =3D pmu_name_len_no_suffix(rhs_pmu_name, &rh=
s_num);
>
>
> This is a bit of a monster... at least it should have a comment on what
> it is doing. Do you consider your own version of strncmp which can
> handle numbers in the suffix as another solution?

Sure, the intention is to be intention revealing getting a left hand
and right hand pmu name, the length of the name part and the suffix
number. I'm not sure a comment can do more than restate what the code
is doing.

> > +     int ret =3D strncmp(lhs_pmu_name, rhs_pmu_name,
> > +                     lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_nam=
e_len : rhs_pmu_name_len);
>
> Could min(lhs_pmu_name_len, rhs_pmu_name_len) be used here?

Right, there is a suitable definition in linux/kernel.h

> > +
> > +     if (lhs_pmu_name_len !=3D rhs_pmu_name_len || ret !=3D 0 || lhs_p=
mu_name_len =3D=3D 0)
> > +             return ret;
> > +
> > +     return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
>
> double ternary operator on same line ain't great - can this be changed
> into multiple return statements and also commented.

The alternative is:
return lhs_num  - rhs_num;
which removes the compares and has a bug around minimum integer
everybody ignores.

Thanks,
Ian

> > +}
> > +
> >   /* Add all pmus in sysfs to pmu list: */
> >   static void pmu_read_sysfs(bool core_only)
> >   {
> > @@ -156,6 +202,8 @@ static void pmu_read_sysfs(bool core_only)
> >               if (!perf_pmu__create_placeholder_core_pmu(&core_pmus))
> >                       pr_err("Failure to set up any core PMUs\n");
> >       }
> > +     list_sort(NULL, &core_pmus, pmus_cmp);
> > +     list_sort(NULL, &other_pmus, pmus_cmp);
> >       if (!list_empty(&core_pmus)) {
> >               read_sysfs_core_pmus =3D true;
> >               if (!core_only)
>
