Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF2E402B8A
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814838; cv=none; b=rieTihAgP0RjpM//pYZMGM6nDii8fFboT8LMAkejVRgL+1ABCw04CYPRtio1/qvYWYjo9TwT8N92dQI3BchfMS0KgnAZ7NcWPNXed9qtHkwstmHO4JnLMgL/mu71oR55mMrdxSok9elfQNRqty7tygEn+pQvsMuHzKau791F6jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814838; c=relaxed/simple;
	bh=J/ntCl7VzBrtQENKrucEaX4Y42N52Fp+g6YVBlYCCCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qD40nnnhH6lcZWOOSA/JwyJMCbnrmFqnRP2Jgj+koCJH3BAlTUe9POjx7olQWVnFJT2i8hGGQzs29F6JLVV6CwX+AlAmShcE6J8UWe5HoUd6rqmhB3/bl9B0FmBBZCYFqSte0ANlfzSg7VWhCkPFUIpYYE9h9RbRB4TGN/zp/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YOtpNEbH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YOtpNEbH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46BFF16F2;
	Tue, 26 May 2026 10:00:31 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8CC63F7B4;
	Tue, 26 May 2026 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779814836; bh=J/ntCl7VzBrtQENKrucEaX4Y42N52Fp+g6YVBlYCCCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YOtpNEbH46pEAvwfLJV2AB7plukp0omTkGLNDM/iceC+7kTVqZSeyJCp0lG29OC/D
	 FVe0UWSehHPWnTyjc5VL+9ueGks+sKorFvood6/B9u0U0tUnjit9HL1bQmawx0pUR3
	 U+7cLDJJXzSdlQ8oGhrKP41MuY8/ujtHBG4yoULk=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 26 May 2026 17:59:40 +0100
Subject: [PATCH v6 4/8] perf cs-etm: Flush thread stacks after decoder
 reset
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-arm_cs_callchain_support_v1-v6-4-f9f49f53c9dd@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779814822; l=2249;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=J/ntCl7VzBrtQENKrucEaX4Y42N52Fp+g6YVBlYCCCI=;
 b=KePtYv0tpTolqn5oU4D1fNyf+077Q/UcSBCdYxmwvXQDKBSNL/qiOhvYCQ68oE/BB/Ma0PyyF
 K3/crQ2Ikb/AJ2rOrZvTEDo4yT7QoJ+u17+jYITgDsuTy6+HYL5WLT+
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Perf resets the CoreSight decoder when moving to a new AUX trace buffer,
this causes trace discontinunity globally.

For callchain synthesis, keeping thread-stack state after decoder reset
can leave stale call/return history attached to threads that are decoded
later, producing incorrect synthesized callchains.

Flush all host thread stacks after a decoder reset. When virtualization
is present, flush the guest thread stacks as well.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 398ab3b7a429d402cc8e5f6cccb35c0b7c253732..ea2424175558ddc0a6f20a9de6c30f377facdc52 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1956,6 +1956,37 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
 
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
@@ -1978,6 +2009,12 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
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

