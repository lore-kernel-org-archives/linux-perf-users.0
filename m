Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC818EB64D9
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Jul 2023 16:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjGJQIb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Jul 2023 12:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGJQIb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Jul 2023 12:08:31 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AE2DF
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jul 2023 09:08:29 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40371070eb7so398841cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jul 2023 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689005308; x=1691597308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCZ478BjRJ70dGPiyazKHs2AHwhWpPHvIJs192KkWtA=;
        b=raiwsZg/csJTCrSWgdBtnd9ljQyiwBv9lV8BD6vdvUmrIz14MewJmemne/YcRSjxbQ
         pZ7wYvDSB2QJECcClLFUE3RWyzO70AqfIXdN54acUD9e4VCf7E96xJ/q5k9bjJuoE+tD
         JZakBTUj4gklq22OZnalVTtBFhnREB4OGxMMw0/P0B8XzioIPEtt/t1xZ/v8L8px72w+
         p4IOjS2dSrLhywDqFRPqIhfRTEljzI6Dj+mWCIGdyqDRtMLWzzheC3hJ+I4v/HYdzd9u
         JLT/+Eo+wjXAAusil+Q9GA6rF6UA5d3PjaY1qMdAIpbInGaZAuuI1/6ABHPeTSm3nQ5Z
         G6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689005308; x=1691597308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCZ478BjRJ70dGPiyazKHs2AHwhWpPHvIJs192KkWtA=;
        b=UojlYwtdr3xKFn9vpaGcuwj+H+i+MzBsRMyFyBueG3YSlqOdG9goUwoQ/0hW7KHFFj
         6epZHT4yDCZhsm9fmhs2fZAvP72ZaV8WrKmxXZJaKnOae1ZYaPzINO8bTwXVgSFMG0Jq
         KytfLRtltYDu8sM0Cie8QzeH6OCvF9/HcfYjRtNzN/drf6NXhK3wQ4Wp1/RIGZ+auGW5
         VAeCaN3+KfnceBuw1fUTUufgSMJuGG5s2TRnjIQcB7xW6xET6NwfRsVwl5nrVsALKhvz
         X3hpRw/TLIHwdl9FBQqGH316XxNmExlAwuCr9Z3Ul+TMm+gtvYHblAN79R3VKrZGKf7t
         6D+Q==
X-Gm-Message-State: ABy/qLZb3CRc/vpQ2mginblZkVJjqVsT3x7fJWD2IalmCauuTUIqCFGl
        GkphlH5Bj6X2PepW0dGA7h7JSkHZqXbdBfa3v2Sncw==
X-Google-Smtp-Source: APBJJlFy1h+xduL4V4mkm/cNZocGgxpL/alpQAW35hY7UfCdCZZXX0KwLjWG4NbXvtKvDxjK6aTHSCnAsTEFRr1B05Y=
X-Received: by 2002:ac8:5850:0:b0:3f8:5b2:aef5 with SMTP id
 h16-20020ac85850000000b003f805b2aef5mr285849qth.29.1689005308540; Mon, 10 Jul
 2023 09:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230710122138.1450930-1-james.clark@arm.com> <20230710122138.1450930-4-james.clark@arm.com>
In-Reply-To: <20230710122138.1450930-4-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Jul 2023 09:08:17 -0700
Message-ID: <CAP-5=fVqHi8M+xCL3ORiabfbaoMSugS=AkPDdhgs5TPUypzqHA@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm_pmu: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS
 capability
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 10, 2023 at 5:22=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> Since commit bd2756811766 ("perf: Rewrite core context handling") the
> relationship between perf_event_context and PMUs has changed so that
> the error scenario that PERF_PMU_CAP_HETEROGENEOUS_CPUS originally
> silenced no longer exists.
>
> Remove the capability and associated comment to avoid confusion that it
> actually influences any perf core behavior. This change should be a
> no-op.
>
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  drivers/perf/arm_pmu.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index d8844a9461a2..297906df6628 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -872,15 +872,12 @@ struct arm_pmu *armpmu_alloc(void)
>                 .attr_groups    =3D pmu->attr_groups,
>                 /*
>                  * This is a CPU PMU potentially in a heterogeneous
> -                * configuration (e.g. big.LITTLE). This is not an uncore=
 PMU,
> -                * and we have taken ctx sharing into account (e.g. with =
our
> -                * pmu::filter callback and pmu::event_init group validat=
ion).
> -                *
> +                * configuration (e.g. big.LITTLE) so
>                  * PERF_PMU_CAP_EXTENDED_HW_TYPE is required to open the =
legacy
>                  * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE events on a
>                  * specific PMU.
>                  */
> -               .capabilities   =3D PERF_PMU_CAP_HETEROGENEOUS_CPUS | PER=
F_PMU_CAP_EXTENDED_REGS |
> +               .capabilities   =3D PERF_PMU_CAP_EXTENDED_REGS |
>                                   PERF_PMU_CAP_EXTENDED_HW_TYPE,
>         };
>
> --
> 2.34.1
>
