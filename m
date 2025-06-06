Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F823C8BE;
	Fri,  6 Jun 2025 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749250472; cv=none; b=nr0LqCxVB8gK0q8tQqYFVsNVL+5k3MgrsmeiWnc5wESXC9wYNlsG46jrH6BrrolyGCYrGzx7i8v0Hs8bpIOldGWUIEbzrZZyP2YrtJqGX4WaqCVpYOuakNASEBvLMEGIX/p8gyjUwoBVahlL6/zBsizes+rpyWnHM0kryrCshs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749250472; c=relaxed/simple;
	bh=is14w4mWXnoRFJnkCMtBgHOur6M9t/X7/GopRZIhvo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uLbVSVcMDzCZG4T7zY/NVPmfZi0BQurbZASnKGRKr37GoP7wNMqD/0+b8KCH1+UHk6RrwVNVNUArJiUnLkFPKg/V+PwEr77NDBlUdkdevoEuICGVT5DZZ0wo8NtLIrTPnBislMNS4q3pRpUjGc0ChCNfPXp6I8DhZx+E7CUkhsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzJoXtga; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzJoXtga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DEEC4CEEB;
	Fri,  6 Jun 2025 22:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749250472;
	bh=is14w4mWXnoRFJnkCMtBgHOur6M9t/X7/GopRZIhvo8=;
	h=From:To:Cc:Subject:Date:From;
	b=lzJoXtga/9yOtbzHR05mkRW0arjDvuie4NX6CILdcaRyJedJnd78u8vT+blFTViBs
	 awKKQA8mmTnH9MOoMx7PbohJbddhydnJyzjt0In8ZWvzG/SwJ9+dlxOVBenixjILkN
	 DGjnjMjz1rkTHBuF/SqxvIw4jVyWwuxmA79rb4EYqsyEcYQeCJuSan8GtSWpmUw0Yn
	 NFwNydPq8deMliS2DSFaqPZH2f2l4nzfleh03ablBERBW1i8kqxplSDQ2e3gPO+/Ft
	 xmQe5ZXnOJr7daYF+byJQZZxIbZRBeCTHj754vmU7aScJzt8E4cNJBKHtjNaemGo7p
	 GbphRj6nz8Pbg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf parse-events: Set default GH modifier properly
Date: Fri,  6 Jun 2025 15:54:31 -0700
Message-ID: <20250606225431.2109754-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7b100989b4f6bce7 ("perf evlist: Remove __evlist__add_default")
changed to use "cycles:P" as a default event.  But the problem is it
cannot set other default modifiers correctly.

perf kvm needs to set attr.exclude_host by default but it didn't work
because of the logic in the parse_events__modifier_list().  Also the
exclude_GH_default was applied only if ":u" modifier was specified -
which is strange.  Move it out after handling the ":GH" and check
perf_host and perf_guest properly.

Before:
  $ ./perf kvm record -vv true |& grep exclude
  (nothing)

But specifying an event (without a modifier) works:

  $ ./perf kvm record -vv -e cycles true |& grep exclude
    exclude_host                     1

After:
It now works for the both cases:

  $ ./perf kvm record -vv true |& grep exclude
    exclude_host                     1

  $ ./perf kvm record -vv -e cycles true |& grep exclude
    exclude_host                     1

Fixes: 35c8d21371e9b342 ("perf tools: Don't set attr.exclude_guest by default")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/parse-events.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7f34e602fc080881..d1965a7b97ed6b97 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1830,13 +1830,11 @@ static int parse_events__modifier_list(struct parse_events_state *parse_state,
 		int eH = group ? evsel->core.attr.exclude_host : 0;
 		int eG = group ? evsel->core.attr.exclude_guest : 0;
 		int exclude = eu | ek | eh;
-		int exclude_GH = group ? evsel->exclude_GH : 0;
+		int exclude_GH = eG | eH;
 
 		if (mod.user) {
 			if (!exclude)
 				exclude = eu = ek = eh = 1;
-			if (!exclude_GH && !perf_guest && exclude_GH_default)
-				eG = 1;
 			eu = 0;
 		}
 		if (mod.kernel) {
@@ -1859,6 +1857,13 @@ static int parse_events__modifier_list(struct parse_events_state *parse_state,
 				exclude_GH = eG = eH = 1;
 			eH = 0;
 		}
+		if (!exclude_GH && exclude_GH_default) {
+			if (perf_host)
+				eG = 1;
+			else if (perf_guest)
+				eH = 1;
+		}
+
 		evsel->core.attr.exclude_user   = eu;
 		evsel->core.attr.exclude_kernel = ek;
 		evsel->core.attr.exclude_hv     = eh;
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog

