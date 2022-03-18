Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8699BC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Mar 2022 10:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbiCRKyQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Mar 2022 06:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiCRKyP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Mar 2022 06:54:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048E027CE28;
        Fri, 18 Mar 2022 03:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oLvSw2t5Gik7RrQqyucAdo114MkDAZy96gLyodSGUTg=; b=nqsWO4HqKoLcyKzEO6AGJpgjpQ
        2dSbDntUmrkIG5J7ZAxrFanDIdxMkpV0VBqkh84TO9gMPmCudQsIGdtH/9Rdvx4ekBPZKfGAkiMeN
        TS/7ga1DuldRRpyFLITPIRf1MvxrlpQkjKD3RrngVta7T4H++TIAqgppn/XK5iCs+8r/yzHzy0OVV
        FtMsikvtiwKoD6XtsOuoA7n85tVqloLm+xMgGLOJHC47bFwsffjyM5f3Mt57BNiDepjtBr9HXVW+b
        ha7jire4r0bcBGlI6Pg2LudHd9QdC4gJ84dD7Edzt+D+/I6uhxi8IPAhV/niaGKug1FEQmZWlGeym
        AcnRUZIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVADq-002BhC-5K; Fri, 18 Mar 2022 10:52:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C0303001C7;
        Fri, 18 Mar 2022 11:52:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DE902D35E974; Fri, 18 Mar 2022 11:52:41 +0100 (CET)
Date:   Fri, 18 Mar 2022 11:52:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, like.xu.linux@gmail.com,
        eranian@google.com, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH 5/7] perf/x86/amd/core: Add PerfMonV2 counter control
Message-ID: <YjRkeQ8C2CeMsUx6@hirez.programming.kicks-ass.net>
References: <cover.1647498015.git.sandipan.das@amd.com>
 <7958e729c6be0f682379bec81f115b8cd7cca1ad.1647498015.git.sandipan.das@amd.com>
 <YjMfe7KyKp+a3Jkp@hirez.programming.kicks-ass.net>
 <ea39ef1d-44a3-478d-f6fb-2120be67e745@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea39ef1d-44a3-478d-f6fb-2120be67e745@amd.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Mar 18, 2022 at 01:32:04PM +0530, Sandipan Das wrote:
> On 3/17/2022 5:16 PM, Peter Zijlstra wrote:

> > First and foremost, *please* tell me your shiny new hardware fixed the
> > terrible behaviour that requires the wait_on_overflow hacks in
> > amd_pmu_disable_all().
> 
> Unfortunately, that workaround is still required.

So much sadness :-(
