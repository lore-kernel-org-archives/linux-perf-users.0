Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0742C43334
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Jun 2022 11:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbiF0LBQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiF0LBP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Jun 2022 07:01:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7860B6470;
        Mon, 27 Jun 2022 04:01:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3302CB810A3;
        Mon, 27 Jun 2022 11:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5391C3411D;
        Mon, 27 Jun 2022 11:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656327672;
        bh=dnVo2kKU4XfL2p5JbW7BGQOVgWSy6yL9g0TtFxZ2uJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AOuDenptTw43xrEUM45YSwOY3l2Z1fhndBUy9ZoEFd/dGBAYgGa3Fwak2NmUv4VOG
         lprN6GaJghhxI+q0fwCIO+Ih1+XH3IsopttRnP05SwWVIPQPqQFeqr/cjG7gvUs10d
         198E9elLVuW2OCv24ftya9bTi4Ykchgv9MHsLUxWv9xp0fZ+2RvlFDje1iPuJFfFH0
         bKt2L2EAyj5TCGjEegZWLxZEtr5/2NkqzBPL1TL0mosGkgNrrzj85owf5HKD3wS/QL
         V91ir/tEEy3VVpUTyH2BItNhLruqJBbktbJByhsAv2laT40rCTxWoQCBwRWSZttkYu
         wrj9OQ/pzYGZw==
Date:   Mon, 27 Jun 2022 12:01:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/8] arm64/perf: Enable branch stack sampling
Message-ID: <20220627110105.GF22095@willie-the-truck>
References: <20220613100119.684673-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613100119.684673-1-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 13, 2022 at 03:31:11PM +0530, Anshuman Khandual wrote:
> This series enables perf branch stack sampling support on arm64 platform
> via a new arch feature called Branch Record Buffer Extension (BRBE). All
> relevant register definitions could be accessed here.
> 
> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
> 
> This series applies on v5.19-rc2 after the BRBE related perf ABI changes series
> (V6) that was posted earlier.
> 
> https://lore.kernel.org/linux-arm-kernel/20220610035101.424112-1-anshuman.khandual@arm.com/
> 
> Following issues remain inconclusive
> 
> - Jame's concerns regarding permission inadequacy related to perfmon_capable()
> - Jame's concerns regarding using perf_event_paranoid along with perfmon_capable()

afaict, the capability stuff remains unresolved with the SPE driver, so I'd
really like to see it fixed there first before we add more broken drivers.

https://lore.kernel.org/r/20220118100702.GB16547@willie-the-truck

Will
