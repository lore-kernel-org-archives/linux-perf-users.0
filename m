Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0411400DE9
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303995; cv=none; b=CIrw0mw89tCf7Sf0CgWGR5jGMVBOT25HlzmhXoOwfTGJnHkXTwKUCzn2YMJ8yGh62VKwW8l376c8rgnq3koi9w66tFLIpjWqm7KhS+BPrbzTivugwreXNKImKrHNTl5j97IZgG9cem6Hfz4Hd8T1aKUHw0C3H68WJF/7OTO730w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303995; c=relaxed/simple;
	bh=+0gdfy/AVYG5UC2nehDz4H+EDi+cTZFhZPNhz1XLddU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AE1mvtce5G/VyChBomtp74o0YoFU21rgK8Un/eKu09za4xRw5gmZXHPLJ7mV9TB0q+cgYyM2ZQBQDRQmVdpN5R8BtX1ZEDfspjpJk5hEIBfuY29a6Jgq/okoVAzSURbt/NgKiwg2ROxmVPq1rAvNtkAOSHvoqfFCizDiWL3G8BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=htWE5Gln; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htWE5Gln"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-303b38ec2f6so7339361eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303993; x=1779908793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NFymczVs1hMjDcX59Oa5tRS59UyGpjhJDS247h+StqQ=;
        b=htWE5GlnkY03w0+Pc8wk630+nAjUaGbhNLHIS/t5XclrjoMiif79X6nGKc8yj6hxSZ
         Hj5/26x6ExZEI++0DqaOS3sQ0GwCR+3NPmCyBE0U/1metBi/53qk+XM0tWbV8d8dx0XI
         mcAYG0qhASMxi2eNv9lg3sUb0ady/M0etV8qDSfnIYc2lpJJBERHO1s+poBGbReUws95
         GdQndVQgnGOFsh2MkjIQnmAPJVk6h+el9+CkknJsg9a+eyZQRutHHRniqbUBCjMwmVs8
         dzCc/zjdirho9fJ2lEgnjVI1x4g4FChq4fK/Xs8JObMrkhZ+dwmZqDzp1mC+Wjb+7FVy
         Z1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303993; x=1779908793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFymczVs1hMjDcX59Oa5tRS59UyGpjhJDS247h+StqQ=;
        b=nL8dwDdCrEzkW7TMF6dES5PMzO5i572G1AkcjOMdpeg+eBuX+gfXho9S6mBkVSB0D0
         X9Tf299NmgRjgp9lUEIcCYKKGcwBJnFRXx4PutXINkFHlKNalWlIEvBITsAS9cZn95U5
         5HrkUrkhHYEfC7cRRtQ3RdVE8oIoywAFqhaFNdO0C0OCGcKnGMLKvzXtBz2RAIltv+59
         k6fbYLI5LGtMYZODq28FuvNSiGPCxMpYVdboCZcC8+gAihojeCsS2w4ToW0TB1jNdrM8
         UURClh4h23RbXnE4WGDxh/54+4QU/u2wjlBrHCqjr72FYNaUyjvoyZUNASLMApBprp5n
         WWBg==
X-Forwarded-Encrypted: i=1; AFNElJ+nbrN4fkW+jTrFQ4yxDRh622ZNYNgKpprPfZVbqrry2E992OJqbODS0XbCU+Xx8+p3pyR+m8xY2lVw2K40j45J@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7XDxYBugbEnRBZnzR4+hL6cWYW/Q/2SdOsQLkvt3s2NQlMLiL
	7zkXwWblmh1bQEhAZBsLwnP3rkCEDPW/m0bUX+POrWIjsO2O68uQDSPHcRGezu3GjIHE4GWXrbo
	rT2HN9GQ0oQ==
X-Received: from dybmi9.prod.google.com ([2002:a05:7301:f89:b0:2f9:af7:5053])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc17:b0:2ed:e12:376c
 with SMTP id 5a478bee46e88-303986bbe04mr11583793eec.34.1779303990974; Wed, 20
 May 2026 12:06:30 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:29 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-24-irogers@google.com>
Subject: [PATCH v14 23/32] perf lock: Avoid segv if event is missing a callchain
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

Avoid a potential segmentation fault if a parsed sample unexpectedly lacks a
valid callchain pointer.

Add a check for a NULL sample->callchain pointer in get_callstack(). If the
callchain is missing, return NULL to safely skip the event and log a debug
warning rather than causing a tool segfault.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
2.54.0.746.g67dd491aae-goog

