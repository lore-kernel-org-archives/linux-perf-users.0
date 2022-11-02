Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB93BC4332F
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Nov 2022 10:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKBKXX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Nov 2022 06:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiKBKXV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Nov 2022 06:23:21 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D25DBC7
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Nov 2022 03:23:20 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3704852322fso91175777b3.8
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Nov 2022 03:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BafOkd8SvWuco2I/Z6NsmvGa0Z/TQs4XgUWd22MNZzc=;
        b=NPdjisJ5hNB1CU5k7SrGdS78wdIMQ35AbWxkPyxqx9aL9gR6tT2qcf5So6UgE14miE
         z7gOzr46BLEHymsJkzRVeR/56iAjly+mfLrnFD65Wmc+yMM7vZO79LfXuoKeoAxu+daC
         PYIfrp56gZ3+onhotCroAAE5VTLTz08lL4s7BpZWugEHy3nVRtxX/sznuxTan+S1JQzH
         jyfhHmbsmmWZL/NoV/6eBNz/hmgblLhtGQAqgPPPzx5c3RYpKS0CynLa1FFc1SzNlKpe
         hMQGEL9/jcIDrHZv43atvExR4SQJTKAoQGtmCRJ+2xZyZJh/gKsE91FNd0ec4JrMIJRX
         OnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BafOkd8SvWuco2I/Z6NsmvGa0Z/TQs4XgUWd22MNZzc=;
        b=doSkvBOoXR/16mqEhqKRjaazrsZZS89A0W3fRB7achKRM+IV3c3Oanu3eM45z/2GtN
         BHj8u16xsgxiCxDLmejRTsTC9Ao8dMQeZlvlOOD0emCpSETLbEW34T1WkS+4CsPaqbHp
         ua9VYCgGUo41GhsEAjcgBQ66PnK+AtGq15KYven369+6FNTaYRq245QXQKTsTMD+SCaB
         J0Aa7mzxJqpKM/8HSf6rJqqx480Aq9dPb+Oesb8b1LiSCbEMGmausmHaRLgP7gs8Nimu
         1hilN+xnmwjeoJoaKeez9am60TrU6G5qzeh2zwtg2LIyVK/3voftGn4x07WApJwwgInA
         eX7A==
X-Gm-Message-State: ACrzQf282s2nVoufqi8gDoR3GGsTRrlzCYZwp2vmHpGb/dsWHHRqWqbR
        25xFexitD8GXy+YBm5Qb66xixFIZ9+QmBli3oUT/+A==
X-Google-Smtp-Source: AMsMyM78/8o4DpKdBUatsiMGIue/Gjo4Q1lrx5/fvrBsDm/9QhuEiH96aDbvtyTuaCQX9YLMspA436QjMxp7LeGSn1I=
X-Received: by 2002:a81:a04a:0:b0:369:1030:fbd3 with SMTP id
 x71-20020a81a04a000000b003691030fbd3mr22760635ywg.465.1667384599743; Wed, 02
 Nov 2022 03:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221026141040.1609203-1-davidgow@google.com> <CAGS_qxrd7kPzXexF_WvFX6YyVqdE_gf_7E7-XJhY2F0QAHPQ=w@mail.gmail.com>
In-Reply-To: <CAGS_qxrd7kPzXexF_WvFX6YyVqdE_gf_7E7-XJhY2F0QAHPQ=w@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 2 Nov 2022 11:22:43 +0100
Message-ID: <CANpmjNOgADdGqze9ZA-o8cb6=isYfE3tEBf1HhwtwJkFJqNe=w@mail.gmail.com>
Subject: Re: [PATCH] perf/hw_breakpoint: test: Skip the test if dependencies unmet
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
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

Hi David, Daniel,

On Wed, 26 Oct 2022 at 20:31, Daniel Latypov <dlatypov@google.com> wrote:
[...]
> > -               return -EINVAL;
> > +               kunit_skip(test, "not enough cpus");
>
> The only minor nit I have is that I'd personally prefer something like
>   kunit_skip(test, "need >=2 cpus");
> since that makes it clearer
> a) that we must only have 1 CPU by default
> b) roughly how one might address this.
>
> Note: b) is a bit more complicated than I would like. The final
> command is something like
> $ ./tools/testing/kunit/kunit.py run --arch x86_64 --qemu_args='-smp
> 2' --kconfig_add='CONFIG_SMP=y'
>
> But that's orthogonal to this patch.

Was there going to be a v2 to address (a), or is this patch ready to
be picked up?

I assume (unless I hear otherwise), this patch shall also go through -tip?

Thanks,
-- Marco
