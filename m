Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE0731F998
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278168; cv=none; b=NUjXI4mC50pu2ONY+6QJpKRIAWo9Xva+9OAr5CVBNfGdShpJ7coyhy0Z3UUKzsaIy4JXUnRIr8nPr0pI1sce3zazSwCQd8tBrZdT3BbAD7xCwDE9DFn4M+KkJtPRJvi9VAAWeDqg7Hay7gy/R0mMrP1cpwPiMdawDfJBUq7UtRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278168; c=relaxed/simple;
	bh=GrXSJoc74YqCKrlE4ri4HkWfhnaWIH2DuHCALs4QeAc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sGRSYd8hrm5hE1LHJG04JmCLDWpdF5POOrV5bwMu76tm25wwQuRIlPvUtxqG179/4eChymQ9NplCJUVhkCq2lqCFcLr4NOpmNB/a+m8scifXxY1mzpKvJV3Uf/za3ZnR94xsTd83LhNGKBpc7cEwPuk4mD3wUPduqfSF6AaEvqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F0k0jnk6; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F0k0jnk6"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-139c6673856so1130107c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278163; x=1782882963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgwg1Ib3KfuAk0Znvp2QUPkDnylzv70E3PuiI7N3AQ4=;
        b=F0k0jnk6hO+nnUsmdyvQtY99FItIRi9D3x5LGZlzpZo+Mnjx7fI2iJSXLRRt1xglsm
         yr6lOVASmesq7Be1HYmizGpU1zvSt/B3Z419VaGRdgQCVzBbmDmwFeBwVAk8Lx6hmxso
         rqjlUZ9NWPjagdL+BY+neGo2wSzz7k0AuAw0gaKvBnuIo2IhARWGQql9zevDoxR1T2tj
         q7H8EGoXkZXo6MhbdD1PRoPzHk0g8Q8fGv0UfrlrHdBvdJ9DzYRbnwJoNRLsW+T36aji
         UauCzuuWBjRWn7lkLh6HGI+PHAV9RxIck0JR2UqD8QH2JwMOa8g4DnPPWu4yEO8+sNJ/
         Lp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278163; x=1782882963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tgwg1Ib3KfuAk0Znvp2QUPkDnylzv70E3PuiI7N3AQ4=;
        b=aC6EVItbk0AuQ0GVQwmbckPiN6vC/IygQfnIZqiPl2rdPwqvCy/sHseCRFyaAs7FJq
         yTEp0e3Rzk0j1ChlLlynqiCO2SCL9QfFB8dGbr5wcWjGCRIoo2OVxoJ/UB7DhZsaGQQu
         FI4yIyjf1lmUVvwcDrHznZV5ZjDuQsogqPE+WY9wPGypbkGmrg3VyOvs6yzNVE+vSGkm
         u59nLhqaZ/nBV548ykrlqsdOKdcBi4PbIOcBLMRmA3NkjVWfFBtmYGovIwasPg4LpsRk
         leyFGxGDD/cT3zS/zIShm6Z1CjS1vCb/GCwLvQykIzI6xh5ayKPmY5uvrMSzjY9Yq9D0
         50Vg==
X-Forwarded-Encrypted: i=1; AFNElJ/Ym0emn/x/VWOKIHVN3e0XCfoXp3V5cAvj9n9UDji7NgV42Frsq4azipd8PjnSFuN9szj9BfFfZtBtvgv+Nwnj@vger.kernel.org
X-Gm-Message-State: AOJu0YxmHgKWEqKcxWrW63MjYgJ9v3r4+SxJfsQAZm/jNQNJT3eH6VHt
	Z++PjGz87XhWvjmHjyQAFJzbo5MQMiJIP28dXCKkhXrY8XIkQt0jS+DDIOpy4Cs13EUzU3M4nl9
	iQMrHGp6tQg==
X-Received: from dlep11.prod.google.com ([2002:a05:701b:458b:b0:139:cc9d:60fd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e0e:b0:138:50d6:7ee8
 with SMTP id a92af1059eb24-139d0c104b6mr1384471c88.16.1782278162670; Tue, 23
 Jun 2026 22:16:02 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:27 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-11-irogers@google.com>
Subject: [PATCH v2 09/16] perf python: Validate CPU and thread maps in pyrf_evsel__open
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add explicit Py_TYPE checks to ensure the arguments passed are
actually of the correct pyrf_thread_map and pyrf_cpu_map types.

Fixes: 877108e42b1b ("perf tools: Initial python binding")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index c6c729808a0f..4bf37e2afb18 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2108,11 +2108,21 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 					 &pcpus, &pthreads, &group, &inherit))
 		return NULL;
 
-	if (pthreads != NULL && pthreads != Py_None)
+	if (pthreads != NULL && pthreads != Py_None) {
+		if (!PyObject_TypeCheck(pthreads, &pyrf_thread_map__type)) {
+			PyErr_SetString(PyExc_TypeError, "threads must be a thread_map");
+			return NULL;
+		}
 		threads = ((struct pyrf_thread_map *)pthreads)->threads;
+	}
 
-	if (pcpus != NULL && pcpus != Py_None)
+	if (pcpus != NULL && pcpus != Py_None) {
+		if (!PyObject_TypeCheck(pcpus, &pyrf_cpu_map__type)) {
+			PyErr_SetString(PyExc_TypeError, "cpus must be a cpu_map");
+			return NULL;
+		}
 		cpus = ((struct pyrf_cpu_map *)pcpus)->cpus;
+	}
 
 	evsel->core.attr.inherit = inherit;
 	/*
-- 
2.55.0.rc0.799.gd6f94ed593-goog

