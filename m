Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3B0C43334
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jul 2022 20:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbiGRUXF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jul 2022 16:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiGRUXE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jul 2022 16:23:04 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCBC31223
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 13:23:03 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id w17so15032284ljh.6
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J3Z3tfeKRJLdAhCCmhWHihJdksAblGizQ/tJ4Dbs+/0=;
        b=HD/VtTr2HeFoaOVpMcfUVs71WCVWY48z0aqcCEiLsX5857s65SH7E5Xb2GjKv3dtWy
         6DmQ9EkCke2ysjQ1N8K2jZB/5gkUbhNp5W2rkR0jCyl6FPTEqwNsyR98jtzPVWJqavRr
         CFbToIfVeJnkjCBBMcdKNkGSveJa+L/1XBtFwxmQ/czqGrrwIW5nO1y3f4zPntYjryFn
         ab5+ruztb1pA9NxwVq7dkPRPKR9aEpwssmZJUyYfvcsF9vGsEJPIa8/Ogtc9yk1S7apl
         2+x8Y87K+VH46qhxvdr5FouKMsKYd/DgRr0ClKYHVU/QLia2LCnSz9qTaU7UmMPfBf7n
         GJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J3Z3tfeKRJLdAhCCmhWHihJdksAblGizQ/tJ4Dbs+/0=;
        b=F4X54rznBv5okdhFZo5BQ49iBhmS0CkV9fUOc//7q9Low4feEnFN/f41zTNL3Zf9HS
         6t8/P748G2qScI9paTM2ygzgLvmOzH8qygHz7a4QfCShf6RvN51mrJ4OgFHRgAEbDre3
         TQUJNb8OVDF2XPFe9KGW+fhg2StVCid/lL97b+GDTN1UiXDXJIu5/ybzV3+Fjylcw+JD
         ig0VU1OhubBye4ZMR0R4WOiXKwEEe/NRbkzX8XmqPcSKCTib1ZCzk2X7OBs6Z/vQ3KTN
         aDWEZxm1rY/xfmcEzInHRW3aywKsp1fuEl1rjly9cV5IicKGrTnVYAlGRkHyByCwBIdt
         JKdg==
X-Gm-Message-State: AJIora/Snb07ARWz+bmnz5sNNX+YIzbpfoizG0YfEK1ESh07zbDg1zst
        SPqIWlpYgEgUv9uQ5xUcBJa0VprT53Y1X9145v71bg==
X-Google-Smtp-Source: AGRyM1ucIKcIR0ILXQCLuba5IMjLqiY0xKoOhbqsIuI59lX0d0LNg307CusOi23Ffxs7aSlum+8gG33zVH2Hil+sy4M=
X-Received: by 2002:a2e:3607:0:b0:25d:73a7:97b4 with SMTP id
 d7-20020a2e3607000000b0025d73a797b4mr14294228lja.352.1658175781963; Mon, 18
 Jul 2022 13:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220629213632.3899212-1-blakejones@google.com>
 <Yr6u/jdLvg2TcT8s@krava> <YtVzVZoo5PTj0qXH@kernel.org> <CAP_z_CjUi-Uk_mftfw33+eac13sLyHMBtQJd8V393SaD4OocNg@mail.gmail.com>
 <YtW1aFY4MyeqxhdH@kernel.org>
In-Reply-To: <YtW1aFY4MyeqxhdH@kernel.org>
From:   Blake Jones <blakejones@google.com>
Date:   Mon, 18 Jul 2022 13:22:50 -0700
Message-ID: <CAP_z_CgPPg7o1TYyQ0b9MtEO17X-69Te3zOfocXK2MYc-SmPmA@mail.gmail.com>
Subject: Re: [PATCH v3] Add a "-m" option to "perf buildid-list".
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Ah yeah of course, sorry about that!


On Mon, Jul 18, 2022 at 12:33 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Jul 18, 2022 at 10:07:32AM -0700, Blake Jones escreveu:
> > Fabulous, thanks!
> >
> > On Mon, Jul 18, 2022 at 7:51 AM Arnaldo Carvalho de Melo <acme@kernel.org>
> > wrote:
> > > > > Signed-off-by: Blake Jones <blakejones@google.com>
> > > >
> > > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > >
> > > To clarify, b4 found v3 and that was the one applied.
>
> Now fixing this:
>
>   28     5.28 debian:experimental-x-mips    : FAIL gcc version 11.2.0 (Debian 11.2.0-18)
>     builtin-buildid-list.c: In function 'buildid__map_cb':
>     builtin-buildid-list.c:32:24: error: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
>        32 |         printf("%s %16lx %16lx", bid_buf, map->start, map->end);
>           |                    ~~~~^                  ~~~~~~~~~~
>           |                        |                     |
>           |                        long unsigned int     u64 {aka long long unsigned int}
>           |                    %16llx
>     builtin-buildid-list.c:32:30: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
>        32 |         printf("%s %16lx %16lx", bid_buf, map->start, map->end);
>           |                          ~~~~^                        ~~~~~~~~
>           |                              |                           |
>           |                              long unsigned int           u64 {aka long long unsigned int}
>           |                          %16llx
>     cc1: all warnings being treated as errors
>   29    23.06 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110
>   30     6.08 debian:experimental-x-mipsel  : FAIL gcc version 11.2.0 (Debian 11.2.0-18)
>     builtin-buildid-list.c: In function 'buildid__map_cb':
>     builtin-buildid-list.c:32:24: error: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
>        32 |         printf("%s %16lx %16lx", bid_buf, map->start, map->end);
>           |                    ~~~~^                  ~~~~~~~~~~
>           |                        |                     |
>           |                        long unsigned int     u64 {aka long long unsigned int}
>           |                    %16llx
>     builtin-buildid-list.c:32:30: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
>        32 |         printf("%s %16lx %16lx", bid_buf, map->start, map->end);
>           |                          ~~~~^                        ~~~~~~~~
>           |                              |                           |
>           |                              long unsigned int           u64 {aka long long unsigned int}
>           |                          %16llx
>     cc1: all warnings being treated as errors
>
>
> These should use PRIx64, etc.
>
> - Arnaldo
