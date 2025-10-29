Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A6307AC4
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 05:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716086; cv=none; b=JVxNhc91LGAqiJgqUgLTL1hh1ttZA9+g8QLM3pArY0EfWb6pRTJQA8adNDLSdmm0ElLaTLIcY+3Otz5TSxkWpOIR4hZoS4si4JpHgDMTqAyNDJ3+r151mHHk0qz//Mj5Lbwvb2BEMylv3///DPvXusuhOfO+YoUk3WlGqrf4JHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716086; c=relaxed/simple;
	bh=dJp7d9Mo/YI8Mc8WeyxTFkIzH06kCcUy8iih/vjPQs4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZJYEX0z+IG3l7SiGcRT8lizZMCI36Y86aZ4JEKtUu0FW9V7nxzk+I10LTqJ5ZSm+wLfOzhpOT+m/Fj9YmbG9cr+5KMbnbD2ncDz3mD5rtJgKjfjWiYVSuTV75G+VdLUoFqi44tg+EKyybJrQKlJk1nsFK1LCxwzTP+pO2BKRJFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fOvB6Jb5; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOvB6Jb5"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-290d860acbcso143599185ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 22:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716084; x=1762320884; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zqi6Ry5NSVNk8CjQYGSWrFXfHqr50wrE9agsn8Mgayg=;
        b=fOvB6Jb5K9Oj29yWtOu9xkKtbPpfAJr8gNSlvHCeiTEwj/mwsGf/pzMSF9cnvUqLNJ
         sV6W+t29qADdkCOEEwS7EIMldKqCjkm59d3NDMiKw9fJcUoh1V7hB87u0omn1HwVzedh
         0OWI/6UfT/VTmLnZCf6C7XOB1JxN60xKj5Pl/DvZKqW0a7wMxRDhJCbIoJHCXIjviG2K
         xjI7RROfZY9fktCrJI2logqrr1FFUcMvMGL6LAOS/37A1CAf5gU/gAFQtH9PSTgDovJ+
         4NKJ+ruBjpZWbR1Bii0+NUzCN+9mh+XeA1uah8lT604V34RZNBwJ6PekcEvJoLc1dIy5
         3lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716084; x=1762320884;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zqi6Ry5NSVNk8CjQYGSWrFXfHqr50wrE9agsn8Mgayg=;
        b=vlGqJJ5Wd8294nHCY7Va8Qbr1UAEF1CUwnCt2xkHbzeuiec2fbgAAXi5AgvkXb3qos
         Kt8dsb00NAX4CePP/nuJoN4DZYTqim82Qe2zhptIqpAf4Tf4p4c+lJWg8QV5+RnN1+Nr
         b8+N0Ka7qtrC6cAVNZBuAkP2CPIFs9o8ZAEc8oB1ydotuhM6ylvBOVt2isj4/ofvwi5m
         2i/rO9Bwsj1AZUX1bebivPV/8UjbJcwX5Z6DNAwjL6blR0KqvIKN0Bl8/2FB60AI6u7W
         fQsRNhnRHsFt0p/aTLc1RBiHjvRluYTErOkoLmQphQDdDn78Jqi5dVHRiPgSV4cvTuqP
         cNzA==
X-Forwarded-Encrypted: i=1; AJvYcCUwc7SyUB2RjszzQH8TWeB0LZ4laTUfM3QepKGlpwV1gGCDsVhgpx0Ls58YlPT4x4ntauHda+pxDaxMW4K3TFJ0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9uM9ygw8CTUS7XXd1336CFCptutoF7RCDTR/VAADMaF/IfYba
	MaCM6eO3bFU6V3cAKg4zrxJIEuNVZ2pLB5Gp+kmFr1vyknEwXiSr46sSixkwI4AxNNiiryFUuAa
	KVXFESS6/9A==
