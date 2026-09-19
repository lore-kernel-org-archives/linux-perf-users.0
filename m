Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EB43515DC;
	Sat, 19 Sep 2026 06:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789799881; cv=none; b=JDNItco342oeot5h3R4IcSN/G6JLN4oXt0tduo+3vS8sGbATKAhPKQTzMtxKfZpUlkZt1l6tJGcqvkHjwMGB5M+qlE5lzpO7LLgIyiWNlWeFc12QjHzJ3ffO7MtCI9n7kX1vQIFOtNBrMLeFPkrVMLActl5GkwFf+Z8Ono58zPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789799881; c=relaxed/simple;
	bh=c0oefu3ZRdD0J4clKz3RxVr35grHfxVn3NLlHA2WsM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pe71sRT6o0jkz1KBPoGKUKYCZqkJfzAZWW3IZzeBlLoCVyqynj/t6cf67ckRYX/lPq2dD1pdeRMFgwS8amzH+jE0BQ0pTOOTaVMVrHDIjqgus+nywgLtXH0gGtDEbOL4PDO06GDbtUReWP0baRZBRiAXlpuzLVSfElc8ZZWMRtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtQ32Ve4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtQ32Ve4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3471F0089A;
	Sat, 19 Sep 2026 06:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789799875;
	bh=usnmYS7u84GLIEK0S3Ait9fvhPzlxHBW3emjiTs/iAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NtQ32Ve4euPuPwXwGpowXS8fY4N53abcIpjUxE3+OpWbz281M4pI3EaVgJcPz2OVH
	 qhcIJ9gDBCjtUPi4OwZw+jHLu/DQELzQ7hSaiDBiRYHxX121NTVSwui+NwkhWr4oZF
	 FLZSL3cwNj+O5jDDjyIWK7UFkBra7j+7SiLLB+sKWnTkL5YNMP+TMGxL6ZA2yIweNE
	 i7FV5yPbfERT/MCk+YFosUdU6cXSBPaUaACVEMC/Xxg/4in6dBDTKed9bZKva9YVGu
	 DMXHfaVXXZXhX4i1ilR9yzXJdVxIKH0xBAIhUnOoDzmB6rWDgFLsMf/t8kukbSX72S
	 HUgEGmtlXV0Bg==
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
Subject: [PATCH v5 4/4] perf annotate-data: Adjust type offset for flex-array
Date: Fri, 18 Sep 2026 23:37:45 -0700
Message-ID: <20260919063745.48444-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919063745.48444-1-namhyung@kernel.org>
References: <20260919063745.48444-1-namhyung@kernel.org>
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
 tools/perf/util/annotate-data.c | 112 +++++++++++++++++++++++++++++---
 tools/perf/util/annotate-data.h |   4 ++
 2 files changed, 107 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 5dd6c6ec2d42451d..e9b58a3d587be45b 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -226,7 +226,7 @@ static bool data_type_less(struct rb_node *node_a, const struct rb_node *node_b)
 static int __add_member_cb(Dwarf_Die *die, void *arg)
 {
 	struct annotated_member *parent = arg;
-	struct annotated_member *member;
+	struct annotated_member *member, *prev;
 	Dwarf_Die die_mem;
 	Dwarf_Word size, loc, bit_size = 0;
 	Dwarf_Attribute attr;
@@ -253,6 +253,7 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	if (dwarf_aggregate_size(&die_mem, &size) < 0 || size == 0) {
 		if (dwarf_tag(&die_mem) == DW_TAG_array_type) { /* flex-array? */
 			die_get_real_type(&die_mem, &die_mem);
+			member->is_flex_array = true;
 			if (dwarf_aggregate_size(&die_mem, &size) < 0)
 				size = 0;
 		} else {
@@ -299,12 +300,19 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	member->size = size;
 	member->offset = loc + parent->offset;
 	INIT_LIST_HEAD(&member->children);
-	list_add_tail(&member->node, &parent->children);
+
+	list_for_each_entry_reverse(prev, &parent->children, node) {
+		if (prev->offset <= member->offset)
+			break;
+	}
+	list_add(&member->node, &prev->node);
 
 	tag = dwarf_tag(&die_mem);
 	switch (tag) {
-	case DW_TAG_structure_type:
 	case DW_TAG_union_type:
+		member->is_union = true;
+		/* fall through */
+	case DW_TAG_structure_type:
 		die_find_child(&die_mem, __add_member_cb, member, &die_mem);
 		break;
 	default:
@@ -333,20 +341,84 @@ static void delete_members(struct annotated_member *member)
 	}
 }
 
+static struct annotated_member *find_flex_array(struct annotated_member *m)
+{
+	struct annotated_member *child;
+
+	if (list_empty(&m->children))
+		return NULL;
+
+	if (m->is_union) {
+		list_for_each_entry(child, &m->children, node) {
+			if (child->is_flex_array)
+				return child;
+		}
+		list_for_each_entry(child, &m->children, node) {
+			struct annotated_member *grand_child;
+
+			grand_child = find_flex_array(child);
+			if (grand_child)
+				return grand_child;
+		}
+		return NULL;
+	}
+
+	child = list_last_entry(&m->children, struct annotated_member, node);
+	if (child->is_flex_array)
+		return child;
+
+	return find_flex_array(child);
+}
+
+static struct annotated_member *get_flex_array_member(struct annotated_data_type *adt)
+{
+	return find_flex_array(&adt->self);
+}
+
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
+		 * logic won't find the outer struct at the offset.
+		 */
+		child = find_flex_array(m);
+		if (child == NULL || offset < child->offset)
+			return 0;
+
+		/* find the immediate child that includes a flex array */
+		if (m->is_union) {
+			list_for_each_entry(child, &m->children, node) {
+				if (child->is_flex_array || find_flex_array(child)) {
+					found = true;
+					break;
+				}
+			}
+		} else {
+			child = list_last_entry(&m->children, struct annotated_member, node);
+			found = true;
+		}
+	}
+
+	if (found) {
 		/* It can have anonymous struct/union members */
 		if (child->var_name) {
 			len = scnprintf(buf, sz, "%s%s",
@@ -356,15 +428,18 @@ static int fill_member_name(char *buf, size_t sz, struct annotated_member *m,
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
 }
 
 static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
@@ -1741,6 +1816,7 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
 {
 	struct dso *dso = map__dso(dloc->ms->map);
 	Dwarf_Die type_die;
+	struct annotated_data_type *result;
 
 	/*
 	 * The type offset is the same as instruction offset by default.
@@ -1753,7 +1829,25 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
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
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 957726334907cc0e..14b8113521a927cf 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -47,6 +47,8 @@ enum type_state_kind {
  * @var_name: Name of the member variable
  * @offset: Offset from the outer data type
  * @size: Size of the member field
+ * @is_union: Whether it's an union type
+ * @is_flex_array: Whether it's a flex array
  *
  * This represents a member type in a data type.
  */
@@ -57,6 +59,8 @@ struct annotated_member {
 	char *var_name;
 	int offset;
 	int size;
+	bool is_union;
+	bool is_flex_array;
 };
 
 /**
-- 
2.55.0

