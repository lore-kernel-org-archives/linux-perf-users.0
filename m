Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63920C07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 16:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DCCE61175
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 16:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhGMQSI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 12:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbhGMQR7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 12:17:59 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85354C0613E9;
        Tue, 13 Jul 2021 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q/eu8LQT2hpk1URDpBZkAtrdVtG7nNICgG8FDDEwlX8=; b=du5ABygyhNq5lfgFowA8sGqV9
        YxJXZEMMydkugGrW9wOa4Mr9JJhGu5AA0pag7hl3s+dzRgbc7r1WFd2Kq/KsVP1JmiMSzvw/+PB8E
        buH9Co2fsg9Wf1z05QDE4HtasBW0r8RmFlDLAe3A8FVTylhG5o1OaMsMr5Wr8Vol1sT8wbpAPqqzg
        hfmRrawZpnWX4jMglSTuLzug5jDXYJNS5d/oLSG3aOS3bsezdiyCbOrzVrRQGJrL7s5zgbI4Ws2JJ
        ZH/QgIHt4YtNMXfKlcDXih3YnOqmIRAhhOOIIY92O4sCS5SdlOz/TPBmH0jfNML3cs1vPvhOYbYqt
        7rbQUnnew==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46058)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1m3L3W-0006I8-IL; Tue, 13 Jul 2021 17:14:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1m3L3R-0000Re-QV; Tue, 13 Jul 2021 17:14:41 +0100
Date:   Tue, 13 Jul 2021 17:14:41 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 11/11] perf auxtrace: Add
 compat_auxtrace_mmap__{read_head|write_tail}
Message-ID: <20210713161441.GK22278@shell.armlinux.org.uk>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-12-leo.yan@linaro.org>
 <20210712144410.GE22278@shell.armlinux.org.uk>
 <20210713154602.GD748506@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713154602.GD748506@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 13, 2021 at 11:46:02PM +0800, Leo Yan wrote:
> Hi Russell,
> 
> On Mon, Jul 12, 2021 at 03:44:11PM +0100, Russell King (Oracle) wrote:
> > On Sun, Jul 11, 2021 at 06:41:05PM +0800, Leo Yan wrote:
> > > When perf runs in compat mode (kernel in 64-bit mode and the perf is in
> > > 32-bit mode), the 64-bit value atomicity in the user space cannot be
> > > assured, E.g. on some architectures, the 64-bit value accessing is split
> > > into two instructions, one is for the low 32-bit word accessing and
> > > another is for the high 32-bit word.
> > 
> > Does this apply to 32-bit ARM code on aarch64? I would not have thought
> > it would, as the structure member is a __u64 and
> > compat_auxtrace_mmap__read_head() doesn't seem to be marking anything
> > as packed, so the compiler _should_ be able to use a LDRD instruction
> > to load the value.
> 
> I think essentially your question is relevant to the memory model.
> For 32-bit Arm application on aarch64, in the Armv8 architecture
> reference manual ARM DDI 0487F.c, chapter "E2.2.1
> Requirements for single-copy atomicity" describes:
> 
> "LDM, LDC, LDRD, STM, STC, STRD, PUSH, POP, RFE, SRS, VLDM, VLDR, VSTM,
> and VSTR instructions are executed as a sequence of word-aligned word
> accesses. Each 32-bit word access is guaranteed to be single-copy
> atomic. The architecture does not require subsequences of two or more
> word accesses from the sequence to be single-copy atomic."

... which is an interesting statement for ARMv7 code. DDI0406C says
similar but goes on to say:

   In an implementation that includes the Large Physical Address
   Extension, LDRD and STRD accesses to 64-bit aligned locations
   are 64-bit single-copy atomic as seen by translation table
   walks and accesses to translation tables.

then states that LPAE page tables must be stored in memory that such
page tables must be in memory that is capable of supporting 64-bit
single-copy atomic accesses.

In Linux, we assume all RAM that the kernel has access to can contain
page tables. So by implication, all RAM that the kernel has access to
and exposes to userspace must be 64-bit single-copy atomic (if not,
we have a rather serious bug.)

The remaining question is whether it would be sane for LDRD and STRD
to be single-copy atomic to translation table walkers but not to other
CPUs. Since Linux expects to be able to modify the page tables from
any CPU in the system, this requirement must hold, otherwise it's going
to be a really strangely designed system.

Therefore, I put it that for Linux to operate correctly on 32-bit Arm
CPUs with LPAE, LDRD and STRD must be 64-bit single-copy atomic
inspite of what the architecture reference documentation may allow.

Now, since we allow 32-bit ARM kernels to run under KVM on ARMv8, it
would be pretty silly if this was broken on aarch64 - it would mean
such a guest would have no way to atomically update the LPAE page
tables. We know that's not true, since we can run 32-bit kernels and
userspace just fine under aarch64.

I'd be interested to hear what Catalin and Will have to say on this,
but I suspect in practice, Arm systems that are running Linux with
LPAE (ARMv7+LPAE, ARMv8) will implement LDRD and STRD with 64-bit
single-copy atomic semantics.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
