Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B993719E83E;
	Tue,  4 Mar 2025 02:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055319; cv=none; b=N0qJQBhboD/sqc21z5dMHwrlX+d9/svRrOLbQBHlj01I0HNmSdmzzCCCfZo1EuAghYzacWh03EjLQhSDYfIyZVuwmLoqDXFf2HkKalIcIS3iwzMdgdkK1esMTiQBW0E/RY7/nyQCdwVa+Cm8p5rH5vmspXDhkxcxiX4J6GCrsCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055319; c=relaxed/simple;
	bh=nM37e+Q5uGyppMyuixp0WQG/9tKW9QwJMxGrmJqtW44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwxd+XuwLAP0airBnmGlxxBo3qZlv6S4MlMwAgFpDb1YabZyCLmMoZQNESzGYFYkM4mBv4B9RvGrUSHM004jq2pRBbYdAz6jCXm9v3PPqixeuQoW0z/t47ipSyAqctVciRfqmsCPKw6vteXfPrjB8/1K2LOQDV79ty3F9G88LWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVkU52Sw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVkU52Sw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A59C4CEEB;
	Tue,  4 Mar 2025 02:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741055319;
	bh=nM37e+Q5uGyppMyuixp0WQG/9tKW9QwJMxGrmJqtW44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SVkU52SwnhdDy7MpLrwBbMd2ZzWj69VfaQhE4kGr9YBNiqf+LV4M2ytDsc0i6wkmX
	 M3hAqlAFwEhCGX6IcQssIPsWJCENrRW9jFEX9UcAdKGsF851ogS0CGC2zdAMJBu0a8
	 ATzC1iMXw1IkKaiB5mAO/+rSwCdAuojsGiAxEgtSCzU7DM2PaZeot70r2KdfhCEfi4
	 bE95AdBTMOqHpYYd9dz0bTlEiKo3vHtfN8e0H337QdCA4aLTbBYdc45+ULaKEWH2Jq
	 Dq74LoyW6aUBH4qOVyf/ZBg95unl19DOPGC7q+v+iBkXFyOVtzArUJelCdX75stGf6
	 N4SRjmrZ/08qw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 2/6] perf test: Skip perf probe tests when running as non-root
Date: Mon,  3 Mar 2025 18:28:33 -0800
Message-ID: <20250304022837.1877845-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250304022837.1877845-1-namhyung@kernel.org>
References: <20250304022837.1877845-1-namhyung@kernel.org>
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

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/perftool-testsuite_probe.sh    |  1 +
 tools/perf/tests/shell/probe_vfs_getname.sh           |  1 +
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh |  1 +
 .../tests/shell/record+script_probe_vfs_getname.sh    |  1 +
 .../perf/tests/shell/test_uprobe_from_different_cu.sh | 11 +++++------
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/perftool-testsuite_probe.sh b/tools/perf/tests/shell/perftool-testsuite_probe.sh
index 7b1bfd0f888fc30c..3863df16c19b9fa2 100755
--- a/tools/perf/tests/shell/perftool-testsuite_probe.sh
+++ b/tools/perf/tests/shell/perftool-testsuite_probe.sh
@@ -2,6 +2,7 @@
 # perftool-testsuite_probe (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
+[ "$(id -u)" = 0 ] || exit 2
 test -d "$(dirname "$0")/base_probe" || exit 2
 cd "$(dirname "$0")/base_probe" || exit 2
 status=0
diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index 0c5aacc446b3ef76..c51a32931af6313e 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -8,6 +8,7 @@
 . "$(dirname $0)"/lib/probe.sh
 
 skip_if_no_perf_probe || exit 2
+[ "$(id -u)" = 0 ] || exit 2
 
 # shellcheck source=lib/probe_vfs_getname.sh
 . "$(dirname $0)"/lib/probe_vfs_getname.sh
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index d5e5193cceb625fd..c4bab5b5cc59f0b3 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -105,6 +105,7 @@ delete_libc_inet_pton_event() {
 
 # Check for IPv6 interface existence
 ip a sh lo | grep -F -q inet6 || exit 2
+[ "$(id -u)" = 0 ] || exit 2
 
 skip_if_no_perf_probe && \
 add_libc_inet_pton_event && \
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index 5940fdc1df37c502..fd5b10d469158b65 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -13,6 +13,7 @@
 . "$(dirname "$0")/lib/probe.sh"
 
 skip_if_no_perf_probe || exit 2
+[ "$(id -u)" = 0 ] || exit 2
 
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

