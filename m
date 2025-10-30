Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13072264DC;
	Thu, 30 Oct 2025 03:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761794845; cv=none; b=fq1zzA2aLtwbGsky7DxmrxIP/qL8uPlfq/DTE/TWbH6jdBfl4ZtfPx6ox2IQduo4a8dpP1Kswh3nNnxpxlfe4KTrFktLcjpyRwnh0kzLvxSOh5Sbm2kieessAIrfxMU5i+tQZjxS//WHXogVr6eaKpS3FFWio6bj0Gw/y0VMsgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761794845; c=relaxed/simple;
	bh=jJ98GA8lXMZB+PEb4XMuc+DVI+yBUyfVXN3flVjshBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxJbja+Ib7siGkKv3buQbbjPVQK19VSTHtytAKcLgyWUMMlg6Fy0mfg5m5eyrE8FmiocyKXPBVarKC22c2BeEylA5LLIhkV/3occP/qcu6lfpIHm7Kd8gjXbz62EScMxtfmv8KcZF2e7rlVhQOSv84QR+LGEp/sB4ZeQRUoIsPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPhrbrJK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPhrbrJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67336C4CEF7;
	Thu, 30 Oct 2025 03:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761794844;
	bh=jJ98GA8lXMZB+PEb4XMuc+DVI+yBUyfVXN3flVjshBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPhrbrJKxNk4PO3YGKRuaN44F7Ub0QfEnH8eiksF0Qmd1qeAp/bp+iKaa1pcD/lEY
	 umPyzuyB31d/ubl88s5JEMbkoarzZf+ZEYo6jQDoafKfTKOjD44Z6rt0Y5ygQpnuK4
	 u7xolnYjGGpFv3E+2nNZkFROqo4NmRTzcvHA65hpWsJmeGIIE+MIgK9JgF7TBvzA3N
	 LM8lHyfkURqAMHsWD8LAOLEX5NDX3my6BbmsqmEYmcf7KV/DVk4S+K80AKVqhhSUjD
	 DQy64zffDRyTIHq9zO4iQYwS3FR/aYIh3DYB06HDJpPRPBLoF368p/YMsYNwspdUOf
	 uCbSt1wrwDG6Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] tracing: wprobe: Make wprobe_handler default overflow_handler compatible
Date: Thu, 30 Oct 2025 12:27:19 +0900
Message-ID: <176179483888.959775.5748906728818431150.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <176179481538.959775.12326313742393696258.stgit@devnote2>
References: <176179481538.959775.12326313742393696258.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

To fix arm64 repeating watchpoint exception on the same instruction
bug, markthe wprobe handler as compatible with the default overflow
handler.

Since do_watchpoint() on arm64 does not configure the single step
execution correctly if the overflow_handler is not compatible with
default perf overflow handlers, custom handler will loop on the
same instruction by repeating watchpoint exception. But if the
overflow handler is compatible with the default handlers, it
configures the single step. So set the compatible flag since
wprobe_handler will not care arch-dependent case.

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/aPvwGhMBJqMKcC9D@finisterre.sirena.org.uk/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_wprobe.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
index 98605b207f43..f2c2f26fd668 100644
--- a/kernel/trace/trace_wprobe.c
+++ b/kernel/trace/trace_wprobe.c
@@ -163,6 +163,8 @@ static void wprobe_perf_handler(struct perf_event *bp,
 static int __register_trace_wprobe(struct trace_wprobe *tw)
 {
 	struct perf_event_attr attr;
+	struct perf_event *bp;
+	int cpu;
 
 	if (tw->bp_event)
 		return -EINVAL;
@@ -179,6 +181,11 @@ static int __register_trace_wprobe(struct trace_wprobe *tw)
 		tw->bp_event = NULL;
 		return ret;
 	}
+	/* Mark wprobe_perf_handler is compatible with default one. */
+	for_each_online_cpu(cpu) {
+		bp = per_cpu(*tw->bp_event, cpu);
+		bp->default_overflow_compatible = true;
+	}
 
 	return 0;
 }

