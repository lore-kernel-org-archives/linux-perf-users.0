Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBF0322522
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278172; cv=none; b=qSTTExeUzLQipOjblPlMKQh3nEvDWkHU1st5uBWp0l9YEIJb/LUfMILjNSKtYI8WqcPqPtxgPXY+GBIJlaZOAszcjr2FQz8ufQhjzegne1qpvwzfK+Jh5HNVKah7zWxtEfWQGqUKXUjS9vcTjj5WE96C7Kp4ixeHYQS6ted4p8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278172; c=relaxed/simple;
	bh=5NSOfZxC9tZSZzh5nzx4J56ffxbdULsyGYFbtB+mfwA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jqkcOq12FsSf2TlM/rKd7mj2ylSY/0c2fkON9GzaMyVfuTzHSNJqajUGipNq4f/lmr2v3Et2G1roU9QTK3m+ZKe1uSixumxnFykHt+RSYjpQpMvRxfavhWwDVkA/Db1w1ujopajlqfMvlCJ42Q8Apg+DuygfZ3RWaz4Zs2aukAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MeI6Qk39; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MeI6Qk39"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-139b62317d0so2509061c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278169; x=1782882969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GVfnkNq1PIBmqGscS0ilZAevukokJ/LZeW/s+TEeeuo=;
        b=MeI6Qk39JwyHZmJaTlnOIrDUgdr1pOeViSikekaA4PxLts/NOWzUXoYtaGN5dnj3C6
         PRvoaBiplWg5ff+E9yGSHdCX2ER4YE95CYY10owpEJzu2BVu1RABBBLn9/BTB2pP6NMo
         /LQdsiFI6VNPi1YMGNAsgEA5nGx1sElqlsLRF/5KTEP2BC/zLN6UM29nflrB4aJlRQS0
         jD9UxfiM15A4fZQToKL49dG/YyIjx5Q+8J0DPBDZNRy+SlaNYdRBk03EXAJcEU+NAL9C
         kefcYm8bYLdgBa6nN4/rXYbbQlTZhqtOvtVG8pZnNFZahmAwvlCmFJJ1FbEXYfIHou6L
         fAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278169; x=1782882969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVfnkNq1PIBmqGscS0ilZAevukokJ/LZeW/s+TEeeuo=;
        b=LvNtpz49GJZuiATrueUunLpuZqsF97CqbsVuxfDp22haGMs20BFkk4jh5/w6uEyyGC
         y0LrEYdJUlI/KqnMBC1ajTv6Xs4eXcPPXhd924pVXMBqBXpTQYV5bk/HEyAPnBn5w1ih
         J7pvKfUiZaZg5tZCw98jy3Hs3ov4Bx64bjwOtHdDepqmCGbK5jCwiS5eC+4QBSPy82aq
         xNciStmik6o9O6w8HJMzLPleztT+0aytX20PPSosHRDEhtAQrmY0v9TyKISZSowf8LCH
         CB+9+rhNIOCf2ZXBTWhMGhtrYhK8mnp8iasc1LYRUgys/eSElCWuQ0g7tQ6gBJDtjP7x
         yGXw==
X-Forwarded-Encrypted: i=1; AFNElJ/Qs58JLOWJLctAIFXsQng+pNcLWGrKz4r9uDXpnl4TP9mfNmezpSvTibu33k6gP6aYfsls7e/jsazkQsiUS+bI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Q0chGP9E3KEetNZhScNfZb7kF8qhyuqA2LOfYSW/MCbdpOAJ
	H4YCYPxTardXYSrrmxrvRI3+/u5K9cnAWzDSJN+dfptpvFfv6MItVdVZ2SK9ER1CPr3DRewgKev
	/i4Wpe8e/Uw==
X-Received: from dlbqc12.prod.google.com ([2002:a05:7023:a8c:b0:139:c208:51f7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec6:b0:136:4a60:43ce
 with SMTP id a92af1059eb24-139d0c1921bmr1579546c88.11.1782278169134; Tue, 23
 Jun 2026 22:16:09 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:30 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-14-irogers@google.com>
Subject: [PATCH v2 12/16] perf python: Add thread and PMU uninitialized checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add CHECK_INITIALIZED checks to the thread attribute getters
(get_pid, get_tid, get_ppid) to prevent crashes if they are accessed
before being properly initialized.

Fixes: 3b96bf7af60d ("perf python: Add python session abstraction wrapping perf's session")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 71be130b38c5..b17b191b1625 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1678,6 +1678,7 @@ static PyObject *pyrf_pmu__name(PyObject *self)
 {
 	struct pyrf_pmu *ppmu = (void *)self;
 
+	CHECK_INITIALIZED(ppmu->pmu, "pmu");
 	return PyUnicode_FromString(ppmu->pmu->name);
 }
 
@@ -1730,6 +1731,8 @@ static PyObject *pyrf_pmu__events(PyObject *self)
 	PyObject *py_list = PyList_New(0);
 	int ret;
 
+	CHECK_INITIALIZED(ppmu->pmu, "pmu");
+
 	if (!py_list)
 		return NULL;
 
@@ -3758,21 +3761,25 @@ static PyMethodDef pyrf_thread__methods[] = {
 
 static PyObject *pyrf_thread__get_pid(struct pyrf_thread *pthread, void *closure __maybe_unused)
 {
+	CHECK_INITIALIZED(pthread->thread, "thread");
 	return PyLong_FromLong(thread__pid(pthread->thread));
 }
 
 static PyObject *pyrf_thread__get_tid(struct pyrf_thread *pthread, void *closure __maybe_unused)
 {
+	CHECK_INITIALIZED(pthread->thread, "thread");
 	return PyLong_FromLong(thread__tid(pthread->thread));
 }
 
 static PyObject *pyrf_thread__get_ppid(struct pyrf_thread *pthread, void *closure __maybe_unused)
 {
+	CHECK_INITIALIZED(pthread->thread, "thread");
 	return PyLong_FromLong(thread__ppid(pthread->thread));
 }
 
 static PyObject *pyrf_thread__get_cpu(struct pyrf_thread *pthread, void *closure __maybe_unused)
 {
+	CHECK_INITIALIZED(pthread->thread, "thread");
 	return PyLong_FromLong(thread__cpu(pthread->thread));
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

