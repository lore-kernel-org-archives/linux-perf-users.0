Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5731D372;
	Thu, 18 Jun 2026 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798820; cv=none; b=qsaxO8q/NdmWIdfN2INL2k8EXdyBQJfHuPa8TZpB9MbVZA2QYxRRVdoOSl1Pt3liMiNhDX8ZJwz/Kq/nJkWieW0njw6KLpQ49GNxgihS69gL+c1EB2HdRS+deLbxTNrheMrB+zdKg0j0upj3WMlXYbCC7m8zwz6vMHjYLonCdiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798820; c=relaxed/simple;
	bh=tZRatZS43HvDe6wsZQ9QseVrqUtoEUfVEzNNaQWe1IY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dgzKlrcseqTLxJp4B0pjYqgmEfonplfr2R1Z1ca1ZWGJvIVYcy5vPFbsrVeRc+/fSnI/MFRYx/6s0a9E3ayXASKNfl4kJzZ8ltMmJ1F3QcOLJUQ6SMLvA/zpvpYMKjH4nqJDZejgLJx6YzJmglid9H73fpsJvr5VmtN2rORd1SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=2ImxAI6M; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="2ImxAI6M"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 3F235D1806;
	Thu, 18 Jun 2026 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1781798370;
	bh=DwDJNV2Gd3BZTjNyyrVSlu/FQu9/VrMnOpwUqla/IlY=;
	h=From:To:Cc:Subject:Date;
	b=2ImxAI6MTV2dvF4d1J/sH4h5N1LkDMfNxNinMxxDQwI1D7Z75MrS7+6eQAYF4Uhoz
	 gIkSdyFiZP3sVuSEvjF44cZoAv6jrfgBNd/8TNLwjOQJbVHJUOR5GUvQZSRiBDo3FU
	 Vh+RMDC8j81caYtOAkxC6oQqoha/gJMm7a7BXdqM=
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
Subject: [PATCH 0/3] perf record: fix multi-record Zstd compression
Date: Thu, 18 Jun 2026 15:59:06 +0000
Message-ID: <cover.1781797544.git.d@ilvokhin.com>
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

Dmitry Ilvokhin (3):
  perf record: Fix multiple PERF_RECORD_COMPRESSED2 records per push
  perf record: Avoid overrunning the zstd output buffer
  perf record: Don't store raw data on zstd compression failure

 tools/perf/builtin-record.c                   | 40 ++++++------
 .../record+zstd_comp_decomp_multi_record.sh   | 64 +++++++++++++++++++
 tools/perf/util/zstd.c                        | 15 +++--
 3 files changed, 94 insertions(+), 25 deletions(-)
 create mode 100755 tools/perf/tests/shell/record+zstd_comp_decomp_multi_record.sh

-- 
2.53.0-Meta

