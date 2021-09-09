Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2A0C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 19:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023746113E
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 19:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbhIITUG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbhIITUF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 15:20:05 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C19C061574
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Sep 2021 12:18:54 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a15so3753931iot.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Sep 2021 12:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i0bP0XSSfAPFk4Oz4Dkuk1H78oVXFRCfNxSLlkfEhdY=;
        b=WkSgUkHu8tv1JztfKXNjYiMAjK4Eq84+K0bHsaXuhxIdeThY5SewxUHqDSeJPkig2/
         7HqCQ3sLyQKbUdm1n0Kx2MbOq9T8hED2m4cA3II8bzTy5ftV0Q6/z5Sejna2F8cbZIdk
         y+J513RZ71ftmsvmRK6cxzvXyZcnusaDm2tYazafRGSxaE46R9QjexJvC2BDvoZEE5n0
         N7u0FQhEfxvPKg5KrMwYsc5aT7AWH/CsunhkwZ9ybD0ZORM21ZwGqr9mt1YCv1aejjQw
         4QznVmV2XUZZkrd+nQr1IH8813UZJmcF5VIGNHVEkpIvM4E1WMsDK1u4QqP1ZIoi+T1B
         GUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0bP0XSSfAPFk4Oz4Dkuk1H78oVXFRCfNxSLlkfEhdY=;
        b=zSYLklrjfQ6+kRI2B74gMT9cfyLbahf74vWBDPHCAHnVJPF+81BDAWjQMhuvaoU4t0
         +gaVfjq2vqz9qmPEqIYsSlUsm4dtOGw4E6Yc3VRX1RpANTthzPyMFfG9Qg6TqpnRdZXA
         4B3rOsyVMf6G75vAJgSDOTUFJJ0/X3d7iCGQtMF71sPlEg55QX9/kbuCudvC0N1Rryq9
         XOnzuCTSTNVxqyVyuzYrHamubld8NPaFIC2XGmR8WIixsUn5L7bWp+ym094LQJ52sXUl
         RthUiYxRRbV3HZb2J5b4L70zd0s1qWMGEWOpC4W2raMcnsVNhw3HT658aw6zZks5MQfK
         63/A==
X-Gm-Message-State: AOAM532dTkrH9+SE+kaPHpQm8ofI/y0u/gZ8AeibUQg1XITWOy/wNWVk
        Xa1S6ow8xuv4cIlFcLG6sqz+9zUh9rsE/azFN9OyFEcwYmD8YA==
X-Google-Smtp-Source: ABdhPJyg71Wnt0IOgR3XKnYzPjz8oSAohvdvJ1Mg9Nad4xEyWmUKtECDeAC6k06bEC4+bwIFxjPQMVf9maL99wZuhQ8=
X-Received: by 2002:a6b:8b4b:: with SMTP id n72mr3887575iod.18.1631215133443;
 Thu, 09 Sep 2021 12:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <cdf5252d-76af-9fb5-522f-206572b21807@wakelift.de>
In-Reply-To: <cdf5252d-76af-9fb5-522f-206572b21807@wakelift.de>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 9 Sep 2021 12:18:41 -0700
Message-ID: <CAP-5=fVes7=aLS3GM15zxyjRpAJXtkqbxPUtYqHeXRy74Zz_xw@mail.gmail.com>
Subject: Re: Make jitted assembly code available for annotation in "perf report"?
To:     Timo Paulssen <timo@wakelift.de>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 9, 2021 at 12:09 PM Timo Paulssen <timo@wakelift.de> wrote:
>
> Hello perf users and devs,
>
> I'm a contributor to the MoarVM project, which is the interpreter and
> jit runtime that powers the Rakudo compiler of the Raku language, which
> you may have heard of back when it was still called Perl 6.
>
> We already output a file `/tmp/perf-%d.map` that contains the start and
> end addresses of jit-generated symbols, but I don't know how to tell
> perf where to look for the binary. Our current code will dump each
> compiled piece of code to a folder with an incrementing number. The perf
> report frontend will in its current implementation answer the request to
> annotate a function by just running objdump against the perf-%d.map
> file, which unsurprisingly doesn't work.
>
> I would be glad to hear suggestions, especially ones that don't require
> me to generate a full elf file or similar to hold the symbols.

Hi Timo,

Did you look into jitdump? It requires the perf.data file be processed
by perf inject, see the -j option in:
https://man7.org/linux/man-pages/man1/perf-inject.1.html

An example JIT agent is provided for JVMTI:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/jvmti?h=perf/core

Thanks,
Ian

> Thanks in advance
>    - Timo
>
