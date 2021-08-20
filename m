Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFC0C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 09:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F39661051
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 09:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbhHTJrP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 05:47:15 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137]:42166 "EHLO
        esa11.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233976AbhHTJrO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 05:47:14 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Aug 2021 05:47:14 EDT
IronPort-SDR: RhdEdyIZlXyuYQWLSfP62ScafB1uoVSpFMFmpphdkSU29FqHOOqutpUiihWlKRrK3Ihs7KWeya
 UMQwQ1VnSg7wJDVTw632x5xIoetFZIXB4o7qFgoVRiW2zBwz/zwR6k76niIJpSAxM/Kf69UewQ
 IFuCiuCS+VXVaD5lvA4EA5oN4k+SHjBAotvFDC7lOjmY7IGBJ5ZchBU8TFVLeAfZ0Y6IGprtD2
 IcPmCiy6JhlS2f2UDDTeIsr0yO1zeVnTcSRA76yZ5+7sw4NnsBBdeEzzaJBfMGcgIl3UJcpeC3
 hVHy2oZn/T2WR/iOCohHymyN
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="20706131"
X-IronPort-AV: E=Sophos;i="5.84,337,1620658800"; 
   d="scan'208";a="20706131"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 20 Aug 2021 18:39:20 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 94BB11FB38E;
        Fri, 20 Aug 2021 18:39:19 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id D574CC522F;
        Fri, 20 Aug 2021 18:39:18 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by oym-om1.fujitsu.com (Postfix) with ESMTP id 8B78B4011E7FF;
        Fri, 20 Aug 2021 18:39:18 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] libperf: Add support for scaling counters obtained from the read() system call during multiplexing
Date:   Fri, 20 Aug 2021 18:39:05 +0900
Message-Id: <20210820093908.734503-1-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch series supports counter scaling when perf_evsel__read() obtains a counter
using the read() system call during multiplexing.

The first patch adds scaling of counters obtained from the read() system call
during multiplexing.

The second patch fixes verbose printing.

The third patch adds a test for the first patch.
This patch is based on Vince's rdpmc_multiplexing.c [1]


[1] https://github.com/deater/perf_event_tests/blob/master/tests/rdpmc/rdpmc_multiplexing.c


Shunsuke Nakamura (3):
  libperf: Add processing to scale the counters obtained during the read
    () system call when multiplexing
  libperf tests: Fix verbose printing
  libperf tests: Add test_stat_multiplexing test

 tools/lib/perf/evsel.c                  |   4 +
 tools/lib/perf/include/internal/tests.h |   2 +
 tools/lib/perf/tests/test-evlist.c      | 138 ++++++++++++++++++++++++
 3 files changed, 144 insertions(+)

-- 
2.25.1

