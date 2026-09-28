Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDAD385509
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619978; cv=none; b=RTF1nW64IVEFak6viwKEpB2V/Pch/BA7kgTXfF9TAnB31F1ac046cwI23cPXgmaoYB2VhaQksFPPstuwfOz6aKD60vdVEyA5OJULpZRk27eS/Qhstlz+fhzzjwCXeBdZuqKd/mF7BIt3e0DgO/8yF2cZ6pdQzQdYsTjngcNUBRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619978; c=relaxed/simple;
	bh=4YiB4X1FKdwW6v8b2oPAGzh0ATpu9ZK2L4omM048Gns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b0UMHSJQIAnOuqQASrtwbmR9aj7wZpDWM1drBwmXk83o+TuDv1DMZKXjd3ip8pCQ6mlc3MOs49/2bAxl7ij9GWI/12FrecRF5vqCjxKAIcNIGJC/kZcaRhWd1UppZ/ck83qnwjp8tsUaTzYnJOPgvcsiKzQlFA42A6S5dimy0E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gVpRnZtv; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVpRnZtv"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1384427c3efso4936522c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790619976; x=1791224776; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y1r410xHvvz6W/oRjLBXwvc9eBjLswOWtY3DJk1lCi8=;
        b=gVpRnZtv42b8yuF9I+s8xyS8m5rqvqmargXNT/8aSuxqtwGoYgZC97SVUgIwQnK8Ci
         GMp5im8YbE2Tz/J82HSvDhL1V4c8Hoav4RXF36khU36fzX04p4J4MrarMM5uE+xvLVxs
         +NJC2rUFYiAIJXUtYQEWBzgr0eKgRgzyDmaUDDjMMtAl6bcNK5dVKnQkhUfE0IdZNFbX
         kjvwLV/4LmAceWZrp8QT8LYQLmWU9+biS2uQCkw+f4huM2Uw1vzIoLirxDhSv70EZokc
         18xPFkSYudaE10Px4DKtVIZqvbVKLvhIoFMgtZ0xTMI1iudbwtm+9faNMPDqyNtCp8Ls
         +f4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619976; x=1791224776;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y1r410xHvvz6W/oRjLBXwvc9eBjLswOWtY3DJk1lCi8=;
        b=KHCgygmjTSkP/nnzt0bk9lXWkOAYuzWU/1kg7PD3DzNbMNZKYb6rvjJcQ/iIu8TkOu
         FjQgPpgABeWOkGmpF+xRPVqSZkKICSJQkhr+AISC3FDa1ZTGcpwFUTTpW7e6zH7bPaRt
         fE6ykOOj3AuWbe7wXnTtYct9JiVjdmBOD7UD3y85hHn2qSRX1fvnnbbR9ll0Tzrc9l/D
         5/0VN6f2eg5mGXSyUo2JWmekmL0q2EkA3wQqaQVrLyiOos9BQ37D6zjttu9HtPfAk9uB
         HRMdASYberZ/iNYu72VgHo27FJEykMWfL6g/GNtvtNXyxagbi4GCBZcGgzvezzpKhjDx
         Nmmg==
X-Forwarded-Encrypted: i=1; AKwUvBypZaEEqSqYEOufa8SZJVJNNGkGO/TCXaq1zA+0gxGk+eacpc0eSZ9bRI1F6xbFIJegW//aJ1rabyd26fE6FTUV@vger.kernel.org
X-Gm-Message-State: AFuF++mSLkkMshEsh91nLqv4AiMD5mv/5m6bRZWHoyK/nJJfJTv1wQhm
	kkXg6pNhMib//AQyxZPlJYlLHNuPg+6YnFVBFY5zZdy4sDdOK8vWZhQMCneO9ruI/4lmMXgS6t0
	XT+LkQztSnQ==
X-Received: from dlev29.prod.google.com ([2002:a05:701b:465d:b0:144:f91e:d429])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:603:b0:144:f47b:d31a
 with SMTP id a92af1059eb24-146ce29fdc4mr14660441c88.1.1790619975758; Mon, 28
 Sep 2026 11:26:15 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:25:40 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-2-irogers@google.com>
Subject: [PATCH v6 01/26] perf trace: Set the augmented arg header in the
 augmenters that omit it
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The augmenters build records in augmented_args_tmp, a per-CPU scratch
buffer reused by every syscall, so a header field that isn't written
holds a stale value from an earlier syscall. sys_enter_sendto(),
sys_enter_perf_event_open(), sys_enter_clock_nanosleep() and
sys_enter_nanosleep() never set the struct augmented_arg size and err,
and augment_arg() doesn't set err.

