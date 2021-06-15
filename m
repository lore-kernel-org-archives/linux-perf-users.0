Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25569C48BDF
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Jun 2021 14:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03CF961452
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Jun 2021 14:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFOOeA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhFOOd6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Jun 2021 10:33:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34907C061574;
        Tue, 15 Jun 2021 07:31:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623767511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rt3yFJiMu77ZYCwr1cccTLFnhODd3+YmwPn0lN+fbco=;
        b=NAyoQ1QtvCCaqhhmXRMFAPUMH+TEf5xI2QnJ0OeDz3lSjTwFhE70R++9hR8f24B1sNXxVt
        raVXGyMmLz5JIBLw0dze2JdU4ELf5aqd3b/eYVX9h3M41rN1uzmcasKhN819lUR+qBtFVV
        50bIRZccTDD3aFCgHtckIiMRvq2fxrZQbIDe+g/jLkoRg4/F6YnM6DaXrCLbbaMKZB0FVp
        Jbz2X9P+XjDSd1VZ/LCCIkSST/hrQz17Zsf1wGEeiC73jRoAJ43Sf2CUwVPqAm59UXyOO0
        NB8k8ValDD61+Tw7QZ7RZOJGKKuWweSFhfPHEFW3SIZRxw+cAoxqhwHjTgUzGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623767511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rt3yFJiMu77ZYCwr1cccTLFnhODd3+YmwPn0lN+fbco=;
        b=T5ypvlpHrwms/m3Dq1Gw/r3IgxZmlDqYCtV8CCblc6FjpwL8I+9p2rIgdW+sut4RipQWne
        dNspmvK+QJCJztBA==
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Anand K Mistry <amistry@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 0/3] TSX force abort
In-Reply-To: <cover.b592910a3829c87c83cf5605718c415c80c0c4a9.1623704845.git-series.pawan.kumar.gupta@linux.intel.com>
References: <cover.b592910a3829c87c83cf5605718c415c80c0c4a9.1623704845.git-series.pawan.kumar.gupta@linux.intel.com>
Date:   Tue, 15 Jun 2021 16:31:51 +0200
Message-ID: <87pmwngpwo.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 14 2021 at 14:11, Pawan Gupta wrote:
> v1->v2:
> - Avoid Reading TSX_FORCE_ABORT MSR for detecting new microcode.
> - In tsx_init() move force abort detection before cmdline parsing.
> - Drop tsx=fake patch, not enough use cases to justify the patch.
> - Rebase to v5.13-rc6.

Aside of the "/* Network style" comment in 2/3 this looks good!

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
