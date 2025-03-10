Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9932A1EB5F9;
	Mon, 10 Mar 2025 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646967; cv=none; b=JtWBghp1f5cu8OBy7szXYzIkEa8Awzz/kIJIqWUiDA3V/MLC5xlyVS45IYBUAnZBihH3NBoFDcC7ncq2yb+ShjdO/JLy0p4Js0918ZQrcRgAgp4vjkmc3XGlcpj/G7PeHkm59rP2xlUCr66qOVz+5tm9ok0ulhRLzYA2T5wBhfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646967; c=relaxed/simple;
	bh=LyTo7sFjnogmd09szBPpG47+nMOqHTi8i38MCphK5zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rx5SVbPb2NmNApvgQHdJVcXIYrgl8GNzEK+kl8a9H0pH/Gx2PR/uD3ligSRrJGXMqqenqRkTtcQxH31NUIa1dVyxqvOD6NR+4HVVHhUv2Zw9RUmiK1HQfUSi/2yjLV4AkQDWDpAH54gQRGX3M6eVNwV/Mb4JCBfPqfZzN+xPEic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7bt1CAV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7bt1CAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F42C4CEEA;
	Mon, 10 Mar 2025 22:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741646967;
	bh=LyTo7sFjnogmd09szBPpG47+nMOqHTi8i38MCphK5zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7bt1CAVIcnTclypz5WXR70I6FWAZweVJBk0jJcoJInqwtaApCH6VM0w9JYOfbGZY
	 IyJYnDkdpMFXaVVKJFGDWB1OfvFKISv8XIrJdJCutpUMS4J6cLIwehDLwzxjOA0tay
	 05kWQ4dFDG7tfZ/lRZ0s0V/0rKIeKG5kU1Hsih3VTC/hauczESMTrjqqH8ggyuVyqq
	 hUqQdYtHC6GZHWlIjO/giuJsnECj9NxomydMSwh3SzOkeZKUwqUiRn1siv/0IQOWDw
	 7orQfy0wBdJc6Nf0nZ8zwE8EtKMo8PYYPZwsGuaPg2Tijz04t0PVMKw66aGzNzRGqB
	 goss0WhiWfQpA==
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
Subject: [PATCH v2 1/7] perf annotate-data: Add annotated_data_type__get_member_name()
Date: Mon, 10 Mar 2025 15:49:19 -0700
Message-ID: <20250310224925.799005-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250310224925.799005-1-namhyung@kernel.org>
References: <20250310224925.799005-1-namhyung@kernel.org>
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

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 34 ++++++++++++++++++++++++++++
 tools/perf/util/annotate-data.h | 13 +++++++++++
 tools/perf/util/sort.c          | 39 ++++++---------------------------
 3 files changed, 54 insertions(+), 32 deletions(-)

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
index 98c80b2268dde889..541fee1a5f0a7af2 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -227,8 +227,13 @@ void annotated_data_type__tree_delete(struct rb_root *root);
 /* Release all global variable information in the tree */
 void global_var_type__tree_delete(struct rb_root *root);
 
+/* Print data type annotation (including members) on stdout */
 int hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel);
 
+/* Get name of member field at the given offset in the data type */
+int annotated_data_type__get_member_name(struct annotated_data_type *adt,
+					 char *buf, size_t sz, int member_offset);
+
 bool has_reg_type(struct type_state *state, int reg);
 struct type_state_stack *findnew_stack_state(struct type_state *state,
 						int offset, u8 kind,
@@ -276,6 +281,14 @@ static inline int hist_entry__annotate_data_tty(struct hist_entry *he __maybe_un
 	return -1;
 }
 
+static inline int annotated_data_type__get_member_name(struct annotated_data_type *adt __maybe_unused,
+						       char *buf __maybe_unused,
+						       size_t sz __maybe_unused,
+						       int member_offset __maybe_unused)
+{
+	return -1;
+}
+
 #endif /* HAVE_LIBDW_SUPPORT */
 
 #ifdef HAVE_SLANG_SUPPORT
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
2.49.0.rc0.332.g42c0ae87b1-goog

