Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F8FC48BC2
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3FE61C21
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhF0NU0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Jun 2021 09:20:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:60751 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229820AbhF0NU0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Jun 2021 09:20:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="195137035"
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="195137035"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 06:18:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="640588983"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2021 06:17:58 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 00/10] perf script: Add API for filtering via dynamically loaded shared object
Date:   Sun, 27 Jun 2021 16:18:08 +0300
Message-Id: <20210627131818.810-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi
 
In some cases, users want to filter very large amounts of data (e.g. from
AUX area tracing like Intel PT) looking for something specific. While
scripting such as Python can be used, Python is 10 to 20 times slower than
C. So define a C API so that custom filters can be written and loaded.

This is V2.

The main patch is patch 1.

The other patches add more functionality, except for patch 5 which installs
the C API header file.


Changes in V2:
    perf script: Move filter_cpu() earlier
    perf script: Move filtering before scripting
    perf script: Share addr_al between functions
	Dropped because they have now been applied.

    perf script: Add API for filtering via dynamically loaded shared object
	Move 2 members of struct perf_dlfilter_sample
	Add 'ctx' as an argument to 'start' and 'stop'
	Find dlfilter .so files in current directory or exec-path/dlfilters

    perf script: Add option to list dlfilters
	New patch

    perf script: Add option to pass arguments to dlfilters
	New patch


Adrian Hunter (10):
      perf script: Add API for filtering via dynamically loaded shared object
      perf script: Add dlfilter__filter_event_early()
      perf script: Add option to list dlfilters
      perf script: Add option to pass arguments to dlfilters
      perf build: Install perf_dlfilter.h
      perf dlfilter: Add resolve_address() to perf_dlfilter_fns
      perf dlfilter: Add insn() to perf_dlfilter_fns
      perf dlfilter: Add srcline() to perf_dlfilter_fns
      perf dlfilter: Add attr() to perf_dlfilter_fns
      perf dlfilter: Add object_code() to perf_dlfilter_fns

 tools/perf/Documentation/perf-dlfilter.txt | 251 ++++++++++++
 tools/perf/Documentation/perf-script.txt   |  15 +-
 tools/perf/Makefile.config                 |   3 +
 tools/perf/Makefile.perf                   |   4 +-
 tools/perf/builtin-script.c                |  86 +++-
 tools/perf/util/Build                      |   1 +
 tools/perf/util/dlfilter.c                 | 615 +++++++++++++++++++++++++++++
 tools/perf/util/dlfilter.h                 |  97 +++++
 tools/perf/util/perf_dlfilter.h            | 150 +++++++
 9 files changed, 1211 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-dlfilter.txt
 create mode 100644 tools/perf/util/dlfilter.c
 create mode 100644 tools/perf/util/dlfilter.h
 create mode 100644 tools/perf/util/perf_dlfilter.h


Regards
Adrian
