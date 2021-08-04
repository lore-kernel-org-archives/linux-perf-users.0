Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2183C4338F
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 13:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA0960F35
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 13:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbhHDNEB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 09:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbhHDND7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Aug 2021 09:03:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA04C0613D5;
        Wed,  4 Aug 2021 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nkb/72Yala+eTU54cegs5bW6fYqKpGJitAnXLiCjS1E=; b=C1/IsNAKPp/DB65EqmxyI4aBBT
        M7p7NiRZnGd9uXsgKe1CSlz08nIJeVgsxB0+cJc08sSjlHfApTWm/LSKPLup0K9oxIoOcYyao7GbB
        85w1Db3cM+aTydWkrVQcJoTdN+Zh/4aZf6UEddcs/tMZFCfC4FfC5JcaOuh03Y5Huah7CJQQNRw4L
        MffjRLZj5cginhSHRkJSBPl8KDVOQ5xDf4LGe7BH7M6lUtWc+aMT+dxPgrlnYGEeJkSo63MLT1k+C
        UXEsTPep0KFCXWV4alpJFh3wHpGgmcliFTsk5CnSKlmIm4J7QmWiwzMMA331mEfHx9sAzwgZX9k9V
        a0bH7gfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBGXc-005rRv-Pe; Wed, 04 Aug 2021 13:02:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF6F89862B0; Wed,  4 Aug 2021 15:02:34 +0200 (CEST)
Date:   Wed, 4 Aug 2021 15:02:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Liam Merwick <Liam.Merwick@oracle.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/x86/amd: Don't touch the AMD64_EVENTSEL_HOSTONLY
 bit inside the guest
Message-ID: <20210804130234.GE8057@worktop.programming.kicks-ass.net>
References: <20210802070850.35295-1-likexu@tencent.com>
 <20210804112854.lmizhfddz3qgli7t@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804112854.lmizhfddz3qgli7t@oracle.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 04, 2021 at 12:28:54PM +0100, Liam Merwick wrote:
> On (08/02/21 15:08), Like Xu wrote:

> > From: Like Xu <likexu@tencent.com>
> > 
> > If we use "perf record" in an AMD Milan guest, dmesg reports a #GP
> > warning from an unchecked MSR access error on MSR_F15H_PERF_CTLx:
> > 
> > [] unchecked MSR access error: WRMSR to 0xc0010200 (tried to write
> > 0x0000020000110076) at rIP: 0xffffffff8106ddb4 (native_write_msr+0x4/0x20)
> > [] Call Trace:
> > []  amd_pmu_disable_event+0x22/0x90
> > []  x86_pmu_stop+0x4c/0xa0
> > []  x86_pmu_del+0x3a/0x140
> > 
> > The AMD64_EVENTSEL_HOSTONLY bit is defined and used on the host,
> > while the guest perf driver should avoid such use.
> > 
> > Fixes: 1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM disabled")
> > Signed-off-by: Like Xu <likexu@tencent.com>
> > Tested-by: Kim Phillips <kim.phillips@amd.com>
> 
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> Tested-by: Liam Merwick <liam.merwick@oracle.com>
> [ Patch applied to a 5.4 branch ]
> 
> Should it also include
> 
> Cc: stable@vger.kernel.org

An accurate Fixes tag is usually sufficient to trigger the stable
robots. Anyway, thanks!
