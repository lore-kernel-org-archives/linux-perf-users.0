Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5CC4C14FA;
	Tue, 15 Sep 2026 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487412; cv=none; b=UBrsU/smeQLbdUftE+o1fFVddjsuedYyCXmTDCOgNdR8XHC3vhJabg9u46AVGZ0UPLfJqYNTJfv7j/nS42zM6jlZUH/+RG1YETtbTMKlXkQfPRfgiS8/c1FwfZWZ5Fq7gnvsCSplQg9ruHGvkHmWS6F9gww4PNP8OFPb84DYxWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487412; c=relaxed/simple;
	bh=lVZAl+1VuCBKIxAJbqmvv4H5T5nJSZSgCMMDFerPAQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N2QTDPfsI1/LAKM5t3DqiK8XTY4nnE/vXFtnTm6dwjvoVIPJvKeOB+qXi3G0TATLi4PdaVpyTg3ZyDMOxaQbOAT1QKzeQeXNq+o2P3G4+YoCxoceM0Y+4JTAfxUTQsp2RU6o0WlViL4HgRKBbB8+RvL8IJiZEGRK1AFfYZjtsY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ExkSaBJo; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ExkSaBJo"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EE711570;
	Tue, 15 Sep 2026 08:50:06 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93D623F882;
	Tue, 15 Sep 2026 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487409; bh=lVZAl+1VuCBKIxAJbqmvv4H5T5nJSZSgCMMDFerPAQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ExkSaBJoAMNwxm+ZhzKUfYC/Xcf5kDN8atZv3BhBSawhhHcZEzSSuetTJ3ClfUsEK
	 eKuGkiPPqRWVlERgQQbO49QhRWlo9s28Y/2v/I8SiSTHhWQDfpOXe4S9IXrTIJBlpN
	 JCuQsUDmbi6Q6Y1gOoMGPZpKSuPrlz50Y95hw66Q=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:49:11 +0100
Subject: [PATCH 25/25] Documentation: coresight: Document AUX sample
 decoding
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-25-35cf6f297d20@arm.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487341; l=3171;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=lVZAl+1VuCBKIxAJbqmvv4H5T5nJSZSgCMMDFerPAQM=;
 b=XjxNu2wRoGrUaTZHtHM2Yf1eAsTXNzo+4/Umo08aBPRMMhqEKSEPnPqtp1q9c0Kfj7e3hWMIc
 KXpp1K5QzZrDEQ7FZ4kRoP89qkLuUIUk355gwdtfbw/ZpJbg6jXuNjk
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Describe recording AUX trace in PMU samples and generating callchains
and branch stacks with --itrace=G and --itrace=L.

Explain the default decoding behavior, preservation of recorded stacks,
context ID requirements and decoding limitations.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 Documentation/trace/coresight/coresight-perf.rst | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/trace/coresight/coresight-perf.rst b/Documentation/trace/coresight/coresight-perf.rst
index c0c82b3d26ea88dad7143afdb047c4d8f502b4a6..59eda2a5b6473ed1cb6bade5d281a12bdde76bb0 100644
--- a/Documentation/trace/coresight/coresight-perf.rst
+++ b/Documentation/trace/coresight/coresight-perf.rst
@@ -171,6 +171,45 @@ no branch history at all, for example samples from a thread that was never
 traced, or samples recorded before the first or after the last trace window.
 It is built and installed with perf's other dlfilters.
 
+Decode branch stack and callchain from AUX samples
+--------------------------------------------------
+
+With a kernel that supports CoreSight AUX sampling, record an AUX trace
+window inside each cycle sample::
+
+  perf record --aux-sample=8192 -e '{cs_etm//u,cycles/period=100003/u}' \
+        -- ./workload
+  perf script --itrace=G16L64 -F comm,pid,tid,cpu,event,ip,brstack
+
+``G16`` adds a reconstructed callchain and ``L64`` adds up to 64 branches.
+Either option can be used alone. Existing callchains and branch stacks are
+preserved. Without an explicit ``--itrace`` option, both are enabled for AUX
+samples. Decoded history is available in ``perf script`` and ``perf report``.
+
+AUX sampling supports unformatted, per-CPU sink (TRBE) trace. Each sample
+selects its CPU's decoder and starts a fresh trace window. The window already
+belongs to the sample, so ETM timestamps are not required for attribution.
+Samples without decodable history receive no reconstructed stack. CPU-wide
+recordings must enable context IDs to distinguish tasks within a window; the
+default recording setup enables them.
+
+Callchains cover only calls visible in the captured window; callers before
+the first synchronization point cannot be recovered.
+
+When kernel tracing is enabled, AUX samples can include PMU interrupt-handler
+execution before the trace source is paused. The late-sample helpers trim
+this using instruction addresses, which may not uniquely identify the sample
+boundary for kernel samples.
+
+Formatted sinks such as ETR are not supported. They can collect trace from
+sources on multiple CPUs in a shared buffer, mixing execution from unrelated
+threads into the AUX sample. Context IDs can distinguish these threads, but
+trace from other CPUs can consume the limited sample window, leaving little
+history for the sampled thread.
+
+Guest samples, synthesizing instruction events, and saving reconstructed
+callchains with ``perf inject`` are also unsupported.
+
 Perf test - Verify kernel and userspace perf CoreSight work
 -----------------------------------------------------------
 

-- 
2.34.1

