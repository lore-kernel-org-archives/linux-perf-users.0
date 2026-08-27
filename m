Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C70476CDA;
	Thu, 27 Aug 2026 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840606; cv=none; b=P4GmEpsT8dNfpW2aOJ5NFP6wbucmWzhRRZEwjxZCYTA52h0eH2ZiJHklhioDWdZFA/TuG24bMNk9pyB+nVfEJL7cfFuaadVrzi5v71ROoXg8cfyWV2LgCgG2KkCWEv3Mmi6eiTtXQHQzLKGL6dIKendpRkj9naIXAPVErmJuZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840606; c=relaxed/simple;
	bh=tHclhW10DdKL3P7paEhkIsa1U3Qcv9fg9VwwzjNjh1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YeQkArJEsOZh3Ct1d/DA/zbjvjmyeGpYP7lWB/f2IUusSYR0kenrza3cjC/PzaJ62rC6aj4RhA4B6ca2sFsQZikF6L58KSLYlFaZauX/MNnvaclNgeJuy/uFx34HklyOFIo/3w1WLFKM0Qw450Zm1KU5VlQmCTtGZlmfT5cxN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CcfNyXWU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CcfNyXWU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC3F11691;
	Thu, 27 Aug 2026 07:23:11 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C6103F85F;
	Thu, 27 Aug 2026 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787840595; bh=tHclhW10DdKL3P7paEhkIsa1U3Qcv9fg9VwwzjNjh1Q=;
	h=From:Date:Subject:To:Cc:From;
	b=CcfNyXWUmkrJTSbvIJBFxwD2mVfKQiZ3EVqdatxiu5akyni4Up7JdmupVodPBpP3j
	 3AVUzYKH3N0nVELPL/I0uKtj7vJLUdGMxv1w+erKDMOXXTHseGX1Pk7ytGLkc36QRt
	 rs+Ias21d5u3Xs4JhwRSnIFidg9TD38jg0bZQ86M=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 27 Aug 2026 15:23:06 +0100
Subject: [PATCH v2] perf/core: Skip empty AUX records with only format
 flags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-perf_core_fix_zero_aux_records-v2-1-c41f2e7d056c@arm.com>
X-B4-Tracking: v=1; b=H4sIAElIkGoC/42NQQ6CMBBFr0JmbQ0dUiiuvIchDbZT6QJKpkpQw
 t2tnMDle/l5f4NEHCjBpdiAaQkpxCkDngqwQz89SASXGbDEutSoxEzsjY1MxofVfIij6V+rYcr
 OJaF1U8kGHaq2hhyZmfLuOLh1mYeQnpHfx98if/bv9CKFFFjdW0XaKeera8/j2cYRun3fv1wcl
 BDKAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787840593; l=4757;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=tHclhW10DdKL3P7paEhkIsa1U3Qcv9fg9VwwzjNjh1Q=;
 b=0CCB4/Thf2zf4ArIx3WpP/vnWEkHqxhJttVyYhzzAZrn5LT55i15hkSKFPvEJz94bpBSfLgg0
 CpCujy9HICFDTvjPRSBxtK5L/cJIe/jcbZY3VcR5kX2Mu90xI4EFm56
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

Introduce a helper perf_aux_flags_need_record() to check if need to
emit an empty PERF_RECORD_AUX record for AUX flags. Allow TRUNCATED,
PARTIAL and COLLISION, which remain meaningful without trace data.
Move the comment to the helper for readable.

Keeping an explicit list also ensures that future flags are evaluated
before they are permitted to generate empty records.

Fixes: 547b60988e63 ("perf: aux: Add flags for the buffer format")
Reported-by: Tamas Petz <tamas.petz@arm.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v2:
- Used flag list for generating RECORD_AUX (James).
- Link to v1: https://lore.kernel.org/r/20260825-perf_core_fix_zero_aux_records-v1-1-23b95e8d5df3@arm.com
---
 kernel/events/ring_buffer.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 9fe92161715e0987520cddb873dd162fd2a77d5c..e81b987319de4707aea46243b5f04ae368e57820 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -477,6 +477,35 @@ static __always_inline bool rb_need_aux_wakeup(struct perf_buffer *rb)
 	return false;
 }
 
+/*
+ * Emit an empty PERF_RECORD_AUX only for flags that report conditions which
+ * userspace needs to observe. Keep an explicit list so that future flags
+ * are evaluated before they are permitted to generate empty records.
+ *
+ * TRUNCATED, PARTIAL and COLLISION report trace loss, gaps or collisions and
+ * remain meaningful even when the record contains no trace data.
+ *
+ * OVERWRITE records by themselves are not considered useful, as they don't
+ * communicate any *new* information, aside from the short-lived offset, that
+ * becomes history at the next event sched-in and therefore isn't useful. The
+ * userspace that needs to copy out AUX data in overwrite mode should know to
+ * use user_page::aux_head for the actual offset. So, from now on we don't
+ * output AUX records that have *only* OVERWRITE flag set.
+ *
+ * PMU format flags describe how to interpret an AUX payload and provide no
+ * useful information when there is no payload, so don't include them.
+ */
+static __always_inline
+bool perf_aux_flags_need_record(struct perf_output_handle *handle)
+{
+	if (handle->aux_flags & (PERF_AUX_FLAG_TRUNCATED |
+				 PERF_AUX_FLAG_PARTIAL |
+				 PERF_AUX_FLAG_COLLISION))
+		return true;
+
+	return false;
+}
+
 /*
  * Commit the data written by hardware into the ring buffer by adjusting
  * aux_head and posting a PERF_RECORD_AUX into the perf buffer. It is the
@@ -506,19 +535,8 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 		rb->aux_head += size;
 	}
 
-	/*
-	 * Only send RECORD_AUX if we have something useful to communicate
-	 *
-	 * Note: the OVERWRITE records by themselves are not considered
-	 * useful, as they don't communicate any *new* information,
-	 * aside from the short-lived offset, that becomes history at
-	 * the next event sched-in and therefore isn't useful.
-	 * The userspace that needs to copy out AUX data in overwrite
-	 * mode should know to use user_page::aux_head for the actual
-	 * offset. So, from now on we don't output AUX records that
-	 * have *only* OVERWRITE flag set.
-	 */
-	if (size || (handle->aux_flags & ~(u64)PERF_AUX_FLAG_OVERWRITE))
+	/* Only send RECORD_AUX if we have something useful to communicate */
+	if (size || perf_aux_flags_need_record(handle))
 		perf_event_aux_event(handle->event, aux_head, size,
 				     handle->aux_flags);
 

---
base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
change-id: 20260825-perf_core_fix_zero_aux_records-8873172d2596

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

