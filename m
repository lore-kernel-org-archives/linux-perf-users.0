Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542C24D990E
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217939; cv=none; b=KEuWIaRIVPfBjWcDtOcFtF7aSxhBdha4mQ+iGpKk8FX4JBWEZUHcyrYQ8IFgNiOZcg5JrzmKgb83+wkucpYg2ifzMnTSk/Hhu3vOfT/0kksIJS0gSaAYcIENCjrIwOg0CyLsBCatg9But7oztD1MSkozhSfw/T4MH4LoZzLkcSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217939; c=relaxed/simple;
	bh=Te+Lm4XROBVtifee5bBcJZlhJO3x6xcISlC99QOdMEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mSPahMoNUgy7IfxlIsN0kOiFLNgsqP3yUOX7xPSkRNz+Xg9LvdamDT8IOsE/sdCh16DdRp/q2PVb7UaYiNGQrotKx6XIiy8/iR8Ri4Bo9L17bhOPOp+h9cSTk4zOZmbtRebdBJYFQhiwtMNZ47ihluwp6vX7frh3aYMl2PzwzRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KP40Ycgi; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KP40Ycgi"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-3080bb0267dso826998eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781217936; x=1781822736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/DeqyEXyTXLLR5IZkFcZFEUXnriopqxIxsZ7mPdUC6k=;
        b=KP40YcgiGAMK1ePlcOovIvXkxXWB+vkFgdmRjvqbt701skqwJ/R3JlCh3EXS4lv2AY
         Od8efnPjMS4hqgssn8rdViDYYa9ApqliqG/4cU0jJGURwdpxVaKZrpDhugX03G2cj5gZ
         BYOmENJQVyk/HkMGUfQF25pQ89uhFInxoIQ0vXRwK8cyBW5m27IKRpOAH6O8uVdfTBGr
         QogD1eUgO11H4KrurrZhvbhpslpbBycATkjpduUMozcm97RgNwnCxNW9ljR2t2eEirFL
         ycS02KbOdbIj14zk9HwvQMp5c0xp0+I9kJzRan1u+WMbJXEwIH6VGJWLOiWDFXjG2qWT
         ltmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781217936; x=1781822736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/DeqyEXyTXLLR5IZkFcZFEUXnriopqxIxsZ7mPdUC6k=;
        b=qnjyHh21OFoMmf3pb/onuYs/qsG6FDEbuUvd2DnL02BFczYbh4uOkfw+qhqLVpVz4X
         etGpDTKv2Fw9vKznb06tTeaN/UaR9msSKl/Fb5bpfbxOQ/Db3q8Z3myuYSnwCy6dsLAo
         Rz+1r13xCZxwwrLH5PILDuAZEjEtM9R1aTO2WxsTgpXvbCanDdJfWRNr7drOFqR7zMtE
         Zu0TkeWPUAoauCMhrWcdvNxqTSreB+UGI8fiVjW8Je0rFQY0wkCHXzJApDkJRv7hwZJn
         ctneQC1q4A8Lod7b0KMcgXaCoQQ2yUFJcVQKwVIZZKtvCY4bZ7yl6QtqdYkUv+fkI6V5
         NUNg==
X-Forwarded-Encrypted: i=1; AFNElJ+fqSR4zKIT2eDJZSzbrD4WpwDVdun9ix4yB3gRl6Y/00uXT3/Ay+Ihicc9XF0yIjV9Afu4wJH3bWgIP/yfeWBM@vger.kernel.org
X-Gm-Message-State: AOJu0YznRqMXpOVsbEob75Rt/vXJy7OwM6FzmRNtkjJpP3LY+q2HP+SN
	L6jSDyPxU9tZeP1BXISSip9izoIIKF1U6av7hUE9ZknRLkDbK88/AMtLeVem2NlP38/cKqmvQz9
	U/ZD7jlz7xA==
X-Received: from dybgo20.prod.google.com ([2002:a05:7301:2594:b0:2f9:af7:5050])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8cab:b0:304:ab8:f87c
 with SMTP id 5a478bee46e88-3081ff7c07fmr236621eec.12.1781217935207; Thu, 11
 Jun 2026 15:45:35 -0700 (PDT)
Date: Thu, 11 Jun 2026 15:44:53 -0700
In-Reply-To: <20260611224455.201994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611171756.4008769-1-irogers@google.com> <20260611224455.201994-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611224455.201994-18-irogers@google.com>
Subject: [PATCH v13 17/19] perf python: Add config file access
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add perf.config_get(name) to expose the perf configuration system.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index fe332cb59862..70c60675db00 100644
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
@@ -3987,7 +3988,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
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

