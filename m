Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178C531AABC;
	Tue, 16 Jun 2026 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638273; cv=none; b=J+4abdy5IOX8pXvljaq4JeajEw0ZMBlOly7meId6IaV7bJ+CttfEyM9FcelVUqgdqDexQZQg46Pp5o8TXhmf8sbrjcCgxsvlmK1l8REtFE3y3SGBEvy6QWpLWReI2P649h3kWoepOlC4Igumo5Dbz+Z9umATZ5+9nIQG3BSjDDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638273; c=relaxed/simple;
	bh=85JVqkl+rAWNKauVFQtmQqG9O8SSpaup6AiUDrOlojw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1tKsrZjvleSM6TIj5NmaYVpiYUP+eDqOWcvnuQz2RYU3o5ZK1qz2ScPoUcnofVVp/cS0gR4etsW+iRzcirwcQXJmXkEv5l+6mH5VhIi6jOjMa3EQjRQn+TV8HUwlYAfMzB3mpW4UnqpJ8tLreBFyo/FMtPmrAB8pk6G9xVJajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9X/ogP8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9X/ogP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1CA1F00A3A;
	Tue, 16 Jun 2026 19:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781638271;
	bh=YrLNC0wOc+lKp5A99yCEhVgyMiZgBXvsO7vMwIGGKCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O9X/ogP8uAKwY797vR9bImbL/YOYWSf+sSfY4jE0Tw29HRcNCaW3DaV/7Gq8U5cRP
	 asNhnmrJHTFppGJTg2E1cuuYSRw8kH4Xnp64cMPnkH6sGccXbseHoEQ0ngC89dAy80
	 9O5Oo6C+7+QdY1uTn8lgNvRZ1YA9PY1vUkvSvon8qNep7bZZL0EFfXduTqsH9WasrJ
	 IW7sg+9o+nI2JLp9Xl+CefPPE2Mje0BAljt4bdW1RnSIcAM2mkWNsIz3LLAADuhqvz
	 pq2r+i0BQNq0JeZs9rHhrR4C1HIMh1HS8jIeAIyA0KU28GesNFnMf8H49R5RMkZ5FI
	 QZGPH3ORNsNiA==
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
	Claude <noreply@anthropic.com>
Subject: [PATCH 7/9] perf c2c: Fix hist entry and format list leaks in c2c_he_free()
Date: Tue, 16 Jun 2026 16:30:31 -0300
Message-ID: <20260616193033.10035-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616193033.10035-1-acme@kernel.org>
References: <20260616193033.10035-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

c2c_he_free() calls hists__delete_entries() which only walks the
output-sorted entries tree.  During c2c resort, when cacheline entries
are merged and the redundant entry is freed, the inner hists have not
been output-resorted yet, so hists->entries is empty.  The actual inner
hist_entry objects live in entries_in_array[] and entries_collapsed,
which are never walked, leaking all inner hist_entry objects for every
merged cacheline.

Additionally, the dynamically allocated format entries on hists->list
are never unregistered or freed.

Fix both issues by switching to hists__delete_all_entries() which walks
all rb_root trees, and calling perf_hpp__reset_output_field() to clean
up format entries.

Fixes: bf0e0d407ea09ce5 ("perf c2c report: Add sample processing")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 2 +-
 tools/perf/util/hist.c   | 2 +-
 tools/perf/util/hist.h   | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index eabb922ef295ef86..c9584dbedf77afe8 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -184,7 +184,7 @@ static void c2c_he_free(void *he)
 
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 	if (c2c_he->hists) {
-		hists__delete_entries(&c2c_he->hists->hists);
+		hists__delete_all_entries(&c2c_he->hists->hists);
 		perf_hpp__reset_output_field(&c2c_he->hists->list);
 		zfree(&c2c_he->hists);
 	}
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index df978c996b6c2262..c93915625ee75de1 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -3041,7 +3041,7 @@ static void hists__delete_remaining_entries(struct rb_root_cached *root)
 	}
 }
 
-static void hists__delete_all_entries(struct hists *hists)
+void hists__delete_all_entries(struct hists *hists)
 {
 	hists__delete_entries(hists);
 	hists__delete_remaining_entries(&hists->entries_in_array[0]);
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 8fb89d81ef069d95..b830cbe7f95bf597 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -391,6 +391,7 @@ int hists__collapse_resort(struct hists *hists, struct ui_progress *prog);
 
 void hists__decay_entries(struct hists *hists, bool zap_user, bool zap_kernel);
 void hists__delete_entries(struct hists *hists);
+void hists__delete_all_entries(struct hists *hists);
 void hists__output_recalc_col_len(struct hists *hists, int max_rows);
 
 struct hist_entry *hists__get_entry(struct hists *hists, int idx);
-- 
2.54.0

