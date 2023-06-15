Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EBEEB64D9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jun 2023 18:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbjFOSOh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jun 2023 14:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjFOSOf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jun 2023 14:14:35 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF9710FE
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Jun 2023 11:14:34 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso13449920a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Jun 2023 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686852872; x=1689444872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyNYAJPbrsk4+kV6DyQJsOygOqO+LfaaaEVKNin4xFM=;
        b=FYscYYVsxDxn/+cJkq4UPRu4HqpXyg4D3FwGUrOibNEdKQjSw0euEBZVPfDUR6DCTF
         vkHZnjSJ/0vBEzmEaoZxIeEdLo/1YMK0NSrE6B5UQI7tV6Eo1QmM2WT8kfbMRyFPerTx
         pThLyNJ5QnqnXo4JBtrlmlDufSHgtFuSMHWDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686852872; x=1689444872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyNYAJPbrsk4+kV6DyQJsOygOqO+LfaaaEVKNin4xFM=;
        b=JGxXw3xjRE4IE/aFW2PD+bFCA9j2FzUqlojLViF7e6iuqcXwJQCgVyMCMLsQIA3XaU
         drqqiSfNgVRylCXs5DgdoN+EhoEDb0j2Z4XTG2KamkI7j7ZiRGA6nfe7PG5scLN2I6aA
         B0lwAZVvgs4H0IgsknXBtCrRd+EyZJ9wSWJDD9cdMYIqqfM8UbKXzSLy8f0yj8+hQKgy
         /+62eB+gra1Ujk+h333r10x66mIPzPL5Ii4f9Bt2GQo2WmuISOAlhQQ2CPtdaSf5vZ6Z
         HgfQXdUhR11tNYsDDeHpHvkFoA8Gfz/fmnwHoWCEWAWnT0HPuFPPwaz3CTFeTXjldWJB
         TGfQ==
X-Gm-Message-State: AC+VfDzKLR8bUdcEf76/L2Hh2+fBuTfK8kZHGrEdqqt7SVyXh93kO9jd
        +RmP1JA1oKxPk7/XAqPPEsER5w5MkLhUiVDNKwvWkuxo
X-Google-Smtp-Source: ACHHUZ4oJdDM6HtrzF1Uu7z7VhZ7UCt/t0nM72nuweRxUeS6WKuu4Br6U38ypIYYzNsOp1L7SPavZQ==
X-Received: by 2002:aa7:d449:0:b0:51a:2125:74d5 with SMTP id q9-20020aa7d449000000b0051a212574d5mr2034254edr.20.1686852872579;
        Thu, 15 Jun 2023 11:14:32 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id c8-20020aa7c988000000b005167bb5fc3csm9178039edt.38.2023.06.15.11.14.31
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 11:14:31 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51400fa347dso1443a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Jun 2023 11:14:31 -0700 (PDT)
X-Received: by 2002:a50:d697:0:b0:510:b2b7:8a78 with SMTP id
 r23-20020a50d697000000b00510b2b78a78mr101415edi.5.1686852871368; Thu, 15 Jun
 2023 11:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230601213440.2488667-1-dianders@chromium.org> <20230601143109.v9.6.Ia3aeac89bb6751b682237e76e5ba594318e4b1aa@changeid>
In-Reply-To: <20230601143109.v9.6.Ia3aeac89bb6751b682237e76e5ba594318e4b1aa@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 15 Jun 2023 11:14:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XbnUZh2uQ5Sr3Dg=+Kiz7rfZVyP-zNQtXrV_NSsCTFcA@mail.gmail.com>
Message-ID: <CAD=FV=XbnUZh2uQ5Sr3Dg=+Kiz7rfZVyP-zNQtXrV_NSsCTFcA@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] kgdb: Provide a stub kgdb_nmicallback() if !CONFIG_KGDB
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Daniel,

On Thu, Jun 1, 2023 at 2:37=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> To save architectures from needing to wrap the call in #ifdefs, add a
> stub no-op version of kgdb_nmicallback(), which returns 1 if it didn't
> handle anything.
>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> In v9 this is the only kgdb dependency. I'm assuming it could go
> through the arm64 tree? If that's not a good idea, we could always
> change the patch ("arm64: kgdb: Roundup cpus using IPI as NMI") not to
> depend on it by only calling kgdb_nmicallback() if CONFIG_KGDB is not
> defined.
>
> Changes in v9:
> - Added missing "inline"
>
> Changes in v8:
> - "Provide a stub kgdb_nmicallback() if !CONFIG_KGDB" new for v8
>
>  include/linux/kgdb.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 258cdde8d356..76e891ee9e37 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -365,5 +365,6 @@ extern void kgdb_free_init_mem(void);
>  #define dbg_late_init()
>  static inline void kgdb_panic(const char *msg) {}
>  static inline void kgdb_free_init_mem(void) { }
> +static inline int kgdb_nmicallback(int cpu, void *regs) { return 1; }

What do you think about landing just ${SUBJECT} patch in kgdb right
now so it can end up in v6.5-rc1? It seems like this series is
currently blocked on Mark getting a spare moment and it seems unlikely
that'll happen this cycle. If we at least land the kgdb patch then it
would make things all that much easier to land in the next cycle. The
kgdb patch feels like it can make sense on its own...

-Doug
