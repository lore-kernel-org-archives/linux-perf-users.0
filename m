Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7590B2DEA98
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643209; cv=none; b=HHbYfAweH6UOpfMfJWzzeYW+6GiKfHe+5cKgCzTJVFqqOMx2Ro43/xi1TYsY2DqEv0kUllli3ugNK7w8PZoYp6fFMSi2lkjVQBNOBra1dS7WSmO/iIBTadD5Gp74ITHiW+jzu416UgDNJ3a57XSN8SF2HbHYE0YPLWGyhNCROQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643209; c=relaxed/simple;
	bh=G+G8BmH84khO+Phb+GZ3kAV1vJ3tNzxPszQ26e+33yE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qysE9JrEyV6WOYjp/YEn6dkrIplWUsL/8IKKQkWQd17icPhWwtsz0wgG6e8oeOTy2X7+DDlExEXtK6HhHDRICiYHTxMMPfkg1WSFwva3plZ/2fI7D9qa1oMcYdYPibMeYB4xm3jw/hNcE4T/z0kQFLGCHHbtihrDShsE1vnQWw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9Fm2Npg; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9Fm2Npg"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c87ba0890so2027892c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643207; x=1777248007; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xS/zey2jqbwGldD1nsw9gZ+Krb57aX+FKB0kslruLtM=;
        b=h9Fm2NpgtUQ7JKw+GvtCjPot+1v61wl/P3mo+IhLdFPaLa7qn1HDqbbfjPRuB8S49W
         zMOhrZhNJFUMp85o+GsHfAXhTrPMIn2EgzYTldZ71DbS8QN1Rei4RpyMBJmDwr0CI5Ef
         FHxy5s0HdaL1ETqVJI4hgHc05XAMQ3SO0FHevpkRYPt54c8WpvgdYn46cG68jLOAwCRA
         jOJ4GfQp1kdcK/EKQuRq4r50BG+dJZT7eowNLXrlgEB6rY2CkjXk0NcSClwyVfTaV2+C
         21IRvbXL+Dp5NeNgPeXF/O5VcOvAcK2zneVtcnAKQacw265+O7dDKFDr5yRiJZ8hw/u6
         ZkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643207; x=1777248007;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xS/zey2jqbwGldD1nsw9gZ+Krb57aX+FKB0kslruLtM=;
        b=nN3+0HIax7lrfc/CHz6L3Ui7oze7hZzrLu57nZ5a5dya5fF73t/jkUeABJiE5P07xc
         ApnRc+lEjI0s8+VSlVo7+2FCVGml+9Fn73xRi+agD++0R4DoZsD2SM32+X2d4YLYq39f
         0vnqYZF0e372fckTaqYcT6Y/fdvapqAAkns+VF/AEbEcPVafs2J6g+IyjcPo218Blm99
         7vyBKfBFRG2BlcJNw/fcQ3xqXFMGeHrH8OSPSuEC2V1xxc7ovz3c4P3xkYz+aVejttM/
         /erDSl1dPw4bVZWAFWeuoBg50H29roSp/hwK29ohcGEKtQ2ANFYTihMjHKn2sZdz0pr9
         E+Pg==
X-Forwarded-Encrypted: i=1; AFNElJ847fYZHT6S9Droxyqg1ReI6eCmJWOOfCay62voRjGCOUyPgyLg8aBnAsgUBvRn46bw/r1944rhSAuHJofUrYZp@vger.kernel.org
X-Gm-Message-State: AOJu0YzcDXc/yR4lg/TIBgS1tq8he8y2/Wzpa8VIgPxCNnmLJLbmubFe
	RrkXrz3Jpj9EN5j+xWEssAbudzf6V4c4HwYwJZ93FwYxN1ESxe3/fMWRsT8Xq8JYtlXGHbSJ7IL
	xxBeW0xFHCw==
