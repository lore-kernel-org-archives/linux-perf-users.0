Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B54C433ED
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 16:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D39D61244
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 16:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347418AbhESQ2y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 12:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355328AbhESQ2s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 12:28:48 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEA1C061760
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 09:27:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h3-20020a05600c3503b0290176f13c7715so3662502wmq.5
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8wZnk7rxOWgKUoVplPXyNkY2T76FEhFaLIyKCx+xj2c=;
        b=EokFC/6CQWYr5SDA9kEnxTtraZIKVGwvwKZM8NCKqM3tq6WYAo8AfSAChW7msw/d0Q
         F/AVoiT8QMftQ9ajuNjuqjiBX31/CRuJWLLSdcVgSeXtJUwe2pGgJWWdTyVBvVQiQq3w
         r54OyALxWra/fMmi1pO7iMyM4VvjRdIpBsb0shSNCbkEs/ow7AjN7v8ONpC0GPAW55GU
         q6LQ77qUqOebnW/lsSKQQBgQGfE6iH9zJfPQMw9IS/vujS9EftngZ+bZSeixVmjti0Wt
         ezT5V3LRxAwaavuGwM7WiADPdVjp2SSVMdNDP/ZyRLCQJqwgaV+htRnt1wLOy07VKMsz
         Wx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8wZnk7rxOWgKUoVplPXyNkY2T76FEhFaLIyKCx+xj2c=;
        b=Gvu4LrIRLTHgjR3jwtURXNMQaE0FI4P8NoaHeUxfvwMtD8vkQ2P3P9hqRYBHMBbaqO
         Beem4H5nhnC0NY1dNijot4niHY3NzkiYugwM7QPJbs1aKZH9n0FIN80br2P7zZurv6er
         XPo7U3C1zM97MMKo3/mb+8eEklmC5bgPmTYDfiCkjOX9dW+EJxOnWX4QukI+eEZvQt4d
         V3HUftllLEa9s1bmB8ZB9xXZBB76enyzfA7EEwuygs/kye/m15u5Z6EBsXh2KV+ga/TT
         w3/2tVioe112uP0x0oGfinP+Cz0CMXW+P5wSs43Mgk/+jfj/MfExIa2MM+ET5RtX9Rby
         sljw==
X-Gm-Message-State: AOAM533wwHqF1jsU74HP5w+SVNYeGroUZ06lEeDJ6gNSK/ZqBI4f66Z8
        LuhGetbolXGPakB9E0oPfTNCgziN01BVwXOvzwpMmw==
X-Google-Smtp-Source: ABdhPJxzLXEWmEw3JJjPSYhsNIBn/wlnznEQ7mpgq6LZ+Lg+/SUEGfx4lH5aaWA3Vv1J5UwJj9dy6O8inX9ac2ALrsI=
X-Received: by 2002:a1c:114:: with SMTP id 20mr159509wmb.124.1621441646648;
 Wed, 19 May 2021 09:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <555b92bd-1884-58a7-76fd-7dd197978436@linux.ibm.com>
In-Reply-To: <555b92bd-1884-58a7-76fd-7dd197978436@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 May 2021 09:27:14 -0700
Message-ID: <CAP-5=fX_+GY38s0imLNDzq9_xjn3qiGC0pFEpSV1U-TzF_UoMg@mail.gmail.com>
Subject: Re: perf list dumps core using 5.13.0.rc2
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 19, 2021 at 7:57 AM Thomas Richter <tmricht@linux.ibm.com> wrot=
e:
>
> Using kernel 5.13.0.rc2 command perf list dumps core on my x86
> virtual machine:
>
> [root@f34 perf]# ./perf list
> Segmentation fault (core dumped)
> ^C
> [root@f34 perf]#
>
> The root case this this change in file ../include/uapi/linux/perf_event.h=
:
> enum perf_sw_ids {
>         PERF_COUNT_SW_CPU_CLOCK                 =3D 0,
>         ...
>  --->   PERF_COUNT_SW_CGROUP_SWITCHES           =3D 11,
>
>         PERF_COUNT_SW_MAX,                      /* non-ABI */
> };
>
> This change increases PERF_COUNT_SW_MAX to 12. However this
> change is not reflected in file util/parse-events.c where data structure
>
> struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] =3D {
>         ....
> }
>
> is defined and it misses the symbol name and alias for this new software
> event. So when command 'perf list' is called, the call chain sequence
> is
>   cmd_list()
>     print_events()
>       print_symbol_events(event_glob, PERF_TYPE_SOFTWARE,
>                           event_symbols_sw, PERF_COUNT_SW_MAX, name_only)=
;
>
> where PERF_COUNT_SW_MAX is 12 and  structure event_symbols_sw[] contains
> only 11 elements. This ends up with the last element of the array being
> all zeroes and the line:
>
>     if (!name_only && strlen(syms->alias))
>
> dumps core because syms->alias is a NULL pointer.
>
> Is this dummy event PERF_COUNT_SW_CGROUP_SWITCHES simply missing in the
> event_symbols_sw[] array or is there more to it (which I am missing).
>
> Thanks.
>
> PS: I can sent a patch if needed....

I believe Namhyung's pending change will fix this:
https://lore.kernel.org/lkml/20210210083327.22726-3-namhyung@kernel.org/

Thanks,
Ian

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
