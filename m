Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9BF21CC5C;
	Thu, 30 Jul 2026 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785375949; cv=none; b=Ax5HdPrGka2epEgymKmRPXRv1wWnWbohbYJrmqbNb6uwkdWVOyN2Gnj7zfkqm/1p+ckHwb59DDxHd5gvI9fbD8vLyh8efOiD3B8snnZ2zswGVK4Xc4tZarFFoS/tueeUjpGfKR7yqY/kLF5jIDYxS7PC2l7RZLcEmAPaoHSwiNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785375949; c=relaxed/simple;
	bh=us3O2M2noA9oreE2jgQQGgKnPbpyGbhmoq11dc+i65w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ufpvWHH4+2xel06oY/qXsr0DY4WPqKmmqjziX6rfQpgmW8yb9+0QrFcrM+fHjWEXLs97TWrMRsitPNz7rsynCMC/oJzIVO0pWHUgKuUqNVZDwfg3JaU3rDiJbM/RCaWaUcnC66xtyVWFekxkca1Vlkb5WeLGxws1LEttGR+ZqUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=golwfR8x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="golwfR8x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EDB1F000E9;
	Thu, 30 Jul 2026 01:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785375945;
	bh=WQ0h9MK1Wssob41tw0Gum2uoamjPMHA5cQ8q3NlSoOg=;
	h=From:To:Cc:Subject:Date;
	b=golwfR8x/FlSROWEYDoqA9HsJemcsYnjP34neK+oeXHz7acKHilnJZ1EmU/6SGXoN
	 IVbE2Ap6grYZ/RY6hofqmO7yj87Z7onwfBXdKbqivrtr/YJX+/qXx2cA4pNe0LOGWr
	 +JatktpnLoiRiHqIcAUO28Py8aNhy0hCVDWbLA+GIExWFLgyEHBUvKlOjdTbOUMqSZ
	 9/J3wPmK9zOQwCSoIjsFYMftnLJ96iZTPvw9fKj7k0l3M35OOuMfnc9/12aJM6ziAY
	 n8AaBGHVomxMKQ9JMKcG/MR2nqj5RKNrcGWTI9GDsY3SQsgC+JLdq6UDpE0/URq9Jc
	 a4pfFBcYIRMqg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] uprobes: Remove redundant guard(rcu) in find_active_uprobe_speculative()
Date: Thu, 30 Jul 2026 10:45:39 +0900
Message-ID: <178537593930.153254.1296986092000402239.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

find_active_uprobe_speculative() is called from find_active_uprobe_rcu(),
which is invoked by handle_swbp() and handle_syscall_uprobe().
Both callers already hold RCU Tasks Trace (via rcu_read_lock_trace() or
guard(rcu_tasks_trace)()).

Calling guard(rcu)() inside find_active_uprobe_speculative() is redundant
because the caller already guarantees RCU Tasks Trace protection.
Furthermore, standard RCU (rcu_read_lock()) does not protect uprobes_tree
against asynchronous uprobe destruction (call_rcu_tasks_trace()).

Remove the redundant guard(rcu)() from find_active_uprobe_speculative() and
replace it with lockdep_assert(rcu_read_lock_trace_held()) and a comment
documenting that callers must hold RCU Tasks Trace protection, matching the
convention used by find_active_uprobe_rcu() and find_uprobe_rcu().

Fixes: e0925f2dc4de ("uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution")
Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/events/uprobes.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4084e926e284..b4e253d43b30 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2424,6 +2424,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	return is_trap_insn(&opcode);
 }
 
+/* assumes being inside RCU Tasks Trace protected region */
 static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
 {
 	struct mm_struct *mm = current->mm;
@@ -2433,7 +2434,7 @@ static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
 	loff_t offset;
 	unsigned int seq;
 
-	guard(rcu)();
+	lockdep_assert(rcu_read_lock_trace_held());
 
 	if (!mmap_lock_speculate_try_begin(mm, &seq))
 		return NULL;

