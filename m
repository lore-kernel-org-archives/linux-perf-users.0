Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8D0C48BCD
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 20:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5297661040
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 20:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhFIU6u (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Jun 2021 16:58:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:12142 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhFIU6u (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Jun 2021 16:58:50 -0400
IronPort-SDR: HD3Zh19AtBXSCfafk4SypDMqumD5qWpFRTUMw60qd5qubDcrJbV7kjc4pmFiTdZKGsmgGV+t/i
 tWUYotAi0Bzw==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192277612"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="192277612"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 13:56:53 -0700
IronPort-SDR: Ffi2XUDy+iYMJrIzCWv3mR7Pf88GSUoUxDTgwJTrUJkmVMt/EUQ0FtaD449IZzOl9dDAD77lpU
 w003NYRufdsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="477075884"
Received: from gupta-dev2.jf.intel.com (HELO gupta-dev2.localdomain) ([10.54.74.119])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2021 13:56:52 -0700
Date:   Wed, 9 Jun 2021 13:57:01 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
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
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 0/4] TSX force abort
Message-ID: <cover.2d906c322f72ec1420955136ebaa7a4c5073917c.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Introduction
============
On some Intel processors [1] a microcode update will always abort
Transactional Synchronization Extensions (TSX) transactions by default. These
CPUs were previously affected by the TSX memory ordering issue [2]. A
workaround was earlier added to perf related to memory ordering which is no
longer required(because TSX is defeatured on these systems). This series adds
support for new bits added to TSX_FORCE_ABORT MSR and CPUID to enumerate new
abort behavior and to bypass the workaround.

Roadmap to this series
======================

0001:	Define new CPUID and MSR bits that are added by the microcode update.
	(The new CPUID.RTM_ALWAYS_ABORT is not shown in /proc/cpuinfo)

0002:	When new microcode is enumerated bypass perf counter workaround for [1].
	Perf workaround is no longer required after the microcode update.

0003:	Clear CPUID.RTM and CPUID.HLE when TSX is defeatured, so that software
	does not enumerate and try to use TSX.

0004:	Add tsx=fake cmdline option to not hide CPUID.RTM and CPUID.HLE. This
	may be desirable when resuming saved guest image that require RTM and HLE
	feature bits to be present.

Thanks,
Pawan

[1] Intel® TSX Memory and Performance Monitoring Update for Intel® Processors
    https://www.intel.com/content/www/us/en/support/articles/000059422/processors.html

[2] Performance Monitoring Impact of Intel® Transactional Synchronization Extension Memory
    http://cdrdv2.intel.com/v1/dl/getContent/604224

Pawan Gupta (4):
  x86/msr: Define new bits in TSX_FORCE_ABORT MSR
  perf/x86/intel: Do not deploy workaround when TSX is deprecated
  x86/tsx: Clear CPUID bits when TSX always force aborts
  x86/tsx: Add cmdline tsx=fake to not clear CPUID bits RTM and HLE

 Documentation/admin-guide/kernel-parameters.txt |  3 +-
 arch/x86/events/intel/core.c                    | 22 +++++++--
 arch/x86/include/asm/cpufeatures.h              |  1 +-
 arch/x86/include/asm/msr-index.h                |  4 ++-
 arch/x86/kernel/cpu/bugs.c                      |  5 +-
 arch/x86/kernel/cpu/cpu.h                       |  3 +-
 arch/x86/kernel/cpu/intel.c                     |  4 +-
 arch/x86/kernel/cpu/tsx.c                       | 44 ++++++++++++++++--
 8 files changed, 75 insertions(+), 11 deletions(-)

base-commit: 614124bea77e452aa6df7a8714e8bc820b489922
-- 
git-series 0.9.1

