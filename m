Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E77730BBA5;
	Mon,  1 Dec 2025 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588163; cv=none; b=UlpkvAzxjL8b9dmhQ6BbQ+ITP048Wu5nc3fM6QuKWis6GzYZQHu8vKY9+hCR38ny/RnG7DpDmJqH96ZH6Wr/uI/tAc+wOHdyofenge52zPf246kBhX6cvld2sQcSEkgHtBSLwH+TYIrvMpAd8gBhE6lytvKfHW+2xw/FWNFQvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588163; c=relaxed/simple;
	bh=YiG3r48nDifBFjpQKNGxPwH2NFBQuAbAaMlyQ0TBHdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iJo3uVKH7TwtUPpSRWs/K9LHsPdNAG8/nLhwDkfkfGHRzktjbXK0RwBGHJeUfjxQxIlWONtM50k7rnl507hiWthkEhj8bNGg35GhXpDr3QlMUnvcM0+/nvEsca11ObzPHz3jzpur8D3Y8yWnehaXa4MuiY8SFVMr6L3vdKBq1ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 922CD153B;
	Mon,  1 Dec 2025 03:22:34 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7236B3F59E;
	Mon,  1 Dec 2025 03:22:39 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 01 Dec 2025 11:22:02 +0000
Subject: [PATCH 12/19] coresight: trbe: Calculate size for buffer wrapping
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-12-7da32b076b28@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=1661;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=YiG3r48nDifBFjpQKNGxPwH2NFBQuAbAaMlyQ0TBHdQ=;
 b=WPVW4J1nxfTXlcM++NTc5Fb3Dr4++iWibPixr4rGthRR2HcJdd1yTZDLV5JhH0wTwZa+HlfG0
 nA53uhBl3/TDcEZ+p2WMKneTR81p+MedxQaDzmOl2IDiUqG2rs9OIG6
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Calculate the wrapped size when the end position is less than the start.

If the start equals the end, the "wrap" flag is used to decide whether
the buffer is full or empty.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 2600af12a8fb94bb8c74efda2a101aacd01b0b34..48bc03bd339908b5eac9466dc60325ff1b238976 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -696,7 +696,7 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
 {
 	u64 write;
 	u64 start_off, end_off;
-	u64 size;
+	u64 size, buf_size;
 	u64 overwrite_skip = TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP_BYTES;
 
 	/*
@@ -726,11 +726,18 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
 	 */
 	end_off = write - buf->trbe_base;
 	start_off = PERF_IDX2OFF(handle->head, buf);
+	buf_size = buf->trbe_limit - buf->trbe_base;
+
+	if (end_off > start_off)
+		size = end_off - start_off;
+	else if (end_off < start_off)
+		size = end_off + buf_size - start_off;
+	else if (wrap)
+		/* The start is the same as the end, just wrapped */
+		size = buf_size;
+	else
+		size = 0;
 
-	if (WARN_ON_ONCE(end_off < start_off))
-		return 0;
-
-	size = end_off - start_off;
 	/*
 	 * If the TRBE is affected by the following erratum, we must fill
 	 * the space we skipped with IGNORE packets. And we are always

-- 
2.34.1

