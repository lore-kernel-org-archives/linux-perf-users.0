Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046F2C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Nov 2022 21:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiKBVY1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Nov 2022 17:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiKBVYZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Nov 2022 17:24:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008045589;
        Wed,  2 Nov 2022 14:24:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 999A961C35;
        Wed,  2 Nov 2022 21:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0236C433C1;
        Wed,  2 Nov 2022 21:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667424264;
        bh=UPPJwSNTnyLmzOsbFdZZkHNDvlO5sX3PxijtsFsBNj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rDqdSsm36TYRbIlu/qG/Q8fEFqijWfDhh8m1xeEY3EtSrpqE6R+Ix5Ihg1fb1Y+oU
         nyLdoYm2AnIDMouP419upczNgU4uqiCBDZoIIBdF62jSl1vEd/RpJibpOZb8KMNkIO
         tk71/5eXgR6dTIvFwAaxYQ1GBW5/mE6HNIrlyhuM=
Date:   Wed, 2 Nov 2022 22:25:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-perf-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Marco Elver <elver@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: qemu-i386: perf: BUG: kernel NULL pointer dereference, address:
 00000148
Message-ID: <Y2LgPWgHx77ld/k8@kroah.com>
References: <CA+G9fYsGFoC5TciCuijZXLx48TZnoTSkq=iUgb+vFdi9EYTucw@mail.gmail.com>
 <84f79a09-7cdb-d6cc-ef28-df5ac6b048e7@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84f79a09-7cdb-d6cc-ef28-df5ac6b048e7@leemhuis.info>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 02, 2022 at 03:24:22PM +0100, Thorsten Leemhuis wrote:
> [just writing this to CC the stable list and Greg, to make sure they are
> in the loop before 6.0.7 is released]
> 
> [/me wonders why that wasn't done and hopes there isn't a good reason
> why it wasn't done]

Yeah, that was odd, thanks for the heads up.

greg k-h
