Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7742619D88C;
	Tue, 27 Aug 2024 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750436; cv=none; b=gzq32RFwyhD7iAEmQjbLNeWWQ9yXIkdH7QhkXeBoJfjJ6JVa+rGWjzipll03HAMEas8idmq7EzyYY8MTlsCo5mfU1i9qKVfDx3AljUrkAzzenGiYaFwEK+51eHNRKk8QA2kZe8xZYnrd+T5smNYGWuvSnhbw9Rn3puimrOzv1xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750436; c=relaxed/simple;
	bh=9aLLDm/VAlfzFoqOKhyK5jdipQ2A/0PKm5gpIg/eXUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PyHw9YFLcOc7j86+bXGCA8OqW2ZCUdToYHsGIfOEFuhaevb/JconbZIv0GMiUIWL4kxqoaMS7AJg33xTpwkVW2FdWNFem3LVC5rjNKrixPoxQjN0eFlSkYrWA9R9fmrNqysaX8NhuHTw9S4ah1itesW6Sx5CKW30Cn2lznGuYZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWe9cIcf; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWe9cIcf"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7bb75419123so3400224a12.3;
        Tue, 27 Aug 2024 02:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724750435; x=1725355235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7x374P9F0jPNFMTHJtbiCnmxTGpC6qte4AieI2H+Lys=;
        b=kWe9cIcfZVR/86vDz1/q/+zZxTeTrVtc4E4VzuzUGrjoY4xXaAaF1qYfHgNSY1DijO
         IW7+md/e94hq5zL+22MlFwulNX4s5Q7f/S7Z8YsqHUgkLp793MKvhqP62B1oufCB+Q3B
         10fpxs5VAsEFTHSt34nHBSUrC7JhL+0RsWO9VLtl0A1dfiHs6BhCyle/ARTTU2I8emEo
         VmqBvg4zk4eGPDoJZHO1MYhD/EuwGS0D/g9b+lhU6UiNqXV5cs6aMQ/X58CNOhqmb02a
         L82m2OWYLn8tomaZEJFDvJB2RC7GBBSMcAKeeZDsHsyqW1ZZTHW/Jah8RW+N0NsT+Hua
         jMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724750435; x=1725355235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7x374P9F0jPNFMTHJtbiCnmxTGpC6qte4AieI2H+Lys=;
        b=VK9XkYedAobatBaMjcLbBJXopy7DPs1vB5wmpLfmz44FAqjCCRSb8NwONNm6e8MTXG
         nYasNG86g+gZzskUQ4nKt6+dfHgRnSqwzAOrvw3F9beUEQwgSyald8puIq8NBouYEwNm
         j1q6iDVguiPXbw/iqtubhptoapss+60kSaEUqtCKT2dGe9dG0IbsS4PQC2TORQ65pAeM
         UvSN8FzmZWex3N34Rgzth4kw9soc7/eMMcz7F6lEbnM+FPKM3ZYmacn24B3O7OyiXORa
         K6w6yPhxl7xJZi5i9peo+SlUERlO4JBJezVASpGrsOchF13XdXGjb1qkjDBnDdmZUID9
         xeRw==
X-Forwarded-Encrypted: i=1; AJvYcCW0022JANx8v74ClyD85Dux7ktLMKQCAOoDbzGAJzpeJOwnjVsDUJdlxzvj6nDDzLdLf9jsT1e4WKm0ovL24pk7SQ==@vger.kernel.org, AJvYcCWqMqvuu6vzKRCWREOtl5CmThjcfPwc503z5a2kCF8dd0ucIGrKYuvwCRN1cehQMZ1rlR+XPyJguPnDdsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyI8jqnIK4OGJHjxCmiMDjR2cnby9ZsJtYoDaGv5FkW4/u9Mol
	9PtK/YxxM0Ygb++SPYlawqR82Lw/cIjdB4IQnebUaldu2t1vZufH
X-Google-Smtp-Source: AGHT+IEe+J6TtekHsFrhNpNYcW8Me2/gb17EXuvBQwu+oS6MZ6y7WSXGX8ymCj6bYo7Bc7Eefg2OKA==
X-Received: by 2002:a17:90b:3b88:b0:2cb:4c32:a7e4 with SMTP id 98e67ed59e1d1-2d646bca003mr11206955a91.15.1724750434510;
        Tue, 27 Aug 2024 02:20:34 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:ab14:280:f82b:883b:12eb:74c7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d6136fdaeasm11523939a91.7.2024.08.27.02.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:20:34 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1 1/2] perf trace: Collect data only for certain pids
