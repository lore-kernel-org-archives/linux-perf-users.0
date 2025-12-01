Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCEE309EE3;
	Mon,  1 Dec 2025 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588152; cv=none; b=VWQwujOhfswP2yQLDAXeBNSrgcFv+qdjv82NUtd/xDAbDKjpSsz8VSkTb7yJ+7oITwfan+LCSy7tmKKDmjpVMnG2ZnuSigluBU/0gOYlMYjruQrf3q7UgcTwIwB82W1/m+S9yU5InGR+XfoYEpiZNUNmFSmX07DtAhu9ui/twVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588152; c=relaxed/simple;
	bh=45Ukm1pq3z+aAFJGvQBiBA1GyyPqXQWhw0CPZGZjIh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QRrNza3YUyJFTPm+tyr2AswiaSAEtGgq5vikP61jX81Kx/RsaufBBXUaHWLfvCSkxGIIHZun/bSgbedYv2JVOhz9NZAoc3UULtwebiaTnAvxXQ9ZWKVKAgDUgheic9Yudo9WAPBLzmLaZAmLScrVTt3lhacqJBN0LFxJ/sIQfQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6420C1595;
	Mon,  1 Dec 2025 03:22:23 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44CCA3F59E;
	Mon,  1 Dec 2025 03:22:28 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 01 Dec 2025 11:21:58 +0000
Subject: [PATCH 08/19] coresight: trbe: Use PERF_AUX_FLAG_PARTIAL instead
 of PERF_AUX_FLAG_COLLISION
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-8-7da32b076b28@arm.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>, 
 Tamas Zsoldos <tamas.zsoldos@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=2104;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=45Ukm1pq3z+aAFJGvQBiBA1GyyPqXQWhw0CPZGZjIh8=;
 b=rv8WJ/wDAP2cVLXQAucOIQ4EXKHQSz3w7jwIFos9rHOyjzA5djR1DbHPp8dhlSMqvqQTqPf4D
 EaUSOON1dr7BGqkzwUyKzCvEq4yAyZ2fgRMWU7HlzH5QRSKSawtHDUE
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

When tracing stops, there is no collision with other samples, so using
PERF_AUX_FLAG_COLLISION does not accurately reflect the trace state and
may mislead userspace.

Use PERF_AUX_FLAG_PARTIAL instead to indicate that tracing stopped and
the record may contain gaps.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index b06885a08e082fd34f68d9588518807b5c47c86e..0caa4a6b437a3aa39fc6bcc72a23711b54f7c598 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -669,21 +669,14 @@ static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *hand
 	}
 
 	/*
-	 * Mark the buffer to indicate that there was a WRAP event by
-	 * setting the COLLISION flag. This indicates to the user that
-	 * the TRBE trace collection was stopped without stopping the
-	 * ETE and thus there might be some amount of trace that was
-	 * lost between the time the WRAP was detected and the IRQ
-	 * was consumed by the CPU.
-	 *
-	 * Setting the TRUNCATED flag would move the event to STOPPED
-	 * state unnecessarily, even when there is space left in the
-	 * ring buffer. Using the COLLISION flag doesn't have this side
-	 * effect. We only set TRUNCATED flag when there is no space
-	 * left in the ring buffer.
+	 * Mark the buffer to indicate that the trace is stopped by setting
+	 * the PARTIAL flag. This indicates to the user that the TRBE trace
+	 * collection was stopped without stopping the ETE and thus there
+	 * might be some amount of trace that was lost between the time the
+	 * TRBE event was detected and the IRQ was consumed by the CPU.
 	 */
 	if (!is_trbe_running(trbsr))
-		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_PARTIAL);
 
 	if (is_trbe_wrap(trbsr))
 		return TRBE_FAULT_ACT_WRAP;

-- 
2.34.1

