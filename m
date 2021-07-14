Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0377BC07E9A
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 08:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73DA6052B
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 08:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbhGNInw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 04:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbhGNInv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jul 2021 04:43:51 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F709C06175F;
        Wed, 14 Jul 2021 01:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HO9aj6B1WjYj8qsLsiziGZ5099hZ4tz+d5ON9qD4q5w=; b=d8cUJ5EJK8sII/t/B+2QPL1G/
        kxh260fNM8iyZQ1aLQNZFrMiCwROlnhMLFjMlUh27iZkJLHQNXi5N3vfbxJBLVhRRvAIB3mbAn8ZI
        7ZbwQCvsHvwXvjvOuHJuDEI3JAIeKoui08fdMyVBQWAi6nR8vpe+b/kPcN/oal67TYm+pEA83K+x8
        DqvV3rZXHwHXbRey4tU9Z626ywvTL1mLkS+1aYkot9wCferIwr+OxHWcemeWH0hVRmpPpBeDTSihU
        NhEYMUxgHKzNMv1MqDgEDMycwR6v9OyztoXXnhZ784qQaTjxHJ5P/yVkXydcW/i7GNCBHRuOSz5bA
        hnyL5T2xQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46084)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1m3aRT-000762-AL; Wed, 14 Jul 2021 09:40:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1m3aRD-00018I-Ky; Wed, 14 Jul 2021 09:40:15 +0100
Date:   Wed, 14 Jul 2021 09:40:15 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <20210714084015.GM22278@shell.armlinux.org.uk>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-12-leo.yan@linaro.org>
 <20210712144410.GE22278@shell.armlinux.org.uk>
 <20210713154602.GD748506@leoy-ThinkPad-X240s>
 <20210713161441.GK22278@shell.armlinux.org.uk>
 <20210713181301.GE13181@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713181301.GE13181@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 13, 2021 at 07:13:02PM +0100, Catalin Marinas wrote:
> We could try to clarify E2.2.1 to simply state that naturally aligned
> LDRD/STRD are single-copy atomic without any subsequent statement on the
> translation table.

I think that clarification would be most helpful. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
