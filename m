Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FCBC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Nov 2022 05:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKCFdB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Nov 2022 01:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKCFdA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Nov 2022 01:33:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577EFBC2
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Nov 2022 22:32:59 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so2445872ejc.4
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Nov 2022 22:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QxHwdNSRZxWkDQkg6uvUY0ujmFP08SAArZlQSADznoA=;
        b=LICjpEJhenrB9iXeBKaktSOAa9LKw7Bcuk88goXAS2rIZYjDAJtvETrJ+FoanrXgAB
         jDMd0lxbkdvDlDDFVGZIB1I+kzciAEHFftg7imFWmgora0eGPF77S8AemRQC0RMwgtvY
         cC6pjvWylf9ocrry8Y7XIbMF2YHC2KD/L+PqX0FOppLS2bIIxDaL8+jQXn9Wr3zMqIZE
         QD5p1/QV9VngYIimvpKq2ATIUALXnkJXkxlO/EmkubHSoM+rVx3OnaYtqfWijnYqEo2M
         EPBoZPXWKeZ7VzLMTw0PhNR8G7khEbavKWyPu/Lcz7IfVs3V2k2NvOGfPQWfZscdAsec
         Jqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxHwdNSRZxWkDQkg6uvUY0ujmFP08SAArZlQSADznoA=;
        b=h9iCHtGtQydWnm3afcrAF//J0kn1IyZQsPyXZ1+riDRmPico00tDBhpD3umTIlWcyw
         Fu7Kz7NXt/hMetlFH2eaY+Gk22zckKB22qqz0bLWxfYQXY1zDGj1EhXZFe5Uo5B/RPdZ
         SjJ4CerLkW6Bxy8Z3tGzJTZm53jx/sP96FLlItomnut0Lgkey7L8MJtyjnslKshi1Q8/
         FjVMunzOgerEZYcz5yAKJF2BQCaza+RJokCKe9DNTjnZQlym6D5v39q/AkwH4u8+nMdB
         kAMcJg6Nt6iGBmsasZvuman+eVcxFRT5qkf0aLTqEk3E4ytWE2VGwD0ZWnmNeOXpL13e
         36/Q==
X-Gm-Message-State: ACrzQf1/jyQXmo22HxduR+1X7/5f9CaiIh42XL0//nyUwEnrLgVoJf9X
        oK3BmKPdbcwsT2RIX+VVND5YewAMKmWa+E0KZZyx+SSzwyc=
X-Google-Smtp-Source: AMsMyM4NmLQqfXH0oBGob4NJPJ7/M23favSgwhq8c2XXT62hem2CFukSGO7O+5fEi9nnXj/gzUeTvplpU4Ba/D10EcQ=
X-Received: by 2002:a17:907:7b93:b0:770:1d4f:4de9 with SMTP id
 ne19-20020a1709077b9300b007701d4f4de9mr27740534ejc.201.1667453577739; Wed, 02
 Nov 2022 22:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsGFoC5TciCuijZXLx48TZnoTSkq=iUgb+vFdi9EYTucw@mail.gmail.com>
 <Y2LgMYsgj8c7Aj1U@kroah.com>
In-Reply-To: <Y2LgMYsgj8c7Aj1U@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 3 Nov 2022 11:02:46 +0530
Message-ID: <CA+G9fYunBonRypu0QruuH23H0chET=sZH7FfbK8nGabkCFd9sg@mail.gmail.com>
Subject: Re: qemu-i386: perf: BUG: kernel NULL pointer dereference, address: 00000148
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-perf-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Marco Elver <elver@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 3 Nov 2022 at 02:54, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 02, 2022 at 06:42:52PM +0530, Naresh Kamboju wrote:
> > Following kernel BUG: noticed on qemu-i386 while running perf test suite
> > on stable-rc 6.0.7-rc1 the image was built with gcc-11.
> >
> > The System did not recover after the crash.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> What is this a regression from?  Does this happen on older stable
> kernels?  Linus's tree?

This looks like an intermittent problem.
I have tested multiple times and found that it is an intermittent crash
with qemu-i386 while running stable-rc 6.x. That is the one of the reasons
for not including the stable list and not reporting this as a regression.

> How about 'git bisect'?

Since it is an intermittent crash it is hard to bisect.

- Naresh
