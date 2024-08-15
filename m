Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DED43ABD;
	Thu, 15 Aug 2024 01:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723685834; cv=none; b=RS6d0yDdbssRwxbXVE/ah/HqsMMQ3Tjk0BxLQz5Q03vbSBRlePenhR5XL6XwcSXJ/SyYaaY+rvNdWCU18XdkTQQRi7xV9rV3pfZxQBPxbwbwAWPYB8ydOMPOwTsjXfihGaymiYNUC1ar//3TiUmsN3Paa8wzagp4IQBXOQUFEnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723685834; c=relaxed/simple;
	bh=xxzhKCQXRaMbX2Fn/2LQ9SCl/677hbD30vUhW6gsF/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fm9rPg8VlJJQ7p3uU/9PrefOYceyzsRGNfecgZpgmpMRP9ptyt+2XTDoRmggrshRGbxm/ARdwojZB/Q5hzQZbtBTQFNBMVrSnMcSMkc29cmkOCe+lynFVr/GnEoxIuWyGR5gSDLxGzWtqRP5T3wOxnmgSJbPEsksAhF9osnTPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4IE2lAM; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4IE2lAM"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3db145c8010so276881b6e.3;
        Wed, 14 Aug 2024 18:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723685832; x=1724290632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncTc6lP7++Cc+HdCfft7z5xIYc9fKy5pzTa2YoxTlfI=;
        b=a4IE2lAMjk81Jzuie9HhBbXwXKB36myXhdFUBiZHgDEeTbenhkvQiKg8R25xA4GPnP
         TUcaYoUnsqppRSkvlddbd92/jkpZAdn51S6gShhhTtWAmJTrOf/fXSUQ4cd3IYWPd7hA
         SFDT1qpOSAWduboXOwRh4+4fEkLiTAPbtLY5O9/59brjBb+IzPARaFdjvzmJ3AA5TAvP
         /F9AcOZlzGsUg2LbffUKgF1qI4z6pS7DUs4BzJaw4T5Z6KMSkM5SWlg6l2vqRnru2+GD
         A5TcAJvjhveK/eBUkAjGxnUO3BX0nNWzJV1PG3Td2qln04r3Gd7DhYIgrJgCcswHPeCV
         /RFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723685832; x=1724290632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncTc6lP7++Cc+HdCfft7z5xIYc9fKy5pzTa2YoxTlfI=;
        b=qVv5lWD1tapoSn1BiVKqhNqbRLFI3qU6gQ9MyX9Pa1wiJ5fVi+x/HoPEUM7X26gw7/
         02UOjIKbjimr25kLWenT79nV6Y8dCviJ/9dejjeJN+NvXoxDnDenRm+PrO/tLd9L33bx
         Pz8Ctk3SkMSCjBUXpDEdnEqCmgxHrMBOteJccuXP0LqntYZkcUjQhG+3DxUtMtsmjl2L
         32zeTyg06t1TxNxhPNaa3E8xjtROck7Ow+pjZ71PEduI0vFRSVfyHVgEEeB54GVkI+Oi
         ZcDa4+CfUdnFXn62McIfeZR48OPIYnaEMCpCJEvhc3OR+cTQgpRkZFWB2eSTvcgr79A9
         KJkg==
X-Forwarded-Encrypted: i=1; AJvYcCVQwdBDwx0fIdxSQi+WTUhgno+46Sjwde40F0vgiyC5pf1LepSanUi2PvOhpp2xhWIuzNIO/EoDcV1XlT0xt7Fe7u1PmyMfB9D2GCCm9GxDMIPPxAxEwJizHcoYiqgPcnGSRfIfYj9E3Uta5HUgRg==
X-Gm-Message-State: AOJu0YyRzWTPeISUjtnPGpoMdOe3T+1a0X7lr1VeM7rQqXKiHccf/hkc
	HM0+HzigFJ7jGaw+EP3PE6SOFT2WBq8QUTgLb5bxyH45aI9Ajum4
X-Google-Smtp-Source: AGHT+IHHEA3KWK7ZOw21EV+fqQNDddcFqMeUxyBqceNCIUnQxWubCiUbYNCxCfK6FXWcowCjMlhVWg==
X-Received: by 2002:a05:6870:96a5:b0:260:ee13:e665 with SMTP id 586e51a60fabf-26fe5bb9896mr5677248fac.37.1723685831713;
        Wed, 14 Aug 2024 18:37:11 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef412bsm196842b3a.123.2024.08.14.18.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 18:37:11 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] perf trace: Collect augmented data using BPF
Date: Thu, 15 Aug 2024 09:36:25 +0800
Message-ID: <20240815013626.935097-10-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240815013626.935097-1-howardchu95@gmail.com>
References: <20240815013626.935097-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include trace_augment.h for TRACE_AUG_MAX_BUF, so that BPF reads
TRACE_AUG_MAX_BUF bytes of buffer maximum.

Determine what type of argument and how many bytes to read from user space, us ing the
value in the beauty_map. This is the relation of parameter type and its corres ponding
value in the beauty map, and how many bytes we read eventually:

