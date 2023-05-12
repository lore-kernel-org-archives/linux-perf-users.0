Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE11C77B7C
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 May 2023 13:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbjELNwh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 May 2023 09:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241075AbjELNwe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 May 2023 09:52:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C11E4A
        for <linux-perf-users@vger.kernel.org>; Fri, 12 May 2023 06:52:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f415a90215so76992515e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 May 2023 06:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683899548; x=1686491548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KlqtYj2sIx0sjwwCMtZ7w/k64brEWXitqz4tOF+SKWQ=;
        b=ikM1onuzF3Q2H1SPl3vp3GOfHcQ+i0G5uF9g9tbNOkzp8gBEtd0oUKEFRDxfL9LnOQ
         JfEkQeoEAU2gKgbpS/KjT0ta/VG6CP75xgy7ao5vtDsXQUFAJx6BJwnhlEGOJOAk3d/7
         AptQCENFBIBebQimL+ZHRUT8eDT4YH9BW1UuXCZFa0O4wnqhByXHQrRfylk5N0s2GhLu
         FizGaUOzpuqFK8zQPZN+rchWGEOO1O2TiXromozhQbkYEKO3KW/XF6Hp3jnp1PHSdCg9
         QRYQ05kei/nv3fNKIn0wqzZD6tiarLvKdaHkPrNVweYs7f/SqzE+ot9y5P6EpLG+s98Q
         Is2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683899548; x=1686491548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlqtYj2sIx0sjwwCMtZ7w/k64brEWXitqz4tOF+SKWQ=;
        b=IqU4MT7HL+nqE+sgcV/2e8LFEOvljMMkXtEummzrXVPEMcxbmuS/MhCke0j/UO9knn
         Im+gSokRrfvyScmhfm3vEtgie+EOmw+HWjpC8KjytjazWTbe/xgl3RGUv0F+/WbPaKut
         1pwbQuT5UF+rlj4nBU2eyO3lz5IpfPozN7QnEw1QUo1X8P9PRShOi4OLknpcrb/Oxmwt
         VC6mPuVskLzA6vY506pkcq7UJ1EVy4keZxUNu3dfOieuja4WdS7IHdVjQyTVnQBQ9JuG
         pkTGXHGh+ky3Io7YA1yJFbOvtEDudJH2BoFGjfw7UNaaQFkD965227WI+BuPLNCZocte
         WFHw==
X-Gm-Message-State: AC+VfDyHd+CDYjx0wmiTz/Zw/8tbfLu45m11vzpBSwsK62JdQyxSQyp9
        pBh2He9FNfXzL3VHQI7jZ1JrDg==
X-Google-Smtp-Source: ACHHUZ5gks0kesTcYHQGZmDMSB53C9RWSGJ2R9t+vGgAq1ZD4zyk0Htxw3eMp2IcxpNoLZT/HXSQMA==
X-Received: by 2002:a5d:6246:0:b0:2f6:25a6:9788 with SMTP id m6-20020a5d6246000000b002f625a69788mr16443692wrv.35.1683899548461;
        Fri, 12 May 2023 06:52:28 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id i11-20020adff30b000000b0030644bdefd8sm23519775wro.52.2023.05.12.06.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:52:27 -0700 (PDT)
Date:   Fri, 12 May 2023 14:52:25 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 08/10] kgdb: Provide a stub kgdb_nmicallback() if
 !CONFIG_KGDB
Message-ID: <20230512135225.GA217187@aspen.lan>
References: <20230419225604.21204-1-dianders@chromium.org>
 <20230419155341.v8.8.Ia3aeac89bb6751b682237e76e5ba594318e4b1aa@changeid>
 <CAD=FV=X=tm_smsi9itwK_Ku2vU0d676JT+MK3fkALn5QMsduiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=X=tm_smsi9itwK_Ku2vU0d676JT+MK3fkALn5QMsduiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 11, 2023 at 07:34:30AM -0700, Doug Anderson wrote:
> Hi,
>
> On Wed, Apr 19, 2023 at 3:57 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > To save architectures from needing to wrap the call in #ifdefs, add a
> > stub no-op version of kgdb_nmicallback(), which returns 1 if it didn't
> > handle anything.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v8:
> > - "Provide a stub kgdb_nmicallback() if !CONFIG_KGDB" new for v8
> >
> >  include/linux/kgdb.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > index 87713bd390f3..9ce628ee47cc 100644
> > --- a/include/linux/kgdb.h
> > +++ b/include/linux/kgdb.h
> > @@ -377,5 +377,6 @@ extern void kgdb_free_init_mem(void);
> >  #define dbg_late_init()
> >  static inline void kgdb_panic(const char *msg) {}
> >  static inline void kgdb_free_init_mem(void) { }
> > +static int kgdb_nmicallback(int cpu, void *regs) { return 1; }
>
> FWIW: I just realized that the above needs an "inline" to make the
> compiler not complain. I'm still hoping for more feedback on the
> series, but I'll plan to fix that in the next spin.

On the next spin feel free to add:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
