Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE23BECAAA1
	for <linux-perf-users@archiver.kernel.org>; Sun, 30 Oct 2022 16:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJ3Qyo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 30 Oct 2022 12:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3Qyn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 30 Oct 2022 12:54:43 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126FCF1A
        for <linux-perf-users@vger.kernel.org>; Sun, 30 Oct 2022 09:54:43 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1opBa3-0008Re-8k; Sun, 30 Oct 2022 17:54:39 +0100
Message-ID: <0d4c6064-4869-f841-0c46-399264474f94@leemhuis.info>
Date:   Sun, 30 Oct 2022 17:54:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Regression: starting powertop crashes my machine hard since
 838d9bb62d13 ("perf: Use sample_flags for raw_data") #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <6e7f32f2-5397-e0cf-4271-a9826d318996@leemhuis.info>
In-Reply-To: <6e7f32f2-5397-e0cf-4271-a9826d318996@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1667148883;0d62e90b;
X-HE-SMSGID: 1opBa3-0008Re-8k
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

[Note: this mail is primarily send for documentation purposes and/or for
regzbot, my Linux kernel regression tracking bot. That's why I removed
most or all folks from the list of recipients, but left any that looked
like a mailing lists. These mails usually contain '#forregzbot' in the
subject, to make them easy to spot and filter out.]

On 25.10.22 20:40, Thorsten Leemhuis wrote:
> Hi! Since 838d9bb62d13 ("perf: Use sample_flags for raw_data") starting
> powertop makes my machine crash hard: keyboard is dead, Sysrq does not
> work, and most of the time there is not even a error message on the
> screen; only once in maybe ~20 cases I got the line "kernel NULL pointer
> dereference, address: 0000000000000010", but nothing else.
>  
> #regzbot introduced 838d9bb62d13

#regzbot fixed-by: 4b66ff46f2e18
