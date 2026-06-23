Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759CA3ACA5C
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192952; cv=none; b=T+mqKKCOHbapU97Iek/G2Rpk/8QLbFgiqa12ovimjKULtf1pVUzojOrPOaHJmgW2BSgKAfQZfgM1M077YDuttR0CIkW6kHYTvAx3tqv9XUKiiWf4HCo2C0NkwWb21S2FGn63C8Uf+b4lb8SNSMMeXd8NO96i50aCy2yGZn6g2kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192952; c=relaxed/simple;
	bh=O9EMavApnKApp6eNZgP01LKURlBAC2vMjLDRaWS58OY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kc1fjMTJNqdOJOjU2RkLp5iTHyMbPn/RYWPmgCBo3WNEWP5dLGSLeC2ex0XAhWSol95uoCu1PUSZcmLedeH0jeUgIiD2DHyeyr8V4CzsNTQhYPUzFcWEJ1ixAL7YJ2v8Zaw3PQgE9alewZ4AY9aut6oHomkGwEBWu9yx+JCP5ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ycn550Ob; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ycn550Ob"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-139c6673856so469790c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 22:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782192950; x=1782797750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HBcsHNwg3xhWkWKpGk7grTy/ddQtz5W1gLOJTYLItws=;
        b=Ycn550ObC+93H+UAOwip+xBMkn+z0Hv/xBmVJnHemSUn4dgkbTNxSC9CyCDUS6sdBX
         PEf/7ti+DhOYUb+Gl9QWQUDJeAG5/V2ULVaoR9wiJgTfP4fyAxgWKdXd7FBxfXXJUfGi
         pxeuQOkZ3Pmfj/aOCMhUJcy/lh0kgkefVwf0wY5PZ6Kpjo/SJbRV4Fn0kB6bDptMflsY
         pdg5AinDdRR9JhScBKd5egZYYB7puaj63aWCvheGJzTmC4cHkyONkScr3HzSC7f2uvlv
         Ggo6Oz7boytZhgo1PkA6i3IbsKv7P5tq4CtCREA27ur4Y6iJ6gLfGZN6zClyVAqq8bqB
         GRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192950; x=1782797750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBcsHNwg3xhWkWKpGk7grTy/ddQtz5W1gLOJTYLItws=;
        b=d1kzliPrZuToGXXu7QkH6CgvFi9mJW9Bqk6p9Qfrgisyd771a9OVZwveOtU4pORAGj
         lzRnxyvyH1I5J2L3SHrKe4rub+IwBw1P3bBV2pF5gddsVa5veQrGiiOjAQzZgJChVNXi
         VvqDwpLN6a1WnugHs3canSudAyZ4IRU7Zjcw8UbZiQDTSMJBq4+l9bAlD3MbytJdNBth
         vzQuMHuBtymni0FIz/1HIcg+ItDxOo/fCStfZdQAluvk+RHvy7tYq+IKGUTBUfk82aYx
         +wNWo3HF92uC94zzpHkmR5TZSjC9AA4b2OwSrb0LmOwS0lLUVBb0uCuuUERL315qtsrY
         c5xQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ufStOfoofaDwhJ2jgLPW6QDzeaLKeJKQWCr/UYNpqc9vyE5Q46OkYFakzP6N7pqcMaSt0ysDDaf+VIh8hz1Ra@vger.kernel.org
X-Gm-Message-State: AOJu0YxJVIpncztdBlTeX7Ul57uVYj7iQ5gBtaoCZ0ZusJWtY6su8CoM
	vt/Q8nSZ8dDsGkve0QeykLmOEFg3QYon8it6KERI5W+mX/4oVs4ck8HmDzvmOvT49OjlJ7/6HN0
	RCz1RYD/iWQ==
X-Received: from dldoa13.prod.google.com ([2002:a05:701a:ca8d:b0:139:c897:8624])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:609d:b0:139:8148:30d5
 with SMTP id a92af1059eb24-139c6f4f521mr650676c88.28.1782192949229; Mon, 22
 Jun 2026 22:35:49 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:35:11 -0700
In-Reply-To: <20260623053515.2677888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623053515.2677888-10-irogers@google.com>
Subject: [PATCH v1 09/13] perf python: Validate CPU and thread maps in pyrf_evsel__open
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add explicit Py_TYPE checks to ensure the arguments passed are
actually of the correct pyrf_thread_map and pyrf_cpu_map types.

Fixes: 877108e42b1b ("perf tools: Initial python binding")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index f9398bc30a80..62f404c40d8d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2096,11 +2096,21 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 					 &pcpus, &pthreads, &group, &inherit))
 		return NULL;
 
-	if (pthreads != NULL && pthreads != Py_None)
+	if (pthreads != NULL && pthreads != Py_None) {
+		if (Py_TYPE(pthreads) != &pyrf_thread_map__type) {
+			PyErr_SetString(PyExc_TypeError, "threads must be a thread_map");
+			return NULL;
+		}
 		threads = ((struct pyrf_thread_map *)pthreads)->threads;
+	}
 
-	if (pcpus != NULL && pcpus != Py_None)
+	if (pcpus != NULL && pcpus != Py_None) {
+		if (Py_TYPE(pcpus) != &pyrf_cpu_map__type) {
+			PyErr_SetString(PyExc_TypeError, "cpus must be a cpu_map");
+			return NULL;
+		}
 		cpus = ((struct pyrf_cpu_map *)pcpus)->cpus;
+	}
 
 	evsel->core.attr.inherit = inherit;
 	/*
-- 
2.55.0.rc0.786.g65d90a0328-goog

