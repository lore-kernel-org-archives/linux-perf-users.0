Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25781BFE15
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153965; cv=none; b=fMCbq5RdyEYTxBa50fn4AbVV9EydLw6FjXd8cPobZk5VS5mlZPdUDfVN2dsicyTivKUfiKmYFkXk/HXmdz5UUU0HYmxZRweaLsD6Hno6MpuWrd7sZuVUE4rDsCG5mWk1bdGS6pi+0NDhhhymMRu/mFAr8mSDUn5XR48Et7vUIr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153965; c=relaxed/simple;
	bh=HzVLxxNDCC58aJIsJSeqkv1E21FxH0Gn8OwOLut/Kr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IcwGOjPpAUhOk8Vd4gSWm9M/x+wvIXqIYlfWdYlnwzfWgm2Rh5LGPCScn0EL7YUmKCny0XwA4xM17/zL+ZN5MPfwc44Zj8gIDh8JixnycLlwn++IjP+Kd3Bu3S3NXuO0EjghaMv0Z1MeaiYP0r+PdAVqk69zy3O36A2CI8trWwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ltLCRag6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltLCRag6"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cd46f3ac9so10167025e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726153962; x=1726758762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGGfB6w3kWS1PGl7UZ8XD03PjQ67uo73eIy0DvIbGgM=;
        b=ltLCRag65QQgrxT0EZksyH6zpTHcQSouOON6PbB2rm3gPI0eUGordxuJoLyzLadJSL
         /PnI3zbnNzZ7OGGb3AVSC13EPnSWJHcugXSg6wH96gunJZ05LBm7fBOdrdMDTm5oa9ED
         34Z0GXK/WB1VQEJKaG5ESY9z+CMu6X2CjMTVBo48FLe2eKXdx96A0wYfHQ/UXyI4lVxf
         V78e5MrJKjCTe3YNzWVK/zhSku1Nv6FKfH48ytj00pg+yKwiwRTqx+FNKvAK5jLGCNvy
         3ViQhxE2horxwnMNWMyAa+BK6znBILNlfuj4b2bSjEA5wpfZOs0Nj4Wz62i3hqKYQ5F0
         1gWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153962; x=1726758762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGGfB6w3kWS1PGl7UZ8XD03PjQ67uo73eIy0DvIbGgM=;
        b=ApVuwHo3wTAWK+F/U9f1I7W7QpT9KOMVl/0OLVuG6vVq/q0/d+MFBOxJNADI6iIyCN
         OevYziE9CVUMbNY7jV/t2B4xdPxlX7+CYnosqpWI+xR9+ajQ0apEy5wk9dNYyXBBJXjq
         YYg0zDZbZrO/xS2OGEmv3cYkQJsgH6sVRnd9DTvJuC3hCkkeQYqPSgwnrIa51TjrON59
         zglQpmDtMRcGvdAqHPVxxxQMb0TOfGvLNHO9j4EmPLZcQPCIMrd9oet++Nc70qzNqn1t
         +O4hQ2e6ua2edJ9NTWXSh5mM0EoKBYth49Wa/75n8AoKRdKYQpxhBEuKIL9OibfHy2Lp
         eHzw==
X-Gm-Message-State: AOJu0YwiTUiU6MZoH/0bEMUiF6texzNNRAY0/Oqc20Giuw6CwRUTSu9i
	GIE/rtUYVTDcqUnKTTWVaGyMivUK6RlzUfY9YHTGCo5oIhYBbXsKAcpjIVxvdXt3RbKWV59nRps
	1ajuafA==
X-Google-Smtp-Source: AGHT+IHHXQ3L4ph9W3/LKP4w6PXlKUgz1FmPRZxqdPxBCXFwutCTMRNnHYk9J1u/W+htrP1UYDcjqA==
X-Received: by 2002:a05:600c:35c1:b0:42c:bfb1:766e with SMTP id 5b1f17b1804b1-42cdb55006fmr26068025e9.21.1726153962042;
        Thu, 12 Sep 2024 08:12:42 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb0dbcb6bsm171928845e9.30.2024.09.12.08.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:12:41 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	gankulkarni@os.amperecomputing.com,
	coresight@lists.linaro.org,
	leo.yan@arm.com,
	scclevenger@os.amperecomputing.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	Ben Gainey <ben.gainey@arm.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/7] perf scripting python: Add function to get a config value
