Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C3833E345
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jul 2026 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783021934; cv=none; b=JyKBpn9gDfE34rPiDilZAdne9RhVGcjAoRkYx/en8PMtvcu7JfumhZDcQYnOMl9qmUopjztrRS/AxoKEPcRwnBvqYgYMZoYf7/rVmP7rY5fElEMn27JyazE8hE4He1n/KOSc1ddCXkb9bCNYknkcx/fSA1Zg5iA/2rxLN35gAH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783021934; c=relaxed/simple;
	bh=uQlR7xel7MmrLv1fzkhL5iQ+ZZr4TZHfqDQZPXmzRQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fL6ZAL5CyIKPO/f+t5fVAtV0LVfHKvtHFyane6D0CzNCbyImR9EYbRx2IYtRiXFtj1h9o8br0+AaiFtyHKOkcnWqdEq5RMFpZD3aoGBazckah0wJR7abw8pIaKR4bYXIcHhLELAyY26ZPiNrfqgGX5cshUXJyGhKSsEL3FBi/fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UmNM+4Nc; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UmNM+4Nc"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B35A735B7;
	Thu,  2 Jul 2026 12:52:07 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B78B3FAA1;
	Thu,  2 Jul 2026 12:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783021932; bh=uQlR7xel7MmrLv1fzkhL5iQ+ZZr4TZHfqDQZPXmzRQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UmNM+4NcQuluqylmR/yhaXtNkuAyBZr8LjkoTS7ZUfoOMcN7HbAuKv13JEQAKs89d
	 cXEnYG1dDE1Y6kGx+ESSzacWuQxtjGCuAwz4hMY/qMfnQ/yMySfw1VexX0KWDzfz++
	 qO27/LBZyQdqIsonTDc6KoHXC0MwhehgvTYN6DMU=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 02 Jul 2026 20:51:38 +0100
Subject: [PATCH v11 3/9] perf cs-etm: Decode ETE exception packets
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-arm_cs_callchain_support_v1-v11-3-846abbf600d7@arm.com>
References: <20260702-b4-arm_cs_callchain_support_v1-v11-0-846abbf600d7@arm.com>
In-Reply-To: <20260702-b4-arm_cs_callchain_support_v1-v11-0-846abbf600d7@arm.com>
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
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783021918; l=2006;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=uQlR7xel7MmrLv1fzkhL5iQ+ZZr4TZHfqDQZPXmzRQk=;
 b=WJa0icWgMR2Xd5fDMsE9v6XIvj1oxE1Pybh0j89T0GBLzvQF0BNUsTHlQ+I6dBIvim4pPBRHQ
 MrO752zTNsXCoepyI9SNsviZZK3K+ND8aQNq9vRTeJM6cVSLzXa1wz3
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

ETE shares the same packet format as ETMv4, but exception decoding
handled ETMv4 packets only. As a result, ETE exception packets were
not classified.

Recognize the ETE magic for exception number decoding.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 95530e10e010c3c31f9a9c4b6c89b782c66c03b5..0ad6cccc292d6bec1596d4826390762a83c04931 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2202,7 +2202,7 @@ static bool cs_etm__is_syscall(struct cs_etm_queue *etmq,
 	 * HVC cases; need to check if it's SVC instruction based on
 	 * packet address.
 	 */
-	if (magic == __perf_cs_etmv4_magic) {
+	if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic) {
 		if (packet->exception_number == CS_ETMV4_EXC_CALL &&
 		    cs_etm__is_svc_instr(etmq, tidq, prev_packet,
 					 prev_packet->end_addr))
@@ -2225,7 +2225,7 @@ static bool cs_etm__is_async_exception(struct cs_etm_traceid_queue *tidq,
 		    packet->exception_number == CS_ETMV3_EXC_FIQ)
 			return true;
 
-	if (magic == __perf_cs_etmv4_magic)
+	if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic)
 		if (packet->exception_number == CS_ETMV4_EXC_RESET ||
 		    packet->exception_number == CS_ETMV4_EXC_DEBUG_HALT ||
 		    packet->exception_number == CS_ETMV4_EXC_SYSTEM_ERROR ||
@@ -2255,7 +2255,7 @@ static bool cs_etm__is_sync_exception(struct cs_etm_queue *etmq,
 		    packet->exception_number == CS_ETMV3_EXC_GENERIC)
 			return true;
 
-	if (magic == __perf_cs_etmv4_magic) {
+	if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic) {
 		if (packet->exception_number == CS_ETMV4_EXC_TRAP ||
 		    packet->exception_number == CS_ETMV4_EXC_ALIGNMENT ||
 		    packet->exception_number == CS_ETMV4_EXC_INST_FAULT ||

-- 
2.34.1

