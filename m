Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94094C10C9;
	Fri, 25 Sep 2026 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348841; cv=none; b=DPTM7rv4AnHrRVzKJtI394mZZqZ9HL98c6X3l+H9VTbmZLcSGTY1s+yyb+/IjeFfQSGw7gkHdl84/dqyzDKZKB9kF/Gy15AJZBt9vi1kjCmG3oUc8eD4u2B/cwblS5wsIv7FnRhL8U9Xf6DxlSgIpyM4aOuewUUgzyRkhsPLMm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348841; c=relaxed/simple;
	bh=sF+iOcuXJVodFmI+uMgqfyneQ9Lf+0QS9ffDhInweSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8bK83Pp2DZbjtFp86ZxTdvPa2y/WiG94kwuCjvLRFA3MwZHoq7mzpM99JiKt1TyeCHvcVfn0FcMqaRLhTBjMXOW5VbA4ArrWu5wgJC4PwYrady0IZ7/KDih4dIj91A6EkJYNHNDCL8v7MDkd0bOiIA4aqJWnbCQ+2sS+0TaMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiC0CWPX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiC0CWPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A807F1F00893;
	Fri, 25 Sep 2026 15:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790348826;
	bh=yPqhUnoFFJd8msd6DYsuXDdvX/9HyEZttiDVX06Hbjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GiC0CWPXZcW7WwrJnKOtgT4u869z5GmcBnXYpvtNr7aQWs5oLNcIVPD2FEv5E1Qkp
	 +2lZQj5lBsNXSXpDoVHELUEc1g6Cr4Gj0f2mRXXLPhO4Ku/AzkTDZwHZyaap6bQ7eF
	 +8L+Tb5Z3eBnU96jyOTFZXQrzUQIPoMWP5IPQOf1NWOk7bgQNAug3reGM9R8YA6rcA
	 eNtf1jHPNKPv+pwjRJdxXpk+oKT8gDbTmNXUyaZeRleciwkvlpujUiEi39TrTTwzxa
	 gdTSYWIj6/LzqaKFyY/DFxkxL4ySfzSLjnj7SZwPQcYNfAXcDGuHgpxlyjKQRHd9HM
	 WR8CLXKnDQhYA==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/6] perf dwarf-aux: Bound the type chases for broken debug info
Date: Fri, 25 Sep 2026 17:06:52 +0200
Message-ID: <20260925150657.1826942-2-acme@kernel.org>
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

A DIE parsed at an offset that is not the start of a DIE can have a
DW_AT_type that refers back to itself, making the typedef/qualifier
chases in die_get_real_type(), die_get_pointer_type() and
die_get_typename_from_type() spin forever; 'perf report -s type' did
that on the dwz compressed debug info of zlib-ng (libz.so.1).

No sane typedef/qualifier chain is 32 DIEs long, so give up on the type
with a pr_debug instead of hanging.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dwarf-aux.c | 84 ++++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 1560e721479a1ac2..2c135ebb1551fca4 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -267,16 +267,27 @@ Dwarf_Die *die_get_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
 		return NULL;
 }
 
+/*
+ * A DIE parsed at an offset that is not the start of a DIE can refer
+ * back to itself via DW_AT_type: bound these chases.
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
@@ -297,8 +308,15 @@ Dwarf_Die *__die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
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
@@ -315,7 +333,7 @@ Dwarf_Die *die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
  */
 Dwarf_Die *die_get_pointer_type(Dwarf_Die *type_die, Dwarf_Die *die_mem)
 {
-	int tag;
+	int tag, chase = 0;
 
 	do {
 		tag = dwarf_tag(type_die);
@@ -325,6 +343,11 @@ Dwarf_Die *die_get_pointer_type(Dwarf_Die *type_die, Dwarf_Die *die_mem)
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
 
@@ -1119,17 +1142,25 @@ Dwarf_Die *die_find_member(Dwarf_Die *st_die, const char *name,
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
@@ -1156,7 +1187,12 @@ int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
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
@@ -1167,6 +1203,19 @@ int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
 	return strbuf_addstr(buf, tmp);
 }
 
+/**
+ * die_get_typename_from_type - Get the name of a type DIE
+ * @type_die: a type DIE
+ * @buf: a strbuf for the result type name
+ *
+ * Stores the typedef name if possible, "*(function_type)" for function
+ * pointers.  Returns 0 or -ENOENT.
+ */
+int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
+{
+	return __die_get_typename_from_type(type_die, buf, 0);
+}
+
 /**
  * die_get_typename - Get the name of given variable DIE
  * @vr_die: a variable DIE
@@ -1179,12 +1228,7 @@ int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
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

