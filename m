Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E49EB64D0
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 15:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241407AbjFMP0S (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 11:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242989AbjFMP0N (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 11:26:13 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849651BEC
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 08:26:10 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f9d619103dso238561cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686669969; x=1689261969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGcsTjigiwsVCHhce7TrLNCGSp3EdOdru0xINbTB9k4=;
        b=f5TKtpmTN9wf7BKxj6Uajjmt5oxcxBG4/knBASSpMcFt//NbRtP/z1Lg+NYOoRocKf
         uHoZuwJzvPZqeEoniwzYWx1FE99oJEfR37uviUCbs3cSDRqmOnSfoqNmP/gRHEFvJZiu
         VthOAu6laAUoPz4in9VIBxUyi5ggwP8wnRejBGedJ1KLMSuUsnGeE3uUgJC1S89sQdfW
         1w71MQMQBV9gHBBb5Vb311u9PzsGhvwjetweYlHGizEhUT41p5qVxFBreUPATE5/0Rmr
         g5xii4u641utrKTeirKfaGrAst4laGTACW2E8Hv98dRSPvUKMiHoi6Hs1wyo/88npeNL
         rvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686669969; x=1689261969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGcsTjigiwsVCHhce7TrLNCGSp3EdOdru0xINbTB9k4=;
        b=VLRQJZO3NzkFPxcqc66QzS2mdoz/fuZZVb1TBC3KGVT2kGJQdQhyk12Dy82LkJz9dH
         J7ApZvwl2RdVVz5EvV2gDNmffnm3+VeFJRoJeFAomzj81Ow+hPlzjZ7q1xISgRrns1Eb
         G0Rh0jgexRhVaiIPVMnuTSEQclnqhP1IwBTiqspPtPv+IzOyGfjoLkKse7ouvgVsvAsM
         931MmxXMhhIZc6fMQrmNjA4XMM9ws0YZswQbRkhPGEtt2R0XaneLm4JUTK0fUT5XabG1
         CNM6BttrXD49OB0LJSdm4qCgiC3KQkcbmlTz11NjZzDrfVrAkCe9OYK2uNBD5O0kPWjr
         yLiA==
X-Gm-Message-State: AC+VfDxe16GO4VCFnYZ64ptkdL/ppPW4tQolccn0qrmpdM+xyLD4sNdl
        5zk18TnyRDRtmcwtBQWsAk3RMpnkw22bwuZgOOl7qw==
X-Google-Smtp-Source: ACHHUZ5Z4kvR+02A8wyJ6TdV6v5xPpAhjbhwmXGnjDl3xuFuioDV2sog3K1wSVuWftI69WmSKIKd4r0sXNJt6SjvyXs=
X-Received: by 2002:a05:622a:46:b0:3f9:b8c2:f2d3 with SMTP id
 y6-20020a05622a004600b003f9b8c2f2d3mr96993qtw.19.1686669969458; Tue, 13 Jun
 2023 08:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230613095506.547-1-ravi.bangoria@amd.com> <20230613095506.547-4-ravi.bangoria@amd.com>
In-Reply-To: <20230613095506.547-4-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 08:25:58 -0700
Message-ID: <CAP-5=fW0R2Dkwvw0twdzL5GrLy6jy0CXmFHYCsZtC8UQnZ4mVQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf mem amd: Fix perf_pmus__num_mem_pmus()
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, peterz@infradead.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        james.clark@arm.com, alisaidi@amazon.com, leo.yan@linaro.org,
        maddy@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 13, 2023 at 2:56=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> AMD cpus does not contain hybrid cores. Also, perf mem/c2c on AMD
> internally uses IBS OP PMU, not the core PMU.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/arch/x86/util/pmu.c | 15 +++++++++++++++
>  tools/perf/util/pmus.c         |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pm=
u.c
> index 3c0de3370d7e..8a20d28d9927 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -14,6 +14,8 @@
>  #include "../../../util/intel-bts.h"
>  #include "../../../util/pmu.h"
>  #include "../../../util/fncache.h"
> +#include "../../../util/pmus.h"
> +#include "env.h"
>
>  struct pmu_alias {
>         char *name;
> @@ -168,3 +170,16 @@ char *pmu_find_alias_name(const char *name)
>
>         return __pmu_find_alias_name(name);
>  }
> +
> +int perf_pmus__num_mem_pmus(void)
> +{
> +       /*
> +        * AMD does not have hybrid cores and also uses IBS OP
> +        * pmu for perf mem/c2c.
> +        */
> +       if (x86__is_amd_cpu())
> +               return 1;

The code and comment seem out of sync here. For the hybrid part
perf_pmus__num_core_pmus() will yield 1 if there is no hybrid, so we
can just use perf_pmus__num_core_pmus(). For the IBS OP part, does
that mean that AMD should have 2 mem pmus? Or is IBS OP a core PMU?
Can we add this as an example in the core/other documentation in patch
1, as you've done for ARM, for clarity.

Thanks,
Ian

> +
> +       /* Intel uses core pmus for perf mem/c2c */
> +       return perf_pmus__num_core_pmus();
> +}
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index e505d2fef828..0ed943932945 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -240,7 +240,7 @@ const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(=
const char *str)
>         return NULL;
>  }
>
> -int perf_pmus__num_mem_pmus(void)
> +int __weak perf_pmus__num_mem_pmus(void)
>  {
>         /* All core PMUs are for mem events. */
>         return perf_pmus__num_core_pmus();
> --
> 2.40.1
>
