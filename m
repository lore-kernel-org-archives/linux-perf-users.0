Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03B237E5DC;
	Sat, 19 Sep 2026 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850462; cv=none; b=gLw7GEC8PkWSswGOCF9CueWv8Mwsxz/hw/63qebju4sR42gIwg6jujlMkZ0q0USWovcZm9JDJ5G0VCpBiimN/oqB2niZEqzmf9ZyzhXYjWoG3yEgDn9rfwSs/kkpgXqjPUC4nTNFCuz6vxUCSNws9ziDPpjI4N9CZbV7Qp/DPXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850462; c=relaxed/simple;
	bh=cdsMhhDLo2jM8tA4bY0FQYn4R/1nfLlAMM5GLmTr6E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clSy14vedHM39zrVYTIvshElXnjpQnedycoFkjB80ksEDusVj9/5NG9iRw9z0DF069prJN+aC8qlYugwP7WOs94vbFjVN7G25Wahe9/3MbXVNPWCx+vSbF7V63McxxXEs6FZhoV7SvHaRA2V6AQZw/bYoRIBv8yfk0qHDn/3sjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsBD9laj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsBD9laj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B361F000FF;
	Sat, 19 Sep 2026 20:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850461;
	bh=lT1wCPAuEIFo7R+PjuyFlgnttrVDkpYDnKA/trn2IFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FsBD9lajtANXWCwC7TPG+fH/W5bnjWnmezBNVo3znPZgwBiDvK5UYq+sm/nVaoNtb
	 Lc7594WywBNHdEAj2RUga+2WXfAuvZJ8Rv4ivLAZ3F+5LfHO1ByiQqkWhE4yAhNRHb
	 7qSIj0/g3Z8M5PXY/+IJHAfCX6jCxxSTU10CWOEFiptLjFWrKl+9g9TYxtbxlNCtJj
	 c6bSgNG3YLdX6hm+TnPkZTkrcIRYIVFMBEneD/YFbmuaMxy/hjtgJlYmwQjBEatu+n
	 UhbB+kNjjLXWrOeUt1yL35J74eacEdQ7UxgRt4Mf2u1cobkrfW0dixrU/ibIhAfedj
	 bSvqby1uEkrVQ==
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
Subject: [PATCH 4/7] perf annotate-data: Bound the member nesting recursion
Date: Sat, 19 Sep 2026 17:40:24 -0300
Message-ID: <20260919204027.8504-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260919204027.8504-1-acme@kernel.org>
References: <20260919204027.8504-1-acme@kernel.org>
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
the stack is gone; nothing usable comes out of nesting members 8 deep
anyway, so stop there, marking the member as truncated (reported by the
JSON exporter added in a later series) and giving up on member types
that don't resolve.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate-data.c | 32 ++++++++++++++++++++++++++------
 tools/perf/util/annotate-data.h |  3 +++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 2ad6d012e069c522..c67bb6005e23c516 100644
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
+#define MAX_MEMBER_DEPTH 8
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
 
@@ -289,10 +300,19 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	}
 	member->size = size;
 	member->offset = loc + parent->offset;
+	member->depth = parent->depth + 1;
 	INIT_LIST_HEAD(&member->children);
 	list_add_tail(&member->node, &parent->children);
 
 	tag = dwarf_tag(&die_mem);
+	if (member->depth >= MAX_MEMBER_DEPTH) {
+		/* Reported by the JSON exporter so consumers can tell a truncated tree. */
+		member->truncated = true;
+		pr_debug_dtp("member nesting limit reached at %s\n",
+			     member->type_name ?: "(unknown type)");
+		return DIE_FIND_CB_SIBLING;
+	}
+
 	switch (tag) {
 	case DW_TAG_structure_type:
 	case DW_TAG_union_type:
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
2.53.0

