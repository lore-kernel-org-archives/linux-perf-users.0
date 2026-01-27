Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3E72C031B;
	Tue, 27 Jan 2026 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530189; cv=none; b=o0DZi88hAZsks6Xq/q339hlYod+FNsL4SsDUsBk1IWBkW5VukTelmwwqSxd6mLnAGEZ67/+1byK4kPABE5TrCoRQeDPdE/T5WCLdTkkfZuyXlB+hL9HIGDqKmw+l2bzNA1GSeTKG3ijJ00vF7nbXLW8LTKditOAMIkuE4s2DVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530189; c=relaxed/simple;
	bh=JGH1tEsu0no5CiHAVwYuTwzbubIxQmp2wf0x7AT7v+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QsFyUi6cdpemGDFsnLxBx/Z00gTUi8NeAgk/w193XxH4DaEyfMikc/fl9SeRwl1nFlRtLUuVp9BhplIcItSoLp0uPkQ947PZM/Vvgyjwjh7PKpSUZcqTZIOkxKR44+ma68dcl2xKsMtG6anYYfKLqyjOzKyO+bYZDHL7ViiiEcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIWqHu36; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIWqHu36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA06C116C6;
	Tue, 27 Jan 2026 16:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769530188;
	bh=JGH1tEsu0no5CiHAVwYuTwzbubIxQmp2wf0x7AT7v+w=;
	h=Date:From:To:Cc:Subject:From;
	b=jIWqHu36UuqOHfbsHhspOyd6BnqBR6QZrd+EaY/9WFxeqfkdrwHvdi/qHvV+2jYOI
	 FIgJPcocOa3n14m5rVDr0uUHYN5+D9CGH81DcQ5CbiyV2xVS6ia9JzzFj20XMWqit0
	 nh9feVIswIMgaCT97ukkip9rtNj2v7XZ/G6yFkxVhDgtBo0Yz//LbnntdvYL4Tv+tM
	 7dabgeT+4XNkh41F1ZyKYvqd2a4wskIacSeEHjpWo+azFd1gX/yXZWN1Nj/BAagd1u
	 RZfmS5eg1VoZ2Fso7BVV/mwEKOd7D1hNrhmv0F6pyX2tLI6raQJOj8F24QooAxZZ6w
	 J/2kBEkWFduaw==
Date: Tue, 27 Jan 2026 13:09:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 next] perf strlist: Remove dont_dupstr logic, used only
 once
