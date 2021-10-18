Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1875C4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Oct 2021 13:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA271608FB
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Oct 2021 13:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhJRNxJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Oct 2021 09:53:09 -0400
Received: from foss.arm.com ([217.140.110.172]:38312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233098AbhJRNvD (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Oct 2021 09:51:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6A5A101E;
        Mon, 18 Oct 2021 06:48:51 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.27.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 43F4B3F73D;
        Mon, 18 Oct 2021 06:48:50 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     denik@chromium.org, James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] perf inject: Add vmlinux and ignore-vmlinux arguments
Date:   Mon, 18 Oct 2021 14:48:40 +0100
Message-Id: <20211018134844.2627174-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Perf inject was missing the --vmlinux argument so I've added it. At
the same time I tidied up the argument checking that already existed in
perf report and applied it to all tools.

What I'm not sure about is whether it would have been better
to check the accessibility of these files further down in a common place?
It seems like vmlinux_name is also used for a non user provided name at
some point so maybe this would be more complicated than just applying the
existing check everywhere.

Thanks
James

James Clark (3):
  perf tools: Refactor out kernel symbol argument sanity checking
  perf tools: Check vmlinux/kallsyms arguments in all tools
  perf inject: Add vmlinux and ignore-vmlinux arguments

 tools/perf/builtin-annotate.c |  4 ++++
 tools/perf/builtin-c2c.c      |  4 ++++
 tools/perf/builtin-inject.c   |  7 +++++++
 tools/perf/builtin-probe.c    |  5 +++++
 tools/perf/builtin-record.c   |  4 ++++
 tools/perf/builtin-report.c   | 13 ++-----------
 tools/perf/builtin-sched.c    |  4 ++++
 tools/perf/builtin-script.c   |  3 +++
 tools/perf/builtin-top.c      |  4 ++++
 tools/perf/util/symbol.c      | 22 ++++++++++++++++++++++
 tools/perf/util/symbol.h      |  2 ++
 11 files changed, 61 insertions(+), 11 deletions(-)

-- 
2.28.0

