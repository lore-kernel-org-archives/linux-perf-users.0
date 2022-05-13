Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F04C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 May 2022 18:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245080AbiEMSeK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 May 2022 14:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiEMSeJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 May 2022 14:34:09 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E915E151
        for <linux-perf-users@vger.kernel.org>; Fri, 13 May 2022 11:34:07 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id z144so9213732vsz.13
        for <linux-perf-users@vger.kernel.org>; Fri, 13 May 2022 11:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XxaAhTM7z7ZXAcsBxj173aYKUbXdWRM6Ctvy2Vo1MV8=;
        b=f2A4SIp536wPkDPMvn62DM+ukUpqK2CvHmbKz3bIo6KqP004+abgMpMcG57+7cpmmM
         QAhsnzVEQDU34hQTs1zeb8dZsZ9EBmN7BqIOfTlTRi18K+R3Kb9OIy8yLO7YeIxYEPKs
         Q8JOQx+js3N5E/mH+LWaNdt2nMv2sPpy5IcVUh5xm1hUVxxJLbgjxV1WOqTGFwmBOJqA
         zm96PP5nwSUCGMb8paUZ/mGdoE5tMa3ea5YQRjJhZMa5o2ByJlvXg950Kq38BJLS1JK+
         jDgPwlCbZhevgvJqeQrjGrQczx4tGKnCg++6iHVWjsHFVZYbBL3jt3i6cYNGIOIGJUR5
         i1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XxaAhTM7z7ZXAcsBxj173aYKUbXdWRM6Ctvy2Vo1MV8=;
        b=fo3ilPn8Ojx6L5XThQO5dLZ5DARDmlB6mCfOMb5L0wfPmcM5bnEUWM+Ce2UWTBpUpQ
         frobyauYBSYQ3QPfWrvcEbO0jjBfmj1rFiDjP2se86ckDPqRs6IIi14GRK6EaZrof5yo
         L4VoH1jymscxG9jdxKQIuVYhhWscrSH4ZyzFDRILwWnX5PD/A0fjlp0JbFybAmbz3oqb
         crZFgLqnFQrLT2pP0AhZVFLiHDggUpdvJ4QIIXfMAfvVXfnfZIky0gAz5muqH5hKq91K
         RFJ8jD1uNsOl7ino6a0bUpUoG+fL10N9Hnq/FuBAbP4SuWgq7CvY8SQ4N7yNFd+1hAG4
         yNXA==
X-Gm-Message-State: AOAM530n4axGDvzUdFizgzgy0jnu/6ulrBKI6F1Sc1mNnEBDMO1bUyB4
        8WfdB/lauZNeb4nVm46AxCkLgZIJkhn6cBT2a5fjzA==
X-Google-Smtp-Source: ABdhPJzSCnp+qEb5zTwkmlHIVcD1jGMriYVuqe1xvpRO2qBWeUcfYknco+S9NCOq7kjF7fo89nwRrNSz+TIYD6wqZH8=
X-Received: by 2002:a05:6102:2929:b0:32d:6662:72e2 with SMTP id
 cz41-20020a056102292900b0032d666272e2mr2943899vsb.56.1652466846453; Fri, 13
 May 2022 11:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220511114959.84002-1-atrajeev@linux.vnet.ibm.com> <151b1538daf92259702242dbf734230aea3199fe.camel@linux.vnet.ibm.com>
In-Reply-To: <151b1538daf92259702242dbf734230aea3199fe.camel@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 13 May 2022 11:33:55 -0700
Message-ID: <CAP-5=fVAfjUHvhLF2E2UZo+BwneSex0GV5BgbHAV6bvdUxj_9w@mail.gmail.com>
Subject: Re: [PATCH V2] tools/perf/tests: Fix session topology test to skip
 the test in guest environment
To:     Disha Goel <disgoel@linux.vnet.ibm.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
        jolsa@kernel.org, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 12, 2022 at 11:18 PM Disha Goel <disgoel@linux.vnet.ibm.com> wrote:
>
>
>
> -----Original Message-----
> From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> To: acme@kernel.org, jolsa@kernel.org
> Cc: mpe@ellerman.id.au, linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, irogers@google.com
> Subject: [PATCH V2] tools/perf/tests: Fix session topology test to skip the test in guest environment
> Date: Wed, 11 May 2022 17:19:59 +0530
>
> The session topology test fails in powerpc pSeries platform.
>
> Test logs:
>
> <<>>
>
> Session topology : FAILED!
>
> <<>>
>
>
> This testcases tests cpu topology by checking the core_id and
>
> socket_id stored in perf_env from perf session. The data from
>
> perf session is compared with the cpu topology information
>
> from "/sys/devices/system/cpu/cpuX/topology" like core_id,
>
> physical_package_id. In case of virtual environment, detail
>
> like physical_package_id is restricted to be exposed. Hence
>
> physical_package_id is set to -1. The testcase fails on such
>
> platforms since socket_id can't be fetched from topology info.
>
>
> Skip the testcase in powerpc if physical_package_id returns -1
>
>
> Signed-off-by: Athira Rajeev <
>
> atrajeev@linux.vnet.ibm.com
>
> >
>
> ---
>
> Changelog:
>
> v1 -> v2:
>
>  Addressed review comments from Arnaldo and Michael Ellerman.
>
>  skip the test in powerpc when physical_package_id is set to
>
>  -1.
>
>  Dropped patch 1 from V1 since current change doesn't use info
>
>  from /proc/cpuinfo and rather uses physical_package_id value.
>
>
>  tools/perf/tests/topology.c | 11 +++++++++++
>
>  1 file changed, 11 insertions(+)
>
>
> Tested the patch on powerpc and powernv, session topology test works fine with the patch.
>
> Tested-by: Disha Goel <disgoel@linux.vnet.ibm.com>


Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
>
> index ee1e3dcbc0bd..d23a9e322ff5 100644
>
> --- a/tools/perf/tests/topology.c
>
> +++ b/tools/perf/tests/topology.c
>
> @@ -109,6 +109,17 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>
>   && strncmp(session->header.env.arch, "aarch64", 7))
>
>   return TEST_SKIP;
>
>
> + /*
>
> + * In powerpc pSeries platform, not all the topology information
>
> + * are exposed via sysfs. Due to restriction, detail like
>
> + * physical_package_id will be set to -1. Hence skip this
>
> + * test if physical_package_id returns -1 for cpu from perf_cpu_map.
>
> + */
>
> + if (strncmp(session->header.env.arch, "powerpc", 7)) {
>
> + if (cpu__get_socket_id(perf_cpu_map__cpu(map, 0)) == -1)
>
> + return TEST_SKIP;
>
> + }
>
> +
>
>   TEST_ASSERT_VAL("Session header CPU map not set", session->header.env.cpu);
>
>
>   for (i = 0; i < session->header.env.nr_cpus_avail; i++) {
