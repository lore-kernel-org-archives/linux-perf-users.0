Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567308;
	b=CE69pwPUuBtvELY+TbU/UwTApxUxcHo9MsEssR1oXFSn0gwlmKTKXJnBtz25x7oavTK8
	 nkffjVvjiTxJ8ViTk3YoteaRxOnc+2sInNsfyfEUcwmLk08dd8zZ/wHyB+Eq+es00UmiB
	 QbwtRyX6uPuhtMXqxWHn8QVeFbZS9Yco1xwreFgisAcLKb8oyiJSOSVs+OLjMt55G3Cga
	 J3fMO9jyZ0+y8RtKFuXXx/4zxyYRhRtLySGhovh4/peOqSeIRM9DrUVhBvCUJ86YCmGFx
	 4kHHeVv6/CAoVNT52dBbpBel/HipKEkma1WTxbdXeJbTqduurZ3vEORp2qYvbz0qxCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567308;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Lw3qKSNbN4hz3Jc1cpyCWweNlOBTCykjd+brmlscD7Y=;
	b=vNb1/UGBU/qqylHbgagiBC859MZmewZ8+PGiRGp5q8KxmlNeRbs9+wPAauu0a4Y9SE+H
	 7LE2fmCtzhsF4Aq4DNZfQ4y2ndBTsCpnhreZxrVJVJNncRy5JCBzoqDzIDfq9q7a90jkv
	 ypNwGrh6c/9NTJgd6jaaw4EM9kzYEows3Wld2bBBG6hq/1hSIMCUzbePtXsfK9sHYdklu
	 RXJFWFLtlUTJ1SBNfyrTdxr6wFXBQQ+9dDFg3rs4CNvpvX1peJSlRDCKqFcGpyTqWf9po
	 W49aBvGHDuI1RuNsPqyFXcBNsFlbl6CKOfW9xS5zRXRHoG6X5+uP70waf5iYA8n/eUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CUOObnwM;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F34D606A883;
	Fri, 13 Nov 2026 10:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F34D606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CUOObnwM
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E06371C00;
	Fri, 13 Nov 2026 02:55:04 -0800 (PST)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B23963F673;
	Fri, 13 Nov 2026 02:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794567307; bh=LEf+1vXrAc9uWP+E08EDnDlvFIEOjLT7EK8mZNHIzGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CUOObnwMRjA9BOm/c7n1/95VTjMMHGwyYOlOr+DFS97WkC8jb9voX5UvO571X93vI
	 IEOVYMCClwDz7siu6SD11qXej+XRV9o7NOw7y2sccnFNNRX3we6DeEKCMhhEGkdJvS
	 qvHjSVUp90JddwAwRfXNQEpFJNbPtKzhROunwuw8=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 13 Nov 2026 10:54:53 +0000
Subject: [PATCH 2/3] perf cs-etm: Use the packet instruction size for stack
 events
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-perf_fix_gcc15_failure-v1-2-eae592c5ff64@arm.com>
References: <20261113-perf_fix_gcc15_failure-v1-0-eae592c5ff64@arm.com>
In-Reply-To: <20261113-perf_fix_gcc15_failure-v1-0-eae592c5ff64@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>, 
 Mike Leach <mike.leach@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Robert Walker <robert.walker@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794567301; l=1680;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=LEf+1vXrAc9uWP+E08EDnDlvFIEOjLT7EK8mZNHIzGY=;
 b=4XRdn06lAFNnamoomk1N7++y4cIUmiZqCxMfKc8r7N/TrPI8AtFgbpVGIQoShPyZKc2m6Vn1U
 +YxhLp+InyyAdYyCuxpdVUC8BNlQa8hRy35sZQWwRpDA+BkFfGrsApy
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

cs_etm__add_stack_event() uses the last executed instruction of the
previous packet as the branch source. The decoder already records this
instruction's size in last_instr_size, including for T32 instructions.

Use the recorded size directly instead of reading instruction memory
again. This removes an unnecessary read and the dependency on DSO data
when updating the thread stack.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 25f12bd110934a204d79244f45317085b7a81666..312d4a734e84faa0d24c4ac1fee16f4dae4c2398 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1626,7 +1626,6 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
 	u64 from, to;
-	int size;
 
 	if (!etm->synth_opts.branches && !etm->synth_opts.instructions)
 		return;
@@ -1638,11 +1637,10 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
 		from = cs_etm__last_executed_instr(tidq->prev_packet);
 		to = cs_etm__first_executed_instr(tidq->packet);
 
-		size = cs_etm__instr_size(etmq, tidq, tidq->prev_packet, from);
-
 		/* Enable callchain so thread stack entry can be allocated */
 		thread_stack__event(tidq->frontend_thread, tidq->prev_packet->cpu,
-				    tidq->prev_packet->flags, from, to, size,
+				    tidq->prev_packet->flags, from, to,
+				    tidq->prev_packet->last_instr_size,
 				    etmq->buffer->buffer_nr + 1,
 				    etmq->etm->use_callchain,
 				    tidq->br_stack_sz, 0);

-- 
2.34.1

