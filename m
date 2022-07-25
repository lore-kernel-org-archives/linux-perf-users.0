Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2456C43334
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Jul 2022 11:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiGYLuk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Jul 2022 07:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiGYLuj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Jul 2022 07:50:39 -0400
X-Greylist: delayed 521 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Jul 2022 04:50:37 PDT
Received: from dd14210.kasserver.com (dd14210.kasserver.com [85.13.138.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE581383
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Jul 2022 04:50:37 -0700 (PDT)
Received: from agathemoarbauer.localnet (p54a1bbed.dip0.t-ipconnect.de [84.161.187.237])
        by dd14210.kasserver.com (Postfix) with ESMTPSA id 8C12B240044;
        Mon, 25 Jul 2022 13:41:53 +0200 (CEST)
From:   Milian Wolff <mail@milianw.de>
To:     linux-perf-users@vger.kernel.org,
        Markus Stange <mstange.moz@gmail.com>
Subject: Re: USER_REGS inconsistency in the presence of PEBS - current status
Date:   Mon, 25 Jul 2022 13:41:53 +0200
Message-ID: <12169462.O9o76ZdvQC@agathemoarbauer>
In-Reply-To: <CAL2j+_NtaO=sHpJPOyyKqY1d3T=E4PZiOwDvW5YRi7LB=01Jpg@mail.gmail.com>
References: <CAL2j+_NtaO=sHpJPOyyKqY1d3T=E4PZiOwDvW5YRi7LB=01Jpg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Bar: /
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Samstag, 23. Juli 2022 21:36:31 CEST Markus Stange wrote:
> Hi all,

Hey Markus!

> I'd like to follow up to a thread from 2018 titled "PEBS level 2/3
> breaks dwarf unwinding! [WAS: Re: Broken dwarf unwinding - wrong stack
> pointer register value?]"
> https://lore.kernel.org/lkml/6310843.N4ooJGWzKY@agathebauer/T/
> 
> In that email thread, it was determined that the kernel will overwrite
> the RIP value in the user registers with the "earlier value" from
> PEBS, making it inconsistent with the other register values in
> USER_REGS and also inconsistent with the USER_STACK memory.
> This means that, any time the instruction pointer is near a push/pop
> instruction, RIP and RSP are at the risk of being inconsistent with
> each other. These inconsistencies break DWARF unwinding.
> For example, if RIP points *before* a push instruction, and RSP has
> the value *after* that push instruction, and the DWARF unwind rule for
> RIP says "The return address is at the top of the stack" but RSP
> already reflects the push, then the wrong return address is read.
> 
> There was a proposed patch in the referenced thread. Has something
> like it been considered for inclusion in the kernel? Has any other
> work on this issue happened since the discussion?

I have not had any chance to further work on this feature. I fear others have 
not (knowingly) run into this and thus noone else saw the need to fix this 
issue. I for one would still very much welcome an improvement to this 
situation, as it regularly leads to broken backtraces in my profiling 
setups...

> I ran into this problem today, with a perf.data file captured on a
> system with a 5.15 kernel.

I don't think it's kernel specific, afair any kernel will exhibit the broken 
behavior when you use DWARF unwinding and PEBS.

Cheers

-- 
Milian Wolff
http://milianw.de


