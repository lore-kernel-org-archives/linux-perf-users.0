Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18EFC001B0
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Aug 2023 01:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjHOBMS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Aug 2023 21:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjHOBLz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Aug 2023 21:11:55 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDEE10C8
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 18:11:54 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40c72caec5cso91591cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 18:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692061913; x=1692666713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWqNV8j4rJ01I2/kmzyAmB0UmrRYsbr0X6nXpcU09Kw=;
        b=QoLabUP1MxN2EF7Rd4tNg3zlcuKjFWbe+WC0AcPXwj7g9lnzIQ6CDnLae+5Ox8WgHs
         m/VbFI8L4dM1KeGHLu9fJrUhoR9io291MGq5WgqmfDFCYiTApGnU6x6GQo7baD6npljz
         kutAhyWEFApMAXeB6fRWBFxUfZE5+2H3Z6/7B2E+xbxO9d5Vsa+pcWF8b3tU5KAesWT8
         J0x30KMknDkoes66oe+mYhdViXl+CecTQCEJPxBrHNufY/ZkAcYR6C/DyilRhvr9FIE5
         d9rfg8yMjJLbCGyDv2X49LhzaUQYC54VJaOeZVQoZZqnYq6s8UAmZmfRD2YR0Aj8LiJ6
         XrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692061913; x=1692666713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWqNV8j4rJ01I2/kmzyAmB0UmrRYsbr0X6nXpcU09Kw=;
        b=BqWpm6Cv+W8yfNVSiO6C/t/4pMu/YA+aYrrQGXFwGYGoEXNpHBmCi8t4XIlwquAon1
         MyAnR9rTeZuJQYazgZv+Hye08EYdOtNzh0PXicCS7Qf+7/Ifg5lVUFozPm7ECouJdkt8
         XZbHX3u4gPtZWY4oh9Jx+dq+xbRVUM19yRr97NL9yTZa6T5vTlxtIJV0iV12UhtAnMi9
         m+0zvuG9Rdrpjo7Cq7ahowcb8cbul85K5csuB5NvytJh0pdWUgfARbOkMfNOKKRFoksP
         JSmLnMp1sZlvC4IyiwgDIvvmHS0bSscRLMyY1hrn1r/g5s29nP6kmnuOFCwWQUT1I87w
         MR8A==
X-Gm-Message-State: AOJu0Yyx4sVPsJbQi8+y71/TZ6SqeURk/zGjpsePwI2P0aiaDLbvHk/+
        kYyPGe128BR/WwZByQfGZL0B4yo33UoR67IleAPFkQ==
X-Google-Smtp-Source: AGHT+IG7MHwhRcBTr5x6srMH1dL3HfSXwFUD3fZEud/UGvJocL5lEnagtJBP+/IcyELLp0Vyr1N2I8JYPNiEqhFk2HA=
X-Received: by 2002:a05:622a:11cb:b0:410:385c:d1d9 with SMTP id
 n11-20020a05622a11cb00b00410385cd1d9mr606418qtk.25.1692061913091; Mon, 14 Aug
 2023 18:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <1691394685-61240-1-git-send-email-renyu.zj@linux.alibaba.com> <1691394685-61240-6-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1691394685-61240-6-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Aug 2023 18:11:40 -0700
Message-ID: <CAP-5=fXPhtPCGYotDi2P_LeFPBMd8N+z_WAPwUT8eR+QiLLTMg@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] perf test: Add pmu-event test for "Compat" and new event_field.
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 7, 2023 at 12:51=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
> Add new event test for uncore system event which is used to verify the
> functionality of "Compat" matching multiple identifiers and the new event
> fields "EventIdCode" and "Type".
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>

Did you test with NO_JEVENTS=3D1?

