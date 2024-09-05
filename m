Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276B510A1F
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549076; cv=none; b=rOeZp6q8c13cotPL/veEGrbMeUbAtRPS7H+IU+2DuejKrgeHOGHen5o3jKA9ZYYicaMy+U3ZhmRglZXicMfdeet4zyK0TcHhcsjdC6BIMw5oWJCrzBQ5m6yhvuS/4va3eXRjpCD3ty05x6ICHSGYDmXXjqRcWy1t81sBLI2/zhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549076; c=relaxed/simple;
	bh=pwsnxnLnM7RSHbIsdPedSoarXTBI8yV6oZlaXMhAqRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r85n84Vd7mULc891+ea11+13w86PzaSRdYx2Ll2se8zkD1QBzNxfmWu5p2syZWjNFutPhT4dxQ+88Du2PeuFFRZbvcNp/lbj95JybhqaWC1b9apz22hQhPSZOJKTTMZz5EU7rVYaLMcOdHnnWkZk6PLk1GHJE1A4s3dkSFVjrg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UF5OaHPC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UF5OaHPC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725549075; x=1757085075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pwsnxnLnM7RSHbIsdPedSoarXTBI8yV6oZlaXMhAqRk=;
  b=UF5OaHPCqyWmo0k1M40fWEOegIpvqcAPk6nMYT6OGqqxMbEjJcecjcbl
   k98Wa3d1kakx+HLJtS9vbcY8ZzzdemGoiskmr+S6ZtTlcM37S6JjaDXme
   HFk0jmw0NZCR8BCDPAc4oa6TUMoISVfWrWVdeTDi17IDIaUnn7LUUMXie
   UJFDzP6WcE7maUU/2hYrogdGriNLAaMayhtckPFNEgEavYN28JmFz/xfh
   DbBc8geJMf2WKbYHfUHV93XshvN2TwmD+n39uNac7N6BPZ4swhFw6ce1V
   E1xWz+jBHsc6kDmdgbLCcHUNKz4l6hXbeMo8HXyxtpAKvUX/uZhVluXMk
   Q==;
X-CSE-ConnectionGUID: FjVLo7K1Rq6zUL4CmqxXsg==
X-CSE-MsgGUID: UcqA8ZIZS8yITh4tkrswVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="49688973"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="49688973"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
X-CSE-ConnectionGUID: 80DIqgF2R+WxEZe8/ALI5g==
X-CSE-MsgGUID: TAaiw+n6Tmiyh2kwk7xHGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70456099"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	namhyung@kernel.org,
	acme@kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 02/10] perf: Support discriminator in addr2line
