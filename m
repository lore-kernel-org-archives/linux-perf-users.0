Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085995187C7
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663172; cv=none; b=Y6XhLM+Cfd7ngeBpkBXnCbRhyWe9uSYa5zsNlKqUXmdH0fqTiHuy9vNGjLtNa1Ydu/eRE/0QX2zr/alRCGi++IKEZ6sg3JpODhQ7n3C4mEkBtEKnK50U1HD2Sk02Z6MdKSS4+43b0QipOF0CkGdxaoRoLmyJ2z0vtfRumFA/aKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663172; c=relaxed/simple;
	bh=lx7wyF3Qu/HpKTFDnfOd4iCQJKE+aEvsCq9kKuv30HU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MLxYOlZXveXhxJ5aMpApJq2/VIU02jSo0HK0k+5ol4/w8GSFW+tlEznfNrGrW/Vryo89eo/8wp/n3oqObRY9KErunpeR//LasZIhoxk/SVCkqpUv4tkvNpOPoTq1mujxtZjR3zntbbNj30S4ktEBLeK2P4V7fC3B8/U4LcRP9fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KmQSwlPm; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmQSwlPm"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d55d8cd938so18953775ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 09:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789663169; x=1790267969; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iDa4jCWG1HgPZsp/vqH9L8ol0+fyo/nirzG/z+7DOWE=;
        b=KmQSwlPmX2l9tTBcJHj2hfipd21q7DnOY7L7gXAin/KlnHXXhUMFD3RnDoYEogJAIk
         Id3VdyiEZL/LLN0wdG8clBBA2p8bCrQ3snN0JNKcK+ifZgxH4lOMeBZV9ZzzrCqLqPkJ
         5/+8/UUSWRjppsFhK4wg+Fg0GiI7rD73XCpkjrSA0Oj/MswEv5T7o9nEQbQFzllcdMdh
         22RlBV3NwaPRwRkbBA1oonp8YGgvTLrPa1GEQbTNqILauWlNmijA7/JWubsM+1RHX5eG
         7SBz95psvEiPXpj/0px0BpmIzYcYbFvhVVp+PzpurY6t7YVMroYECijXvC7VjH7T6Fmw
         MNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663169; x=1790267969;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iDa4jCWG1HgPZsp/vqH9L8ol0+fyo/nirzG/z+7DOWE=;
        b=I8qFDA/yRrOe7ANvwlXH9BDkTMWtQW9CFXXnYm9YQbKbhEQGn74tlulHyr/Dx3P4WB
         Op90FAG3YDiAqesAaK0XzL8jJt9yeWsRdsRy2h6JCCh+SyEIh2s5q2tXTSnkLTzTAMuK
         fIjvzw7UbgJ4IjXhrEQojEBG/p2eUTFmET1qVSAnjEkkBRJQXt83EQ9EaKcws1K67Uq/
         u1Hs9kYlBcDSTJjjjuUBZ3FwhiN0+RYJrOQZwIwbVZcZoNtcqBK4Tf8k5wznyksw1FOv
         2nHdaHGitGU8rmVJFDywiM6U/Z9o2YRLhGpU8ku1Nrc5aK8RmlBjisEtaIZ/doYr7vMj
         fYCg==
X-Forwarded-Encrypted: i=1; AKwUvByYdVCfC8QhJFeZrcHfC8xta3qccVXjb+GhNgWufD468e7LxztFRwIQZdy5PT8Ae4zeXtjun9SBo72KRI3eupRf@vger.kernel.org
X-Gm-Message-State: AFuF++nxDb8KAjU1gGYH/OK9Gtbn/Mt6PhTOk1bdnrQAzu3zp7LUxRcK
	Pinro5+p2G/Gj3BuuGCYDRvvmXC6Sx4cMJGGH4cN4pSKl9nOCBCV/QS4QmllOdPfhRN+2OD1NWU
	2wpRks3f+Rg==
