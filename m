Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D8B30B536;
	Mon,  1 Dec 2025 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588160; cv=none; b=P3zM0fMGKI/OtfWu84rXLktHr6lWK7nq4Cng6ZjsibPFPkdhmfJHHh3PQLjlVyazDzaBqsBtVRcQv47QJa+YVwXeoi9PxUQuXfbNjrJ3Uoa6wS/IsQpJnFZweyQjki+07217hcxu/9UVOClm+Py01pq9alx0estpSiT/OscxyuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588160; c=relaxed/simple;
	bh=zPgqK7cT5HRw0jmMlFJlZiw1Qze5S36cdWxXgWmVrNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H3KmoOkFEUgENTducTwqp4goJMpeYnbExX/RSAuzcZ0x84MDP6m8LWqduD7h1WYMhExE38dXN0Jh3XRLCwL/6W1iXirjY/q40biDBL84x7FifldK2ZDMTezDjsuOMLn8H156WLkxttcc0CSBtPkqXHrGo8G1kUnfY1RYak78bS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2684153B;
	Mon,  1 Dec 2025 03:22:31 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A46FC3F59E;
	Mon,  1 Dec 2025 03:22:36 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 01 Dec 2025 11:22:01 +0000
Subject: [PATCH 11/19] coresight: trbe: Apply overwrite erratum for only
 wrap event
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-11-7da32b076b28@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=1418;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=zPgqK7cT5HRw0jmMlFJlZiw1Qze5S36cdWxXgWmVrNo=;
 b=0m6xNEMS4HJ8tkJXOqGn+u0uyMMVUB0T6iKZ8Uf469sl+ePiLcER3p8nvin6+E5g9tAzGRpq0
 VvzQeV6frqAD1s3U8PKT/La3jBobNX74D0Auq+2WgksHHITGx/kBW4u
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The overwrite erratum occurs only on wrap events, so apply the extra
wrap condition check in the workaround.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index e579ea98523c24d23a0cd265dcdd0a46b52b52da..2600af12a8fb94bb8c74efda2a101aacd01b0b34 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -714,7 +714,7 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
 	 * 64bytes. Thus we ignore the potential triggering of the erratum
 	 * on WRAP and limit the data to LIMIT.
 	 */
-	if (wrap)
+	if (wrap && trbe_may_overwrite_in_fill_mode(buf->cpudata))
 		write = get_trbe_limit_pointer();
 	else
 		write = get_trbe_write_pointer();
@@ -736,7 +736,7 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
 	 * the space we skipped with IGNORE packets. And we are always
 	 * guaranteed to have at least a PAGE_SIZE space in the buffer.
 	 */
-	if (trbe_may_overwrite_in_fill_mode(buf->cpudata) &&
+	if (wrap && trbe_may_overwrite_in_fill_mode(buf->cpudata) &&
 	    !WARN_ON(size < overwrite_skip))
 		__trbe_pad_buf(buf, start_off, overwrite_skip);
 

-- 
2.34.1