Message-ID: <aXjjSR1s3CJQn0bY@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ian Rogers noticed that 678ed6b707e4b2db ("perf strlist: Don't write to
const memory") breaks the 'Remove thread map' 'perf test' entry, because
it keeps pointers to the temporary string introduced to avoid touching
the const memory.

This is because the thread_map__new_by_[pt]id_str() were the only
methods using the slist->dont_dupstr knob to keep pointers to the
original const string list, as it uses strtol to parse numbers and it
stops at the comma.

As this is the only case of dont_dupstr use, dupstr being the default,
and it gets in the way of getting rid of the last const-correctness,
remove this knob, with it:

  $ perf test 37
  37: Remove thread map   : Ok
  $

Fixes: 678ed6b707e4b2db ("perf strlist: Don't write to const memory")
Reported-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/strlist.c    | 25 ++++++++-----------------
 tools/perf/util/strlist.h    |  2 --
 tools/perf/util/thread_map.c | 18 ++++++------------
 3 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/tools/perf/util/strlist.c b/tools/perf/util/strlist.c
index 98883672fcf47102..50add72575e0c60c 100644
--- a/tools/perf/util/strlist.c
+++ b/tools/perf/util/strlist.c
@@ -12,20 +12,16 @@
 #include <linux/zalloc.h>
 
 static
-struct rb_node *strlist__node_new(struct rblist *rblist, const void *entry)
+struct rb_node *strlist__node_new(struct rblist *rblist __maybe_unused, const void *entry)
 {
 	const char *s = entry;
 	struct rb_node *rc = NULL;
-	struct strlist *strlist = container_of(rblist, struct strlist, rblist);
 	struct str_node *snode = malloc(sizeof(*snode));
 
 	if (snode != NULL) {
-		if (strlist->dupstr) {
-			s = strdup(s);
-			if (s == NULL)
-				goto out_delete;
-		}
-		snode->s = s;
+		snode->s = strdup(s);
+		if (snode->s == NULL)
+			goto out_delete;
 		rc = &snode->rb_node;
 	}
 
@@ -36,20 +32,18 @@ struct rb_node *strlist__node_new(struct rblist *rblist, const void *entry)
 	return NULL;
 }
 
-static void str_node__delete(struct str_node *snode, bool dupstr)
+static void str_node__delete(struct str_node *snode)
 {
-	if (dupstr)
-		zfree((char **)&snode->s);
+	zfree((char **)&snode->s);
 	free(snode);
 }
 
 static
-void strlist__node_delete(struct rblist *rblist, struct rb_node *rb_node)
+void strlist__node_delete(struct rblist *rblist __maybe_unused, struct rb_node *rb_node)
 {
-	struct strlist *slist = container_of(rblist, struct strlist, rblist);
 	struct str_node *snode = container_of(rb_node, struct str_node, rb_node);
 
-	str_node__delete(snode, slist->dupstr);
+	str_node__delete(snode);
 }
 
 static int strlist__node_cmp(struct rb_node *rb_node, const void *entry)
@@ -165,12 +159,10 @@ struct strlist *strlist__new(const char *list, const struct strlist_config *conf
 	struct strlist *slist = malloc(sizeof(*slist));
 
 	if (slist != NULL) {
-		bool dupstr = true;
 		bool file_only = false;
 		const char *dirname = NULL;
 
 		if (config) {
-			dupstr = !config->dont_dupstr;
 			dirname = config->dirname;
 			file_only = config->file_only;
 		}
@@ -180,7 +172,6 @@ struct strlist *strlist__new(const char *list, const struct strlist_config *conf
 		slist->rblist.node_new    = strlist__node_new;
 		slist->rblist.node_delete = strlist__node_delete;
 
-		slist->dupstr	 = dupstr;
 		slist->file_only = file_only;
 
 		if (list && strlist__parse_list(slist, list, dirname) != 0)
diff --git a/tools/perf/util/strlist.h b/tools/perf/util/strlist.h
index 7e82c71dcc422d7e..3e9533e66ca9ee11 100644
--- a/tools/perf/util/strlist.h
+++ b/tools/perf/util/strlist.h
@@ -14,7 +14,6 @@ struct str_node {
 
 struct strlist {
 	struct rblist rblist;
-	bool	      dupstr;
 	bool	      file_only;
 };
 
@@ -24,7 +23,6 @@ struct strlist {
  *             found
  */
 struct strlist_config {
-	bool dont_dupstr;
 	bool file_only;
 	const char *dirname;
 };
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index ca193c1374ed4823..48c70f149e9201dc 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -164,19 +164,16 @@ static struct perf_thread_map *thread_map__new_by_pid_str(const char *pid_str)
 	struct dirent **namelist = NULL;
 	int i, j = 0;
 	pid_t pid, prev_pid = INT_MAX;
-	char *end_ptr;
 	struct str_node *pos;
-	struct strlist_config slist_config = { .dont_dupstr = true, };
-	struct strlist *slist = strlist__new(pid_str, &slist_config);
+	struct strlist *slist = strlist__new(pid_str, NULL);
 
 	if (!slist)
 		return NULL;
 
 	strlist__for_each_entry(pos, slist) {
-		pid = strtol(pos->s, &end_ptr, 10);
+		pid = strtol(pos->s, NULL, 10);
 
-		if (pid == INT_MIN || pid == INT_MAX ||
-		    (*end_ptr != '\0' && *end_ptr != ','))
+		if (pid == INT_MIN || pid == INT_MAX)
 			goto out_free_threads;
 
 		if (pid == prev_pid)
@@ -223,24 +220,21 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
 	struct perf_thread_map *threads = NULL, *nt;
 	int ntasks = 0;
 	pid_t tid, prev_tid = INT_MAX;
-	char *end_ptr;
 	struct str_node *pos;
-	struct strlist_config slist_config = { .dont_dupstr = true, };
 	struct strlist *slist;
 
 	/* perf-stat expects threads to be generated even if tid not given */
 	if (!tid_str)
 		return perf_thread_map__new_dummy();
 
-	slist = strlist__new(tid_str, &slist_config);
+	slist = strlist__new(tid_str, NULL);
 	if (!slist)
 		return NULL;
 
 	strlist__for_each_entry(pos, slist) {
-		tid = strtol(pos->s, &end_ptr, 10);
+		tid = strtol(pos->s, NULL, 10);
 
-		if (tid == INT_MIN || tid == INT_MAX ||
-		    (*end_ptr != '\0' && *end_ptr != ','))
+		if (tid == INT_MIN || tid == INT_MAX)
 			goto out_free_threads;
 
 		if (tid == prev_tid)
-- 
2.52.0