X-Received: from dlbqq7.prod.google.com ([2002:a05:7022:ed07:b0:12a:7182:6cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f509:b0:12b:ee7b:51e9
 with SMTP id a92af1059eb24-12c73f6c4b1mr2997285c88.4.1776643206278; Sun, 19
 Apr 2026 17:00:06 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:32 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-21-irogers@google.com>
Subject: [PATCH v1 20/58] perf python: Extend API for stat events in python.c
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add stat information to the session. Add call backs for stat events.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 159 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index e5f96bc695fd..1e393f354ea0 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -291,6 +291,75 @@ static PyTypeObject pyrf_lost_event__type = {
 	.tp_repr	= (reprfunc)pyrf_lost_event__repr,
 };
 
+static const char pyrf_stat_event__doc[] = PyDoc_STR("perf stat event object.");
+
+static PyMemberDef pyrf_stat_event__members[] = {
+	sample_members
+	member_def(perf_event_header, type, T_UINT, "event type"),
+	member_def(perf_record_stat, id, T_ULONGLONG, "event id"),
+	member_def(perf_record_stat, cpu, T_UINT, "event cpu"),
+	member_def(perf_record_stat, thread, T_UINT, "event thread"),
+	member_def(perf_record_stat, val, T_ULONGLONG, "counter value"),
+	member_def(perf_record_stat, ena, T_ULONGLONG, "enabled time"),
+	member_def(perf_record_stat, run, T_ULONGLONG, "running time"),
+	{ .name = NULL, },
+};
+
+static PyObject *pyrf_stat_event__repr(const struct pyrf_event *pevent)
+{
+	return PyUnicode_FromFormat(
+		"{ type: stat, id: %llu, cpu: %u, thread: %u, val: %llu, ena: %llu, run: %llu }",
+		pevent->event.stat.id,
+		pevent->event.stat.cpu,
+		pevent->event.stat.thread,
+		pevent->event.stat.val,
+		pevent->event.stat.ena,
+		pevent->event.stat.run);
+}
+
+static PyTypeObject pyrf_stat_event__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.stat_event",
+	.tp_basicsize	= sizeof(struct pyrf_event),
+	.tp_new		= PyType_GenericNew,
+	.tp_dealloc	= (destructor)pyrf_event__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= pyrf_stat_event__doc,
+	.tp_members	= pyrf_stat_event__members,
+	.tp_getset	= pyrf_event__getset,
+	.tp_repr	= (reprfunc)pyrf_stat_event__repr,
+};
+
+static const char pyrf_stat_round_event__doc[] = PyDoc_STR("perf stat round event object.");
+
+static PyMemberDef pyrf_stat_round_event__members[] = {
+	sample_members
+	member_def(perf_event_header, type, T_UINT, "event type"),
+	member_def(perf_record_stat_round, type, T_ULONGLONG, "round type"),
+	member_def(perf_record_stat_round, time, T_ULONGLONG, "round time"),
+	{ .name = NULL, },
+};
+
+static PyObject *pyrf_stat_round_event__repr(const struct pyrf_event *pevent)
+{
+	return PyUnicode_FromFormat("{ type: stat_round, type: %llu, time: %llu }",
+				   pevent->event.stat_round.type,
+				   pevent->event.stat_round.time);
+}
+
+static PyTypeObject pyrf_stat_round_event__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.stat_round_event",
+	.tp_basicsize	= sizeof(struct pyrf_event),
+	.tp_new		= PyType_GenericNew,
+	.tp_dealloc	= (destructor)pyrf_event__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= pyrf_stat_round_event__doc,
+	.tp_members	= pyrf_stat_round_event__members,
+	.tp_getset	= pyrf_event__getset,
+	.tp_repr	= (reprfunc)pyrf_stat_round_event__repr,
+};
+
 static const char pyrf_read_event__doc[] = PyDoc_STR("perf read event object.");
 
 static PyMemberDef pyrf_read_event__members[] = {
@@ -983,6 +1052,12 @@ static int pyrf_event__setup_types(void)
 	if (err < 0)
 		goto out;
 	err = PyType_Ready(&pyrf_context_switch_event__type);
+	if (err < 0)
+		goto out;
+	err = PyType_Ready(&pyrf_stat_event__type);
+	if (err < 0)
+		goto out;
+	err = PyType_Ready(&pyrf_stat_round_event__type);
 	if (err < 0)
 		goto out;
 	err = PyType_Ready(&pyrf_callchain_node__type);
@@ -1007,6 +1082,8 @@ static PyTypeObject *pyrf_event__type[] = {
 	[PERF_RECORD_SAMPLE]	 = &pyrf_sample_event__type,
 	[PERF_RECORD_SWITCH]	 = &pyrf_context_switch_event__type,
 	[PERF_RECORD_SWITCH_CPU_WIDE]  = &pyrf_context_switch_event__type,
+	[PERF_RECORD_STAT]	 = &pyrf_stat_event__type,
+	[PERF_RECORD_STAT_ROUND] = &pyrf_stat_round_event__type,
 };
 
 static PyObject *pyrf_event__new(const union perf_event *event)
@@ -1017,7 +1094,9 @@ static PyObject *pyrf_event__new(const union perf_event *event)
 	if ((event->header.type < PERF_RECORD_MMAP ||
 	     event->header.type > PERF_RECORD_SAMPLE) &&
 	    !(event->header.type == PERF_RECORD_SWITCH ||
-	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)) {
+	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE ||
+	      event->header.type == PERF_RECORD_STAT ||
+	      event->header.type == PERF_RECORD_STAT_ROUND)) {
 		PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
 			     event->header.type);
 		return NULL;
