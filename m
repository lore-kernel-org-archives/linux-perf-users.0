Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55A4C48BE6
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Jun 2021 21:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B897F613AC
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Jun 2021 21:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhFNVNO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Jun 2021 17:13:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:25529 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233920AbhFNVNN (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Jun 2021 17:13:13 -0400
IronPort-SDR: 0AXDrIy49w2eJvugQexQoMvt0FyiGPjR/Ws7rEaXGBerGGUqZquKHC40P0Yb74fxAPkhFWlqO1
 KjYfiay9VmtA==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="205912953"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="205912953"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 14:11:08 -0700
IronPort-SDR: sAqXJHJZlKjI+aulJ9ns1ke13lR6LlBdA3eSWPXWSl9zh2sUb1QEyrH+uaS+L/hGeVaT1M9mIz
 tueBnYyRw8pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="451719735"
Received: from gupta-dev2.jf.intel.com (HELO gupta-dev2.localdomain) ([10.54.74.119])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jun 2021 14:11:07 -0700
Date:   Mon, 14 Jun 2021 14:11:21 -0700
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
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v2 0/3] TSX force abort
Message-ID: <cover.b592910a3829c87c83cf5605718c415c80c0c4a9.1623704845.git-series.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

v1->v2:
- Avoid Reading TSX_FORCE_ABORT MSR for detecting new microcode.
- In tsx_init() move force abort detection before cmdline parsing.
- Drop tsx=fake patch, not enough use cases to justify the patch.
- Rebase to v5.13-rc6.

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

Thanks,
Pawan

[1] Intel® TSX Memory and Performance Monitoring Update for Intel® Processors
    https://www.intel.com/content/www/us/en/support/articles/000059422/processors.html

[2] Performance Monitoring Impact of Intel® Transactional Synchronization Extension Memory
    http://cdrdv2.intel.com/v1/dl/getContent/604224 (Document ID 604224)

Pawan Gupta (3):
  x86/msr: Define new bits in TSX_FORCE_ABORT MSR
  perf/x86/intel: Do not deploy workaround when TSX is deprecated
  x86/tsx: Clear CPUID bits when TSX always force aborts

 arch/x86/events/intel/core.c       | 10 +++++++-
 arch/x86/include/asm/cpufeatures.h |  1 +-
 arch/x86/include/asm/msr-index.h   |  4 +++-
 arch/x86/kernel/cpu/cpu.h          |  2 ++-
 arch/x86/kernel/cpu/intel.c        |  4 ++-
 arch/x86/kernel/cpu/tsx.c          | 37 +++++++++++++++++++++++++++++--
 6 files changed, 54 insertions(+), 4 deletions(-)

base-commit: 009c9aa5be652675a06d5211e1640e02bbb1c33d
-- 
git-series 0.9.1

