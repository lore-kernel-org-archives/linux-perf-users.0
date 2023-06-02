Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B76C7EE24
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jun 2023 06:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjFBGmT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 2 Jun 2023 02:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbjFBGmO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Jun 2023 02:42:14 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F2D99
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Jun 2023 23:42:13 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f6c6320d4eso95051cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jun 2023 23:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685688132; x=1688280132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tki20qie0FAxJ4SIIr1Vqb0p71g8+s5PBNVvAr0u+QE=;
        b=t37+3wnf+hoGTriopAzMk5eAPKaoMQ99lyQEd1VPCstVbgVAqXsW+ucF4dbhS59NIl
         sft0SyYSAI4YxdTi4H63+sORO9+7XSWf6XdkjcDliX+aHzueNEMTsIAmWTs0WZ0gXWBj
         Qqzg6g4ZBsY4/XOAmRtoPamKuV+vAu3ObhJMedCt2k5BcBpfbVh0YlaUwEbOVLCs5aKM
         dHOPlXHaIExrScPZqozW8RA8m5MBsyqNEKoyXDNicZ2jG3/SF4aiF2NQNxiFJgpRi8y2
         sdpP3AEuK6SdkulFGkIi7WeAyE5+CyRIcPv7kgos0McRvRXynyPzl7zSWi3kiVP22IO9
         oqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685688132; x=1688280132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tki20qie0FAxJ4SIIr1Vqb0p71g8+s5PBNVvAr0u+QE=;
        b=Jmqs8O612xVPOfgxjvS3f3MYaIPl58LLVGBix+uUntHUMkiJvvb/qByVaDAsmX3AiC
         Y3jc/Q2N4FpxAXGhPGlikF8i6kRlmnxRR5XAhA7fzLs6UWagBmZW6ggC4rD8a5vDPU7E
         v/MMeIiuGvqvuStZmQduJ6bCHPso1pm+o1iCfUaYrtcIa8G1AWofummZ2JfIV//jQ2G2
         1qfzVh40rDUCEATJ+K7XLXt57pIwD6pxx0S5iuWdWd2yy0Gde2EVqYKBlsUg6q6gl0Ph
         8bUYFrN/1vR0hLgdYH3D7Hssipa6XJ1a+zVqxmOoytz9izYE++nc3RKc/iXzQH0G5Wee
         z3YA==
X-Gm-Message-State: AC+VfDzCpgyNJMYMDrLkbn9GukNS/IAWZBlpoMakHDlnJM5CAd1EWUwk
        E+3reAAUT3x0pA3S98DYeKEYBKlhumtmjUXWGzEf9w==
X-Google-Smtp-Source: ACHHUZ6cneUR2obQrO+vCzEe0zlO+pSO/rBvMoGUuFy3Vdsky9czAMs07nTGAHOCttsa8nwN6mMjpDVzoo1sv9y3XZU=
X-Received: by 2002:a05:622a:1182:b0:3ef:3361:75d5 with SMTP id
 m2-20020a05622a118200b003ef336175d5mr107258qtk.11.1685688132242; Thu, 01 Jun
 2023 23:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com> <20230527072210.2900565-28-irogers@google.com>
 <f0d9ff32-c4e6-674e-0719-833334f39e5d@amd.com>
In-Reply-To: <f0d9ff32-c4e6-674e-0719-833334f39e5d@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 1 Jun 2023 23:42:00 -0700
Message-ID: <CAP-5=fUPZ7+nAcxBp5sFBfxzkOH8kzWkLV0uziHqxYC0cDbbDw@mail.gmail.com>
Subject: Re: [PATCH] perf test amd: Fix build failure with amd-ibs-via-core-pmu.c
 -- Was: Re: [PATCH v5 27/34] perf pmu: Separate pmu and pmus
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 1, 2023 at 10:30=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> On 27-May-23 12:52 PM, Ian Rogers wrote:
> > Separate and hide the pmus list in pmus.[ch]. Move pmus functionality
> > out of pmu.[ch] into pmus.[ch] renaming pmus functions which were
> > prefixed perf_pmu__ to perf_pmus__.
>
> I'm seeing perf tool build failures on linux-next because a patch[1] went=
 in
> via Peter's tree needed some changes done by this patch.
>
> [1]: https://lore.kernel.org/lkml/168372562075.404.10852387134590654382.t=
ip-bot2@tip-bot2
>
> Below patch fixes the issue.
>
> From c041b94df00baea024b64d4b19e37ee827484e74 Mon Sep 17 00:00:00 2001
> From: Ravi Bangoria <ravi.bangoria@amd.com>
> Date: Thu, 1 Jun 2023 15:23:22 +0530
> Subject: [PATCH] perf test amd: Fix build failure with amd-ibs-via-core-p=
mu.c
>
> Since amd-ibs-via-core-pmu.c was applied via Peter's tree, some of
> the changes came via Arnaldo's tree did not reflected in this file,
> which is causing build failures.
>
>   arch/x86/tests/amd-ibs-via-core-pmu.c:47:25: error: =E2=80=98pmus=E2=80=
=99 undeclared
>   (first use in this function)
>      47 |         if (list_empty(&pmus))
>         |                         ^~~~
>   arch/x86/tests/amd-ibs-via-core-pmu.c:48:17: error: implicit declaratio=
n
>   of function =E2=80=98perf_pmu__scan=E2=80=99; did you mean
>   perf_pmus__scan=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>      48 |                 perf_pmu__scan(NULL);
>         |                 ^~~~~~~~~~~~~~
>         |                 perf_pmus__scan
>   arch/x86/tests/amd-ibs-via-core-pmu.c:50:19: error: implicit declaratio=
n
>   of function =E2=80=98perf_pmu__find=E2=80=99; did you mean
>   perf_pmus__find=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>      50 |         ibs_pmu =3D perf_pmu__find("ibs_op");
>         |                   ^~~~~~~~~~~~~~
>         |                   perf_pmus__find
>
> Fix those.
>
> Fixes: 1eaf496ed386 ("perf pmu: Separate pmu and pmus")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c b/tools/per=
f/arch/x86/tests/amd-ibs-via-core-pmu.c
> index 2902798ca5c1..1e08b2455725 100644
> --- a/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
> +++ b/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
> @@ -44,10 +44,10 @@ int test__amd_ibs_via_core_pmu(struct test_suite *tes=
t __maybe_unused,
>         int ret =3D TEST_OK;
>         int fd, i;
>
> -       if (list_empty(&pmus))
> -               perf_pmu__scan(NULL);
> +       /* No way to know whether pmus list is already populated or not. =
*/
> +       perf_pmus__scan(NULL);

Thanks Ravi, you should be able to just remove the 2 lines above. The
code will check to make sure the list is populated for the find below:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/util/pmus.c?h=3Dperf-tools-next#n79

Thanks,
Ian

> -       ibs_pmu =3D perf_pmu__find("ibs_op");
> +       ibs_pmu =3D perf_pmus__find("ibs_op");
>         if (!ibs_pmu)
>                 return TEST_SKIP;
>
> --
> 2.40.1
