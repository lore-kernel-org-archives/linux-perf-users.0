Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C35622652D
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043406; cv=none; b=eDd3iaHS+gkFh633YtbHgGGtn8/75eaee6Wmh9Pu8zBKN8B3s6Dl/gMRuJ0LhWP3JfOvDzGTA5iK8Rv721uMXTj8pehT8DcwLmz3B6Xf5m8b5OZ9h8Qev5G9rxdVUav25JuXOGrT3g2ZhiYgQCU1zJDHobetuS8GRYUc9ZWvizo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043406; c=relaxed/simple;
	bh=+R1TjR7D/n+SVy+MvcOVgKHmNVERa5SqQsXwquU4Gqc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aIS5IIfOxAk4yO1ypyL1A08nWDNorZJoaVloky588Lce3Pe2stVAf/l+HMLVjgMFSAnrVPMcJyduKz7niTGJ8YRdmlFoERG9GOuv7s1BBwOO05M67ENDUYs4v3HRR6TZ1tZ4oOZoAffZ2OdbJKMFGJ5snAKuevWO84kNpDt0cto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aruvWU3f; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aruvWU3f"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c28353912so6250412c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043405; x=1776648205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I6cwCi85nL+UMzH5dHBjsjgh7zFGt951FXHMXIOHqdc=;
        b=aruvWU3f5RJfrQ7Fpsp5kNoVwvW2SkPtuvqprWP+BKYdh0epXLLeRtzNIy0YyT6t9h
         HRyxROjkJ9KwLuowKQRkRSpS6lYnkz/5idJw/rLNQ22UXJXdKKROWtqEVfc5cTR8Q7wW
         AyyPOXtuCB50bXQ0XNiSwumWF4tLrIJ/CmUs5TSRx7p0krl10HUve+vCZoj6CvWvhwoL
         1fPsfWtbGk/29mmBaIvsN8JrqumAGyAIJrsORCpiYEMpFATXZsgqgBLl1cNxv55qZfpe
         z4p2AeDXt4f6Oj92OwUhs+s8ROgqt5cqrWk2yK6BQphlxocN9sRpyNGmGsJQ4K2y9SyV
         NqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043405; x=1776648205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6cwCi85nL+UMzH5dHBjsjgh7zFGt951FXHMXIOHqdc=;
        b=RavG3RtTEyNIUfMvaehwcNRCXFi6aA0G9uDQ7WoaaXVJrvjdwoJtj+5HhBZulF2zRr
         iRGwDYNzaHvn/f0xVOpAXYAwJnawmoc1mMXSkxMIoS6Nw3D4mJFe6dL5qcXjNpoykR0u
         QQPX698Y+2DSsD4Kj8m/AWwGp1+A+hFzx4iz2qG0yCqds6fAn3TH1zgPxOg5xYFndm5/
         vQolLow+kr3WVrSmA5R4uqgx22Rdw3YKSJIebZd8USBYeQMlAgiMln12BWEcwt9WY6Cf
         v1TbiOCDvLl69804M/5Mlw2qvsBlhdpEFM8cmbEo5ddRaPsEso3cTj4u5CTG6fMGGror
         8rrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8G/kpZQwfvhyCgc2KrpWaiY8tAFudpggTjA0SvJY+JhaDS/6qBO6loBfyXqvyW8UxVTL/SN8b9lHKcyGcG+Vs@vger.kernel.org
X-Gm-Message-State: AOJu0YwC+tQ80WUQrSc5Ovdg+1Nx9EUQL3TPKQNLI7TAslkraYbFGq/8
	LKBNNVIi9wvAkCOTs/NG6xCULmc85vUDlzA2JiQHT/ALAZFvON1Vad1qzi3JgLgsQ19ZsSrkp61
	yF5kr5aMB2g==
X-Received: from dlbur20.prod.google.com ([2002:a05:7022:ea54:b0:12b:fc23:6fcb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:411:b0:128:c9fa:4c32
 with SMTP id a92af1059eb24-12c34eec551mr6848923c88.28.1776043404371; Sun, 12
 Apr 2026 18:23:24 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:18 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-25-irogers@google.com>
Subject: [PATCH v11 24/33] perf lock: Avoid segv if event is missing a callchain
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Sashiko recognized a potential segv if a sample is missing a
callchain. Return NULL for this case just as a memory allocation
failure does. In the verbose pr_debug output describe the error and
rather than fail the entire file just skip the event (return 0 rather
than -ENOMEM).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 89a40d385b27..064b3aa4bad7 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -938,9 +938,16 @@ static u64 *get_callstack(struct perf_sample *sample, int max_stack)
 	u64 i;
 	int c;
 
+	if (!sample->callchain) {
+		pr_debug("Sample unexpectedly missing callchain\n");
+		return NULL;
+	}
+
 	callstack = calloc(max_stack, sizeof(*callstack));
-	if (callstack == NULL)
+	if (callstack == NULL) {
+		pr_debug("Failed to allocate callstack\n");
 		return NULL;
+	}
 
 	for (i = 0, c = 0; i < sample->callchain->nr && c < max_stack; i++) {
 		u64 ip = sample->callchain->ips[i];
@@ -1059,7 +1066,7 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
 	if (needs_callstack()) {
 		u64 *callstack = get_callstack(sample, max_stack_depth);
 		if (callstack == NULL)
-			return -ENOMEM;
+			return 0;
 
 		if (!match_callstack_filter(machine, callstack, max_stack_depth)) {
 			free(callstack);
-- 
2.53.0.1213.gd9a14994de-goog

