Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E9F143C6E;
	Mon,  7 Oct 2024 05:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728278067; cv=none; b=KZ9otVxrvSGRnw57+li2/wUv6HNk3py5Pdlhm/3BffwJWgbIMNbOQNVfdGaOepZGYUhN/u0xcuKSGhZss1r7x1+florYBSjiUE61v73tM/5PKdMdlPdF041FFsY7t2IDWrPBYsAuR0MSWhcA43/9Vwn6nGqH1n+A3nbghDH6CFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728278067; c=relaxed/simple;
	bh=QhAAQy89BUMqfImN0D4BR9Wz3jLaEcjlkVFFPRyTaTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgD50wjR9+ZdbCweNkUsICYE8y2I42fB2DirhwqUNpl8x8M0dD4pWbZMSwDZE337MPUhDHA8Opz1CMmh9hBdQftZzEGreOHHt04OFn+ygVpp0+LAePB8QnOjruk56r7J825BLLqE4DVDJD9XHWgvAxuvU0cJnkyjJF7dvycciYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC+kK3gW; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC+kK3gW"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71dff3b3c66so434341b3a.0;
        Sun, 06 Oct 2024 22:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728278065; x=1728882865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nc45GScwEYb/XDKFhfFPvbfiSpKjiTkjmHeMFk8YbE=;
        b=MC+kK3gWqRUvxbdhZPVbCIB3JgbCvL5NIv+heD9VDMNaAADtat/ijt8chZ9bOWz45n
         vzOvUsPdEv1VU6fS3QaCcf1R+/4WaBzOhiZveNrSOX+UM9KyOoTDwKxED5j+EAVHMa3t
         /qanlUNZm49taKjN4bgtgnb9OvTgjhkxyV13EMlULWtwVe2q4cgC2PNdz+fjAixG6SAr
         idyMellZibbVG28uwm065EJUq+B6nQD3KUUCPcuwtRUKvqDSi95buqraaBd33YmDSYTU
         itlcgdRuJhIFlMJl99OQCdkJRf65ivQHG8k2wAAfxhAQEAn3ue2yU2xv98EStqDIn2rD
         1AoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728278065; x=1728882865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nc45GScwEYb/XDKFhfFPvbfiSpKjiTkjmHeMFk8YbE=;
        b=FxG1GV0omU1F38TnORJjflby6LAuQUXn/JaDMQoPyBSfZKUu1u0Zdfe9fY1tWVJuBu
         N0QKmoy1ZVUSPg1GD7mYbgRT9A7QyeDe/J2HGifv8eswbV3hW2NFec7wfuDS1vRx25op
         WsWqngl5HkNu6sbfg/kk5usHgeldBHK+xvsV//HePmYLZ3YYwe6F32ZQjXu0iDt106fg
         Hm4G1pXkSapSLVub4tnCfCbTfss+11oU2V4Milk2K4PUuTqJaTi1LOi271imY27MlqMb
         NUMEEEmO4jXl0dozzEv1YYhXuiEaPMMJjmuItWxeIIczU9VpHQao1N6LBwBFzxOBdUKL
         IlgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMop3R8Kt63g0O2UzXuS8F/d2/hvvCJPMP11aUgHZ2YDzY8nNzxBP+5qjcqWYAZU+VBs/KMbC+/8Oj9ISmBM2Ukg==@vger.kernel.org, AJvYcCWeaqzd8l1jU1txRTUIHPMr2HNF1iwPHNGhwrQXHdreYw7EesIgWy1SMQsl8VeEP2fKZka46y0xe41dLdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsXDJza5shLBjwF2H9UbUe3AQjO3yxbSq4rj6dfi1PwPf9upCP
	TgiAiC3SsR2tWRFQY90H0yFfyyld8bnct8Px0FirBOaxLvL9Xbfc
X-Google-Smtp-Source: AGHT+IE8x3gG9FMOG8qFANHupGXaZZBHD1Ra/Uq65LPI+t3pkLMkv7g3ZQVW89pXSCMoHkbd3FaMpQ==
X-Received: by 2002:a05:6a00:1785:b0:71e:c8:ac99 with SMTP id d2e1a72fcca58-71e00c8ae44mr4378360b3a.3.1728278064913;
        Sun, 06 Oct 2024 22:14:24 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccd04csm3560706b3a.46.2024.10.06.22.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 22:14:24 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH 2/2] perf trace: Rewrite BPF programs to pass the verifier
