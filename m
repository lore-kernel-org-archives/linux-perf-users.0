Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23572FFFA4;
	Mon,  8 Jun 2026 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780882354; cv=none; b=bQ+oUyNW0qQEvadxtAH1NvbHski2oiIqV0xNxa5n+6fiRiK82qJWV5mTnZO+Mv0NSdaOeeau7xHdYyUtjro9rEsjSpqHOl1YRBCowlLsYz/t9nhHnwSWx5w6Ot6Sb/8ziV+kjKI4WFg7+zcriok6HSMoBxQmXgaA+9mpy+GC914=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780882354; c=relaxed/simple;
	bh=yzpqRp1KXXDtRZ3nmlG1tbtU+tGkMKMkq+qmu7cRbFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8cTasuvn1WwgAoFup+aBfglmxM7bKYOGICzNiJHpkleBjHru4gBPTia5EF+AM0uQdKa2nufn6vW0Lmm1CSLO+FdxqXNt0ue7Zh6EwpCy7CT951sC4OUw6TV95P6UPEc9yDbJaxOMRNfM16WduUVO1bTqcki+o1mre7AVhPnMXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsUYF/GX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsUYF/GX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E751F00898;
	Mon,  8 Jun 2026 01:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780882353;
	bh=mb2YK/7aZ7ZZv5PM4t9lUCtnKOmzQa+WV7ppgUYJCqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AsUYF/GXLh5J3ergfsE/4lolHbBJAy3gHbbrXl8BBJy8e/S4BlNNYXy0F6BiO7S22
	 wlqXI/JScpBR8VQVO7tZ5wB4wI/Wqja9xEk7G0Uxtw67+jzwT4HVIfY1yvkO6mRGT6
	 KIl/HXmxDcMTEZ42NDdhAqnKwH1AYLPEihkmmNBQ1V8b42ifWJvB/UYOPUuIvsKC/a
	 Xsz+EX9VBMWhqjpD9Zg8LKm/WT48D4gTwjUaBJWHqRQJB5xJu9kw/XGbLsF2YK++df
	 MiYMgamG5hFewzacOGGbCElKSj+M3f5DCtNRep4IDgNpqcovxwfWvLfdFaqBEXQhd4
	 ycMTA3w5vYxeg==
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
Subject: [PATCH 10/11] perf hists: Fix snprintf() in hists__scnprintf_title() UID filter path
Date: Sun,  7 Jun 2026 22:30:54 -0300
Message-ID: <20260608013057.1942953-11-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608013057.1942953-1-acme@kernel.org>
References: <20260608013057.1942953-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

hists__scnprintf_title() accumulates formatted output into a buffer
using scnprintf() for all filter clauses except the UID filter, which
uses snprintf().  If the buffer fills up and snprintf() returns more
than the remaining space, printed exceeds size and the next 'size -
printed' underflows, causing later scnprintf() calls to write past
the buffer.

Switch the UID filter clause to scnprintf() to match the rest of the
function.

Fixes: 25c312dbf88ca402 ("perf hists: Move hists__scnprintf_title() away from the TUI code")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 811d68fa6770c5b7..df978c996b6c2262 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2963,9 +2963,10 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
 			   ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
 
 
-	if (hists->uid_filter_str)
-		printed += snprintf(bf + printed, size - printed,
-				    ", UID: %s", hists->uid_filter_str);
+	if (hists->uid_filter_str) {
+		printed += scnprintf(bf + printed, size - printed,
+				     ", UID: %s", hists->uid_filter_str);
+	}
 	if (thread) {
 		if (hists__has(hists, thread)) {
 			printed += scnprintf(bf + printed, size - printed,
-- 
2.54.0

