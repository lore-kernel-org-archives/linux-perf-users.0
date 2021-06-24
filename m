Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA285C49EA7
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Jun 2021 07:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4C76100A
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Jun 2021 07:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhFXH1M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Jun 2021 03:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhFXH1L (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Jun 2021 03:27:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8EFC061574;
        Thu, 24 Jun 2021 00:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rQbfn9TBdWl2iF98I/1RqeTRSgzel5XcaOzVBzuMaig=; b=WODazNOEu+2VZoMeZLWkHyjW06
        7IWuwWFueTulkOi7RSxso+QvYmwac+ZpwRoc4POzTe2VgQH++cFYWLfddVnasrIoDBejdVhTlFF5b
        ZJ0c8tVxmn/nE22W14kFXP4t8mchEm2w8/aPukqhCnf+0s3RYpoBBdw233qO3fAFp34SKer4cP0Lm
        IHScGIQzu7ogYmqbwjPBAJCOK+0tmJ/qyaiAIh4oDeinIyp8yaidzBkQvXg0Wyw8vGbAXUclwjmWt
        JZMESokmoNcujjRvLJVGKd7v/lxpRP+WFpfZV1BLjsaSlnEuxyJm3/w63zdXqoNTvhE5Id4jlWpQt
        x4M0W6xA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwJih-00BA62-MM; Thu, 24 Jun 2021 07:24:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 562E330021A;
        Thu, 24 Jun 2021 09:24:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E76852C8CABB7; Thu, 24 Jun 2021 09:24:20 +0200 (CEST)
Date:   Thu, 24 Jun 2021 09:24:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     13145886936@163.com
Cc:     tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>,
        "Liang, Kan" <kan.liang@intel.com>
Subject: Re: [PATCH] x86: eas should not be NULL when it is referenced
Message-ID: <YNQzJIvBGnChxdou@hirez.programming.kicks-ass.net>
References: <20210624070442.34291-1-13145886936@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624070442.34291-1-13145886936@163.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 24, 2021 at 12:04:42AM -0700, 13145886936@163.com wrote:
> From: gushengxian <gushengxian@yulong.com>

Is ^^^ that you? That is, 13145886936@163.com is a bit of a dodgy email
address and i've no way of verifying you are the person responsible for
the patch.

Could you, if at all possible, please send patches from your yulong.com
account such that we have at least a coherent chain of custody?
