Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0231038837E
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572590; cv=none; b=N0UuehSUXsVTVhQ9ue470GTINZ17oxI11URaztisTEagyttjxQu4ISXTBW+pwBpkxLIufxz8DqKfmaUdP+pXgS3RkBzy70QM4f9/g3JXY1g10o4izscjfIH96Guf5qZFESUDAlc7ULasaoxuLMatGgNxjS2odX8gXCalk1HlRZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572590; c=relaxed/simple;
	bh=b+zFPPddi5vsuvVelPM3s+QHu6ScPZ/Q3IhGSJ9QvrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y7KO5SD28msRSrbzj1Rappz2FYR5B8M3AFhVf3BoOh2qstldoidB7etIVWdj8in2pJK1/L4Rv9Eq44hcsGlS5fNFWYATyjxrG8YoUG8pPm/+mU7BmUKxBKzjZjbM2Kup2YqFHlxlS8PDszqDZNGysnqCgDWTBTg7ARau9kwVAjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hghmRu6i; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hghmRu6i"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304f1820babso6028841eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781572588; x=1782177388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DhNmHmJTzevaW5Ie0slFVTtwGbX/K4JKnDxjqTLGpkg=;
        b=hghmRu6inexuKZgpi/1fAEbQCDjq+snVPuYmEDGVF0IsS3O8ZUg/Xoe4Z4I2aaSe6T
         2ir0jsBETn7PMmqVhSoEQd18AI3/RcokqdUJMFIS2ElEq3HctKBR/GIRsSvL+Zzh+M4u
         5GpNxidzgScYRnQktMayP56wcPWmCVHELabPnKXFbIfXmrTR+Oo3kF3WA5Q2EVjcyE/z
         7fzy2EvPjn9qTEsZ5lS8b0Eo8lGWXym7KNLIO5Iw6PDbY7jmFGLFuLUj4dw9mvtbufUF
         3ZpHpOLA3juwCvgjnncDk7WsE206I/cgE08uEpK6JYL5tC6fRAHnJfcgA6WVxQCcPgEv
         SWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781572588; x=1782177388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhNmHmJTzevaW5Ie0slFVTtwGbX/K4JKnDxjqTLGpkg=;
        b=L2naL9BbSmiUBL919a0F7CRNpJUTGVXxoeIyAUdcS5NcYC2lsduo5wncDkxGxkmQe1
         AsZEQ3McjB/TJBzWJ9buHNKyOw7RImt7etJi9o4rAGnJErU+0NlWSIFfv+AMai1ulQ6c
         v2ngNY8EJ/mZEoWUolLvJ/pFqwVgyF2WxN9CEiI/nI1jGo4lYSlSlqN8e8pf0rIj0eEu
         dsLYA8blRQtz0yJie/y5IkffdYDnIOGlAXtDgW1A1M2aiGiWJ43P9OtRLgaIOytyKWNm
         oQcobz0xKR/PSARS0EOmv7Vii8JUXg/z+Vn1YAL0/kl0Ot4WQo6r5B2wXeRjBqJOwvC4
         wdYw==
X-Forwarded-Encrypted: i=1; AFNElJ/jHUf1ks9TNYlB6CsC2gcLC0JXAJD2VI5DlHmwKCPrk82dHY19uLZYGWEJ7OEzpX6cF6SXxrSi/fG9/ijCY9eg@vger.kernel.org
X-Gm-Message-State: AOJu0YzyjP9o85t0jjIBkl3+uKG33LACfDc+RL/h+V34+D4CAj2o1HJd
	RyqaTFSrTYQBr1Ekg4ZiPdmHcmz2Enr5OrUQ4zNjNoZXk72WJVdICkx7RSdYLyEQ69mAhe1Hbh5
	tDdxkpNRlJg==
X-Received: from dyhd2.prod.google.com ([2002:a05:7300:8282:b0:304:e649:3ce4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:9e43:b0:304:cefc:5fd7
 with SMTP id 5a478bee46e88-30ba5fd3dcdmr898035eec.32.1781572587774; Mon, 15
 Jun 2026 18:16:27 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:15:40 -0700
In-Reply-To: <20260616011543.4037138-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615223011.3873955-1-irogers@google.com> <20260616011543.4037138-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616011543.4037138-19-irogers@google.com>
Subject: [PATCH v21 18/21] perf python: Handle Py_None for thread and cpu maps
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
index 3a9f4e35d0bb..4ec5a91d45c0 100644
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
@@ -3341,8 +3341,10 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
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
@@ -3375,8 +3377,10 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
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

