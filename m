Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BC8C6FD18
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 Apr 2023 11:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjDYLUT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 Apr 2023 07:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjDYLUT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 Apr 2023 07:20:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DD8196;
        Tue, 25 Apr 2023 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WYHkmc6gK/GgjTHZCT7HG42OoUHKVnX5JUVMg0hbRso=; b=QfNLhB5DzekLEkai9G6ZF7BUOm
        rQv3+I3XgNSEw7nvwc9WNDionRYGlF9vk8vrQscnfDFJ2/K3Co8XBTPNqkc8s6sX6deOARg6TAYF8
        xq+8BWEsobA86UyX+9n4CW1Imth1Fb3xWkH+cEwG6/8jxULJA9y4kO9eeCQnagW8X+Fd7aDGKXzMo
        7A5AIoGuUfcKyPJC623/r0rGxC9eM+XI1hvcLkX0ezWwmPNApOp28NbbX9m+1u+2YTYybQovSoKyH
        ZsMRYRHUyJ86HM56eZkpjxyk3qNhCqrBte3jgepxUuoF0zICPQ+x3kE+3q+MaYn555wOk3rfopS7g
        uH9Yr3fA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1prGiE-001Ntn-2s; Tue, 25 Apr 2023 11:19:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3114C300380;
        Tue, 25 Apr 2023 13:19:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 09882241B9566; Tue, 25 Apr 2023 13:19:56 +0200 (CEST)
Date:   Tue, 25 Apr 2023 13:19:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     kan.liang@linux.intel.com, oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V4 2/2] perf/x86/intel/ds: Delay the threshold update
Message-ID: <20230425111955.GB1335080@hirez.programming.kicks-ass.net>
References: <20230421184529.3320912-2-kan.liang@linux.intel.com>
 <202304251457.d108dbb3-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202304251457.d108dbb3-yujie.liu@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Apr 25, 2023 at 03:16:29PM +0800, kernel test robot wrote:
> Hello,
> 
> kernel test robot noticed "Kernel_panic-not_syncing:Timeout:Not_all_CPUs_entered_broadcast_exception_handler" on:
> 
> commit: a17c97370d1fb9b2eac75c85136a1f70ec44eded ("[PATCH V4 2/2] perf/x86/intel/ds: Delay the threshold update")
> url: https://github.com/intel-lab-lkp/linux/commits/kan-liang-linux-intel-com/perf-x86-intel-ds-Delay-the-threshold-update/20230422-024743
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 15def34e2635ab7e0e96f1bc32e1b69609f14942
> patch link: https://lore.kernel.org/all/20230421184529.3320912-2-kan.liang@linux.intel.com/
> patch subject: [PATCH V4 2/2] perf/x86/intel/ds: Delay the threshold update
> 

> [  224.064675][   C84] mce: CPUs not responding to MCE broadcast (may include false positives): 0-83,85-223
> [  224.064681][   C84] Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler
> [  225.089881][   C84] Shutting down cpus with NMI
> [  225.129381][   C84] Kernel Offset: disabled

That seems very unrelated to the patch at hand; was this bisect double
checked?
