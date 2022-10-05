Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4CBC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Oct 2022 21:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiJEV4I (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 17:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJEV4H (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Oct 2022 17:56:07 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814E47F09C
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Oct 2022 14:56:06 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g28so207420pfk.8
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Oct 2022 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=8Pm7ryG24AwEz26lUQ3ZeFC6zq7cw9NWM/gooLAfALU=;
        b=AeGTAH1qBklqxpEo2vkcmEcRdYKPcxJMLw1EDD69Voxgucq1qWXkuWtpw0hbFOksBD
         T2x3k5SN/zcyEoWATrm8D40aJyi6q8dQX7OZiAGgR0C09ypu0qh3/LufYyj8XS2QT6dS
         kExPzR5TV/VT/yZy+yntCBO4FeNxGBpLoyX9H4AWXJM4fia6VUTK20B8CVFVNtgZ4jUx
         Byc8ttTJFq4HTvTdNsdeAOqZ3tRaC8Md3meGvUL9dL7ICZUASUVgoW/vaZh9q3zriNdV
         PytRMfPfXNBNQPkS5cz3jjk7OBBN1JRpG7UcALq+uTnGDrF91HEhorMi+aewRQujzdWc
         40Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8Pm7ryG24AwEz26lUQ3ZeFC6zq7cw9NWM/gooLAfALU=;
        b=oaHKfhzTcqWKXW+0Jg0jIgWk17mrakQRGPqjqB1TGFBEsnlDmIl/6ANZgG/cUZYqpV
         r7K9VGdU2xVgSylA27tvKY7sSZKAsxj4IJK3k+o/Hb5VeUpaOwynaTu4HA+v6XbbJ7ce
         QQpQfzeTzKcJK6Vlm1OSSiy8est325oreIo/HVuFVtaOqpe0YlYUwGdYVu5lSpZU7bU0
         +nXp6G3ha3Rv2Uc5SrFq3MC6YzVWk8w05ePwHvmDCJIh6QZxdBVu9Di6Bqax+uXRmFNl
         qQXFIKAY6Qo8edsntkEAomH+sMPT/yt/PHkMmJFm6soxX/1scqbuPyL9ivL3A2uGtFRU
         ZUEQ==
X-Gm-Message-State: ACrzQf2R/OEQgkBQuLyB/7ZREZMmH49Bd4XU6if/eoSo31JuCJ4FnPUS
        Hufze6Gh1Yp6MMCtt4yRuz6NnNeVAn4TY59xd+EYu+qUZjl1tg==
X-Google-Smtp-Source: AMsMyM72KOFuFLd05ekvHqkC8iQgjYBslmgWI6FetqXQFawTd561WeWnr2R3S8hjrJtx04dmecSswFY8Hu90TDRE2aY=
X-Received: by 2002:a62:1a97:0:b0:562:5587:12d6 with SMTP id
 a145-20020a621a97000000b00562558712d6mr1824718pfa.37.1665006965827; Wed, 05
 Oct 2022 14:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnrHErOK+w878izVauHUKaX3eD-HXgigq2Ogm3iSj-fHA@mail.gmail.com>
 <76CB17D0-5A66-4D49-A389-8F40EC830DC0@sladewatkins.net> <CAP-5=fXVgwMO_CpS-EHN6PFhLB-J5Ft7qHz7oQd-WOMnTj72Cw@mail.gmail.com>
 <CAM9d7chvZjZ4YVc6j3w7OkdHteyJ0GUZboieu9G7jAWBevoZqA@mail.gmail.com> <e553c4f8-ed3d-0755-cc8a-b5ffe43b2c2f@amd.com>
In-Reply-To: <e553c4f8-ed3d-0755-cc8a-b5ffe43b2c2f@amd.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Oct 2022 14:55:54 -0700
Message-ID: <CAKwvOdk6TTNhu_+FdONTXPo9Z8u5D4-5kf-rMN8oK4+6fMyc-w@mail.gmail.com>
Subject: Re: Invalid event (cycles:pp) in per-thread mode, enable system wide
 with '-a'.
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Slade Watkins <srw@sladewatkins.net>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Kees Cook <keescook@chromium.org>, sandipan.das@amd.com,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

+ Stephane, Kees, Sandipan, Bill, ClangBuiltLinux mailing list, Yonghong
https://www.spinics.net/lists/linux-perf-users/msg23103.html
starts the thread, for context.

On Thu, Sep 29, 2022 at 9:32 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote=
:
>
> On 30-Sep-22 9:56 AM, Namhyung Kim wrote:
> > Hello,
> >
> > On Thu, Sep 29, 2022 at 8:49 PM Ian Rogers <irogers@google.com> wrote:
> >>
> >> On Thu, Sep 29, 2022 at 3:10 PM Slade Watkins <srw@sladewatkins.net> w=
rote:
> >>>
> >>> Hey Nick,
> >>>
> >>>> On Sep 29, 2022, at 5:54 PM, Nick Desaulniers <ndesaulniers@google.c=
om> wrote:
> >>>>
> >>>> I remember hearing rumblings about issues with zen 2, LBR, vs zen 3.
> >>>> Is this a known issue, or am I holding it wrong?
> >>>
> >>> Hm=E2=80=A6 I also remember this. I have a Zen 2 based system that I =
can do testing on, so I will do so when I=E2=80=99m able.
> >>>
> >>> If I discover something of note, I=E2=80=99ll get back to you.
> >>>
> >>> Cheers,
> >>> -srw
> >>>
> >>
> >> LBR isn't yet supported for Zen but is coming:
> >> https://lore.kernel.org/lkml/166155216401.401.5809694678609694438.tip-=
bot2@tip-bot2/
> >> I'd recommend frame-pointers.

Having to recompile is less than ideal for my workflow.  I have added a not=
e to
https://github.com/ClangBuiltLinux/profiling/tree/main/perf#errors
Please let me know how I might improve the documentation.

> >>
> >> +Ravi who may be able to say if there are any issues with the precise
> >> sampling on AMD.
> >
> > Afaik cvcles:pp will use IBS but it doesn't support per-task profiling
> > since it has no task context.  Ravi is working on it..
>
> Right.
> https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangoria@amd.com

Cool, thanks for working on this Ravi.

I'm not sure yet whether I may replace the kernel on my corporate
provided workstation, so I'm not sure yet I can help test that patch.

Can you confirm that
$ perf record -e cycles:pp --freq=3D128 --call-graph lbr -- <command to pro=
file>

works with just that patch applied? Or is there more work required?
What is the status of that patch?

For context, we had difficulty upstreaming support for instrumentation
based profile guided optimizations in the Linux kernel.
https://lore.kernel.org/lkml/CAHk-=3DwhqCT0BeqBQhW8D-YoLLgp_eFY=3D8Y=3D9ieR=
EM5xx0ef08w@mail.gmail.com/
We'd like to be able to use either instrumentation or sampling to
optimize our builds.  The major barrier to sample based approaches are
architecture / micro architecture issues with sample based profile
data collection, and bitrot of data processing utilities.
https://github.com/google/autofdo/issues/144
--=20
Thanks,
~Nick Desaulniers
