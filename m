Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D6C38655D
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189483; cv=none; b=XaqSj5BLE8vD/TgJN36DZ5BkOmbIYSN6WrHg/zttxCrDQhgrWQJbCP/RAL1g5xhILLiL7UFniyWyprpT/Q0Y4nTfVbCcD240R48QV3eVdYyRmwbldc7zpxbfjoCxFuN2h5Yitb0BkaZLrtD87k+5jxN+fd12MfVUtnz4ZdHvVkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189483; c=relaxed/simple;
	bh=K9XwVhFCJHiYVvXag6p9m+VswzyNDNL7GJxTZTjt/kM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pi0SaOohLJeHroLCnBAMvWYsDgAF7MvbNh1LTwNIXSbFrSZw97keAWunos7+5HFQSoZkE9+DQW2/mxMhnDGg7hpnT7pPWGuu92Y2E/Y5q7EUYcZQVX663vpbqc4Px6xAet4ZGXU6K/+QdLXQjLHzOeUtPF/T2sTRk/EQtHRcIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TJD2ub1b; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TJD2ub1b"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D17825DC;
	Thu, 11 Jun 2026 07:51:16 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B96363FBB1;
	Thu, 11 Jun 2026 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781189481; bh=K9XwVhFCJHiYVvXag6p9m+VswzyNDNL7GJxTZTjt/kM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TJD2ub1bR+0cNX60rEtnES6iwZ2MjcFN/QQXXBmoLED3BvDYBSiAQe1NGbs5AMl8c
	 eE17oa5LL56wNRd8yKj+8XwK/cMG72n95O1CdJ5gDIRpTagHj+p425pfp7NWbu4vmz
	 6Zp0bSqPmXBcGykxkFBsbYL09bsw9WOJfpwBZrOs=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 11 Jun 2026 15:50:51 +0100
Subject: [PATCH v8 5/8] perf cs-etm: Flush thread stacks after decoder
 reset
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-arm_cs_callchain_support_v1-v8-5-737948584fea@arm.com>
References: <20260611-b4-arm_cs_callchain_support_v1-v8-0-737948584fea@arm.com>
In-Reply-To: <20260611-b4-arm_cs_callchain_support_v1-v8-0-737948584fea@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781189463; l=2300;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=K9XwVhFCJHiYVvXag6p9m+VswzyNDNL7GJxTZTjt/kM=;
 b=I9bMn6+jXkNR+6Vgz4pWchYLzr1/Cd8XLA30H8ppXu9efcLKlkSvx/jqrVm/K9otwqKvv7+p5
 uJ5jmx7+ALIALBU/ukZC4/Fm92KFyFEte3VIUtM+ZWSN4VaHxVD9vMb
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

