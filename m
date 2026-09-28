Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D8239CCF5
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620016; cv=none; b=uLfOIOmb9p/uWTDlen76niSajuy4vA5quv/xUAXwPf52NLQBFbOROMaVaJ2hpLJ0sy/Ti65nmA36c75V9snNcUKRrm1uVA3a6UNgXiAug5Aw9z7O55tOG4eVSHjXZXwFvyX45gWavz93KJ1e8E+u1yvRZUT9OQJGEHAAYcax25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620016; c=relaxed/simple;
	bh=oHzsdwx5aeU8Dp8T2d2iVVS7whNEEoSVkl+YcjQtyrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qsob0hC6SNTfCo0kibmuPW1xmWRigmNs4o61ZNnZFNH/ozBYPc73VGmcUpn1lWlInPVnMA14Z6iToQV+vgTQDJRslJIXO49qiISGcjnfEv60I1oLMQY4IZf7d+pw5y4hZAdyYiwGn5i5QhyQkludU/1qlA/b6m5nTMntv/Fzouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHDXjll0; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHDXjll0"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1383723dfddso1730769c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790620014; x=1791224814; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g+1hiNg/m/mLz0NhE72Tn8428eFBoJJOVTop223mhcs=;
        b=MHDXjll0bpbDiVKnY2j5FQYGZBdTXDPHyU+Aao4kKEgUVhES1L7kitfgXOEPeqpyaP
         ZpqYJU7PBeOE11HtaZzsTN4J9AXuSy+uSGzrBN9jHYtbBq/R3F8N/AkRnWLFVZeuPkGs
         q9EpziQbYskZAD5zasyaNboLkrSpTR4+Z/M5k9r1+73AooZSVGW5lNOaCboI0ASoP/YL
         rn5x+S2hk0SPFkv88HuFT/f8BTvjedlg2DVKiZ2PJtNzRoosa5nbBN4GlXd/wnZAm8bJ
         JQHYbjoOEjPW080A67VK+LG1QIUXv+oV4I3eAddMsY90p4yQEq+Gzg86SxtDg446n5JD
         ajrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620014; x=1791224814;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g+1hiNg/m/mLz0NhE72Tn8428eFBoJJOVTop223mhcs=;
        b=J4WaMtiif/byGGrX0LN9d33APjvcaSmvm+0dPMYB1XBEAkQNsa0PrxOgmexW4x6qrN
         a3JPfn/zNHbRzecdVPCD/6GH4tO5yHlLNs2vZYIf7PGR7i9FrK+b7OzcyfBRaE4wWLSC
         dprY5msRq9rZoFoILkWJQCBQaMR2KWCcw53lII+/g6h42NT3aUo2AcOQnBD9nlYRKnns
         5mztxRtLBvTKpsebqzvIaw8EBM4OjpOW7t7RnX3DuYhxVPskIu4DBwml8sIoSf/zVfJ6
         H4Vhv1SdRMKF+9RWHsw8GUJ5zISusPNP6bZu5vR7oALvbdDrqMtJrI6caGvje9UUdMA0
         C+Hw==
X-Forwarded-Encrypted: i=1; AKwUvBwVQ/Vv5lOuc+SJY2lRk1kT6rlL7HXuHBT7zuJegF6H99tln/Yc+9/4ghuvpq5gAWpXSFpSdrp6bk0a/LyNL+xj@vger.kernel.org
X-Gm-Message-State: AFuF++lCdtYVRHeOxKQIhmRLpn2ej4fntL0BGphL2w0WFnOvVGFCHNmN
	gcMf2YleHz3APov2JlQf25OcwAcGHboEuZzod4gMMjUYXQwazAfR+jni8AJfMPm+xYG4sCE3YLo
	9gQ6mRwQEKg==
X-Received: from dlk3.prod.google.com ([2002:a05:7022:103:b0:14a:f387:29b1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4344:b0:144:fc5b:2121
 with SMTP id a92af1059eb24-146ce67fa31mr10998946c88.17.1790620012138; Mon, 28
 Sep 2026 11:26:52 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:25:57 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-19-irogers@google.com>
Subject: [PATCH v6 18/26] perf trace: Remove unused code
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

Now syscall init for augmented arguments is simplified.  Let's get rid
of dead code.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20250814071754.193265-5-namhyung@kernel.org
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 110 -------------------------------------
 1 file changed, 110 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 3dd40f3c3cbb..1be355a3ae22 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -490,38 +490,6 @@ static int evsel__init_syscall_tp(struct evsel *evsel)
 	return -ENOMEM;
 }
 
-static int evsel__init_augmented_syscall_tp(struct evsel *evsel, struct evsel *tp)
-{
-	struct syscall_tp *sc = evsel__syscall_tp(evsel);
-
-	if (sc != NULL) {
-		struct tep_format_field *syscall_id = evsel__field(tp, "id");
-		if (syscall_id == NULL)
-			syscall_id = evsel__field(tp, "__syscall_nr");
-		if (syscall_id == NULL ||
-		    __tp_field__init_uint(&sc->id, syscall_id->size, syscall_id->offset, evsel->needs_swap))
-			return -EINVAL;
-
-		return 0;
-	}
-
-	return -ENOMEM;
-}
-
-static int evsel__init_augmented_syscall_tp_args(struct evsel *evsel)
-{
-	struct syscall_tp *sc = __evsel__syscall_tp(evsel);
-
-	return __tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64));
-}
-
-static int evsel__init_augmented_syscall_tp_ret(struct evsel *evsel)
-{
-	struct syscall_tp *sc = __evsel__syscall_tp(evsel);
-
-	return __tp_field__init_uint(&sc->ret, sizeof(u64), sc->id.offset + sizeof(u64), evsel->needs_swap);
-}
-
 static int evsel__init_raw_syscall_tp(struct evsel *evsel, void *handler)
 {
 	if (evsel__syscall_tp(evsel) != NULL) {
@@ -5914,7 +5882,6 @@ int cmd_trace(int argc, const char **argv)
 	};
 	bool __maybe_unused max_stack_user_set = true;
 	bool mmap_pages_user_set = true;
-	struct evsel *evsel;
 	const char * const trace_subcommands[] = { "record", NULL };
 	int err = -1;
 	char bf[BUFSIZ];
@@ -6080,83 +6047,6 @@ int cmd_trace(int argc, const char **argv)
 		}
 	}
 
