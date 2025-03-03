Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3467823535E;
	Mon,  3 Mar 2025 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023489; cv=none; b=uQDALAtBe48V65+AlLheuw6tNx2fOHum6cmueDJKTvYR1a26Lmn2R8LQ+tnTHZQ/1+Q/HiI7PdXYnJfGwJPQGF0NF9Rv3Kog/YZdsCtFDOfpAyaDSpmHcILwD0nj7i/ePBt6AyHQG/oR8zjjrl+TiUlEVE9yhY/S4uLEDA+JBKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023489; c=relaxed/simple;
	bh=GDpi9wNiAD/cO0cZVgUO/Tf4xH/dw8B2UZS8sd2EcQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOsGFeMn0FXxWPk3WJVwXaToYJ1MdlO2ALXU6X/0iUjg+I7YUdHALMf0n/p5o88c1f3QHxT7vISgav33oP1T+QFhq543M3skea2UDFikwmX1re6de3v9iaOAE4q5kB8+tgvLNOeqhImluO9R+XydT5r2QFEpVJWX9wVQ+J9F/qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=In1dfOKg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="In1dfOKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D5FC4CEE6;
	Mon,  3 Mar 2025 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741023488;
	bh=GDpi9wNiAD/cO0cZVgUO/Tf4xH/dw8B2UZS8sd2EcQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=In1dfOKgPdJSkiMYLN6fAtBX2t//ojs1J1nkD+skN0Mkso0/mFwZFPqFlAI22kkfh
	 0n3ro6hfUlGzXalaHbssDVu/hAnqIU/rD5RwXfGtnfPzsGd17xG86gZEfY2oiXXcR2
	 Gt35ykYKw0ByPm8oiCh35CEj6xIZBYTGQ0cnXSz02jJEmgkSLjiZ/Iq76fz0bUA4cw
	 nK2DYeGS+8Qx1+IapjlYIktsyPfhYsBuVOKzT6iI6OJwIZnat93n15YWsf02AFhWTN
	 /MTBnU1Fp81xOYj8GHdLWQHxJoMtRHZqkXkBfU6xbMm1+pU7vYlrfLenCW/Nv26MTA
	 h5i83tzVFldww==
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 1/7] perf annotate-data: Add annotated_data_type__get_member_name()
Date: Mon,  3 Mar 2025 09:38:01 -0800
Message-ID: <20250303173807.1765098-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303173807.1765098-1-namhyung@kernel.org>
References: <20250303173807.1765098-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out a function to get the name of member field at the given
offset.  This will be used in other places.

Also update the output of typeoff sort key a little bit.  As we know
that some special types like (stack operation), (stack canary) and
(unknown) won't have fields, skip printing the offset and field.

For example, the following change is expected.

  "(stack operation) +0 (no field)"   ==>   "(stack operation)"

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 34 ++++++++++++++++++++++++++++
 tools/perf/util/annotate-data.h |  3 +++
 tools/perf/util/sort.c          | 39 ++++++---------------------------
 3 files changed, 44 insertions(+), 32 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index eaf96fa80c830d05..1ef2edbc71d91a50 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -314,6 +314,40 @@ static void delete_members(struct annotated_member *member)
 	}
 }
 
+static int fill_member_name(char *buf, size_t sz, struct annotated_member *m,
+			    int offset, bool first)
+{
+	struct annotated_member *child;
+
+	if (list_empty(&m->children))
+		return 0;
+
+	list_for_each_entry(child, &m->children, node) {
+		int len;
+
+		if (offset < child->offset || offset >= child->offset + child->size)
+			continue;
+
+		/* It can have anonymous struct/union members */
+		if (child->var_name) {
+			len = scnprintf(buf, sz, "%s%s",
+					first ? "" : ".", child->var_name);
+			first = false;
+		} else {
+			len = 0;
+		}
+
+		return fill_member_name(buf + len, sz - len, child, offset, first) + len;
+	}
+	return 0;
+}
+
+int annotated_data_type__get_member_name(struct annotated_data_type *adt,
+					 char *buf, size_t sz, int member_offset)
+{
+	return fill_member_name(buf, sz, &adt->self, member_offset, /*first=*/true);
+}
+
 static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
 							  Dwarf_Die *type_die)
 {
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 98c80b2268dde889..c9a1678a8a32518c 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -229,6 +229,9 @@ void global_var_type__tree_delete(struct rb_root *root);
 
 int hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel);
 
+int annotated_data_type__get_member_name(struct annotated_data_type *adt,
+					 char *buf, size_t sz, int member_offset);
+
 bool has_reg_type(struct type_state *state, int reg);
 struct type_state_stack *findnew_stack_state(struct type_state *state,
 						int offset, u8 kind,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 2b6023de7a53ae2e..6f7696b11b97a9f9 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2403,44 +2403,19 @@ sort__typeoff_sort(struct hist_entry *left, struct hist_entry *right)
 	return left->mem_type_off - right->mem_type_off;
 }
 
-static void fill_member_name(char *buf, size_t sz, struct annotated_member *m,
-			     int offset, bool first)
-{
-	struct annotated_member *child;
-
-	if (list_empty(&m->children))
-		return;
-
-	list_for_each_entry(child, &m->children, node) {
-		if (child->offset <= offset && offset < child->offset + child->size) {
-			int len = 0;
-
-			/* It can have anonymous struct/union members */
-			if (child->var_name) {
-				len = scnprintf(buf, sz, "%s%s",
-						first ? "" : ".", child->var_name);
-				first = false;
-			}
-
-			fill_member_name(buf + len, sz - len, child, offset, first);
-			return;
-		}
-	}
-}
-
 static int hist_entry__typeoff_snprintf(struct hist_entry *he, char *bf,
 				     size_t size, unsigned int width __maybe_unused)
 {
 	struct annotated_data_type *he_type = he->mem_type;
 	char buf[4096];
 
-	buf[0] = '\0';
-	if (list_empty(&he_type->self.children))
-		snprintf(buf, sizeof(buf), "no field");
-	else
-		fill_member_name(buf, sizeof(buf), &he_type->self,
-				 he->mem_type_off, true);
-	buf[4095] = '\0';
+	if (he_type == &unknown_type || he_type == &stackop_type ||
+	    he_type == &canary_type)
+		return repsep_snprintf(bf, size, "%s", he_type->self.type_name);
+
+	if (!annotated_data_type__get_member_name(he_type, buf, sizeof(buf),
+						  he->mem_type_off))
+		scnprintf(buf, sizeof(buf), "no field");
 
 	return repsep_snprintf(bf, size, "%s +%#x (%s)", he_type->self.type_name,
 			       he->mem_type_off, buf);
-- 
2.48.1.711.g2feabab25a-goog

