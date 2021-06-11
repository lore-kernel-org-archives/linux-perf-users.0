Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BBBC48BE5
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 21:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1C461073
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 21:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFKViL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Jun 2021 17:38:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:27455 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhFKViL (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Jun 2021 17:38:11 -0400
IronPort-SDR: PbHaIPB143Md79jpgXn4wjeIDpEeAFXCJbBIoSOzXSBy7YC4tHg7YdURs7aFbD+5PkA5f9hn8X
 WXI0UVfoi88A==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="291247153"
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="291247153"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 14:36:11 -0700
IronPort-SDR: zsFX5XOEZif7pTyxCjeyESd4H2QsYVWfy9GhY3tvFAKK8+7mYFQOT5W4OnQuTZDf5nrHhD+OGW
 vTT1p0spFkuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="449241880"
Received: from gupta-dev2.jf.intel.com (HELO gupta-dev2.localdomain) ([10.54.74.119])
  by orsmga008.jf.intel.com with ESMTP; 11 Jun 2021 14:36:11 -0700
Date:   Fri, 11 Jun 2021 14:36:22 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
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
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/4] x86/tsx: Clear CPUID bits when TSX always force
 aborts
Message-ID: <20210611213622.n3rlgzwe7c6q7lfu@gupta-dev2.localdomain>
References: <cover.2d906c322f72ec1420955136ebaa7a4c5073917c.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <aaf129dab23878913bf6f370894c336fc45388a2.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <YMM0/SARv62uo41r@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <YMM0/SARv62uo41r@zn.tnic>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11.06.2021 12:03, Borislav Petkov wrote:
>On Wed, Jun 09, 2021 at 02:13:38PM -0700, Pawan Gupta wrote:
>> @@ -114,6 +127,26 @@ void __init tsx_init(void)
>>  			tsx_ctrl_state = TSX_CTRL_ENABLE;
>>  	}
>>
>> +	/*
>> +	 * Hardware will always abort a TSX transaction if both CPUID bits
>> +	 * RTM_ALWAYS_ABORT and TSX_FORCE_ABORT are enumerated.  In this case it
>> +	 * is better not to enumerate CPUID.RTM and CPUID.HLE bits. Clear them
>> +	 * here.
>> +	 */
>> +	if (boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT) &&
>> +	    boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
>> +		tsx_ctrl_state = TSX_CTRL_RTM_ALWAYS_ABORT;
>> +		tsx_clear_cpuid();
>> +		setup_clear_cpu_cap(X86_FEATURE_RTM);
>> +		setup_clear_cpu_cap(X86_FEATURE_HLE);
>> +		return;
>> +	}
>
>Why isn't this happening as the first thing on entry in that tsx_init()
>function? IOW, there's no point to noodle through cmdline options etc if
>the hardware will always abort transactions.

Because the next patch is adding tsx=fake cmdline, for that this code
needs to be executed after cmdline parsing. I wanted to avoid the churn
to move this code between patches.

But, I see your comment for 4/4 i.e. tsx=fake may not be needed. It was
added after an internal test failure.

tsx=fake is really for a corner case and if that patch goes away it
would make sense to move the code in question here before cmdline
parsing.

Thanks,
Pawan
