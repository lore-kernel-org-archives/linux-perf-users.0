Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32A438757D;
	Tue, 25 Aug 2026 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654241; cv=none; b=nPtN9CUcBoW4ODCCdoc4h8OvW2jqKr2prWfKPOPNgarxzUdXks5RRhn422/96VVMXqPcOT2oPK6gMAzpdbXZ9kljJpkdD5AaSkD5qbfdZvmwbmFT7VzQ/l+gFaxB5tqxMoOz/K5dbdGCc496/5PnSJcBh9TwrLnsJTYpUfhBG+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654241; c=relaxed/simple;
	bh=rUi2WHUXh0Cj1EV3noMmULzi4UoUtPzWOVC8ZQDqePs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cjXQDK1RgtmnHWjGkfPPDGkBGOK5T0PYTkvoqeI3Dll/E6LE8LgL9LEXd014D7NA12m1jfSqaKbm5hZ5teBFsnVz3T+thmaPOqSHJBeH6icYvOIT3g6SLJpHwh3XnhDw977ZSUz3hNXlJ0nWPpDk/VNeRwSOBte4tIgHl5aMe3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=uVMr8x4I; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="uVMr8x4I"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE8921713;
	Tue, 25 Aug 2026 03:37:14 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 768133F7D8;
	Tue, 25 Aug 2026 03:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787654238; bh=rUi2WHUXh0Cj1EV3noMmULzi4UoUtPzWOVC8ZQDqePs=;
	h=From:Date:Subject:To:Cc:From;
	b=uVMr8x4IqtlLmMQ7vLr2+QhPB89fOlDUv6eSbj4+HBgJjhVnBjy9ee8od9dtfemPg
	 yOVIafVCraIif5Zd8Ry0m6hGrT4CWJho5q2rfgRWxiVQvph8h/7Cj6WPatQKUQ6Shy
	 0XtWrlHUAC2ljBhfFTx+H3+uivASDwfazoAHCkN0=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 25 Aug 2026 11:37:06 +0100
Subject: [PATCH] perf/core: Skip empty AUX records with only format flags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-perf_core_fix_zero_aux_records-v1-1-23b95e8d5df3@arm.com>
X-B4-Tracking: v=1; b=H4sIAFFwjWoC/x2NQQqDQBAEvyJzzoKOqJt8JYRB3DaZiyuzRCTi3
 x1yrKboOqjAFIUe1UGGTYvmxaG5VTR9xuWNoMmZuOa+jtyFFTbLlA0y6y4/WJbxu4vBt1RCjEP
 bDJy4u/fkJ6vBvX/g+TrPCxorGeBwAAAA
X-Change-ID: 20260825-perf_core_fix_zero_aux_records-8873172d2596
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Tamas Petz <tamas.petz@arm.com>, 
 Tamas Zsoldos <tamas.zsoldos@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787654236; l=2913;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=rUi2WHUXh0Cj1EV3noMmULzi4UoUtPzWOVC8ZQDqePs=;
 b=KcMiSjSj/FVKc2tJCmAhcBeMS5wLOe2DZ3+T8IdI9/nQkCrFn4ZB+eg6wEPEBHSV4BlE3RthK
 rwD28QB/QfhBodTWLNtjqarI0KXGAsML/xVYGyHmt0/8AyOJe9gOLD6
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

perf_aux_output_end() emits a PERF_RECORD_AUX when the recorded size is
nonzero or when any flag other than PERF_AUX_FLAG_OVERWRITE is set.

PMU format flags describe how an AUX payload is encoded. TRBE driver
sets PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW for raw trace buffers, causing
an AUX record to be emitted even when no trace data.

This is noticeable when tracing a task with strace. Ptrace stops
repeatedly end empty AUX transactions, producing many zero-sized
PERF_RECORD_AUX records. For example:

  perf record -e cs_etm//u -m,128M -- strace ls

  perf script -D 2>&1 |
     awk '/PERF_RECORD_AUX offset/ {
        for (i = 1; i <= NF; i++)
                if ($i == "size:" && $(i + 1) == "0")
                        count++
     }
     END { print count }'
  165

This recording contains 165 zero-sized AUX records which provide no
useful information to userspace.

Ignore PERF_AUX_FLAG_PMU_FORMAT_TYPE_MASK, together with
PERF_AUX_FLAG_OVERWRITE, when deciding whether an empty AUX record is
useful. Zero-sized records carrying TRUNCATED, PARTIAL or COLLISION
are still emitted.

Fixes: 547b60988e63 ("perf: aux: Add flags for the buffer format")
Reported-by: Tamas Petz <tamas.petz@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 kernel/events/ring_buffer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 9fe92161715e0987520cddb873dd162fd2a77d5c..1b1ffe0533e58a9d976d0eb0fc23e09d5936da2b 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -509,7 +509,10 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 	/*
 	 * Only send RECORD_AUX if we have something useful to communicate
 	 *
-	 * Note: the OVERWRITE records by themselves are not considered
+	 * PMU_FORMAT bits identify the PMU type rather than an AUX event
+	 * has occurred, so ignore them for zero-sized records.
+	 *
+	 * The OVERWRITE records by themselves are not considered
 	 * useful, as they don't communicate any *new* information,
 	 * aside from the short-lived offset, that becomes history at
 	 * the next event sched-in and therefore isn't useful.
@@ -518,7 +521,9 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 	 * offset. So, from now on we don't output AUX records that
 	 * have *only* OVERWRITE flag set.
 	 */
-	if (size || (handle->aux_flags & ~(u64)PERF_AUX_FLAG_OVERWRITE))
+	if (size ||
+	    (handle->aux_flags & ~(u64)(PERF_AUX_FLAG_PMU_FORMAT_TYPE_MASK |
+					PERF_AUX_FLAG_OVERWRITE)))
 		perf_event_aux_event(handle->event, aux_head, size,
 				     handle->aux_flags);
 

---
base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
change-id: 20260825-perf_core_fix_zero_aux_records-8873172d2596

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

