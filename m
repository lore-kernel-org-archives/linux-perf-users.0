Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B025776;
	Sat, 12 Sep 2026 05:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789192033; cv=none; b=gscNLUltwr1ou/J61gRw14hHDsQklAtat4pel0J7hSPjedjnPFsZNg4ylePUXCJYLnuOYRWXN3323y+nEQWVMVaO7lap6i5QTsBw0ra+94NB9i9XCQHioVI8KYG3SSYlehAy51dgjT4BJN0HOxYdtwFj7gI9LH0kaqlpFaNkORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789192033; c=relaxed/simple;
	bh=rxJHyYBFUF4d3+RIhzPWcaffFWFaNkaQyoI6io9Iq0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7RuMO56i8fWl3/pj03WvZb4TGZxUZNr4wMpRa5WKl9A0IuAzvUo81gRJeezHYIWhrQbF/yaHsbSVWjCKjmmcamFQWc7Ha5bykX0DJcCHQrYtNcpAqgsWNeVpte0RPFN3Oq3/QNs3CzrDB74+D8e4gaIfDtGeEjGYgkaZW+RetM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8FtxHkq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8FtxHkq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC421F0089C;
	Sat, 12 Sep 2026 05:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789192032;
	bh=rruhuPrNVDhLgAmVl7i/uXVuPDrgS4PaGgLoND0pxEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g8FtxHkqmYMaUI12boMRp2k1bEbcUcKS1/fE8RrHrJSNj/Qezx4bkbzBmPbn2SKy3
	 ZrRx2LBZUD1xqkKRpNHCNxfGW1eqNxyVeaum6TPGzpbcMRe+QjBZd/ixOyi3aJrWw6
	 HWf4LL2BpkueQviQovgtk9K39IRPbI/gsfmDpTXq2d5zPk4c6ZDE+oN+/aYaJQvikE
	 DuA7TBQmVZ8i5md7vFY9GIaDNhCEa49/DlIQAlHMwgTdsI29z32f6r4QIN5v7OJRy+
	 NSWaTWem3Xm4Ki3yypQy2CtT78uMi6Et6HOUeQXQ4ryuI10CeS0zAWJvcNZz9YAk1z
	 MmO1SQEKB0HYg==
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
Subject: [PATCH 4/4] perf annotate-data: Adjust type offset for flex-array
Date: Fri, 11 Sep 2026 22:47:06 -0700
Message-ID: <20260912054706.1475583-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260912054706.1475583-1-namhyung@kernel.org>
References: <20260912054706.1475583-1-namhyung@kernel.org>
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
 tools/perf/util/annotate-data.c | 73 ++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index ad043403ced58d98..0789a8cbea7c0355 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -332,19 +332,40 @@ static void delete_members(struct annotated_member *member)
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
+		if (!strstr(child->type_name, "struct "))
+			return 0;
+
+		found = true;
+	}
+
+	if (found) {
 		/* It can have anonymous struct/union members */
 		if (child->var_name) {
 			len = scnprintf(buf, sz, "%s%s",
@@ -354,15 +375,37 @@ static int fill_member_name(char *buf, size_t sz, struct annotated_member *m,
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
+static struct annotated_member *find_flex_array(struct annotated_member *m, int offset)
+{
+	struct annotated_member *child;
+
+	if (list_empty(&m->children))
+		return NULL;
+
+	child = list_last_entry(&m->children, struct annotated_member, node);
+	if (offset == child->offset && strstr(child->type_name, "[]"))
+		return child;
+
+	return find_flex_array(child, offset);
+}
+
+static struct annotated_member *get_flex_array_member(struct annotated_data_type *adt)
+{
+	return find_flex_array(&adt->self, adt->self.size);
 }
 
 static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
@@ -1743,6 +1786,7 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
 {
 	struct dso *dso = map__dso(dloc->ms->map);
 	Dwarf_Die type_die;
+	struct annotated_data_type *result;
 
 	/*
 	 * The type offset is the same as instruction offset by default.
@@ -1755,7 +1799,24 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
 	if (find_data_type_die(dloc, &type_die) < 0)
 		return NULL;
 
-	return dso__findnew_data_type(dso, &type_die);
+	result = dso__findnew_data_type(dso, &type_die);
+	if (result == NULL)
+		return NULL;
+
+	if (result->flex_array && dloc->type_offset > result->self.size) {
+		struct annotated_member *flex_array = get_flex_array_member(result);
+		if (flex_array) {
+			int offset = dloc->type_offset;
+
+			/* adjust offset in the flex array */
+			offset -= result->self.size;
+			offset %= flex_array->size;
+			offset += result->self.size;
+
+			dloc->type_offset = offset;
+		}
+	}
+	return result;
 }
 
 static size_t data_type_hash(long key, void *ctx __maybe_unused)
-- 
2.55.0.1032.g73a4cd73de-goog

