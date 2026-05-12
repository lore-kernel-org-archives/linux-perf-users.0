Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C13AC0F3
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625073; cv=none; b=lHqByapjdTxFwSN2TTro/H5dVAubZHUU2oUQRx3w+qIGJN5newCW+P3YLG02/sMzjzk92aOaAokF8mXYhE6qDYaid35ieLhgvwLzXr3UsUOjwxyNaKyiU9ysDlFDXtqE4OKUvmTH85yZkgNhQ9GYAuN2+0LnoFYIm5t+J+HDCBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625073; c=relaxed/simple;
	bh=72xRP6f0Ol1osow8niCKehNnJDkNM0NdjErnuzdX+zE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=shAvwQ6VARNs9NHb1O5NrYT1KS0nE8Bj6hdeJBiQ7ugN/s2+w0s8tw0qunDi/T10hnUAP+bNaz7PJtMppKSn1PyVqO2TfNStP3hxD0RPXk3VGgndJtK2AItRY4e215KPDqN5Bi5ZjpPYkAa94gLyZaFvXFUwe528s7gFe6Ygn4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jp7ked+O; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jp7ked+O"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1306c2f7037so6269534c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625071; x=1779229871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cwNyso6AbtvFceW9QVdjbrfvsFAuuri0XJA+j19lZek=;
        b=jp7ked+O2oIf9+tcT1gKPuXP7wp8MI2zpDCuRBUPtLYC8fr5XITVSSKGLrVURJyQ0f
         h3hSNWkPRt5YyACP830rAFueKvh0yBVyJM1Q0h9YdZ1E5Vk3psOTZ3gRZ9W5dlkV4k/0
         guVoX65vngJkfOJKZVBV+f2XvxUtC0xyHaulWjnJu1GqUPYCHAzBE1gargn3LsQphHkH
         RNP87DeyJw7Non3bmPgPOY19PLZUDKeguGtQoDzIfaJj+vULNb8NtSjLJm1hLeoUFFy3
         uvpYnBSfQ0mooXnQsqYaVtWOpHSrDFExK39hFRaxf1m/BVMpzy2SB75jAI6XHZvOn06h
         hDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625071; x=1779229871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwNyso6AbtvFceW9QVdjbrfvsFAuuri0XJA+j19lZek=;
        b=D8ar+WOmrhrjey5GqbpEIlI6MjskRtsGmY+1delgGsgCx2eH7wzpf1IKX7Wr9fUPS6
         AkDZZSvfie/XmNFFNOoEMYq4hXoIM38ACK4ehxkVARc95XDy+cv8CQyO4chSnA+4//a9
         alB2nj5LtaxeLmqZ1w85+a7A9Qvv4SGoRNHpzpa3tCeY5KOn7WASu1nnqVOZXOxY+kLS
         ryg8DKZiLapen2t2fccILsN32cGVpH1eooWgQsK+yT/19s6d15pOo8Ion07E7aRKae/x
         bSPJG0r4MRXjYUtAWG89YGdR9GMLt3iKC6C2fgyJgnGYECnTytNemHcxMowx0hQUph1b
         upmQ==
X-Forwarded-Encrypted: i=1; AFNElJ/i1l/t7tILFRpQi1WSczj81a8jU8cYBAcXNaSIiV9GmRdChNCRuJXJrusfbbiXA5kpg1U+Irl4Wm9JdOxOG2yZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyISSfznEJeEylUZoeWTMXKldGtTh1h4ADNhQnss5zoScO85JSz
	3s9Ptde6v+6l23rd+e5dHmPd7+vFqxlXQFuTKlPHojsSUZ4yCfQ9yYeYYxhqabmBRbhblI9nkSt
	oqn5ff9lzyA==
X-Received: from dlbcy37.prod.google.com ([2002:a05:7022:ba5:b0:12c:912f:7d3f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2399:b0:134:83c2:26b3
 with SMTP id a92af1059eb24-1349a14eed9mr215146c88.0.1778625070814; Tue, 12
 May 2026 15:31:10 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:51 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-23-irogers@google.com>
Subject: [PATCH v13 22/32] perf lock: Constify trace_lock_handler variables
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, nichen@iscas.ac.cn, palmer@dabbelt.com, 
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
2.54.0.563.g4f69b47b94-goog

