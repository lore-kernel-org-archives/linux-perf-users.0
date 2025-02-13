Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A45245B01;
	Thu, 13 Feb 2025 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487621; cv=none; b=I+zeJWlWZSA3DpB7Z1ksRA6MthSrtSjnI3MWoETZKZbwvxDC5g0eGsxtBHaEVMOIastbhCHTsFgwJ7qmdXySEq4ZAHvUC+a9lhWpNtI5mXNd3lXv+RBAdzxqNzdhuuCdyispcTJjgYWIyxVYrL/FmkIHqtPps233pvXeK8RsNd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487621; c=relaxed/simple;
	bh=zkA9NoqxuTJ9143G+fHdqorubFcg2Pyh1R5efL11ql8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j954x1EP88B/Qwwwl5VoEo7Ui0fuAJI5wOa68/KT4OwqTY5PijkYa9mL5AvjueWZLiH5iK+QR/Fjg+9uty8GsA/uJoki1B1SpcEGj6wjqUoJJmGFyhA3kNYyxe8i/wyFE0LAeYm5RHyzI9TFFO+r1EBs8vNGeZNEibNGRSFhO0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1Qz/JS0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1Qz/JS0"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fbfc9ff0b9so2343411a91.2;
        Thu, 13 Feb 2025 15:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739487619; x=1740092419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7omCjmTFle31Ye/Qq9MO6Xsp5wPVSFLbffxm3Uj/s40=;
        b=R1Qz/JS0t+crKKK15BPl/sSr4C0NSEVJY+4ktxheW+lDVgqC8jJlPIz7E3989oGete
         MENS3nh+Bg+sZ+yV9c56G01pwTYi3+n9a33gVW6b0fWwx1PhhXNq0d59hxar4ocW5Dyl
         s2rmEJ4DYXkYECbU3dbaUl9YRAMzftqvSYt5n9AViV2J2qGWyZhIGW+v1GJJsSY/ZYbb
         yAm+aODbufleDtT3tUDHzc4NvsdqKU9HTDdGcuYjV89jsafTSzAgUzNYlqZY9Qtj2k3x
         3Dinr7SSU20/UIO+ti7b3XZp5P+2nHMoi2iZ27Z075e6c45pq+1FlTUr0dUqmwUJENev
         r/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487619; x=1740092419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7omCjmTFle31Ye/Qq9MO6Xsp5wPVSFLbffxm3Uj/s40=;
        b=LnUdBlMVKLYXiNQfwGZ+DuNl9MdlLEbo2h8kiAxUKk3oYDnpXUhkNnb/QT2FbYgWLr
         a/QxyJCWjx4A8tbIDACkSUW716xvMir/+RAyNABgEzIOP3tLpw8GhdoOZFAeHZmC02fh
         0aPywmUVX5u/9buXLIsMr67dw5Ju+reONBFzWiHOW9xrAi4sXgmYoLqYtYlVAcOxVZQQ
         ujf9PDrqZ38U+bxAZMZHMCLpGWCCWq2Srg8xXOBkzb8mRk44eCR1sgsea0MYJ5RGiL8k
         7j9lN9Rfm6V6FZhMj9h/IgLHicLb8lL2mlH+PTgqhXIpyiEPoQyGBL86k9+AidIQV6MK
         mn5g==
X-Forwarded-Encrypted: i=1; AJvYcCWw8FgHVbPykzHi4n8e7Ge91waCBG0n89zNndnhB1tU9iGLg7xLlAyH+Oc47QoLLwD4RIkya/IGsezACpc=@vger.kernel.org, AJvYcCX9ek+VDbnVCQfeZZgeyl1mJogSdseVUMmMARmxV9GcMiDfTNq2Wir/8ygDN1I59OVQbpLx/cZcf61yYmBJFXhY7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbilXCZdTCQfSmyr2zKc7qDvdKoqxkDXoSKzK16gD5gB9FvqiO
	XmLJAYhH7LAuyQGNKg8A1SugKf7j9nphKlRdFjjKd0awUc0ZYF5A
X-Gm-Gg: ASbGncshxwn9YGRqMHqNSa/vFpFzaUXSv05kohAn7974FqjWY/vS77NC4GsvT1VtUl3
	8meA0qcz/Sqh0WXfC4KVJb0zyQcQQ9AJkcCirbGGVMIYdA98czxsWXm4/X6pjucisP5eeKtqrOX
	NPxTon1xK1w7O7vlgQ12WSG2s3RzKAOUXDFcTAIEFQPhnYhX60WhfDDRP1fYJjhTN4VYujsQqzA
	uUoonVc2FxAmePq0qi4uxmJYl1GEGVTrE816EmCxrEJ7v9YM8bttNx2EyTX4Sl2Y/XCQlGT0Q83
	UXtnj2u7Q3ojD3Wyj2D4kktUv7MacIUaihTWchPsATuoD98=
X-Google-Smtp-Source: AGHT+IHQkqj2tuGm2/iP1In6kDFCvUkCoGVTR8ApKhEJwPXCq9/+A/FrzymyX6JtyclRG3ZO0r6Vkw==
X-Received: by 2002:a17:90b:38c6:b0:2ee:f80c:6884 with SMTP id 98e67ed59e1d1-2fc0f0db50dmr7986893a91.33.1739487618650;
        Thu, 13 Feb 2025 15:00:18 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349210sm17641735ad.11.2025.02.13.15.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 15:00:18 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v15 04/10] perf record --off-cpu: Dump off-cpu samples in BPF
