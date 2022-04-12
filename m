Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB76C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Apr 2022 16:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354000AbiDLQmT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Apr 2022 12:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357738AbiDLQmS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Apr 2022 12:42:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396594831E
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Apr 2022 09:39:55 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso2214022wma.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Apr 2022 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRKI7gKq0i/3bBlyNJYsi1bvRUvgpZxesLRuzQfX23Q=;
        b=BxEMOAZvyD9qEhgyyLw5dmhi59nRAJ3cmwnhL2AONOvKIcWu3UdhSdYxxpoXdzg8d7
         yqgcwnIF50iIhssYrNWGcKV76NILxkd9BL/nSlBdot1w0xQJf1tq1JMS3D8LEOSZR6p/
         INDXy9fhbJKA5O6lqw5caQSahfB/5jENeZXS2dSPUuGJBw9jP1An9r2L5vkDk9BNr6ij
         8REinqiAFtUEYMfyWvapYXH9FopfHQ9yENQnoTo7f084MrTsr3ZKRwdKMXpkjNesioCp
         OUSK65PuXT7FHAqYe+NY+JFW+PXg2I5QMsB7iGu6bPfsdYexHAyRxmfoV5wh+oSC3jJ4
         psDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRKI7gKq0i/3bBlyNJYsi1bvRUvgpZxesLRuzQfX23Q=;
        b=XF/t5n1y9L9t9txO0rJGJ6jdEINd3C4CZr+U+uRpD/BcKaK7Ac65gxI2rTvL7TRWnL
         kVVjQVb0MMuAK+dGRjA4bnMd1B+Mbn+mvWkyNmtgf20D93587J1SGlaE6syrOepaqSij
         M5X9h+iCJp1181kIfsHlPIR2X8zpt1Y9id/Y9xwbATLxuKq7ufW3MqsJ8aBwH00AZBfv
         0IZGMkNVq7Cn16T/YOLJoN132CNE5/BvPEywRILISBMn1005WEb025od4L+J36FbN4P4
         2jCYjmNhS4AbThuReYI9zlXISFaKRwNN62+OjLu3AZxW3pa/NOA6kYUB8ioqDQb8wxbe
         VrDA==
X-Gm-Message-State: AOAM5309fh3Z4MgkqQ1h6TZU49uCwI6FcZNp2+RkN1blenRZDIFVGm+X
        T+3J7JitbY1pZQU+2IrmjMeej7lJutAkrQFD0GXR1A==
X-Google-Smtp-Source: ABdhPJy4d+a/GIHQx4axrrgaeF/nr9A4FpnJ+CiRbFr3coct0+qSOgylwG8aQKV/4rtubv00y1S7A67qCo0KHtvHOVQ=
X-Received: by 2002:a7b:cb56:0:b0:38e:7e24:33ab with SMTP id
 v22-20020a7bcb56000000b0038e7e2433abmr4973747wmj.182.1649781593060; Tue, 12
 Apr 2022 09:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAPS78poKf3EF5y_AND3p7A_rc6SGbQtmBfQKnBzkqU+yq5TF6g@mail.gmail.com>
In-Reply-To: <CAPS78poKf3EF5y_AND3p7A_rc6SGbQtmBfQKnBzkqU+yq5TF6g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 Apr 2022 09:39:40 -0700
Message-ID: <CAP-5=fXsLJ=mRq1wDn2f5Oc3x6K4=m3QFzBK9Z_5ZQzGm6aC-A@mail.gmail.com>
Subject: Re: [Question about project size]Perf data converter is large project
 or medium project?
To:     Tanusree Debnath <tanu235m@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        arnaldo.melo@gmail.com, mingo@redhat.com, acme@kernel.org,
        peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Apr 12, 2022 at 6:55 AM Tanusree Debnath <tanu235m@gmail.com> wrote:
>
> Hi,
> I am applying for GSoC. I wanted to know if "Perf data converter" is a
> large project or a medium project as I have to mention that in the
> google application form. Please let me know.

I think it can be both, it is deliberately open ended so that you can
keep contributing support for more formats as time allows. Does the
selection have time or other implications? If not I'd say either
choice should be fine.

Thanks,
Ian

> Thank you,
> Tanusree Debnath
