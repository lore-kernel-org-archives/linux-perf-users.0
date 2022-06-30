Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F41C43334
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Jun 2022 06:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiF3GuJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Jun 2022 02:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiF3GuI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Jun 2022 02:50:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF1D31523
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 23:50:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r20so25761352wra.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 23:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=A18i+0tA65SLSAR3mtwgydnTcBxRidlePlWOrx+hrrU=;
        b=JRDW3dTcYuYTWxEJGIBZXJ1NmZ8ynPPzzydwouNV04GOFLvHLw9Xwyqegu/4rW6GHV
         hM0u7oSJrf7tmvdQp4p5TbbZ1ynHAr1edid5T5n1tbILergdx5wxYUxVsUinsgYKhfYC
         dWngMBezzc4SijyckuTpFWy83IFTVD9BBAIz3vwpJhSneFU/lC7jsLYI7BRGqANB0sv9
         i3zHIjQ7qTjcSy7BII5wBkphf3zyog3B9z1KPB1LWK4eY/pY8KiGJeWArWvhE3p096gl
         Ltz0fs6YEVmKyn/5x+z4ez3onZBlJ/bJsrVmWs9kChgbbuyEVsK/1GzQaM8NRS8GEFhv
         /pNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=A18i+0tA65SLSAR3mtwgydnTcBxRidlePlWOrx+hrrU=;
        b=2NzCEF+eTEbAKqEJQ5CHFY62jqnAIKXgK1XMxUMj/CZ85mYJAjHJeKYGCuJkLAd3vU
         ba4y8U1fj9UqzsUbdRXS+LQaPqJyTZQJbfrgXbOs/LTdx6kLQq7J1A+cx2iC4BvOs4lO
         XmtZu1RCMCtFLMIEb5zUE6kpik6UhSxLrIAXto7aFmfunImlVwIjfUD4z6qnsDf6cH5v
         v5XYk0UPOs6GIlGHhbGLXwnelw2AtpXRrLPPpOlY/5tsbosx0q3mbwRUPQoGqEQgq0qy
         qZ6P6wRszkw3HdRv9pKTwfyMrD9D3SvECnoKY5/NYCYzru/OnvqyHoYe5TNMBpiqGdIf
         VzGA==
X-Gm-Message-State: AJIora/vkJZsKeDR5g601rocMuBAU8MOnGC5A5jTxETH9reOTtolZwv8
        Rw+DuzATZwHNYlzrawKP9BauoBvxg20BdpM0mgkJtWwOt2mW4Q==
X-Google-Smtp-Source: AGRyM1vdjnI38fspbFv8p1dp8rKsnk0tfEHqBrL049TkPUgWe1SVvXbtg+6j/HGAmyrKU42xK+4qtmarqPGbWt6iX6k=
X-Received: by 2002:a5d:6b91:0:b0:21b:bc0b:7282 with SMTP id
 n17-20020a5d6b91000000b0021bbc0b7282mr6750079wrx.375.1656571804733; Wed, 29
 Jun 2022 23:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fUpDdYOcRBBy21cDi=eTov++cKY_E-rnP9++wvopJbijw@mail.gmail.com>
In-Reply-To: <CAP-5=fUpDdYOcRBBy21cDi=eTov++cKY_E-rnP9++wvopJbijw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Jun 2022 23:49:52 -0700
Message-ID: <CAP-5=fWdKGbk-WWWzkYwC5KUtK4qsT1mFrGy=oFQD71SOBTs4g@mail.gmail.com>
Subject: Re: June 30th - office hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A reminder that this will happen in a little over 7 hours.

Thanks,
Ian

On Mon, Jun 27, 2022 at 9:31 AM Ian Rogers <irogers@google.com> wrote:
>
> Hi,
>
> An earlier than of late reminder that there will be another office
> hours on June 30th at 2pm GMT*. We should do our usual GSoC
> contributor check-ins, please feel free to suggest additional agenda
> items!
>
> If you experience problems then my email can be used for Google
> hangout messages, I'll try to be on IRC (#perf on irc.oftc.net).
>
> A reminder that the code of conduct is below**:
> https://www.kernel.org/doc/html/latest/process/code-of-conduct.html
>
> The Google meet details are here:
> Linux Perf Tool - Office Hours
> Thursday, June 30 =C2=B7 7:00 =E2=80=93 8:00am (PDT)
> Google Meet joining info
> Video call link: https://meet.google.com/goj-quks-ydn
> Or dial: =E2=80=AA(US) +1 301-969-4101=E2=80=AC PIN: =E2=80=AA374 496 227=
=E2=80=AC#
> More phone numbers: https://tel.meet/goj-quks-ydn?pin=3D8067739163431
> Notes (ask to be added to see):
> https://docs.google.com/document/d/1tQZvJ12czMedpmLLZWS0XILAte97zdR6H_tgC=
3Ivafs/edit?usp=3Dsharing&resourcekey=3D0-iV9_8Oc0cSOPl0-NvEYDAA
>
> Thanks,
> Ian
>
> *The around the world times I believe are:
> China: 10pm
> India: 7:30pm
> Europe: 4pm
> UK: 3pm
> US east coast: 10am
> Brazil: 11am
> US west coast: 7am
>
> **More details from the first office hours are here:
> https://lore.kernel.org/linux-perf-users/CAP-5=3DfWkxtm5-Ebwkh4pzA83prvuA=
J5yy6CKQYatdkKWu3Tgeg@mail.gmail.com/
