Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8F73C6611
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781334709; cv=none; b=WdVHCYhcgpwaEZjdr5jrJVHJ66uq+7riziTnSW8FhgM2On5ZduvTSBYblqcvxiF5okhq0pbWF1nErgZdRPMo1AfoyWyCiHD9S0szGlBhcQVooojNRYj2N+7Rk4Cuuih4FcnqhM8WguV2Rv0e4AlLSyuzyEL1/nPlrJvXF2HaSAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781334709; c=relaxed/simple;
	bh=PLF4WJXZBpORTZ2JlH+GCFFWzFf6msVG7RwS3W4YDmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hi3G9utEuxOgamTnFb6SoVqGvRVWCth2OF6/NAsw2tU3GtzMQm4yEhxdsr2ekeDHm6A15v+hypd/5LTHUYbvnyffbaHy4z/CVf0NU6wxQfXb9BcyZ/L76YNQFm3WNjkDc+1xm0FTk0grsPo6DfzdGXP5OIA6zrWqMEdXkpwcsfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9eSIFs7; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9eSIFs7"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304e7fc90b1so1998327eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 00:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781334700; x=1781939500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5FmwGLPyViUdq322mofgfDRvlY2+s3k9Pg5JyAuFQcQ=;
        b=B9eSIFs7l0lFHRfif1ABlwRcJMDv7DdIs0lz/00xFabeEKua04ek7G+V6gW5HiP3IA
         S4GWC71/GomhnKzQFAaCx4Jf9pxOeBanR21tIsTShYYYUL//Nn/33m8CCmjZsuO/oISE
         WPYMMUdVe5kZmvxFOYko+UR3HpPYoKP7aBxPqeCO6zxnjxIvXZuIVP141om1ylfjzVIV
         HY4yPSX/pWfVts7cP0n3b0LtfcfkFqhGRpvzrxjnVG1MldIg+BdrgJ64s9tT7aXfmkit
         8n51uc+xm3np2RxO4+Gkmjvz+e15RRApirE7brqXvAm+Hbu/7aOGbHWX+/RoHy6mjEwi
         JA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781334700; x=1781939500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5FmwGLPyViUdq322mofgfDRvlY2+s3k9Pg5JyAuFQcQ=;
        b=KfSFZ1ylHXtwBvpIpRbnsk9tx/u+AIjxEnaofDTVK8fgDb6CzoS/DGYCIjDNxkASQZ
         qitQVKNjrVw2fN/h093BCOnQDLpqn5BVYhQXua0w1wc5XyhfeN3bYXatskEc9bIXh+mr
         PlP9B80zGMBi76124oBqX5YY68XL+e+7vuQH6c4pPfSjcB0SNiV0wrsqkVRI7bml3bF4
         FBuoJYwjmdisiCcxI38f2xyYQJjCcCquG4Mr0L2Y3+yDnn5AJpEbLlHPf+ZzsnU/CI9f
         KkS2krCttiNcMzFrzHvVZlpIH8i8r2s2MAmw9zEeqydUsw4mP0aADLTPbp4b360vyuE+
         6gVA==
X-Forwarded-Encrypted: i=1; AFNElJ8LQZttLvY3AfqfOzXRGQs/U4M/S9oowj7wX4q1QdfUcDfFH8b5lg/t0Fcbw7UA7kLz65ho48sM95qSk/ZQYbQj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+L0CXwILYxRAkBrQw4OI1o3o0GbPitTZLWbfh3UOoMYik3vNC
	yc3/kXaT+/2SGYQgB89U84J6pEql9Je5xpavpYFr/H7a+9p19lgn/BipgDHvyd1iOQ/hD66sxME
	Q/OJxNOQtZw==
X-Received: from dybvc22.prod.google.com ([2002:a05:7301:5156:b0:2f4:b34a:2550])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:511:b0:304:de94:1c55
 with SMTP id 5a478bee46e88-30940542b00mr1654679eec.35.1781334700147; Sat, 13
 Jun 2026 00:11:40 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:10:58 -0700
In-Reply-To: <20260613071100.1508192-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613052722.1424093-1-irogers@google.com> <20260613071100.1508192-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613071100.1508192-19-irogers@google.com>
Subject: [PATCH v17 18/20] perf python: Handle Py_None for thread and cpu maps
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
index ee88b3af98e3..8d4877148aa6 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2086,10 +2086,10 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 					 &pcpus, &pthreads, &group, &inherit))
 		return NULL;
 
-	if (pthreads != NULL)
+	if (pthreads != NULL && pthreads != Py_None)
 		threads = ((struct pyrf_thread_map *)pthreads)->threads;
 
-	if (pcpus != NULL)
+	if (pcpus != NULL && pcpus != Py_None)
 		cpus = ((struct pyrf_cpu_map *)pcpus)->cpus;
 
 	evsel->core.attr.inherit = inherit;
@@ -3335,8 +3335,8 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
 		return NULL;
 	}
 
-	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
-	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
+	threads = (pthreads && pthreads != Py_None) ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
+	cpus = (pcpus && pcpus != Py_None) ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
 
 	parse_events_error__init(&err);
 	perf_evlist__set_maps(evlist__core(evlist), cpus, threads);
@@ -3369,8 +3369,8 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
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

