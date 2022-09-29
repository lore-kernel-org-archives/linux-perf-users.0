Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4754C32771
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Sep 2022 02:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbiI2CLb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Sep 2022 22:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbiI2CLa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Sep 2022 22:11:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC72105D6F
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 19:11:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so2365586wml.5
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 19:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TwooFJxjhRgJG+cOSV3PRCJCp4RIeUqc3CtUNz+Wumk=;
        b=spuLDBc8RRYI6yfGXXyY1PEyX8lSRB2teAxRuop2uJtO1oW8LBT+i/2UhFM8pOd6H2
         LIWIrsuUXHkHWavX8aY3GUFAO/CAQT5qAWQ/9yLxnTaX61qMxpkFNQu7AArCg76J09KQ
         Y1A9/Mse3fMgmWxV41i0BUbYUCLuhhWyX/1HISvZ2LQ20c0s9uix34ijzH9TG+ro6iJV
         AD2ZGZC45uJ3KCu1/PQXwNkujCwfEeq7MEFuu7Pcm17EKV6cmr5gRYP3BemR0eT6WFQ4
         SxEfpsbZgkYSrE0/ZMeazezp05fC8KPWJvKgE2sLNm2xSm2Ljm0eg4Kr8OQG/AkiCdiX
         2Ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TwooFJxjhRgJG+cOSV3PRCJCp4RIeUqc3CtUNz+Wumk=;
        b=F6sMM4/RfZcRO9gAc21iiiG1zlmtXw88lTIwQmJwjhtKQOFwx6sSGJeWVgZbPGhtx0
         neU3HaDRQcsiLLoHot9lHYCjO5RDoAGsaBVTP9Q+Q3NqXc/JmxnO2rl90tObX8FAA3dG
         CdoU1OjcQuR/IKqPDAlj+9DrAed5ZmyTB/8zqxPun3iOLD3qqmf+4+wYi+q036FyvSYt
         3hAhpxyVTz+rOlEDHjvvqt0CdonIr44PfEadXflMBbTPwotWFIcVaUnNap9vggg8rdhQ
         NWvNWLbTElmrB5/XMjOBWdOKG9l3iHGaMi6e+oE1L11sFVVVwnndRwQ48IuhcOyU1Vpp
         K9Jg==
X-Gm-Message-State: ACrzQf0ytNDH98rLjHpK3VKfIqHVTLuXImFLSK8mhJf3mxZoaHNJog7A
        +YzE5nIqDZXOqqNQ1+ic2BJhhFjt6ZifwqLM9kshcg==
X-Google-Smtp-Source: AMsMyM5USHjqcex3UgGFABXMyH/XTRe2NtqMCvmsWB/a7GJGkUUxhuIUhfMj0gFiEEGEgcZVSwmhXa7flf9f0GYpsX0=
X-Received: by 2002:a05:600c:4e94:b0:3b4:b416:46c3 with SMTP id
 f20-20020a05600c4e9400b003b4b41646c3mr527727wmq.149.1664417487060; Wed, 28
 Sep 2022 19:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220927051513.3768717-1-zhengjun.xing@linux.intel.com> <YzRaAxFrg56uph+W@kernel.org>
In-Reply-To: <YzRaAxFrg56uph+W@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 28 Sep 2022 19:11:15 -0700
Message-ID: <CAP-5=fVgsMzx6F=rgy9kyfWS=Gj3hvtLTJmTzf6+O954x4oY_g@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix test case 87 ("perf record tests") for
 hybrid systems
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     zhengjun.xing@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 28, 2022 at 7:28 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Sep 27, 2022 at 01:15:13PM +0800, zhengjun.xing@linux.intel.com escreveu:
> > From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> >
> > The test case 87 ("perf record tests") failed on hybrid systems,the event
> > "cpu/br_inst_retired.near_call/p" is only for non-hybrid system. Correct
> > the test event to support both non-hybrid and hybrid systems.
> >
> > Before:
> >  # ./perf test 87
> >  87: perf record tests                                   : FAILED!
> >
> > After:
> >  # ./perf test 87
> >  87: perf record tests                                   : Ok
>
> Looks sane, applied.
>
> Ian, consider providing your Acked-by,
>
> - Arnaldo

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>
> > Fixes: 24f378e66021 ("perf test: Add basic perf record tests")
> > Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > ---
> >  tools/perf/tests/shell/record.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> > index 00c7285ce1ac..301f95427159 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -61,7 +61,7 @@ test_register_capture() {
> >      echo "Register capture test [Skipped missing registers]"
> >      return
> >    fi
> > -  if ! perf record -o - --intr-regs=di,r8,dx,cx -e cpu/br_inst_retired.near_call/p \
> > +  if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p \
> >      -c 1000 --per-thread true 2> /dev/null \
> >      | perf script -F ip,sym,iregs -i - 2> /dev/null \
> >      | egrep -q "DI:"
> > --
> > 2.25.1
>
> --
>
> - Arnaldo
