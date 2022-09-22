Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D32ECAAD8
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Sep 2022 19:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiIVTgP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Sep 2022 15:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiIVTgO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Sep 2022 15:36:14 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F5810B206
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Sep 2022 12:36:10 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id e81so14220271ybb.13
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Sep 2022 12:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=B+gga6ltJtUAel3yll8VCzI2wh4t47DgPA/bbeueEV4=;
        b=LGw6RoWIJhTtjzyWPFyoOKWj2PALb/UK9cMieG1EswUK8uncGsTKcX9GOT90bFqJCY
         zxjAEudl4ROGfcjGQySHHEM4eM3g5Rdayzz+sbVQRpHc+v4SEspoyjoGm3dUPlhjJ2i/
         l+RZN9qaEGfJLJNwZwDvDLDBT8y3FrqJP40VTeBaVNBEARp6hksHQ3Ff4oxXTt7PS16o
         zXeM0mf/BuhhK9PO25w6zjlb2zxTmppYIQ42mjn9ddbgHz9v6upXky0rjTFzDBck3iYy
         g/W6wREdY/00bB45gfdGxdAnaRsyZNQd3r/+lk9aeTuHTw9dqm0p8fPDdBEGZwqXnSsn
         Bdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=B+gga6ltJtUAel3yll8VCzI2wh4t47DgPA/bbeueEV4=;
        b=YR8v26ywxb81Nejaks0WkZ329Rau5sNjfKtkX2zZZNEtMGhSui/ATISXcIuUwVyGUf
         I2mMZ/7daYg1I972o80HdvvxgLxzU8fZL6jUQW+PmB+asH4ZCkeNPkOABGujVm/9rDnc
         BRj7MKHQtogmIDIWaa7dHjGJ0k2W/SuZR5LrRW1jt0rzJtoHgnCIz1Lj0vmLWCcwd4p5
         haXzoy/DffR/kaHMV/C6QFBPb3TIG677++210hViBGB5Mh0ToUvcvXRlT6yLBmR5PGXg
         pl0pl+6LqXNNo9++ntBh6YMrP806sp/GZQPNOj3NB3kj5G+hXa30ATcM+IUgg+XZCYVm
         B9Og==
X-Gm-Message-State: ACrzQf3lk4n6fuYEqhd+7/KYAb/tIZr4yEScEPuOn3yok3SpawfQcehk
        IXN2fDsOTrB3hqI8yhrxtG7pfGRdzY5lOBQrt4l5qA==
X-Google-Smtp-Source: AMsMyM5B26rqF5aDDU+4uPkZq44P4q/L62syhM0LGixbAJaHbFp8dTKOynRG64pCiD4+nr40BnT8apLy+md/oSRK3Xk=
X-Received: by 2002:a25:8b10:0:b0:6b0:58a:f8f5 with SMTP id
 i16-20020a258b10000000b006b0058af8f5mr5294000ybl.524.1663875369520; Thu, 22
 Sep 2022 12:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220922044023.718774-1-namhyung@kernel.org>
In-Reply-To: <20220922044023.718774-1-namhyung@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 22 Sep 2022 12:35:58 -0700
Message-ID: <CA+khW7gQPqoBSi5bSQXFdnkVyjMpu4A=vzFXRLvWDjZww0brEA@mail.gmail.com>
Subject: Re: [PATCH v2] perf tools: Get a perf cgroup more portably in BPF
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 21, 2022 at 9:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The perf_event_cgrp_id can be different on other configurations.
> To be more portable as CO-RE, it needs to get the cgroup subsys id
> using the bpf_core_enum_value() helper.
>

I remember using bpf_core_enum_value requires a compiler built-in. So
the build will fail on old compiler such as clang-11. See [1]. Maybe
we should surround it with #if
__has_builtin(__builtin_preserve_enum_value) to be sure.

[1]  https://www.spinics.net/lists/bpf/msg30859.html

> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
[...]
