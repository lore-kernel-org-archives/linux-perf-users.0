Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7745FFB4
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147677; cv=none; b=KXCPUQ1rLzvGMyyhipuYjNwQAMNddrcZxQGn3H7I3y+r6N+Vt18CFhu+QjmYbGzmQ3d/Q9JUBlDhAvMrF4n0mlaR0sSO437LP//1Z+MykDavRB3LtRr2IDYBNhYuaTOdfFmhjwE7Lv5qcVH1BoMwBVb2RDi+oOpbr/WS2Cs4oJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147677; c=relaxed/simple;
	bh=sWDjpmqQFHNxbOrqetG/mdGySdzadyLLEakaJ4zMYI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=InMJrIisCKv+eZeBuKq2WBcPDmxRQXrUIm6QRKjvD1Bh23pjrGbukYdJAHIaU2XKUxB6nsRlBvhTNjfKfIr5WQGj9T9EPK2P2+jwccpG8X7Ye80AsdWui+rfPXYt5exi5z/qfHKOHQcydMEFJFDwoLHSSgbRLPdORYWSi4vxEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ym3RI0mn; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ym3RI0mn"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-14371f7ba1eso942488c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147674; x=1790752474; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2RXz5qApTCo7+4xTK6ChTxiYdBPBy8PFXhCMYPC9khM=;
        b=Ym3RI0mnwn3lCknw4VSr7jIc0QyJ3n2D71+CnqEQomcOckUIVDSQpy0+0j8v/cYH+N
         89LOYmqx4IHwFrZkHmgUe5iXQC3kOsj1cLAuw5AgtBsq7d7ZK+3nTP5qJlIuOy591X1I
         6yGby/AIkVB9RLaC5fyYRYUbgbAIQpTH2zbvdPvtfZHo3f3LvJzwhwROD2dv1ahpId80
         oL4J7T9GZUr6Xg5fXP36mMCdlMt3XwY2k3QBNispL8Cwql9wbnwDmg73CjECsZ+yMnUF
         xOHIVcKc+WDm6Y5jIeRKh+UoMV3cdfR38iMYV6Cz66zIForo6+NL6LmM8jGr2yIlxYjq
         phAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147674; x=1790752474;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2RXz5qApTCo7+4xTK6ChTxiYdBPBy8PFXhCMYPC9khM=;
        b=beKnfkSRP3+4ppTUnGL4mg7jYr1TUkJaVeb/oAC6GtjulhfUA+af63W4QVviltioPC
         IOS6J4bTlQmWmw786vmuP8jVjzVE86EUllXyNVZxXjXSOYSn/1m53NP6W3o9OvaPe9sE
         5QCGY47j2TJA/75ACvdFpFGHy7L0Vp8+TFajcXd/f7w4RpUslGJRwytp6O6vcCdK3vj2
         SOEms99rE6FXJhSAEja0us1qWB5RS4UK3P8enFG/Avcn+zlSK1ZNXD5v7lOLDGYuKbZb
         M8Zy2PyodWuGXGt1eqkD3DHF0sbWoVPkGf9lOJ0PXnVNFfR1uMp0CwUSf6TqcnujGUTr
         /hdA==
X-Forwarded-Encrypted: i=1; AKwUvBxwgqJbK+qcrQF362LNAmgEpUhVeuzcqpqC/NMKX9dffx0SrUeBYtm22id9L9Y1ndrrhaJS+2iKL4VvHehNe5o8@vger.kernel.org
X-Gm-Message-State: AFuF++nQrxzDi48F1nqgxA3u+OZdbFTL8m/3Vi/hbDa+DPAXGw+QyOgS
	Onf1hNcWpppg5UgsBbiY4q32al224ExLnVwAXvYIve4xVAr1U9Hj1qIRhCmPXYdd8a9+Fro4ouX
	xjoRixgqhyw==
X-Received: from dlbps14.prod.google.com ([2002:a05:7023:88e:b0:144:db24:c0ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4247:20b0:143:297c:82e1
 with SMTP id a92af1059eb24-144f931bbf3mr2024267c88.33.1790147673875; Wed, 23
 Sep 2026 00:14:33 -0700 (PDT)
Date: Wed, 23 Sep 2026 00:13:51 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <42dc47785bdb78054500591b193a1cb653ef39b7.1790145937.git.irogers@google.com>
Subject: [PATCH v5 11/23] perf trace: Do not set unaugmented BPF program on
 sys_exit map
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, howardchu95@gmail.com, 
	namhyung@kernel.org
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
index aa2d64eb56bd..0ae14ecd9f00 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4176,7 +4176,12 @@ static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace __ma
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
@@ -4199,7 +4204,7 @@ static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int e_machine, int
 static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int e_machine, int id)
 {
 	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, id);
-	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(unaugmented_prog);
+	return sc && sc->bpf_prog.sys_exit ? bpf_program__fd(sc->bpf_prog.sys_exit) : -1;
 }
 
 static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, int key, unsigned int *beauty_array)
@@ -4454,16 +4459,27 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_m
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
2.56.0.rc1.315.gc6ed9934b7-goog

