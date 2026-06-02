Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812D3CAE93;
	Tue,  2 Jun 2026 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444681; cv=none; b=Z4a/TZdr8clJgUuMK+ztGZoj9KjR9NkFuWxqS82cQK5LkGFHQB1M9CizPbSAH8IkLGnh13m4oM5hTJUXqNG2fivoRvNi/UYB+PwxDlvEsKUNjZlX/Y4PHz2vHDdVQLdxlMH0seiUXPOTFbWRasIujCdJQRpKbxhjBihAPPOpGQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444681; c=relaxed/simple;
	bh=QtXAGfzdOo6wDZhvcxzLc7g+4g07Cn858eyEp2pWTyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVFqhf+eTa7NXgqo+AODgnibw9qUAeJekYC+tN8vGZQzyk9g9Tx2nuNT7ogxNiqdToaTJgbHy+3OZgBUROxRE7045dlg4QlCrOVy7e4shN94lu51/9vbefr/ddDDAcKd8y926IFun2NnBv9gPAmdudA9LW3Q9x6zcwatd7qlwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7QGOr0m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7QGOr0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620071F00893;
	Tue,  2 Jun 2026 23:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780444679;
	bh=eXg4kIoAYKSbZy+VQ+kEWyv7CpcOjI0CHDdUrVD0IXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L7QGOr0mA03g2z/lqU/LEVc3UNmBzxefEJXhVbaR1lYI2XIWBs6QZlSkFq0Yi4QWt
	 ZMayOiOiWku378heYSqquJVlIeTDzmcppbiPqDWVOfG3w+PrBryZ1Gc3ZLwZGtuwUR
	 2XAnlAs96bfg2FfeBiEnyYmzjEG7hwYr1m2dERqiSU3fOOOOkcVUHRnPNcp71VD7y/
	 tjYRIvSzPofcdmJh03WSJJfkEDePeHuDSuQPQ0ackx/+tR8pm1MCpSlYEHG5nKRXhf
	 2GeuGCGs3zrFsSg4xLNsnIjVc82O4H5kAuirqsAfx8YC6fGnDTL5fvmmCD9y6NEzAz
	 P5UJMKQ4bi9fA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 8/8] perf test: Add file offset diagnostic test for corrupted perf.data
Date: Tue,  2 Jun 2026 20:57:07 -0300
Message-ID: <20260602235709.1541603-9-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602235709.1541603-1-acme@kernel.org>
References: <20260602235709.1541603-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add a shell test that verifies the file_offset diagnostic messages
work correctly when perf encounters corrupted events.

The test corrupts a MMAP2 event's size field in a recorded perf.data
file, then checks that perf report produces warning messages that
include both the file offset (e.g. "at offset 0x2738:") and the
event type name with numeric id (e.g. "MMAP2 (10)").

This exercises the diagnostic improvements from the file_offset
series, which retrofitted all skip/stop/error messages to include
the position and type of the problematic event.

Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../shell/data_file_offset_diagnostics.sh     | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100755 tools/perf/tests/shell/data_file_offset_diagnostics.sh

diff --git a/tools/perf/tests/shell/data_file_offset_diagnostics.sh b/tools/perf/tests/shell/data_file_offset_diagnostics.sh
new file mode 100755
index 0000000000000000..031f49480d999d8c
--- /dev/null
+++ b/tools/perf/tests/shell/data_file_offset_diagnostics.sh
@@ -0,0 +1,82 @@
+#!/bin/bash
+# Test that perf report includes file offsets and event type names in diagnostic messages.
+# SPDX-License-Identifier: GPL-2.0
+#
+# The file_offset diagnostic series adds "at offset 0x...: TYPE (N)"
+# to all skip/stop/error messages.  This test corrupts an event's size
+# field in a perf.data file, then verifies the resulting warning
+# includes the file offset and event type.
+
+err=0
+
+cleanup() {
+	[ -n "${perfdata}" ] && rm -f "${perfdata}" "${perfdata}.old"
+	rm -f "${corrupted}" "${stderrfile}"
+	trap - EXIT TERM INT
+}
+trap 'cleanup; exit 1' TERM INT
+trap cleanup EXIT
+
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX) || exit 2
+corrupted=$(mktemp /tmp/__perf_test.perf.data.XXXXX) || exit 2
+stderrfile=$(mktemp /tmp/__perf_test.perf.data.XXXXX) || exit 2
+
+if ! perf record -o "${perfdata}" -- perf test -w noploop 2>/dev/null; then
+	echo "Skip: perf record failed"
+	cleanup
+	exit 2
+fi
+
+# Find the file offset of the first MMAP2 event via perf report -D.
+# Format: "timestamp 0xOFFSET [0xSIZE]: PERF_RECORD_MMAP2 ..."
+mmap2_line=$(perf report -D -i "${perfdata}" 2>/dev/null | grep "PERF_RECORD_MMAP2" | head -1)
+if [ -z "${mmap2_line}" ]; then
+	echo "Skip: no MMAP2 events found in perf.data"
+	cleanup
+	exit 2
+fi
+
+mmap2_offset=$(echo "${mmap2_line}" | awk '{print $2}')
+mmap2_offset_dec=$((mmap2_offset))
+
+# Copy the file and corrupt the MMAP2 event's size field.
+# perf_event_header layout: type(u32) misc(u16) size(u16)
+# Set size to 16 (0x10 0x00 little-endian) — below the MMAP2
+# minimum, which triggers the "event size too small" warning.
+cp "${perfdata}" "${corrupted}"
+printf '\x10\x00' | dd of="${corrupted}" bs=1 seek=$((mmap2_offset_dec + 6)) conv=notrunc 2>/dev/null
+
+perf report -i "${corrupted}" --stdio > /dev/null 2> "${stderrfile}"
+
+# Check that warnings include "at offset 0x..."
+if grep -q "at offset 0x" "${stderrfile}"; then
+	echo "File offset in diagnostics [Success]"
+else
+	echo "File offset in diagnostics [Failed: no 'at offset 0x...' found]"
+	echo "  stderr was:"
+	head -5 "${stderrfile}"
+	err=1
+fi
+
+# Check that the event type name and numeric id appear: "MMAP2 (10)"
+if grep -q "MMAP2 (10)" "${stderrfile}"; then
+	echo "Event type name in diagnostics [Success]"
+else
+	echo "Event type name in diagnostics [Failed: no 'MMAP2 (10)' found]"
+	echo "  stderr was:"
+	head -5 "${stderrfile}"
+	err=1
+fi
+
+# Check that the reported offset matches the actual corruption point
+if grep -q "at offset ${mmap2_offset}:" "${stderrfile}"; then
+	echo "Correct offset reported [Success]"
+else
+	echo "Correct offset reported [Failed: expected offset ${mmap2_offset}]"
+	echo "  stderr was:"
+	head -5 "${stderrfile}"
+	err=1
+fi
+
+cleanup
+exit ${err}
-- 
2.54.0

