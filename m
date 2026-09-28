Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E15D39479C
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619999; cv=none; b=U9RXgOIfSADclyV1XgUu3sGs/bAo4KDnRfxz6INhzVOC9CYMyo8QpucFWxOpCX3My9cct4OQRTBLjDc9+kqj3qn8llqO1yjpxobdhVVTTKCBzJ2GdAPz73OcwzFjuXw/jwn/h6cg5sU/yrOT2tDnTSOkOjHKeVXVYieEqRRhF3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619999; c=relaxed/simple;
	bh=0hpC6WYhUaPoQCAA+yO9XhUMBwiDlLMACaS2N2EMRkg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gVlSgP+dAIPF6T34Lmt4jTU/hLGP/jrTx7fqkCBqpn4Ecc4I26hHHAV7QLylH9XOnRcOoo5hUpcCJlwmpa+xBK3axkYwPQo3kiQRc6TEtcYVmh7uDb4sMxhlkeWbsr82wuGxx4xvXj3n39xZNkCEG/E5ogKoqg0UTkWmg753fCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dnXXI/Vz; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dnXXI/Vz"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3282d5302ffso212359eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790619997; x=1791224797; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o/mGEeHuSPa9qD+MdqsXUR95lGlbev8XDzvUO+1lxyE=;
        b=dnXXI/VzTdNy0WhdTvrPjwLEO7kEh4PQdO9aPCkKCY7ral57kl0O+V6yJ65WhkA1Im
         Chwh6FEptjPE7mTGDIQXbkgVUzwIh/8ZLE4dwuGnYUFW7pn765/eJPEklIzYjC75WTeP
         HeNZixnIgwc7etCBojLAht9kJKnlt2u8csTCUI8PHzJcb99+/MdFb9NbM7ffmXyOZ6QZ
         jVjE+d0Hz0jmm4LGRkgZJ4Yc4SgEWKBgpMLtAUlmS1bmQauBzn6gnzXgV4pXvJY75dg3
         0U53scHZF+P31X8+6UNaYQmQZf/vHXtQxmkFsG5vxJVhElRHNr96akodtz6NJivUw0/q
         HREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619997; x=1791224797;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o/mGEeHuSPa9qD+MdqsXUR95lGlbev8XDzvUO+1lxyE=;
        b=w2oT8NiSkqr0mJpIwc16s3B8sF7TkP5KtavNBBQ32d8sJtyaH7ocCyPJ2UnW8zlSsv
         iD5uw8myzRNrvunyiIZHJGhygkm9aBWFx2X+ptNNvLZmlMDqKeWfl1OU+EPH62ZB029I
         Lw1JbCGrNMmoTy8R8YIpOd+j5g1RKhRS+MM+x6MfZWsCUPBGfN5eMKZR3aeMi+lSsUAm
         X/E0wf9XWLicdmKt6yVDA5elQKINck7RHCSwpvH7/gftbZ6w4nE9p7p/gzKmtFiFfPgX
         ECfQfBZtzfODDbGuVgWqw00OeESzdAqYbieTOtGedsmeBt2cWGqIgaXHH9eK+6patUTx
         S+pA==
X-Forwarded-Encrypted: i=1; AKwUvBwVGAyU3YEAc3gFQzVpnHxY8OEU7FQpvdS517D8zqRzmjF19PAx95KfNo6+B0RKy09WXU6dGx0+TtsAweicN76S@vger.kernel.org
X-Gm-Message-State: AFq9FYL+ANNUoanLR3SZW3/NkwJLIW4mzJnbH4iGfcOHZSCavMPmwRH/
	ETZVXFpw5cZDAgP/lNpe0cyPKn3YU/cyP5qTGm3Dm8LY06cv4ReNtqT5GjEwMVk7sqGQmzH6yow
	xyB6LaoMCeQ==
X-Received: from dydb6.prod.google.com ([2002:a05:7300:80c6:b0:33b:c09b:a189])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2829:b0:347:49d2:db76
 with SMTP id 5a478bee46e88-34af7c55279mr249264eec.7.1790619996135; Mon, 28
 Sep 2026 11:26:36 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:25:50 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-12-irogers@google.com>
Subject: [PATCH v6 11/26] perf trace: Split unaugmented sys_exit program
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Namhyung Kim <namhyung@kernel.org>

We want to handle syscall exit path differently so let's split the
unaugmented exit BPF program.  Currently it does nothing (same as
sys_enter).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20250814071754.193265-3-namhyung@kernel.org
[ irogers: Use struct syscall_{enter,exit}_args and make
  trace__find_syscall_bpf_prog() fall back to the exit program for
  exits ]
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c                            | 10 ++++++----
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c |  8 +++++++-
 tools/perf/util/bpf_trace_augment.c                   |  9 +++++++--
 tools/perf/util/trace_augment.h                       | 10 ++++++++--
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1f89f85ba2e4..17e482ae02c9 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4084,7 +4084,7 @@ static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace __ma
 	pr_debug("Couldn't find BPF prog \"%s\" to associate with syscalls:sys_%s_%s, not augmenting it\n",
 		 prog_name, type, sc->name);
 out_unaugmented:
-	return unaugmented_prog;
+	return strcmp(type, "exit") ? unaugmented_prog : augmented_syscalls__unaugmented_exit();
 }
 
 static void trace__init_syscall_bpf_progs(struct trace *trace, int e_machine, int id)
@@ -4101,13 +4101,15 @@ static void trace__init_syscall_bpf_progs(struct trace *trace, int e_machine, in
 static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int e_machine, int id)
 {
 	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, id);
-	return sc ? bpf_program__fd(sc->bpf_prog.sys_enter) : bpf_program__fd(unaugmented_prog);
+	return sc ? bpf_program__fd(sc->bpf_prog.sys_enter) :
+		bpf_program__fd(augmented_syscalls__unaugmented_enter());
 }
 
 static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int e_machine, int id)
 {
 	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, id);
-	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(unaugmented_prog);
+	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) :
+		bpf_program__fd(augmented_syscalls__unaugmented_exit());
 }
 
 static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, int key, unsigned int *beauty_array)
@@ -4318,7 +4320,7 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_m
 	if (augmented_syscalls__get_map_fds(&map_enter_fd, &map_exit_fd, &beauty_map_fd) < 0)
 		return -1;
 
-	unaugmented_prog = augmented_syscalls__unaugmented();
+	unaugmented_prog = augmented_syscalls__unaugmented_enter();
 
 	for (int i = 0, num_idx = syscalltbl__num_idx(e_machine); i < num_idx; ++i) {
 		int prog_fd, key = syscalltbl__id_at_idx(e_machine, i);
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index cc70861a23d6..18835c7512ac 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -192,7 +192,13 @@ unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const
 }
 
 SEC("tp/raw_syscalls/sys_enter")
-int syscall_unaugmented(struct syscall_enter_args *args)
+int sys_enter_unaugmented(struct syscall_enter_args *args)
+{
+	return 1;
+}
+
+SEC("tp/raw_syscalls/sys_exit")
+int sys_exit_unaugmented(struct syscall_exit_args *args)
 {
 	return 1;
 }
diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_trace_augment.c
index ebb26225fb04..0f510554ad9f 100644
--- a/tools/perf/util/bpf_trace_augment.c
+++ b/tools/perf/util/bpf_trace_augment.c
@@ -117,9 +117,14 @@ int augmented_syscalls__get_map_fds(int *enter_fd, int *exit_fd, int *beauty_fd)
 	return 0;
 }
 
-struct bpf_program *augmented_syscalls__unaugmented(void)
+struct bpf_program *augmented_syscalls__unaugmented_enter(void)
 {
-	return skel->progs.syscall_unaugmented;
+	return skel->progs.sys_enter_unaugmented;
+}
+
+struct bpf_program *augmented_syscalls__unaugmented_exit(void)
+{
+	return skel->progs.sys_exit_unaugmented;
 }
 
 struct bpf_program *augmented_syscalls__find_by_title(const char *name)
diff --git a/tools/perf/util/trace_augment.h b/tools/perf/util/trace_augment.h
index a1cd9a5e0213..9c91e2569890 100644
--- a/tools/perf/util/trace_augment.h
+++ b/tools/perf/util/trace_augment.h
@@ -15,7 +15,8 @@ void augmented_syscalls__setup_bpf_output(void);
 int augmented_syscalls__set_filter_pids(unsigned int nr, pid_t *pids);
 int augmented_syscalls__get_map_fds(int *enter_fd, int *exit_fd, int *beauty_fd);
 struct bpf_program *augmented_syscalls__find_by_title(const char *name);
-struct bpf_program *augmented_syscalls__unaugmented(void);
+struct bpf_program *augmented_syscalls__unaugmented_enter(void);
+struct bpf_program *augmented_syscalls__unaugmented_exit(void);
 void augmented_syscalls__cleanup(void);
 
 #else /* !HAVE_BPF_SKEL */
@@ -53,7 +54,12 @@ augmented_syscalls__find_by_title(const char *name __maybe_unused)
 	return NULL;
 }
 
-static inline struct bpf_program *augmented_syscalls__unaugmented(void)
+static inline struct bpf_program *augmented_syscalls__unaugmented_enter(void)
+{
+	return NULL;
+}
+
+static inline struct bpf_program *augmented_syscalls__unaugmented_exit(void)
 {
 	return NULL;
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