Set both. When bpf_probe_read_user() fails in the connect, sendto and
nanosleep augmenters, report a zero sized payload and the error rather
than the stale scratch contents.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 37 ++++++++++++++++---
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 3bc9e28a9b8a..f7c9eb49648f 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -210,6 +210,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
 	const void *sockaddr_arg = (const void *)args->args[1];
 	unsigned int socklen = args->args[2];
 	unsigned int len = sizeof(u64) + sizeof(augmented_args->args); // the size + err in all 'augmented_arg' structs
+	int err;
 
         if (augmented_args == NULL)
                 return 1; /* Failure: don't filter */
@@ -217,9 +218,11 @@ int sys_enter_connect(struct syscall_enter_args *args)
 	_Static_assert(is_power_of_2(sizeof(augmented_args->arg.saddr)), "sizeof(augmented_args->arg.saddr) needs to be a power of two");
 	socklen &= sizeof(augmented_args->arg.saddr) - 1;
 
-	bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr_arg);
+	err = bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr_arg);
+	if (err)
+		socklen = 0;
 	augmented_args->arg.size = socklen;
-	augmented_args->arg.err = 0;
+	augmented_args->arg.err = err;
 
 	return augmented__output(args, augmented_args, len + socklen);
 }
@@ -231,13 +234,18 @@ int sys_enter_sendto(struct syscall_enter_args *args)
 	const void *sockaddr_arg = (const void *)args->args[4];
 	unsigned int socklen = args->args[5];
 	unsigned int len = sizeof(u64) + sizeof(augmented_args->args); // the size + err in all 'augmented_arg' structs
+	int err;
 
         if (augmented_args == NULL)
                 return 1; /* Failure: don't filter */
 
 	socklen &= sizeof(augmented_args->arg.saddr) - 1;
 
-	bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr_arg);
+	err = bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr_arg);
+	if (err)
+		socklen = 0;
+	augmented_args->arg.size = socklen;
+	augmented_args->arg.err = err;
 
 	return augmented__output(args, augmented_args, len + socklen);
 }
@@ -372,6 +380,9 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
 	if (bpf_probe_read_user(&augmented_args->arg.value, size, attr) < 0)
 		goto failure;
 
+	augmented_args->arg.size = size;
+	augmented_args->arg.err = 0;
+
 	return augmented__output(args, augmented_args, len + size);
 failure:
 	return 1; /* Failure: don't filter */
@@ -384,6 +395,7 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
 	const void *rqtp_arg = (const void *)args->args[2];
 	unsigned int len = sizeof(u64) + sizeof(augmented_args->args); // the size + err in all 'augmented_arg' structs
 	__u32 size = sizeof(struct timespec64);
+	int err;
 
         if (augmented_args == NULL)
 		goto failure;
@@ -391,7 +403,11 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
 	if (size > sizeof(augmented_args->arg.value))
                 goto failure;
 
-	bpf_probe_read_user(&augmented_args->arg.value, size, rqtp_arg);
+	err = bpf_probe_read_user(&augmented_args->arg.value, size, rqtp_arg);
+	if (err)
+		size = 0;
+	augmented_args->arg.size = size;
+	augmented_args->arg.err = err;
 
 	return augmented__output(args, augmented_args, len + size);
 failure:
@@ -405,6 +421,7 @@ int sys_enter_nanosleep(struct syscall_enter_args *args)
 	const void *req_arg = (const void *)args->args[0];
 	unsigned int len = sizeof(augmented_args->args);
 	__u32 size = sizeof(struct timespec64);
+	int err;
 
         if (augmented_args == NULL)
 		goto failure;
@@ -412,7 +429,11 @@ int sys_enter_nanosleep(struct syscall_enter_args *args)
 	if (size > sizeof(augmented_args->arg.value))
                 goto failure;
 
-	bpf_probe_read_user(&augmented_args->arg.value, size, req_arg);
+	err = bpf_probe_read_user(&augmented_args->arg.value, size, req_arg);
+	if (err)
+		size = 0;
+	augmented_args->arg.size = size;
+	augmented_args->arg.err = err;
 
 	return augmented__output(args, augmented_args, len + size);
 failure:
@@ -445,6 +466,7 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
 			      struct beauty_payload_enter *payload, u64 offset)
 {
 	int index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
+	int read_err = 0;
 	struct augmented_arg *payload_offset;
 	s64 aug_size, size;
 	bool augmented;
@@ -467,8 +489,10 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
 	if (size == 1) { /* string */
 		aug_size = bpf_probe_read_user_str(payload_offset->value, value_size, arg);
 		/* minimum of 0 to pass the verifier */
-		if (aug_size < 0)
+		if (aug_size < 0) {
+			read_err = aug_size;
 			aug_size = 0;
+		}
 
 		augmented = true;
 	} else if (size > 0 && size <= value_size) { /* struct */
@@ -498,6 +522,7 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
 			return -1;
 
 		payload_offset->size = aug_size;
+		payload_offset->err = read_err;
 		return written;
 	}
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

