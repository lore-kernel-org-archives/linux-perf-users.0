Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEDD3290A6
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 23:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643192; cv=none; b=c0t5uL6yx247d0er966OnryFg8lxuPozhb9LkxD4HILC0BhljPxQ0Vx/Qc19KIcHC7yhjA+i2pK+2eNBN0AKWflzKIYtyuw/fLkrDXK91IygD1fugzZ+9CFvyF1fdALzq0OzAnH+7eRq5HYNxCugu4PQhSV5Ng5ATRVd/jTHswA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643192; c=relaxed/simple;
	bh=boLLMF2QtEVMyUjFVQ8TQQDT2nZ6aU224jb8PV/EJWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uztWgvY54AD5OtRNAilk58t5WGLYjzjg2y8NOhEBHczN+v/nfjbAleDjIPFzhgfyG8omNfD2QE4E9XUDbZQg3DGg+K7ZNbRIA5MPtgGQB/d0l/ohVx6l1xNqDT5G1oBJIP4DmitunbW9xyNiwLIal5lJfEJDmrWuTW5Gr5sQBqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p0az/Esi; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0az/Esi"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2dd6fb4c867so1916382eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 16:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643190; x=1777247990; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q36CpGFhO4kxK2qbwmzIOsr9S2LUQ4s/PljcVh1oH6U=;
        b=p0az/EsiEQeOM7WK75/mfijOViHhjP7hHaN7gnBMQgEdaoASgWbWbfeBmjJnopRUBM
         qzxnK5U1xqWmJ3H9nXSo07rrozPjO9wcpT0kx+wu6Ncj3nI3OtKnr2h1FQLD+hiOCIqm
         1+o3OMRvA6KdSsvrTBfyFBMoFwmvDZjmKeGqSsuzicAqZkLM+48TkgeksN4Dy2ID5DAs
         m3DLcSQvubobkzY7iyvrxPfD/nZYyDzwqFI2GsbIdILBl+oYdUUAIgdFJ0633hXH/+hG
         V8EsVZfrVB0jZTLs9KcoQ9D5R2+CcERNInr8pWZUyJcX4aX/UZX1oHURsSlnd7XwSvxP
         lyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643190; x=1777247990;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q36CpGFhO4kxK2qbwmzIOsr9S2LUQ4s/PljcVh1oH6U=;
        b=SZJKePaR40ZI0VV84xIj8H4NIMh6IxqVnppekJ8veHjrrcvwyPxVLA55H+Q2VMxK4j
         ZzKm5JJ8dew+sLg2JPifXunknV14GWpkRDEEEb9rAQP6bSt8rP3z7CzpiTNPkyvlHA7k
         EprkVi5jIp5wiaQY8mhA1SLIERSbQrMDrqqPRYTmouaJBnhXlpECnRtLz3Oy0TOly6KD
         UjvOOeZUfaeiV4w9zAw+JDvyNbJmktnxCBpn863bC86T0S8mqpu7BJh4gmcDBS7QNrHC
         cIwsY47GmQ25HW1D1Abdr93Pb4kp9KLNQ/Kyvsp6ZXNLVJH30yWKN85ak9GxtsiWZkdy
         qT7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+QZuYrzNE4BIhO6qPNkU+0TwI0MFyUrVYn48JEGBBYTc7pj+C3XtriVswG8DqS1RElbL1fdlNmpt0/znzKZcg+@vger.kernel.org
X-Gm-Message-State: AOJu0YwaPVTGR+PNMsqIKGWjBoappq1NWb+lMQG0ML3gMFPOAaHvR+Xv
	IjE4Sjr5fW/d79XTCrgnl4JfNG/jUea7Lgzio2w29giUImhWBu/xi4SnkPrvmpYP47rbR9MPiL+
	op189svCayQ==
X-Received: from dycnr11-n1.prod.google.com ([2002:a05:7300:e9cb:10b0:2e5:fa99:f6e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7491:b0:2df:7b88:a1b0
 with SMTP id 5a478bee46e88-2e4873f31a7mr6396278eec.27.1776643189974; Sun, 19
 Apr 2026 16:59:49 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:25 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-14-irogers@google.com>
Subject: [PATCH v1 13/58] perf python: Use evsel in sample in pyrf_event
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

Avoid a duplicated evsel by using the one in sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index e72b9d52e9ff..46fe173c6b5c 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -43,7 +43,6 @@ PyMODINIT_FUNC PyInit_perf(void);
 
 struct pyrf_event {
 	PyObject_HEAD
-	struct evsel *evsel;
 	struct perf_sample sample;
 	union perf_event   event;
 };
@@ -274,7 +273,7 @@ static PyMemberDef pyrf_sample_event__members[] = {
 
 static void pyrf_sample_event__delete(struct pyrf_event *pevent)
 {
-	evsel__put(pevent->evsel);
+	evsel__put(pevent->sample.evsel);
 	perf_sample__exit(&pevent->sample);
 	Py_TYPE(pevent)->tp_free((PyObject*)pevent);
 }
@@ -296,7 +295,7 @@ static PyObject *pyrf_sample_event__repr(const struct pyrf_event *pevent)
 #ifdef HAVE_LIBTRACEEVENT
 static bool is_tracepoint(const struct pyrf_event *pevent)
 {
-	return pevent->evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
+	return pevent->sample.evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
 }
 
 static PyObject*
@@ -343,7 +342,7 @@ tracepoint_field(const struct pyrf_event *pe, struct tep_format_field *field)
 static PyObject*
 get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
 {
-	struct evsel *evsel = pevent->evsel;
+	struct evsel *evsel = pevent->sample.evsel;
 	struct tep_event *tp_format = evsel__tp_format(evsel);
 	struct tep_format_field *field;
 
@@ -1770,8 +1769,6 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 			return Py_None;
 		}
 
-		pevent->evsel = evsel;
-
 		perf_mmap__consume(&md->core);
 
 		err = evsel__parse_sample(evsel, &pevent->event, &pevent->sample);
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

