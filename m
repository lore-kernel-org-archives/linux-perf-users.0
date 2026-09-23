Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2791D57F746;
	Wed, 23 Sep 2026 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176953; cv=none; b=fLQcWPAgK33PakVvVtsCG6O/xFNkWKeU3AgucBIpIuHdHa0Ol9+3cgMXPjwb1sOmfOEs4JRAnb4HDPZprfSLmnCCUtYFkgPtLMFTCRgWMrI7yondCy/1yV/Cni+oLog6w0XQ0LlcogIJECj/MsE2KojD0kI7TZAajPXLoNIuhik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176953; c=relaxed/simple;
	bh=EMuhC/0lDACH65JGvd017LcTWkEHVrNEuDe6Eoq9Hq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E2PlL+fkrHQvKNRzN28ft7WSuksByDJNEERbW/e3qAVgbBylv1UezC4VUDI+xx1veKvmjCYB/KLPzwpWq3TK95tUo/tWBk5/nR4CiKZqiuwqZqe7ddqSCHJxXvmHpysitfTNWjDS5YJ0adUpEqBhFbHc+LDdZFJBngnmMn6mle4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=O2PVX6RG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="O2PVX6RG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F5631E5E;
	Wed, 23 Sep 2026 08:22:28 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7118C3F86F;
	Wed, 23 Sep 2026 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790176951; bh=EMuhC/0lDACH65JGvd017LcTWkEHVrNEuDe6Eoq9Hq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O2PVX6RGsaXYTOIazTUZVn/nRmiznh3pNplutIBqkaPrRzuQXa6IJbwydmzbIYDzf
	 +i0Jol3K7CKipeq07gZDIPAedBkgPm0V0f4JBw+DkV5ssSbVA52LZBjyc7/VLt63DC
	 Z5jxy5wkACxDL/57lXv8azPCS2gCLHAZop+TRofI=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 23 Sep 2026 16:21:54 +0100
Subject: [PATCH v2 14/14] perf tests: Check CoreSight emulated instruction
 entry and exit
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-perf_cs_etm_fix_non_taken-v2-14-6ab8c07a5455@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790176913; l=2055;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=EMuhC/0lDACH65JGvd017LcTWkEHVrNEuDe6Eoq9Hq4=;
 b=y9kz+vj19LRt/+Lorv7jNh5I5cKJ52fcNPewi0j7HJGoPERH3qYF+Ur/mKSEv5FlvsNgycUWe
 COq2yyIsyXVCaBboOiqTIVziJ8f3J63kVe8fhHgS7jTWpxDrg4TbUf/
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Use traploop's EL0 read of ID_AA64ISAR0_EL1 to check an emulated
instruction. The kernel emulates MRS and advances the return PC by four
bytes.

Select MRS entries by instruction encoding because page faults also
appear as int/iret pairs but return to the same PC. Reuse the common FIFO
recorder and pair checker.

For example, an expected int/iret pair is:

  int            5cc808 => ffff800080010c00 insn: 00 06 38 d5
  ...
  iret ffff800080012284 =>           5cc80c insn: e0 03 9f d6

The entry instruction is MRS X0, ID_AA64ISAR0_EL1. After emulating the
read at 0x5cc808, the kernel returns via ERET to the next instruction at
0x5cc80c.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../perf/tests/shell/coresight/trap_entry_exit.sh  | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/trap_entry_exit.sh b/tools/perf/tests/shell/coresight/trap_entry_exit.sh
new file mode 100755
index 0000000000000000000000000000000000000000..3ebd4033b247a1a43e0139868972afd41ba905ba
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/trap_entry_exit.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# CoreSight emulated instruction entry and exit (exclusive)
+
+# shellcheck source=../lib/coresight_exception.sh
+. "$(dirname "$0")/../lib/coresight_exception.sh"
+
+test_trap_entry_exit()
+{
+	# traploop reads ID_AA64ISAR0_EL1 from EL0. The kernel emulates MRS and
+	# advances the saved PC, so IRET must resume four bytes after the trap.
+	if ! record_trace traploop 256; then
+		cat "$tmpdir/record.log"
+		echo "Failed to record the traploop workload"
+		return 1
+	fi
+	decode_trace || return 1
+	# Page faults also appear as "int", but retry the same PC. Select MRS
+	# Xt, ID_AA64ISAR0_EL1 by its encoding; the low five bits select Xt.
+	check_exception_pairs "int.*insn: [01][[:xdigit:]] 06 38 d5" "iret" 4 || return 1
+}
+
+setup_exception_test || exit $?
+test_trap_entry_exit

-- 
2.34.1

