Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA033E5A0E
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147657; cv=none; b=Q1VVSQhjivXIvWeXSaiO4QNHNeRBUuGssQycVWi7HO/hWAVxFeV4pXyzhXW8tqxSErtEhgS0msEHRtvdvTUy724lGPhK4N4SSNvVf/UV1pe+bc5AlNBm7+5LN6xE7Gp8stmTrhU4euKT9qhkh06v+s8hFcCK76AVWLVztySWhIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147657; c=relaxed/simple;
	bh=LdtI4ge8t/WGXKJw6waxWaXwyAYO7yzwcGmaQXwxyK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tAE/Hidny1tEjeJIFgx7+GGWlP5PVjCQrsH/S9cgCNKWgUNqgcGuw5/Yfl1vzbOH216FMFMYtIMtWLYbUiq4qiEWITNXuROU5KXZ+YBk8eIItu1byMrFOo3d2QyaHaNkjXosGshBMyZ3zv10PSCMUeU/4dCUsnMFdoL4U09+mMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qE3XF/12; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qE3XF/12"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3282d5302ffso653785eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147655; x=1790752455; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KAkoHlkHmEth86m+gr1xtW3uL/QzU5kqVxXnVnfJnDI=;
        b=qE3XF/12aLNBCHDLW767GOfpyWUQ5t7TrLnUflBp8MT5VkjcX72xrmaLplxHB/Em2g
         ZXIDsmLt5uQukjzI61qNbLuJTpsvCQ2d1vcSlqbbRqU54HzppcThgPUOTEwTj2Fgy9Rj
         x3LI0dVy4j3b0fQWk23YXPKpyY0IsAQD0ezVdSMPWYTkktrNz3/43tzjJl6nD4KRA3v8
         E4HWNKuhLZtmxcfiD/d6eS3bGC1XZAAHglohSYGwBxmaMJH14tmtLdZWMrBO/T45SSqV
         e/N9hLVI2Ej6PcutzuEJ42bYQikvRnrzMooHNn8RpNjGTSfZnk6kLCDReJPXw6+KTcms
         SDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147655; x=1790752455;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KAkoHlkHmEth86m+gr1xtW3uL/QzU5kqVxXnVnfJnDI=;
        b=waLtLu7lQthiXeLE0HKDrt54BoSwOcA+Jx7rdrKi7/h9HrPMP1+IrFuezq2Z29uA5v
         KNwUSvE2Ib1FXpPa6ypET12vSbACGUVCwVqSjNuAhvIKSWaMVe9iXZCyzvwIAJTpi9wA
         HOLc9Ej7UBitiGncSo6+UmITawfkSBv8uADm79BmuQYsziyuyKFQlFjR4IcknIqhLh0T
         HX4/t27jaXtJSZK+/fE33DWLzbHZ3GRovvW5PL6p+PCD8ugG+n3omn1J7zuyBKoQdsAW
         LT25cGoxSLFWToZTj+Loo/s+1xFYt6GsHMKUMYKU9K7eAQYbZQdBMURjFiGPszwRrU4o
         7i7w==
X-Forwarded-Encrypted: i=1; AKwUvBxAD0HR6/YrbLXyOhgGggzhfqTCBpiT1ESXgdOcqJNss9xV5NGonNaeWzlyNGwRKfsxixkbIwg1wHGscL/8zQz6@vger.kernel.org
X-Gm-Message-State: AFuF++mBAjCJ3w0lDol03gtZoiRRQmd7OudFMPjfbrHi4+1ayFmC2KcR
	VXkf1/VNu/dpsTt2SIB0pfKjFhS86llDJxY7WE78JiREUgRnleoxes5V5pV6DrWL6IZacblezdp
	FiWA0iCNFmw==
