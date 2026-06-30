Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6079F2BE03B;
	Tue, 30 Jun 2026 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803848; cv=none; b=VCjTqxu07RFMr6AhYJOTDChyS95qo0X+F8ZnIgrzkZeFqJ8pUQMYsG7Lgkr1C6/bTG8JdbBw6xN80p+sNcmdZkgrmc5c5WPhHkSWepaXJyqXznzQ3hDQDHRel2xAfTEBGE4H34a1JdNDgsbqjVQrMGpycMk1MPLehJAnXuDZ2yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803848; c=relaxed/simple;
	bh=WlceMyiBObjrIEVlIWC/hkWKUtBxtjsq2pVwa0XY8Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StGAdKdO23ySLRx0TGX5IpQZPohT1eFFc+FcQZkQdb1NOehniHtJFfJNvKEpJ/byvzR0SIWeb5jNPQx9mOADqYma87jo1BGPZeqDur9xVHLxDHvIyvV6QvyOSTT1a6F85pD7QnRIIVbK0q+P0nzcJ2l2D/wcT36VfymXIAr1YDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=d9aJtEa6; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="d9aJtEa6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1782803845;
	bh=JGlyV0XJERwi0Y+8mScsM+60IYwn7WRTS2djcLQVUzM=;
	h=From:To:Cc:Subject:Date;
	b=d9aJtEa6IYaFylh9GGf+cVYhfWkv1je/LcFF3lWJ68R/UEJWKYjUCds6MO6EY8ASa
	 s6U3nDFLattXLIdFR0n/HoNpcBhqU2oh2vLLfgDqBytIRIocr14stBvedesmFnmNbq
	 nK1fW1zfBdDAQWZPO0tzy6+rOqbLM63PtiTKt318=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id DFE33DB245;
	Tue, 30 Jun 2026 07:17:24 +0000 (UTC)
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
Subject: [PATCH v2 0/3] perf record: fix multi-record Zstd compression
Date: Tue, 30 Jun 2026 07:16:59 +0000
Message-ID: <cover.1782743187.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes a 'perf record -z' regression that aborts recording with
"Bad address" and produces an undecompressable perf.data.

While fixing it I found two more latent bugs in the same compressor,
zstd_compress_stream_to_records(): an output-buffer overrun and a broken
zstd-error fallback. Addressed in patches 2 and 3.

v1 -> v2:

- Patch 2 ("perf record: Avoid overrunning the zstd output buffer"):
  rework the overly strict output buffer check to pass the remaining dst
  size to process_comp_header() and bail only when a record won't fit
  (Sashiko).

v1: https://lore.kernel.org/all/cover.1781797544.git.d@ilvokhin.com/

Dmitry Ilvokhin (3):
  perf record: Fix multiple PERF_RECORD_COMPRESSED2 records per push
  perf record: Avoid overrunning the zstd output buffer
  perf record: Don't store raw data on zstd compression failure

 tools/perf/builtin-record.c                   | 48 ++++++++------
 .../record+zstd_comp_decomp_multi_record.sh   | 64 +++++++++++++++++++
 tools/perf/util/compress.h                    |  6 +-
 tools/perf/util/zstd.c                        | 28 +++++---
 4 files changed, 116 insertions(+), 30 deletions(-)
 create mode 100755 tools/perf/tests/shell/record+zstd_comp_decomp_multi_record.sh

-- 
2.53.0-Meta

