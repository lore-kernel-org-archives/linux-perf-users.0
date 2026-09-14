Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A023B3822A3;
	Mon, 14 Sep 2026 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368342; cv=none; b=PdE1x1ywIG0QfDavsXbatMiripB/lFNAJ/d+fhOCfh4+xBJa2gs/2WeYUgDZb48LzihAVFLHfW78CJSTuUH8/fatn5vmtfGWs7wWDfkd5KejBRa0N/M57rCJBbV4M21BJcpvEI8V0ShDcrGstX+YNf6ORmRkab8I9dhhClPCZQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368342; c=relaxed/simple;
	bh=xcvF5DwxsirA0Wfh3x+KUC6C6aLKVTKzqBD70+B19Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1JmiItrGDPykkAYypf6at8vdd3WavV1l2Le1fjQyl2p/XLc4auCtmKRiZDme8HbGDyTUX+TdE0JWtUeLcPaMPbXtz8ynHN2Hrl9PNR8+rucO2h6ETOVeyJY6Q2d5CU3BV5hFOR1cXqqXxHu0G+ttZGUD3p3Fq49RkGn53Qa6zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzuvEsaJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzuvEsaJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAE61F0089C;
	Mon, 14 Sep 2026 06:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789368340;
	bh=4nt8l8m6QQOaS7ZxE7D5yfx1hTVC4vG/+Gwe9/9l1Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kzuvEsaJSHnu31fLmLun+nxtrRZFv95G/UikjkDyOuJqMlp3olu6q6LVLIbmHpCeO
	 idMeU3tWuG27fGpdVmtgRbdnNVShEz925/BJXAm96xwBdKUocbuUGjTYCkmSIMKaGd
	 4WVw3Hl3rti0KR2lUDD3lN8d60fDnNVO+DW1QlVwpXY4YM+LZkB5isigyLdLkYlxhR
	 VzNxoih8+tAMhgsAibB0lnmfRr8O9pocuTrT3rAiiSICbA5aNEJUMnfRZniuamIsgO
	 dnbR5cb4raIVF1DEqaLETaHjXWiQSEKPxNtU+Aa2AnaYbzxM13FNIVUUE/VJ6Yfx6J
	 jsDWqTfKEZEbQ==
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
Subject: [PATCH v2 4/4] perf annotate-data: Adjust type offset for flex-array
Date: Sun, 13 Sep 2026 23:45:35 -0700
Message-ID: <20260914064535.1671939-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260914064535.1671939-1-namhyung@kernel.org>
References: <20260914064535.1671939-1-namhyung@kernel.org>
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
 tools/perf/util/annotate-data.c | 74 ++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index e8aff6a916c0afe0..a66b72feb6e2f227 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -333,19 +333,40 @@ static void delete_members(struct annotated_member *member)
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
@@ -355,15 +376,37 @@ static int fill_member_name(char *buf, size_t sz, struct annotated_member *m,
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
@@ -1740,6 +1783,7 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
 {
 	struct dso *dso = map__dso(dloc->ms->map);
 	Dwarf_Die type_die;
+	struct annotated_data_type *result;
 
 	/*
 	 * The type offset is the same as instruction offset by default.
@@ -1752,7 +1796,25 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
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

