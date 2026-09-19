Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B462E0B5C;
	Sat, 19 Sep 2026 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850449; cv=none; b=F+7ZtC71c+ssk8SqpyLFNaM54cI32QImeHifhrYg5eh8Dcgi+SzNBPDl07dtjhwN0Z9CkoYN0aCobCJ6pjfr2LQkpRUuhs02pP2SqvwjKKJ2aqDlYQ+7lW9z13j4qmes1jpFInQxFkstghL4DwvsehSzZooK0vkttfUqE+vNV8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850449; c=relaxed/simple;
	bh=u/l1019tOO/XoAlgGYR/3QPOm7ASfUvmqHOxfTNqcyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFnO7KpNI2KCGP0tZHWzBkft+xPvdS+kCDEA6hY0m6xvtH2oEdT7waHrEFFydmpAt/wVsnW1N5Q3OIcPoHV7eZf4imiC8dCOlAfzrsWLr6TjczkX6vHBZfVVxdpUZ5xL0B7QCHedWNI2wApxnKLcS9lmqbp3eM1TDr8dmuGZvjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrXpy5Sx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrXpy5Sx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B6E1F00893;
	Sat, 19 Sep 2026 20:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850447;
	bh=DZau4VFdc8JLRYU/zsxSJdHkRPnwhv27DePH4WfF8tM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jrXpy5SxmjaLaf4gSUy/vQ1FwRuNrRaLwqmSHDvobSyBLZgW/TPu5EVk2E553AjkT
	 bGYWbGuxfRcDxjxJiNvf4HFjyHX1Cada6qOTlfOhMJz5AsmTUSJir3Y5zPfS0K/u4R
	 pgGye2791ZW7hOuQeG+TQUJzzqyyJge6IYdKj9FFfLBdq/jLH7D865ywqV7wfIvNGg
	 KT2sKpcUZAJGPuhXqxU3REXS3j/XlGEA89Q3BCDnPSc7jZu4kQaFbS1Ozs6b3YKaym
	 3GMYavjwI01LQ08Ds3nloGZNuSmNVqrOYHwcm44rONYNOJd4VnnxqIfSOa9nAz3R/u
	 NGycZWRBMpdgA==
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
Subject: [PATCH 1/7] perf dwarf-aux: Bound the type chases for broken debug info
Date: Sat, 19 Sep 2026 17:40:21 -0300
Message-ID: <20260919204027.8504-2-acme@kernel.org>
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

A DIE that is not what it looks like, e.g. one parsed at an offset that
is not the start of a DIE, can have a DW_AT_type that refers back to
itself, making the typedef/qualifier chases in die_get_real_type() and
die_get_pointer_type() spin forever, and the same for the type name
recursion in die_get_typename_from_type(); 'perf report -s type' did
exactly that on the dwz compressed debug info of zlib-ng (libz.so.1).

No sane chain of typedefs and qualifiers is 32 DIEs long, so give up on
the type with a pr_debug instead of hanging.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dwarf-aux.c | 88 ++++++++++++++++++++++++++++---------
 1 file changed, 68 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index d7160f87ac7d7ab3..b5ffeea54446408d 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -266,16 +266,29 @@ Dwarf_Die *die_get_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
 		return NULL;
 }
 
