Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0342B401A21
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962666; cv=none; b=Tvpkb2PoiLFkpIwB04+2XbFgxMdqi6SaluhPbdLMiceJE/oBerN9vkIyyacA5yGUBLVdDiJ+Cp+9PPtp7hyBLbi5NbHlvU8BhdAjLphUREnU5ETjsQbyn24UnpqLTMiObvgz5imCpR5u1UXU2oSry4GSYTNE4tF3rPdQzGDWf3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962666; c=relaxed/simple;
	bh=RCv6opy0rOqvlNj5z92+NzI29eWRQq7w3cUzbQCiF+k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BRQ5/8JuqlL6w88fFctVZ6SundX/lwBxGHxxZaGDGgTE3EEjKaNKEt7b5cNovq3bcsbQobuBb0YGUAxab0LpG+6HJUttdEeXnU3rq7jeoyahnk7RwMu0rnHov+dlbUuV/RUTsqEGpJFzRj5yuoLX92XAq6diFaIYQxkq9BUY6XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ELcKHMgB; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ELcKHMgB"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c1030ca85eso8298858eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773962663; x=1774567463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d33AbYDTlaS5mB4Y5js7O+MGtwScYB2I0WrPSaITagA=;
        b=ELcKHMgBLcJMJsXxpatr+EkTjk4v72LTHmvljFk90zYx6Xj+4R33RJ8LeAVmyUgsvl
         IEgCt5Ls14wA7oYlpOYdRnp3ZiqCisrnox674Y9+eFb3YB0hYJFBcfXlLGX3gPuoLypb
         9z6qHyQqg4AKFM1kyl5+qjh1Gbd8VQ1HuRhbomCFC/rpOSEKMOCbllig/EOd1ByJCvPS
         2DkubAeVanRMTNuCS+6XYHa1rNUrBKZXKzWfU5DT+V6U+UbZJgOleqq4yFXaVCUpafIm
         RVjGO89VZw05lqM62dZ92sXQZmYZrPfnMO2skWpaLZQJeU3iplNjhVDChye3NCORdN75
         T+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962663; x=1774567463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d33AbYDTlaS5mB4Y5js7O+MGtwScYB2I0WrPSaITagA=;
        b=nyJGzyPhA8ZT60TTwSMh1NaYk0KkZ0VAtlg4JrVkycH16Pa2QBXZy5CShEmtk2s7FY
         fv1kpAyOGKwGvNPfLF1CXHrekPB6fbbF9OyuwZQeME2LuvZgXnwChRuBzFEmFQXBOy0g
         LyeA56YPXH5eZDaVZP7psyQe5McRR/89VDGKig+dXWp+M0nPHXzSJm5+uXuyNDUXp/In
         UW/u18KMlXxZW+eCJm+wFBWSPgoJmGvV+EcXRjpf3IvvhjV+RL/BPorKCp0dwXCEISXW
         UfvMUKn52YCz4NnwzhIKcohLlhTWnjOZub7HM4GSyJnPktdBDZCCCm9QXHYyUjvgju01
         nBjA==
X-Forwarded-Encrypted: i=1; AJvYcCXr0vKV0ier5CbNa/73tUdWC9Dk5be6pdB5VwIjy9paF8NG5sBIN8z5hRKdPY4hF9N/8bdiQI02Qmbl148uFnhG@vger.kernel.org
X-Gm-Message-State: AOJu0YywYXutsWNgO3SmRQclxM2DA/0Pa6qgxurDwfJK6DtOuiktlwms
	cgG5HzRUukl4E471Vnao+rUJZElGnt7YLMiBqN5Q7sC6O6OBfHhDbAUQjDp0D9lzJzHEzJ82EKj
	Dx6mHn5Ddug==
X-Received: from dyckg8.prod.google.com ([2002:a05:7301:d188:b0:2c0:b1d7:935c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3252:b0:2bd:c285:2fe
 with SMTP id 5a478bee46e88-2c1095fa7fcmr635808eec.9.1773962662896; Thu, 19
 Mar 2026 16:24:22 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:23:19 -0700
In-Reply-To: <20260319232334.287517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <20260319232334.287517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319232334.287517-11-irogers@google.com>
Subject: [PATCH v2 10/25] perf lock: Constify trace_lock_handler variables
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Structs don't change and so constify.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 78fb39d06e7c..735e6bb234ae 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1179,7 +1179,7 @@ static int report_lock_contention_end_event(struct perf_sample *sample)
 
 /* lock oriented handlers */
 /* TODO: handlers for CPU oriented, thread oriented */
-static struct trace_lock_handler report_lock_ops  = {
+static const struct trace_lock_handler report_lock_ops  = {
 	.acquire_event		= report_lock_acquire_event,
 	.acquired_event		= report_lock_acquired_event,
 	.contended_event	= report_lock_contended_event,
@@ -1188,13 +1188,13 @@ static struct trace_lock_handler report_lock_ops  = {
 	.contention_end_event	= report_lock_contention_end_event,
 };
 
-static struct trace_lock_handler contention_lock_ops  = {
+static const struct trace_lock_handler contention_lock_ops  = {
 	.contention_begin_event	= report_lock_contention_begin_event,
 	.contention_end_event	= report_lock_contention_end_event,
 };
 
 
-static struct trace_lock_handler *trace_handler;
+static const struct trace_lock_handler *trace_handler;
 
 static int evsel__process_lock_acquire(struct perf_sample *sample)
 {
-- 
2.53.0.959.g497ff81fa9-goog

