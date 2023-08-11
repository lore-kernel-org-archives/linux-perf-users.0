Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC361EB64DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Aug 2023 15:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbjHKPTc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Aug 2023 11:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbjHKPTW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Aug 2023 11:19:22 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE0830E8
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Aug 2023 08:19:13 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40a47e8e38dso233831cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Aug 2023 08:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691767152; x=1692371952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ge5Vnfmxyw0WWYcJ8Y5T1OVpnNu9VXbDz6SZdgZAO5s=;
        b=TXuDKwz5Rh2tMvstysUlaDrjzn40RmL1dktFB+nt5IcmfJtT/KCs0tAIw6K4p2MYwP
         /vaUBTB5+N+fmy0Aar8CtRyGbxO33ztkoQCNGbwiAyyqtfU9P9MY/mgSXHVzWXhjLIGX
         XQviezS8VVsxpVY5kwpqHwqXmqg+FmsKnAt1WyMiXoFmgFPBYvirCE30VrkS0K8ncE1x
         zQQ36YBn4l+47sGUZvI0qrO9kKDB5o08BPfJOsz2/tUVdLa+1UIqlihnKOTAF6qwrc65
         bsJvkd740qF8Fl7opgr7DXt72e/f7mUXxg7oSFfj0J9A9LB3tO6URy6QIfyzPO4LBl8k
         Tcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691767152; x=1692371952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ge5Vnfmxyw0WWYcJ8Y5T1OVpnNu9VXbDz6SZdgZAO5s=;
        b=II0AKZA1/FKtB7PPh8wj/8TURa+vYY7tkmfaUOp+2DACcTmWbMqGNPG2dftY9QEXeV
         R5gOTpMn4Cx8Q+7C2S2mDJRI+Mu8q2yveEHCTcxuHOeF/KOWaXODWgiM2R64oFl+9gYE
         h6hSpP58IQvosW7eZYaOptRqVNs6lePY3tHEGx8I27oTZWMnYvFXJwhKXjohZOF9PDxe
         njZac9Haj2VKq7xiF0EXKmnsQRf7UL6gJQbD0KW79j1fkY2vnfPXYYQEcU1vph3uFJBw
         TuQ8UkDKhjQ2iDTqstYm30kM6d4h9JhLGx9ansnieHKB2hNYnj3fzrp+s/Y16kGpeqou
         ZQNw==
X-Gm-Message-State: AOJu0Yz9Vo7+bHhn4I5oISs8CQ5U/89iks0APKW8Iy65hGPc2rfoxaVQ
        lV9Bwh606MeVBqyapWxFIMNUgl1qLaEo4CAnpiZxqQ==
X-Google-Smtp-Source: AGHT+IGp2Wpzl76g37ohXtoX5FLv/ckVOtcpucSJbcbTJrfxs43s9qKPIfw8mWBLihiEMAjaAm4FTooS3tlCkhXQuUw=
X-Received: by 2002:ac8:5c0c:0:b0:403:fdf1:e05e with SMTP id
 i12-20020ac85c0c000000b00403fdf1e05emr213400qti.19.1691767152122; Fri, 11 Aug
 2023 08:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230810214952.2934029-1-irogers@google.com> <20230810214952.2934029-2-irogers@google.com>
 <ZNY+BHUFETc2eNib@kernel.org>
In-Reply-To: <ZNY+BHUFETc2eNib@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 11 Aug 2023 08:19:00 -0700
Message-ID: <CAP-5=fXPBVmSxt=96wyRJnDu-Hm6oPxt8XxG2_9P-FfH4VFDGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf pmus: Sort pmus by name then suffix
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 11, 2023 at 6:56=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Aug 10, 2023 at 02:49:50PM -0700, Ian Rogers escreveu:
> > Sort PMUs by name. If two PMUs have the same name but differ by
> > suffix, sort the suffixes numerically. For example, "breakpoint" comes
> > before "cpu", "uncore_imc_free_running_0" comes before
> > "uncore_imc_free_running_1".
>
> Why is this needed?

It is needed so that in the later patches we just "perf list" the
uncore_imc_free_running_0 and skip all the other suffix numbers.
Sorting using strcmp isn't sufficient as consider uncore_imc_10 and
uncore_imc_9, where 9 would appear before 10 if only the characters
were being compared.

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmus.c | 48 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index c58ba9fb6a36..3581710667b0 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -1,8 +1,10 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/list.h>
> > +#include <linux/list_sort.h>
> >  #include <linux/zalloc.h>
> >  #include <subcmd/pager.h>
> >  #include <sys/types.h>
> > +#include <ctype.h>
> >  #include <dirent.h>
> >  #include <pthread.h>
> >  #include <string.h>
> > @@ -33,6 +35,31 @@ static LIST_HEAD(other_pmus);
> >  static bool read_sysfs_core_pmus;
> >  static bool read_sysfs_all_pmus;
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
> >  void perf_pmus__destroy(void)
> >  {
> >       struct perf_pmu *pmu, *tmp;
> > @@ -122,6 +149,25 @@ static struct perf_pmu *perf_pmu__find2(int dirfd,=
 const char *name)
> >       return perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirf=
d, name);
> >  }
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
> > +     int ret =3D strncmp(lhs_pmu_name, rhs_pmu_name,
> > +                     lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_nam=
e_len : rhs_pmu_name_len);
> > +
> > +     if (lhs_pmu_name_len !=3D rhs_pmu_name_len || ret !=3D 0 || lhs_p=
mu_name_len =3D=3D 0)
> > +             return ret;
> > +
> > +     return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
> > +}
> > +
> >  /* Add all pmus in sysfs to pmu list: */
> >  static void pmu_read_sysfs(bool core_only)
> >  {
> > @@ -156,6 +202,8 @@ static void pmu_read_sysfs(bool core_only)
> >               if (!perf_pmu__create_placeholder_core_pmu(&core_pmus))
> >                       pr_err("Failure to set up any core PMUs\n");
> >       }
> > +     list_sort(NULL, &core_pmus, pmus_cmp);
> > +     list_sort(NULL, &other_pmus, pmus_cmp);
> >       if (!list_empty(&core_pmus)) {
> >               read_sysfs_core_pmus =3D true;
> >               if (!core_only)
> > --
> > 2.41.0.640.ga95def55d0-goog
> >
>
> --
>
> - Arnaldo
