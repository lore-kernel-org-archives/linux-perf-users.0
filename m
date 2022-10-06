Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B6CC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 17:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJFRUu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 13:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJFRUt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Oct 2022 13:20:49 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E93A59B5
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Oct 2022 10:20:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a3so3776927wrt.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Oct 2022 10:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=quJ379rlLFhvYXSYbfBlLsRVOJw+DdULfdKm4t4RrhM=;
        b=Y48UDzYSbpViVWcpv9Y3FASlAPOXKCfwCB/xPIU2befslJSPuN/PekMVPXEnerq488
         UnDCCQSQFCg67RONah71Sie5N77UpRjwq1hpQ6kN3dS7trkB70dgZAcKHTijQkhqJieT
         2/K8Xz58TwbfAn0NS8pzDSqwPTAhb9IaSDtN3LpNF8FIRjAM6+Y7I8raeZWavzE6ipk3
         qxgkI+xlq8HpZP1rxDYJgU10xwh7oXk9f94AcBF28MU8OU77v+0TAodCSNxlJMG7uwyE
         Ac+HtLN3c+9F2ZHF6v0ALW/rjYe+2bomhh2LrlbSyIg940gMCHYG/v3qynzzRAa3FxFX
         fy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quJ379rlLFhvYXSYbfBlLsRVOJw+DdULfdKm4t4RrhM=;
        b=d8zPaQniMkzkradP2iLC26HqlMhFQ5gCCQRbOYmBZuHOYQQS4A8goFv170oHe+86UX
         Gu3azaS63J+De3SOBo/5tkgSVQ78BOIi/05WszXkeRYl5Rj0a0pW/JadTUCaXFMkYPeF
         B5Mt3CYHeW4On4Le5eokFtZfFd5UKiQWb4okGkKlZesnCj92cRsOFThlkqrLzOPRLGeV
         PyiJSAwNbpzMNi2OiGNFIm0oaaDxMq6dg5xNk76Fmh8ZlWgXdwcCkn3rY6kTM0aQWy++
         BmEPtmDgjonlh62o69DCYcw2Bicee9ttgtA7EM/0M319TzjdU1HkNk4f9KoBUPaWIpAm
         WqqA==
X-Gm-Message-State: ACrzQf15vPy8WnEIOllnIv8BP1qzl/sFQTjX6nsbtZuSJwkviRHd8oGp
        OexemrmFuvIjX7AKd8RTOz6qAl/rrUQNwnoquigSVA==
X-Google-Smtp-Source: AMsMyM5DAe4H1ptnOD29uHOP5p7xEbG9Z8HC0IRzDBackQ1DJp0a3726vZKC+PMwmRuCl/I/nb9+rsqxHNkJBJIIgTQ=
X-Received: by 2002:a05:6000:168f:b0:22e:4c3:de09 with SMTP id
 y15-20020a056000168f00b0022e04c3de09mr704326wrd.40.1665076846971; Thu, 06 Oct
 2022 10:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221006142852.mhrgi3r4fvtkircw@altlinux.org> <20221006151622.i45co6lioxgheval@altlinux.org>
In-Reply-To: <20221006151622.i45co6lioxgheval@altlinux.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 6 Oct 2022 10:20:34 -0700
Message-ID: <CAP-5=fXqQpcVk+mzPpM9vC=RHTcZvm4Ng14dJ0Uax4kCQ5Qa7Q@mail.gmail.com>
Subject: Re: /usr/include/perf/event.h:9:10: fatal error: linux/compiler.h: No
 such file or directory
To:     Vitaly Chikunov <vt@altlinux.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 6, 2022 at 8:16 AM Vitaly Chikunov <vt@altlinux.org> wrote:
>
> On Thu, Oct 06, 2022 at 05:28:53PM +0300, Vitaly Chikunov wrote:
> > I noticed that perf examples do not compile anymore with v6.0 (first on ALT,
> > but on Fedora is the same). Fedora example for convenience:
> >
> >   # dnf install kernel libperf-devel gcc
> >   # cc /usr/share/doc/libperf/examples/counting.c -lperf
> >   In file included from /usr/share/doc/libperf/examples/counting.c:8:
> >   /usr/include/perf/event.h:9:10: fatal error: linux/compiler.h: No such file or directory
> >       9 | #include <linux/compiler.h>
> >       |          ^~~~~~~~~~~~~~~~~~
> >   compilation terminated.
>
> This is introduced in b2f10cd4e805 ("perf cpumap: Fix alignment for
> masks in event encoding") just (it seems) for `__packed'.
> I am told that all uapi is using  __attribute__ ((__packed__)) for that.
>
> Thanks,

Thanks for reporting the issue and sorry for the breakage. I'm not a
dependency/packaging expert. Arnaldo, what should be the next steps
here?

Thanks,
Ian

> >
> > I don't see compiler.h installed anywhere by the `make headers_install`.
> >
> > Thanks,
> >
