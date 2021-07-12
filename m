Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA44C07E99
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jul 2021 14:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F57F6115B
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jul 2021 14:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhGLOrp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jul 2021 10:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbhGLOro (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jul 2021 10:47:44 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26BDC0613DD;
        Mon, 12 Jul 2021 07:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EB6pq64nXJnPrEFCHroVUkFxPf+D61J6AzYGlTxsJok=; b=ksIprcA9uVFqqagxuFBNbkz/v
        TxgTlx34RX2TWQrp7WiIzCugWGX2kiTYR1pTPAPCX/AGj9hWIDgiZW+nlAY34IqmpRAe46iwBU5L+
        /72leq4Gsl/zQm3ePsqvJp8xvfapl++LvBmw4GhSHOh0b/pEQksj9tqc+fBHvTrNmLTidcv2Mtn3b
        TlwzSj0AjND4UG3dpm6BT+0mvbwQPu+xud6unscwCf9zTsc+q3vDkp9q1Xz8WkE3FjhDM9Y9Agpne
        HHGVxzbythLNAE65EyBM3WxuxVMKNK+E2591OKcxtBRjtNSqqG5wyDoU0RicN4dgkmFftIcg4xLcm
        UhUJ954SA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46018)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1m2xAN-0004ua-MH; Mon, 12 Jul 2021 15:44:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1m2xAJ-0007r6-1c; Mon, 12 Jul 2021 15:44:11 +0100
Date:   Mon, 12 Jul 2021 15:44:11 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Leo Yan <leo.yan@linaro.org>
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
Message-ID: <20210712144410.GE22278@shell.armlinux.org.uk>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-12-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210711104105.505728-12-leo.yan@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Jul 11, 2021 at 06:41:05PM +0800, Leo Yan wrote:
> When perf runs in compat mode (kernel in 64-bit mode and the perf is in
> 32-bit mode), the 64-bit value atomicity in the user space cannot be
> assured, E.g. on some architectures, the 64-bit value accessing is split
> into two instructions, one is for the low 32-bit word accessing and
> another is for the high 32-bit word.

Does this apply to 32-bit ARM code on aarch64? I would not have thought
it would, as the structure member is a __u64 and
compat_auxtrace_mmap__read_head() doesn't seem to be marking anything
as packed, so the compiler _should_ be able to use a LDRD instruction
to load the value.

Is this a problem noticed on non-ARM architectures?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
