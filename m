Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071D531280C
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164642; cv=none; b=MwgUXT8SpLvY0XjynE2/VhN80LdYZ3coh2hAOTKi/JVwtVFYSM+dyUhuJy/eEvDSuVZIKFxTnCIoqsgrahxkWYxPa/zor6ugpPmhY8Imaa2i9KOszvb8/L6VAS0RMz77ye+fWwuCR1DjPx6TqWZ/kgMu8RfdiDVE2SEYAmcH6pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164642; c=relaxed/simple;
	bh=7vX85SCMTjYcpvokZvj/T+O8xSn23+Z4QL/pSBdhFU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pXbpv3ANXGcffw4WI1SncRfXXwwWDg6qLo1/aDGOJ1b1eQ5Ij+c6EimH3oNn3/pC4Qjg+dpbBtDBt7rOAd1TRw0k4Zi7RCljoM6bN38bVBTQP7lRfw2ULJOeh2lNlLYd25nMA/34TzA+DBSknq5kB3jFevnT3zzSk0TTykRPmJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=c9Nvzyoz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c9Nvzyoz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 891B81E8D;
	Thu, 11 Jun 2026 00:57:15 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 862E23FD88;
	Thu, 11 Jun 2026 00:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781164640; bh=7vX85SCMTjYcpvokZvj/T+O8xSn23+Z4QL/pSBdhFU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c9NvzyozU6imyL5kIeYINUx6hwfs4iup0Fm8FiyqCczE6CqpDvYDk27CEmqfxiMVo
	 DK0FBEkuADcYKe0l+CVQD36dp6VMr/FKqkfKkUoQcFrxWV5q4QvKUplpZP1ZMtn08D
	 c4AD2+z4lBZAsdc3vvhc70zVWeZQndW6rjMFDZBE=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 11 Jun 2026 08:56:56 +0100
Subject: [PATCH v7 2/8] perf cs-etm: Decode ETE exception packets
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-arm_cs_callchain_support_v1-v7-2-1ba770c862ae@arm.com>
References: <20260611-b4-arm_cs_callchain_support_v1-v7-0-1ba770c862ae@arm.com>
In-Reply-To: <20260611-b4-arm_cs_callchain_support_v1-v7-0-1ba770c862ae@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781164631; l=2006;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=7vX85SCMTjYcpvokZvj/T+O8xSn23+Z4QL/pSBdhFU8=;
 b=YX6etHrRZ2FzQJeFYYdNW7rQQu+z7tWBxDZ/7FqSPYbK+NTDLjbGimPQdS2vztTtF+0P5x4Cw
 dHOSOQuX15zCMWaH1zOaz0CWTrCe4VPByt4GAc8+otzlNZxOhh513tK
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
index c2b0f98ceee7671d0e98cfe5673c6f4ec19707a5..b4d598ccabbd2551affdc8feed5c63bac4fee98d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2176,7 +2176,7 @@ static bool cs_etm__is_syscall(struct cs_etm_queue *etmq,
 	 * HVC cases; need to check if it's SVC instruction based on
 	 * packet address.
 	 */
-	if (magic == __perf_cs_etmv4_magic) {
+	if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic) {
 		if (packet->exception_number == CS_ETMV4_EXC_CALL &&
 		    cs_etm__is_svc_instr(etmq, tidq, prev_packet,
 					 prev_packet->end_addr))
@@ -2199,7 +2199,7 @@ static bool cs_etm__is_async_exception(struct cs_etm_traceid_queue *tidq,
 		    packet->exception_number == CS_ETMV3_EXC_FIQ)
 			return true;
 
-	if (magic == __perf_cs_etmv4_magic)
+	if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic)
 		if (packet->exception_number == CS_ETMV4_EXC_RESET ||
 		    packet->exception_number == CS_ETMV4_EXC_DEBUG_HALT ||
 		    packet->exception_number == CS_ETMV4_EXC_SYSTEM_ERROR ||
@@ -2229,7 +2229,7 @@ static bool cs_etm__is_sync_exception(struct cs_etm_queue *etmq,
 		    packet->exception_number == CS_ETMV3_EXC_GENERIC)
 			return true;
 
-	if (magic == __perf_cs_etmv4_magic) {
+	if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic) {
 		if (packet->exception_number == CS_ETMV4_EXC_TRAP ||
 		    packet->exception_number == CS_ETMV4_EXC_ALIGNMENT ||
 		    packet->exception_number == CS_ETMV4_EXC_INST_FAULT ||

-- 
2.34.1

