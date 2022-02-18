Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CCBC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Feb 2022 09:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiBRJoo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Feb 2022 04:44:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiBRJon (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Feb 2022 04:44:43 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D1824BC9
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Feb 2022 01:44:27 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id c6so18443284ybk.3
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Feb 2022 01:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TGdjV0Q3xyVks5N4khTecn3sldyZnJb3gKUY1KtrMU=;
        b=AOlbdfQfIplSLJ+l7JlFsTZZwiIAFQP4vIRwLqfU+sjpXwwcGu+odpiC4icGnuczPs
         KCQ7UdnoBYRMsYk4KeyzhC7qAGYFA6E0Qpq1O8DZcHvVi2MjhrMYLTiUb75o29fdI75c
         CKuYhRHEpbSSPBB14diyEqMWUJEOPcEGtzPdzR+LoAq888eDJge9JXTuL5kepYYkD1cg
         QhlHmg2DKjFO5jG057keS4XhnJcVSMwgq5fnEB5xAJIPsb5YlIYAsux692PLMV3ZZHpX
         lfFUmmSibdwm0f4NpT9WiEByUqvPez+8mLlHyJBgv/9VM10QxKwTWqjEryMUlv6dNWKb
         dqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TGdjV0Q3xyVks5N4khTecn3sldyZnJb3gKUY1KtrMU=;
        b=PSm+lrXmpS0NbwFrlZ6aooJRs6ng1uHVKXRKhHVZ92hQIKhdi/XWfeOIZwbOp0Hhah
         zHii9YINgdYajHhyBwlXzUcqRrYxEv4P3bkLDz14b09AHFzMRL/4gW5r+9CEyhhxhJt0
         /yjLsABeGm5lERqGH8BlXkTT9bgygkZAgQrVQDbpY33x9VPsRnVW1kyPZQ9HWNN68H5f
         8rHiBbbQLauxM0niK8hEAD1IwcItsbbGNgtQ9e7m6QVkvZf2nBPO3Y/iA4QlPDMdxLSY
         OzdnQgAr73UtZR9JQRx97ylBQaWbz4jccGPjTlpvNC6vDqskP05YKEmevJ6/OPP9bmRo
         C1XA==
X-Gm-Message-State: AOAM533mmK6Yvfoh3Z/a3tTbIG4bEGcIWdaw+qRnHmjG09R2LDD4BBNu
        nai549bYi+50BKiqWuJqMu0duyQ9911sMhDP1Oksew==
X-Google-Smtp-Source: ABdhPJzA46WERAi0kdsB5sx7dXGjsix8eJtkQhaYxjn+ahZ0OgZmhU+uPdP7ygKFCmqJscjB9WRhduaBjvniEosQ+dk=
X-Received: by 2002:a05:6902:2:b0:624:4cb5:fd3b with SMTP id
 l2-20020a056902000200b006244cb5fd3bmr791226ybh.1.1645177466506; Fri, 18 Feb
 2022 01:44:26 -0800 (PST)
MIME-Version: 1.0
References: <1645176813-202756-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1645176813-202756-1-git-send-email-john.garry@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 18 Feb 2022 10:44:15 +0100
Message-ID: <CANpmjNMVz0VoBvV74AJhCYoP5yVad0JwOpY47YhUrqsZqF7NZw@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Skip Sigtrap test for arm+aarch64
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        leo.yan@linaro.org, dvyukov@google.com, will@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        tmricht@linux.ibm.com, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, 18 Feb 2022 at 10:39, John Garry <john.garry@huawei.com> wrote:
>
> Skip the Sigtrap test for arm + arm64, same as was done for s390 in
> commit a840974e96fd ("perf test: Test 73 Sig_trap fails on s390"). For
> this, reuse BP_SIGNAL_IS_SUPPORTED - meaning that the arch can use BP to
> generate signals - instead of BP_ACCOUNT_IS_SUPPORTED, which is
> appropriate.
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

Acked-by: Marco Elver <elver@google.com>

Thanks !

> diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> index 1f147fe6595f..e32ece90e164 100644
> --- a/tools/perf/tests/sigtrap.c
> +++ b/tools/perf/tests/sigtrap.c
> @@ -22,19 +22,6 @@
>  #include "tests.h"
>  #include "../perf-sys.h"
>
> -/*
> - * PowerPC and S390 do not support creation of instruction breakpoints using the
> - * perf_event interface.
> - *
> - * Just disable the test for these architectures until these issues are
> - * resolved.
> - */
> -#if defined(__powerpc__) || defined(__s390x__)
> -#define BP_ACCOUNT_IS_SUPPORTED 0
> -#else
> -#define BP_ACCOUNT_IS_SUPPORTED 1
> -#endif
> -
>  #define NUM_THREADS 5
>
>  static struct {
> @@ -135,7 +122,7 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
>         char sbuf[STRERR_BUFSIZE];
>         int i, fd, ret = TEST_FAIL;
>
> -       if (!BP_ACCOUNT_IS_SUPPORTED) {
> +       if (!BP_SIGNAL_IS_SUPPORTED) {
>                 pr_debug("Test not supported on this architecture");
>                 return TEST_SKIP;
>         }
> --
> 2.26.2
>
