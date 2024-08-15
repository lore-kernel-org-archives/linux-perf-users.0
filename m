Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2ED41C85;
	Thu, 15 Aug 2024 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723685830; cv=none; b=m7z2VF9EuzHbWoBF0LJRgnlW8fbo6U1w3rgAxxTeaujj2u+5dyjy26qDcmGSxkxyUYfW1e/EeJiCB91Z2oP5pYPfX9FhJroUNAPY/Ly3FLPwNqS0iZc3MO/Z5uJBJtSYGpwU6CkUaDVq5CsNJLtqT37OjfEszOyUswMIz9z+11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723685830; c=relaxed/simple;
	bh=dXAx1IOj5EFw26EiR6phyEx2pV+x6J1qogFrwbESj0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nf92k+bdXEsDMbxRKIaIVJs9npWVBmcV8lmI4OvqMvOSt+0h4rpO3f1aFuGHedGV9Q+bN2qn9q1UgfaosMONTpllMnEcz2/ZJuRL8c7JS0n6wZpeShz5gSW/J/jOncYhHx/ZKYWWQc5x/DxKrle4h/ffp9N7r82Qj7u8gbTUyGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBkXQL8y; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBkXQL8y"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-710d1de6ee5so398974b3a.0;
        Wed, 14 Aug 2024 18:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723685828; x=1724290628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMyjLjgcp28DS5DbcvmQBHlVC/BS4wgpfivdvBamMwU=;
        b=HBkXQL8ybK09W9GosFr5fujuLAAGjjisuEhltUSm0dHs5zhPmDJgvy4OyBMUPXfhVX
         eefaNVpm9u2SKcxTcdqu8Ccng5SonQtOAsnQPnmI5hhxvH3ZncixZC1+485qU4bvJXuv
         Ncksd8BR1bt6iIixBkC4l5HRz5gUIGo88t/zMmXaHTGuZQXgaWtBktW+lfrtzR8YhPR4
         MPCpXcsJALgouu/2Xd0cBwJSneqV6Kzr/uqsNXKbIpZZHWuxKoJNN4wskZc57edu0Ka8
         bg3oy2ZjGJQuOgwuP1aiX5Sb1I/CJTuTEnfIMq+bR3KxULIP1Mlu2IytQPs/E5Hv2+2m
         o1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723685828; x=1724290628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMyjLjgcp28DS5DbcvmQBHlVC/BS4wgpfivdvBamMwU=;
        b=iF1NAZyMEqH3h9G4+oAbf4z9aSk026LuKcjQESQnzRaQ3i8fuiTQdgLwRnsSu++AQZ
         U/V1lk6uFRuSXxb7S2HkNkm9ZupdGYVcskc/nKtzgsjtjc4hPZrh5YLSCxKEPkSJiyV2
         RoA8vIcpN5Fejy+HzohIJTLtCJe/a/2Qi+NdDK3QHJG8IPJq0FIcPmv1oO8DRl9xulyL
         Sz5PZy1uU6PBO3CPw65k7W0MRSuHsEINTAgVg9cJad1v9KVJG4ZMm/rNNZ0BxLuUbTR7
         Rh9VXW5ef/djedGBht7jJbMIhlA0zstc9KScHVWvM5+hwsHmDyYl4NQij1cFXVt/tt6h
         dV6w==
X-Forwarded-Encrypted: i=1; AJvYcCUtcqojqCKGttfjzMY+NyWT2Mgh+hMXRIInCWQdmKP5GaZjgLwbi/PZmnFb+8+1USZCFgK3f13ADji3T9m8dA29I7mvk5Avh4y5Y9kcqZ18RCRejkxlHvjd/weTLRGi2tYpIi5/4Py6RouvB36H9Q==
X-Gm-Message-State: AOJu0YzT7jKTx2drPomrTRS8KWYA7+801VW9SkMa0KhfmZ6xynoNAhIB
	9P1ViD7bZlZeMWAR/XDa99Ife454dUkj3VttafPlgHAgNGFh4zmg
X-Google-Smtp-Source: AGHT+IFB9mXnEs8+/EZwTUhpDOjqZH2on30/R5i1w/qIhSwvoG6SizfiZEdOIdZ3wD2D/6v6uP99eA==
X-Received: by 2002:a05:6a21:150b:b0:1c2:8d91:634 with SMTP id adf61e73a8af0-1c8eaf8b4f5mr6159760637.45.1723685827885;
        Wed, 14 Aug 2024 18:37:07 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef412bsm196842b3a.123.2024.08.14.18.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 18:37:07 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] perf trace: Add pids_allowed and rename pids_filtered
