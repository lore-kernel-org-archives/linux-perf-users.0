Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F511A0B09
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549079; cv=none; b=fA4EZowKv1LqEUHmFxVkmMteA/H81tmy3tERV0T4OuSfXDedqu84MveWWDGLMCIE4Ri0pa6JDFy7+Zj8IN8Wqgp2kiTRHgJtAjyvOeeY0kPqmzjtIe0EZIfeLGBAWsaG3fWXvOcU5j+fKswUhai4ZmDSIAlqFtVlEEPui5jPutc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549079; c=relaxed/simple;
	bh=khlpCN2TLSjhoeo1QFb+C4We4n91wBs13YfAxnSY/EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZGSCmYkRVmokWOGATCrNKokCBXaVliUUSXRXXL18HjY9qnmFPeWbjLAyKLlRDlsoLuW55BbHkKuqz8cQXPbxUhQSFeONK4a7j6ciaFEqJhPoSTAcvzDNoa/Rml9lECqMrjFgywu4u5GgtoXbQZ3BsFfdI4A4KwCDbCZiq3PFO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwL6fhfI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwL6fhfI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725549078; x=1757085078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=khlpCN2TLSjhoeo1QFb+C4We4n91wBs13YfAxnSY/EE=;
  b=gwL6fhfIRYQCe2P2KwWiJuvt4+CE6HufB0UkvxutJ/x53IwiK8GiTALa
   Uf5Pk/xiXpJ9/nh82kkDvEkTQPJoP28DyAHQyMGxMSkG8yicnY4rBLHCk
   Cs0vAh6+7RcGictDalPJ7dEz732NgoD2BhlIqjX9DqsgAY57XDNXGUmT/
   /oDjjmy6wQ84K1ZnzhsKXxZchJT31f3HiPRnp9Ao82rEcAujQ0fZhlNtd
   MCwzwgFh+ZVC4rWmzlTOGbdIsZQ6hcM7h3J6vdmx/wt+q/sjbsiJwUiLJ
   /CbU5xzHXRnhunPpRvyWqUEGeBOTS7n5NnOUoWkNbeLWATIsMjSKB7TSP
   g==;
X-CSE-ConnectionGUID: 5zok+DVWTJaQ8vMQJG0ecw==
X-CSE-MsgGUID: DGTk+LeGQ+eCqRYokOGTXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="49688983"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="49688983"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
X-CSE-ConnectionGUID: ur/HUjgRQESorukT37Nw9w==
X-CSE-MsgGUID: yABMqVUcSCGJgji66+zGxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70456114"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	namhyung@kernel.org,
	acme@kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 07/10] perf: Support returning inlines in get_srcline_split
Date: Thu,  5 Sep 2024 08:08:01 -0700
Message-ID: <20240905151058.2127122-8-ak@linux.intel.com>
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

Support filling in an inline_node for get_srcline_split so that
callers can generate an inline stack. Adjust all the callers.
Used in next patch.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c                         | 2 +-
 tools/perf/scripts/python/Perf-Trace-Util/Context.c | 3 ++-
 tools/perf/util/dlfilter.c                          | 2 +-
 tools/perf/util/srcline.c                           | 5 +++--
 tools/perf/util/srcline.h                           | 5 ++++-
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c12beceae8b3..065b8c15718d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1140,7 +1140,7 @@ static int map__fprintf_srccode(struct map *map, u64 addr, FILE *fp, struct srcc
 		return 0;
 	srcfile = get_srcline_split(dso,
 				    map__rip_2objdump(map, addr),
-				    &line, &disc);
+				    &line, &disc, NULL);
 	if (!srcfile)
 		return 0;
 
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 417466231f71..1c1d8d08b10e 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -158,7 +158,8 @@ static PyObject *perf_sample_src(PyObject *obj, PyObject *args, bool get_srccode
 	dso = map ? map__dso(map) : NULL;
 
 	if (dso)
-		srcfile = get_srcline_split(dso, map__rip_2objdump(map, addr), &line, &disc);
+		srcfile = get_srcline_split(dso, map__rip_2objdump(map, addr), &line, &disc,
+				NULL);
 
 	if (get_srccode) {
 		if (srcfile)
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 1a3b5ba92313..33d9e917f0df 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -268,7 +268,7 @@ static const char *dlfilter__srcline(void *ctx, __u32 *line_no)
 	dso = map ? map__dso(map) : NULL;
 
 	if (dso)
-		srcfile = get_srcline_split(dso, map__rip_2objdump(map, addr), &line, &disc);
+		srcfile = get_srcline_split(dso, map__rip_2objdump(map, addr), &line, &disc, NULL);
 
 	*line_no = line;
 	return srcfile;
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 0b11e3fe3f11..fac552c0a271 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -886,7 +886,8 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 }
 
 /* Returns filename and fills in line number in line and discriminator in disc */
-char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line, unsigned *disc)
+char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line, unsigned *disc, 
+		        struct inline_node *inline_node)
 {
 	char *file = NULL;
 	const char *dso_name;
@@ -898,7 +899,7 @@ char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line, unsigned *dis
 	if (dso_name == NULL)
 		goto out_err;
 
-	if (!addr2line(dso_name, addr, &file, line, dso, true, NULL, NULL, disc))
+	if (!addr2line(dso_name, addr, &file, line, dso, true, inline_node, NULL, disc))
 		goto out_err;
 
 	dso__set_a2l_fails(dso, 0);
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index 5d37fcc7c02c..27dbe79a63b9 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -17,7 +17,10 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 		  bool show_sym, bool show_addr, bool unwind_inlines,
 		  u64 ip);
 void zfree_srcline(char **srcline);
-char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line, unsigned *disc);
+
+struct inline_node;
+char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line, unsigned *disc,
+			struct inline_node *inline_node);
 
 /* insert the srcline into the DSO, which will take ownership */
 void srcline__tree_insert(struct rb_root_cached *tree, u64 addr, char *srcline);
-- 
2.45.2

