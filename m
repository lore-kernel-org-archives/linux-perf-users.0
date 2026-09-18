Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AE052CCC1
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766401; cv=none; b=ClOAdyTXbGSOc7JQsE1mzzvOozyjHGH+W2yrvE+eKx4YEY4/KsoWUqEIub31z4S0tCP74BJezVqda2jLFqFDZK89q12aQHeBfaioUmy3Nmckk9od920yJJjV+lAlLWFX0+Lxro7L74OqDQd+jc64mI14sqcN1AepONxShTFvyyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766401; c=relaxed/simple;
	bh=wTN188sd46YvyIQC7dEL12UIN+qtz6SqD1SpbXW7xD0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gMS5T/fRrTn4aaXL87bpVgfQ+pQ4pLkWfQZiID4IOxMzSoyR3hJ6UonXyd5BBgkVYlzFLveVCH525WzL5S2ZY2ke4mjEscpQhnevslfYCnLxYaqiNjtRQ0v7nb6kGtedA8pIqyC9LiI6tfLnAwu2Y2qwA4xKsBBZmgO0zDIH9es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W21C614h; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W21C614h"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398d0010cfaso1959122a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789766399; x=1790371199; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZCuQJlBx4iOYW61TQncdFtiIp5eHB2qyRCxal5DDox4=;
        b=W21C614h0DODeJh0XpD+LMEo6pbER//NfVh2anSOW0lTJFajWRVtVtHanShOPWu/gO
         4vdNCYhOIBW8lOTrmffD3sgayM9AGlCg+p66CGW4otPJfqGkwC6dluKYEbDiLTeqcICH
         3OfqNqdqXTCQOAE7e0XI9omKOP79P9g7rmHX9b8vKLfLfBSBjO6WNc5CTxXzc5Jj6Zzt
         c//F/co/YQMZqymAIp9skjFy64OAKO+IvQRmacORNIwZ8oqUc7evp/vbKEl6fkd4fWf3
         my7n3zGmOipm7ezcueRtEjynFo5evzX0FP0lWSutP7Morg0SaS1KknyHUy+bBlfUBSdc
         S4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789766399; x=1790371199;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZCuQJlBx4iOYW61TQncdFtiIp5eHB2qyRCxal5DDox4=;
        b=VuAoj7rQ6Fxnd7fGaeWQ4Fv9RpZLYy5eyzAEKcpDxnjyPNIvcOVlDUMIptjlJ3JdAc
         cvOKYUJ6IG+013BJncCRwKOmXhDc/mOX2vFxpb+9MAxzV9ezzP9vuX3OL646KN3XzW/k
         zpL1/hriXpArFVlFzj8r3Mu84Bc0BIVtqzTEOibkOq5fVvMdV6qTz0ctyBjS5+oKwwKo
         0VrbfMd8GMFz4mEQiItbrC459fRS64kKA1giIsFuzqNatrUT9Pe6gzjP1/Wq1B6ChzKk
         tybnl1jUWZ1jIoZbYq9A4UvGvPO9PnZpo+2RiQkOb/4DH9kTYPymei6E1Jyvsber9kCi
         JGHA==
X-Forwarded-Encrypted: i=1; AKwUvByqcLfBfwDuLwqo01KxBwY58zUuDZe+hI7F0ZYzaNF87vWtV5U17rmgkTv8pvvyRLOWb2d0fArPXPivmPGXvmNe@vger.kernel.org
X-Gm-Message-State: AFuF++nEfMaRCCF6oqs8F1OWkJq+5M6XP6b/fDN4C2CQIYjrdz8VenXd
	sjdpbjXHNNb2m0hqognYNvlB+PMZmsdeIifQE812RJv+UVChGCw5COZjEVuyzD8ENyRaykhOmq5
	5FwC6kCYAeA==
X-Received: from dled9-n1.prod.google.com ([2002:a05:701b:42c9:10b0:143:8a67:84b5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57e8:b0:39e:6c69:7774
 with SMTP id 98e67ed59e1d1-39e6c697961mr2142236a91.29.1789766399150; Fri, 18
 Sep 2026 14:19:59 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:19:20 -0700
In-Reply-To: <20260918211932.2966061-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918140659.2501976-1-irogers@google.com> <20260918211932.2966061-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918211932.2966061-7-irogers@google.com>
Subject: [PATCH v4 06/18] perf trace: Do not set unaugmented BPF program on
 sys_exit map
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	Howard Chu <howardchu95@gmail.com>
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
index de3108dcef8a..f6fb6ffd654a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4133,7 +4133,12 @@ static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace __ma
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
@@ -4156,7 +4161,7 @@ static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int e_machine, int
 static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int e_machine, int id)
 {
 	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, id);
-	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(unaugmented_prog);
+	return sc && sc->bpf_prog.sys_exit ? bpf_program__fd(sc->bpf_prog.sys_exit) : -1;
 }
 
 static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, int key, unsigned int *beauty_array)
@@ -4411,16 +4416,27 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_m
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

