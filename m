Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FFFEB64DA
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jul 2023 17:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjGERey (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjGERex (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jul 2023 13:34:53 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6776E1BC6
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Jul 2023 10:34:16 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-c49777d6e7aso5860744276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Jul 2023 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688578410; x=1691170410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHoat11egk4c+Fr6oyWcJqtRqyY61MlbsSd3lj+tGHg=;
        b=hryGVU4EooMfT50jZ2YPOYOSt2UpUcO8F6eMDp0F71hgh9knrNQ7HoXiKLZQriusTW
         Z4JrjljoD6+mj81xXwNnHcx3lWfviqfACt8HgOVvnj3E8ESkf7U07ILAK+it73kKIBPD
         NRkBV3cVgrOx9d2HsYkksFg036oAez+yqnljHztjVtTLtIKd+DZ6fTiJYKTatFgStOKv
         iaP1kHpm5CYtgj6paEgRlxloP84ejyshangIheG3XZq0+/07h1QHXoJ2r4HvWfV9Mza5
         AgyPCFYYktKpq3klRPpDnpDg67jNv1poG0kmOAefXyqSOdSwXcyIAu8zKZPQCL5YXN4h
         hNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688578410; x=1691170410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHoat11egk4c+Fr6oyWcJqtRqyY61MlbsSd3lj+tGHg=;
        b=iFg2MIJs5S/023bNk0KRGVeCaMU24Z/SLgPlyrrHb0fytwII9gx7J61mspHeNmMTpr
         56hKBrqE2D03KunbvVEeb2LU/0KEYzYpc350jrxnCJmJl2/2thh6ud9AXTykiT7tlCt5
         bw53g6uhrLorsfCATUO3T2mfJwmUy92b0D5jdQzXwe3s4t+IoYesCyjl8Kgnq9DhNfJL
         C9mePPXYLYn4yR4EbNqCA122Tm6GC8pr6sEXKCyotnIaIr5D00J5YDGw08AO7uLAz4Fq
         CwpY2L65XGWNkDO8ozg3G/WiiwR6vOvfwqUD2OwVbFxAqKd+uwfHkjyyTLSHC+UJJDH8
         1rTg==
X-Gm-Message-State: ABy/qLaJHriUZAxjRPXI9UBoz0HomnXnm7VBICKrdptIU+TrzpNuP07H
        NW0fvzABQE6MSkOoBz8QgAne4TTibx5DUR+LKpc=
X-Google-Smtp-Source: APBJJlHpexuJXBoSSh05RT6ZcIovSOcWCOo8S21kPKS1QlmluuurEdi0XeIf5hQW2BUHWjN8YQjyg5w55r4dgyp0CoQ=
X-Received: by 2002:a25:ce92:0:b0:c61:4ae3:b2a3 with SMTP id
 x140-20020a25ce92000000b00c614ae3b2a3mr4031606ybe.28.1688578410575; Wed, 05
 Jul 2023 10:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <CALDTKqiVNLHM8b21T-zikuNvhfE0N_-kEinpZGSRjSO-04R96w@mail.gmail.com>
 <874963e2-f97e-b463-1351-b00640b0f67b@arm.com> <CALDTKqg01+xJ2xu218c_QH2PbX9wdhYOiJfDieCXL5PHWV-6FQ@mail.gmail.com>
 <77773641-26e5-a754-63cf-e7d3443e11fc@arm.com> <CALDTKqgek3Bicxkvnq3BQnSaS2keQG6UK8S6_0oJn26r0D00MA@mail.gmail.com>
 <20230614012102.GJ217089@leoy-huanghe.lan> <cf180f9a-085b-ad9b-c477-f02d32559c0a@arm.com>
 <f811f7ce-bf04-b5af-ee33-ea489927649f@arm.com> <20230703093913.GA904662@leoy-huanghe>
 <87b24c93-c457-6cec-736f-ab976ee1d608@arm.com> <20230703102032.GB904662@leoy-huanghe>
 <0ed20560-a880-9790-a7b2-5089c091fdae@arm.com>
In-Reply-To: <0ed20560-a880-9790-a7b2-5089c091fdae@arm.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Wed, 5 Jul 2023 10:33:18 -0700
Message-ID: <CAM9d7chz+7szVG8-XWrFGyiCPXFRc2zfq8s7VqMcqx3J7QCeyQ@mail.gmail.com>
Subject: Re: Some questions about using the perf tool in ARM-SPE
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>,
        =?UTF-8?B?6JSh5rKF5L+h?= <fissure2010@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Mon, Jul 3, 2023 at 6:33=E2=80=AFAM Suzuki K Poulose <suzuki.poulose@arm=
.com> wrote:
>
> On 03/07/2023 11:20, Leo Yan wrote:
> > On Mon, Jul 03, 2023 at 10:42:21AM +0100, James Clark wrote:
> >
> > [...]
> >
> >>>> This is on the tool side rather than in the kernel. But yes, if the =
data
> >>>> source encoding is the same as the existing ones please send a patch
> >>>> adding X4's MIDR to the list.
> >>>
> >>> I can do this; as elaborated above, I think we need two patches, one =
is
> >>> a kernel patch for adding MIDR and another patch is for perf tool to
> >>> consume the MIDR of X4.  I would like to know if this is expected or
> >>> not from your side.
> >>>
> >>
> >> Personally I would just add it on the tool side only. If it's not real=
ly
> >> needed in the kernel then it doesn't make sense to add it.
> >
> > Makes sense to me.  I will try to work out a patch, and it's good to no=
t
> > break building when kernel adds the same MIDR x4 definition.
>
> Do we somehow sync (copy) the cputype.h for perf tool ? Or do we keep
> them in sync with a patch ?
>
> If it is the former, I wouldn't bother about updating the kernel
> headers.

In general, perf tool has a copy of kernel headers and there's a script
called check-headers.sh to verify they are in sync.  We don't
recommend kernel patches to touch the tool's copy.  And it's done
by tool devs separately.

Thanks,
Namhyung


>
> Also, how does the perf tool read the midr ? It is safer to read :
>
> /sys/devices/system/cpu/cpu<N>/regs/identification/midr_el1
>
> than relying mrs emulation, which could get you migrated to another CPU
> and get a completely different MIDR_EL1 of a little CPU.
>
> Suzuki
>
>
>
> >
> > Thanks,
> > Leo
> >
> >> But I suppose from a consistency point of view we could add it in both
> >> places. I'm not too fussed either way.
> >>
> >>> Thanks,
> >>> Leo
>
