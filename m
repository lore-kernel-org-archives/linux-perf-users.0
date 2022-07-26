Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94124C43334
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jul 2022 10:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbiGZKX1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Jul 2022 06:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiGZKX1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 26 Jul 2022 06:23:27 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B1D2A404;
        Tue, 26 Jul 2022 03:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZyyMHLfPNBqn8b5XevXxfGsSWJJ8PaS0+qkVi+HN0QI=; b=v2dCzkOk27vIpvvmVSME49wkle
        Qxx5VLFmm98O/qFeL/t9e2FzIQiowmJ+qQQ8MczgE1/XM9yio3YjO+wUEZ8r6YLdaKYFLKMeFSsm0
        HO7lBFJZGc7cvG2YBZFKSIyfVeEWHkwtMZlMzoVoUH107FtcNbvAN7xI8MzE7sG00tf+hhQ6FVJtA
        bnn5wHl93DqKT0CGcPXuA6KzcqbNvYgQGJAdD5m9PcaDPRkGfmWQkApGTXxPdc1rA5QeLQppcRIIh
        eYdMbEVfW6ytoTzrMtyGnEKoGorQpO1yAKKTNDMAbAEUYqAgEDQH/S9AjkW3LygZrA7PBKKYBPkt3
        IjqYftuA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33568)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oGHi8-0003zX-5j; Tue, 26 Jul 2022 11:22:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oGHhz-00018l-Q6; Tue, 26 Jul 2022 11:22:35 +0100
Date:   Tue, 26 Jul 2022 11:22:35 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     ardb@kernel.org, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, arnd@arndb.de,
        linus.walleij@linaro.org, rostedt@goodmis.org,
        nick.hawkins@hpe.com, john@phrozen.org, mhiramat@kernel.org,
        ast@kernel.org, linyujun809@huawei.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/5] ARM: stacktrace: Avoid duplicate saving of exception
 PC value
Message-ID: <Yt/AawOdA8w24toW@shell.armlinux.org.uk>
References: <20220712021527.109921-1-lihuafei1@huawei.com>
 <20220712021527.109921-3-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712021527.109921-3-lihuafei1@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 12, 2022 at 10:15:24AM +0800, Li Huafei wrote:
> @@ -34,6 +37,9 @@ void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
>  		frame->kr_cur = NULL;
>  		frame->tsk = current;
>  #endif
> +#ifdef CONFIG_UNWINDER_FRAME_POINTER
> +		frame->ex_frame = in_entry_text(frame->pc) ? true : false;

in_entry_text() returns a bool, so there's no need for the ternary
operator. The same comment applies throughout this patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
