Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695DE370D7C
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994142; cv=none; b=r5KyCof39zYK7c6ABF7Qeq8XihPIEO2JvrlkRoexFnbxHSkhjk0iqtQSo8N8KjmEzL7J+wb9omzHgKUGANo4SJeV4j2jDmG4ukt4HyHsT4v2ugqOnhlvzl6H/fnoyzm0StbrG4qJrUfmOVm3ia5RVA4WwtNvPgPprxfNxGTxb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994142; c=relaxed/simple;
	bh=RCv6opy0rOqvlNj5z92+NzI29eWRQq7w3cUzbQCiF+k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DSklJzkKEQOGInEiWnL/ztf7CLSRnE0XLam4789sphoD3+Za+tl/VlnLh0fCcJKbfNnOASM0dhvVzESOcBkKqjbFp3+AbYvCw4KnX7vBnwwjY9hlD6WBo+3QJLMcaeC8nId92sXExGIwf1xX/MGCZdSXKoWTRrBJol2rAc+wNX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FXzff5BX; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FXzff5BX"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-128ba70cc99so1144961c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 01:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773994140; x=1774598940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d33AbYDTlaS5mB4Y5js7O+MGtwScYB2I0WrPSaITagA=;
        b=FXzff5BXSe9yBOR6ebidVHs3pFoFQfZfna38FzgGpo5WzzlTjwVhbzpYNAIi9/vHwR
         OkVhq7jv+jIga4n0jhZbzZGtobhD9f7V/LQ87WsJJk+VJFz8kLQDjbqBtRhVo7DFuV08
         JiLK6mY5XRagyetE7BAIOMH+mdHM5vwhX6Xvmndyy+Fhn2x/3QoIR5ZRwtBz/Bcak3W8
         WmH76EHv5CgpEY0BjkYWcauXe3J3TPztZ6Qtgj5ZAVwNuL/gpq2OhBqk+aHC1zLaZdav
         tRbCyaaHSLnBFH585N62uODA/ZUby0MdOtZtjtBUgCML+zanxsvET6USAW28nKe+/p9B
         mdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994140; x=1774598940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d33AbYDTlaS5mB4Y5js7O+MGtwScYB2I0WrPSaITagA=;
        b=GY51kURh+mYlxZlz0kdV1Dz39aOlLgEG1Y/O8YNglBbhTS4pgpaXf+eq8BN5t+BwGz
         gCiV+2mRk+nzZzcgyiMEFwGnw7O7Gf0BeL2QZ1ISqWu1daCvXzuxWL6FqE990UdNuOhU
         JDupEikxJlYQ1pna3QFGrXt5Xqu5YEUQRQxs8+Midti4jpkxusKQ29AgWI7oHe+CJmya
         uNBIvrNpK0gh0sEUyTT2mNUDhpqbDKBWNHWvUpTRCO6CvCApa7pei/Ub9X6UovKUKohz
         R9uRZ6EEzIaes+4T6wr3Nb6RP6NhHp2Z48R5wvkYPVCT0mdQiISA50yha4+wUsXbxp1L
         geJw==
X-Forwarded-Encrypted: i=1; AJvYcCWLoad9HM4+tGda6ApBVkkrupWdgzuM3EhdA50/DLWJpgunhX2C9GNe0OT6HUPL/yPLX6j6BZ5UMk/Wpyp+qCGk@vger.kernel.org
X-Gm-Message-State: AOJu0YwojWgEpLPM9Cq16pNu95YSBR1CRjYgIq7eMHSb3Q4jbQRTkSzC
	H0vqvOs0PEhOOlOkh2j8B0u2w2CCMW6B2lDrPTEnJwZ0ydWvl+CiirbtK32j6lVuokklcDUMvf+
	HZxRTkmK4TQ==
X-Received: from dycok24.prod.google.com ([2002:a05:7301:db18:b0:2c1:88d:a44c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f9a:b0:122:2f4:b251
 with SMTP id a92af1059eb24-12a726cad77mr890039c88.21.1773994140230; Fri, 20
 Mar 2026 01:09:00 -0700 (PDT)
Date: Fri, 20 Mar 2026 01:08:19 -0700
In-Reply-To: <20260320080835.724836-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319232334.287517-1-irogers@google.com> <20260320080835.724836-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320080835.724836-11-irogers@google.com>
Subject: [PATCH v3 10/25] perf lock: Constify trace_lock_handler variables
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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

