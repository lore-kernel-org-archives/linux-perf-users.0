Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452BB3CD8D3
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462262; cv=none; b=fZJqW/XNUhhMHl+YWOcNb1qqE9qN+BhRO9tixBYnPkSmY5oFN1IulPXqnUJiVCcMQk8r2LXRjq6WfcOv++PsY6afcA6l7Mdoc3AgJHRj5kLWXi1rr4kLoEdzNMv/hdHhL60NQ8l9y3gbhHJhJ1CW9JdUbMQzw1d9fhyMaz8KGqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462262; c=relaxed/simple;
	bh=kA5LbSGzSFt0yV/2KASUph8Bp02kP3gLVrrUuWxXR3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sWJwIm+XQ/zcMG1V/0/MlMNHqvvVHqPPtJay6Hth7zsDG/JoSf6wBqagMrZDW5vm61vbBcJIxCzVqw+cADQt3Dm+hUEoVV8WzGYKirxCEw/6oOahJ69OgJn6o1KaYo1TdYtZFTEPaTjIH0T5J8yBlLXSN69XLabutcZPjng5VIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=doX/qdOG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="doX/qdOG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so45419655e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 08:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786462258; x=1787067058; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CbdOfomTAI7oLSknzQNqLoWXfzHYXHRHempsJBX4UAA=;
        b=doX/qdOGaEXQazU+mOEus+PVWQ7TMIqJd8kDLmP2Y5c1pG0KFmprPqyJjprxGfOupw
         gKA/YETT+b602Qw8MONZanT06vCm0e/V9ualoV0sRnKOTm2YRuCKswCG+hrevZUM++Vf
         ENxFrH1a4gSceSx1JwH48LtR6H9TNgX4G4qfdHxkW2bE8YIjOLN6gkc9p5fesXltNDIc
         /sidPbUr2IoZDpz9CSVKslPyiI2YMRV+yHpaeENoI5xfLZQ/ZFAN5mEmJfUwA7yshUTN
         t4ugYyffRx39y8OLV7gE48yakNYRNa5nCtuoiY1T+aVZ8GP5oaiA8niZNlLmApBhC/bv
         ATFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462258; x=1787067058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CbdOfomTAI7oLSknzQNqLoWXfzHYXHRHempsJBX4UAA=;
        b=REW1uvIaQQOmyqqqB3usut6Pv3vNIhS7eodKD0IJ5gSzvj7ii9BpgngzJ4kZyb7Jyb
         9QiuAWlKxZ7xvQhR/K9X97kB360HDwSwE9UocTqt+MiPfvtkHyH0ormtF6JwKVsbJPKf
         xwo1GCs3UItLsIQ/9e+XKakkGhZtmxDxU0qG5MrhZI6K21XevCVKATHIo2ypVPfWkCW/
         6BGrOXzRRgOxtEosM6Lni/IiYqJECS/mhdmGQRYrw0RrcwM/jHszqzp34A1MmlHUCiH6
         rzcGAFt390qaaB5okcKOpG71x/lKcxl4KqGRYueCAoQq7EFT9GvTtIbPIgOj13Cj4OKY
         6aOQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNCDccFTRN5OLF/jvkEDOt+ZTx9vF+64X1b1lAo7xQpgX66z8xbScd7XKkFjuLBRJVlTWQpyl748J7qUP3JrG5@vger.kernel.org
X-Gm-Message-State: AOJu0YxBS/56yyVlNq/M0RJZX7kx7PrF03iRI8moW2p9n88jEZlmwGZu
	py6DVIZUoDcAFcyGB7mg6eEW1R9RZOxiE/bTXJ2A+cTtRjgJCJvhV4NnPeSBsHyYAIE=
X-Gm-Gg: AR+sD12/gf6ATyHH7gpY+nbMbRK+k2K4rUuldHRO0XdKmmBOtoVRjIYignVHLRGoHwe
	ifBUidv7dHcyI7mhK8nwjohd7cV/uYSwNtb4YlkWx1xb1uLGuC1tqzagOOFbyN7nMvXS7If3KUU
	1hXMtispsFrerXgzlSoQfjUUnt/Lb0HWXu0LOHwsgXsq2rai4vKkaKoo8Eourka3NMbBts3unAM
	ORItTHHT3DMrQQOfwXi0k+0czlL5axotl13tizZB0EXhpEfxlEYarql/ulFtUmVFMm3Nrvg1Ksi
	8r9fRiIsWAmAngFShdIw/E8kMvdwL2yFjb2Du3FeM3JtY/D0Zdp7BtSP93T798H9tRXK9B0n4Ct
	wxc/26VXfZOGsoeo/+8XU2TDQNsnxG9Sy8NZfuzgGHHlO5Ca3oPxfVUi4620D5lCwIF1g1d8mcP
	mhqpCHjZYSA284n7FqwZEgzrhjGntiBqB7b+9ukY0eiNapQfZjH85MlrCOx95S8IPHUfQo9CquJ
	5g=
