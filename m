Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9144EC88CB4
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jun 2023 13:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbjFLN5c (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 09:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbjFLN5M (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jun 2023 09:57:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5418810F5
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 06:56:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5186a157b85so338802a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 06:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686578170; x=1689170170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HGBKm3rUtk6a6owuw8xAw+5Ji2XRPu2JkI1sZuIh9k=;
        b=jXEvY1pA2U8GUgvKgiCwziv3wrsCuPJxIXoz4FQnxeJ5edpv35iO4Q+agEadCKNJwm
         a1xcBOF+BSXkqJcK73LQJ3u6XGdLYM6gJDjgo8+mHDNxk3KYO2aZNrAQHH8ras2lkt49
         x2BCc4uHqZgs6KI23u0yMTQLY16AOuAnHZz64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686578170; x=1689170170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HGBKm3rUtk6a6owuw8xAw+5Ji2XRPu2JkI1sZuIh9k=;
        b=bOIBrpvqedLFTiFg8xRAhh7N4Y7WnsqyeyoUP0ucmvSxNAxrU/I5ZOmnOug5GuOxf6
         863VJpjqwy3oktmyTIEhSOKrALIXGojSLlAU/HZSgUG5qoBZ9m4Gd0evNSIeTXPsNn/e
         rDz3PqjB8I6fsPUmi4UniyAFNnkNr19C3vGrlLS4zqsWHhBYffOsCFIxT2WM17CSHd2K
         Z6WTSnotqjqnwPjV+y9QH0AjfeHU0ewA7X9IYTqURCv/ZIbrUTzTnlbePNJmdJOtGTUA
         OxDQvHV+qqJSQUQh/yfl0zOhQvArInK2e+ZZIlauTVv4ydvM8v856GGBVJBp9CEmmyB1
         v73w==
X-Gm-Message-State: AC+VfDwLAnfQJynV2oEKuZNUopUTjok2n8sR5Pvv3Av83Smq1nZa4Pi2
        jcb6+mxv3O6Sxv53kaS3uTIiY5QN4EUKbXORroLwlg==
X-Google-Smtp-Source: ACHHUZ4YJZNatWNcQy8dbiAslAKAsH2n95D4dYhlL37SpodYwyXeLaH9j800BULmZuIziYfyOX/Ojw==
X-Received: by 2002:a17:907:3f21:b0:969:93f2:259a with SMTP id hq33-20020a1709073f2100b0096993f2259amr10304736ejc.73.1686578170045;
        Mon, 12 Jun 2023 06:56:10 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id j22-20020a170906411600b00965cfc209d5sm5298875ejk.8.2023.06.12.06.56.09
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 06:56:09 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f7f7dfc037so96435e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 06:56:09 -0700 (PDT)
X-Received: by 2002:a50:9fad:0:b0:505:863:d85f with SMTP id
 c42-20020a509fad000000b005050863d85fmr200065edf.4.1686578149114; Mon, 12 Jun
 2023 06:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.15.Ic55cb6f90ef5967d8aaa2b503a4e67c753f64d3a@changeid> <ZIb0hd8djM+jJviF@FVFF77S0Q05N>
In-Reply-To: <ZIb0hd8djM+jJviF@FVFF77S0Q05N>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 12 Jun 2023 06:55:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WyLKygSsArCaSzid47Rz5=ozR6Yh9L6Q3JStpzF9Tn9w@mail.gmail.com>
Message-ID: <CAD=FV=WyLKygSsArCaSzid47Rz5=ozR6Yh9L6Q3JStpzF9Tn9w@mail.gmail.com>
Subject: Re: [PATCH v5 15/18] watchdog/perf: Add a weak function for an arch
 to detect if perf can use NMIs
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Mark,

On Mon, Jun 12, 2023 at 3:33=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Fri, May 19, 2023 at 10:18:39AM -0700, Douglas Anderson wrote:
> > On arm64, NMI support needs to be detected at runtime. Add a weak
> > function to the perf hardlockup detector so that an architecture can
> > implement it to detect whether NMIs are available.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > While I won't object to this patch landing, I consider it part of the
> > arm64 perf hardlockup effort. I would be OK with the earlier patches
> > in the series landing and then not landing ${SUBJECT} patch nor
> > anything else later.
>
> FWIW, everything prior to this looks fine to me, so I reckon it'd be wort=
h
> splitting the series here and getting the buddy lockup detector in first,=
 to
> avoid a log-jam on all the subsequent NMI bits.

I think the whole series has already landed in Andrew's tree,
including the arm64 "perf" lockup detector bits. I saw all the
notifications from Andrew go through over the weekend that they were
moved from an "unstable" branch to a "stable" one and I see them at:

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=3Dmm-non=
mm-stable

When I first saw Anderw land the arm64 perf lockup detector bits in
his unstable branch several weeks ago, I sent a private message to the
arm64 maintainers (yourself included) to make sure you were aware of
it and that it hadn't been caught in mail filters. I got the
impression that everything was OK. Is that not the case?


-Doug
