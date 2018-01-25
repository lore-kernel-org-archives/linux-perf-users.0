From: ufo19890607 <ufo19890607@gmail.com>
Subject: [PATCH v2 0/2] perf stat: Add interval-count and time support
Date: Thu, 25 Jan 2018 10:10:02 +0100
Message-ID: <1516871404-31920-1-git-send-email-ufo19890607@gmail.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:37806 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbeAYJKU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 Jan 2018 04:10:20 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com, wangnan0@huawei.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com

From: yuzhoujian <yuzhoujian@didichuxing.com>

Introduce two new options for perf stat and update perf-stat documentation
accordingly.

The interval-count option can be used to print counts for fixed number of
times, and it should be used specifically with "-I" option.

Show below is the output of the interval-count option for perf stat.

        $ perf stat -I 1000 --interval-count 2 -e cycles -a
        #           time             counts unit events
             1.002827089         93,884,870      cycles
             2.004231506         56,573,446      cycles
        
The time option can be used to print counts after a period of time, and it
should not used with "-I" option.

Show below is the output of the time option for perf stat.

	$ perf stat --time 2000 -e cycles -a
        Performance counter stats for 'system wide':

                157,260,423      cycles

                2.003060766 seconds time elapsed

yuzhoujian (2):
Patch 1: Add support to print counts for fixed times
Patch 2: Add support to print counts after a period of time

Changes since v1: 
- change the name of the new option "times-print" to "interval-count".
- keep the interval-count option interval specifically.

 tools/perf/Documentation/perf-stat.txt | 10 +++++++
 tools/perf/builtin-stat.c              | 53 ++++++++++++++++++++++++++++++++--
 tools/perf/util/stat.h                 |  2 ++
 3 files changed, 62 insertions(+), 3 deletions(-)

-- 
2.14.1
