Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69522BE63F
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259728; cv=none; b=Xrn2Tcs+04fY1ggxD7ePZWFcJ02Tb1F8aQWGMOvpPc5cpr4/KrAtDDpXgPJp96It6KKTMyZTkH8PS10CeYsmQ/WyUlB+rr3tymkVXzSYs+6eKIman9cqTCspUIw+wQjKz7J7vmTh6JhvsbfoebhOCgIC5EsPI2iKUtWWDbNNOmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259728; c=relaxed/simple;
	bh=jQARfxlrhw5Edr99xK8KqJ/X0zZW/9CLynsfZ/iahLQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aORcetsDnfkqkSJ0PEXeSyMXWMCPhStl5Aix0gd4BZVsLFjuWcqYh6i8BcjIO0uC0c0jLf2dQSvHF7FrNoXkPSJYyfW2s63R3aQFioDcjyyTtoQdRYYewljJGPWPnFJd3+IiEuNzLKFCOLHTDdCFg2cK1dJfnOwZeBNHiHGOPJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k4nI8T52; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k4nI8T52"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so1604479a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 00:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786259724; x=1786864524; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bqhTaOZx4oYiIKO7FVaVB+owHoEMVUNoR+tChJIAFMM=;
        b=k4nI8T52AL/p/eoI1L1ZZZ9raO3lkZZ151+RLyp2v2roeoBpeDpofBkmjeHcgyXMbQ
         cIEYPtjtDbok0NKZZt0sw8Zp/5Z82zd89JR5mX8y2jmfgxksZPnx3WLkNUNpJTU9UtUw
         u5IOSav9/lOc9d1oY1OGeuLklQSC38Ibf2WZfy7guq6A5c3k7c4idxir1n/Q+3qww59T
         BhvJrpjyMfn2fSywFaf+6f1V9ENcXUDPDAFcGOktqE8iizkKvVRtyd37b8i6AiAEJ+1P
         TkZ/I7khM+LcNedAP2+29AeyIFS557KMG37uSOzvMjhn4hjWQXugQJLaXWD3ikQVoO1M
         FAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259724; x=1786864524;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bqhTaOZx4oYiIKO7FVaVB+owHoEMVUNoR+tChJIAFMM=;
        b=kNrc2U8cDhkaGJzb4xOIa8CGRqCxYMmBVeaaqJSTBwqU4wvUfSnPudJSm4DNKnGSsR
         phvmvNCV9hj/Iy4mnokaLfg3qCCNS2QVjlcik2+RJ18j4nJEnzfIY59SxZqVbT7Ig/x6
         WRR7HBNYCxHaq4r8LT/lbgQiA4USvZ4vD/UiohCU7uEItkVsrB/Cf+f2w8h3F9XlHnxk
         Bfa0tqF0/xuiLifLijUKpMEyuNzITFT5daTFrfxp/pnm6RAP01Ryg3q9KArwSCvEjhWa
         UK0CkWq8Lk1yloPbtteQ+q14355bqBrBEarQQ+jXtzVC6OP+urJihhaftJNhCJAQqsGO
         C3qg==
X-Forwarded-Encrypted: i=1; AHgh+RpGdQTv+FinKhDkNCuinEi329DeHhVVeMgViZKx2HQIhxGSL5xEeP5Kz66MpkHHn00qf1PhC1ba5vX/W+miB/hb@vger.kernel.org
X-Gm-Message-State: AOJu0YwTmdYED99SFLj83zAwhCTK2qbvylgztjgx2SZOwqmqSOpbT6oH
	lHXRbAcZtuhLj/nBYT1mkkJz/JcaCahcRKyw8yQsQ6WXohmtSbN/ZQZPheLmK2UsFfCoFfGN9hq
	y8iAuPZRumg==
X-Received: from dldz6-n2.prod.google.com ([2002:a05:701b:4186:20b0:140:f3bd:b2fa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:578e:b0:383:5a16:bd70
 with SMTP id 98e67ed59e1d1-3903c5ebc8cmr36529406a91.16.1786259724100; Sun, 09
 Aug 2026 00:15:24 -0700 (PDT)
Date: Sun,  9 Aug 2026 00:14:50 -0700
In-Reply-To: <20260809071455.1221514-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624051535.3584977-1-irogers@google.com> <20260809071455.1221514-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260809071455.1221514-12-irogers@google.com>
Subject: [PATCH v3 11/15] perf python: Add thread and PMU uninitialized checks
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
 tools/perf/util/python.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index c70b151428f7..fe5afce17333 100644
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
 
@@ -1750,6 +1753,7 @@ static PyObject *pyrf_pmu__repr(PyObject *self)
 {
 	struct pyrf_pmu *ppmu = (void *)self;
 
+	CHECK_INITIALIZED(ppmu->pmu, "pmu");
 	return PyUnicode_FromFormat("pmu(%s)", ppmu->pmu->name);
 }
 
@@ -3764,21 +3768,25 @@ static PyMethodDef pyrf_thread__methods[] = {
 
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
2.55.0.679.g6767b8d81c-goog