X-Google-Smtp-Source: AGHT+IEssDD1Wr8QgcOB4tVI4HLcQH9yG9e29tLmTkb9S16XsXoxbGnLaEAJhXlcKNm2geB/qU1Fe91ExQ6z
X-Received: from pli3.prod.google.com ([2002:a17:902:c103:b0:292:adbb:88e3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4ce:b0:272:a900:c42e
 with SMTP id d9443c01a7336-294dee990fbmr23651385ad.35.1761716083608; Tue, 28
 Oct 2025 22:34:43 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:34:12 -0700
In-Reply-To: <20251029053413.355154-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-15-irogers@google.com>
Subject: [RFC PATCH v1 14/15] perf python: Add access to evsel and phys_addr
 in event
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Song Liu <song@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Blake Jones <blakejones@google.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Use the reference counting to wrap the evsel in the sample processing
pyrf_event and access using a getter routine.
Expose the phys_addr in the perf_sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 27410b3fb7c5..09098c1112d3 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -32,6 +32,8 @@
 
 PyMODINIT_FUNC PyInit_perf(void);
 
+static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel);
+
 #define member_def(type, member, ptype, help) \
 	{ #member, ptype, \
 	  offsetof(struct pyrf_event, event) + offsetof(struct type, member), \
@@ -55,11 +57,29 @@ struct pyrf_event {
 	sample_member_def(sample_tid, tid, T_INT, "event tid"),			 \
 	sample_member_def(sample_time, time, T_ULONGLONG, "event timestamp"),		 \
 	sample_member_def(sample_addr, addr, T_ULONGLONG, "event addr"),		 \
+	sample_member_def(sample_phys_addr, phys_addr, T_ULONGLONG, "event physical addr"),		 \
 	sample_member_def(sample_id, id, T_ULONGLONG, "event id"),			 \
 	sample_member_def(sample_stream_id, stream_id, T_ULONGLONG, "event stream id"), \
 	sample_member_def(sample_period, period, T_ULONGLONG, "event period"),		 \
 	sample_member_def(sample_cpu, cpu, T_UINT, "event cpu"),
 
+static PyObject *pyrf_event__get_evsel(PyObject *self, void */*closure*/)
+{
+	struct pyrf_event *pevent = (void *)self;
+
+	return pyrf_evsel__from_evsel(pevent->evsel);
+}
+
+static PyGetSetDef pyrf_event__getset[] = {
+	{
+		.name = "evsel",
+		.get = pyrf_event__get_evsel,
+		.set = NULL,
+		.doc = "tracking event.",
+	},
+	{ .name = NULL, },
+};
+
 static const char pyrf_mmap_event__doc[] = PyDoc_STR("perf mmap event object.");
 
 static PyMemberDef pyrf_mmap_event__members[] = {
@@ -101,6 +121,7 @@ static PyTypeObject pyrf_mmap_event__type = {
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_mmap_event__doc,
 	.tp_members	= pyrf_mmap_event__members,
+	.tp_getset	= pyrf_event__getset,
 	.tp_repr	= (reprfunc)pyrf_mmap_event__repr,
 };
 
@@ -136,6 +157,7 @@ static PyTypeObject pyrf_task_event__type = {
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_task_event__doc,
 	.tp_members	= pyrf_task_event__members,
+	.tp_getset	= pyrf_event__getset,
 	.tp_repr	= (reprfunc)pyrf_task_event__repr,
 };
 
@@ -165,6 +187,7 @@ static PyTypeObject pyrf_comm_event__type = {
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_comm_event__doc,
 	.tp_members	= pyrf_comm_event__members,
+	.tp_getset	= pyrf_event__getset,
 	.tp_repr	= (reprfunc)pyrf_comm_event__repr,
 };
 
@@ -197,6 +220,7 @@ static PyTypeObject pyrf_throttle_event__type = {
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_throttle_event__doc,
 	.tp_members	= pyrf_throttle_event__members,
+	.tp_getset	= pyrf_event__getset,
 	.tp_repr	= (reprfunc)pyrf_throttle_event__repr,
 };
 
@@ -232,6 +256,7 @@ static PyTypeObject pyrf_lost_event__type = {
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_lost_event__doc,
 	.tp_members	= pyrf_lost_event__members,
+	.tp_getset	= pyrf_event__getset,
 	.tp_repr	= (reprfunc)pyrf_lost_event__repr,
 };
 
@@ -262,6 +287,7 @@ static PyTypeObject pyrf_read_event__type = {
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_read_event__doc,
 	.tp_members	= pyrf_read_event__members,
+	.tp_getset	= pyrf_event__getset,
 	.tp_repr	= (reprfunc)pyrf_read_event__repr,
 };
 
@@ -387,6 +413,7 @@ static PyTypeObject pyrf_sample_event__type = {
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_sample_event__doc,
 	.tp_members	= pyrf_sample_event__members,
+	.tp_getset	= pyrf_event__getset,
 	.tp_repr	= (reprfunc)pyrf_sample_event__repr,
 	.tp_getattro	= (getattrofunc) pyrf_sample_event__getattro,
 };
@@ -425,6 +452,7 @@ static PyTypeObject pyrf_context_switch_event__type = {
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_context_switch_event__doc,
 	.tp_members	= pyrf_context_switch_event__members,
+	.tp_getset	= pyrf_event__getset,
 	.tp_repr	= (reprfunc)pyrf_context_switch_event__repr,
 };
 
@@ -1196,7 +1224,7 @@ static PyObject *pyrf_evsel__str(PyObject *self)
 	struct pyrf_evsel *pevsel = (void *)self;
 	struct evsel *evsel = pevsel->evsel;
 
-	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel__pmu_name(evsel), evsel__name(evsel));
+	return PyUnicode_FromFormat("evsel(%s)", evsel__name(evsel));
 }
 
 static PyMethodDef pyrf_evsel__methods[] = {
@@ -1954,10 +1982,7 @@ static PyObject *pyrf_evlist__str(PyObject *self)
 	evlist__for_each_entry(pevlist->evlist, pos) {
 		if (!first)
 			strbuf_addch(&sb, ',');
-		if (!pos->pmu)
-			strbuf_addstr(&sb, evsel__name(pos));
-		else
-			strbuf_addf(&sb, "%s/%s/", pos->pmu->name, evsel__name(pos));
+		strbuf_addstr(&sb, evsel__name(pos));
 		first = false;
 	}
 	strbuf_addstr(&sb, "])");
-- 
2.51.1.851.g4ebd6896fd-goog

