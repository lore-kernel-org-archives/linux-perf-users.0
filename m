Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFF4C6FD1E
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Mar 2023 14:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjCJOD3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Mar 2023 09:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjCJODJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Mar 2023 09:03:09 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743A42211D
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 06:03:06 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bx12so5116364wrb.11
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 06:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678456985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EThpMPvCDkvwUMyGGwdhDMNuAbIb6339z2iBBL6EJw4=;
        b=OVcDHFfVNbGrUMculUqDGq53hLAMoorrr6OCW/mNihTwOdCRLRgM4buhYOa89RlSmv
         88LpojhhtxNviSsNZS87k7A3J1vuyqQkLeXPCNF5aOQJ9fkFULIOv8RJZuFluI6VqcQV
         lUAxuEGJDMq5bkkZNEd/HWnUykLjMef3Q3Bnyt0VeZC4c6xunxhg15AVUYu8NcWot5rf
         5qa5R3yMEwuWXhUJ/4Pdnp8gl95/vMavp/rZwkynUETdonWr7DzgpTvNUPhJonHzvakt
         QSYIdx2qb+c1HXvVDMl1MXdikmcAB2qjLLncqUFLZY7v6fYpxsKjeXNxfRrH48lG6Kn/
         YnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678456985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EThpMPvCDkvwUMyGGwdhDMNuAbIb6339z2iBBL6EJw4=;
        b=lI8tHVU9pAHmV96Z2v+WZ/58u9ozGsDGsyjpxpUO/2LTb5BQ0LylDhFNiGkcggku/v
         0EbTrqfrQxlfkDmW7np/CUtylYHNcFc58Wz+fObEg7GcRBeePiWdnLc+rrQ8cK9QbhWi
         loqhXfd0nQNsteexqUzbvCDtDBjeoentIkuQAXDYRzX/NExd+DlyQ3u8T3N7MDGLR3Ko
         iU3wqvtcCvwyMS0Mszk2C8XvwCY9s6ja2nOie5rn5VKcJulGwgf+3gVrHY6EszAoTlUL
         Sep/jmkdRdTFh5DpDwl1QYTUvwj+Xu2OIO3CwSkuKgbbxEui2feZ1NJiSScuYfiOvZxM
         8xsA==
X-Gm-Message-State: AO0yUKUC6ToXgb7aVAZKW36qZ4SljhaVm0rlWdDZoqs4YK40sAIOLb4e
        SYYhsZ01wGw/VxvpIf01papmbDJWgyvMIhLL2nkJET0TyxjWCoSz
X-Google-Smtp-Source: AK7set9n2E6+93IMYXrz3tRWgZmCyIpX2XeQYwjcs8MxWukHx+uql5HoaK5hpUM965ux2wdqsCICs1kJ2hE+Qh0Tx5M=
X-Received: by 2002:adf:fd0b:0:b0:2c9:f41d:6200 with SMTP id
 e11-20020adffd0b000000b002c9f41d6200mr4877802wrr.4.1678456985327; Fri, 10 Mar
 2023 06:03:05 -0800 (PST)
MIME-Version: 1.0
References: <20230310111001.2836295-1-lozko.roma@gmail.com> <01f16399-f600-2b45-766f-0b5e5f868345@intel.com>
In-Reply-To: <01f16399-f600-2b45-766f-0b5e5f868345@intel.com>
From:   Roman Lozko <lozko.roma@gmail.com>
Date:   Fri, 10 Mar 2023 16:02:54 +0200
Message-ID: <CAEhC_B=hB+bmozvxk-5sGDfw3mJ5Xt6hd0bUm-L1Dt373Z3Uow@mail.gmail.com>
Subject: Re: [PATCH] fix IPC output in perf intel-pt-events script
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Mar 10, 2023 at 3:32=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> Thanks for finding this.  Obviously Python 3 is preferred nowadays
> but Python 2 seems to be still a thing.
>
> AFAICT, it would be better to fix this by adding:
>
> from __future__ import division
>
> at the top of the script, next to from __future__ import print_function

Is it possible to build perf with python3? May it be better to stop
supporting Python 2?

> Also the patch subject should be:
>
> perf scripts: intel-pt-events.py: Fix IPC output for Python 2
>
> Also a Fixes tag could be added i.e.
>
> Fixes: a483e64c0b62 ("perf scripting python: intel-pt-events.py: Add --in=
sn-trace and --src-trace")

Thanks for details, this is my first patch, I knew I would miss something :=
)
