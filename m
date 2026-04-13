Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8488D225397
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043404; cv=none; b=VJwnG+uJUGcty2f99GrA0X9ifjsXNubzNJaQAiRXbFOOjVGTqk7BxQRBFpxC64eht3/B/I1NWTAdMifltcdXDVgPYUHTUMrVaq0y7aaTOrByK3DeEEDdAV7s4Y36RwKOy0OGVq57OgqShxj8kGRUEiEfFlDpeYn701ta9nICquE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043404; c=relaxed/simple;
	bh=/TJHliXZNcJc0WMzmCn1uj85dssMOv30WvsxQWbGYts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CLhWK8ILHbFjKxjUbIgT0/s1Rx1RcYr9I1MxCRPeIINeWpJ8i9Whw5CNfVVCQAxMGEYQyZZiVyf3aWVa1+l6+SRO2/dHVXvTeW+yVgKk7DO+vcLMLrXKRtclPzQeiS+peTygkp64ncy0rDjjruScH+1kfekz66ShiAEpwakWYEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ho9+dIaU; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ho9+dIaU"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d70f60aff7so5830906eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043403; x=1776648203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ky2umPzRcxH/XBrATEo/kk5mztVaDExoaZNmlerHag=;
        b=Ho9+dIaU1j4N+OCKXy/QjT0MgW3VnEs4SuMt8lsg82c+auG0OK58RaJpJfImC7N8vZ
         sd27t7KAzJ7X7tw1t1iOdJdLMfGPTTSXRfYCGqApKO23onrHEUNLiuwF8t9qKTLR67OR
         /DFJeS4sYt/cpSKBUTx/OXzVb8zChXvcznaY5Mi8eJFG9h+qBsvXAjpJ1g/McsZsiKpY
         ujvF8SAsMbk51c114biiR71TQaL+hNf2K/X2/ph9ZesUm4IUvVfCDWppzlsmiOVCZjrE
         OmKO11coo/sqXMmrJFh8TinD58PA/t1y3B7SyuI9PsfcY0TSwsWNteAKQoahPcUCOO2a
         rE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043403; x=1776648203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ky2umPzRcxH/XBrATEo/kk5mztVaDExoaZNmlerHag=;
        b=WHYK7662Z7gQ1RdTjrnGEW/AaNrYL1VBUmkNW8WWviN2hm9fmq+0nBydqrlKjLtRl1
         NZ+8fwImF/yNPmPRaXCV13DGvHZyHhYbBIQ3c5mN2n6dxpF0qvyhWrBP1b3+qbvd/+Ag
         Gt8KpLugMm+cCnWAk4QaRjlvNKW917/FOmrIIOm1uQ13k5twe3hcKAaoIS7jv4NMC4hN
         Mv1vsu/HA7Fl4xxVAqTNFe8P81nfYHr2UnGLISpWcNk/ptofHLf0l/197rCzwPxc8cWf
         d446DDWXrXvJ9kdsWWZ82BfBmoH+eosIJlNeOO7qbx/a/wn3RrYfgVS5eC9fAaToAR+9
         thHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5rhvGYSkxelxGyPSnaDu+0/FidU3OO/8XxKYyWUCvmKSzi1s5VdOSQ1ieWMLSRYkb3WjFFol0nhftIXhqLEn0@vger.kernel.org
X-Gm-Message-State: AOJu0YwbappkraL+GCjwrvc3RndrtXB9uH6AjRXz6KHCSvIBPK4UjxLC
	LoyTmoirJKIeQsDY4QKhRTZxrSCte0nraXwWb2CIzpByWWZpAHy0cBk2HNaqAZ5J23f5iUc3MCO
	86q+FaXEYVA==
X-Received: from dybts2.prod.google.com ([2002:a05:7300:f582:b0:2d6:703e:417d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7495:b0:2ca:e4f2:31ff
 with SMTP id 5a478bee46e88-2d5873adf3emr7247555eec.6.1776043402318; Sun, 12
 Apr 2026 18:23:22 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:17 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-24-irogers@google.com>
Subject: [PATCH v11 23/33] perf lock: Constify trace_lock_handler variables
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

Structs don't change and so constify.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index b6533483ba64..89a40d385b27 100644
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
2.53.0.1213.gd9a14994de-goog

