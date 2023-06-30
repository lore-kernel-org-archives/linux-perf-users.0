Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350E5EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jun 2023 18:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjF3Sn0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 14:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjF3SnZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2023 14:43:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575A73C35
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 11:43:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-992b2249d82so229694666b.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 11:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688150602; x=1690742602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jPEvXo6WjRs1USguPeZQCvSg+BfPycq4avRrgWVGqyM=;
        b=Tfd4srCUb5pQPtWZGrzEItpOby83+pCgDydvDuEEyTa7LSdNmjIMuWUxGxMnwUiKw3
         hhL+mYcTJpREALUKA7NuMx6BzVcp3tgEfPFtW5rIpw93SYNEbPlwJfzvHMzcEMDCb0a1
         dO6nTRA+ES7Ob6qnlZ64kGLfbiUn+5ya26kN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688150602; x=1690742602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPEvXo6WjRs1USguPeZQCvSg+BfPycq4avRrgWVGqyM=;
        b=Z5x4D4Yv7rv7b8OxZXU0iURexKIobuEXDGO/nD3OTBCR3wJTLtAsDu3m9jiYYstmRC
         /9K1pRo3Gt/gzVcZEQy6t+FtBs//oq7ByN8x2GmbeKQ3WMxc/lOTp/SOQeJETfvETeaG
         PCUUz4l1COhUHeXo2iy/WKgdT93c0KOPrrOa8dmVUvwMokR4mr87R0jrs8yDqwGKdFQd
         BYzsYPAxAlvBOtStyBWhLt2QTOCPqslbzPh/QT33Vh+eaUuREfw5hHfTBilUdz2TmvPZ
         CCbWc4bGmN9XSRnog5aANJ8fvsZqEllV0AN2tyes4KrXpgWm81tG/EnVkS1q+y7/szwt
         SVYw==
X-Gm-Message-State: ABy/qLZUnpvQTt1Q+/3TD+8qRTllLXd0xtuwkA21cTZd8TRcb7yO7N00
        wNeRAOpSpfu3raoALhcpzDxhUOYBPGu43kPfXRRfgeIv
X-Google-Smtp-Source: APBJJlHWT0153IUilKT7obfEKIuIKOs2SlH9GxCoNKta9oNmZrILSKHnbdNOZTFm7qlJFv4kauQHag==
X-Received: by 2002:a17:906:3bd3:b0:991:e961:a5f4 with SMTP id v19-20020a1709063bd300b00991e961a5f4mr2575024ejf.20.1688150602574;
        Fri, 30 Jun 2023 11:43:22 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id p21-20020a170906499500b0097404f4a124sm8376043eju.2.2023.06.30.11.43.21
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 11:43:21 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51d885b0256so2590753a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 11:43:21 -0700 (PDT)
X-Received: by 2002:a05:6402:3456:b0:51a:50f2:4e7a with SMTP id
 l22-20020a056402345600b0051a50f24e7amr2198661edc.13.1688150601530; Fri, 30
 Jun 2023 11:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230628215954.1230048-1-namhyung@kernel.org>
In-Reply-To: <20230628215954.1230048-1-namhyung@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jun 2023 11:43:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whOLQsPiDJifHzfg+q-W4q=MXcbvzKLS4J4otOicbZqjA@mail.gmail.com>
Message-ID: <CAHk-=whOLQsPiDJifHzfg+q-W4q=MXcbvzKLS4J4otOicbZqjA@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.5
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, 28 Jun 2023 at 15:00, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Please consider pulling perf tool changes.  I'm doing this on behalf of
> Arnaldo as he's on vacation.  This is my first pull request and hope I
> didn't break anything. :)

Things look normal, although I find your pgp key situation confusing.

I looked up your gpg key from the kernel.org pgp key repo, but that's
apparently not the one you used for signing this.

So I have two keys for you, and neither of them are then signed by
others (although that part is probably just the usual pgp mess with
signatures being dropped due to flooded bogus signatures, which has
made the whole pgp infrastructure be essentially close to useless).

Anyway, I wish the pgp key situation would be better, but it's not an
actual problem.

HOWEVER.

What _is_ a problem is that the end result doesn't build cleanly.

The

        if (list_empty(&pmus))
                perf_pmu__scan(NULL);

        ibs_pmu = perf_pmu__find("ibs_op");

in the amd-ibs-via-core no longer works, and it seems that it should just be

        ibs_pmu = perf_pmus__find("ibs_op");

That's fine - I can do (and did) that merge resolution - and it's part
of my normal "merge and test build", but I'm slightly unhappy that I
wasn't told about this part.

The actual data conflicts were trivial. But this was a semantic
conflict that was invisible to git, but showed up in build testing.

And I *think* you should have known about it, because the conflict you
do talk about shows that

 +perf-y += amd-ibs-via-core-pmu.o

as part of the actual data conflicts.

Anyway, I've resolved this, and it wasn't a *problem*, and I'm just a
bit unhappy that it took me by surprise.

              Linus
