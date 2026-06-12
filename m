Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A9A5474F;
	Fri, 12 Jun 2026 00:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224495; cv=none; b=OUzmXP8lGGYUy54ZS/SXJnXIRrkWo4R3ntqvmGDZP9uABtcKiGHgLFhEXiqYFz59CDKzw7e0/WW6LvmCY+cqv09oJw7oEJDvhumaz+qcwi/M6LmrXeG6v3zwZQkmWHDT6jVX/nNqqcLd9ARpMPutUYD4dLkaQ8R3uaMzmljyiU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224495; c=relaxed/simple;
	bh=sUzViC1WFVYEcIbxbF8T56nDE6tG6MoOESqkY25KPgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4yq6uiJHDhu6KHNWW3cXSs37ruEyH+1GJzEhNdWZWJgOts/QAHvdQADYMOYJZW7pGKX202YhNrR0EQ2DNYxWeN5gj3dDQP6PBRpr/z5uqRlFjvk7zVikEb6CXPwU+bAN2g9etB8MNCeP/sTkPpaNVGraheOpYiyemOLl0JYyVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WduLdTnI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WduLdTnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194E51F00A3A;
	Fri, 12 Jun 2026 00:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224494;
	bh=uKihYxeSFiFhXjPKrGLJkuVtnc6h8mryrIf11VT9gME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WduLdTnIehLKUvx4BOWi7xgP3xN9bvtiHBqJ/NAJ+GQ/9R0xTD5W+7YFdcj8AMP8o
	 rRc23AADkZCrADKYTaZXsyL0AlZdTTQCe0CgYIpfv1zxaFTKmP7EsKeKv/7UPapq6I
	 t9pie2dA21OUchRfHChKrKoFXCLwfN3GzEVOJJsTITZAxbY904LJ+SNFWChObA48jV
	 yIPlxR9WcaKqpBO8Y/yy7FmoYmU30A5ldpGEBlenVUdelCsJCrmsScXuGDY4UtrGJ3
	 7enQJvOE7g13tfUX7yBbNcPI60xJiL7Ehli5nPUbf6TsP6iIcI1ADVKhZbLECHjuXu
	 YTu3epKAIgEgA==
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
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 01/15] perf symbols: Fix bswap copy-paste error for 32-bit ELF p_filesz
Date: Thu, 11 Jun 2026 21:34:29 -0300
Message-ID: <20260612003444.50723-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612003444.50723-1-acme@kernel.org>
References: <20260612003444.50723-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

filename__read_build_id() byte-swaps 32-bit ELF program headers on
cross-endian files, but line 178 passes p_offset to bswap_32() instead
of p_filesz:

  hdrs.phdr32[i].p_filesz = bswap_32(hdrs.phdr32[i].p_offset);

This clobbers p_filesz with the already-swapped p_offset value.  The
64-bit path on line 182 is correct and swaps p_filesz from p_filesz.

The consequence is that the PT_NOTE segment read uses the wrong size,
which can cause either a short read (missing the build-id) or an
oversized read (reading past the segment into adjacent data).

Fix by swapping the correct field.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: fef8f648bb47726d ("perf symbol: Fix use-after-free in filename__read_build_id")
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-minimal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 091071d06416e290..f4b0a711a62cf3de 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -175,7 +175,7 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 			if (elf32) {
 				hdrs.phdr32[i].p_type = bswap_32(hdrs.phdr32[i].p_type);
 				hdrs.phdr32[i].p_offset = bswap_32(hdrs.phdr32[i].p_offset);
-				hdrs.phdr32[i].p_filesz = bswap_32(hdrs.phdr32[i].p_offset);
+				hdrs.phdr32[i].p_filesz = bswap_32(hdrs.phdr32[i].p_filesz);
 			} else {
 				hdrs.phdr64[i].p_type = bswap_32(hdrs.phdr64[i].p_type);
 				hdrs.phdr64[i].p_offset = bswap_64(hdrs.phdr64[i].p_offset);
-- 
2.54.0

