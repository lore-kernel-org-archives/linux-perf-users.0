Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FADC77B75
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 May 2023 16:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjEEQqm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 May 2023 12:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjEEQql (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 May 2023 12:46:41 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1C013294
        for <linux-perf-users@vger.kernel.org>; Fri,  5 May 2023 09:46:40 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-76372a83c8eso44975339f.3
        for <linux-perf-users@vger.kernel.org>; Fri, 05 May 2023 09:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683305199; x=1685897199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFdQlmBZsVXpMFRWa31Nf9CH5lKcpqbN0ffO9NCLDqk=;
        b=C3xBDtMyfXMgAYX/cA7Nn3bUoQGZFR45G17ic6CuUzkPnm23aqNnYdHTyhkYbZA4dj
         gLHtDcfEOM0LCfiwHDQEWrvna8EZ6GP6sayqTcdb6WpWyiR+obeA9sWExxMWYlGKApMK
         tlLiGrfS5TAawb4Zc0NUILIW3PWfmncVKQnoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683305199; x=1685897199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFdQlmBZsVXpMFRWa31Nf9CH5lKcpqbN0ffO9NCLDqk=;
        b=g/M3O6Vg0ChwJ15HnujaGiwFw/yuPzMup3V3HvCr1KCSg0uOL0z0ZaDvJ5iQA41NZp
         zGPwdvHCdnsAtunNA0Qzctoc+rjxfIV8J9OgQyJOf+/YmItr3k0W7S2Ke07NJu/tcmSh
         DM2Wzw1mboDXT6adyRLlkdRJVU9AnSV72i3NzFv3zi5tnUtr33KpW/Z6FHMyX7niuLH0
         VbiFqr+wsgpq2z6wsnhJ4iRndQ2dOkmW1jdz3NcgRhP9boBx2EEweBgovkWhFN+lpGqb
         5BmLiLZce0aqVowK11odITkkH2mb6ctezpYzT0NE5mNmqxfdqAabAjuvUPNiG6j4367T
         8q9Q==
X-Gm-Message-State: AC+VfDzrerJk+rJrIbhby6DiPm997avB54p30Wr4uV3m1lmmnvPkfngD
        R/BD2U+wnZyBVvyiR1ugCgAnO8VaIst47FByot8=
X-Google-Smtp-Source: ACHHUZ44a1xohcioOZxMj8O1jSPlQ7CV1Zn/iutRrXUaTZq4Nykv0NX3DCapRAau0FFsKE1YcwZsOw==
X-Received: by 2002:a92:c087:0:b0:32b:59f2:41d2 with SMTP id h7-20020a92c087000000b0032b59f241d2mr1307169ile.15.1683305199213;
        Fri, 05 May 2023 09:46:39 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id v17-20020a92c811000000b00331139b467bsm585873iln.21.2023.05.05.09.46.38
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 09:46:39 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-33164ec77ccso601865ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 May 2023 09:46:38 -0700 (PDT)
X-Received: by 2002:ac8:5a8e:0:b0:3ef:3361:75d5 with SMTP id
 c14-20020ac85a8e000000b003ef336175d5mr266034qtc.11.1683304721570; Fri, 05 May
 2023 09:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.11.I91f7277bab4bf8c0cb238732ed92e7ce7bbd71a6@changeid> <CSE0GBQQDUAY.1QAJIC3D3OBVU@wheely>
In-Reply-To: <CSE0GBQQDUAY.1QAJIC3D3OBVU@wheely>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 May 2023 09:38:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VVhPpTLPv1fmavGz-iwW1xA2P7_Uu_=GKZ-Ofu=vReZw@mail.gmail.com>
Message-ID: <CAD=FV=VVhPpTLPv1fmavGz-iwW1xA2P7_Uu_=GKZ-Ofu=vReZw@mail.gmail.com>
Subject: Re: [PATCH v4 11/17] watchdog/hardlockup: Rename some "NMI watchdog" constants/function
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Stephen Boyd <swboyd@chromium.org>, ricardo.neri@intel.com,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wens@csie.org>, christophe.leroy@csgroup.eu,
        davem@davemloft.net, sparclinux@vger.kernel.org,
        mpe@ellerman.id.au, Will Deacon <will@kernel.org>,
        ravi.v.shankar@intel.com, linuxppc-dev@lists.ozlabs.org,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Thu, May 4, 2023 at 8:07=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com> =
wrote:
>
> On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> > Do a search and replace of:
> > - NMI_WATCHDOG_ENABLED =3D> HARD_WATCHDOG_ENABLED
> > - watchdog_nmi_ =3D> watchdog_hardlockup_
>
> These are just making prefixes inconsistent again.
>
> If you really want to do a prefix, I would call it hardlockup which
> probably best matches existing code and sysctl / boot stuff, and
> concentrate on non-static symbols.

As with other similar patches, I'm happy to drop this and am doing it
at Petr's request.

[1] https://lore.kernel.org/r/ZFErmshcrcikrSU1@alley
