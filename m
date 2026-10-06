Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5049F126;
	Tue,  6 Oct 2026 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303220; cv=none; b=b2Q2iZCIzy0zIfI4cCemATVLArqG5JgElfmQsEJJizsZWmMFwK/qJh8R+CZ+VWaaddhj83qtsRD5BUTTFec0guqC0HY8UN7qyqlxzz97GcpaMppcB0Tx87a9PsB5YRm0ZD8+cg1h9UJ6FVwAyRiI3K56qu9O/zL3/FCUt60rYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303220; c=relaxed/simple;
	bh=blTe50G5CW8Av3QGUqqQ9RKrTp9rPcL8gMXmX8YG6PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rB11RK12W6FkK5VxKe6vn6yLBRyi12oUS9A8fmSavZcneQwak73qpoVHSj9iu21KXTN6EllRtKxqbxuHyJR4/kFVOT4wNZ7aVSapxcpPJJNY8+wc/ud+uSOKqr6DIB+D3VHD46IDz1MiwB7yIYKmZJL6d9WUbmXZRXnDARr4F6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEJiLUrJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEJiLUrJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047EA1F0089C;
	Tue,  6 Oct 2026 16:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303218;
	bh=B93c2QflIkrAuM/g9mt1s/SFesbAVkqbLnzBVrbUB6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZEJiLUrJLHcExtVhjysUKsW7kw2RZ4b65ch+xt38uLpn6Ki+1dYIm0vPlY3LmTB1k
	 NdEPBwwoLbbIkmxG9gPaUnF6sCXqrVmXCpuNMHxwFCzhlNZuX+zDdHi3kExJ9t7JwX
	 Ej3TMX2s/F6fV1YO1noNwZPsXHKYJaHDv/CwvgeKdjMGbxoVN3kqnzb4o9HQHLRpMF
	 6AfAWxwWwssNfDfdjdVQPnNDO8tsClnrMYSyzOSzGDRc//iXtPuE1fYXApsWbW5uJH
	 qTFx4TEiXE1djj86kCvkkHKzKcgoIo5jojmjLJB7k22dvCO2xywrWAI/0Cd3QubKAo
	 jXzw+eVcPl6Mg==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 3/6] perf test attr: Fix record dwarf sample_type expectation
Date: Tue,  6 Oct 2026 18:13:06 +0200
Message-ID: <20261006161309.3078488-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006161309.3078488-1-acme@kernel.org>
References: <20261006161309.3078488-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since bdd051e249141c79 ("perf record: Split --data-mmap option"),
record_opts__parse_callchain() sets record_data_mmap instead of
record->sample_address for the DWARF unwind mode, so -d/--data and its
implied PERF_SAMPLE_DATA_SRC are not enabled implicitly anymore.

As a result, --call-graph dwarf no longer sets PERF_SAMPLE_ADDR and
PERF_SAMPLE_DATA_SRC, making the test fail:

  expected sample_type=45359, got 12583

where 45359 (0xb12f) is:

  IP|TID|TIME|ADDR|CALLCHAIN|PERIOD|REGS_USER|STACK_USER|DATA_SRC

and 12583 (0x3127) is:

  IP|TID|TIME|CALLCHAIN|PERIOD|REGS_USER|STACK_USER

i.e. the values differ exactly by PERF_SAMPLE_ADDR (0x8) and
PERF_SAMPLE_DATA_SRC (0x8000).  The mmap_data=1 expectation is still
correct as DWARF now enables record_data_mmap.

This went unnoticed because tests/attr.sh ignored attr.py's return
value until 04a0a19ede01e771 ("perf test attr: Propagate the return
value from the test to the wrapper").

Fixes: bdd051e249141c79 ("perf record: Split --data-mmap option")
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/attr/test-record-graph-dwarf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/attr/test-record-graph-dwarf b/tools/perf/tests/shell/attr/test-record-graph-dwarf
index ae92061d611ded68..fbe0faa8cdb6a8f4 100644
--- a/tools/perf/tests/shell/attr/test-record-graph-dwarf
+++ b/tools/perf/tests/shell/attr/test-record-graph-dwarf
@@ -4,7 +4,7 @@ args    = --no-bpf-event --call-graph dwarf -- kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
-sample_type=45359
+sample_type=12583
 exclude_callchain_user=1
 sample_stack_user=8192
 # TODO different for each arch, no support for that now
-- 
2.55.0

