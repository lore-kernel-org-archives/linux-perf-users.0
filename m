Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D499EEB565
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Sep 2023 23:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbjIHX4U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjIHX4U (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Sep 2023 19:56:20 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91102133;
        Fri,  8 Sep 2023 16:56:16 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d7f0a60a159so2283369276.0;
        Fri, 08 Sep 2023 16:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694217376; x=1694822176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fduUCFN1Wge3LY7Pmf8tbiG6qwcGsnDEnR60i43Dug=;
        b=uH11FijiQ1Cp33fWFePd7hgSZQUlzYJTIf+bXK8CISCER2enTpP4hdykyB2cIadaZJ
         V6q1vQlqt5cC15D/qnkscOm6bWdzrri47sFEdCBbLLhD692LS0MimBsFSQnFaMF/6t0I
         ENmI5YAI55/P+r0uOlYxJX/5c1x/jekyKWYkwEuysiO63OQoHDUD8j16NEhL1/uM0VNS
         FW9W0C+8MrmXvVGvS/Y0YBlyb97eJdiaQPDLzRDOFvarsmxPj6X3WE0abBu8VxsSKbgA
         nZmXnX1KA1Sqn0hDjOl24Ibf8JOs+iI/2vLn7xka5sNPlfPHwuMr74QFUsUCpfxwTm9+
         xBpw==
X-Gm-Message-State: AOJu0Yw1f6yYFJcB/jlVl29b2rdTA29ZsNJzZ7ZadybBaRGQ3UGLhkWz
        8lrYHqxRoKL1VosWDyXFdCcQ81EkEQborCWjXMY=
X-Google-Smtp-Source: AGHT+IFpPpodW4aTMB2R61kpjLaDyqIbx6kCtrohLpibG63gjKxeOMguL8CNXvS7QlLEljxFwDZi+X53sPI3clZKjkM=
X-Received: by 2002:a25:9208:0:b0:d44:19e9:4c6d with SMTP id
 b8-20020a259208000000b00d4419e94c6dmr3611037ybo.65.1694217375658; Fri, 08 Sep
 2023 16:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230908052216.566148-1-namhyung@kernel.org> <CAP-5=fUtEvW9h7N=w3vvYBB3vytnTXJsXrHDD6zLA2DzYFOBHQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUtEvW9h7N=w3vvYBB3vytnTXJsXrHDD6zLA2DzYFOBHQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 8 Sep 2023 16:56:04 -0700
Message-ID: <CAM9d7cj1rEjGy0QM2tkJhBn=hac-9Jya+ZJ4SNhBmB29u5KVMg@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Add more x86 mov instruction cases
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,

On Thu, Sep 7, 2023 at 11:24 PM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Sep 7, 2023 at 10:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Instructions with sign- and zero- extention like movsbl and movzwq were
> > not handled properly.  As it can check different size suffix (-b, -w, -l
> > or -q) we can omit that and add the common parts even though some
> > combinations are not possible.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/arch/x86/annotate/instructions.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
> > index 5f4ac4fc7fcf..5cdf457f5cbe 100644
> > --- a/tools/perf/arch/x86/annotate/instructions.c
> > +++ b/tools/perf/arch/x86/annotate/instructions.c
> > @@ -74,12 +74,15 @@ static struct ins x86__instructions[] = {
> >         { .name = "movdqa",     .ops = &mov_ops,  },
> >         { .name = "movdqu",     .ops = &mov_ops,  },
> >         { .name = "movsd",      .ops = &mov_ops,  },
> > -       { .name = "movslq",     .ops = &mov_ops,  },
> >         { .name = "movss",      .ops = &mov_ops,  },
> > +       { .name = "movsb",      .ops = &mov_ops,  },
> > +       { .name = "movsw",      .ops = &mov_ops,  },
> > +       { .name = "movsl",      .ops = &mov_ops,  },
>
> In Intel's manual some of these names are "Move Data From String to
> String" operations, movsb and movsw in particular. These instructions
> can be used to make simple memcpy loops. Could it be the past omission
> was deliberate due to the different way the addressing works in the
> instructions?

I don't know but in terms of instruction parsing, they are the same
"MOVE" with two operands.  I'm not aware of anything in perf with
the operands of these instructions.  So I guess it'd be fine to add
these instructions even if they have different underlying behaviors.

Thanks,
Namhyung
