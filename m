Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47FB1A0B12
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549080; cv=none; b=bjmKW+EiQ1jskDX2ct54ckvGeJzZ7obxUoQ5P3RS1QjMIE/2gaahEZ5q2uyvN6aLptA144IUdyCjXhJre9IHrs/J15ZaOYG4YNJFv5qFgoyV3fTWPB8q+2aqYPbQk0QuI26gtZH3wNymhtxU5ey10rSgMEPYwU7rJhtAvATQwjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549080; c=relaxed/simple;
	bh=K9yOaNAHv+bKXYHq8kJbsXVlLDKiLHzsuYaNcNow+pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeyIq8fOsi8cxzu2N15YvBZNW+x+i3V9m5cPku3MvrYsTU+F3/BTginAQfa56DbSRnmemNmODQpn3pCYHUe+qnnQO0Mhzob87IJmniA+vKIbfHSm/glZZ7ggq4sv22DpAX0dnuVi4sklidw4tDzyX99dhzPQtetyKjtWlKJ3MuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MRG2Mm+Z; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MRG2Mm+Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725549078; x=1757085078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K9yOaNAHv+bKXYHq8kJbsXVlLDKiLHzsuYaNcNow+pM=;
  b=MRG2Mm+Z/a4WlMkarYkGn0YiiO8e2mG1LvVoBzOCEn8S16NNY0T/Y+st
   oOJrMpyIacBFOSHLA02MzHwdNF8c1c4J3KPDI/Goifensxv5DF3XFWYAt
   r/3m5QpZ4dHTNgLsNkGo0G8OEi2I5IzFZzrkH6LYj0dt9g8Na25Yk8UDg
   TvjZIL/evm0mqwZjNseVbe36hw9WD5p/SNiIQcxXh8+z/DBVkm1tGNAQQ
   3wIzav13rscnCbvCydQXlTNOlrV/J6AfirpupvC6xfJhZfubqCzduJJtS
   1l0r7iRperZziapGf0P8Z1mregd5Xtv2PBJgQq3E57a103Ue+A8H8GMMu
   g==;
X-CSE-ConnectionGUID: 89fIUWrwTHil+u/ojhENDA==
X-CSE-MsgGUID: QFD0c+W6QVus1f7VV4kvfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="49688985"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="49688985"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
X-CSE-ConnectionGUID: ZfINgxbbQQ2G7KNOaClVbQ==
X-CSE-MsgGUID: DV4OvA+hSxmaP6Hch6xKCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70456117"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	namhyung@kernel.org,
	acme@kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 08/10] perf: resolve inlines for perf_brstack_srcline/perf_ip_srcline
Date: Thu,  5 Sep 2024 08:08:02 -0700
Message-ID: <20240905151058.2127122-9-ak@linux.intel.com>
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

Extend perf_brstack/ip_srcline to also return the inline stack to the
python script. I made it unconditional for now.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 .../scripts/python/Perf-Trace-Util/Context.c  | 43 ++++++++++++++++---
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 1c1d8d08b10e..a1c3c35bc6e6 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -194,7 +194,12 @@ static PyObject *do_resolve_ip(struct scripting_context *c, PyObject *ipp)
 	bool kernel;
 	u64 ip = PyLong_AsUnsignedLongLong(ipp);
 	unsigned line = 0, disc = 0;
+	struct inline_node *inode = calloc(sizeof(struct inline_node), 1);
 
+	if (!inode)
+		goto err2;
+
+	INIT_LIST_HEAD(&inode->val);
 	kernel = machine__kernel_ip(c->machine, ip);
 	if (kernel)
 		cpumode = PERF_RECORD_MISC_KERNEL;
@@ -213,15 +218,41 @@ static PyObject *do_resolve_ip(struct scripting_context *c, PyObject *ipp)
 		goto err;
 	if (dso__data(dso)->status == DSO_DATA_STATUS_ERROR)
 		goto err;
-	srcfile = get_srcline_split(dso, map__rip_2objdump(al.map, al.addr), &line, &disc);
-	if (srcfile)
-		result = Py_BuildValue("(sII)", srcfile, line, disc);
-	free(srcfile);
+	srcfile = get_srcline_split(dso, map__rip_2objdump(al.map, al.addr), &line,
+				    &disc, inode);
+	if (srcfile && srcfile != SRCLINE_UNKNOWN) {
+		if (!list_empty(&inode->val)) {
+			PyObject *inlines;
+			struct inline_list *ilist;
+			int num;
+		       	num = 0;
+			list_for_each_entry (ilist, &inode->val, list)
+				num++;
+			inlines = PyTuple_New(num);
+			if (!inlines)
+				goto out;
+			num = 0;
+			list_for_each_entry (ilist, &inode->val, list) {
+				PyTuple_SetItem(inlines, num,
+						Py_BuildValue("(ssII)",
+							ilist->srcline, ilist->symbol->name,
+							ilist->line, ilist->disc));
+				num++;
+			}
+			result = Py_BuildValue("(sIIO)", srcfile, line, disc, inlines);
+			Py_DECREF(inlines);
+		out:
+		} else {
+			result = Py_BuildValue("(sII)", srcfile, line, disc);
+		}
+	}
+	zfree_srcline(&srcfile);
 err:
 	addr_location__exit(&al);
 err2:
 	if (!result)
 		return Py_BuildValue("");
+	inline_node__delete(inode);
 	return result;
 }
 
@@ -268,9 +299,9 @@ static PyMethodDef ContextMethods[] = {
 	{ "perf_sample_srccode", perf_sample_srccode,
 	  METH_VARARGS,	"Get source file name, line number and line."},
 	{ "perf_brstack_srcline", perf_brstack_srcline,
-	  METH_VARARGS, "Get source file name, line number, discriminator for from/to of a brstack entry." },
+	  METH_VARARGS, "Get source file name, line number, discriminator, inline stack for from/to of a brstack entry." },
 	{ "perf_resolve_ip", perf_resolve_ip,
-	  METH_VARARGS, "Get source file name, line number, discriminator for numerical IP." },
+	  METH_VARARGS, "Get source file name, line number, discriminator, inline stack for numerical IP." },
 	{ NULL, NULL, 0, NULL}
 };
 
-- 
2.45.2

