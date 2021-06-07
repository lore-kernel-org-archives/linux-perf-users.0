Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE40C47082
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 15:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95754611BD
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 15:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFGPdU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Jun 2021 11:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhFGPdU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Jun 2021 11:33:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8ACC061766;
        Mon,  7 Jun 2021 08:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ur7ovxkpT6WgTOE/FPrwgd7n8NhtA8XJRJmI2FHX9v8=; b=Woe6gtrZI4BuLKjZlX/CDSZFT6
        0OXBzbGI16tD+IXpas52LDmmcFcHMatOZpIAe0y31Q+yPO9IXT1VkskPdo71aO7PBR8irTraDP/Cu
        MAfqJZgCh50585BjS3jZz7EoeZ/T3fptlJOmDO+fm8wKJBz8V5EzCt11JTAqHODN7Sro55+qj9FiG
        vwmP/BNn6u8xROeI/lZji66nl9/iyrtPM7VCQHrEr45lIitZC47UOtDyqcvCUbRLPyWdhvBzT3dj3
        VkbCH3MUVSf8uMxXltwLQAZVd+8you0HVpyekVJyYvtJeH5mDn9k870Ex0xdafGgVx90+1t3h/JNX
        vnq/eXOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lqHCO-00Fwab-7k; Mon, 07 Jun 2021 15:30:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD0E530018A;
        Mon,  7 Jun 2021 17:29:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC4512D6A7343; Mon,  7 Jun 2021 17:29:55 +0200 (CEST)
Date:   Mon, 7 Jun 2021 17:29:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/8] perf auxtrace: Change to use SMP memory barriers
Message-ID: <YL47cyfNBx5OIRNB@hirez.programming.kicks-ass.net>
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-6-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602103007.184993-6-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 02, 2021 at 06:30:04PM +0800, Leo Yan wrote:
> The kernel and the userspace tool can access the AUX ring buffer head
> and tail from different CPUs, thus SMP class of barriers are required
> on SMP system.
> 
> This patch changes to use SMP barriers to replace mb() and rmb()
> barriers.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
