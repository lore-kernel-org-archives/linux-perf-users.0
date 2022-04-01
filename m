Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814CFC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  1 Apr 2022 05:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbiDAFt0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 1 Apr 2022 01:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiDAFtZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 1 Apr 2022 01:49:25 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E26247C2D
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Mar 2022 22:47:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y10so1677154edv.7
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Mar 2022 22:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w92NLA3TMQsYKuR9CXX+L2Tvsy/pumxbCD/vKiNzt/8=;
        b=RrGd6fDL+BlZgiJiYDlk1afYMuo/wxX5kFOVTYynem0oxFMrwjZb3hB7Bju7pz0WJ5
         CqSl/I+qy0nKeqMCA+hHT115kgVy6EaTH1nxCOluYxe1hWv67AuVlYeTVsp1sMM3VP9z
         tscXTUtG3PR+1Ts022kRGQCECRCRU8bq2GazE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w92NLA3TMQsYKuR9CXX+L2Tvsy/pumxbCD/vKiNzt/8=;
        b=Yqjo3jqrJLJ2KFtOHjODVSdLfw0JjV6eR4HRkuPUd+CXmEPiXYzPKWKJd7Y4IutIZ0
         IBxguMT1orX9hA3bUAe7ltwiCli5PE4JsrQ+yre4sew7adCsyGeGQJo6bxGVD/6arVak
         sJ8WKkSpp4plUIuTUnKP6JS3rESPUduTNQpVhUnvlw8t6p18rIFIH2DghzEO7j16unpg
         N33HNG/Vqdzu7UBBAGYpaqZowbADShAWY9HJTyKAaiVdsOtlNXSS6C4XS2bbOF2t61ds
         GSaLqOAJanIzVQ8VoG4+ghtzKZk43Tdd/D+yU37DZ2slhMLF1oTbuGli0mbrgbUbvtk7
         ENCA==
X-Gm-Message-State: AOAM530prJpIkDDoAGhgrABlz5Nu5skTvlsFSqEBb6yAOr9Ffe12Ymb2
        kRahH5facUB7byWAuGzzB76IKnwGZ4MdX0+I8g+kTQ==
X-Google-Smtp-Source: ABdhPJyfuPxec2DZyNCbiEggRHvedTz2z7UWAXESzkgSyo7XF/dLiybkn0eMtMv3PKBjeTtUuvcfQlIL8phX0K382lo=
X-Received: by 2002:a05:6402:350b:b0:419:1c11:23ed with SMTP id
 b11-20020a056402350b00b004191c1123edmr19717204edd.8.1648792055453; Thu, 31
 Mar 2022 22:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220330031130.2152327-1-denik@chromium.org> <77fa14e8-6630-c0e9-21fc-2603f7383f5f@arm.com>
In-Reply-To: <77fa14e8-6630-c0e9-21fc-2603f7383f5f@arm.com>
From:   Denis Nikitin <denik@chromium.org>
Date:   Thu, 31 Mar 2022 22:47:24 -0700
Message-ID: <CADDJ8CVjOe4E-2uAP=vXdSFrn3+8cj4s6yDO-qqS2S0E55kjJw@mail.gmail.com>
Subject: Re: [PATCH] perf session: Remap buf if there is no space for event
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        jolsa@kernel.org, alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James,

Thanks for your review.

On Thu, Mar 31, 2022 at 7:20 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 30/03/2022 04:11, Denis Nikitin wrote:
> > If a perf event doesn't fit into remaining buffer space return NULL to
> > remap buf and fetch the event again.
> > Keep the logic to error out on inadequate input from fuzzing.
> >
> > This fixes perf failing on ChromeOS (with 32b userspace):
> >
> >   $ perf report -v -i perf.data
> >   ...
> >   prefetch_event: head=0x1fffff8 event->header_size=0x30, mmap_size=0x2000000: fuzzed or compressed perf.data?
> >   Error:
> >   failed to process sample
> >
> > Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
> > Signed-off-by: Denis Nikitin <denik@chromium.org>
>
> Hi Denis,
>
> I tested this and it does fix the issue with a 32bit build. One concern is that the calculation to
> see if it will fit in the next map is dependent on the implementation of reader__mmap(). I think it
> would be possible for that to change slightly and then you could still get an infinite loop.
>
> But I can't really see a better way to do it, and it's unlikely for reader__mmap() to be modified
> to map data in a way to waste part of the buffer so it's probably fine.
>
> Maybe you could extract a function to calculate where the new offset would be in the buffer and share
> it between here and reader__mmap(). That would also make it more obvious what the 'head % page_size'
> bit is for.

Good point. I will send a separate patch to handle this.

Thanks,
Denis

>
> Either way:
>
> Reviewed-by: James Clark <james.clark@arm.com>
>
