Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737044582DD;
	Tue, 11 Aug 2026 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468351; cv=none; b=qDyKNJYFrfPYHGIopj0OThU3zM3x5PPDLFHDtkVt97L8/wcZ4iyK8YRuXNY3DnXpPB2Ic/ED5B2KjC7VIpDwWjw3UWFV9HfemEOFralCRXNIe89/1DQPtY0pWn6zDVb69zr29FYdBF95tKFDCEN/8HKrgsXsQ2hylEzfNqS0fcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468351; c=relaxed/simple;
	bh=a2sYeoCNrwrU3geY55t3idlAIEB9k0GzPOt11pWY4ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWxblR/loKAzPwJWDp4hxVAWH+yuaubiXvoqQX2XwAEW6/L8yWXXvMlOYbgx0FWpUOyRvIhdXlBwH4Z0JrIIjXsJNHSqiWX/ynRD/WdKelM8JmfjCBKi9LiOOexqt2WABB56mBQy/WgF2OzcRRyu0lPO0osk2eSHacoVnTwECSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8x+1p/G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8x+1p/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FB41F00A3A;
	Tue, 11 Aug 2026 17:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786468350;
	bh=EV37sXYMvDxNyI3O2pN+AzI6ZNZUFdIY6F/NfIRVeVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P8x+1p/GqZY4t4eKgvYvwG9hDbRO9AJFk0V64X+kxur6GyEcTqYuQhDVK7NBQL413
	 DPSuXGVnJv/vMrC0HrNP+d8ANG+Gv1fM1FocQmStw069T+oR9GljeaLW2TzPkEh+EN
	 qJJq7IxpId5fnBIT863T1B8At5sKteaTbsVt5SPCvWL6qNTbU1LSXNCSjBf8R+vI1G
	 RqKDEWKoIy3k5L/FZm6YdlLTrpO71n3SCdcPwDqWq/jHfg9W8ujQkICyP8PjeDggwb
	 ycA4cCa3ioN2K4Pw8em3pjuSVyOE4xaSif8KQiiQrsyOEbeSfY8Te7jdhOokSg56Q6
	 NksOe/QnXftGA==
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
Date: Tue, 11 Aug 2026 14:12:00 -0300
Message-ID: <20260811171200.30096-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811171200.30096-1-acme@kernel.org>
References: <20260811171200.30096-1-acme@kernel.org>
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
index 2cf9f44a87903d7d..031de8f1da0329b2 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2027,7 +2027,12 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
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

