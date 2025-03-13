Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025CE260372;
	Thu, 13 Mar 2025 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852331; cv=none; b=q4kv8pjYVHXVGNY9oYbasI+3fPJF+5O/ndsw9XOpWGMB4Y41Wk8PYT4ai704t+126mJ+gu4J0Wf432vpYfEjpTnjZ6TkJ+R+qD0McMpqW1BfQN3cyQIReu4vGctJ37COMcY4aaM95aBAT0Wv+lWw9SDyGb6P/MrQpeSDBeX+6/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852331; c=relaxed/simple;
	bh=ofKZ9kQApiZqP/L+tkA0TgjZohU6q1uyaOBqKodqXJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzAmUJomuAV2gBrHSPvT+bYBqkPPS2XK4+X17SDjjhmK2scbPYCauu5Ey71+CJXc5yE47d97b+z/Y81DAZ/Fj5OVlLKRUHaFlY7eeNoDBrStyG+j/dv5Xp7v5hwSavC1hlfy4ZSZ4UdGEICPp9YTf31wVOA7rW0R/H7ZnitS7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MbYs+XDL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MbYs+XDL"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CMkZGG023136;
	Thu, 13 Mar 2025 07:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cvzn5kePyIZiAGRtI
	VSzmJl+PnzSxTLse4RU+RSkZpk=; b=MbYs+XDLGE3XW/8gw7HwHtmbhzst6Ki7c
	giIOpXEYOPB1Bj/5IFP02DJhGSBkwUOM/CEmznXySFDXxO7Cl2jRPvzEVSfMUq6A
	10HHgn54RMAiwny5EsEWR8HucJVqLemarYkg8gNdgk5taukaekXpRLuSKHHIVn4l
	BVLGT67eHfk/sJ6cD6KmrMPal9POfG5nuSEUms9iypWWWUTt8DU4kw4ZhTqJHuBm
	+DimyxMdv2fjL8pDQgja+hyOne5B0CA2gELpVOm8vtNg13B+j5SouEpWWnr+09Sf
	8KOdy+y/0yctARmKE7DNHE0ex8HmclpW95O55YYACAFGatRk8Vipg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bbppvcju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 07:51:59 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52D7pwU6004301;
	Thu, 13 Mar 2025 07:51:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bbppvcjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 07:51:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52D4QrNj012255;
	Thu, 13 Mar 2025 07:51:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsrgjs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 07:51:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52D7prTP41877948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 07:51:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12D2920043;
	Thu, 13 Mar 2025 07:51:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79D0C20040;
	Thu, 13 Mar 2025 07:51:50 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.in.ibm.com (unknown [9.204.206.66])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Mar 2025 07:51:50 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [RFC PATCH 2/3] libperf: Introduce a C extension module for python
Date: Thu, 13 Mar 2025 13:21:23 +0530
Message-ID: <20250313075126.547881-3-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250313075126.547881-1-gautam@linux.ibm.com>
References: <20250313075126.547881-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: L3FhwI1KdtmemB2dxDpp1E2k0uZYj-Kt
X-Proofpoint-GUID: K4OTOpxPu2XKKY_GLb3J3m8Ubhm800P2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130058

Create a C extension module for libperf that will be used by python to
call the libperf functions.

Co-developed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 tools/lib/perf/Build       |   1 +
 tools/lib/perf/Makefile    |  12 +-
 tools/lib/perf/libperf.map |   1 +
 tools/lib/perf/py_perf.c   | 261 +++++++++++++++++++++++++++++++++++++
 4 files changed, 273 insertions(+), 2 deletions(-)
 create mode 100644 tools/lib/perf/py_perf.c

diff --git a/tools/lib/perf/Build b/tools/lib/perf/Build
index e8f5b7fb9973..4869da30ffb5 100644
--- a/tools/lib/perf/Build
+++ b/tools/lib/perf/Build
@@ -7,6 +7,7 @@ libperf-y += mmap.o
 libperf-y += zalloc.o
 libperf-y += xyarray.o
 libperf-y += lib.o
