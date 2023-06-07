Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347CBC77B7A
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jun 2023 23:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjFGXh6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjFGXh5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jun 2023 19:37:57 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E973426AF
        for <linux-perf-users@vger.kernel.org>; Wed,  7 Jun 2023 16:37:36 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-777b4c9e341so206237339f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jun 2023 16:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686181055; x=1688773055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN7QCcXv3GhQ50KYCOkYuc7v8/KdYJA2Wdn7x5ACZBs=;
        b=j7P34YHOYHXEN5m6sprm1z9RILqU45cM7iBZf0UUjkLN1Z8TxMe0YIqzljyllJP9ST
         fYCIbYR3iz8BZ5MSlJeSjjWgcEsLHQnEq4teh4pJEa3UXp/iCGFoHb5zOeC1XYxEkZMM
         6V9aevVsYko4O4sbDW2MpZ5T2WuA3Ec5vQy9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181055; x=1688773055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EN7QCcXv3GhQ50KYCOkYuc7v8/KdYJA2Wdn7x5ACZBs=;
        b=ZIS7QNr6FcAP3lN6nt5lhRZ7buwFQ0XnBh4m8dnHjwa5/hYSZJAsAsdmGOm+izND/e
         KhYP7NQSRYn1JcrP33s7c0M+UIu5Bcnj7XEMTdlvcv2CTbYWzzbDarIzDGRKcDhUVv+a
         sX/0Hsx72fr2XTS9fdD5FOrbGykxxNbnwHeVtSc9gkhnuZnAKQPhVIWVQpqG6cmsNfkm
         vYT8CKBt+WWzo6LtMenDAK0qPjwG8+FT4FjctilwceXF8hWuYQzMEbRboVzpoDMEIULl
         a55RQsnr3NzQOXKmgPU2fXb5Jb+JiCbpSKclgX+eGH5vXiEC2eh5KvrinIw/FrSXaFPD
         ydUg==
X-Gm-Message-State: AC+VfDwsUS17BJ899qjo94CXnVwsDU1d6PJbBNFHlGZyqB6ubR9Vgihz
        eeC+1stK/+nytloeFx7bDnExaFHwaqd6NFQ2lF0=
X-Google-Smtp-Source: ACHHUZ6ezowOlxkQ2oI/YrBFzGY+hhKDoB8btMROh9J4mZB5O5PvT6+EVO4bK0KL5V2aHMrTPzp9WQ==
X-Received: by 2002:a6b:e218:0:b0:77a:c808:3c89 with SMTP id z24-20020a6be218000000b0077ac8083c89mr1910294ioc.20.1686181055449;
        Wed, 07 Jun 2023 16:37:35 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id b23-20020a02c997000000b0040bbfad3e28sm3712860jap.96.2023.06.07.16.37.32
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:37:34 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-33d928a268eso54845ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jun 2023 16:37:32 -0700 (PDT)
X-Received: by 2002:a92:c54d:0:b0:33e:6b65:6f78 with SMTP id
 a13-20020a92c54d000000b0033e6b656f78mr16557ilj.27.1686181051931; Wed, 07 Jun
 2023 16:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-1-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:37:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W=xamTf6BUmp-Yg-SEEgE8GRKw6Pnfv6t=Hviywj-N-g@mail.gmail.com>
Message-ID: <CAD=FV=W=xamTf6BUmp-Yg-SEEgE8GRKw6Pnfv6t=Hviywj-N-g@mail.gmail.com>
Subject: Re: [PATCH 0/7] watchdog/hardlockup: Cleanup configuration of
 hardlockup detectors
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Wed, Jun 7, 2023 at 8:25=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> Hi,
>
> this patchset is supposed to replace the last patch in the patchset clean=
ing
> up after introducing the buddy detector, see
> https://lore.kernel.org/r/20230526184139.10.I821fe7609e57608913fe05abd8f3=
5b343e7a9aae@changeid

I will let Andrew chime in with his preference, but so far I haven't
seen him dropping and/or modifying any patches that he's picked up in
this series. I see that he's already picked up the patch that you're
"replacing". I wonder if it would be easier for him if you just built
atop that?

-Doug
