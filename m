Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE74C636CE
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 15:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8579B61245
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 15:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbhGUOW1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 10:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbhGUOTG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jul 2021 10:19:06 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DF8C0613D3
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jul 2021 07:59:43 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z9so2665382iob.8
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jul 2021 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XI+Dx3h7cED2ymBlyHrrhom6GxHUNS25otSbDCgTdfM=;
        b=StuwqrCNBxAbvlaItriRISqUD2bCPrwte93gRcZgZRTpbgma1yt3VbTMnXPiMYOT5A
         wS66/RgcYikmz21fweGdngLUbmyoAe3hK5pFRTh9jZlus1fm+U7mop8//e75VPGWFshD
         W8lmHS5IsP0PyTYfCpXsxiFt/RTFuRO/9WKS2MLzRnX0d/YB8Ox7xseTNkhOdAz1bq1z
         zicnkCWJKkJMNBQBYp1XGtf4+RTBQnIySSHou9FUDsOFmMV17QmHE3vNZCpvw36297uy
         MDhIhNVEtFGBXPtXDJqQA99PsjO8xZhZ4/sfFnw8K/7aSKLBw6O/H8VV6NECw9vx6eez
         31Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XI+Dx3h7cED2ymBlyHrrhom6GxHUNS25otSbDCgTdfM=;
        b=bB9uoyPSvkL2+X2kOzR9w4vIiLxasLCKTHRvBx0EfXZ46PndzfuusE7vO6Fjz2nmYS
         FnCH/94MVNmKYLqzhVkNMtvZxJr5/9mEuCYJ0JnPiHTHava7+J0PVVb0fNNWwdS1kgbb
         aqMfme7DSvlCuCdBjhamDTOz36WpSUCE+Msr+7xKfkctEjoiZj5uZrL216ymZeRkIkww
         qiajR1KbQwNRIvoqar8FhTv4vlaaegfW5QgoOniVIp5wie/TN8azCuUzYSFZBatYuPfZ
         3nILKQvo2RxIV8UbY6Hw7fUVbDtiBdwQdXE8pTC8Bcv/ux2CCsRLczWuIyD5P+Enm6+8
         PWvg==
X-Gm-Message-State: AOAM530P9fT/iqDHokUOOEKFCRshy6OzTmttwQ3iqWsiGgmFlUpyrEyr
        v0izf+Rdvs/HXTEECmdbql154JetgHv3UZRY8E9gYg==
X-Google-Smtp-Source: ABdhPJxWig2ftKvDrXZ52oVv1Tgm9j7Gynu/T56MHNUX8Y4w0mTDu5mLA7JxdJDhGzDmynKXL3lild0by9DMwauSDc4=
X-Received: by 2002:a02:380b:: with SMTP id b11mr31300909jaa.83.1626879582678;
 Wed, 21 Jul 2021 07:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210721090706.21523-1-james.clark@arm.com>
In-Reply-To: <20210721090706.21523-1-james.clark@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 21 Jul 2021 08:59:31 -0600
Message-ID: <CANLsYkyjQi9+qM7mzWw+nxD_G36oRbN8Q8K2Vyo0rvsSnJQ90w@mail.gmail.com>
Subject: Re: [PATCH 0/6] Support ETE decoding
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Al Grant <al.grant@arm.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James,

I have received this set but won't be able to look at it for quite some time.

Thanks,
Mathieu

On Wed, 21 Jul 2021 at 03:07, James Clark <james.clark@arm.com> wrote:
>
> Decoding ETE already works because it is a superset of
> ETMv4, but if any new packet types are found then they will be
> ignored by the decoder. This patchset creates an ETE decoder
> which can output the new packets and saves a new register that
> is required. No new packet types are handled by perf yet, as this
> can be added in the future.
>
> This set applies on top of "perf cs-etm: Support TRBE
> (unformatted decoding)" on perf/core.
>
> James Clark (6):
>   perf cs-etm: Refactor initialisation of decoder params.
>   perf cs-etm: Initialise architecture based on TRCIDR1
>   perf cs-etm: Save TRCDEVARCH register
>   perf cs-etm: Update OpenCSD decoder for ETE
>   perf cs-etm: Create ETE decoder
>   perf cs-etm: Print the decoder name
>
>  tools/build/feature/test-libopencsd.c         |   4 +-
>  tools/perf/arch/arm/util/cs-etm.c             |  13 +-
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 151 ++++++++----------
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   8 +
>  tools/perf/util/cs-etm.c                      |  54 ++++++-
>  tools/perf/util/cs-etm.h                      |   6 +-
>  6 files changed, 147 insertions(+), 89 deletions(-)
>
> --
> 2.28.0
>
