Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB22C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 10:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A62F6608FB
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 10:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhIVKSO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 06:18:14 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49]:45530 "EHLO
        esa3.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234414AbhIVKSK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 06:18:10 -0400
IronPort-SDR: koZWrufzIyTEu2N0YKCBbWa0PnzM0xgihR2D9s+x5sC347COGEka9Q/00Gd+XZERvo1JMNqqWn
 T4nB2uE1HpTo6J4edb1NH3XHb3ExoSYuzbXRnRnHUIly3iJIZcxrUe2sHJdtB20Gspt9cn5C/K
 4ZCsA8uZVvsSgdslHWNq8PZvkiY+cIwJqgDYuDHhE1SbSVFZ2eerIRJvhKQv8fIexbt31gMqZu
 1K9PY8Ih4yFYl5v3Wxs/Fhh8AkANWAGi0XixUFJUE2C8e36YbX9kIWIO1tODHTsaNF7x7yXXrQ
 d82+R7YYRf69IhoUcnRWLeWa
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="46127437"
X-IronPort-AV: E=Sophos;i="5.85,313,1624287600"; 
   d="scan'208";a="46127437"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 22 Sep 2021 19:16:33 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8EA83EBA43;
        Wed, 22 Sep 2021 19:16:31 +0900 (JST)
Received: from yto-om2.fujitsu.com (yto-om2.o.css.fujitsu.com [10.128.89.163])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id B75802161D4;
        Wed, 22 Sep 2021 19:16:30 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-om2.fujitsu.com (Postfix) with ESMTP id 92E1E400C0072;
        Wed, 22 Sep 2021 19:16:30 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v2 0/2] libperf: Add support for scaling counters obtained from the read() system call during multiplexing
Date:   Wed, 22 Sep 2021 19:16:25 +0900
Message-Id: <20210922101627.3396398-1-nakamura.shun@fujitsu.com>
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

The second patch adds a test for the first patch.
This patch is based on Vince's rdpmc_multiplexing.c [1]

---
Changes in v2:
 - Fix not to divide by zero when counter scaling
 - Add test to verify that no division by zero occurs


[1] https://github.com/deater/perf_event_tests/blob/master/tests/rdpmc/rdpmc_multiplexing.c


nakamura shunsuke (2):
  libperf: Add processing to scale the counters obtained during the
    read() system call when multiplexing
  libperf tests: Add test_stat_multiplexing test

 tools/lib/perf/evsel.c             |   6 +
 tools/lib/perf/tests/test-evlist.c | 183 +++++++++++++++++++++++++++++
 2 files changed, 189 insertions(+)

-- 
2.27.0

