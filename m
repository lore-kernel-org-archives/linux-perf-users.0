Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE88B423A79
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542253; cv=none; b=Ri3fk/z9emTOVWpyrrRKhBXx1751vbaX5lVPhW8xva6RRXKpcJ1SYs8O+QyzEuOV3zayf0qI9qh2mQ5fLU1ePkiYqlbu6Ls69mPKhPbUCp3iEA1Rs9r4a37z02oPaiXhNvWGgJ7wHQqFPzWVVKjDaytK9Emnpnu49Ym6ahQDU8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542253; c=relaxed/simple;
	bh=7Ou4Ehb3EB5Nvzu1qULu8OlFOd9EWLp6NCml3x1Ym5s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MPfeD0+z6pTU5aLjvBYRDIDf1Uaf6kkkejteJ3T6tJ7aQtf9GEv5QzbSuNdszOqEqcCXeveAW4CxuLwMKcEwu+V2Hu3700kyjiZWBNMKKNmMCUVixjTKYjI8fqxThZXTMfLkrpQCfJ7rsJDWakhBxP6gHyK1LkU8/oI7wsAQzMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJY5JMrb; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJY5JMrb"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30ba395b047so189383eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781542251; x=1782147051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XD26SctRAczF8gjk3e/dIIjJ4oWi9jYsbtNxYyZiuQs=;
        b=pJY5JMrbHk5b6i2ZAhTEFyhGPkPSjWCqgTsSKdkP70f3bjyKJhec/PO87jY06Lev11
         odwi/VqquuvJyqAFEaBgdTuJOCp0q398KpNA9FJWT6hvKcNHekUip15m01wspzXYd/4+
         eh0hXUIaBioWr/UCNnl1JKSAtcCWu4tVSyGRqdBaPzWKxFpOEBKvO2NzTMuA42lfYlS4
         P71xlIGDe0hs/Ltdlxa6bqy0PnFPlBhojm+a6rBENkuGA8gNr2t6JAWdadEbRwt3myfh
         Ob+Dx1wCl4+d/fSODSfbzSJ3mpYIshI8Ptju3MN1A3mOWhdUTM81/5Xo5PPg9yVam6Jm
         EMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542251; x=1782147051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XD26SctRAczF8gjk3e/dIIjJ4oWi9jYsbtNxYyZiuQs=;
        b=h7bwNnz6keMF7EgML/ja50MSK2rB0BVE6uN8tuMiMbL52OGvczp3A8eh391JcxTPRl
         uf6ZhZwr1HdMyZ/E7RqcO2k08A4Gdaw+fy0Ymqcfyg6d9LQhR7XOTJfsu8igG1cN12dY
         KFzJoFVd1ayeGV0pYIyKh5yX2taCFw1tFsjsg0ZXyslcCF96fHCZy3R35u/AVx86ZWO3
         EBA3/HAfReW5CSMId9hVBmUb5dLabIHOnz9zSVfyl7SAo5YXdg8U5RzauKbJGOOirU44
         C26FlJBUtiyN2dSpRvmKtmrximtZ3rBUjgiDLfdCBp7YkIrM+P74kNRut68Xqv1IFQxR
         UC8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/hRHZPUqj0dR8zsxZ42PYjTNnmPZFOOO0jadPaPCgTF9nYfO4DriEGSKhWddwwFAdBOl5c/ZsciDH3XIKkNC+j@vger.kernel.org
X-Gm-Message-State: AOJu0YxRJynNX6WID3saUzgVHI7fUlxaPtM3HfwxfBjK3qi/AjjCor4g
	1bSfG0V8W+UVXg5ZsiUY8HTWo5y1YbR7OWogNZNP3olk/kNwcj/0aquQ6hA2Xn8sG1Y4d32Fzyb
	SkB4nAs0H7g==
X-Received: from dybnb29.prod.google.com ([2002:a05:7300:cc9d:b0:304:d272:2198])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:5795:b0:304:9b48:53d0
 with SMTP id 5a478bee46e88-3093979212fmr6039061eec.12.1781542250473; Mon, 15
 Jun 2026 09:50:50 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:50:08 -0700
In-Reply-To: <20260615165010.2724690-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615165010.2724690-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615165010.2724690-19-irogers@google.com>
Subject: [PATCH v19 18/20] perf python: Handle Py_None for thread and cpu maps
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The python stubs allow passing None for threads and cpus to the
perf.parse_events() and perf.parse_metrics() bindings. However, PyArg_ParseTuple
parses None into a Py_None object, which is not a NULL pointer.
Because the C code lacked an explicit check for Py_None, it would cast
Py_None to a pyrf_thread_map/pyrf_cpu_map struct pointer and dereference it,
causing a memory corruption crash.

Fix this pre-existing issue by explicitly checking for Py_None alongside NULL
in pyrf__parse_events, pyrf__parse_metrics, and pyrf_evsel__open.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 38a41bd6c9b5..a6593c388a48 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2089,10 +2089,10 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 					 &pcpus, &pthreads, &group, &inherit))
 		return NULL;
 
-	if (pthreads != NULL)
+	if (pthreads != NULL && pthreads != Py_None)
 		threads = ((struct pyrf_thread_map *)pthreads)->threads;
 
-	if (pcpus != NULL)
+	if (pcpus != NULL && pcpus != Py_None)
 		cpus = ((struct pyrf_cpu_map *)pcpus)->cpus;
 
 	evsel->core.attr.inherit = inherit;
@@ -3338,8 +3338,10 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
 		return NULL;
 	}
 
-	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
-	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
+	threads = (pthreads && pthreads != Py_None) ?
+			((struct pyrf_thread_map *)pthreads)->threads : NULL;
+	cpus = (pcpus && pcpus != Py_None) ?
+			((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
 
 	parse_events_error__init(&err);
 	perf_evlist__set_maps(evlist__core(evlist), cpus, threads);
@@ -3372,8 +3374,10 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
 		return NULL;
 	}
 
-	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
-	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
+	threads = (pthreads && pthreads != Py_None) ?
+			((struct pyrf_thread_map *)pthreads)->threads : NULL;
+	cpus = (pcpus && pcpus != Py_None) ?
+			((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
 
 	perf_evlist__set_maps(evlist__core(evlist), cpus, threads);
 	ret = metricgroup__parse_groups(evlist, pmu ?: "all", input,
-- 
2.54.0.1136.gdb2ca164c4-goog

