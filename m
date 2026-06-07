Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3866620010A;
	Sun,  7 Jun 2026 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780875035; cv=none; b=WoU/STDrnE8ZEKdDIfnoKKRVeN04bLN2dEj+SgSbsWJWZiF7KhGwSZE/OMXvyxR27PSYREbQGv9d9KCCOfmfhaC8sNmde5cuWNdnN69QHW3xo0DUQ/iHjRgds391XAOMWaOS0qTeLxVgqCfXNRPO5GoAmHn4tWkUx/44hiIxGZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780875035; c=relaxed/simple;
	bh=yzpqRp1KXXDtRZ3nmlG1tbtU+tGkMKMkq+qmu7cRbFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vcvrrqs+KQ7NPY0fEtMcWWmAFY5LkDjnpYY7JyIQ3xTxPn2+BprT2yanRdKyMEpiKXF4Rktm4tJgu4Dj0rHZofmK6r1zDlkPY+XAdhaM9R5kyhq3of0MkebwSN3D0aWdrwhVPbkF1GVgIW31u61/1RPqxJEQjjuoygHv1OzC3QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK9nPFBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK9nPFBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D611F00893;
	Sun,  7 Jun 2026 23:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780875033;
	bh=mb2YK/7aZ7ZZv5PM4t9lUCtnKOmzQa+WV7ppgUYJCqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WK9nPFBm/4Wmr7jdj1PQs9MCTaC/aUw51I3XPkehLC3vbeD6/OUwf2ny86iwYu3Ur
	 KPxNjDKouPZEt6TOkTWmISdW6ZTx1eqiF4Se3kMMn16fk2cd3g2yjSUcLkHJy1FflY
	 wgSmm2cIuukfhcs5qKFJsezUgTjMfAQ+VKHyQ/C/c9HxQNWq0SGsGA51bUrUlY/tCA
	 03HsKHE5IoO05L7pBHt0PqRko0V8llYT9R/Qs1ddd8tHIHqO6PToaDOLWVovZ7Ao4M
	 ZfFsQKgkwf7xgg4KfNafnoJWW7JeMxkg/kf+oA5qa72QzN96k7Aq2eEOh2z8T9Br+l
	 27EnYPXLAX7hQ==
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
Date: Sun,  7 Jun 2026 20:29:23 -0300
Message-ID: <20260607232925.1935819-11-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607232925.1935819-1-acme@kernel.org>
References: <20260607232925.1935819-1-acme@kernel.org>
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

