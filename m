Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A57C83F2B
	for <linux-perf-users@archiver.kernel.org>; Thu, 31 Aug 2023 07:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbjHaHJG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 31 Aug 2023 03:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjHaHJF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 31 Aug 2023 03:09:05 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926EF1A3
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Aug 2023 00:09:02 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7a282340fdfso240245241.0
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Aug 2023 00:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693465741; x=1694070541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uVsSpAW1DhF2x13GYmGZSVYciWwIfeitaqqWOip6FM=;
        b=grs4hKTLTvDMYqXHu+Tld9XIj+7A+prixDx4Qc4pMZxHpMYuao9qojNkhLTcdPBioI
         1dN1TlBsatOoYx82tphqvRKcTjzboaRiDyKy3M+4m6zH1E76g336U1SrMsL9RprjQHMA
         sseLL4sZnRHhMpVDiA9YglUSOW+iSGapGkB1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693465741; x=1694070541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uVsSpAW1DhF2x13GYmGZSVYciWwIfeitaqqWOip6FM=;
        b=Ciqk+e7koXm6K3mRancwIDwahyssS+o0uapf3UVDkfs1AVT51h4YWBDUkF9yn6vtri
         /fzUrHdaPDk+hKLn+D6UP4iVlfVu+juX237/BNIzFTBrQ6zYGeeMAqgvx0XThPoBc8GA
         JRZs2me6NMcwh6OynG3PB4CePAlxRcEvDsxSrCgjgwav2e2vUsUVFruQxVtsA6TQpYqW
         vyS8mDc+Tk4e6MMEmqfZc5HwIfNc5fjhBJVenAf9Fj9U7ZAxOswjyO2t2SIwgxkc7Xhj
         VoU1DbjqTSBl79BHxW3Jweagq0ftqhMx8qC8o+EF4dlbfIdrURlXwF2eXDfzP4XE+9Dy
         0wWA==
X-Gm-Message-State: AOJu0YxuuWaWkSv428s2Bs7wmP79Ill3qO0NfLr1VEV3EQKGJ2mnTibE
        8Hwy26tDOh1CICs1wmceOI9asTlXamHyc4HW23JM9Q==
X-Google-Smtp-Source: AGHT+IEGICoo3PYQAQ8/OyXlu3ek+xLE7aA2b5GZ2G0bfXSYq1N8geqPNGhehlKWNKIzgzA5dbtIER5HUdWf1vEen7A=
X-Received: by 2002:a67:fe16:0:b0:44e:9ab0:ed1d with SMTP id
 l22-20020a67fe16000000b0044e9ab0ed1dmr4534623vsr.1.1693465741445; Thu, 31 Aug
 2023 00:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230830191314.1618136-1-dianders@chromium.org>
In-Reply-To: <20230830191314.1618136-1-dianders@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 31 Aug 2023 15:08:50 +0800
Message-ID: <CAGXv+5F4BLxj3Rum7ifaa51krRsd_yAcQUgPUpetf7doMbfRPw@mail.gmail.com>
Subject: Re: [PATCH v12 0/7] arm64: Add IPI for backtraces / kgdb; try to use
 NMI for some IPIs
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>, ito-yuichi@fujitsu.com,
        linux-perf-users@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 31, 2023 at 3:14=E2=80=AFAM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> This is an attempt to resurrect Sumit's old patch series [1] that
