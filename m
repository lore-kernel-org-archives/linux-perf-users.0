Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545331A0AFA
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549079; cv=none; b=JBsucvCDNRpOfEIPm+NTfks62Z6fK9yHt6Th2Zd8rMLULL5YsI7TN/fpZl3VG1/iBje2UUX6vF2RVzagAIxV+BztvDA9ZTInagNHFpRNEYDIdXA3KpZGSp+V6bay/bKXj0hd6pUERMLTDmWyjVl4FY8rLVSRoG0AlqfJlB/sGms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549079; c=relaxed/simple;
	bh=NXkix6wCwjIfUGNccBewI/yQuZlkVvZKxo4ZqAjfg28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mfr0iOMcFbqgc/KLylPnd16oxkH93fviaTYCEWox5tpeVv3Z9C3f5kzWuqHIcSrf/iC0oY+PCBT3CoPJivQbAIwXHvwRkQAdfQfPx3WZubMr9V3bw6HVxeGDJChPrwUw9Oid7TD9SIZYWrw27u2uJOP6e8b6I3BBG3cqMBTkNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXueFgF/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXueFgF/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725549078; x=1757085078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NXkix6wCwjIfUGNccBewI/yQuZlkVvZKxo4ZqAjfg28=;
  b=MXueFgF/NGqxjQYxal3gn5cxI6EMPJlKkWo20F2XigqhLNXkBw1E4hX0
   24KVDBLqn8jXZPW4hKJLxhROjjtaUbMtsHatgbI2HLaxwnzerUJCouHi9
   d3KFZYZ+j+j7Q/4cGT7F1nfblFjJdZFbjCr+SQ1JTIhBLkIZRuMLyq/JG
   0zEQ0/ZKP4+6GQRFF+rZAapic1O6sultbM0QSq9Nu/LAXjMqcNFYCsa+g
   2n0/EtPfXJaoxb7OXULggmvq8YvmxPy4KBptZPkBVeeTfwJVN0+S92z6L
   r3Nf6FqOhJisJoa1nXIER1O1afV9YQ6/9OoRW0hEeFEMtNmAdXj723Lbe
   w==;
X-CSE-ConnectionGUID: 78Wm4jtuRIO7WkncGIdNYQ==
X-CSE-MsgGUID: uXBJW9JBRPSYf+9vvYpcxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="49688981"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="49688981"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
X-CSE-ConnectionGUID: BwEMpANiQrS4BppISlGl2Q==
X-CSE-MsgGUID: eh9UkcCJTMijYG04zAmnvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70456111"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	namhyung@kernel.org,
	acme@kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 06/10] perf: Add plumbling for line/disc for inlines
Date: Thu,  5 Sep 2024 08:08:00 -0700
Message-ID: <20240905151058.2127122-7-ak@linux.intel.com>
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

When resolving inlines save the line number and the discriminator for
later use. The line number is already in the string, but it's more
convenient to have it as a integer too. Used in future patches.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/srcline.c | 18 ++++++++++++------
 tools/perf/util/srcline.h |  2 ++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 07df410b52e4..0b11e3fe3f11 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -46,6 +46,7 @@ static const char *srcline_dso_name(struct dso *dso)
 }
 
 static int inline_list__append(struct symbol *symbol, char *srcline,
+			       int line, int disc,
 			       struct inline_node *node)
 {
 	struct inline_list *ilist;
@@ -56,6 +57,8 @@ static int inline_list__append(struct symbol *symbol, char *srcline,
 
 	ilist->symbol = symbol;
 	ilist->srcline = srcline;
+	ilist->disc = disc;
+	ilist->line = line;
 
 	if (callchain_param.order == ORDER_CALLEE)
 		list_add_tail(&ilist->list, &node->val);
@@ -297,7 +300,8 @@ static int inline_list__append_dso_a2l(struct dso *dso,
 	if (a2l->filename)
 		srcline = srcline_from_fileline(a2l->filename, a2l->line);
 
-	return inline_list__append(inline_sym, srcline, node);
+	return inline_list__append(inline_sym, srcline, a2l->line,
+				   a2l->discriminator, node);
 }
 
 static int addr2line(const char *dso_name, u64 addr,
@@ -636,11 +640,12 @@ static int inline_list__append_record(struct dso *dso,
 				      struct symbol *sym,
 				      const char *function,
 				      const char *filename,
-				      unsigned int line_nr)
+				      unsigned int line_nr,
+				      unsigned int disc)
 {
 	struct symbol *inline_sym = new_inline_sym(dso, sym, function);
 
-	return inline_list__append(inline_sym, srcline_from_fileline(filename, line_nr), node);
+	return inline_list__append(inline_sym, srcline_from_fileline(filename, line_nr), line_nr, disc, node);
 }
 
 static int addr2line(const char *dso_name, u64 addr,
@@ -750,7 +755,8 @@ static int addr2line(const char *dso_name, u64 addr,
 		if (node && inline_list__append_record(dso, node, sym,
 						       record_function,
 						       record_filename,
-						       record_line_nr)) {
+						       record_line_nr,
+						       disc)) {
 			ret = 0;
 			goto out;
 		}
@@ -768,12 +774,12 @@ static int addr2line(const char *dso_name, u64 addr,
 						      /*first=*/false,
 						      &record_function,
 						      &record_filename,
-						      &record_line_nr, NULL)) == 1) {
+						      &record_line_nr, &disc)) == 1) {
 		if (unwind_inlines && node && inline_count++ < MAX_INLINE_NEST) {
 			if (inline_list__append_record(dso, node, sym,
 						       record_function,
 						       record_filename,
-						       record_line_nr)) {
+						       record_line_nr, disc)) {
 				ret = 0;
 				goto out;
 			}
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index d2cb90b1177e..5d37fcc7c02c 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -32,6 +32,8 @@ extern char *srcline__unknown;
 struct inline_list {
 	struct symbol		*symbol;
 	char			*srcline;
+	int			line;
+	int			disc;
 	struct list_head	list;
 };
 
-- 
2.45.2

