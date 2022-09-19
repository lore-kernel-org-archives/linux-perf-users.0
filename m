Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCEFC6FA82
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Sep 2022 11:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiISL0F (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Sep 2022 07:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiISLZu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Sep 2022 07:25:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B091C92A
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Sep 2022 04:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2/4M+3qLFOobrll3zhOYj1GCpIjtbHEhDJ/4tQIjL5g=; b=KZp3xRw0WuDPW2GIRjdjnYOHjp
        U5TAMn2cnj46U8ELJLGB6OkC8PgOzeGFvSHQdLDilhen9t7vIDOtoL7XdqE2tkvoINQyP6zkVIiTY
        56KuM8I9p9bXw3ZrrvZINTo8Sl9xodG862HNyDg1oHdTNAiUGqzGmoVdcp0w/xEZlZx4UvpsKwCh4
        LJs180LDs2vh23AKH9ZaLwAQ6oF5COvQK+p7NNSGmJHqgtpIzXIz+EZ40F4poFE+W7lEX0pvNwnGh
        a0LXL+3TrThvP9aQq7dFp/nU874lQ7nFzFSUnvldk5AG3JApnxW2wPfylWRbQj7cFbuUlpxFjohD9
        ZYfSp7pA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaEuC-004enf-A0; Mon, 19 Sep 2022 11:25:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28C20300342;
        Mon, 19 Sep 2022 13:25:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8C4E2B62EDA5; Mon, 19 Sep 2022 13:25:35 +0200 (CEST)
Date:   Mon, 19 Sep 2022 13:25:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, Elana.Copperman@mobileye.com
Subject: Re: [PATCH 1/2] perf/core: convert snprintf to scnprintf
Message-ID: <YyhRr5iqgvwG5Yat@hirez.programming.kicks-ass.net>
References: <YyZbFOmp9bW3B3s6@playground>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyZbFOmp9bW3B3s6@playground>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Sep 18, 2022 at 12:41:08AM +0100, Jules Irenge wrote:
> Coccinelle reports a warning
> 
> WARNING: use scnprintf or sprintf
> 
> Adding to that,
> there has also been some slow migration from snprintf to scnprintf
> The article explains the rationale for this change
> 
> https: //lwn.net/Articles/69419/

Please but at least a bare minimum of justification in the Changelog
itself. I can't be arsed to wade through the interweb in order to figure
out if this patch has merit or is just whitespace wankery.
