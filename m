Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03D157EDB2;
	Wed, 23 Sep 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176948; cv=none; b=fYjlT5+hmP5Lr3xpEzoIUK7tW4sCLEy88YK5cZNz7A70GVVGvAi3W7cPtqKKeFDx242V8j3BZVPwJ+q/Ycd8Prqt7q3M0ElGvl/A1hto4MrmJQKMl+dRZK/fyKn45tWDHHMpa6fT8/PK+D339RfGC2FOnAMrl7E1suChwZZKGjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176948; c=relaxed/simple;
	bh=9E/qd6jg0Rof28rV1XuWJc0vRTRpsBID5XI48+8mKF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=txCRuAch4lhwO+9zXj/O5/kqlqSE1CrFkvWiPQ+7u4Amd8GXlfLXrrhe2PMotlHPQ/NlyvJZl2/4tWrh5+OE/tChKetKwXu/qZTdhdrO9p21D6aebUzmTAI0K/JwGIjMtcEjDtZjqhCqnqjVtfgLlQCLMpV+fYwVrBu5Kh+BRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=r1MxpRSt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r1MxpRSt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DC811E2F;
	Wed, 23 Sep 2026 08:22:23 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EE3C3F86F;
	Wed, 23 Sep 2026 08:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790176946; bh=9E/qd6jg0Rof28rV1XuWJc0vRTRpsBID5XI48+8mKF0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r1MxpRStJNSPHcgVHysUljDmHSLOivvPbjyzGUsbmeaeI8+jCcZP5RQUUkxW9jW+b
	 mi1ykmFg0y1pysnKpnWbRJWXm78LVppZS6gj0dLfgt/5BwUrHmeQLkUHUGRfSl4IcE
	 84O8igkU6cMBsHMcHEUDLgx+DnaBoMu7O9kBqMbo=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 23 Sep 2026 16:21:52 +0100
Subject: [PATCH v2 12/14] perf tests: Check CoreSight syscall entry and
 exit
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-perf_cs_etm_fix_non_taken-v2-12-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790176913; l=1624;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=9E/qd6jg0Rof28rV1XuWJc0vRTRpsBID5XI48+8mKF0=;
 b=4CWv8CvPVQyYp3GMJIhy/EI7F8lzkLhtsiBFi4MK/qtUj+x8lxsWO24q2hVNbk9PyEaLoTK07
 lvHbqjzePrLCvhm/lD2KxZzHNtPmwGN6lr6wVdBGx2R4BQvISbQ7NC5
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Record the existing callchain workload, which issues gettid() through
SVC. The test requires syscall/sysret pairs to advance the PC by four
bytes.

For example, an expected syscall/sysret pair is:

  syscall           bb76e4 => ffff800080010c00 insn: 01 00 00 d4
  ...
  sysret  ffff800080012284 =>           bb76e8 insn: e0 03 9f d6

The entry instruction is SVC #0 at 0xbb76e4. On syscall completion,
ERET returns to 0xbb76e8, the instruction immediately after SVC.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../tests/shell/coresight/syscall_entry_exit.sh     | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/syscall_entry_exit.sh b/tools/perf/tests/shell/coresight/syscall_entry_exit.sh
new file mode 100755
index 0000000000000000000000000000000000000000..bf61b1fdf6f15e290295afc7577870c6864ddd93
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/syscall_entry_exit.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# CoreSight syscall entry and exit (exclusive)
+
+# shellcheck source=../lib/coresight_exception.sh
+. "$(dirname "$0")/../lib/coresight_exception.sh"
+
+test_syscall_entry_exit()
+{
+	# callchain() invokes gettid() through SVC, which returns to PC + 4.
+	if ! record_trace callchain; then
+		cat "$tmpdir/record.log"
+		echo "Failed to record the callchain workload"
+		return 1
+	fi
+	decode_trace || return 1
+	check_exception_pairs "syscall" "sysret" 4 || return 1
+}
+
+setup_exception_test || exit $?
+test_syscall_entry_exit

-- 
2.34.1