X-Received: by 2002:a05:600c:4594:b0:499:7aa7:eaa7 with SMTP id 5b1f17b1804b1-4997aa7eaafmr2747295e9.15.1786462258292;
        Tue, 11 Aug 2026 08:30:58 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977dfacb6sm49865395e9.1.2026.08.11.08.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:30:57 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 11 Aug 2026 16:30:10 +0100
Subject: [PATCH 07/14] perf arm-spe: Use generic snapshot search
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-james-cs-unformatted-per-thread-fix-v1-7-90565318f5f8@linaro.org>
References: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
In-Reply-To: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>
Cc: Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

The new generic snapshot search gives a similar result as the
reimplemented version of it here. One slight difference is in the
pointer fixup. SPE has:

  *head += mm->len;
  *old = *head - mm->len;

Which gives exactly the same result but written in reverse order to the
generic one:

  *old = *head;
  *head += mm->len;

SPE also had a special fixup case for head pointers greater than the
buffer length, which is not needed because the SPE driver always wraps
them, and __auxtrace_mmap__read() handles that anyway. It also didn't
have the special case for old > head for when the wrap heuristic fails
but the pointers showed a wrap had happened.

The other feature lost is that this search only looked from head to the
end of the buffer, rather than always at the last 512 bytes. This was
flawed because once head is close to the end, it's likely it could
contain zero padding from actual SPE data and a wrap would be missed.
It's better to err on the side of caution and mark as a wrap, rather
than trying to optimize by limiting the search from head onwards.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 147 +----------------------------------
 1 file changed, 2 insertions(+), 145 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 1ba803a8d9b4..d8c4a1d6c621 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -26,7 +26,6 @@
 #include "../../../util/record.h"
 #include "../../../util/header.h"
 #include "../../../util/arm-spe.h"
-#include <tools/libc_compat.h> // reallocarray
 
 #define ARM_SPE_CPU_MAGIC		0x1010101010101010ULL
 
@@ -37,8 +36,6 @@ struct arm_spe_recording {
 	struct auxtrace_record		itr;
 	struct perf_pmu			*arm_spe_pmu;
 	struct evlist		*evlist;
-	int			wrapped_cnt;
-	bool			*wrapped;
 };
 
 /* Iterate config list to detect if the "freq" parameter is set */
@@ -497,146 +494,6 @@ static int arm_spe_snapshot_finish(struct auxtrace_record *itr)
 	return ret;
 }
 