+libperf-y += py_perf.o
 
 $(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
 	$(call rule_mkdir)
diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index e9a7ac2c062e..8e16492af882 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -48,20 +48,28 @@ else
   CFLAGS := -g -Wall
 endif
 
+# Check Python.h path
+ifeq (,$(shell which python-config))
+	$(error "Consider installing python-dev or python-devel")
+endif
+
+PYTHON_INCLUDE = $(shell python-config --includes)
+
 INCLUDES = \
 -I$(srctree)/tools/lib/perf/include \
 -I$(srctree)/tools/lib/ \
 -I$(srctree)/tools/include \
 -I$(srctree)/tools/arch/$(SRCARCH)/include/ \
 -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi \
--I$(srctree)/tools/include/uapi
+-I$(srctree)/tools/include/uapi \
+-I$(PYTHON_INCLUDE)
 
 # Append required CFLAGS
 override CFLAGS += $(EXTRA_WARNINGS)
 override CFLAGS += -Werror -Wall
 override CFLAGS += -fPIC
 override CFLAGS += $(INCLUDES)
-override CFLAGS += -fvisibility=hidden
+override CFLAGS += -fvisibility=hidden -Wno-redundant-decls
 
 all:
 
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index fdd8304fe9d0..0488c0591404 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -57,6 +57,7 @@ LIBPERF_0.0.1 {
 		perf_mmap__read_done;
 		perf_mmap__read_event;
 		perf_counts_values__scale;
+		PyInit_libperf;
 	local:
 		*;
 };
diff --git a/tools/lib/perf/py_perf.c b/tools/lib/perf/py_perf.c
new file mode 100644
index 000000000000..cf0fcb8cc6c1
--- /dev/null
+++ b/tools/lib/perf/py_perf.c
@@ -0,0 +1,261 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include "include/perf/py_perf.h"
+#include <stdlib.h>
+#include <perf/threadmap.h>
+#include <perf/py_perf.h>
+#include <errno.h>
+#include <internal/threadmap.h>
+
+static PyObject *program_perf_thread_map__new_dummy(PyObject *self, PyObject *args)
+{
+	py_perf_thread_map *pythread_map = PyObject_New(py_perf_thread_map, &py_perf_thread_map_type);
+
+	pythread_map->thread_map = perf_thread_map__new_dummy();
+	if (!pythread_map->thread_map) {
+		Py_DECREF(pythread_map);
+		return Py_None;
+	}
+
+	return Py_BuildValue("O", pythread_map);
+}
+
+static PyObject *program_perf_thread_map__set_pid(PyObject *self, PyObject *args)
+{
+	py_perf_thread_map *pythread_map = NULL;
+	int idx, pid;
+
+	if (!PyArg_ParseTuple(args, "Oii", &pythread_map, &idx, &pid)) {
+		return NULL;
+	}
+
+	perf_thread_map__set_pid(pythread_map->thread_map, idx, pid);
+
+	return Py_None;
+}
+
+static PyObject *program_perf_evlist__new(PyObject *self, PyObject *args)
+{
+	py_perf_evlist *pyperf_evlist = PyObject_New(py_perf_evlist, &py_perf_evlist_type);
+
+	pyperf_evlist->evlist = perf_evlist__new();
+	if (!pyperf_evlist->evlist) {
+		Py_DECREF(pyperf_evlist);
+		return Py_None;
+	}
+
+	return Py_BuildValue("O", pyperf_evlist);
+}
+
+static PyObject *program_perf_evsel__new(PyObject *self, PyObject *args)
+{
+	struct perf_event_attr *attr;
+	PyObject *py_attr;
+	py_perf_evsel *pyperf_evsel = PyObject_New(py_perf_evsel, &py_perf_evsel_type);
+
+	if (!PyArg_ParseTuple(args, "O", &py_attr)) {
+		return NULL;
+	}
+
+	attr = (py_attr == Py_None)? NULL: ((py_perf_event_attr *)py_attr)->attr;
+	pyperf_evsel->evsel = perf_evsel__new(attr);
+	if (!pyperf_evsel->evsel) {
+		Py_DECREF(pyperf_evsel);
+		return Py_None;
+	}
+
+	return Py_BuildValue("O", pyperf_evsel);
+}
+
+static PyObject *program_perf_evlist__add(PyObject *self, PyObject *args)
+{
+	struct perf_evsel *evsel;
+	struct perf_evlist *evlist;
+	PyObject *pyevlist, *pyevsel;
+
+	if (!PyArg_ParseTuple(args, "OO", &pyevlist, &pyevsel)) {
+		return NULL;
+	}
+
+	evsel = (pyevsel == Py_None)? NULL: ((py_perf_evsel *)pyevsel)->evsel;
+	evlist = (pyevlist == Py_None)? NULL: ((py_perf_evlist *)pyevlist)->evlist;
+	perf_evlist__add(evlist, evsel);
+
+	return Py_None;
+}
+
+static PyObject *program_perf_evlist__set_maps(PyObject *self, PyObject *args)
+{
+	struct perf_thread_map *thread_map;
+	struct perf_evlist *evlist;
+	struct perf_cpu_map *cpu_map;
+	PyObject *pyevlist, *pythread_map, *pycpu_map;
+
+	if (!PyArg_ParseTuple(args, "OOO", &pyevlist, &pycpu_map, &pythread_map)) {
+		return NULL;
+	}
+
+	evlist = (pyevlist == Py_None)? NULL: ((py_perf_evlist *)pyevlist)->evlist;
+	cpu_map = (pycpu_map == Py_None)? NULL: ((py_perf_cpu_map *)pycpu_map)->map;
+	thread_map = (pythread_map == Py_None)? NULL: ((py_perf_thread_map *)pythread_map)->thread_map;
+	perf_evlist__set_maps(evlist, cpu_map, thread_map);
+
+	return Py_None;
+}
+
+static PyObject *program_perf_evlist__open(PyObject *self, PyObject *args)
+{
+	struct perf_evlist *evlist;
+	PyObject *pyevlist;
+
+	if (!PyArg_ParseTuple(args, "O", &pyevlist)) {
+		return NULL;
+	}
+	evlist = (pyevlist == Py_None)? NULL: ((py_perf_evlist *)pyevlist)->evlist;
+
+	return Py_BuildValue("i", perf_evlist__open(evlist));
+}
+
+static PyObject *program_perf_evlist__enable(PyObject *self, PyObject *args)
+{
+	struct perf_evlist *evlist;
+	PyObject *pyevlist;
+
+	if (!PyArg_ParseTuple(args, "O", &pyevlist)) {
+		return NULL;
+	}
+
+	evlist = (pyevlist == Py_None)? NULL: ((py_perf_evlist *)pyevlist)->evlist;
+	perf_evlist__enable(evlist);
+
+	return Py_None;
+}
+
+static PyObject *program_perf_evlist__disable(PyObject *self, PyObject *args)
+{
+	struct perf_evlist *evlist;
+	PyObject *pyevlist;
+
+	if (!PyArg_ParseTuple(args, "O", &pyevlist)) {
+		return NULL;
+	}
+	evlist = (pyevlist == Py_None)? NULL: ((py_perf_evlist *)pyevlist)->evlist;
+	perf_evlist__disable(evlist);
+
+	return Py_None;
+}
+
+static PyObject *program_perf_evsel__read(PyObject *self, PyObject *args)
+{
+	PyObject *pyevsel, *pyperf_counts_values;
+	struct perf_evsel *evsel;
+	struct perf_counts_values *values;
+	int cpu_map_idx, thread;
+
+	if (!PyArg_ParseTuple(args, "OiiO", &pyevsel, &cpu_map_idx, &thread, &pyperf_counts_values)) {
+		return NULL;
+	}
+	evsel = (pyevsel == Py_None)? NULL: ((py_perf_evsel *)pyevsel)->evsel;
+	values = (pyevsel == Py_None)? NULL: ((py_perf_counts_values *)pyperf_counts_values)->values;
+
+	return Py_BuildValue("i", perf_evsel__read(evsel, cpu_map_idx, thread, values));
+}
+
+static PyObject *program_perf_evlist__close(PyObject *self, PyObject *args)
+{
+	struct perf_evlist *evlist;
+	PyObject *pyevlist;
+
+	if (!PyArg_ParseTuple(args, "O", &pyevlist)) {
+		return NULL;
+	}
+	evlist = (pyevlist == Py_None)? NULL: ((py_perf_evlist *)pyevlist)->evlist;
+	perf_evlist__close(evlist);
+
+	return Py_None;
+}
+
+static PyObject *program_perf_evlist__delete(PyObject *self, PyObject *args)
+{
+	struct perf_evlist *evlist;
+	PyObject *pyevlist;
+
+	if (!PyArg_ParseTuple(args, "O", &pyevlist)) {
+		return NULL;
+	}
+	evlist = (pyevlist == Py_None)? NULL: ((py_perf_evlist *)pyevlist)->evlist;
+	perf_evlist__delete(evlist);
+
+	return Py_None;
+}
+
+static PyObject *program_perf_thread_map__put(PyObject *self, PyObject *args)
+{
+	struct perf_thread_map *map;
+	PyObject *pyperf_thread_map;
+
+	if (!PyArg_ParseTuple(args, "O", &pyperf_thread_map)) {
+		return NULL;
+	}
+	map = (pyperf_thread_map == Py_None)? NULL: ((py_perf_thread_map *)pyperf_thread_map)->thread_map;
+	perf_thread_map__put(map);
+
+	return Py_None;
+}
+
+static int libperf_print(enum libperf_print_level level,
+			  const char *fmt, va_list ap)
+{
+	return vfprintf(stderr, fmt, ap);
+}
+
+static PyObject *program_libperf_init(PyObject *self, PyObject *args)
+{
+       libperf_init(libperf_print);
+       return Py_None;
+}
+
+PyMethodDef libperf_methods[] = {
+	{"perf_thread_map__new_dummy", program_perf_thread_map__new_dummy, METH_VARARGS, "Create a dummy thread map function variable"},
+	{"perf_thread_map__set_pid", program_perf_thread_map__set_pid, METH_VARARGS, "Set PID for a thread map"},
+	{"perf_evlist__new", program_perf_evlist__new, METH_VARARGS, "Create a perf evlist"},
+	{"perf_evsel__new", program_perf_evsel__new, METH_VARARGS, "Create a perf evsel"},
+	{"perf_evlist__add", program_perf_evlist__add, METH_VARARGS, "Add evsel to evlist"},
+	{"perf_evlist__set_maps", program_perf_evlist__set_maps, METH_VARARGS, "perf_evlist__set_maps"},
+	{"perf_evlist__open", program_perf_evlist__open, METH_VARARGS, "perf_evlist__set_maps"},
+	{"perf_evlist__enable", program_perf_evlist__enable, METH_VARARGS, "perf_evlist__enable"},
+	{"perf_evlist__disable", program_perf_evlist__disable, METH_VARARGS, "perf_evlist__disable"},
+	{"perf_evsel__read", program_perf_evsel__read, METH_VARARGS, "perf_evsel__read"},
+	{"perf_evlist__close", program_perf_evlist__close, METH_VARARGS, "perf_evlist__close"},
+	{"perf_evlist__delete", program_perf_evlist__delete, METH_VARARGS, "perf_evlist__delete"},
+	{"perf_thread_map__put", program_perf_thread_map__put, METH_VARARGS, "perf_thread_map__put"},
+	{"libperf_init", program_libperf_init, METH_VARARGS, "libperf init"},
+	{NULL, NULL, 0, NULL}
+};
+
+struct PyModuleDef libperf = {
+	PyModuleDef_HEAD_INIT,
+	"libperf",
+	"Extension module to expose libperf to python",
+	-1,
+	libperf_methods
+};
+
+PyMODINIT_FUNC PyInit_libperf(void) {
+	PyObject *m = PyModule_Create(&libperf);
+
+	if (!m)
+		return NULL;
+
+	python_push_type("py_perf_thread_map", m, &py_perf_thread_map_type);
+	python_push_type("py_perf_evlist", m, &py_perf_evlist_type);
+	python_push_type("evlist_iterator", m, &py_perf_evlist_iterator_type);
+	python_push_type("py_perf_evsel", m, &py_perf_evsel_type);
+	python_push_type("py_perf_cpu_map", m, &py_perf_cpu_map_type);
+	python_push_type("py_perf_event_attr", m, &py_perf_event_attr_type);
+	python_push_type("py_perf_counts_values", m, &py_perf_counts_values_type);
+
+	PyModule_AddObject(m, "perf_event_attr", (PyObject *) & py_perf_event_attr_type);
+	PyModule_AddObject(m, "perf_counts_values", (PyObject *) & py_perf_counts_values_type);
+
+	return m;
+}
-- 
2.47.0

