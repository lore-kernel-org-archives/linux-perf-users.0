Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373241;
	b=tzKs2Eh0XvBB2vwMkITsbCXeyuqTL+QDtTVryJ6QIEriH+1XQ8lUYp/+aGFevqgo+JJK
	 5NGbMiHPrZ2Vwm9SgoB9x9frtjeGjQlbIHBw0L9/KnmlpivQs9js0ZyapP3KthD8KBpGC
	 U6ebQdDZZJ8ylp4A/rr0MVFzORf3U7ZD/bv3Utex7FjiuPANNT6IaOXtDMhRlSSWb0JAE
	 wiDJTaFVjzWxaW+tXUpG2Iokopb4bocKJrQcMnJj9z4BJaaRxll6/SiYdc02HtGdGvy4A
	 QxfCwTphfPt8/FXt9LRH3ul7DipbBae8WgT9mP9Nx68Tg0tmYyqSp5o6n5e39UZfx0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373241;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=+rM42lMVWYrTyqPz3fPMPzSnMbUrQ5yCmC7jK/qTA9M=;
	b=fNkF8bxJa8Mq9nAb/L2GZs5rjTxgFvLKVAG4hD8H83oSdpYe9qtGpyRQcghAVlvVFftX
	 5C2xlM3bLN+LIQRUzJp38ujg5ex33uEa/4SwAcOKuXHn+LEujc94yN6YiYSaxfc8k1oZi
	 DMSY+v8reRGhHIekwCSICo6OMOo7GdvxxA7ySnSSQnM8McMB9AQhW4rEZ/XsobvCpbXIv
	 56SOqCSBchXvmSVfFJqNBZgjRlvj0b8isM8PZUoSZHojxa2CBydzcRIonoIwAB7NcIVIi
	 FAUrjLB6Sv6oKroYFKNGLWm85wS0iX0lECkvkAaebLzOWb+PQQGWIV6HehzEaxPxFIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LuAd9ScQ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8215E606A33D;
	Fri, 30 Oct 2026 15:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8215E606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LuAd9ScQ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9FF91682;
	Fri, 30 Oct 2026 08:13:56 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A22B23F59E;
	Fri, 30 Oct 2026 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793373239; bh=ud+KGbq8vc4zGQ8mJPdEUGfwVQqtsWXdPrjpP0/C8CA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LuAd9ScQsOiJzzolp6bSj5UdKDSOyu1j+JUaW5x7BIlJXffN/JGqSZNj5Gc30j0Dy
	 45Im3CEQwhKy4jfl5IdFCi8rg7lu1iXxPkO3baiwt4RUFw0HT1+Inh+aVb4DCCePUY
	 RjVJPP1oGq1vyHMtOyIV1BnnQ+bVT7e4DBZfVqQ4=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 30 Oct 2026 15:13:21 +0000
Subject: [PATCH v3 14/14] perf tests: Check CoreSight emulated instruction
 entry and exit
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
Message-Id: <20261030-perf_cs_etm_fix_non_taken-v3-14-7629b52ab047@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793373201; l=2576;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=ud+KGbq8vc4zGQ8mJPdEUGfwVQqtsWXdPrjpP0/C8CA=;
 b=J+IpPXgeZpt+yD5qjm+xAxSH2eL2hkn8/kHiIR8jsu3OebW9Ysc7gBjHTyKPgCecuuDCBoBkD
 lS0wmbWXA3WBJ6bc5Bk8FP+TPT2Z+fVUa7tVyUx5nprMxNE1N8044pK
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Use traploop's EL0 read of ID_AA64ISAR0_EL1 to check an emulated
instruction. The kernel emulates MRS and advances the return PC by four
bytes.

Select MRS entries by instruction encoding and reuse the common FIFO
recorder and pair checker. An instruction page fault at MRS also matches
the opcode filter and returns to the same PC. Retry recordings when the
pair check fails or finds no complete pair, and fail after three
unsuccessful attempts. Recording and decoding errors fail immediately.

For example, an expected int/iret pair is:

  int            5cc808 => ffff800080010c00 insn: 00 06 38 d5
  ...
  iret ffff800080012284 =>           5cc80c insn: e0 03 9f d6

The entry instruction is MRS X0, ID_AA64ISAR0_EL1. After emulating the
read at 0x5cc808, the kernel returns via ERET to the next instruction at
0x5cc80c.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../perf/tests/shell/coresight/trap_entry_exit.sh  | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/trap_entry_exit.sh b/tools/perf/tests/shell/coresight/trap_entry_exit.sh
new file mode 100755
index 0000000000000000000000000000000000000000..4521e4f4ba58100c7da7a915d729df7ad814f031
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/trap_entry_exit.sh
@@ -0,0 +1,39 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# CoreSight emulated instruction entry and exit (exclusive)
+
+. "$(dirname "$0")/../lib/coresight_exception.sh"
+
+test_trap_entry_exit()
+{
+	local attempt result
+
+	# traploop reads ID_AA64ISAR0_EL1 from EL0. The kernel emulates MRS and
+	# advances the saved PC, so IRET must resume four bytes after the trap.
+	for attempt in 1 2 3; do
+		echo "Recording emulated instructions (attempt $attempt/3)"
+		if ! record_trace traploop 256; then
+			cat "$tmpdir/record.log"
+			echo "Failed to record the traploop workload"
+			return 1
+		fi
+		decode_trace || return 1
+		# Select MRS Xt, ID_AA64ISAR0_EL1; the low five bits select Xt.
+		check_exception_pairs "int.*insn: [01][[:xdigit:]] 06 38 d5" "iret" 4
+		result=$?
+
+		# An instruction page fault at MRS can also match the opcode filter.
+		# Retry failed checks to tolerate such transient faults.
+		case $result in
+		0) return 0 ;;
+		1|2) continue ;;
+		*) return "$result" ;;
+		esac
+	done
+
+	echo "FAIL: No valid trap pair after three recordings"
+	return 1
+}
+
+setup_exception_test || exit $?
+test_trap_entry_exit

-- 
2.34.1

