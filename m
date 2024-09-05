Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7E1A08B2
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549078; cv=none; b=b59eZj2IqUzY7DsEb30R4pYp0TQIko7ZDwbhFK6AgV7VkioUFQnODAyS3DKpXL8+JdUhEJ85rx0iZ8ccQCIWd1D+xL1EYC98arr/24j0Ro1Uj+PwOXJpwEdMiBjBLKOqac1DhdO+NhMHH1v8zc06iKpdh/dOXuEANdGVde/udNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549078; c=relaxed/simple;
	bh=7aAYxHzrsviUkloGDLcF3W5y8I56fXqfxXS9bptd8dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miXHLp7+SIq1jVvPzGe24m5V524O0zCs++fx5NVPPldd48MZhHTFSZD3V7zVDNdQxTQp3jw+YMuqlS+qWI6N0M23TTzWlHQ9G4LS7LIiFuubftX+3fPhS7aoe6P6TTGTVVN/Yls3/hgq0IIlfp+hdaZcwVVwpBvoz3uOSe5ihkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaUeEtva; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaUeEtva"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725549077; x=1757085077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7aAYxHzrsviUkloGDLcF3W5y8I56fXqfxXS9bptd8dc=;
  b=SaUeEtvafVeBH2O1vXVkS9EicDWJP7v209Gek4ltoKmcksfpAbCIdtjE
   iQw3QOsvtWkVh/A1SFZ8wIikgQgIvNZeU+k1V2IRYrb12mdAuH7dUlqag
   F/xx0CXgq0ZoR3tG7sIuVlx3keujF7dsGHcm53qDg/wJ2sk161HPSYgep
   F8q+2oV4Y8rLl81sK6oW4erLnqE3YKUKRG/AGBSaRsccoQmn7IjQBAMU1
   WDEDoKfc2S0116Jh6uKfoddvQ/YeaJyl/CCssOaYtt3qJMrw20K6FCw2+
   Y8WSIULXV19mbo+8mimid9U9YnQt+9o5LcuJtC/gq+qKR52bMBecFdlKF
   w==;
X-CSE-ConnectionGUID: AUjXxhoeRJeKIlw34IMcMA==
X-CSE-MsgGUID: vGwwPw8TQvCGFTWFZccGBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="49688977"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="49688977"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
X-CSE-ConnectionGUID: hjY5JVFzSsmXbyySKecOkA==
X-CSE-MsgGUID: iluwsinPT8S+JV4fx33YAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70456105"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	namhyung@kernel.org,
	acme@kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 04/10] perf: Add perf_brstack_srcline to resolve brstack entries
Date: Thu,  5 Sep 2024 08:07:58 -0700
Message-ID: <20240905151058.2127122-5-ak@linux.intel.com>
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

Add a new perf_brstack_srcline python function that resolves a full
brstack to filename/line/line/discriminator for each entry.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 .../scripts/python/Perf-Trace-Util/Context.c  | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 3aa5e6385c1e..a95a27895a15 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -22,6 +22,7 @@
 #include "../../../util/session.h"
 #include "../../../util/srcline.h"
 #include "../../../util/srccode.h"
+#include "../../../util/dso.h"
 
 #if PY_MAJOR_VERSION < 3
 #define _PyCapsule_GetPointer(arg1, arg2) \
@@ -182,6 +183,61 @@ static PyObject *perf_sample_srccode(PyObject *obj, PyObject *args)
 	return perf_sample_src(obj, args, true);
 }
 
+static PyObject *do_perf_brstack_srcline(struct scripting_context *c, PyObject *ipp)
+{
+	struct addr_location al;
+	struct dso *dso;
+	u8 cpumode;
+	char *srcfile = NULL;
+	PyObject *result = NULL;
+	bool kernel;
+	u64 ip = PyLong_AsUnsignedLongLong(ipp);
+	unsigned line = 0, disc = 0;
+
+	kernel = machine__kernel_ip(c->machine, ip);
+	if (kernel)
+		cpumode = PERF_RECORD_MISC_KERNEL;
+	else
+		cpumode = PERF_RECORD_MISC_USER;
+
+	addr_location__init(&al);
+	if (machine__resolve(c->machine, &al, c->sample) < 0)
+		goto err2;
+	if (!thread__find_map(al.thread, cpumode, ip, &al))
+		goto err;
+	if (!al.map)
+		goto err;
+	dso = map__dso(al.map);
+	if (!dso)
+		goto err;
+	if (dso__data(dso)->status == DSO_DATA_STATUS_ERROR)
+		goto err;
+	srcfile = get_srcline_split(dso, map__rip_2objdump(al.map, al.addr), &line, &disc);
+	if (srcfile)
+		result = Py_BuildValue("(sII)", srcfile, line, disc);
+	free(srcfile);
+err:
+	addr_location__exit(&al);
+err2:
+	if (!result)
+		return Py_BuildValue("");
+	return result;
+}
+
+/* Resolve srcfile/line/disc for brstack from/to. */
+
+static PyObject *perf_brstack_srcline(PyObject *obj, PyObject *args)
+{
+	PyObject *brstack = NULL;
+	PyObject *from, *to;
+	struct scripting_context *c = get_args(args, "brstack", &brstack);
+	if (!c)
+		return NULL;
+	from = do_perf_brstack_srcline(c, PyDict_GetItemString(brstack, "from"));
+	to = do_perf_brstack_srcline(c, PyDict_GetItemString(brstack, "to"));
+	return Py_BuildValue("(OO)", from, to);
+}
+
 static PyMethodDef ContextMethods[] = {
 #ifdef HAVE_LIBTRACEEVENT
 	{ "common_pc", perf_trace_context_common_pc, METH_VARARGS,
@@ -199,6 +255,8 @@ static PyMethodDef ContextMethods[] = {
 	  METH_VARARGS,	"Get source file name and line number."},
 	{ "perf_sample_srccode", perf_sample_srccode,
 	  METH_VARARGS,	"Get source file name, line number and line."},
+	{ "perf_brstack_srcline", perf_brstack_srcline,
+	  METH_VARARGS, "Get source file name, line number, discriminator for from/to of a brstack entry." },
 	{ NULL, NULL, 0, NULL}
 };
 
-- 
2.45.2