> allowed us to use the arm64 pseudo-NMI to get backtraces of CPUs and
> also to round up CPUs in kdb/kgdb. The last post from Sumit that I
> could find was v7, so I started my series at v8. I haven't copied all
> of his old changelongs here, but you can find them from the link.
>
> This patch series targets v6.6. Specifically it can't land in v6.5
> since it depends on commit 8d539b84f1e3 ("nmi_backtrace: allow
> excluding an arbitrary CPU").
>
> It should be noted that Mark still feels there might be some corner
> cases where pseudo-NMI is not production ready [2] [3], but as far as
> I'm aware there are no concrete/documented issues. Regardless of
> whether this should be enabled for production, though, this series
> will be invaluable to anyone trying to debug crashes on arm64
> machines.
>
> v12 of this series collects tags, fixes a few small nits in comments
> and commit messages from v11 and adds a new (and somewhat unrelated)
> small patch to the end of the series. There are no code changes other
> than the last patch, which is tiny.
>
> v11 of this series addressed Stephen Boyd's feedback on v10 and added
> a missing "static" that the patches robot found.
>
> v10 of this series attempted to address all of Mark's feedback on
> v9. As a quick summary:
> - It includes his patch to remove IPI_WAKEUP, freeing up an extra IPI.
> - It no longer combines the "kgdb" and "backtrace" IPIs. If we need
>   another IPI these could always be recombined later.
> - It promotes IPI_CPU_STOP and IPI_CPU_CRASH_STOP to NMI.
> - It puts nearly all the code directly in smp.c.
> - Several of the patches are squashed together.
> - Patch #6 ("kgdb: Provide a stub kgdb_nmicallback() if !CONFIG_KGDB")
>   was dropped from the series since it landed.
>
> Between v8 and v9, I had cleaned up this patch series by integrating
> the 10th patch from v8 [4] into the whole series. As part of this, I
> renamed the "NMI IPI" to the "debug IPI" since it could now be backed
> by a regular IPI in the case that pseudo NMIs weren't available. With
> the fallback, this allowed me to drop some extra patches from the
> series. This feels (to me) to be pretty clean and hopefully others
> agree. Any patch I touched significantly I removed Masayoshi and
> Chen-Yu's tags from.
>
> ...also in v8, I reorderd the patches a bit in a way that seemed a
> little cleaner to me.
>
> Since v7, I have:
> * Addressed the small amount of feedback that was there for v7.
> * Rebased.
> * Added a new patch that prevents us from spamming the logs with idle
>   tasks.
> * Added an extra patch to gracefully fall back to regular IPIs if
>   pseudo-NMIs aren't there.
>
> It can be noted that this patch series works very well with the recent
> "hardlockup" patches that have landed through Andrew Morton's tree and
> are currently in mainline. It works especially well with the "buddy"
> lockup detector.
>
> [1] https://lore.kernel.org/linux-arm-kernel/1604317487-14543-1-git-send-=
email-sumit.garg@linaro.org/
> [2] https://lore.kernel.org/lkml/ZFvGqD%2F%2Fpm%2FlZb+p@FVFF77S0Q05N.camb=
ridge.arm.com/
> [3] https://lore.kernel.org/lkml/ZNDKVP2m-iiZCz3v@FVFF77S0Q05N.cambridge.=
arm.com
> [4] https://lore.kernel.org/r/20230419155341.v8.10.Ic3659997d6243139d0522=
fc3afcdfd88d7a5f030@changeid/
>
> Changes in v12:
> - ("arm64: smp: Mark IPI globals as __ro_after_init") new for v12.
> - Added a comment about why we account for 16 SGIs when Linux uses 8.
> - Minor comment change to add "()" after nmi_trigger_cpumask_backtrace.
> - Updated the commit hash of the commit this depends on.
>
> Changes in v11:
> - Adjust comment about NR_IPI/MAX_IPI.
> - Don't use confusing "backed by" idiom in comment.
> - Made arm64_backtrace_ipi() static.
> - Updated commit message as per Stephen.
> - arch_send_wakeup_ipi() now takes an unsigned int.
>
> Changes in v10:
> - ("IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI") new for v10.
> - ("arm64: smp: Remove dedicated wakeup IPI") new for v10.
> - Backtrace now directly supported in smp.c
> - Don't allocate the cpumask on the stack; just iterate.
> - Moved kgdb calls to smp.c to avoid needing to export IPI info.
> - Rewrite as needed for 5.11+ as per Mark Rutland and Sumit.
> - Squash backtrace into patch adding support for pseudo-NMI IPIs.
> - kgdb now has its own IPI.
>
> Changes in v9:
> - Added comments that we might not be using NMI always.
> - Added to commit message that this doesn't catch all cases.
> - Fold in v8 patch #10 ("Fallback to a regular IPI if NMI isn't enabled")
> - Moved header file out of "include" since it didn't need to be there.
> - Remove arm64_supports_nmi()
> - Remove fallback for when debug IPI isn't available.
> - Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
> - arch_trigger_cpumask_backtrace() no longer returns bool
>
> Changes in v8:
> - "Tag the arm64 idle functions as __cpuidle" new for v8
> - Removed "#ifdef CONFIG_SMP" since arm64 is always SMP
> - debug_ipi_setup() and debug_ipi_teardown() no longer take cpu param
>
> Douglas Anderson (6):
>   irqchip/gic-v3: Enable support for SGIs to act as NMIs
>   arm64: idle: Tag the arm64 idle functions as __cpuidle
>   arm64: smp: Add arch support for backtrace using pseudo-NMI
>   arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI
>   arm64: kgdb: Implement kgdb_roundup_cpus() to enable pseudo-NMI
>     roundup
>   arm64: smp: Mark IPI globals as __ro_after_init
>
> Mark Rutland (1):
>   arm64: smp: Remove dedicated wakeup IPI

Whole series is

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on SolidRun i.MX8MM Hummingboard Pulse by injecting HARDLOCKUP with lkdtm.
