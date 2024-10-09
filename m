Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A181E22E4;
	Wed,  9 Oct 2024 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505212; cv=none; b=MFCXjIh3YykwBHe6R/QqGEXiduqlfUu1sSruqzua8M+7Z4wv20lypt4QhcbjfpQ2E3LQ/g7XEUgfH6BmHyPuhPNOE7OEgIvYzko72T+WeSYPQcU9iwaIBAC6dapd4P5NGsDnaAokCLgbGoJJdOEVWkkky1ibNTkHqvKjOHrY3Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505212; c=relaxed/simple;
	bh=mKDdaLVBNhhxGXFWnMRy3d6ToS5emDeXqh9jc1BIO2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyKW8WtG02Hz0xnggURgBtbtD4pJ8+Wm/29mJIk7UGR3BwD1Pm43uE0au+HUF2BVXHKwmIkb08fxAzax0Ml9hsMkLHzH9VOQM9MaTvyS6BIxe3ZaRU0/SksTLEwxcKxiYFpGfE3AlpOYY15XYQwO4zGHYbWuUdRU0Y/cqwwMf5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmKUabRI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmKUabRI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34C2C4CECC;
	Wed,  9 Oct 2024 20:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728505212;
	bh=mKDdaLVBNhhxGXFWnMRy3d6ToS5emDeXqh9jc1BIO2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmKUabRIYayLfnZbYtSNBKnnFiE20KYESf7HZJRAbwykq15exuhA1raCBtLaJQVTz
	 Bm4pFtbFdNuQN98Rksw9ZfqTOEaywOo1mENvOTmJAgyqtObzpO52/Uvqe3uMtR4v7r
	 PscfML+ZRzavFP8JcpZVse0w2Cud3n99FxF18MGErNO9jlTrkfI1Lp0Q1dmqD3A5M4
	 M/P2z2XvpmWoCj15UxboowWTSSHdKMYdrmqR4arovmbNhjPaSggxkmMoarAt9jlmgz
	 3uK+bPY3n2HS9ncwgnY6o/XRJ5IfwDHo6ZK2dBu+dc6ptLwIR3MFmxgPpPVYqE3Aw+
	 c8obmxyYiWZgg==
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
Subject: [PATCH 2/2] perf tools: Remove unnecessary parentheses
Date: Wed,  9 Oct 2024 13:20:09 -0700
Message-ID: <20241009202009.884884-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241009202009.884884-1-namhyung@kernel.org>
References: <20241009202009.884884-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hashmap API used to require parentheses for the hashmap argument if
it's not a pointer type.  It's now fixed so let's drop the parentheses.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/threads.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/threads.c b/tools/perf/util/threads.c
index ff2b169e0085ed77..6ca0b178fb6c3a9d 100644
--- a/tools/perf/util/threads.c
+++ b/tools/perf/util/threads.c
@@ -141,7 +141,7 @@ void threads__remove_all_threads(struct threads *threads)
 
 		down_write(&table->lock);
 		__threads_table_entry__set_last_match(table, NULL);
-		hashmap__for_each_entry_safe((&table->shard), cur, tmp, bkt) {
+		hashmap__for_each_entry_safe(&table->shard, cur, tmp, bkt) {
 			struct thread *old_value;
 
 			hashmap__delete(&table->shard, cur->key, /*old_key=*/NULL, &old_value);
@@ -175,7 +175,7 @@ int threads__for_each_thread(struct threads *threads,
 		size_t bkt;
 
 		down_read(&table->lock);
-		hashmap__for_each_entry((&table->shard), cur, bkt) {
+		hashmap__for_each_entry(&table->shard, cur, bkt) {
 			int rc = fn((struct thread *)cur->pvalue, data);
 
 			if (rc != 0) {
-- 
2.47.0.rc0.187.ge670bccf7e-goog

