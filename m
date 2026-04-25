Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60129391E78
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156932; cv=none; b=USC7XsPBtBnmaH7M4CuMZ2G4wS0cVfv6XZ5NCvb02b/SNce+1vgYhobtZtF6kMFgBjti6f9930AF3G1Dh9z9x7Y052szADheZ1dvzZthXl75d2cSpkcrTPryk6Ja60s3yZJePBkVHbXCLBDMF+4zbzD54KGTa66i+uyQQncfGSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156932; c=relaxed/simple;
	bh=PiF/VN47oVtkaq0UVg1dETvbcKU6+L/0hmPAremZV2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P5kYT2n1PYR0pqMtovpQBqn9QN4346NKAX+sPgtyI+zRLX06+X0HFCgpyJPnfOyVKOtA7Ek0ZCrxXWyj+zNS2gS8KSFgy6rW2fBvOkvDvjdQC8k3T/5BV3B9a5JTg0GXWMMF6DX9w3O8aNHTRww/9pERZAWWwdMZe0M8GZlvvWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZ0Md5aU; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZ0Md5aU"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso11622125eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156930; x=1777761730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qNJyUA9ryt9seTGqwkY6UAT2Vxtn3jg366bqqeB58s=;
        b=TZ0Md5aUspAXqj+6S0QVibuOvZeab2DzIVqzWbiwTOJ8yHodZ00hX97R7iOJrihdYE
         hoewv+RvXQ8pOstpTK6gxfECueytBx6JWpmUKoGlFo1wq7R5q3Qu/99/uFyLgO8r5AG9
         sSKr4KCJ3dKbro/7X8F9RaJUorXepbdl+el+uzoAClFxOQ5Y9xC5aDFwX3y8xYzflK5M
         boPe3kWV7f2x0rJMJcUuZmLFa+fuX+n1kNDGWfDdmkU/nyb5FBNFiOnkQX2aRFxq1GO/
         aCz62HH9AXMIPG8cYAZPp5fBxjh2ITIYYFV40nVmfRtL0k95pJIl0m24xg6+zX8Tsrhz
         Ah0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156930; x=1777761730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qNJyUA9ryt9seTGqwkY6UAT2Vxtn3jg366bqqeB58s=;
        b=b3ZzZyCYZuJflGGMVcKogmHTEF6CPwD9QeexPMdXPc4W2ehWmLymOyIcM7XfHOtNDw
         OAnzwBfZT7GIZe1cuW/vLGDb4o2LKIXnLeQvjNW1y8AeDwlkaP1KHUwhBp1tvgBpRW/w
         gTJXbw6cDcdqHUfrFrxG2j0glbs4wRcdaHy4ykscgx73qnN7x/mEKEE5NvQ0gms1Hke0
         DD8oLdeJQozvclsHhp/LGR9WOwFt+sHleP9SeVWZjaHLXX3HtjMhFknGKma9kROc8kCq
         OYOIXKypeP4IUodu6qR/4JxhGzhsfx64USZ3LOuKRa+jynbXAylD4oF5QePK8tpPPxhs
         8+qg==
X-Forwarded-Encrypted: i=1; AFNElJ9LuRe+CVsv9jucpSAdSkWV/QoxsBgNsNeGtTZmCK8+jSZCSj504RNwtsIoqh5jqKR2RnVoR72+l1IQaG52k/tX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5TcMzcV/KKfFjAehPtyxTO8rKcyolKTy0Dv22+7XjHatIQrri
	GMjnYPHUHYdYYVFTNeBI8+OkaeD39Bq8yNSfuFlobwDvycShXu2QqY/20SYs3Dcny4X5aPafJRS
	rG/bS753Lpg==
X-Received: from dybfx10.prod.google.com ([2002:a05:7300:c38a:b0:2de:831d:2756])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc93:b0:2da:45f8:1b41
 with SMTP id 5a478bee46e88-2e478c1f80fmr17612030eec.19.1777156930309; Sat, 25
 Apr 2026 15:42:10 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:44 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-20-irogers@google.com>
Subject: [PATCH v7 19/59] perf python: Add config file access
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add perf.config_get(name) to expose the perf configuration system.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 2953c4c8e142..5478561ca62c 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -12,6 +12,7 @@
 #include "build-id.h"
 #include "callchain.h"
 #include "comm.h"
+#include "config.h"
 #include "counts.h"
 #include "data.h"
 #include "debug.h"
@@ -3296,7 +3297,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
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
2.54.0.545.g6539524ca2-goog

