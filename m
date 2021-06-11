Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF6BC48BD1
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 21:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882C1613CC
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 21:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhFKVdV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Jun 2021 17:33:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:12921 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhFKVdV (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Jun 2021 17:33:21 -0400
IronPort-SDR: XU/5NqtnvivbSXRPlqEgYCigli5GgRc/bhSSx0NpSuxIeeMze42dLaTtoi1uvf12R0mw42e66Q
 bJFJlcwjB89w==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="205433117"
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="205433117"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 14:31:21 -0700
IronPort-SDR: qYaDt4miFhmPz+227d6FoxbgaUH3brrBV7XvB5DJaP/u4G7HgdDHiM3d47awuR09r/hzadm1aw
 nZnwKNsY9+2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="553535554"
Received: from gupta-dev2.jf.intel.com (HELO gupta-dev2.localdomain) ([10.54.74.119])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jun 2021 14:31:18 -0700
Date:   Fri, 11 Jun 2021 14:31:29 -0700
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
Subject: Re: [PATCH 1/4] x86/msr: Define new bits in TSX_FORCE_ABORT MSR
Message-ID: <20210611213129.py2jyfzy37czegkm@gupta-dev2.localdomain>
References: <cover.2d906c322f72ec1420955136ebaa7a4c5073917c.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <4a258368e1797d592d4b16f124bd88cf9c21ac35.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <YMMhTwR7lJvA/9nu@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YMMhTwR7lJvA/9nu@zn.tnic>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11.06.2021 10:39, Borislav Petkov wrote:
>On Wed, Jun 09, 2021 at 01:58:02PM -0700, Pawan Gupta wrote:
>> Intel client processors that support IA32_TSX_FORCE_ABORT MSR related to
>> perf counter interaction [1] received a microcode update that deprecates
>> Transactional Synchronization Extension (TSX) feature. MSR
>> IA32_TSX_FORCE_ABORT bit FORCE_ABORT_RTM now defaults to 1, writes to
>> this bit are ignored. A new bit TSX_CPUID_CLEAR clears the TSX related
>> CPUID bits.
>>
>> Below is the summary of changes to IA32_TSX_FORCE_ABORT MSR:
>>
>>   Bit 0: FORCE_ABORT_RTM (legacy bit, new default=1) Status bit that
>>   indicates if RTM transactions are always aborted. This bit is
>>   essentially !SDV_ENABLE_RTM(Bit 2). Writes to this bit are ignored.
>>
>>   Bit 1: TSX_CPUID_CLEAR (new bit, default=0) When set, CPUID.HLE = 0
>>   and CPUID.RTM = 0.
>>
>>   Bit 2: SDV_ENABLE_RTM (new bit, default=0) When clear, XBEGIN will
>>   always abort with EAX code 0. When set, XBEGIN will not be forced to
>>   abort (but will always abort in SGX enclaves). This bit is intended to
>>   be SDV-only. If this bit is set transactional atomicity correctness is
>
>SDV?

Sorry should have expanded this. It stands for Software Development
Vehicle (SDV), i.e. developer systems.

>>   not certain.
>>
>> Performance monitoring counter 3 is usable in all cases, regardless of
>> the value of above bits.
>>
>> A new CPUID bit CPUID.RTM_ALWAYS_ABORT (CPUID 7.EDX[11]) is added to
>> indicate the status of always abort behavior.
>>
>> Define these new CPUID and MSR bits.
>>
>> [1] Performance Monitoring Impact of Intel® Transactional Synchronization Extension Memory
>>     http://cdrdv2.intel.com/v1/dl/getContent/604224
>
>That link does not look stable enough to put in commit messages.
>Besides, you've said it all in the commit message already.

The important part is the Document ID 604224. I can remove the link
completely, or add the document ID to it, whatever you suggest:

	[1] Performance Monitoring Impact of Intel® Transactional Synchronization Extension Memory
	    http://cdrdv2.intel.com/v1/dl/getContent/604224 (Document ID 604224).
							     ^^^^^^^^^^^^^^^^^^

Thanks,
Pawan
