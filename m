Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A2142CAEB
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663438; cv=none; b=YxzzTXbCLh0W+q0dNOjpk0dc+TiwPDRp2jzldRHI/+2avLHjMP+F6edYBh8neDQZXv4UYTO+b27YVE3hIfGNP6Kg7jas1e2XBZZr67dT3lQeIlhxg7eg63oEh1M2qsDYxVH2GwjY44fiAnbIRamFIMR/8cgWcpA7F3e9ZSFD0kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663438; c=relaxed/simple;
	bh=EzNAQc+zqELLfEsqlQ1kpZ+oVvfzTZI1o5rnigTKwoY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VZtfEi4kcAVsgU8XtwXNYg7rdE7Xa2/GDFlQEcCi+Lwb9C7BKzSByI2K9XNuhl8mARwue9nYLDaF6RU7kwS3sB0iVE8vdtHP/dMRqj/nnc2MGcw+CrujEJalZJZoXPaEgqHYH95C5DJIkwKTgrDxT3THKpPIeSsnN69om9qiLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v76FC8Ya; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v76FC8Ya"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1466ab2bc8dso1373089c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 23:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790663436; x=1791268236; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4/IsA7upi/zbnOhoxbNy0tZ5zJbyc70QixREWB/C8w=;
        b=v76FC8Ya6apNgp/B3qLbqj4zK4dOBTbNl3tyoDJOa7msO99Pp9h3yDQD1d5PF9e8Zm
         WNL3m36eyTRejVeVmuUKYe32qR4c6dO9LP0phqR+sXrEmPSEbXGCBnx2O9NcnDVMjTpF
         Louk7DwMN9wpkabiHUl50voRW/qxnFVZaNkQzUPyYIYKp36bb9uBNZo5DHnPaSPxFSjG
         ourk0Zw+h/cR2N+DXs83dNkfbIJXLlcQl02b03LjSLCohOh7BM/D6nHFMeACCY9oe5u0
         UBwBs4qulVVkDHaOkwB3VOk6MSR+MeT9lJq4isgXlbcxvV2V6B+pbP+rSHYiiurXwpkX
         7Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790663436; x=1791268236;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f4/IsA7upi/zbnOhoxbNy0tZ5zJbyc70QixREWB/C8w=;
        b=2qBOFVppgMBT0lVh2Z7zvL11LAvRIyT3Cp81v+tF8n/qmVXheh7DNIPGkWJKVXgfpu
         bczjGkQA7UjfALpBNLl9wngJYhFCfWaWdCfAXX85t0BYQOK0ZfmpJRn6T/YiCb12yJrw
         U/AUEpUQP3anpu05efxUi5cTeiG/YpugyHLsBgzRZ5tstW3fMgQlfumGwGGiKIlk3gvp
         GjCCqVK2od0JZ4JyctWpGhfR7vOwrKjKfuPefTFnY6Wa1+22zzzD6MV2jtwK2ctWLEUf
         lbCpIL0B3QAxPh26+CgijfVg4HlEW9RI89RQIyHPvWpYOxVxSkWyxv0cj2XXsjxhsD+9
         7A0g==
X-Forwarded-Encrypted: i=1; AKwUvByvZPL5zRXB7GjjfeDDhGUpsOyPy3gZQI2NuVpZAy5E5a25e4g0HPsVBbyDLRpiAKDApr4icxgRI1dThwuoRrEG@vger.kernel.org
X-Gm-Message-State: AFuF++nhSCa6NZzGu9g/IxwODF1diejhTjPsnbPDkYQhY8xEFYRGjHKa
	wI8OhgRK1R/Q8KNma1VFpJG5heG0jYbTefSz1DTu9i9rUa0jODRDc+dpqoSDfMPmWG5tRnV6Ppt
	1Uldvl8sxYQ==
X-Received: from dlbsj4.prod.google.com ([2002:a05:7022:f904:b0:14b:229e:d8e1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2059:10b0:143:298f:33b8
 with SMTP id a92af1059eb24-146d0f32cacmr12559121c88.44.1790663436160; Mon, 28
 Sep 2026 23:30:36 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:29:36 -0700
In-Reply-To: <20260929062937.374137-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929021913.56010-1-irogers@google.com> <20260929062937.374137-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929062937.374137-9-irogers@google.com>
Subject: [PATCH v2 8/9] perf python: Initialize debug output on module load
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Unlike the perf binary's main(), PyInit_perf() does not call
perf_debug_setup(). As a result, the first warning or error printed from
the perf Python C extension hits debug_file() with _debug_file == NULL
and emits 'debug_file not set' without a trailing newline before the
actual diagnostic message.

Call perf_debug_setup() in PyInit_perf() and add the missing trailing
newline to the fallback warning in debug_file().

Fixes: ec49230cf6dd ("perf debug: Expose debug file")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/debug.c  | 2 +-
 tools/perf/util/python.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 6b5ffe81f141..b7095519419e 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -55,7 +55,7 @@ FILE *debug_file(void)
 {
 	if (!_debug_file) {
 		debug_set_file(stderr);
-		pr_warning_once("debug_file not set");
+		pr_warning_once("%s not set\n", __func__);
 	}
 	return _debug_file;
 }
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 690a94fb4f62..95140dfaef9c 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -5157,6 +5157,7 @@ PyMODINIT_FUNC PyInit_perf(void)
 
 	/* The page_size is placed in util object. */
 	page_size = sysconf(_SC_PAGE_SIZE);
+	perf_debug_setup();
 
 	Py_INCREF(&pyrf_evlist__type);
 	PyModule_AddObject(module, "evlist", (PyObject *)&pyrf_evlist__type);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