> ---
>  .../pmu-events/arch/test/test_soc/sys/uncore.json  |  8 ++++
>  tools/perf/tests/pmu-events.c                      | 55 ++++++++++++++++=
++++++
>  2 files changed, 63 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json b/t=
ools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
> index c7e7528..19ec595 100644
> --- a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
> +++ b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
> @@ -12,5 +12,13 @@
>             "EventName": "sys_ccn_pmu.read_cycles",
>             "Unit": "sys_ccn_pmu",
>             "Compat": "0x01"
> +   },
> +   {
> +           "BriefDescription": "Counts total cache misses in first looku=
p result (high priority).",
> +           "Type": "0x05",
> +           "EventIdCode": "0x01",
> +           "EventName": "sys_cmn_pmu.hnf_cache_miss",
> +           "Unit": "sys_cmn_pmu",
> +           "Compat": "434*;436*;43c*;43a01"

I suspect this needs adding here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/empty-pmu-events.c?h=3Dperf-tools-next#n247

Thanks,
Ian

>     }
>  ]
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.=
c
> index 3204252..79fb3e2 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -255,9 +255,24 @@ struct perf_pmu_test_pmu {
>         .matching_pmu =3D "uncore_sys_ccn_pmu4",
>  };
>
> +static const struct perf_pmu_test_event sys_cmn_pmu_hnf_cache_miss =3D {
> +       .event =3D {
> +               .name =3D "sys_cmn_pmu.hnf_cache_miss",
> +               .event =3D "type=3D0x05,eventid=3D0x01",
> +               .desc =3D "Counts total cache misses in first lookup resu=
lt (high priority). Unit: uncore_sys_cmn_pmu ",
> +               .topic =3D "uncore",
> +               .pmu =3D "uncore_sys_cmn_pmu",
> +               .compat =3D "434*;436*;43c*;43a01",
> +       },
> +       .alias_str =3D "type=3D0x5,eventid=3D0x1",
> +       .alias_long_desc =3D "Counts total cache misses in first lookup r=
esult (high priority). Unit: uncore_sys_cmn_pmu ",
> +       .matching_pmu =3D "uncore_sys_cmn_pmu0",
> +};
> +
>  static const struct perf_pmu_test_event *sys_events[] =3D {
>         &sys_ddr_pmu_write_cycles,
>         &sys_ccn_pmu_read_cycles,
> +       &sys_cmn_pmu_hnf_cache_miss,
>         NULL
>  };
>
> @@ -704,6 +719,46 @@ static int __test_uncore_pmu_event_aliases(struct pe=
rf_pmu_test_pmu *test_pmu)
>                         &sys_ccn_pmu_read_cycles,
>                 },
>         },
> +       {
> +               .pmu =3D {
> +                       .name =3D (char *)"uncore_sys_cmn_pmu0",
> +                       .is_uncore =3D 1,
> +                       .id =3D (char *)"43401",
> +               },
> +               .aliases =3D {
> +                       &sys_cmn_pmu_hnf_cache_miss,
> +               },
> +       },
> +       {
> +               .pmu =3D {
> +                       .name =3D (char *)"uncore_sys_cmn_pmu0",
> +                       .is_uncore =3D 1,
> +                       .id =3D (char *)"43602",
> +               },
> +               .aliases =3D {
> +                       &sys_cmn_pmu_hnf_cache_miss,
> +               },
> +       },
> +       {
> +               .pmu =3D {
> +                       .name =3D (char *)"uncore_sys_cmn_pmu0",
> +                       .is_uncore =3D 1,
> +                       .id =3D (char *)"43c03",
> +               },
> +               .aliases =3D {
> +                       &sys_cmn_pmu_hnf_cache_miss,
> +               },
> +       },
> +       {
> +               .pmu =3D {
> +                       .name =3D (char *)"uncore_sys_cmn_pmu0",
> +                       .is_uncore =3D 1,
> +                       .id =3D (char *)"43a01",
> +               },
> +               .aliases =3D {
> +                       &sys_cmn_pmu_hnf_cache_miss,
> +               },
> +       }
>  };
>
>  /* Test that aliases generated are as expected */
> --
> 1.8.3.1
>