-static int arm_spe_alloc_wrapped_array(struct arm_spe_recording *ptr, int idx)
-{
-	bool *wrapped;
-	int cnt = ptr->wrapped_cnt, new_cnt, i;
-
-	/*
-	 * No need to allocate, so return early.
-	 */
-	if (idx < cnt)
-		return 0;
-
-	/*
-	 * Make ptr->wrapped as big as idx.
-	 */
-	new_cnt = idx + 1;
-
-	/*
-	 * Free'ed in arm_spe_recording_free().
-	 */
-	wrapped = reallocarray(ptr->wrapped, new_cnt, sizeof(bool));
-	if (!wrapped)
-		return -ENOMEM;
-
-	/*
-	 * init new allocated values.
-	 */
-	for (i = cnt; i < new_cnt; i++)
-		wrapped[i] = false;
-
-	ptr->wrapped_cnt = new_cnt;
-	ptr->wrapped = wrapped;
-
-	return 0;
-}
-
-static bool arm_spe_buffer_has_wrapped(unsigned char *buffer,
-				      size_t buffer_size, u64 head)
-{
-	u64 i, watermark;
-	u64 *buf = (u64 *)buffer;
-	size_t buf_size = buffer_size;
-
-	/*
-	 * Defensively handle the case where head might be continually increasing - if its value is
-	 * equal or greater than the size of the ring buffer, then we can safely determine it has
-	 * wrapped around. Otherwise, continue to detect if head might have wrapped.
-	 */
-	if (head >= buffer_size)
-		return true;
-
-	/*
-	 * We want to look the very last 512 byte (chosen arbitrarily) in the ring buffer.
-	 */
-	watermark = buf_size - 512;
-
-	/*
-	 * The value of head is somewhere within the size of the ring buffer. This can be that there
-	 * hasn't been enough data to fill the ring buffer yet or the trace time was so long that
-	 * head has numerically wrapped around.  To find we need to check if we have data at the
-	 * very end of the ring buffer.  We can reliably do this because mmap'ed pages are zeroed
-	 * out and there is a fresh mapping with every new session.
-	 */
-
-	/*
-	 * head is less than 512 byte from the end of the ring buffer.
-	 */
-	if (head > watermark)
-		watermark = head;
-
-	/*
-	 * Speed things up by using 64 bit transactions (see "u64 *buf" above)
-	 */
-	watermark /= sizeof(u64);
-	buf_size /= sizeof(u64);
-
-	/*
-	 * If we find trace data at the end of the ring buffer, head has been there and has
-	 * numerically wrapped around at least once.
-	 */
-	for (i = watermark; i < buf_size; i++)
-		if (buf[i])
-			return true;
-
-	return false;
-}
-
-static int arm_spe_find_snapshot(struct auxtrace_record *itr, int idx,
-				  struct auxtrace_mmap *mm, unsigned char *data,
-				  u64 *head, u64 *old)
-{
-	int err;
-	bool wrapped;
-	struct arm_spe_recording *ptr =
-			container_of(itr, struct arm_spe_recording, itr);
-
-	/*
-	 * Allocate memory to keep track of wrapping if this is the first
-	 * time we deal with this *mm.
-	 */
-	if (idx >= ptr->wrapped_cnt) {
-		err = arm_spe_alloc_wrapped_array(ptr, idx);
-		if (err)
-			return err;
-	}
-
-	/*
-	 * Check to see if *head has wrapped around.  If it hasn't only the
-	 * amount of data between *head and *old is snapshot'ed to avoid
-	 * bloating the perf.data file with zeros.  But as soon as *head has
-	 * wrapped around the entire size of the AUX ring buffer it taken.
-	 */
-	wrapped = ptr->wrapped[idx];
-	if (!wrapped && arm_spe_buffer_has_wrapped(data, mm->len, *head)) {
-		wrapped = true;
-		ptr->wrapped[idx] = true;
-	}
-
-	pr_debug3("%s: mmap index %d old head %zu new head %zu size %zu\n",
-		  __func__, idx, (size_t)*old, (size_t)*head, mm->len);
-
-	/*
-	 * No wrap has occurred, we can just use *head and *old.
-	 */
-	if (!wrapped)
-		return 0;
-
-	/*
-	 * *head has wrapped around - adjust *head and *old to pickup the
-	 * entire content of the AUX buffer.
-	 */
-	if (*head >= mm->len) {
-		*old = *head - mm->len;
-	} else {
-		*head += mm->len;
-		*old = *head - mm->len;
-	}
-
-	return 0;
-}
-
 static u64 arm_spe_reference(struct auxtrace_record *itr __maybe_unused)
 {
 	struct timespec ts;
@@ -651,7 +508,6 @@ static void arm_spe_recording_free(struct auxtrace_record *itr)
 	struct arm_spe_recording *sper =
 			container_of(itr, struct arm_spe_recording, itr);
 
-	zfree(&sper->wrapped);
 	free(sper);
 }
 
@@ -674,7 +530,8 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 	sper->arm_spe_pmu = arm_spe_pmu;
 	sper->itr.snapshot_start = arm_spe_snapshot_start;
 	sper->itr.snapshot_finish = arm_spe_snapshot_finish;
-	sper->itr.find_snapshot = arm_spe_find_snapshot;
+	sper->itr.snapshot_has_wrapped = auxtrace_record__has_wrapped;
+	sper->itr.snapshot_search_bytes = 512;
 	sper->itr.parse_snapshot_options = arm_spe_parse_snapshot_options;
 	sper->itr.recording_options = arm_spe_recording_options;
 	sper->itr.info_priv_size = arm_spe_info_priv_size;

-- 
2.43.0