+/*
+ * A DIE that is not what it looks like, e.g. one parsed at an offset
+ * that is not the start of a DIE, can have a DW_AT_type that refers
+ * back to itself, making these chases spin forever: bound them and
+ * report, instead of hanging.
+ */
+#define MAX_TYPE_CHASE 32
+
 /* Get a type die, but skip qualifiers */
 Dwarf_Die *__die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
 {
-	int tag;
+	int tag, chase = 0;
 
 	do {
 		vr_die = die_get_type(vr_die, die_mem);
 		if (!vr_die)
-			break;
+			return NULL;
 		tag = dwarf_tag(vr_die);
+		if (++chase > MAX_TYPE_CHASE) {
+			pr_debug("DWARF: qualifier chase limit reached at DIE 0x%lx\n",
+				 (unsigned long)dwarf_dieoffset(vr_die));
+			return NULL;
+		}
 	} while (tag == DW_TAG_const_type ||
 		 tag == DW_TAG_restrict_type ||
 		 tag == DW_TAG_volatile_type ||
@@ -296,8 +309,15 @@ Dwarf_Die *__die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
  */
 Dwarf_Die *die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
 {
+	int chase = 0;
+
 	do {
 		vr_die = __die_get_real_type(vr_die, die_mem);
+		if (++chase > MAX_TYPE_CHASE) {
+			pr_debug("DWARF: typedef chase limit reached at DIE 0x%lx\n",
+				 vr_die ? (unsigned long)dwarf_dieoffset(vr_die) : 0);
+			return NULL;
+		}
 	} while (vr_die && dwarf_tag(vr_die) == DW_TAG_typedef);
 
 	return vr_die;
@@ -314,7 +334,7 @@ Dwarf_Die *die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
  */
 Dwarf_Die *die_get_pointer_type(Dwarf_Die *type_die, Dwarf_Die *die_mem)
 {
-	int tag;
+	int tag, chase = 0;
 
 	do {
 		tag = dwarf_tag(type_die);
@@ -324,6 +344,11 @@ Dwarf_Die *die_get_pointer_type(Dwarf_Die *type_die, Dwarf_Die *die_mem)
 		    tag != DW_TAG_restrict_type && tag != DW_TAG_volatile_type &&
 		    tag != DW_TAG_shared_type)
 			return NULL;
+		if (++chase > MAX_TYPE_CHASE) {
+			pr_debug("DWARF: pointer type chase limit reached at DIE 0x%lx\n",
+				 (unsigned long)dwarf_dieoffset(type_die));
+			return NULL;
+		}
 		type_die = die_get_type(type_die, die_mem);
 	} while (type_die);
 
@@ -1118,17 +1143,25 @@ Dwarf_Die *die_find_member(Dwarf_Die *st_die, const char *name,
 			      die_mem);
 }
 
-/**
- * die_get_typename_from_type - Get the name of given type DIE
- * @type_die: a type DIE
- * @buf: a strbuf for result type name
- *
- * Get the name of @type_die and stores it to @buf. Return 0 if succeeded.
- * and Return -ENOENT if failed to find type name.
- * Note that the result will stores typedef name if possible, and stores
- * "*(function_type)" if the type is a function pointer.
+/*
+ * The name follows DW_AT_type, so a self-referring DIE makes this
+ * recurse forever: bound it like the chases above.
  */
-int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
+static int __die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf,
+					int depth);
+
+static int __die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf, int depth)
+{
+	Dwarf_Die type;
+
+	if (__die_get_real_type(vr_die, &type) == NULL)
+		return -ENOENT;
+
+	return __die_get_typename_from_type(&type, buf, depth);
+}
+
+static int __die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf,
+					int depth)
 {
 	int tag, ret;
 	const char *tmp = "";
@@ -1155,7 +1188,12 @@ int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
 		/* Write a base name */
 		return strbuf_addf(buf, "%s%s", tmp, name ?: "");
 	}
-	ret = die_get_typename(type_die, buf);
+	if (depth >= MAX_TYPE_CHASE) {
+		pr_debug("DWARF: type name recursion limit reached at DIE 0x%lx\n",
+			 (unsigned long)dwarf_dieoffset(type_die));
+		return -ENOENT;
+	}
+	ret = __die_get_typename(type_die, buf, depth + 1);
 	if (ret < 0) {
 		/* void pointer has no type attribute */
 		if (tag == DW_TAG_pointer_type && ret == -ENOENT)
@@ -1166,6 +1204,21 @@ int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
 	return strbuf_addstr(buf, tmp);
 }
 
+/**
+ * die_get_typename_from_type - Get the name of given type DIE
+ * @type_die: a type DIE
+ * @buf: a strbuf for result type name
+ *
+ * Get the name of @type_die and stores it to @buf. Return 0 if succeeded.
+ * and Return -ENOENT if failed to find type name.
+ * Note that the result will stores typedef name if possible, and stores
+ * "*(function_type)" if the type is a function pointer.
+ */
+int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
+{
+	return __die_get_typename_from_type(type_die, buf, 0);
+}
+
 /**
  * die_get_typename - Get the name of given variable DIE
  * @vr_die: a variable DIE
@@ -1178,12 +1231,7 @@ int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
  */
 int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
 {
-	Dwarf_Die type;
-
-	if (__die_get_real_type(vr_die, &type) == NULL)
-		return -ENOENT;
-
-	return die_get_typename_from_type(&type, buf);
+	return __die_get_typename(vr_die, buf, 0);
 }
 
 /**
-- 
2.53.0

