From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 0/3] introducing tools/perf/testsuite
Date: Thu, 22 Oct 2015 01:08:45 +0200
Message-ID: <1445468925.12960.117.camel@Rudolf-RHEL-7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60442 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755259AbbJUXIr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 21 Oct 2015 19:08:47 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 700F3FA9CF
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2015 23:08:47 +0000 (UTC)
Received: from [10.34.1.123] (dhcp-1-123.brq.redhat.com [10.34.1.123])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t9LN8kwo001704
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2015 19:08:47 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi all,

in the following patches I introduce a skeleton of a testsuite for
perf tool. The idea of this testsuite is to primarily cover all the
sub-commands perf has and verify their functionality.

The testsuite is designed to be structured in order to be able to
keep an order in some amount of testcases. Each group of testcases
is located in a base_<something> dir with its init and cleanup
scripts and shell files test_<something>.sh that should carry the
testcases. Each testcase can have multiple assertions inside. The
base_skeleton and base_stat are an example. New tests are supposed
to be derived from them.

Since the testsuite is meant to be usable for both smoke and deeper
testing, it has some parametrization in common/parametrization.sh.

My idea is to add testcases for the other existing builtin commands
and then continue extending it for the upcoming ones.

How does it seem to you? Thoughts?

Michael


Michael Petlan (3):
  tools/perf/testsuite: Init commit
  tools/perf/testsuite: Adding a skeleton for future testcases
  tools/perf/testsuite: Adding a set of testcases for perf-stat

 tools/perf/testsuite/base_skeleton/cleanup.sh      |  16 +++
 tools/perf/testsuite/base_skeleton/settings.sh     |  10 ++
 tools/perf/testsuite/base_skeleton/setup.sh        |  16 +++
 tools/perf/testsuite/base_skeleton/test_01.sh      |  40 ++++++++
 tools/perf/testsuite/base_stat/cleanup.sh          |  20 ++++
 tools/perf/testsuite/base_stat/settings.sh         |  10 ++
 tools/perf/testsuite/base_stat/test_basic.sh       |  68 ++++++++++++
 tools/perf/testsuite/base_stat/test_hw.sh          |  50 +++++++++
 tools/perf/testsuite/base_stat/test_hwcache.sh     |  51 +++++++++
 .../testsuite/base_stat/test_powerpc_hv_24x7.sh    |  60 +++++++++++
 .../testsuite/common/check_all_lines_matched.pl    |  28 +++++
 .../testsuite/common/check_all_patterns_found.pl   |  30 ++++++
 .../testsuite/common/check_any_pattern_found.pl    |  14 +++
 tools/perf/testsuite/common/init.sh                |  50 +++++++++
 tools/perf/testsuite/common/parametrization.sh     |  18 ++++
 tools/perf/testsuite/common/patterns.sh            |  74 +++++++++++++
 tools/perf/testsuite/common/settings.sh            |  50 +++++++++
 tools/perf/testsuite/test_driver.sh                | 114 +++++++++++++++++++++
 18 files changed, 719 insertions(+)
 create mode 100755 tools/perf/testsuite/base_skeleton/cleanup.sh
 create mode 100644 tools/perf/testsuite/base_skeleton/settings.sh
 create mode 100755 tools/perf/testsuite/base_skeleton/setup.sh
 create mode 100755 tools/perf/testsuite/base_skeleton/test_01.sh
 create mode 100755 tools/perf/testsuite/base_stat/cleanup.sh
 create mode 100644 tools/perf/testsuite/base_stat/settings.sh
 create mode 100755 tools/perf/testsuite/base_stat/test_basic.sh
 create mode 100755 tools/perf/testsuite/base_stat/test_hw.sh
 create mode 100755 tools/perf/testsuite/base_stat/test_hwcache.sh
 create mode 100755 tools/perf/testsuite/base_stat/test_powerpc_hv_24x7.sh
 create mode 100755 tools/perf/testsuite/common/check_all_lines_matched.pl
 create mode 100755 tools/perf/testsuite/common/check_all_patterns_found.pl
 create mode 100755 tools/perf/testsuite/common/check_any_pattern_found.pl
 create mode 100644 tools/perf/testsuite/common/init.sh
 create mode 100644 tools/perf/testsuite/common/parametrization.sh
 create mode 100644 tools/perf/testsuite/common/patterns.sh
 create mode 100644 tools/perf/testsuite/common/settings.sh
 create mode 100755 tools/perf/testsuite/test_driver.sh

-- 
1.8.3.1
