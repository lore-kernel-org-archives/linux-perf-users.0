Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13AF272811;
	Wed, 30 Jul 2025 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753882463; cv=none; b=JmLaI96UyVQPKfCUaHK/CBhaDnN39pl9lDC7qdHRDAic7sswaTJJovBmyBgExnRefNHjnE12vecctj3UQ/kgSh21uKvmAKvNgqWXoT40dvs5M3TE4Z8NX5Jcb+EzSHgZQ4o6RuYeEmVnAQOY6hru9BIZxiMe5F5FnDWsDXO+myE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753882463; c=relaxed/simple;
	bh=RTq/HmujBTojLcJSLOhpTonp9KM6fxbaiWIe5QZA6Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ns8D/tWS7TWOXrWOIp+8Qeq4OhaauHNEcsVjoKek6jEAlA/AseXSujX7ddEqdwzxtNi7bg4D/7g3zcAvurRmnBJqP3eW8Bux+35hs+w8AEAoO8RSiAMEbntnJIdxTOHIE3vc9aO+uzLIuY5VcoEHU8UPgTP48vTn+oQ60elZkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0Svggp2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0Svggp2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93ABC4CEE7;
	Wed, 30 Jul 2025 13:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753882463;
	bh=RTq/HmujBTojLcJSLOhpTonp9KM6fxbaiWIe5QZA6Uo=;
	h=Date:From:To:Cc:Subject:From;
	b=i0Svggp2pHjd6/C8TZbWp/Wl9Ve0Jahtn/dZvjuIh88r1i3u0f6uAknJlpCE5la5a
	 XWbUO0cuaJEavOZ9KghHZSjkObHhAFRw3j4Oc0Xfx/01tX28f1fO2ADvjVEjrJQlCD
	 w77r9rSWo2n5JxrCn2ECIvPrqJamh7jFpsE1AOpYAZpL9V/ot+ms4oaGZTqfmtihBA
	 k/BLpXxL36FChWkUvdSOEvtAtk1A70x2tfDxod27/yyMzcYlW4wiQ8aEzDD4uIcKIt
	 bH0SKXms6ccpykob8FDQ7o/odIpHrLDgNyiMz/a80aub8lOJDqJzQkK02J6coad5in
	 QO/vfOyBI5oWw==
Date: Wed, 30 Jul 2025 10:34:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 v6.17] perf python: Stop using deprecated
 PyUnicode_AsString()
Message-ID: <aIofXNK8QLtLIaI3@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

As noticed while building for Fedora 43:

    GEN     /tmp/build/perf/python/perf.cpython-314-x86_64-linux-gnu.so
  /git/perf-6.16.0-rc3/tools/perf/util/python.c: In function ‘get_tracepoint_field’:
  /git/perf-6.16.0-rc3/tools/perf/util/python.c:340:9: error: ‘_PyUnicode_AsString’ is deprecated [-Werror=deprecated-declarations]
    340 |         const char *str = _PyUnicode_AsString(PyObject_Str(attr_name));
        |         ^~~~~
  In file included from /usr/include/python3.14/unicodeobject.h:1022,
                   from /usr/include/python3.14/Python.h:89,
                   from /git/perf-6.16.0-rc3/tools/perf/util/python.c:2:
  /usr/include/python3.14/cpython/unicodeobject.h:648:1: note: declared here
    648 | _PyUnicode_AsString(PyObject *unicode)
        | ^~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors
  error: command '/usr/bin/gcc' failed with exit code 1

Use PyUnicode_AsUTF8() instead and also check if PyObject_Str() fails
before doing so.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 2f28f71325a87a2d..ea77bea0306fa08d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -337,7 +337,6 @@ tracepoint_field(const struct pyrf_event *pe, struct tep_format_field *field)
 static PyObject*
 get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
 {
-	const char *str = _PyUnicode_AsString(PyObject_Str(attr_name));
 	struct evsel *evsel = pevent->evsel;
 	struct tep_event *tp_format = evsel__tp_format(evsel);
 	struct tep_format_field *field;
@@ -345,7 +344,18 @@ get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
 	if (IS_ERR_OR_NULL(tp_format))
 		return NULL;
 
+	PyObject *obj = PyObject_Str(attr_name);
+	if (obj == NULL)
+		return NULL;
+
+	const char *str = PyUnicode_AsUTF8(obj);
+	if (str == NULL) {
+		Py_DECREF(obj);
+		return NULL;
+	}
+
 	field = tep_find_any_field(tp_format, str);
+	Py_DECREF(obj);
 	return field ? tracepoint_field(pevent, field) : NULL;
 }
 #endif /* HAVE_LIBTRACEEVENT */
-- 
2.50.1

