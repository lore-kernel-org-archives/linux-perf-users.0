Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5DA55D881;
	Wed, 23 Sep 2026 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176925; cv=none; b=nErKhWHhpDcc8hGj7xzNz26ITdy9F6QIV4/XfuBJG3a6byuxXYQImXXEmOLLFoCzQBX12iE0SIWERkN5X34+uOwBX0b6ZIdDIrxrCUAwUwRSTmHS0XurbSZRbtI5I9T693iooObk9Jajn3rYXXHEIu6t8aV9gUbMUVmQ8p8blPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176925; c=relaxed/simple;
	bh=wi+zn9O1qBn5yWetnOxpHDcJ44qEdmWTjDLDoafQLSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lknCnj5qdT2AbYSm0uXnvvVXGoHPt/srBk0El1rR1EmdHPM7NOxczbOnswgRfCPUtZu0iJKL+tonBXFjeKDrluUio6JCNFeR3CoSoEHay+PxKDtWgBuWBnfJWCW5ZHF0uc7k3VvmoIavOlz36dBRLPPNpSILzPDwhv4chuN+BgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=I9GAUcip; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="I9GAUcip"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E15831A32;
	Wed, 23 Sep 2026 08:21:59 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C1B43F86F;
	Wed, 23 Sep 2026 08:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790176923; bh=wi+zn9O1qBn5yWetnOxpHDcJ44qEdmWTjDLDoafQLSY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I9GAUcipFtMhldJOdMoWYOAtPTFQPIy5oEZXM0Xv2Jdx4GHnIf6pff4+m0nN9OiiC
	 EUirc5EwgHte2IV0BGDpcmfcbHfliUwqiZ+moVez3ogYH/rfBpOT1gR3RvTl36WmR+
	 8MWkrpJ4LMSEzomqa8gUIUqA1HZMDFF6+PpTAYA4=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 23 Sep 2026 16:21:43 +0100
Subject: [PATCH v2 03/14] perf cs-etm: Break branch history when
 instruction memory is unavailable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-perf_cs_etm_fix_non_taken-v2-3-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790176913; l=1293;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=wi+zn9O1qBn5yWetnOxpHDcJ44qEdmWTjDLDoafQLSY=;
 b=k24/0ahZeLiRNnrB33kUsNhRAUML1zwRXvPDR6Jf8jGLim1vV4DejcevwOpoXQuEN5zMaWQYr
 eSUZ3XQ6GzrCMLhBEg77kMmYgfB3GBrb+FUe20xOHYt1jswDMKo+2Zr
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The decoder currently ignores OCSD_GEN_TRC_ELEM_ADDR_NACC, allowing a
subsequent range to be paired with stale branch history from before the
unreadable code.

Treat an inaccessible instruction address as a discontinuity and flush
the pending range and branch history before processing subsequent
elements.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 26940f1f1b0bf44c8671d80020597c672c361c1a..35ca1a23e12735416d0d412a949595efc5bfe50a 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -594,7 +594,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 
 	if (type == OCSD_GEN_TRC_ELEM_EO_TRACE ||
 	    type == OCSD_GEN_TRC_ELEM_NO_SYNC ||
-	    type == OCSD_GEN_TRC_ELEM_TRACE_ON)
+	    type == OCSD_GEN_TRC_ELEM_TRACE_ON ||
+	    type == OCSD_GEN_TRC_ELEM_ADDR_NACC)
 		resp = cs_etm_decoder__buffer_discontinuity(etmq, packet_queue,
 							    trace_chan_id);
 	else if (type == OCSD_GEN_TRC_ELEM_INSTR_RANGE)

-- 
2.34.1

