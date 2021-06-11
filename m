Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADE0C48BD1
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 21:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC8D5613CF
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 21:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFKVgf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Jun 2021 17:36:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:63739 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhFKVge (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Jun 2021 17:36:34 -0400
IronPort-SDR: UuOio6x+hh72cXzUSJw5tYZ06PCSpYyY5ssavtBlgN31OKFqJuw+XNG/yMjptU33fkm3WKYzWb
 8TBQFpbFUUPw==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="205576884"
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="205576884"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 14:34:32 -0700
IronPort-SDR: 0DendlUeQhbi8Q0nfmSXXTVKrie2o0Q+2Se7KasDXeQoSxlE3Lw9KnsV/evM1Tcd/NXiFBgVoQ
 CvkPJDIj6D/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="449241568"
Received: from gupta-dev2.jf.intel.com (HELO gupta-dev2.localdomain) ([10.54.74.119])
  by orsmga008.jf.intel.com with ESMTP; 11 Jun 2021 14:34:31 -0700
Date:   Fri, 11 Jun 2021 14:34:43 -0700
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
Subject: Re: [PATCH 2/4] perf/x86/intel: Do not deploy workaround when TSX is
 deprecated
Message-ID: <20210611213443.ira5gc65jlafz7pu@gupta-dev2.localdomain>
References: <cover.2d906c322f72ec1420955136ebaa7a4c5073917c.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <4926973a8b0b2ed78217add01b5c459a92f0d511.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <YMMVvq9ZZCu9zZom@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YMMVvq9ZZCu9zZom@zn.tnic>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11.06.2021 09:50, Borislav Petkov wrote:
>On Wed, Jun 09, 2021 at 02:12:38PM -0700, Pawan Gupta wrote:
>> Earlier workaround added by commit 400816f60c54 ("perf/x86/intel:
>> Implement support for TSX Force Abort") for perf counter interactions
>> [1] are not required on some client systems which received a microcode
>> update that deprecates TSX.
>>
>> Bypass the perf workaround when such microcode is enumerated.
>>
>> [1] Performance Monitoring Impact of Intel® Transactional Synchronization Extension Memory
>>     http://cdrdv2.intel.com/v1/dl/getContent/604224
>>
>> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
>> ---
>>  arch/x86/events/intel/core.c | 22 ++++++++++++++++++----
>>  1 file changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index e28892270c58..b5953e1e59a2 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -6016,10 +6016,24 @@ __init int intel_pmu_init(void)
>>  		intel_pmu_pebs_data_source_skl(pmem);
>>
>>  		if (boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
>> -			x86_pmu.flags |= PMU_FL_TFA;
>> -			x86_pmu.get_event_constraints = tfa_get_event_constraints;
>> -			x86_pmu.enable_all = intel_tfa_pmu_enable_all;
>> -			x86_pmu.commit_scheduling = intel_tfa_commit_scheduling;
>> +			u64 msr;
>> +
>> +			rdmsrl(MSR_TSX_FORCE_ABORT, msr);
>> +			/* Systems that enumerate CPUID.RTM_ALWAYS_ABORT or
>> +			 * support MSR_TSX_FORCE_ABORT[SDV_ENABLE_RTM] bit have
>> +			 * TSX deprecated by default. TSX force abort hooks are
>> +			 * not required on these systems.
>
>So if they're not required, why aren't you simply disabling the force
>abort "workaround" by clearing the feature flag?

Feature flag also enumerates MSR_TSX_FORCE_ABORT, which is still present
after the microcode update. Patch 3/4 in this series clears the TSX
CPUID bits using MSR_TSX_FORCE_ABORT. So we do need the feature flag 
X86_FEATURE_TSX_FORCE_ABORT.

>
>	if (boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
>		if (boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT))
>			setup_clear_cpu_cap(X86_FEATURE_TSX_FORCE_ABORT);
>	}
>
>so that it doesn't get enabled in the first place?

Feature flag is needed as explained above.

Thanks,
Pawan
