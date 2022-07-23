Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39A0C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 23 Jul 2022 19:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiGWThL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 23 Jul 2022 15:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGWThL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 23 Jul 2022 15:37:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306CF1E3D0
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Jul 2022 12:37:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s206so7011067pgs.3
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Jul 2022 12:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gP+iBR7WXlHtlXgikNeHGXtetxlMVRk/TwPfC8XPb5Y=;
        b=Y41ejNJSsGAs536uT60pgny69S+MyF7clKEjkbGDFue+58jfXTebctTfV40VGGtqWz
         LKf1Q+L77pgYamTLVaxuIgsPRJohUvjsqu/lIi2iLQ7nS9yvOMGlB2tHG3oOrygHIwyc
         m0WBrtfYs3b6Ji6yGYEblztj6WCZAefrpjEKoGlezyygk9sYXjwoW2FSUP6mgtz28wB2
         tjzzwfrPcJAd6bqbr7rt29jbsMEbMDQa2DS619/XhFRxxrbWzLzwUPuWRbAfrjJfSLE1
         Ucm4lErnmHz1LUkXPpQMSv+c9bRKDw1eTFelAb6e50OQpQTHdjlNUgQMa7KHEEP6a+kJ
         kEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gP+iBR7WXlHtlXgikNeHGXtetxlMVRk/TwPfC8XPb5Y=;
        b=Igq1hCjFX0yEB/cTQL6LKTn+RHWunD/OiRZIaDbWZPZFfr5o2yzbIFmZdcV2DblGfJ
         GZVfmvJglUnt/r7g/6j6AtmwWoZCOHiVBJowt+DCHg5xEsnO7m7yioHGtQT1juTefDIb
         aOr1jclOCSqNrxchSFi3bf3jh6yMeGEdH/EeqU1WxggWY8TusNlgky8BuMin795BiQUb
         YP7dpTbMC1yFGIKDwnQsHPdJcY2FsTbxI8a6NwpGIelwKBsjMuioBULYIoBK1jACsMyA
         +a+LNHx+8yP9NuP5ZjotEJNRTHGt+A4gTtDtHr8/xUUk74ek5y+liGWjOOUWAnUJOaoC
         etQw==
X-Gm-Message-State: AJIora+cPt6C7+8m2n3/96dIlAiFoy2wkhGXEIpfE1zeE3z/G0SRspzd
        VC8I0IcbceN/z5CGjg1+D/pa8PqXisC0BBOOvHc3MoayAxI=
X-Google-Smtp-Source: AGRyM1tPUZBNVRg0aYBySrzgYtMEdJQ8ttz8DL/xfPb/SwqkAfn+xWQ84h4NcLTkQ2YwI1uKc9MwiVpsO9GP6Eb669M=
X-Received: by 2002:a05:6a00:1812:b0:52a:c171:7cc5 with SMTP id
 y18-20020a056a00181200b0052ac1717cc5mr5583898pfa.81.1658605028303; Sat, 23
 Jul 2022 12:37:08 -0700 (PDT)
MIME-Version: 1.0
From:   Markus Stange <mstange.moz@gmail.com>
Date:   Sat, 23 Jul 2022 15:36:31 -0400
Message-ID: <CAL2j+_NtaO=sHpJPOyyKqY1d3T=E4PZiOwDvW5YRi7LB=01Jpg@mail.gmail.com>
Subject: USER_REGS inconsistency in the presence of PEBS - current status
To:     linux-perf-users@vger.kernel.org
Cc:     Milian Wolf <mail@milianw.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi all,

I'd like to follow up to a thread from 2018 titled "PEBS level 2/3
breaks dwarf unwinding! [WAS: Re: Broken dwarf unwinding - wrong stack
pointer register value?]"
https://lore.kernel.org/lkml/6310843.N4ooJGWzKY@agathebauer/T/

In that email thread, it was determined that the kernel will overwrite
the RIP value in the user registers with the "earlier value" from
PEBS, making it inconsistent with the other register values in
USER_REGS and also inconsistent with the USER_STACK memory.
This means that, any time the instruction pointer is near a push/pop
instruction, RIP and RSP are at the risk of being inconsistent with
each other. These inconsistencies break DWARF unwinding.
For example, if RIP points *before* a push instruction, and RSP has
the value *after* that push instruction, and the DWARF unwind rule for
RIP says "The return address is at the top of the stack" but RSP
already reflects the push, then the wrong return address is read.

There was a proposed patch in the referenced thread. Has something
like it been considered for inclusion in the kernel? Has any other
work on this issue happened since the discussion?

I ran into this problem today, with a perf.data file captured on a
system with a 5.15 kernel.

Markus
