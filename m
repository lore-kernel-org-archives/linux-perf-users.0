Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB263ACF17
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625075; cv=none; b=KASP1C2gaHe32Px8MtvDYSXviDCn7rEx8e6lRNIbSYzCXUve0lLhyLvRQG171sKxf/t7a3pSzsxjKcW7FTJs4DlCH7xD+TTcwK0+Ve0o6WBPc6ZEepiuU7cStr5/D6khJlNoaTpWaR9sES4N5MOsjfLIFpiO8afbnjWQWFBg0Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625075; c=relaxed/simple;
	bh=BwGDgKDai1yXT4v9UnCvwH95vy4i1dx1vDujNIJDNfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T+fXzJx9IJ69gJ7nhGfjNRhOXD3zIoaVnTUboeHvymwuTT6Mi6MBxrEG5MOsf5DnVxYU44XVhpIhztKUZNcq4w5oV/QJQ7mHUKPPQUyNVcUJkzNkYu15bEpLGt8Zc4+eQYKXRDCWEsjAuIlVR34msYd9kRcWkx0LfeY1eH+l0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AD92hzb4; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AD92hzb4"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132c3280e03so597669c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625073; x=1779229873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P8HhbK7eBurj4615EN2DB6WOMz8XT/PwWIzY9YpHnV8=;
        b=AD92hzb4whxhUtWmA0qVllXNuUm1rowTzspSuwEvr/jx0uLEv0MIu0EKJh7UTqkkn+
         JkHT8ihKUY1kfYfchEhtqhYECaqG0NYJ4IA08TcR4g8JsiW2u2oWRWyQtnDaNZW2Fpat
         BoAFvxRMP5Wr/+WvwrSXPOXvpnRfzRII+dvAD+vnAgawObJFnHRZ2YtoXcY9N/fsF3+q
         rFUHjqVNg2DwRyL0XFPH3O0fhFc+Y+a2+wyuCZh8t/SymNXGy5RUvWvarjPgJiydCh9S
         oZSGALZGDj+aFn8Y+9VCPj+ff2xGOxBRsV4OILDcrsai8Kfn3bMHN7PHAdljRHZiPEgZ
         t+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625073; x=1779229873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8HhbK7eBurj4615EN2DB6WOMz8XT/PwWIzY9YpHnV8=;
        b=k3jY29AUSBEgHvRN2xOsVwAFFDfJ0wADw571pbGY3pgLEP7IMeZhYrqGHb1CpWRkeS
         i6+IeY5TUSnmh7ZSExQw+YH6yqRBPispvpY9qnAD7Xv/Bk04x77vJyaebLLi71XbXDej
         +M6gj+xKkwnm4++us/X8vptwsq5mljCxyV4XAzoPCv/ejvQBQ76OnFLdC7MRbXta7TdN
         SvQYeqy/zgSC6yWaxrMRQ+8RU7MMb9XPGGZ02sGh6r8Dn0o4F3YpSwU9HyqkDPGKD9w4
         yIDLC33B/vvWg1DptuMquEa1+9fYB0IpkDfvEJQQ72tEpmmVj4J8HaAc2YD6wwVeAyl+
         +b4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9hc1ftMG67DyBCVy6o3LLNbWmbIzgyU7VQ/SKDf18NmEgQHe0vMitmmjKXq9qESYPMAMI2nQ1ql9kIZFFefm6I@vger.kernel.org
X-Gm-Message-State: AOJu0YyI62Crqt0g5mpMzVwuGiiZGm4RiW6e3I1VPnXoI1PzzQqxpcsq
	TwH+yhBG92ZRU/FXyft1uzslJc3socu2FgKhLm2O777XbvvtjsiKvCrwQOhVBv9COtHanUtlhZO
	ho93nEnLAPw==
X-Received: from dlbbz24.prod.google.com ([2002:a05:7022:2398:b0:12d:d227:fad5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1288:b0:12d:b2ca:a9ef
 with SMTP id a92af1059eb24-1343677c8e9mr517636c88.17.1778625073075; Tue, 12
 May 2026 15:31:13 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:52 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-24-irogers@google.com>
Subject: [PATCH v13 23/32] perf lock: Avoid segv if event is missing a callchain
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
2.54.0.563.g4f69b47b94-goog

