Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79CF17D6;
	Wed,  8 Jul 2026 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517952; cv=none; b=DHFVaipQ1a0/3zntR0dEqU97W4co+OLVjeyyMEEEbULP9poTPzyjdRvIsuMBKhkbQWHaOt1Z/EBpSFD9uZO+G3IwbKenIW7JQq6RJaauNeZgPCEmDMfojH6LFQMAeWtCyQ8lgSWlzzuenBmpw/k77EGQWXxWxnmX7j2Vwx2If3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517952; c=relaxed/simple;
	bh=dEhFxfCahr31L1F5SntJAmUomlK/XzGUpK8CQw5o44A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4s/+NHkIwEEq4uMmn2zgp0sLy3YZgAuWZXtQeoLBzH2PNoMJuVYYcu/vTdNKUE+olecGWx3QJQMuX4CpM5iAVfu5jVKHR9Ad2aaO1b8lodpE0GdIuGC3q+lKuZr9gR3jSatoBt0VMIHqk8Wl1etFAGM51umjrjFhdLgD+jltks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=FoOSjvtT; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="FoOSjvtT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1783517942;
	bh=zfTLYOGz2115pWO5Bctt530M/nLnfY1+cdIa5cV87gs=;
	h=From:To:Cc:Subject:Date;
	b=FoOSjvtTFm510CWw4P8ZhOQFXp5gbKhuz8Qrv3M7DBWlNHcrzViz6YPL0qDHUDfVd
	 S4dNeCRnrAEVW9HZZ8Is4lpVjSUkhuy2LeKoV3bWlqFe53i5OlTtZ0SUbHSvxD95jN
	 h2/TNqzb1n+iQO+B/+3nCOoLz9jPx3+UDODjbzs8=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id BD90EDB5BB;
	Wed, 08 Jul 2026 13:39:02 +0000 (UTC)
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	kernel-team@meta.com,
	Farid Zakaria <fmzakari@meta.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH v3 0/2] perf record: fix multi-record Zstd compression
Date: Wed,  8 Jul 2026 13:38:32 +0000
Message-ID: <cover.1783513665.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a 'perf record -z' regression that aborts recording and writes a perf.data
that cannot be decompressed (see full analysis in patch 2).

v2 -> v3:

- Dropped "perf record: Avoid overrunning the zstd output buffer" and "perf
  record: Don't store raw data on zstd compression failure": both are now fixed
  in perf-tools-next.
- Added "perf record: Return the written size from process_comp_header()", a
  no-functional-change prep patch, so the fix's per-record padding can't
  overrun 'dst'
- Removed blank line from record+zstd_comp_decomp_multi_record.sh between test
  description and license (Namhyung Kim).
- Added missing <string.h> include (Sashiko).
- Rebased onto perf-tools-next (Namhyung Kim).

v1 -> v2:

- Patch 2 ("perf record: Avoid overrunning the zstd output buffer"):
  rework the overly strict output buffer check to pass the remaining dst
  size to process_comp_header() and bail only when a record won't fit
  (Sashiko).

v1: https://lore.kernel.org/all/cover.1781797544.git.d@ilvokhin.com/
v2: https://lore.kernel.org/all/cover.1782743187.git.d@ilvokhin.com/

Dmitry Ilvokhin (2):
  perf record: Return the written size from process_comp_header()
  perf record: Fix multiple PERF_RECORD_COMPRESSED2 records per push

 tools/perf/builtin-record.c                   | 49 +++++++++------
 .../record+zstd_comp_decomp_multi_record.sh   | 63 +++++++++++++++++++
 tools/perf/util/compress.h                    |  6 +-
 tools/perf/util/zstd.c                        | 25 ++++----
 4 files changed, 111 insertions(+), 32 deletions(-)
 create mode 100755 tools/perf/tests/shell/record+zstd_comp_decomp_multi_record.sh

-- 
2.53.0-Meta

