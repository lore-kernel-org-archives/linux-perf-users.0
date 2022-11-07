Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11A6C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Nov 2022 19:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiKGTdK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiKGTdJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Nov 2022 14:33:09 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B422529C;
        Mon,  7 Nov 2022 11:33:08 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id q186so853658oia.9;
        Mon, 07 Nov 2022 11:33:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bY31HDe7M3SSa1pI1yBsat1eyKCY1gr8xmUrHz5gwqU=;
        b=ClvKk5HlRKUHsc/0lT1PCrVl9JU70QldSu2aI9gmpsyFHKOTmLaqR/vxQt2GJH9j4P
         YO65XMPtsqwagUQDzBcN14WK+0sw5tgw+CWGZJYN2+ztegzJjMO4RNxCYAtDNBZ7c5b8
         AnrUbhlkzybakHXsM9iFJ8XQjGlPBoglRwTI6DvzxfVdSDuT4mR1+oU67wYnagYjjsQY
         Ki2f8id6P/sB0bklszDI76qcNnFEC97u7yxRXYu7Q8ojgKZccdmgX4uHv6PKO6HF//2X
         +xcph0x0qDQryrxERW1YE4oQ7td3lqe70u5DnzcIGWHYv5MvrTzt9JAu6qvrmciC+TkW
         Sz7Q==
X-Gm-Message-State: ACrzQf3tRFS9DjR3JwRa+hscINVZjYSTm0okAcG3uVSQ+62svU0rgtkm
        xhgQc6HmeC1DHoCcgGeP/3phC1u/QPD6iwnk7V8=
X-Google-Smtp-Source: AMsMyM42hLefen7H4IPJAB0bFoU1yZWFCA3+B4rdXf/9hLvX4vkiHnuCz8qdbw0WaJXfK862mmHdcNf1zqeUcBwxuds=
X-Received: by 2002:aca:2805:0:b0:359:e340:d53 with SMTP id
 5-20020aca2805000000b00359e3400d53mr26578086oix.209.1667849587792; Mon, 07
 Nov 2022 11:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20221104121805.5264-1-adrian.hunter@intel.com>
In-Reply-To: <20221104121805.5264-1-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 7 Nov 2022 11:32:56 -0800
Message-ID: <CAM9d7cjHb4tKsuNjD+Mhj_4coO=H-822uBxpNAmnm6NN=Eavhw@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf: intel-pt: Add hybrid CPU compatibility test
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Adrian,

On Fri, Nov 4, 2022 at 5:18 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> The kernel driver assumes hybrid CPUs will have Intel PT capabilities
> that are compatible with the boot CPU. Add a test to check that is the
> case.
>
> First 2 patches are preparation.
>
>
> Adrian Hunter (3):
>       perf: intel-pt: Rename intel-pt-pkt-decoder-test.c
>       perf: intel-pt: Redefine test_suite
>       perf: intel-pt: Add hybrid CPU compatibility test

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
>  tools/perf/arch/x86/include/arch-tests.h           |   1 +
>  tools/perf/arch/x86/tests/Build                    |   2 +-
>  tools/perf/arch/x86/tests/arch-tests.c             |  15 +-
>  ...intel-pt-pkt-decoder-test.c => intel-pt-test.c} | 154 +++++++++++++++++++++
>  4 files changed, 169 insertions(+), 3 deletions(-)
>  rename tools/perf/arch/x86/tests/{intel-pt-pkt-decoder-test.c => intel-pt-test.c} (80%)
>
>
> Regards
> Adrian
