Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC34DC83F33
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Sep 2023 04:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351353AbjIDENu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Sep 2023 00:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350156AbjIDENu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Sep 2023 00:13:50 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E0AF9
        for <linux-perf-users@vger.kernel.org>; Sun,  3 Sep 2023 21:13:43 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-414ba610766so142061cf.0
        for <linux-perf-users@vger.kernel.org>; Sun, 03 Sep 2023 21:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693800823; x=1694405623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxRLIJBMnpHWUX8c55TV3jAg5ZMsiY7Ja0B+ws3qU0I=;
        b=SECqts0hzzZMQePvyiNDZxXe2rWNfkb2jtEaG/whXALR/DG1RdSu867HWqIgO2GmZW
         6/WM8lQxxqrArAWBhkjrPux5WoHliWyC1meE2tpHraMyP347sR7cJ6ZWksqIN9TFN5nA
         FX1jYkgkYpgIaxC9h7YhRtrC4w0bOxGdMimnKG1mIF7JeBGIR7FcI7EcnHNFlJ9BduO7
         JCWVds6XwNa3jZDrTZOmjuASjErozyG8Wb0OsMJ554SP79IfGDG7GiTt9BkbL6Z98ya7
         JseJLPTD8XQtMBXhbu4wR5CEaIWhGkockEVshcV7aJY4n65exdVhGOaVRToUlche8VnV
         TYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693800823; x=1694405623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxRLIJBMnpHWUX8c55TV3jAg5ZMsiY7Ja0B+ws3qU0I=;
        b=ftEiT/c8eYwwcNmKUpPjLfJmt5eu5gzzPkdYauyZUR/n4uSnYlESYo0S+S3H/70Ybf
         dokJ55Efx8QACeflZQQ02zwEWWmPrut41FEd4nPcSs3J2R1UtYeu3fY3E4IQYO7q2YYY
         fUuRskvRk/h8G4grY3f67zPyA13O1z4YKGLX2yKcWM5Aw1cCOiLY9SEfZDdeHgrqhPb0
         uD1D9bsgPjG3w4d2qVPfBeyCkezg5FFj/00UVhsFB9i8S/NReSYvVQfX5wZsxl/vhQnQ
         LYNO0b5hlW1kdYEpFBPNZfiGRt173n/E75b9v6bZlSicjzBUI8YlFItPGj0ZHqegIlBM
         rLag==
X-Gm-Message-State: AOJu0YyT2IcdzSskm4vflUerj8IjDL4Eqe0oRjZZPUcIM1HTk/rq6CKF
        BXWL6Ko4knHOcYoCf+eiDoAD2Ed3Mr7p1gv8vo+1kw==
X-Google-Smtp-Source: AGHT+IGlyxV52NBtbkkIhKQu6SiK2ry2Xd/ArZFMKlu0+UO9G2QwvMQ9h6JJeuEpIywTaCYA+DRoO25cS4y9wlCQcH0=
X-Received: by 2002:a05:622a:1053:b0:3f2:2c89:f1ef with SMTP id
 f19-20020a05622a105300b003f22c89f1efmr234865qte.5.1693800822937; Sun, 03 Sep
 2023 21:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230812084917.169338-1-yangjihong1@huawei.com> <20230812084917.169338-6-yangjihong1@huawei.com>
In-Reply-To: <20230812084917.169338-6-yangjihong1@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 3 Sep 2023 21:13:28 -0700
Message-ID: <CAP-5=fWLmRWPdnxSG1AcyxzaupUAn9sX0M-dtDB1dd7-FCEhrw@mail.gmail.com>
Subject: Re: [RFC v1 05/16] perf kwork: Overwrite original atom in the list
 when a new atom is pushed.
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, sandipan.das@amd.com,
        ravi.bangoria@amd.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Aug 12, 2023 at 1:52=E2=80=AFAM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> work_push_atom() supports nesting. Currently, all supported kworks are no=
t
> nested. A `overwrite` parameter is added to overwrite the original atom i=
n
> the list.
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/builtin-kwork.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 42ea59a957ae..f620911a26a2 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -392,9 +392,10 @@ static int work_push_atom(struct perf_kwork *kwork,
>                           struct evsel *evsel,
>                           struct perf_sample *sample,
>                           struct machine *machine,
> -                         struct kwork_work **ret_work)
> +                         struct kwork_work **ret_work,
> +                         bool overwrite)

kerneldoc would be useful. Pushing something seems self-evident but
what does overwrite mean without reading the code?

>  {
> -       struct kwork_atom *atom, *dst_atom;
> +       struct kwork_atom *atom, *dst_atom, *last_atom;
>         struct kwork_work *work, key;
>
>         BUG_ON(class->work_init =3D=3D NULL);
> @@ -427,6 +428,17 @@ static int work_push_atom(struct perf_kwork *kwork,
>         if (ret_work !=3D NULL)
>                 *ret_work =3D work;
>
> +       if (overwrite) {
> +               last_atom =3D list_last_entry_or_null(&work->atom_list[sr=
c_type],
> +                                                   struct kwork_atom, li=
st);
> +               if (last_atom) {
> +                       atom_del(last_atom);
> +
> +                       kwork->nr_skipped_events[src_type]++;
> +                       kwork->nr_skipped_events[KWORK_TRACE_MAX]++;
> +               }
> +       }
> +
>         list_add_tail(&atom->list, &work->atom_list[src_type]);
>
>         return 0;
> @@ -502,7 +514,7 @@ static int report_entry_event(struct perf_kwork *kwor=
k,
>  {
>         return work_push_atom(kwork, class, KWORK_TRACE_ENTRY,
>                               KWORK_TRACE_MAX, evsel, sample,
> -                             machine, NULL);
> +                             machine, NULL, true);

nit: for constant arguments it can be useful to add parameter names
which can enable checks like clang-tidy's bugprone argument:
https://clang.llvm.org/extra/clang-tidy/checks/bugprone/argument-comment.ht=
ml
This would make this:
        return work_push_atom(kwork, class, KWORK_TRACE_ENTRY,
                              KWORK_TRACE_MAX, evsel, sample,
                              machine, /*ret_work=3D*/NULL, /*overwite=3D*/=
true);

Thanks,
Ian

>  }
>
>  static int report_exit_event(struct perf_kwork *kwork,
> @@ -557,7 +569,7 @@ static int latency_raise_event(struct perf_kwork *kwo=
rk,
>  {
>         return work_push_atom(kwork, class, KWORK_TRACE_RAISE,
>                               KWORK_TRACE_MAX, evsel, sample,
> -                             machine, NULL);
> +                             machine, NULL, true);
>  }
>
>  static int latency_entry_event(struct perf_kwork *kwork,
> @@ -716,7 +728,7 @@ static int timehist_raise_event(struct perf_kwork *kw=
ork,
>  {
>         return work_push_atom(kwork, class, KWORK_TRACE_RAISE,
>                               KWORK_TRACE_MAX, evsel, sample,
> -                             machine, NULL);
> +                             machine, NULL, true);
>  }
>
>  static int timehist_entry_event(struct perf_kwork *kwork,
> @@ -730,7 +742,7 @@ static int timehist_entry_event(struct perf_kwork *kw=
ork,
>
>         ret =3D work_push_atom(kwork, class, KWORK_TRACE_ENTRY,
>                              KWORK_TRACE_RAISE, evsel, sample,
> -                            machine, &work);
> +                            machine, &work, true);
>         if (ret)
>                 return ret;
>
> --
> 2.30.GIT
>
