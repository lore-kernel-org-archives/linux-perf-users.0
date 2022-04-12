Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1631C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Apr 2022 16:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbiDLQkp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Apr 2022 12:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357719AbiDLQkm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Apr 2022 12:40:42 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C403B1CB16
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Apr 2022 09:38:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r7so12289172wmq.2
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Apr 2022 09:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Ai2FXsz1lpt5CfIxcPnvg2o3bfj4cEdKtHkGdr3+zI=;
        b=imNfUf/wOpAGo1uNfQpoA2iEh1kGwTKLlDTs+2Yv+2jwGd1c17AaSDQ6DB+zMQkSsK
         i/v57BtZOinugDf4u923xuMtsHWbMI+Wb3h9eVNrb4gVyi/nhH86Klv11pXYd58eEdPW
         D9e6dpcgqLg0KxqqXwCLXF3Cu1cGMXWrbdcmbQYYVOCz0irJZcBLxJS6M16/6K3R16Jf
         qJt0OGpWte4v2vH3lT/1evIK+iUpljcflDmzOPG8TAbpm/UDdZ2y2Dl7NhNo6s5xnUDG
         AooQ9KV7uFH16AAbNBu901Jnbv4+sZyXDTfmqjAe9eJ5uvUoB+Nf1SFuAMv6dwGwy8j/
         ofQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Ai2FXsz1lpt5CfIxcPnvg2o3bfj4cEdKtHkGdr3+zI=;
        b=driJFnicy+E0SuhYpqjOyhMrfzsrYboXjN/PjZQX2xUboZdh/7BiRFRxhsSTHeXtT/
         c4waIY14kx8kfCWKCTiCyqnHVsF9RgbqDJzlo8LBkxpDOWU3YYORJVjGrIkJAk+myDJg
         NZ7BuU/U4nn/LHh7gBWMkQ8U8l4/Kxxx4FCcVzbtagucGS0/FPb/1OqMnX0opCovnHiY
         5wFmvRDdNbo+lha1TDbuW5T2odYq0oIhE/7gpD66x/h3f22TmvlerYZyjwifgkjTV6Ca
         OXKs5zZBtJOnAIJy7RJtjlDjCb8USZfisWcZwNiyPPtQfFsgwsnpaNUb/VsXsshYeCQh
         FazA==
X-Gm-Message-State: AOAM533M+AhTzSyGAiaPEQkVl/4P3C5EdJdPhNFAMUcwvLKQKEk3oyV8
        kY8l6IJLswFSNyuYU6Qu6H7ooVvSWQDCMHxGE7t2Zw==
X-Google-Smtp-Source: ABdhPJwNHGYzgZeCRDmI1E/jH3hxhARvf2Ltz+BaLth4rt9H5etkb227vDWbmsUtfeiaaAivFgb8yU6wQUyl1952Obk=
X-Received: by 2002:a7b:c77a:0:b0:38c:2c33:d8f1 with SMTP id
 x26-20020a7bc77a000000b0038c2c33d8f1mr4839993wmk.115.1649781503016; Tue, 12
 Apr 2022 09:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAPS78prVW-RRgzpBoYONRvmZz5DotizX9t8U4aWd2qLb1x9D=w@mail.gmail.com>
In-Reply-To: <CAPS78prVW-RRgzpBoYONRvmZz5DotizX9t8U4aWd2qLb1x9D=w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 Apr 2022 09:38:10 -0700
Message-ID: <CAP-5=fU0NEgdEwv1cGtvF2-cRLO=wOZ5UF0QCK3toJf2tnT3TQ@mail.gmail.com>
Subject: Re: [GSoC] Applicant Introduction, project selection
To:     Tanusree Debnath <tanu235m@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        arnaldo.melo@gmail.com, mingo@redhat.com, acme@kernel.org,
        peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Apr 11, 2022 at 9:21 PM Tanusree Debnath <tanu235m@gmail.com> wrote:
>
> Hi,
> I am Tanusree Debnath. I have graduated from San Jose State University
> with a bachelor's degree in computer science. I love to program in
> different programming languages. I like open source projects, and I
> recently started contributing to open source projects. I have been
> using the linux operating system for over 5 years now. I always wanted
> to contribute to Linux and recently I started contributing to the
> Linux operating system.
>
> I am interested in contributing to the "Perf data converter" project.
> In preparation for this, I have already submitted three patches to
> Linux perf out of which one was accepted.

Awesome, thank you for your contributions!

> My IRC nick is Tanusree.

Apologies, I'd dropped off but will try to make sure I'm on IRC for
people who want to talk about GSoC.

Thanks,
Ian

> Thanks,
> Tanusree Debnath