-	/*
-	 * If we are augmenting syscalls, then combine what we put in the
-	 * __augmented_syscalls__ BPF map with what is in the
-	 * syscalls:sys_exit_FOO tracepoints, i.e. just like we do without BPF,
-	 * combining raw_syscalls:sys_enter with raw_syscalls:sys_exit.
-	 *
-	 * We'll switch to look at two BPF maps, one for sys_enter and the
-	 * other for sys_exit when we start augmenting the sys_exit paths with
-	 * buffers that are being copied from kernel to userspace, think 'read'
-	 * syscall.
-	 */
-	if (trace.syscalls.events.bpf_output) {
-		evlist__for_each_entry(trace.evlist, evsel) {
-			bool raw_syscalls_sys_exit = evsel__name_is(evsel, "raw_syscalls:sys_exit");
-
-			if (raw_syscalls_sys_exit) {
-				trace.raw_augmented_syscalls = true;
-				goto init_augmented_syscall_tp;
-			}
-
-			if (trace.syscalls.events.bpf_output->priv == NULL &&
-			    strstr(evsel__name(evsel), "syscalls:sys_enter")) {
-				struct evsel *augmented = trace.syscalls.events.bpf_output;
-				if (evsel__init_augmented_syscall_tp(augmented, evsel) ||
-				    evsel__init_augmented_syscall_tp_args(augmented))
-					goto out;
-				/*
-				 * Augmented is __augmented_syscalls__ BPF_OUTPUT event
-				 * Above we made sure we can get from the payload the tp fields
-				 * that we get from syscalls:sys_enter tracefs format file.
-				 */
-				augmented->handler = trace__sys_enter;
-				/*
-				 * Now we do the same for the *syscalls:sys_enter event so that
-				 * if we handle it directly, i.e. if the BPF prog returns 0 so
-				 * as not to filter it, then we'll handle it just like we would
-				 * for the BPF_OUTPUT one:
-				 */
-				if (evsel__init_augmented_syscall_tp(evsel, evsel) ||
-				    evsel__init_augmented_syscall_tp_args(evsel))
-					goto out;
-				evsel->handler = trace__sys_enter;
-			}
-
-			if (strstarts(evsel__name(evsel), "syscalls:sys_exit_")) {
-				struct syscall_tp *sc;
-init_augmented_syscall_tp:
-				if (evsel__init_augmented_syscall_tp(evsel, evsel))
-					goto out;
-				sc = __evsel__syscall_tp(evsel);
-				/*
-				 * For now with BPF raw_augmented we hook into
-				 * raw_syscalls:sys_enter and there we get all
-				 * 6 syscall args plus the tracepoint common
-				 * fields and the syscall_nr (another long).
-				 * So we check if that is the case and if so
-				 * don't look after the sc->args_size but
-				 * always after the full raw_syscalls:sys_enter
-				 * payload, which is fixed.
-				 *
-				 * We'll revisit this later to pass
-				 * s->args_size to the BPF augmenter (now
-				 * tools/perf/examples/bpf/augmented_raw_syscalls.c,
-				 * so that it copies only what we need for each
-				 * syscall, like what happens when we use
-				 * syscalls:sys_enter_NAME, so that we reduce
-				 * the kernel/userspace traffic to just what is
-				 * needed for each syscall.
-				 */
-				if (trace.raw_augmented_syscalls)
-					trace.raw_augmented_syscalls_args_size = (6 + 1) * sizeof(long) + sc->id.offset;
-				evsel__init_augmented_syscall_tp_ret(evsel);
-				evsel->handler = trace__sys_exit;
-			}
-		}
-	}
-
 	if ((argc >= 1) && (strcmp(argv[0], "record") == 0)) {
 		err = trace__record(&trace, argc-1, &argv[1]);
 		goto out;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

