Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F3CC001E0
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Jul 2023 16:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjGSQpb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Jul 2023 12:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjGSQpU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2023 12:45:20 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592A41FF6
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Jul 2023 09:45:09 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40371070eb7so561cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Jul 2023 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689785108; x=1692377108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eouzQn1DE3Woy1acpRFuk9bMIN105v+sSKwoOHp8Q8=;
        b=iSnTbfngNexifbTiJuj1A6pSo2Dvmra91A6H2aTFXGTdtnmF/hweiXJatXvaYyRH94
         iFaeVyWCgEhGxoqSM88bbB5h/kHIQ4+2SIKEKGbRuXgqduISr1qluykNMSfYxdOtjT0Z
         9amcHsbdvG0+WiWUIR7y5qGp47GKcUf0Ia5qYmCmP8su/ZuOaRG+Q9bccR+PKJPVIPcm
         dSwucDH1R0BIkkXmAryUDhGrC8AXwBv9q0SPJH9gY24OoBpqYaas2WdyHp2R2W13TBoc
         9kvQHu8ZIJG10bA4EMIUhJu+4iYx5Z933YapDLepmhz1hgqrbZQLBPVCCHJXKMJIn+Zi
         EvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689785108; x=1692377108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eouzQn1DE3Woy1acpRFuk9bMIN105v+sSKwoOHp8Q8=;
        b=TlHzhsxW3nsZZfjbv14fGmcxWueSv71BnB1+poZmJqukN751GXhBcqvVouFAVU6ngx
         sMl/S+5yhDhTlWkHdhB7sn7g1CCoe8jGHyCpTwTnVPW+q/3Hua9/kjW5SvQUyxNyjW2e
         enW+ok5/Bxm76n8s5QBVoykf2l9YcGKnGTiYKkr8Qh+qFyZALnnw/DhJXIfUTaq/fS7c
         phl410jSFdkt83A0gRCXo6IwAZM5pehqq0VSNZAzj+FT431rbpprIAV6n9yWx0RFbf4P
         qd3vs6TA6Jg73/TFxAlTKcqJi3RnK6j7Yiq9jFAMrWNr26P/BvMgrGqE1YXX3pcXZxSf
         07EQ==
X-Gm-Message-State: ABy/qLYXQONci5bdPxbXBy1dN3FWeElQCARDjrtADVlV1d1s3FcH2fEy
        xPrmHPq8Y9zwlIqozVXDeqdocwu4YMvt+AKtT7AVqQ==
X-Google-Smtp-Source: APBJJlEL8/G/yVptpWOuQ0guUBdI/DR3grNFP/ZpiVN+HoXzJ96I7quOyM5EFQoiqbygx2tM85uZiFrotTti9DDS5c4=
X-Received: by 2002:a05:622a:38b:b0:405:3a65:b3d6 with SMTP id
 j11-20020a05622a038b00b004053a65b3d6mr117111qtx.13.1689785107840; Wed, 19 Jul
 2023 09:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230715032915.97146-1-yangjihong1@huawei.com> <20230715032915.97146-3-yangjihong1@huawei.com>
In-Reply-To: <20230715032915.97146-3-yangjihong1@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 09:44:56 -0700
Message-ID: <CAP-5=fVysKhUn1YsUr0NBU2kVBDgkoczO861XwK5VCtkeYSRJA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] perf evlist: Add evlist__findnew_tracking_event() helper
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

On Fri, Jul 14, 2023 at 8:31=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> Currently, intel-bts, intel-pt, and arm-spe may add a dummy event for
> tracking to the evlist. We may need to search for the dummy event for
> some settings. Therefore, add evlist__findnew_tracking_event() helper.
>
> evlist__findnew_tracking_event() also deal with system_wide maps if
> system_wide is true.

I'm wondering if we can simplify the naming in the API, we have "dummy
event" which makes sense as we literally call the event "dummy",
"sideband" which refers to the kind of samples/events the dummy event
will record but "tracking" I think tends to get used as a verb rather
than a noun. So I think evlist__findnew_tracking_event should be
evlist__findnew_dummy_event.

Thanks,
Ian

> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/builtin-record.c | 11 +++--------
>  tools/perf/util/evlist.c    | 18 ++++++++++++++++++
>  tools/perf/util/evlist.h    |  1 +
>  3 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index aec18db7ff23..ca83599cc50c 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1295,14 +1295,9 @@ static int record__open(struct record *rec)
>          */
>         if (opts->target.initial_delay || target__has_cpu(&opts->target) =
||
>             perf_pmus__num_core_pmus() > 1) {
> -               pos =3D evlist__get_tracking_event(evlist);
> -               if (!evsel__is_dummy_event(pos)) {
> -                       /* Set up dummy event. */
> -                       if (evlist__add_dummy(evlist))
> -                               return -ENOMEM;
> -                       pos =3D evlist__last(evlist);
> -                       evlist__set_tracking_event(evlist, pos);
> -               }
> +               pos =3D evlist__findnew_tracking_event(evlist, false);
> +               if (!pos)
> +                       return -ENOMEM;
>
>                 /*
>                  * Enable the dummy event when the process is forked for
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 7ef43f72098e..25c3ebe2c2f5 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1694,6 +1694,24 @@ void evlist__set_tracking_event(struct evlist *evl=
ist, struct evsel *tracking_ev
>         tracking_evsel->tracking =3D true;
>  }
>
> +struct evsel *evlist__findnew_tracking_event(struct evlist *evlist, bool=
 system_wide)
> +{
> +       struct evsel *evsel;
> +
> +       evsel =3D evlist__get_tracking_event(evlist);
> +       if (!evsel__is_dummy_event(evsel)) {
> +               evsel =3D evlist__add_aux_dummy(evlist, system_wide);
> +               if (!evsel)
> +                       return NULL;
> +
> +               evlist__set_tracking_event(evlist, evsel);
> +       } else if (system_wide) {
> +               perf_evlist__go_system_wide(&evlist->core, &evsel->core);
> +       }
> +
> +       return evsel;
> +}
> +
>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const cha=
r *str)
>  {
>         struct evsel *evsel;
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 664c6bf7b3e0..98e7ddb2bd30 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -387,6 +387,7 @@ bool evlist_cpu_iterator__end(const struct evlist_cpu=
_iterator *evlist_cpu_itr);
>
>  struct evsel *evlist__get_tracking_event(struct evlist *evlist);
>  void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tra=
cking_evsel);
> +struct evsel *evlist__findnew_tracking_event(struct evlist *evlist, bool=
 system_wide);
>
>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const cha=
r *str);
>
> --
> 2.30.GIT
>
