Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F1C13B5A8;
	Fri, 10 May 2024 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375094; cv=none; b=L2d7HWduJogMrx7r0gFr+IeMD7r8qLbw/HuewHlo3c2g8yxQlfjNLPbJZNBlzsdSoGVu1rF7xk8g9irmOQeKyU04hnwzUpb1xioXb2S+Szswjsypu9SV5IB5PZUHwWwbUbzfB0KC3gZDpyWasXHJetF7Px98iLNkNTO9HfIdfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375094; c=relaxed/simple;
	bh=HBZIj1WAuQM5nC/b9RWGi6gCG6UEdmsr7b+HnD3F+1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDbhYzQdAYGZ6AK7h79LnhKqwXXJXSkelkSnU4A5CqMrJS1wQJdqMFnuNVdXY3JunrTQ1RVvd41rvrKdMo6K+mGUTwewkIuxI8fZhxFId3HTx7maqyUXRT7kCovkPXVVYhsO/jbvtBEoJwE3hMvSvrPWyeLuWeg4LxiPcT7SHlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dm1LHtwI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dm1LHtwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0086CC32781;
	Fri, 10 May 2024 21:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715375094;
	bh=HBZIj1WAuQM5nC/b9RWGi6gCG6UEdmsr7b+HnD3F+1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dm1LHtwIJqJWUYZU/FM4z2YDihwqpiFG3uY4Z+EMVdi+48iNByqfb1A25NdIXLlyE
	 NSpSw8JH9nca5my7b9OymwjfQn6bmNzplbyRRtbQurXFL/7N1xI9nOdM40sVjJG0nK
	 OAhk3kGLOf/hh3liILX3YNNFq6LZ3qBa9vzzfYkGzJEuJvHyHN72VpHeDYnbSn1y5W
	 958QUcpjnYwo1897xdtxMU3zh8ij8bcPKHRkeLzgHeMisHM+oFgEUafjw3L4pahj5l
	 WzEfaueLku+xbqNATXeK7+EMsOv6KH38p7ci7vV9fohVNcH7rICGVXWrdhTwtEfjP8
	 fbAfkpTynnj5Q==
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
Subject: [PATCH 2/2] perf annotate-data: Ensure the number of type histograms
Date: Fri, 10 May 2024 14:04:52 -0700
Message-ID: <20240510210452.2449944-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
In-Reply-To: <20240510210452.2449944-1-namhyung@kernel.org>
References: <CAM9d7ci6Y98hkiN1+=Q=YgLQLL-GN+pTxQ1JjqA+Q1EMEi52+g@mail.gmail.com>
 <20240510210452.2449944-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arnaldo reported that there is a case where nr_histograms and histograms
don't agree each other.  It ended up in a segfault trying to access NULL
histograms array.  Let's make sure to update the nr_histograms when the
histograms array is changed.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 57e7d4b3550b..965da6c0b542 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1800,7 +1800,6 @@ static int alloc_data_type_histograms(struct annotated_data_type *adt, int nr_en
 	sz += sizeof(struct type_hist_entry) * adt->self.size;
 
 	/* Allocate a table of pointers for each event */
-	adt->nr_histograms = nr_entries;
 	adt->histograms = calloc(nr_entries, sizeof(*adt->histograms));
 	if (adt->histograms == NULL)
 		return -ENOMEM;
@@ -1814,6 +1813,8 @@ static int alloc_data_type_histograms(struct annotated_data_type *adt, int nr_en
 		if (adt->histograms[i] == NULL)
 			goto err;
 	}
+
+	adt->nr_histograms = nr_entries;
 	return 0;
 
 err:
@@ -1827,7 +1828,9 @@ static void delete_data_type_histograms(struct annotated_data_type *adt)
 {
 	for (int i = 0; i < adt->nr_histograms; i++)
 		zfree(&(adt->histograms[i]));
+
 	zfree(&adt->histograms);
+	adt->nr_histograms = 0;
 }
 
 void annotated_data_type__tree_delete(struct rb_root *root)
-- 
2.45.0.118.g7fe29c98d7-goog