Date: Sun,  6 Oct 2024 22:14:14 -0700
Message-ID: <20241007051414.2995674-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007051414.2995674-1-howardchu95@gmail.com>
References: <20241007051414.2995674-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite the code to add more memory bound checkings in order to pass the
BPF verifier, not logic is changed.

This rewrite is centered around two main ideas:

- Always use a variable instead of an expression in if block's condition,
  so BPF verifier keeps track of the correct register.
- Delay the check until just before the function call, as late as possible. 

Things that can be done better still:

- Instead of allowing a theoretical maximum of a 6-argument augmentation
  payload, reduce the payload to a smaller fixed size.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 117 ++++++++++--------
 1 file changed, 63 insertions(+), 54 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index b2f17cca014b..a2b67365cedf 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -277,25 +277,31 @@ int sys_enter_rename(struct syscall_enter_args *args)
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *oldpath_arg = (const void *)args->args[0],
 		   *newpath_arg = (const void *)args->args[1];
-	unsigned int len = sizeof(augmented_args->args), oldpath_len, newpath_len;
+	unsigned int len = sizeof(augmented_args->args), oldpath_len, newpath_len, aligned_size;
 
         if (augmented_args == NULL)
-                return 1; /* Failure: don't filter */
+		goto failure;
 
 	len += 2 * sizeof(u64); // The overhead of size and err, just before the payload...
 
 	oldpath_len = augmented_arg__read_str(&augmented_args->arg, oldpath_arg, sizeof(augmented_args->arg.value));
-	augmented_args->arg.size = PERF_ALIGN(oldpath_len + 1, sizeof(u64));
-	len += augmented_args->arg.size;
+	aligned_size = PERF_ALIGN(oldpath_len + 1, sizeof(u64));
+	augmented_args->arg.size = aligned_size;
+	len += aligned_size;
 
-	struct augmented_arg *arg2 = (void *)&augmented_args->arg.value + augmented_args->arg.size;
+	/* Every read from userspace is limited to value size */
+	if (aligned_size > sizeof(augmented_args->arg.value))
+		goto failure;
+
+	struct augmented_arg *arg2 = (void *)&augmented_args->arg.value + aligned_size;
 
 	newpath_len = augmented_arg__read_str(arg2, newpath_arg, sizeof(augmented_args->arg.value));
 	arg2->size = newpath_len;
-
 	len += newpath_len;
 
 	return augmented__output(args, augmented_args, len);
+failure:
+	return 1; /* Failure: don't filter */
 }
 
 SEC("tp/syscalls/sys_enter_renameat2")
@@ -304,25 +310,31 @@ int sys_enter_renameat2(struct syscall_enter_args *args)
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *oldpath_arg = (const void *)args->args[1],
 		   *newpath_arg = (const void *)args->args[3];
-	unsigned int len = sizeof(augmented_args->args), oldpath_len, newpath_len;
+	unsigned int len = sizeof(augmented_args->args), oldpath_len, newpath_len, aligned_size;
 
         if (augmented_args == NULL)
-                return 1; /* Failure: don't filter */
+		goto failure;
 
 	len += 2 * sizeof(u64); // The overhead of size and err, just before the payload...
 
 	oldpath_len = augmented_arg__read_str(&augmented_args->arg, oldpath_arg, sizeof(augmented_args->arg.value));
-	augmented_args->arg.size = PERF_ALIGN(oldpath_len + 1, sizeof(u64));
-	len += augmented_args->arg.size;
+	aligned_size = PERF_ALIGN(oldpath_len + 1, sizeof(u64));
+	augmented_args->arg.size = aligned_size;
+	len += aligned_size;
 
-	struct augmented_arg *arg2 = (void *)&augmented_args->arg.value + augmented_args->arg.size;
+	/* Every read from userspace is limited to value size */
+	if (aligned_size > sizeof(augmented_args->arg.value))
+		goto failure;
+
+	struct augmented_arg *arg2 = (void *)&augmented_args->arg.value + aligned_size;
 
 	newpath_len = augmented_arg__read_str(arg2, newpath_arg, sizeof(augmented_args->arg.value));
 	arg2->size = newpath_len;
-
 	len += newpath_len;
 
 	return augmented__output(args, augmented_args, len);
+failure:
+	return 1; /* Failure: don't filter */
 }
 
 #define PERF_ATTR_SIZE_VER0     64      /* sizeof first published struct */
