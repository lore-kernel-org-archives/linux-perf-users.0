Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7312472B8;
	Fri, 16 Oct 2026 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109933; cv=none; b=c/HoNxeMqhwECnwq+t4898CVaoeoio0+9UMpeSZX0VxQR+QG6mT0IVVpKjYCeE6q1MjmS/We7iWkjmQSYaoNpID6qYgGIcnyGg8y+052S9xnaluw1X6EvjBPcIKU6VkzZ+bSyE2tV6B3DYQFRoMeQ1U9uc7Vguvd5eq32A4qJkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109933; c=relaxed/simple;
	bh=SmxGbot7TR9HDni/Elet4vrkv/9q2gIcEau2siebyHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBvpG6ZM2fzs/uujOadl0Q2XOCEJJVKIPJg6FH6XDaxWyfFnNeDgpQGSIfKQZr71rYXEhTFWbCmcfUNZikPzTak35BrRQ9xMJvszX3Jv5JPl3+zgn58INYe3q1UlbgHiAYFsyxR4IB4I0JnYKQXtTW3l3bvEbDpgDhn9+d0cYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atAmCGG8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atAmCGG8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6881A1F000C5;
	Fri, 16 Oct 2026 00:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109932;
	bh=w5/BfkC1OceS3dX0jV7eo4MrwK7mpfm5mPAWRCk6F7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=atAmCGG8zv7EaBd+1S0qKP4YY3rk14E85PsDmrkyRtwlLTJ1b+7sFHWtBzZzyVH1i
	 goP+WvQmzca2838GaIDLo/xWHErRizou6Qoc6zk7oyVAlmJKu3HNP57kKPCTlwf0yl
	 FerXX5hhYd5mPG+ZvWV1CtqwcLjxLwMCICD5LX9lc2/za03TL9jMvhTuHmY0fpUC7s
	 EmQVTZe/cPADe0FEvvSc3lqQvTcjyw0LK8YusP+7s+QAAHOzHGMY2fBB9qQcYtA4+U
	 wBK8TCYgfaKr8ZUCHT4W8D529UBXelpf5K9W039HNrwztJXRQpvZDCahtB25RgC8wV
	 DFZbfn+UCySLQ==
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
Subject: [PATCH v3 01/19] perf test attr: Fix record dwarf sample_type expectation
Date: Thu, 15 Oct 2026 21:18:25 -0300
Message-ID: <20261016001843.71978-2-acme@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016001843.71978-1-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since commit bdd051e24914 ("perf record: Split --data-mmap option"),
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

This went unnoticed until tests/attr.sh stopped ignoring attr.py's
return value.

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