X-Received: from dybzy24.prod.google.com ([2002:a05:7301:e118:b0:313:fb09:e2c0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46c7:b0:2db:8ae7:a5d2
 with SMTP id d9443c01a7336-2dd8e026db9mr148505725ad.9.1789663168790; Thu, 17
 Sep 2026 09:39:28 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:38:52 -0700
In-Reply-To: <cover.1789662556.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <ff6b4ac0b85c13aa3dd8c0e60f89253669c661ff.1789662556.git.irogers@google.com>
Subject: [PATCH v2 04/14] perf trace: Do not set unaugmented BPF program on
 sys_exit map
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

In trace__init_syscalls_bpf_prog_array_maps(), the BPF program array map
for sys_exit (syscalls_sys_exit) was populated with the result of
trace__bpf_prog_sys_exit_fd().

When a syscall had no specific exit augmenter,
trace__find_syscall_bpf_prog() fell back to unaugmented_prog
(syscall_unaugmented). However, syscall_unaugmented is a sys_enter
program that outputs enter arguments to __augmented_syscalls__.

As a consequence, when an unaugmented syscall exited, sys_exit
tail-called syscall_unaugmented, which interpreted the exit arguments as
enter arguments and emitted a duplicate, corrupt sys_enter event into
__augmented_syscalls__ right as the syscall completed.

Fix this by:
1. Returning NULL from trace__find_syscall_bpf_prog() when looking up exit
   augmenters and none is found.
2. Returning -1 from trace__bpf_prog_sys_exit_fd() when no exit program
   is present.
3. Only updating map_exit_fd when prog_fd >= 0.
4. Clearing err = 0 when trace__bpf_sys_enter_beauty_map() returns
   non-zero (indicating the syscall has no augmentable pointer arguments)
   before continuing the loop, so a trailing run of such syscalls (e.g.
   'perf trace -e close') does not leave err non-zero on return and abort
   the session.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index af9696aadaec..a68d34256996 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4117,7 +4117,12 @@ static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace __ma
 	pr_debug("Couldn't find BPF prog \"%s\" to associate with syscalls:sys_%s_%s, not augmenting it\n",
 		 prog_name, type, sc->name);
 out_unaugmented:
-	return unaugmented_prog;
+	/*
+	 * Do not set unaugmented_prog for exit: syscall_unaugmented is a
+	 * sys_enter program that outputs enter arguments. Exit without a
+	 * specialized return augmenter returns 1 directly from sys_exit.
+	 */
+	return !strcmp(type, "exit") ? NULL : unaugmented_prog;
 }
 
 static void trace__init_syscall_bpf_progs(struct trace *trace, int e_machine, int id)
@@ -4140,7 +4145,7 @@ static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int e_machine, int
 static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int e_machine, int id)
 {
 	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, id);
-	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(unaugmented_prog);
+	return sc && sc->bpf_prog.sys_exit ? bpf_program__fd(sc->bpf_prog.sys_exit) : -1;
 }
 
 static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, int key, unsigned int *beauty_array)
@@ -4395,16 +4400,27 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_m
 		err = bpf_map_update_elem(map_enter_fd, &key, &prog_fd, BPF_ANY);
 		if (err)
 			break;
+		/* Only update the exit prog array map if an exit augmenter exists */
 		prog_fd = trace__bpf_prog_sys_exit_fd(trace, e_machine, key);
-		err = bpf_map_update_elem(map_exit_fd, &key, &prog_fd, BPF_ANY);
-		if (err)
-			break;
+		if (prog_fd >= 0) {
+			err = bpf_map_update_elem(map_exit_fd, &key, &prog_fd, BPF_ANY);
+			if (err)
+				break;
+		}
 
 		/* use beauty_map to tell BPF how many bytes to collect, set beauty_map's value here */
 		memset(beauty_array, 0, sizeof(beauty_array));
 		err = trace__bpf_sys_enter_beauty_map(trace, e_machine, key, (unsigned int *)beauty_array);
-		if (err)
+		if (err) {
+			/*
+			 * Not a failure: the syscall just has no augmentable
+			 * arguments. Clear err, or a trailing run of such
+			 * syscalls, e.g. all of them for 'perf trace -e close',
+			 * would leave it set on return and abort the session.
+			 */
+			err = 0;
 			continue;
+		}
 		err = bpf_map_update_elem(beauty_map_fd, &key, beauty_array, BPF_ANY);
 		if (err)
 			break;
-- 
2.55.0.1082.g2b9226bbc0-goog

