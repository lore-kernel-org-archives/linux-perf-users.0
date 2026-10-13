Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D8753D9EA;
	Tue, 13 Oct 2026 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922471; cv=none; b=PwqsFBfqmpDv0XGPmbg/SPrE0oCS9NrjOJj7hqhJcFMhQCmK9chE3rOiw0s0PvyjMg75JyCZTQon0zWPJwE8pxfNZ0fTcoLOOojaEwZiGpo3SMyxSSu9HMamhuL+qLs5dbRcKaQesPeqi5sIk5oHtkf4VWZPcSxJfJvHhtFHFLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922471; c=relaxed/simple;
	bh=SmxGbot7TR9HDni/Elet4vrkv/9q2gIcEau2siebyHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLw/XHhKITitMOf5Mr6+YSLrdTSfC7E7706ygYqHT/SnthzDsZfIDDAVHJ8XA53gk3pD7bCJ2PvMp+H6TldwCo/AxOS8Ryk3BjytqVehXj/bYxDNhj8n0Qih/cuvc6MT5G/zSVDDunuxCoPXV0IXnztbVBgkIa+d1letvSQtOxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iG3rYam+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG3rYam+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8243D1F00893;
	Tue, 13 Oct 2026 20:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922469;
	bh=w5/BfkC1OceS3dX0jV7eo4MrwK7mpfm5mPAWRCk6F7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iG3rYam+sCgtv9ecpz7G83YzJ2TFH4wR3A3opZ1ZNxMusEQzdQkT2KXcuQpsAoJXY
	 AL6ZGzpx1HPajDWJbXgqa2QNsiVYz96QWNAbUvpfWCSXdqML3KAkc5X41PTLK3801H
	 l4yUMFIAJs3/I5K6lRbu2qrKqiggcd3dkN3ReEesKWqJTr1VukhXMW1/7CGe2y/Qu3
	 QPKjzRwrgUc//N3MbEcHC8F8lKFOr6S/1X17/GsqcDWz/OYioVDcnmDIgvbSWCo7Ne
	 8VG6SFh3OjwCpna0TwPeJ0WFbuGy6HDWnhJwdK7UFGFgjvxtch0FxDp+7LboaIbdk2
	 Lv69an7ayyIeg==
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
Subject: [PATCH v2 01/19] perf test attr: Fix record dwarf sample_type expectation
Date: Tue, 13 Oct 2026 17:13:56 -0300
Message-ID: <20261013201415.36428-2-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013201415.36428-1-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
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

