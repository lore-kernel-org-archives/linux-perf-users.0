Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731819E7C8
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549078; cv=none; b=OXmj6sSvrtB4zwQcNTcPth/QTGx8xE65zUHZbE54l47H3xh44lSJ6fkTf1/wZ5pilOOwhP8UV8fizE18K/r1Fd7qU0Nne0Rwmp6JTHg7IaL0RGkjg8g845b7CTtnwhEMMdJke/qMFlgS7pB0vD5R3pKn8VUnFFywlLvtvotdeEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549078; c=relaxed/simple;
	bh=ZgF5Mu+1KhlYgCB6OfO04q0Nt8Al9bVwW6ovJg0Sv+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1BibpJ9nWg0QNMw3YY8zmGp7dD6Die2pInYQmsIJrvtc1jeVUyh02o/kYKCYhemjcdShMq0qhZ8nl/6X7ONhqiENBHgPmZ0cWxARTmYwT+L/whO6+HmypTFnK3ji3ufX9vki0sdKI9y+CuS2veimCmOH9jPvnJgs3APSKhPwzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mr/Fx2DN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mr/Fx2DN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725549077; x=1757085077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZgF5Mu+1KhlYgCB6OfO04q0Nt8Al9bVwW6ovJg0Sv+0=;
  b=Mr/Fx2DNPXSb5TnqUlDwTBwJeyCerbQ/hBDGRDEfx8XVRMWBD3cCsruJ
   F2MrySFz0DNlHyqBY13022F56q52HREpVkMP4XZpXFNX/n6G+ODxl8f7g
   K0/Vdd9r67Ij28ChRTeyYrX3OWi349Wcmi+rWp5kUXQwDY8d0PwCyXYN+
   rp4ylYKmE6wMiQB+AUXnnEhgzJsJUA77ELT86eIQOcm3fVSIQGS2CteS/
   425vIC/75/On/97qeu7rGC8csAduK0AYY0jG+oRXAlGcsoceZtA5Q7Cgi
   eLOKcZOGzA/lPnbXw8hacngp/GZtgb/WvBFEDmugRRxPz8i8UFvWSZD4x
   A==;
X-CSE-ConnectionGUID: sPKnHBsvRdGRQ2mXv+gBNA==
X-CSE-MsgGUID: 46675LhsRAKg2lzTuUnaKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="49688979"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="49688979"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
X-CSE-ConnectionGUID: 10n7O0XbQuOnVKvjR+txxQ==
X-CSE-MsgGUID: tDy7IHvIR9aIRyq/fReNAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70456108"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	namhyung@kernel.org,
	acme@kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 05/10] perf: Add perf_resolve_ip python interface
Date: Thu,  5 Sep 2024 08:07:59 -0700
Message-ID: <20240905151058.2127122-6-ak@linux.intel.com>
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

Add a perf_resolve_ip python interface to resolve filename/line/disc for
specific addresses.  I had a case where a script needs to resolve
this for the base symbol of a sample. It reuses the same machinery
as the earlier added perf_brstack_srcline.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 .../scripts/python/Perf-Trace-Util/Context.c  | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index a95a27895a15..417466231f71 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -183,7 +183,7 @@ static PyObject *perf_sample_srccode(PyObject *obj, PyObject *args)
 	return perf_sample_src(obj, args, true);
 }
 
-static PyObject *do_perf_brstack_srcline(struct scripting_context *c, PyObject *ipp)
+static PyObject *do_resolve_ip(struct scripting_context *c, PyObject *ipp)
 {
 	struct addr_location al;
 	struct dso *dso;
@@ -233,11 +233,22 @@ static PyObject *perf_brstack_srcline(PyObject *obj, PyObject *args)
 	struct scripting_context *c = get_args(args, "brstack", &brstack);
 	if (!c)
 		return NULL;
-	from = do_perf_brstack_srcline(c, PyDict_GetItemString(brstack, "from"));
-	to = do_perf_brstack_srcline(c, PyDict_GetItemString(brstack, "to"));
+	from = do_resolve_ip(c, PyDict_GetItemString(brstack, "from"));
+	to = do_resolve_ip(c, PyDict_GetItemString(brstack, "to"));
 	return Py_BuildValue("(OO)", from, to);
 }
 
+/* Resolve an numerical address to srcfile/line/disc */
+
+static PyObject *perf_resolve_ip(PyObject *obj, PyObject *args)
+{
+	PyObject *ip;
+	struct scripting_context *c = get_args(args, "ip", &ip);
+	if (!c)
+		return NULL;
+	return do_resolve_ip(c, ip);
+}
+
 static PyMethodDef ContextMethods[] = {
 #ifdef HAVE_LIBTRACEEVENT
 	{ "common_pc", perf_trace_context_common_pc, METH_VARARGS,
@@ -257,6 +268,8 @@ static PyMethodDef ContextMethods[] = {
 	  METH_VARARGS,	"Get source file name, line number and line."},
 	{ "perf_brstack_srcline", perf_brstack_srcline,
 	  METH_VARARGS, "Get source file name, line number, discriminator for from/to of a brstack entry." },
+	{ "perf_resolve_ip", perf_resolve_ip,
+	  METH_VARARGS, "Get source file name, line number, discriminator for numerical IP." },
 	{ NULL, NULL, 0, NULL}
 };
 
-- 
2.45.2

