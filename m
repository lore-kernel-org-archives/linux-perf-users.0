Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC61167296;
	Wed, 31 Jul 2024 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455399; cv=none; b=rcLvCNjT+kzwl4YwHe2H3KY5BOKwPKGJmg5Euor1adv323EnMZKcr82tCew4E8CUdlGC2V3iZnqGQ+K7F61oZZqgvoQKi/pRUgS9dFnzer86IG4Wm7beqRvWS9wTo6dlN22IugBK2CEa8V+7hjzyt5OThow44dNaIH7wbMNMQPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455399; c=relaxed/simple;
	bh=HN6yTO7+A27IjMmK11mbMRnqecL/dySO+hV6Sn62zM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUgV0yFjXOW9Q6IsOclFm3l5Mk/T5nnCBLdJeJvd16Bn75g4EgEsVMcGYjqwcsoPoJIQJLLKkLSxhXUo3CopVqFyxWksmitDXLlngrqzUc6HxTfFkNkpeAMrdRBFCTQEmyKvm5eJ5WZfwVG2/KX/TwN62GjUI0RnnHzXppGsCuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XL7LcZ3J; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL7LcZ3J"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fd69e44596so10432825ad.1;
        Wed, 31 Jul 2024 12:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722455397; x=1723060197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9Weln6HL4jFvu3R12bR6RV3rp5GwkSNm79NhbYTCSs=;
        b=XL7LcZ3JXcA4eJjLN4tyNRDL3YQpwgzz+HGHeqKNC/OgISGm3ji2Tt3SHhJHxUSw8C
         Sqwn9lnJyjcqrUsB/VPCRKublmdo4HD6uLxrFucg0v/YBFFzTcQyz5stqJAWlcazM+vE
         pkWfN1yPnp6A/L4VQwPgm95OO/TE5QvnMcRZ3SsQ/CcAjkHwr/2Ca8eiWb/2BVTgvbVd
         AGXphm958rqnShF8SrNVKDFmKdtAiVcpJcuQZ3OzHScBSwNep0CWCJullpPNTC2HHvHn
         VwV+LgkwlUNETg0FaQWvRynWCSCM6EeAJVxd0pgyLn0tsXwN43YEYRba74KA/DvUuy8p
         DZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722455397; x=1723060197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9Weln6HL4jFvu3R12bR6RV3rp5GwkSNm79NhbYTCSs=;
        b=hmcq66eoS3WixtiFNr43DFjdXGWtQ4PR6ZyXAyK/64pFfXu7vyW3ytj7srqe4WinKY
         l5B5xKrm5DlU67iG8rWwe0i42Xrqkl3+sKLWze3wHSSbjEp5HxF+OAsj3TpBVw54IHGt
         7OEERIjSeK9ShFBTy3IHR7dpQRSGTb2G2YObv4V0vDeUVx+URrfPy0cVP8RiJUmsMXC7
         xEtO4jQShuWfMQdXHgbqC5wk/uHbdew+HzXRpEeDgAY6hcuVd3lBEzsUWHHm+TgJPtHz
         0UxaalMWDMb+sGjWdVfErcMCqLvoHk4NcZd/y2T9gnvWi2NHjvnZOHw4YYAUr1qUcsfN
         w5/A==
X-Forwarded-Encrypted: i=1; AJvYcCVaIaRCyIKflSujlZFnS46uJdLHmyXCoyOi8ZQ0K4jtCdmEVzvew9omgl4U+aAhdq1rQmhgwTvatVT37pYY2S0e+3zeXSmBOEhRPSZe4NgtWD0IrIRdCPe8BVyfxEElkDd1dZFWdEfoLSyezSipDg==
X-Gm-Message-State: AOJu0YxSnIabRgWEQWGwBDOVHvpQWB0/syX5t87LPPiEhU0Brwz/IrWf
	cRTqzscAY3XU6cASvOrg8AQ27QjO/a5BeQ5Jyis0aa+qWMDNG9wo
X-Google-Smtp-Source: AGHT+IHNWT3DaA12LNkK0/h7wma29i6IdEA0Oa7UzzyXyPHx9UOlWTqHoqS8GVP7MQeW8bJQV0Pwjg==
X-Received: by 2002:a17:902:e54f:b0:1fb:8e29:621f with SMTP id d9443c01a7336-1ff4d66e3e2mr3565555ad.16.1722455397449;
        Wed, 31 Jul 2024 12:49:57 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7837e40sm124708615ad.0.2024.07.31.12.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:49:57 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] perf trace: Collect augmented data using BPF
Date: Thu,  1 Aug 2024 03:49:38 +0800
Message-ID: <20240731194939.4760-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731194939.4760-1-howardchu95@gmail.com>
References: <20240731194939.4760-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add task filtering in BPF to avoid collecting useless data.

