Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373236;
	b=X6RToK2PZSMzUfCbi7y3ofLmAlQV/hiD8DqpthTK9NF4JjmVtC5DoZ3iYnJd/p7j6Eky
	 B7FMBuV2F1k0+SPCsCeWaTWO6XvI1YcqnVuTohaHMVWpXW0S0wxucnIrwT6fzrKT0/qpM
	 Wr662hzhMsDC/2Y4QfuAXdhexYBNR2L/QeT/wYjMkJTVLzGk2E9S7Ih8/mefRgLfY5xNi
	 nwJ75ALGThMgxwnnnL015A7KX2zffpO8+gkHl6QHOOKCjTX+o70guOugawfQK+MCpeo/g
	 UvXxu+uWUilDHelchJMLLKH3jstFDbzPaVKHge4tR8AuHcaj4PWC5M0XKBCUh7xKL1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373236;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=idpyB3wgpvjBHxuW32YaXd0au8kRjOVi2L6+27t/1JE=;
	b=oR3Dgi6CiZ91OTAvpx1dakRMJuShsqYedCvFOVFKXEOSP/ydEaPSNeTWX87z+zJ7c9R9
	 xHC0ELZRXfXRfBqAfybQ6g1/2BDW44Yt6bWMkT4yFycyIXtEXETZjMNXm0+5Y4SDsFFqh
	 KlkqycL0OG4FJmOTjPcuID5ekBavs+CvW+QQvTXzKrniRszwQmo8rpv7ot6uRCgtGJaJC
	 79B1DkkzbKYRKr5rZqKSYRXMIgB9MRrM4DG1QRamEjVWs/LUIJ6bPFqTm8FDNC2XQlhNp
	 yb8g1Yuv6z9WXJL5au6SogEd9UD0atORwjOrn8QH44QuhRFjs5ZuCvcWfQRidTqkrYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HGi9Be5T;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5300F606A31E;
	Fri, 30 Oct 2026 15:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5300F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HGi9Be5T
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9941F1682;
	Fri, 30 Oct 2026 08:13:51 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F0EF3F59E;
	Fri, 30 Oct 2026 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793373234; bh=vziERIi8LrySqcEJ/HArFy53XXcyTmszjoyyYLltKXY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HGi9Be5TA9gatIVfYsfZZWHbEXNxTD1DO8KNR2ssmHRAASrTEcLJ/wR6ckGbRwy/s
	 gxBy42hS60MWmZt+ouqEhAHQoByoQh5tDYl157fOTmvdxq7E1YM7pLguA0XO79c0Mr
	 SbTcj0fVtt91B8BUSR8XeyVLcFSc1lkYvGyHTH/s=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 30 Oct 2026 15:13:19 +0000
Subject: [PATCH v3 12/14] perf tests: Check CoreSight syscall entry and
 exit
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-perf_cs_etm_fix_non_taken-v3-12-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793373201; l=1861;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=vziERIi8LrySqcEJ/HArFy53XXcyTmszjoyyYLltKXY=;
 b=0gzf2fGP6i+qnYdLDxfD9HhsKzmG9uwUE2NL2i9X+YxRdS0yFYDQxV2J3sp4Rlac73qbqoXEQ
 FyY3h3HxF0MBW2h9ySe736E6S12Q2VH2FrYHCNZtRMzsjmVj4W7NUfD
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

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../tests/shell/coresight/syscall_entry_exit.sh    | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/syscall_entry_exit.sh b/tools/perf/tests/shell/coresight/syscall_entry_exit.sh
new file mode 100755
index 0000000000000000000000000000000000000000..cf49f9961bf710da2738ef92c12887d5fc1f06d1
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/syscall_entry_exit.sh
@@ -0,0 +1,32 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# CoreSight syscall entry and exit (exclusive)
+
+. "$(dirname "$0")/../lib/coresight_exception.sh"
+
+test_syscall_entry_exit()
+{
+	local attempt result
+
+	# callchain() invokes gettid() through SVC, which returns to PC + 4.
+	for attempt in 1 2 3; do
+		echo "Recording syscalls (attempt $attempt/3)"
+		if ! record_trace callchain; then
+			cat "$tmpdir/record.log"
+			echo "Failed to record the callchain workload"
+			return 1
+		fi
+		decode_trace || return 1
+		check_exception_pairs "syscall" "sysret" 4
+		result=$?
+		if [ "$result" -ne 2 ]; then
+			return "$result"
+		fi
+	done
+
+	echo "FAIL: No complete syscall pair after three recordings"
+	return 1
+}
+
+setup_exception_test || exit $?
+test_syscall_entry_exit

-- 
2.34.1