X-Received: from dyjf15.prod.google.com ([2002:a05:7300:680f:b0:33e:55a2:f3c0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:152d:b0:33c:36e9:30d7
 with SMTP id 5a478bee46e88-33e5c75de28mr1731181eec.4.1790147654853; Wed, 23
 Sep 2026 00:14:14 -0700 (PDT)
Date: Wed, 23 Sep 2026 00:13:41 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <aa751d26ad55f8a7d72db30dc23a67fae66e4b6b.1790145937.git.irogers@google.com>
Subject: [PATCH v5 01/23] perf trace: Set the augmented arg header in the
 augmenters that omit it
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, howardchu95@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

An augmented argument is a struct augmented_arg header, holding the
length of the payload and an error code, followed by the payload. The
augmenters build it in augmented_args_tmp, a single entry per-CPU array
reused by every syscall on that CPU, so a field left unassigned holds
whatever the previous syscall on that CPU put there rather than anything
about this one.

The string augmenters get both fields from augmented_arg__read_str(),
and sys_enter_perf_event_open() bails out when its read fails, but
sys_enter_connect(), sys_enter_sendto(), sys_enter_clock_nanosleep() and
sys_enter_nanosleep() copy the payload and output the record without
ever describing it, and augment_arg() sets the length but not the error.

This has gone unnoticed because the beautifiers for those payloads take
a fixed sized type and so read the value without consulting the header:
syscall_arg__scnprintf_augmented_sockaddr(),
syscall_arg__scnprintf_augmented_timespec() and
syscall_arg__scnprintf_augmented_perf_event_attr() all cast
augmented.args->value directly. Nothing has yet read a length that was
never written.

Describe the payload everywhere one is produced, so that a reader can
bound it by its length.

These reads can fail, and none of the four checked whether they had.
Rather than claim a payload that was not read, report a length of zero
and the error, so the record describes what it holds and leaves the
scratch out of it. A reader that bounds the payload by the header then
shows the pointer, as it does for a syscall with no augmentation at
all, rather than another task's data.

The error is set for the same reason the length is, that the header is
in a buffer the next syscall on this CPU will reuse and so carries the
previous one's value if it is not written, rather than because anything
reads it yet: beauty.h still calls the field int_arg and no beautifier
looks at it. augment_arg() reported a string it could not read as an
empty one before this and still does.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 53 ++++++++++++++++---
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 3bc9e28a9b8a..dd3aa5bd910b 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -210,6 +210,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
 	const void *sockaddr_arg = (const void *)args->args[1];
 	unsigned int socklen = args->args[2];
 	unsigned int len = sizeof(u64) + sizeof(augmented_args->args); // the size + err in all 'augmented_arg' structs
+	int err;
 
         if (augmented_args == NULL)
                 return 1; /* Failure: don't filter */
@@ -217,9 +218,16 @@ int sys_enter_connect(struct syscall_enter_args *args)
 	_Static_assert(is_power_of_2(sizeof(augmented_args->arg.saddr)), "sizeof(augmented_args->arg.saddr) needs to be a power of two");
 	socklen &= sizeof(augmented_args->arg.saddr) - 1;
 
-	bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr_arg);
+	err = bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr_arg);
+	/*
+	 * A failed read leaves the scratch holding whatever the previous
+	 * syscall on this CPU put there, so say there is no payload and why,
+	 * rather than describing another task's data as this task's sockaddr.
+	 */
+	if (err < 0)
+		socklen = 0;
 	augmented_args->arg.size = socklen;
-	augmented_args->arg.err = 0;
+	augmented_args->arg.err = err < 0 ? err : 0;
 
 	return augmented__output(args, augmented_args, len + socklen);
 }
@@ -231,13 +239,19 @@ int sys_enter_sendto(struct syscall_enter_args *args)
 	const void *sockaddr_arg = (const void *)args->args[4];
 	unsigned int socklen = args->args[5];
 	unsigned int len = sizeof(u64) + sizeof(augmented_args->args); // the size + err in all 'augmented_arg' structs
+	int err;
 
         if (augmented_args == NULL)
                 return 1; /* Failure: don't filter */
 
 	socklen &= sizeof(augmented_args->arg.saddr) - 1;
 
