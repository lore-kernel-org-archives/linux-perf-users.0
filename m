Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDA8C43334
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Jul 2022 16:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiGKQQr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Jul 2022 12:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiGKQQq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Jul 2022 12:16:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98F77AB3E
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Jul 2022 09:16:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so5312644wme.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Jul 2022 09:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ac36GHPqLNsKOXcJS/JCbJrssirgqDImIw++AW07FLQ=;
        b=pXWRziR+xf0tdp3I549Xqt9JU5O3nTo6+wSVg1y007y5PLEbTQOGzKrJGShjdvVtrv
         8UHQGtmjgrEIg3Tzq2LHpsiULUkwgXbZO7VSx20IfgHUHpJpVeKL6Mzzcqs2BKVmBtbo
         QeYmy/hbYwxIWvTKMbZREOmGfjFvpN/pVRG9WQslb8/0PUxOwaODlAmK/v/t5DB9cG0A
         Kumu0fwerixNZioMEy4lbiNYiOkFez3ABXUtc+Nk8Qgf4ikFVAan8pTQh+rdwx3ondzo
         wqxIDWIF7Q+S8KQc9uB//buebsGFFVU8m2ovJsRX93IdxH5jlNhP+v/IIk53kYZAPqSi
         aznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ac36GHPqLNsKOXcJS/JCbJrssirgqDImIw++AW07FLQ=;
        b=VYdZeYJ4M+1r9p/Vrngno2ecNCX15gXaENfOQhnMgF5K3fSUAQAHtHi6R1oSxD870u
         RSKDsvf5BmBWc7vPh/nq/9KgE2aFV11n2Wyuzbd2ItBvcSDAIKl8u1DPlxilAZDDJZ/w
         esCG6VW8Cc6mmkxy7uvPa5s0UpOOnG8rN76KpsFSRJ8/NkYGxFbH3O+hInncBVy0Smwm
         HI4hOROSYi4DBJxwrqUQeqitg5Xw+fHqxczoEb0HFq6muvv3RtRvd/vE6h9oua5QA3QH
         x1LxqgdzBIetStml9CAvjJrwZlKPNN1DvJLicgnQqnsxIVLrdHmgCnGY3sVeOFiWlipG
         VACw==
X-Gm-Message-State: AJIora+tDvwSfWwErDtldLBFGNZc+nQ+CLqm8nvLQlwNIvq1F7bpW9c9
        XZCVnE9ARkfc68pxR5gDjNtOFSfVb3XrdzBa3+M0LQ==
X-Google-Smtp-Source: AGRyM1sYtHZti/+mAu1TajubUU19ISNKfS6YUhimVsHN0bol+a9rmCs3QIR+qiHePachhZeYRlqYJPEYiHX17TSbzY8=
X-Received: by 2002:a05:600c:4e4c:b0:3a0:53a2:48b5 with SMTP id
 e12-20020a05600c4e4c00b003a053a248b5mr16127029wmq.174.1657556203057; Mon, 11
 Jul 2022 09:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220701063949.1769434-1-anshuman.khandual@arm.com>
 <b9da8d22-6896-68a3-b4e5-e8fd7b82b711@arm.com> <Ysgxzxl0N7+J8Vbt@worktop.programming.kicks-ass.net>
 <d03e334a-ec7e-cd87-7f0b-ac7564266d3a@arm.com> <YswVWwwXi6zWaEAy@hirez.programming.kicks-ass.net>
In-Reply-To: <YswVWwwXi6zWaEAy@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 11 Jul 2022 09:16:30 -0700
Message-ID: <CAP-5=fW+S3UoqzUc7_+ZmaAj1b=0RtF5p9WHzw23t2AoWZGd9Q@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Add macros for possible sysctl_perf_event_paranoid
 values
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 11, 2022 at 5:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 11, 2022 at 02:55:12PM +0530, Anshuman Khandual wrote:
> > Enumerating [-1, 0, 1, 2] paranoid range values in kernel too, does not add
> > much value as well ?
>
> That's what the user-interface requires as well. How is obscuring the
> values the user has to explicitly poke in help things?

Perhaps a helper function like ParanoidAndNotRoot that takes the
failing paranoia level such as here:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/tests/shell/stat+csv_output.sh?h=perf/core#n48
would help clean this up. Perhaps something that explicitly calls out
this is a permissions check. Cleaning up permission checking seems
like useful value add. We've been trying to do something similar in
tests to make them skip rather than fail due to permission issues -
this should increase the signal perf test gives.

Thanks,
Ian
