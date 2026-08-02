Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7AC377AB5;
	Sun,  2 Aug 2026 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680847; cv=none; b=W8TEHaXowGZBQP6QwairgsjIcDn54qQ9sbqnlpbfRUVglp71MgwCx+cYDEDgW4/39pAtG23cUFop+KE8gzwZSeWueezxOoBw6tECXvDVZtghW80teDpbGGixzZbi1SAMog75ri/ONnjwdMNWXQThQ+UwbS7Fk6gNIYj8Kwr+qsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680847; c=relaxed/simple;
	bh=YkWJsw1x92FJoCNdCuRVMvI1nFCwL9eILPzavWcg+7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owZF/aLM6nxbqxHDGzWuknurg5jTb2w9GQ+hXlMV6Xb3Dfh98hPJn4zbBTi43yZuObq2mE+OwtIkx+UWvaRw55huMtKpa6o5flWkoamAod7IFFxOVWHxGpQN0Iou81PfBZjLVyCkEZZXScCdzOt7KMWA8xbTqB2yLmvOyJ8SxjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9QWNc4T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9QWNc4T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF101F000E9;
	Sun,  2 Aug 2026 14:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785680846;
	bh=KZRceK2vwHkMBIIeSH1tpa2/APit2uWHTO9BMVPtBwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q9QWNc4Tom35CBhzTtOBMXx1PJVgCs+DeP39JTw44Ns35p5eGzd/QICUWMKKmPLWs
	 /y+JkeSCJomBht77e17yvU9TxYulounGqD7Y76HxYQWS064EHS5P1Uuo+96K64oNKF
	 90T+KjOjHYsxtSSfXLKVnY0zsphEbpKINutH3hiuTgYot173EFJ4vv2uwg9TdrUdNv
	 AOcdh0L06N14gcpl5NsLdo5Hxz3NlbvB1dDuJSIWL5Os4RpBwrh94p29zTeoutaQTY
	 Q5Y5qmT5UMTEOTxHYLrzXDdH0FewW3wecIDojs5fIXjDT9iIS2oIGUlTnkvkAVJfGi
	 YpYIS19b6CBYA==
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
	Song Liu <songliubraving@fb.com>
Subject: [PATCH 1/4] perf libbfd: Validate BPF prog info arrays before pointer cast
Date: Sun,  2 Aug 2026 11:27:09 -0300
Message-ID: <20260802142712.154726-2-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802142712.154726-1-acme@kernel.org>
References: <20260802142712.154726-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

symbol__disassemble_bpf_libbfd() casts info_linear->info.jited_prog_insns
and info_linear->info.jited_ksyms to pointers without checking whether
bpil_offs_to_addr() actually converted the file offsets.  A crafted
perf.data with PERF_BPIL_* bits unset but non-zero counts causes raw
file offsets to be dereferenced as pointers.

Add bitmask checks for PERF_BPIL_JITED_INSNS and PERF_BPIL_JITED_KSYMS
before the casts, matching the validation added to bpf-event.c call
sites.

Fixes: 6987561c9e86 ("perf annotate: Enable annotation of BPF programs")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/libbfd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index d8241c7caac50836..0b7164f0e9fdbbed 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -552,6 +552,11 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
 	info_linear = info_node->info_linear;
 	sub_id = dso__bpf_prog(dso)->sub_id;
 
+	/* jited_prog_insns is only valid if bpil_offs_to_addr() converted it */
+	if (!(info_linear->arrays & (1UL << PERF_BPIL_JITED_INSNS))) {
+		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
+		goto out;
+	}
 	info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
 	info.buffer_length = info_linear->info.jited_prog_len;
 
@@ -581,6 +586,12 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
 	if (disassemble == NULL)
 		abort();
 
+	/* jited_ksyms is only valid if bpil_offs_to_addr() converted it */
+	if (!(info_linear->arrays & (1UL << PERF_BPIL_JITED_KSYMS))) {
+		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
+		goto out;
+	}
+
 	fflush(s);
 	do {
 		const struct bpf_line_info *linfo = NULL;
-- 
2.55.0

