Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6B2F8E98;
	Tue, 15 Sep 2026 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789454443; cv=none; b=C4Yqaxs6wXTaAOPAgijkbvbX7+EGPAMlGLzFow4DwiPFVh8KUlLaA5DlTZDS4qF48ANLUpypaHp066+undPVumDlU4VFWnPfKSTvHm4Wz3JDwDL3sIPNCeh5TAcg5HEJBGN4EFHe2X7TR/D4uLzYd7/853z8hdQqKaGK4xpyrJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789454443; c=relaxed/simple;
	bh=E9Si2OLdLKJDCRlVA+K3/QMtHNdDsTAiYITsNFszYd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uyd1Tyt08BBIoQB/tXTELfa3rh4QuBI5aGVZU92d0caaaSnXgn8OMI1goikIUtef2RmqGvnq+F3dSCv/4fQTe0kU2ubAydXxmFfAlFljFAs3O4V1BMma1F1kLV2g4pt0KJjlEB3TB0tx9WsRODevl8//D4uppJwxu9pKnydiGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5AJMUiw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5AJMUiw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76171F00898;
	Tue, 15 Sep 2026 06:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789454442;
	bh=UFXstwGzfVCmjcpWJEqcYHIuvCIqu0LCDSe4kkGOu+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n5AJMUiwYphJRPyVhT6ZVeShyPe2r96KJCQuuqRUg/Ne//Bm0riD0EmQpGMcA3EYT
	 eCoqvdtKUIx9yYwt8GQ59bhavtMecz2Q1xGNwvs6EqbuE2qfEETGCRyjrs8Q2S9mDK
	 vWJXBeP3WP2TufNvoawRBg7P1SWj0mEAEottVPxisPSHSWqAddM/Ft3TxP8X43QZBP
	 NrzB0Vc3ZWP2Du43iHJJWcKKcgCVXoDYQN2Rnwi/szpluYDHAoKunZWcbTWLJ7Q0Ao
	 WkJ1niBtE0iMuwHytHkRC1dnQekhrM/ZZ8q/5QZCvonjFoHdIAzKSncCJiE4bkDQPp
	 rSUHiVd4850MQ==
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
Subject: [PATCH v3 3/3] perf annotate-data: Adjust type offset for flex-array
Date: Mon, 14 Sep 2026 23:40:35 -0700
Message-ID: <20260915064035.1970175-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260915064035.1970175-1-namhyung@kernel.org>
References: <20260915064035.1970175-1-namhyung@kernel.org>
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
 tools/perf/util/annotate-data.c | 77 ++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 1ee2b74f99205567..1c19b807c4f2179d 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -241,7 +241,8 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 		return DIE_FIND_CB_END;
 
 	strbuf_init(&sb, 32);
-	die_get_typename(die, &sb);
+	if (die_get_typename(die, &sb) < 0)
+		strbuf_add(&sb, "(unknown type)", 14);
 
 	__die_get_real_type(die, &member_type);
 	if (dwarf_tag(&member_type) == DW_TAG_typedef)
@@ -333,19 +334,40 @@ static void delete_members(struct annotated_member *member)
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
@@ -355,15 +377,37 @@ static int fill_member_name(char *buf, size_t sz, struct annotated_member *m,
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
@@ -1740,6 +1784,7 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
 {
 	struct dso *dso = map__dso(dloc->ms->map);
 	Dwarf_Die type_die;
+	struct annotated_data_type *result;
 
 	/*
 	 * The type offset is the same as instruction offset by default.
@@ -1752,7 +1797,25 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
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
2.55.0.1082.g2b9226bbc0-goog

