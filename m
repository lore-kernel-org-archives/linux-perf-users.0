Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8294A4BFE79;
	Fri, 25 Sep 2026 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348841; cv=none; b=UpC8AReCpqq35j5O6sacmqSh21c21JMiEv9UmC+mTgedyuNN3UvmYRBydWM2rOZSG4uqXJ4oXPq9kTNteznzQHd6ygsUUYGshQRxYZQ0Va6gvbnAkUBUvQ8oGtXt0Xwne/4YuhkmUGBr07I+6hXKoOdmWfPYApdo/Yn+8HrbP9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348841; c=relaxed/simple;
	bh=KxO5qPXM9FbaoNLo69cUV8NlgPxhAP8aMZcEyjOeLE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKobZGu5ED8C4XaQDxGEsdeUf6k6XH4ZkEGCG4JRyVpzzHFpnWg0OweKtX+0ql1goi2H85SH4nwptnwh5+pTwM+dP32tXUPxPkJLF/Cpt5vltcWjW0M28DYBfYbDvJK49SemCaYt243Y0EsC56vaigiO1mbCjC/LWCbIjFByHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/wHK48C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/wHK48C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F481F0089A;
	Fri, 25 Sep 2026 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790348834;
	bh=M1NMKBmM7/1YWvdOM75XN9nOUA4bkPfX1aS6i02DlFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F/wHK48CihNX6/QGFA3EhJMw8cRIfxz7+BfC6HNM6km5pJSlVew0gcrR024Bnp/UF
	 JRNJKB/ibCVDL57ewOwuScf1f4shbTqqcG9glOGqJMsPMDSbwBVNiS54ZCDo5upuNM
	 1jlh2qDi9kPRPazwaGmBUgVj0BlW5uGU6/8UhYSg88spsmvh5rnx6MVpX4pGekJuIS
	 MDrmqcN5kyfEaKdu1dUCBRbaoLETcH8qcPzpS1wMwdfaeEnIic/t7xbU3RG3ZFgaNn
	 nS7qlj8kzIuu8X+zShP/Qdcka5+kKMbEnx3CWM2FGdK1vUOvG5Kkfqr9/y6O/EtLHP
	 +9kjdquG5Db3A==
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
Subject: [PATCH 4/6] perf annotate-data: Bound the member nesting recursion
Date: Fri, 25 Sep 2026 17:06:55 +0200
Message-ID: <20260925150657.1826942-5-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925150657.1826942-1-acme@kernel.org>
References: <20260925150657.1826942-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Members are added recursively, and a broken DIE can make a member's
type point back at one of its own ancestors, recursing until the stack
is gone; nothing usable comes out of nesting members 32 deep anyway, so
stop there, marking the member as truncated and giving up on member
types that don't resolve.

The check is where the children of an aggregate would be expanded, so
only struct/union members are marked as truncated.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate-data.c | 20 ++++++++++++++++++--
 tools/perf/util/annotate-data.h |  3 +++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index bc9698abc6a9e055..19a6ecd67f28719d 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -222,6 +222,12 @@ static bool data_type_less(struct rb_node *node_a, const struct rb_node *node_b)
 	return strcmp(a->self.type_name, b->self.type_name) < 0;
 }
 
+/*
+ * A broken type can point back at one of its own ancestors: bound the
+ * nesting so it doesn't recurse until the stack is gone.
+ */
+#define MAX_MEMBER_DEPTH 32
+
 /* Recursively add new members for struct/union */
 static int __add_member_cb(Dwarf_Die *die, void *arg)
 {
@@ -236,6 +242,9 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	if (dwarf_tag(die) != DW_TAG_member)
 		return DIE_FIND_CB_SIBLING;
 
+	if (die_get_real_type(die, &die_mem) == NULL)
+		return DIE_FIND_CB_SIBLING;
+
 	member = zalloc(sizeof(*member));
 	if (member == NULL)
 		return DIE_FIND_CB_END;
@@ -248,8 +257,6 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	if (die_get_typename(die, &sb) < 0)
 		strbuf_add(&sb, "(unknown type)", 14);
 
-	die_get_real_type(die, &die_mem);
-
 	if (dwarf_aggregate_size(&die_mem, &size) < 0 || size == 0) {
 		if (dwarf_tag(&die_mem) == DW_TAG_array_type) { /* flex-array? */
 			die_get_real_type(&die_mem, &die_mem);
@@ -299,6 +306,7 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	}
 	member->size = size;
 	member->offset = loc + parent->offset;
+	member->depth = parent->depth + 1;
 	INIT_LIST_HEAD(&member->children);
 
 	list_for_each_entry_reverse(prev, &parent->children, node) {
@@ -313,6 +321,14 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 		member->is_union = true;
 		/* fall through */
 	case DW_TAG_structure_type:
+		/* Only aggregates have children to expand, so only they get truncated. */
+		if (member->depth >= MAX_MEMBER_DEPTH) {
+			/* Consumed by the JSON exporter added in a later series. */
+			member->truncated = true;
+			pr_debug_dtp("member nesting limit reached at %s\n",
+				     member->type_name ?: "(unknown type)");
+			break;
+		}
 		die_find_child(&die_mem, __add_member_cb, member, &die_mem);
 		break;
 	default:
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 14b8113521a927cf..ca0abfb2a036d229 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -61,6 +61,9 @@ struct annotated_member {
 	int size;
 	bool is_union;
 	bool is_flex_array;
+	unsigned int depth;
+	/* Children not expanded because the nesting limit was reached */
+	bool truncated;
 };
 
 /**
-- 
2.53.0

