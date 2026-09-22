Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4E739CD19;
	Tue, 22 Sep 2026 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080036; cv=none; b=oa0V4AQxtZbMRsaS3wzgr5flBlkYJ8COg7DWdvtZIu1DnltUin85TB6Z3D5ntwZdSVto2I/CLARqgDzHGgTfWtyOrPIvLh2IdNsapsK5GtztLuJXXgthlYmLADpX0B9dsAyRDhkPtRBr+kAQJv3CvKzWDc8A2CrKfQGZ2TcE6cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080036; c=relaxed/simple;
	bh=ry7RvaQvCyx8PVDPMx2T4Ot5MGZBNJR47tiXNPK6jPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzhKFmTEaYXMuqrPUmNwBqIKFFTUoIG8BB87cjIKZHP5g9E2KwDWQf+2Q6Sh4CeCLM3b58Bicm3n20SRuJgqrFM4pb7xB9xme5zEsqA+EGKpsMlWPTaxDf54jyGzGxnOCcdWwKpha9pnHtLMCNiLyo01ADIoWNAabKCocu1axf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dvwq4sAO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dvwq4sAO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C51F1F000FF;
	Tue, 22 Sep 2026 12:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080034;
	bh=0ksv4bkAAggNOsXlCZ2OGQbl1L2IBrjnYABIaalGLao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dvwq4sAODIXdho5Fszli8Do4UrhQ5SXPSbGIpuGsjGla+/KPwJDXOBu+KkfoqTdPo
	 1FwPeOL8NvvxtHYyhT/koPf7ockXybPQC4YifAFK/ue0xaBUYjCxCKoJW0N4ryYo4e
	 3GpOl1qMG/zBYaNQJJivVIFbmiQgxQeAqdPY5bOgFV/2piT38ZJVbPB3k8gbGNs4ar
	 +QPeN53ruVRMUMmjrg5l7vDcgWketD+IfVVp33qMjD3I65Zd7jcpdO5zzEERItblJn
	 Gh8jDkDOv8v+2vrpwkwHxQ9AAVf5NkXOVRQJttHbV0tZx3+0aDrbgX2nDkD9yNhAhP
	 zxM24sVwLnKrw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 4/7] perf annotate-data: Bound the member nesting recursion
Date: Tue, 22 Sep 2026 14:26:20 +0200
Message-ID: <20260922122623.1029132-5-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922122623.1029132-1-acme@kernel.org>
References: <20260922122623.1029132-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Members are added recursively, and the same kind of broken DIE can make
a member's type point back at one of its own ancestors, recursing until
the stack is gone; nothing usable comes out of nesting members 32 deep
anyway, so stop there, marking the member as truncated (reported by the
JSON exporter added in a later series) and giving up on member types
that don't resolve.

The limit is checked where the children of an aggregate would be
expanded, so only struct/union members get marked as truncated: a
primitive member that merely lands on the limit has no children to
expand and is reported as complete.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate-data.c | 36 +++++++++++++++++++++++++++------
 tools/perf/util/annotate-data.h |  3 +++
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 2ad6d012e069c522..a0f63a91d45614cb 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -221,6 +221,13 @@ static bool data_type_less(struct rb_node *node_a, const struct rb_node *node_b)
 	return strcmp(a->self.type_name, b->self.type_name) < 0;
 }
 
+/*
+ * Members are added recursively; bound the nesting so that a broken
+ * type that points back at one of its own ancestors doesn't recurse
+ * until the stack is gone.
+ */
+#define MAX_MEMBER_DEPTH 32
+
 /* Recursively add new members for struct/union */
 static int __add_member_cb(Dwarf_Die *die, void *arg)
 {
@@ -235,6 +242,16 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	if (dwarf_tag(die) != DW_TAG_member)
 		return DIE_FIND_CB_SIBLING;
 
+	if (__die_get_real_type(die, &member_type) == NULL)
+		return DIE_FIND_CB_SIBLING;
+
+	if (dwarf_tag(&member_type) == DW_TAG_typedef) {
+		if (die_get_real_type(&member_type, &die_mem) == NULL)
+			return DIE_FIND_CB_SIBLING;
+	} else {
+		die_mem = member_type;
+	}
+
 	member = zalloc(sizeof(*member));
 	if (member == NULL)
 		return DIE_FIND_CB_END;
@@ -242,12 +259,6 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	strbuf_init(&sb, 32);
 	die_get_typename(die, &sb);
 
-	__die_get_real_type(die, &member_type);
-	if (dwarf_tag(&member_type) == DW_TAG_typedef)
-		die_get_real_type(&member_type, &die_mem);
-	else
-		die_mem = member_type;
-
 	if (dwarf_aggregate_size(&die_mem, &size) < 0)
 		size = 0;
 
@@ -289,6 +300,7 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	}
 	member->size = size;
 	member->offset = loc + parent->offset;
+	member->depth = parent->depth + 1;
 	INIT_LIST_HEAD(&member->children);
 	list_add_tail(&member->node, &parent->children);
 
@@ -296,6 +308,18 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	switch (tag) {
 	case DW_TAG_structure_type:
 	case DW_TAG_union_type:
+		/*
+		 * Only aggregates have children to expand: a primitive
+		 * member that happens to land on the limit is complete,
+		 * not truncated.
+		 */
+		if (member->depth >= MAX_MEMBER_DEPTH) {
+			/* Reported by the JSON exporter so consumers can tell a truncated tree. */
+			member->truncated = true;
+			pr_debug_dtp("member nesting limit reached at %s\n",
+				     member->type_name ?: "(unknown type)");
+			break;
+		}
 		die_find_child(&die_mem, __add_member_cb, member, &die_mem);
 		break;
 	default:
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index ca2096a9ee62cbfe..cc576232f55b5fb0 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -57,6 +57,9 @@ struct annotated_member {
 	char *var_name;
 	int offset;
 	int size;
+	unsigned int depth;
+	/* Children not expanded because the nesting limit was reached */
+	bool truncated;
 };
 
 /**
-- 
2.55.0

