Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD630EF7A;
	Mon,  1 Dec 2025 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588184; cv=none; b=sKcdOawW8ijkTTVT2XdIfNErMmYHgAeyOAx4PSb4BtmBLY7xWApg2FMzsDn0TmnJKstqQPj+6daZGa51dEhXBV9RYEeEqpJxUlrfsrviIAzq7ENOICMjpH9GdBF8f8yXjTpGsN5/fg+9lVlRTEH4qm51DRUQ+k78iANPErvxauw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588184; c=relaxed/simple;
	bh=CnLBhlCtv3ztxvAipwj7G3XfegrAX9IB1iFyGNaXBw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oq8hzY/KISFCTGVAb8RW1ML2BCmmsrgj6AsloTwjnaQGoWuecUtbeu211a0u7XmXfJGX2HF2LnzQbv9Sq6QUQq7ll9bd6/ajwlEpvAsWc5krHslutpH5HoZj7oA13egI+SJzRZGltxyPTligkFWJ3JJO1kMBK+D0Q7xgw6ZiZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48F431595;
	Mon,  1 Dec 2025 03:22:54 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28E3E3F59E;
	Mon,  1 Dec 2025 03:22:59 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 01 Dec 2025 11:22:09 +0000
Subject: [PATCH 19/19] perf: cs-etm: Set watermark for AUX trace
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-19-7da32b076b28@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=1279;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=CnLBhlCtv3ztxvAipwj7G3XfegrAX9IB1iFyGNaXBw4=;
 b=JCZvKgPoppyGZi9uQ3L79JfnjD3WKDxqWgyj3lepFbASg8s6jT6fcDbvQWEeQja+YC/BoKXNE
 m0yvrnCCStzDA76g5U7+URc7obMXrMG0frUfWc8f9+16Mg8axWh8mAu
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The default watermark is half of the total buffer size. In many cases,
the tool can not be notified with sufficient free space, especially when
profiling with small AUX buffer (e.g., 64KiB).

Setting watermark to quarter of the buffer to notifies the tool to read
data earlier and prevents the data loss.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index ea891d12f8f40beebf8dee1d3db71cad701f5666..649b8b0d0f92b4af45fb97db9da3c5ccf24a978b 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -424,6 +424,13 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 		pr_debug2("%s snapshot size: %zu\n", CORESIGHT_ETM_PMU_NAME,
 			  opts->auxtrace_snapshot_size);
 
+	if (!opts->auxtrace_snapshot_mode && !opts->auxtrace_sample_mode) {
+		size_t aw = opts->auxtrace_mmap_pages * (size_t)page_size / 4;
+		u32 aux_watermark = aw > UINT_MAX ? UINT_MAX : aw;
+
+		cs_etm_evsel->core.attr.aux_watermark = aux_watermark;
+	}
+
 	/*
 	 * To obtain the auxtrace buffer file descriptor, the auxtrace
 	 * event must come first.

-- 
2.34.1

