Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADAD146A87
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133152; cv=none; b=hMtiOHD0MMcn+9nBgxE9WkNDzBN5A5S/+kX6fMUSkg5vMoUBFmfhxbpiXIb8THrFZFGTa/n3jES9A/H4L/oy/AF4/2HSL615e89FfHi4wSMI4STpBVk7KJiC0uJcNzJElEYn8QXEPxHA3Ek3NyA7RGXxB47zFUcz+9tjHM+p1JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133152; c=relaxed/simple;
	bh=MCTzfXp2410npPWMxPnIy//KFfI1FnSlwqErfN8AdVw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=nQFZzC9R5PVUTJ2ee8XCijlnnY9rfSqkpn3i0XDtNiXTLNpW0YkcpUT/7fw1N9salOrWnuIZjZKe2eXyHgw1NdH33D2qsNVJ2NsxFM8KZV+gHQ2EpJDHzAHblDUiEO5SEZfUvs3W7Wj/FOxuHaqGYt9Rd0lacDMpJpnAVHLyaJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vlwx+UF6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vlwx+UF6"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e376aa4586so58279727b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 22:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133149; x=1731737949; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQC+nYVZnsSIPtVomujUJB9/ZDMtc8fpB8iG7KWs9rs=;
        b=Vlwx+UF6Og1P1ohXLNFHkKtMyIAUHT79LeNk9pPckNTWLiwPqXCfe64X/WrIyhHp1x
         M3OIIaQyFCT7jKM9GcW5EuAL3JqoWteU2D98/4wIpBsg3D4FuIxDnffjUVlq0bJpkAGw
         +QWZArYxdJlFOxDgzpG0OEv1GU1wowea/4WRp6ltcyTTcqbo9tB24n7nJNz47zzEM49z
         ZHP+YhpjyGz9GQwLiMgvcFU0uHNbglWXL4D6vRt7MgxjFunlqvXCDplQa4sfhMY/iYaU
         xRuDaHSnmCGU+GKem+KeKRJrJ30hCbb8nHzXE+m5gxqH//FcPbklIGwGnTyMAgXu8MQW
         5fmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133149; x=1731737949;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQC+nYVZnsSIPtVomujUJB9/ZDMtc8fpB8iG7KWs9rs=;
        b=JGCJNfvQL0BfoNl1Y5RVSp7vxjVTrw9Zf3FXGaL5ZQ4NhI721pO2Pjf+gnp6w1zNLE
         NbrTK4rVQ6HtYUEPCKIm+NMWDiFGTpZTJqP5bEnj7+TH1b+10e8MdOsJRSXK6TM3OZFD
         YWchs7dICI1d2F12A+jdyI4r+pkQ9hUTNvEwFZSNoGVd/0+gIE5qj8GfKArSlYv+PODF
         CBLzkfiAB5Ru6NxKZqKXHWX8LJDroEEFHrxjLWMzaDAdoiGsRPSBR/8LSNgMXkNe87Y0
         O770W4AcktYN9Ohn15lrcJd30IY+We3+G30lRK+odrld3KS/mxa9WZihIcKHne5Gj5Ak
         NeCg==
X-Forwarded-Encrypted: i=1; AJvYcCWBwvENoGLkIi2eVfdw7FP1Dq1LFeIw+MLnL5ptoyt95LmL5xW0/VkXtwUhCbLxE6y6avERDIbuPrczO/7pwi/K@vger.kernel.org
X-Gm-Message-State: AOJu0YzN49Ot/YyIl7EZXipkilX8BFoWoxqlGblqzM3zcvHj5RUMdZqG
	Qw6P6wgvRu8p9R8GL4SJ01zNtEmV2PzRGS41xmSkUaWJ1N3QJ08YrTXkEbw59Uzww6hlL9FT/cW
	bj34hhw==
X-Google-Smtp-Source: AGHT+IG2J8xhYT2nRn4RChEQkkMF8wDYoMqfx5nMQX1zyrXP8KIbZkwthsd8g0UJFa4g+kK5T8mO25tIMjc9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a05:690c:620a:b0:6ea:e559:d69c with SMTP
 id 00721157ae682-6eae559d710mr212777b3.5.1731133149313; Fri, 08 Nov 2024
 22:19:09 -0800 (PST)
Date: Fri,  8 Nov 2024 22:18:08 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 21/22] perf python: Add __str__ and __repr__ functions to evsel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

This allows evsel to be shown in the REPL like:
```
Python 3.11.9 (main, Jun 19 2024, 00:38:48) [GCC 13.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import sys
>>> sys.path.insert(0, '/tmp/perf/python')
>>> import perf
>>> x=perf.parse_events('cycles,data_read')
>>> print(x)
evlist([cycles,uncore_imc_free_running_0/data_read/,uncore_imc_free_running_1/data_read/])
>>> x[0]
evsel(cycles)
>>> x[1]
evsel(uncore_imc_free_running_0/data_read/)
>>> x[2]
evsel(uncore_imc_free_running_1/data_read/)
```

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index a71bad3418da..0d71ec673aa3 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -781,6 +781,17 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 	return Py_None;
 }
 
+static PyObject *pyrf_evsel__str(PyObject *self)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+	struct evsel *evsel = &pevsel->evsel;
+
+	if (!evsel->pmu)
+		return PyUnicode_FromFormat("evsel(%s)", evsel__name(evsel));
+
+	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel->pmu->name, evsel__name(evsel));
+}
+
 static PyMethodDef pyrf_evsel__methods[] = {
 	{
 		.ml_name  = "open",
@@ -802,6 +813,8 @@ static PyTypeObject pyrf_evsel__type = {
 	.tp_doc		= pyrf_evsel__doc,
 	.tp_methods	= pyrf_evsel__methods,
 	.tp_init	= (initproc)pyrf_evsel__init,
+	.tp_str         = pyrf_evsel__str,
+	.tp_repr        = pyrf_evsel__str,
 };
 
 static int pyrf_evsel__setup_types(void)
-- 
2.47.0.277.g8800431eea-goog

