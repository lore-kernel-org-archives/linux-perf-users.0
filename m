Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053E1EABBE;
	Fri, 11 Oct 2024 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612852; cv=none; b=gOLldGO4k9qx91GjyAupKDIOTrP72a2nba/Rt1hWZJMR8HDSDWKqiY5mKWX69K1md1LLXN20kdn05mI0+TG2xu9SiJVsFCJNG4TrZCVLwEoQaGGiYdzQtOfB8WnWBLz1RW/73CE2+C6KRvOj2szJZFd9qylFLj+dJ2RZJcIw8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612852; c=relaxed/simple;
	bh=Faz5um/LkKzqB8ZjN4Jg+GjjWI0PfNgOUrIiymn4gAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtFibbRKogmS8xdmH2QoswmzdOX6YnEr2C+XuyHiw46mlIFXqWQTJbRr625EwiMMkRf6Ny5ZUCf3OSfDgqABWLpg0rRe5ujZNvFxgF5ckzzlHZI+cVJCrgH/CV7ABQbc0OrR04S5cEt8tn991nP5s1F70w9mjdWuO9BKtjFuIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnEXjYf0; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnEXjYf0"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso1348138a91.3;
        Thu, 10 Oct 2024 19:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728612850; x=1729217650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgOjfzVdFS3y30GZHi4FKJSIKe0cpG5dnomDFlD9jeY=;
        b=YnEXjYf0Nxv4HHPMA1HIh4w4F+5uyVuSCrtxFbZ3V+2kf7T0iEYBwovG0cH3XGnoAH
         ugnAM8iohcy1IAQZW8lKqTqOtDZazzGWmfptC4Wqidc15IQHicx6+27N+P7kRHOiUFx+
         NwqXMwJ/8mH7Va8j92v5FaLak0RdqbVxvgN+vIBraWorxo0TkoX/hg6DyIU5jjeSYclm
         K/ttGTyZXivDBzq91CEzCDfclEgNbuwcSWzzB+cFqjaXc3MSRcCCp6IkXy2P8D2rXChP
         EwMaHsI66Gz8FrhO9Kp76PgAuQVk2TiWepvFKwu1/boS+J/9CBX26AwGeKYu4VO8hSZO
         9/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612850; x=1729217650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgOjfzVdFS3y30GZHi4FKJSIKe0cpG5dnomDFlD9jeY=;
        b=ACYLuEedkhlBxLO1f0C5G/HRpEO8nOCoow5LxjNL0jTJCLf80e46pAEZkpBNJtGkYK
         22vNrsIl6N2kdy5wjfweopnuAVor3IfWOdWGLtilBbsjjGd+C7I8ooLH2zBIMm4MBZ4Y
         AFrGHs98FHxmQt+STDN6snzjRqfZZjWNAkUy9BRCzdRFRodOQFdlrc1KGndJqLMZT8SZ
         n/tg9TSLzBaLPo8GNgnBGPbGfmTsBh8eNlP45mds0qns4mV5Dw92/32nE5LX38xSqKpn
         Wklo0OTvQOme2pNyV95hQ1ZeUBU6nslRfRfjK3boj7K77kH++Isuu8UfGxNXtQwEGblm
         HEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9Do4hNv788ujI0eCAj7lnHIjEIISg8dcWV3VbfttiZlTFc5O9sfs+DA++X4luo9gBn5OtozaJf3dk2QZK3jDgJA==@vger.kernel.org, AJvYcCWLE67s5UMG3+yjcUpbZMEzNZ5zZ/S5G8O3lcW4fpS4hJfre+MmJc391Q4xJoB+SPD6ALstSvD6Ow7vlxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL4i+L7oLXEoEIEdqKfJqRDabh/SYpABQL4+yAKhD0aEIpGgG/
	TSuEYKicgSNl/amFXZ1Jfs1SjhRJYj/x+KPTdVioDJwGYnkOOhw0
X-Google-Smtp-Source: AGHT+IE8p/0jNH1GdWDl+1+su39ICkz1+z7QqHAjvgvLTerohZ0Co+kJqT1SEXEYQY2rL5enutfLEw==
X-Received: by 2002:a17:90a:fc8e:b0:2e2:bd72:543d with SMTP id 98e67ed59e1d1-2e2f0ddb967mr1334832a91.41.1728612850049;
        Thu, 10 Oct 2024 19:14:10 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a56f71b5sm4393024a91.20.2024.10.10.19.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 19:14:09 -0700 (PDT)
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
	james.clark@linaro.org,
	alan.maguire@oracle.com,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v2 2/2] perf trace: Rewrite BPF code to pass the verifier
Date: Thu, 10 Oct 2024 19:14:02 -0700
Message-ID: <20241011021403.4089793-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011021403.4089793-1-howardchu95@gmail.com>
References: <20241011021403.4089793-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite the code to add more memory bound checking in order to pass the
BPF verifier, no logic is changed.

This rewrite is centered around two main ideas:

- Always use a variable instead of an expression in if block's condition,
  so BPF verifier keeps track of the correct register.
- Delay the check as late as possible, just before the BPF function
  call.

Things that can be done better still:

- Instead of allowing a theoretical maximum of a 6-argument augmentation
  payload, reduce the payload to a smaller fixed size.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 122 ++++++++++--------
 1 file changed, 67 insertions(+), 55 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index b2f17cca014b..9ae459faac4b 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -157,9 +157,9 @@ static inline int augmented__output(void *ctx, struct augmented_args_payload *ar
 	return bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, args, len);
 }
 
-static inline int augmented__beauty_output(void *ctx, void *data, int len)
+static inline int augmented__beauty_output(void *ctx, struct beauty_payload_enter *args, int len)
 {
-	return bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, data, len);
+	return bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, args, len);
 }
 
 static inline
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
+
+	/* Every read from userspace is limited to value size */
+	if (aligned_size > sizeof(augmented_args->arg.value))
+		goto failure;
 
-	struct augmented_arg *arg2 = (void *)&augmented_args->arg.value + augmented_args->arg.size;
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
@@ -422,12 +434,12 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 
 static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 {
-	bool augmented, do_output = false;
-	int zero = 0, size, aug_size, index, output = 0,
-	    value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
+	bool do_augment = false;
+	int zero = 0, value_size = sizeof(struct augmented_arg) - sizeof(u64);
 	unsigned int nr, *beauty_map;
 	struct beauty_payload_enter *payload;
-	void *arg, *payload_offset;
+	void *payload_offset, *value_offset;
+	u64 len = 0; /* has to be u64, otherwise it won't pass the verifier */
 
 	/* fall back to do predefined tail call */
 	if (args == NULL)
@@ -436,16 +448,18 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
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
 	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
+	len += sizeof(struct syscall_enter_args);
 
 	/*
 	 * Determine what type of argument and how many bytes to read from user space, using the
@@ -457,52 +471,50 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
 	 */
 	for (int i = 0; i < 6; i++) {
-		arg = (void *)args->args[i];
-		augmented = false;
-		size = beauty_map[i];
-		aug_size = size; /* size of the augmented data read from user space */
+		int augment_size = beauty_map[i];
+		unsigned int augment_size_with_header;
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

