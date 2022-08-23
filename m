Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3C5C32774
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Aug 2022 19:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiHWTn4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Aug 2022 15:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiHWTn0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Aug 2022 15:43:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0537D80026
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 11:44:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B6DDB82053
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 18:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF9BC433D6;
        Tue, 23 Aug 2022 18:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661280282;
        bh=T0uBLbCmH35SLZ3L6AYdGbqjDJhQzRw68V2UEAxY5bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IdQ97In7uxvpcU7ypcTniuPEAMoDBxRHhUe4ofUNKR2tXg4r2Xch+rFdnu7b4Hfc/
         2dPo6AWfnn6+lURVFBJ0/zuDaXq3DdM+KF2enyIYNqwm0QfaQPmFTCtN1BrXIqfpvp
         0+2Eq/VBzm8yx1qZT7a6zay5XCXIhPkvLIW9enRNnVyYTRy37ohCWpeOzKSV8wsO0v
         mRZQQcFTpPJoumKSh5lSIkej8PfnjSnjtxh/bGbNMTPfbLvwyoHxbRKZQl5zXjAVjz
         FOj3uXvEbmXu4jgXDpx7S0Gqt9p6+gMdGOzsdrKMCyphoxyopb7gpJ6TxxO1GQ/0w1
         VWFFN8gIhLfIw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C0D30404A1; Tue, 23 Aug 2022 15:44:40 -0300 (-03)
Date:   Tue, 23 Aug 2022 15:44:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org, zhengjun.xing@intel.com
Subject: Re: [PATCH] perf tools: Improve hybrid description in perf record
 manpage
Message-ID: <YwUgGMfO2I44e0it@kernel.org>
References: <20220818100127.249401-1-ak@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818100127.249401-1-ak@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Aug 18, 2022 at 03:01:27AM -0700, Andi Kleen escreveu:
> The Intel hybrid description is written in a different style than
> the rest of the perf record man page. There were some new command line
> options added after it which resulted in very strange section ordering.
> Move the hybrid include last.
> 
> Also the sub sections in the hybrid document don't fit the record
> manpage well (especially since it talks about all kinds of unrelated
> commands). I left this for now, but would be better to separate this
> properly in the different man pages.
> 
> It would be better to use sub sections for the other sections, but these
> don't seem to be supported in AsciiDoc?
> 
> Some of the examples are still misrendered in the manpage with an indented
> troff command, but I don't know how to fix that.
> 
> In any case it's now better than before.

Thanks, tested and applied.

- Arnaldo
