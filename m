Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E88C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Dec 2021 03:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhL2DrJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Dec 2021 22:47:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37304 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbhL2DrJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Dec 2021 22:47:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38E7AB81806
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 03:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71BCC36AEA;
        Wed, 29 Dec 2021 03:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640749626;
        bh=DhuMBa2+JL37Y0mjDM/VjSfJ20Hzyh5BnFk4SC4Z+C8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XIImZTBe8lh4Z7C/mX+9YVxI9x0c0NWIj0PAyq0FVnDDk2JpLzO5QGKyGKab7P/DX
         2w4gJdncbHkhdGA4AwI3L+mRpU2vrK6Yn2KJhIKkOeO501TKI2sbQn/CUaapwEb8T+
         vNQdfeisW8z9YAPW9ZeR7drBljzV3raG4Zc1kM267XwgKd5PnyH+5dRqO3OqW9748w
         f7wZElp2MhJtAfkvGbWMnMqp2Unp+/C+hosiM1mgZr2BEjtR1ki4CknT4YuTGVOBP1
         FU862o9/LaygmJO9w1TiY/KDZ5Cx8AKPaAjRgzPMJsXCqpAZGuiJMJxCMsoPv8AjlE
         q6z9WpOD+2xSg==
Subject: Re: [PATCH] arc: perf: Move static structs to where they're really
 used
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     linux-perf-users@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mischa Jonker <Mischa.Jonker@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
References: <20211129203707.28510-1-abrodkin@synopsys.com>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <23a16eb8-ccbe-e000-53a4-0b0dc2ffb1ad@kernel.org>
Date:   Tue, 28 Dec 2021 19:47:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129203707.28510-1-abrodkin@synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11/29/21 12:37 PM, Alexey Brodkin wrote:
> It is all well described by Stephen Rothwell who initially spotted that:
> ----------------------------->8----------------------------
> After merging the origin tree, today's linux-next build (arc
> haps_hs_smp_defconfig+kselftest) produced these warnings:
>
> arch/arc/include/asm/perf_event.h:126:27: warning: 'arc_pmu_cache_map' defined but not used [-Wunused-const-variable=]
> arch/arc/include/asm/perf_event.h:91:27: warning: 'arc_pmu_ev_hw_map' defined but not used [-Wunused-const-variable=]
>
> Introduced by commit 0dd450fe13da ("ARC: Add perf support for ARC700 cores")
>
> The 2 static arrays should be moved into arch/arc/kernel/perf_event.c
> (the only place that uses them). We get the warning because perf_event.h
> is also included by arch/arc/kernel/unaligned.c.
> ----------------------------->8----------------------------
>
> Could be easily reproduced by running make with "W=1" on any up-to-date
> sources, when extra warnings get enabled (in particular
> "-Wunused-const-variable"), otherwise disabled by default in the top-level
> Makefile as "These warnings generated too much noise in a regular build".
>
> Signed-off-by: Alexey Brodkin<abrodkin@synopsys.com>
> Cc: Stephen Rothwell<sfr@canb.auug.org.au>
> Cc: Mischa Jonker<mjonker@synopsys.com>
> Cc: Vineet Gupta<vgupta@kernel.org>

Added to ARC tree.

Thx,
-Vineet
