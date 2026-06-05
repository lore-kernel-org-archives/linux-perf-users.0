Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1432B9BA;
	Fri,  5 Jun 2026 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661732; cv=none; b=r5N+Uggb5D1o6v0W1vQ7loqaTZHHXZuQqhLey2WneAtH19jf4EX3HJszpbF2m+EnIPja6xIVfiri7YOrlAVUfe7B0mc+3VmfQbK+4N6k7tRa5Vz3uTkCALuoPkG0Kca74pOp+LX4FGef6wiz/y7Xfj+/ItS2RzjnnOQhH+tx+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661732; c=relaxed/simple;
	bh=SF5ZF2BblWfErPptcvocSIo0q8Zm5fWA+7ob7hmIZMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZwYowxdGp+eUzixxi1ari0jrmrLujs7HA88o2KUSkl37CW40N8PVLp+bvJfA8sS4SU8KQFpM9Jie5PC4tu6XwCD0wKX2vsvAOLf9EbKkfQJzrMCoKRCPlgEDU4sEGapctVGywtS1MhQa6iRboq7Lnhs4xxABBpKMi3H3X6q44w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bxf+UBeD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bxf+UBeD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FE91F00899;
	Fri,  5 Jun 2026 12:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661731;
	bh=cGgiqBqVSTzmH2qdKzPTMwaQ+0wTc4gAaPhVbB6NQtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bxf+UBeD+Mboa8EOqm29dt/U3lY+vJxEMrpVv1RMXPNT2Vv39rPhXUffNRZOeD7kX
	 0cSNc465WNO+trW9D7H9/8Ks/5oEHsgTOX1Z9c1nIsGBo6AfSpwUSNkT2oWnYXHOp0
	 48PfHXg3chng/B8f3jS0Qt8q8O0kzfgrPzi/Zc8XXO+CrU3tNdKzGSftiO7qJisx7N
	 b5luLljBa0O2m/OVdVUrpCe99c9LP0bdbmeB+l+noley8/5JQ26sjhyWig6IQz8xiI
	 BgHQLdF2Vlv4GiFg+o6KukTVoVYRhInq+fAu9JYsACcZY3Eq28+S0c2pqRFQFcYjRG
	 YgXB5Y85PXEsg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Anton Blanchard <anton@samba.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 1/5] perf tools: Guard remaining test_bit calls from OOB sample CPU
Date: Fri,  5 Jun 2026 09:15:10 -0300
Message-ID: <20260605121515.1725549-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605121515.1725549-1-acme@kernel.org>
References: <20260605121515.1725549-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

auxtrace.c:filter_cpu() and builtin-script.c:filter_cpu() call
test_bit(cpu, cpu_bitmap) where cpu_bitmap is declared with
MAX_NR_CPUS bits.  When the CPU value from a perf.data event is
corrupt or absent (e.g. negative or >= MAX_NR_CPUS), test_bit reads
out of bounds.

Add bounds checks before test_bit(): >= 0 for the int16_t cpu.cpu in
auxtrace (which also covers the -1 sentinel), and < MAX_NR_CPUS for
both sites.  Matches the pattern applied in the previous series for
builtin-annotate.c, builtin-diff.c, builtin-report.c, and
builtin-sched.c.

Fixes: 644e0840ad46 ("perf auxtrace: Add CPU filter support")
Fixes: 5d67be97f890 ("perf report/annotate/script: Add option to specify a CPU range")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 2 +-
 tools/perf/util/auxtrace.c  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f4aa255fc3297f90..9ac29bdc3cd547e6 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2646,7 +2646,7 @@ static int cleanup_scripting(void)
 
 static bool filter_cpu(struct perf_sample *sample)
 {
-	if (cpu_list && sample->cpu != (u32)-1)
+	if (cpu_list && sample->cpu != (u32)-1 && sample->cpu < MAX_NR_CPUS)
 		return !test_bit(sample->cpu, cpu_bitmap);
 	return false;
 }
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 5f4aa1701aef649a..4cd2caf5401522ca 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -372,7 +372,8 @@ static bool filter_cpu(struct perf_session *session, struct perf_cpu cpu)
 {
 	unsigned long *cpu_bitmap = session->itrace_synth_opts->cpu_bitmap;
 
-	return cpu_bitmap && cpu.cpu != -1 && !test_bit(cpu.cpu, cpu_bitmap);
+	return cpu_bitmap && cpu.cpu >= 0 && cpu.cpu < MAX_NR_CPUS &&
+	       !test_bit(cpu.cpu, cpu_bitmap);
 }
 
 static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
-- 
2.54.0

