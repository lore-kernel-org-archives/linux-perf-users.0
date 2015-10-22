From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core 0/2] perf/runtests: Add runtests.sh shellscript
 testcases for perf probe
Date: Thu, 22 Oct 2015 21:16:15 +0900
Message-ID: <20151022121615.13192.71967.stgit@localhost.localdomain>
References: <1445468925.12960.117.camel@Rudolf-RHEL-7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44]:35061 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbbJVMXQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 22 Oct 2015 08:23:16 -0400
In-Reply-To: <1445468925.12960.117.camel@Rudolf-RHEL-7>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>

Hi Michael,

Here is a couple of patches to add my testsuite(runtest.sh) to perf.

This runs as ftracetest does. I've added some testcases which cover
perf-probe features :)

  ----
  # ./runtests.sh
  === Run tests ===
  [1] Basinc probe adding [PASS]
  [2] Basic probe adding on user binary   [PASS]
  [3] Skip blacklist function     [PASS]
  [4] Basic probe deleting        [PASS]
  [5] probe adding with --force   [PASS]
  [6] Cut off the function suffix from name       [PASS]
  [7] Basic function listup command       [PASS]
  [8] help messages       [PASS]
  [9] invalid commands    [PASS]
  [10] perf probe --list outputs in stdout        [PASS]
  [11] list command parsing       [PASS]
  [12] Skip out-of-text functions [PASS]
  [13] Quiet option check [PASS]
  [14] --line semantic errors     [PASS]
  [15] readable vars command      [PASS]
  [16] perf-probe wildcard support        [PASS]
  
  # of passed:  16
  # of failed:  0
  # of unresolved:  0
  # of untested:  0
  # of unsupported:  0
  # of xfailed:  0
  # of undefined(test bug):  0
  ----

Thank you,

---

Masami Hiramatsu (2):
      perf/runtests: Add runtests.sh shellscript testsuite
      perf/runtests: Add testcases for perf probe


 tools/perf/runtests/runtests.conf                  |    5 
 tools/perf/runtests/runtests.sh                    |  264 ++++++++++++++++++++
 tools/perf/runtests/test.d/functions               |   13 +
 tools/perf/runtests/test.d/probe/addprobes.tc      |   15 +
 tools/perf/runtests/test.d/probe/adduprobes.tc     |   13 +
 tools/perf/runtests/test.d/probe/blacklist.tc      |   14 +
 tools/perf/runtests/test.d/probe/delete.tc         |    8 +
 tools/perf/runtests/test.d/probe/forceadd.tc       |    8 +
 .../perf/runtests/test.d/probe/funcname-suffix.tc  |   17 +
 tools/perf/runtests/test.d/probe/funcs.tc          |    8 +
 tools/perf/runtests/test.d/probe/help.tc           |    5 
 .../perf/runtests/test.d/probe/invalid_command.tc  |   27 ++
 tools/perf/runtests/test.d/probe/list-stdout.tc    |    7 +
 tools/perf/runtests/test.d/probe/list.tc           |   10 +
 tools/perf/runtests/test.d/probe/out-of-text.tc    |   10 +
 tools/perf/runtests/test.d/probe/quiet.tc          |    6 
 tools/perf/runtests/test.d/probe/semantic-line.tc  |   20 ++
 tools/perf/runtests/test.d/probe/vars.tc           |    9 +
 tools/perf/runtests/test.d/probe/wildcard.tc       |    6 
 19 files changed, 465 insertions(+)
 create mode 100644 tools/perf/runtests/runtests.conf
 create mode 100755 tools/perf/runtests/runtests.sh
 create mode 100644 tools/perf/runtests/test.d/functions
 create mode 100644 tools/perf/runtests/test.d/probe/addprobes.tc
 create mode 100644 tools/perf/runtests/test.d/probe/adduprobes.tc
 create mode 100644 tools/perf/runtests/test.d/probe/blacklist.tc
 create mode 100644 tools/perf/runtests/test.d/probe/delete.tc
 create mode 100644 tools/perf/runtests/test.d/probe/forceadd.tc
 create mode 100644 tools/perf/runtests/test.d/probe/funcname-suffix.tc
 create mode 100644 tools/perf/runtests/test.d/probe/funcs.tc
 create mode 100644 tools/perf/runtests/test.d/probe/help.tc
 create mode 100644 tools/perf/runtests/test.d/probe/invalid_command.tc
 create mode 100644 tools/perf/runtests/test.d/probe/list-stdout.tc
 create mode 100644 tools/perf/runtests/test.d/probe/list.tc
 create mode 100644 tools/perf/runtests/test.d/probe/out-of-text.tc
 create mode 100644 tools/perf/runtests/test.d/probe/quiet.tc
 create mode 100644 tools/perf/runtests/test.d/probe/semantic-line.tc
 create mode 100644 tools/perf/runtests/test.d/probe/vars.tc
 create mode 100644 tools/perf/runtests/test.d/probe/wildcard.tc

--
