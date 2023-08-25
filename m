Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB70AC3DA66
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 04:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbjHYEwK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 00:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240527AbjHYEvh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 00:51:37 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BFD1FEB
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 21:51:34 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40a47e8e38dso102521cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 21:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692939093; x=1693543893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPFyyKMSssNX8avgS44LTxp2qnFm6/B0jvZ21cpGXLk=;
        b=FBl1UivoDQtUIUksVjHTkoZ6n2tK7zRoU6FiOsFc0VFCTsH8gcBw00EL6qyN2a5+sb
         iK+rQhhFr89SgCJVZ71zNQsQH4P9tCekaR7zI7xsLIGq3ouwhuyM3N21/HOvVjyrsWvD
         JxfUaA82T9pbQ1uqSQS0d6PukVs+lR13M57PGDMt2OuUc4qeltboMRxkmi4mndYonQ1O
         sLpNjTXL9uxW2BPBEy1NbbNoBhkGQJ1fG0e3KijOM4Qsye2/Hgw6aBgYysDzwkAf+RaN
         TjIz5O4B0sWV155jmCJPrr661QMaIYymyL+89yvFfTXYHlNn9zPzUOMolurN4PWqZsL1
         ovRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692939093; x=1693543893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPFyyKMSssNX8avgS44LTxp2qnFm6/B0jvZ21cpGXLk=;
        b=X5aD01mWALIIeWXpszJFAr88To5FldT0mq1g5FUNsbFi5xCWHJPjO/2CCMJ2v3krNp
         ws2yXvIh3HgBnf7H0icEQvh4+G6iKj0mxCU1JcAPO3VuUYAvNHY41EW/CL9P8MUC3KJa
         SbRNzEW5QbNnzRwSCBPcrKz+x7bhc09Bh90r43lwnJRpfdxZjJs/Aeu54k5ZL+bu63uA
         6Q7iizBJnYogj5/m+1qGdb+NfGmKHaO/izWdSx1eIdX0jvy0xqh1PwVVtfzbdCTCX6em
         uMWyUQsg3jGocyAR+lbM/YyS0kgwLeHUBc1XCU+UY973XRAFuKPsrgjKNB106QPRpzBC
         OaYg==
X-Gm-Message-State: AOJu0YxCURcLRXkzeQMnlDi9Ljv89s91GWqW+Pk29PSdsgFTn71ExW0I
        l0eSZwFIkTLIh4THjWyMEljJVKIIcR2FMzd2Kg9cGQ==
X-Google-Smtp-Source: AGHT+IEDndaQpZqCUxYnXWbxxdq4b7vxoWXcbvDIOtr2iuaNWb0yaxCQqreDRgTOsMCtCqcAiJKKakJxRPLmmS7OLhQ=
X-Received: by 2002:a05:622a:1748:b0:404:8218:83da with SMTP id
 l8-20020a05622a174800b00404821883damr118639qtk.1.1692939093178; Thu, 24 Aug
 2023 21:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230821012734.18241-1-yangjihong1@huawei.com> <20230821012734.18241-2-yangjihong1@huawei.com>
In-Reply-To: <20230821012734.18241-2-yangjihong1@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 21:51:22 -0700
Message-ID: <CAP-5=fXexLBnq1pkHPR5uXR-bL3CFTzEWkFnxHVs-71+S0yZSg@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] perf evlist: Add perf_evlist__go_system_wide() helper
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Aug 20, 2023 at 6:30=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> For dummy events that keep tracking, we may need to modify its cpu_maps.
> For example, change the cpu_maps to record sideband events for all CPUS.
> Add perf_evlist__go_system_wide() helper to support this scenario.
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/lib/perf/evlist.c                  | 9 +++++++++
>  tools/lib/perf/include/internal/evlist.h | 2 ++
>  2 files changed, 11 insertions(+)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index b8b066d0dc5e..3acbbccc1901 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -738,3 +738,12 @@ int perf_evlist__nr_groups(struct perf_evlist *evlis=
t)
>         }
>         return nr_groups;
>  }
> +
> +void perf_evlist__go_system_wide(struct perf_evlist *evlist, struct perf=
_evsel *evsel)
> +{
> +       if (!evsel->system_wide) {
> +               evsel->system_wide =3D true;
> +               if (evlist->needs_map_propagation)
> +                       __perf_evlist__propagate_maps(evlist, evsel);
> +       }
> +}

I think this should be:

void evsel__set_system_wide(struct evsel *evsel)
{
        if (evsel->system_wide)
               return;
        evsel->system_wide =3D true;
        if (evsel->evlist->core.needs_map_propagation)
...

The API being on evlist makes it look like all evsels are affected.

Thanks,
Ian

> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/in=
clude/internal/evlist.h
> index 3339bc2f1765..d86ffe8ed483 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -135,4 +135,6 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist=
,
>  void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
>
>  void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel=
 *leader);
> +
> +void perf_evlist__go_system_wide(struct perf_evlist *evlist, struct perf=
_evsel *evsel);
>  #endif /* __LIBPERF_INTERNAL_EVLIST_H */
> --
> 2.30.GIT
>