@@ -422,12 +434,11 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 
 static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 {
-	bool augmented, do_output = false;
-	int zero = 0, size, aug_size, index, output = 0,
-	    value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
-	unsigned int nr, *beauty_map;
+	bool do_augment = false;
+	int zero = 0, value_size = sizeof(struct augmented_arg) - sizeof(u64);
+	unsigned int nr, *beauty_map, len = sizeof(struct syscall_enter_args);
 	struct beauty_payload_enter *payload;
-	void *arg, *payload_offset;
+	void *payload_offset, *value_offset;
 
 	/* fall back to do predefined tail call */
 	if (args == NULL)
@@ -436,12 +447,13 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 	/* use syscall number to get beauty_map entry */
 	nr             = (__u32)args->syscall_nr;
 	beauty_map     = bpf_map_lookup_elem(&beauty_map_enter, &nr);
+	if (beauty_map == NULL)
+		return 1;
 
 	/* set up payload for output */
 	payload        = bpf_map_lookup_elem(&beauty_payload_enter_map, &zero);
 	payload_offset = (void *)&payload->aug_args;
-
-	if (beauty_map == NULL || payload == NULL)
+	if (payload == NULL)
 		return 1;
 
 	/* copy the sys_enter header, which has the syscall_nr */
@@ -457,52 +469,49 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
 	 */
 	for (int i = 0; i < 6; i++) {
-		arg = (void *)args->args[i];
-		augmented = false;
-		size = beauty_map[i];
-		aug_size = size; /* size of the augmented data read from user space */
+		int augment_size = beauty_map[i], augment_size_with_header;
+		void *addr = (void *)args->args[i];
+		bool is_augmented = false;
 
-		if (size == 0 || arg == NULL)
+		if (augment_size == 0 || addr == NULL)
 			continue;
 
-		if (size == 1) { /* string */
-			aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
-			/* minimum of 0 to pass the verifier */
-			if (aug_size < 0)
-				aug_size = 0;
-
-			augmented = true;
-		} else if (size > 0 && size <= value_size) { /* struct */
-			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
-				augmented = true;
-		} else if (size < 0 && size >= -6) { /* buffer */
-			index = -(size + 1);
-			aug_size = args->args[index];
-
-			if (aug_size > TRACE_AUG_MAX_BUF)
-				aug_size = TRACE_AUG_MAX_BUF;
-
-			if (aug_size > 0) {
-				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
-					augmented = true;
-			}
+		value_offset = ((struct augmented_arg *)payload_offset)->value;
+
+		if (augment_size == 1) { /* string */
+			augment_size = bpf_probe_read_user_str(value_offset, value_size, addr);
+			is_augmented = true;
+		} else if (augment_size > 1 && augment_size <= value_size) { /* struct */
+			if (!bpf_probe_read_user(value_offset, value_size, addr))
+				is_augmented = true;
+		} else if (augment_size < 0 && augment_size >= -6) { /* buffer */
+			int index = -(augment_size + 1);
+
+			augment_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
+			if (!bpf_probe_read_user(value_offset, augment_size, addr))
+				is_augmented = true;
 		}
 
-		/* write data to payload */
-		if (augmented) {
-			int written = offsetof(struct augmented_arg, value) + aug_size;
+		/* Augmented data size is limited to value size */
+		if (augment_size > value_size)
+			augment_size = value_size;
+
+		/* Explicitly define this variable to pass the verifier */
+		augment_size_with_header = sizeof(u64) + augment_size;
 
-			((struct augmented_arg *)payload_offset)->size = aug_size;
-			output += written;
-			payload_offset += written;
-			do_output = true;
+		/* Write data to payload */
+		if (is_augmented && augment_size_with_header <= sizeof(struct augmented_arg)) {
+			((struct augmented_arg *)payload_offset)->size = augment_size;
+			do_augment      = true;
+			len            += augment_size_with_header;
+			payload_offset += augment_size_with_header;
 		}
 	}
 
-	if (!do_output)
+	if (!do_augment || len > sizeof(struct beauty_payload_enter))
 		return 1;
 
-	return augmented__beauty_output(ctx, payload, sizeof(struct syscall_enter_args) + output);
+	return augmented__beauty_output(ctx, payload, len);
 }
 
 SEC("tp/raw_syscalls/sys_enter")
-- 
2.43.0

