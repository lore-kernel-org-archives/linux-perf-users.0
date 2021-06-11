Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A03C48BE0
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 10:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46C4613DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 10:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhFKKLJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Jun 2021 06:11:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41444 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhFKKLJ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Jun 2021 06:11:09 -0400
Received: from zn.tnic (p2e584d18.dip0.t-ipconnect.de [46.88.77.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 182821EC0577;
        Fri, 11 Jun 2021 12:09:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623406150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=83KwCaOaC03vSpwN8QmjjUwowUHRgzJgsu/dfNEzFQE=;
        b=MYp1q3ELIAi/9Z8oRzVcy9Um2+tkC1Xi0Z6//GGtbyiaC9aMuj5nogGH2JUMm9upPLMZgS
        2ROVpFpU4s174McAQAeVxKjdENqLVo1pdbmXxFbntYJ/faPWkQj3kBJ/7d0cArV9d2VicJ
        +qAx2DsWc7apK2Yyr88XaX4NGGNo7Vo=
Date:   Fri, 11 Jun 2021 12:06:57 +0200
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
Subject: Re: [PATCH 4/4] x86/tsx: Add cmdline tsx=fake to not clear CPUID
 bits RTM and HLE
Message-ID: <YMM1wUjg/REXCkQQ@zn.tnic>
References: <cover.2d906c322f72ec1420955136ebaa7a4c5073917c.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <de6b97a567e273adff1f5268998692bad548aa10.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de6b97a567e273adff1f5268998692bad548aa10.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 09, 2021 at 02:14:39PM -0700, Pawan Gupta wrote:
> On CPUs that deprecated TSX, clearing the enumeration bits CPUID.RTM and
> CPUID.HLE may not be desirable in some corner cases. Like a saved guest
> would refuse to resume if it was saved before the microcode update
> that deprecated TSX.

That corner case needs a lot more justification. Otherwise this is just
silly.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
