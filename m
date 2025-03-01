Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125541B87F0;
	Sat,  1 Mar 2025 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740801776; cv=none; b=HJSivuYWCNWjqsZEUASNCX3F3SYpSYs/lJLR2z3jdtfJLnc8HQPSvyOKbkrBR/r/rg59HkJNqpeSrtGT4OL3LUs5PWuph0yhF5TMERhEBFiltl9xLFTOfAVLqlK277grcHruHYuJj9cCjWZQPGzwxZvoKPTcqxGDddBUUQzMX2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740801776; c=relaxed/simple;
	bh=d901Y/hjDUT/pU0UBAW8Em2x+X51gXf/2YaVHj81Xq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/Se/0nGd4jlt+qHfGu69/mW7JF2QjS8tV8br2LaidOA5HxUWWOGby0WeDqToBSFrcNBJ64vmXZ3QbEN2JCWOrv6v0Upg/RSgOZbURz+MEE0PwHNPq7EdWroCWENzutPkYUr+jrXiH4fhyQKEhhln+gY7+3q8BTuk3hlqTnCbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4xZVTKR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4xZVTKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDE2C4CEEA;
	Sat,  1 Mar 2025 04:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740801774;
	bh=d901Y/hjDUT/pU0UBAW8Em2x+X51gXf/2YaVHj81Xq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F4xZVTKRgOkBhiYeEjseUPb3NxTpr+XHFa+i6lHdE55KvQU3g/AVgypO2lJFRm6uC
	 /lUu4+vMEHy6012YTeMe0iTS6RDa+k9jGgJF9Wc6SxxYJ2Kzy/5BabPGDvpA7BF9Wd
	 PbvMqvBzKLqcMltNCttieuzDAyQLoMqO9zv4z9TkESf/x36QA8VVWeb+Tejb3GFhnr
	 /HXDZIP91fC7jiwP5UpKqODwbaHPvIvKtIklWceqWW73AbnNVEb931xL5+0o0+jbRk
	 K2+AnuklBSR8SsJ/1maTpLW5uFgfw++HD+rlezGOAP5h3H7WZeZzl8nN+BNxyc3bTJ
	 Go2WfOu8BgtFw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/4] perf test: Skip perf probe tests when running as non-root
Date: Fri, 28 Feb 2025 20:02:50 -0800
Message-ID: <20250301040252.1586750-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250301040252.1586750-1-namhyung@kernel.org>
References: <20250301040252.1586750-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf trace requires root because it needs to use [ku]probes.
Skip those test when it's not run as root.

Before:
  $ perf test probe
   47: Probe SDT events                                                : Ok
  104: test perf probe of function from different CU                   : FAILED!
  115: perftool-testsuite_probe                                        : FAILED!
  117: Add vfs_getname probe to get syscall args filenames             : FAILED!
  118: probe libc's inet_pton & backtrace it with ping                 : FAILED!
  119: Use vfs_getname probe to get syscall args filenames             : FAILED!

After:
  $ perf test probe
   47: Probe SDT events                                                : Ok
  104: test perf probe of function from different CU                   : Skip
  115: perftool-testsuite_probe                                        : Skip
  117: Add vfs_getname probe to get syscall args filenames             : Skip
  118: probe libc's inet_pton & backtrace it with ping                 : Skip
  119: Use vfs_getname probe to get syscall args filenames             : Skip

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/perftool-testsuite_probe.sh    |  1 +
 tools/perf/tests/shell/probe_vfs_getname.sh           |  1 +
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh |  1 +
 .../tests/shell/record+script_probe_vfs_getname.sh    |  1 +
 .../perf/tests/shell/test_uprobe_from_different_cu.sh | 11 +++++------
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/perftool-testsuite_probe.sh b/tools/perf/tests/shell/perftool-testsuite_probe.sh
index 7b1bfd0f888fc30c..add77aaeb26421a5 100755
--- a/tools/perf/tests/shell/perftool-testsuite_probe.sh
+++ b/tools/perf/tests/shell/perftool-testsuite_probe.sh
@@ -2,6 +2,7 @@
 # perftool-testsuite_probe (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
+[ "$(id -u)" == 0 ] || exit 2
 test -d "$(dirname "$0")/base_probe" || exit 2
 cd "$(dirname "$0")/base_probe" || exit 2
 status=0
diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index 0c5aacc446b3ef76..b8e53a9d8473bf6b 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -8,6 +8,7 @@
 . "$(dirname $0)"/lib/probe.sh
 
 skip_if_no_perf_probe || exit 2
+[ "$(id -u)" == 0 ] || exit 2
 
 # shellcheck source=lib/probe_vfs_getname.sh
 . "$(dirname $0)"/lib/probe_vfs_getname.sh
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index d5e5193cceb625fd..07a1527c5c03b93d 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -105,6 +105,7 @@ delete_libc_inet_pton_event() {
 
 # Check for IPv6 interface existence
 ip a sh lo | grep -F -q inet6 || exit 2
+[ "$(id -u)" == 0 ] || exit 2
 
 skip_if_no_perf_probe && \
 add_libc_inet_pton_event && \
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index 5940fdc1df37c502..0af3af90a8dcc742 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -13,6 +13,7 @@
 . "$(dirname "$0")/lib/probe.sh"
 
 skip_if_no_perf_probe || exit 2
+[ "$(id -u)" == 0 ] || exit 2
 
 # shellcheck source=lib/probe_vfs_getname.sh
 . "$(dirname "$0")/lib/probe_vfs_getname.sh"
diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
index 33387c329f92b6ed..7adf9755d6de240e 100755
--- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -4,12 +4,11 @@
 
 set -e
 
-# Skip if there's no probe command.
-if ! perf | grep probe
-then
-        echo "Skip: probe command isn't present"
-        exit 2
-fi
+# shellcheck source=lib/probe.sh
+. "$(dirname $0)"/lib/probe.sh
+
+skip_if_no_perf_probe || exit 2
+[ "$(id -u)" == 0 ] || exit 2
 
 # skip if there's no gcc
 if ! [ -x "$(command -v gcc)" ]; then
-- 
2.48.1.711.g2feabab25a-goog

