Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C19FC7EE23
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 May 2023 17:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243793AbjEORW3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 May 2023 13:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244060AbjEORWF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 May 2023 13:22:05 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7BF13C01
        for <linux-perf-users@vger.kernel.org>; Mon, 15 May 2023 10:20:16 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-24e4f674356so11669468a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 15 May 2023 10:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684171214; x=1686763214;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX6egQiHhIXuURJzhuekh3GWalrQL58fuRjBxSVKU44=;
        b=DCysOcvZAq2Qg21dqZ6wHxBGBIIgvLp4GcrrcRsl/4xvFuSK22NUVgbCLRUkIrQ69c
         +KrAT7tEPlHBnaa6ia7TZPPRU2CeHkRU3Tq/ZUcjuDBfTP/BuzjQAqy2FrbsbdAkBb4f
         ouPgI0iWUIcMVstRdWPTiNbGwjlmMBZ/8rN/V4VYHHqQnii2b1DGEQcey+cOtFLcmdWh
         eMKmTrkqVGFYNo/BzSFwBWroQHNc44BcpVlJezD5GZd6shSbaRGxzrtbF43ljGGfvdqG
         wy0hCGssbdVTn4mZA9iyGGvu6tYSupvxeVteUkpj8FKgNnEHNVGhomBuXxPfJKZe3lw1
         hkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684171214; x=1686763214;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FX6egQiHhIXuURJzhuekh3GWalrQL58fuRjBxSVKU44=;
        b=aFK01Faw1XtRcSjAqC+LHBcxXCY6YqrdS2qrKnFRpej58/B8ONrG1JJ1DvhimXA4qt
         2fulCDhyT0+x5/TuVOux9EjQEowXk0L+X6sGw/Kd2JYlq2FCGJuOX/l0HFkBASKN2WgP
         19wE4VdqVOTyBrWkkY+nwQUeNm9lnJrl3sg6fWkX4rwI9D7L2rUeyJfKN+iuFxuVHGu9
         WmWA41s+2ANsVYFy+yB/xKk3l1zSdKIeoHMj1HCLVQnxKGZdvfS2FLBvXfTwFjnL3epR
         GZiWZEF5iag/j5G60OmelWtw/cwCv8liWwsh+aEAy0+fjQ4Ks85Vh5ulVkEaOuplBtDm
         OnMA==
X-Gm-Message-State: AC+VfDxARpNPUXUdnAs8id5tQOjEl1Dn8fuR3bIAnEVAzSpAT3j7ki2C
        ida8prW2JCtLQbK5w6d8BrpYe99BjEWVefpMiMToo8lk
X-Google-Smtp-Source: ACHHUZ7efjsKR+COZuU6zeF9TphOU3M4F2igOPBHC0zc0Uo3dbyPCRua+tK2cLXprWccg0dAaw8pD+j5Pti9+7xAMp4=
X-Received: by 2002:a17:90a:3ccd:b0:250:4847:426a with SMTP id
 k13-20020a17090a3ccd00b002504847426amr31555929pjd.11.1684171214517; Mon, 15
 May 2023 10:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAGA5_H6b7jVJcy0ahnbTqG3eqA2PD3TGFmXm7xQ=gMBVJ1yZyg@mail.gmail.com>
In-Reply-To: <CAGA5_H6b7jVJcy0ahnbTqG3eqA2PD3TGFmXm7xQ=gMBVJ1yZyg@mail.gmail.com>
From:   Rajasekhar Pulluru <pullururajasekhar@gmail.com>
Date:   Mon, 15 May 2023 22:50:02 +0530
Message-ID: <CAGA5_H7CBGiaaULrbhQk1P8qQC5BKBOK54pEGnppggY892MWSw@mail.gmail.com>
Subject: Re: missing symbol names in perf top but not in perf record/report
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Team,
Will be glad to see some help on the issue reported below.
Is this an expected behaviour? Is there a known solution to this problem?

Thanks & Regards,
Rajasekhar

On Thu, May 11, 2023 at 11:05=E2=80=AFAM Rajasekhar Pulluru
<pullururajasekhar@gmail.com> wrote:
>
> An application (compiled with -g and -fno-omit-frame-pointer) is
> running inside the linux container. Trying to use perf tool on the
> linux host (not inside the container) to identify a list of functions
> consuming more cpu cycles.
> Running perf top -p `pidof app` on the linux host prints address
> instead of symbol name, where-as perf record -p `pidof app` and perf
> report prints symbol names instead of addresses.
>
> Why doesn't perf top display symbol names if perf record/report can?
>
> Linux host is based on jammy, and Linux container is based on bionic.
>
> Appreciate any help.
>
> Thanks & Regards,
> Rajasekhar
