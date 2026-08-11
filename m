Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618FD34EF0C;
	Tue, 11 Aug 2026 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470731; cv=none; b=UuG92dLV0Hrwbd4MhAWp3ZaZkrZiZpzc0a/u0gP1eUTaSQnLnldRV5QFtdhg+A9A2RbJVjUzV1PTVH5Tg3XQWFI2MpXwFQqr09RhpPKRoW3eM5bco9wAbFjqK7h6hrlcF4u1yBpl9tB2dTLQI5u8QtWSccckzPgRt7KfxhMFzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470731; c=relaxed/simple;
	bh=wEj3U44ZkgGmUeTbAIvUHA4HkefQyR81vQVs9Ff5Wsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjj8cWXMF4OLMOH1Bcbh4fhZECacvpF1nJccgr9ZwiVJREvdxYBSbR7r9FR37lMWH7zi2MP45Oe/wzI++thdLBoDmMK45MU3VdcIwB5MRbTU1SLSVkagiTmEXFBqjx9Fz36D5uVU8G6Hp1sX+ODmHin920Y4cwzpZDcmJFTmVBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olzGZAoz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olzGZAoz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E9B1F00A3A;
	Tue, 11 Aug 2026 17:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786470730;
	bh=xgsj6giw+Z2i0aNaQTUB0L9TsWsLGJzJIS/7tZOy67E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=olzGZAozPJ4es450+f4IZR4P0/eQGPMY5kVhDQa0+pX/enKY5SGCc+4O2wChHMDVZ
	 wE++Rc0APqKcs5jcy3gFy+e874HhZfsJNaSqlC1rAjO/agHhAMIRDYI3H3Swrwirv8
	 Vyb98RxsUSGhspVJWRtldmHovVq8r8msfUKuHVpoKzJl5+3QYaknXw48Q5TEdrvLhY
	 OoDM4qXgKsA3DfD9IZ5jyJBcV/DtcmfQlNI3TMceDLPsoFbl0xUAOgBs3jBgQbFj4U
	 fextE9zMtR3mk6A1FNVm5TXS5p3yIib3+2qL1ZN0WIvOXAxB0yuHTIL0Tsp8uFaG1C
	 2oZNsfVUV9N0w==
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
	Song Liu <song@kernel.org>
Subject: [PATCH 5/5] perf dso: Replace assert with runtime check in dso__read_symbol()
Date: Tue, 11 Aug 2026 14:51:34 -0300
Message-ID: <20260811175140.7235-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811175140.7235-1-acme@kernel.org>
References: <20260811175140.7235-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

dso__read_symbol() asserts that len <= jited_prog_len, where len comes
from sym->end - sym->start (parsed from PERF_RECORD_KSYMBOL in
perf.data).  Both values originate from untrusted file input.

With NDEBUG (production builds), the assert is compiled out, allowing
an out-of-bounds heap read when the BPF program buffer is accessed.
Without NDEBUG, a crafted perf.data crashes perf with an assertion
failure.

Replace the assert with a runtime bounds check that returns NULL with
an appropriate error code, matching the existing error handling
pattern in this function.

Fixes: aa04707f507e ("perf dso: Support BPF programs in dso__read_symbol()")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Song Liu <song@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 8e16b919e80721f0..40b23b7cbb94049c 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2031,7 +2031,12 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 			errno = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
 			return NULL;
 		}
-		assert(len <= info_linear->info.jited_prog_len);
+		if (len > info_linear->info.jited_prog_len) {
+			pr_debug("BPF symbol length %zu exceeds jited_prog_len %u\n",
+				 len, info_linear->info.jited_prog_len);
+			errno = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
+			return NULL;
+		}
 		*out_buf_len = len;
 		return (const u8 *)(uintptr_t)(info_linear->info.jited_prog_insns);
 #else
-- 
2.55.0

