Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719763AD51A
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 05:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192958; cv=none; b=JFllZftQpLYDYf76MYb23yA300ZabZOTHrAYfFb3yC0hFzkHbumRg9n1NyPVm7BDKigI0Hvt+lPFrMLFlMhQOx5BFdMbgCrzuKtUAuI2Nk9fxeo8iYOcIuMV/cfp4fD+pQB3CTURgtM5jW3I7aKRPIIEJbwgIMrnLuHTnK6vcpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192958; c=relaxed/simple;
	bh=wSpcBU8iKtPs4xGeTTYUvSrhHezb9JAwl/ZDXgglsG0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JwYXA5Z8wfHKM5kxhgKTVvZTjr5L4L83/dV50wHcbnnMUcTHbGXGFT7aoSWpTeCFlmnn0ku67x7hi2jvUVdNZ3oO6azRL6tTsCeEHdvDTljOzSENqzzzsCyZdSzSPaeZPbyGWdm4wBBOS33hEuX5pNoZOdhliJ2Ra8G45vgzkdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tiazY/eq; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tiazY/eq"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30c5978b108so324490eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 22:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782192956; x=1782797756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BkI8oQZxv16EQ4za0fOcpIRE2TUNYWN0ivaDm6QhIL4=;
        b=tiazY/eqDwqHnl64pehGrUMuV+lTLyXczTmklzT1jSRNzhOSyVXR0jfllzKI3NRazJ
         ilNwglw7kJVhnEDQy7T3bN9w/Nt3j4NtFGIGscQD9hkiq1KVIuKazVZxn0PYuLQWLPmj
         u8y3JSDblarKdkuPjvC1Q1KU8/3d3VUlv72DgvjLQcWP2OT9pFsOL4qQW6cbdatZIgt7
         qF4Dl3g6XiAEgeV9nvaLjdcnOqrrCO2WMLF9/Y3eYoNxpCo1z3+Cv3YY/L6OUE7lNznV
         JVuMVPwqsf2cNPlZbWjfHxtPdfprMRqws0Lppsph8gziVwWeydgGfTnuM/ADcoF5xD4D
         1JqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192956; x=1782797756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkI8oQZxv16EQ4za0fOcpIRE2TUNYWN0ivaDm6QhIL4=;
        b=f6gJFtAXoDmZ51HbM2fnufQ0HQohB4zV+ZbXdyDNa71GsgF93HJv4P38s389UvHklr
         sU50Y8aImjvyZoqAAgmIesglOAEzlrmsGMuSY+MlExf3j/wx2DuHqOuLCmxrf2Bcy+RT
         SiAdyset0/45bbPkU4tfIBlJ8g3SByN483DGdxzmguMEmZu01UpblaO2E27kw3xEzsed
         FHUvfF3VTvjZRrWjVv3ur0AnqIcno4Ya2HJuqBuZ66I2B4ZqQeqJ/VyoImQNgko1hZVS
         rLJtCjfxTwiJ9CXV68tyq9bAKAIvdpwplyk0S6kjjKJUPZoeZIonPHgImlKEw5b3Jfeg
         gX0g==
X-Forwarded-Encrypted: i=1; AHgh+RqH76dBdWDMa06wSxHAmknQdDjaTzg6FYRGe0XICxiyNgAi96AaeQFqcOI2ScS4f6gfJmqAyJLsytNd59Fu9Nw9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/XiO4dL1zdKV2YCc0ToA7hs6h9yzlu9+kzhgt6Q2HG6X5Hf3G
	t51zLaKD/uJ5JPA3+gqOw3mmvXDNeoISiN2IFf6vtY9luf6sH9rqP30HLeQfVfhCgS8joogX99S
	cLKeFATE/4Q==
X-Received: from dycmb16-n1.prod.google.com ([2002:a05:693c:20d0:10b0:30c:c25:298b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4312:b0:304:e2a5:689a
 with SMTP id 5a478bee46e88-30c5b8d35d7mr854064eec.21.1782192956198; Mon, 22
 Jun 2026 22:35:56 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:35:14 -0700
In-Reply-To: <20260623053515.2677888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623053515.2677888-13-irogers@google.com>
Subject: [PATCH v1 12/13] perf python: Add thread uninitialized checks
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add CHECK_INITIALIZED checks to the thread attribute getters
(get_pid, get_tid, get_ppid) to prevent crashes if they are accessed
before being properly initialized.

Fixes: 3b96bf7af60d ("perf python: Add python session abstraction wrapping perf's session")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 03b4e8809107..70f985ad3dd2 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -3743,16 +3743,19 @@ static PyMethodDef pyrf_thread__methods[] = {
 
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
 
-- 
2.55.0.rc0.786.g65d90a0328-goog

