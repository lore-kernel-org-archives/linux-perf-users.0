Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E440C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 09:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E2361057
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 09:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbhKIJJf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 04:09:35 -0500
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223]:30340 "EHLO
        esa9.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230489AbhKIJJf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 04:09:35 -0500
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Nov 2021 04:09:34 EST
IronPort-SDR: +k2Whk6yF0CuwluFT+56L7yEKRlDdAA1JNJqjzzuQUpNUNr+e3lM3yQDUwca16Owbii/cFyDet
 sqrNTwdrgs3JTIxcLbEjyncmUNJXWD7GupNdT2I1asEerdDPz69wYGmJ5oRhq+qxDO/1gdRm2I
 OMgW2ks6BCQYiLoCKL8FAnmv/PDDCtmuXUWDsMDQG3ENSbQmejconabzny+l+7Dd0KnupypTbV
 y4kyoWfpmiw5CkBR92EhcJBAwALM/XBeCsHqZd/fJGZuVZ7w+rYUqx2zXmFJVy59TyMCGW02ea
 BLKkKaqeo1E2Fqw2Rt5wY8+V
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="39878293"
X-IronPort-AV: E=Sophos;i="5.87,219,1631545200"; 
   d="scan'208";a="39878293"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 09 Nov 2021 17:58:38 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id C3D7A1F4782;
        Tue,  9 Nov 2021 17:58:37 +0900 (JST)
Received: from yto-om2.fujitsu.com (yto-om2.o.css.fujitsu.com [10.128.89.163])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 924BBC9CC1;
        Tue,  9 Nov 2021 17:58:35 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-om2.fujitsu.com (Postfix) with ESMTP id 8CFD54006D7C8;
        Tue,  9 Nov 2021 17:58:35 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v3 0/3] libperf: Unify scaling of counters obtained from perf_evsel__read()
Date:   Tue,  9 Nov 2021 17:58:28 +0900
Message-Id: <20211109085831.3770594-1-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch series unifies the counters that can be obtained from
perf_evsel__read() to "no scaling".
The counter scaling will be done using a function moved from
tools/perf/util.

The first patch move perf_counts_values__scale from tools/perf/util
to tools/lib/perf so that it can be used with libperf.

The second patch removes the scaling process from
perf_mmap__read_self().

The third patch adds a verification test to make sure that it scales
correctly when multiplexed.

---
Previous version at:
https://lore.kernel.org/linux-perf-users/20210922101627.3396398-1-nakamura.shun@fujitsu.com/

Changes in v3:
 - Move scaling process from tools/perf/util to tools/lib/perf
 - Remove scaling process from perf_mmap__read_self()
 - Remove scaling process for perf_mmap__read_self
 - Remove test to verify that no division by zero occurs

Changes in v2:
 - Fix not to divide by zero when counter scaling
 - Add test to verify that no division by zero occurs


[1] https://github.com/deater/perf_event_tests/blob/master/tests/rdpmc/rdpmc_multiplexing.c


Shunsuke Nakamura (3):
  libperf: Move perf_counts_values__scale to tools/lib/perf
  libperf: Remove scaling process from perf_mmap__read_self()
  libperf tests: Add test_stat_multiplexing test

 tools/lib/perf/evsel.c              |  19 ++++
 tools/lib/perf/include/perf/evsel.h |   4 +
 tools/lib/perf/libperf.map          |   1 +
 tools/lib/perf/mmap.c               |   2 -
 tools/lib/perf/tests/test-evlist.c  | 157 ++++++++++++++++++++++++++++
 tools/perf/util/evsel.c             |  19 ----
 tools/perf/util/evsel.h             |   3 -
 7 files changed, 181 insertions(+), 24 deletions(-)

-- 
2.27.0

