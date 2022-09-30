Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA346C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Sep 2022 03:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiI3DZs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Sep 2022 23:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiI3DZI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Sep 2022 23:25:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792E3201916
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Sep 2022 20:24:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bk15so4836471wrb.13
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Sep 2022 20:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=KwtIAg7HwJ1rqqT+DnWl1VJ0hVA7c6T9lqyTYBLhets=;
        b=dnYVUdyV/UOJ+rvdo9lF+LmpB88wHEkW45PqT3a3eaHJwMU8paQRnrD1/o/htiX04y
         YohPdITF9BknKL9HidQDvJze6bd3Y3WzCP6Hj1KOdO0ZpbhNbBDjpZp/Vo4IAozImaXy
         l6i7kVBf4JBtjUwdrB7GO+GSFqolxELWQYIIMSFL2QhHhiav80UEsZa6Xz55oGwvabfZ
         0wWE53Xi8MgBYnvAvxlWA71NUX6w4YUUTtn8GGe64yITUvPEoZ70WqR/G0DSEmfNh6Wf
         CPCoOv2IPVywyqMz5EfwwVm3gFUyX8yEkXPdjqKFoBQzQ3Rpri1tUGDGzKjg6cx8PuV2
         ommQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KwtIAg7HwJ1rqqT+DnWl1VJ0hVA7c6T9lqyTYBLhets=;
        b=lpYlmdk/LJzYMCuQfSFv7iaKkf99i/k1rSOkerjfBDzbfvhcFzx340G7f6G4iVcMyb
         96VC/cOMDgG4H2iy8eh6S8XfyAQolP5liZZxXc2+8ZuXbD+gKoDv/k9A1g35OiZPblqE
         lvx9ZndQzJk+SvihLw9c5ueQdzRrTgqaY3z/yMwJ5STdxA8hnrDDO0m0xzH0lgjj7xte
         jGpGrC+6K1BzP/dUM3xJGHNfnNxChZ0zM+8orqKD2Bcq3j5DiyZpEk9R48FI3HbNhMCs
         ACNrB9+KYxV9rLaXjnHB0zyNiK2LNDcs2Ly423oo6WMVc3YiKcZGhrAyxRBbGz1oFQ/T
         nXZQ==
X-Gm-Message-State: ACrzQf3C+EwuWpipQry7cqOkRSP1IA0Mxqfq6n2EPZBMiLwDZNQ3o/e7
        LEniG95YHZl6T6hqL/AfTikPpaKirREpFilkjFjvnKYshoi8PQ==
X-Google-Smtp-Source: AMsMyM7XEtx+FTqXF6CXEzSTaxkaOHy1r/Gq/4I5ZCTlj+nvpKG7RLXTzZSSUlvdKx3n4BuDfdhITiiozf4JgGkalao=
X-Received: by 2002:adf:dd8f:0:b0:22a:84ab:4be3 with SMTP id
 x15-20020adfdd8f000000b0022a84ab4be3mr4215261wrl.40.1664508237708; Thu, 29
 Sep 2022 20:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnrHErOK+w878izVauHUKaX3eD-HXgigq2Ogm3iSj-fHA@mail.gmail.com>
 <76CB17D0-5A66-4D49-A389-8F40EC830DC0@sladewatkins.net>
In-Reply-To: <76CB17D0-5A66-4D49-A389-8F40EC830DC0@sladewatkins.net>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 29 Sep 2022 20:23:45 -0700
Message-ID: <CAP-5=fXVgwMO_CpS-EHN6PFhLB-J5Ft7qHz7oQd-WOMnTj72Cw@mail.gmail.com>
Subject: Re: Invalid event (cycles:pp) in per-thread mode, enable system wide
 with '-a'.
To:     Slade Watkins <srw@sladewatkins.net>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 29, 2022 at 3:10 PM Slade Watkins <srw@sladewatkins.net> wrote:
>
> Hey Nick,
>
> > On Sep 29, 2022, at 5:54 PM, Nick Desaulniers <ndesaulniers@google.com>=
 wrote:
> >
> > I remember hearing rumblings about issues with zen 2, LBR, vs zen 3.
> > Is this a known issue, or am I holding it wrong?
>
> Hm=E2=80=A6 I also remember this. I have a Zen 2 based system that I can =
do testing on, so I will do so when I=E2=80=99m able.
>
> If I discover something of note, I=E2=80=99ll get back to you.
>
> Cheers,
> -srw
>

LBR isn't yet supported for Zen but is coming:
https://lore.kernel.org/lkml/166155216401.401.5809694678609694438.tip-bot2@=
tip-bot2/
I'd recommend frame-pointers.

+Ravi who may be able to say if there are any issues with the precise
sampling on AMD.

Thanks,
Ian
