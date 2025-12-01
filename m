Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085C4255F31;
	Mon,  1 Dec 2025 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588133; cv=none; b=WsCZo0VoARrlKbzjylkAUs+vgLZrXc3zjyCaBKXJmAWwmTYrS8gyYU+rCgnWW19J6h9H4HwwqDVhYEsiy6fsckCWGDWIoKRhDJ9O9JaYGsA4hB1IEiz0EtXqkvvYkeBDA8Fzd0/RbBspi3dR4hZIEc92qsOGqKQkrFAp3AGE6HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588133; c=relaxed/simple;
	bh=WzPIT7JrkPATOGEn6EDeq+ISNkYbUEBxIuW8y7cUFbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MiQFyYI8GfBXukc2aHfgGQBbEeep0Q+Sf++/rMC4CLj5MDnzTRA0HewP4TxD7C7wMAejHHtrG4rUA5C926KgHcPznjTziUiykXBvCmtBv53AGF53Ci4JIuPCVGJ5qr0BIa0yiING9SqVzxl7qnAvdRgbnzVoPmiIy/UT4EXJsQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D39701595;
	Mon,  1 Dec 2025 03:22:03 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B23FC3F59E;
	Mon,  1 Dec 2025 03:22:08 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 01 Dec 2025 11:21:51 +0000
Subject: [PATCH 01/19] coresight: trbe: Use helpers for checking errata
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-1-7da32b076b28@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=1969;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=WzPIT7JrkPATOGEn6EDeq+ISNkYbUEBxIuW8y7cUFbg=;
 b=6YaGZArGMrS7ML/KajEPsrZHMzjRZMdzjMsh9THC9ulWERs8ss1yDgMpkkmrHqS4OsYaWKrUD
 AHKWQAbvmHGBT8OuWGN6d7Z9suNVa+z29sH6HVky3wjkVcKXejOb6h8
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Use the existed helpers for checking errata instead of open coded
equivalent.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 293715b4ff0eb0abe30f9b477700ca94f81cd4a2..0ddb3db0213cf0014e29decfb79da68b0a351b31 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -723,7 +723,7 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
 	 * the space we skipped with IGNORE packets. And we are always
 	 * guaranteed to have at least a PAGE_SIZE space in the buffer.
 	 */
-	if (trbe_has_erratum(buf->cpudata, TRBE_WORKAROUND_OVERWRITE_FILL_MODE) &&
+	if (trbe_may_overwrite_in_fill_mode(buf->cpudata) &&
 	    !WARN_ON(size < overwrite_skip))
 		__trbe_pad_buf(buf, start_off, overwrite_skip);
 
@@ -946,7 +946,7 @@ static int trbe_apply_work_around_before_enable(struct trbe_buf *buf)
 	 *  - At trace collection:
 	 *     - Pad the 256bytes skipped above again with IGNORE packets.
 	 */
-	if (trbe_has_erratum(buf->cpudata, TRBE_WORKAROUND_OVERWRITE_FILL_MODE)) {
+	if (trbe_may_overwrite_in_fill_mode(buf->cpudata)) {
 		if (WARN_ON(!IS_ALIGNED(buf->trbe_write, PAGE_SIZE)))
 			return -EINVAL;
 		buf->trbe_hw_base = buf->trbe_write;
@@ -970,7 +970,7 @@ static int trbe_apply_work_around_before_enable(struct trbe_buf *buf)
 	 *     - Adjust the TRBLIMITR.LIMIT to leave the extra PAGE outside
 	 *       the TRBE's range (i.e [TRBBASER, TRBLIMITR.LIMI] ).
 	 */
-	if (trbe_has_erratum(buf->cpudata, TRBE_WORKAROUND_WRITE_OUT_OF_RANGE)) {
+	if (trbe_may_write_out_of_range(buf->cpudata)) {
 		s64 space = buf->trbe_limit - buf->trbe_write;
 		/*
 		 * We must have more than a PAGE_SIZE worth space in the proposed

-- 
2.34.1

