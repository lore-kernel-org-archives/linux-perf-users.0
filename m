Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB382EEE75
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 00:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781483335; cv=none; b=MtCeJHt/fFd073XUjLRItUmi14LEscO7IXEAZ9QSNPfxuYGxNeu18sQkirQtPXTvktCHlMZLMEKY7XcUksKe1A/lE+MXAmkLfa1I2MDhNzH2265dqY4VDyCqSHwWQ2W8+H7jlOl73TFTV/ddPBjXkOs59NMfrUbxmcI8zidwnrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781483335; c=relaxed/simple;
	bh=OBgsLJOOfvmD4ebW9xz95/WWY9fR2jtCC7ZX+eI5GGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=upB1CD1u9XzFUjRrvcZyybEPQt0VaUAdl9HDBa/vTmeR5b1D1fxWQZ/pWyHDYlPuoCZj7w+X0jYCcxW2BhPN3tZ6hZbU5jH+KdmWW4x16I97RVLo6JQh4TBRmlvoFnj/fmixaWCRm9DoLBOQwdm+w6Kn/KNRZMbhe4UYUZBSMXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t2e41vq1; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t2e41vq1"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1384ec9a1e8so6663676c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Jun 2026 17:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781483333; x=1782088133; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WC6q07A3WehSz5zntTk5Uant7ecXTwcluaL+fJIwivs=;
        b=t2e41vq1Ju1v9Qt7D1zi5JIo+HEdrmeLfep0V6Zjanf86sLyNRw3CxrZj6GCBNuwJs
         mWTnFgEmXGCarEyic2HSgyxXrK3R5JhVCYjQp9IY6l4O+S661kxEbBC7MVuO7DMpsduD
         2tPvbe1Skfm88/FTxNOBtlbxRwWfZSb12F1aX1itdzQMeZmqYhRObDWuRrF9j5whKSSx
         +yPyd9kzaeOVFQyhIDMmFaZZdS1hcu9Vi3iHoUwNAdjs7LWJm2bNEQz5vpFPN91mGrAt
         u7+NJNQDsY9oXKUBvEuKC1igYD0WudBOhVuP4eaVnqGnBQ6HjzJbwNgzKyMW4n6odh6V
         bTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781483333; x=1782088133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WC6q07A3WehSz5zntTk5Uant7ecXTwcluaL+fJIwivs=;
        b=REhb6EJjMaZKRApulxOa/5Og1v7MR/vHsXEah8+u7MYeXcD1tEouVHvx1UIejm36x6
         DpfX/CK6SJ2VSqFasKOIACJql+NSfjsZ8hcDlxiFhHkyphGbk2jwdzFpQyZIQvRjH24B
         bgYG9VFud2PCt1TG1IW6bl/Rn2J5w/gI4aCew+JQ9Bc/J2i22lDGQo3w5td80eFbG0ps
         b3+HD15jSO5DPMOGuLa1W+0R1sKoEVM3RArIukf2oJ74VVmthZIlST7phi0W2u6E9dfG
         25VJwgDF3IkuHTWpBly1Cb+qzCjKZc5ZNUSFQY/NJkN8/5ERGGLaRKSBSPkvcdDpaSCt
         6g4w==
X-Forwarded-Encrypted: i=1; AFNElJ9sSZ7Cla2R9Dd3cIgPoF/cZI3RSnlzwPpeLFzTM0Q0K1Njnywrnjc36OsTxqzzuehunTK1MsFD13MqYe78y+M4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn4U8yCY7+XOUYMKfMbj/DqsFZ1i73EQN7PJih8O1SfofxnBps
	G70rlr2+Z9VcT1MtdwslZbnH3vFbruBUcvFbW94TKY177Hf3aKa6PztO4KAqTQ7sJCg63vmdD82
	zO33/0Wsyzg==
X-Received: from dlbpv1.prod.google.com ([2002:a05:7023:901:b0:138:498:899c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6ba8:b0:137:fea7:ed19
 with SMTP id a92af1059eb24-1384bb1c373mr5775404c88.3.1781483333049; Sun, 14
 Jun 2026 17:28:53 -0700 (PDT)
Date: Sun, 14 Jun 2026 17:28:10 -0700
In-Reply-To: <20260615002812.2234795-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613071100.1508192-1-irogers@google.com> <20260615002812.2234795-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615002812.2234795-19-irogers@google.com>
Subject: [PATCH v18 18/20] perf python: Handle Py_None for thread and cpu maps
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
 tools/perf/util/python.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index a5045e40a621..656ef9871a42 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2091,10 +2091,10 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 					 &pcpus, &pthreads, &group, &inherit))
 		return NULL;
 
-	if (pthreads != NULL)
+	if (pthreads != NULL && pthreads != Py_None)
 		threads = ((struct pyrf_thread_map *)pthreads)->threads;
 
-	if (pcpus != NULL)
+	if (pcpus != NULL && pcpus != Py_None)
 		cpus = ((struct pyrf_cpu_map *)pcpus)->cpus;
 
 	evsel->core.attr.inherit = inherit;
@@ -3340,8 +3340,8 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
 		return NULL;
 	}
 
-	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
-	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
+	threads = (pthreads && pthreads != Py_None) ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
+	cpus = (pcpus && pcpus != Py_None) ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
 
 	parse_events_error__init(&err);
 	perf_evlist__set_maps(evlist__core(evlist), cpus, threads);
@@ -3374,8 +3374,8 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
 		return NULL;
 	}
 
-	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
-	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
+	threads = (pthreads && pthreads != Py_None) ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
+	cpus = (pcpus && pcpus != Py_None) ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
 
 	perf_evlist__set_maps(evlist__core(evlist), cpus, threads);
 	ret = metricgroup__parse_groups(evlist, pmu ?: "all", input,
-- 
2.54.0.1136.gdb2ca164c4-goog

