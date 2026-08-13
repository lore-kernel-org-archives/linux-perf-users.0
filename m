Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A4488DB2;
	Thu, 13 Aug 2026 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633933; cv=none; b=B43rw9zmxeeFTvtPqJ56tabWKAP0HCBtYipbXurEuh5dtGT0rHGv4ov3Oy7UsBpzj5gtbs1Lq4NDyGPB7ljiNrLi+8qpLQA8ND+q7tv9LKfQLBqE4PuKauYMbCIeGoo3WawxUvCvCwDcQddIJkkTrFRH0K63BqnRk+nR41iQKZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633933; c=relaxed/simple;
	bh=52IIqMbY2p0UfwGl9dUASwGOo93+toNU8D5TRgMYigM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6FmsLBQBdsvmrVUIV5TglU6IGP6HefzhE9nnZ4jJV+XjsveRRJVf50pHRZI9SDojdOMoZI3BLm2rK9ZSrJ5wUX6CB148JCjUETL5Xa/xg6a9rbB722Hp2UQkt1V3nqV24fHp/3mxOMF1qx+QIgzirEqeTXbvPJTQL4ZXl3C11I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClkquzYR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClkquzYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F105E1F00A3D;
	Thu, 13 Aug 2026 15:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633932;
	bh=Xm4ge2uI2RMkDV/egTaPU3dqzmNnQZnZyDpsB5I3BDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ClkquzYRcFLn+HNdkLrI1zM7LEI2eriO6LLGYbfnxDOtStOC8Dd5S0YGYgSyRTXVZ
	 SzJF4+0DSL2O3bep1B1Ue0c980uzsbaAB05Xl0pIY3J9YTfZb9K46qXdhYZ74ocLdD
	 CTBLIkKK9SOdYqhHu36GZlb2fGHaz0BpDPPaN5kTpaGIpJpStF/q0hkvmAOtqT8zno
	 kvqU/MnddQjFeMyXhnbbyFEKyty5GI4/8RWjsDA48bJ6pp/TEHKNdtjFP/aCHOBJ/a
	 AMCohvVcp6ilccL+i1vWth+xUFwSceuHwg+5GoaAhdMGZmgwBk6HMy9A5/0S7Lcszm
	 6IScazVpafZrQ==
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
Date: Thu, 13 Aug 2026 12:11:46 -0300
Message-ID: <20260813151148.23169-6-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813151148.23169-1-acme@kernel.org>
References: <20260813151148.23169-1-acme@kernel.org>
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
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Song Liu <song@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 4dd64069c4348c06..42bfe30a3b518e80 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2038,7 +2038,12 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
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

