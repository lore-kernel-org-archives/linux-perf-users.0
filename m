Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7EBEB64D9
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Jul 2023 16:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjGJQEy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Jul 2023 12:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGJQEx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Jul 2023 12:04:53 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56153B1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jul 2023 09:04:52 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-401d1d967beso401861cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jul 2023 09:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689005091; x=1691597091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQ0ChdJZ9bvsDMGFfFNVKYinco8bgguH5l8lIeF9Wb4=;
        b=aKFNT3c6Sym9xk3ozE3Ix8+OiI1n/FwQMdOYbq9gHIld7LwkpBx8vsciYETfb+k5IT
         /G7R2iz8zjG3vsG2QfbIi+7pnRW5Qp+AWsiMFwl3JE64NRGBJnXJ/hqJ/OIN2IXxwc4x
         06IwqdWorovjUkkOKB8CzCCHGm8ANj+UpumRDVUHWX86NgXj0QVJbM3rAI1iTo06wX2x
         kLjuaeouWkbApL3PRQySkOAV5JhSui5C4yoxFbJkl9+VhehYGpgvz0Cj37SIF0vl2hT9
         rrWu4AxRkVdT7UACAMQXzKZUQ4AN7KX0/MgGPeXLguxsfi5MEAkfeVyNRoQPyI1S/Ypw
         QBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689005091; x=1691597091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQ0ChdJZ9bvsDMGFfFNVKYinco8bgguH5l8lIeF9Wb4=;
        b=XidaL3nuXvmQUoh+GjFHEzKdRP6TNPv3ycUO85vk86HN44UMlgbrzP2gx50Azxtpz5
         XfWjdR+ZtSk8w/JARxvB/RN85kvTTL3Xv8MH4GDCO3Puol3EVCHvU4MP51xQU0x2R8/J
         8TEfXR2JC9iNJogRKSID7wIbAyhiNN40A67GYthznkx414bF+8k1fDeqbLhoZ43GzDQ8
         CiiLtjgvmESe/ih9FwJ9Jjtjg8PdcBB7yY5Hdv5npvsYr3hWP4joenPWWMsidpjCSLXb
         c18Ru3hTzMX9Ur1N8LcQWODFnmYaFYD/RHjn8wgYJdW/KRNgD9xx3Kq+ceS+1Un2jN57
         AdDg==
X-Gm-Message-State: ABy/qLYG2hzg2eA5D14g4ljZP6L0T70MbQNVUOEwDr8vpEZPvGlkCH37
        AAjswt32uH8NNawfFYq6XfCrkqArozzKsd2Pz0QQ5g==
X-Google-Smtp-Source: APBJJlGG3emPEW9lCBmbjIZvOhY9Y2wKHO9AVCRQTb5IQmhuex38dhkY6Tx06HnSWe1fbxnzXvXNKEm2fhg/kBCXhQI=
X-Received: by 2002:a05:622a:18a9:b0:3fa:3c8f:3435 with SMTP id
 v41-20020a05622a18a900b003fa3c8f3435mr238467qtc.27.1689005091243; Mon, 10 Jul
 2023 09:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230710122138.1450930-1-james.clark@arm.com> <20230710122138.1450930-2-james.clark@arm.com>
In-Reply-To: <20230710122138.1450930-2-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Jul 2023 09:04:40 -0700
Message-ID: <CAP-5=fVoFKTUOLL=Bo6m=3hS61mWV_PJ9dvFCGTprbH75BJh4w@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 10, 2023 at 5:22=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> This capability gives us the ability to open PERF_TYPE_HARDWARE and
> PERF_TYPE_HW_CACHE events on a specific PMU for free. All the
> implementation is contained in the Perf core and tool code so no change
> to the Arm PMU driver is needed.
>
> The following basic use case now results in Perf opening the event on
> all PMUs rather than picking only one in an unpredictable way:
>
>   $ perf stat -e cycles -- taskset --cpu-list 0,1 stress -c 2
>
>    Performance counter stats for 'taskset --cpu-list 0,1 stress -c 2':
>
>          963279620      armv8_cortex_a57/cycles/                (99.19%)
>          752745657      armv8_cortex_a53/cycles/                (94.80%)
>
> Fixes: 55bcf6ef314a ("perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CA=
CHE")
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  drivers/perf/arm_pmu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 277e29fbd504..d8844a9461a2 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -875,8 +875,13 @@ struct arm_pmu *armpmu_alloc(void)
>                  * configuration (e.g. big.LITTLE). This is not an uncore=
 PMU,
>                  * and we have taken ctx sharing into account (e.g. with =
our
>                  * pmu::filter callback and pmu::event_init group validat=
ion).
> +                *
> +                * PERF_PMU_CAP_EXTENDED_HW_TYPE is required to open the =
legacy
> +                * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE events on a
> +                * specific PMU.
>                  */
> -               .capabilities   =3D PERF_PMU_CAP_HETEROGENEOUS_CPUS | PER=
F_PMU_CAP_EXTENDED_REGS,
> +               .capabilities   =3D PERF_PMU_CAP_HETEROGENEOUS_CPUS | PER=
F_PMU_CAP_EXTENDED_REGS |
> +                                 PERF_PMU_CAP_EXTENDED_HW_TYPE,
>         };
>
>         pmu->attr_groups[ARMPMU_ATTR_GROUP_COMMON] =3D
> --
> 2.34.1
>
