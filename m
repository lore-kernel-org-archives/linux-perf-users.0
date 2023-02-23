Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D52CC61DA4
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Feb 2023 18:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjBWSrX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Feb 2023 13:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjBWSrP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Feb 2023 13:47:15 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB8915892
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Feb 2023 10:46:59 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g17so2216701lfv.4
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Feb 2023 10:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d84WjkOkqupHcw+FU5vzhrvdpAfWUWehoXECwf0pUzI=;
        b=qhm3hPm+oSJ4s1ShP0lapEUYR5IkwmhP+F+TJeQKrxZd+TPQYlMiwjnu0Bj10ztB0Y
         YVurYzUsyGsKrzwbqRkGwEmL9maWHZaHGOOA65qnrC6JLnKcGptkWpvgQMgseJZlUAH2
         iYEoFhf2x9kip/2gCIgUrrWz9EeWQvDPbx5zbpqbicLx2RZgcVWR5xKL1BQro2kthufd
         kXPaewWe4ha8b3ROmFmaN0PuS2+nM4kSds4IAapt12zwv+KDBqlfRMQJj64QvmhtF2nf
         c+ZepL+WBfUJtsnpJmB//rjxP68pXKk+MNswp83Ty3nkVa+jVVkAAnxXoFpnZycxev4B
         pYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d84WjkOkqupHcw+FU5vzhrvdpAfWUWehoXECwf0pUzI=;
        b=6uUnr2pZtfK18DfVcshGO8J3t1xyhV8Mw73FwZ4G8cWo24kKLJmspORyoOOuSu/+87
         TSo6NWIoLiQ4mwHNF+T3h7O7sIksZopXabtVwFTxLyHReoOtk87Th70GoJfrEQXs9IB1
         g8VsnOwRn3n63Ly2iOiG29XG7GDI8nH74B789i76KH0HGodyBpNrGexd3zAjM41cH8Wp
         aYFdHnxT3kgxvFEIaIcFb/VhSw5DAP0ZYn+CvFB4oJEWO2K6eQqdFvFR4gC16931Y922
         3X958vAMSJhUFMqTtwkAyB70hpqdWo+oE9iNPrjIt3VZIS5jdjaR0TP9QshFu01Z3DzV
         TiSg==
X-Gm-Message-State: AO0yUKVn877Tic7G0L0JFb2Z8iiYwWoGTk0Jk9s7WsE9snAuSybCVAVr
        WjlW+BRA7KvaPn6KLEncKyILuagGlUmARXWLWL7i4Q==
X-Google-Smtp-Source: AK7set9GVMhv/MFxdE4YCHJ+J6E6QpFq7wGeHK54sZrlaJUASkgEtczMsrA24TNPaRXTbFQJxd/Sez72HlZanbuvKhg=
X-Received: by 2002:ac2:5689:0:b0:4d5:ca42:aeed with SMTP id
 9-20020ac25689000000b004d5ca42aeedmr4072955lfr.13.1677178017989; Thu, 23 Feb
 2023 10:46:57 -0800 (PST)
MIME-Version: 1.0
References: <CAOnJCUKHq_8msJtU-H1JvWJ8nY94J0tcarQMBsPNpBZO8sP6HQ@mail.gmail.com>
 <Y/cjW8qVhRTPiz0t@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/cjW8qVhRTPiz0t@hirez.programming.kicks-ass.net>
From:   Beeman Strong <beeman@rivosinc.com>
Date:   Thu, 23 Feb 2023 10:46:46 -0800
Message-ID: <CAP55G9CmOai+L_5yhqAQT586sas5+zSc=NgeJZVa6U8WzQYf+Q@mail.gmail.com>
Subject: Re: Perf event to counter mapping question
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Trying again:
Hi Peter, thanks for the feedback.  Can you say more about AMD's
overlapping constraints?


On Thu, Feb 23, 2023 at 12:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 22, 2023 at 04:28:36PM -0800, Atish Patra wrote:
>
> > AFAIK, ARM64 allows all-to-all mapping in pmuv3[1]. That makes life
> > much easier. It just needs to pick the next available counter.
> > On the other hand, x86 allows selective counter mapping which is
> > discovered from the json file and maintained in per event
> > constraints[4].
>
> All the contraint management is done in kernel, and yes, it's a giant
> pain in the rear side.
>
> From what I understand the reason for these contraints is complexity of
> implementation, less constraints is more 'wires' in the hardware.
>
> With PMU use being ever more popular, we're seeing the x86 PMU move
> towards less constraints -- although I don't think we'll ever get rid of
> them :/
>
> > 2. Mandate all-to-all mapping similar to ARM64.
>
> If at all possible, I would strongly recommend taking this route. Yes,
> the hardware people will complain, but newer x86 hardware having less,
> or simpler, constraints might be sufficient to convince them.
>
> (and if you do have to do contraints, please take a lesson from x86 and
>  *never* allow overlapping contraints as AMD had, solving those
>  constraints is not fun)
>
> As you note, this is *much* simpler to program and virtualize.
>
> > Note: This is only for programmable counters. If the platform supports
> > any fixed counters (i.e. can monitor
> > only a specific event), that needs to be provisioned via some other
> > method. IIRC the fixed counters(apart from cycle) in ARM64 are part of
> > AMU not PMU.
>
> So free running counters are ideal and fairly simple to multiplex/use.
>
> The moment you start adding overflow interrupts / filters and any other
> complexities to fixed function counters it becomes a mess (look at the
> x86 PMU again).
