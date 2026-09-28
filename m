Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538F3939A5
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619997; cv=none; b=k2oIYndxps7wiV0Uc6OsI8Z6c+tvvu2bRZgVYIu8LTy1quCbQXUwc7yHUT7ahetkNoP6iYCib4aFqJjiBgp62pFwSHIpMaKXH3Db6U6ee4SRYRabJUY58f+lUvUJOWCLJTYLuKxDfd1AObwQ0lGH631cYzkflLbgiIp8+2VYDtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619997; c=relaxed/simple;
	bh=UduaDJlHfbFTdzR6YJRzsoWjOUEEZ0mJdO4Z993c2l8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VFFeGbDIjrQvIIJl7sjmmMvepc1Tqqs1SGOnC0tDR67gAFQxYncl9WUBYUf8eGDeSb72jh7OHssrohxmaj9c9iIpkXsNonua4Pqj1DgFlg5bKCB0Ml0AMudvrY1hZ//aKRSjPx5kQ6ITiSD2JUZfCmTkdyXMtipRNhoiMcSDeT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lus4bln2; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lus4bln2"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-147be78cd56so232972c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790619995; x=1791224795; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dk1kduljn1xel3FGAsdASwjPdqG+eyGO9CLIz0ryBwM=;
        b=lus4bln2JTF7vnyTHFA7uaqrZYTn1clNWnkV6qjkwhhizHWa/GAqVL7Y3TYoW1ZU24
         qX6fgkUYBO5mcHlurEp3tS2QZrlxQ3jKGwGEPZ+msXi7XR0ghRNBA33ItHasbaSC3Xta
         aNnINO3m0hveHDt8Dtzp8B152zAa7hTnVSlbMAb1AoKPDQ98bvocvhXYN2yQWyAFUfSC
         wADvkD+0D8To6JsDjFkIBZe84qhco7cnfAmdkuOcMnmXTTRk77qWg11YFXhz6cdTvOWp
         Ag9xGCZduYWgLRF/i5mmvDPKnKmYtJO2mwdLVI+r27QycXRmi+ZeJaz1Tbg//iUiisiT
         c+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619995; x=1791224795;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dk1kduljn1xel3FGAsdASwjPdqG+eyGO9CLIz0ryBwM=;
        b=ElBlHvAMOtW9M3/rIGmtRjeUUhGX4I8A/rQyK8IMKkBkEBzNsvZcvgS3JRpyE14roe
         Lw1uYHExTAOnRWITuWNJzvwDTUyNRg/gPUM3sliQLXD4Q3fDpenoNrZOvX+1a/tjyOVD
         KsNJZpApYNapKA381SYep3dUBzHi30uAVRHDLESYxAok3few7qgL6Iojs8bsx60EmP/q
         dZQm60ZM2g2NEIiERXvyguGm5tLB1hrVBMAY9TwjIvuhmB6yd1wsy8Psdg5G8F8Jr02y
         4lqbm7TW27d7QhGIU+o3tH/dHZuxY+Y9cfHZ4GpjBtYN4O6flq6Ji/voitMQjN3o/G7a
         NCKQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7EWz4r349DUVFE08vsVClsVcg1Pmh74s6xLPulPvyqboov9tlGuuHRsHaeHEr1oYEKCB/8uI9g4scEnJzOAV9@vger.kernel.org
X-Gm-Message-State: AFuF++kSdU0alDu3nrEbghC2Ig5BWp8d8TWciSNBDp9g8otkWwj5mqso
	eCW46xmIS7I3PWkwrlmmWhIXo19FEOAnZ/mW64zy8/PGktkVNvd++R/7Y3pkA4QVIDspuFDWtTp
	G2kskznSUYA==
X-Received: from dlbsn5.prod.google.com ([2002:a05:7022:b905:b0:144:c63a:75d4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:270b:b0:14a:51c8:e9fd
 with SMTP id a92af1059eb24-14a51c8eba7mr2776611c88.26.1790619994154; Mon, 28
 Sep 2026 11:26:34 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:25:49 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-11-irogers@google.com>
Subject: [PATCH v6 10/26] perf trace: Only take augmented arguments from the
 BPF output event
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

syscall__augmented_args() treats any data after the syscall arguments as
augmented arguments. trace__sys_enter() avoids this for
raw_syscalls:sys_enter, but trace__fprintf_sys_enter() also handles
syscalls:sys_enter_* tracepoint events, whose trailing data since v6.19
holds the __data_loc strings of internal fields. Only the BPF output
event carries augmented arguments, so only look for them there.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6a54d8bff534..1f89f85ba2e4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2947,7 +2947,8 @@ static int trace__fprintf_sample(struct trace *trace, struct perf_sample *sample
 	return printed;
 }
 
-static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sample, int *augmented_args_size, int raw_augmented_args_size)
+static void *syscall__augmented_args(struct trace *trace, struct syscall *sc,
+				     struct perf_sample *sample, int *augmented_args_size)
 {
 	/*
 	 * For now with BPF raw_augmented we hook into raw_syscalls:sys_enter
@@ -2963,9 +2964,14 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
 	 * use syscalls:sys_enter_NAME, so that we reduce the kernel/userspace
 	 * traffic to just what is needed for each syscall.
 	 */
-	int args_size = raw_augmented_args_size ?: sc->args_size;
+	int args_size = trace->raw_augmented_syscalls_args_size ?: sc->args_size;
 	static uintptr_t argbuf[1024]; /* assuming single-threaded */
 
+	*augmented_args_size = 0;
+	/* Only the BPF output event carries augmented arguments. */
+	if (sample->evsel != trace->syscalls.events.bpf_output)
+		return NULL;
+
 	*augmented_args_size = sample->raw_size - args_size;
 	/*
 	 * The raw data is padded to a u64 boundary with stale bytes, so less
@@ -3025,18 +3031,7 @@ static int trace__sys_enter(struct trace *trace,
 
 	if (!(trace->duration_filter || trace->summary_only || trace->min_stack))
 		trace__printf_interrupted_entry(trace);
-	/*
-	 * If this is raw_syscalls.sys_enter, then it always comes with the 6 possible
-	 * arguments, even if the syscall being handled, say "openat", uses only 4 arguments
-	 * this breaks syscall__augmented_args() check for augmented args, as we calculate
-	 * syscall->args_size using each syscalls:sys_enter_NAME tracefs format file,
-	 * so when handling, say the openat syscall, we end up getting 6 args for the
-	 * raw_syscalls:sys_enter event, when we expected just 4, we end up mistakenly
-	 * thinking that the extra 2 u64 args are the augmented filename, so just check
-	 * here and avoid using augmented syscalls when the evsel is the raw_syscalls one.
-	 */
-	if (evsel != trace->syscalls.events.sys_enter)
-		augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
+	augmented_args = syscall__augmented_args(trace, sc, sample, &augmented_args_size);
 	ttrace->entry_time = sample->time;
 	ttrace->entry_cpu = sample->cpu;
 	msg = ttrace->entry_str;
@@ -3099,7 +3094,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct perf_sample *sam
 		goto out_put;
 
 	args = perf_evsel__sc_tp_ptr(args, sample);
-	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
+	augmented_args = syscall__augmented_args(trace, sc, sample, &augmented_args_size);
 	printed += syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
 	fprintf(trace->output, "%.*s", (int)printed, msg);
 	err = 0;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