string: 1                          -> size of string (till null)
struct: size of struct             -> size of struct
buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_ MAX_BUF)

After reading from user space, we output the augmented data using
bpf_perf_event_output().

If the struct augmenter, augment_sys_enter() failed, we fall back to
using bpf_tail_call().

I have to make the payload 6 times the size of augmented_arg, to pass the
BPF verifier.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 114 +++++++++++++++++-
 1 file changed, 113 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index c7b9f80239c7..d665af449b1b 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -7,6 +7,8 @@
  */
 
 #include "vmlinux.h"
+#include "../trace_augment.h"
+
 #include <bpf/bpf_helpers.h>
 #include <linux/limits.h>
 
@@ -135,6 +137,25 @@ struct augmented_args_tmp {
 	__uint(max_entries, 1);
 } augmented_args_tmp SEC(".maps");
 
+struct beauty_payload_enter {
+	struct syscall_enter_args args;
+	struct augmented_arg aug_args[6];
+};
+
+struct beauty_map_enter {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, __u32[6]);
+	__uint(max_entries, 512);
+} beauty_map_enter SEC(".maps");
+
+struct beauty_payload_enter_map {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__type(key, int);
+	__type(value, struct beauty_payload_enter);
+	__uint(max_entries, 1);
+} beauty_payload_enter_map SEC(".maps");
+
 static inline struct augmented_args_payload *augmented_args_payload(void)
 {
 	int key = 0;
@@ -147,6 +168,11 @@ static inline int augmented__output(void *ctx, struct augmented_args_payload *ar
 	return bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, args, len);
 }
 
+static inline int augmented__beauty_output(void *ctx, void *data, int len)
+{
+	return bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, data, len);
+}
+
 static inline
 unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const void *arg, unsigned int arg_len)
 {
@@ -399,6 +425,91 @@ static inline bool task_can_trace()
 	return true;
 }
 
+static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
+{
+	bool augmented, do_output = false;
+	int zero = 0, size, aug_size, index, output = 0,
+	    value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
+	unsigned int nr, *beauty_map;
+	struct beauty_payload_enter *payload;
+	void *arg, *payload_offset;
+
+	/* fall back to do predefined tail call */
+	if (args == NULL)
+		return 1;
+
+	/* use syscall number to get beauty_map entry */
+	nr             = (__u32)args->syscall_nr;
+	beauty_map     = bpf_map_lookup_elem(&beauty_map_enter, &nr);
+
+	/* set up payload for output */
+	payload        = bpf_map_lookup_elem(&beauty_payload_enter_map, &zero);
+	payload_offset = (void *)&payload->aug_args;
+
+	if (beauty_map == NULL || payload == NULL)
+		return 1;
+
+	/* copy the sys_enter header, which has the syscall_nr */
+	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
+
+	/*
+	 * Determine what type of argument and how many bytes to read from user space, using the
+	 * value in the beauty_map. This is the relation of parameter type and its corresponding
+	 * value in the beauty map, and how many bytes we read eventually:
+	 *
+	 * string: 1			      -> size of string
+	 * struct: size of struct	      -> size of struct
+	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
+	 */
+	for (int i = 0; i < 6; i++) {
+		arg = (void *)args->args[i];
+		augmented = false;
+		size = beauty_map[i];
+		aug_size = size; /* size of the augmented data read from user space */
+
+		if (size == 0 || arg == NULL)
+			continue;
+
+		if (size == 1) { /* string */
+			aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
+			/* minimum of 0 to pass the verifier */
+			if (aug_size < 0)
+				aug_size = 0;
+
+			augmented = true;
+		} else if (size > 0 && size <= value_size) { /* struct */
+			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
+				augmented = true;
+		} else if (size < 0 && size >= -6) { /* buffer */
+			index = -(size + 1);
+			aug_size = args->args[index];
+
+			if (aug_size > TRACE_AUG_MAX_BUF)
+				aug_size = TRACE_AUG_MAX_BUF;
+
+			if (aug_size > 0) {
+				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
+					augmented = true;
+			}
+		}
+
+		/* write data to payload */
+		if (augmented) {
+			int written = offsetof(struct augmented_arg, value) + aug_size;
+
+			((struct augmented_arg *)payload_offset)->size = aug_size;
+			output += written;
+			payload_offset += written;
+			do_output = true;
+		}
+	}
+
+	if (!do_output)
+		return 1;
+
+	return augmented__beauty_output(ctx, payload, sizeof(struct syscall_enter_args) + output);
+}
+
 SEC("tp/raw_syscalls/sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
@@ -427,7 +538,8 @@ int sys_enter(struct syscall_enter_args *args)
 	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
 	 * unaugmented tracepoint payload.
 	 */
-	bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
+	if (augment_sys_enter(args, &augmented_args->args))
+		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
 
 	// If not found on the PROG_ARRAY syscalls map, then we're filtering it:
 	return 0;
-- 
2.45.2

