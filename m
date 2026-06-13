Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495843C988D
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781328490; cv=none; b=EGV/cwfbEL8nFsPvRrWdNfgtigydDTczFUEXDeNO1NDRxqP6QXW4MHVPZYF7V6d8S0MkyqaMEctEbE5+yqxMVxXeaTlXFJS+kpZa7KPSz95ltHl7tK8C4nrmPEy0prpUHQxEN6J4QGy0xLMfXtSNgAs5N2yWem3+/ESPOotAI14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781328490; c=relaxed/simple;
	bh=7GAROG8vQlF3QxiBS1xuvmsNbjXplYgC0JokGTJtl4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ewC1IEnQEvcbweTy8lb7s2bnXu7AUq4oXi90fERcTlTdyPXj0/ByanPfEHpUcUtjxOpOGahSW8HJ/oTo1IPXnUhUgHL0ZIPhQNIcye2RxqmjTMu9PCVxHuHJfgU8KvO3DgOnwK+NSd7yYMYCFds7HoJGffFH1MkFn9+s2E/bcZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=owmLh+cJ; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="owmLh+cJ"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30761ab3483so2270530eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781328483; x=1781933283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CLRif5RgnHZwJcd4qbDUbeN9NBrzn7oTgH55SVS3nlA=;
        b=owmLh+cJ3UZgPKRXoXS5H4e5ZnSeu5rTjA20E2Y/UF31wzXKf5SQ6TIz4lTnytxUEq
         jGRON3yggpSKbEF3+Vjxj9FWDg/V30JY11IYOyMx28nEOoUElre8vDKok89b+HslhzOu
         cALXJBg10Vs4JcLVpgMjm2g/z4XZoWE77Dvsg4ri9z3yUpmWTFlCIeMdzRXUyraN095Q
         8hQV9bHNSHPl0upRrpojf4LDLYwF/EIMiYJaU7HgNvL1ZEgtvRaLaiRPfJk2UzY/PuYe
         SaVc0pm7GoNYBijA7+n3LpsxtrBzcajRvqn7cdfuPLKSiDF7WUDnf6Ifs05HPZVQObjt
         WbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781328483; x=1781933283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLRif5RgnHZwJcd4qbDUbeN9NBrzn7oTgH55SVS3nlA=;
        b=C/jHdHZQNrbSvf/qlDhFjvWmt9dLTu7iO4QGdlYUKYIl3dcb36ZmEeSyJpIlixJiQV
         2BeuCMtNPlwdl8HYn4ksOd4sgkE/RBcJfE/5pV68NwtRI0GYDmfp4bQ1XEtSth7duwVO
         VvYu7Fed7jgtPqMO5UuLxYKwwcAPiQjpCvRX06ftZuJAHtygsG3tHqIN05udx0qs82Y1
         Vz1Nv9o3bvYVBbpGHV+JZIj189zuaOyRvWvF9JFw1QpGoc+Yex9v0cs7wbu0qJOmXkNK
         iOfTp3AciYABlcPeBOXL20NziAOt5BxFdtlxTUdzBsYP66QtBLPIthrGK6R7db46ngTj
         klKA==
X-Forwarded-Encrypted: i=1; AFNElJ9HSDax3faYGMrLbGOhK5YwR4Qe99DBt2JA9OAM0x03h12KqXS3e8doh/T0ywGMw4JkXF0ln7llVBBqmffdkBro@vger.kernel.org
X-Gm-Message-State: AOJu0YzBtGRMj1KaoRoWrsLlI1+HiE85gzPgszOoWs6iikGUCIu8D651
	vYKVeikifjezxIlKNfnxlJ3UkwiTMaRzMFly5avtKKRp5YJkLphguO8ees48J0+hREbgLPcjFLY
	y68h2ipV98g==
X-Received: from dybff23.prod.google.com ([2002:a05:7300:bf17:b0:2ee:de47:cde3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5415:b0:2f2:5c68:5052
 with SMTP id 5a478bee46e88-3081ff744b8mr3178436eec.13.1781328482851; Fri, 12
 Jun 2026 22:28:02 -0700 (PDT)
Date: Fri, 12 Jun 2026 22:27:19 -0700
In-Reply-To: <20260613052722.1424093-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612221211.1221305-1-irogers@google.com> <20260613052722.1424093-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613052722.1424093-19-irogers@google.com>
Subject: [PATCH v16 18/20] perf python: Handle Py_None for thread and cpu maps
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
index debdf0aaebaf..1e5aa7457043 100644
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

