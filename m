Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B4B3E8C46;
	Wed, 16 Sep 2026 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539572; cv=none; b=uHpNDMS6uGKUNFyCwvH2JIKpTIjzjjnNxL/8zLjckoqtHCF74DjgPBW8tV1INYqUDhr3flf/sKlHFC1cnnzVst+k8EAiu1o1UfjMkYfrF5v3dT1Gq+gLg3lzqoqej5a0HYZgjFEncHzgMaxxm7V2kB8hb+Cf5o1nNp3KGGH6ffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539572; c=relaxed/simple;
	bh=jXC3n+iEzHQcWYd6uXZrNnYmtL5ZmmYgDfm4jV7hLMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIerIQ7oluc+rTeQ4p2mlOq1LK0qoRt7gU6WImrCC1LArRQ4gbh95vAMI5XfDTQ0WJb+E8rIu7KHwchfGvN7wWfcVhR1LlaysdosY0ZFpYA71Xz0Ta4bHxC1BY2onX6SSnLpD2yl9LwS0e3MEfsCesVBA7ZUZIuDBFbAuu8WTPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fD6lEAxa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD6lEAxa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F67D1F00899;
	Wed, 16 Sep 2026 06:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539570;
	bh=R3YoEwxyzqsQ9OofOJ+4vhwOKv46eKYIDoSvwPNiBrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fD6lEAxaQts6hKlolmhL4bCUsK9cSTtp2GGXsKRH1cSj0wd3GM3aBU4urWDhB7EVN
	 p/w+KSlgs88Q+YE5q8ZkflbqQvK8Qmj9hPSfXpa8oIp8INfcP/1J7GWxZsVKSht3Dl
	 WXdUOFy987J+z1rZ/6Lvhsxc4nH++h/R690BJXjrFAwEOSufDmwDxZQ/voik/8YC6i
	 dtG9FTtzED5fa7DW5v5+To99IrhHoNFEL6F4GNK21L/Jk9ZGut/4UVbJ0GsPDQw7c9
	 9gKN1Cx+xFA5cIX0YL1rSwMeW+YCHBBs88bdhawqdYp0h326mqyv3QZ/jG9g3rc4uO
	 Jy1zllFjIyC9w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Zecheng Li <zli94@ncsu.edu>,
	Yanbo Zhao <yzhao62@ncsu.edu>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v4 3/3] perf annotate-data: Adjust type offset for flex-array
Date: Tue, 15 Sep 2026 23:19:26 -0700
Message-ID: <20260916061926.2224222-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916061926.2224222-1-namhyung@kernel.org>
References: <20260916061926.2224222-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flex array members are located beyond the original type size.  Also
it needs to adjust the offset in an array to find a corresponding
element using module operation.  Note that we focus on access to type and
field, so array index is not important.

Make sure to find a field name for flex arrays.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 85 +++++++++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 1ee2b74f99205567..d4410d720e12635b 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -240,8 +240,13 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	if (member == NULL)
 		return DIE_FIND_CB_END;
 
-	strbuf_init(&sb, 32);
-	die_get_typename(die, &sb);
+	if (strbuf_init(&sb, 32) < 0) {
+		free(member);
+		return DIE_FIND_CB_END;
+	}
+
+	if (die_get_typename(die, &sb) < 0)
+		strbuf_add(&sb, "(unknown type)", 14);
 
 	__die_get_real_type(die, &member_type);
 	if (dwarf_tag(&member_type) == DW_TAG_typedef)
@@ -249,7 +254,7 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	else
 		die_mem = member_type;
 
-	if (dwarf_aggregate_size(&die_mem, &size) < 0) {
+	if (dwarf_aggregate_size(&die_mem, &size) < 0 || size == 0) {
 		if (dwarf_tag(&die_mem) == DW_TAG_array_type) { /* flex-array? */
 			die_get_real_type(&die_mem, &die_mem);
 			if (dwarf_aggregate_size(&die_mem, &size) < 0)
@@ -333,19 +338,40 @@ static void delete_members(struct annotated_member *member)
 }
 
 static int fill_member_name(char *buf, size_t sz, struct annotated_member *m,
-			    int offset, bool first)
+			    int offset, bool first, bool has_flex_array)
 {
 	struct annotated_member *child;
+	bool found = false;
+	int len;
 
 	if (list_empty(&m->children))
 		return 0;
 
 	list_for_each_entry(child, &m->children, node) {
-		int len;
-
 		if (offset < child->offset || offset >= child->offset + child->size)
 			continue;
 
+		found = true;
+		break;
+	}
+
+	if (!found && has_flex_array) {
+		/*
+		 * It may have an intermediate struct that has another struct that
+		 * contains a flex array.  In that case, the outer struct itself is
+		 * has no array and the size is less than the offset so the above
+		 * logic won't find the outer struct at the offset.  Let's use the
+		 * last struct if it couldn't find a member for the flex array.
+		 */
+		child = list_last_entry(&m->children, struct annotated_member, node);
+
+		if (offset < child->offset)
+			return 0;
+
+		found = true;
+	}
+
+	if (found) {
 		/* It can have anonymous struct/union members */
 		if (child->var_name) {
 			len = scnprintf(buf, sz, "%s%s",
@@ -355,15 +381,37 @@ static int fill_member_name(char *buf, size_t sz, struct annotated_member *m,
 			len = 0;
 		}
 
-		return fill_member_name(buf + len, sz - len, child, offset, first) + len;
+		return fill_member_name(buf + len, sz - len, child, offset, first,
+					has_flex_array) + len;
 	}
+
 	return 0;
 }
 
 int annotated_data_type__get_member_name(struct annotated_data_type *adt,
 					 char *buf, size_t sz, int member_offset)
 {
-	return fill_member_name(buf, sz, &adt->self, member_offset, /*first=*/true);
+	return fill_member_name(buf, sz, &adt->self, member_offset, /*first=*/true,
+				adt->flex_array);
+}
+
+static struct annotated_member *find_flex_array(struct annotated_member *m)
+{
+	struct annotated_member *child;
+
+	if (list_empty(&m->children))
+		return NULL;
+
+	child = list_last_entry(&m->children, struct annotated_member, node);
+	if (strstr(child->type_name, "[]"))
+		return child;
+
+	return find_flex_array(child);
+}
+
+static struct annotated_member *get_flex_array_member(struct annotated_data_type *adt)
+{
+	return find_flex_array(&adt->self);
 }
 
 static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
@@ -1740,6 +1788,7 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
 {
 	struct dso *dso = map__dso(dloc->ms->map);
 	Dwarf_Die type_die;
+	struct annotated_data_type *result;
 
 	/*
 	 * The type offset is the same as instruction offset by default.
@@ -1752,7 +1801,25 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
 	if (find_data_type_die(dloc, &type_die) < 0)
 		return NULL;
 
-	return dso__findnew_data_type(dso, &type_die);
+	result = dso__findnew_data_type(dso, &type_die);
+	if (result == NULL)
+		return NULL;
+
+	if (result->flex_array && dloc->type_offset > result->self.size) {
+		struct annotated_member *flex_array = get_flex_array_member(result);
+
+		if (flex_array && flex_array->size > 0) {
+			int offset = dloc->type_offset;
+
+			/* adjust offset in the flex array */
+			offset -= flex_array->offset;
+			offset %= flex_array->size;
+			offset += flex_array->offset;
+
+			dloc->type_offset = offset;
+		}
+	}
+	return result;
 }
 
 static size_t data_type_hash(long key, void *ctx __maybe_unused)
-- 
2.55.0.1032.g73a4cd73de-goog

