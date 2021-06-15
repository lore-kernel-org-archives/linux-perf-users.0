Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4340C48BE8
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Jun 2021 17:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1F6610A2
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Jun 2021 17:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhFOSA1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Jun 2021 14:00:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:63575 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229981AbhFOSA0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Jun 2021 14:00:26 -0400
IronPort-SDR: KBlLT0qaWG7Hen/GhURBBzfiar+x3HOEBJYctebPdMD2ctpJicrIySZ5nbfms97mA+XtqI6CSc
 r5iWuHg5LLOQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="203021160"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="203021160"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 10:58:21 -0700
IronPort-SDR: /NWBIAGO6My8nHyPT2PCq4JegKFeeQF10gNYT09Fgl7o+A8upGQtsR7NncRmorl3F+zNiBJGmG
 10gW0/LhMtmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="553767173"
Received: from gupta-dev2.jf.intel.com (HELO gupta-dev2.localdomain) ([10.54.74.119])
  by orsmga004.jf.intel.com with ESMTP; 15 Jun 2021 10:58:20 -0700
Date:   Tue, 15 Jun 2021 10:58:35 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>,
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
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 0/3] TSX force abort
Message-ID: <20210615175835.gdtcxodvqjd2xwht@gupta-dev2.localdomain>
References: <cover.b592910a3829c87c83cf5605718c415c80c0c4a9.1623704845.git-series.pawan.kumar.gupta@linux.intel.com>
 <87pmwngpwo.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <87pmwngpwo.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 15.06.2021 16:31, Thomas Gleixner wrote:
>On Mon, Jun 14 2021 at 14:11, Pawan Gupta wrote:
>> v1->v2:
>> - Avoid Reading TSX_FORCE_ABORT MSR for detecting new microcode.
>> - In tsx_init() move force abort detection before cmdline parsing.
>> - Drop tsx=fake patch, not enough use cases to justify the patch.
>> - Rebase to v5.13-rc6.
>
>Aside of the "/* Network style" comment in 2/3 this looks good!
>
>Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Many thanks for the review Thomas, Boris, Tony and Andi.
