Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C6DC43334
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Jun 2022 16:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiFBQ0G (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Jun 2022 12:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237033AbiFBQ0F (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Jun 2022 12:26:05 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A5D2B07F6
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Jun 2022 09:26:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l2-20020a05600c1d0200b0039c35ef94c4so809338wms.4
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Jun 2022 09:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T6UEyUXqYX3xyu14o7rWq7PQbH2AtN9Ky7KtT8K7DLg=;
        b=r4u969ZeaIKUeo7WvsKQNxVURK2un9pFYUpDRxpHbPnCt8ZM2YB2lmr89qiLE2QM/e
         ysTkbhoxmOma9WeRErcZwANAF1DzNXfG0dlC2NlJ4TGuDxjo28FzV8c7yYOOVjEFEwNo
         Wc2+vAAMB9SJNFTA26RkYiAL8ehRtbWxfQty9VrRzz+2/zgoxL3R7DHLuOBOOYTzBxH4
         YmgQyTsHP1taBV0KDc9L8hfywGzBKw/4gfQE7AK2TiSE1Nr+CPxf5BUe9EfQLPcC/AqK
         iAIlc8+v8isqQvDrC7OxXN1h/aqeFtprSPWPzQiy/5+p51nV/wJcjB9Rwg7awW0gOj58
         09ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6UEyUXqYX3xyu14o7rWq7PQbH2AtN9Ky7KtT8K7DLg=;
        b=d0hv302jrCTdL6xC6qCfv2HIL5CPzdkImP/HJ+qhN3uZd0DhMXs1n1ggdkeU/DB1Zc
         KXkj95Z54OD/XHb9xJD0dGCadlLuc1u8tC1HtQguWFD94vIelEeYJUM8BfimEQtztocw
         YEgyWfteWcBh3tHYnVTHxoVcBVyN1CUS+0/fexXDFGvWj9pZb7ZHGhqLNDQRXiL/Ai3J
         i4U4ppuF0dM0uT/G7p1UA/czd2UdJDtgUDhKP6yxFzgJMciab4m7PzU32BOCdb6lmpnq
         8g3u+iusUeJDtfxldzZxm4rUG0zq3kk00brFbednDO1O1PuB+ecNSpzaYSZ4seYdEocI
         6VdQ==
X-Gm-Message-State: AOAM5335TQQ+Nu0eplMF/x4/MnCUBgPUoadTpJxVvoXRJthPuU/qCzO2
        jUA1lXPmCqdb3ErOOPJcQTqcZh4QgE2icJ9s/NK4GWDBDfijESKr
X-Google-Smtp-Source: ABdhPJwiMGrfg8U8K77YwAdM6QX5bkaEDbwscZBnAiEral9tLwlRAyr4vPWc7ZMIw4g8Z2Qep/jBs5sY2y5tCoQahVw=
X-Received: by 2002:a7b:c015:0:b0:397:3685:5148 with SMTP id
 c21-20020a7bc015000000b0039736855148mr4787451wmb.174.1654187160975; Thu, 02
 Jun 2022 09:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <5842751-f5a2-4469-53f2-57ef1362568@maine.edu>
In-Reply-To: <5842751-f5a2-4469-53f2-57ef1362568@maine.edu>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Jun 2022 09:25:46 -0700
Message-ID: <CAP-5=fVeDJJ_HD=AeK0XSpsY52H58ZynRnnEpOB-z478=NxaiA@mail.gmail.com>
Subject: Re: a few libperf questions
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 2, 2022 at 8:38 AM Vince Weaver <vincent.weaver@maine.edu> wrote:
>
> Hello
>
> I work on various perf-related tools in the HPC community, most notably
> the PAPI performance library.
>
> Currently PAPI maintains its own independent code for working with
> perf_event_open(), but with the advent of libperf I was looking into maybe
> linking against libperf to avoid all the code/work duplication.  So I had
> a few questions.
>
>         1. What's the licensing of libperf?  Is it GPLv2?
>
>                 PAPI is BSD licensed.
>                 This is something that actually pushes us to libperf
>                 because if I wanted to (for example) implement the new
>                 ARM rdpmc code I can't just copy it in to PAPI but
>                 would have to re-implement from scratch

I believe that as code in libperf was copied from perf it retains the
GPL-2.0-only license. Some new code is "LGPL-2.1 OR BSD-2-Clause",
which makes more sense and would align libperf with libbpf. We've
talked about rewriting this code in Rust, perhaps when that is done
the more permissive license could be used.

>         2. Is it expected that distributions will start shipping
>                 libperf?  As part of perf or otherwise?
>
>                 Telling HPC users they need to dowload an entire
>                 kernel tree just to build libperf is seen as a huge
>                 obstacle for many, and just including a snapshot
>                 of the code into our code tree again starts having
>                 licensing issues.

There is a Makefile and an install step, however, I would say libperf
is *not* ready to be distributed. There was a lot of cleanup effort to
make libbpf 1.0 and similar should happen to libperf. I particularly
loathe perf_cpu_map__empty, which isn't doing what it says on the tin.

>         3. Is libperf planned to be backwards compatible with old kernels,
>                 or will it be tied to whatever kernel it is shipped with?
>                 Will it have ABI-stable releases?
>
>                 Sort of like with perf, I know only supporting the most
>                 recent kernel makes life easier for the kernel developers
>                 but it does make for a library versioning nightmare
>                 especially if trying to support people on older
>                 distro releases.

There is a myth that comes from Debian that perf only supports the
running kernel. This is wrong and means that bug fixes, improvements,
etc. are missed out on. This thread discusses it:
https://lore.kernel.org/linux-perf-users/CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com/
It would be hugely impactful if someone could fix this, as a lot of
other distributions follow Debian.

Given perf doesn't have this problem and it is using libperf, I don't
think libperf has the problem.

> I'm going to try to see if I can get a libperf backend for PAPI going and
> maybe try to get some of the other HPC parties involved (they tend to not
> want to deal with kernel development directly for some reason) but I'm not
> sure if they're going to like how closely bound libperf is to
> the kernel tree.

Sounds good. The code is in the kernel tree but I'm not sure it is
"bound" to it.

Thanks,
Ian

> Vince Weaver
> vincent.weaver@maine.edu
