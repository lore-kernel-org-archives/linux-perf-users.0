From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 0/9] Tesstsuite - splitted to more commits
Date: Mon, 07 Dec 2015 19:52:52 +0100
Message-ID: <1449514372.24573.250.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39349 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932310AbbLGSwy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 7 Dec 2015 13:52:54 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id C46198CF4D
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Dec 2015 18:52:54 +0000 (UTC)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi,

so I have splitted the suite into more commits that are related to
the logical parts of it.  These patches should apply to the latest
Arnaldo's tree on top of perf/core branch.

I hope it works now.
Thanks for reviewing.

Michael



Michael Petlan (9):
  perf test: Adding an entry for the perftool-testsuite
  perf test: adding new testsuite: common files
  perf test: new testsuite: perf annotate tests
  perf test: new testsuite: perf buildid-list tests
  perf test: new testsuite: perf list tests
  perf test: new testsuite: perf probe tests
  perf test: new testsuite: perf report tests
  perf test: new testsuite: perf stat tests
  perf test: new testsuite: perf trace tests

 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/builtin-test.c                    |   4 +
 tools/perf/tests/suite.c                           | 143 +++++++++++++
 tools/perf/tests/suite.h                           |  30 +++
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/testsuite/base_annotate/cleanup.sh      |  22 ++
 .../perf/testsuite/base_annotate/examples/Makefile |  13 ++
 tools/perf/testsuite/base_annotate/examples/load.c |  24 +++
 tools/perf/testsuite/base_annotate/settings.sh     |  15 ++
 tools/perf/testsuite/base_annotate/setup.sh        |  35 ++++
 tools/perf/testsuite/base_annotate/test_basic.sh   | 169 +++++++++++++++
 tools/perf/testsuite/base_buildid/cleanup.sh       |  20 ++
 tools/perf/testsuite/base_buildid/settings.sh      |  23 +++
 tools/perf/testsuite/base_buildid/setup.sh         |  26 +++
 .../testsuite/base_buildid/test_buildid-list.sh    |  79 +++++++
 tools/perf/testsuite/base_list/cleanup.sh          |  19 ++
 tools/perf/testsuite/base_list/settings.sh         |  15 ++
 tools/perf/testsuite/base_list/setup.sh            |  20 ++
 tools/perf/testsuite/base_list/test_basic.sh       |  88 ++++++++
 tools/perf/testsuite/base_probe/cleanup.sh         |  22 ++
 tools/perf/testsuite/base_probe/examples/Makefile  |  13 ++
 .../perf/testsuite/base_probe/examples/advanced.c  |  40 ++++
 .../testsuite/base_probe/examples/exact_counts.c   |  35 ++++
 tools/perf/testsuite/base_probe/examples/test.c    |  35 ++++
 tools/perf/testsuite/base_probe/settings.sh        |  42 ++++
 tools/perf/testsuite/base_probe/setup.sh           |  23 +++
 .../base_probe/test_adding_blacklisted.sh          |  63 ++++++
 .../testsuite/base_probe/test_adding_kernel.sh     | 229 +++++++++++++++++++++
 tools/perf/testsuite/base_probe/test_advanced.sh   | 124 +++++++++++
 tools/perf/testsuite/base_probe/test_basic.sh      |  79 +++++++
 .../perf/testsuite/base_probe/test_exact_counts.sh | 106 ++++++++++
 .../testsuite/base_probe/test_invalid_options.sh   |  80 +++++++
 .../testsuite/base_probe/test_line_semantics.sh    |  56 +++++
 tools/perf/testsuite/base_probe/test_listing.sh    | 154 ++++++++++++++
 .../perf/testsuite/base_probe/test_probe_syntax.sh | 119 +++++++++++
 tools/perf/testsuite/base_report/cleanup.sh        |  22 ++
 tools/perf/testsuite/base_report/settings.sh       |  15 ++
 tools/perf/testsuite/base_report/setup.sh          |  26 +++
 .../testsuite/base_report/stderr-whitelist.txt     |   1 +
 tools/perf/testsuite/base_report/test_basic.sh     | 169 +++++++++++++++
 tools/perf/testsuite/base_stat/cleanup.sh          |  21 ++
 tools/perf/testsuite/base_stat/settings.sh         |  10 +
 tools/perf/testsuite/base_stat/test_basic.sh       |  68 ++++++
 tools/perf/testsuite/base_stat/test_hw.sh          |  50 +++++
 tools/perf/testsuite/base_stat/test_hwcache.sh     |  51 +++++
 .../perf/testsuite/base_stat/test_intel_uncore.sh  |  46 +++++
 .../testsuite/base_stat/test_powerpc_hv_24x7.sh    |  60 ++++++
 .../base_stat/test_tracepoints_definition.sh       |  60 ++++++
 tools/perf/testsuite/base_trace/cleanup.sh         |  19 ++
 tools/perf/testsuite/base_trace/settings.sh        |  10 +
 tools/perf/testsuite/base_trace/setup.sh           |  16 ++
 .../perf/testsuite/base_trace/stderr-whitelist.txt |   1 +
 tools/perf/testsuite/base_trace/test_basic.sh      | 129 ++++++++++++
 tools/perf/testsuite/base_trace/test_record.sh     |  45 ++++
 .../testsuite/common/check_all_lines_matched.pl    |  38 ++++
 .../testsuite/common/check_all_patterns_found.pl   |  33 +++
 .../testsuite/common/check_any_pattern_found.pl    |  14 ++
 .../testsuite/common/check_buildids_vs_files.pl    |  22 ++
 .../testsuite/common/check_errors_whitelisted.pl   |  50 +++++
 .../testsuite/common/check_exact_pattern_order.pl  |  27 +++
 .../testsuite/common/check_kallsyms_vs_probes.pl   |  48 +++++
 .../testsuite/common/check_no_patterns_found.pl    |  33 +++
 tools/perf/testsuite/common/init.sh                |  67 ++++++
 tools/perf/testsuite/common/parametrization.sh     |  32 +++
 tools/perf/testsuite/common/patterns.sh            | 117 +++++++++++
 tools/perf/testsuite/common/settings.sh            |  57 +++++
 66 files changed, 3324 insertions(+)
 create mode 100644 tools/perf/tests/suite.c
 create mode 100644 tools/perf/tests/suite.h
 create mode 100755 tools/perf/testsuite/base_annotate/cleanup.sh
 create mode 100644 tools/perf/testsuite/base_annotate/examples/Makefile
 create mode 100644 tools/perf/testsuite/base_annotate/examples/load.c
 create mode 100644 tools/perf/testsuite/base_annotate/settings.sh
 create mode 100755 tools/perf/testsuite/base_annotate/setup.sh
 create mode 100755 tools/perf/testsuite/base_annotate/test_basic.sh
 create mode 100755 tools/perf/testsuite/base_buildid/cleanup.sh
 create mode 100644 tools/perf/testsuite/base_buildid/settings.sh
 create mode 100755 tools/perf/testsuite/base_buildid/setup.sh
 create mode 100755 tools/perf/testsuite/base_buildid/test_buildid-list.sh
 create mode 100755 tools/perf/testsuite/base_list/cleanup.sh
 create mode 100644 tools/perf/testsuite/base_list/settings.sh
 create mode 100755 tools/perf/testsuite/base_list/setup.sh
 create mode 100755 tools/perf/testsuite/base_list/test_basic.sh
 create mode 100755 tools/perf/testsuite/base_probe/cleanup.sh
 create mode 100644 tools/perf/testsuite/base_probe/examples/Makefile
 create mode 100644 tools/perf/testsuite/base_probe/examples/advanced.c
 create mode 100644 tools/perf/testsuite/base_probe/examples/exact_counts.c
 create mode 100644 tools/perf/testsuite/base_probe/examples/test.c
 create mode 100644 tools/perf/testsuite/base_probe/settings.sh
 create mode 100755 tools/perf/testsuite/base_probe/setup.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_adding_blacklisted.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_adding_kernel.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_advanced.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_basic.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_exact_counts.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_invalid_options.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_line_semantics.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_listing.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_probe_syntax.sh
 create mode 100755 tools/perf/testsuite/base_report/cleanup.sh
 create mode 100644 tools/perf/testsuite/base_report/settings.sh
 create mode 100755 tools/perf/testsuite/base_report/setup.sh
 create mode 100644 tools/perf/testsuite/base_report/stderr-whitelist.txt
 create mode 100755 tools/perf/testsuite/base_report/test_basic.sh
 create mode 100755 tools/perf/testsuite/base_stat/cleanup.sh
 create mode 100644 tools/perf/testsuite/base_stat/settings.sh
 create mode 100755 tools/perf/testsuite/base_stat/test_basic.sh
 create mode 100755 tools/perf/testsuite/base_stat/test_hw.sh
 create mode 100755 tools/perf/testsuite/base_stat/test_hwcache.sh
 create mode 100755 tools/perf/testsuite/base_stat/test_intel_uncore.sh
 create mode 100755 tools/perf/testsuite/base_stat/test_powerpc_hv_24x7.sh
 create mode 100755 tools/perf/testsuite/base_stat/test_tracepoints_definition.sh
 create mode 100755 tools/perf/testsuite/base_trace/cleanup.sh
 create mode 100644 tools/perf/testsuite/base_trace/settings.sh
 create mode 100755 tools/perf/testsuite/base_trace/setup.sh
 create mode 100644 tools/perf/testsuite/base_trace/stderr-whitelist.txt
 create mode 100755 tools/perf/testsuite/base_trace/test_basic.sh
 create mode 100755 tools/perf/testsuite/base_trace/test_record.sh
 create mode 100755 tools/perf/testsuite/common/check_all_lines_matched.pl
 create mode 100755 tools/perf/testsuite/common/check_all_patterns_found.pl
 create mode 100755 tools/perf/testsuite/common/check_any_pattern_found.pl
 create mode 100755 tools/perf/testsuite/common/check_buildids_vs_files.pl
 create mode 100755 tools/perf/testsuite/common/check_errors_whitelisted.pl
 create mode 100755 tools/perf/testsuite/common/check_exact_pattern_order.pl
 create mode 100755 tools/perf/testsuite/common/check_kallsyms_vs_probes.pl
 create mode 100755 tools/perf/testsuite/common/check_no_patterns_found.pl
 create mode 100644 tools/perf/testsuite/common/init.sh
 create mode 100644 tools/perf/testsuite/common/parametrization.sh
 create mode 100644 tools/perf/testsuite/common/patterns.sh
 create mode 100644 tools/perf/testsuite/common/settings.sh
