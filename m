Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FBD3B14AB
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504233; cv=none; b=YCD/jEzvkux8ZWFn2EFmFEHqdKujZ3SfHe7V+Y4tSL3q+p9CrI4GvejvUK30j2gEJ3ocC0Fv80BNMgAV6g65OQpzk6LA9gN4b4BLfcPcq8/LNx4Qk9gvq6Z80Ul16TFddvigpTI6+1DE6hurWQiSd/9qzousYNMPs8gTfRaJ5ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504233; c=relaxed/simple;
	bh=7Ou4Ehb3EB5Nvzu1qULu8OlFOd9EWLp6NCml3x1Ym5s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HDEGFPeVZP/IaY2/KwtqYR6y4dOy38cpx478LFBx7Lf5Sm1RblOMSBbLr1/DmzYneeIZCP+ra29sQgNRE3T/JTwz8/LcTutaoA/j6ypFWbbUj3/kFlYIhHpIEofEBUVRD4sUCbUEag8LPjjWxKj4sjLUm5OS19ibI/ezL/hlN28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Je2m1x/6; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Je2m1x/6"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304ed777a96so1975186eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Jun 2026 23:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781504231; x=1782109031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XD26SctRAczF8gjk3e/dIIjJ4oWi9jYsbtNxYyZiuQs=;
        b=Je2m1x/6fxRHL+sVCabTuwB1ak76tAlHJiUXEG24m/YdxMqyFcqm3i3PgRO3kkq93p
         sKOhhjAptbWlZVdvfNMBWcAwpQ2nT7/LQavpJ5VMHyeO5sHXMviY23qUJkve7pq/VicH
         h76uYI82Bkz5HlRwPee4AdzWTPVE+4lrEzf9633LJ3doVOvlV7GJ15stVEaA0RqWVtTp
         JttrEXiHzHt8RmzfyyY4nO46fe7wIVoWLCu3Y7AUnmIqgOsSU9hQAgEDw8aZRFo0ZBXv
         BrVYrTthvmeWp/bdKQan59iMKoYoJEiTNYJUNnbg6Xd8fFACKOZhhFS/DrNN7sLucvSn
         b6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781504231; x=1782109031;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XD26SctRAczF8gjk3e/dIIjJ4oWi9jYsbtNxYyZiuQs=;
        b=j7VlmJTBu9ik9EvNJTw+PHKD8DoZfmItfM4xeNPH0AMD3qy52KayMVnSv20cegjmjP
         ZCnEYeLmwVQDENl1Bfc8PzjkB0aKsGyJTZicG5LqEfmSP1O6dYANxr7Qu09nDM/UOR/X
         vDqqGKEPhnP5xVBox6ZelScnFG3Keb6vaw7zw2fWxpi9JVslaegTSOaSMiSmuh3KYcJ6
         i/lorjC9+1N9q7+TLNJy05Ic2SQIo3w6vGuHk1cXoxAnzynV0R746OLn/fwTBIwaFRX6
         BhIx79QwYgM4xKa8wPdRjyBxbbtakZgB+WFBlvV3pNLM4yIrHzEzkVSXAPeCmiDMYQD0
         fe1A==
X-Forwarded-Encrypted: i=1; AFNElJ/Ad8GvwrDTiyoSPa0ZooI5AQT6FslkmKj9B512htJcrVy/UP0PJEbaYZgGR1ggVFRuyf+lDRnWovIFTlixprje@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Iouzd898Q0EFdPkzJ+DT5nRzfE7Jw0biDYFcIKhHOTn51p+n
	ljhT5+Rm5Iv/WA5SEb/HIpSyj0PJ9NPrFvTwcT3DivNkv08gf5Komy2o5cSboXPe0y6bB0IEjBz
	9OJ6tLEjA6w==
X-Received: from dycsr10.prod.google.com ([2002:a05:693c:374a:b0:304:ec70:1018])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4b18:b0:304:6822:2cb2
 with SMTP id 5a478bee46e88-30820cc3819mr5668261eec.11.1781504231084; Sun, 14
 Jun 2026 23:17:11 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:16:28 -0700
In-Reply-To: <20260615061631.2382079-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615002812.2234795-1-irogers@google.com> <20260615061631.2382079-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615061631.2382079-19-irogers@google.com>
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

