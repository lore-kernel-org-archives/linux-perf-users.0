Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD84C636CC
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Feb 2023 03:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjBIDhN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Feb 2023 22:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjBIDhM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Feb 2023 22:37:12 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872901ABEA
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Feb 2023 19:37:10 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so2952086wmb.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Feb 2023 19:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jOgT4GdvZa5jEVGZKRj6I6nTwqrpQo+1FFavkNlMM2M=;
        b=iTd7osQSkF+DhPtvQYIOxGPXppz4Zuo6MEnjE/KEckcX5EFcqAWuUNokO1LPFrbuXw
         5mHcWj4GyDyccUGrHvavXY7sK3JnZzlgzBk96QPpip+JT1GNLGWtYxG3vsxMbjtoDuov
         jGq/9uTePtlMbMdfXS0HZ5P9UOjI8Ijoj5ZE3DpaxVNBqJ+mePnAZfVTQHgt6xKoOLg2
         6bE+vI0KCQZrqwccw98iFPErwQTQSZ6cXNKv2kGIUEkzwVr6O6TOaHyifiYC5o+mIlqS
         WIFbjUEJuZvwNxlc90NmBWHWiywN2vAZtJqkvpyf6fCFE3UuW7oV2h/Y2BvcFwzP7//Q
         gsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOgT4GdvZa5jEVGZKRj6I6nTwqrpQo+1FFavkNlMM2M=;
        b=pzOYmTQs6DTtTjmgiP0zuLBoHBAXaNfbw9I5LHa9W3ekrm5ic5XH0f3rcM+Lhs0KBK
         cbOsZAfzgY79E5lxVOBRCjPE+SaAbCUUiyDKkAApNi8sRwfMJOFdujBcOvuSLmOFjLZM
         dGBKAFhB4ClV1n0+1jVM2UeAVGYQDijLMflHJA/71Z2u7kxau+mtHk0wJGZ5KE23PkA6
         qBDr6NFdvIY+o3TJ1QmrwkDi9j63e2mkEYaUES+C1gG32H1yHnBeJD0bdd5r02aG7M/+
         uGwD33d2d/t2Bz1w17n5pjEs/cQVjUedqj8EXLvCBxsQSJ2hC6Cq/hfFOyuZUxSKgCKg
         qOaQ==
X-Gm-Message-State: AO0yUKVISBz9npHadvYuo63lp2+sQf5fDKdhVuWdm5mIMH5DIx/Yr40Y
        xgyWp+C6a9chMaVqkx53hfP9HmQxnsaK/RjRwKFHst7JbE2AtsFYPYQ=
X-Google-Smtp-Source: AK7set+P7qA198FZNe3RNum821OTtK047qM0Pk4SLzZJz2sj7iwvcP8RaGSadSR7exCPvf704Hz37y+20C30rigwp3U=
X-Received: by 2002:a05:600c:350f:b0:3dc:599b:7963 with SMTP id
 h15-20020a05600c350f00b003dc599b7963mr410571wmq.60.1675913828906; Wed, 08 Feb
 2023 19:37:08 -0800 (PST)
MIME-Version: 1.0
References: <CAK2+a3QGJ6gJEiBwH831aWUqaBUskhmbyfz43cLk2vpSX_UT6A@mail.gmail.com>
In-Reply-To: <CAK2+a3QGJ6gJEiBwH831aWUqaBUskhmbyfz43cLk2vpSX_UT6A@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 8 Feb 2023 19:36:55 -0800
Message-ID: <CAP-5=fWNgPGO-Zx6398=6tuGzwxQm0Hz9v=GfOufxoTJEWrCWw@mail.gmail.com>
Subject: Re: missing stack frames
To:     Pete Stevenson <jstevenson@pixielabs.ai>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Feb 8, 2023 at 5:54 PM Pete Stevenson <jstevenson@pixielabs.ai> wrote:
>
> We have crafted a program where with some definite expectations about
> what stack traces we expect, but in less than 1% of the samples, we
> see one stack frame missing.
>
> Roughly speaking, we see the following:
> libc -> main -> foo -> bar (99.49%) (expected)
> libc -> main -> bar (0.51%) (not expected)
>
> That is, in 0.51% +/- of the cases, the stack trace samples collected
> by perf appear to indicate that "main" is directly calling "bar" which
> we do not believe to be the case. We first observed this in a slightly
> more complicated setup with a different profiler, but have been
> chasing this down to a fairly reductive example. We ran the perf
> profiler using a few different command line options (with and without
> -g and --call-graph dwarf) and saw the same basic results with each
> method.
>
> Curious to know if anyone understands the underlying cause of this...
> Is it something like a non-atomic sample of the stack trace, i.e. the
> stack frames are being manipulated while the stack trace is being
> sampled? Something else?

It is possibly an issue with frame pointers. On x86 function entry looks like:
push %rbp
mov %rsp, %rbp

Stacks grow down, the x86 representation is:
https://github.com/torvalds/linux/blob/master/arch/x86/include/asm/stacktrace.h#L101

The stack can only be walked if both of the entry instructions have
been executed and the 0.51% may be inside these first two instructions
(or similar in the function epilogue).

Thanks,
Ian
> Thank you,
> John P. (Pete) Stevenson
