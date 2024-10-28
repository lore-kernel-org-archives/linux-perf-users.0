Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF40D205E1E;
	Mon, 28 Oct 2024 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152125; cv=none; b=kvzD6IWQwjQgKfOp6MxJhgwiohz18q3z2CE8Ng1g90PzP9xeXSaOten9Krk8su5xlh4VPvEf/3pX5fAErkd3m+xhWZ1OuX2RtTC1rbRV5y7DlHkS20zHWs3b+ABnKtLgOmiHEEPpxQK9eidTECwCtWWfse2kUsFxz89sVgVsXTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152125; c=relaxed/simple;
	bh=FAGQnaAp9X/oqvdaCFG+QdxKrKoTF5tQk3+U3LCGtAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmYSvEOdQSHY7j1/xxxkTc66zAVsVHUeCRixc3OC3NMb9EjG0Pph0+C6uA3uCssO/niIh2d09aGoxSeRXbVneRT1j6VPpSSfRMe1kx1rJGoR14UbWzJDGEFrADBD4k6mB7RaPZzLejqJT1+og0wAvk8dm56JQfhvpa5hJvlJMNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMI1naWt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMI1naWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E126BC4CEE9;
	Mon, 28 Oct 2024 21:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152124;
	bh=FAGQnaAp9X/oqvdaCFG+QdxKrKoTF5tQk3+U3LCGtAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lMI1naWt/OcRVRfW3r//9dUCbm60Z7U9GFAvivgychWGOyJsGRwGD7FFmPobIioXh
	 NWA2FU1CSKluSVPqXrHZ32iKd+sPyPIrMQxQNVM9HcfBnWfvEGzGKzfSw7nwd6gFMU
	 H+ZsOqoBqkZFbsikanxh0SD5LO9epHX2+COfkuLTGwCq/6bC8khTQv7G8x7kQtz4cX
	 QHfB/EfwQwc7uT9H7dEPU8WP3BkxOQCby2gmsKDf375gmmniVCgJl13W80vAqG4+u8
	 mFfezumdshymeAaZC9pCfJDnO5xaYw6qmiJ7DBijUtaiN4lo+bef0WpN0lSr8DmrGQ
	 bF/nGFoqrVbjg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org,
	Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 14/19] perf: Simplify get_perf_callchain() user logic
Date: Mon, 28 Oct 2024 14:48:01 -0700
Message-ID: <4d141847262054cc73551fa33609bc3099f0d2f9.1730150953.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730150953.git.jpoimboe@kernel.org>
References: <cover.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20241028214801.zi-myr9H2yCe3TgBacXzNi44uzBD4yOzzXDxPAasyR8@z>

Simplify the get_perf_callchain() user logic a bit.  task_pt_regs()
should never be NULL.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 kernel/events/callchain.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 655fb25a725b..2278402b7ac9 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -241,22 +241,20 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 
 	if (user) {
 		if (!user_mode(regs)) {
-			if  (current->mm)
-				regs = task_pt_regs(current);
-			else
-				regs = NULL;
+			if (!current->mm)
+				goto exit_put;
+			regs = task_pt_regs(current);
 		}
 
-		if (regs) {
-			if (add_mark)
-				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
+		if (add_mark)
+			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
-			start_entry_idx = entry->nr;
-			perf_callchain_user(&ctx, regs);
-			fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
-		}
+		start_entry_idx = entry->nr;
+		perf_callchain_user(&ctx, regs);
+		fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
 	}
 
+exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
-- 
2.47.0