-	bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr_arg);
+	err = bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr_arg);
+	/* As in sys_enter_connect(), do not describe scratch as a sockaddr. */
+	if (err < 0)
+		socklen = 0;
+	augmented_args->arg.size = socklen;
+	augmented_args->arg.err = err < 0 ? err : 0;
 
 	return augmented__output(args, augmented_args, len + socklen);
 }
@@ -372,6 +386,9 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
 	if (bpf_probe_read_user(&augmented_args->arg.value, size, attr) < 0)
 		goto failure;
 
+	augmented_args->arg.size = size;
+	augmented_args->arg.err = 0;
+
 	return augmented__output(args, augmented_args, len + size);
 failure:
 	return 1; /* Failure: don't filter */
@@ -384,6 +401,7 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
 	const void *rqtp_arg = (const void *)args->args[2];
 	unsigned int len = sizeof(u64) + sizeof(augmented_args->args); // the size + err in all 'augmented_arg' structs
 	__u32 size = sizeof(struct timespec64);
+	int err;
 
         if (augmented_args == NULL)
 		goto failure;
@@ -391,7 +409,12 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
 	if (size > sizeof(augmented_args->arg.value))
                 goto failure;
 
-	bpf_probe_read_user(&augmented_args->arg.value, size, rqtp_arg);
+	err = bpf_probe_read_user(&augmented_args->arg.value, size, rqtp_arg);
+	/* As in sys_enter_connect(), do not describe scratch as a timespec. */
+	if (err < 0)
+		size = 0;
+	augmented_args->arg.size = size;
+	augmented_args->arg.err = err < 0 ? err : 0;
 
 	return augmented__output(args, augmented_args, len + size);
 failure:
@@ -405,6 +428,7 @@ int sys_enter_nanosleep(struct syscall_enter_args *args)
 	const void *req_arg = (const void *)args->args[0];
 	unsigned int len = sizeof(augmented_args->args);
 	__u32 size = sizeof(struct timespec64);
+	int err;
 
         if (augmented_args == NULL)
 		goto failure;
@@ -412,7 +436,12 @@ int sys_enter_nanosleep(struct syscall_enter_args *args)
 	if (size > sizeof(augmented_args->arg.value))
                 goto failure;
 
-	bpf_probe_read_user(&augmented_args->arg.value, size, req_arg);
+	err = bpf_probe_read_user(&augmented_args->arg.value, size, req_arg);
+	/* As in sys_enter_connect(), do not describe scratch as a timespec. */
+	if (err < 0)
+		size = 0;
+	augmented_args->arg.size = size;
+	augmented_args->arg.err = err < 0 ? err : 0;
 
 	return augmented__output(args, augmented_args, len + size);
 failure:
@@ -445,6 +474,7 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
 			      struct beauty_payload_enter *payload, u64 offset)
 {
 	int index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
+	int read_err = 0;
 	struct augmented_arg *payload_offset;
 	s64 aug_size, size;
 	bool augmented;
@@ -467,8 +497,18 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
 	if (size == 1) { /* string */
 		aug_size = bpf_probe_read_user_str(payload_offset->value, value_size, arg);
 		/* minimum of 0 to pass the verifier */
-		if (aug_size < 0)
+		if (aug_size < 0) {
+			/*
+			 * Record why nothing was read. The header sits in
+			 * scratch that the next syscall on this CPU reuses,
+			 * so an error left unwritten is the previous one's.
+			 * No beautifier reads it yet, beauty.h still calls
+			 * the field int_arg, so the string is still shown
+			 * as an empty one.
+			 */
+			read_err = aug_size;
 			aug_size = 0;
+		}
 
 		augmented = true;
 	} else if (size > 0 && size <= value_size) { /* struct */
@@ -498,6 +538,7 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
 			return -1;
 
 		payload_offset->size = aug_size;
+		payload_offset->err = read_err;
 		return written;
 	}
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

