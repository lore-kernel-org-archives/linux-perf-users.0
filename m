Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842DDECAAD3
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Sep 2022 12:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiINMNq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Sep 2022 08:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiINMNp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Sep 2022 08:13:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629B22C13E;
        Wed, 14 Sep 2022 05:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W5j1Ml4/FGhqmMtCc95aFu4AVQsz1Mj8TqQkpBHoMxs=; b=WLJj4M0rV4tUTtnynNBIdEAd1U
        V3oKAsGc0iGaN1MleNa5z6efNVmmmsWL01bthSmyYxIXCmFRsPMo08m0aMDwjfpVIeJLNQ+AJD65j
        Om9Rr7vGAOAqXYUW00o/aj83DfLGc8Y5m4wRMnJOoPsyBuFIujgHBp/BBrwbZLgKxQgN5dvhClNIF
        iAApv+rNUMoovnStQEJIXg28oFxBWbf9BgZB3lAswMN2mfozEP7eWmW7TocGMl907sFf0+RJyf0PT
        InCig9B+9dr1mL0y1aHytN/33KpSXsSicc+uQ3kY7vLad0ZL82LXT96MofzZMIgWqKD3OW5iuzajx
        t6EZOb7w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYRGp-00CLtS-AT; Wed, 14 Sep 2022 12:13:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A559D3002AE;
        Wed, 14 Sep 2022 14:13:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E1F02B1255A4; Wed, 14 Sep 2022 14:13:34 +0200 (CEST)
Date:   Wed, 14 Sep 2022 14:13:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: next: possible circular locking dependency: perf vs printk
Message-ID: <YyHFbhDIvU++Q4Hh@hirez.programming.kicks-ass.net>
References: <YyGrVxN8HD9Bks0/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyGrVxN8HD9Bks0/@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 14, 2022 at 07:22:15PM +0900, Sergey Senozhatsky wrote:
> Hello folks,
> 
> The lockdep splat below is pretty interesting. If I understand it
> correctly:

Known thing; only happens because you trip a WARN, fix that, problem
goes away.


