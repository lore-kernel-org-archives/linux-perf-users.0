Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D524EC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  7 Sep 2021 16:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB60860F13
	for <linux-perf-users@archiver.kernel.org>; Tue,  7 Sep 2021 16:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbhIGQm1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Sep 2021 12:42:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:27264 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231347AbhIGQm0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Sep 2021 12:42:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="283959445"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="283959445"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 09:38:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="430979243"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2021 09:38:36 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/3] perf intel-pt: Add PEBS-via-PT side-band
Date:   Tue,  7 Sep 2021 19:39:00 +0300
Message-Id: <20210907163903.11820-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi

PEBS output to Intel Processor Trace was introduced with Atom
processors based on Tremont.  Currently there is software support
only for a single PEBS-via-PT event.

Here is support for multiple PEBS-via-PT events.

The first patch is the kernel change which adds a new event,
namely PERF_RECORD_AUX_OUTPUT_HW_ID which contains the counter
index.  That is output when the PEBS-via-PT event is enabled in hardware.
There is an optimization, to report the index only when it changes
for the event.  That will work only so long as all PEBS-via-PT
events are scheduled together, which they are for a recording
session because they are in a single group.

Also no attribute bit is used to select the new event, so a new
kernel is not compatible with older perf tools.  The assumption
being that PEBS-via-PT is sufficiently esoteric that users will not
be troubled by this.

The second patch adds the usual boiler plate to perf tools for
a new event.

The third patch adds support for processing the new event by
perf tool's Intel PT decoder.


Changes in V3:
    perf/x86: Add new event for AUX output counter index
	Do not set assign callback unless x86_pmu.intel_cap.pebs_output_pt_available

Changes in V2:
    perf/x86: Add new event for AUX output counter index
	Use callback from x86_assign_hw_event


Adrian Hunter (3):
      perf/x86: Add new event for AUX output counter index
      perf tools: Add support for PERF_RECORD_AUX_OUTPUT_HW_ID
      perf intel-pt: Add support for PERF_RECORD_AUX_OUTPUT_HW_ID

 arch/x86/events/core.c                     |  6 +++
 arch/x86/events/intel/core.c               | 16 ++++++
 arch/x86/events/perf_event.h               |  1 +
 include/linux/perf_event.h                 |  1 +
 include/uapi/linux/perf_event.h            | 15 ++++++
 kernel/events/core.c                       | 30 +++++++++++
 tools/include/uapi/linux/perf_event.h      | 15 ++++++
 tools/lib/perf/include/perf/event.h        |  6 +++
 tools/perf/Documentation/perf-intel-pt.txt |  7 ++-
 tools/perf/builtin-inject.c                |  4 +-
 tools/perf/builtin-record.c                |  2 +-
 tools/perf/util/event.c                    | 18 +++++++
 tools/perf/util/event.h                    |  5 ++
 tools/perf/util/intel-pt.c                 | 85 ++++++++++++++++++++++++++++--
 tools/perf/util/machine.c                  | 10 ++++
 tools/perf/util/machine.h                  |  2 +
 tools/perf/util/session.c                  |  5 ++
 tools/perf/util/tool.h                     |  1 +
 18 files changed, 222 insertions(+), 7 deletions(-)


Regards
Adrian