Date: Thu, 12 Sep 2024 16:11:34 +0100
Message-Id: <20240912151143.1264483-4-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912151143.1264483-1-james.clark@linaro.org>
References: <20240912151143.1264483-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This can be used to get config values like which objdump Perf uses for
disassembly.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../perf/Documentation/perf-script-python.txt |  2 +-
 .../scripts/python/Perf-Trace-Util/Context.c  | 11 ++++++++++
 tools/perf/util/config.c                      | 22 +++++++++++++++++++
 tools/perf/util/config.h                      |  1 +
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
index 13e37e9385ee..27a1cac6fe76 100644
--- a/tools/perf/Documentation/perf-script-python.txt
+++ b/tools/perf/Documentation/perf-script-python.txt
@@ -624,7 +624,7 @@ as perf_trace_context.perf_script_context .
  perf_set_itrace_options(context, itrace_options) - set --itrace options if they have not been set already
  perf_sample_srcline(context) - returns source_file_name, line_number
  perf_sample_srccode(context) - returns source_file_name, line_number, source_line
-
+ perf_config_get(config_name) - returns the value of the named config item, or None if unset
 
 Util.py Module
 ~~~~~~~~~~~~~~
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 3954bd1587ce..01f54d6724a5 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -12,6 +12,7 @@
 #define PY_SSIZE_T_CLEAN
 
 #include <Python.h>
+#include "../../../util/config.h"
 #include "../../../util/trace-event.h"
 #include "../../../util/event.h"
 #include "../../../util/symbol.h"
@@ -182,6 +183,15 @@ static PyObject *perf_sample_srccode(PyObject *obj, PyObject *args)
 	return perf_sample_src(obj, args, true);
 }
 
+static PyObject *__perf_config_get(PyObject *obj, PyObject *args)
+{
+	const char *config_name;
+
+	if (!PyArg_ParseTuple(args, "s", &config_name))
+		return NULL;
+	return Py_BuildValue("s", perf_config_get(config_name));
+}
+
 static PyMethodDef ContextMethods[] = {
 #ifdef HAVE_LIBTRACEEVENT
 	{ "common_pc", perf_trace_context_common_pc, METH_VARARGS,
@@ -199,6 +209,7 @@ static PyMethodDef ContextMethods[] = {
 	  METH_VARARGS,	"Get source file name and line number."},
 	{ "perf_sample_srccode", perf_sample_srccode,
 	  METH_VARARGS,	"Get source file name, line number and line."},
+	{ "perf_config_get", __perf_config_get, METH_VARARGS, "Get perf config entry"},
 	{ NULL, NULL, 0, NULL}
 };
 
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 7a650de0db83..68f9407ca74b 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -912,6 +912,7 @@ void set_buildid_dir(const char *dir)
 struct perf_config_scan_data {
 	const char *name;
 	const char *fmt;
+	const char *value;
 	va_list args;
 	int ret;
 };
@@ -939,3 +940,24 @@ int perf_config_scan(const char *name, const char *fmt, ...)
 
 	return d.ret;
 }
+
+static int perf_config_get_cb(const char *var, const char *value, void *data)
+{
+	struct perf_config_scan_data *d = data;
+
+	if (!strcmp(var, d->name))
+		d->value = value;
+
+	return 0;
+}
+
+const char *perf_config_get(const char *name)
+{
+	struct perf_config_scan_data d = {
+		.name = name,
+		.value = NULL,
+	};
+
+	perf_config(perf_config_get_cb, &d);
+	return d.value;
+}
diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
index 2e5e808928a5..9971313d61c1 100644
--- a/tools/perf/util/config.h
+++ b/tools/perf/util/config.h
@@ -30,6 +30,7 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
 int perf_default_config(const char *, const char *, void *);
 int perf_config(config_fn_t fn, void *);
 int perf_config_scan(const char *name, const char *fmt, ...) __scanf(2, 3);
+const char *perf_config_get(const char *name);
 int perf_config_set(struct perf_config_set *set,
 		    config_fn_t fn, void *data);
 int perf_config_int(int *dest, const char *, const char *);
-- 
2.34.1

