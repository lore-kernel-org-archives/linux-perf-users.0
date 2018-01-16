From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC 0/5] per-event settings fixes
Date: Tue, 16 Jan 2018 11:24:33 -0300
Message-ID: <20180116142438.19520-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbeAPOYw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Jan 2018 09:24:52 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrick Brueckner <brueckner@linux.vnet.ibm.com>, Namhyung Kim <namhyung@kernel.org>, Noel Grandin <noelgrandin@gmail.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi guys,

	Jiri asked me to post this series, so here it is, please take a
look, I'd love to harvest your Reviewed-by/Tested-by/Acked-by,

- Arnaldo

Arnaldo Carvalho de Melo (5):
  perf callchain: Fix attr.sample_max_stack setting
  perf unwind: Do not look at globals
  perf trace: Setup DWARF callchains for non-syscall events when --max-stack is used
  perf trace: Allow overriding global --max-stack per event
  perf callchains: Ask for PERF_RECORD_MMAP for data mmaps for DWARF unwinding

 tools/perf/builtin-trace.c               | 19 ++++++++++++++++---
 tools/perf/util/evsel.c                  | 24 +++++++++++++++++-------
 tools/perf/util/unwind-libunwind-local.c |  9 ---------
 3 files changed, 33 insertions(+), 19 deletions(-)

-- 
2.14.3
