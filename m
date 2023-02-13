Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BABAC636D4
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Feb 2023 17:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBMR30 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Feb 2023 12:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBMR3Z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Feb 2023 12:29:25 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171879776
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Feb 2023 09:29:24 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cq19so11218870edb.5
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Feb 2023 09:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pixielabs-ai.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vYetjgGQCTHzhcamPkMkvapmKCJxR3hzSMjQWn+e1bQ=;
        b=TLa2S92m+TAU5I06oggp7NqTe5ElIeFvf4A3V4G56wpiWApCY9duYR00Ol9HJEHOsj
         GVhH1rDdoYw8o8TG0zbamORw5tSWgDe3wvQxOvXlpXjDnGKlz1vBwk5biPKyldqNYAsu
         zBHfsHLWOjdONVWOvpKV7uCnZEYU/wgo3/PYN+mfw26Th9Z/ZirWceG74OYxfs+/PRsX
         YO/LEYv7pq//qTAdtF2CeMI9taGM/RB4QPuWxeKjN6B8c0IzDpjV+XtqZJcRU9QXKDO+
         6/HEuVtUUIf7pNgmqW1z9XCATfDFIAmLs9Eg0o1QB1xsmHM0zQhz5xjAaD8dnMY1WLYQ
         B5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYetjgGQCTHzhcamPkMkvapmKCJxR3hzSMjQWn+e1bQ=;
        b=Xt9R/ymWIbMzJyBe0lh6xm5Ro+P3SKAXB0ta+xdim9AwTO5z4prB8IDKMzxKCqYj7R
         8C9dwaJ3nlP6xP1IZ1kcvTJ4DIxyDCVSWj9C5fZ1E5NWwVG7ble90aMvTsTGwxDR6ig+
         gMEU1cPmGdJnIIYBxZALhAzGy52JoYuJVASw9+wEt/U1s1ayxAti7qFbaGzDEI/3s78e
         EElhy/rWiLy3w4is6W0Hren5PfTW5rkXUd+Y4HFgHkO4nlWT004Dwh00ABv5Tf9hqDXi
         0bTgYQgTUYfn/gW6BScmEAgOPPjWVtCfw5lyyR+tvsfODtXmJYwPrb0rJtBRknnqCeYe
         EA3A==
X-Gm-Message-State: AO0yUKU99UIcvApEFmQyYw89YFgbmHXPGLTvydyFHMI8yGl1yIRdw+IS
        j0P5ao1d4KD3aPB3aqjS2F6dPyDE6emSpvVmTXkI3gJGnt7ymKh1
X-Google-Smtp-Source: AK7set/B8PjRqIpXiU/lfK5nqfayclrqhfomHHilQVIpkLwAJlB3oex0TGHOoH4o8TtvHkwEL9nFCPPKVeNLdk4zCNE=
X-Received: by 2002:a50:9e27:0:b0:4ac:c6c7:631d with SMTP id
 z36-20020a509e27000000b004acc6c7631dmr1823390ede.4.1676309362487; Mon, 13 Feb
 2023 09:29:22 -0800 (PST)
MIME-Version: 1.0
References: <CAK2+a3QGJ6gJEiBwH831aWUqaBUskhmbyfz43cLk2vpSX_UT6A@mail.gmail.com>
 <CAP-5=fWNgPGO-Zx6398=6tuGzwxQm0Hz9v=GfOufxoTJEWrCWw@mail.gmail.com> <894c0e96-b450-dfc1-fc70-31e21194f10a@arm.com>
In-Reply-To: <894c0e96-b450-dfc1-fc70-31e21194f10a@arm.com>
From:   Pete Stevenson <jstevenson@pixielabs.ai>
Date:   Mon, 13 Feb 2023 09:29:11 -0800
Message-ID: <CAK2+a3RUFEb4ooe9BehBnBkOKgVt8n4Z28Ryzr2E4SH0--iiWg@mail.gmail.com>
Subject: Re: missing stack frames
To:     James Clark <james.clark@arm.com>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

James - the comments about dwarf make sense -- I will double check the
results using --call-graph=dwarf.

Thank you!

On Mon, Feb 13, 2023 at 1:54 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 09/02/2023 03:36, Ian Rogers wrote:
> > On Wed, Feb 8, 2023 at 5:54 PM Pete Stevenson <jstevenson@pixielabs.ai> wrote:
> >>
> >> We have crafted a program where with some definite expectations about
> >> what stack traces we expect, but in less than 1% of the samples, we
> >> see one stack frame missing.
> >>
> >> Roughly speaking, we see the following:
> >> libc -> main -> foo -> bar (99.49%) (expected)
> >> libc -> main -> bar (0.51%) (not expected)
> >>
> >> That is, in 0.51% +/- of the cases, the stack trace samples collected
> >> by perf appear to indicate that "main" is directly calling "bar" which
> >> we do not believe to be the case. We first observed this in a slightly
> >> more complicated setup with a different profiler, but have been
> >> chasing this down to a fairly reductive example. We ran the perf
> >> profiler using a few different command line options (with and without
> >> -g and --call-graph dwarf) and saw the same basic results with each
> >> method.
> >>
> >> Curious to know if anyone understands the underlying cause of this...
> >> Is it something like a non-atomic sample of the stack trace, i.e. the
> >> stack frames are being manipulated while the stack trace is being
> >> sampled? Something else?
> >
> > It is possibly an issue with frame pointers. On x86 function entry looks like:
> > push %rbp
> > mov %rsp, %rbp
> >
> > Stacks grow down, the x86 representation is:
> > https://github.com/torvalds/linux/blob/master/arch/x86/include/asm/stacktrace.h#L101
> >
> > The stack can only be walked if both of the entry instructions have
> > been executed and the 0.51% may be inside these first two instructions
> > (or similar in the function epilogue).
> >
>
> On Arm we had an issue that looked like this when using --call-graph=fp,
> but we managed to insert the second to last missing frame in Perf using
> the dwarf as a post processing step. This was because leaf functions
> don't insert a frame pointer, even with -fno-omit-frame-pointer because
> there is no point.
>
> With --call-graph=dwarf I would expect the stacks to always be complete,
> even with inlining and missing frame pointers. Unless you aren't
> including all the debug symbols or stripping them afterwards or
> something like that? Otherwise it could be a bug in libunwind or libdw
> or the dwarf generation.
>
> James
