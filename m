Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B857FC07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 18:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 936F6613AB
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 18:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhGMSQD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 14:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhGMSQD (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 14:16:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16A2361374;
        Tue, 13 Jul 2021 18:13:09 +0000 (UTC)
Date:   Tue, 13 Jul 2021 19:13:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <20210713181301.GE13181@arm.com>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-12-leo.yan@linaro.org>
 <20210712144410.GE22278@shell.armlinux.org.uk>
 <20210713154602.GD748506@leoy-ThinkPad-X240s>
 <20210713161441.GK22278@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713161441.GK22278@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 13, 2021 at 05:14:41PM +0100, Russell King wrote:
> On Tue, Jul 13, 2021 at 11:46:02PM +0800, Leo Yan wrote:
> > On Mon, Jul 12, 2021 at 03:44:11PM +0100, Russell King (Oracle) wrote:
> > > On Sun, Jul 11, 2021 at 06:41:05PM +0800, Leo Yan wrote:
> > > > When perf runs in compat mode (kernel in 64-bit mode and the perf is in
> > > > 32-bit mode), the 64-bit value atomicity in the user space cannot be
> > > > assured, E.g. on some architectures, the 64-bit value accessing is split
> > > > into two instructions, one is for the low 32-bit word accessing and
> > > > another is for the high 32-bit word.
> > > 
> > > Does this apply to 32-bit ARM code on aarch64? I would not have thought
> > > it would, as the structure member is a __u64 and
> > > compat_auxtrace_mmap__read_head() doesn't seem to be marking anything
> > > as packed, so the compiler _should_ be able to use a LDRD instruction
> > > to load the value.
> > 
> > I think essentially your question is relevant to the memory model.
> > For 32-bit Arm application on aarch64, in the Armv8 architecture
> > reference manual ARM DDI 0487F.c, chapter "E2.2.1
> > Requirements for single-copy atomicity" describes:
> > 
> > "LDM, LDC, LDRD, STM, STC, STRD, PUSH, POP, RFE, SRS, VLDM, VLDR, VSTM,
> > and VSTR instructions are executed as a sequence of word-aligned word
> > accesses. Each 32-bit word access is guaranteed to be single-copy
> > atomic. The architecture does not require subsequences of two or more
> > word accesses from the sequence to be single-copy atomic."
> 
> ... which is an interesting statement for ARMv7 code. DDI0406C says
> similar but goes on to say:
> 
>    In an implementation that includes the Large Physical Address
>    Extension, LDRD and STRD accesses to 64-bit aligned locations
>    are 64-bit single-copy atomic as seen by translation table
>    walks and accesses to translation tables.
> 
> then states that LPAE page tables must be stored in memory that such
> page tables must be in memory that is capable of supporting 64-bit
> single-copy atomic accesses.

A similar statement is in the ARMv8 ARM (E2.2.1 in version G.a).

> In Linux, we assume all RAM that the kernel has access to can contain
> page tables. So by implication, all RAM that the kernel has access to
> and exposes to userspace must be 64-bit single-copy atomic (if not,
> we have a rather serious bug.)

Indeed. We should assume that the SDRAM supports all the CPU features.

> The remaining question is whether it would be sane for LDRD and STRD
> to be single-copy atomic to translation table walkers but not to other
> CPUs. Since Linux expects to be able to modify the page tables from
> any CPU in the system, this requirement must hold, otherwise it's going
> to be a really strangely designed system.

The above statement does say "translation table walks and accesses to
translation tables". The accesses can be LDRD/STRD instructions from
other CPUs. Since the hardware can't tell whether the access is to a
page table, the designers just made LDRD/STRD single-copy atomic.

> I'd be interested to hear what Catalin and Will have to say on this,
> but I suspect in practice, Arm systems that are running Linux with
> LPAE (ARMv7+LPAE, ARMv8) will implement LDRD and STRD with 64-bit
> single-copy atomic semantics.

That's my understanding as well. In theory one could have a page table
access from EL0, so it should be atomic.

We could try to clarify E2.2.1 to simply state that naturally aligned
LDRD/STRD are single-copy atomic without any subsequent statement on the
translation table.

-- 
Catalin
