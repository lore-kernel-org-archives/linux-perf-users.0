From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 0/9] perf test: the testsuite again
Date: Wed, 16 Mar 2016 14:50:06 +0100 (CET)
Message-ID: <alpine.LRH.2.20.1603161423550.13911@Rudolf-RHEL-7>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49213 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966756AbcCPNuK (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Mar 2016 09:50:10 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org, Jiri Olsa <jolsa@redhat.com>

Hi all,

after some time, I am sending the proposed testsuite again. I have fixed
couple of things there since last time.

   * three verbosity levels are now supported (perf test suite -vv)
   * logs and temp files are stored in /tmp/, so the main tree is not
     spoiled anymore
   * more things can be parametrized from the outside
   * log parsing should be more robust now

The testsuite is roughly tested on x86_64, i386, ppc64, s390x and aarch64.
The following patches should be applicable upon the Arnaldo's tree, to the
'perf/core' branch.

Some issues to be discussed:

1) Packaging

While the other tests are packed within perf, the character of this suite
does not fit that model very well. Nowadays, it is run only when the dir
'testsuite' is found in the current dir. Otherwise the test is skipped.
I still haven't found any better solution for this.

2) In case it gets into the kernel tree, where the 'upstream' will be?

I have been developing the suite in my github repository [1]. I am planning
to continue with that, if the suite gets or not into the kernel tree. There
are still many testcases missing. I also backport the suite for RHEL testing
purposes.

It is easier for me to continue the development there and merge bigger
chunks into the kernel tree, than move all the development here. Is that
an acceptable model?

Is there anything else that you would like to point at?

Thanks.
Michael



[1] https://github.com/rfmvh/perftool-testsuite

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
  tools/perf/tests/suite.c                           | 150 ++++++++++++++
  tools/perf/tests/suite.h                           |  30 +++
  tools/perf/tests/tests.h                           |   1 +
  tools/perf/testsuite/base_annotate/cleanup.sh      |  24 +++
  .../perf/testsuite/base_annotate/examples/Makefile |  16 ++
  tools/perf/testsuite/base_annotate/examples/load.c |  24 +++
  tools/perf/testsuite/base_annotate/settings.sh     |  31 +++
  tools/perf/testsuite/base_annotate/setup.sh        |  35 ++++
  tools/perf/testsuite/base_annotate/test_basic.sh   | 169 +++++++++++++++
  tools/perf/testsuite/base_buildid/cleanup.sh       |  23 +++
  tools/perf/testsuite/base_buildid/settings.sh      |  45 ++++
  tools/perf/testsuite/base_buildid/setup.sh         |  26 +++
  .../testsuite/base_buildid/test_buildid-list.sh    |  81 ++++++++
  tools/perf/testsuite/base_list/cleanup.sh          |  22 ++
  tools/perf/testsuite/base_list/settings.sh         |  30 +++
  tools/perf/testsuite/base_list/setup.sh            |  20 ++
  tools/perf/testsuite/base_list/test_basic.sh       | 101 +++++++++
  tools/perf/testsuite/base_probe/cleanup.sh         |  22 ++
  tools/perf/testsuite/base_probe/examples/Makefile  |  16 ++
  .../perf/testsuite/base_probe/examples/advanced.c  |  40 ++++
  .../testsuite/base_probe/examples/exact_counts.c   |  35 ++++
  tools/perf/testsuite/base_probe/examples/test.c    |  35 ++++
  tools/perf/testsuite/base_probe/settings.sh        |  58 ++++++
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
  tools/perf/testsuite/base_report/cleanup.sh        |  24 +++
  tools/perf/testsuite/base_report/settings.sh       |  30 +++
  tools/perf/testsuite/base_report/setup.sh          |  26 +++
  .../testsuite/base_report/stderr-whitelist.txt     |   1 +
  tools/perf/testsuite/base_report/test_basic.sh     | 169 +++++++++++++++
  tools/perf/testsuite/base_stat/cleanup.sh          |  26 +++
  tools/perf/testsuite/base_stat/settings.sh         |  25 +++
  tools/perf/testsuite/base_stat/test_basic.sh       |  69 +++++++
  tools/perf/testsuite/base_stat/test_hw.sh          |  50 +++++
  tools/perf/testsuite/base_stat/test_hwcache.sh     |  51 +++++
  .../perf/testsuite/base_stat/test_intel_uncore.sh  |  46 +++++
  .../testsuite/base_stat/test_powerpc_hv_24x7.sh    |  60 ++++++
  .../base_stat/test_tracepoints_definition.sh       |  62 ++++++
  tools/perf/testsuite/base_trace/cleanup.sh         |  24 +++
  tools/perf/testsuite/base_trace/settings.sh        |  25 +++
  tools/perf/testsuite/base_trace/setup.sh           |  16 ++
  .../perf/testsuite/base_trace/stderr-whitelist.txt |   1 +
  tools/perf/testsuite/base_trace/test_basic.sh      | 131 ++++++++++++
  tools/perf/testsuite/base_trace/test_overhead.sh   |  51 +++++
  tools/perf/testsuite/base_trace/test_record.sh     |  45 ++++
  .../testsuite/common/check_all_lines_matched.pl    |  38 ++++
  .../testsuite/common/check_all_patterns_found.pl   |  33 +++
  .../testsuite/common/check_any_pattern_found.pl    |  14 ++
  .../testsuite/common/check_buildids_vs_files.pl    |  31 +++
  .../testsuite/common/check_errors_whitelisted.pl   |  50 +++++
  .../testsuite/common/check_exact_pattern_order.pl  |  27 +++
  .../testsuite/common/check_kallsyms_vs_probes.pl   |  61 ++++++
  .../testsuite/common/check_no_patterns_found.pl    |  33 +++
  tools/perf/testsuite/common/init.sh                |  67 ++++++
  tools/perf/testsuite/common/parametrization.sh     |  39 ++++
  tools/perf/testsuite/common/patterns.sh            | 119 +++++++++++
  tools/perf/testsuite/common/settings.sh            |  57 +++++
  67 files changed, 3573 insertions(+)
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
  create mode 100755 tools/perf/testsuite/base_trace/test_overhead.sh
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

-- 
1.8.3.1
