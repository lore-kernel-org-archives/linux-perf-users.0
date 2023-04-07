Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B43C6FD1D
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 Apr 2023 05:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjDGFwk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 7 Apr 2023 01:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDGFwj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 Apr 2023 01:52:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580559768;
        Thu,  6 Apr 2023 22:52:37 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pt6r24q8KznYFL;
        Fri,  7 Apr 2023 13:49:06 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 7 Apr 2023 13:52:33 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>,
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v2 0/2] perf script: Have consistent output for symbol address
Date:   Fri, 7 Apr 2023 13:52:10 +0800
Message-ID: <20230407055212.2701635-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The goal of this change is to achieve consistent output for symbol address.
Before this, the raw ip is printed for non-callchain and dso offset for
callchain. Mostly what we expect is the raw ip.

This patch does two changes:
  - Always print raw ip for resolved symbols.
  - Add a new 'dsoff' field if we really need the dso offset, and the
    offset is appended to dso name.

v2:
  o split into two patches.
  o do not print offset for unresolved symbols.

Changbin Du (2):
  perf script: print raw ip instead of binary offset for callchain
  perf: script: add new output field 'dsoff' to print dso offset

 tools/perf/Documentation/perf-script.txt |  2 +-
 tools/perf/builtin-script.c              |  5 +++++
 tools/perf/util/evsel_fprintf.c          | 15 ++++++++-------
 tools/perf/util/evsel_fprintf.h          |  1 +
 4 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.25.1

