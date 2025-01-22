Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D01F91E7;
	Wed, 22 Jan 2025 02:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513146; cv=none; b=oCbGtxrqBvFNZ+veNSrshdbDjyK6l3caCcrHwjwOZJ7AVfCqHv+L1S/F2+wKbG68mFTP6oazNhDAXcVX7Qc9b152tSnMcDYqv86TfWc3y9d0WmNPH4339Xuqn7rjUx2WuEACT0gkE64HK9fe3XxlUX8t0oFRbwhzTyimitCJX1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513146; c=relaxed/simple;
	bh=Gs8v1zYZGA9WgVzi0szwyjCyauktTY2A6iruS7+ZdvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNjJMZHVfS/vV6Z8+Zk8G4zj2VmVjnXhi3jPX2zYEJixgQhW4qHnp6QEsCcdQpvxBrFlEOtlvYUtpE1Byek3BJG5SPYFeGmTengT4wFrXjLVwvLvvFyHIdMppcFXw51HQvNt17Pasnaaut6r7rm2oHM8re750onCaU0l+8sDiCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pea5ZGrZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pea5ZGrZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752D4C4CEE7;
	Wed, 22 Jan 2025 02:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513146;
	bh=Gs8v1zYZGA9WgVzi0szwyjCyauktTY2A6iruS7+ZdvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pea5ZGrZ+8aCRbO2PsnB27cGnmW8xsIBCneWjVJRzo5ONnk15IRza1fW74lvNQl+x
	 V+7o20Bn61lMrc87illvKD8CiLyEKB7wi8uxw/ERGHSIlVet5Zcn2zAReAJyom7A4D
	 ZfxVKQ9sB0Dt+3s21v7I9UF41DwWXwCe2cQobJFyQX+A8ftvLOb3yuqnwgNYvfrkgY
	 e4KkyG66YrkkC6xZe55B9VJ+IH5KOvYq3VpuVtqVGIsnKBA6bMhN4SglBMXiGXfs2x
	 CLX4s9oz0UVE/vmpNO6gXNhe2Md8K38oRkzxGwbcCGZclpzADDUkA3zfMMSPILvTiM
	 eEmkyqbEG7b3w==
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
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: [PATCH v4 33/39] perf: Simplify get_perf_callchain() user logic
Date: Tue, 21 Jan 2025 18:31:25 -0800
Message-ID: <074d22524c53f976a716facfb67150ba6d825071.1737511963.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1737511963.git.jpoimboe@kernel.org>
References: <cover.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.48.1