Date: Tue, 27 Aug 2024 17:20:12 +0800
Message-Id: <20240827092013.1596-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240827092013.1596-1-howardchu95@gmail.com>
References: <20240827092013.1596-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we collect augmented data for __every__ process, even when -p
argument is used.

For instance, if we do perf trace -e write -p 11451, we don't just
collect write buffer for process 11451, we collect write buffers for all
the processes running on the system. Those data will eventually go to
waste, we are not interested in them.

In this patch, I add a new BPF map: pids_allowed. We only allow
augmented data collection on certain processes. This is different from
pids_filtered, which is a map that filters the pids we don't want, for
example, we don't want to trace the perf trace itself.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c                    | 45 +++++++++++++++++++
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 23 ++++++++--
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 115f8dffb272..d38e0b919e8e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3911,6 +3911,44 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 
 	return err;
 }
+
+static int trace__set_allowed_pids(struct trace *trace)
+{
+	int err, pids_allowed_fd = bpf_map__fd(trace->skel->maps.pids_allowed);
+	bool exists = true;
+	struct str_node *pos;
+	struct strlist *pids_slist = strlist__new(trace->opts.target.pid, NULL);
+
+	trace->skel->bss->task_specific = false;
+
+	if (pids_slist) {
+		strlist__for_each_entry(pos, pids_slist) {
+			char *end_ptr;
+			int pid = strtol(pos->s, &end_ptr, 10);
+
+			if (pid == INT_MIN || pid == INT_MAX ||
+			    (*end_ptr != '\0' && *end_ptr != ','))
+				continue;
+
+			err = bpf_map_update_elem(pids_allowed_fd, &pid, &exists, BPF_ANY);
+			if (err)
+				return err;
+
+			trace->skel->bss->task_specific = true;
+		}
+	}
+
+	if (workload_pid != -1) {
+		err = bpf_map_update_elem(pids_allowed_fd, &workload_pid, &exists, BPF_ANY);
+		if (err)
+			return err;
+
+		trace->skel->bss->task_specific = true;
+	}
+
+	strlist__delete(pids_slist);
+	return 0;
+}
 #endif // HAVE_BPF_SKEL
 
 static int trace__set_ev_qualifier_filter(struct trace *trace)
@@ -4305,6 +4343,13 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 #ifdef HAVE_BPF_SKEL
 	if (trace->skel && trace->skel->progs.sys_enter)
 		trace__init_syscalls_bpf_prog_array_maps(trace);
+
+	if (trace->skel) {
+		/* set up workload and user-specified pids for BPF */
+		err = trace__set_allowed_pids(trace);
+		if (err)
+			goto out_error_mem;
+	}
 #endif
 
 	if (trace->ev_qualifier_ids.nr > 0) {
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index f29a8dfca044..1ab0a56c8f35 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -24,6 +24,8 @@
 
 #define MAX_CPUS  4096
 
+volatile bool task_specific;
+
 /* bpf-output associated map */
 struct __augmented_syscalls__ {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
@@ -81,6 +83,13 @@ struct pids_filtered {
 	__uint(max_entries, 64);
 } pids_filtered SEC(".maps");
 
+struct pids_allowed {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, pid_t);
+	__type(value, bool);
+	__uint(max_entries, 512);
+} pids_allowed SEC(".maps");
+
 /*
  * Desired design of maximum size and alignment (see RFC2553)
  */
@@ -393,9 +402,15 @@ static pid_t getpid(void)
 	return bpf_get_current_pid_tgid();
 }
 
-static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
+static inline bool should_filter(void)
 {
-	return bpf_map_lookup_elem(pids, &pid) != NULL;
+	pid_t pid = getpid();
+
+	if (bpf_map_lookup_elem(&pids_filtered, &pid) ||
+	    (task_specific && !bpf_map_lookup_elem(&pids_allowed, &pid)))
+		return true;
+
+	return false;
 }
 
 static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
@@ -497,7 +512,7 @@ int sys_enter(struct syscall_enter_args *args)
 	 * initial, non-augmented raw_syscalls:sys_enter payload.
 	 */
 
-	if (pid_filter__has(&pids_filtered, getpid()))
+	if (should_filter())
 		return 0;
 
 	augmented_args = augmented_args_payload();
@@ -523,7 +538,7 @@ int sys_exit(struct syscall_exit_args *args)
 {
 	struct syscall_exit_args exit_args;
 
-	if (pid_filter__has(&pids_filtered, getpid()))
+	if (should_filter())
 		return 0;
 
 	bpf_probe_read_kernel(&exit_args, sizeof(exit_args), args);
-- 
2.46.0