Date: Thu, 13 Feb 2025 15:00:03 -0800
Message-ID: <20250213230009.1450907-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250213230009.1450907-1-howardchu95@gmail.com>
References: <20250213230009.1450907-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Collect tid, period, callchain, and cgroup id and dump them when off-cpu
time threshold is reached.

We don't collect the off-cpu time twice (the delta), it's either in
direct samples, or accumulated samples that are dumped at the end of
perf.data.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-6-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 89 ++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index 1cdd4d63ea92..c15b69586723 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -19,11 +19,18 @@
 #define MAX_ENTRIES  102400
 
 #define MAX_CPUS  4096
+#define MAX_OFFCPU_LEN 37
+
+// We have a 'struct stack' in vmlinux.h when building with GEN_VMLINUX_H=1
+struct __stack {
+	u64 array[MAX_STACKS];
+};
 
 struct tstamp_data {
 	__u32 stack_id;
 	__u32 state;
 	__u64 timestamp;
+	struct __stack stack;
 };
 
 struct offcpu_key {
@@ -41,6 +48,10 @@ struct {
 	__uint(max_entries, MAX_ENTRIES);
 } stacks SEC(".maps");
 
+struct offcpu_data {
+	u64 array[MAX_OFFCPU_LEN];
+};
+
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
 	__uint(key_size, sizeof(__u32));
@@ -48,6 +59,13 @@ struct {
 	__uint(max_entries, MAX_CPUS);
 } offcpu_output SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct offcpu_data));
+	__uint(max_entries, 1);
+} offcpu_payload SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
@@ -106,6 +124,8 @@ const volatile bool uses_cgroup_v1 = false;
 
 int perf_subsys_id = -1;
 
+__u64 offcpu_thresh_ns = 500000000ull;
+
 /*
  * Old kernel used to call it task_struct->state and now it's '__state'.
  * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
@@ -192,6 +212,47 @@ static inline int can_record(struct task_struct *t, int state)
 	return 1;
 }
 
+static inline int copy_stack(struct __stack *from, struct offcpu_data *to, int n)
+{
+	int len = 0;
+
+	for (int i = 0; i < MAX_STACKS && from->array[i]; ++i, ++len)
+		to->array[n + 2 + i] = from->array[i];
+
+	return len;
+}
+
+/**
+ * off_cpu_dump - dump off-cpu samples to ring buffer
+ * @data: payload for dumping off-cpu samples
+ * @key: off-cpu data
+ * @stack: stack trace of the task before being scheduled out
+ *
+ * If the threshold of off-cpu time is reached, acquire tid, period, callchain, and cgroup id
+ * information of the task, and dump it as a raw sample to perf ring buffer
+ */
+static int off_cpu_dump(void *ctx, struct offcpu_data *data, struct offcpu_key *key,
+			struct __stack *stack, __u64 delta)
+{
+	int n = 0, len = 0;
+
+	data->array[n++] = (u64)key->tgid << 32 | key->pid;
+	data->array[n++] = delta;
+
+	/* data->array[n] is callchain->nr (updated later) */
+	data->array[n + 1] = PERF_CONTEXT_USER;
+	data->array[n + 2] = 0;
+	len = copy_stack(stack, data, n);
+
+	/* update length of callchain */
+	data->array[n] = len + 1;
+	n += len + 2;
+
+	data->array[n++] = key->cgroup_id;
+
+	return bpf_perf_event_output(ctx, &offcpu_output, BPF_F_CURRENT_CPU, data, n * sizeof(u64));
+}
+
 static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
 			struct task_struct *next, int state)
 {
@@ -216,6 +277,16 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
 	pelem->state = state;
 	pelem->stack_id = stack_id;
 
+	/*
+	 * If stacks are successfully collected by bpf_get_stackid(), collect them once more
+	 * in task_storage for direct off-cpu sample dumping
+	 */
+	if (stack_id > 0 && bpf_get_stack(ctx, &pelem->stack, MAX_STACKS * sizeof(u64), BPF_F_USER_STACK)) {
+		/*
+		 * This empty if block is used to avoid 'result unused warning' from bpf_get_stack().
+		 * If the collection fails, continue with the logic for the next task.
+		 */
+	}
 next:
 	pelem = bpf_task_storage_get(&tstamp, next, NULL, 0);
 
@@ -230,11 +301,19 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
 		__u64 delta = ts - pelem->timestamp;
 		__u64 *total;
 
-		total = bpf_map_lookup_elem(&off_cpu, &key);
-		if (total)
-			*total += delta;
-		else
-			bpf_map_update_elem(&off_cpu, &key, &delta, BPF_ANY);
+		if (delta >= offcpu_thresh_ns) {
+			int zero = 0;
+			struct offcpu_data *data = bpf_map_lookup_elem(&offcpu_payload, &zero);
+
+			if (data)
+				off_cpu_dump(ctx, data, &key, &pelem->stack, delta);
+		} else {
+			total = bpf_map_lookup_elem(&off_cpu, &key);
+			if (total)
+				*total += delta;
+			else
+				bpf_map_update_elem(&off_cpu, &key, &delta, BPF_ANY);
+		}
 
 		/* prevent to reuse the timestamp later */
 		pelem->timestamp = 0;
-- 
2.45.2

