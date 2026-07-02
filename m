Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3F6372EC6
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jul 2026 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783021944; cv=none; b=R2xUM2FkSK092PClmxyB/8IzaYty5IHXekT4I5V1G+FLhV5zJ91Nb9FkvwCm9axaY+n6y4CDbzAoGXRqlwUboJLKFIS6K8PN4d7Kf6dSGgy7rahhe0lmnEwzYLiLfRRNzBFiCeqxp/SAVT7Ajiiwz9VHCcD//7789Gy+upA/6Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783021944; c=relaxed/simple;
	bh=fWKnWG0XxHYhp737OPV3xLbFPiT3yu4LRky6F/1DhAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GgVUEXITD0JzLRTlfS5sakeUICQqCDe2WJvf0NjmrPaYtCEYr4C4ZFAd/ZdHcdCrS22jBD3pIUXE+q5zGmy40gvw/ORHPg30YXgjrrPzQag+KVNeKUnMpZFZW3dAgbY/gwcyCRHbyeXOsyaU0uaTObo/q+kuPx5oyX4u3KfrobA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fIfgg+Qv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fIfgg+Qv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1ECE35B7;
	Thu,  2 Jul 2026 12:52:17 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 286F93F673;
	Thu,  2 Jul 2026 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783021942; bh=fWKnWG0XxHYhp737OPV3xLbFPiT3yu4LRky6F/1DhAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fIfgg+QvFyZx7l65u1kX6PnBjph4njk8XiZ/VAVZ8zu12tbtG/iar71coIeXK6Gzj
	 BCEH2vSnHuXg6GcG7TPzmhenunl0MinNNHqz1zgiC7MG6WcH0O0O4PPC7/j7lKwU0y
	 cwglbOVkibjY5i+BNCIDPmp7PIB64c6G+hpxXwMY=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 02 Jul 2026 20:51:41 +0100
Subject: [PATCH v11 6/9] perf cs-etm: Flush thread stacks after decoder
 reset
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-arm_cs_callchain_support_v1-v11-6-846abbf600d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783021918; l=2436;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=fWKnWG0XxHYhp737OPV3xLbFPiT3yu4LRky6F/1DhAs=;
 b=EPQypMpJmD7A2fCuPuIa2rBffyHDWk2UmnFx6ll9HkmhERKoZFdEH3iV5rItp6x/SF83wOVsD
 8+09NH/UthAAyrr/COTO18vm2INYDEqaLvA/NOrtBL0ILFo7OJCnaWG
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
 tools/perf/util/cs-etm.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ba9ffb7bdb4bd95c9dc6c323c0d56f516aae56b8..996317687ce7b241afed83444b554155edb09564 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2033,6 +2033,45 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
 
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
+	switch (pid_fmt) {
+	case CS_ETM_PIDFMT_CTXTID2:
+		/* Clear the guest stack if virtualization is supported */
+		cs_etm__flush_machine_stack(etmq, DEFAULT_GUEST_KERNEL_ID);
+		fallthrough;
+	case CS_ETM_PIDFMT_CTXTID:
+		cs_etm__flush_machine_stack(etmq, HOST_KERNEL_ID);
+		break;
+	case CS_ETM_PIDFMT_NONE:
+	default:
+		break;
+
+	}
+}
+
 /*
  * cs_etm__get_data_block: Fetch a block from the auxtrace_buffer queue
  *			   if need be.
@@ -2055,6 +2094,12 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
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

