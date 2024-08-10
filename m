Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A0613CF8C;
	Sat, 10 Aug 2024 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723317304; cv=none; b=Wj24NEL3qiaU3N1AKcrWZc2plOl/Mas6lvUtpZWfcT+Ypv6QfU3+f494BR014k86ozy7I6sgzSq0FwRKbSm2SqjAW5VyEeUxLvM9UXH8rOcPHpTEI1T6wFnvRghEhYSwAo6YfnqDWpwGDG6S6+aFjDE8U2ZlF5sA8OHgn5WLCRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723317304; c=relaxed/simple;
	bh=UfuaYCE9A6dy6rV17fG+J80wNjWQc0fQQISknMXjsMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nb2TE5p2D2BvpwsjRwy7ISsT0UHpvtqABQeppQFKSYfs9SjIOI4KObnZr5N0k1ah3ERYNKuaPFanseDgh8IDOBFfBrDysuvQF4VBkg16GzuDsDSPP649OXRD09+BiV6wL/7FjVzrbxysk2wDvUf70GhLqKzT6JZGPRIt+GgxRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnxNLere; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnxNLere"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37991C32781;
	Sat, 10 Aug 2024 19:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723317303;
	bh=UfuaYCE9A6dy6rV17fG+J80wNjWQc0fQQISknMXjsMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MnxNLeretaUXpQ9R9KAfa4HZTiKq/sqsYGNSjpn1SzfW/bWxHtXmWS1zjrhIhjpGR
	 /pnZpxPIZpdy+YsJM+mUcRWK9jog1VdMzlwW9mVjMY0iOctKtSSj9A74fIhxvDfNWy
	 INfQH6hJNOrNpdj/PboE6uqw5knYcMfcINq1SKAIhUUb/F3ZudyqbKuRp/66qCW2hv
	 7hNoThp3EbXYoAufwSZa8otO4D5DGVf8LlIbf3MrbhtMEC7G0M6L6uA2vv3b4ZjmYA
	 br8fAGXnE3QhEwjQVsBUYEAa+0cEvbGPcESAppOFZw5WUtJR/Z1u6W+vHT+hOK7dPo
	 Z0xK6J5JmncWw==
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
Subject: [PATCH] perf annotate-data: Fix a buffer overflow in TUI browser
Date: Sat, 10 Aug 2024 12:15:02 -0700
Message-ID: <20240810191502.1947959-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <CA+JHD90ZChq4FFyrqVYE9RvK=K2sKoD6T5dyYknK=STST9_AEQ@mail.gmail.com>
References: <CA+JHD90ZChq4FFyrqVYE9RvK=K2sKoD6T5dyYknK=STST9_AEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In get_member_overhead(), k is updated when it has a entry in the
histogram.  But the entry->hists array is allocated with the number of
evsel in the group.  So the k should be reset when it iterates the event
using for_each_group_evsel(), otherwise it'd crash due to a buffer
overflow.

Fixes: cb1898f58e0f ("perf annotate-data: Support --skip-empty option")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate-data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
index c3db80a7589a..a937b55da736 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -46,11 +46,12 @@ static int get_member_overhead(struct annotated_data_type *adt,
 	struct annotated_member *member = entry->data;
 	int i, k;
 
-	for (i = 0, k = 0; i < member->size; i++) {
+	for (i = 0; i < member->size; i++) {
 		struct type_hist *h;
 		struct evsel *evsel;
 		int offset = member->offset + i;
 
+		k = 0;
 		for_each_group_evsel(evsel, leader) {
 			if (symbol_conf.skip_empty &&
 			    evsel__hists(evsel)->stats.nr_samples == 0)
-- 
2.46.0.76.ge559c4bf1a-goog

