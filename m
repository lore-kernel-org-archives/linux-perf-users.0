Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2823C1096
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562663; cv=none; b=Dcv24JUyHhztY/WT2EbLBZo2W3m0gyT3aM0iFarAxPxa5cLVxtqu28tRZj9L2KdPZqx+2CxDDwqzqUKDNT+5jrmjUqT9dHm+m0hy1ihg7zbvoCriHmKW3OnSyjNBSTiAgtCsPaAOPrsX4nf8IF2mCT1xDvhcCB1/dM+U13wJTug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562663; c=relaxed/simple;
	bh=t/LhJ10u5dl+TczaQe/LZURK3yNFuTaIISU3LK2SOPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WdTjbpP6A2LeyAIJK49PhlaHX8XZ1b78n9jLmVgaICr4SqX9K4KEW6+KbCp5skWZ1coGDutIF0HATAuQW4PRoF0gODv0HvMcfyW6qf/Ej9n5uOLvd6iNp0S7/2DQlneJE7GvR7KaeLsClppd4bL8dksEHt+FLYcVxZs+4I+arnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PjIc18E3; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PjIc18E3"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30761ab3483so86532eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 15:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781562661; x=1782167461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bAee8Y38VMh4ewZxYIBMES9ciGIaXoibDzamzAZ9gF4=;
        b=PjIc18E3h7NqBE9OSfSilyMzujlt6ErOi/0ApmR9SBBcaEb9z8qyQm276DAcI8wWmV
         mFh0eHtC06BoTyn+PEKlBGxlFqB59DXB+RlbTL9KnW1zdezdZM0Us0AC3h9CiIqAvEyY
         1IvkJPwsz3koAQAsfjfwiGeQJIVzHsiVydz9tyR3m1nWHucQPVIVM2PN1wetMRBmATwb
         gY1Hf4HNySRL5AL38szq8mab3LPvClXxhcEHZGOlla7F5yRmT+93IKpSfTdQoV0523vv
         Mf28cMfIiTZ6kSU6YwfHGqgf4f4HUEHf0ywwBYo+BXUbvk3tBI9J5PkhAuDQQYMLTQKE
         jpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781562661; x=1782167461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAee8Y38VMh4ewZxYIBMES9ciGIaXoibDzamzAZ9gF4=;
        b=hZjuIUXREILoHmkKwnDXxq6EljvFmFWfWoIWIrLcR7cUZTiJdaQAHnuYPW514r5baq
         DdNH3Ysh2x2RzbQyoI19XUc8T669/hLZGYjo8e0j18BiEQaHrmHN41ej13/3jVmjchqZ
         1sUZNTTPgT5rqlPti4qBeMHeE1SYYmrnl6/jJqVHXwNIVTPc98lufpn9Ncu9f0xe9DFS
         xNfSWXnN/xwBiehiG0xMbZ1lJB+U2RBm0Od7Xgrv8v2YuF3JC6KRAI1TpWF5e3pCufU5
         vokGU8NyQ1c4ZuI6zysKK/HPasHDmYJsXNGDgoASqF76QVuEwHwwhKE3y/5/ce9ewXtv
         db3g==
X-Forwarded-Encrypted: i=1; AFNElJ+WjYn86ED0R+iyy5MLPxNu1Dbgj0sqfJdflQkPir0TAIoUdr2yB8CtF6dGlxzPgt/o8ZwErqZfrRWAGOwQ024l@vger.kernel.org
X-Gm-Message-State: AOJu0YxoBNJbGXgXAsqjBBhsN+4OEu0uySPB9ufZzbqF4S/pBBqS9z17
	ieWLmwKUpKKdT26PCKHjUckQHeVOp6EKdk1dVcRuDDQzAYSxRn/6KAh9Rp28bFTjajtxqyU0hPC
	02LKffcKKbw==
X-Received: from dyw6.prod.google.com ([2002:a05:7300:8806:b0:2f2:fc0:8869])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e882:b0:304:e2a5:689e
 with SMTP id 5a478bee46e88-30ba5989923mr678087eec.2.1781562661150; Mon, 15
 Jun 2026 15:31:01 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:30:07 -0700
In-Reply-To: <20260615223011.3873955-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615223011.3873955-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615223011.3873955-18-irogers@google.com>
Subject: [PATCH v20 17/21] perf python: Add config file access
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

