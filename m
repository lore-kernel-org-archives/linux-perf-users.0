Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797942EF66B;
	Thu, 13 Aug 2026 00:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582199; cv=none; b=p7CTtdBhlqkZoxVPKGpgaHa/CCA97vOg4YFef7bJXjjCe6r1xfs1C6HXHal01ncUDPcVGJuRl9sNpnnppuMyIiW/HR5jV+9LNvISD1K3gvRVAKy/1lnH6YMtKdaMHyuZsBeBi5pWciVszIIVaOQSI66S+WDykcIgjUAT85ACdck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582199; c=relaxed/simple;
	bh=2syjdaMv/Mee/1dBFBKh2VMNcou5wTO1ZWd5IDPuKUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZnHhDUrIEYy3ulPA1UmZg0qlv/gAp8xL1JaRfEb1RlgmBUVLZeTtRyT/2fIIa2xrAxVb/s+o/0L4DPF6l6uZpgMwqpLj5M7UVXxk5OI7Fb4qLEFlRIZh8Rk6pqiHLwvDU85vWJpdVdTQMwRvdiIusVSiAwvHnTzPr7wxE4o8v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lU2lbsrb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU2lbsrb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA611F00A3A;
	Thu, 13 Aug 2026 00:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786582198;
	bh=vE5YCx5Sc9WzuwGSZa37Dgb8gWMC+horNLeZfxc8lEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lU2lbsrbgcqRARpsIsmg3z7NPabnlQGjlkWlaKyC6ur/K7IqRyxxWyzGXlXxYG6FE
	 lk5Iqs0M5blZBoDoInolKC66GG4EQqQ+vPmtjlWkaLXYEJWNC36LvnVn5sODWgEeEe
	 0TPmm7xaN+tYomxGf3F1kRBlL0L1VDJkyRKbMX8wKEGX5dfeH5D7Ws2/emZY7OdVwX
	 NpPGzIddtMKioYrgC28Kb/zxfykOhaRB/5rrVTRw9w7BN2qN609om7a2Pj7TKsfmUQ
	 /lgLtRoXWpdfaIvg4ZyOtm6MVIvIg9yHt0VypwqYMVViWIK7CLn8BbepsO3SemSxyl
	 DVwBvcb5dV6Hw==
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
Date: Wed, 12 Aug 2026 21:49:24 -0300
Message-ID: <20260813004927.16738-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813004927.16738-1-acme@kernel.org>
References: <20260813004927.16738-1-acme@kernel.org>
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

Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 03e7f89d5465c91f..68cd90b5605f8c50 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2033,7 +2033,12 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
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

