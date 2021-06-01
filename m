Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873C1C4708F
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 09:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3FE6138C
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 09:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhFAJTn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Jun 2021 05:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhFAJTn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Jun 2021 05:19:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8746DC061574;
        Tue,  1 Jun 2021 02:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5rmhQAIMRhc0/LXllKDO9MjTjuKbppvLAxt/fqIeNe0=; b=bP1CJz4s1PkNBLaGcX+yW6zHu/
        1XXqpeUi1pFJ0EhIDBh9vZT/LxvjJbWeut6it+HG1Ryxaugdn1PbwdYhctNtsD4068Vc+LBMIdO6r
        l/7VFWM/DF4rMUG3x2GD552/ujSDdEcCmkFG0H0wgMJehmEDhXUNtjgANz9frQyFzYshxfljS2HuU
        HfYKbYV8vHjIECJwueJKKTGv2jLJMbvqjIuy7pm9xjpSiknQmLlHgbzKYlon/ThFzaG1b80fbK3SO
        sLZZhS1e7UdMvvJDCPIM3qDhm4lzWxeWjjhIw3C8rpWRAvU+a2Cenn/trEKvjEb7Rybhq5sbBUUKQ
        qof1GGTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lo0Wr-002W26-SI; Tue, 01 Jun 2021 09:17:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3E8E30019C;
        Tue,  1 Jun 2021 11:17:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D72032011CA24; Tue,  1 Jun 2021 11:17:46 +0200 (CEST)
Date:   Tue, 1 Jun 2021 11:17:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf auxtrace: Optimize barriers with
 load-acquire and store-release
Message-ID: <YLX7OhK37QmfeOwu@hirez.programming.kicks-ass.net>
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <20210519140319.1673043-2-leo.yan@linaro.org>
 <20210531151049.GE9324@leoy-ThinkPad-X240s>
 <cc3810cd-5edc-26d3-9c77-8bb6479152c1@intel.com>
 <20210601063342.GB10026@leoy-ThinkPad-X240s>
 <71b0e395-0e20-fdd1-b105-0ca1706c8ed1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71b0e395-0e20-fdd1-b105-0ca1706c8ed1@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 01, 2021 at 12:07:31PM +0300, Adrian Hunter wrote:
> __sync_xxx_compare_and_swap is out-of-date now. This page:
> 
> https://gcc.gnu.org/onlinedocs/gcc/_005f_005fsync-Builtins.html#g_t_005f_005fsync-Builtins
> 
> recommends '__atomic' builtins instead.

perf doesn't seem to use that.

> Since atomics are needed only for the "compat" case (i.e. 32-bit perf with 64-bit kernel)
> you could try to find an elegant way to check for a 64-bit kernel, and avoid the atomics
> for a 32-bit perf with 32-bit kernel.

Most 32bit archs cannot do 64bit atomics. I suppose the only reason this
doesn't explode is because the aux stuff isn't supported on many
architectures?

