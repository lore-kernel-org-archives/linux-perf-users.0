Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2158AC0015E
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Jul 2023 16:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjGSQsp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Jul 2023 12:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGSQso (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2023 12:48:44 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB652136
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Jul 2023 09:48:32 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-401d1d967beso5741cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Jul 2023 09:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689785311; x=1692377311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qdhb3Ae11Gg1Dat3FtPlzRqYz+pl+VF4Ei5yrEPLth0=;
        b=ZhpgSv3ucAbMdOpycJUjN25cYLL4v6Q2VEZ9BHyAYp/RLIZTddNVRP3H1CckWGYT6+
         DDx8BkNPfq1m4eGu6KnD4v1nA34X3YhpzrtlxqtwXNDeNfzi8I3R/BnpbSNCAz/cFOxA
         UX+0qplhn5jKCpboPrfhEab3jglezs+E+hmzwVSQ2k1VJY/jfuG6MwtsX8KrhBEksb5N
         MDUMdrW2UvnNCPajHkBwyePdOUD1wurmMBd2MxzCJ+0xWWDuOJVMWRH5kxdKfbMckjqE
         /iJa8ARtYoF4YjmmF8B9PZexijoUH2qNxe/gi9VJBHzhDH6Yi/fPH9zOTTYSnbo6kFjQ
         03iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689785311; x=1692377311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qdhb3Ae11Gg1Dat3FtPlzRqYz+pl+VF4Ei5yrEPLth0=;
        b=F6CN4JWmscho9GpBOmkeqU9jEplkRDr2oxTk8s8GbcrjbDbDj6WyicXFOf7PkKhsQn
         o76SK4g4CSWxNPp2vKi+BGz1gC+9CfuUHxjcmUyTCKyhT5hQ60IluGM6mCLdLAyfm+sQ
         ioUo5vEbM8YeoG2CtECi2OUwHvwXJ/p0Iq2I14sQ99IuL5KU6B/ntoIYmBZ2EBx8omdr
         Zqjt2uhVtgoHz4WqduTP9XMt3F+0UP/a+GzQHyGZZSABRTx365ekOZNgrL2G6JwYOMVN
         yPlorQmDG+S3bJOxniQsaHw00jzy3UR5avsdCLxWgFq9gSBuKXWUsQ2L14j6TiIcYq+m
         dkng==
X-Gm-Message-State: ABy/qLY4Et4R2EKUsrqvcz6a7nX3G16z9NqWDyAQpHeo77Ygms7EX2cU
        Y1vOiTYzWK8s/RtUleXaggCLCnMolERsZ6IkKJrZVw==
X-Google-Smtp-Source: APBJJlGHWag7WGvy2AIyTiB9+pLYJ1QpIZVF1cgNC8KDXbH+lfqt6f2fQwTqpmSovIPhRjokwwyzwhW6thNdncLuoxs=
X-Received: by 2002:a05:622a:1cd:b0:403:a090:41c5 with SMTP id
 t13-20020a05622a01cd00b00403a09041c5mr701146qtw.16.1689785311166; Wed, 19 Jul
 2023 09:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230715032915.97146-1-yangjihong1@huawei.com> <20230715032915.97146-8-yangjihong1@huawei.com>
In-Reply-To: <20230715032915.97146-8-yangjihong1@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 09:48:19 -0700
Message-ID: <CAP-5=fXANQvgd96=hi2j7touCex0UQ9GsUB0cL1018KfeZPqzg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] perf test: Add test case for record sideband events
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
> Add a new test case to record sideband events for all CPUs when tracing
> selected CPUs
>
> Test result:
>
>   # ./perf test list 2>&1 | grep 'perf record sideband tests'
>    95: perf record sideband tests
>   # ./perf test 95
>    95: perf record sideband tests                                      : =
Ok
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/tests/shell/record_tracking.sh | 44 +++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100755 tools/perf/tests/shell/record_tracking.sh
>
> diff --git a/tools/perf/tests/shell/record_tracking.sh b/tools/perf/tests=
/shell/record_tracking.sh

Could this be record_sideband.sh ? It will be more consistent with the
test output...

Thanks,
Ian

> new file mode 100755
> index 000000000000..44fc0af92f81
> --- /dev/null
> +++ b/tools/perf/tests/shell/record_tracking.sh
> @@ -0,0 +1,44 @@
> +#!/bin/sh
> +# perf record sideband tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +err=3D0
> +perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +
> +can_cpu_wide()
> +{
> +    if ! perf record -o ${perfdata} -BN --no-bpf-event -e dummy:u -C $1 =
true 2>&1 >/dev/null
> +    then
> +        echo "record sideband test [Skipped cannot record cpu$1]"
> +        err=3D2
> +    fi
> +
> +    rm -f ${perfdata}
> +    return $err
> +}
> +
> +test_system_wide_tracking()
> +{
> +    # Need CPU 0 and CPU 1
> +    can_cpu_wide 0 || return 0
> +    can_cpu_wide 1 || return 0
> +
> +    # Record on CPU 0 a task running on CPU 1
> +    perf record -BN --no-bpf-event -o ${perfdata} -e dummy:u -C 0 -- tas=
kset --cpu-list 1 true
> +
> +    # Should get MMAP events from CPU 1
> +    mmap_cnt=3D`perf script -i ${perfdata} --show-mmap-events -C 1 2>/de=
v/null | grep MMAP | wc -l`
> +
> +    rm -f ${perfdata}
> +
> +    if [ ${mmap_cnt} -gt 0 ] ; then
> +        return 0
> +    fi
> +
> +    echo "Failed to record MMAP events on CPU 1 when tracing CPU 0"
> +    return 1
> +}
> +
> +test_system_wide_tracking
> --
> 2.30.GIT
>
