Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA4BC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Feb 2022 16:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbiBQQqV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Feb 2022 11:46:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242697AbiBQQqV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Feb 2022 11:46:21 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3522B355D
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Feb 2022 08:46:01 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id e140so14212928ybh.9
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Feb 2022 08:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Krbys4z1HiJYbO7ekpiHQnj69+zGpmG1n2OUUWl+mIM=;
        b=Sum0eKi9lz9/AsHv7XUtUOTvCs8DBrKvEzLtHtvjJ2sq5smZHSfCSkdVPJaEVStXAY
         DcmI8SFRd3HdnLNleqKe20e4PSC95CvEvqvYu6rU2zEccEMklpN+27lDiI7yK3QbX1Wm
         6Svp0TrvotB+PBNZ7S0B4vJ66hAaAaHuKVy+CzM05vWtOo5rWM3fvTMy2LZjDr1OZzLL
         BIOa3FMCLEEoJ2v5dYWygMcy70OTcnoVvwXs6Ptg3ViwGq8rMaLJ+7t225e+LvaBg5tw
         mGl0JNL0W/CichfPjAiFqlGr7QrLznIBXXqJ/7G2fK71/mzetmBkZ8JJqt/5BU+RKEJt
         RQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Krbys4z1HiJYbO7ekpiHQnj69+zGpmG1n2OUUWl+mIM=;
        b=WmvhM4T37at5qCnpbJ9Aa14fN0XOH8Ae13piCPy9UA74kOX3D0Zp33D2rMT/mUIMdE
         e4aZYYrPS+sage2BCT3g7W9SViGr6z79kTgl209DdwVzy1rbEpHJag++at0nXYRmfRGw
         3wAlya4VxIeWAvLnKATYQ6crNgsxnvfuLSG607wPfbioeOCYlD2mt5lstkZzzqFu4ptb
         HipzBoE/576sgNrk38fKJxBhgqaG6yXqOEh20DlRymI9OymnHn6+gqz3U2VvggbYtrMy
         G4ygZu3sbX3kXHLzrbm4R7NYIRwzNhP0KLqM1NUjNAOQldcoxznn3Hr307kLGG5T9Ve3
         o1RQ==
X-Gm-Message-State: AOAM533LL7DXzH27qIrqYVR8xahAXoIyuQM8NgBfKbO4fFEkuEtJsnvq
        kPxAH4uNNdTE9/XdIoOZNHEQTdhqOJcIoWWvzXbirA==
X-Google-Smtp-Source: ABdhPJw5fINJmYdUVixpISo4vuZIcCuYpLrgLsvboR0CRG5CjvLN3KssWhNmWvl/PhHbt09gQs/0BBLfo+qKLMyCbuQ=
X-Received: by 2002:a25:bb8d:0:b0:61d:aca6:8aa0 with SMTP id
 y13-20020a25bb8d000000b0061daca68aa0mr3232251ybg.609.1645116360251; Thu, 17
 Feb 2022 08:46:00 -0800 (PST)
MIME-Version: 1.0
References: <1645114959-119064-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1645114959-119064-1-git-send-email-john.garry@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 17 Feb 2022 17:45:49 +0100
Message-ID: <CANpmjNOO6yxF+xXoatR==uvSaEwsWyZ=n7ExEM_=OJaDYBCeSw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip Sigtrap test for arm+aarch64
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        leo.yan@linaro.org, dvyukov@google.com, will@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 17 Feb 2022 at 17:28, John Garry <john.garry@huawei.com> wrote:
>
> Skip the Sigtrap test for arm + arm64, same as was done for s390 in
> commit a840974e96fd ("perf test: Test 73 Sig_trap fails on s390").
>
> As described by Will at [0], in the test we get stuck in a loop of handling
> the HW breakpoint exception and never making progress. GDB handles this
> by stepping over the faulting instruction, but with perf the kernel is
> expected to handle the step (which it doesn't for arm).
>
> Dmitry made an attempt to get this work, also mentioned in the same thread
> as [0], which was appreciated. But the best thing to do is skip the test
> for now.
>
> [0] https://lore.kernel.org/linux-perf-users/20220118124343.GC98966@leoy-ThinkPad-X240s/T/#m13b06c39d2a5100d340f009435df6f4d8ee57b5a
>
> Fixes: Fixes: 5504f67944484 ("perf test sigtrap: Add basic stress test for sigtrap handling")
> Signed-off-by: John Garry <john.garry@huawei.com>
>
> diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> index 1f147fe6595f..3f0b5c1398b5 100644
> --- a/tools/perf/tests/sigtrap.c
> +++ b/tools/perf/tests/sigtrap.c
> @@ -29,7 +29,8 @@
>   * Just disable the test for these architectures until these issues are
>   * resolved.
>   */
> -#if defined(__powerpc__) || defined(__s390x__)
> +#if defined(__powerpc__) || defined(__s390x__) || \
> +       defined(__arm__) || defined(__aarch64__)
>  #define BP_ACCOUNT_IS_SUPPORTED 0
>  #else
>  #define BP_ACCOUNT_IS_SUPPORTED 1

This is now equivalent to BP_SIGNAL_IS_SUPPORTED
tools/perf/tests/tests.h -- and different from the original
BP_ACCOUNT_IS_SUPPORTED (and makes me wonder why
BP_SIGNAL_IS_SUPPORTED wasn't just used from the beginning). Perhaps
just use BP_SIGNAL_IS_SUPPORTED.

Thanks,
-- Marco
