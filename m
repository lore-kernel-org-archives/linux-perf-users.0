Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414C1382F15
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572588; cv=none; b=kszv2RMobQny2kbbBU6a8XR5w8YRcHsJHXEfu8DEKPKZsZFz3U9sgLRLGdDAPse9qlLOKM63Mww1dWwlM6C88y0j9dfqEyPDCzHJaLcTcioJMFIsS8KYxELWNZsAsHse5imWkYdt5GyQrpqggXq1kYBg+BWULT5Y+7N3eP0GbuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572588; c=relaxed/simple;
	bh=t/LhJ10u5dl+TczaQe/LZURK3yNFuTaIISU3LK2SOPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a8eF8q3hJfhxzzvqU67PsFS8U0YNnzA/97m1ffYEj5TrmJy1g+e5aXTijl1eiPT3eZrpg51rjeacL4bjNeGKT5CWy7EK6u1zMw3HXRoUb7lRXYqx6s9MeSEAU67LjZwOjgzjHDaZEZWzyVp0p31m6sr1aJvUio4XW0qAhaxVPDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWUp12Qq; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWUp12Qq"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1394c3ee7f2so9379940c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781572586; x=1782177386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bAee8Y38VMh4ewZxYIBMES9ciGIaXoibDzamzAZ9gF4=;
        b=RWUp12QqreoEQUuRJ2ESV28/J9xDnLJKkYqMXF0EQpneGr2yD7MvdiSD2jquEv4rcD
         T0/r4MqZDW8tLHcIFOIg5uKGwe7pIq6+5+0tZVMKqrXcsxXU40DW+7PD5PNakxuWq+Bh
         9xk671wgU2RvZlwElZ9ySEwJEBs63BkfaJYK6/nD7y51VP1MnnHI++P4z0/dDE7q898H
         Duwz98+PcM8U9cYSAPGmVG8vQ1HJRSCz2ODXzoHha7CkiUYcunWBTN7OsP8ibmwH85PI
         FY7jkRiHlEMIXd+DfPjxMgDpHhsBmqr3yxg6Bh1xw6Q/OmmTDxnlb6cuypo1ecjNGKZj
         siWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781572586; x=1782177386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAee8Y38VMh4ewZxYIBMES9ciGIaXoibDzamzAZ9gF4=;
        b=aptUD5iAt62AWOc5yfx20W50OHUgeuxUICX1AgBznly1zrXJLt4SkFiQKl/ysBTYqo
         FY1gYbOxF908Ff1pzTWNFM8njc3sVj15oSSqDvO4g4DnuBKqTklubhUJOzqEN/RGmGI5
         a1lzsKBSXcsOxL0JKEBa5R0geVVG73iQVw+YG3MOXJItby5reuu/wEcGryOMC49Z/qgh
         9g/gz9dbLsY28M9fo6d+IUaSof1sA7Az+rysn8ftBuDoaLrLpESGutPtH2okogmeqqZe
         IiygwoOfJf7mWNrdFJHASfaHe0EzMeICax9DPhBdTRs9Pu16+hgs+jT6F1AaJvJimbvX
         uuzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/lpnw9EKqYKoZrBYR8xXQngX0pdStVJrrgL/z4kCOHzXmgi0f7n8Zs3B9IIu6BbSzZK8OCWzLfWgQsoTLwq5NE@vger.kernel.org
X-Gm-Message-State: AOJu0YxjzwlzQD9jiVv/7GvoF/UfJMtJheg1RQhsCB4RfwNyrX2q6Ry7
	5ZLwC4Ob34YW5tg6nuiOQqbHIMqsdGtYZngJtJq5PEycwOiOyWqdb8rPTAfhrNlYF9bsGPBb2xo
	dufAV9NoOAQ==
X-Received: from dled13-n2.prod.google.com ([2002:a05:701b:42cd:20b0:138:14f4:c975])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f83:b0:134:df7f:910d
 with SMTP id a92af1059eb24-1386f23581dmr6155781c88.7.1781572586003; Mon, 15
 Jun 2026 18:16:26 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:15:39 -0700
In-Reply-To: <20260616011543.4037138-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615223011.3873955-1-irogers@google.com> <20260616011543.4037138-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616011543.4037138-18-irogers@google.com>
Subject: [PATCH v21 17/21] perf python: Add config file access
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
index c5f567c15cc7..3a9f4e35d0bb 100644
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
@@ -3993,7 +3994,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
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

