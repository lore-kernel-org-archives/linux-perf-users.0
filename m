Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F7BC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Apr 2022 04:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345749AbiDLEXY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Apr 2022 00:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345786AbiDLEXI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Apr 2022 00:23:08 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6AB2F386
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Apr 2022 21:20:50 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id m19so11667uao.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Apr 2022 21:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=q2QdjCqo18Dzjk8Ld4ttoSDfl2EYdoJBbPg39MtRIdk=;
        b=BgWl1lDXdTl6zt8wBzeOUvPntIBF+bTYwMQ8PmYKURbN1DH54HL6eEgY9TA+87H2yZ
         Xpcpdk4W9iTe+KYP38YhjpeV0WuC6uoXy1k455v8TxAsqKAZqQgB+gke01o8NxyKScbQ
         2cHPSjA1xg6Wob4dMrXnzyqEe8QYNIChaTEfLACifmXkQdw40Amrf4OCidqjZNC9UHP5
         SyyAFBwvBNqi3rRTGZeiBK9INSgdigOJb+TAMlmidwDewJ81BY5famwzEaYF4szln/Xm
         LqDVWyjoKOUddZBckf8p3duHTjv2FN/sboYV0zJBX6oAVx6ovt3JuMKZMEmWEjB5tGzj
         KEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=q2QdjCqo18Dzjk8Ld4ttoSDfl2EYdoJBbPg39MtRIdk=;
        b=ChFNnRjnAdRtgZWpl8iAmsqmd4SiJjsKhkzuBo85wu7YVKvS+re4mKdJNV04bT/z/i
         s9hjkwxMqQULPtAcavDkvASw2H4B/ZaGnpDUcGffCD243DDGtaeB/PumPQlh80rIKWJS
         WoMk0uHASQU8MVryT9voyehgUE4qTDLLIPwctiohH71Ilw6jylTH7CWwAPQ5SwkBEqPC
         35c98MLza8I/Nr7vLFdTFOiyX8HSuEuHK5ieBliPASmYTX1lJjBYpV/k8KcwyR1M99gD
         ELpgNdc0YJpjyGXU1qAkMiY/qOFCocH12ECFOjso38x0OcGbMqkkGJv0XwTqj3VqZuvs
         j6CQ==
X-Gm-Message-State: AOAM531ubzBeWZBG1o+bOkidXL7V8h6kCHyJ621XXKUToR4ng1tChTOH
        xz9WigofPTDjwKsYhHHp78xucR9+9usy1OGxi4M2lwbx8jg=
X-Google-Smtp-Source: ABdhPJz0c8ciM9CcjW/iP+VM7v9m+SPRvPdzyUqGPbvbDal+y2dGjZRKB8qXT1sAS1dksbZyluVtRM373QSar4wa3rE=
X-Received: by 2002:ab0:7188:0:b0:35d:3365:81fc with SMTP id
 l8-20020ab07188000000b0035d336581fcmr814504uao.33.1649737249246; Mon, 11 Apr
 2022 21:20:49 -0700 (PDT)
MIME-Version: 1.0
From:   Tanusree Debnath <tanu235m@gmail.com>
Date:   Mon, 11 Apr 2022 21:20:38 -0700
Message-ID: <CAPS78prVW-RRgzpBoYONRvmZz5DotizX9t8U4aWd2qLb1x9D=w@mail.gmail.com>
Subject: [GSoC] Applicant Introduction, project selection
To:     linux-perf-users@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>, arnaldo.melo@gmail.com,
        mingo@redhat.com, acme@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,
I am Tanusree Debnath. I have graduated from San Jose State University
with a bachelor's degree in computer science. I love to program in
different programming languages. I like open source projects, and I
recently started contributing to open source projects. I have been
using the linux operating system for over 5 years now. I always wanted
to contribute to Linux and recently I started contributing to the
Linux operating system.

I am interested in contributing to the "Perf data converter" project.
In preparation for this, I have already submitted three patches to
Linux perf out of which one was accepted.

My IRC nick is Tanusree.

Thanks,
Tanusree Debnath