Date: Thu,  5 Sep 2024 08:07:56 -0700
Message-ID: <20240905151058.2127122-3-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905151058.2127122-1-ak@linux.intel.com>
References: <20240905151058.2127122-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dwarf has the concept of a discriminator to distinguish multiple
compiler generated statements in a line. Add support
for retrieving the discriminator in addr2line. Will be used
in later patches to pass to python scripts.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c                   |  6 ++-
 .../scripts/python/Perf-Trace-Util/Context.c  |  4 +-
 tools/perf/util/dlfilter.c                    |  4 +-
 tools/perf/util/srcline.c                     | 42 ++++++++++++-------
 tools/perf/util/srcline.h                     |  2 +-
 5 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 206b08426555..dc7e5406dae9 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1131,7 +1131,7 @@ static int map__fprintf_srccode(struct map *map, u64 addr, FILE *fp, struct srcc
 {
 	char *srcfile;
 	int ret = 0;
-	unsigned line;
+	unsigned line, disc;
 	int len;
 	char *srccode;
 	struct dso *dso;
@@ -1140,7 +1140,7 @@ static int map__fprintf_srccode(struct map *map, u64 addr, FILE *fp, struct srcc
 		return 0;
 	srcfile = get_srcline_split(dso,
 				    map__rip_2objdump(map, addr),
-				    &line);
+				    &line, &disc);
 	if (!srcfile)
 		return 0;
 
@@ -1157,6 +1157,8 @@ static int map__fprintf_srccode(struct map *map, u64 addr, FILE *fp, struct srcc
 	if (!srccode)
 		goto out_free_line;
 
+	/* Print discriminator too? Maybe with a new option */
+
 	ret = fprintf(fp, "|%-8d %.*s", line, len, srccode);
 
 	if (state) {
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 3954bd1587ce..3aa5e6385c1e 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -140,7 +140,7 @@ static PyObject *perf_set_itrace_options(PyObject *obj, PyObject *args)
 static PyObject *perf_sample_src(PyObject *obj, PyObject *args, bool get_srccode)
 {
 	struct scripting_context *c = get_scripting_context(args);
-	unsigned int line = 0;
+	unsigned int line = 0, disc = 0;
 	char *srcfile = NULL;
 	char *srccode = NULL;
 	PyObject *result;
@@ -157,7 +157,7 @@ static PyObject *perf_sample_src(PyObject *obj, PyObject *args, bool get_srccode
 	dso = map ? map__dso(map) : NULL;
 
 	if (dso)
-		srcfile = get_srcline_split(dso, map__rip_2objdump(map, addr), &line);
+		srcfile = get_srcline_split(dso, map__rip_2objdump(map, addr), &line, &disc);
 
 	if (get_srccode) {
 		if (srcfile)
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 7d180bdaedbc..1a3b5ba92313 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -250,7 +250,7 @@ static const char *dlfilter__srcline(void *ctx, __u32 *line_no)
 {
 	struct dlfilter *d = (struct dlfilter *)ctx;
 	struct addr_location *al;
-	unsigned int line = 0;
+	unsigned int line = 0, disc = 0;
 	char *srcfile = NULL;
 	struct map *map;
 	struct dso *dso;
@@ -268,7 +268,7 @@ static const char *dlfilter__srcline(void *ctx, __u32 *line_no)
 	dso = map ? map__dso(map) : NULL;
 
 	if (dso)
-		srcfile = get_srcline_split(dso, map__rip_2objdump(map, addr), &line);
+		srcfile = get_srcline_split(dso, map__rip_2objdump(map, addr), &line, &disc);
 
 	*line_no = line;
 	return srcfile;
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 760742fd4a7d..07df410b52e4 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -146,6 +146,7 @@ struct a2l_data {
 	const char 	*filename;
 	const char 	*funcname;
 	unsigned 	line;
+	unsigned	discriminator;
 
 	bfd 		*abfd;
 	asymbol 	**syms;
@@ -232,9 +233,10 @@ static void find_address_in_section(bfd *abfd, asection *section, void *data)
 	if (pc < vma || pc >= vma + size)
 		return;
 
-	a2l->found = bfd_find_nearest_line(abfd, section, a2l->syms, pc - vma,
-					   &a2l->filename, &a2l->funcname,
-					   &a2l->line);
+	a2l->found = bfd_find_nearest_line_discriminator(abfd,
+							 section, a2l->syms, pc - vma,
+							 &a2l->filename, &a2l->funcname,
+							 &a2l->line, &a2l->discriminator);
 
 	if (a2l->filename && !strlen(a2l->filename))
 		a2l->filename = NULL;
@@ -301,7 +303,7 @@ static int inline_list__append_dso_a2l(struct dso *dso,
 static int addr2line(const char *dso_name, u64 addr,
 		     char **file, unsigned int *line, struct dso *dso,
 		     bool unwind_inlines, struct inline_node *node,
-		     struct symbol *sym)
+		     struct symbol *sym, unsigned *disc)
 {
 	int ret = 0;
 	struct a2l_data *a2l = dso__a2l(dso);
@@ -354,6 +356,8 @@ static int addr2line(const char *dso_name, u64 addr,
 
 	if (line)
 		*line = a2l->line;
+	if (disc)
+		*disc = a2l->discriminator;
 
 	return ret;
 }
@@ -506,7 +510,8 @@ static int read_addr2line_record(struct io *io,
 				 bool first,
 				 char **function,
 				 char **filename,
-				 unsigned int *line_nr)
+				 unsigned int *line_nr,
+				 unsigned *disc)
 {
 	/*
 	 * Returns:
@@ -518,6 +523,9 @@ static int read_addr2line_record(struct io *io,
 	size_t line_len = 0;
 	unsigned int dummy_line_nr = 0;
 	int ret = -1;
+	char *p;
+
+	*disc = 0;
 
 	if (function != NULL)
 		zfree(function);
@@ -602,6 +610,10 @@ static int read_addr2line_record(struct io *io,
 		goto error;
 	}
 
+	p = strstr(line, "discriminator");
+	if (p && disc)
+		*disc = strtoul(p + sizeof("discriminator"), NULL, 0);
+
 	if (filename != NULL)
 		*filename = strdup(line);
 
@@ -636,7 +648,8 @@ static int addr2line(const char *dso_name, u64 addr,
 		     struct dso *dso,
 		     bool unwind_inlines,
 		     struct inline_node *node,
-		     struct symbol *sym __maybe_unused)
+		     struct symbol *sym __maybe_unused,
+		     unsigned *disc)
 {
 	struct child_process *a2l = dso__a2l(dso);
 	char *record_function = NULL;
@@ -688,7 +701,8 @@ static int addr2line(const char *dso_name, u64 addr,
 	io__init(&io, a2l->out, buf, sizeof(buf));
 	io.timeout_ms = addr2line_timeout_ms;
 	switch (read_addr2line_record(&io, a2l_style, dso_name, addr, /*first=*/true,
-				      &record_function, &record_filename, &record_line_nr)) {
+				      &record_function, &record_filename, &record_line_nr,
+				      &disc)) {
 	case -1:
 		if (!symbol_conf.disable_add2line_warn)
 			pr_warning("%s %s: could not read first record\n", __func__, dso_name);
@@ -704,7 +718,7 @@ static int addr2line(const char *dso_name, u64 addr,
 		 */
 		switch (read_addr2line_record(&io, a2l_style, dso_name,
 					      /*addr=*/1, /*first=*/true,
-					      NULL, NULL, NULL)) {
+					      NULL, NULL, NULL, NULL)) {
 		case -1:
 			if (!symbol_conf.disable_add2line_warn)
 				pr_warning("%s %s: could not read sentinel record\n",
@@ -754,7 +768,7 @@ static int addr2line(const char *dso_name, u64 addr,
 						      /*first=*/false,
 						      &record_function,
 						      &record_filename,
-						      &record_line_nr)) == 1) {
+						      &record_line_nr, NULL)) == 1) {
 		if (unwind_inlines && node && inline_count++ < MAX_INLINE_NEST) {
 			if (inline_list__append_record(dso, node, sym,
 						       record_function,
@@ -805,7 +819,7 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 	INIT_LIST_HEAD(&node->val);
 	node->addr = addr;
 
-	addr2line(dso_name, addr, NULL, NULL, dso, true, node, sym);
+	addr2line(dso_name, addr, NULL, NULL, dso, true, node, sym, NULL);
 	return node;
 }
 
@@ -832,7 +846,7 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 		goto out_err;
 
 	if (!addr2line(dso_name, addr, &file, &line, dso,
-		       unwind_inlines, NULL, sym))
+		       unwind_inlines, NULL, sym, NULL))
 		goto out_err;
 
 	srcline = srcline_from_fileline(file, line);
@@ -865,8 +879,8 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 	return srcline;
 }
 
-/* Returns filename and fills in line number in line */
-char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line)
+/* Returns filename and fills in line number in line and discriminator in disc */
+char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line, unsigned *disc)
 {
 	char *file = NULL;
 	const char *dso_name;
@@ -878,7 +892,7 @@ char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line)
 	if (dso_name == NULL)
 		goto out_err;
 
-	if (!addr2line(dso_name, addr, &file, line, dso, true, NULL, NULL))
+	if (!addr2line(dso_name, addr, &file, line, dso, true, NULL, NULL, disc))
 		goto out_err;
 
 	dso__set_a2l_fails(dso, 0);
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index 75010d39ea28..d2cb90b1177e 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -17,7 +17,7 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 		  bool show_sym, bool show_addr, bool unwind_inlines,
 		  u64 ip);
 void zfree_srcline(char **srcline);
-char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line);
+char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line, unsigned *disc);
 
 /* insert the srcline into the DSO, which will take ownership */
 void srcline__tree_insert(struct rb_root_cached *tree, u64 addr, char *srcline);
-- 
2.45.2

