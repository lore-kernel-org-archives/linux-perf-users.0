Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D59C28E8;
	Fri,  7 Mar 2025 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334911; cv=none; b=gqvUeGvKKkGwj87FKCorCXsmnzSvSgJcvTRmjVSuQi5Kl2JgIsUzzxisZ27A6A8C9X/cLpNb4cz95vhajUWWKDkHdu0X+Yyvcp1SgRKn+6IH31LQYBD3kKRb6zU3XbcjuBmNxLRQZ2Vo8aaCzsmVkxg5cfKoVPwkqUXhCATqqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334911; c=relaxed/simple;
	bh=R7McxMqYt7xjhm1X6S7itYmS510cv+FdsApwHps+Zm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z/pMfENRwLaL6i/JOVM7oTF/50pmehMMQoNm2C/jAhZRfnlGyjwem38i9K2UxLijqDWK3Y7WmkGgXnwEtMILLvG1GZGuOlM8E356dcckMhHlTYBoGfMUvhtUMstpbrpEYaIVcIaEGU/yfVdDgSEHjERiMIEoIsjXDOjf8TqhfYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJb2y/aD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJb2y/aD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557B8C4CED1;
	Fri,  7 Mar 2025 08:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741334910;
	bh=R7McxMqYt7xjhm1X6S7itYmS510cv+FdsApwHps+Zm0=;
	h=From:To:Cc:Subject:Date:From;
	b=EJb2y/aDYLTRXoscwPEUrUes89HEur3zfemJFD5prS1cxcyS83hu9WoCWVuhPpBIy
	 q22RsO9m5z6tV7GFywb2HygpWyOvM4GfWfMjPTknq50yOXL4k83kb1uVbmMzWrhM5s
	 kYqo6k36jmNohuet02Thk1c7Z7GqfhHgYGfLw5rARB0oATdJbDBEw1h67P7Id5YVL6
	 T1Oqx7dRiIEsdBVklc1jnrkEkw6Yusc7OwaHLm5LlGcl82tALQQleMfRMNHPO8nLWm
	 KEpJ92cYXQyCa81gMyNkm+jmSyYtArVWqlYgVJb9WDkm+PaodOEhW+w8NGIhNlZuyc
	 vxQ2h0gMS7Ijw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH 1/3] perf sort: Keep output fields in the same level
Date: Fri,  7 Mar 2025 00:08:27 -0800
Message-ID: <20250307080829.354947-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is useful for hierarchy output mode where the first level is
considered as output fields.  We want them in the same level so that it
can show only the remaining groups in the hierarchy.

Before:
  $ perf report -s overhead,sample,period,comm,dso -H --stdio
  ...
  #          Overhead  Samples / Period / Command / Shared Object
  # .................  ..........................................
  #
     100.00%           4035
        100.00%           3835883066
           100.00%           perf
               99.37%           perf
                0.50%           ld-linux-x86-64.so.2
                0.06%           [unknown]
                0.04%           libc.so.6
                0.02%           libLLVM-16.so.1

After:
  $ perf report -s overhead,sample,period,comm,dso -H --stdio
  ...
  #    Overhead       Samples        Period  Command / Shared Object
  # .......................................  .......................
  #
     100.00%          4035    3835883066     perf
         99.37%          4005    3811826223     perf
          0.50%            19      19210014     ld-linux-x86-64.so.2
          0.06%             8       2367089     [unknown]
          0.04%             2       1720336     libc.so.6
          0.02%             1        759404     libLLVM-16.so.1

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/sort.c | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f08fbc4bf0a2ce29..6b49d64854f5f986 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -3720,6 +3720,34 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 	return -ESRCH;
 }
 
+/* This should match with sort_dimension__add() above */
+static bool is_hpp_sort_key(const char *key)
+{
+	unsigned i;
+
+	for (i = 0; i < ARRAY_SIZE(arch_specific_sort_keys); i++) {
+		if (!strcmp(arch_specific_sort_keys[i], key) &&
+		    !arch_support_sort_key(key)) {
+			return false;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(common_sort_dimensions); i++) {
+		struct sort_dimension *sd = &common_sort_dimensions[i];
+
+		if (sd->name && !strncasecmp(key, sd->name, strlen(key)))
+			return false;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(hpp_sort_dimensions); i++) {
+		struct hpp_dimension *hd = &hpp_sort_dimensions[i];
+
+		if (!strncasecmp(key, hd->name, strlen(key)))
+			return true;
+	}
+	return false;
+}
+
 static int setup_sort_list(struct perf_hpp_list *list, char *str,
 			   struct evlist *evlist)
 {
@@ -3727,7 +3755,9 @@ static int setup_sort_list(struct perf_hpp_list *list, char *str,
 	int ret = 0;
 	int level = 0;
 	int next_level = 1;
+	int prev_level = 0;
 	bool in_group = false;
+	bool prev_was_hpp = false;
 
 	do {
 		tok = str;
@@ -3748,6 +3778,19 @@ static int setup_sort_list(struct perf_hpp_list *list, char *str,
 		}
 
 		if (*tok) {
+			if (is_hpp_sort_key(tok)) {
+				/* keep output (hpp) sort keys in the same level */
+				if (prev_was_hpp) {
+					bool next_same = (level == next_level);
+
+					level = prev_level;
+					next_level = next_same ? level : level+1;
+				}
+				prev_was_hpp = true;
+			} else {
+				prev_was_hpp = false;
+			}
+
 			ret = sort_dimension__add(list, tok, evlist, level);
 			if (ret == -EINVAL) {
 				if (!cacheline_size() && !strncasecmp(tok, "dcacheline", strlen(tok)))
@@ -3759,6 +3802,7 @@ static int setup_sort_list(struct perf_hpp_list *list, char *str,
 				ui__error("Unknown --sort key: `%s'", tok);
 				break;
 			}
+			prev_level = level;
 		}
 
 		level = next_level;
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

