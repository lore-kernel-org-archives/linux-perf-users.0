Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E231FC7EE22
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 May 2023 14:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbjEKOfo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 May 2023 10:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238573AbjEKOf0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 May 2023 10:35:26 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A369B11B68
        for <linux-perf-users@vger.kernel.org>; Thu, 11 May 2023 07:34:48 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7591797c638so13663985a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 May 2023 07:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683815686; x=1686407686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDAnVIuo236iFwX8Q4PwBvcDGXZtwfSqujw0bG7p3X0=;
        b=GTmTypfqSNuLbRXk7CoP5u2QhIfP2ABwgsrnyU8SyjwRhri7xhRhiCPlxWYdoU3vL6
         QFPcynxldEMfc6XpkSco9M92VA3cEELBoJbd600audt762yS1ER/PFkDdjZJO4jP2j++
         g4DGXREKQ4yO+KZmco1dWlLLRgejdc3Buw1F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815686; x=1686407686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDAnVIuo236iFwX8Q4PwBvcDGXZtwfSqujw0bG7p3X0=;
        b=FgB/nSHcHuJ2RamApdXaUYZlNekSzJqXMI93g/i8sYqWOqHwIn0VqXTonvZoIYgHHo
         NVZYWqd1AY2ItJYG/+HToxuIB/SPubhSIwElVDK//uaYTCgCt+AxUygDWjGzmv82ZKCr
         d71bJin0mmx4KgY1zNsSTzdptwHyLGrQ+68IVCsTAoGNxqrPFnZopiQBw2uLB0lMdADi
         fh9lK0lVtHLLgebR8wDBzMfUU++BCDSidA2XUcUneuNJILtbmrEWfqr3ItJ2XR0p3Tsw
         qHuCzT1SJR7mPrb5VWX0CRZv/dOxdBhBjKiaBpgVfq52sRjEVolc/jlWr/x6UsHbZPCS
         dLOQ==
X-Gm-Message-State: AC+VfDw9phbKECK/r02iEm5JuxMcIr5x2q1pdbBWWMSYWnureE+WxS0I
        lfrzP3H0cYYKHBa+U+XJlwVTkSX+OADyyuLoZetYTQ==
X-Google-Smtp-Source: ACHHUZ7hdBDCZ4G5WI26cZ0i3lMhi8Fy8St+FAGZPqEpSOdzzKpoMMk3OIWpxqMWwpvCjSx+fSBMYA==
X-Received: by 2002:a05:6214:2629:b0:61b:6271:532b with SMTP id gv9-20020a056214262900b0061b6271532bmr34260271qvb.36.1683815686100;
        Thu, 11 May 2023 07:34:46 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id c16-20020a0ca9d0000000b005ef6b124d39sm2334459qvb.5.2023.05.11.07.34.43
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 07:34:43 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-3f38824a025so789481cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 May 2023 07:34:43 -0700 (PDT)
X-Received: by 2002:a05:622a:1a05:b0:3f3:9c91:fee7 with SMTP id
 f5-20020a05622a1a0500b003f39c91fee7mr421512qtb.16.1683815682956; Thu, 11 May
 2023 07:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230419225604.21204-1-dianders@chromium.org> <20230419155341.v8.8.Ia3aeac89bb6751b682237e76e5ba594318e4b1aa@changeid>
In-Reply-To: <20230419155341.v8.8.Ia3aeac89bb6751b682237e76e5ba594318e4b1aa@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 11 May 2023 07:34:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X=tm_smsi9itwK_Ku2vU0d676JT+MK3fkALn5QMsduiQ@mail.gmail.com>
Message-ID: <CAD=FV=X=tm_smsi9itwK_Ku2vU0d676JT+MK3fkALn5QMsduiQ@mail.gmail.com>
Subject: Re: [PATCH v8 08/10] kgdb: Provide a stub kgdb_nmicallback() if !CONFIG_KGDB
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Chen-Yu Tsai <wens@csie.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Wed, Apr 19, 2023 at 3:57=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> To save architectures from needing to wrap the call in #ifdefs, add a
> stub no-op version of kgdb_nmicallback(), which returns 1 if it didn't
> handle anything.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v8:
> - "Provide a stub kgdb_nmicallback() if !CONFIG_KGDB" new for v8
>
>  include/linux/kgdb.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 87713bd390f3..9ce628ee47cc 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -377,5 +377,6 @@ extern void kgdb_free_init_mem(void);
>  #define dbg_late_init()
>  static inline void kgdb_panic(const char *msg) {}
>  static inline void kgdb_free_init_mem(void) { }
> +static int kgdb_nmicallback(int cpu, void *regs) { return 1; }

FWIW: I just realized that the above needs an "inline" to make the
compiler not complain. I'm still hoping for more feedback on the
series, but I'll plan to fix that in the next spin.

-Doug
