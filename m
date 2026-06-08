Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3B03EE1C4;
	Mon,  8 Jun 2026 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949916; cv=none; b=Y+QLBTJDsAbfeGjElLpaDaZE2Ya5zxY9J9Y/ceFTznZLpaJUlEuwr2s4aw0eDiYmsE5+oiH2pi87Zw4f3mbtEuKkOV9vPd2jps8D0BCOjF0Ou3/P3NsOl91aoKPLBYTVcUzskyCt9rVTr0ExN8teX6O/jQVm9UVH4CBJcDYeV6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949916; c=relaxed/simple;
	bh=yzpqRp1KXXDtRZ3nmlG1tbtU+tGkMKMkq+qmu7cRbFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwzfAKjXPP/h1/4yZfWAKzpmZd5GQjDREMU2aN/H2JBGEA12rAqMGAViuNKa5vMkVs9vIW850lgcE01c7Wic+s8nAxDSfSI1Xq3bDxMvEAu7PEoP5N7NgI4i8FVeGQm+ar48Pkan6L6ikJBCyYC7/lGDKEv/Y8Rq+LMBbF/Z+UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDOTNTTb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDOTNTTb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887DD1F00898;
	Mon,  8 Jun 2026 20:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949914;
	bh=mb2YK/7aZ7ZZv5PM4t9lUCtnKOmzQa+WV7ppgUYJCqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eDOTNTTbLOStCf8Y3t/nG+1nXV6ZfNm0aQXHOCE6GLiptjXtMXBoJW6qOW2bPEJT6
	 4wi/lQ9MM6fDa6LKWWojQwcTnEBA7ajTJ2XPF5SAY1LsPfkMHJoD0GCqjjmIuBPvrk
	 9cLp7RS9ZSQafQBR+8H8fBJp085pt72T0u0c/Ab8TkoKNZva2NM1vdZyCd79KsNYM0
	 r+nBcgePik4y6py5F0iPWe8Vbz7kAfc8h7aCyN9c/GQG2JE8cTOmDNoLBgz9ju3Rdp
	 eNukdJhHNJ9qJWc1i7IbqAYvZaJOPMp7Uow/vDgdfvgmDrscWQ6BfPoQ8292QAKYud
	 yjcYm2kKLF5BQ==
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
Subject: [PATCH 09/11] perf hists: Fix snprintf() in hists__scnprintf_title() UID filter path
Date: Mon,  8 Jun 2026 17:17:49 -0300
Message-ID: <20260608201753.1979464-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608201753.1979464-1-acme@kernel.org>
References: <20260608201753.1979464-1-acme@kernel.org>
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

