Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8871A08B2
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549081; cv=none; b=JJTdCWqO+xpcI+xRBgFFYZsgdR1ahXc25dLImtrqb6Hk5XuIdAzcaMP0LaWEDwq6OJYmqMZLR88Wzq7z4UCZwnMZvfGK/Ljgr7sW2xbh8qfBm1oC+CHuXBvPJ6GN8/Zq23ES+8c44QGlOWRrPdSnH2Rp6fgTvmSSli/Jcw8taUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549081; c=relaxed/simple;
	bh=yKSoZzbLgYRAYufexFE046Kxv0TUOGUneCHyljwKRUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzQsW7BMqQs1IZpRabepUSYrpaHLujt9Uvl34kq1HbazEpIjG9cO34P4PJh89yPTwGhaMIvJyUij/WP3YvyuwTiS4Tt99bmmRwOXRWFPjuTgTvw3Khu/iLteyU7/dPYwHjVcKGELWxn4CziBnjxBF9/M7PsUkPCepuWFNCvMxKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fk9INHtZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fk9INHtZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725549080; x=1757085080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yKSoZzbLgYRAYufexFE046Kxv0TUOGUneCHyljwKRUQ=;
  b=fk9INHtZrMfqibu3osADiUdRxQc3LC5CNm6fnN+QPT5PG09yxSANhBBX
   UzWmK2z76N0y4A+b7rd/junK+q3paErUcG5zETVpMrzDgSUBjdNp41uid
   RgliouhuGf+9hnnzljAOjOq9cRB3HAglhREWLzEbx1bfiRUct1F1E/AFv
   XZy0fQ94/Y+kALUFV/efc1qjaTwIMLRY4OPWshwGipI6yUGQpeG3QlCxe
   uvManvk1PQ8KlHMajBHd8mibQqQhkwsNQy68NlhRq4sPqrE71Fy5W9mQ5
   afmi+XPGNkbnexk3vTpxPgqJ6/Yr1OB4Q8af4EkEKmjVmzNp0xacVIz7o
   g==;
X-CSE-ConnectionGUID: prKhESh/SjGdOXZRhcnVkA==
X-CSE-MsgGUID: 9Zxr9bWTSgaUeAA+PbAJtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="49688988"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="49688988"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
X-CSE-ConnectionGUID: Aa6EZb9nSD6dkjzX0fJHeA==
X-CSE-MsgGUID: 2rE1R106QuSPUqeGdc8JqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70456120"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	namhyung@kernel.org,
	acme@kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 09/10] perf: Add build id and filename to perf_brstack/ip_srcline
Date: Thu,  5 Sep 2024 08:08:03 -0700
Message-ID: <20240905151058.2127122-10-ak@linux.intel.com>
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

Add the buildid and executable file name to the tuple returned by the
new perf_brstack/ip_srcline python callbacks. This is all useful for
some analysis by perf scripts.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 .../scripts/python/Perf-Trace-Util/Context.c  | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index a1c3c35bc6e6..a64acc3af607 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -23,6 +23,7 @@
 #include "../../../util/srcline.h"
 #include "../../../util/srccode.h"
 #include "../../../util/dso.h"
+#include "../../../util/build-id.h"
 
 #if PY_MAJOR_VERSION < 3
 #define _PyCapsule_GetPointer(arg1, arg2) \
@@ -195,6 +196,7 @@ static PyObject *do_resolve_ip(struct scripting_context *c, PyObject *ipp)
 	u64 ip = PyLong_AsUnsignedLongLong(ipp);
 	unsigned line = 0, disc = 0;
 	struct inline_node *inode = calloc(sizeof(struct inline_node), 1);
+	char bid[SBUILD_ID_SIZE];
 
 	if (!inode)
 		goto err2;
@@ -218,6 +220,8 @@ static PyObject *do_resolve_ip(struct scripting_context *c, PyObject *ipp)
 		goto err;
 	if (dso__data(dso)->status == DSO_DATA_STATUS_ERROR)
 		goto err;
+	build_id__sprintf(dso__bid(dso), bid);
+
 	srcfile = get_srcline_split(dso, map__rip_2objdump(al.map, al.addr), &line,
 				    &disc, inode);
 	if (srcfile && srcfile != SRCLINE_UNKNOWN) {
@@ -234,16 +238,18 @@ static PyObject *do_resolve_ip(struct scripting_context *c, PyObject *ipp)
 			num = 0;
 			list_for_each_entry (ilist, &inode->val, list) {
 				PyTuple_SetItem(inlines, num,
-						Py_BuildValue("(ssII)",
-							ilist->srcline, ilist->symbol->name,
-							ilist->line, ilist->disc));
+						Py_BuildValue("(s#IIs)",
+							ilist->srcline,
+							strcspn(ilist->srcline, ":"),
+							ilist->line, ilist->disc,
+							ilist->symbol->name));
 				num++;
 			}
-			result = Py_BuildValue("(sIIO)", srcfile, line, disc, inlines);
+			result = Py_BuildValue("(sIIssO)", srcfile, line, disc, dso->long_name, bid, inlines);
 			Py_DECREF(inlines);
 		out:
 		} else {
-			result = Py_BuildValue("(sII)", srcfile, line, disc);
+			result = Py_BuildValue("(sIIss())", srcfile, line, disc, dso->long_name, bid);
 		}
 	}
 	zfree_srcline(&srcfile);
@@ -299,9 +305,9 @@ static PyMethodDef ContextMethods[] = {
 	{ "perf_sample_srccode", perf_sample_srccode,
 	  METH_VARARGS,	"Get source file name, line number and line."},
 	{ "perf_brstack_srcline", perf_brstack_srcline,
-	  METH_VARARGS, "Get source file name, line number, discriminator, inline stack for from/to of a brstack entry." },
+	  METH_VARARGS, "Get source file name, line number, discriminator, executable, build-id, inline stack for from/to of a brstack entry." },
 	{ "perf_resolve_ip", perf_resolve_ip,
-	  METH_VARARGS, "Get source file name, line number, discriminator, inline stack for numerical IP." },
+	  METH_VARARGS, "Get source file name, line number, discriminator, executable, build-id, inline stack for numerical IP." },
 	{ NULL, NULL, 0, NULL}
 };
 
-- 
2.45.2

