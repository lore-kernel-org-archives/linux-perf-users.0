Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D100EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jun 2023 17:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjF3RlQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 13:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjF3RlP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2023 13:41:15 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0377E199B
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 10:41:15 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-401d1d967beso25061cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688146874; x=1690738874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkFhDjCMVwNhOcO2v4G0EUDJBSzG4xJjBNq5yTT5bH8=;
        b=R9kyVWaPQlz3WF2q9F+9D2hpAYfGj0DR3fds0AKbRKLxLMUXciVT8FvIpD5ICzbCrS
         SOUB49q5QDV//Maefm+vq9UcMJmNvxwfwcP/32xR01Uo+1aip1j4ppkQfMLuQM2tAB/B
         cXczeJaoOjeI13w6N6f49fEHj+4dfObrOhYxEAmwlUlqJFhOzi9DR5p1zIN/rGKHT0zM
         Zhac8jxSF51wjSxoQGQ+l5HtL26RklLY9AWWKJlx/m6CxIoubQlooJdajCv0aBaGsKPn
         b+fyTHedj7MnydhPlokC8PZZxK9n7y9bvWCuCTIQm54KAcZRCP3SQJc6P/bHHljHVr4E
         Yvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688146874; x=1690738874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkFhDjCMVwNhOcO2v4G0EUDJBSzG4xJjBNq5yTT5bH8=;
        b=CoQIR1CbxqAdW3bJn/R43CiQB4DzJXWFzzpZWzQUBkFPkMDzh8N+o0O8piVL0sq1iq
         asO/PjZBa9OzbYDcNKAHI+wBaySiB0kUXf/kZbpJAH7ULkZYBeBrzSyWOeGWbH2zxTWj
         YEDz9DDuJeD7P3kHYERy3WP4lxG1LWeLkDHSIo1R6wdZSU6wuMnYW1jEf6B+SArYDiIe
         NaQ6VXiqnWoptqZ1ljuD0ag/QzQhF75RE9BRLFAiOMPqqlZMbS2+ezn0XEXkQbaQAFn4
         hbFBEguZmhRhQ6QCKRC+yZ/UJ+TGnqUZqympJd0lP+GePu/SOq0jDZe3quJFFL+1AYgx
         KFNg==
X-Gm-Message-State: ABy/qLZJ3iEOAzGVY5YCRu/Jxkx10MRQICyw/pkXAHqRyIBg7tY0hv9K
        m3jrZUTa/pMChf+FZBNkKfo8h4BdKkOtVcU4PDAC0A==
X-Google-Smtp-Source: APBJJlGilaay9n2gLJLQCtHRtujFT3kTGKXgjUqBcBQP2xEJjhnP9I9FteHpbL6AtJXwtrMU6Bs+JuEHuYgx7MIpC9w=
X-Received: by 2002:a05:622a:5d4:b0:3e3:8c75:461 with SMTP id
 d20-20020a05622a05d400b003e38c750461mr7411qtb.6.1688146874051; Fri, 30 Jun
 2023 10:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230628102949.2598096-1-john.g.garry@oracle.com> <20230628102949.2598096-3-john.g.garry@oracle.com>
In-Reply-To: <20230628102949.2598096-3-john.g.garry@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 10:41:02 -0700
Message-ID: <CAP-5=fWB9H0KWrXYouepUiAbnfH3u29XuRVN6KXVw3CNbD4xrA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] perf metrics: Don't iter sys metrics if we
 already found a CPU match
To:     John Garry <john.g.garry@oracle.com>
Cc:     acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 28, 2023 at 3:30=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> In metricgroup__add_metric() we still iter the sys metrics if we already
> found a match from the CPU table, which is pretty pointless, so don't
> bother.
>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  tools/perf/util/metricgroup.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 4389ccd29fe7..8d2ac2513530 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1261,6 +1261,12 @@ static int metricgroup__add_metric(const char *pmu=
, const char *metric_name, con
>
>                 has_match =3D data.has_match;
>         }
> +
> +       if (has_match) {
> +               ret =3D 0;
> +               goto out;
> +       }
> +

I think this can just be:

if (!has_match)

However, I'm not sure I agree with the intent of the change. We may
have a metric like IPC and want it to apply to all types of CPU, GPU,
etc. If we short-cut here then that won't be possible.

Thanks,
Ian
>         {
>                 struct metricgroup_iter_data data =3D {
>                         .fn =3D metricgroup__add_metric_sys_event_iter,
> @@ -1279,6 +1285,7 @@ static int metricgroup__add_metric(const char *pmu,=
 const char *metric_name, con
>
>                 pmu_for_each_sys_metric(metricgroup__sys_event_iter, &dat=
a);
>         }
> +
>         /* End of pmu events. */
>         if (!has_match)
>                 ret =3D -EINVAL;
> --
> 2.35.3
>
