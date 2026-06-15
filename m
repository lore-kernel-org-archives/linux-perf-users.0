Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28483B42ED
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 06:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504231; cv=none; b=iTIK3kG6IMVquAk35pUnvMTdL7mM0FV/uLTdjY4QjJdK44cDVZqFmCx0tjS5HF3pIWyKb205OkyP75mqqqzjhxJqTKxLnkUW3EgX+R99WzCPx6CZPXLkpRIfPJuUh32TbmvkW6dc4OeOMofIRnGmm104WmydTR/N9i3vjuFETHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504231; c=relaxed/simple;
	bh=+kArYm+PyddyuOuiwzAv+Df/IciTN+QUSyH+40Mm5e8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N+EHLyevNOv5YOBVBVSqvugkP8btjEHcjkxnnTGE3kBpe+RP3sfSQF9c/3/RdN2QQcICYMyKx6Ut5hGvX1vRaoC7388RbFgjWUBhNtsfcOXPtOrOZnEGYQBXGuJfLHXXMAn7spbC16SKzhAKtEnXto7357+Dw/a9VqFVHsvLGZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PaOLBiKa; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PaOLBiKa"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1384427c3efso10238190c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Jun 2026 23:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781504229; x=1782109029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFmvWkkGaC/UhMYsb9kvVBBU8wa/WhdEif7SwlvhvB4=;
        b=PaOLBiKalnBJnfF+qlhvDUwHRI179xH76Eumg7eGgkIAkNnpoXBtwpUTFcqor4WTCD
         W8zpujr2GpvlvGg4jNgBQTdluV7IolhzE/iXkKyZ216YF8uaeQDB1/16bwQVWwU7an8T
         58KSQaiG8kgdJFsuSsVRbgAmZzVetf2QVRYa5hIBUYeK+ldZ1ujreBBlzw9s5+Co9DvV
         0yZ1KpJgpTTgpxfDxq23Gepfpogz7RVzWdv9NNpZvReEO0WJbuCabjvkQyhvt15mEtoX
         xi2669bwqfM7mS1yp1yXTVKtcKQw+ez4iS0eZ8MOciC6+c7emwSY/ZHufqAVw1gla6a4
         o6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781504229; x=1782109029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFmvWkkGaC/UhMYsb9kvVBBU8wa/WhdEif7SwlvhvB4=;
        b=AuDFfNYuaJiiD2SyBM4JRup6e1cnGV5uMgyLIEcpN66rXmrLwXoDlLpoZRBGl/EN1P
         R5opG+3F8BMNbNU9WYdWFRtR45Q5AZauKVBT5AwGImyYwExHgD+MJy5h+iF5+eXCNHDn
         7Xoegs5CFJte1xXRq30JE4JdO3uwo6ps+tZvIyg0c+B3Pcb9lCxLoWyBxX89VzUp+Yke
         nNBy2w+Z5Pr1jTzPvYOzQmruEx6oLAtXNr514wDH068TcWS0xkfJMZN4B0LY8X7uyJfr
         ToLpfRpU3WbXijVkEHsy93N42e2IZ9OvOpASc4NtbIEFEJHHup2RKC5fCwoDyolgQT4I
         gAvQ==
X-Forwarded-Encrypted: i=1; AFNElJ88aAKNjsWqbNfjYbM2uIB01j1BCvYh/PV9nyiz07BXrxWdeXG6JPslt7kGwudQIUhhhOa5fIMIllb3MVpQh5GG@vger.kernel.org
X-Gm-Message-State: AOJu0YxBGge3URJ6uVWi3MRl6EeYjOd4KQ/wux0lR3xLOQVpkJAeasXE
	NC3Sxa6qMOKIutG6pNRx1cJN0br6LHprd+HZh6DZkcQvGOM//OQyKEeU2XjykpneJQ+61ZEfR7L
	9b5W5CGyexQ==
X-Received: from dybmk48.prod.google.com ([2002:a05:7301:eb0:b0:304:eb73:cff1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:313:b0:12a:6fb7:87e3
 with SMTP id a92af1059eb24-1384bbc999amr6181807c88.31.1781504228833; Sun, 14
 Jun 2026 23:17:08 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:16:27 -0700
In-Reply-To: <20260615061631.2382079-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615002812.2234795-1-irogers@google.com> <20260615061631.2382079-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615061631.2382079-18-irogers@google.com>
Subject: [PATCH v19 17/20] perf python: Add config file access
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
index f1230bd222d7..38a41bd6c9b5 100644
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
@@ -3990,7 +3991,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
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

