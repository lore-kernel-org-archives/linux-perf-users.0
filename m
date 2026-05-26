Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB85402BA0
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814832; cv=none; b=HcOZXblUkXlpbGnRi5FpVGGXDbZ2x3kc7Yf4QZ2+fbUBTWDH3ILccyvUagvc2t9BQ7NBxzyzIiaVMh6MDf9DG9Sos9X01S5pN7a7VBRTyaiofHJJhJ0vYlhHOFX8D8V2DgOs7kgUauO3YE4oAFNoLX4QMQbHAkOHRaX2MT7iZOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814832; c=relaxed/simple;
	bh=WBHX4FZ3m/MWfi/N4mG+lvTtRVIgmy9WpiYjeKRoPRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V1B15X3Tp/g670GhCKXELeK2EiWEcm3ytVg2APsXEEHMGamA1nEIy7pQBJeU0PA4i7Aor5hgfiivUqmCO3Xkomrl48FXbJKSPYH5JY/CCOI2B/1O7PBQJ1akccl/+keVTuOiUCwXxgGVHMJkaw5OcRx3fS2+afob/qQkhpycYpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cSIUKNY2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cSIUKNY2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0842A2880;
	Tue, 26 May 2026 10:00:23 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC5C63F7B4;
	Tue, 26 May 2026 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779814828; bh=WBHX4FZ3m/MWfi/N4mG+lvTtRVIgmy9WpiYjeKRoPRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cSIUKNY2PMfPKQk/S2DdPFxkcJTFi4qlctPmkWZBibStChJXcvnp9U5K3a1DuYM2g
	 BACTubaqpfyYJt3xDqWlmjTAAuOV9GMXx7kmWRPZLr4Gdl2QdCfYI/uJKtiVR7UXfJ
	 eX9+RMKzVBUcd4O0iOeZ+vImLacLsdrUzZxqwW8E=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 26 May 2026 17:59:37 +0100
Subject: [PATCH v6 1/8] perf cs-etm: Decode ETE exception packets
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-arm_cs_callchain_support_v1-v6-1-f9f49f53c9dd@arm.com>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
In-Reply-To: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>, 
 Paschalis Mpeis <paschalis.mpeis@arm.com>, Amir Ayupov <aaupov@fb.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779814822; l=1964;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=WBHX4FZ3m/MWfi/N4mG+lvTtRVIgmy9WpiYjeKRoPRc=;
 b=De33Lcyk41T/eJvhYwls1cIyCwEpfeZb6CshQBq/HHnLOUFYmsv3NHyLOGH391kqd8VBDcLSy
 7TtvgymWnFmCc7C0hl6dYNFxSZ+au+DjAi/Bmtcl/u6iVxHsjT6IwqI
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

ETE shares the same packet format as ETMv4, but exception decoding
handled ETMv4 packets only. As a result, ETE exception packets were
not classified.

Recognize the ETE magic for exception number decoding.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 6ec48de29441012f3d827d50616349c6c0d1f037..ab79d08f5a6095448470e2c3ec85ff3db2fb5634 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2138,7 +2138,7 @@ static bool cs_etm__is_syscall(struct cs_etm_queue *etmq,
 	 * HVC cases; need to check if it's SVC instruction based on
 	 * packet address.
 	 */
-	if (magic == __perf_cs_etmv4_magic) {
+	if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic) {
 		if (packet->exception_number == CS_ETMV4_EXC_CALL &&
 		    cs_etm__is_svc_instr(etmq, trace_chan_id, prev_packet,
 					 prev_packet->end_addr))
@@ -2161,7 +2161,7 @@ static bool cs_etm__is_async_exception(struct cs_etm_traceid_queue *tidq,
 		    packet->exception_number == CS_ETMV3_EXC_FIQ)
 			return true;
 
-	if (magic == __perf_cs_etmv4_magic)
+	if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic)
 		if (packet->exception_number == CS_ETMV4_EXC_RESET ||
 		    packet->exception_number == CS_ETMV4_EXC_DEBUG_HALT ||
 		    packet->exception_number == CS_ETMV4_EXC_SYSTEM_ERROR ||
@@ -2192,7 +2192,7 @@ static bool cs_etm__is_sync_exception(struct cs_etm_queue *etmq,
 		    packet->exception_number == CS_ETMV3_EXC_GENERIC)
 			return true;
 
-	if (magic == __perf_cs_etmv4_magic) {
+	if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic) {
 		if (packet->exception_number == CS_ETMV4_EXC_TRAP ||
 		    packet->exception_number == CS_ETMV4_EXC_ALIGNMENT ||
 		    packet->exception_number == CS_ETMV4_EXC_INST_FAULT ||

-- 
2.34.1