@@ -1867,7 +1946,40 @@ static PyObject *pyrf_evsel__get_attr_wakeup_events(PyObject *self, void */*clos
 	return PyLong_FromUnsignedLong(pevsel->evsel->core.attr.wakeup_events);
 }
 
+static PyObject *pyrf_evsel__get_ids(struct pyrf_evsel *pevsel, void *closure __maybe_unused)
+{
+	struct evsel *evsel = pevsel->evsel;
+	PyObject *list = PyList_New(0);
+
+	if (!list)
+		return NULL;
+
+	for (u32 i = 0; i < evsel->core.ids; i++) {
+		PyObject *id = PyLong_FromUnsignedLongLong(evsel->core.id[i]);
+		int ret;
+
+		if (!id) {
+			Py_DECREF(list);
+			return NULL;
+		}
+		ret = PyList_Append(list, id);
+		Py_DECREF(id);
+		if (ret < 0) {
+			Py_DECREF(list);
+			return NULL;
+		}
+	}
+
+	return list;
+}
+
 static PyGetSetDef pyrf_evsel__getset[] = {
+	{
+		.name = "ids",
+		.get = (getter)pyrf_evsel__get_ids,
+		.set = NULL,
+		.doc = "event IDs.",
+	},
 	{
 		.name = "tracking",
 		.get = pyrf_evsel__get_tracking,
@@ -2620,6 +2732,8 @@ static const struct perf_constant perf__constants[] = {
 	PERF_CONST(RECORD_LOST_SAMPLES),
 	PERF_CONST(RECORD_SWITCH),
 	PERF_CONST(RECORD_SWITCH_CPU_WIDE),
+	PERF_CONST(RECORD_STAT),
+	PERF_CONST(RECORD_STAT_ROUND),
 
 	PERF_CONST(RECORD_MISC_SWITCH_OUT),
 	{ .name = NULL, },
@@ -2960,6 +3074,39 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
 	return 0;
 }
 
+static int pyrf_session_tool__stat(const struct perf_tool *tool,
+				   struct perf_session *session,
+				   union perf_event *event)
+{
+	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
+	PyObject *pyevent = pyrf_event__new(event);
+	struct evsel *evsel = evlist__id2evsel(session->evlist, event->stat.id);
+	const char *name = evsel ? evsel__name(evsel) : "unknown";
+
+	if (pyevent == NULL)
+		return -ENOMEM;
+
+	PyObject_CallFunction(psession->stat, "Os", pyevent, name);
+	Py_DECREF(pyevent);
+	return 0;
+}
+
+static int pyrf_session_tool__stat_round(const struct perf_tool *tool,
+					 struct perf_session *session __maybe_unused,
+					 union perf_event *event)
+{
+	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
+	PyObject *pyevent = pyrf_event__new(event);
+
+	if (pyevent == NULL)
+		return -ENOMEM;
+
+	PyObject_CallFunction(psession->stat, "O", pyevent);
+	Py_DECREF(pyevent);
+	return 0;
+}
+
+
 static PyObject *pyrf_session__process(struct pyrf_session *psession, PyObject *args)
 {
 	struct machine *machine;
@@ -2992,9 +3139,10 @@ static int pyrf_session__init(struct pyrf_session *psession, PyObject *args, PyO
 {
 	struct pyrf_data *pdata;
 	PyObject *sample = NULL;
-	static char *kwlist[] = { "data", "sample", NULL };
+	PyObject *stat = NULL;
+	static char *kwlist[] = { "data", "sample", "stat", NULL };
 
-	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O|O", kwlist, &pdata, &sample))
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O|OO", kwlist, &pdata, &sample, &stat))
 		return -1;
 
 	Py_INCREF(pdata);
@@ -3016,8 +3164,13 @@ static int pyrf_session__init(struct pyrf_session *psession, PyObject *args, PyO
 	} while (0)
 
 	ADD_TOOL(sample);
+	ADD_TOOL(stat);
 	#undef ADD_TOOL
 
+	if (stat)
+		psession->tool.stat_round = pyrf_session_tool__stat_round;
+
+
 	psession->tool.comm		= perf_event__process_comm;
 	psession->tool.mmap		= perf_event__process_mmap;
 	psession->tool.mmap2            = perf_event__process_mmap2;
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

