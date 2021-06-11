Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B349EC48BE5
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 08:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B23F613C8
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 08:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFKIoB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Jun 2021 04:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFKIoB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Jun 2021 04:44:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686EDC061574;
        Fri, 11 Jun 2021 01:42:03 -0700 (PDT)
Received: from zn.tnic (p2e584d18.dip0.t-ipconnect.de [46.88.77.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A63F1EC03E4;
        Fri, 11 Jun 2021 10:42:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623400921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KIA7zFQYyGvC5dZzXAgcoJPNiKNE7axh8OV+krFMr4g=;
        b=lASDncwv5BRMRWuXZm8sTwFdFYF3XFYviH+HtiR9pj1KZNWRFvZjnmg2UXEDh/O8DSyJAg
        wKMNzDKgNGOzBdXIG07suvzNlZPGz+MqvtKFrsT2YE0/imU4a5PV0kDHXUVqmRQ0pj71hg
        EaGZVHvLGnJWCA6NvSdCy3cv4W6Ugts=
Date:   Fri, 11 Jun 2021 10:39:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tony Luck <tony.luck@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Victor Ding <victording@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Anand K Mistry <amistry@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/4] x86/msr: Define new bits in TSX_FORCE_ABORT MSR
Message-ID: <YMMhTwR7lJvA/9nu@zn.tnic>
References: <cover.2d906c322f72ec1420955136ebaa7a4c5073917c.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <4a258368e1797d592d4b16f124bd88cf9c21ac35.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a258368e1797d592d4b16f124bd88cf9c21ac35.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 09, 2021 at 01:58:02PM -0700, Pawan Gupta wrote:
> Intel client processors that support IA32_TSX_FORCE_ABORT MSR related to
> perf counter interaction [1] received a microcode update that deprecates
> Transactional Synchronization Extension (TSX) feature. MSR
> IA32_TSX_FORCE_ABORT bit FORCE_ABORT_RTM now defaults to 1, writes to
> this bit are ignored. A new bit TSX_CPUID_CLEAR clears the TSX related
> CPUID bits.
> 
> Below is the summary of changes to IA32_TSX_FORCE_ABORT MSR:
> 
>   Bit 0: FORCE_ABORT_RTM (legacy bit, new default=1) Status bit that
>   indicates if RTM transactions are always aborted. This bit is
>   essentially !SDV_ENABLE_RTM(Bit 2). Writes to this bit are ignored.
> 
>   Bit 1: TSX_CPUID_CLEAR (new bit, default=0) When set, CPUID.HLE = 0
>   and CPUID.RTM = 0.
> 
>   Bit 2: SDV_ENABLE_RTM (new bit, default=0) When clear, XBEGIN will
>   always abort with EAX code 0. When set, XBEGIN will not be forced to
>   abort (but will always abort in SGX enclaves). This bit is intended to
>   be SDV-only. If this bit is set transactional atomicity correctness is

SDV?

>   not certain.
> 
> Performance monitoring counter 3 is usable in all cases, regardless of
> the value of above bits.
> 
> A new CPUID bit CPUID.RTM_ALWAYS_ABORT (CPUID 7.EDX[11]) is added to
> indicate the status of always abort behavior.
> 
> Define these new CPUID and MSR bits.
> 
> [1] Performance Monitoring Impact of Intel® Transactional Synchronization Extension Memory
>     http://cdrdv2.intel.com/v1/dl/getContent/604224

That link does not look stable enough to put in commit messages.
Besides, you've said it all in the commit message already.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
