Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FC1C4743C
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 15:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B87610C7
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 15:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFUPHO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:07:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:58513 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFUPHO (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 11:07:14 -0400
IronPort-SDR: B/JeFTeGLjkKljfiofzvWmj7D8Pqg1Mh2uq0zmnCQ2w0s+Bn07MQpagFKRZ+ZO03nNHYcwOByX
 Wd5amrHbUfEw==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="193998786"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="193998786"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 08:04:54 -0700
IronPort-SDR: vZ+04PrVbHVu1SiDnl29C5d8dcffnRutge9/QkMSvs5cUmUcxQKrAH4fZn1N+sszy3cJpiKkif
 6Esbb5ANcuTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486519153"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 08:04:51 -0700
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
Subject: [PATCH RFC 00/11] perf script: Add API for filtering via dynamically loaded shared object
Date:   Mon, 21 Jun 2021 18:05:03 +0300
Message-Id: <20210621150514.32159-1-adrian.hunter@intel.com>
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

There are 3 preparation patches.  The main patch is patch 4.

The other patches add more functionality, except for patch 6 which installs
the C API header file.


Adrian Hunter (11):
      perf script: Move filter_cpu() earlier
      perf script: Move filtering before scripting
      perf script: Share addr_al between functions
      perf script: Add API for filtering via dynamically loaded shared object
      perf script: Add dlfilter__filter_event_early()
      perf build: Install perf_dlfilter.h
      perf dlfilter: Add resolve_address() to perf_dlfilter_fns
      perf dlfilter: Add insn() to perf_dlfilter_fns
      perf dlfilter: Add srcline() to perf_dlfilter_fns
      perf dlfilter: Add attr() to perf_dlfilter_fns
      perf dlfilter: Add object_code() to perf_dlfilter_fns

 tools/perf/Documentation/perf-dlfilter.txt | 235 +++++++++++++++
 tools/perf/Documentation/perf-script.txt   |   7 +-
 tools/perf/Makefile.config                 |   3 +
 tools/perf/Makefile.perf                   |   4 +-
 tools/perf/builtin-script.c                |  93 ++++--
 tools/perf/util/Build                      |   1 +
 tools/perf/util/dlfilter.c                 | 469 +++++++++++++++++++++++++++++
 tools/perf/util/dlfilter.h                 |  91 ++++++
 tools/perf/util/perf_dlfilter.h            | 139 +++++++++
 9 files changed, 1015 insertions(+), 27 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-dlfilter.txt
 create mode 100644 tools/perf/util/dlfilter.c
 create mode 100644 tools/perf/util/dlfilter.h
 create mode 100644 tools/perf/util/perf_dlfilter.h


Regards
Adrian
