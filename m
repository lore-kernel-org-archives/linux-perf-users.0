Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D9931280C
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164651; cv=none; b=TR3iRsVrIwOAaoVQB/NBAxfhdHYMlCtuEY+PDgclraD8g/VgCT+u7WRa6yWZ/X9tef7zc0JQrbWdgcAQteWDyDe1ky2yD6DEKFLS5t6K0VXDmRwdFckkAgXvUv8jiRIYfxsBNLkjwmoPcOJDTLgxtl8ZDfKmCne0EKXip2gZeDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164651; c=relaxed/simple;
	bh=K9XwVhFCJHiYVvXag6p9m+VswzyNDNL7GJxTZTjt/kM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xnba1o2pYWXRDyn+UKrGX2LFDqUaCWp0G0dEYFCnXoQ6SS1Ugf7wTi3jLhDPyP/RZK9Jwhd/oBDtrAeKWMgPCH8O3+4gtcAOznSoGcjz5mjysCIR0UDytRO4vCWtpum/U8GmxwmAoFhdO7DJ9n5LN4LJZzhAd9x0LEpqFfu6bB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rSH3tAan; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rSH3tAan"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A59941E4D;
	Thu, 11 Jun 2026 00:57:24 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F7773FD88;
	Thu, 11 Jun 2026 00:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781164649; bh=K9XwVhFCJHiYVvXag6p9m+VswzyNDNL7GJxTZTjt/kM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rSH3tAanGJjQHPLwk1n/5eRgl15c7+3mCKqnklfpwRQzUKvKCG2efLfhdwppA4aTF
	 fvPHAvu9WBRashsxS2vdC9/+J5+3CHvhBr5E37iki5iq+UY/6WQ2hT/jSewFSV9BA7
	 KWEv1IY1oXWdf+JAB0DMi55t86io6JKOEQagPDPw=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 11 Jun 2026 08:56:59 +0100
Subject: [PATCH v7 5/8] perf cs-etm: Flush thread stacks after decoder
 reset
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-arm_cs_callchain_support_v1-v7-5-1ba770c862ae@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781164631; l=2300;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=K9XwVhFCJHiYVvXag6p9m+VswzyNDNL7GJxTZTjt/kM=;
 b=0yg1JBmAQT7swM7yhElcXxRe5nx0ViHMz/D+rTOFPNmcH8LzoT9N9krxzX9BkP5R97+je3Mfg
 Ips4ayHZytOD+ZNmRuBOwUIFwMLvSHboyXmNkPlFagEUOhJnis4C2t8
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Perf resets the CoreSight decoder when moving to a new AUX trace buffer,
this causes trace discontinunity globally.

For callchain synthesis, keeping thread-stack state after decoder reset
can leave stale call/return history attached to threads that are decoded
later, producing incorrect synthesized callchains.

Flush all host thread stacks after a decoder reset. When virtualization
is present, flush the guest thread stacks as well.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8798bf0471faf3b1813780b45c588263ff6b4416..7069b4990e6107fdece3cc5451142714f1d627ef 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1997,6 +1997,37 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
 
 	return 0;
 }
+
+static int cs_etm__flush_stack_cb(struct thread *thread,
+				  void *data __maybe_unused)
+{
+	thread_stack__flush(thread);
+	return 0;
+}
+
+static void cs_etm__flush_machine_stack(struct cs_etm_queue *etmq, pid_t pid)
+{
+	struct machine *machine;
+
+	machine = machines__find(&etmq->etm->session->machines, pid);
+	if (machine)
+		machine__for_each_thread(machine, cs_etm__flush_stack_cb, NULL);
+}
+
+static void cs_etm__flush_all_stack(struct cs_etm_queue *etmq)
+{
+	enum cs_etm_pid_fmt pid_fmt = cs_etm__get_pid_fmt(etmq);
+
+	if (!etmq->etm->synth_opts.last_branch)
+		return;
+
+	cs_etm__flush_machine_stack(etmq, HOST_KERNEL_ID);
+
+	/* Clear the guest stack if virtualization is supported */
+	if (pid_fmt == CS_ETM_PIDFMT_CTXTID2)
+		cs_etm__flush_machine_stack(etmq, DEFAULT_GUEST_KERNEL_ID);
+}
+
 /*
  * cs_etm__get_data_block: Fetch a block from the auxtrace_buffer queue
  *			   if need be.
@@ -2019,6 +2050,12 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
 		ret = cs_etm_decoder__reset(etmq->decoder);
 		if (ret)
 			return ret;
+
+		/*
+		 * Since the decoder is reset, this causes a global trace
+		 * discontinuity. Flush all thread stacks.
+		 */
+		cs_etm__flush_all_stack(etmq);
 	}
 
 	return etmq->buf_len;

-- 
2.34.1

