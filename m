Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BF3C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 May 2022 13:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiEINMX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 May 2022 09:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbiEINMS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 May 2022 09:12:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203EA23F3A1;
        Mon,  9 May 2022 06:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0yNOraBv1neVOBjF4rkQmGA1UClv6oQqF7sKwICGE3I=; b=Z7V1jYDJDcZyxzkkJvsA6Rj/A7
        ZFep02+0m2gHdW8PQqrUQRCt9yzI5iYf4UsAOeD/NQVAsGXBAxj47alVWFjiTQQ4we618L0hmE2bf
        /iXZAcSyy4VPeAgQLDMSfiwvo10xAdBZklFk3FW1/eqH9RpfEfFCb0alyQROJh9Gsza4x8c/VQv67
        cKvuwwQXZW3McI2jZ39xAsTJw4G3XSudWOwFruL7RuoSFTl72KhSWDZQaf2eJEdKizCV3cAJiMc7R
        HrFIkAi2SVsxbx4XCO9+o+J46KFGR6bA9kyP5A7QeBjwKrnE1P4cM4aCWOJdGVmrNCnhNND71LGyy
        7SmbKzsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1no37K-003SfG-0r; Mon, 09 May 2022 13:08:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6940300385;
        Mon,  9 May 2022 15:07:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE4F42026963D; Mon,  9 May 2022 15:07:59 +0200 (CEST)
Date:   Mon, 9 May 2022 15:07:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, rrichter@amd.com, mingo@redhat.com,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, bp@alien8.de, irogers@google.com,
        yao.jin@linux.intel.com, james.clark@arm.com, leo.yan@linaro.org,
        kan.liang@linux.intel.com, ak@linux.intel.com, eranian@google.com,
        like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v2 3/8] perf/amd/ibs: Add support for L3 miss filtering
Message-ID: <YnkSL5QwwFxnWM/0@hirez.programming.kicks-ass.net>
References: <20220509044914.1473-1-ravi.bangoria@amd.com>
 <20220509044914.1473-4-ravi.bangoria@amd.com>
 <YnkDfRIRyztvXv6o@hirez.programming.kicks-ass.net>
 <d4486cd1-e4dc-3120-97ec-dad922bd8430@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4486cd1-e4dc-3120-97ec-dad922bd8430@amd.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 09, 2022 at 06:05:53PM +0530, Ravi Bangoria wrote:
> 
> On 09-May-22 5:35 PM, Peter Zijlstra wrote:
> > On Mon, May 09, 2022 at 10:19:09AM +0530, Ravi Bangoria wrote:
> >> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> >> index b06e4c573add..a24b637a6e1d 100644
> >> --- a/arch/x86/include/asm/perf_event.h
> >> +++ b/arch/x86/include/asm/perf_event.h
> >> @@ -391,6 +391,7 @@ struct pebs_xmm {
> >>  #define IBS_CAPS_OPBRNFUSE		(1U<<8)
> >>  #define IBS_CAPS_FETCHCTLEXTD		(1U<<9)
> >>  #define IBS_CAPS_OPDATA4		(1U<<10)
> >> +#define IBS_CAPS_ZEN4IBSEXTENSIONS	(1U<<11)
> >>  
> >>  #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
> >>  					 | IBS_CAPS_FETCHSAM	\
> > 
> > Would you mind terribly if I do:
> > 
> >   's/IBS_CAPS_ZEN4IBSEXTENSIONS/IBS_CAPS_ZEN4/'
> > 
> > on it? Per the IBS_ suffix, we're already talking about IBS, per the
> > CAPS thing we're talking about capabilities and I'm thinking that makes
> > EXTENTION somewhat redundant, which then leaves:
> > 
> >   IBS_CAPS_ZEN4
> 
> Yeah, IBS_CAPS_ZEN4 is better. Let me know if you want me to respin.

Nah, I just edited the patch, all good.