I have to make the payload 6 times the size of augmented_arg, to pass the
BPF verifier.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 121 +++++++++++++++++-
 1 file changed, 120 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 0acbd74e8c76..e96a3ed46dca 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -22,6 +22,10 @@
 
 #define MAX_CPUS  4096
 
+#define MAX_BUF 32 /* maximum size of buffer augmentation */
+
+volatile bool filter_pid;
+
 /* bpf-output associated map */
 struct __augmented_syscalls__ {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
@@ -79,6 +83,13 @@ struct pids_filtered {
 	__uint(max_entries, 64);
 } pids_filtered SEC(".maps");
 
+struct pid_filter {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, pid_t);
+	__type(value, bool);
+	__uint(max_entries, 512);
+} pid_filter SEC(".maps");
+
 /*
  * Desired design of maximum size and alignment (see RFC2553)
  */
@@ -124,6 +135,25 @@ struct augmented_args_tmp {
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
@@ -136,6 +166,11 @@ static inline int augmented__output(void *ctx, struct augmented_args_payload *ar
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
@@ -176,6 +211,7 @@ int syscall_unaugmented(struct syscall_enter_args *args)
  * on from there, reading the first syscall arg as a string, i.e. open's
  * filename.
  */
+
 SEC("tp/syscalls/sys_enter_connect")
 int sys_enter_connect(struct syscall_enter_args *args)
 {
@@ -372,6 +408,82 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 	return bpf_map_lookup_elem(pids, &pid) != NULL;
 }
 
+static inline bool not_in_filter(pid_t pid)
+{
+	return bpf_map_lookup_elem(&pid_filter, &pid) == NULL;
+}
+
+static int beauty_enter(void *ctx, struct syscall_enter_args *args)
+{
+	if (args == NULL)
+		return 1;
+
+	int zero = 0;
+	struct beauty_payload_enter *payload = bpf_map_lookup_elem(&beauty_payload_enter_map, &zero);
+	unsigned int nr = (__u32)args->syscall_nr,
+		     *m = bpf_map_lookup_elem(&beauty_map_enter, &nr);
+
+	if (m == NULL || payload == NULL)
+		return 1;
+
+	bool augment = false;
+	int size, err, index, written, output = 0, augsiz = sizeof(payload->aug_args[0].value);
+	void *arg, *arg_offset = (void *)&payload->aug_args;
+
+	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
+
+	for (int i = 0; i < 6; i++) {
+		size = m[i];
+		arg = (void *)args->args[i];
+		written = 0;
+
+		if (size == 0 || arg == NULL)
+			continue;
+
+		if (size == 1) { /* string */
+			size = bpf_probe_read_user_str(((struct augmented_arg *)arg_offset)->value, augsiz, arg);
+			if (size < 0)
+				size = 0;
+
+			/* these three lines can't be moved outside of this if block, sigh. */
+			((struct augmented_arg *)arg_offset)->size = size;
+			augment = true;
+			written = offsetof(struct augmented_arg, value) + size;
+		} else if (size > 0 && size <= augsiz) { /* struct */
+			err = bpf_probe_read_user(((struct augmented_arg *)arg_offset)->value, size, arg);
+			if (err)
+				continue;
+
+			((struct augmented_arg *)arg_offset)->size = size;
+			augment = true;
+			written = offsetof(struct augmented_arg, value) + size;
+		} else if (size < 0 && size >= -6) { /* buffer */
+			index = -(size + 1);
+			size = args->args[index];
+
+			if (size > MAX_BUF)
+				size = MAX_BUF;
+
+			if (size > 0) {
+				err = bpf_probe_read_user(((struct augmented_arg *)arg_offset)->value, size, arg);
+				if (err)
+					continue;
+
+				((struct augmented_arg *)arg_offset)->size = size;
+				augment = true;
+				written = offsetof(struct augmented_arg, value) + size;
+			}
+		}
+		output += written;
+		arg_offset += written;
+	}
+
+	if (!augment)
+		return 1;
+
+	return augmented__beauty_output(ctx, payload, sizeof(struct syscall_enter_args) + output);
+}
+
 SEC("tp/raw_syscalls/sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
@@ -389,6 +501,9 @@ int sys_enter(struct syscall_enter_args *args)
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
 
+	if (filter_pid && not_in_filter(getpid()))
+		return 0;
+
 	augmented_args = augmented_args_payload();
 	if (augmented_args == NULL)
 		return 1;
@@ -400,7 +515,8 @@ int sys_enter(struct syscall_enter_args *args)
 	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
 	 * unaugmented tracepoint payload.
 	 */
-	bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
+	if (beauty_enter(args, &augmented_args->args))
+		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
 
 	// If not found on the PROG_ARRAY syscalls map, then we're filtering it:
 	return 0;
@@ -411,6 +527,9 @@ int sys_exit(struct syscall_exit_args *args)
 {
 	struct syscall_exit_args exit_args;
 
+	if (filter_pid && not_in_filter(getpid()))
+		return 0;
+
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
 
-- 
2.45.2

