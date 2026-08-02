Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0E279DC9;
	Sun,  2 Aug 2026 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680448; cv=none; b=hrgQIy2KcIvCUGxsZ+449VtBv9xUhw+BbcuCTFXd0dYlD3fgh4xNW9vpOz8/tL2pUp6feMMUN+C94g3W6n7wKEfnMprN9kr78/xXPx9waM+32eP0W1SQReeUN40Fidp3TJBJHFOMdjcSK5BWaFr9VNuzbMsZzKHf3Ucb8o1LoeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680448; c=relaxed/simple;
	bh=9ghGZvR+z4A6yyxvsNCDL1xvfZHOTNX4GVWCklmmVAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXM9sb9tjpdOIwDfgW7We+gYTDOLLntc/Oqo9vET5txxP6JtyFN9erPEJI+eFNvCEuETLP1GYqZO04WIBD+6XIHHz55HrD2NZsgc39dPqA95OmtIAW1qaMYV0UV96iL6hehsW2F7MGLw7XVzknaQBZ1K72ud4Zv3fpouU61bAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YN9ljNhI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YN9ljNhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081F41F00A3A;
	Sun,  2 Aug 2026 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785680447;
	bh=QAtZHxi1/mlCckbhP0Sap6uW+3wYT8TzghRz+mnk+5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YN9ljNhI4jBx/MTPuBfuaNTrsh+378gyD2kWcJgSSGsy/GfMxzJ7KqseZwK37O5iB
	 hLO9f1ASL+Snr8ldBiJxwLtgyqLiQIL0gYSHeacrTBjyoXJyqMnMR/BlDaAbMktVm/
	 E5fpdexsWaBcESxmLUy7M7hxEw5FyebtqMAV4/WNXfWXGt/SkuwjgQP9jUzkXM6Cg8
	 I9W/xt1RVaTAKquy8IApEFpvYsx7RFMi9yUETRDcLa/EOUZquhTerLwD5spgnovUkc
	 7pFlfUdeEzn2JDtE988JcX5ix8uf+2wP5JpOB4kEf470XA8WJEhY1B+uCGJQuto7mX
	 GlFOvkVpX0GSQ==
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
Date: Sun,  2 Aug 2026 11:20:22 -0300
Message-ID: <20260802142022.154219-6-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802142022.154219-1-acme@kernel.org>
References: <20260802142022.154219-1-acme@kernel.org>
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
index a0de56c93592a5dd..f3209f285db7675b 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2024,7 +2024,12 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
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

