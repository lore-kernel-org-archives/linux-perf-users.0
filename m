Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F13C38A2D
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Oct 2022 18:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiJZScm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Oct 2022 14:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbiJZScP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Oct 2022 14:32:15 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB97E10CF84
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Oct 2022 11:31:24 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id bn35so14720115ljb.5
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Oct 2022 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KGZ+b7AE38d+5UwfXCy0/gevM/R3+Wu+DeyQvG3oHGU=;
        b=DA6R5PRs05EXklso+W+hmkRSKmzNFrdlPHrumf+P6eNAP70ubDQfmKrY+otZcTcLXd
         CvPxCWq7muIGmO6qHrzr8TZAArg4hJQvXvNa/XR/Txdac+G9sXF2XEI+0ipXHNZXopJb
         cCFh/U5GCO8Y6ZAPEq/Ub3W6ZW70eV4cp/opqeWC5W5/VRQ703eMPH2f56teUZFC1qCQ
         3rNMcTofJP+b4HhxsvqYQa4aB6TAiD0oquv8SDMwsUIOkwcyo5GWRlSf6WLHWQm13GoX
         Go1qpse67K0WNXpt7GKFHSSGKl+KOjkVrzcwoCzl5EmtT8wjEa8OjOr5cOmLGL8U7txE
         qbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGZ+b7AE38d+5UwfXCy0/gevM/R3+Wu+DeyQvG3oHGU=;
        b=0kLBZWg1qqA2tyKKCEkAClz6FCC51lwxdcs9x7OI/Xb4cImp1Ne7ZO0EOgrVxjLAs4
         8U844uGP3ML+Abo5LOLYj9/LhsFl+r3/yjw1t4YtvSjuaE5vvWex//Ubif4nl4T+8Y3e
         yNUPOFv8Y+tH3bMsXth8J4yLqRODO3aJ6bMsocMNeJ+EP72DUI/NYoODd59nNSwkMseL
         UIok4lUyMeH5efAXJAzsSoXAa2uj/Oq87pmA/bU1Va2lt5m9M2brSNMyl17nylIt1EdI
         hUrF6lbHx3A0ppAFz9ThF77SNQXiy2StlczTcnxVPW3ud17HrkEUJXtAzEr1dXjLkuU3
         q3KQ==
X-Gm-Message-State: ACrzQf22tL7Cy/5fuRLwGWy4hqCBEtKEtPi31vLtC/GPe0TYQi3DXuII
        sNT1o0Op8uU6u2rWp1dl0u4cCS7m+9ExWgNOk0Ovkg==
X-Google-Smtp-Source: AMsMyM60aH64MsXumBnoFULKI736s7tM2Ujc/LnIfGhSG75YqtviPQqK5e+Gvb+A4hRb8CzOSg9Ik6Fmdlgjaccraik=
X-Received: by 2002:a2e:7303:0:b0:277:c7c:9c61 with SMTP id
 o3-20020a2e7303000000b002770c7c9c61mr6631853ljc.274.1666809082407; Wed, 26
 Oct 2022 11:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221026141040.1609203-1-davidgow@google.com>
In-Reply-To: <20221026141040.1609203-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 26 Oct 2022 11:31:10 -0700
Message-ID: <CAGS_qxrd7kPzXexF_WvFX6YyVqdE_gf_7E7-XJhY2F0QAHPQ=w@mail.gmail.com>
Subject: Re: [PATCH] perf/hw_breakpoint: test: Skip the test if dependencies unmet
To:     David Gow <davidgow@google.com>
Cc:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Oct 26, 2022 at 7:10 AM David Gow <davidgow@google.com> wrote:
>
> Running the test currently fails on non-SMP systems, despite being
> enabled by default. This means that running the test with:
>
>  ./tools/testing/kunit/kunit.py run --arch x86_64 hw_breakpoint
>
> results in every hw_breakpoint test failing with:
>
>  # test_one_cpu: failed to initialize: -22
>  not ok 1 - test_one_cpu
>
> Instead, use kunit_skip(), which will mark the test as skipped, and give
> a more comprehensible message:
>
>  ok 1 - test_one_cpu # SKIP not enough cpus
>
> This makes it more obvious that the test is not suited to the test
> environment, and so wasn't run, rather than having run and failed.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

This patch makes this command pass for me.
$ ./tools/testing/kunit/kunit.py run --arch x86_64
Since this test gets picked up by default, having it pass for common
uses of kunit.py is a priority, IMO.

(Note: if I add --alltests as well, these were the only failures)

I agree with Marco that TAP/KTAP saying "ok" for skipped tests can be
confusing at first.
But a SKIP status feels more appropriate than FAIL, so I'd strongly
like for this change to go in.

> ---
>  kernel/events/hw_breakpoint_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/events/hw_breakpoint_test.c b/kernel/events/hw_breakpoint_test.c
> index 5ced822df788..c57610f52bb4 100644
> --- a/kernel/events/hw_breakpoint_test.c
> +++ b/kernel/events/hw_breakpoint_test.c
> @@ -295,11 +295,11 @@ static int test_init(struct kunit *test)
>  {
>         /* Most test cases want 2 distinct CPUs. */
>         if (num_online_cpus() < 2)
> -               return -EINVAL;
> +               kunit_skip(test, "not enough cpus");

The only minor nit I have is that I'd personally prefer something like
  kunit_skip(test, "need >=2 cpus");
since that makes it clearer
a) that we must only have 1 CPU by default
b) roughly how one might address this.

Note: b) is a bit more complicated than I would like. The final
command is something like
$ ./tools/testing/kunit/kunit.py run --arch x86_64 --qemu_args='-smp
2' --kconfig_add='CONFIG_SMP=y'

But that's orthogonal to this patch.