Date: Thu, 15 Aug 2024 09:36:24 +0800
Message-ID: <20240815013626.935097-9-howardchu95@gmail.com>
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

Add pids_allowed so that we only trace these pids. Rename pids_filtered
to pids_filtered_out to prevent confusion. (pids_filtered_out is for
reducing the observer effect)

We write -p argument as well as workload pid to pids_allowed to leave
only the pids that we are interested in.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c                    | 49 ++++++++++++++++++-
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 39 ++++++++++++---
 2 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 593b0b8724d0..e7574146165e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3922,6 +3922,45 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 
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
+
 #endif // HAVE_BPF_SKEL
 
 static int trace__set_ev_qualifier_filter(struct trace *trace)
@@ -3980,7 +4019,7 @@ static int trace__set_filter_loop_pids(struct trace *trace)
 	return err;
 }
 
-static int trace__set_filter_pids(struct trace *trace)
+static int trace__set_filtered_out_pids(struct trace *trace)
 {
 	int err = 0;
 	/*
@@ -4309,13 +4348,19 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		}
 	}
 #endif
-	err = trace__set_filter_pids(trace);
+	err = trace__set_filtered_out_pids(trace);
 	if (err < 0)
 		goto out_error_mem;
 
 #ifdef HAVE_BPF_SKEL
 	if (trace->skel && trace->skel->progs.sys_enter)
 		trace__init_syscalls_bpf_prog_array_maps(trace);
+
+	if (trace->skel) {
+		err = trace__set_allowed_pids(trace);
+		if (err)
+			goto out_error_mem;
+	}
 #endif
 
 	if (trace->ev_qualifier_ids.nr > 0) {
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 0acbd74e8c76..c7b9f80239c7 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -22,6 +22,8 @@
 
 #define MAX_CPUS  4096
 
+volatile bool task_specific;
+
 /* bpf-output associated map */
 struct __augmented_syscalls__ {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
@@ -72,12 +74,21 @@ struct augmented_arg {
 	char		value[PATH_MAX];
 };
 
-struct pids_filtered {
+/* Do not trace these PIDs to prevent the observer effect */
+struct pids_filtered_out {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__type(key, pid_t);
 	__type(value, bool);
 	__uint(max_entries, 64);
-} pids_filtered SEC(".maps");
+} pids_filtered_out SEC(".maps");
+
+/* Only trace these PIDs, disregard the rest */
+struct pids_allowed {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, pid_t);
+	__type(value, bool);
+	__uint(max_entries, 512);
+} pids_allowed SEC(".maps");
 
 /*
  * Desired design of maximum size and alignment (see RFC2553)
@@ -367,18 +378,34 @@ static pid_t getpid(void)
 	return bpf_get_current_pid_tgid();
 }
 
-static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
+static inline bool pid_filtered_out__has(struct pids_filtered_out *pids, pid_t pid)
 {
 	return bpf_map_lookup_elem(pids, &pid) != NULL;
 }
 
+static inline bool pid_allowed__has(struct pids_allowed *pids, pid_t pid)
+{
+	return bpf_map_lookup_elem(pids, &pid) != NULL;
+}
+
+static inline bool task_can_trace(void)
+{
+	if (pid_filtered_out__has(&pids_filtered_out, getpid()))
+		return false;
+
+	if (task_specific && !pid_allowed__has(&pids_allowed, getpid()))
+		return false;
+
+	return true;
+}
+
 SEC("tp/raw_syscalls/sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
 	struct augmented_args_payload *augmented_args;
 	/*
 	 * We start len, the amount of data that will be in the perf ring
-	 * buffer, if this is not filtered out by one of pid_filter__has(),
+	 * buffer, if this is not filtered out by one of pid_filtered_out__has(),
 	 * syscall->enabled, etc, with the non-augmented raw syscall payload,
 	 * i.e. sizeof(augmented_args->args).
 	 *
@@ -386,7 +413,7 @@ int sys_enter(struct syscall_enter_args *args)
 	 * initial, non-augmented raw_syscalls:sys_enter payload.
 	 */
 
-	if (pid_filter__has(&pids_filtered, getpid()))
+	if (!task_can_trace())
 		return 0;
 
 	augmented_args = augmented_args_payload();
@@ -411,7 +438,7 @@ int sys_exit(struct syscall_exit_args *args)
 {
 	struct syscall_exit_args exit_args;
 
-	if (pid_filter__has(&pids_filtered, getpid()))
+	if (!task_can_trace())
 		return 0;
 
 	bpf_probe_read_kernel(&exit_args, sizeof(exit_args), args);
-- 
2.45.2

