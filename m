Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835253A4538;
	Sun, 30 Aug 2026 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100050; cv=none; b=Lvv701ybJJJa1Y2Cl0JsKhDzDAhKGeK7De3p7WTINUO2m26MYFFG89zuXm7Isi6j6ZcgNuKMZ10IZ6pe1el9pxZYpRg85e3GYqd2t9hp/IcNGA4VezAhkTmDvmmGjzyvzbySZe3eeqhSu6mjYopsCw8I3SYKXU0XeobsOlVeSh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100050; c=relaxed/simple;
	bh=iNBqkjGw9boBKwGqswIgHukU35tiaVG/4H9oKlMlaBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c57wbsD1CTU2P+lkxvXN9mrHd/f889paEgKiSmCInwsewaUNMXP9ST4kYWR0qfeNXpwSrwpoB5mBzTFX9TTbT1YNGN5lJcDmcHJ8FRLqPnLhbLwDspqL+GmIq86nzS3GtBA6gc1a3bn+6CcRULv71Yk9GBPzx6idbQ9+oi5nuKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC772hzI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC772hzI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498601F000E9;
	Sun, 30 Aug 2026 14:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100049;
	bh=He2O1Sn0+2lOx9gKR6SPUaj6ovVNGVeXwdkqK1WC+QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nC772hzIljAUWEc3dlsWbtscB+Cjk5FndPd6bLCg/R9NBsbm1oPOvpZ1UT/vjCK1J
	 8ZB7QYgSW4JMr21xglZhDQknJcePPdl0VXRvhHDrb0O37zEjI0/aFQO1yOHrI3IXhZ
	 Wl9Oe+HYciCK4oQRPqQmxazSFJcdm8nH2b9ez3GoeK9X5kQV3W7YywMKWLGJFuLFtf
	 9gLIPeP4DLiocKYSJ6Fq/fNMQlqlsCrbCXMMBCY7/Bf55hjuWV/7zRyOagGLb9syuW
	 y8uL4QEUrojAvhqToJaL+NTKTyFcXzijnX71gW8QOWtBbtpGuJfCaWmt7tBwA0W+BS
	 EHxEPCTWDuKZg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v14 03/14] kprobes: Protect kprobe_blacklist with RCU
Date: Sun, 30 Aug 2026 23:27:23 +0900
Message-ID: <178810004323.64882.16493230858653316962.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178810001186.64882.2161016469449127450.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
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

__within_kprobe_blacklist() traverses kprobe_blacklist without holding
kprobe_mutex. When a module is unloaded, kprobe_remove_area_blacklist()
removes blacklist entries and immediately frees them with kfree().
A concurrent call to within_kprobe_blacklist() can therefore dereference
freed memory.

Furthermore, within_kprobe_blacklist() can be called in atomic or
non-preemptible contexts where the sleeping kprobe_mutex cannot be taken.

Protect kprobe_blacklist with RCU. Use guard(rcu)() and
list_for_each_entry_rcu() for traversal, list_add_tail_rcu() for
insertions, list_del_rcu() for deletions, and kfree_rcu() to reclaim
entries safely after a grace period.

Assisted-by: Antigravity:gemini-3.7-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v13:
 - Newly added.
---
 include/linux/kprobes.h |    1 +
 kernel/kprobes.c        |   14 ++++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 8c4f3bb24429..e6de7ae55bda 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -181,6 +181,7 @@ struct kprobe_blacklist_entry {
 	struct list_head list;
 	unsigned long start_addr;
 	unsigned long end_addr;
+	struct rcu_head rcu;
 };
 
 #ifdef CONFIG_KPROBES
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index bfc89083daa9..6337da5cab9e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1447,8 +1447,14 @@ static bool __within_kprobe_blacklist(unsigned long addr)
 	/*
 	 * If 'kprobe_blacklist' is defined, check the address and
 	 * reject any probe registration in the prohibited area.
+	 * Note: this can return true during transition period where
+	 * (start_addr, end_addr) in the black list is shrinking
+	 * but old entry has not been removed yet. This is acceptable
+	 * because the worst case is that we reject more probes than
+	 * we should.
 	 */
-	list_for_each_entry(ent, &kprobe_blacklist, list) {
+	guard(rcu)();
+	list_for_each_entry_rcu(ent, &kprobe_blacklist, list) {
 		if (addr >= ent->start_addr && addr < ent->end_addr)
 			return true;
 	}
@@ -2509,7 +2515,7 @@ int kprobe_add_ksym_blacklist(unsigned long entry)
 	ent->start_addr = entry;
 	ent->end_addr = entry + size;
 	INIT_LIST_HEAD(&ent->list);
-	list_add_tail(&ent->list, &kprobe_blacklist);
+	list_add_tail_rcu(&ent->list, &kprobe_blacklist);
 
 	return (int)size;
 }
@@ -2603,8 +2609,8 @@ static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
 	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
 		if (ent->start_addr < start || ent->start_addr >= end)
 			continue;
-		list_del(&ent->list);
-		kfree(ent);
+		list_del_rcu(&ent->list);
+		kfree_rcu(ent, rcu);
 	}
 }
 

