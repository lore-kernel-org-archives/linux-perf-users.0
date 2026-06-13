Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354A33CEBBB
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781328487; cv=none; b=GgmPb78WAMxz1920zof6xg6g+Dpkg6aORCRxtQ5odqWK6pjYhwVA13jQslayAOuFH/XMUFah/rda8npbuWLR/KQQK68qLpw+CCn6wBvo48WqfWni92Ld/zSV+C6u1S0OzU/VwCQtYam6esyBo4rvclhDSWlj3coKA35ZRRq1dws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781328487; c=relaxed/simple;
	bh=EjJwD3aS8LKjRiB1i4U9opu14NHxGbs6kVSl2x11AhI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uOHhXnezsHheLYw5YbfRYoPLhvbjHQBDP9FFHj+gOxJ8kEziDB6Le2cWZot2HwmzGTvdNTkkiOWLUcUCKr9fONtqM+DtHddD9RhcUAWNhya67zh2j1hOBrXo3ydQZvIho0H5I7Xgv3Lfeq8vH2Df5aOiTLFK3Q2L64WJ2VOtJco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JkpNTARf; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkpNTARf"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-3074d4102a9so4741582eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781328481; x=1781933281; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Plx+UR6wjRd9N8bwlGTdYarAXuj5WZhqurIeR6SRoyQ=;
        b=JkpNTARfTsTvRgC0WLjgWFXk52GVH+j6KnxiPTDU7N2UVp5pz1sr2v1ii3rFQOtylE
         toZwMg9nMcGFyRTJKZ1lO2ruhR7h86TeSvEYWIeLqK03rvlb2lDrD5FzKmWrdGNSaZom
         3uJQtJ1Fl5Hgbs2hTqF1ODrkPLxV4ITEouCW9T1LxjtSKG48bFh1znPFA96fpZbPJKlo
         L1meTlLD+Oj/1EkmIilqNH8XnuWSWzkQPzrM7rmF4KaGxgE6ASU448wFQLSxQiMdg4SD
         AUhAfRroEi45P3UR9TlML3wrAZHdBhv/z1XuUm0L4qTpWd+aPI/OvthmCMI5sUfqPGuv
         8eIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781328481; x=1781933281;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Plx+UR6wjRd9N8bwlGTdYarAXuj5WZhqurIeR6SRoyQ=;
        b=d76MfJPmPxH+CWlKLD5CpZ7FJHbCLjbkWEQnWWTGCZF15aDbTVlFZZQOiIH6Rh2C30
         XkgPtHobHlriq25fdQPu2JIsnqL/A2ciuWNEhJ9gvMp8/niPal7kZluL5oZTMup7W1n+
         Egb0E8FF1/5WTUjD95CSsxUMrRKf/CWlFBEUpxJPdLH+La8RappFRyPA5UHov0e2LhN+
         EfSV9qsnrMtDMJZvoPH3TxZQwlW93tImJtHdgCSH70rYbF5CfW/DBvyu3Pvp5Umw53Hm
         JVgJn8hXDw1cOIZRf1T0ND7C/aUMMnIsEkv3wWIfmkIq7SL0LEbOgR6YM4/lW6njoYti
         5bIA==
X-Forwarded-Encrypted: i=1; AFNElJ+MO+r/+u38/2nm0tzZHl2LsE8RVi8FTF2jpVmnpqC0kAk6FD/uq5MubRN3j+c+PXDcnv+2XJlxZtjHu/78FtTr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0W0B3zEqhgJUFK+zRsndiF6WkdGizVDwMLlRbHm8//mzxFLsb
	0NUvZdkqCdOUZ/HMD3XVHOyO66IGqpAjPBth4seqBJ5oJxE2PR9rMbrOdPd6KMDzmePPn60qQC6
	v+Damn+N2Ew==
X-Received: from dycou16.prod.google.com ([2002:a05:7300:dc90:b0:304:ed39:7b0c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d4c7:b0:2f5:3641:f126
 with SMTP id 5a478bee46e88-308201deb64mr3108193eec.24.1781328480918; Fri, 12
 Jun 2026 22:28:00 -0700 (PDT)
Date: Fri, 12 Jun 2026 22:27:18 -0700
In-Reply-To: <20260613052722.1424093-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612221211.1221305-1-irogers@google.com> <20260613052722.1424093-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613052722.1424093-18-irogers@google.com>
Subject: [PATCH v16 17/20] perf python: Add config file access
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add perf.config_get(name) to expose the perf configuration system.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 137699a08c0d..debdf0aaebaf 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -17,6 +17,7 @@
 #include "build-id.h"
 #include "callchain.h"
 #include "comm.h"
+#include "config.h"
 #include "counts.h"
 #include "data.h"
 #include "debug.h"
@@ -3981,7 +3982,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
 	return PyLong_FromLong(id);
 }
 
+static PyObject *pyrf__config_get(PyObject *self, PyObject *args)
+{
+	const char *config_name, *val;
+
+	if (!PyArg_ParseTuple(args, "s", &config_name))
+		return NULL;
+
+	val = perf_config_get(config_name);
+	if (!val)
+		Py_RETURN_NONE;
+	return PyUnicode_FromString(val);
+}
+
 static PyMethodDef perf__methods[] = {
+	{
+		.ml_name  = "config_get",
+		.ml_meth  = (PyCFunction) pyrf__config_get,
+		.ml_flags = METH_VARARGS,
+		.ml_doc	  = PyDoc_STR("Get a perf config value.")
+	},
 	{
 		.ml_name  = "metrics",
 		.ml_meth  = (PyCFunction) pyrf__metrics,
-- 
2.54.0.1136.gdb2ca164c4-goog

